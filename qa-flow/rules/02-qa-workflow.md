# 02 — Workflow QA

## 1. Chuỗi thiết kế

Requirement → Requirement Analysis → **Requirement Debate & Alignment** → Use Case → Business Rule →
Decision Table (nếu có logic điều kiện) → State Transition (nếu có trạng thái) → Risk Analysis →
Coverage Matrix → Test Scenario → Testcase Summary → Testcase Detail → Regression Scope → Automation Candidate

Chuỗi nối tiếp khi sản phẩm truy cập được và có công cụ:

Test Execution → Result Analysis → Defect Analysis → Regression Update → Knowledge Update

Customer Experience Agent chạy **song song** với QA Test Designer, sau khi cổng Alignment đã mở cho phạm vi
được review.

## 2. Bắt đầu một feature

1. Hỏi tên/ID feature, mục tiêu, phạm vi — từng câu, theo hội thoại; không đưa form dài.
2. Yêu cầu tài liệu BA và tài liệu liên quan; nếu có UI design / prototype thì nhận thêm cho CX.
3. Tạo `wiki/qa/features/<ID>/`. Nếu thư mục đã có, đọc trạng thái (§4) và tiếp tục từ giai đoạn dở.
4. Làm lần lượt S3 → S5 theo bảng ở `CLAUDE.md` §2.

## 3. Điều kiện chuyển giai đoạn

| Từ → sang | Điều kiện |
| --- | --- |
| S3 → S4 | `01-requirement-analysis.md` đã ghi đủ nguồn, phạm vi đã đọc, danh sách điểm chưa rõ |
| S4a → S4b | Điểm trọng yếu còn mở = 0 (BA đã trả lời) |
| S4b → S5 | Debate đã đi hết các nhóm BR; mục 4 Alignment Summary có nội dung |
| S5 → S6/S7 | `gate: open` do người dùng xác nhận |
| S6/S7 → S9 | Cả hai sub-agent đã ghi file và tự kiểm |
| S9 → S10 | Có môi trường, công cụ, và người dùng yêu cầu chạy |

Khi điều kiện chưa đạt: dừng, nói rõ đang thiếu gì theo mẫu ở `10-human-in-the-loop.md` §2. Không làm tắt.

## 4. Trạng thái feature

Ghi ở frontmatter của `02-alignment-summary.md`:

```yaml
featureId: <ID>
stage: S3 | S4a | S4b | S5 | S6-S7 | S9 | S10
gate: closed | open
materialOpen: <số điểm trọng yếu còn mở>
nonMaterialOpen: <số điểm không trọng yếu còn mở>
gateOpenedBy: <tên người dùng>      # trống khi closed
gateOpenedAt: <YYYY-MM-DD>
```

## 5. Quay lại giai đoạn trước

- Test Designer hoặc CX Agent gặp điểm tài liệu chưa rõ → không tự chọn cách hiểu; ghi vào danh sách trả về,
  Orchestrator đưa lại S4.
- Điểm mới là **trọng yếu** → `gate: closed` cho phần phạm vi bị ảnh hưởng; phần còn lại giữ nguyên.
- Tài liệu nguồn thay đổi → cập nhật `01-…`, rà lại `02-…`, đánh dấu case bị ảnh hưởng.
- Đề xuất cải thiện UX/CX không quay lại S4; ghi ở luồng riêng trong `05-cx-review.md`.

## 6. Giao việc cho sub-agent

Prompt giao việc phải có: đường dẫn thư mục feature, đường dẫn tài liệu nguồn, phạm vi được review, danh
sách điểm không trọng yếu còn mở, và câu "ghi file trước, báo cáo sau". Hai agent ghi vào file khác nhau nên
chạy song song được.
