# [G028] — Tắt / Bật thông báo hội thoại — TESTCASES

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

## 9. Testcase Summary

| ID | Test Case | Category | Priority | Use Case | Business Rule | Status |
|---|---|---|---|---|---|---|
| G028_TC001 | Mở menu mute từ icon chuông panel phải | Functional | High | UC-01 | BR01 | Not Run |
| G028_TC002 | Mở menu mute từ option menu hội thoại | Functional | High | UC-01 | BR01 | Not Run |
| G028_TC003 | Menu hiển thị đủ 1h/4h/đến 8h/cho đến khi bật lại | UI/UX | High | UC-01 | BR01 | Not Run |
| G028_TC004 | Mặc định hội thoại ở trạng thái bật thông báo | State Transition | High | UC-01 | State | Not Run |
| G028_TC005 | Mute 1 giờ chặn notification cho đúng user | Functional | Critical | UC-01 | BR01/BR05 | Not Run |
| G028_TC006 | Mute 4 giờ chặn notification cho đúng user | Functional | Critical | UC-01 | BR01/BR05 | Not Run |
| G028_TC007 | Mute vô thời hạn duy trì đến khi bật tay | Functional | Critical | UC-01 | BR01 | Not Run |
| G028_TC008 | Mute trước 08:00 đến 8h sáng hết hạn cùng ngày | Boundary | Critical | UC-01 | BR01 | Not Run |
| G028_TC009 | Mute đúng 08:00 đến 8h sáng hết hạn hôm sau | Boundary | Critical | UC-01 | BR01 | Not Run |
| G028_TC010 | Mute sau 08:00 đến 8h sáng hết hạn hôm sau | Boundary | Critical | UC-01 | BR01 | Not Run |
| G028_TC011 | Hết 1 giờ tự bật lại | State Transition | Critical | UC-01 | BR02 | Not Run |
| G028_TC012 | Hết 4 giờ tự bật lại | State Transition | Critical | UC-01 | BR02 | Not Run |
| G028_TC013 | Hết mốc 8h sáng tự bật lại | State Transition | Critical | UC-01 | BR02 | Not Run |
| G028_TC014 | Icon chuông đổi sang trạng thái tắt sau mute | UI/UX | High | UC-01 | BR02 | Not Run |
| G028_TC015 | Icon chuông trở lại bật sau auto-unmute | UI/UX | High | UC-01 | BR02 | Not Run |
| G028_TC016 | Bật lại thủ công khi đang mute hẹn giờ | Functional | Critical | UC-02 | BR03 | Not Run |
| G028_TC017 | Bật lại thủ công huỷ timer cũ | State Transition | Critical | UC-02 | BR03 | Not Run |
| G028_TC018 | Bật lại thủ công với mute vô thời hạn | Functional | Critical | UC-02 | BR03 | Not Run |
| G028_TC019 | Đang mute 8h sáng đổi sang 1h reset timer | State Transition | Critical | UC-01 | BR04 | Not Run |
| G028_TC020 | Đang mute 1h đổi sang 4h không cộng dồn | State Transition | Critical | UC-01 | BR04 | Not Run |
| G028_TC021 | Đang mute hẹn giờ đổi sang vô thời hạn | State Transition | High | UC-01 | BR04 | Not Run |
| G028_TC022 | Trong thời gian mute hội thoại vẫn nhận tin | Functional | Critical | UC-01 | BR05 | Not Run |
| G028_TC023 | Trong thời gian mute unread vẫn tăng | Functional | Critical | UC-01 | BR05 | Not Run |
| G028_TC024 | Trong thời gian mute không có toast web | Integration | Critical | UC-01 | BR05/G027 | Not Run |
| G028_TC025 | Trong thời gian mute không có browser notification | Integration | Critical | UC-01 | BR05/G027 | Not Run |
| G028_TC026 | Trong thời gian mute không có mobile push | Integration | Critical | UC-01 | BR05/G027 | Not Run |
| G028_TC027 | User A mute không ảnh hưởng user B cùng tài khoản Zalo | Data Isolation | Critical | UC-01 | BR06 | Not Run |
| G028_TC028 | User B vẫn nhận notification khi A mute | Integration | Critical | UC-01 | BR06/G027 | Not Run |
| G028_TC029 | Mute của user A trên hội thoại X không ảnh hưởng hội thoại Y | Data Isolation | Critical | UC-01 | BR06 | Not Run |
| G028_TC030 | Mute trạng thái được giữ sau reload | Regression | High | UC-01 | BR06 | Not Run |
| G028_TC031 | Mute trạng thái được giữ sau logout/login nếu chưa hết hạn | Regression | High | UC-01 | BR06 | Not Run |
| G028_TC032 | Thao tác mute thất bại giữ nguyên trạng thái trước đó | Recovery | Critical | UC-01 | E01 | Not Run |
| G028_TC033 | Thao tác unmute thất bại giữ nguyên trạng thái mute | Recovery | Critical | UC-02 | E01 | Not Run |
| G028_TC034 | Mất quyền hội thoại thì không còn thao tác mute được | Permission | High | UC-01/02 | Precondition | Not Run |
| G028_TC035 | Trạng thái mute của cùng user nhất quán giữa các tab | Sync | High | UC-01/02 | QA | Not Run |

