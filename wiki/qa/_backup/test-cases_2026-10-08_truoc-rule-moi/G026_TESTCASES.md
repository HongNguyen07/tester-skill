# [G026] — Cài đặt nhóm — TESTCASES

## 1. Requirement Information

| Item | Value |
|---|---|
| Feature ID | G026 |
| Feature Name | Cài đặt nhóm |
| Source | G026 - Cài đặt nhóm.md |
| Total Test Cases | 55 |
| Documentation Standard | QA Specification v1.1 |

## 2. Requirement Analysis

- Requirement chính thức: giống Zalo nhưng không có phó nhóm; chỉ trưởng nhóm chỉnh; 5 quyền gate sang G008/G019/G025/G014/G003.
- Coverage QA bổ sung: kiểm tra API authorization, persistence qua reload, cross-feature gating, member approval concurrency.
- Cần Dev xác nhận: phạm vi 'tin gần đây' là Zalo quyết định nên không hard-code expected theo số ngày.

## 3. Use Cases

UC-01, UC-02, UC-03, UC-04, UC-05, UC-06

## 4. Business Rules

BR01, BR02, BR03, BR04, BR05, BR05b, BR06, BR07, BR08

## 5. Decision Table

| D | Actor | Zalo | Setting | Expected |
|---|---|---|---|---|
| D01 | Trưởng nhóm | Connected | Editable | Cho chỉnh |
| D02 | Member | Connected | Any | Chỉ đọc |
| D03 | Trưởng nhóm | Disconnected | Any | Không lưu |
| D04 | Trưởng nhóm | Connected | Sửa info nhóm | Khóa Chỉ trưởng nhóm |

## 6. State Transition

| From | Event | To |
|---|---|---|
| Toggle Off | Bật | Toggle On |
| Toggle On | Tắt | Toggle Off |
| Pending request | Duyệt | Member |
| Pending request | Từ chối | Removed |
| Permission All | Set leader-only | Leader-only |
| Permission Leader-only | Set all | All |

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
| G026 | UC-01, UC-02, UC-03, UC-04, UC-05, UC-06 | BR01, BR02, BR03, BR04, BR05, BR05b, BR06, BR07, BR08 | G026_TC001 → G026_TC055 | Covered |

## 9. Testcase Summary

