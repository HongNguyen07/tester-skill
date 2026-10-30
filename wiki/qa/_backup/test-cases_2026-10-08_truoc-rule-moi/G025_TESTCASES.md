# [G025] — Bình chọn (trong nhóm) — TESTCASES

## 1. Requirement Information

| Item | Value |
|---|---|
| Feature ID | G025 |
| Feature Name | Bình chọn (trong nhóm) |
| Source | G025 - Bình chọn.md |
| Total Test Cases | 50 |
| Documentation Standard | QA Specification v1.1 |

## 2. Requirement Analysis

- Requirement chính thức: Poll chỉ trong nhóm, Zalo-native, quyền tạo theo G026, kết quả không ẩn danh, có multi-vote/add option/pin/deadline/hide-result.
- Coverage QA bổ sung: boundary số phương án, concurrency vote, event ordering, permission change trong lúc thao tác, cross-device consistency.
- Không đưa ẩn danh vào scope vì OOS01 đã loại rõ.

## 3. Use Cases

UC-01, UC-02, UC-03, UC-04, UC-05

## 4. Business Rules

BR01, BR02, BR03, BR04, BR05, BR06, BR07, BR08, BR09, BR10

## 5. Decision Table

| D | Loại chat | Quyền tạo | Trạng thái Zalo | Expected |
|---|---|---|---|---|
| D01 | 1:1 | Any | Connected | Không có poll |
| D02 | Group | Tất cả | Connected | Member tạo được |
| D03 | Group | Chỉ trưởng | Connected | Chỉ trưởng tạo |
| D04 | Group | Any | Disconnected | Không thao tác |

## 6. State Transition

| From | Event | To |
|---|---|---|
| Chưa có | Tạo | Đang mở |
| Đang mở | Vote/Thêm option | Đang mở |
| Đang mở | Kết thúc | Đã đóng |
| Đang mở | Đến deadline | Đã đóng |

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
| G025 | UC-01, UC-02, UC-03, UC-04, UC-05 | BR01, BR02, BR03, BR04, BR05, BR06, BR07, BR08, BR09, BR10 | G025_TC001 → G025_TC050 | Covered |

## 9. Testcase Summary