## 10. Testcase Detail

### G028_TC001

| Field | Value |
|---|---|
| Test Case | Mở menu mute từ icon chuông panel phải |
| ID | G028_TC001 |
| Purpose | Xác minh mở menu mute từ icon chuông panel phải |
| Category | Functional |
| Priority | High |
| Requirement | G028 |
| Use Case | UC-01 |
| Business Rule | BR01 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Mở menu mute từ icon chuông panel phải; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G028_TC002

| Field | Value |
|---|---|
| Test Case | Mở menu mute từ option menu hội thoại |
| ID | G028_TC002 |
| Purpose | Xác minh mở menu mute từ option menu hội thoại |
| Category | Functional |
| Priority | High |
| Requirement | G028 |
| Use Case | UC-01 |
| Business Rule | BR01 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Mở menu mute từ option menu hội thoại; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G028_TC003

| Field | Value |
|---|---|
| Test Case | Menu hiển thị đủ 1h/4h/đến 8h/cho đến khi bật lại |
| ID | G028_TC003 |
| Purpose | Xác minh menu hiển thị đủ 1h/4h/đến 8h/cho đến khi bật lại |
| Category | UI/UX |
| Priority | High |
| Requirement | G028 |
| Use Case | UC-01 |
| Business Rule | BR01 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Menu hiển thị đủ 1h/4h/đến 8h/cho đến khi bật lại; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G028_TC004

| Field | Value |
|---|---|
| Test Case | Mặc định hội thoại ở trạng thái bật thông báo |
| ID | G028_TC004 |
| Purpose | Xác minh mặc định hội thoại ở trạng thái bật thông báo |
| Category | State Transition |
| Priority | High |
| Requirement | G028 |
| Use Case | UC-01 |
| Business Rule | State |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Mặc định hội thoại ở trạng thái bật thông báo; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G028_TC005

| Field | Value |
|---|---|
| Test Case | Mute 1 giờ chặn notification cho đúng user |
| ID | G028_TC005 |
| Purpose | Xác minh mute 1 giờ chặn notification cho đúng user |
| Category | Functional |
| Priority | Critical |
| Requirement | G028 |
| Use Case | UC-01 |
| Business Rule | BR01/BR05 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Mute 1 giờ chặn notification cho đúng user; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G028_TC006

| Field | Value |
|---|---|
| Test Case | Mute 4 giờ chặn notification cho đúng user |
| ID | G028_TC006 |
| Purpose | Xác minh mute 4 giờ chặn notification cho đúng user |
| Category | Functional |
| Priority | Critical |
| Requirement | G028 |
| Use Case | UC-01 |
| Business Rule | BR01/BR05 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Mute 4 giờ chặn notification cho đúng user; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G028_TC007

| Field | Value |
|---|---|
| Test Case | Mute vô thời hạn duy trì đến khi bật tay |
| ID | G028_TC007 |
| Purpose | Xác minh mute vô thời hạn duy trì đến khi bật tay |
| Category | Functional |
| Priority | Critical |
| Requirement | G028 |
| Use Case | UC-01 |
| Business Rule | BR01 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Mute vô thời hạn duy trì đến khi bật tay; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G028_TC008

