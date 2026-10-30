# ZALO-OTP — Verify số điện thoại qua Zalo OTP

> **Nguồn:** tài liệu `2026-09-22-tai-lieu-zalo-otp.md` do user cung cấp (API Documentation).
> Đây là RAW SPEC (input material). QA derive test case từ file này.
> Spec KHÔNG có mục AC Given/When/Then riêng → AC-source = các Section đánh số dưới đây.

## Section 1. Giới thiệu & phạm vi

Tính năng verify số điện thoại qua Zalo OTP: luồng gửi OTP, luồng xác thực OTP, cấu hình trong
`system_settings`, cơ chế cache, refresh token Zalo và các lỗi FE phải xử lý.

- API Base URL: `https://api-dev.gopany.site/hrm-api`
- API Version: v1
- Authentication: **không yêu cầu xác thực** cho 2 endpoint gửi và verify OTP.

Tính năng dùng để xác thực số điện thoại cho account trong bảng `user_providers`.
Account được xác định bằng `uuid` gửi từ FE; `uuid` map với cột `provider_id` trong `user_providers`.

Khi verify thành công, hệ thống cập nhật:

```json
{ "phone": "raw phone input", "is_verify_phone": true }
```

**Lưu ý về số điện thoại:**

- Khi gọi Zalo, số điện thoại được chuẩn hóa về định dạng quốc gia: `0347566507` → `84347566507`.
- Khi lưu vào `user_providers.phone`, hệ thống lưu **raw input sau khi trim**: nhập `0347566507` thì DB lưu `0347566507`.
- Khi kiểm tra trùng số điện thoại, so sánh theo các biến thể `0xxxxxxxxx`, `84xxxxxxxxx`, `+84xxxxxxxxx`.

## Section 2. Luồng gửi OTP

Endpoint: `POST /api/v1/auth/phone/send-zalo-otp`

Request:

```json
{ "uuid": "550e8400-e29b-41d4-a716-446655440000", "phone": "0347566507" }
```

Các bước xử lý (S2-01 … S2-18):

1. Validate `uuid` bắt buộc là UUID hợp lệ.
2. Validate `phone` bắt buộc là số điện thoại Việt Nam hợp lệ, bắt đầu bằng `0`, `84` hoặc `+84`.
3. Kiểm tra account có tồn tại trong `user_providers.provider_id`.
4. Nếu account đã có `is_verify_phone = true`, không cho gửi OTP nữa.
5. Kiểm tra số điện thoại đã được account khác sử dụng chưa.
6. Xác định request là đổi số điện thoại hay resend dựa trên account hiện tại và OTP cache hiện hành theo `uuid`.
7. Kiểm tra cooldown theo `uuid` **trước** các khóa nghiệp vụ; nếu còn cooldown thì trả lỗi `otp_cooldown` và **không** tăng số lần resend/đổi số.
8. Nếu không còn cooldown, hệ thống set cooldown mới **ngay khi request hợp lệ đi vào API**, trước khi kiểm tra lock đổi số/resend và trước khi gọi Zalo.
9. Nếu account đã có `phone` và số mới khác số đang lưu, kiểm tra khóa đổi số điện thoại theo `uuid`.
10. Nếu request là resend, kiểm tra khóa resend OTP theo cặp `uuid + phone`.
11. Sinh OTP gồm 6 chữ số.
12. Nếu `zalo_setting.send_message_enabled = true`, gọi API Zalo để gửi OTP.
13. Nếu gửi Zalo thành công, cập nhật `user_providers.phone` bằng raw phone input; nếu số điện thoại thay đổi thì reset `is_verify_phone = false`.
14. Cache OTP hiện hành theo `uuid`; nếu trước đó account đã có OTP cho số khác thì **OTP cũ bị ghi đè**.
15. Nếu là đổi số hợp lệ, tăng số lần đổi số theo `uuid`.
16. Nếu là resend, tăng số lần resend theo cặp `uuid + phone`.
17. Nếu số lần đổi số hoặc resend chạm bậc khóa tương ứng, tạo khóa cho **request kế tiếp** trong thời gian khóa; **request hiện tại vẫn trả OTP** nếu gửi thành công.
18. Trả response cho FE.

**Trường hợp `send_message_enabled = false`:**