| ID | Test Case | Category | Priority | Use Case | Business Rule | Status |
|---|---|---|---|---|---|---|
| G025_TC001 | Entry Bình chọn chỉ hiển thị trong nhóm | Functional | Critical | UC-01 | BR01 | Not Run |
| G025_TC002 | Chat 1:1 không hiển thị Tạo bình chọn | Negative | Critical | UC-01 | BR01/E01 | Not Run |
| G025_TC003 | Màn Bình chọn hiển thị danh sách poll và nút Tạo | Functional | High | UC-01 | BR01 | Not Run |
| G025_TC004 | Quyền tạo = Tất cả mọi người thì member tạo được | Permission | Critical | UC-01 | BR02 | Not Run |
| G025_TC005 | Quyền tạo = Chỉ trưởng nhóm thì member không tạo được | Permission | Critical | UC-01 | BR02 | Not Run |
| G025_TC006 | Quyền tạo = Chỉ trưởng nhóm thì trưởng nhóm tạo được | Permission | Critical | UC-01 | BR02 | Not Run |
| G025_TC007 | Form tạo hiển thị đủ các tùy chọn | UI/UX | High | UC-01 | BR03 | Not Run |
| G025_TC008 | Không hiển thị toggle Ẩn người bình chọn | Negative | High | UC-01 | BR04/OOS01 | Not Run |
| G025_TC009 | Câu hỏi trống không tạo được poll | Negative | Critical | UC-01 | E02 | Not Run |
| G025_TC010 | Chỉ 1 phương án không tạo được poll | Boundary | Critical | UC-01 | E02 | Not Run |
| G025_TC011 | 2 phương án hợp lệ tạo poll thành công | Boundary | Critical | UC-01 | E02 | Not Run |
| G025_TC012 | Phương án trống hiển thị lỗi inline | Negative | Critical | UC-01 | E04 | Not Run |
| G025_TC013 | Huỷ form tạo không phát sinh poll | Functional | High | UC-01 | AF01 | Not Run |
| G025_TC014 | Tạo poll thành công gửi card vào nhóm | Functional | Critical | UC-01 | BR07 | Not Run |
| G025_TC015 | Poll hiển thị cho khách trên Zalo | Sync | Critical | UC-01 | BR07 | Not Run |
| G025_TC016 | Tùy chọn Ghim mặc định tắt | Functional | Medium | UC-01 | BR08 | Not Run |
| G025_TC017 | Bật Ghim khi tạo làm card được ghim | Integration | Critical | UC-01 | BR08 | Not Run |
| G025_TC018 | Deadline mặc định Không có thời hạn | Functional | Medium | UC-01 | BR09 | Not Run |
| G025_TC019 | Đặt deadline tương lai tạo poll mở | Functional | High | UC-01 | BR09 | Not Run |
| G025_TC020 | Đến deadline poll tự đóng | State Transition | Critical | UC-05 | BR09 | Not Run |
| G025_TC021 | Đã đóng do deadline vẫn hiển thị kết quả | Functional | High | UC-05 | BR09 | Not Run |
| G025_TC022 | Single-vote chỉ chọn 1 phương án | Functional | Critical | UC-02 | BR06 | Not Run |
| G025_TC023 | Single-vote đổi lựa chọn trước khi đóng | Functional | High | UC-02 | BR06 | Not Run |
| G025_TC024 | Single-vote bỏ phiếu trước khi đóng | Functional | High | UC-02 | BR06 | Not Run |
| G025_TC025 | Multi-vote chọn nhiều phương án | Functional | Critical | UC-02 | BR03/BR06 | Not Run |
| G025_TC026 | Multi-vote bỏ tick từng phương án | Functional | High | UC-02 | BR06 | Not Run |
| G025_TC027 | Vote cập nhật số phiếu | Functional | Critical | UC-02 | BR04 | Not Run |
| G025_TC028 | Vote hiển thị avatar/tên người chọn | Functional | Critical | UC-02 | BR04 | Not Run |
| G025_TC029 | Bộ đếm N người đã bình chọn chính xác | Functional | High | UC-04 | BR04 | Not Run |
| G025_TC030 | Click bộ đếm xem chi tiết ai chọn gì | Functional | High | UC-04 | BR04 | Not Run |
| G025_TC031 | Hide result bật: member chưa vote không thấy kết quả | Permission | Critical | UC-04 | BR10 | Not Run |
| G025_TC032 | Hide result bật: member vote xong thấy kết quả | State Transition | Critical | UC-04 | BR10 | Not Run |
| G025_TC033 | Hide result bật: người tạo luôn xem được | Permission | High | UC-04 | BR10 | Not Run |
| G025_TC034 | Hide result bật: trưởng nhóm luôn xem được | Permission | High | UC-04 | BR10 | Not Run |
| G025_TC035 | Cho phép thành viên thêm phương án bật thì member thêm được | Functional | Critical | UC-03 | BR03 | Not Run |
| G025_TC036 | Không bật quyền thêm phương án thì member không thấy action | Negative | High | UC-03 | BR03 | Not Run |
| G025_TC037 | Thêm phương án trống bị chặn | Negative | Critical | UC-03 | E04 | Not Run |
| G025_TC038 | Phương án mới hiển thị cho cả nhóm | Sync | High | UC-03 | BR03 | Not Run |
| G025_TC039 | Người tạo kết thúc poll được | Permission | Critical | UC-05 | BR05 | Not Run |
| G025_TC040 | Trưởng nhóm kết thúc poll được | Permission | Critical | UC-05 | BR05 | Not Run |
| G025_TC041 | Member khác không kết thúc poll được | Security | Critical | UC-05 | BR05/E03 | Not Run |
| G025_TC042 | Huỷ confirm kết thúc giữ poll đang mở | Functional | High | UC-05 | AF01 | Not Run |
| G025_TC043 | Sau đóng không vote được | State Transition | Critical | UC-05 | BR05 | Not Run |
| G025_TC044 | Sau đóng không thêm phương án được | State Transition | Critical | UC-05 | BR05 | Not Run |
| G025_TC045 | Sau đóng kết quả chốt không đổi | Functional | Critical | UC-05 | BR05 | Not Run |
| G025_TC046 | DISCONNECTED không tạo được poll | Exception | Critical | UC-01 | BR07/E05 | Not Run |
| G025_TC047 | DISCONNECTED không vote được | Exception | Critical | UC-02 | BR07/E05 | Not Run |
| G025_TC048 | DISCONNECTED không đóng được poll | Exception | Critical | UC-05 | BR07/E05 | Not Run |
| G025_TC049 | Hai member vote gần đồng thời không mất phiếu | Concurrency | Critical | UC-02 | QA | Not Run |
| G025_TC050 | Poll giữ nhất quán giữa Gopany và Zalo sau vote/close | Sync | Critical | UC-02/05 | BR07 | Not Run |