| ID | Test Case | Category | Priority | Use Case | Business Rule | Status |
|---|---|---|---|---|---|---|
| G026_TC001 | Mở màn Cài đặt nhóm hiển thị đủ 3 nhóm | Functional | Critical | UC-01 | BR01 | Not Run |
| G026_TC002 | Không xuất hiện cụm từ/vai trò phó nhóm ở bất kỳ đâu | Negative | Critical | UC-01 | BR01 | Not Run |
| G026_TC003 | Trưởng nhóm thấy control editable | Permission | Critical | UC-01 | BR02 | Not Run |
| G026_TC004 | Member thường chỉ xem, control read-only | Permission | Critical | UC-01 | BR02 | Not Run |
| G026_TC005 | API trực tiếp từ member không được đổi setting | Security | Critical | UC-02/03/04/05 | BR02/E01 | Not Run |
| G026_TC006 | Bật Làm nổi tin trưởng nhóm lưu thành công | Functional | High | UC-02 | BR03 | Not Run |
| G026_TC007 | Khi bật, tin trưởng nhóm có nhãn Trưởng nhóm | UI/UX | High | UC-02 | BR03 | Not Run |
| G026_TC008 | Khi bật, tin trưởng nhóm có màu viền khác | UI/UX | High | UC-02 | BR03 | Not Run |
| G026_TC009 | Tin member thường không bị làm nổi | Negative | High | UC-02 | BR03 | Not Run |
| G026_TC010 | Tắt Làm nổi tin trưởng nhóm trả UI về bình thường | State Transition | High | UC-02 | BR03 | Not Run |
| G026_TC011 | Bật Thành viên mới xem tin gần đây lưu thành công | Functional | High | UC-03 | BR03 | Not Run |
| G026_TC012 | Khi bật, member mới thấy phần lịch sử do Zalo trả | Integration | High | UC-03 | BR03 | Not Run |
| G026_TC013 | Khi tắt, member mới chỉ thấy tin từ lúc vào | Integration | Critical | UC-03 | BR03 | Not Run |
| G026_TC014 | Không hard-code phạm vi 2 tuần ở Gopany | Negative | High | UC-03 | BR03 | Not Run |
| G026_TC015 | Bật Duyệt thành viên lưu thành công | Functional | Critical | UC-04 | BR04 | Not Run |
| G026_TC016 | Khi bật, người vào qua link vào danh sách chờ | State Transition | Critical | UC-04/06 | BR04/BR08 | Not Run |
| G026_TC017 | Khi tắt, người vào qua link vào thẳng nhóm | State Transition | Critical | UC-04 | BR04 | Not Run |
| G026_TC018 | Badge số chờ hiển thị đúng | Functional | High | UC-06 | BR08 | Not Run |
| G026_TC019 | Trưởng nhóm duyệt request thành công | Permission | Critical | UC-06 | BR08 | Not Run |
| G026_TC020 | Sau duyệt user xuất hiện trong danh sách thành viên | Integration | Critical | UC-06 | BR08 | Not Run |
| G026_TC021 | Trưởng nhóm từ chối request thành công | Permission | Critical | UC-06 | BR08 | Not Run |
| G026_TC022 | Sau từ chối user bị loại khỏi danh sách chờ | State Transition | High | UC-06 | BR08 | Not Run |
| G026_TC023 | Member thường không duyệt/từ chối được | Security | Critical | UC-06 | BR08 | Not Run |
| G026_TC024 | Quyền sửa thông tin nhóm hiển thị Chỉ trưởng nhóm và khóa | Functional | Critical | UC-05 | BR05b | Not Run |
| G026_TC025 | Option Tất cả mọi người của sửa thông tin nhóm bị disable | Negative | Critical | UC-05 | BR05b | Not Run |
| G026_TC026 | Quyền tạo ghi chú/nhắc hẹn đổi được giữa 2 mức | Functional | High | UC-05 | BR05 | Not Run |
| G026_TC027 | Quyền tạo bình chọn đổi được giữa 2 mức | Functional | Critical | UC-05 | BR05 | Not Run |
| G026_TC028 | Quyền ghim tin nhắn đổi được giữa 2 mức | Functional | Critical | UC-05 | BR05 | Not Run |
| G026_TC029 | Quyền gửi tin nhắn đổi được giữa 2 mức | Functional | Critical | UC-05 | BR05 | Not Run |
| G026_TC030 | Đặt tạo ghi chú/nhắc hẹn = Chỉ trưởng nhóm gate đúng G019 | Integration | Critical | UC-05 | BR06 | Not Run |
| G026_TC031 | Đặt tạo bình chọn = Chỉ trưởng nhóm gate đúng G025 | Integration | Critical | UC-05 | BR06 | Not Run |
| G026_TC032 | Đặt ghim tin = Chỉ trưởng nhóm gate đúng G014 | Integration | Critical | UC-05 | BR06 | Not Run |
| G026_TC033 | Đặt gửi tin = Chỉ trưởng nhóm disable composer của member | Integration | Critical | UC-05 | BR06 | Not Run |
| G026_TC034 | Đặt quyền = Tất cả mọi người khôi phục action cho member | State Transition | Critical | UC-05 | BR06 | Not Run |
| G026_TC035 | Permission change áp dụng sau reload | Regression | High | UC-05 | BR05/BR06 | Not Run |
| G026_TC036 | Permission change áp dụng trên phiên member đang mở | Sync | High | UC-05 | BR06 | Not Run |
| G026_TC037 | DISCONNECTED không đổi được toggle Làm nổi | Exception | Critical | UC-02 | BR07/E02 | Not Run |
| G026_TC038 | DISCONNECTED không đổi được toggle lịch sử gần đây | Exception | Critical | UC-03 | BR07/E02 | Not Run |
| G026_TC039 | DISCONNECTED không đổi được Duyệt thành viên | Exception | Critical | UC-04 | BR07/E02 | Not Run |
| G026_TC040 | DISCONNECTED không đổi được quyền thành viên | Exception | Critical | UC-05 | BR07/E02 | Not Run |
| G026_TC041 | Lưu lỗi rollback toggle về trạng thái trước | Recovery | Critical | UC-02/03/04/05 | E02 | Not Run |
| G026_TC042 | Lưu lỗi permission rollback lựa chọn trước | Recovery | Critical | UC-05 | E02 | Not Run |
| G026_TC043 | Member thường mở màn vẫn thấy đúng trạng thái hiện tại | Functional | High | UC-01 | BR02 | Not Run |
| G026_TC044 | Quản lý thành viên điều hướng đúng G008 | Regression | High | UC-01 | Dependency | Not Run |
| G026_TC045 | Thay trưởng nhóm thì quyền chỉnh chuyển sang trưởng mới | State Transition | Critical | UC-01 | BR02 | Not Run |
| G026_TC046 | Trưởng cũ sau chuyển quyền không còn chỉnh được | Security | Critical | UC-01 | BR02 | Not Run |
| G026_TC047 | Hai request chờ được duyệt độc lập không lẫn trạng thái | Concurrency | High | UC-06 | BR08 | Not Run |
| G026_TC048 | Duyệt cùng một request từ hai phiên không tạo member trùng | Concurrency | Critical | UC-06 | BR08 | Not Run |
| G026_TC049 | Badge chờ giảm đúng sau duyệt | State Transition | High | UC-06 | BR08 | Not Run |
| G026_TC050 | Badge chờ giảm đúng sau từ chối | State Transition | High | UC-06 | BR08 | Not Run |
| G026_TC051 | Cài đặt nhóm chỉ áp dụng cho hội thoại nhóm | Negative | High | UC-01 | Scope | Not Run |
| G026_TC052 | Không phải trưởng nhóm nhưng có quyền xem vẫn không chỉnh được | Permission | Critical | UC-01 | BR02 | Not Run |
| G026_TC053 | Member mới sau khi setting quyền thay đổi nhận đúng gate hiện tại | Regression | High | UC-05 | BR06 | Not Run |
| G026_TC054 | Các setting đọc/ghi qua đúng tài khoản Zalo của nhóm | Integration | Critical | UC-02/03/04/05 | BR07 | Not Run |
| G026_TC055 | Không hiển thị quyền cấu hình theo từng member riêng lẻ | Negative | Medium | UC-05 | OOS02 | Not Run |