- Hệ thống không gọi API Zalo.
- Vẫn chạy đầy đủ validate, cache OTP, cooldown và các logic lock.
- Response trả thêm trường `otp` để FE/QA test mà không spam Zalo.

Response thành công (gửi thật qua Zalo):

```json
{
  "data": { "accountId": 123, "uuid": "550e8400-e29b-41d4-a716-446655440000", "phone": "0347566507", "expiresIn": 300 },
  "status": "success", "code": 200, "message": "Gửi mã OTP qua Zalo thành công"
}
```

Response thành công (tắt gửi thật):

```json
{
  "data": { "accountId": 123, "uuid": "550e8400-e29b-41d4-a716-446655440000", "phone": "0347566507", "expiresIn": 300, "otp": "123456" },
  "status": "success", "code": 200, "message": "Gửi mã OTP qua Zalo thành công"
}
```

**Lưu ý quan trọng (BR gửi OTP):**

- Nếu gọi Zalo thất bại, hệ thống **không** cập nhật `phone` vào `user_providers`.
- Nếu Zalo trả lỗi số điện thoại không tồn tại trên Zalo (`error = -118`), API trả `errorCode = 30015`.
- Lỗi gửi Zalo thất bại **không** tạo OTP cache, **không** cộng lượt đổi số và **không** cộng lượt resend. Cooldown đã được set ngay khi request hợp lệ đi vào API.
- Nếu request là đổi sang số mới, chỉ khi target phone **khác** target đổi số gần nhất thì mới cộng thêm lượt đổi số.
- Gửi lại cùng `uuid + phone` hoặc cùng số đang lưu **không** bị cộng thêm vào bộ đếm đổi số. Lượt đổi số chỉ được cộng **sau khi** OTP gửi thành công.
- Resend OTP được tính theo cặp `uuid + phone`, chỉ tính **sau khi** resend OTP thành công. Nếu Zalo gửi lỗi thì không cộng lượt resend.

## Section 3. Luồng xác thực OTP

Endpoint: `POST /api/v1/auth/phone/verify-zalo-otp`

Request:

```json
{ "uuid": "550e8400-e29b-41d4-a716-446655440000", "phone": "0347566507", "otp": "123456" }
```

Các bước xử lý (S3-01 … S3-10):

1. Validate `uuid`, `phone`, `otp`.
2. Kiểm tra cặp `uuid + phone` có đang bị khóa verify OTP không.
3. Lấy OTP hiện hành đã cache theo `uuid`.
4. Nếu OTP không tồn tại hoặc hết hạn → tăng số lần lỗi verify theo cặp `uuid + phone` và trả lỗi `otp_expired`.
5. Nếu payload cache không khớp `uuid` hoặc `phone` → tăng số lần lỗi verify theo cặp `uuid + phone` và trả lỗi `otp_mismatch`.
6. Nếu OTP sai → tăng số lần lỗi verify theo cặp `uuid + phone` và trả lỗi `otp_invalid`.
7. Nếu số lần lỗi verify chạm bậc khóa trong `verify_lock_steps` → khóa verify theo số phút cấu hình và trả lỗi `otp_verify_locked`.
8. Nếu OTP đúng → cập nhật `user_providers.phone` bằng raw phone input và `is_verify_phone = true`.
9. Xóa cache OTP, cache số lần nhập sai và cache khóa verify.
10. Trả response thành công.

Response thành công:

```json
{
  "data": { "accountId": 123, "uuid": "550e8400-e29b-41d4-a716-446655440000", "phone": "0347566507", "verified": true },
  "status": "success", "code": 200, "message": "Xác thực mã OTP thành công"
}
```

## Section 4. Cấu hình Zalo Setting

Cấu hình nằm trong bảng `system_settings`, record có `key = zalo_setting`.