| Field | Value |
|---|---|
| Test Case | Mute trước 08:00 đến 8h sáng hết hạn cùng ngày |
| ID | G028_TC008 |
| Purpose | Xác minh mute trước 08:00 đến 8h sáng hết hạn cùng ngày |
| Category | Boundary |
| Priority | Critical |
| Requirement | G028 |
| Use Case | UC-01 |
| Business Rule | BR01 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Mute trước 08:00 đến 8h sáng hết hạn cùng ngày; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G028_TC009

| Field | Value |
|---|---|
| Test Case | Mute đúng 08:00 đến 8h sáng hết hạn hôm sau |
| ID | G028_TC009 |
| Purpose | Xác minh mute đúng 08:00 đến 8h sáng hết hạn hôm sau |
| Category | Boundary |
| Priority | Critical |
| Requirement | G028 |
| Use Case | UC-01 |
| Business Rule | BR01 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Mute đúng 08:00 đến 8h sáng hết hạn hôm sau; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G028_TC010

| Field | Value |
|---|---|
| Test Case | Mute sau 08:00 đến 8h sáng hết hạn hôm sau |
| ID | G028_TC010 |
| Purpose | Xác minh mute sau 08:00 đến 8h sáng hết hạn hôm sau |
| Category | Boundary |
| Priority | Critical |
| Requirement | G028 |
| Use Case | UC-01 |
| Business Rule | BR01 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Mute sau 08:00 đến 8h sáng hết hạn hôm sau; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G028_TC011

| Field | Value |
|---|---|
| Test Case | Hết 1 giờ tự bật lại |
| ID | G028_TC011 |
| Purpose | Xác minh hết 1 giờ tự bật lại |
| Category | State Transition |
| Priority | Critical |
| Requirement | G028 |
| Use Case | UC-01 |
| Business Rule | BR02 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Hết 1 giờ tự bật lại; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G028_TC012

| Field | Value |
|---|---|
| Test Case | Hết 4 giờ tự bật lại |
| ID | G028_TC012 |
| Purpose | Xác minh hết 4 giờ tự bật lại |
| Category | State Transition |
| Priority | Critical |
| Requirement | G028 |
| Use Case | UC-01 |
| Business Rule | BR02 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Hết 4 giờ tự bật lại; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G028_TC013

| Field | Value |
|---|---|
| Test Case | Hết mốc 8h sáng tự bật lại |
| ID | G028_TC013 |
| Purpose | Xác minh hết mốc 8h sáng tự bật lại |
| Category | State Transition |
| Priority | Critical |
| Requirement | G028 |
| Use Case | UC-01 |
| Business Rule | BR02 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Hết mốc 8h sáng tự bật lại; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G028_TC014

| Field | Value |
|---|---|
| Test Case | Icon chuông đổi sang trạng thái tắt sau mute |
| ID | G028_TC014 |
| Purpose | Xác minh icon chuông đổi sang trạng thái tắt sau mute |
| Category | UI/UX |
| Priority | High |
| Requirement | G028 |
| Use Case | UC-01 |
| Business Rule | BR02 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Icon chuông đổi sang trạng thái tắt sau mute; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G028_TC015

| Field | Value |
|---|---|
| Test Case | Icon chuông trở lại bật sau auto-unmute |
| ID | G028_TC015 |
| Purpose | Xác minh icon chuông trở lại bật sau auto-unmute |
| Category | UI/UX |
| Priority | High |
| Requirement | G028 |
| Use Case | UC-01 |
| Business Rule | BR02 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Icon chuông trở lại bật sau auto-unmute; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G028_TC016

| Field | Value |
|---|---|
| Test Case | Bật lại thủ công khi đang mute hẹn giờ |
| ID | G028_TC016 |
| Purpose | Xác minh bật lại thủ công khi đang mute hẹn giờ |
| Category | Functional |
| Priority | Critical |
| Requirement | G028 |
| Use Case | UC-02 |
| Business Rule | BR03 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Bật lại thủ công khi đang mute hẹn giờ; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G028_TC017

