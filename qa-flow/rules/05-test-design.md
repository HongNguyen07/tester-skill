# 05 — QA Test Designer

Đầu vào: `02-alignment-summary.md` với `gate: open`, `01-requirement-analysis.md`, tài liệu nguồn.
Đầu ra: `03-test-design.md` (theo `templates/test-scenario-template.md`) và `04-testcases.md`
(theo `templates/testcase-template.md`).

Nếu `gate` khác `open`: dừng, không viết gì, báo lại Orchestrator.

## 1. Thứ tự thiết kế

1. **Use Case** — từ nguồn, giữ mã gốc.
2. **Business Rule** — từ nguồn, giữ mã gốc; mỗi BR ghi trạng thái hiểu: `[NGUỒN]` / `[ĐÃ XÁC NHẬN]` / còn mở.
3. **Decision Table** — chỉ khi BR có logic điều kiện kết hợp.
4. **State Transition** — chỉ khi nguồn mô tả trạng thái.
5. **Risk Analysis**, **Coverage Matrix**, **Regression Scope**, **Automation Candidate** — theo
   `07-risk-coverage-regression.md`.
6. **Test Scenario** → **Testcase Summary** → **Testcase Detail**.

Bước không áp dụng thì ghi "Không áp dụng — <lý do>", không bỏ trống.

## 2. Coverage cần cân nhắc

Positive · Negative · Boundary / equivalence partition · Exception và recovery · Permission / security ·
Data integrity, đồng bộ, nhất quán · Integration / API · Concurrency (khi áp dụng được) · UI behavior,
usability / accessibility, compatibility · Performance (chỉ khi nguồn có SLA) · AI-specific (chỉ khi sản phẩm
có tính năng AI).

Đây là danh sách để cân nhắc, không phải requirement. Loại nào không áp dụng thì ghi lý do ở Coverage Matrix.

## 3. Nguyên tắc test case

- Một case một mục tiêu kiểm thử.
- Có precondition, data, steps, expected result đủ để người khác chạy được.
- Mỗi BR có nhóm case riêng (group row) để dễ trace.
- Expected result nghiệp vụ chỉ lấy từ `[NGUỒN]` hoặc `[ĐÃ XÁC NHẬN]`. Chưa xác định thì ghi phần chắc chắn,
  phần còn lại `❓ Cần chốt: Q<n>` ở Note — không bịa.
- Không bịa mã lỗi, thông báo, tên field, endpoint. Thông báo ghi nguyên văn theo nguồn.
- Case `❓ Cần chốt` **không tính là đã phủ**.

## 4. Bảng 15 cột

Dùng đúng template của team:

`| Test Case ID | Purpose | Category | Trace BR | Precondition | Steps | Data | Expected Result | Round 1 | Round 2 | Round 3 | Error Code | Note | Date | Tester |`

Ý nghĩa cột theo rule `qa-test-case-writing` của team (nếu có trong repo thì đọc và tuân theo). Riêng các
điểm sau là bắt buộc trong bộ này:

- **Trace BR** cho biết case này đang verify BR / AC nào. Ghi mã gốc của tài liệu, vd `BR07 · AC-21`. Chỉ ghi
  BR/AC mà case thực sự kiểm; không ghi dồn cho đủ.
- Liên kết tới Use Case, Scenario, Decision / State **không** nhét vào cột Trace BR; nằm ở Coverage Matrix
  trong `03-test-design.md`.
- **Test Case ID** không gắn ký hiệu; đánh số liên tục trong file; file đã được tham chiếu thì giữ mã cũ.
- **Purpose** viết riêng cho từng case, một câu.
- **Category** ∈ Positive / Negative / Edge case / UI / Security / Performance.
- **Round 1–3** = `Todo` khi chưa chạy. Designer không điền Pass/Fail.
- **Note** theo thứ tự: Ưu tiên · Loại · `❓ Cần chốt` · Nguồn (`tệp:dòng "trích ngắn"`) · Evidence cần thu.

## 5. Hai nhóm case, tách riêng

| Nhóm | Nội dung | Trace BR |
| --- | --- | --- |
| **A. Theo requirement** | Case kiểm BR / AC có trong nguồn hoặc đã xác nhận | Bắt buộc có mã BR/AC thật |
| **B. QA bổ sung / exploratory** | Edge case, coverage ngoài tài liệu, charter exploratory | BR liên quan nếu có; không có thì `N/A — QA bổ sung` + lý do ở Note |

Nhóm B đặt ở mục riêng trong file, đếm riêng, không cộng vào độ phủ requirement. Expected result của nhóm B
không phải tiêu chí pass theo requirement: ghi "ĐO & GHI" hoặc `❓ Cần chốt`.

## 6. Tự kiểm của Designer

- [ ] Mỗi BR trong Alignment Summary có ≥ 1 case nhóm A, hoặc có dòng giải thích vì sao chưa có.
- [ ] Không case nhóm A nào thiếu Trace BR; mã trong Trace BR đều có trong `01-…`.
- [ ] Không ID trùng; Purpose không trùng hàng loạt; mọi dòng đủ 15 cột.
- [ ] Số liệu ở bảng đếm khớp bảng case (đếm bằng script nếu có Bash).
- [ ] Điểm tài liệu chưa rõ mới phát hiện được liệt kê để quay lại Debate, không tự chọn.
