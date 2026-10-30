# 7. Send mã OTP

API Documentation: API Gửi OTP Qua Zalo

Giới thiệu

Mục đích: Tài liệu này mô tả API Gửi OTP Qua Zalo, bao gồm endpoint, định dạng request/response, yêu cầu xác thực và các thông tin kỹ thuật cần thiết để frontend hoặc hệ thống tích hợp sử dụng API đúng cách.

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
| 400  | 11000     | Lỗi dữ liệu | Trả về khi `uuid` hoặc `phone` bị thiếu hoặc không đúng định dạng. |
| 400  | 30016     | Tài khoản không tồn tại | Trả về khi `uuid` không tồn tại trong cột `provider_id` của bảng `user_providers`. Module `user`, rule `not_found`. |
| 400  | 30014     | Số điện thoại đã được xác thực | Trả về khi account hiện tại đã có `is_verify_phone = true`, hoặc `phone` đã được verify bởi account khác trong bảng `user_providers`. Module `user`, rule `phone_already_verified`. |
| 400  | 30018     | Vui lòng chờ trước khi gửi lại mã OTP | Trả về khi `uuid` vẫn đang trong thời gian chờ gửi lại. Module `zalo`, rule `otp_cooldown`. |
| 400  | 30019     | Bạn đã đổi số điện thoại quá nhiều lần, vui lòng thử lại sau | Trả về khi account đang bị khóa đổi số điện thoại theo cấu hình `phone_change_lock_steps`. Module `zalo`, rule `phone_change_locked`. |
| 400  | 30020     | Bạn đã gửi lại OTP quá nhiều lần, vui lòng thử lại sau | Trả về khi cặp `uuid` và `phone` đang bị khóa resend OTP theo cấu hình `resend_lock_steps`. Module `zalo`, rule `otp_resend_locked`. |
| 400  | 30017     | Cấu hình Zalo OTP chưa đúng | Trả về khi setting Zalo OTP không tồn tại hoặc thiếu thông tin bắt buộc. Module `zalo`, rule `config_error`. |
| 400  | 30021     | Cấu hình refresh token Zalo chưa đúng | Trả về khi thiếu `refresh_token`, `app_id` hoặc `secret_key` để refresh access token. Module `zalo`, rule `refresh_config_error`. |
| 400  | 30022     | Refresh token Zalo đã hết hạn hoặc sắp hết hạn | Trả về khi `refresh_expires_in` đã gần hết hạn hoặc hết hạn. Module `zalo`, rule `refresh_token_expired`. |
| 400  | 30023     | Refresh token Zalo thất bại | Trả về khi API refresh token của Zalo trả lỗi hoặc response thiếu token mới. Module `zalo`, rule `refresh_token_failed`. |
| 400  | 30024     | Gửi mã OTP qua Zalo thất bại | Trả về khi API gửi template message của Zalo trả lỗi khác `-118`. Module `zalo`, rule `send_otp_failed`. |
| 400  | 30015     | Gửi mã OTP qua Zalo thất bại | Trả về khi Zalo báo số điện thoại không tồn tại trên Zalo với `response.error = -118`. Module `zalo`, rule `send_otp_failed`. |

Tài nguyên / Endpoint

Gửi mã OTP qua Zalo

Phương thức: POST

URL: `/api/v1/auth/phone/send-zalo-otp`

Mô tả: Gửi mã OTP 6 chữ số cho số điện thoại của người dùng. API dùng `uuid` để map với cột `provider_id` trong bảng `user_providers`, sau đó cache OTP hiện hành theo `uuid`. Payload OTP vẫn lưu `phone` đã chuẩn hóa để bước verify bắt buộc khớp cả `uuid + phone`. Số điện thoại được chuẩn hóa về định dạng `84xxxxxxxxx` khi gửi sang Zalo, nhưng dữ liệu lưu trong `user_providers.phone` giữ nguyên raw input sau khi trim.

