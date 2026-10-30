# [G024] — Thao tác hội thoại: Ẩn trò chuyện · Xoá lịch sử · Báo xấu — TESTCASES

## 1. Requirement Information

| Item | Value |
|---|---|
| Feature ID | G024 |
| Feature Name | Thao tác hội thoại: Ẩn trò chuyện · Xoá lịch sử · Báo xấu |
| Source | G024 - Thao tác hội thoại (Ẩn, Xoá lịch sử, Báo xấu).md |
| Total Test Cases | 50 |
| Documentation Standard | QA Specification v1.1 |

## 2. Requirement Analysis

- Requirement chính thức: Ẩn và Xoá lịch sử là nội bộ Gopany theo từng user; Báo xấu là Zalo-native.
- Coverage QA bổ sung: data isolation per-user, mốc xoá ở mọi điểm hiển thị, search/undo/new message reappear, API authorization, audit log.
- Cần BA/Dev xác nhận: BR06 chống spam 1 lần/24h vẫn là đề xuất, không coi là acceptance chính thức cho tới khi chốt.

## 3. Use Cases

UC-01, UC-02, UC-03

## 4. Business Rules

BR01, BR02, BR03, BR04, BR05, BR06, BR07, BR08, BR09, BR10

## 5. Decision Table

| D | Action | Scope | Zalo | Expected |
|---|---|---|---|---|
| D01 | Ẩn | Per-user | Không gọi | Ẩn view |
| D02 | Xoá lịch sử | Per-user | Không gọi | Lưu mốc xoá |
| D03 | Báo xấu | Account-level | Có gọi | Gửi Zalo |
| D04 | Báo xấu + Disconnected | — | Không khả dụng | Chặn |

## 6. State Transition

| From | Event | To |
|---|---|---|
| Hiện | Ẩn | Ẩn |
| Ẩn | Tin mới/Undo/Search open | Hiện |
| Mốc xoá T1 | Xoá lại T2 | Mốc xoá T2 |
| Report form | Gửi hợp lệ | Đã gửi |

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
| G024 | UC-01, UC-02, UC-03 | BR01, BR02, BR03, BR04, BR05, BR06, BR07, BR08, BR09, BR10 | G024_TC001 → G024_TC050 | Covered |

## 9. Testcase Summary

