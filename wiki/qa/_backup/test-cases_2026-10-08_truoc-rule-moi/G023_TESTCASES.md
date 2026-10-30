# [G023] — Gửi danh thiếp & Sticker — TESTCASES

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

## 9. Testcase Summary

| ID | Test Case | Category | Priority | Use Case | Business Rule | Status |
|---|---|---|---|---|---|---|
| G023_TC001 | Mở picker danh thiếp từ toolbar | Functional | Critical | UC-01 | BR01 | Not Run |
| G023_TC002 | Picker danh thiếp chỉ hiển thị bạn bè của đúng tài khoản Zalo đang chat | Functional | Critical | UC-01 | BR01/BR03 | Not Run |
| G023_TC003 | Picker danh thiếp không có mục Gần đây | Negative | High | UC-01 | BR01 | Not Run |
| G023_TC004 | Tìm liên hệ theo tên chính xác | Functional | High | UC-01 | BR01 | Not Run |
| G023_TC005 | Tìm liên hệ theo một phần tên | Functional | Medium | UC-01 | BR01 | Not Run |
| G023_TC006 | Tìm liên hệ theo SĐT | Functional | High | UC-01 | BR01 | Not Run |
| G023_TC007 | Tìm không có kết quả hiển thị trạng thái phù hợp | Negative | Medium | UC-01 | BR01 | Not Run |
| G023_TC008 | Danh bạ trống hiển thị 'Chưa có liên hệ' | Exception | High | UC-01 | E01 | Not Run |
| G023_TC009 | Chưa chọn liên hệ thì không gửi được | Negative | High | UC-01 | BR01b | Not Run |
| G023_TC010 | Chọn 1 danh thiếp và gửi thành công | Functional | Critical | UC-01 | BR01b | Not Run |
| G023_TC011 | Chọn 9 danh thiếp và gửi thành công | Boundary | Critical | UC-01 | BR01b | Not Run |
| G023_TC012 | Chọn liên hệ thứ 10 bị chặn | Boundary | Critical | UC-01 | E04 | Not Run |
| G023_TC013 | Bộ đếm Đã chọn cập nhật đúng khi chọn/bỏ chọn | Functional | High | UC-01 | BR01b | Not Run |
| G023_TC014 | Toggle gửi kèm SĐT bật áp dụng cho cả lô | Functional | Critical | UC-01 | BR01c | Not Run |
| G023_TC015 | Toggle gửi kèm SĐT tắt chỉ gửi avatar + tên | Functional | Critical | UC-01 | BR01c | Not Run |
| G023_TC016 | Danh thiếp gửi ra hiển thị đúng theo G013 | Regression | Critical | UC-01 | BR05 | Not Run |
| G023_TC017 | Gửi danh thiếp qua đúng tài khoản Zalo của hội thoại | Functional | Critical | UC-01 | BR03 | Not Run |
| G023_TC018 | Staff có quyền nhắn tin gửi được danh thiếp | Permission | High | UC-01 | BR04 | Not Run |
| G023_TC019 | Staff không có quyền nhắn tin không gửi được danh thiếp | Permission | Critical | UC-01 | BR04 | Not Run |
| G023_TC020 | DISCONNECTED khi mở picker danh thiếp bị chặn | Exception | Critical | UC-01 | BR07/E03 | Not Run |
| G023_TC021 | DISCONNECTED trong lúc gửi danh thiếp trả lỗi, không gửi trùng | Recovery | Critical | UC-01 | E02/E03 | Not Run |
| G023_TC022 | Double-click nút Gửi không tạo lô danh thiếp trùng | Concurrency | High | UC-01 | QA | Not Run |
| G023_TC023 | Mở picker sticker từ toolbar | Functional | Critical | UC-02 | BR02 | Not Run |
| G023_TC024 | Picker sticker có mục Gần đây | Functional | High | UC-02 | BR02 | Not Run |
| G023_TC025 | Picker sticker hiển thị bộ mặc định và bộ đã tải | Functional | High | UC-02 | BR02 | Not Run |
| G023_TC026 | Không có chức năng upload sticker tùy chỉnh | Negative | High | UC-02 | OOS01 | Not Run |
| G023_TC027 | Chọn sticker thì gửi ngay, không có bước confirm | Functional | Critical | UC-02 | BR06 | Not Run |
| G023_TC028 | Sticker vừa gửi xuất hiện trong Gần đây | Functional | Medium | UC-02 | BR02 | Not Run |
| G023_TC029 | Sticker gửi qua đúng tài khoản Zalo của hội thoại | Functional | Critical | UC-02 | BR03 | Not Run |
| G023_TC030 | DISCONNECTED không gửi được sticker | Exception | Critical | UC-02 | BR07/E03 | Not Run |
| G023_TC031 | Zalo API lỗi khi gửi sticker hiển thị toast lỗi | Exception | High | UC-02 | E02 | Not Run |
| G023_TC032 | Staff có quyền nhắn tin gửi được sticker | Permission | High | UC-02 | BR04 | Not Run |
| G023_TC033 | Không có quyền nhắn tin không gửi được sticker | Permission | Critical | UC-02 | BR04 | Not Run |
| G023_TC034 | Không cho gửi nhiều sticker trong một thao tác | Negative | Medium | UC-02 | OOS04 | Not Run |
| G023_TC035 | Chuyển hội thoại khác, picker dùng đúng danh bạ/sticker của tài khoản mới | Regression | Critical | UC-01/02 | BR03 | Not Run |

