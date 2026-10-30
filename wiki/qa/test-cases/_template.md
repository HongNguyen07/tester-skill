# Test Cases — <ID>: <tên feature>

> Expected Result ghi **theo từng bước**: mỗi dòng bắt đầu bằng số bước tương ứng trong Steps (bước trung gian không có gì kiểm thì bỏ số). Rule đầy đủ: skill `qa-test-case-writing` §2.

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
| [<Mã>_01] | <một câu, riêng cho case này> | Positive | BR01 · AC-01 | | 1. <thao tác><br>2. <thao tác><br>3. <quan sát> | | 2. <kết quả sau bước 2 — chỉ từ `[NGUỒN]` / `[ĐÃ XÁC NHẬN]`><br>3. <kết quả sau bước 3; thông báo "nguyên văn"> | Todo | Todo | Todo | | Ưu tiên: P1<br>Loại: …<br>Nguồn: `tệp:dòng "trích ngắn"`<br>Evidence: screenshot | | |
| [<Mã>_02] | | Negative | BR01 | | 1. …<br>2. … | | 2. <phần chắc chắn>; Chờ Q-05: <phần tài liệu chưa nói> | Todo | Todo | Todo | | ❓ Cần chốt: Q-05<br>Nguồn: … | | |

## B. Case QA bổ sung / exploratory `[QA BỔ SUNG]`

Không tính vào độ phủ requirement. Kỳ vọng không phải tiêu chí pass theo requirement.

| Test Case ID | Purpose | Category | Trace BR | Precondition | Steps | Data | Expected Result | Round 1 | Round 2 | Round 3 | Error Code | Note | Date | Tester |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| [<Mã>_NN] | | Edge case | BR07 (liên quan) hoặc `N/A — QA bổ sung` | | 1. …<br>2. … | | 2. ĐO & GHI: … | Todo | Todo | Todo | | Loại: QA bổ sung<br>Lý do thêm: … | | |

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