| ID | Test Case | Category | Priority | Use Case | Business Rule | Status |
|---|---|---|---|---|---|---|
| G024_TC001 | Mở option menu bằng icon ba chấm khi hover | UI/UX | High | UC-01/02/03 | BR04 | Not Run |
| G024_TC002 | Mở option menu bằng chuột phải | UI/UX | Medium | UC-01/02/03 | BR04 | Not Run |
| G024_TC003 | Ẩn trò chuyện chỉ ẩn với user thao tác | Functional | Critical | UC-01 | BR01 | Not Run |
| G024_TC004 | Ẩn trò chuyện không ảnh hưởng nhân sự khác | Data Isolation | Critical | UC-01 | BR01 | Not Run |
| G024_TC005 | Ẩn trò chuyện không gọi Zalo | Regression | Critical | UC-01 | BR01 | Not Run |
| G024_TC006 | Ẩn hội thoại đang mở làm đóng khung chat | Functional | High | UC-01 | BR01 | Not Run |
| G024_TC007 | Ẩn hiển thị toast và nút Hoàn tác | UI/UX | High | UC-01 | AF03 | Not Run |
| G024_TC008 | Hoàn tác trong thời gian toast hiện lại hội thoại | Recovery | High | UC-01 | AF03 | Not Run |
| G024_TC009 | Tin khách gửi mới làm hội thoại tự hiện lại | State Transition | Critical | UC-01 | BR01 | Not Run |
| G024_TC010 | Tin do nhân sự khác gửi làm hội thoại tự hiện lại | State Transition | Critical | UC-01 | BR01 | Not Run |
| G024_TC011 | Mở hội thoại ẩn từ tìm kiếm tự bỏ ẩn | Functional | High | UC-01 | AF04 | Not Run |
| G024_TC012 | Khi đang ẩn không phát notification cho user đó | Functional | Critical | UC-01 | BR08 | Not Run |
| G024_TC013 | Khi đang ẩn không tăng badge unread cho user đó | Functional | Critical | UC-01 | BR08 | Not Run |
| G024_TC014 | Ẩn không thay đổi ghim, thẻ, phân công | Regression | High | UC-01 | BR08 | Not Run |
| G024_TC015 | Xoá lịch sử hiển thị cho mọi user có quyền xem | Permission | Critical | UC-02 | BR02 | Not Run |
| G024_TC016 | Xoá lịch sử có popup xác nhận đúng nội dung | UI/UX | High | UC-02 | BR02 | Not Run |
| G024_TC017 | Huỷ xoá lịch sử không thay đổi dữ liệu | Functional | High | UC-02 | AF01 | Not Run |
| G024_TC018 | Xác nhận xoá lưu mốc theo user × conversation | Functional | Critical | UC-02 | BR02 | Not Run |
| G024_TC019 | Tin có thời điểm <= mốc xoá không còn hiển thị trong khung chat | Functional | Critical | UC-02 | BR07 | Not Run |
| G024_TC020 | Tin > mốc xoá vẫn hiển thị bình thường | Boundary | Critical | UC-02 | BR02 | Not Run |
| G024_TC021 | Sau xoá preview panel trái trống và badge về 0 | Functional | High | UC-02 | BR07 | Not Run |
| G024_TC022 | Xoá lịch sử không ảnh hưởng nhân sự khác | Data Isolation | Critical | UC-02 | BR02 | Not Run |
| G024_TC023 | Xoá lịch sử không gọi Zalo và Zalo vẫn còn lịch sử | Regression | Critical | UC-02 | BR02 | Not Run |
| G024_TC024 | Tin cũ không xuất hiện trong tìm kiếm trong hội thoại | Regression | Critical | UC-02 | BR07 | Not Run |
| G024_TC025 | Tin cũ không xuất hiện trong tìm kiếm hợp nhất G017 | Regression | Critical | UC-02 | BR07 | Not Run |
| G024_TC026 | Tin ghim cũ <= mốc xoá không hiển thị với user đó | Regression | Critical | UC-02 | BR07 | Not Run |
| G024_TC027 | Media/link cũ <= mốc xoá không hiển thị ở panel G011 | Regression | Critical | UC-02 | BR07 | Not Run |
| G024_TC028 | Nhắc hẹn/thẻ/phân công không bị ảnh hưởng bởi xoá lịch sử | Regression | High | UC-02 | BR07 | Not Run |
| G024_TC029 | Xoá lịch sử lần 2 ghi đè mốc cũ | State Transition | High | UC-02 | BR02 | Not Run |
| G024_TC030 | Dữ liệu vẫn tồn tại ngầm phục vụ audit | Security | Critical | UC-02 | BR02 | Not Run |
| G024_TC031 | Ẩn và Xoá lịch sử vẫn dùng được khi Zalo DISCONNECTED | Functional | Critical | UC-01/02 | BR05 | Not Run |
| G024_TC032 | Báo xấu chỉ hiển thị cho user có quyền nhắn tin | Permission | Critical | UC-03 | BR03 | Not Run |
| G024_TC033 | Mở popup Báo xấu hiển thị đúng bộ lý do | Functional | High | UC-03 | BR03 | Not Run |
| G024_TC034 | Chưa chọn lý do thì nút Gửi disabled | Negative | Critical | UC-03 | E04 | Not Run |
| G024_TC035 | Chọn Khác hiển thị ô mô tả bắt buộc | Functional | High | UC-03 | BR03 | Not Run |
| G024_TC036 | Chọn Khác nhưng bỏ trống mô tả không gửi được | Negative | Critical | UC-03 | E04 | Not Run |
| G024_TC037 | Huỷ popup Báo xấu không gửi và không ghi log | Functional | High | UC-03 | AF02 | Not Run |
| G024_TC038 | Gửi báo xấu hợp lệ lên đúng Zalo | Functional | Critical | UC-03 | BR03 | Not Run |
| G024_TC039 | Báo xấu lưu audit log đầy đủ lý do/mô tả | Security | Critical | UC-03 | BR10 | Not Run |
| G024_TC040 | Zalo API lỗi giữ nguyên dữ liệu popup | Recovery | Critical | UC-03 | E02 | Not Run |
| G024_TC041 | DISCONNECTED chặn Báo xấu | Exception | Critical | UC-03 | BR05/E03 | Not Run |
| G024_TC042 | Mất quyền trong lúc thao tác hiển thị E06 và refresh danh sách | Permission | Critical | UC-01/02/03 | E06 | Not Run |
| G024_TC043 | Hội thoại không tồn tại hiển thị E06 | Exception | High | UC-01/02/03 | E06 | Not Run |
| G024_TC044 | Cả 3 thao tác hoạt động với hội thoại 1:1 | Regression | High | UC-01/02/03 | BR09 | Not Run |
| G024_TC045 | Cả 3 thao tác hoạt động với hội thoại nhóm | Regression | High | UC-01/02/03 | BR09 | Not Run |
| G024_TC046 | Audit log ghi hành động Ẩn | Security | High | UC-01 | BR10 | Not Run |
| G024_TC047 | Audit log ghi hành động Xoá lịch sử | Security | High | UC-02 | BR10 | Not Run |
| G024_TC048 | Không thể dùng API Ẩn/Xoá để ảnh hưởng user khác | Security | Critical | UC-01/02 | BR01/BR02 | Not Run |
| G024_TC049 | BR06 chống spam 24h - nếu được chốt - chặn lần báo thứ hai | Conditional | Medium | UC-03 | BR06 | Not Run |
| G024_TC050 | BR06 chống spam tính toàn workspace - nếu được chốt | Conditional | Medium | UC-03 | BR06 | Not Run |

