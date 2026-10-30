# Risk Lanes — Intake Gate (SHARED, multi-discipline)

> **File CHUNG cho cả 3 discipline** (BA / BE / FE) trong wiki chung. Mỗi orchestrator đọc
> **section của discipline mình** (`.project-config.yml → discipline`): **BE** dùng "Risk Flags"
> + "Hard Gates" ngay dưới; **FE** dùng "## Lanes — FE (fe-nextjs)"; **BA** dùng
> "## Lanes — BA (nghiệp vụ)". Các section KHÔNG đè nhau.
>
> **Mục đích chung:** mọi yêu cầu qua gate này TRƯỚC khi orchestrator tạo TODO/story/claim FEAT.
> Flow chung: đếm flag → check hard gate → chọn lane (tiny / normal / high-risk) → áp yêu cầu lane.

---

## Flow

```
Intake Form đã điền
        │
        ▼
Đếm Risk Flags (bảng dưới)
        │
        ▼
Check Hard Gates
        │
        ▼
Chọn Lane: tiny / normal / high-risk
        │
        ▼
Áp dụng yêu cầu của lane → tạo TODO + story packet phù hợp
```

---

## Risk Flags

Tick mỗi flag mà yêu cầu chạm vào:

| Flag | Áp dụng khi yêu cầu chạm vào |
|---|---|
| `auth` | login, logout, session, JWT, password, refresh token, OAuth flow |
| `authorization` | role, permission, `@PreAuthorize`, tenantId scope, cross-tenant rule |
| `data-model` | entity mới, schema change, Liquibase migration, unique constraint, soft delete, retention |
| `audit-security` | audit log, sensitive data (PII, payment), access log, encryption |
| `external-system` | gọi service ngoài (HTTP client mới), Kafka producer/consumer mới, R2 storage, email, payment provider |
| `public-contract` | API shape thay đổi (request/response), error code mới, response envelope |
| `cross-domain` | đụng > 1 domain (vd Subject + Product + User trong cùng task) |
| `existing-behavior` | sửa behavior đã có user dùng / đã có test cover |
| `weak-proof` | vùng code bị sửa chưa có unit/integration test |
| `performance-critical` | endpoint read-heavy, query có khả năng N+1, batch job, scheduled task |

---

## Hard Gates (auto high-risk)

Bất kỳ điều nào sau đây → **bắt buộc high-risk**, trừ khi user xác nhận thu hẹp scope:

- `auth` (Auth Server, password, JWT issuance)
- `authorization` thay đổi PermissionCode hoặc cross-tenant rule
- `data-model` có **migration phá vỡ dữ liệu cũ** (drop column, rename, change type)
- `audit-security` ghi/đọc dữ liệu nhạy cảm
- `external-system` payment / email gửi đi production
- Xoá hoặc nới lỏng validation đã có

---

## Classification

| Số flag | Lane | Hành động |
|---|---|---|
| 0–1 flag, không hard gate | **tiny** | Patch trực tiếp, không cần story packet đầy đủ |
| 2–3 flag, không hard gate | **normal** | Bắt buộc story packet đầy đủ + checklist tương ứng |
| ≥ 4 flag, hoặc bất kỳ hard gate | **high-risk** | Story packet đầy đủ + design note + xác nhận user trước khi code |

---

## Yêu cầu theo lane

### Tiny

- KHÔNG cần story packet riêng — log gọn vào task hiện có hoặc tạo task ngắn (`status` jump thẳng `Done`).
- Không cần update `TEST_MATRIX.md` trừ khi tạo behavior mới.
- Vẫn phải chạy checklist cơ bản (ví dụ: nếu sửa entity → `checklist-entity.md`).

### Normal (mặc định)

- Tạo story packet đầy đủ từ `task/_template.md`:
  - **Acceptance Criteria điền TRƯỚC khi code** (không phải sau).
  - **Validation expectations điền TRƯỚC khi code** (mục nào sẽ có unit / integration / e2e test).
- Update `TEST_MATRIX.md` với row mới cho behavior thêm vào.
- Áp dụng đầy đủ checklist từ skills đã chọn.
- Không cần xác nhận user thêm sau khi đã duyệt TODO.

### High-Risk

- Tất cả yêu cầu của normal, cộng thêm:
- Tạo file design note: `wiki/document/adr/ADR-{id}_{topic}.md` ghi rõ:
  - **Context:** vì sao thay đổi
  - **Decision:** chọn approach nào
  - **Alternatives considered:** các phương án bị loại
  - **Consequences:** rủi ro, rollback plan