## 10. Testcase Detail

### G026_TC001

| Field | Value |
|---|---|
| Test Case | Mở màn Cài đặt nhóm hiển thị đủ 3 nhóm |
| ID | G026_TC001 |
| Purpose | Xác minh mở màn cài đặt nhóm hiển thị đủ 3 nhóm |
| Category | Functional |
| Priority | Critical |
| Requirement | G026 |
| Use Case | UC-01 |
| Business Rule | BR01 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Mở màn Cài đặt nhóm hiển thị đủ 3 nhóm; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC002

| Field | Value |
|---|---|
| Test Case | Không xuất hiện cụm từ/vai trò phó nhóm ở bất kỳ đâu |
| ID | G026_TC002 |
| Purpose | Xác minh không xuất hiện cụm từ/vai trò phó nhóm ở bất kỳ đâu |
| Category | Negative |
| Priority | Critical |
| Requirement | G026 |
| Use Case | UC-01 |
| Business Rule | BR01 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Không xuất hiện cụm từ/vai trò phó nhóm ở bất kỳ đâu; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC003

| Field | Value |
|---|---|
| Test Case | Trưởng nhóm thấy control editable |
| ID | G026_TC003 |
| Purpose | Xác minh trưởng nhóm thấy control editable |
| Category | Permission |
| Priority | Critical |
| Requirement | G026 |
| Use Case | UC-01 |
| Business Rule | BR02 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Trưởng nhóm thấy control editable; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC004

| Field | Value |
|---|---|
| Test Case | Member thường chỉ xem, control read-only |
| ID | G026_TC004 |
| Purpose | Xác minh member thường chỉ xem, control read-only |
| Category | Permission |
| Priority | Critical |
| Requirement | G026 |
| Use Case | UC-01 |
| Business Rule | BR02 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Member thường chỉ xem, control read-only; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC005

| Field | Value |
|---|---|
| Test Case | API trực tiếp từ member không được đổi setting |
| ID | G026_TC005 |
| Purpose | Xác minh api trực tiếp từ member không được đổi setting |
| Category | Security |
| Priority | Critical |
| Requirement | G026 |
| Use Case | UC-02/03/04/05 |
| Business Rule | BR02/E01 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: API trực tiếp từ member không được đổi setting; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC006

| Field | Value |
|---|---|
| Test Case | Bật Làm nổi tin trưởng nhóm lưu thành công |
| ID | G026_TC006 |
| Purpose | Xác minh bật làm nổi tin trưởng nhóm lưu thành công |
| Category | Functional |
| Priority | High |
| Requirement | G026 |
| Use Case | UC-02 |
| Business Rule | BR03 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Bật Làm nổi tin trưởng nhóm lưu thành công; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC007