## 10. Testcase Detail

### G024_TC001

| Field | Value |
|---|---|
| Test Case | Mở option menu bằng icon ba chấm khi hover |
| ID | G024_TC001 |
| Purpose | Xác minh mở option menu bằng icon ba chấm khi hover |
| Category | UI/UX |
| Priority | High |
| Requirement | G024 |
| Use Case | UC-01/02/03 |
| Business Rule | BR04 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Mở option menu bằng icon ba chấm khi hover; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC002

| Field | Value |
|---|---|
| Test Case | Mở option menu bằng chuột phải |
| ID | G024_TC002 |
| Purpose | Xác minh mở option menu bằng chuột phải |
| Category | UI/UX |
| Priority | Medium |
| Requirement | G024 |
| Use Case | UC-01/02/03 |
| Business Rule | BR04 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Mở option menu bằng chuột phải; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC003

| Field | Value |
|---|---|
| Test Case | Ẩn trò chuyện chỉ ẩn với user thao tác |
| ID | G024_TC003 |
| Purpose | Xác minh ẩn trò chuyện chỉ ẩn với user thao tác |
| Category | Functional |
| Priority | Critical |
| Requirement | G024 |
| Use Case | UC-01 |
| Business Rule | BR01 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Ẩn trò chuyện chỉ ẩn với user thao tác; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC004

| Field | Value |
|---|---|
| Test Case | Ẩn trò chuyện không ảnh hưởng nhân sự khác |
| ID | G024_TC004 |
| Purpose | Xác minh ẩn trò chuyện không ảnh hưởng nhân sự khác |
| Category | Data Isolation |
| Priority | Critical |
| Requirement | G024 |
| Use Case | UC-01 |
| Business Rule | BR01 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Ẩn trò chuyện không ảnh hưởng nhân sự khác; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC005

| Field | Value |
|---|---|
| Test Case | Ẩn trò chuyện không gọi Zalo |
| ID | G024_TC005 |
| Purpose | Xác minh ẩn trò chuyện không gọi zalo |
| Category | Regression |
| Priority | Critical |
| Requirement | G024 |
| Use Case | UC-01 |
| Business Rule | BR01 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Ẩn trò chuyện không gọi Zalo; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC006

