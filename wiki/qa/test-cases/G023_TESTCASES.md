# [G023] — Gửi danh thiếp & Sticker — TESTCASES

| Mục | Giá trị |
|---|---|
| Tên màn hình/Tên chức năng | G023 — Gửi danh thiếp & Sticker |
| Thiết bị, hệ điều hành | |
| Mã trường hợp kiểm thử | G023 |

**Manual test**

| Chỉ số | Số lượng |
|---|---|
| Số trường hợp kiểm thử đạt (P) | 0 |
| Số trường hợp kiểm thử không đạt (F) | 0 |
| Số trường hợp kiểm thử đang xem xét (NA) | 0 |
| Số trường hợp kiểm thử chưa thực hiện | 35 |
| Tổng số trường hợp kiểm thử | 35 |

> **Đã chuyển sang template test case chuẩn ngày 2026-10-08** (rule: skill `qa-test-case-writing`). Bản trước khi chuyển: `wiki/qa/_backup/test-cases_2026-10-08_truoc-rule-moi/`.
> Cột cũ → cột mới: *Trace* → **Trace BR** · *Loại* → **Category** (giá trị gốc giữ ở Note `Loại:`) · *Mã lỗi* (mã lỗi kỳ vọng) → cuối **Expected Result** (`Mã lỗi kỳ vọng:`), cột **Error Code** nay để tester điền mã bug khi Fail · *Nguồn tài liệu*, *Evidence-required*, *Trạng thái*, dấu ❓/⚠ cạnh mã → **Note**. Các mục "quy ước / cách đọc" bên dưới nếu nhắc tên cột cũ thì hiểu theo bảng đổi này.
> Mã test case giữ nguyên như trước khi chuyển (đang được intake / test plan / point report / ma trận tham chiếu).
> ⚠ **Chưa đạt rule ở 3 cột:** Precondition, Steps, Data của toàn bộ case trong file này là câu mẫu chung ("Chuẩn bị Preconditions… Thực hiện thao tác theo Test Case…"), Expected Result chỉ lặp lại tên case. Đã đưa về đúng cột của template nhưng **cần viết lại nội dung theo spec G023** thì case mới chạy được.

## 1. Requirement Information

| Item | Value |
|---|---|
| Feature ID | G023 |
| Feature Name | Gửi danh thiếp & Sticker |
| Source | G023 - Gửi danh thiếp & Sticker.md |
| Total Test Cases | 35 |
| Documentation Standard | QA Specification v1.1 |

## 2. Requirement Analysis

- Requirement chính thức: danh thiếp lấy từ danh bạ Zalo, chọn tối đa 9, có toggle gửi kèm SĐT; sticker có Gần đây và gửi ngay.
- Coverage QA bổ sung: boundary chọn 0/1/9/10 danh thiếp, search theo tên/SĐT, multi-account, retry, duplicate-click, picker empty/loading.
- Cần BA/Dev xác nhận: mặc định toggle 'Gửi kèm số điện thoại' là BẬT hay TẮT; thứ tự danh bạ; hành vi khi sticker bộ đã tải bị lỗi tải.

## 3. Use Cases

UC-01, UC-02

## 4. Business Rules

BR01, BR01b, BR01c, BR02, BR03, BR04, BR05, BR06, BR07

## 5. Decision Table

| D | Nội dung | Điều kiện | Expected |
|---|---|---|---|
| D01 | Danh thiếp | 1-9 liên hệ | Cho gửi |
| D02 | Danh thiếp | >9 liên hệ | Chặn |
| D03 | Sticker | Connected | Chọn là gửi |
| D04 | Bất kỳ | Disconnected | Chặn gửi |

## 6. State Transition

Feature gửi nội dung không có vòng đời nghiệp vụ phức tạp; không áp dụng State Transition riêng.

## 7. Risk Analysis

| Risk ID | Risk | Impact | Priority | Coverage |
|---|---|---|---|---|
| R01 | Sai quyền hoặc sai phạm vi dữ liệu | High | Critical | Permission/Security |
| R02 | Sai trạng thái sau thao tác | High | Critical | State/Recovery |
| R03 | Lỗi tích hợp Zalo hoặc dependency | High | Critical | Integration/Exception |
| R04 | Dữ liệu không nhất quán giữa phiên/user | High | High | Sync/Concurrency |
| R05 | UI hiển thị không đúng điều kiện | Medium | High | UI/Regression |

## 8. Coverage Matrix

| Requirement | UC | BR / Rule | Testcase Range | Status |
|---|---|---|---|---|
| G023 | UC-01, UC-02 | BR01, BR01b, BR01c, BR02, BR03, BR04, BR05, BR06, BR07 | G023_TC001 → G023_TC035 | Covered |

