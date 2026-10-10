# 07 — Risk, Coverage, Regression, Automation Candidate

Phiên bản đầu: do `qa-test-designer` thực hiện, ghi ở mục 5–9 của `03-test-design.md`.

## 1. Risk Analysis

- Đánh giá theo impact, likelihood, độ phức tạp, quyền hạn, dữ liệu, phạm vi ảnh hưởng — **khi có căn cứ**.
  Mỗi dòng ghi căn cứ (nguồn, điểm còn mở, lịch sử defect).
- Không có căn cứ cho một yếu tố thì ghi "chưa có dữ liệu", không tự cho điểm.
- Rủi ro là nhận định QA (`[QA BỔ SUNG]`), không phải acceptance criteria.

## 2. Coverage Matrix

Mỗi dòng một BR / AC: Use Case liên quan → Scenario → danh sách case nhóm A → trạng thái.

| Trạng thái | Điều kiện |
| --- | --- |
| Đã phủ | Có ≥ 1 case nhóm A không `❓` |
| Phủ một phần | Có case nhưng thiếu nhánh, hoặc một phần case `❓` |
| Chưa phủ | Chỉ có case `❓`, hoặc không có case |

Phải nêu được ba loại lỗ hổng: requirement không có case · case không có nguồn · coverage chưa rõ.
Coverage bắt buộc theo requirement và coverage QA bổ sung báo cáo **riêng**, không cộng chung.

## 3. Regression Scope

- Xác định từ thay đổi, dependency, khu vực bị ảnh hưởng, lịch sử defect (nếu có).
- Mỗi khu vực ghi căn cứ và giới hạn của phân tích.
- **Không** khẳng định một khu vực "không bị ảnh hưởng" khi không có dữ liệu dependency đủ tin cậy; ghi
  "chưa đủ dữ liệu để loại trừ".

## 4. Automation Candidate

- Đề xuất theo: độ ổn định, tần suất chạy, giá trị regression, khả năng kiểm tra kết quả, chi phí bảo trì.
- Mỗi ứng viên nêu dependency, test data, môi trường, điều kiện cần.
- Trạng thái mặc định `Candidate`. Chỉ ghi `Automated` khi có script và đường dẫn tới script.