| Field | Value |
|---|---|
| Test Case | Ẩn hội thoại đang mở làm đóng khung chat |
| ID | G024_TC006 |
| Purpose | Xác minh ẩn hội thoại đang mở làm đóng khung chat |
| Category | Functional |
| Priority | High |
| Requirement | G024 |
| Use Case | UC-01 |
| Business Rule | BR01 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Ẩn hội thoại đang mở làm đóng khung chat; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC007

| Field | Value |
|---|---|
| Test Case | Ẩn hiển thị toast và nút Hoàn tác |
| ID | G024_TC007 |
| Purpose | Xác minh ẩn hiển thị toast và nút hoàn tác |
| Category | UI/UX |
| Priority | High |
| Requirement | G024 |
| Use Case | UC-01 |
| Business Rule | AF03 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Ẩn hiển thị toast và nút Hoàn tác; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC008

| Field | Value |
|---|---|
| Test Case | Hoàn tác trong thời gian toast hiện lại hội thoại |
| ID | G024_TC008 |
| Purpose | Xác minh hoàn tác trong thời gian toast hiện lại hội thoại |
| Category | Recovery |
| Priority | High |
| Requirement | G024 |
| Use Case | UC-01 |
| Business Rule | AF03 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Hoàn tác trong thời gian toast hiện lại hội thoại; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC009

| Field | Value |
|---|---|
| Test Case | Tin khách gửi mới làm hội thoại tự hiện lại |
| ID | G024_TC009 |
| Purpose | Xác minh tin khách gửi mới làm hội thoại tự hiện lại |
| Category | State Transition |
| Priority | Critical |
| Requirement | G024 |
| Use Case | UC-01 |
| Business Rule | BR01 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Tin khách gửi mới làm hội thoại tự hiện lại; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC010

| Field | Value |
|---|---|
| Test Case | Tin do nhân sự khác gửi làm hội thoại tự hiện lại |
| ID | G024_TC010 |
| Purpose | Xác minh tin do nhân sự khác gửi làm hội thoại tự hiện lại |
| Category | State Transition |
| Priority | Critical |
| Requirement | G024 |
| Use Case | UC-01 |
| Business Rule | BR01 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Tin do nhân sự khác gửi làm hội thoại tự hiện lại; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC011

| Field | Value |
|---|---|
| Test Case | Mở hội thoại ẩn từ tìm kiếm tự bỏ ẩn |
| ID | G024_TC011 |
| Purpose | Xác minh mở hội thoại ẩn từ tìm kiếm tự bỏ ẩn |
| Category | Functional |
| Priority | High |
| Requirement | G024 |
| Use Case | UC-01 |
| Business Rule | AF04 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Mở hội thoại ẩn từ tìm kiếm tự bỏ ẩn; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC012

| Field | Value |
|---|---|
| Test Case | Khi đang ẩn không phát notification cho user đó |
| ID | G024_TC012 |
| Purpose | Xác minh khi đang ẩn không phát notification cho user đó |
| Category | Functional |
| Priority | Critical |
| Requirement | G024 |
| Use Case | UC-01 |
| Business Rule | BR08 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Khi đang ẩn không phát notification cho user đó; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC013

| Field | Value |
|---|---|
| Test Case | Khi đang ẩn không tăng badge unread cho user đó |
| ID | G024_TC013 |
| Purpose | Xác minh khi đang ẩn không tăng badge unread cho user đó |
| Category | Functional |
| Priority | Critical |
| Requirement | G024 |
| Use Case | UC-01 |
| Business Rule | BR08 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Khi đang ẩn không tăng badge unread cho user đó; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC014

| Field | Value |
|---|---|
| Test Case | Ẩn không thay đổi ghim, thẻ, phân công |
| ID | G024_TC014 |
| Purpose | Xác minh ẩn không thay đổi ghim, thẻ, phân công |
| Category | Regression |
| Priority | High |
| Requirement | G024 |
| Use Case | UC-01 |
| Business Rule | BR08 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Ẩn không thay đổi ghim, thẻ, phân công; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC015

| Field | Value |
|---|---|
| Test Case | Xoá lịch sử hiển thị cho mọi user có quyền xem |
| ID | G024_TC015 |
| Purpose | Xác minh xoá lịch sử hiển thị cho mọi user có quyền xem |
| Category | Permission |
| Priority | Critical |
| Requirement | G024 |
| Use Case | UC-02 |
| Business Rule | BR02 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Xoá lịch sử hiển thị cho mọi user có quyền xem; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC016

