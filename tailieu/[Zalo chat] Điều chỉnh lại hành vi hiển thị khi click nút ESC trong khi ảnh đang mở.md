# [Zalo chat] Điều chỉnh lại hành vi hiển thị khi click nút ESC trong khi ảnh đang mở

**Loại yêu cầu:** Change Request (CR)

## Hiện tại

Khi người dùng mở một ảnh bất kỳ trong đoạn chat và nhấn phím **ESC**, hệ thống thoát khỏi đoạn chat, đưa người dùng về danh sách đoạn chat. Hành vi này làm gián đoạn việc xem và tiếp tục trò chuyện.

## Yêu cầu thay đổi

Khi lightbox xem ảnh đang mở, người dùng nhấn phím **ESC** thì hệ thống chỉ đóng lightbox và giữ người dùng trong đoạn chat hiện tại. Cùng một lần nhấn ESC không được đồng thời kích hoạt hành vi thoát đoạn chat.

## Luồng mong muốn

Người dùng mở đoạn chat → Nhấn vào một ảnh để mở lightbox → Nhấn phím ESC → Lightbox đóng → Người dùng tiếp tục thao tác trong đoạn chat vừa xem.

## Tiêu chí nghiệm thu

| Mã | Điều kiện / Thao tác | Kết quả mong muốn |
|---|---|---|
| AC-01 | Mở một ảnh bất kỳ trong đoạn chat, sau đó nhấn ESC. | Lightbox đóng. |
| AC-02 | Lightbox được đóng bằng ESC. | Người dùng vẫn ở đúng đoạn chat hiện tại, không chuyển về danh sách đoạn chat. |
| AC-03 | Nhấn ESC một lần khi lightbox đang mở. | Chỉ xử lý đóng lightbox, không đồng thời xử lý thoát đoạn chat. |

## Phạm vi

CR áp dụng cho thao tác nhấn phím ESC khi lightbox xem ảnh trong Zalo Chat đang mở. Hành vi ESC khi không có lightbox đang mở giữ theo logic hiện tại.