## 10. Testcase Detail

### G025_TC001

| Field | Value |
|---|---|
| Test Case | Entry Bình chọn chỉ hiển thị trong nhóm |
| ID | G025_TC001 |
| Purpose | Xác minh entry bình chọn chỉ hiển thị trong nhóm |
| Category | Functional |
| Priority | Critical |
| Requirement | G025 |
| Use Case | UC-01 |
| Business Rule | BR01 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Entry Bình chọn chỉ hiển thị trong nhóm; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC002

| Field | Value |
|---|---|
| Test Case | Chat 1:1 không hiển thị Tạo bình chọn |
| ID | G025_TC002 |
| Purpose | Xác minh chat 1:1 không hiển thị tạo bình chọn |
| Category | Negative |
| Priority | Critical |
| Requirement | G025 |
| Use Case | UC-01 |
| Business Rule | BR01/E01 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Chat 1:1 không hiển thị Tạo bình chọn; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC003

| Field | Value |
|---|---|
| Test Case | Màn Bình chọn hiển thị danh sách poll và nút Tạo |
| ID | G025_TC003 |
| Purpose | Xác minh màn bình chọn hiển thị danh sách poll và nút tạo |
| Category | Functional |
| Priority | High |
| Requirement | G025 |
| Use Case | UC-01 |
| Business Rule | BR01 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Màn Bình chọn hiển thị danh sách poll và nút Tạo; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC004

| Field | Value |
|---|---|
| Test Case | Quyền tạo = Tất cả mọi người thì member tạo được |
| ID | G025_TC004 |
| Purpose | Xác minh quyền tạo = tất cả mọi người thì member tạo được |
| Category | Permission |
| Priority | Critical |
| Requirement | G025 |
| Use Case | UC-01 |
| Business Rule | BR02 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Quyền tạo = Tất cả mọi người thì member tạo được; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC005

| Field | Value |
|---|---|
| Test Case | Quyền tạo = Chỉ trưởng nhóm thì member không tạo được |
| ID | G025_TC005 |
| Purpose | Xác minh quyền tạo = chỉ trưởng nhóm thì member không tạo được |
| Category | Permission |
| Priority | Critical |
| Requirement | G025 |
| Use Case | UC-01 |
| Business Rule | BR02 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Quyền tạo = Chỉ trưởng nhóm thì member không tạo được; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC006

| Field | Value |
|---|---|
| Test Case | Quyền tạo = Chỉ trưởng nhóm thì trưởng nhóm tạo được |
| ID | G025_TC006 |
| Purpose | Xác minh quyền tạo = chỉ trưởng nhóm thì trưởng nhóm tạo được |
| Category | Permission |
| Priority | Critical |
| Requirement | G025 |
| Use Case | UC-01 |
| Business Rule | BR02 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Quyền tạo = Chỉ trưởng nhóm thì trưởng nhóm tạo được; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC007

| Field | Value |
|---|---|
| Test Case | Form tạo hiển thị đủ các tùy chọn |
| ID | G025_TC007 |
| Purpose | Xác minh form tạo hiển thị đủ các tùy chọn |
| Category | UI/UX |
| Priority | High |
| Requirement | G025 |
| Use Case | UC-01 |
| Business Rule | BR03 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Form tạo hiển thị đủ các tùy chọn; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC008

| Field | Value |
|---|---|
| Test Case | Không hiển thị toggle Ẩn người bình chọn |
| ID | G025_TC008 |
| Purpose | Xác minh không hiển thị toggle ẩn người bình chọn |
| Category | Negative |
| Priority | High |
| Requirement | G025 |
| Use Case | UC-01 |
| Business Rule | BR04/OOS01 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Không hiển thị toggle Ẩn người bình chọn; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC009