Nếu setting `zalo_setting.send_message_enabled = true`, hệ thống sẽ gửi OTP thật qua Zalo. Nếu setting này là `false`, hệ thống không gọi API Zalo và trả mã OTP trực tiếp trong response để phục vụ môi trường test, nhưng vẫn giữ nguyên các logic validate, cache OTP và cooldown.

Thứ tự xử lý chính:


1. Validate account, số điện thoại và trạng thái số đã verify.
2. Xác định request là đổi số điện thoại hay resend dựa trên account hiện tại và OTP cache hiện hành theo `uuid`.
3. Kiểm tra cooldown theo `uuid` trước các lock nghiệp vụ; nếu còn cooldown thì trả `otp_cooldown`.
4. Nếu không còn cooldown, hệ thống bắt đầu tính cooldown mới ngay khi request hợp lệ đi vào API, trước khi kiểm tra lock đổi số/resend và trước khi gọi Zalo.
5. Nếu là đổi số điện thoại, kiểm tra khóa đổi số theo `uuid`.
6. Nếu là resend, kiểm tra khóa resend theo cặp `uuid + phone`.
7. Nếu không bị khóa thì mới gửi OTP hoặc trả OTP trong response theo setting.
8. Nếu gửi thành công, cập nhật `user_providers.phone`, cache OTP mới theo `uuid` và ghi đè OTP cũ của account đó.
9. Nếu gửi thành công và là đổi số/resend, cộng lượt tương ứng; khi chạm bậc khóa thì tạo khóa cho request kế tiếp trong thời gian khóa.

Tham số request

| **Name** | **Type** | **Required** | **Description** |
|------|------|----------|-------------|
| uuid | string | Có       | UUID của account cần xác thực. Giá trị này phải tồn tại trong cột `provider_id` của bảng `user_providers`. |
| phone | string | Có       | Số điện thoại Việt Nam, chấp nhận định dạng bắt đầu bằng `0`, `84` hoặc `+84`. |

Request mẫu:

```javascript
{
  "uuid": "550e8400-e29b-41d4-a716-446655440000",
  "phone": "0987654321"
}
```

Response mẫu khi `send_message_enabled = true`:

```javascript
{
  "data": {
    "accountId": 123,
    "uuid": "550e8400-e29b-41d4-a716-446655440000",
    "phone": "0987654321",
    "expiresIn": 300
  },
  "status": "success",
  "code": 200,
  "message": "Gửi mã OTP qua Zalo thành công"
}
```

Response mẫu khi `send_message_enabled = false`:

```javascript
{
  "data": {
    "accountId": 123,
    "uuid": "550e8400-e29b-41d4-a716-446655440000",
    "phone": "0987654321",
    "expiresIn": 300,
    "otp": "123456"
  },
  "status": "success",
  "code": 200,
  "message": "Gửi mã OTP qua Zalo thành công"
}
```


Response lỗi validation mẫu:

```javascript
{
  "status": "error",
  "code": 400,
  "message": "Lỗi dữ liệu",
  "errors": {
    "phone": [
      {
        "rule": "regex",
        "message": "Số điện thoại không đúng định dạng",
        "module": "unknown"
      }
    ]
  }
}
```

Response lỗi cooldown mẫu:

```javascript
{
  "status": "error",
  "code": 400,
  "errorCode": 30018,
  "message": "Vui lòng chờ trước khi gửi lại mã OTP",
  "module": "zalo",
  "rule": "otp_cooldown",
  "errors": {
    "lockedUntil": 1790000000,
    "remainingSeconds": 60,
    "remainingMinutes": 1
  }
}
```

Response lỗi khóa đổi số điện thoại mẫu:

```javascript
{
  "status": "error",
  "code": 400,
  "errorCode": 30019,
  "message": "Bạn đã đổi số điện thoại quá nhiều lần, vui lòng thử lại sau",
  "module": "zalo",
  "rule": "phone_change_locked",
  "errors": {
    "failedAttempts": 5,
    "lockMinutes": 1,
    "lockedUntil": 1790000000,
    "remainingSeconds": 60,
    "remainingMinutes": 1
  }
}
```

