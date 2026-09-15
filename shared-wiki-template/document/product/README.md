# Product Contract Snapshots

> **Current product contract** per domain. Living document — auto-updated bởi be-wiki-logger sau mỗi task có behavior change.
>
> Match harness pattern: `docs/product/*` = current product contract derived from accepted input. Trước implementation = describe intent; sau implementation = product docs + executable tests = living contract.

---

## Vai trò

- **1 file per domain** (vd `user-management.md`, `catalog.md`, `payment.md`)
- **Snapshot** trạng thái hiện tại của product contract — KHÔNG phải spec gốc, KHÔNG phải post-code dev doc
- Agent đọc khi cần hiểu "behavior X hiện tại là gì" mà không phải gộp api-spec + dev-doc + entity
- Distinct với:
  - `srs/` = input material (BA push, raw, không update sau)
  - `api-specs/` = per-endpoint shape (auto-generated post-code)
  - `dev-document/` = implementation guide (technical, not contract)

## Naming

- File: `{domain-slug}.md` (vd `user-management.md`, `catalog.md`)
- 1 file per **product domain** (= business area, KHÔNG phải code module)
- 1 domain có thể span nhiều service

## Khi nào tạo

- Task đầu tiên đụng domain mới → be-wiki-logger tự tạo từ template
- Initiative mới có affected domain → be-initiative-builder tạo

## Khi nào update

- Mọi task có Behavior ID mới ở domain → be-wiki-logger update section behaviors
- ADR Accepted đổi contract → be-wiki-logger update section "Decisions"
- Spec slice / Change request → update "Status" của behavior tương ứng

## Index

| Domain | Owner service(s) | Total behaviors | Last updated |
|---|---|---|---|
| _(chưa có)_ | | | |

> Auto-update bởi be-wiki-logger.