| Field | Value |
|---|---|
| Test Case | Câu hỏi trống không tạo được poll |
| ID | G025_TC009 |
| Purpose | Xác minh câu hỏi trống không tạo được poll |
| Category | Negative |
| Priority | Critical |
| Requirement | G025 |
| Use Case | UC-01 |
| Business Rule | E02 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Câu hỏi trống không tạo được poll; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC010

| Field | Value |
|---|---|
| Test Case | Chỉ 1 phương án không tạo được poll |
| ID | G025_TC010 |
| Purpose | Xác minh chỉ 1 phương án không tạo được poll |
| Category | Boundary |
| Priority | Critical |
| Requirement | G025 |
| Use Case | UC-01 |
| Business Rule | E02 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Chỉ 1 phương án không tạo được poll; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC011

| Field | Value |
|---|---|
| Test Case | 2 phương án hợp lệ tạo poll thành công |
| ID | G025_TC011 |
| Purpose | Xác minh 2 phương án hợp lệ tạo poll thành công |
| Category | Boundary |
| Priority | Critical |
| Requirement | G025 |
| Use Case | UC-01 |
| Business Rule | E02 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: 2 phương án hợp lệ tạo poll thành công; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC012

| Field | Value |
|---|---|
| Test Case | Phương án trống hiển thị lỗi inline |
| ID | G025_TC012 |
| Purpose | Xác minh phương án trống hiển thị lỗi inline |
| Category | Negative |
| Priority | Critical |
| Requirement | G025 |
| Use Case | UC-01 |
| Business Rule | E04 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Phương án trống hiển thị lỗi inline; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC013

| Field | Value |
|---|---|
| Test Case | Huỷ form tạo không phát sinh poll |
| ID | G025_TC013 |
| Purpose | Xác minh huỷ form tạo không phát sinh poll |
| Category | Functional |
| Priority | High |
| Requirement | G025 |
| Use Case | UC-01 |
| Business Rule | AF01 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Huỷ form tạo không phát sinh poll; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC014

| Field | Value |
|---|---|
| Test Case | Tạo poll thành công gửi card vào nhóm |
| ID | G025_TC014 |
| Purpose | Xác minh tạo poll thành công gửi card vào nhóm |
| Category | Functional |
| Priority | Critical |
| Requirement | G025 |
| Use Case | UC-01 |
| Business Rule | BR07 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Tạo poll thành công gửi card vào nhóm; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC015

| Field | Value |
|---|---|
| Test Case | Poll hiển thị cho khách trên Zalo |
| ID | G025_TC015 |
| Purpose | Xác minh poll hiển thị cho khách trên zalo |
| Category | Sync |
| Priority | Critical |
| Requirement | G025 |
| Use Case | UC-01 |
| Business Rule | BR07 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Poll hiển thị cho khách trên Zalo; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC016

| Field | Value |
|---|---|
| Test Case | Tùy chọn Ghim mặc định tắt |
| ID | G025_TC016 |
| Purpose | Xác minh tùy chọn ghim mặc định tắt |
| Category | Functional |
| Priority | Medium |
| Requirement | G025 |
| Use Case | UC-01 |
| Business Rule | BR08 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Tùy chọn Ghim mặc định tắt; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC017

| Field | Value |
|---|---|
| Test Case | Bật Ghim khi tạo làm card được ghim |
| ID | G025_TC017 |
| Purpose | Xác minh bật ghim khi tạo làm card được ghim |
| Category | Integration |
| Priority | Critical |
| Requirement | G025 |
| Use Case | UC-01 |
| Business Rule | BR08 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Bật Ghim khi tạo làm card được ghim; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC018

| Field | Value |
|---|---|
| Test Case | Deadline mặc định Không có thời hạn |
| ID | G025_TC018 |
| Purpose | Xác minh deadline mặc định không có thời hạn |
| Category | Functional |
| Priority | Medium |
| Requirement | G025 |
| Use Case | UC-01 |
| Business Rule | BR09 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Deadline mặc định Không có thời hạn; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC019

| Field | Value |
|---|---|
| Test Case | Đặt deadline tương lai tạo poll mở |
| ID | G025_TC019 |
| Purpose | Xác minh đặt deadline tương lai tạo poll mở |
| Category | Functional |
| Priority | High |
| Requirement | G025 |
| Use Case | UC-01 |
| Business Rule | BR09 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Đặt deadline tương lai tạo poll mở; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC020