| Field | Value |
|---|---|
| Test Case | Bật lại thủ công huỷ timer cũ |
| ID | G028_TC017 |
| Purpose | Xác minh bật lại thủ công huỷ timer cũ |
| Category | State Transition |
| Priority | Critical |
| Requirement | G028 |
| Use Case | UC-02 |
| Business Rule | BR03 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Bật lại thủ công huỷ timer cũ; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G028_TC018

| Field | Value |
|---|---|
| Test Case | Bật lại thủ công với mute vô thời hạn |
| ID | G028_TC018 |
| Purpose | Xác minh bật lại thủ công với mute vô thời hạn |
| Category | Functional |
| Priority | Critical |
| Requirement | G028 |
| Use Case | UC-02 |
| Business Rule | BR03 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Bật lại thủ công với mute vô thời hạn; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G028_TC019

| Field | Value |
|---|---|
| Test Case | Đang mute 8h sáng đổi sang 1h reset timer |
| ID | G028_TC019 |
| Purpose | Xác minh đang mute 8h sáng đổi sang 1h reset timer |
| Category | State Transition |
| Priority | Critical |
| Requirement | G028 |
| Use Case | UC-01 |
| Business Rule | BR04 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Đang mute 8h sáng đổi sang 1h reset timer; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G028_TC020

| Field | Value |
|---|---|
| Test Case | Đang mute 1h đổi sang 4h không cộng dồn |
| ID | G028_TC020 |
| Purpose | Xác minh đang mute 1h đổi sang 4h không cộng dồn |
| Category | State Transition |
| Priority | Critical |
| Requirement | G028 |
| Use Case | UC-01 |
| Business Rule | BR04 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Đang mute 1h đổi sang 4h không cộng dồn; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G028_TC021

| Field | Value |
|---|---|
| Test Case | Đang mute hẹn giờ đổi sang vô thời hạn |
| ID | G028_TC021 |
| Purpose | Xác minh đang mute hẹn giờ đổi sang vô thời hạn |
| Category | State Transition |
| Priority | High |
| Requirement | G028 |
| Use Case | UC-01 |
| Business Rule | BR04 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Đang mute hẹn giờ đổi sang vô thời hạn; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G028_TC022

| Field | Value |
|---|---|
| Test Case | Trong thời gian mute hội thoại vẫn nhận tin |
| ID | G028_TC022 |
| Purpose | Xác minh trong thời gian mute hội thoại vẫn nhận tin |
| Category | Functional |
| Priority | Critical |
| Requirement | G028 |
| Use Case | UC-01 |
| Business Rule | BR05 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Trong thời gian mute hội thoại vẫn nhận tin; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G028_TC023

| Field | Value |
|---|---|
| Test Case | Trong thời gian mute unread vẫn tăng |
| ID | G028_TC023 |
| Purpose | Xác minh trong thời gian mute unread vẫn tăng |
| Category | Functional |
| Priority | Critical |
| Requirement | G028 |
| Use Case | UC-01 |
| Business Rule | BR05 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Trong thời gian mute unread vẫn tăng; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G028_TC024

| Field | Value |
|---|---|
| Test Case | Trong thời gian mute không có toast web |
| ID | G028_TC024 |
| Purpose | Xác minh trong thời gian mute không có toast web |
| Category | Integration |
| Priority | Critical |
| Requirement | G028 |
| Use Case | UC-01 |
| Business Rule | BR05/G027 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Trong thời gian mute không có toast web; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G028_TC025

| Field | Value |
|---|---|
| Test Case | Trong thời gian mute không có browser notification |
| ID | G028_TC025 |
| Purpose | Xác minh trong thời gian mute không có browser notification |
| Category | Integration |
| Priority | Critical |
| Requirement | G028 |
| Use Case | UC-01 |
| Business Rule | BR05/G027 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Trong thời gian mute không có browser notification; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G028_TC026

| Field | Value |
|---|---|
| Test Case | Trong thời gian mute không có mobile push |
| ID | G028_TC026 |
| Purpose | Xác minh trong thời gian mute không có mobile push |
| Category | Integration |
| Priority | Critical |
| Requirement | G028 |
| Use Case | UC-01 |
| Business Rule | BR05/G027 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Trong thời gian mute không có mobile push; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G028_TC027