| Field | Value |
|---|---|
| Test Case | Xoá lịch sử có popup xác nhận đúng nội dung |
| ID | G024_TC016 |
| Purpose | Xác minh xoá lịch sử có popup xác nhận đúng nội dung |
| Category | UI/UX |
| Priority | High |
| Requirement | G024 |
| Use Case | UC-02 |
| Business Rule | BR02 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Xoá lịch sử có popup xác nhận đúng nội dung; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC017

| Field | Value |
|---|---|
| Test Case | Huỷ xoá lịch sử không thay đổi dữ liệu |
| ID | G024_TC017 |
| Purpose | Xác minh huỷ xoá lịch sử không thay đổi dữ liệu |
| Category | Functional |
| Priority | High |
| Requirement | G024 |
| Use Case | UC-02 |
| Business Rule | AF01 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Huỷ xoá lịch sử không thay đổi dữ liệu; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC018

| Field | Value |
|---|---|
| Test Case | Xác nhận xoá lưu mốc theo user × conversation |
| ID | G024_TC018 |
| Purpose | Xác minh xác nhận xoá lưu mốc theo user × conversation |
| Category | Functional |
| Priority | Critical |
| Requirement | G024 |
| Use Case | UC-02 |
| Business Rule | BR02 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Xác nhận xoá lưu mốc theo user × conversation; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC019

| Field | Value |
|---|---|
| Test Case | Tin có thời điểm <= mốc xoá không còn hiển thị trong khung chat |
| ID | G024_TC019 |
| Purpose | Xác minh tin có thời điểm <= mốc xoá không còn hiển thị trong khung chat |
| Category | Functional |
| Priority | Critical |
| Requirement | G024 |
| Use Case | UC-02 |
| Business Rule | BR07 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Tin có thời điểm <= mốc xoá không còn hiển thị trong khung chat; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC020

| Field | Value |
|---|---|
| Test Case | Tin > mốc xoá vẫn hiển thị bình thường |
| ID | G024_TC020 |
| Purpose | Xác minh tin > mốc xoá vẫn hiển thị bình thường |
| Category | Boundary |
| Priority | Critical |
| Requirement | G024 |
| Use Case | UC-02 |
| Business Rule | BR02 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Tin > mốc xoá vẫn hiển thị bình thường; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC021

| Field | Value |
|---|---|
| Test Case | Sau xoá preview panel trái trống và badge về 0 |
| ID | G024_TC021 |
| Purpose | Xác minh sau xoá preview panel trái trống và badge về 0 |
| Category | Functional |
| Priority | High |
| Requirement | G024 |
| Use Case | UC-02 |
| Business Rule | BR07 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Sau xoá preview panel trái trống và badge về 0; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC022

| Field | Value |
|---|---|
| Test Case | Xoá lịch sử không ảnh hưởng nhân sự khác |
| ID | G024_TC022 |
| Purpose | Xác minh xoá lịch sử không ảnh hưởng nhân sự khác |
| Category | Data Isolation |
| Priority | Critical |
| Requirement | G024 |
| Use Case | UC-02 |
| Business Rule | BR02 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Xoá lịch sử không ảnh hưởng nhân sự khác; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC023

| Field | Value |
|---|---|
| Test Case | Xoá lịch sử không gọi Zalo và Zalo vẫn còn lịch sử |
| ID | G024_TC023 |
| Purpose | Xác minh xoá lịch sử không gọi zalo và zalo vẫn còn lịch sử |
| Category | Regression |
| Priority | Critical |
| Requirement | G024 |
| Use Case | UC-02 |
| Business Rule | BR02 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Xoá lịch sử không gọi Zalo và Zalo vẫn còn lịch sử; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC024

| Field | Value |
|---|---|
| Test Case | Tin cũ không xuất hiện trong tìm kiếm trong hội thoại |
| ID | G024_TC024 |
| Purpose | Xác minh tin cũ không xuất hiện trong tìm kiếm trong hội thoại |
| Category | Regression |
| Priority | Critical |
| Requirement | G024 |
| Use Case | UC-02 |
| Business Rule | BR07 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Tin cũ không xuất hiện trong tìm kiếm trong hội thoại; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC025

