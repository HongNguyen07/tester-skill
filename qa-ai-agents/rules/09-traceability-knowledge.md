# 09 — Traceability và Knowledge Base

## 1. Chuỗi truy vết tối thiểu

- Requirement → Use Case → Business Rule → Decision / State (nếu có) → Test Scenario → Testcase →
  Execution Result → Defect
- Requirement → Testcase → Automation Candidate → Automation Status
- CX: Source / Requirement (nếu có) → Persona / Context → Customer Journey / Scenario → CX Finding →
  QA Testcase / Defect (nếu liên quan) → Product / BA Decision

Không có liên kết hợp lệ → ghi `N/A` hoặc `Unlinked` kèm lý do. Không tạo liên kết giả.

## 2. Liên kết nằm ở đâu

| Liên kết | File |
| --- | --- |
| Requirement / UC / BR ↔ nguồn (`tệp:dòng`) | `01-requirement-analysis.md` |
| Câu hỏi ↔ nguồn ↔ câu trả lời ↔ người xác nhận | `02-alignment-summary.md` |
| BR / AC ↔ UC ↔ Decision / State ↔ Scenario ↔ case | Coverage Matrix trong `03-test-design.md` |
| Case ↔ BR / AC đang verify | cột **Trace BR** trong `04-testcases.md` |
| CX finding ↔ nguồn ↔ persona ↔ case / defect | `05-cx-review.md` |

## 3. Quy ước mã

- Giữ mã gốc của tài liệu. Mã QA tự đánh phải ghi rõ là mã QA và ổn định qua các lần sửa.
- Câu hỏi: `Q-<nn>`. Kịch bản: `SC-<nn>`. CX finding: `CX-<nn>`. Đề xuất thay đổi: `CP-<nn>`.
- Mã đã được file khác tham chiếu thì không đổi; mục bị bỏ thì đánh dấu bỏ, không tái sử dụng số.

## 4. Knowledge Base

Thư mục `wiki/qa/knowledge/` (tạo khi có mục đầu tiên):

| File | Chứa |
| --- | --- |
| `product.md` | Chức năng, module, dependency, glossary **đã xác nhận** |
| `requirements.md` | Nguồn requirement, version, trạng thái xác nhận, lịch sử thay đổi |
| `test.md` | Scenario, case, coverage, test data tái sử dụng được |
| `defects.md` | Defect **đã xác minh**, pattern, regression liên quan |
| `cx.md` | CX finding đã quan sát, quyết định Product, bài học đã xác nhận |
| `decisions.md` | Quyết định đã được người có thẩm quyền xác nhận: nội dung, ai, ngày, nguồn, phạm vi áp dụng |

Quy tắc nhập:

- Chỉ nhập nội dung `[NGUỒN]` hoặc `[ĐÃ XÁC NHẬN]`, kèm nguồn và ngày.
- Giả thuyết, nhận định chưa xác minh, persona giả định **không** vào kho như dữ kiện. Nếu cần lưu để theo
  dõi, đặt ở mục "Chưa xác minh" tách riêng trong file.
- Mỗi lần cập nhật ghi ngày và feature nguồn. Mục sai thì sửa hoặc gạch, không để hai bản mâu thuẫn.