| Field | Value |
|---|---|
| Test Case | Khi bật, tin trưởng nhóm có nhãn Trưởng nhóm |
| ID | G026_TC007 |
| Purpose | Xác minh khi bật, tin trưởng nhóm có nhãn trưởng nhóm |
| Category | UI/UX |
| Priority | High |
| Requirement | G026 |
| Use Case | UC-02 |
| Business Rule | BR03 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Khi bật, tin trưởng nhóm có nhãn Trưởng nhóm; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC008

| Field | Value |
|---|---|
| Test Case | Khi bật, tin trưởng nhóm có màu viền khác |
| ID | G026_TC008 |
| Purpose | Xác minh khi bật, tin trưởng nhóm có màu viền khác |
| Category | UI/UX |
| Priority | High |
| Requirement | G026 |
| Use Case | UC-02 |
| Business Rule | BR03 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Khi bật, tin trưởng nhóm có màu viền khác; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC009

| Field | Value |
|---|---|
| Test Case | Tin member thường không bị làm nổi |
| ID | G026_TC009 |
| Purpose | Xác minh tin member thường không bị làm nổi |
| Category | Negative |
| Priority | High |
| Requirement | G026 |
| Use Case | UC-02 |
| Business Rule | BR03 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Tin member thường không bị làm nổi; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC010

| Field | Value |
|---|---|
| Test Case | Tắt Làm nổi tin trưởng nhóm trả UI về bình thường |
| ID | G026_TC010 |
| Purpose | Xác minh tắt làm nổi tin trưởng nhóm trả ui về bình thường |
| Category | State Transition |
| Priority | High |
| Requirement | G026 |
| Use Case | UC-02 |
| Business Rule | BR03 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Tắt Làm nổi tin trưởng nhóm trả UI về bình thường; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC011

| Field | Value |
|---|---|
| Test Case | Bật Thành viên mới xem tin gần đây lưu thành công |
| ID | G026_TC011 |
| Purpose | Xác minh bật thành viên mới xem tin gần đây lưu thành công |
| Category | Functional |
| Priority | High |
| Requirement | G026 |
| Use Case | UC-03 |
| Business Rule | BR03 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Bật Thành viên mới xem tin gần đây lưu thành công; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC012

| Field | Value |
|---|---|
| Test Case | Khi bật, member mới thấy phần lịch sử do Zalo trả |
| ID | G026_TC012 |
| Purpose | Xác minh khi bật, member mới thấy phần lịch sử do zalo trả |
| Category | Integration |
| Priority | High |
| Requirement | G026 |
| Use Case | UC-03 |
| Business Rule | BR03 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Khi bật, member mới thấy phần lịch sử do Zalo trả; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC013

| Field | Value |
|---|---|
| Test Case | Khi tắt, member mới chỉ thấy tin từ lúc vào |
| ID | G026_TC013 |
| Purpose | Xác minh khi tắt, member mới chỉ thấy tin từ lúc vào |
| Category | Integration |
| Priority | Critical |
| Requirement | G026 |
| Use Case | UC-03 |
| Business Rule | BR03 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Khi tắt, member mới chỉ thấy tin từ lúc vào; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC014

| Field | Value |
|---|---|
| Test Case | Không hard-code phạm vi 2 tuần ở Gopany |
| ID | G026_TC014 |
| Purpose | Xác minh không hard-code phạm vi 2 tuần ở gopany |
| Category | Negative |
| Priority | High |
| Requirement | G026 |
| Use Case | UC-03 |
| Business Rule | BR03 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Không hard-code phạm vi 2 tuần ở Gopany; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC015

| Field | Value |
|---|---|
| Test Case | Bật Duyệt thành viên lưu thành công |
| ID | G026_TC015 |
| Purpose | Xác minh bật duyệt thành viên lưu thành công |
| Category | Functional |
| Priority | Critical |
| Requirement | G026 |
| Use Case | UC-04 |
| Business Rule | BR04 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Bật Duyệt thành viên lưu thành công; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC016

| Field | Value |
|---|---|
| Test Case | Khi bật, người vào qua link vào danh sách chờ |
| ID | G026_TC016 |
| Purpose | Xác minh khi bật, người vào qua link vào danh sách chờ |
| Category | State Transition |
| Priority | Critical |
| Requirement | G026 |
| Use Case | UC-04/06 |
| Business Rule | BR04/BR08 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Khi bật, người vào qua link vào danh sách chờ; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC017

