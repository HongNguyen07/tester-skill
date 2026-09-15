# Glossary — Domain & Technical Terms

> Khi gặp term không chắc nghĩa, đọc file này trước khi đoán. Add term mới khi gặp lần đầu.

---

## Domain Terms

| Term | Định nghĩa | Ghi chú |
|---|---|---|
| **Tenant** | Một đơn vị khách hàng độc lập (trường/trung tâm). Dữ liệu giữa tenant phải cô lập. | Mọi entity bắt buộc có `tenantId` (trừ entity dùng chung). |
| **Multi-tenancy** | Cơ chế cô lập dữ liệu theo `tenantId` — mọi query phải filter `tenantId` lấy từ JWT. | Xem `code-be-multitenancy` skill. |
| **Cross-tenant** | Truy cập dữ liệu của tenant khác → cấm trừ khi có flag `super-admin`. | Hard gate trong RISK_LANES. |
| **SRS** | Software Requirements Specification — tài liệu BA push vào trước khi dev code. | Lưu tại `document/srs/`. |
| **ADR** | Architecture Decision Record — ghi quyết định kiến trúc + lý do + alternatives. | Lưu tại `document/adr/`. |
| **Behavior ID** | Mã định danh 1 hành vi nghiệp vụ verifiable, format `{behaviorPrefix}-{NNN}`. | Dùng trong TEST_MATRIX, prefix lấy từ `.project-config.yml services[].behaviorPrefix`. |
| **Initiative** | Group ≥ 5 task vào 1 product area lớn. | Lưu tại `document/initiatives/`. |
| **Product Contract Snapshot** | Current state of a product domain (behaviors, API, decisions). | Lưu tại `document/product/`. |
| **Harness** | Operating environment cho agent (rules + templates + state). | Wiki = harness state. |
| **Harness delta** | Change ở chính harness (templates / rules / backlog), khác Product delta (code). | Mỗi task có thể tạo cả 2. |
| **Story Packet** | File task chứa Pre-Code (AC + Validation Plan) + Post-Code (results). | Template tại `task/_template.md`. |

---

## Service / Module

> _(điền sau khi bootstrap project — list services từ `.project-config.yml`)_

| Tên | Loại | Mô tả |
|---|---|---|
| _(chưa có)_ | | |

| Khái niệm | Định nghĩa |
|---|---|
| **Auth Server** | Service phát hành JWT, BCrypt password, AuditorAware (Spring Authorization Server). |
| **Resource Server** | Service verify JWT, áp `@PreAuthorize` (Spring OAuth2 Resource Server). |
| **Gateway** | API gateway routing requests sang backend services. |
| **Library** | Shared module (common DTO, exception, util) — không phải runnable service. |

---

## Technical Terms

| Term | Định nghĩa |
|---|---|
| **Soft delete** | Đánh dấu `deletedAt` thay vì xoá row. Mọi query phải filter `deletedAt IS NULL`. |
| **Liquibase** | Tool migration DB. Mỗi changelog phải có rollback file đi kèm. |
| **Specification** | Pattern Spring Data để build dynamic query — dùng cho search filter. |
| **MapStruct** | Code-gen mapper Entity ↔ DTO. KHÔNG viết mapping bằng tay. |
| **Enrich pattern** | Mapper gọi service khác để fill thêm field (vd: gắn tên user vào response). |
| **N+1 query** | Anti-pattern: 1 query lấy list + N query lấy chi tiết từng item. Phải batch load. |
| **IdResponse** | DTO chuẩn `{ id: string }` trả về sau create — KHÔNG trả full object. |
| **ApiResponse** | Envelope chuẩn `{ success, message, data, error }` cho mọi response. |
| **PermissionCode** | Class hằng số chứa string permission (`USER_CREATE`, `SUBJECT_UPDATE`...). |
| **SecurityContextUtil** | Util lấy current userId/tenantId từ JWT — KHÔNG inject `Authentication` vào controller. |
| **R2 Storage** | Cloudflare R2 (S3-compatible). Upload qua presigned URL, mark used sau khi save. |
| **HTTP Exchange** | Spring 6 declarative HTTP client (`@HttpExchange`) — thay cho RestTemplate/WebClient. |
| **TransactionalEventListener** | Spring event chạy sau commit transaction — dùng cho post-commit side-effect. |
| **Idempotency** | Cùng input → cùng output, không tạo duplicate. Bắt buộc cho Kafka consumer. |

---

## Risk & Lane Terms

| Term | Định nghĩa |
|---|---|
| **Risk flag** | 1 trong 10 cờ rủi ro của task (auth, data-model, ...). Xem RISK_LANES.md. |
| **Hard gate** | Risk flag bắt buộc auto high-risk (auth, audit-security, data migration...). |
| **Lane** | tiny / normal / high-risk — quyết định độ chặt chẽ của workflow. |
| **Blast radius** | Phạm vi ảnh hưởng nếu task fail (1 endpoint vs cả service vs cross-service). |

---

## Status Values

| Status | Khi nào dùng |
|---|---|
| `Planning` | Story packet vừa tạo (Pre-Code điền xong, chưa code) |
| `In Progress` | Đang code |
| `Done` | Code xong, checklist passed, AC verified, wiki log đầy đủ |
| `Blocked` | Dừng vì dependency / waiting clarification |
| `Cancelled` | Bỏ task — KHÔNG xoá file, đổi status + ghi lý do |

---

## Test Matrix Status

| Symbol | Nghĩa |
|---|---|
| ✅ covered | Có test, đang xanh |
| ⚠️ partial | Có test nhưng thiếu edge case |
| ❌ missing | Behavior tồn tại, chưa có test (nợ kỹ thuật) |
| 🚧 planned | Sẽ có test trong task X |
| 🗑️ removed | Behavior đã xoá |