| Field | Value |
|---|---|
| Test Case | Tin cũ không xuất hiện trong tìm kiếm hợp nhất G017 |
| ID | G024_TC025 |
| Purpose | Xác minh tin cũ không xuất hiện trong tìm kiếm hợp nhất g017 |
| Category | Regression |
| Priority | Critical |
| Requirement | G024 |
| Use Case | UC-02 |
| Business Rule | BR07 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Tin cũ không xuất hiện trong tìm kiếm hợp nhất G017; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC026

| Field | Value |
|---|---|
| Test Case | Tin ghim cũ <= mốc xoá không hiển thị với user đó |
| ID | G024_TC026 |
| Purpose | Xác minh tin ghim cũ <= mốc xoá không hiển thị với user đó |
| Category | Regression |
| Priority | Critical |
| Requirement | G024 |
| Use Case | UC-02 |
| Business Rule | BR07 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Tin ghim cũ <= mốc xoá không hiển thị với user đó; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC027

| Field | Value |
|---|---|
| Test Case | Media/link cũ <= mốc xoá không hiển thị ở panel G011 |
| ID | G024_TC027 |
| Purpose | Xác minh media/link cũ <= mốc xoá không hiển thị ở panel g011 |
| Category | Regression |
| Priority | Critical |
| Requirement | G024 |
| Use Case | UC-02 |
| Business Rule | BR07 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Media/link cũ <= mốc xoá không hiển thị ở panel G011; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC028

| Field | Value |
|---|---|
| Test Case | Nhắc hẹn/thẻ/phân công không bị ảnh hưởng bởi xoá lịch sử |
| ID | G024_TC028 |
| Purpose | Xác minh nhắc hẹn/thẻ/phân công không bị ảnh hưởng bởi xoá lịch sử |
| Category | Regression |
| Priority | High |
| Requirement | G024 |
| Use Case | UC-02 |
| Business Rule | BR07 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Nhắc hẹn/thẻ/phân công không bị ảnh hưởng bởi xoá lịch sử; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC029

| Field | Value |
|---|---|
| Test Case | Xoá lịch sử lần 2 ghi đè mốc cũ |
| ID | G024_TC029 |
| Purpose | Xác minh xoá lịch sử lần 2 ghi đè mốc cũ |
| Category | State Transition |
| Priority | High |
| Requirement | G024 |
| Use Case | UC-02 |
| Business Rule | BR02 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Xoá lịch sử lần 2 ghi đè mốc cũ; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC030

| Field | Value |
|---|---|
| Test Case | Dữ liệu vẫn tồn tại ngầm phục vụ audit |
| ID | G024_TC030 |
| Purpose | Xác minh dữ liệu vẫn tồn tại ngầm phục vụ audit |
| Category | Security |
| Priority | Critical |
| Requirement | G024 |
| Use Case | UC-02 |
| Business Rule | BR02 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Dữ liệu vẫn tồn tại ngầm phục vụ audit; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC031

| Field | Value |
|---|---|
| Test Case | Ẩn và Xoá lịch sử vẫn dùng được khi Zalo DISCONNECTED |
| ID | G024_TC031 |
| Purpose | Xác minh ẩn và xoá lịch sử vẫn dùng được khi zalo disconnected |
| Category | Functional |
| Priority | Critical |
| Requirement | G024 |
| Use Case | UC-01/02 |
| Business Rule | BR05 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Ẩn và Xoá lịch sử vẫn dùng được khi Zalo DISCONNECTED; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC032

| Field | Value |
|---|---|
| Test Case | Báo xấu chỉ hiển thị cho user có quyền nhắn tin |
| ID | G024_TC032 |
| Purpose | Xác minh báo xấu chỉ hiển thị cho user có quyền nhắn tin |
| Category | Permission |
| Priority | Critical |
| Requirement | G024 |
| Use Case | UC-03 |
| Business Rule | BR03 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Báo xấu chỉ hiển thị cho user có quyền nhắn tin; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC033

