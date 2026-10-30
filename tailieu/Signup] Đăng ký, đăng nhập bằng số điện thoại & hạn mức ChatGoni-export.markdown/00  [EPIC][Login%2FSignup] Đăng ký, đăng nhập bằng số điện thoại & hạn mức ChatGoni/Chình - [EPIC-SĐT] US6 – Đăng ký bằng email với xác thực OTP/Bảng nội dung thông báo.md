# Bảng nội dung thông báo

| Story | Màn | Tình huống | Trạng thái hệ thống |
|-------|-----|------------|---------------------|
|       | 05b-12 | Không nhập đủ 6 chữ số | Vô hiệu hóa nút xác thực |
| US2   | 05b-12 | Nhập đủ 6 chữ số | Nút xác thực được mở |
| 05b-12 | Người dùng yêu cầu gửi lại khi hết thời gian chờ | Ẩn đếm ngược; bật **Gửi lại mã**  |
| 05b-12 | Gửi OTP không thành công | Chưa thể gửi mã xác thực. Vui lòng thử lại sau.(thông báo) |
 |
| 05b-12 | Sai mã | Mã không đúng bạn còn \[\] lần thử.(validate ô nhập) |
| 05b-12 | Mã hết hạn | Mã hết hạn. VuI lòng gửi lại mã mới(validate ô nhập) |
| 05b-12 | Gửi quá nhiều lần | Bạn đã yêu cầu quá nhiều lần vui lòng thử lại sau \[X\] phút(validate ô nhập) |
|       | 05b-12 | Nhập sai quá nhiều lần | Bạn đã nhập sai quá nhiều lần. Tạp khóa xác thực cho số điện thoại này trong \[\] phút(validate ô nhập) |
|       | 05b | Không gửi được qua zalo | Không thể           |
| US3-Đăng nhập | 01  | Đối với IOS | Không hiển thị link đăng ký |
| 01    | Chưa nhập đủ thông tin | Vô hiệu hóa nút đăng nhập |
| 01    | Nhập đủ thông tin | Nút đăng nhập được mở |
 |
| 01    | Sai email/SĐT hoặc mật khẩu | Tài khoản hoặc mật khẩu không chính xác. Vui lòng thử lại. |
| 01    | Nhập sai thông tin quá X lần | Đăng nhập đang tạm bị khóa. Vui lòng thử lại sau \[thời gian\]. Vô hiệu hóa nút đăng nhập  |
| US4-quên mật khẩu | 02  | Chưa nhập thông tin | Vô hiệu hóa nút Tiếp tục |
| 02    | Email hoặc số điện thoại không tồn tại | Email hoặc số điện thoại không đúng |
| 04    | Chưa nhập đầy đủ thông tin | Vô hiệu hóa nút lưu mật khẩu |
| 04    | Mật khẩu không hợp lệ | Mật khẩu phải có từ 8–16 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt(validate dưới ô nhập) |
| 04    | Nhập mật khẩu không khớp | Mật khẩu không khớp vui lòng nhập lại(validate dưới ô nhập mật khẩu) |
 |
| US1   | 05a | Số điện thoại đã được sử dụng trong hệ thống | Thông báo giữa màn hình" Số điện thoại đã đăng kí. đăng nhập" bao gồm nút đăng nhập và nút hủy |
|       | 05a | Thiết bị đổi quá hạn số điện thoại | Bạn đã đổi quá X số điện thoại vui lòng quay lại sau |
|       | ~~05a~~ | ~~Số điện thoại đã bị đưa vào danh sách đen do nghi ngờ hành vi xấu~~ | ~~Số điện thoại này đã được đưa vào danh sách đen của chúng tôi vui lòng thử số khác(validate dưới ô nhập)~~ |
|       | 05a | Số điện thoại không đúng định dạng | Số điện thoại không đúng định dạng |
|       | 05a | Chưa nhập số điện thoại | Vô hiệu hóa nút gửi mã xác thực |
|       | 05c | Chưa nhập đầy đủ thông tin ở hai ô nhập | Vô hiệu hóa nút lưu mật khẩu |
|       | 05c | Mật khẩu không hợp lệ | Mật khẩu phải có từ 8–16 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt(validate dưới ô nhập) |
|       | 05c | Nhập mật khẩu không khớp | Mật khẩu không khớp vui lòng nhập lại(validate dưới ô nhập mật khẩu) |
| US6   | 11  | Email đã được sử dụng trong hệ thống | Thông báo giữa màn hình" Email đã đăng kí. đăng nhập" bao gồm nút đăng nhập và nút hủy |
|       | 11  | Thiết bị đổi quá hạn Email | Bạn đã đổi quá X Email vui lòng quay lại sau X giờ |
|       | 11  | Email đã bị đưa vào danh sách đen do nghi ngờ hành vi xấu | Số điện thoại này đã được đưa vào danh sách đen của chúng tôi vui lòng thử số khác(validate dưới ô nhập) |
|       | 11  | Email không đúng định dạng | Email không đúng định dạng |
|       | 11  | Chưa nhập Email | Vô hiệu hóa nút gửi mã xác thực |
|       | 13  | Chưa nhập đầy đủ thông tin ở hai ô nhập | Vô hiệu hóa nút lưu mật khẩu |
|       | 13  | Mật khẩu không hợp lệ | Mật khẩu phải có từ 8–16 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt(validate dưới ô nhập) |
|       | 13  | Nhập mật khẩu không khớp | Mật khẩu không khớp vui lòng nhập lại(validate dưới ô nhập mật khẩu) |
| Dùng chung | Các màn liên quan |            | Đã xảy ra lỗi. Vui lòng kiểm tra và thử lại. |