| Field | Value |
|---|---|
| Test Case | Khi tắt, người vào qua link vào thẳng nhóm |
| ID | G026_TC017 |
| Purpose | Xác minh khi tắt, người vào qua link vào thẳng nhóm |
| Category | State Transition |
| Priority | Critical |
| Requirement | G026 |
| Use Case | UC-04 |
| Business Rule | BR04 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Khi tắt, người vào qua link vào thẳng nhóm; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC018

| Field | Value |
|---|---|
| Test Case | Badge số chờ hiển thị đúng |
| ID | G026_TC018 |
| Purpose | Xác minh badge số chờ hiển thị đúng |
| Category | Functional |
| Priority | High |
| Requirement | G026 |
| Use Case | UC-06 |
| Business Rule | BR08 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Badge số chờ hiển thị đúng; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC019

| Field | Value |
|---|---|
| Test Case | Trưởng nhóm duyệt request thành công |
| ID | G026_TC019 |
| Purpose | Xác minh trưởng nhóm duyệt request thành công |
| Category | Permission |
| Priority | Critical |
| Requirement | G026 |
| Use Case | UC-06 |
| Business Rule | BR08 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Trưởng nhóm duyệt request thành công; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC020

| Field | Value |
|---|---|
| Test Case | Sau duyệt user xuất hiện trong danh sách thành viên |
| ID | G026_TC020 |
| Purpose | Xác minh sau duyệt user xuất hiện trong danh sách thành viên |
| Category | Integration |
| Priority | Critical |
| Requirement | G026 |
| Use Case | UC-06 |
| Business Rule | BR08 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Sau duyệt user xuất hiện trong danh sách thành viên; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC021

| Field | Value |
|---|---|
| Test Case | Trưởng nhóm từ chối request thành công |
| ID | G026_TC021 |
| Purpose | Xác minh trưởng nhóm từ chối request thành công |
| Category | Permission |
| Priority | Critical |
| Requirement | G026 |
| Use Case | UC-06 |
| Business Rule | BR08 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Trưởng nhóm từ chối request thành công; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC022

| Field | Value |
|---|---|
| Test Case | Sau từ chối user bị loại khỏi danh sách chờ |
| ID | G026_TC022 |
| Purpose | Xác minh sau từ chối user bị loại khỏi danh sách chờ |
| Category | State Transition |
| Priority | High |
| Requirement | G026 |
| Use Case | UC-06 |
| Business Rule | BR08 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Sau từ chối user bị loại khỏi danh sách chờ; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC023

| Field | Value |
|---|---|
| Test Case | Member thường không duyệt/từ chối được |
| ID | G026_TC023 |
| Purpose | Xác minh member thường không duyệt/từ chối được |
| Category | Security |
| Priority | Critical |
| Requirement | G026 |
| Use Case | UC-06 |
| Business Rule | BR08 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Member thường không duyệt/từ chối được; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC024

| Field | Value |
|---|---|
| Test Case | Quyền sửa thông tin nhóm hiển thị Chỉ trưởng nhóm và khóa |
| ID | G026_TC024 |
| Purpose | Xác minh quyền sửa thông tin nhóm hiển thị chỉ trưởng nhóm và khóa |
| Category | Functional |
| Priority | Critical |
| Requirement | G026 |
| Use Case | UC-05 |
| Business Rule | BR05b |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Quyền sửa thông tin nhóm hiển thị Chỉ trưởng nhóm và khóa; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC025

| Field | Value |
|---|---|
| Test Case | Option Tất cả mọi người của sửa thông tin nhóm bị disable |
| ID | G026_TC025 |
| Purpose | Xác minh option tất cả mọi người của sửa thông tin nhóm bị disable |
| Category | Negative |
| Priority | Critical |
| Requirement | G026 |
| Use Case | UC-05 |
| Business Rule | BR05b |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Option Tất cả mọi người của sửa thông tin nhóm bị disable; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC026

| Field | Value |
|---|---|
| Test Case | Quyền tạo ghi chú/nhắc hẹn đổi được giữa 2 mức |
| ID | G026_TC026 |
| Purpose | Xác minh quyền tạo ghi chú/nhắc hẹn đổi được giữa 2 mức |
| Category | Functional |
| Priority | High |
| Requirement | G026 |
| Use Case | UC-05 |
| Business Rule | BR05 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Quyền tạo ghi chú/nhắc hẹn đổi được giữa 2 mức; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC027