## 9. Bảng test case

| Test Case ID | Purpose | Category | Trace BR | Precondition | Steps | Data | Expected Result | Round 1 | Round 2 | Round 3 | Error Code | Note | Date | Tester |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| **UC-01** | | | | | | | | | | | | | | |
| G023_TC001 | Mở picker danh thiếp từ toolbar | Positive | BR01 · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Mở picker danh thiếp từ toolbar; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Critical<br>Loại: Functional |  |  |
| G023_TC002 | Picker danh thiếp chỉ hiển thị bạn bè của đúng tài khoản Zalo đang chat | Positive | BR01/BR03 · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Picker danh thiếp chỉ hiển thị bạn bè của đúng tài khoản Zalo đang chat; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Critical<br>Loại: Functional |  |  |
| G023_TC003 | Picker danh thiếp không có mục Gần đây | Negative | BR01 · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Picker danh thiếp không có mục Gần đây; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: High<br>Loại: Negative |  |  |
| G023_TC004 | Tìm liên hệ theo tên chính xác | Positive | BR01 · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Tìm liên hệ theo tên chính xác; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: High<br>Loại: Functional |  |  |
| G023_TC005 | Tìm liên hệ theo một phần tên | Positive | BR01 · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Tìm liên hệ theo một phần tên; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Medium<br>Loại: Functional |  |  |
| G023_TC006 | Tìm liên hệ theo SĐT | Positive | BR01 · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Tìm liên hệ theo SĐT; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: High<br>Loại: Functional |  |  |
| G023_TC007 | Tìm không có kết quả hiển thị trạng thái phù hợp | Negative | BR01 · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Tìm không có kết quả hiển thị trạng thái phù hợp; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Medium<br>Loại: Negative |  |  |
| G023_TC008 | Danh bạ trống hiển thị 'Chưa có liên hệ' | Negative | E01 · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Danh bạ trống hiển thị 'Chưa có liên hệ'; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: High<br>Loại: Exception |  |  |
| G023_TC009 | Chưa chọn liên hệ thì không gửi được | Negative | BR01b · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Chưa chọn liên hệ thì không gửi được; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: High<br>Loại: Negative |  |  |
| G023_TC010 | Chọn 1 danh thiếp và gửi thành công | Positive | BR01b · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Chọn 1 danh thiếp và gửi thành công; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Critical<br>Loại: Functional |  |  |
| G023_TC011 | Chọn 9 danh thiếp và gửi thành công | Edge case | BR01b · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Chọn 9 danh thiếp và gửi thành công; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Critical<br>Loại: Boundary |  |  |
| G023_TC012 | Chọn liên hệ thứ 10 bị chặn | Edge case | E04 · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Chọn liên hệ thứ 10 bị chặn; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Critical<br>Loại: Boundary |  |  |
| G023_TC013 | Bộ đếm Đã chọn cập nhật đúng khi chọn/bỏ chọn | Positive | BR01b · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Bộ đếm Đã chọn cập nhật đúng khi chọn/bỏ chọn; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: High<br>Loại: Functional |  |  |
| G023_TC014 | Toggle gửi kèm SĐT bật áp dụng cho cả lô | Positive | BR01c · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Toggle gửi kèm SĐT bật áp dụng cho cả lô; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Critical<br>Loại: Functional |  |  |
| G023_TC015 | Toggle gửi kèm SĐT tắt chỉ gửi avatar + tên | Positive | BR01c · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Toggle gửi kèm SĐT tắt chỉ gửi avatar + tên; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Critical<br>Loại: Functional |  |  |
| G023_TC016 | Danh thiếp gửi ra hiển thị đúng theo G013 | Positive | BR05 · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Danh thiếp gửi ra hiển thị đúng theo G013; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Critical<br>Loại: Regression |  |  |
| G023_TC017 | Gửi danh thiếp qua đúng tài khoản Zalo của hội thoại | Positive | BR03 · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Gửi danh thiếp qua đúng tài khoản Zalo của hội thoại; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Critical<br>Loại: Functional |  |  |
| G023_TC018 | Staff có quyền nhắn tin gửi được danh thiếp | Security | BR04 · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Staff có quyền nhắn tin gửi được danh thiếp; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: High<br>Loại: Permission |  |  |
| G023_TC019 | Staff không có quyền nhắn tin không gửi được danh thiếp | Security | BR04 · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Staff không có quyền nhắn tin không gửi được danh thiếp; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Critical<br>Loại: Permission |  |  |
| G023_TC020 | DISCONNECTED khi mở picker danh thiếp bị chặn | Negative | BR07/E03 · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: DISCONNECTED khi mở picker danh thiếp bị chặn; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Critical<br>Loại: Exception |  |  |
| G023_TC021 | DISCONNECTED trong lúc gửi danh thiếp trả lỗi, không gửi trùng | Edge case | E02/E03 · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: DISCONNECTED trong lúc gửi danh thiếp trả lỗi, không gửi trùng; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Critical<br>Loại: Recovery |  |  |
| G023_TC022 | Double-click nút Gửi không tạo lô danh thiếp trùng | Edge case | Ngoài tài liệu (QA bổ sung) · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Double-click nút Gửi không tạo lô danh thiếp trùng; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: High<br>Loại: Concurrency |  |  |
| **UC-02** | | | | | | | | | | | | | | |
| G023_TC023 | Mở picker sticker từ toolbar | Positive | BR02 · UC-02 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Mở picker sticker từ toolbar; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Critical<br>Loại: Functional |  |  |
| G023_TC024 | Picker sticker có mục Gần đây | Positive | BR02 · UC-02 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Picker sticker có mục Gần đây; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: High<br>Loại: Functional |  |  |
| G023_TC025 | Picker sticker hiển thị bộ mặc định và bộ đã tải | Positive | BR02 · UC-02 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Picker sticker hiển thị bộ mặc định và bộ đã tải; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: High<br>Loại: Functional |  |  |
| G023_TC026 | Không có chức năng upload sticker tùy chỉnh | Negative | OOS01 · UC-02 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Không có chức năng upload sticker tùy chỉnh; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: High<br>Loại: Negative |  |  |
| G023_TC027 | Chọn sticker thì gửi ngay, không có bước confirm | Positive | BR06 · UC-02 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Chọn sticker thì gửi ngay, không có bước confirm; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Critical<br>Loại: Functional |  |  |
| G023_TC028 | Sticker vừa gửi xuất hiện trong Gần đây | Positive | BR02 · UC-02 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Sticker vừa gửi xuất hiện trong Gần đây; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Medium<br>Loại: Functional |  |  |
| G023_TC029 | Sticker gửi qua đúng tài khoản Zalo của hội thoại | Positive | BR03 · UC-02 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Sticker gửi qua đúng tài khoản Zalo của hội thoại; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Critical<br>Loại: Functional |  |  |
| G023_TC030 | DISCONNECTED không gửi được sticker | Negative | BR07/E03 · UC-02 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: DISCONNECTED không gửi được sticker; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Critical<br>Loại: Exception |  |  |
| G023_TC031 | Zalo API lỗi khi gửi sticker hiển thị toast lỗi | Negative | E02 · UC-02 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Zalo API lỗi khi gửi sticker hiển thị toast lỗi; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: High<br>Loại: Exception |  |  |
| G023_TC032 | Staff có quyền nhắn tin gửi được sticker | Security | BR04 · UC-02 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Staff có quyền nhắn tin gửi được sticker; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: High<br>Loại: Permission |  |  |
| G023_TC033 | Không có quyền nhắn tin không gửi được sticker | Security | BR04 · UC-02 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Không có quyền nhắn tin không gửi được sticker; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Critical<br>Loại: Permission |  |  |
| G023_TC034 | Không cho gửi nhiều sticker trong một thao tác | Negative | OOS04 · UC-02 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Không cho gửi nhiều sticker trong một thao tác; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Medium<br>Loại: Negative |  |  |
| **UC-01/02** | | | | | | | | | | | | | | |
| G023_TC035 | Chuyển hội thoại khác, picker dùng đúng danh bạ/sticker của tài khoản mới | Positive | BR03 · UC-01/02 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Chuyển hội thoại khác, picker dùng đúng danh bạ/sticker của tài khoản mới; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Critical<br>Loại: Regression |  |  |

## 11. Regression Scope

| Module / Feature | Reason | Regression Level |
|---|---|---|
| Chat core | Điểm vào/thao tác hội thoại | Full |
| Permission | Quyền xem/nhắn/role | Full |
| Zalo integration | Các action Zalo-native | Full |
| Related dependencies | Theo requirement | High |
| Multi-user/session | Isolation/sync | High |

## 12. Automation Candidate

| Group | Candidate | Note |
|---|---|---|
| Functional happy path | Yes | Expected rõ ràng |
| Permission/negative | Yes | Nên automate API/UI |
| Concurrency/sync | Partial | Cần orchestration nhiều phiên |
| UI/UX visual | No/Partial | Manual hoặc visual automation |
| Third-party Zalo | Partial | Cần môi trường tích hợp/mock |

## 13. Change History

| Version | Date | Description |
|---|---|---|
| 1.0 | 2026-08-22 | Tạo testcase riêng cho requirement G023 |