## 10. Testcase Detail

### G023_TC001

| Field | Value |
|---|---|
| Test Case | Mở picker danh thiếp từ toolbar |
| ID | G023_TC001 |
| Purpose | Xác minh mở picker danh thiếp từ toolbar |
| Category | Functional |
| Priority | Critical |
| Requirement | G023 |
| Use Case | UC-01 |
| Business Rule | BR01 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Mở picker danh thiếp từ toolbar; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G023_TC002

| Field | Value |
|---|---|
| Test Case | Picker danh thiếp chỉ hiển thị bạn bè của đúng tài khoản Zalo đang chat |
| ID | G023_TC002 |
| Purpose | Xác minh picker danh thiếp chỉ hiển thị bạn bè của đúng tài khoản zalo đang chat |
| Category | Functional |
| Priority | Critical |
| Requirement | G023 |
| Use Case | UC-01 |
| Business Rule | BR01/BR03 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Picker danh thiếp chỉ hiển thị bạn bè của đúng tài khoản Zalo đang chat; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G023_TC003

| Field | Value |
|---|---|
| Test Case | Picker danh thiếp không có mục Gần đây |
| ID | G023_TC003 |
| Purpose | Xác minh picker danh thiếp không có mục gần đây |
| Category | Negative |
| Priority | High |
| Requirement | G023 |
| Use Case | UC-01 |
| Business Rule | BR01 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Picker danh thiếp không có mục Gần đây; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G023_TC004

| Field | Value |
|---|---|
| Test Case | Tìm liên hệ theo tên chính xác |
| ID | G023_TC004 |
| Purpose | Xác minh tìm liên hệ theo tên chính xác |
| Category | Functional |
| Priority | High |
| Requirement | G023 |
| Use Case | UC-01 |
| Business Rule | BR01 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Tìm liên hệ theo tên chính xác; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G023_TC005

| Field | Value |
|---|---|
| Test Case | Tìm liên hệ theo một phần tên |
| ID | G023_TC005 |
| Purpose | Xác minh tìm liên hệ theo một phần tên |
| Category | Functional |
| Priority | Medium |
| Requirement | G023 |
| Use Case | UC-01 |
| Business Rule | BR01 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Tìm liên hệ theo một phần tên; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G023_TC006

| Field | Value |
|---|---|
| Test Case | Tìm liên hệ theo SĐT |
| ID | G023_TC006 |
| Purpose | Xác minh tìm liên hệ theo sđt |
| Category | Functional |
| Priority | High |
| Requirement | G023 |
| Use Case | UC-01 |
| Business Rule | BR01 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Tìm liên hệ theo SĐT; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G023_TC007

| Field | Value |
|---|---|
| Test Case | Tìm không có kết quả hiển thị trạng thái phù hợp |
| ID | G023_TC007 |
| Purpose | Xác minh tìm không có kết quả hiển thị trạng thái phù hợp |
| Category | Negative |
| Priority | Medium |
| Requirement | G023 |
| Use Case | UC-01 |
| Business Rule | BR01 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Tìm không có kết quả hiển thị trạng thái phù hợp; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G023_TC008

| Field | Value |
|---|---|
| Test Case | Danh bạ trống hiển thị 'Chưa có liên hệ' |
| ID | G023_TC008 |
| Purpose | Xác minh danh bạ trống hiển thị 'chưa có liên hệ' |
| Category | Exception |
| Priority | High |
| Requirement | G023 |
| Use Case | UC-01 |
| Business Rule | E01 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Danh bạ trống hiển thị 'Chưa có liên hệ'; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G023_TC009