| Key | Kiểu | Mô tả |
|-----|------|-------|
| `endpoint` | string | Endpoint gửi template message Zalo. Mặc định hỗ trợ `https://business.openapi.zalo.me/message/template`. |
| `access_token` | string | Access token dùng để gọi API Zalo. |
| `refresh_token` | string | Refresh token dùng để cấp lại access token. |
| `app_id` | string | App ID Zalo, dùng khi refresh token. |
| `secret_key` | string | Secret key Zalo, dùng khi refresh token. |
| `template_id` | string | Template ID gửi OTP. |
| `template_otp_key` | string | Tên key OTP trong `template_data`, mặc định là `otp`. |
| `ttl_minutes` | integer | Số phút OTP có hiệu lực. |
| `cooldown` | integer | Số phút phải chờ trước khi gửi lại OTP theo `uuid`. Kiểm tra đầu luồng, set ngay khi request hợp lệ vào API, trước khi gọi Zalo. |
| `timeout` | integer | Timeout khi gọi API Zalo, tính bằng giây. |
| `expires_in` | timestamp | Thời điểm access token hết hạn. |
| `refresh_expires_in` | timestamp | Thời điểm refresh token hết hạn. |
| `send_message_enabled` | boolean | `true` gửi OTP thật qua Zalo; `false` trả OTP trong response để test. |
| `auto_refresh_token_enabled` | boolean | `true` thì scheduler được phép tự refresh access token. |
| `phone_verify_bypass_ips` | array | Danh sách IP/CIDR không cần xác thực OTP ở middleware verify phone. |
| `phone_change_lock_steps` | array | Khóa đổi số điện thoại theo bậc thang. Kiểm tra theo `uuid`. |
| `resend_lock_steps` | array | Khóa resend OTP theo bậc thang. Kiểm tra theo cặp `uuid + phone`. |
| `verify_lock_steps` | array | Khóa verify OTP theo bậc thang. Kiểm tra theo cặp `uuid + phone`. |

Ví dụ `phone_change_lock_steps` / `resend_lock_steps` / `verify_lock_steps` (cả ba cùng shape):

```json
[
  { "attempts": 5,  "lock_minutes": 1  },
  { "attempts": 10, "lock_minutes": 10 },
  { "attempts": 20, "lock_minutes": 60 }
]
```

**Ý nghĩa bậc khóa:**

- Với verify: lỗi lần thứ 5 khóa 1 phút; lỗi lần thứ 10 khóa 10 phút; lỗi lần thứ 20 khóa 60 phút.
- Với đổi số/resend: lần chạm bậc **vẫn trả OTP** nếu gửi thành công, đồng thời tạo khóa để chặn **request kế tiếp** trong thời gian cấu hình.
- Nếu chạm bậc cuối, hệ thống khóa theo bậc cuối.
- Khi chạm bậc cuối, **bộ đếm của nhóm đó được reset** để vòng tiếp theo quay lại từ bậc đầu.
- Trường `failedAttempts` trong response lỗi khóa là mốc `attempts` của bậc đang bị khóa, **không phải** tổng counter nội bộ.

## Section 5. Cấu hình trên Admin

Màn hình: `/admin/system-settings/{id}`. Với record `key = zalo_setting`, admin quản lý:

- JSON tổng ở trường `Giá trị (JSON)`.
- Các input/toggle tách riêng cho những key đang tồn tại trong JSON.
- Toggle `Gửi OTP qua Zalo` ↔ `send_message_enabled`.
- Toggle `Tự động refresh token Zalo` ↔ `auto_refresh_token_enabled`.
- Danh sách IP không cần xác thực OTP.
- Cấu hình `Bậc khóa khi đổi số điện thoại` / `Bậc khóa khi resend OTP` / `Bậc khóa khi nhập sai OTP`.
- Danh sách key có thể xóa khỏi JSON.

**Nguyên tắc hiển thị:** trường nào không tồn tại trong JSON thì không hiển thị input tương ứng,
trừ `phone_change_lock_steps`, `resend_lock_steps`, `verify_lock_steps` có thể được thêm mặc định.
JSON tổng vẫn hiển thị để admin kiểm tra đầy đủ dữ liệu.

## Section 6. Cơ chế cache

OTP hiện hành được cache theo **hash của `uuid`** sau khi normalize. Payload OTP vẫn lưu `phone` đã
normalize để bước verify bắt buộc khớp **cả `uuid + phone`**. Cache verify/resend tạo theo hash của
cặp `uuid + phone`; cache cooldown và đổi số điện thoại tạo theo hash của `uuid`.

