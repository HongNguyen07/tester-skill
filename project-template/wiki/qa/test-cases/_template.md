# Test Cases — <ID>: <tên feature>

| Thông tin | Giá trị |
| --- | --- |
| Mã trường hợp kiểm thử | <mã dùng làm tiền tố ID> |
| Tên trường hợp kiểm thử | <tên feature> |
| Tài liệu nguồn | `tailieu/<tệp>` (version ghi trong tệp) |
| Căn cứ cách hiểu | `02-alignment-summary.md`, cổng mở ngày <YYYY-MM-DD> |
| Trục trace | Trace BR = BR / AC mà case đang verify (mã gốc của tài liệu) |
| Người thiết kế · ngày | |

## Manual test

| | Pass | Fail | NA | Chưa thực hiện | Tổng |
| --- | ---: | ---: | ---: | ---: | ---: |
| Round 1 | 0 | 0 | 0 | <n> | <n> |
| Round 2 | 0 | 0 | 0 | <n> | <n> |
| Round 3 | 0 | 0 | 0 | <n> | <n> |

## A. Case theo requirement

| Test Case ID | Purpose | Category | Trace BR | Precondition | Steps | Data | Expected Result | Round 1 | Round 2 | Round 3 | Error Code | Note | Date | Tester |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| **BR01 — <tên BR>** | | | | | | | | | | | | | | |
| [<Mã>_01] | <một câu, riêng cho case này> | Positive | BR01 · AC-01 | | 1. …<br>2. … | | <chỉ từ `[NGUỒN]` / `[ĐÃ XÁC NHẬN]`> | Todo | Todo | Todo | | Ưu tiên: P1<br>Loại: …<br>Nguồn: `tệp:dòng "trích ngắn"`<br>Evidence: screenshot | | |
| [<Mã>_02] | | Negative | BR01 | | | | <phần chắc chắn> | Todo | Todo | Todo | | ❓ Cần chốt: Q-05<br>Nguồn: … | | |

## B. Case QA bổ sung / exploratory `[QA BỔ SUNG]`

Không tính vào độ phủ requirement. Kỳ vọng không phải tiêu chí pass theo requirement.

| Test Case ID | Purpose | Category | Trace BR | Precondition | Steps | Data | Expected Result | Round 1 | Round 2 | Round 3 | Error Code | Note | Date | Tester |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| [<Mã>_NN] | | Edge case | BR07 (liên quan) hoặc `N/A — QA bổ sung` | | | | ĐO & GHI: … | Todo | Todo | Todo | | Loại: QA bổ sung<br>Lý do thêm: … | | |

## Câu hỏi cần chốt

| Q | Nội dung | Case liên quan | Trạng thái |
| --- | --- | --- | --- |

## Thống kê

| | Nhóm A | Nhóm B |
| --- | ---: | ---: |
| Tổng case | | |
| Positive / Negative / Edge case / khác | | |
| Case `❓ Cần chốt` (chưa tính là đã phủ) | | |
| BR đã phủ / tổng BR | | — |

## Lịch sử cập nhật

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