| Field | Value |
|---|---|
| Test Case | Đến deadline poll tự đóng |
| ID | G025_TC020 |
| Purpose | Xác minh đến deadline poll tự đóng |
| Category | State Transition |
| Priority | Critical |
| Requirement | G025 |
| Use Case | UC-05 |
| Business Rule | BR09 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Đến deadline poll tự đóng; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC021

| Field | Value |
|---|---|
| Test Case | Đã đóng do deadline vẫn hiển thị kết quả |
| ID | G025_TC021 |
| Purpose | Xác minh đã đóng do deadline vẫn hiển thị kết quả |
| Category | Functional |
| Priority | High |
| Requirement | G025 |
| Use Case | UC-05 |
| Business Rule | BR09 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Đã đóng do deadline vẫn hiển thị kết quả; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC022

| Field | Value |
|---|---|
| Test Case | Single-vote chỉ chọn 1 phương án |
| ID | G025_TC022 |
| Purpose | Xác minh single-vote chỉ chọn 1 phương án |
| Category | Functional |
| Priority | Critical |
| Requirement | G025 |
| Use Case | UC-02 |
| Business Rule | BR06 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Single-vote chỉ chọn 1 phương án; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC023

| Field | Value |
|---|---|
| Test Case | Single-vote đổi lựa chọn trước khi đóng |
| ID | G025_TC023 |
| Purpose | Xác minh single-vote đổi lựa chọn trước khi đóng |
| Category | Functional |
| Priority | High |
| Requirement | G025 |
| Use Case | UC-02 |
| Business Rule | BR06 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Single-vote đổi lựa chọn trước khi đóng; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC024

| Field | Value |
|---|---|
| Test Case | Single-vote bỏ phiếu trước khi đóng |
| ID | G025_TC024 |
| Purpose | Xác minh single-vote bỏ phiếu trước khi đóng |
| Category | Functional |
| Priority | High |
| Requirement | G025 |
| Use Case | UC-02 |
| Business Rule | BR06 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Single-vote bỏ phiếu trước khi đóng; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC025

| Field | Value |
|---|---|
| Test Case | Multi-vote chọn nhiều phương án |
| ID | G025_TC025 |
| Purpose | Xác minh multi-vote chọn nhiều phương án |
| Category | Functional |
| Priority | Critical |
| Requirement | G025 |
| Use Case | UC-02 |
| Business Rule | BR03/BR06 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Multi-vote chọn nhiều phương án; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC026

| Field | Value |
|---|---|
| Test Case | Multi-vote bỏ tick từng phương án |
| ID | G025_TC026 |
| Purpose | Xác minh multi-vote bỏ tick từng phương án |
| Category | Functional |
| Priority | High |
| Requirement | G025 |
| Use Case | UC-02 |
| Business Rule | BR06 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Multi-vote bỏ tick từng phương án; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC027

| Field | Value |
|---|---|
| Test Case | Vote cập nhật số phiếu |
| ID | G025_TC027 |
| Purpose | Xác minh vote cập nhật số phiếu |
| Category | Functional |
| Priority | Critical |
| Requirement | G025 |
| Use Case | UC-02 |
| Business Rule | BR04 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Vote cập nhật số phiếu; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC028

| Field | Value |
|---|---|
| Test Case | Vote hiển thị avatar/tên người chọn |
| ID | G025_TC028 |
| Purpose | Xác minh vote hiển thị avatar/tên người chọn |
| Category | Functional |
| Priority | Critical |
| Requirement | G025 |
| Use Case | UC-02 |
| Business Rule | BR04 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Vote hiển thị avatar/tên người chọn; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC029

| Field | Value |
|---|---|
| Test Case | Bộ đếm N người đã bình chọn chính xác |
| ID | G025_TC029 |
| Purpose | Xác minh bộ đếm n người đã bình chọn chính xác |
| Category | Functional |
| Priority | High |
| Requirement | G025 |
| Use Case | UC-04 |
| Business Rule | BR04 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Bộ đếm N người đã bình chọn chính xác; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC030