| Field | Value |
|---|---|
| Test Case | Chưa chọn liên hệ thì không gửi được |
| ID | G023_TC009 |
| Purpose | Xác minh chưa chọn liên hệ thì không gửi được |
| Category | Negative |
| Priority | High |
| Requirement | G023 |
| Use Case | UC-01 |
| Business Rule | BR01b |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Chưa chọn liên hệ thì không gửi được; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G023_TC010

| Field | Value |
|---|---|
| Test Case | Chọn 1 danh thiếp và gửi thành công |
| ID | G023_TC010 |
| Purpose | Xác minh chọn 1 danh thiếp và gửi thành công |
| Category | Functional |
| Priority | Critical |
| Requirement | G023 |
| Use Case | UC-01 |
| Business Rule | BR01b |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Chọn 1 danh thiếp và gửi thành công; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G023_TC011

| Field | Value |
|---|---|
| Test Case | Chọn 9 danh thiếp và gửi thành công |
| ID | G023_TC011 |
| Purpose | Xác minh chọn 9 danh thiếp và gửi thành công |
| Category | Boundary |
| Priority | Critical |
| Requirement | G023 |
| Use Case | UC-01 |
| Business Rule | BR01b |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Chọn 9 danh thiếp và gửi thành công; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G023_TC012

| Field | Value |
|---|---|
| Test Case | Chọn liên hệ thứ 10 bị chặn |
| ID | G023_TC012 |
| Purpose | Xác minh chọn liên hệ thứ 10 bị chặn |
| Category | Boundary |
| Priority | Critical |
| Requirement | G023 |
| Use Case | UC-01 |
| Business Rule | E04 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Chọn liên hệ thứ 10 bị chặn; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G023_TC013

| Field | Value |
|---|---|
| Test Case | Bộ đếm Đã chọn cập nhật đúng khi chọn/bỏ chọn |
| ID | G023_TC013 |
| Purpose | Xác minh bộ đếm đã chọn cập nhật đúng khi chọn/bỏ chọn |
| Category | Functional |
| Priority | High |
| Requirement | G023 |
| Use Case | UC-01 |
| Business Rule | BR01b |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Bộ đếm Đã chọn cập nhật đúng khi chọn/bỏ chọn; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G023_TC014

| Field | Value |
|---|---|
| Test Case | Toggle gửi kèm SĐT bật áp dụng cho cả lô |
| ID | G023_TC014 |
| Purpose | Xác minh toggle gửi kèm sđt bật áp dụng cho cả lô |
| Category | Functional |
| Priority | Critical |
| Requirement | G023 |
| Use Case | UC-01 |
| Business Rule | BR01c |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Toggle gửi kèm SĐT bật áp dụng cho cả lô; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G023_TC015

| Field | Value |
|---|---|
| Test Case | Toggle gửi kèm SĐT tắt chỉ gửi avatar + tên |
| ID | G023_TC015 |
| Purpose | Xác minh toggle gửi kèm sđt tắt chỉ gửi avatar + tên |
| Category | Functional |
| Priority | Critical |
| Requirement | G023 |
| Use Case | UC-01 |
| Business Rule | BR01c |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Toggle gửi kèm SĐT tắt chỉ gửi avatar + tên; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G023_TC016

| Field | Value |
|---|---|
| Test Case | Danh thiếp gửi ra hiển thị đúng theo G013 |
| ID | G023_TC016 |
| Purpose | Xác minh danh thiếp gửi ra hiển thị đúng theo g013 |
| Category | Regression |
| Priority | Critical |
| Requirement | G023 |
| Use Case | UC-01 |
| Business Rule | BR05 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Danh thiếp gửi ra hiển thị đúng theo G013; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G023_TC017

| Field | Value |
|---|---|
| Test Case | Gửi danh thiếp qua đúng tài khoản Zalo của hội thoại |
| ID | G023_TC017 |
| Purpose | Xác minh gửi danh thiếp qua đúng tài khoản zalo của hội thoại |
| Category | Functional |
| Priority | Critical |
| Requirement | G023 |
| Use Case | UC-01 |
| Business Rule | BR03 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Gửi danh thiếp qua đúng tài khoản Zalo của hội thoại; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G023_TC018

| Field | Value |
|---|---|
| Test Case | Staff có quyền nhắn tin gửi được danh thiếp |
| ID | G023_TC018 |
| Purpose | Xác minh staff có quyền nhắn tin gửi được danh thiếp |
| Category | Permission |
| Priority | High |
| Requirement | G023 |
| Use Case | UC-01 |
| Business Rule | BR04 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Staff có quyền nhắn tin gửi được danh thiếp; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G023_TC019