| Field | Value |
|---|---|
| Test Case | Mở popup Báo xấu hiển thị đúng bộ lý do |
| ID | G024_TC033 |
| Purpose | Xác minh mở popup báo xấu hiển thị đúng bộ lý do |
| Category | Functional |
| Priority | High |
| Requirement | G024 |
| Use Case | UC-03 |
| Business Rule | BR03 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Mở popup Báo xấu hiển thị đúng bộ lý do; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC034

| Field | Value |
|---|---|
| Test Case | Chưa chọn lý do thì nút Gửi disabled |
| ID | G024_TC034 |
| Purpose | Xác minh chưa chọn lý do thì nút gửi disabled |
| Category | Negative |
| Priority | Critical |
| Requirement | G024 |
| Use Case | UC-03 |
| Business Rule | E04 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Chưa chọn lý do thì nút Gửi disabled; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC035

| Field | Value |
|---|---|
| Test Case | Chọn Khác hiển thị ô mô tả bắt buộc |
| ID | G024_TC035 |
| Purpose | Xác minh chọn khác hiển thị ô mô tả bắt buộc |
| Category | Functional |
| Priority | High |
| Requirement | G024 |
| Use Case | UC-03 |
| Business Rule | BR03 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Chọn Khác hiển thị ô mô tả bắt buộc; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC036

| Field | Value |
|---|---|
| Test Case | Chọn Khác nhưng bỏ trống mô tả không gửi được |
| ID | G024_TC036 |
| Purpose | Xác minh chọn khác nhưng bỏ trống mô tả không gửi được |
| Category | Negative |
| Priority | Critical |
| Requirement | G024 |
| Use Case | UC-03 |
| Business Rule | E04 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Chọn Khác nhưng bỏ trống mô tả không gửi được; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC037

| Field | Value |
|---|---|
| Test Case | Huỷ popup Báo xấu không gửi và không ghi log |
| ID | G024_TC037 |
| Purpose | Xác minh huỷ popup báo xấu không gửi và không ghi log |
| Category | Functional |
| Priority | High |
| Requirement | G024 |
| Use Case | UC-03 |
| Business Rule | AF02 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Huỷ popup Báo xấu không gửi và không ghi log; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC038

| Field | Value |
|---|---|
| Test Case | Gửi báo xấu hợp lệ lên đúng Zalo |
| ID | G024_TC038 |
| Purpose | Xác minh gửi báo xấu hợp lệ lên đúng zalo |
| Category | Functional |
| Priority | Critical |
| Requirement | G024 |
| Use Case | UC-03 |
| Business Rule | BR03 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Gửi báo xấu hợp lệ lên đúng Zalo; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC039

| Field | Value |
|---|---|
| Test Case | Báo xấu lưu audit log đầy đủ lý do/mô tả |
| ID | G024_TC039 |
| Purpose | Xác minh báo xấu lưu audit log đầy đủ lý do/mô tả |
| Category | Security |
| Priority | Critical |
| Requirement | G024 |
| Use Case | UC-03 |
| Business Rule | BR10 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Báo xấu lưu audit log đầy đủ lý do/mô tả; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC040

| Field | Value |
|---|---|
| Test Case | Zalo API lỗi giữ nguyên dữ liệu popup |
| ID | G024_TC040 |
| Purpose | Xác minh zalo api lỗi giữ nguyên dữ liệu popup |
| Category | Recovery |
| Priority | Critical |
| Requirement | G024 |
| Use Case | UC-03 |
| Business Rule | E02 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Zalo API lỗi giữ nguyên dữ liệu popup; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC041

| Field | Value |
|---|---|
| Test Case | DISCONNECTED chặn Báo xấu |
| ID | G024_TC041 |
| Purpose | Xác minh disconnected chặn báo xấu |
| Category | Exception |
| Priority | Critical |
| Requirement | G024 |
| Use Case | UC-03 |
| Business Rule | BR05/E03 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: DISCONNECTED chặn Báo xấu; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC042

