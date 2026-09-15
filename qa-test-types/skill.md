---
name: qa-test-types
description: "Test types + pyramid + QA/dev boundary — dev owns unit/integration/contract (white-box), QA owns system/E2E/acceptance/regression/smoke/sanity/exploratory + a11y/perf-smoke/security-test black-box; map to RISK_LANES QA lane and FEAT gate (be.done+fe.done)."
allowed-tools: Read, Write, Edit, Glob, Grep
---

# qa-test-types — QA Test Types & Pyramid Skill

> Skill này trả lời **CÁI GÌ test ở TẦNG NÀO**. Không dạy kỹ thuật thiết kế case
> (xem `qa-test-design`), không dạy automation (xem `qa-e2e-playwright`, `qa-api-test`).

## Core rules

1. **QA = black-box, xuyên discipline.** QA test qua UI / API / hành vi observable — KHÔNG đọc code nội bộ để viết case.
2. **Dev giữ white-box: unit / integration / contract.** QA **KHÔNG lặp lại** các tầng này (đã có `be-test-writer` + FE dev). Lặp lại = lãng phí + false coverage.
3. **No test without AC-source.** Mỗi case QA trace ngược ≥1 AC / US / SR. Không test hành vi ngoài spec.
4. **Chọn test type theo RISK_LANES QA lane**, không "test tất cả mọi thứ mọi lúc".
5. **Execution cần gate `deps.qa` (be.done + fe.done).** Test-design (viết case) shift-left khi `status.ba=done`; thực thi chỉ khi build sẵn sàng.
6. **Non-functional trong scope QA set này = a11y + perf-smoke + basic security-test** (black-box). Full perf/pentest = ngoài scope, escalate.

---

## Test pyramid & ranh giới QA ↔ Dev

```
                 ▲ ít case, chậm, đắt, gần user
      /  \        ┌──────────────────────────── QA OWNS (black-box) ────────────
     / E2E\       │ Acceptance (per AC) · System · E2E user journey
    /──────\      │ Regression · Smoke · Sanity · Exploratory
   / System \     │ + a11y (WCAG/axe) · perf-smoke · basic security-test
  /──────────\    ╞══════════════════════ FEAT GATE (be.done + fe.done) ═════════
 / Integration\   │ Integration (module ↔ DB/Kafka/cache)   ← DEV owns (white-box)
/──────────────\  │ Contract (provider/consumer vs FEAT §3) ← DEV owns
│     Unit      │  │ Unit (hàm/class đơn lẻ, mock deps)       ← DEV owns
└───────────────┘  └──────────────────────────────────────────────────────────
 nhiều case, nhanh, rẻ, xa user ▼
```

**Ranh giới cứng:**

| Tầng | Ai sở hữu | Hộp | Repo | QA làm gì |
|---|---|---|---|---|
| Unit | Dev (BE `be-test-writer` / FE dev) | White-box | service repo | KHÔNG chạm |
| Integration | Dev | White-box | service repo | KHÔNG chạm |
| Contract | Dev | White-box (schema) | service repo | Tham chiếu FEAT §3 để suy ra E2E/API black-box, KHÔNG viết contract test |
| Acceptance / System / E2E | **QA** | Black-box | test repo / wiki/qa | Sở hữu toàn bộ |
| Regression / Smoke / Sanity / Exploratory | **QA** | Black-box | test repo / wiki/qa | Sở hữu toàn bộ |
| a11y / perf-smoke / security-test | **QA** | Black-box | test repo / wiki/qa | Sở hữu (mức smoke) |

> **Chống trùng lặp:** trước khi viết case, hỏi "hành vi này đã được unit/integration/contract của dev cover chưa?". Nếu chỉ là logic nội bộ 1 hàm → để dev. QA chỉ verify **hành vi end-to-end quan sát được từ ngoài**.

---

## Functional test types

