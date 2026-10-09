# 08 — Execution, Result, Defect, AI Quality

Phiên bản đầu **chưa có agent** cho phần này. Rule dưới đây áp dụng cho bất kỳ vai nào được người dùng yêu cầu
làm các việc này.

## 1. Test Executor

- Chỉ chạy khi có môi trường và công cụ phù hợp, và người dùng yêu cầu.
- Mỗi case ghi: status, actual result, evidence (screenshot / log / HAR / trace), môi trường, build, ngày, người.
- Không đủ bằng chứng → không ghi Pass / Fail.
- Không chạy được → `Blocked` hoặc `Not Executed` kèm lý do.
- Không có công cụ → chỉ được lập kế hoạch chạy, hoặc mô phỏng gắn nhãn "mô phỏng, chưa thực thi".
- Hành động có thể phá dữ liệu / môi trường → dừng hỏi trước (`10-…`).

## 2. Result Analyzer

- Tổng hợp kết quả từ bản ghi thực thi thật; số liệu đếm lại từ dữ liệu.
- Nêu pattern lỗi và điểm bất thường.
- Tách **quan sát** với **root cause đã xác minh**. Root cause chưa có bằng chứng ghi là giả thuyết.

## 3. Defect Analyst

- Defect report có: bước tái hiện, expected (kèm nguồn requirement), actual, evidence, môi trường, impact.
- Severity / priority chỉ **đề xuất** kèm lý do; người có thẩm quyền quyết định.
- Không khẳng định root cause khi chưa có bằng chứng.
- Hành vi không có requirement làm căn cứ → không phải defect; ghi thành câu hỏi hoặc QA observation.

## 4. AI Quality Evaluator

Chỉ áp dụng khi sản phẩm có tính năng AI. Tiêu chí có thể gồm: độ đúng và bám ngữ cảnh · instruction
following · hallucination · prompt injection và input không tin cậy · privacy / data leakage · retry, timeout,
streaming, error recovery · tính nhất quán. Tiêu chí phải khớp requirement, threat model và phạm vi thật của
sản phẩm; không tự đặt ngưỡng.

## 5. Sau khi chạy

Regression Update và Knowledge Update chỉ dựa trên kết quả có bằng chứng (`09-traceability-knowledge.md`).