| Field | Value |
|---|---|
| Test Case | Staff không có quyền nhắn tin không gửi được danh thiếp |
| ID | G023_TC019 |
| Purpose | Xác minh staff không có quyền nhắn tin không gửi được danh thiếp |
| Category | Permission |
| Priority | Critical |
| Requirement | G023 |
| Use Case | UC-01 |
| Business Rule | BR04 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Staff không có quyền nhắn tin không gửi được danh thiếp; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G023_TC020

| Field | Value |
|---|---|
| Test Case | DISCONNECTED khi mở picker danh thiếp bị chặn |
| ID | G023_TC020 |
| Purpose | Xác minh disconnected khi mở picker danh thiếp bị chặn |
| Category | Exception |
| Priority | Critical |
| Requirement | G023 |
| Use Case | UC-01 |
| Business Rule | BR07/E03 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: DISCONNECTED khi mở picker danh thiếp bị chặn; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G023_TC021

| Field | Value |
|---|---|
| Test Case | DISCONNECTED trong lúc gửi danh thiếp trả lỗi, không gửi trùng |
| ID | G023_TC021 |
| Purpose | Xác minh disconnected trong lúc gửi danh thiếp trả lỗi, không gửi trùng |
| Category | Recovery |
| Priority | Critical |
| Requirement | G023 |
| Use Case | UC-01 |
| Business Rule | E02/E03 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: DISCONNECTED trong lúc gửi danh thiếp trả lỗi, không gửi trùng; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G023_TC022

| Field | Value |
|---|---|
| Test Case | Double-click nút Gửi không tạo lô danh thiếp trùng |
| ID | G023_TC022 |
| Purpose | Xác minh double-click nút gửi không tạo lô danh thiếp trùng |
| Category | Concurrency |
| Priority | High |
| Requirement | G023 |
| Use Case | UC-01 |
| Business Rule | QA |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Double-click nút Gửi không tạo lô danh thiếp trùng; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G023_TC023

| Field | Value |
|---|---|
| Test Case | Mở picker sticker từ toolbar |
| ID | G023_TC023 |
| Purpose | Xác minh mở picker sticker từ toolbar |
| Category | Functional |
| Priority | Critical |
| Requirement | G023 |
| Use Case | UC-02 |
| Business Rule | BR02 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Mở picker sticker từ toolbar; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G023_TC024

| Field | Value |
|---|---|
| Test Case | Picker sticker có mục Gần đây |
| ID | G023_TC024 |
| Purpose | Xác minh picker sticker có mục gần đây |
| Category | Functional |
| Priority | High |
| Requirement | G023 |
| Use Case | UC-02 |
| Business Rule | BR02 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Picker sticker có mục Gần đây; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G023_TC025

| Field | Value |
|---|---|
| Test Case | Picker sticker hiển thị bộ mặc định và bộ đã tải |
| ID | G023_TC025 |
| Purpose | Xác minh picker sticker hiển thị bộ mặc định và bộ đã tải |
| Category | Functional |
| Priority | High |
| Requirement | G023 |
| Use Case | UC-02 |
| Business Rule | BR02 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Picker sticker hiển thị bộ mặc định và bộ đã tải; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G023_TC026

| Field | Value |
|---|---|
| Test Case | Không có chức năng upload sticker tùy chỉnh |
| ID | G023_TC026 |
| Purpose | Xác minh không có chức năng upload sticker tùy chỉnh |
| Category | Negative |
| Priority | High |
| Requirement | G023 |
| Use Case | UC-02 |
| Business Rule | OOS01 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Không có chức năng upload sticker tùy chỉnh; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G023_TC027

| Field | Value |
|---|---|
| Test Case | Chọn sticker thì gửi ngay, không có bước confirm |
| ID | G023_TC027 |
| Purpose | Xác minh chọn sticker thì gửi ngay, không có bước confirm |
| Category | Functional |
| Priority | Critical |
| Requirement | G023 |
| Use Case | UC-02 |
| Business Rule | BR06 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Chọn sticker thì gửi ngay, không có bước confirm; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G023_TC028

