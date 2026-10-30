# Nội dung đề xuất US2

| Nội dung | Quy tắc đề xuất | Lý do |
|----------|-----------------|-------|
| **Thời hạn OTP** | Mã gồm **6 chữ số**, hiệu lực **5 phút** | Giới hạn thời gian sử dụng mã, đồng thời dành thời gian để người dùng nhận và nhập mã |
| **Chờ gửi lại** | Cho gửi lại sau **60 giây** | Tránh gửi dồn khi tin nhắn đến chậm; giảm nhầm lẫn giữa nhiều mã |
| **Giới hạn theo SĐT/email** | Tối đa **5 lượt gửi/24 giờ trượt**, tính chung mọi luồng và thiết bị | Hạn chế làm phiền cùng người nhận; đổi thiết bị không tạo thêm lượt gửi |
| **Giới hạn theo thiết bị** | Tối đa **5 lượt gửi OTP bằng SĐT/24 giờ trượt**, cộng dồn mọi SĐT và luồng | Ngăn một thiết bị chuyển qua nhiều SĐT để tiếp tục gửi mã |
| **Khóa SĐT/email** | ### Sai đủ **5 lần trong 15 phút** → khóa gửi và xác thực **15 phút** trên mọi thiết bị | Hạn chế dò mã của cùng SĐT/email từ nhiều thiết bị |
| **Khóa thiết bị lần đầu** | Sai đủ **5 lần trong 15 phút**, cộng dồn mọi SĐT → khóa **15 phút** | Chặn việc đổi SĐT để tiếp tục thử mã; mức khóa đầu cho phép người nhập nhầm sớm thử lại |
| **Thiết bị tái phạm** | Trong 24 giờ từ lần khóa đầu: lần thứ hai đạt ngưỡng → khóa **1 giờ**; lần thứ ba → khóa **24 giờ** | Tăng mức xử lý khi hành vi tiếp tục lặp lại sau khi đã được mở khóa |
| **Không cho né khóa** | Thiết bị đang khóa không được gửi hoặc xác thực OTP bằng SĐT và Email; vô hiệu hóa **Đổi số và gmail** trên màn OTP và áp dụng qua lại giữa hai kênh | Bảo đảm khóa có hiệu lực với cả số mới, không chỉ số đang hiển thị |
| **Bảo toàn thông tin** | Không xóa SĐT/email, không gỡ liên kết và không tự đăng xuất tài khoản | Nhập sai OTP chưa đủ căn cứ để xóa thông tin hoặc ảnh hưởng các phiên hợp lệ |