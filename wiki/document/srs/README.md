# SRS (Software Requirements Specification)

> **Thư mục này do BA (Business Analyst) quản lý và push vào.**
> Dev và Agent KHÔNG sửa trực tiếp nội dung SRS.

---

## Cách dùng

1. BA tạo file SRS theo tên feature: `{module}-{feature-name}-srs.md`
2. Dev hoặc Agent đọc SRS khi nhận intake form (field `Link SRS`)
3. Agent tham chiếu SRS khi phân tích yêu cầu và viết Acceptance Criteria

---

## SRS Index

| Module | Feature | File | Version | BA | Ngày |
|---|---|---|---|---|---|
| _(chưa có SRS nào — BA sẽ push vào)_ | | | | | |

---

## Template cho BA

```markdown
# SRS: {Module} — {Feature Name}

| Version | Date | Author | Changes |
|---|---|---|---|
| 1.0 | YYYY-MM-DD | {BA name} | Initial |

## 1. Business Context
...

## 2. User Stories
As a {role}, I want to {action} so that {benefit}

## 3. Functional Requirements
FR-01: ...
FR-02: ...

## 4. Non-Functional Requirements
NFR-01: Performance — ...
NFR-02: Security — ...

## 5. Business Rules
BR-01: ...

## 6. Acceptance Criteria
...

## 7. Out of Scope
...
```
