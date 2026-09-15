---
name: qa-test-data
description: "Test data management cho QA — fixtures/factories/seed deterministic (fixed seed), setup/teardown known-state, multi-tenant isolation (khớp be-multitenancy), no production data + mask PII, env-specific config, secret injection, parallel-safe unique keys. Load bởi qa-test-case-writer / qa-automation-builder / qa-test-executor."
allowed-tools: Read, Write, Edit, Glob, Grep
---

# qa-test-data — Test Data Management Skill

Quản lý dữ liệu test cho QA discipline (black-box: acceptance / system / E2E / regression / a11y / perf-smoke).
Mục tiêu: mỗi test bắt đầu từ **known state**, chạy **reproducible**, **cô lập tenant**, **không rò rỉ PII**, và **an toàn khi chạy parallel**.

## Core rules

1. **NEVER production data** — không copy DB prod / dump thật vào test repo. Synthesize hoặc mask PII (name, email, phone, ID) trước khi dùng.
2. **Deterministic by default** — random phải có **fixed seed** để reproduce khi fail. Không seed → flaky → cấm.
3. **Known state mỗi test** — setup dựng đúng data cần, teardown dọn sạch. Không phụ thuộc thứ tự chạy, không cross-test pollution.
4. **Tenant isolation** — mỗi test tự tạo tenant riêng (`tenantId` distinct); phải có assertion tenant A KHÔNG thấy data tenant B (khớp `be-multitenancy`).
5. **No secrets in repo** — không hardcode credential/API key/PII thật. Inject qua env / secret manager.
6. **Parallel-safe** — unique key per worker (prefix worker id / run id), không tranh chấp record dùng chung.
7. **Env-specific** — data + config tách theo môi trường (local / staging / uat), chọn qua profile, không hardcode host/tenant.

---

## Pattern: Factory + fixed seed (deterministic)

```java
// qa/testdata/CustomerFactory.java  — Test Data Builder, seed cố định để reproduce
public final class CustomerFactory {
    // Seed cố định: cùng seed → cùng data mỗi lần chạy (reproducible)
    private static final Faker FAKER = new Faker(new Random(20260729L));

    public static Customer.CustomerBuilder valid(String tenantId) {
        String uniq = TestIds.unique();          // parallel-safe, xem pattern bên dưới
        return Customer.builder()
                .tenantId(tenantId)               // BẮT BUỘC: gắn tenant
                .name(FAKER.name().fullName())    // synthesized, KHÔNG phải PII thật
                .phone("+849" + uniq.substring(0, 8))
                .email("qa+" + uniq + "@example.test")  // domain .test, không gửi thật
                .status(CustomerStatus.ACTIVE);
    }

    // Overload cho boundary/equivalence (ties to qa-test-design)
    public static Customer.CustomerBuilder withNameLength(String tenantId, int len) {
        return valid(tenantId).name("A".repeat(len));   // len ∈ {0,1,255,256} → biên
    }
}
```

Nguyên tắc: **factory trả builder**, test tự override field cần cho case. Không dùng object mutable share giữa các test.

## Pattern: Setup / teardown known-state (JUnit + Testcontainers)

```java
@Testcontainers
class CustomerAcceptanceTest {
    @Container
    static PostgreSQLContainer<?> db = new PostgreSQLContainer<>("postgres:16-alpine");

    String tenantA, tenantB;

    @BeforeEach
    void setUp() {
        // Mỗi test dựng tenant MỚI, riêng → không dính data test trước
        tenantA = TestIds.tenant();
        tenantB = TestIds.tenant();
        seedRepo.saveAll(CustomerFactory.valid(tenantA).build());
    }

    @AfterEach
    void tearDown() {
        // Dọn theo tenant vừa tạo → không cross-test pollution
        seedRepo.deleteByTenantId(tenantA);
        seedRepo.deleteByTenantId(tenantB);
    }
}
```

Ưu tiên **transactional rollback** (`@Transactional` trên test) khi có thể — nhanh + tự dọn. Nếu test đi qua HTTP boundary (không share transaction) → phải teardown thủ công theo `tenantId`.

## Pattern: Multi-tenant isolation assertion (khớp be-multitenancy)

```java
@Test
void tenantA_khong_thay_data_cua_tenantB() {
    var a = seedRepo.save(CustomerFactory.valid(tenantA).build());
    var b = seedRepo.save(CustomerFactory.valid(tenantB).build());

    // Query dưới context tenant A
    var visibleToA = api.asTenant(tenantA).searchCustomers();

    assertThat(visibleToA).extracting(Customer::getId).contains(a.getId());
    // GATE cứng: tenant A TUYỆT ĐỐI không thấy record của tenant B
    assertThat(visibleToA).extracting(Customer::getId).doesNotContain(b.getId());

    // Cross-tenant access trực tiếp bằng id → 403/404, không 200
    api.asTenant(tenantA).getCustomer(b.getId()).expectStatus(404);
}
```

Mọi FEAT có `tenantId` → phải có ≥1 case cross-tenant leak như trên. Thiếu = must-fix ở `qa-reviewer`.

## Pattern: Parallel-safe unique keys per worker

```java
// qa/testdata/TestIds.java
public final class TestIds {
    // JUNIT_WORKER_ID / PW_TEST_WORKER_INDEX phân biệt worker khi chạy song song
    private static final String WORKER =
        System.getProperty("junit.worker", System.getenv().getOrDefault("TEST_WORKER", "0"));
    private static final AtomicLong SEQ = new AtomicLong();

    public static String unique() {          // vd: w0-1a2b3c-42
        return "w" + WORKER + "-" + Long.toHexString(System.nanoTime()) + "-" + SEQ.incrementAndGet();
    }
    public static String tenant() { return "tnt-" + unique(); }
}
```

