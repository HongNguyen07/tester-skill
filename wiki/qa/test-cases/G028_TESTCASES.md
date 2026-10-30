# [G028] — Tắt / Bật thông báo hội thoại — TESTCASES

| Mục | Giá trị |
|---|---|
| Tên màn hình/Tên chức năng | G028 — Tắt / Bật thông báo hội thoại |
| Thiết bị, hệ điều hành | |
| Mã trường hợp kiểm thử | G028 |

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
> ⚠ **Chưa đạt rule ở 3 cột:** Precondition, Steps, Data của toàn bộ case trong file này là câu mẫu chung ("Chuẩn bị Preconditions… Thực hiện thao tác theo Test Case…"), Expected Result chỉ lặp lại tên case. Đã đưa về đúng cột của template nhưng **cần viết lại nội dung theo spec G028** thì case mới chạy được.

## 1. Requirement Information

| Item | Value |
|---|---|
| Feature ID | G028 |
| Feature Name | Tắt / Bật thông báo hội thoại |
| Source | G028 - Tắt Bật thông báo hội thoại.md |
| Total Test Cases | 35 |
| Documentation Standard | QA Specification v1.1 |

## 2. Requirement Analysis

- Requirement chính thức: mute per-user theo hội thoại, 4 lựa chọn thời hạn, auto-unmute, reset timer, unread vẫn tăng.
- Coverage QA bổ sung: boundary 07:59/08:00/08:01, nhiều tab/device cùng user, persistence sau logout/login, concurrent remute.
- Cần BA/Dev xác nhận: timezone chuẩn dùng để tính '8 giờ sáng lần kế tiếp'; đồng bộ trạng thái mute giữa web/mobile của cùng user.

## 3. Use Cases

UC-01, UC-02

## 4. Business Rules

BR01, BR02, BR03, BR04, BR05, BR06

## 5. Decision Table

| D | Trạng thái hiện tại | Lựa chọn | Expected |
|---|---|---|---|
| D01 | Bật | 1 giờ | Tắt hẹn giờ 1h |
| D02 | Bật | 4 giờ | Tắt hẹn giờ 4h |
| D03 | Bật | Đến 8h | Tắt tới 8h kế tiếp |
| D04 | Bật | Cho đến khi bật lại | Tắt vô thời hạn |
| D05 | Đang tắt | Chọn thời hạn khác | Reset timer |
| D06 | Đang tắt | Bật thông báo | Bật ngay, huỷ timer |

## 6. State Transition

| From | Event | To |
|---|---|---|
| Bật | Mute có thời hạn | Tắt hẹn giờ |
| Bật | Mute vô thời hạn | Tắt vô thời hạn |
| Tắt hẹn giờ | Hết hạn | Bật |
| Tắt hẹn giờ | Bật tay | Bật |
| Tắt vô thời hạn | Bật tay | Bật |

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
| G028 | UC-01, UC-02 | BR01, BR02, BR03, BR04, BR05, BR06 | G028_TC001 → G028_TC035 | Covered |

## 9. Bảng test case