| Field | Value |
|---|---|
| Test Case | Quyền tạo bình chọn đổi được giữa 2 mức |
| ID | G026_TC027 |
| Purpose | Xác minh quyền tạo bình chọn đổi được giữa 2 mức |
| Category | Functional |
| Priority | Critical |
| Requirement | G026 |
| Use Case | UC-05 |
| Business Rule | BR05 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Quyền tạo bình chọn đổi được giữa 2 mức; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC028

| Field | Value |
|---|---|
| Test Case | Quyền ghim tin nhắn đổi được giữa 2 mức |
| ID | G026_TC028 |
| Purpose | Xác minh quyền ghim tin nhắn đổi được giữa 2 mức |
| Category | Functional |
| Priority | Critical |
| Requirement | G026 |
| Use Case | UC-05 |
| Business Rule | BR05 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Quyền ghim tin nhắn đổi được giữa 2 mức; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC029

| Field | Value |
|---|---|
| Test Case | Quyền gửi tin nhắn đổi được giữa 2 mức |
| ID | G026_TC029 |
| Purpose | Xác minh quyền gửi tin nhắn đổi được giữa 2 mức |
| Category | Functional |
| Priority | Critical |
| Requirement | G026 |
| Use Case | UC-05 |
| Business Rule | BR05 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Quyền gửi tin nhắn đổi được giữa 2 mức; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC030

| Field | Value |
|---|---|
| Test Case | Đặt tạo ghi chú/nhắc hẹn = Chỉ trưởng nhóm gate đúng G019 |
| ID | G026_TC030 |
| Purpose | Xác minh đặt tạo ghi chú/nhắc hẹn = chỉ trưởng nhóm gate đúng g019 |
| Category | Integration |
| Priority | Critical |
| Requirement | G026 |
| Use Case | UC-05 |
| Business Rule | BR06 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Đặt tạo ghi chú/nhắc hẹn = Chỉ trưởng nhóm gate đúng G019; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC031

| Field | Value |
|---|---|
| Test Case | Đặt tạo bình chọn = Chỉ trưởng nhóm gate đúng G025 |
| ID | G026_TC031 |
| Purpose | Xác minh đặt tạo bình chọn = chỉ trưởng nhóm gate đúng g025 |
| Category | Integration |
| Priority | Critical |
| Requirement | G026 |
| Use Case | UC-05 |
| Business Rule | BR06 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Đặt tạo bình chọn = Chỉ trưởng nhóm gate đúng G025; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC032

| Field | Value |
|---|---|
| Test Case | Đặt ghim tin = Chỉ trưởng nhóm gate đúng G014 |
| ID | G026_TC032 |
| Purpose | Xác minh đặt ghim tin = chỉ trưởng nhóm gate đúng g014 |
| Category | Integration |
| Priority | Critical |
| Requirement | G026 |
| Use Case | UC-05 |
| Business Rule | BR06 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Đặt ghim tin = Chỉ trưởng nhóm gate đúng G014; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC033

| Field | Value |
|---|---|
| Test Case | Đặt gửi tin = Chỉ trưởng nhóm disable composer của member |
| ID | G026_TC033 |
| Purpose | Xác minh đặt gửi tin = chỉ trưởng nhóm disable composer của member |
| Category | Integration |
| Priority | Critical |
| Requirement | G026 |
| Use Case | UC-05 |
| Business Rule | BR06 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Đặt gửi tin = Chỉ trưởng nhóm disable composer của member; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC034

| Field | Value |
|---|---|
| Test Case | Đặt quyền = Tất cả mọi người khôi phục action cho member |
| ID | G026_TC034 |
| Purpose | Xác minh đặt quyền = tất cả mọi người khôi phục action cho member |
| Category | State Transition |
| Priority | Critical |
| Requirement | G026 |
| Use Case | UC-05 |
| Business Rule | BR06 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Đặt quyền = Tất cả mọi người khôi phục action cho member; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC035

| Field | Value |
|---|---|
| Test Case | Permission change áp dụng sau reload |
| ID | G026_TC035 |
| Purpose | Xác minh permission change áp dụng sau reload |
| Category | Regression |
| Priority | High |
| Requirement | G026 |
| Use Case | UC-05 |
| Business Rule | BR05/BR06 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Permission change áp dụng sau reload; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC036

| Field | Value |
|---|---|
| Test Case | Permission change áp dụng trên phiên member đang mở |
| ID | G026_TC036 |
| Purpose | Xác minh permission change áp dụng trên phiên member đang mở |
| Category | Sync |
| Priority | High |
| Requirement | G026 |
| Use Case | UC-05 |
| Business Rule | BR06 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Permission change áp dụng trên phiên member đang mở; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC037