```typescript
// Playwright: worker-scoped fixture — mỗi worker 1 tenant, không tranh chấp
export const test = base.extend<{}, { tenantId: string }>({
  tenantId: [async ({}, use, workerInfo) => {
    const tenantId = `tnt-w${workerInfo.workerIndex}-${Date.now()}`;
    await use(tenantId);
  }, { scope: 'worker' }],
});
```

Nguyên tắc: **không có shared mutable record** giữa các test/worker. Unique key nhúng worker id → hai worker không đụng cùng row.

## Pattern: Env-specific data + config

```yaml
# qa/config/test-data.yml — chọn qua profile, KHÔNG hardcode trong test
local:
  baseUrl:  http://localhost:8080
  seedSize: small
staging:
  baseUrl:  https://staging.api.internal
  seedSize: medium
uat:
  baseUrl:  https://uat.api.internal
  seedSize: full        # gần prod nhưng data synthesized
```

```java
// Đọc profile từ env, KHÔNG hardcode
String env = System.getenv().getOrDefault("QA_ENV", "local");
```

## Pattern: Secret injection (no secret in repo)

```typescript
// KHÔNG: const token = "eyJhbGciOi..."   ← credential thật commit vào repo = cấm
// ĐÚNG: đọc từ env / secret manager lúc runtime
const apiToken = process.env.QA_API_TOKEN;
if (!apiToken) throw new Error('QA_API_TOKEN chưa set — inject qua CI secret / .env.local');
```

```bash
# qa/.env.example  — committed (template, KHÔNG có giá trị)
QA_ENV=local
QA_API_TOKEN=
QA_TENANT_SEED_KEY=

# qa/.env.local     — committed=false (.gitignore), giá trị thật ở đây / CI secret
```

---

## Boundary / equivalence data (ties to qa-test-design)

| Field | Equivalence classes | Boundary values cần fixture |
|---|---|---|
| name (1..255) | valid / empty / quá dài | `""`, `"A"`, 255 ký tự, 256 ký tự |
| phone VN | hợp lệ / sai format / rỗng | `+8490...`, `090...` (thiếu +84), `""` |
| money (BigDecimal) | dương / 0 / âm / vượt scale | `0.01`, `0.00`, `-0.01`, scale > 2 |
| tenantId | tồn tại / khác tenant / null | `tenantA`, `tenantB`, `null` |

Factory phải có overload dựng đúng các giá trị biên này để `qa-test-case-writer` gọi trực tiếp — không rải magic value trong từng test.

---

## Anti-patterns (NGHIÊM CẤM)

| Anti-pattern | Đúng |
|---|---|
| Dùng dump/DB production làm test data | Synthesize qua factory; nếu bắt buộc dữ liệu thật → mask PII trước |
| PII thật (email/phone/CCCD khách hàng) trong fixture | Faker synthesized, email domain `@example.test` |
| `new Random()` / faker không seed | `new Faker(new Random(FIXED_SEED))` — reproducible |
| Hardcode credential / API key / JWT trong repo | Inject qua env / secret manager, `.env.example` rỗng |
| Test dựa vào data test trước để lại (thứ tự chạy) | Mỗi test tự setup known-state + teardown |
| Không teardown → record tồn dư sang test sau | `@AfterEach` dọn theo `tenantId`, hoặc transactional rollback |
| Tạo entity thiếu `tenantId` | Factory luôn set `tenantId`; không có default global |
| Không có case cross-tenant leak | ≥1 assertion tenant A không thấy data tenant B |
| Shared record cứng (id=1) giữa worker khi chạy parallel | Unique key per worker (`w{idx}-...`) |
| Hardcode `http://localhost` / tenant cố định trong test | Đọc từ `QA_ENV` profile / fixture |
| Seed data khổng lồ mỗi test (chậm, khó reason) | Chỉ seed đúng data case cần |

---

## Integration with other skills

- `qa-test-design` — factory cung cấp fixture cho boundary / equivalence / decision-table.
- `qa-api-test` — data setup/teardown qua API contract (FEAT §3), auth token inject.
- `qa-e2e-playwright` — worker-scoped fixture, tenant per worker, dọn sau spec.
- `qa-defect` — repro của defect phải kèm seed + tenantId để reproduce.
- `be-multitenancy` (BE) — nguồn chân lý về `tenantId` filter; QA verify không rò rỉ.
- `code-be-testing` (BE) — dev unit/integration dùng Testcontainers + tenant isolation; QA bổ sung black-box, không lặp.

---

## Checklist

- [ ] Không có production data / PII thật trong repo (đã mask/synthesize)
- [ ] Random data có fixed seed (reproducible)
- [ ] Mỗi test setup known-state + teardown (rollback hoặc delete-by-tenant)
- [ ] Không phụ thuộc thứ tự chạy / data test khác để lại
- [ ] Mọi entity có `tenantId`; factory luôn set
- [ ] Có ≥1 case cross-tenant leak (A không thấy B, direct id → 403/404)
- [ ] Unique key per worker → parallel-safe
- [ ] Không hardcode credential/secret; inject qua env, `.env.example` rỗng committed
- [ ] Config data tách theo env (local/staging/uat), chọn qua `QA_ENV`
- [ ] Có fixture cho boundary/equivalence values (ties qa-test-design)
- [ ] Seed tối thiểu — chỉ data case cần

---

## Related memory

- `feedback_no_production_data_in_test.md`
- `feedback_tenant_isolation_assertion_required.md`
- `feedback_fixed_seed_for_reproducibility.md`
- `feedback_parallel_safe_unique_keys.md`