| Field | Value |
|---|---|
| Test Case | User A mute không ảnh hưởng user B cùng tài khoản Zalo |
| ID | G028_TC027 |
| Purpose | Xác minh user a mute không ảnh hưởng user b cùng tài khoản zalo |
| Category | Data Isolation |
| Priority | Critical |
| Requirement | G028 |
| Use Case | UC-01 |
| Business Rule | BR06 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: User A mute không ảnh hưởng user B cùng tài khoản Zalo; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G028_TC028

| Field | Value |
|---|---|
| Test Case | User B vẫn nhận notification khi A mute |
| ID | G028_TC028 |
| Purpose | Xác minh user b vẫn nhận notification khi a mute |
| Category | Integration |
| Priority | Critical |
| Requirement | G028 |
| Use Case | UC-01 |
| Business Rule | BR06/G027 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: User B vẫn nhận notification khi A mute; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G028_TC029

| Field | Value |
|---|---|
| Test Case | Mute của user A trên hội thoại X không ảnh hưởng hội thoại Y |
| ID | G028_TC029 |
| Purpose | Xác minh mute của user a trên hội thoại x không ảnh hưởng hội thoại y |
| Category | Data Isolation |
| Priority | Critical |
| Requirement | G028 |
| Use Case | UC-01 |
| Business Rule | BR06 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Mute của user A trên hội thoại X không ảnh hưởng hội thoại Y; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G028_TC030

| Field | Value |
|---|---|
| Test Case | Mute trạng thái được giữ sau reload |
| ID | G028_TC030 |
| Purpose | Xác minh mute trạng thái được giữ sau reload |
| Category | Regression |
| Priority | High |
| Requirement | G028 |
| Use Case | UC-01 |
| Business Rule | BR06 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Mute trạng thái được giữ sau reload; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G028_TC031

| Field | Value |
|---|---|
| Test Case | Mute trạng thái được giữ sau logout/login nếu chưa hết hạn |
| ID | G028_TC031 |
| Purpose | Xác minh mute trạng thái được giữ sau logout/login nếu chưa hết hạn |
| Category | Regression |
| Priority | High |
| Requirement | G028 |
| Use Case | UC-01 |
| Business Rule | BR06 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Mute trạng thái được giữ sau logout/login nếu chưa hết hạn; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G028_TC032

| Field | Value |
|---|---|
| Test Case | Thao tác mute thất bại giữ nguyên trạng thái trước đó |
| ID | G028_TC032 |
| Purpose | Xác minh thao tác mute thất bại giữ nguyên trạng thái trước đó |
| Category | Recovery |
| Priority | Critical |
| Requirement | G028 |
| Use Case | UC-01 |
| Business Rule | E01 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Thao tác mute thất bại giữ nguyên trạng thái trước đó; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G028_TC033

| Field | Value |
|---|---|
| Test Case | Thao tác unmute thất bại giữ nguyên trạng thái mute |
| ID | G028_TC033 |
| Purpose | Xác minh thao tác unmute thất bại giữ nguyên trạng thái mute |
| Category | Recovery |
| Priority | Critical |
| Requirement | G028 |
| Use Case | UC-02 |
| Business Rule | E01 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Thao tác unmute thất bại giữ nguyên trạng thái mute; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G028_TC034

| Field | Value |
|---|---|
| Test Case | Mất quyền hội thoại thì không còn thao tác mute được |
| ID | G028_TC034 |
| Purpose | Xác minh mất quyền hội thoại thì không còn thao tác mute được |
| Category | Permission |
| Priority | High |
| Requirement | G028 |
| Use Case | UC-01/02 |
| Business Rule | Precondition |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Mất quyền hội thoại thì không còn thao tác mute được; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G028_TC035

| Field | Value |
|---|---|
| Test Case | Trạng thái mute của cùng user nhất quán giữa các tab |
| ID | G028_TC035 |
| Purpose | Xác minh trạng thái mute của cùng user nhất quán giữa các tab |
| Category | Sync |
| Priority | High |
| Requirement | G028 |
| Use Case | UC-01/02 |
| Business Rule | QA |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Trạng thái mute của cùng user nhất quán giữa các tab; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
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
| 1.0 | 2026-08-22 | Tạo testcase riêng cho requirement G028 |