| Field | Value |
|---|---|
| Test Case | DISCONNECTED không đổi được toggle Làm nổi |
| ID | G026_TC037 |
| Purpose | Xác minh disconnected không đổi được toggle làm nổi |
| Category | Exception |
| Priority | Critical |
| Requirement | G026 |
| Use Case | UC-02 |
| Business Rule | BR07/E02 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: DISCONNECTED không đổi được toggle Làm nổi; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC038

| Field | Value |
|---|---|
| Test Case | DISCONNECTED không đổi được toggle lịch sử gần đây |
| ID | G026_TC038 |
| Purpose | Xác minh disconnected không đổi được toggle lịch sử gần đây |
| Category | Exception |
| Priority | Critical |
| Requirement | G026 |
| Use Case | UC-03 |
| Business Rule | BR07/E02 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: DISCONNECTED không đổi được toggle lịch sử gần đây; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC039

| Field | Value |
|---|---|
| Test Case | DISCONNECTED không đổi được Duyệt thành viên |
| ID | G026_TC039 |
| Purpose | Xác minh disconnected không đổi được duyệt thành viên |
| Category | Exception |
| Priority | Critical |
| Requirement | G026 |
| Use Case | UC-04 |
| Business Rule | BR07/E02 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: DISCONNECTED không đổi được Duyệt thành viên; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC040

| Field | Value |
|---|---|
| Test Case | DISCONNECTED không đổi được quyền thành viên |
| ID | G026_TC040 |
| Purpose | Xác minh disconnected không đổi được quyền thành viên |
| Category | Exception |
| Priority | Critical |
| Requirement | G026 |
| Use Case | UC-05 |
| Business Rule | BR07/E02 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: DISCONNECTED không đổi được quyền thành viên; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC041

| Field | Value |
|---|---|
| Test Case | Lưu lỗi rollback toggle về trạng thái trước |
| ID | G026_TC041 |
| Purpose | Xác minh lưu lỗi rollback toggle về trạng thái trước |
| Category | Recovery |
| Priority | Critical |
| Requirement | G026 |
| Use Case | UC-02/03/04/05 |
| Business Rule | E02 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Lưu lỗi rollback toggle về trạng thái trước; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC042

| Field | Value |
|---|---|
| Test Case | Lưu lỗi permission rollback lựa chọn trước |
| ID | G026_TC042 |
| Purpose | Xác minh lưu lỗi permission rollback lựa chọn trước |
| Category | Recovery |
| Priority | Critical |
| Requirement | G026 |
| Use Case | UC-05 |
| Business Rule | E02 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Lưu lỗi permission rollback lựa chọn trước; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC043

| Field | Value |
|---|---|
| Test Case | Member thường mở màn vẫn thấy đúng trạng thái hiện tại |
| ID | G026_TC043 |
| Purpose | Xác minh member thường mở màn vẫn thấy đúng trạng thái hiện tại |
| Category | Functional |
| Priority | High |
| Requirement | G026 |
| Use Case | UC-01 |
| Business Rule | BR02 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Member thường mở màn vẫn thấy đúng trạng thái hiện tại; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC044

| Field | Value |
|---|---|
| Test Case | Quản lý thành viên điều hướng đúng G008 |
| ID | G026_TC044 |
| Purpose | Xác minh quản lý thành viên điều hướng đúng g008 |
| Category | Regression |
| Priority | High |
| Requirement | G026 |
| Use Case | UC-01 |
| Business Rule | Dependency |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Quản lý thành viên điều hướng đúng G008; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC045

| Field | Value |
|---|---|
| Test Case | Thay trưởng nhóm thì quyền chỉnh chuyển sang trưởng mới |
| ID | G026_TC045 |
| Purpose | Xác minh thay trưởng nhóm thì quyền chỉnh chuyển sang trưởng mới |
| Category | State Transition |
| Priority | Critical |
| Requirement | G026 |
| Use Case | UC-01 |
| Business Rule | BR02 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Thay trưởng nhóm thì quyền chỉnh chuyển sang trưởng mới; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC046

| Field | Value |
|---|---|
| Test Case | Trưởng cũ sau chuyển quyền không còn chỉnh được |
| ID | G026_TC046 |
| Purpose | Xác minh trưởng cũ sau chuyển quyền không còn chỉnh được |
| Category | Security |
| Priority | Critical |
| Requirement | G026 |
| Use Case | UC-01 |
| Business Rule | BR02 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Trưởng cũ sau chuyển quyền không còn chỉnh được; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC047

