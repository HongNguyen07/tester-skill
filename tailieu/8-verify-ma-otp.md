# 8. Verify mã OTP

API Documentation: API Xác Thực OTP Zalo

Giới thiệu

Mục đích: Tài liệu này mô tả API Xác Thực OTP Zalo, bao gồm endpoint, định dạng request/response, yêu cầu xác thực và các thông tin kỹ thuật cần thiết để frontend hoặc hệ thống tích hợp sử dụng API đúng cách.

Thông tin chung

* API Base URL: <https://api-dev.gopany.site/hrm-api>
* API Version: v1
* Contact Email: Chưa được chỉ định
* Authentication Method: Không yêu cầu xác thực

Xác thực

Endpoint này là public theo cấu hình `source/config/kong.php` trong danh sách `oidc.unauthenticated_paths`.

Mã lỗi

| **Code** | **errorCode** | **Message** | **Description** |
|------|-----------|---------|-------------|
| 400  | 11000     | Lỗi dữ liệu | Trả về khi `uuid`, `phone` hoặc `otp` bị thiếu hoặc không đúng định dạng. |
| 400  | 30029     | Tài khoản đã được xác thực | Trả về khi account theo `uuid` đã có `is_verify_phone = true` trong bảng `user_providers`. Module `user`, rule `account_already_verified`. Rule này được ưu tiên kiểm tra trước rule số điện thoại đã được xác thực. |
| 400  | 30014     | Số điện thoại đã được xác thực | Trả về khi `phone` đã được verify bởi account khác trong bảng `user_providers`. Module `user`, rule `phone_already_verified`. |
| 400  | 30025     | Mã OTP đã hết hạn hoặc không tồn tại | Trả về khi không tìm thấy OTP cache hiện hành theo `uuid`. Module `zalo`, rule `otp_expired`. Lỗi này được tính vào bộ đếm khóa verify theo cặp `uuid + phone`. |
| 400  | 30026     | Thông tin xác thực OTP không khớp | Trả về khi payload OTP trong cache không khớp với `uuid` hoặc `phone` sau khi chuẩn hóa. Module `zalo`, rule `otp_mismatch`. Lỗi này được tính vào bộ đếm khóa verify theo cặp `uuid + phone`. |
| 400  | 30027     | Mã OTP không đúng | Trả về khi mã OTP gửi lên khác với mã OTP đang lưu trong cache. Module `zalo`, rule `otp_invalid`. Lỗi này được tính vào bộ đếm khóa verify theo cặp `uuid + phone`. |
| 400  | 30028     | Bạn đã nhập sai OTP quá nhiều lần, vui lòng thử lại sau | Trả về khi cặp `uuid` và `phone` đang bị khóa verify theo cấu hình `verify_lock_steps`. Module `zalo`, rule `otp_verify_locked`. |

Tài nguyên / Endpoint

Xác thực mã OTP Zalo

Phương thức: POST

URL: `/api/v1/auth/phone/verify-zalo-otp`

Mô tả: Xác thực mã OTP đã được gửi qua API `POST /api/v1/auth/phone/send-zalo-otp`. OTP hiện hành được cache theo `uuid`, nhưng payload OTP vẫn chứa `phone`; API chỉ xác thực thành công khi request khớp cả `uuid + phone + otp`. Nếu mã đúng thì cập nhật trạng thái xác thực, xóa OTP cache theo `uuid`, cache resend và cache verify theo cặp `uuid + phone`.

Tham số request

| **Name** | **Type** | **Required** | **Description** |
|------|------|----------|-------------|
| uuid | string | Có       | UUID của account đã dùng khi gửi OTP. Giá trị này map với cột `provider_id` trong bảng `user_providers`. |
| phone | string | Có       | Số điện thoại đã dùng khi gửi OTP, chấp nhận định dạng bắt đầu bằng `0`, `84` hoặc `+84`. |
| otp  | string | Có       | Mã OTP gồm đúng 6 chữ số. |

Request mẫu:

