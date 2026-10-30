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

### HB-002 — 7 clarification gap ZALO-OTP chưa chốt, chặn 2 case + để trống mã lỗi 4 case
- **Phát hiện ngày:** 2026-09-28
- **Phát hiện trong task:** FEAT ZALO-OTP — Phase 9 `qa-wiki-logger` (nguồn: `wiki/qa/test-cases/ZALO-OTP.md` §3)
- **Loại:** missing-ac
- **Friction:** Spec raw ZALO-OTP (chưa có AC chính thức qua FEAT) còn 7 gap chưa chốt kỳ vọng. Ưu tiên cao nhất là **Gap #7** (rủi ro bảo mật): `phone_change` cho phép đổi số điện thoại liên tục để "làm mới" bộ đếm `verify_lock` theo cặp `uuid+phone` — attacker né được khóa verify sớm, chỉ còn bị chặn cuối cùng bởi `phone_change_lock` (5 lần) thay vì `verify_lock` (5 lần/cặp) — chặn TC-ZALO-OTP-67. **Gap #5** (S2-05 check trùng số có áp đủ 3 biến thể `0/84/+84` không) chặn TC-ZALO-OTP-11. **Gap #6** (Section 8 không có `errorCode` cho lỗi validate cơ bản uuid/phone sai format) khiến 4 case TC-ZALO-OTP-04→07 phải để trống cột mã lỗi.
- **Đề xuất:** BA + Security trả lời Gap #7 trước tiên (đây là quyết định thiết kế bảo mật, không chỉ test gap); BE trả lời Gap #5/#6 để mở khóa 5 case còn lại. Trả lời tại `wiki/qa/test-cases/ZALO-OTP.md` §3, sau đó cập nhật case ❓ trước khi dispatch `qa-automation-builder`/`qa-test-executor` cho các case liên quan.
- **Ưu tiên:** P0 (Gap #7 — security bypass), P1 (Gap #5, #6 và 4 gap còn lại #1–#4)
- **Status:** open

### HB-003 — Project thiếu FEAT spine (ZALO-OTP, Z-02) → QA pipeline chuẩn không áp được đủ (bỏ checklist §4.4 / roll-up §5 / sign-off gate)
- **Phát hiện ngày:** 2026-09-28
- **Phát hiện trong task:** FEAT ZALO-OTP — Phase 9 `qa-wiki-logger`
- **Loại:** process-debt
- **Friction:** `wiki/features/FEAT-*.md` không tồn tại cho ZALO-OTP (và Z-02) — nguồn duy nhất là raw spec `wiki/document/srs/*.md`. `qa-wiki-logger` (Phase 9, quy trình chuẩn) không thể: (a) tick QA checklist §4.4 trong FEAT, (b) update roll-up §5, (c) chạy sign-off gate (`status.qa`/`milestones.qa.signedOff` không có nơi ghi). `QA_COVERAGE_MATRIX.md` cũng phải biến tấu cột "FEAT" thành id + ghi chú `(no FEAT spine)` thay vì roll-up chuẩn theo FEAT.
- **Đề xuất:** (a) BA tạo `FEAT-xxx.md` chính thức cho 2 spec này để vào luồng chuẩn có AC/status/milestones; **hoặc** (b) bổ sung chính thức "chế độ spec-sourced" vào `qa-orchestrator` + `qa-test-planner` + `qa-wiki-logger` — định nghĩa rõ: matrix hiển thị thế nào khi không có FEAT, ai/khi nào được sign-off, roll-up thay thế ra sao khi thiếu spine.
- **Ưu tiên:** P1
- **Status:** open

### HB-004 — Spec ZALO-OTP thiếu contract mã lỗi cho validate cơ bản (uuid/phone sai format)
- **Phát hiện ngày:** 2026-09-28
- **Phát hiện trong task:** FEAT ZALO-OTP (`wiki/qa/test-cases/ZALO-OTP.md` Gap #6, §3)
- **Loại:** contract-mismatch
- **Friction:** Section 8 của spec chỉ liệt kê mã lỗi nghiệp vụ (30014–30028) cho các nhánh S2-03 trở đi; không có `errorCode` cho lỗi validate cơ bản ở S2-01/S2-02 (uuid rỗng/sai format, phone rỗng/sai định dạng). 4 test case (TC-ZALO-OTP-04→07) phải để trống cột "Mã lỗi" vì không được tự chế (anti-hallucination rule 3).
- **Đề xuất:** BE bổ sung vào contract Section 8 (hoặc tài liệu API riêng): dùng mã lỗi validate framework chuẩn (HTTP 422/400 field errors) hay `errorCode` nghiệp vụ riêng cho input validation.
- **Ưu tiên:** P1
- **Status:** open

### HB-005 — Gap #8 (verify): thứ tự kiểm tra 30029/30014 và việc tính vào bộ đếm khóa chưa rõ
- **Phát hiện ngày:** 2026-10-02
- **Phát hiện trong task:** FEAT ZALO-OTP — Phase 9 (nguồn: `tailieu/8-verify-ma-otp.md`, `wiki/qa/test-cases/ZALO-OTP.md` §3 Gap #8)
- **Loại:** missing-ac
- **Friction:** Tài liệu verify không nói rõ 30029 (`account_already_verified`) / 30014 (phone đã verify bởi account khác) được kiểm tra trước hay sau 30028/30025, và có tăng `failedAttempts`/bộ đếm khóa hay không. TC-60 và TC-99 phải đánh dấu ⚠️.
- **Đề xuất:** BE xác nhận thứ tự + hiệu ứng lên bộ đếm, ghi vào tài liệu; sau đó QA gỡ ⚠️ cho TC-60/TC-99.
- **Ưu tiên:** P1
- **Status:** open

### HB-006 — Gap #6 vẫn mở: QA từng thấy 11000 ở send-otp (2026-09-30) nhưng không lưu evidence
- **Phát hiện ngày:** 2026-10-02
- **Phát hiện trong task:** FEAT ZALO-OTP — Phase 9
- **Loại:** evidence-gap
- **Friction:** Quan sát thực tế mã 11000 cho validation lỗi không có request/response lưu lại nên không dùng được làm căn cứ chốt TC-04/06 (vẫn ❓). Gap #6 cũng đã nằm ở HB-004 — cập nhật: spec `tailieu/8` đã ghi 11000 cho verify, send-otp vẫn chưa xác nhận bằng tài liệu.
- **Đề xuất:** Khi probe API thực tế (api-dev), lưu ngay evidence (curl + response + timestamp) vào `wiki/qa/test-runs/` hoặc đính kèm gap; BE xác nhận 11000 cho send-otp để đóng HB-004.
- **Ưu tiên:** P2
- **Status:** open

### HB-007 — quality-trend: dòng reviewer append nằm sai vị trí (sau mục "Đọc trend")
- **Phát hiện ngày:** 2026-10-02
- **Phát hiện trong task:** FEAT ZALO-OTP — Phase 8/9
- **Loại:** process-debt
- **Friction:** Reviewer append 2 dòng bằng cách nối cuối file, khiến chúng nằm ngoài bảng Markdown (sau đoạn "Đọc trend"). Phase 9 đã dời lên liền bảng (không đổi nội dung).
- **Đề xuất:** Hướng dẫn qa-reviewer chèn dòng trend ngay sau hàng cuối của bảng (trước mục "## Đọc trend"), không append cuối file.
- **Ưu tiên:** P2
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
