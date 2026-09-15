# Harness Backlog — Growth From Friction

> **Mục đích:** Bộ skill `java-architecture` không phải static. Mỗi khi agent gặp friction (confused, repeat manual reasoning, thiếu rule, gặp recurring failure), phải log vào đây để cải tiến harness.
>
> **Khác với task thường:** Task = công việc cho user / sản phẩm. Backlog item = công việc cho **chính bộ skill / wiki / template**.

---

## Khi nào agent log vào đây

Bắt buộc log proposal khi:

1. Agent phải hỏi user 1 câu mà câu đó nên có trong Intake Form / RISK_LANES.
2. Agent gặp tình huống không có skill cover (ví dụ: WebSocket, gRPC, GraphQL, Saga pattern...).
3. Cùng 1 lỗi gặp ≥ 2 lần trong các task khác nhau (recurring failure).
4. Checklist có mục mơ hồ → agent không biết pass/fail.
5. Template (`task/_template.md`, `release/_template.md`) thiếu field cần dùng.
6. Có rule mới user nói "lần sau làm thế này" → ghi lại để khỏi hỏi lại.

---

## Format mỗi item

```
### HB-{NNN} — {Tên ngắn}
- **Phát hiện ngày:** YYYY-MM-DD
- **Phát hiện trong task:** TASK-{id} (link)
- **Loại:** missing-skill | template-gap | rule-clarification | checklist-fix | new-template | recurring-bug
- **Friction:** Mô tả 1-2 câu agent đã bị vướng cái gì
- **Đề xuất:** Sửa file nào / thêm gì
- **Ưu tiên:** P0 (block luôn) | P1 (sprint sau) | P2 (nice to have)
- **Status:** open | in-progress | done | wontfix
```

---

## Open Items

### HB-001 — Ví dụ: thiếu skill cho WebSocket
- **Phát hiện ngày:** 2026-05-09
- **Phát hiện trong task:** TASK-XXX
- **Loại:** missing-skill
- **Friction:** User yêu cầu tạo endpoint WebSocket cho real-time chat. Bộ `java-skill` chỉ có HTTP REST patterns, không có rule cho STOMP / Spring WebSocket / session management.
- **Đề xuất:** Thêm skill `code-be-websocket` với SKILL.MD + checklist. Thêm field "Realtime?" vào Intake Form section 4.
- **Ưu tiên:** P1
- **Status:** open

---

## Done Items (changelog)

> Khi item chuyển `done`, di chuyển xuống đây kèm ngày + commit/PR link.

| HB-ID | Tên | Done date | Bằng cách nào |
|---|---|---|---|
| _(chưa có)_ | | | |

---

## Quy tắc

1. Không xoá item — chỉ chuyển status `wontfix` + ghi lý do.
2. Mỗi sprint review, lọc P0/P1 để xử lý.
3. Khi 1 backlog item được fix → update SKILL.MD / checklist / template / Intake Form tương ứng, **rồi** chuyển item về Done.
4. Nếu cùng pattern friction xuất hiện ở nhiều backlog item → gom thành 1 ADR (`document/adr/`) thay vì chỉ patch lẻ.