| Field | Value |
|---|---|
| Test Case | Click bộ đếm xem chi tiết ai chọn gì |
| ID | G025_TC030 |
| Purpose | Xác minh click bộ đếm xem chi tiết ai chọn gì |
| Category | Functional |
| Priority | High |
| Requirement | G025 |
| Use Case | UC-04 |
| Business Rule | BR04 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Click bộ đếm xem chi tiết ai chọn gì; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC031

| Field | Value |
|---|---|
| Test Case | Hide result bật: member chưa vote không thấy kết quả |
| ID | G025_TC031 |
| Purpose | Xác minh hide result bật: member chưa vote không thấy kết quả |
| Category | Permission |
| Priority | Critical |
| Requirement | G025 |
| Use Case | UC-04 |
| Business Rule | BR10 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Hide result bật: member chưa vote không thấy kết quả; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC032

| Field | Value |
|---|---|
| Test Case | Hide result bật: member vote xong thấy kết quả |
| ID | G025_TC032 |
| Purpose | Xác minh hide result bật: member vote xong thấy kết quả |
| Category | State Transition |
| Priority | Critical |
| Requirement | G025 |
| Use Case | UC-04 |
| Business Rule | BR10 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Hide result bật: member vote xong thấy kết quả; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC033

| Field | Value |
|---|---|
| Test Case | Hide result bật: người tạo luôn xem được |
| ID | G025_TC033 |
| Purpose | Xác minh hide result bật: người tạo luôn xem được |
| Category | Permission |
| Priority | High |
| Requirement | G025 |
| Use Case | UC-04 |
| Business Rule | BR10 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Hide result bật: người tạo luôn xem được; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC034

| Field | Value |
|---|---|
| Test Case | Hide result bật: trưởng nhóm luôn xem được |
| ID | G025_TC034 |
| Purpose | Xác minh hide result bật: trưởng nhóm luôn xem được |
| Category | Permission |
| Priority | High |
| Requirement | G025 |
| Use Case | UC-04 |
| Business Rule | BR10 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Hide result bật: trưởng nhóm luôn xem được; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC035

| Field | Value |
|---|---|
| Test Case | Cho phép thành viên thêm phương án bật thì member thêm được |
| ID | G025_TC035 |
| Purpose | Xác minh cho phép thành viên thêm phương án bật thì member thêm được |
| Category | Functional |
| Priority | Critical |
| Requirement | G025 |
| Use Case | UC-03 |
| Business Rule | BR03 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Cho phép thành viên thêm phương án bật thì member thêm được; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC036

| Field | Value |
|---|---|
| Test Case | Không bật quyền thêm phương án thì member không thấy action |
| ID | G025_TC036 |
| Purpose | Xác minh không bật quyền thêm phương án thì member không thấy action |
| Category | Negative |
| Priority | High |
| Requirement | G025 |
| Use Case | UC-03 |
| Business Rule | BR03 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Không bật quyền thêm phương án thì member không thấy action; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC037

| Field | Value |
|---|---|
| Test Case | Thêm phương án trống bị chặn |
| ID | G025_TC037 |
| Purpose | Xác minh thêm phương án trống bị chặn |
| Category | Negative |
| Priority | Critical |
| Requirement | G025 |
| Use Case | UC-03 |
| Business Rule | E04 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Thêm phương án trống bị chặn; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC038

| Field | Value |
|---|---|
| Test Case | Phương án mới hiển thị cho cả nhóm |
| ID | G025_TC038 |
| Purpose | Xác minh phương án mới hiển thị cho cả nhóm |
| Category | Sync |
| Priority | High |
| Requirement | G025 |
| Use Case | UC-03 |
| Business Rule | BR03 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Phương án mới hiển thị cho cả nhóm; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC039

| Field | Value |
|---|---|
| Test Case | Người tạo kết thúc poll được |
| ID | G025_TC039 |
| Purpose | Xác minh người tạo kết thúc poll được |
| Category | Permission |
| Priority | Critical |
| Requirement | G025 |
| Use Case | UC-05 |
| Business Rule | BR05 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Người tạo kết thúc poll được; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC040

| Field | Value |
|---|---|
| Test Case | Trưởng nhóm kết thúc poll được |
| ID | G025_TC040 |
| Purpose | Xác minh trưởng nhóm kết thúc poll được |
| Category | Permission |
| Priority | Critical |
| Requirement | G025 |
| Use Case | UC-05 |
| Business Rule | BR05 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Trưởng nhóm kết thúc poll được; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC041