```javascript
{
  "uuid": "550e8400-e29b-41d4-a716-446655440000",
  "phone": "0987654321",
  "otp": "123456"
}
```

Response mẫu:

```javascript
{
  "data": {
    "accountId": 123,
    "uuid": "550e8400-e29b-41d4-a716-446655440000",
    "phone": "0987654321",
    "verified": true
  },
  "status": "success",
  "code": 200,
  "message": "Xác thực mã OTP thành công"
}
```

Response lỗi validation mẫu:

```javascript
{
  "status": "error",
  "code": 400,
  "errorCode": 11000,
  "message": "Lỗi dữ liệu",
  "errors": {
    "otp": [
      {
        "rule": "regex",
        "message": "Mã OTP phải gồm 6 chữ số",
        "module": "unknown"
      }
    ]
  }
}
```

Response lỗi OTP sai/chưa hợp lệ mẫu:

```javascript
{
  "status": "error",
  "code": 400,
  "errorCode": 30027,
  "message": "Mã OTP không đúng",
  "module": "zalo",
  "rule": "otp_invalid",
  "errors": {
    "failedAttempts": 1
  }
}
```

Response lỗi khóa verify mẫu:

```javascript
{
  "status": "error",
  "code": 400,
  "errorCode": 30028,
  "message": "Bạn đã nhập sai OTP quá nhiều lần, vui lòng thử lại sau",
  "module": "zalo",
  "rule": "otp_verify_locked",
  "errors": {
    "failedAttempts": 5,
    "lockMinutes": 1,
    "lockedUntil": 1790000000,
    "remainingSeconds": 60,
    "remainingMinutes": 1
  }
}
```


---

Lịch sử thay đổi

* 2026-10-02 09:36:42 +07: Tách riêng 2 rule cho `verify-zalo-otp`: `account_already_verified` khi account đã xác thực và `phone_already_verified` khi số điện thoại đã được account khác xác thực; ưu tiên kiểm tra account trước.


* 2026-09-23 15:54:10 +07: Bổ sung `errorCode` riêng cho các lỗi `verify-zalo-otp`; các lỗi endpoint này trả HTTP `400`, FE phân biệt nghiệp vụ bằng `errorCode` hoặc `rule`.
* 2026-09-22 17:11:11 +07: Cập nhật luồng verify mới: OTP cache theo `uuid`, verify bắt buộc khớp `uuid + phone`; các lỗi `otp_expired`, `otp_mismatch`, `otp_invalid` đều cộng vào bộ đếm khóa verify theo cặp `uuid + phone`.
* 2026-09-22 13:47:13 +07: Cập nhật logic khóa verify OTP theo bậc thang; bổ sung response `otp_verify_locked` có thời gian còn lại; ghi rõ verify thành công sẽ xóa OTP cache, cache resend và cache verify theo cặp `uuid + phone`.
* 2026-09-16: Thêm tài liệu cho `POST /api/v1/auth/phone/verify-zalo-otp`.

Thuật ngữ / Định nghĩa

* OTP: Mã xác thực dùng một lần, gồm 6 chữ số.
* Zalo OTP: Luồng xác thực số điện thoại bằng mã OTP gửi qua Zalo template message.
* Cache OTP: Nơi lưu tạm OTP hiện hành theo `uuid` trong thời gian hiệu lực; payload cache vẫn chứa `phone` để verify bắt buộc khớp `uuid + phone`.
* `verify_lock_steps`: Cấu hình khóa verify theo bậc thang, đơn vị khóa là phút. Các lỗi `otp_expired`, `otp_mismatch`, `otp_invalid` đều được tính vào bộ đếm này. Ví dụ: `[{"attempts":5,"lock_minutes":1},{"attempts":10,"lock_minutes":10},{"attempts":20,"lock_minutes":60}]`.
* `failedAttempts`: Trong response lỗi khóa, đây là mốc `attempts` của bậc đang bị khóa. Khi chạm bậc cuối, bộ đếm verify được reset để vòng tiếp theo quay lại từ bậc đầu.