| Cache | Mục đích |
|-------|----------|
| `zalo_phone_otp:{hash}` | OTP hiện hành theo `uuid`: `accountId`, `uuid`, `phone`, `trackingId`, `sentAt`. Gửi OTP cho số mới **ghi đè** OTP cũ cùng `uuid`. |
| `zalo_phone_otp_cooldown:{hash}` | Chặn gửi lại OTP trong thời gian cooldown theo `uuid`. |
| `zalo_phone_otp_resend_attempts:{hash}` | Đếm số lần resend OTP theo cặp `uuid + phone`. |
| `zalo_phone_otp_resend_lock:{hash}` | Trạng thái khóa resend OTP theo cặp `uuid + phone`. |
| `zalo_phone_otp_verify_attempts:{hash}` | Đếm số lần nhập sai OTP theo cặp `uuid + phone`. |
| `zalo_phone_otp_verify_lock:{hash}` | Trạng thái khóa verify OTP. |
| `zalo_phone_change_attempts:{hash}` | Đếm số lần đổi số điện thoại theo `uuid`. |
| `zalo_phone_change_lock:{hash}` | Trạng thái khóa đổi số điện thoại theo `uuid`. |

Khi verify OTP thành công, hệ thống xóa OTP cache theo `uuid`, cache resend, số lần nhập sai và lock
verify theo cặp `uuid + phone`.

## Section 7. Refresh token Zalo

Hai cách refresh access token:

1. Khi gửi OTP, nếu `expires_in` gần hết hạn, service tự refresh token trước khi gọi Zalo.
2. Scheduler chạy mỗi ngày lúc `03:00`, command `zalo:refresh-otp-token`; nếu `auto_refresh_token_enabled = true`
   và access token còn dưới 2 ngày thì refresh.

Khi refresh thành công, cập nhật lại: `access_token`, `refresh_token`, `expires_in` (+25 giờ từ thời
điểm refresh), `refresh_expires_in` (+3 tháng từ thời điểm refresh). Token mới lưu vào DB và đồng bộ
lại cache `zalo_setting` để request sau dùng ngay.

## Section 8. Mã lỗi (CONTRACT — nguồn chuẩn cho case Error)

| Code | errorCode | Rule | Message | Ý nghĩa |
|------|-----------|------|---------|---------|
| 400 | 30016 | `not_found` | Tài khoản không tồn tại | `uuid` không map được với `user_providers.provider_id`. |
| 400 | 30014 | `phone_already_verified` | Số điện thoại đã được xác thực | Account hiện tại đã verify phone, hoặc số điện thoại đã được verify bởi account khác. |
| 400 | 30025 | `otp_expired` | Mã OTP đã hết hạn hoặc không tồn tại | OTP cache không còn tồn tại; **tính vào** bộ đếm khóa verify. |
| 400 | 30026 | `otp_mismatch` | Thông tin xác thực OTP không khớp | Payload cache không khớp request; **tính vào** bộ đếm khóa verify. |
| 400 | 30027 | `otp_invalid` | Mã OTP không đúng | OTP sai nhưng chưa chạm bậc khóa; **tính vào** bộ đếm khóa verify. |
| 400 | 30018 | `otp_cooldown` | Vui lòng chờ trước khi gửi lại mã OTP | `uuid` còn cooldown gửi OTP. |
| 400 | 30019 | `phone_change_locked` | Bạn đã đổi số điện thoại quá nhiều lần, vui lòng thử lại sau | Account đang bị khóa đổi số theo bậc thang. |
| 400 | 30020 | `otp_resend_locked` | Bạn đã gửi lại OTP quá nhiều lần, vui lòng thử lại sau | Cặp `uuid + phone` đang bị khóa resend theo bậc thang. |
| 400 | 30028 | `otp_verify_locked` | Bạn đã nhập sai OTP quá nhiều lần, vui lòng thử lại sau | Cặp `uuid + phone` đang bị khóa verify theo bậc thang. |
| 400 | 30017 | `config_error` | Cấu hình Zalo OTP chưa đúng | Thiếu hoặc sai cấu hình Zalo. |
| 400 | 30021 | `refresh_config_error` | Cấu hình refresh token Zalo chưa đúng | Thiếu `refresh_token`, `app_id` hoặc `secret_key`. |
| 400 | 30022 | `refresh_token_expired` | Refresh token Zalo đã hết hạn hoặc sắp hết hạn | Refresh token không còn an toàn để refresh. |
| 400 | 30023 | `refresh_token_failed` | Refresh token Zalo thất bại | API Zalo refresh token trả lỗi. |
| 400 | 30024 | `send_otp_failed` | Gửi mã OTP qua Zalo thất bại | API Zalo gửi template message trả lỗi khác `-118`. |
| 400 | 30015 | `send_otp_failed` | Gửi mã OTP qua Zalo thất bại | Zalo trả `error = -118`, số điện thoại không tồn tại trên Zalo. |

