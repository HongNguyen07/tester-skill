---
featureId: <ID>
reviewedAt: <YYYY-MM-DD>
inputs: [01-requirement-analysis.md, 02-alignment-summary.md, 03-test-design.md, 04-testcases.md, 05-cx-review.md]
---

# Unified QA Review — <ID>: <tên feature>

Hợp nhất kết quả QA và CX. Hai phần giữ phân loại riêng, không trộn.

## 1. Trạng thái chung

| Mục | Giá trị |
| --- | --- |
| Cổng Alignment | open — <ai · ngày> |
| Điểm còn mở (trọng yếu / không trọng yếu) | <n> / <n> |
| Đã thực thi chưa | Chưa — chỉ thiết kế / Đã chạy: xem bản ghi <đường dẫn> |

## 2. Phần QA (theo requirement)

| Chỉ số | Giá trị |
| --- | --- |
| BR đã phủ / một phần / chưa phủ | |
| Case nhóm A (tổng · có `❓`) | |
| Case nhóm B — QA bổ sung (báo cáo riêng) | |
| Lỗ hổng coverage | |
| Rủi ro cao nhất | |
| Regression scope | |
| Automation candidate | |

## 3. Phần CX (quan sát và giả thuyết)

| Loại | Số lượng | ID |
| --- | ---: | --- |
| Defect (có bằng chứng thực tế) | | |
| Usability Issue | | |
| CX Risk | | |
| Improvement Suggestion | | |

Mode đã chạy và mức bằng chứng: <…>

## 4. Điểm giao nhau QA ↔ CX

| CX finding | Case / BR liên quan | Việc cần làm (QA xác minh / thêm case nhóm B / không) |
| --- | --- | --- |

## 5. Cần con người quyết định

| # | Điểm chờ quyết định | Nguồn / bằng chứng | Vì sao AI không tự quyết | Lựa chọn tài liệu hỗ trợ | Ảnh hưởng nếu chưa giải quyết | Ai quyết |
| ---: | --- | --- | --- | --- | --- | --- |

## 6. Change Proposal và đề xuất cải thiện (chưa là requirement)

| ID | Nội dung | Nguồn (CP từ Debate / CX suggestion) | Trạng thái |
| --- | --- | --- | --- |

## 7. Giới hạn của lượt review này

<phần chưa đọc, chưa chạy, chưa có công cụ, giả định còn dùng>

## 8. Việc tiếp theo

<danh sách ngắn, có người phụ trách nếu biết>