| Type | Mục đích | Khi nào | Nguồn |
|---|---|---|---|
| **Acceptance** | Chứng minh từng AC pass đúng như spec | Mọi FEAT có AC | 1 case ↔ ≥1 AC (Given/When/Then) |
| **System** | Hệ thống tích hợp end-to-end hoạt động đúng trên môi trường thật | Feature chạm nhiều module/service | SRS/PRD + FEAT |
| **E2E user journey** | Luồng người dùng thật xuyên nhiều màn/API (login → thao tác → kết quả) | Journey cross-screen / cross-service | User story / use case |
| **Regression** | Đảm bảo thay đổi mới KHÔNG phá vỡ chức năng cũ | Sau mỗi change chạm vùng đã ship | Regression suite tích luỹ |
| **Smoke** | "Build có sống không" — vài happy-path chí mạng | Mỗi deploy/build mới, trước khi test sâu | Critical path |
| **Sanity** | Xác nhận nhanh 1 fix/1 vùng hẹp hoạt động sau bug-fix | Sau bug-fix, không cần full regression | Defect + AC liên quan |
| **Exploratory** | Tìm lỗi ngoài case đã viết bằng khám phá có định hướng (charter) | Vùng high-risk / mơ hồ / mới | Charter + rủi ro, session-based |

**Smoke vs Sanity:** Smoke = **rộng & nông** (nhiều chức năng, mỗi cái 1 happy-path, chạy trước). Sanity = **hẹp & sâu** (1 vùng vừa sửa, kiểm nhanh, chạy sau fix).

---

## Non-functional (trong scope QA set này)

| Type | Scope QA (làm) | NGOÀI scope (escalate) |
|---|---|---|
| **a11y** | WCAG 2.1 AA smoke bằng axe: contrast ≥4.5:1, keyboard nav, aria-label icon button, label form, heading hierarchy, `role=alert` cho lỗi | Full VPAT / audit screen-reader thủ công toàn site |
| **perf-smoke** | Sanity thời gian phản hồi 1 request/1 page load dưới ngưỡng thô (vd < 3s), phát hiện regression hiển nhiên | Load/stress/soak test, capacity planning, p99 SLA formal |
| **security-test (basic)** | Black-box authz/tenant isolation: user A KHÔNG đọc/sửa được data tenant B; endpoint thiếu quyền trả 401/403; IDOR thô qua đổi id | Pentest, fuzzing, SAST/DAST, threat modeling |

> Khớp `be-multitenancy` + `code-be-security`: tenant isolation test là **must** cho mọi FEAT có `tenantId`. a11y khớp `code-fe-accessibility`.

---

## Decision table — "given this change → run these types"

| Thay đổi (change) | QA lane | Test types bắt buộc |
|---|---|---|
| Copy/label/style nhỏ, 1 field, không đổi logic | **tiny** | Smoke happy-path (+ a11y nếu chạm UI) |
| CRUD chuẩn 1 màn/1 endpoint, logic bình thường | **normal** | Acceptance (Happy/Edge/Error per AC) + Smoke |
| Feature chạm nhiều màn / nhiều service / luồng người dùng | **normal→high** | Acceptance + System/E2E journey + Smoke |
| Bug-fix | (theo vùng) | Sanity vùng fix + Regression liên quan + case tái hiện defect |
| Đụng data nhạy / multi-tenant / phân quyền | **high-risk** | Acceptance + **security-test (tenant isolation + authz)** + Exploratory |
| Vùng high-risk / mơ hồ / rework nhiều | **high-risk** | Acceptance + **Exploratory (charter)** + **a11y** + **Regression automation** |
| Trước mỗi deploy / release build | — | Smoke (gate vào) + Regression suite |
| UI mới hoặc đổi form/flow người dùng | (+a11y) | Acceptance + a11y (axe) + E2E |
| Chạm hiệu năng (list lớn, query nặng, upload) | (+perf) | Acceptance + perf-smoke |

Ánh xạ lane theo `RISK_LANES.md § QA` (do `qa-intake-classifier` chấm): **tiny** = smoke happy-path; **normal** = Happy/Edge/Error acceptance; **high-risk** = + exploratory + a11y + regression automation.

---

## Entry / Exit vs FEAT gate