| Field | Value |
|---|---|
| Test Case | Hai request chờ được duyệt độc lập không lẫn trạng thái |
| ID | G026_TC047 |
| Purpose | Xác minh hai request chờ được duyệt độc lập không lẫn trạng thái |
| Category | Concurrency |
| Priority | High |
| Requirement | G026 |
| Use Case | UC-06 |
| Business Rule | BR08 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Hai request chờ được duyệt độc lập không lẫn trạng thái; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC048

| Field | Value |
|---|---|
| Test Case | Duyệt cùng một request từ hai phiên không tạo member trùng |
| ID | G026_TC048 |
| Purpose | Xác minh duyệt cùng một request từ hai phiên không tạo member trùng |
| Category | Concurrency |
| Priority | Critical |
| Requirement | G026 |
| Use Case | UC-06 |
| Business Rule | BR08 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Duyệt cùng một request từ hai phiên không tạo member trùng; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC049

| Field | Value |
|---|---|
| Test Case | Badge chờ giảm đúng sau duyệt |
| ID | G026_TC049 |
| Purpose | Xác minh badge chờ giảm đúng sau duyệt |
| Category | State Transition |
| Priority | High |
| Requirement | G026 |
| Use Case | UC-06 |
| Business Rule | BR08 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Badge chờ giảm đúng sau duyệt; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC050

| Field | Value |
|---|---|
| Test Case | Badge chờ giảm đúng sau từ chối |
| ID | G026_TC050 |
| Purpose | Xác minh badge chờ giảm đúng sau từ chối |
| Category | State Transition |
| Priority | High |
| Requirement | G026 |
| Use Case | UC-06 |
| Business Rule | BR08 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Badge chờ giảm đúng sau từ chối; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC051

| Field | Value |
|---|---|
| Test Case | Cài đặt nhóm chỉ áp dụng cho hội thoại nhóm |
| ID | G026_TC051 |
| Purpose | Xác minh cài đặt nhóm chỉ áp dụng cho hội thoại nhóm |
| Category | Negative |
| Priority | High |
| Requirement | G026 |
| Use Case | UC-01 |
| Business Rule | Scope |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Cài đặt nhóm chỉ áp dụng cho hội thoại nhóm; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC052

| Field | Value |
|---|---|
| Test Case | Không phải trưởng nhóm nhưng có quyền xem vẫn không chỉnh được |
| ID | G026_TC052 |
| Purpose | Xác minh không phải trưởng nhóm nhưng có quyền xem vẫn không chỉnh được |
| Category | Permission |
| Priority | Critical |
| Requirement | G026 |
| Use Case | UC-01 |
| Business Rule | BR02 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Không phải trưởng nhóm nhưng có quyền xem vẫn không chỉnh được; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC053

| Field | Value |
|---|---|
| Test Case | Member mới sau khi setting quyền thay đổi nhận đúng gate hiện tại |
| ID | G026_TC053 |
| Purpose | Xác minh member mới sau khi setting quyền thay đổi nhận đúng gate hiện tại |
| Category | Regression |
| Priority | High |
| Requirement | G026 |
| Use Case | UC-05 |
| Business Rule | BR06 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Member mới sau khi setting quyền thay đổi nhận đúng gate hiện tại; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC054

| Field | Value |
|---|---|
| Test Case | Các setting đọc/ghi qua đúng tài khoản Zalo của nhóm |
| ID | G026_TC054 |
| Purpose | Xác minh các setting đọc/ghi qua đúng tài khoản zalo của nhóm |
| Category | Integration |
| Priority | Critical |
| Requirement | G026 |
| Use Case | UC-02/03/04/05 |
| Business Rule | BR07 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Các setting đọc/ghi qua đúng tài khoản Zalo của nhóm; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G026_TC055

| Field | Value |
|---|---|
| Test Case | Không hiển thị quyền cấu hình theo từng member riêng lẻ |
| ID | G026_TC055 |
| Purpose | Xác minh không hiển thị quyền cấu hình theo từng member riêng lẻ |
| Category | Negative |
| Priority | Medium |
| Requirement | G026 |
| Use Case | UC-05 |
| Business Rule | OOS02 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Không hiển thị quyền cấu hình theo từng member riêng lẻ; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
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
| 1.0 | 2026-08-22 | Tạo testcase riêng cho requirement G026 |