Response lỗi khóa resend OTP mẫu:

```javascript
{
  "status": "error",
  "code": 400,
  "errorCode": 30020,
  "message": "Bạn đã gửi lại OTP quá nhiều lần, vui lòng thử lại sau",
  "module": "zalo",
  "rule": "otp_resend_locked",
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

* 2026-09-23 15:54:10 +07: Bổ sung `errorCode` riêng cho các lỗi `send-zalo-otp`; FE không cần dùng HTTP `code = 400` để phân biệt nghiệp vụ.
* 2026-09-22 17:11:11 +07: Cập nhật luồng mới: OTP cache theo `uuid`, verify vẫn khớp `uuid + phone`; cooldown được kiểm tra trước lock và bắt đầu tính ngay khi request hợp lệ đi vào API; đổi số và resend chạm bậc khóa vẫn trả OTP ở request hiện tại, khóa áp dụng cho request kế tiếp; cập nhật lỗi số điện thoại đã verify về `phone_already_verified`.
* 2026-09-22 13:47:13 +07: Cập nhật thứ tự xử lý `send-zalo-otp`: cooldown theo `uuid`, đổi số theo `uuid`, resend theo cặp `uuid + phone`; bổ sung lỗi `phone_change_locked`, `otp_resend_locked` và response `otp_cooldown` có thời gian còn lại.
* 2026-09-16: Thêm tài liệu cho `POST /api/v1/auth/phone/send-zalo-otp`.

Thuật ngữ / Định nghĩa

* OTP: Mã xác thực dùng một lần, gồm 6 chữ số.
* Zalo OTP: Luồng gửi OTP qua Zalo template message.
* `ttl_minutes`: Số phút OTP có hiệu lực, đọc từ `system_settings`.
* `cooldown`: Thời gian chờ gửi lại OTP theo `uuid`, hiện được xử lý là số phút. Cooldown được kiểm tra trước các lock đổi số/resend và được set ngay khi request hợp lệ đi vào API, trước khi gọi Zalo.
* `phone_change_lock_steps`: Cấu hình khóa đổi số điện thoại theo bậc thang, đơn vị khóa là phút. Chỉ tính khi account đã có `phone` và số mới khác số đang lưu. Gửi lại cùng `uuid + phone` không cộng thêm lượt đổi số; lượt đổi số chỉ được cộng sau khi gửi OTP thành công. Khi chạm bậc khóa, request hiện tại vẫn trả OTP và khóa áp dụng cho request kế tiếp.
* `resend_lock_steps`: Cấu hình khóa resend OTP theo bậc thang, đơn vị khóa là phút. Resend được tính theo cặp `uuid` và `phone`, chỉ tính sau khi resend OTP thành công và request không còn trong cooldown. Khi chạm bậc khóa, request hiện tại vẫn trả OTP và khóa áp dụng cho request kế tiếp.
* Bậc khóa cuối cùng: Khi chạm bậc cuối, bộ đếm tương ứng được reset để vòng tiếp theo quay lại từ bậc đầu. Trường `failedAttempts` trong response lỗi khóa là mốc `attempts` của bậc đang bị khóa.
* `send_message_enabled`: Cấu hình bật/tắt gửi OTP thật qua Zalo. `true` là gửi qua Zalo, `false` là không gọi Zalo và trả OTP trong response.
* `auto_refresh_token_enabled`: Cấu hình bật/tắt scheduler tự refresh access token Zalo. `true` là cho phép command hằng ngày refresh khi access token còn dưới 2 ngày, `false` là bỏ qua.
* Access Token Zalo: Token dùng để gọi API gửi template message của Zalo.
* Refresh Token Zalo: Token dùng để cấp lại access token khi access token gần hết hạn hoặc hết hạn.