# Test case nghiệp vụ — Xác thực số điện thoại qua Zalo OTP

> Bản viết lại theo **ngôn ngữ nghiệp vụ** từ [ZALO-OTP.md](ZALO-OTP.md) (bản kỹ thuật).
> Cập nhật 2026-10-02 theo tài liệu "Verify mã OTP" (tailieu/8-verify-ma-otp.md) — xem mục 13b và mục 16.
> Giữ nguyên mã TC để đối chiếu 2 bản. Chi tiết API / cache / DB xem bản kỹ thuật.

---

## 1. Tính năng này làm gì?

Người dùng đăng nhập bằng tài khoản mạng xã hội cần **xác thực số điện thoại**. Luồng gồm 2 bước:

1. **Gửi mã:** người dùng nhập số điện thoại → hệ thống gửi **mã OTP 6 số** qua tin nhắn Zalo.
2. **Nhập mã:** người dùng nhập mã nhận được → nếu đúng, số điện thoại được lưu và đánh dấu **đã xác thực**.

Sau khi đã xác thực, tài khoản **không được** yêu cầu gửi mã nữa.

## 2. Thuật ngữ

| Thuật ngữ | Nghĩa dễ hiểu |
|---|---|
| **Thời gian chờ gửi lại** | Sau mỗi lần bấm "Gửi mã", phải chờ một khoảng thời gian mới được gửi tiếp (kể cả khi lần trước gửi lỗi). |
| **Thời hạn của mã** | Mã OTP chỉ dùng được trong X phút. Quá hạn thì mã hết hiệu lực. |
| **Gửi lại mã** | Gửi mã mới cho **cùng** số điện thoại vừa gửi trước đó. |
| **Đổi số** | Gửi mã cho một số điện thoại **khác** với số gần nhất. |
| **Khóa đổi số** | Đổi số quá nhiều lần thì tài khoản tạm thời không được đổi số. |
| **Khóa gửi lại** | Gửi lại mã cho cùng một số quá nhiều lần thì tạm thời bị chặn. |
| **Khóa nhập mã** | Nhập sai mã quá nhiều lần thì tạm thời không được nhập mã cho số đó. |
| **Admin cấu hình** | Màn hình quản trị để bật/tắt gửi Zalo, chỉnh số lần/thời gian khóa. |

### Quy tắc khóa (mặc định)

| Số lần | Thời gian khóa |
|---|---|
| Lần thứ 5 | 1 phút |
| Lần thứ 10 | 10 phút |
| Lần thứ 20 (bậc cuối) | 60 phút, sau đó **đếm lại từ đầu** |

> ⚠️ **Khác biệt quan trọng:**
> - **Đổi số / Gửi lại mã:** đến lần thứ 5 thì **lần đó vẫn gửi mã bình thường**, khóa bắt đầu từ lần **thứ 6**.
> - **Nhập sai mã:** sai đến lần thứ 5 thì **bị khóa ngay tại lần đó**.

### Ký hiệu

- **✅ Thành công** / **❌ Bị từ chối** — kết quả người dùng nhận được.
- **❓** — Chưa chốt được kết quả mong đợi, đang chờ BA/BE trả lời (xem mục 14).
- **⚠️** — Kết quả đã ghi nhưng phụ thuộc một điểm chưa được xác nhận (xem mục 14).
- ~~gạch ngang~~ = thông tin cũ đã thay; 🆕 = mới thêm (cập nhật 2026-10-02 theo tailieu/8-verify-ma-otp.md).
- **Cột "Nguồn tài liệu"** (cuối mỗi bảng case): cho biết kết quả mong đợi lấy từ tài liệu nào, dòng nào, kèm trích nguyên văn ngắn. Bấm vào link `L<số>` để tới đúng dòng. Tên viết tắt: **"SRS"** = `wiki/document/srs/ZALO-OTP.md`; **"Tài liệu 8"** = `tailieu/8-verify-ma-otp.md` (API verify); **"Tài liệu 7"** = `tailieu/7-send-ma-otp.md` (API gửi mã). Ô ghi "**Không có trong tài liệu**" hoặc "**Suy diễn**" nghĩa là QA tự bổ sung / suy ra, không có đoạn tài liệu trực tiếp — kèm căn cứ gần nhất.

---

## 3. Nhập thông tin khi gửi mã