| Story | Màn | Tình huống | Trạng thái hệ thống / Cách hiển thị | Nội dung thông báo |
|-------|-----|------------|-------------------------------------|--------------------|
| US1   | 05a | Số điện thoại đã được sử dụng trong hệ thống | Hiển thị **hộp thoại giữa màn hình**, gồm nút **Đăng nhập** và **Hủy**. | Số điện thoại này đã được đăng ký. Bạn có muốn đăng nhập không? |
| US1   | 05a | Thiết bị yêu cầu quá hạn mức gửi số điện thoại | Hiển thị validate dưới ô nhập số điện thoại | Bạn đã vượt giới hạn 3 đổi số điện thoại. Vui lòng thử lại sau 24 giờ. |
| US1   | 05a | Số điện thoại bị ghi nhận trong danh sách đen | Hiển thị validate **dưới ô Số điện thoại**; đánh dấu ô nhập ở trạng thái lỗi. | Số điện thoại bị hệ thống ghi nhận nghi ngờ. Vui lòng dùng số khác. |
| US1   | 05a | Số điện thoại không đúng định dạng | Hiển thị **lỗi dưới ô Số điện thoại**; đánh dấu ô nhập ở trạng thái lỗi. | Số điện thoại không đúng định dạng. |
| US1   | 05a | Chưa nhập số điện thoại | Vô hiệu hóa nút **Gửi mã xác thực**. | Không hiển thị thông báo. |
| US1   | 05c | Một hoặc cả hai ô Mật khẩu và Xác nhận mật khẩu còn trống | Vô hiệu hóa nút **Lưu mật khẩu**.   | Không hiển thị thông báo. |
| US1   | 05c | Mật khẩu không đáp ứng quy định | Hiển thị **lỗi dưới ô Mật khẩu**; đánh dấu ô nhập ở trạng thái lỗi. | Mật khẩu phải có từ 8–16 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt. |
| US1   | 05c | Xác nhận mật khẩu không khớp với mật khẩu đã nhập | Hiển thị **lỗi dưới ô Xác nhận mật khẩu**; đánh dấu ô nhập này ở trạng thái lỗi. | Mật khẩu xác nhận không khớp. Vui lòng nhập lại. |
| US6   | 11  | Email đã được sử dụng trong hệ thống | Hiển thị **hộp thoại giữa màn hình**, gồm nút **Đăng nhập** và **Hủy**. | Email này đã được đăng ký. Bạn có muốn đăng nhập không? |
| US6   | 11  | Thiết bị đã vượt giới hạn số lượng email được phép sử dụng | Hiển thị **thông báo trên form**, gần khu vực nhập email. Vô hiệu hóa nút **Gửi mã xác thực** trong thời gian bị giới hạn. | Bạn đã vượt giới hạn \[X\] email trên thiết bị này. Vui lòng thử lại sau \[Y\] giờ. |
| US6   | 11  | Email thuộc danh sách chặn | Hiển thị **lỗi dưới ô Email**; đánh dấu ô nhập ở trạng thái lỗi. | Email này hiện không được phép sử dụng. Vui lòng nhập email khác. |
| US6   | 11  | Email không đúng định dạng | Hiển thị **lỗi dưới ô Email**; đánh dấu ô nhập ở trạng thái lỗi. | Email không đúng định dạng. |
| US6   | 11  | Chưa nhập email | Vô hiệu hóa nút **Gửi mã xác thực**. | Không hiển thị thông báo. |
| US6   | 13  | Một hoặc cả hai ô Mật khẩu và Xác nhận mật khẩu còn trống | Vô hiệu hóa nút **Lưu mật khẩu**.   | Không hiển thị thông báo. |
| US6   | 13  | Mật khẩu không đáp ứng quy định | Hiển thị **lỗi dưới ô Mật khẩu**; đánh dấu ô nhập ở trạng thái lỗi. | Mật khẩu phải có từ 8–16 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt. |
| US6   | 13  | Xác nhận mật khẩu không khớp với mật khẩu đã nhập | Hiển thị **lỗi dưới ô Xác nhận mật khẩu**; đánh dấu ô nhập này ở trạng thái lỗi. | Mật khẩu xác nhận không khớp. Vui lòng nhập lại. |