Response lỗi cooldown (có countdown):

```json
{
  "status": "error", "code": 400, "errorCode": 30018,
  "message": "Vui lòng chờ trước khi gửi lại mã OTP",
  "module": "zalo", "rule": "otp_cooldown",
  "errors": { "lockedUntil": 1790000000, "remainingSeconds": 60, "remainingMinutes": 1 }
}
```

Response lỗi khóa đổi số / resend / verify (cùng shape, khác `errorCode` + `rule`):

```json
{
  "status": "error", "code": 400, "errorCode": 30019,
  "message": "Bạn đã đổi số điện thoại quá nhiều lần, vui lòng thử lại sau",
  "module": "zalo", "rule": "phone_change_locked",
  "errors": { "failedAttempts": 5, "lockMinutes": 1, "lockedUntil": 1790000000, "remainingSeconds": 60, "remainingMinutes": 1 }
}
```

- `phone_change_locked` → `errorCode 30019`
- `otp_resend_locked` → `errorCode 30020`
- `otp_verify_locked` → `errorCode 30028`

## Section 9. Ghi chú cho Frontend

- Nếu `send-zalo-otp` trả `otp` trong `data` → môi trường đang tắt gửi thật qua Zalo để test.
- Với `otp_cooldown`, `phone_change_locked`, `otp_resend_locked`, `otp_verify_locked`: FE dùng
  `errors.remainingSeconds` hoặc `errors.remainingMinutes` để hiển thị countdown.
- Với `errorCode = 30015`, FE có thể hiển thị thông báo số điện thoại không tồn tại trên Zalo.
- FE nên bắt lỗi nghiệp vụ bằng `errorCode` hoặc `rule`; HTTP `code` của các lỗi OTP là `400`.
- FE nên gửi lại đúng `uuid + phone` đã dùng ở bước gửi OTP khi gọi verify OTP.

## Section 10. Lịch sử thay đổi

- 2026-09-23 15:54:10 +07: Bổ sung `errorCode` riêng cho các lỗi của `phone/send-zalo-otp` và
  `phone/verify-zalo-otp`; các lỗi endpoint này trả HTTP `400`, FE phân biệt nghiệp vụ bằng `errorCode` hoặc `rule`.
- 2026-09-22 17:11:11 +07: OTP cache theo `uuid`, verify vẫn khớp `uuid + phone`; cooldown kiểm tra
  đầu luồng và set ngay khi request hợp lệ vào API trước khi gọi Zalo; đổi số/resend chạm bậc khóa
  vẫn trả OTP ở request hiện tại, khóa áp dụng cho request kế tiếp; verify tính bậc khóa cho
  `otp_expired`, `otp_mismatch`, `otp_invalid`; lỗi số đã verify đổi về `phone_already_verified`.
- 2026-09-22 13:47:13 +07: Cooldown tính theo `uuid`; resend tính theo cặp `uuid + phone`; bổ sung
  khóa bậc thang cho đổi số, resend, verify; bổ sung response countdown.
- 2026-09-21: Thêm tài liệu tổng quan tính năng verify số điện thoại qua Zalo.

## Section 11. Thuật ngữ

- **OTP:** mã xác thực dùng một lần, gồm 6 chữ số.
- **Raw phone:** số điện thoại đúng như người dùng nhập sau khi trim.
- **Normalized phone:** số điện thoại đã chuẩn hóa để gửi Zalo và tạo cache key.
- **`uuid`:** giá trị map với `user_providers.provider_id`.
- **`zalo_setting`:** record cấu hình Zalo OTP trong bảng `system_settings`.