| Field | Value |
|---|---|
| Test Case | Sticker vừa gửi xuất hiện trong Gần đây |
| ID | G023_TC028 |
| Purpose | Xác minh sticker vừa gửi xuất hiện trong gần đây |
| Category | Functional |
| Priority | Medium |
| Requirement | G023 |
| Use Case | UC-02 |
| Business Rule | BR02 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Sticker vừa gửi xuất hiện trong Gần đây; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G023_TC029

| Field | Value |
|---|---|
| Test Case | Sticker gửi qua đúng tài khoản Zalo của hội thoại |
| ID | G023_TC029 |
| Purpose | Xác minh sticker gửi qua đúng tài khoản zalo của hội thoại |
| Category | Functional |
| Priority | Critical |
| Requirement | G023 |
| Use Case | UC-02 |
| Business Rule | BR03 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Sticker gửi qua đúng tài khoản Zalo của hội thoại; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G023_TC030

| Field | Value |
|---|---|
| Test Case | DISCONNECTED không gửi được sticker |
| ID | G023_TC030 |
| Purpose | Xác minh disconnected không gửi được sticker |
| Category | Exception |
| Priority | Critical |
| Requirement | G023 |
| Use Case | UC-02 |
| Business Rule | BR07/E03 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: DISCONNECTED không gửi được sticker; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G023_TC031

| Field | Value |
|---|---|
| Test Case | Zalo API lỗi khi gửi sticker hiển thị toast lỗi |
| ID | G023_TC031 |
| Purpose | Xác minh zalo api lỗi khi gửi sticker hiển thị toast lỗi |
| Category | Exception |
| Priority | High |
| Requirement | G023 |
| Use Case | UC-02 |
| Business Rule | E02 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Zalo API lỗi khi gửi sticker hiển thị toast lỗi; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G023_TC032

| Field | Value |
|---|---|
| Test Case | Staff có quyền nhắn tin gửi được sticker |
| ID | G023_TC032 |
| Purpose | Xác minh staff có quyền nhắn tin gửi được sticker |
| Category | Permission |
| Priority | High |
| Requirement | G023 |
| Use Case | UC-02 |
| Business Rule | BR04 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Staff có quyền nhắn tin gửi được sticker; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G023_TC033

| Field | Value |
|---|---|
| Test Case | Không có quyền nhắn tin không gửi được sticker |
| ID | G023_TC033 |
| Purpose | Xác minh không có quyền nhắn tin không gửi được sticker |
| Category | Permission |
| Priority | Critical |
| Requirement | G023 |
| Use Case | UC-02 |
| Business Rule | BR04 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Không có quyền nhắn tin không gửi được sticker; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G023_TC034

| Field | Value |
|---|---|
| Test Case | Không cho gửi nhiều sticker trong một thao tác |
| ID | G023_TC034 |
| Purpose | Xác minh không cho gửi nhiều sticker trong một thao tác |
| Category | Negative |
| Priority | Medium |
| Requirement | G023 |
| Use Case | UC-02 |
| Business Rule | OOS04 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Không cho gửi nhiều sticker trong một thao tác; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
| Actual Result |  |
| Error Code |  |
| Note |  |
| Date |  |
| Tester |  |
| Status | Not Run |
### G023_TC035

| Field | Value |
|---|---|
| Test Case | Chuyển hội thoại khác, picker dùng đúng danh bạ/sticker của tài khoản mới |
| ID | G023_TC035 |
| Purpose | Xác minh chuyển hội thoại khác, picker dùng đúng danh bạ/sticker của tài khoản mới |
| Category | Regression |
| Priority | Critical |
| Requirement | G023 |
| Use Case | UC-01/02 |
| Business Rule | BR03 |
| Decision / State | Theo Decision Table / State Transition tương ứng |
| Preconditions | Người dùng đã đăng nhập; chuẩn bị hội thoại/tài khoản/quyền/trạng thái phù hợp với testcase. |
| Test Data | Dùng dữ liệu kiểm thử cụ thể phù hợp với testcase và requirement. |
| Test Steps | 1. Chuẩn bị Preconditions.<br>2. Thực hiện thao tác theo Test Case.<br>3. Quan sát UI, dữ liệu và tích hợp liên quan.<br>4. Reload/chuyển phiên/thiết bị nếu cần để xác nhận persistence hoặc isolation. |
| Expected Result | Hệ thống xử lý đúng: Chuyển hội thoại khác, picker dùng đúng danh bạ/sticker của tài khoản mới; không ảnh hưởng dữ liệu/người dùng ngoài phạm vi và không phát sinh hành vi ngoài requirement. |
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
| 1.0 | 2026-08-22 | Tạo testcase riêng cho requirement G023 |
