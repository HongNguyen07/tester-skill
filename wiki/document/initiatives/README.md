# Initiatives

> Scoped notes cho **product area lớn cần nhiều story** (≥ 5 tasks). KHÔNG dùng spec monolithic — mỗi initiative là 1 file riêng.
>
> Match harness pattern: "Large product areas should use scoped initiative notes instead of a second monolithic specification."

---

## Khi nào tạo initiative

- Product area cần nhiều story để hoàn thành (vd "Multi-tenant migration", "Add real-time chat module", "Migration sang event-driven")
- Scope vượt 1 service hoặc đụng cross-cutting (vd security, observability, performance)
- Cần nhiều ADR + nhiều story packet
- BA push 1 spec lớn → cần decompose thành initiative + N stories

## Khi nào KHÔNG tạo

- 1-3 task lẻ → chỉ tạo story packet thường
- Bug fix nhỏ → Change Request
- Maintenance task đơn lẻ → Maintenance type

---

## Naming convention

- File: `INIT-{NNN}_{slug}.md` (vd `INIT-001_multi-tenant-migration.md`)
- ID auto-increment, không reuse
- Status: `Planning` / `In Progress` / `Done` / `Cancelled` / `On Hold`

---

## Workflow

1. User trigger Type=`New Initiative`
2. Orchestrator dispatch `be-initiative-builder` (sub-agent mới)
3. Sub-agent đọc spec/SRS → output:
   - 1 file initiative tại đây
   - N candidate story packet (Pre-Code) tại `wiki/task/{service}/`
   - Link 2 chiều
4. User duyệt initiative → từng story tự enter pipeline khi đến lượt

---

## Index

| INIT-ID | Title | Status | Owner service(s) | # Stories | Created | File |
|---|---|---|---|---|---|---|
| _(chưa có)_ | | | | | | |

> Auto-update bởi be-wiki-logger khi có initiative mới.