| Test Case ID | Purpose | Category | Trace BR | Precondition | Steps | Data | Expected Result | Round 1 | Round 2 | Round 3 | Error Code | Note | Date | Tester |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| **UC-01** | | | | | | | | | | | | | | |
| G028_TC001 | Mở menu mute từ icon chuông panel phải | Positive | BR01 · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Mở menu mute từ icon chuông panel phải; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: High<br>Loại: Functional |  |  |
| G028_TC002 | Mở menu mute từ option menu hội thoại | Positive | BR01 · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Mở menu mute từ option menu hội thoại; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: High<br>Loại: Functional |  |  |
| G028_TC003 | Menu hiển thị đủ 1h/4h/đến 8h/cho đến khi bật lại | UI | BR01 · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Menu hiển thị đủ 1h/4h/đến 8h/cho đến khi bật lại; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: High<br>Loại: UI/UX |  |  |
| G028_TC004 | Mặc định hội thoại ở trạng thái bật thông báo | Positive | State · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Mặc định hội thoại ở trạng thái bật thông báo; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: High<br>Loại: State Transition |  |  |
| G028_TC005 | Mute 1 giờ chặn notification cho đúng user | Positive | BR01/BR05 · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Mute 1 giờ chặn notification cho đúng user; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Critical<br>Loại: Functional |  |  |
| G028_TC006 | Mute 4 giờ chặn notification cho đúng user | Positive | BR01/BR05 · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Mute 4 giờ chặn notification cho đúng user; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Critical<br>Loại: Functional |  |  |
| G028_TC007 | Mute vô thời hạn duy trì đến khi bật tay | Positive | BR01 · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Mute vô thời hạn duy trì đến khi bật tay; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Critical<br>Loại: Functional |  |  |
| G028_TC008 | Mute trước 08:00 đến 8h sáng hết hạn cùng ngày | Edge case | BR01 · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Mute trước 08:00 đến 8h sáng hết hạn cùng ngày; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Critical<br>Loại: Boundary |  |  |
| G028_TC009 | Mute đúng 08:00 đến 8h sáng hết hạn hôm sau | Edge case | BR01 · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Mute đúng 08:00 đến 8h sáng hết hạn hôm sau; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Critical<br>Loại: Boundary |  |  |
| G028_TC010 | Mute sau 08:00 đến 8h sáng hết hạn hôm sau | Edge case | BR01 · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Mute sau 08:00 đến 8h sáng hết hạn hôm sau; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Critical<br>Loại: Boundary |  |  |
| G028_TC011 | Hết 1 giờ tự bật lại | Positive | BR02 · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Hết 1 giờ tự bật lại; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Critical<br>Loại: State Transition |  |  |
| G028_TC012 | Hết 4 giờ tự bật lại | Positive | BR02 · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Hết 4 giờ tự bật lại; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Critical<br>Loại: State Transition |  |  |
| G028_TC013 | Hết mốc 8h sáng tự bật lại | Positive | BR02 · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Hết mốc 8h sáng tự bật lại; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Critical<br>Loại: State Transition |  |  |
| G028_TC014 | Icon chuông đổi sang trạng thái tắt sau mute | UI | BR02 · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Icon chuông đổi sang trạng thái tắt sau mute; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: High<br>Loại: UI/UX |  |  |
| G028_TC015 | Icon chuông trở lại bật sau auto-unmute | UI | BR02 · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Icon chuông trở lại bật sau auto-unmute; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: High<br>Loại: UI/UX |  |  |
| **UC-02** | | | | | | | | | | | | | | |
| G028_TC016 | Bật lại thủ công khi đang mute hẹn giờ | Positive | BR03 · UC-02 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Bật lại thủ công khi đang mute hẹn giờ; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Critical<br>Loại: Functional |  |  |
| G028_TC017 | Bật lại thủ công huỷ timer cũ | Positive | BR03 · UC-02 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Bật lại thủ công huỷ timer cũ; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Critical<br>Loại: State Transition |  |  |
| G028_TC018 | Bật lại thủ công với mute vô thời hạn | Positive | BR03 · UC-02 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Bật lại thủ công với mute vô thời hạn; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Critical<br>Loại: Functional |  |  |
| **UC-01** | | | | | | | | | | | | | | |
| G028_TC019 | Đang mute 8h sáng đổi sang 1h reset timer | Positive | BR04 · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Đang mute 8h sáng đổi sang 1h reset timer; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Critical<br>Loại: State Transition |  |  |
| G028_TC020 | Đang mute 1h đổi sang 4h không cộng dồn | Positive | BR04 · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Đang mute 1h đổi sang 4h không cộng dồn; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Critical<br>Loại: State Transition |  |  |
| G028_TC021 | Đang mute hẹn giờ đổi sang vô thời hạn | Positive | BR04 · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Đang mute hẹn giờ đổi sang vô thời hạn; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: High<br>Loại: State Transition |  |  |
| G028_TC022 | Trong thời gian mute hội thoại vẫn nhận tin | Positive | BR05 · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Trong thời gian mute hội thoại vẫn nhận tin; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Critical<br>Loại: Functional |  |  |
| G028_TC023 | Trong thời gian mute unread vẫn tăng | Positive | BR05 · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Trong thời gian mute unread vẫn tăng; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Critical<br>Loại: Functional |  |  |
| G028_TC024 | Trong thời gian mute không có toast web | Positive | BR05/G027 · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Trong thời gian mute không có toast web; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Critical<br>Loại: Integration |  |  |
| G028_TC025 | Trong thời gian mute không có browser notification | Positive | BR05/G027 · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Trong thời gian mute không có browser notification; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Critical<br>Loại: Integration |  |  |
| G028_TC026 | Trong thời gian mute không có mobile push | Positive | BR05/G027 · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Trong thời gian mute không có mobile push; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Critical<br>Loại: Integration |  |  |
| G028_TC027 | User A mute không ảnh hưởng user B cùng tài khoản Zalo | Security | BR06 · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: User A mute không ảnh hưởng user B cùng tài khoản Zalo; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Critical<br>Loại: Data Isolation |  |  |
| G028_TC028 | User B vẫn nhận notification khi A mute | Positive | BR06/G027 · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: User B vẫn nhận notification khi A mute; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Critical<br>Loại: Integration |  |  |
| G028_TC029 | Mute của user A trên hội thoại X không ảnh hưởng hội thoại Y | Security | BR06 · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Mute của user A trên hội thoại X không ảnh hưởng hội thoại Y; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Critical<br>Loại: Data Isolation |  |  |
| G028_TC030 | Mute trạng thái được giữ sau reload | Positive | BR06 · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Mute trạng thái được giữ sau reload; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: High<br>Loại: Regression |  |  |
| G028_TC031 | Mute trạng thái được giữ sau logout/login nếu chưa hết hạn | Positive | BR06 · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Mute trạng thái được giữ sau logout/login nếu chưa hết hạn; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: High<br>Loại: Regression |  |  |
| G028_TC032 | Thao tác mute thất bại giữ nguyên trạng thái trước đó | Edge case | E01 · UC-01 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Thao tác mute thất bại giữ nguyên trạng thái trước đó; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Critical<br>Loại: Recovery |  |  |
| **UC-02** | | | | | | | | | | | | | | |
| G028_TC033 | Thao tác unmute thất bại giữ nguyên trạng thái mute | Edge case | E01 · UC-02 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Thao tác unmute thất bại giữ nguyên trạng thái mute; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: Critical<br>Loại: Recovery |  |  |
| **UC-01/02** | | | | | | | | | | | | | | |
| G028_TC034 | Mất quyền hội thoại thì không còn thao tác mute được | Security | Precondition · UC-01/02 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Mất quyền hội thoại thì không còn thao tác mute được; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: High<br>Loại: Permission |  |  |
| G028_TC035 | Trạng thái mute của cùng user nhất quán giữa các tab | Positive | Ngoài tài liệu (QA bổ sung) · UC-01/02 | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. | Hệ thống xử lý đúng: Trạng thái mute của cùng user nhất quán giữa các tab; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. | Todo | Todo | Todo |  | Ưu tiên: High<br>Loại: Sync |  |  |

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
| 1.0 | 2026-08-22 | Tạo testcase riêng cho requirement G028 |