- **DỪNG sau khi tạo TODO + story packet + ADR draft, hỏi user xác nhận lần 2** trước khi code.
- Chia code thành nhiều PR nhỏ nếu blast radius lớn.
- Bắt buộc có rollback plan trong Liquibase + ghi vào ADR.

---

## Output bắt buộc của intake gate

Sau khi chạy gate, agent phải in ra block sau **trước** TODO list:

```
## Risk Assessment
- **Lane:** tiny | normal | high-risk
- **Flags:** auth, authorization, data-model, ...
- **Hard gates triggered:** none | <list>
- **Reason:** <1-2 câu giải thích vì sao chọn lane này>
- **Story packet:** <path file task hoặc "patch trực tiếp">
- **ADR required:** yes (link draft) | no
- **Test matrix rows affected:** <list behavior IDs>
```

Ví dụ:

```
## Risk Assessment
- Lane: high-risk
- Flags: auth, authorization, data-model, audit-security, external-system
- Hard gates triggered: auth (issue JWT mới), data-model (migration thêm cột tenant_id)
- Reason: Đụng JWT issuance + migration không rollback được nếu data đã ghi.
- Story packet: wiki/task/auth-service/TASK-042_multi-tenant-jwt.md
- ADR required: yes — wiki/document/adr/ADR-007_multi-tenant-jwt.md
- Test matrix rows affected: AUTH-005, AUTH-006, AUTH-012
```

---

## Lanes — FE (fe-nextjs)

> `fe-architecture` đọc section này. Flow/lane (tiny/normal/high-risk) như trên; flag riêng FE:

| Flag FE | Áp dụng khi |
|---|---|
| `xss-risk` | render HTML động, dangerouslySetInnerHTML, user-content, markdown |
| `design-system-drift` | tự chế component thay vì dùng common (Button/Input/DataTable/Dialog...) |
| `accessibility-regress` | thiếu alt/aria/keyboard-nav, contrast < 4.5:1, heading sai cấp |
| `server-client-boundary-leak` | import DB/secret vào client, `'use client'` trên page/layout, env nhạy cảm ra bundle |
| `public-form-leak` | form public (login/checkout) không validate/không auth-check trong Server Action |
| `auth-flow-touch` | đụng luồng auth/session/redirect phía FE |

Hard gate FE (auto high-risk): `public-form-leak`, `auth-flow-touch`, `server-client-boundary-leak`.

## Lanes — BA (nghiệp vụ)

> `ba-orchestrator` đọc section này. Đây là intake gate nghiệp vụ (không code).

| Input type | Lane mặc định |
|---|---|
| New engagement / phase activity thường | tiny–normal theo impact artifact |
| Change request lên artifact đã agreed | normal + cross-check + review |
| Đổi scope sau sign-off, đổi methodology, chạm compliance, đè artifact signed-off | **high-risk** (bắt buộc confirm user + CR) |

Hard gate BA (auto high-risk): `scope-after-signoff`, `methodology-change`, `compliance`,
`signed-off-artifact-change`. Chi tiết flow intake BA + phase routing: xem
`wiki/analysis/WORKFLOW.md` (overlay BA).

## Lanes — QA (tester)

> `qa-orchestrator` đọc section này. Đây là **test-risk** gate: xác định độ sâu test cần cho FEAT.
> Flow/lane (tiny/normal/high-risk) như trên; flag riêng QA:

| Flag QA | Áp dụng khi |
|---|---|
| `data-integrity` | tính tiền, tồn kho, số dư, migration — sai là hỏng dữ liệu |
| `security-test` | auth/permission/tenant-scope — cần test phân quyền + rò rỉ |
| `regression-scope` | đụng luồng nghiệp vụ chính đã ship → cần regression rộng |
| `cross-service-e2e` | flow xuyên nhiều BE service (contract nhiều bên) |
| `multi-tenant-isolation` | dữ liệu phải cô lập giữa tenant |
| `flaky-risk` | phụ thuộc thời gian/thứ tự/async → test dễ flaky |
| `no-ac-source` | FEAT thiếu AC rõ để viết case (BA gap) → **chặn**, báo BA |

Hard gate QA (auto high-risk): `data-integrity`, `security-test`, `cross-service-e2e`,
`multi-tenant-isolation`. Lane quyết định độ phủ: **tiny** = smoke happy-path;
**normal** = Happy/Edge/Error đủ AC; **high-risk** = thêm exploratory + a11y + automation regression + confirm scope.