**Entry (execution) — cần đủ trước khi CHẠY:**
- `status.ba=done` (có AC) → cho phép **test-design** shift-left (viết case sớm, song song dev).
- `deps.qa` thỏa: **`be.done` + `fe.done`** → cho phép **execution** (chạy trên build thật + evidence).
- Môi trường + test data sẵn sàng (khớp `qa-test-data`).

**Exit (sign-off) — feature `done` toàn cục CHỈ khi:**
- AC coverage = 100% (mọi AC có ≥1 case pass).
- Blocking case pass 100%, **0 defect critical/blocker còn mở**.
- Mọi "pass" có **evidence** (log/screenshot/trace) — pass không evidence không tính (mirror `qa-orchestrator` anti-hallucination).
- `status.qa=done` + `qa.signedOff=true` → mới đóng gate cuối. QA fail → `qa-bug-reporter` tạo defect → loop BE/FE (`status.be/fe → review`).

---

## Anti-patterns (NGHIÊM CẤM)

| Anti-pattern | Đúng |
|---|---|
| QA viết lại unit test cho hàm nội bộ | Để dev (`be-test-writer`/FE dev); QA test hành vi black-box |
| QA đọc code để "test theo implementation" | Test theo AC/spec quan sát từ ngoài (black-box) |
| Case không trace được AC/US nào | Loại case, hoặc báo BA bổ sung AC — KHÔNG bịa hành vi |
| Chạy execution khi `deps.qa` chưa thỏa (be/fe chưa done) | Chờ gate; trước đó chỉ làm test-design |
| Full performance/load test dán nhãn "perf-smoke" | perf-smoke = sanity ngưỡng thô; load test escalate ngoài scope |
| Bỏ qua tenant isolation vì "chắc BE lo rồi" | Luôn có case A↔B tenant leak cho FEAT có `tenantId` |
| "Pass" khai bằng miệng, không evidence | Đính log/screenshot/trace mọi kết quả pass |
| Đổi 1 dòng copy nhưng chạy full regression | tiny lane → smoke happy-path; đừng over-test |
| Sign-off khi còn defect critical mở | Giữ gate; không đóng `status.qa=done` |
| Smoke chạy sau khi test sâu | Smoke chạy **trước** (gate vào build) |

---

## Integration with other skills

- `qa-test-design` — sau khi chọn *type* ở skill này, chọn *kỹ thuật* (boundary/decision-table/state-transition…).
- `qa-e2e-playwright` — hiện thực System/E2E/a11y/visual (automation).
- `qa-api-test` — hiện thực black-box API test dựa trên FEAT §3 contract.
- `qa-exit-criteria` — chuẩn DoD/sign-off gate cuối.
- `qa-test-data` — test data + tenant isolation setup.
- `code-be-testing` — ranh giới: dev owns unit/integration/contract (KHÔNG trùng).
- `code-be-multitenancy` / `code-be-security` — nguồn cho security-test (tenant/authz).
- `code-fe-accessibility` — nguồn tiêu chí a11y (WCAG/axe).

---

## Checklist

- [ ] Xác định QA lane (tiny/normal/high-risk) trước khi chọn type
- [ ] Không viết type mà dev đã cover (unit/integration/contract)
- [ ] Mỗi case chọn được trace về ≥1 AC/US
- [ ] Acceptance phủ Happy / Edge / Error cho lane normal+
- [ ] Smoke happy-path xác định cho mọi build (gate vào)
- [ ] Regression suite cập nhật khi change chạm vùng đã ship
- [ ] Exploratory (charter) cho vùng high-risk
- [ ] a11y (axe) khi chạm UI mới/đổi form
- [ ] perf-smoke khi chạm list lớn/query nặng/upload
- [ ] security-test tenant isolation + authz cho FEAT có `tenantId`/phân quyền
- [ ] Execution chỉ chạy khi `deps.qa` (be.done+fe.done) thỏa
- [ ] Mọi pass có evidence; exit criteria đạt trước sign-off

---

## Related memory

- `feedback_no_test_without_ac.md`
- `feedback_qa_no_duplicate_dev_unit.md`
- `feedback_tenant_isolation_black_box.md`
- `feedback_evidence_backed_pass.md`
