# {Domain Name}

> **Product contract snapshot** cho domain này. Living document — be-wiki-logger auto-update.
> Đây là **current state** của contract, KHÔNG phải spec gốc (xem `wiki/document/srs/` cho input material).

| Thuộc tính | Giá trị |
|---|---|
| **Domain** | `{domain-slug}` |
| **Owner service(s)** | `{service-a}, {service-b}` |
| **Status** | `Draft` / `Active` / `Deprecated` |
| **Last updated** | `YYYY-MM-DD` (by TASK-ID) |
| **Related initiatives** | `INIT-{NNN}` (link nếu có) |

---

## Purpose

> 2-3 câu nghiệp vụ. Domain này giải quyết bài toán gì cho người dùng cuối?

---

## Behaviors

> Tất cả behavior public của domain này. Mỗi row link sang test-matrix + story packet.

| Behavior ID | Mô tả | Status | Test status | Owner story |
|---|---|---|---|---|
| `{PREFIX}-001` | User đăng nhập trả JWT | Active | ✅ covered | [{PREFIX}-T001](../../task/{service}/{PREFIX}-T001_login.md) |
| `{PREFIX}-002` | User đổi password | Active | ⚠️ partial | [{PREFIX}-T015](...) |

---

## API surface

> Endpoint chính của domain. Detail per endpoint xem `wiki/document/api-specs/{service}/`.

| Endpoint | Method | Permission | Service |
|---|---|---|---|
| `/api/v1/users` | POST | USER_CREATE | auth |
| `/api/v1/users/{id}` | GET | USER_VIEW | auth |

---

## Domain entities

> List entity owned by domain này. Detail xem `wiki/technical/entity/{service}/`.

| Entity | Service | Bảng DB |
|---|---|---|
| User | auth | auth_users |
| RefreshToken | auth | auth_refresh_tokens |

---

## Cross-domain interactions

> Domain này gọi / consume domain khác.

| Direction | Target | Mechanism | Mục đích |
|---|---|---|---|
| Calls | `catalog` | HTTP GET /products | Validate product exists khi user đặt order |
| Publishes | `auth.user.created` event | Kafka | Notify other domains |

---

## Business rules

> Constraints + invariants quan trọng. KHÔNG technical detail, chỉ rules nghiệp vụ.

- Email unique per tenant
- Password ≥ 8 chars, ≥ 1 digit, ≥ 1 special
- Soft delete: user record giữ 90 ngày trước hard delete

---

## Decisions affecting this domain

| ADR | Title | Status | Date |
|---|---|---|---|
| `ADR-007` | _(vd: Use BCrypt cost 12)_ | Accepted | YYYY-MM-DD |

---

## Open questions

> Câu hỏi nghiệp vụ chưa chốt — cần BA confirm.

- [ ] _(vd: Khi delete user, các comment họ post bị xoá hay anonymize?)_

---

## Change log

> be-wiki-logger append mỗi khi behavior thay đổi.

- `YYYY-MM-DD` (TASK-ID): Added `{PREFIX}-005` — User reset password via email
- `YYYY-MM-DD` (TASK-ID): Deprecated `{PREFIX}-002` (replaced by `{PREFIX}-007`)