| Field | Value |
|---|---|
| Test Case | Mất quyền trong lúc thao tác hiển thị E06 và refresh danh sách |
| ID | G024_TC042 |
| Purpose | Xác minh mất quyền trong lúc thao tác hiển thị e06 và refresh danh sách |
| Category | Permission |
| Priority | Critical |
| Requirement | G024 |
| Use Case | UC-01/02/03 |
| Business Rule | E06 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Mất quyền trong lúc thao tác hiển thị E06 và refresh danh sách; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC043

| Field | Value |
|---|---|
| Test Case | Hội thoại không tồn tại hiển thị E06 |
| ID | G024_TC043 |
| Purpose | Xác minh hội thoại không tồn tại hiển thị e06 |
| Category | Exception |
| Priority | High |
| Requirement | G024 |
| Use Case | UC-01/02/03 |
| Business Rule | E06 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Hội thoại không tồn tại hiển thị E06; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC044

| Field | Value |
|---|---|
| Test Case | Cả 3 thao tác hoạt động với hội thoại 1:1 |
| ID | G024_TC044 |
| Purpose | Xác minh cả 3 thao tác hoạt động với hội thoại 1:1 |
| Category | Regression |
| Priority | High |
| Requirement | G024 |
| Use Case | UC-01/02/03 |
| Business Rule | BR09 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Cả 3 thao tác hoạt động với hội thoại 1:1; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC045

| Field | Value |
|---|---|
| Test Case | Cả 3 thao tác hoạt động với hội thoại nhóm |
| ID | G024_TC045 |
| Purpose | Xác minh cả 3 thao tác hoạt động với hội thoại nhóm |
| Category | Regression |
| Priority | High |
| Requirement | G024 |
| Use Case | UC-01/02/03 |
| Business Rule | BR09 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Cả 3 thao tác hoạt động với hội thoại nhóm; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC046

| Field | Value |
|---|---|
| Test Case | Audit log ghi hành động Ẩn |
| ID | G024_TC046 |
| Purpose | Xác minh audit log ghi hành động ẩn |
| Category | Security |
| Priority | High |
| Requirement | G024 |
| Use Case | UC-01 |
| Business Rule | BR10 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Audit log ghi hành động Ẩn; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC047

| Field | Value |
|---|---|
| Test Case | Audit log ghi hành động Xoá lịch sử |
| ID | G024_TC047 |
| Purpose | Xác minh audit log ghi hành động xoá lịch sử |
| Category | Security |
| Priority | High |
| Requirement | G024 |
| Use Case | UC-02 |
| Business Rule | BR10 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Audit log ghi hành động Xoá lịch sử; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC048

| Field | Value |
|---|---|
| Test Case | Không thể dùng API Ẩn/Xoá để ảnh hưởng user khác |
| ID | G024_TC048 |
| Purpose | Xác minh không thể dùng api ẩn/xoá để ảnh hưởng user khác |
| Category | Security |
| Priority | Critical |
| Requirement | G024 |
| Use Case | UC-01/02 |
| Business Rule | BR01/BR02 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Không thể dùng API Ẩn/Xoá để ảnh hưởng user khác; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC049

| Field | Value |
|---|---|
| Test Case | BR06 chống spam 24h - nếu được chốt - chặn lần báo thứ hai |
| ID | G024_TC049 |
| Purpose | Xác minh br06 chống spam 24h - nếu được chốt - chặn lần báo thứ hai |
| Category | Conditional |
| Priority | Medium |
| Requirement | G024 |
| Use Case | UC-03 |
| Business Rule | BR06 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: BR06 chống spam 24h - nếu được chốt - chặn lần báo thứ hai; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G024_TC050

| Field | Value |
|---|---|
| Test Case | BR06 chống spam tính toàn workspace - nếu được chốt |
| ID | G024_TC050 |
| Purpose | Xác minh br06 chống spam tính toàn workspace - nếu được chốt |
| Category | Conditional |
| Priority | Medium |
| Requirement | G024 |
| Use Case | UC-03 |
| Business Rule | BR06 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: BR06 chống spam tính toàn workspace - nếu được chốt; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |


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
| 1.0 | 2026-08-22 | Tạo testcase riêng cho requirement G024 |