| Mã TC | Tình huống | Điều kiện trước | Thao tác | Kết quả mong đợi | Nguồn tài liệu |
|---|---|---|---|---|---|
| TC-01 | Gửi mã với SĐT dạng `0xxx` | Tài khoản chưa có SĐT, chưa xác thực. Đang **tắt** gửi Zalo thật (môi trường test) | Nhập `0347566507` → Gửi mã | ✅ Báo *"Gửi mã OTP qua Zalo thành công"*, trả về mã OTP và thời hạn mã | [SRS L66](../../document/srs/ZALO-OTP.md#L66): "Response trả thêm trường `otp` để FE/QA test mà không spam Zalo."<br>[SRS L81-82](../../document/srs/ZALO-OTP.md#L81): `"expiresIn": 300`, `"message": "Gửi mã OTP qua Zalo thành công"` |
| TC-02 | Gửi mã với SĐT dạng `84xxx` | Tài khoản chưa xác thực | Nhập `84347566507` → Gửi mã | ✅ Chấp nhận là số hợp lệ | [SRS L44](../../document/srs/ZALO-OTP.md#L44): "bắt đầu bằng `0`, `84` hoặc `+84`" |
| TC-03 | Gửi mã với SĐT dạng `+84xxx` | Tài khoản chưa xác thực | Nhập `+84347566507` → Gửi mã | ✅ Chấp nhận là số hợp lệ | [SRS L44](../../document/srs/ZALO-OTP.md#L44): "bắt đầu bằng `0`, `84` hoặc `+84`" |
| TC-04 ❓ | Bỏ trống SĐT | Bất kỳ | Để trống SĐT → Gửi mã | ~~❌ Từ chối, không gửi mã *(mã lỗi chưa rõ — câu hỏi #6)*~~ → ❌ Từ chối, không gửi mã, có báo lỗi ở ô SĐT. *(Mã lỗi và nội dung thông báo chưa chốt — chờ câu hỏi #6)* | **Không có kết quả cụ thể trong SRS.** Căn cứ gần nhất: [SRS L44](../../document/srs/ZALO-OTP.md#L44) "Validate `phone` bắt buộc là số điện thoại Việt Nam hợp lệ".<br>Tham khảo, chưa dùng làm kỳ vọng: [Tài liệu 7 L24](../../../tailieu/7-send-ma-otp.md#L24) "Trả về khi `uuid` hoặc `phone` bị thiếu hoặc không đúng định dạng." |
| TC-05 | SĐT sai định dạng | Bất kỳ | Nhập `12345` → Gửi mã | ❌ Từ chối, không gửi mã *(mã lỗi chưa rõ — câu hỏi #6)* | **Không có kết quả cụ thể trong SRS.** Căn cứ gần nhất: [SRS L44](../../document/srs/ZALO-OTP.md#L44) "Validate `phone` bắt buộc là số điện thoại Việt Nam hợp lệ".<br>Tham khảo, chưa dùng làm kỳ vọng: [Tài liệu 7 L24](../../../tailieu/7-send-ma-otp.md#L24) và mẫu lỗi [L121-125](../../../tailieu/7-send-ma-otp.md#L121) |
| TC-06 ❓ | Thiếu mã tài khoản | — | Gửi yêu cầu để trống mã tài khoản | ~~❌ Từ chối *(mã lỗi chưa rõ — câu hỏi #6)*~~ → ❌ Từ chối, có báo lỗi ở mã tài khoản. *(Mã lỗi và nội dung thông báo chưa chốt — chờ câu hỏi #6)* | **Không có kết quả cụ thể trong SRS.** Căn cứ gần nhất: [SRS L43](../../document/srs/ZALO-OTP.md#L43) "Validate `uuid` bắt buộc là UUID hợp lệ."<br>Tham khảo, chưa dùng làm kỳ vọng: [Tài liệu 7 L24](../../../tailieu/7-send-ma-otp.md#L24) |
| TC-07 | Mã tài khoản sai định dạng | — | Gửi với mã tài khoản `not-a-uuid` | ❌ Từ chối *(mã lỗi chưa rõ — câu hỏi #6)* | **Không có kết quả cụ thể trong SRS.** Căn cứ gần nhất: [SRS L43](../../document/srs/ZALO-OTP.md#L43) "Validate `uuid` bắt buộc là UUID hợp lệ."<br>Tham khảo, chưa dùng làm kỳ vọng: [Tài liệu 7 L24](../../../tailieu/7-send-ma-otp.md#L24) |

## 4. Kiểm tra tài khoản và số điện thoại trùng

| Mã TC | Tình huống | Điều kiện trước | Thao tác | Kết quả mong đợi | Nguồn tài liệu |
|---|---|---|---|---|---|
| TC-08 | Tài khoản không tồn tại | Mã tài khoản đúng định dạng nhưng không có trong hệ thống | Gửi mã | ❌ Lỗi **không tìm thấy tài khoản** (30016) | [SRS L45](../../document/srs/ZALO-OTP.md#L45): "Kiểm tra account có tồn tại trong `user_providers.provider_id`."<br>[SRS L222](../../document/srs/ZALO-OTP.md#L222): 30016 "Tài khoản không tồn tại" |
| TC-09 | Tài khoản đã xác thực SĐT rồi | Tài khoản đã xác thực | Gửi mã | ❌ Lỗi **SĐT đã được xác thực** (30014) | [SRS L46](../../document/srs/ZALO-OTP.md#L46): "Nếu account đã có `is_verify_phone = true`, không cho gửi OTP nữa."<br>[Tài liệu 7 L26](../../../tailieu/7-send-ma-otp.md#L26): 30014 |
| TC-10 | SĐT đã được người khác xác thực | Số P1 đã được tài khoản B xác thực | Tài khoản A gửi mã cho số P1 | ❌ Lỗi **SĐT đã được xác thực** (30014) | [SRS L47](../../document/srs/ZALO-OTP.md#L47): "Kiểm tra số điện thoại đã được account khác sử dụng chưa."<br>[SRS L223](../../document/srs/ZALO-OTP.md#L223): "hoặc số điện thoại đã được verify bởi account khác." |
| TC-11 ❓ | Cùng số nhưng khác cách viết | Tài khoản B đã xác thực số `0347566507` | Tài khoản A gửi mã cho `84347566507` | QA đề xuất: ❌ vẫn phải phát hiện trùng (30014). **Chờ BE xác nhận** — câu hỏi #5 | Kỳ vọng là **đề xuất của QA** (chưa chốt). Căn cứ gần nhất: [SRS L29](../../document/srs/ZALO-OTP.md#L29): "so sánh theo các biến thể `0xxxxxxxxx`, `84xxxxxxxxx`, `+84xxxxxxxxx`." — SRS không nói rõ bước kiểm tra trùng ở gửi mã có áp đủ không |
| TC-12 | SĐT trùng nhưng người kia **chưa** xác thực | Tài khoản B có số P2 nhưng chưa xác thực | Tài khoản A gửi mã cho P2 | ✅ Vẫn gửi mã được (chỉ chặn khi số đã được **xác thực**) | **Suy diễn** từ [SRS L223](../../document/srs/ZALO-OTP.md#L223): lỗi chỉ nêu "số điện thoại đã được verify bởi account khác" — tài liệu không nói trực tiếp trường hợp người kia chưa xác thực |
| TC-13 | Không lộ thông tin người khác | 3 trường hợp: tài khoản không tồn tại / đã xác thực / số trùng người khác | Gửi mã lần lượt 3 trường hợp, so sánh phản hồi | ❌ Chỉ khác mã lỗi và thông báo. **Không** trả về tên, email, mã tài khoản của người khác | **Không có trong tài liệu** — QA bổ sung (kiểm thử bảo mật). Căn cứ gần nhất: bảng mã lỗi [SRS L222-223](../../document/srs/ZALO-OTP.md#L222) chỉ nêu mã và thông báo chung |

## 5. Gửi mã: lần đầu, gửi lại, đổi số

| Mã TC | Tình huống | Điều kiện trước | Thao tác | Kết quả mong đợi | Nguồn tài liệu |
|---|---|---|---|---|---|
| TC-14 | Gửi mã lần đầu | Tài khoản chưa có SĐT, chưa gửi mã lần nào | Gửi mã cho P1 | ✅ Nhận mã. Bắt đầu tính thời gian chờ gửi lại. **Không** tính là đổi số hay gửi lại | [SRS L141](../../document/srs/ZALO-OTP.md#L141): "Kiểm tra đầu luồng, set ngay khi request hợp lệ vào API, trước khi gọi Zalo."<br>[SRS L57-58](../../document/srs/ZALO-OTP.md#L57): đổi số / resend mới được cộng lượt |
| TC-15 | Gửi khi chưa hết thời gian chờ | Vừa gửi mã thành công | Gửi mã lại ngay | ❌ Lỗi **đang trong thời gian chờ** (30018), cho biết còn bao nhiêu giây/phút. Không bị tính thêm lượt | [Tài liệu 7 L54](../../../tailieu/7-send-ma-otp.md#L54): "nếu còn cooldown thì trả `otp_cooldown`."<br>[SRS L245](../../document/srs/ZALO-OTP.md#L245): `"remainingSeconds": 60, "remainingMinutes": 1`<br>[SRS L49](../../document/srs/ZALO-OTP.md#L49): "**không** tăng số lần resend/đổi số" |
| TC-16 | Đổi sang số khác | Đã gửi mã cho P1, hết thời gian chờ, chưa bị khóa đổi số | Gửi mã cho P2 | ✅ Nhận mã. SĐT tài khoản đổi thành P2, trạng thái về **chưa xác thực**. Tính **+1 lượt đổi số** | [SRS L55](../../document/srs/ZALO-OTP.md#L55): "nếu số điện thoại thay đổi thì reset `is_verify_phone = false`."<br>[SRS L57](../../document/srs/ZALO-OTP.md#L57): "Nếu là đổi số hợp lệ, tăng số lần đổi số theo `uuid`." |
| TC-17 | Đổi số khi đang bị khóa | Tài khoản đang bị khóa đổi số | Gửi mã cho số mới | ❌ Lỗi **đang bị khóa đổi số** (30019). Không gửi Zalo, không tính lượt | [SRS L228](../../document/srs/ZALO-OTP.md#L228): 30019 "Account đang bị khóa đổi số theo bậc thang."<br>"Không gửi Zalo, không tính lượt": **suy diễn** từ thứ tự [SRS L51-54](../../document/srs/ZALO-OTP.md#L51) (kiểm tra khóa trước khi gọi Zalo) |
| TC-18 | Số không dùng Zalo | Bật gửi Zalo thật. Chọn số chưa đăng ký Zalo | Gửi mã cho số đó | ❌ Lỗi **gửi OTP thất bại** (30015). SĐT tài khoản giữ nguyên, không tính lượt đổi số. **Vẫn bị tính thời gian chờ** | [SRS L89](../../document/srs/ZALO-OTP.md#L89): "(`error = -118`), API trả `errorCode = 30015`."<br>[SRS L90](../../document/srs/ZALO-OTP.md#L90): "Cooldown đã được set ngay khi request hợp lệ đi vào API."<br>[SRS L88](../../document/srs/ZALO-OTP.md#L88): không cập nhật `phone` khi Zalo thất bại |
| TC-19 | Zalo gặp lỗi khác | Giả lập Zalo lỗi hệ thống | Gửi mã | ❌ Lỗi **gửi OTP thất bại** (30024). Không đổi SĐT, không tính lượt. Vẫn tính thời gian chờ | [SRS L235](../../document/srs/ZALO-OTP.md#L235): 30024 "API Zalo gửi template message trả lỗi khác `-118`."<br>[SRS L88-90](../../document/srs/ZALO-OTP.md#L88): không cập nhật phone, không cộng lượt, cooldown vẫn set |
| TC-20 | Đổi số đến lần thứ 5 | Đã đổi số thành công 4 lần | Đổi số lần thứ 5 | ✅ **Lần này vẫn nhận mã**. Từ lần tiếp theo bị khóa đổi số 1 phút | [Tài liệu 7 L60](../../../tailieu/7-send-ma-otp.md#L60): "khi chạm bậc khóa thì tạo khóa cho request kế tiếp trong thời gian khóa"<br>[SRS L156](../../document/srs/ZALO-OTP.md#L156): bậc `"attempts": 5, "lock_minutes": 1` |
| TC-21 | Gửi lại mã cho cùng số | Đã gửi mã cho P1, chưa nhập mã, hết thời gian chờ | Gửi lại mã cho P1 | ✅ Nhận **mã mới** (mã cũ hết tác dụng). Tính **+1 lượt gửi lại**, không tính đổi số | [SRS L58](../../document/srs/ZALO-OTP.md#L58): "Nếu là resend, tăng số lần resend theo cặp `uuid + phone`."<br>[Tài liệu 7 L59](../../../tailieu/7-send-ma-otp.md#L59): "ghi đè OTP cũ của account đó." |
| TC-22 | Gửi lại khi đang bị khóa gửi lại | Số P1 của tài khoản đang bị khóa gửi lại | Gửi lại mã cho P1 | ❌ Lỗi **đang bị khóa gửi lại** (30020) | [SRS L229](../../document/srs/ZALO-OTP.md#L229): 30020 "Cặp `uuid + phone` đang bị khóa resend theo bậc thang." |
| TC-23 | Gửi lại nhưng Zalo lỗi | Giả lập Zalo lỗi | Gửi lại mã | ❌ Lỗi gửi thất bại (30015 hoặc 30024). Không tính lượt gửi lại. Vẫn tính thời gian chờ | [SRS L93](../../document/srs/ZALO-OTP.md#L93): "Nếu Zalo gửi lỗi thì không cộng lượt resend."<br>[SRS L235-236](../../document/srs/ZALO-OTP.md#L235): mã 30024 / 30015 |
| TC-24 | Gửi mã cho đúng số đang lưu | Tài khoản đang lưu P1, hết thời gian chờ | Gửi mã cho P1 | ✅ Nhận mã. **Không** tính đổi số | [SRS L92](../../document/srs/ZALO-OTP.md#L92): "hoặc cùng số đang lưu **không** bị cộng thêm vào bộ đếm đổi số." |
| TC-25 | Zalo lỗi rồi bấm gửi lại ngay | Tài khoản hợp lệ, giả lập Zalo lỗi | 1. Gửi mã (lỗi)<br>2. Gửi lại ngay | Bước 1: ❌ gửi thất bại (30024).<br>Bước 2: ❌ **đang trong thời gian chờ** (30018) — chứng minh thời gian chờ vẫn tính dù lần trước lỗi | [SRS L90](../../document/srs/ZALO-OTP.md#L90): "Cooldown đã được set ngay khi request hợp lệ đi vào API."<br>[SRS L227](../../document/srs/ZALO-OTP.md#L227): 30018 "`uuid` còn cooldown gửi OTP." |

## 6. Giới hạn số lần đổi số điện thoại

> Dùng **1 tài khoản** chạy liên tục từ TC-26 đến TC-35. Mỗi lần đổi số phải chờ hết thời gian chờ.

| Mã TC | Lần đổi số | Thao tác | Kết quả mong đợi | Nguồn tài liệu |
|---|---|---|---|---|
| TC-26 | Lần 4 | Đổi sang số mới | ✅ Nhận mã, chưa bị khóa | **Suy diễn** từ bậc đầu [SRS L156](../../document/srs/ZALO-OTP.md#L156) `"attempts": 5` (lần 4 chưa chạm bậc) |
| TC-27 | Lần 5 | Đổi sang số mới | ✅ **Vẫn nhận mã**. Bắt đầu khóa 1 phút cho lần sau | [SRS L165](../../document/srs/ZALO-OTP.md#L165): "lần chạm bậc **vẫn trả OTP** nếu gửi thành công"<br>[SRS L156](../../document/srs/ZALO-OTP.md#L156): `"attempts": 5, "lock_minutes": 1` |
| TC-28 | Lần 6 (ngay sau) | Đổi sang số mới | ❌ **Khóa đổi số** (30019). Báo: đã đổi 5 lần, khóa 1 phút, còn lại bao lâu | [SRS L168](../../document/srs/ZALO-OTP.md#L168): "là mốc `attempts` của bậc đang bị khóa"<br>[SRS L256](../../document/srs/ZALO-OTP.md#L256): `"failedAttempts": 5, "lockMinutes": 1, ... "remainingSeconds": 60` |
| TC-29 | Lần 9 (sau khi hết khóa) | Đổi sang số mới | ✅ Nhận mã, chưa bị khóa | **Suy diễn** từ bậc 2 [SRS L157](../../document/srs/ZALO-OTP.md#L157) `"attempts": 10` (lần 9 chưa chạm bậc) |
| TC-30 | Lần 10 | Đổi sang số mới | ✅ **Vẫn nhận mã**. Bắt đầu khóa 10 phút cho lần sau | [SRS L157](../../document/srs/ZALO-OTP.md#L157): `"attempts": 10, "lock_minutes": 10`<br>[SRS L165](../../document/srs/ZALO-OTP.md#L165): "lần chạm bậc **vẫn trả OTP**" |
| TC-31 | Lần 11 (ngay sau) | Đổi sang số mới | ❌ **Khóa đổi số** (30019). Báo: đã đổi 10 lần, khóa 10 phút | [SRS L157](../../document/srs/ZALO-OTP.md#L157): bậc 10 lần / 10 phút<br>[SRS L168](../../document/srs/ZALO-OTP.md#L168): `failedAttempts` là mốc bậc |
| TC-32 | Lần 19 (sau khi hết khóa) | Đổi sang số mới | ✅ Nhận mã, chưa bị khóa | **Suy diễn** từ bậc cuối [SRS L158](../../document/srs/ZALO-OTP.md#L158) `"attempts": 20` (lần 19 chưa chạm bậc) |
| TC-33 | Lần 20 (bậc cuối) | Đổi sang số mới | ✅ **Vẫn nhận mã**. Khóa 60 phút cho lần sau. Bộ đếm **về 0** | [SRS L158](../../document/srs/ZALO-OTP.md#L158): `"attempts": 20, "lock_minutes": 60`<br>[SRS L167](../../document/srs/ZALO-OTP.md#L167): "Khi chạm bậc cuối, **bộ đếm của nhóm đó được reset**" |
| TC-34 | Lần 21 (ngay sau) | Đổi sang số mới | ❌ **Khóa đổi số** (30019). Báo: **20 lần** (không phải 21), khóa 60 phút | [SRS L168](../../document/srs/ZALO-OTP.md#L168): "**không phải** tổng counter nội bộ."<br>[SRS L158](../../document/srs/ZALO-OTP.md#L158): 20 lần / 60 phút |
| TC-35 | Sau khi hết khóa 60 phút | Đổi số thêm 5 lần | 4 lần đầu ✅ bình thường. Lần thứ 5 mới bắt đầu khóa 1 phút → xác nhận **đã đếm lại từ đầu** | [SRS L167](../../document/srs/ZALO-OTP.md#L167): "để vòng tiếp theo quay lại từ bậc đầu."<br>[Tài liệu 7 L207](../../../tailieu/7-send-ma-otp.md#L207): bộ đếm reset khi chạm bậc cuối |

## 7. Giới hạn số lần gửi lại mã (cho cùng 1 số)

> Dùng **1 tài khoản + 1 số điện thoại** chạy liên tục từ TC-36 đến TC-45.

| Mã TC | Lần gửi lại | Thao tác | Kết quả mong đợi | Nguồn tài liệu |
|---|---|---|---|---|
| TC-36 | Lần 4 | Gửi lại mã | ✅ Nhận mã, chưa bị khóa | **Suy diễn** từ bậc đầu [SRS L156](../../document/srs/ZALO-OTP.md#L156) `"attempts": 5` (dùng chung cấu trúc cho resend, [SRS L152](../../document/srs/ZALO-OTP.md#L152)) |
| TC-37 | Lần 5 | Gửi lại mã | ✅ **Vẫn nhận mã**. Khóa 1 phút cho lần sau | [SRS L165](../../document/srs/ZALO-OTP.md#L165): "Với đổi số/resend: lần chạm bậc **vẫn trả OTP**"<br>[SRS L156](../../document/srs/ZALO-OTP.md#L156): 5 lần / 1 phút |
| TC-38 | Lần 6 (ngay sau) | Gửi lại mã | ❌ **Khóa gửi lại** (30020). Báo: 5 lần, khóa 1 phút | [SRS L229](../../document/srs/ZALO-OTP.md#L229): 30020 "Cặp `uuid + phone` đang bị khóa resend theo bậc thang."<br>[SRS L168](../../document/srs/ZALO-OTP.md#L168): `failedAttempts` là mốc bậc |
| TC-39 | Lần 9 (sau khi hết khóa) | Gửi lại mã | ✅ Nhận mã | **Suy diễn** từ bậc 2 [SRS L157](../../document/srs/ZALO-OTP.md#L157) `"attempts": 10` |
| TC-40 | Lần 10 | Gửi lại mã | ✅ **Vẫn nhận mã**. Khóa 10 phút cho lần sau | [SRS L157](../../document/srs/ZALO-OTP.md#L157): `"attempts": 10, "lock_minutes": 10`<br>[SRS L165](../../document/srs/ZALO-OTP.md#L165): lần chạm bậc vẫn trả OTP |
| TC-41 | Lần 11 (ngay sau) | Gửi lại mã | ❌ **Khóa gửi lại** (30020). Báo: 10 lần, khóa 10 phút | [SRS L229](../../document/srs/ZALO-OTP.md#L229): 30020<br>[SRS L157](../../document/srs/ZALO-OTP.md#L157): 10 lần / 10 phút |
| TC-42 | Lần 19 (sau khi hết khóa) | Gửi lại mã | ✅ Nhận mã | **Suy diễn** từ bậc cuối [SRS L158](../../document/srs/ZALO-OTP.md#L158) `"attempts": 20` |
| TC-43 | Lần 20 (bậc cuối) | Gửi lại mã | ✅ **Vẫn nhận mã**. Khóa 60 phút. Bộ đếm **về 0** | [SRS L158](../../document/srs/ZALO-OTP.md#L158): 20 lần / 60 phút<br>[SRS L167](../../document/srs/ZALO-OTP.md#L167): "**bộ đếm của nhóm đó được reset**" |
| TC-44 | Lần 21 (ngay sau) | Gửi lại mã | ❌ **Khóa gửi lại** (30020). Báo: 20 lần, khóa 60 phút | [SRS L229](../../document/srs/ZALO-OTP.md#L229): 30020<br>[SRS L168](../../document/srs/ZALO-OTP.md#L168): `failedAttempts` là mốc bậc, không phải counter nội bộ |
| TC-45 | Sau khi hết khóa 60 phút | Gửi lại 5 lần | 4 lần đầu ✅. Lần thứ 5 mới khóa 1 phút → **đã đếm lại từ đầu** | [SRS L167](../../document/srs/ZALO-OTP.md#L167): "để vòng tiếp theo quay lại từ bậc đầu." |

## 8. Giới hạn số lần nhập sai mã

> ⚠️ Khác 2 nhóm trên: **sai đến lần thứ 5 là bị khóa ngay tại lần đó**.
> Khi đang bị khóa, **nhập mã đúng cũng không được chấp nhận**.

| Mã TC | Tình huống | Thao tác | Kết quả mong đợi | Nguồn tài liệu |
|---|---|---|---|---|
| TC-46 | Sai lần 4 | Nhập mã sai | ~~❌ **Mã không đúng** (30027), chưa bị khóa~~ → ❌ **Mã không đúng** (30027), chưa bị khóa. Hệ thống báo kèm **số lần đã nhập sai = 4** *(cập nhật 2026-10-02; giá trị 4 là suy diễn từ mẫu "1 lần sai" trong tài liệu)* | [Tài liệu 8 L29](../../../tailieu/8-verify-ma-otp.md#L29): 30027 "Mã OTP gửi lên khác với mã OTP đang lưu trong cache."<br>[Tài liệu 8 L107](../../../tailieu/8-verify-ma-otp.md#L107): `"failedAttempts": 1` — mẫu chỉ có giá trị 1, giá trị 4 là **suy diễn** |
| TC-47 | Sai lần 5 | Nhập mã sai | ❌ **Bị khóa nhập mã ngay** (30028). Báo: 5 lần, khóa 1 phút | [SRS L113](../../document/srs/ZALO-OTP.md#L113): "chạm bậc khóa trong `verify_lock_steps` → khóa verify theo số phút cấu hình"<br>[SRS L164](../../document/srs/ZALO-OTP.md#L164): "lỗi lần thứ 5 khóa 1 phút" |
| TC-48 | Đang bị khóa, nhập **mã đúng** | Nhập mã đúng (mã vẫn còn hạn) | ❌ Vẫn **bị khóa** (30028) — hệ thống kiểm tra khóa trước khi kiểm tra mã | [SRS L108-109](../../document/srs/ZALO-OTP.md#L108): bước 2 "Kiểm tra cặp `uuid + phone` có đang bị khóa verify OTP không." đứng trước bước 3 lấy OTP<br>[Tài liệu 8 L30](../../../tailieu/8-verify-ma-otp.md#L30): 30028 |
| TC-49 | Sai lần 9 (sau khi hết khóa) | Nhập mã sai | ~~❌ **Mã không đúng** (30027), chưa khóa~~ → ❌ **Mã không đúng** (30027), chưa khóa. Báo kèm số lần đã sai = 9 *(cập nhật 2026-10-02; suy diễn từ mẫu trong tài liệu)* | [SRS L226](../../document/srs/ZALO-OTP.md#L226): 30027 "OTP sai nhưng chưa chạm bậc khóa"<br>[Tài liệu 8 L107](../../../tailieu/8-verify-ma-otp.md#L107): `"failedAttempts": 1` — giá trị 9 là **suy diễn** |
| TC-50 | Sai lần 10 | Nhập mã sai | ❌ **Bị khóa ngay** (30028). Báo: 10 lần, khóa 10 phút | [SRS L164](../../document/srs/ZALO-OTP.md#L164): "lỗi lần thứ 10 khóa 10 phút"<br>[Tài liệu 8 L150](../../../tailieu/8-verify-ma-otp.md#L150): `{"attempts":10,"lock_minutes":10}` |
| TC-51 | Đang khóa 10 phút, nhập mã đúng | Nhập mã đúng | ❌ Vẫn bị khóa (30028) | [SRS L108](../../document/srs/ZALO-OTP.md#L108): kiểm tra khóa verify trước khi lấy OTP<br>[Tài liệu 8 L30](../../../tailieu/8-verify-ma-otp.md#L30): 30028 |
| TC-52 | Sai lần 19 (sau khi hết khóa) | Nhập mã sai | ~~❌ **Mã không đúng** (30027), chưa khóa~~ → ❌ **Mã không đúng** (30027), chưa khóa. Báo kèm số lần đã sai = 19 *(cập nhật 2026-10-02; suy diễn từ mẫu trong tài liệu)* | [SRS L226](../../document/srs/ZALO-OTP.md#L226): 30027 "OTP sai nhưng chưa chạm bậc khóa"<br>[Tài liệu 8 L107](../../../tailieu/8-verify-ma-otp.md#L107): `"failedAttempts": 1` — giá trị 19 là **suy diễn** |
| TC-53 | Sai lần 20 (bậc cuối) | Nhập mã sai | ❌ **Bị khóa ngay** (30028). Báo: 20 lần, khóa 60 phút. Bộ đếm **về 0** | [SRS L164](../../document/srs/ZALO-OTP.md#L164): "lỗi lần thứ 20 khóa 60 phút."<br>[Tài liệu 8 L151](../../../tailieu/8-verify-ma-otp.md#L151): "Khi chạm bậc cuối, bộ đếm verify được reset" |
| TC-54 | Đang khóa 60 phút, nhập mã đúng | Nhập mã đúng | ❌ Vẫn bị khóa (30028) | [SRS L108](../../document/srs/ZALO-OTP.md#L108): kiểm tra khóa verify trước khi lấy OTP<br>[Tài liệu 8 L30](../../../tailieu/8-verify-ma-otp.md#L30): 30028 |
| TC-55 | Sau khi hết khóa 60 phút | Gửi mã mới, nhập sai 5 lần | 4 lần đầu ❌ mã không đúng. Lần 5 mới bị khóa 1 phút → **đã đếm lại từ đầu** | [Tài liệu 8 L151](../../../tailieu/8-verify-ma-otp.md#L151): "bộ đếm verify được reset để vòng tiếp theo quay lại từ bậc đầu."<br>[SRS L167](../../document/srs/ZALO-OTP.md#L167) |

## 9. Nhập mã OTP

| Mã TC | Tình huống | Điều kiện trước | Thao tác | Kết quả mong đợi | Nguồn tài liệu |
|---|---|---|---|---|---|
| TC-56 | Mã đã hết hạn | Đã gửi mã, chờ quá thời hạn | Nhập mã | ❌ **Mã đã hết hạn** (30025). Tính 1 lần sai | [SRS L110](../../document/srs/ZALO-OTP.md#L110): "Nếu OTP không tồn tại hoặc hết hạn → tăng số lần lỗi verify"<br>[Tài liệu 8 L27](../../../tailieu/8-verify-ma-otp.md#L27): 30025 "Lỗi này được tính vào bộ đếm khóa verify" |
| TC-57 | Nhập mã cho số khác số vừa gửi | Gửi mã cho số A | Nhập mã kèm số B | ❌ **Mã không khớp** (30026). Tính 1 lần sai | [SRS L111](../../document/srs/ZALO-OTP.md#L111): "Nếu payload cache không khớp `uuid` hoặc `phone` → tăng số lần lỗi verify"<br>[Tài liệu 8 L28](../../../tailieu/8-verify-ma-otp.md#L28): 30026 |
| TC-58 | Nhập mã khi chưa từng gửi mã | Tài khoản chưa bấm gửi mã lần nào | Nhập mã bất kỳ | ❌ **Mã đã hết hạn** (30025) | [Tài liệu 8 L27](../../../tailieu/8-verify-ma-otp.md#L27): 30025 "Trả về khi không tìm thấy OTP cache hiện hành theo `uuid`." |
| TC-59 | **Nhập mã đúng** | Vừa nhận mã cho P1, còn hạn | Nhập đúng mã | ✅ **Xác thực thành công**. Tài khoản lưu SĐT P1, trạng thái **đã xác thực**. ~~Xóa số lần sai và khóa nhập mã của số này~~ → Xóa mã OTP, xóa số lần sai và khóa nhập mã của số này, **xóa luôn bộ đếm gửi lại mã** *(cập nhật 2026-10-02)* | [SRS L114](../../document/srs/ZALO-OTP.md#L114): "cập nhật `user_providers.phone` bằng raw phone input và `is_verify_phone = true`."<br>[Tài liệu 8 L40](../../../tailieu/8-verify-ma-otp.md#L40): "xóa OTP cache theo `uuid`, cache resend và cache verify theo cặp `uuid + phone`." |
| TC-60 ⚠️ | ~~Dùng lại mã vừa xác thực~~ → Nhập mã lại sau khi đã xác thực thành công | Ngay sau TC-59 (tài khoản đã xác thực) | Nhập lại mã cũ | ~~❌ **Mã đã hết hạn** (30025) — mỗi mã chỉ dùng 1 lần~~ → ❌ **Tài khoản đã được xác thực** (30029). *(Sửa theo tài liệu 2026-10-02)* ⚠️ **Phụ thuộc câu hỏi #8** (thứ tự kiểm tra chưa được xác nhận) | [Tài liệu 8 L25](../../../tailieu/8-verify-ma-otp.md#L25): 30029 "Trả về khi account theo `uuid` đã có `is_verify_phone = true`"<br>[Tài liệu 8 L137](../../../tailieu/8-verify-ma-otp.md#L137): lịch sử "`account_already_verified` khi account đã xác thực"<br>Thứ tự so với các kiểm tra khác: tài liệu không nêu (câu hỏi #8) |
| TC-61 | Nhập mã sát giờ hết hạn | Chỉnh thời hạn mã ngắn để test | Nhập mã đúng khi còn 1–2 giây | ✅ Xác thực thành công | **Suy diễn** (kỹ thuật kiểm thử giá trị biên). Căn cứ gần nhất: [SRS L140](../../document/srs/ZALO-OTP.md#L140): `ttl_minutes` "Số phút OTP có hiệu lực." |
| TC-62 | Nhập mã ngay sau khi hết hạn | Như trên | Nhập mã đúng ngay khi vừa hết hạn | ❌ **Mã đã hết hạn** (30025) | [SRS L110](../../document/srs/ZALO-OTP.md#L110): "Nếu OTP không tồn tại hoặc hết hạn"<br>[SRS L140](../../document/srs/ZALO-OTP.md#L140): `ttl_minutes` |
| TC-63 | Đổi số rồi nhập mã của số cũ | Gửi mã cho A, sau đó đổi số sang B | Nhập mã cũ kèm số A | ❌ **Mã không khớp** (30026) — mã của A đã bị thay bằng mã của B | [Tài liệu 7 L59](../../../tailieu/7-send-ma-otp.md#L59): "ghi đè OTP cũ của account đó."<br>[SRS L111](../../document/srs/ZALO-OTP.md#L111): payload cache không khớp `phone` → `otp_mismatch` |
| TC-64 | Bấm gửi mã 2 lần cùng lúc | Tài khoản chưa gửi mã lần nào | Gửi 2 yêu cầu cùng lúc (2 số khác nhau) | Chỉ 1 yêu cầu thành công. Yêu cầu còn lại bị **thời gian chờ** (30018). Không có 2 mã song song | **Không có trong tài liệu** — QA bổ sung (kiểm thử đồng thời / race condition). Căn cứ gần nhất: [Tài liệu 7 L54](../../../tailieu/7-send-ma-otp.md#L54) "nếu còn cooldown thì trả `otp_cooldown`." |
| TC-65 | Đổi số qua lại A → B → A | Tài khoản chưa có SĐT | Đổi số lần lượt A, B, A (chờ hết thời gian chờ mỗi lần) | Cả 3 lần đều tính là đổi số → đếm = 3 | [SRS L91](../../document/srs/ZALO-OTP.md#L91): "target phone **khác** target đổi số gần nhất thì mới cộng thêm lượt đổi số." |
| TC-66 | Đoán mã liên tục (brute-force) | Đã gửi mã | Nhập sai liên tục nhiều lần | ❌ **Bị khóa ngay lần thứ 5** (30028) — không thể đoán hết 1 triệu tổ hợp | **Không có trong tài liệu** — QA bổ sung (kiểm thử bảo mật). Căn cứ gần nhất: [SRS L164](../../document/srs/ZALO-OTP.md#L164) "lỗi lần thứ 5 khóa 1 phút" |
| TC-67 ❓ | Đổi số để "né" khóa nhập mã | Số A đã nhập sai 4 lần | 1. Đổi sang số B<br>2. Nhập sai mã cho B | Theo spec hiện tại: số B bắt đầu đếm lại từ 0 → có thể **né khóa** bằng cách đổi số. **Rủi ro bảo mật, chờ BA/Security quyết định** — câu hỏi #7 | **Không có trong tài liệu** — QA phát hiện rủi ro, suy ra từ thiết kế. Căn cứ: [SRS L150](../../document/srs/ZALO-OTP.md#L150) `verify_lock_steps` "Kiểm tra theo cặp `uuid + phone`." |
| TC-68 | Không lộ tài khoản có tồn tại hay không | Mã tài khoản không có trong hệ thống | Nhập mã | ❌ **Mã đã hết hạn** (30025) — **giống hệt** TC-58, không để lộ tài khoản có tồn tại | **Suy diễn** (kiểm thử bảo mật) từ [Tài liệu 8 L27](../../../tailieu/8-verify-ma-otp.md#L27): 30025 khi "không tìm thấy OTP cache hiện hành theo `uuid`" — tài liệu không nêu riêng trường hợp tài khoản không tồn tại |
| TC-69 | Đã xác thực rồi thì không gửi mã nữa | Tài khoản vừa xác thực thành công | Gửi mã | ❌ **SĐT đã được xác thực** (30014) | [SRS L46](../../document/srs/ZALO-OTP.md#L46): "Nếu account đã có `is_verify_phone = true`, không cho gửi OTP nữa."<br>[Tài liệu 7 L26](../../../tailieu/7-send-ma-otp.md#L26): 30014 |
| TC-70 | **Luồng đầy đủ từ đầu đến cuối** | Tài khoản mới, chưa xác thực | 1. Gửi mã<br>2. Nhập sai 4 lần<br>3. Nhập sai lần 5<br>4. Chờ 1 phút<br>5. Gửi mã mới, nhập đúng<br>6. Gửi mã lại | 1. ✅ Nhận mã<br>2. ❌ Mã không đúng ×4<br>3. ❌ Bị khóa<br>4–5. ✅ Xác thực thành công<br>6. ❌ SĐT đã được xác thực | **Suy diễn** (kịch bản E2E ghép nhiều bước): [SRS L112-115](../../document/srs/ZALO-OTP.md#L112) (sai → khóa → đúng), [SRS L164](../../document/srs/ZALO-OTP.md#L164) (5 lần khóa 1 phút), [SRS L46](../../document/srs/ZALO-OTP.md#L46) (đã xác thực thì không gửi nữa) |

## 10. Màn hình Admin cấu hình Zalo

| Mã TC | Tình huống | Điều kiện trước | Thao tác | Kết quả mong đợi | Nguồn tài liệu |
|---|---|---|---|---|---|
| TC-71 | Xem cấu hình | Đăng nhập Admin, đã có cấu hình Zalo | Mở trang cấu hình Zalo | Hiện đầy đủ JSON cấu hình. Chỉ hiện ô nhập/nút bật tắt cho mục **có trong** cấu hình | [SRS L174-175](../../document/srs/ZALO-OTP.md#L174): "JSON tổng ở trường `Giá trị (JSON)`." / "Các input/toggle tách riêng cho những key đang tồn tại trong JSON." |
| TC-72 | Bật/tắt "Gửi OTP qua Zalo" | Đang bật | Tắt → Lưu → tải lại trang | Lưu thành công, trạng thái **tắt** được giữ nguyên | [SRS L176](../../document/srs/ZALO-OTP.md#L176): "Toggle `Gửi OTP qua Zalo` ↔ `send_message_enabled`." |
| TC-73 | Bật/tắt "Tự động refresh token Zalo" | Đang ở màn cấu hình | Đổi trạng thái → Lưu | Lưu thành công, giá trị đúng | [SRS L177](../../document/srs/ZALO-OTP.md#L177): "Toggle `Tự động refresh token Zalo` ↔ `auto_refresh_token_enabled`." |
| TC-74 | Sửa số lần / thời gian khóa | Có cấu hình 3 nhóm khóa | Sửa mỗi nhóm 1 bậc (vd khóa nhập mã từ 5 → 3 lần) → Lưu → mở lại | Giá trị mới được lưu | [SRS L179](../../document/srs/ZALO-OTP.md#L179): "Cấu hình `Bậc khóa khi đổi số điện thoại` / `Bậc khóa khi resend OTP` / `Bậc khóa khi nhập sai OTP`." |
| TC-75 | Ẩn mục không có trong cấu hình | Cấu hình **không có** danh sách IP bỏ qua OTP | Mở màn cấu hình | **Không hiện** ô "Danh sách IP không cần xác thực OTP" | [SRS L182](../../document/srs/ZALO-OTP.md#L182): "trường nào không tồn tại trong JSON thì không hiển thị input tương ứng" |
| TC-76 | 3 nhóm khóa luôn hiện | Cấu hình **không có** 3 nhóm khóa | Mở màn cấu hình | 3 nhóm khóa **vẫn hiện** với giá trị mặc định (ngoại lệ của TC-75) | [SRS L183](../../document/srs/ZALO-OTP.md#L183): "trừ `phone_change_lock_steps`, `resend_lock_steps`, `verify_lock_steps` có thể được thêm mặc định." |
| TC-77 | Hỗ trợ người khuyết tật | Mở màn cấu hình | Quét bằng công cụ axe | Không có lỗi nghiêm trọng. Nút bật tắt và ô nhập đều có nhãn | **Không có trong tài liệu** — QA bổ sung (kiểm thử khả năng tiếp cận). Căn cứ gần nhất: màn hình Admin tại [SRS L172](../../document/srs/ZALO-OTP.md#L172) |
| TC-78 | Dùng hoàn toàn bằng bàn phím | Mở màn cấu hình | Dùng phím Tab đi qua tất cả nút, bảng, nút Lưu | Thao tác được hết, thấy rõ vị trí đang chọn, không bị kẹt | **Không có trong tài liệu** — QA bổ sung (kiểm thử khả năng tiếp cận). Căn cứ gần nhất: màn hình Admin tại [SRS L172](../../document/srs/ZALO-OTP.md#L172) |

## 11. Token kết nối Zalo

| Mã TC | Tình huống | Điều kiện trước | Thao tác | Kết quả mong đợi | Nguồn tài liệu |
|---|---|---|---|---|---|
| TC-79 | Token sắp hết hạn khi gửi mã | Token sắp hết hạn, cấu hình refresh đầy đủ | Gửi mã | ✅ Hệ thống tự làm mới token rồi gửi mã. Token mới dùng được 25 giờ, token refresh dùng được 3 tháng | [SRS L210](../../document/srs/ZALO-OTP.md#L210): "nếu `expires_in` gần hết hạn, service tự refresh token trước khi gọi Zalo."<br>[SRS L214](../../document/srs/ZALO-OTP.md#L214): "`expires_in` (+25 giờ từ thời" / [L215](../../document/srs/ZALO-OTP.md#L215) "`refresh_expires_in` (+3 tháng từ thời điểm refresh)" |
| TC-80 | Thiếu cấu hình để làm mới token | Thiếu refresh token / app id / secret key; token sắp hết hạn | Gửi mã | ❌ **Lỗi cấu hình refresh** (30021), không gửi mã | [SRS L232](../../document/srs/ZALO-OTP.md#L232): 30021 "Thiếu `refresh_token`, `app_id` hoặc `secret_key`."<br>[Tài liệu 7 L31](../../../tailieu/7-send-ma-otp.md#L31) |
| TC-81 | Refresh token đã hết hạn | Refresh token quá hạn | Gửi mã | ❌ **Refresh token hết hạn** (30022) | [SRS L233](../../document/srs/ZALO-OTP.md#L233): 30022 "Refresh token không còn an toàn để refresh."<br>[Tài liệu 7 L32](../../../tailieu/7-send-ma-otp.md#L32): "khi `refresh_expires_in` đã gần hết hạn hoặc hết hạn" |
| TC-82 | Zalo từ chối làm mới token | Giả lập Zalo lỗi khi làm mới | Gửi mã | ❌ **Làm mới token thất bại** (30023) | [SRS L234](../../document/srs/ZALO-OTP.md#L234): 30023 "API Zalo refresh token trả lỗi."<br>[Tài liệu 7 L33](../../../tailieu/7-send-ma-otp.md#L33) |
| TC-83 | Thiếu cấu hình Zalo cơ bản | Thiếu địa chỉ API / mẫu tin / token | Gửi mã | ❌ **Lỗi cấu hình** (30017) | [SRS L231](../../document/srs/ZALO-OTP.md#L231): 30017 "Thiếu hoặc sai cấu hình Zalo."<br>[Tài liệu 7 L30](../../../tailieu/7-send-ma-otp.md#L30) |
| TC-84 | Tác vụ tự động 3h sáng làm mới token | Bật tự động refresh, token còn dưới 2 ngày | Chạy tác vụ (hoặc chờ 03:00) | ✅ Token được làm mới. Lần gửi mã tiếp theo dùng ngay token mới | [SRS L211-212](../../document/srs/ZALO-OTP.md#L211): "Scheduler chạy mỗi ngày lúc `03:00`" ... "access token còn dưới 2 ngày thì refresh."<br>[SRS L216](../../document/srs/ZALO-OTP.md#L216): "đồng bộ lại cache `zalo_setting` để request sau dùng ngay." |
| TC-85 | Tắt tự động refresh | Tắt tự động refresh, token sắp hết hạn | Chạy tác vụ | Token **không** được làm mới | **Suy diễn** từ [SRS L211-212](../../document/srs/ZALO-OTP.md#L211): chỉ refresh "nếu `auto_refresh_token_enabled = true`"; [Tài liệu 7 L209](../../../tailieu/7-send-ma-otp.md#L209): "`false` là bỏ qua." |
| TC-86 | Token còn dài hạn | Bật tự động refresh, token còn trên 2 ngày | Chạy tác vụ | Token **không** được làm mới (chưa cần) | [SRS L212](../../document/srs/ZALO-OTP.md#L212): "access token còn dưới 2 ngày thì refresh." (suy ra: trên 2 ngày thì không) |

## 12. Tốc độ phản hồi

| Mã TC | Tình huống | Điều kiện trước | Thao tác | Kết quả mong đợi | Nguồn tài liệu |
|---|---|---|---|---|---|
| TC-87 | Tốc độ gửi mã | Tắt gửi Zalo thật, tải nhẹ | Gửi mã, đo thời gian | Phản hồi dưới ngưỡng đã thống nhất (vd < 2 giây) | **Không có trong tài liệu** — QA bổ sung (kiểm thử hiệu năng sơ bộ), ngưỡng chưa được thống nhất. Căn cứ gần nhất: [SRS L64-66](../../document/srs/ZALO-OTP.md#L64) (chế độ tắt gửi Zalo thật) |
| TC-88 | Tốc độ nhập mã | Có mã còn hạn | Nhập mã, đo thời gian | Phản hồi dưới ngưỡng (vd < 1 giây) | **Không có trong tài liệu** — QA bổ sung (kiểm thử hiệu năng sơ bộ), ngưỡng chưa được thống nhất. Căn cứ gần nhất: luồng verify [SRS L105-116](../../document/srs/ZALO-OTP.md#L105) |
| TC-89 | Zalo phản hồi quá chậm | Giả lập Zalo chậm hơn thời gian chờ tối đa | Gửi mã | ❌ Không bị treo; báo **gửi thất bại** (30024) sau khoảng thời gian chờ tối đa | **Suy diễn.** Căn cứ: [SRS L142](../../document/srs/ZALO-OTP.md#L142): `timeout` "Timeout khi gọi API Zalo, tính bằng giây."; [SRS L235](../../document/srs/ZALO-OTP.md#L235): 30024 khi Zalo trả lỗi khác `-118`. Tài liệu không nói rõ timeout trả mã 30024 |

## 13. Chuẩn hóa số điện thoại

| Mã TC | Tình huống | Điều kiện trước | Thao tác | Kết quả mong đợi | Nguồn tài liệu |
|---|---|---|---|---|---|
| TC-90 | SĐT có khoảng trắng | Tài khoản chưa có SĐT | Nhập `"  0347566507  "` → Gửi mã | Hệ thống lưu `0347566507` (bỏ khoảng trắng). Khi gửi sang Zalo dùng dạng `84347566507` | [SRS L27](../../document/srs/ZALO-OTP.md#L27): "`0347566507` → `84347566507`."<br>[SRS L28](../../document/srs/ZALO-OTP.md#L28): "hệ thống lưu **raw input sau khi trim**" |

## 13b. 🆕 Kiểm tra dữ liệu và trường hợp đặc biệt khi nhập mã (cập nhật 2026-10-02)

> Theo tài liệu "Verify mã OTP" ngày 02/10/2026. Mã OTP phải gồm **đúng 6 chữ số**. Nhập thiếu/sai dữ liệu được báo **Lỗi dữ liệu** (11000). Việc có tính là 1 lần nhập sai hay không tài liệu chưa nêu (câu hỏi #8).

| Mã TC | Tình huống | Điều kiện trước | Thao tác | Kết quả mong đợi | Nguồn tài liệu |
|---|---|---|---|---|---|
| 🆕 TC-91 | Bỏ trống mã OTP | Bất kỳ | Để trống mã → Xác nhận | ❌ **Lỗi dữ liệu** (11000), có báo lỗi ở ô mã OTP. Có tính là lần nhập sai hay không: **chưa xác nhận** (câu hỏi #8) | [Tài liệu 8 L24](../../../tailieu/8-verify-ma-otp.md#L24): 11000 "Trả về khi `uuid`, `phone` hoặc `otp` bị thiếu hoặc không đúng định dạng."<br>Việc tính vào bộ đếm: tài liệu không nêu (liệt kê chỉ 30025/30026/30027 ở [L27-29](../../../tailieu/8-verify-ma-otp.md#L27)) |
| 🆕 TC-92 | Mã OTP thiếu số (5 số) | Đã gửi mã | Nhập `12345` | ❌ **Lỗi dữ liệu** (11000): *"Mã OTP phải gồm 6 chữ số"* | [Tài liệu 8 L48](../../../tailieu/8-verify-ma-otp.md#L48): "Mã OTP gồm đúng 6 chữ số."<br>[Tài liệu 8 L88](../../../tailieu/8-verify-ma-otp.md#L88): `"message": "Mã OTP phải gồm 6 chữ số"` |
| 🆕 TC-93 | Mã OTP thừa số (7 số) | Đã gửi mã | Nhập `1234567` | ❌ **Lỗi dữ liệu** (11000): *"Mã OTP phải gồm 6 chữ số"* | [Tài liệu 8 L48](../../../tailieu/8-verify-ma-otp.md#L48): "Mã OTP gồm đúng 6 chữ số."<br>[Tài liệu 8 L88](../../../tailieu/8-verify-ma-otp.md#L88): `"message": "Mã OTP phải gồm 6 chữ số"` |
| 🆕 TC-94 | Mã OTP có chữ cái | Đã gửi mã | Nhập `12a456` | ❌ **Lỗi dữ liệu** (11000): *"Mã OTP phải gồm 6 chữ số"* | [Tài liệu 8 L88](../../../tailieu/8-verify-ma-otp.md#L88): `"message": "Mã OTP phải gồm 6 chữ số"`, rule `regex` ([L87](../../../tailieu/8-verify-ma-otp.md#L87))<br>[Tài liệu 8 L48](../../../tailieu/8-verify-ma-otp.md#L48): "Mã OTP gồm đúng 6 chữ số." |
| 🆕 TC-95 | Thiếu mã tài khoản khi nhập mã | — | Gửi yêu cầu nhập mã không có mã tài khoản | ❌ **Lỗi dữ liệu** (11000), báo lỗi ở mã tài khoản | [Tài liệu 8 L24](../../../tailieu/8-verify-ma-otp.md#L24): 11000 khi "`uuid`, `phone` hoặc `otp` bị thiếu"<br>[Tài liệu 8 L46](../../../tailieu/8-verify-ma-otp.md#L46): `uuid` Required "Có" |
| 🆕 TC-96 | Mã tài khoản sai định dạng khi nhập mã | — | Gửi với mã tài khoản `not-a-uuid` | ❌ **Lỗi dữ liệu** (11000), báo lỗi ở mã tài khoản | [Tài liệu 8 L24](../../../tailieu/8-verify-ma-otp.md#L24): 11000 khi "bị thiếu hoặc không đúng định dạng."<br>[Tài liệu 8 L46](../../../tailieu/8-verify-ma-otp.md#L46): "UUID của account đã dùng khi gửi OTP." |
| 🆕 TC-97 | SĐT sai định dạng khi nhập mã | Đã gửi mã | Nhập mã kèm SĐT `12345` | ❌ **Lỗi dữ liệu** (11000), báo lỗi ở SĐT. Có tính là lần nhập sai hay không: **chưa xác nhận** (câu hỏi #8) | [Tài liệu 8 L24](../../../tailieu/8-verify-ma-otp.md#L24): 11000 khi "bị thiếu hoặc không đúng định dạng."<br>[Tài liệu 8 L47](../../../tailieu/8-verify-ma-otp.md#L47): "chấp nhận định dạng bắt đầu bằng `0`, `84` hoặc `+84`."<br>Việc tính vào bộ đếm: tài liệu không nêu |
| 🆕 TC-98 | SĐT đã được người khác xác thực xong | Tài khoản A đã nhận mã cho số P1. Trong lúc đó tài khoản B xác thực xong số P1 | A nhập đúng mã cho số P1 | ❌ **SĐT đã được xác thực** (30014). Tài khoản A vẫn **chưa** xác thực | [Tài liệu 8 L26](../../../tailieu/8-verify-ma-otp.md#L26): 30014 "Trả về khi `phone` đã được verify bởi account khác"<br>[Tài liệu 8 L137](../../../tailieu/8-verify-ma-otp.md#L137): "`phone_already_verified` khi số điện thoại đã được account khác xác thực"<br>Cách dựng tình huống (A gửi mã trước khi B xác thực xong) là QA bố trí |
| 🆕 TC-99 ⚠️ | Vừa đã xác thực vừa trùng số người khác | Tài khoản A đã xác thực số P1. Số P2 đã được tài khoản B xác thực | A nhập mã kèm số P2 | ❌ **Tài khoản đã được xác thực** (30029) — **không phải** 30014 (kiểm tra tài khoản trước). ⚠️ **Phụ thuộc câu hỏi #8** (thứ tự kiểm tra so với khóa nhập mã chưa xác nhận; giả định cặp này không đang bị khóa) | [Tài liệu 8 L25](../../../tailieu/8-verify-ma-otp.md#L25): "Rule này được ưu tiên kiểm tra trước rule số điện thoại đã được xác thực."<br>[Tài liệu 8 L137](../../../tailieu/8-verify-ma-otp.md#L137): "ưu tiên kiểm tra account trước."<br>Thứ tự so với khóa nhập mã: tài liệu không nêu (câu hỏi #8) |
| 🆕 TC-100 | Gửi mã bằng `0xxx`, nhập mã bằng `84xxx` | Gửi mã cho `0347566507`, mã còn hạn | Nhập đúng mã kèm SĐT `84347566507` | ✅ **Xác thực thành công** (cùng một số, không báo "Mã không khớp") | [Tài liệu 8 L28](../../../tailieu/8-verify-ma-otp.md#L28): 30026 chỉ khi "không khớp với `uuid` hoặc `phone` sau khi chuẩn hóa"<br>[Tài liệu 8 L47](../../../tailieu/8-verify-ma-otp.md#L47): chấp nhận `0`, `84` hoặc `+84` |
| 🆕 TC-101 | Gửi mã bằng `0xxx`, nhập mã bằng `+84xxx` | Gửi mã cho `0347566507`, mã còn hạn | Nhập đúng mã kèm SĐT `+84347566507` | ✅ **Xác thực thành công** | [Tài liệu 8 L28](../../../tailieu/8-verify-ma-otp.md#L28): 30026 chỉ khi "không khớp với `uuid` hoặc `phone` sau khi chuẩn hóa"<br>[Tài liệu 8 L47](../../../tailieu/8-verify-ma-otp.md#L47): chấp nhận `0`, `84` hoặc `+84` |
| 🆕 TC-102 | Nhập sai mã lần đầu | Đã gửi mã, chưa nhập sai lần nào | Nhập mã sai (đủ 6 số) | ❌ **Mã không đúng** (30027), báo kèm **số lần đã sai = 1** | [Tài liệu 8 L102-107](../../../tailieu/8-verify-ma-otp.md#L102): mẫu `"errorCode": 30027` ... `"failedAttempts": 1`<br>[Tài liệu 8 L29](../../../tailieu/8-verify-ma-otp.md#L29): 30027 "Mã OTP không đúng" |

---

## 14. Câu hỏi cần BA/BE trả lời trước khi test

| # | Câu hỏi | Ảnh hưởng | Người trả lời |
|---|---|---|---|
| 1 | Danh sách "IP không cần xác thực OTP" áp dụng ở bước nào? | Chưa viết được test cho tính năng này | BA |
| 2 | Admin nhập JSON sai (sai cú pháp, thiếu trường, sai kiểu) thì báo lỗi gì? | Chưa có test lỗi cho màn Admin | BA |
| 3 | Tác vụ 3h sáng làm mới token bị lỗi thì token cũ còn dùng được không? Có thử lại / cảnh báo không? | Chưa test sâu trường hợp lỗi | BA/BE |
| 4 | Chưa có thiết kế giao diện cho người dùng nhập SĐT / mã | Chưa test giao diện người dùng cuối | BA/FE |
| 5 | Kiểm tra số trùng có coi `0xxx`, `84xxx`, `+84xxx` là cùng một số không? | TC-11 | BE |
| 6 | ~~Nhập sai định dạng SĐT / mã tài khoản thì trả mã lỗi gì? (bảng mã lỗi chưa có)~~ → **Còn mở.** Tài liệu 02/10/2026 chỉ nói về phía **nhập mã** (Lỗi dữ liệu 11000). Phía **gửi mã** (SĐT / mã tài khoản trống hoặc sai định dạng) vẫn chưa có mã lỗi chính thức. *Ghi chú:* QA từng quan sát 11000 khi gửi cả mã tài khoản và SĐT để trống (30/09, môi trường dev) nhưng chưa lưu bằng chứng — cần chạy lại có bằng chứng hoặc BA xác nhận. | TC-04 → TC-07 | BE/BA |
| 7 | **Bảo mật:** đổi số điện thoại sẽ làm số lần nhập sai được đếm lại từ đầu → kẻ xấu có thể đoán mã nhiều lần hơn giới hạn. Có chấp nhận không? | TC-67 | BA + Security |
| 🆕 8 | **(Mới 02/10/2026)** Khi tài khoản đã xác thực (hoặc SĐT đã bị người khác xác thực) mà đồng thời cặp tài khoản + SĐT đang bị **khóa nhập mã**, hệ thống báo lỗi nào — "đã xác thực" (30029/30014) hay "bị khóa" (30028)? Các lỗi 30029/30014 có được tính vào số lần nhập sai không? Tài liệu chưa nêu thứ tự kiểm tra này nên chưa viết case. | Chưa có TC (thứ tự kiểm tra khi nhập mã) | BE |

## 15. Bảng mã lỗi

| Mã | Ý nghĩa | TC liên quan |
|---|---|---|
| 🆕 11000 | Lỗi dữ liệu (thiếu / sai định dạng; mã OTP phải đủ 6 số) *(mới 02/10/2026)* | TC-91, 92, 93, 94, 95, 96, 97 (chỉ phần nhập mã; phần gửi mã chưa chốt — câu hỏi #6) |
| 30014 | SĐT đã được xác thực | ~~TC-09, 10, 11, 69~~ → TC-09, 10, 11, 69, 98 |
| 30015 | Gửi OTP thất bại (số không dùng Zalo) | TC-18, 23 |
| 30016 | Không tìm thấy tài khoản | TC-08 |
| 30017 | Lỗi cấu hình Zalo | TC-83 |
| 30018 | Đang trong thời gian chờ gửi lại | TC-15, 25 |
| 30019 | Đang bị khóa đổi số | TC-17, 28, 31, 34 |
| 30020 | Đang bị khóa gửi lại mã | TC-22, 38, 41, 44 |
| 30021 | Lỗi cấu hình làm mới token | TC-80 |
| 30022 | Refresh token hết hạn | TC-81 |
| 30023 | Làm mới token thất bại | TC-82 |
| 30024 | Gửi OTP thất bại (lỗi khác) | TC-19, 23, 25, 89 |
| 30025 | Mã đã hết hạn | ~~TC-56, 58, 60, 62, 68~~ → TC-56, 58, 62, 68 |
| 30026 | Mã không khớp | TC-57, 63 |
| 30027 | Mã không đúng (kèm số lần đã sai) | ~~TC-46, 49, 52~~ → TC-46, 49, 52, 102 |
| 30028 | Đang bị khóa nhập mã | TC-47, 48, 50, 51, 53, 54 |
| 🆕 30029 | Tài khoản đã được xác thực *(mới 02/10/2026; kiểm tra trước 30014)* | TC-60, 99 |

**Tổng: ~~90 test case, trong đó 2 case (TC-11, TC-67) đang chờ BA/BE trả lời~~ → 102 test case** (90 cũ + 12 mới TC-91 → TC-102), trong đó 4 case ❓ (TC-04, TC-06, TC-11, TC-67) đang chờ BA/BE trả lời, và 2 case ⚠️ (TC-60, TC-99) phụ thuộc câu hỏi #8.

---

## 16. Lịch sử cập nhật

| Ngày | Người | Nội dung |
|---|---|---|
| 2026-10-02 | QA | Cập nhật theo tailieu/8-verify-ma-otp.md: thêm mã lỗi 30029 (tài khoản đã xác thực, kiểm tra trước 30014) và 11000 (lỗi dữ liệu, mã OTP đủ 6 số). **Sửa:** TC-60 (30025 → 30029), TC-59 (xóa thêm bộ đếm gửi lại), TC-46/49/52 (báo kèm số lần sai), TC-04/06 (11000 theo quan sát thực tế). **Thêm:** TC-91 → TC-102 (kiểm tra dữ liệu nhập mã, SĐT đã được người khác xác thực, ưu tiên 30029, nhập SĐT dạng 84/+84, số lần sai lần đầu). Câu hỏi #6 trả lời một phần; thêm câu hỏi #8 (thứ tự kiểm tra với khóa nhập mã). Tổng 90 → 102 case. *(Nội dung TC-04/06 và câu hỏi #6 đã được thay bởi dòng review bên dưới.)* |
| 2026-10-02 | QA | Sửa theo review lần 1: TC-04/06 đưa về ❓ chờ câu hỏi #6 (chỉ ghi "bị từ chối, có báo lỗi ở ô tương ứng", bỏ mã 11000 và nội dung thông báo; chưa có bằng chứng cho quan sát 30/09); bỏ 11000 phía gửi mã khỏi bảng mã lỗi; TC-60 và TC-99 gắn ⚠️ phụ thuộc câu hỏi #8; TC-46/49/52 ghi chú số lần sai là suy diễn từ mẫu tài liệu; TC-91/97 "có tính là lần nhập sai hay không" ghi là chưa xác nhận; số case chờ trả lời = 4 (TC-04, 06, 11, 67). |
| 2026-10-02 | QA | Đánh dấu thay đổi: gạch thông tin cũ, ghi thông tin mới theo yêu cầu user |
| 2026-10-02 | QA | Thêm cột Nguồn tài liệu cho từng case theo yêu cầu user |