| Field | Value |
|---|---|
| Test Case | Member khác không kết thúc poll được |
| ID | G025_TC041 |
| Purpose | Xác minh member khác không kết thúc poll được |
| Category | Security |
| Priority | Critical |
| Requirement | G025 |
| Use Case | UC-05 |
| Business Rule | BR05/E03 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Member khác không kết thúc poll được; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC042

| Field | Value |
|---|---|
| Test Case | Huỷ confirm kết thúc giữ poll đang mở |
| ID | G025_TC042 |
| Purpose | Xác minh huỷ confirm kết thúc giữ poll đang mở |
| Category | Functional |
| Priority | High |
| Requirement | G025 |
| Use Case | UC-05 |
| Business Rule | AF01 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Huỷ confirm kết thúc giữ poll đang mở; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC043

| Field | Value |
|---|---|
| Test Case | Sau đóng không vote được |
| ID | G025_TC043 |
| Purpose | Xác minh sau đóng không vote được |
| Category | State Transition |
| Priority | Critical |
| Requirement | G025 |
| Use Case | UC-05 |
| Business Rule | BR05 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Sau đóng không vote được; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC044

| Field | Value |
|---|---|
| Test Case | Sau đóng không thêm phương án được |
| ID | G025_TC044 |
| Purpose | Xác minh sau đóng không thêm phương án được |
| Category | State Transition |
| Priority | Critical |
| Requirement | G025 |
| Use Case | UC-05 |
| Business Rule | BR05 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Sau đóng không thêm phương án được; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC045

| Field | Value |
|---|---|
| Test Case | Sau đóng kết quả chốt không đổi |
| ID | G025_TC045 |
| Purpose | Xác minh sau đóng kết quả chốt không đổi |
| Category | Functional |
| Priority | Critical |
| Requirement | G025 |
| Use Case | UC-05 |
| Business Rule | BR05 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Sau đóng kết quả chốt không đổi; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC046

| Field | Value |
|---|---|
| Test Case | DISCONNECTED không tạo được poll |
| ID | G025_TC046 |
| Purpose | Xác minh disconnected không tạo được poll |
| Category | Exception |
| Priority | Critical |
| Requirement | G025 |
| Use Case | UC-01 |
| Business Rule | BR07/E05 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: DISCONNECTED không tạo được poll; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC047

| Field | Value |
|---|---|
| Test Case | DISCONNECTED không vote được |
| ID | G025_TC047 |
| Purpose | Xác minh disconnected không vote được |
| Category | Exception |
| Priority | Critical |
| Requirement | G025 |
| Use Case | UC-02 |
| Business Rule | BR07/E05 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: DISCONNECTED không vote được; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC048

| Field | Value |
|---|---|
| Test Case | DISCONNECTED không đóng được poll |
| ID | G025_TC048 |
| Purpose | Xác minh disconnected không đóng được poll |
| Category | Exception |
| Priority | Critical |
| Requirement | G025 |
| Use Case | UC-05 |
| Business Rule | BR07/E05 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: DISCONNECTED không đóng được poll; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC049

| Field | Value |
|---|---|
| Test Case | Hai member vote gần đồng thời không mất phiếu |
| ID | G025_TC049 |
| Purpose | Xác minh hai member vote gần đồng thời không mất phiếu |
| Category | Concurrency |
| Priority | Critical |
| Requirement | G025 |
| Use Case | UC-02 |
| Business Rule | QA |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Hai member vote gần đồng thời không mất phiếu; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G025_TC050

| Field | Value |
|---|---|
| Test Case | Poll giữ nhất quán giữa Gopany và Zalo sau vote/close |
| ID | G025_TC050 |
| Purpose | Xác minh poll giữ nhất quán giữa gopany và zalo sau vote/close |
| Category | Sync |
| Priority | Critical |
| Requirement | G025 |
| Use Case | UC-02/05 |
| Business Rule | BR07 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Poll giữ nhất quán giữa Gopany và Zalo sau vote/close; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
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
| 1.0 | 2026-08-22 | Tạo testcase riêng cho requirement G025 |
