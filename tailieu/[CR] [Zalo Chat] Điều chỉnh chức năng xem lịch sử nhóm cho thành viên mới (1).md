# [CR] [Zalo Chat] Điều chỉnh chức năng xem lịch sử nhóm cho thành viên mới

## 1. Current Situation

Hiện tại, Zalo Chat đã có chức năng **Thành viên mới xem được tin gửi gần đây** tại Cài đặt nhóm. Tuy nhiên, khi toggle ở trạng thái bật, thành viên mới tham gia nhóm vẫn không xem được tin nhắn trước thời điểm tham gia.

Tại Zalo Chat, điều chỉnh chức năng để thành viên mới tham gia nhóm khi toggle bật xem được toàn bộ lịch sử trò chuyện trước đó, không giới hạn thời gian. Làm rõ hành vi khi bật/tắt cài đặt và bổ sung popup thông tin tin ghim cho thành viên không có quyền xem tin nhắn trước thời điểm tham gia.

## 2. Expectation

| Mục tiêu | Nội dung |
| :--- | :--- |
| Xem đầy đủ lịch sử nhóm | Khi tính năng bật, thành viên mới xem được toàn bộ tin nhắn trong nhóm trước thời điểm tham gia, không giới hạn thời gian. |
| Giữ quyền xem lịch sử đã có | Tắt tính năng không làm mất quyền xem tin nhắn cũ của thành viên đã có quyền xem toàn bộ lịch sử. |
| Mở lịch sử khi bật lại | Bật lại tính năng cho phép tất cả thành viên hiện có xem toàn bộ lịch sử, gồm người đã tham gia khi tính năng tắt. |
| Xem thông tin tin ghim | Thành viên có quyền xem tin nhắn cũ click tin ghim để điều hướng và highlight theo logic hiện tại. Thành viên không có quyền xem tin nhắn cũ click tin ghim trước thời điểm tham gia để mở popup thông tin tin ghim. |

## 3. Scope

### 3.1. In Scope

Áp dụng cho hội thoại nhóm trên desktop/mobile, trong phạm vi hội thoại mà user có quyền truy cập.

- Điều chỉnh phạm vi lịch sử thành viên mới xem được khi được mời vào nhóm, tham gia nhóm qua các luồng hiện có.
- Điều chỉnh tác động của việc bật/tắt toggle **Thành viên mới xem được tin gửi gần đây** đến thành viên mới và thành viên đang trong nhóm.
- Bổ sung popup thông tin tin ghim khi thành viên không có quyền xem tin nhắn trước thời điểm tham gia.
- Đảm bảo tin nhắn cũ và nội dung đính kèm được hiển thị tại khung chat, tìm kiếm và kho Ảnh/Video/Tài liệu/Liên kết khi thành viên có quyền xem toàn bộ lịch sử.

*Note: Giữ nguyên logic nghiệp vụ hiện tại về đồng bộ cài đặt với Zalo, quyền chỉnh cài đặt nhóm, phân quyền tài khoản/hội thoại, phân công nhân sự, luồng tham gia nhóm, ghim/bỏ ghim, thao tác với tin nhắn, cài đặt mặc định khi tạo nhóm mới, xóa lịch sử trò chuyện, trạng thái tải và xử lý lỗi kết nối, ngoại trừ các thay đổi được mô tả trong Change Request này.*

### 3.2. Out of Scope

- Không thay đổi bố cục và cách hiển thị tin ghim tại màn hội thoại và danh sách tin đã ghim.
- Không bổ sung phân quyền xem riêng cho từng tin nhắn.
- Không thay đổi luồng rời nhóm và tham gia lại, kế thừa logic Zalo hiện tại.
- Không bổ sung chức năng chỉnh sửa nội dung tin ghim tại popup.

## 4. Change Details

| ID | Current Behavior | New Behavior | Reason |
| :--- | :--- | :--- | :--- |
| CR-01 | Zalo Chat đã có chức năng cho phép thành viên mới xem tin nhắn trước khi tham gia nhóm. Tuy nhiên, khi toggle ở trạng thái bật, thành viên mới vẫn không xem được tin nhắn trước thời điểm tham gia. | • Khi toggle **Thành viên mới xem được tin gửi gần đây = ON**, thành viên mới xem được toàn bộ tin nhắn trong nhóm trước thời điểm tham gia, không giới hạn thời gian.<br>• Khi toggle **= OFF**, thành viên mới chỉ xem được tin nhắn từ thời điểm tham gia. Thành viên mới vẫn xem được:<br>+ Tin nhắn đã ghim.<br>+ Nhắc hẹn.<br>+ Bình chọn.<br>+ Ghi chú nội bộ.<br>+ Hồ sơ khách hàng.<br>• Khi bật lại toggle, tất cả thành viên hiện có được xem toàn bộ tin nhắn trong hội thoại. Thành viên mới tham gia trong thời gian toggle bật cũng xem được toàn bộ tin nhắn trước khi tham gia.<br>• Khi trưởng nhóm tắt tính năng sau đó, các thành viên đã có quyền xem toàn bộ lịch sử vẫn tiếp tục xem được toàn bộ tin nhắn trong hội thoại nhóm. | Đảm bảo chức năng cho phép xem tin nhắn trước khi tham gia hoạt động đúng, không còn trường hợp toggle đã bật nhưng thành viên mới vẫn không xem được tin nhắn trước đó. |
| CR-02 | N/A | Bổ sung hành vi khi user không có quyền xem tin nhắn trước thời điểm tham gia: click tin ghim thuộc phần lịch sử này sẽ mở popup thông tin tin ghim, không điều hướng đến đoạn chat và không hiển thị các tin xung quanh. | Cho phép user xem nội dung tin ghim trong popup khi không có quyền truy cập tin đó trong lịch sử hội thoại. |

## 5. Business Rules

| ID | Nội dung | Mô tả |
| :--- | :--- | :--- |
| BR-01 | Thành viên mới tham gia nhóm | • Khi toggle **Thành viên mới xem được tin gửi gần đây = ON**, thành viên mới xem được toàn bộ tin nhắn trong nhóm trước thời điểm tham gia, không giới hạn thời gian.<br>• Khi toggle **= OFF**, thành viên mới chỉ xem được tin nhắn từ thời điểm tham gia. Các mục tại BR-05 vẫn xem được.<br>• Áp dụng khi thành viên được mời vào nhóm, tham gia qua link/QR. |
| BR-02 | Bật tính năng | • Khi trưởng nhóm bật toggle **Thành viên mới xem được tin gửi gần đây**, tất cả thành viên đang trong nhóm có quyền xem toàn bộ lịch sử, gồm người đã tham gia khi tính năng tắt.<br>• Thành viên mới tham gia trong thời gian toggle bật cũng xem được toàn bộ tin nhắn trước khi tham gia. |
| BR-03 | Tắt tính năng | • Khi trưởng nhóm tắt toggle **Thành viên mới xem được tin gửi gần đây**, thành viên đã có quyền xem toàn bộ lịch sử vẫn tiếp tục xem được toàn bộ tin nhắn trong hội thoại nhóm.<br>• Thành viên mới tham gia sau khi tắt chỉ xem được tin nhắn từ thời điểm tham gia. Các mục tại BR-05 vẫn xem được.<br>• Quy tắc này tiếp tục áp dụng khi cài đặt được bật/tắt nhiều lần. |
| BR-04 | Tham gia nhóm cần duyệt | Với thành viên tham gia nhóm cần duyệt, căn cứ trạng thái toggle **Thành viên mới xem được tin gửi gần đây** tại thời điểm được duyệt vào nhóm, không lấy trạng thái lúc gửi yêu cầu. |
| BR-05 | Các mục vẫn xem được khi không có quyền xem tin nhắn cũ | Thành viên mới không có quyền xem tin nhắn trước thời điểm tham gia vẫn xem được:<br>+ Tin nhắn đã ghim.<br>+ Nhắc hẹn.<br>+ Bình chọn.<br>+ Ghi chú nội bộ.<br>+ Hồ sơ khách hàng.<br>Xem các mục này không mở thêm quyền truy cập các tin nhắn cũ trong hội thoại. |
| BR-06 | Click tin ghim | • Thành viên có quyền xem toàn bộ tin nhắn trong hội thoại click tin ghim để điều hướng đến đúng tin và highlight theo logic hiện tại.<br>• Thành viên không có quyền xem tin nhắn cũ click tin ghim trước thời điểm tham gia để mở popup thông tin tin ghim, không điều hướng đến đoạn chat và không hiển thị các tin xung quanh.<br>• Với tin ghim được gửi từ thời điểm thành viên tham gia, click tiếp tục điều hướng và highlight theo logic hiện tại. |
| BR-07 | Trạng thái tin ghim trong popup | Trong popup, tin ghim đã xóa/thu hồi giữ trạng thái hiển thị tương ứng với tin trong đoạn chat. Thumbnail ảnh thu hồi hiển thị đen trắng và nhãn trạng thái hiện tại. |
| BR-08 | Nội dung popup | Popup hiển thị đúng người gửi và nội dung của tin ghim được chọn. Tin ảnh/video kèm text hiển thị thumbnail và phần mô tả/text thuộc tin đó, không lấy từ một tin nhắn riêng bên cạnh. Tin tệp hiển thị icon tệp, nhãn **[File]** và tên tệp. Nội dung dài cho phép cuộn để đọc đầy đủ. |
| BR-09 | Sao chép từ popup | • Tin văn bản: sao chép nội dung văn bản.<br>• Tin ảnh/video kèm text: sao chép phần mô tả/text thuộc tin đó.<br>• Tin ảnh/video không kèm text: icon copy disabled.<br>• Tin tệp: sao chép tên tệp.<br>Phản hồi sao chép thành công/thất bại kế thừa logic hiện tại. |
| BR-10 | Tương tác và đóng popup | Thumbnail ảnh/video, icon tệp và tên tệp chỉ hiển thị thông tin. Click không mở trình xem ảnh/video, không phát video, không mở tệp, không tải tệp và không điều hướng đến đoạn chat. User đóng popup bằng icon **X**, nút **Đóng**, click lớp phủ ngoài popup, nhấn **Esc**. Các cách đóng đều giữ vị trí cuộn và nội dung đang soạn. Thao tác trong popup không đồng thời kích hoạt thao tác ở màn phía sau. |
| BR-11 | Click tin ghim sau khi bật lại | Sau khi trưởng nhóm bật lại toggle **Thành viên mới xem được tin gửi gần đây**, thành viên có quyền xem toàn bộ tin nhắn trong hội thoại. Click tin ghim trước thời điểm tham gia sẽ điều hướng đến đúng tin và highlight theo logic hiện tại. |
| BR-12 | Hiển thị lịch sử tại các phần liên quan | Khi thành viên có quyền xem toàn bộ lịch sử, tin nhắn cũ phải xem được tại khung chat, tìm được qua tìm kiếm trong hội thoại và tìm kiếm hợp nhất. Kho Ảnh/Video/Tài liệu/Liên kết hiển thị nội dung tương ứng. Kết quả tìm kiếm phải được cập nhật để không xảy ra tình trạng xem được tin trong chat nhưng không tìm thấy. |
| BR-13 | Không coi lịch sử cũ là tin mới | Việc mở quyền xem lịch sử cũ không làm tăng chưa đọc, phát lại thông báo và đẩy nhóm lên đầu danh sách theo thời điểm lịch sử được mở. Tin phát sinh mới tiếp tục xử lý theo logic hiện tại. |

### 5.1. Phạm vi xem lịch sử theo thay đổi cài đặt

Trong bảng dưới, **toggle** là cài đặt **Thành viên mới xem được tin gửi gần đây**. Các thành viên được nhắc đến tiếp tục ở trong nhóm trong suốt tình huống.

| Tình huống | Kết quả |
| :--- | :--- |
| Toggle **ON** → A tham gia nhóm | A xem được toàn bộ tin nhắn trong hội thoại nhóm, gồm tin trước thời điểm tham gia. |
| Toggle **ON** → A tham gia nhóm → chuyển **OFF** | A vẫn xem được toàn bộ tin nhắn trong hội thoại nhóm. |
| Toggle **OFF** → B tham gia nhóm | B chỉ xem được tin nhắn từ thời điểm tham gia, vẫn xem được tin ghim, nhắc hẹn, bình chọn, ghi chú nội bộ và hồ sơ khách hàng. |
| Toggle **OFF** → B tham gia nhóm → chuyển **ON** | B và tất cả thành viên hiện có xem được toàn bộ tin nhắn trong hội thoại nhóm. |
| Toggle **OFF** → B tham gia nhóm → chuyển **ON** → chuyển **OFF** | B vẫn xem được toàn bộ tin nhắn trong hội thoại nhóm. |
| A, B đã xem được toàn bộ lịch sử → chuyển **OFF** → C tham gia nhóm | A, B vẫn xem được toàn bộ tin nhắn. C chỉ xem được tin từ thời điểm tham gia, vẫn xem được tin ghim, nhắc hẹn, bình chọn, ghi chú nội bộ và hồ sơ khách hàng. |

### 5.2. Hành vi khi click tin ghim

| Trường hợp | Hành vi khi click tin ghim |
| :--- | :--- |
| Thành viên có quyền xem toàn bộ lịch sử nhóm | Điều hướng đến đúng tin và highlight theo logic hiện tại. |
| Thành viên không có quyền xem tin nhắn cũ, tin ghim được gửi trước thời điểm tham gia | Vẫn thấy tin ghim. Click mở popup thông tin tin ghim, không điều hướng đến tin trong đoạn chat và không mở các tin xung quanh. |
| Thành viên không có quyền xem tin nhắn cũ, tin ghim được gửi từ thời điểm tham gia | Điều hướng đến đúng tin và highlight theo logic hiện tại. |

## 6. UI Specification

*Note: Popup hiển thị giữa màn hình, có lớp phủ phía sau.*

| UI Element | Control Type | Required? | Default Value | Mô tả |
| :--- | :--- | :--- | :--- | :--- |
| Tiêu đề | Text | N/A | Tin nhắn | Hiển thị **Tin nhắn** ở đầu popup, căn giữa. |
| Người gửi | Text | N/A | Người gửi tin được ghim | Hiển thị **Từ {Tên người gửi}**, căn giữa phía trên nội dung. Tên kế thừa quy tắc hiển thị người gửi hiện tại. |
| Nội dung tin nhắn | Content Container | N/A | Nội dung tin ghim được chọn | • Tin văn bản: hiển thị nội dung text.<br>• Tin ảnh/video: hiển thị thumbnail. Mô tả/text đi kèm hiển thị bên cạnh thumbnail và xuống dòng khi dài.<br>• Tin tệp: icon tệp nằm bên trái. Bên phải hiển thị nhãn **[File]**, tên tệp ở dòng bên dưới.<br>• Tin xóa/thu hồi: giữ cách hiển thị trạng thái tương ứng với tin trong đoạn chat. Thumbnail ảnh thu hồi đen trắng, có nhãn trạng thái hiện tại.<br>• Nội dung vượt chiều cao vùng hiển thị: có thanh cuộn dọc để xem đầy đủ. Tiêu đề và chân popup cố định khi cuộn.<br>• Thumbnail ảnh/video, icon tệp và tên tệp chỉ để hiển thị, không mở trình xem ảnh/video, không phát video, không mở tệp và không tải tệp khi click. |
| Icon copy | Icon Button | N/A | Enabled với tin văn bản, tin tệp, ảnh/video có text. Disabled với ảnh/video không kèm text. | Nằm bên trái chân popup. Click thực hiện quy tắc sao chép tại BR-09. |
| Icon Đóng | Icon Button | N/A | N/A | Hiển thị icon **X** tại góc trên bên phải. Click đóng popup. |
| Đóng | Button | N/A | N/A | Nằm bên phải chân popup, nhãn **Đóng**. Click đóng popup. |

Click lớp phủ ngoài popup và nhấn **Esc** đều đóng popup theo BR-10.

## 7. Acceptance Criteria

| ID | Scenarios | Given | When | Then |
| :--- | :--- | :--- | :--- | :--- |
| AC-01 | Thành viên được mời vào nhóm | Nhóm có tin nhắn trước thời điểm A tham gia, gồm tin ở nhiều tháng trước.<br><br>[1] Toggle **Thành viên mới xem được tin gửi gần đây = ON**.<br><br>[2] Toggle **Thành viên mới xem được tin gửi gần đây = OFF**. | User có quyền thêm thành viên mời A vào nhóm. A mở hội thoại nhóm. | [1] A xem được toàn bộ tin nhắn trong hội thoại, gồm toàn bộ lịch sử trước khi tham gia, không giới hạn thời gian.<br><br>[2] A chỉ xem được tin nhắn từ thời điểm tham gia. A vẫn xem được tin ghim, nhắc hẹn, bình chọn, ghi chú nội bộ và hồ sơ khách hàng. |
| AC-02 | Giữ quyền xem lịch sử khi tắt cài đặt | A tham gia nhóm khi toggle **Thành viên mới xem được tin gửi gần đây = ON**. | Trưởng nhóm chuyển toggle **Thành viên mới xem được tin gửi gần đây = OFF**. A mở hội thoại nhóm. | A vẫn xem được toàn bộ tin nhắn trong hội thoại nhóm. |
| AC-03 | Thành viên tham gia sau khi tắt cài đặt | A có quyền xem toàn bộ tin nhắn trong hội thoại nhóm. Trưởng nhóm đã chuyển toggle **Thành viên mới xem được tin gửi gần đây = OFF**. | User có quyền thêm thành viên mời B vào nhóm. B mở hội thoại nhóm. | A vẫn xem được toàn bộ tin nhắn. B chỉ xem được tin từ thời điểm B tham gia, vẫn xem được tin ghim, nhắc hẹn, bình chọn, ghi chú nội bộ và hồ sơ khách hàng. |
| AC-04 | Bật lại cài đặt xem tin cũ | A đang trong nhóm và tham gia khi toggle **Thành viên mới xem được tin gửi gần đây = OFF**. | Trưởng nhóm chuyển toggle **Thành viên mới xem được tin gửi gần đây = ON**. User có quyền thêm thành viên mời B vào nhóm. | A và tất cả thành viên đang trong nhóm được xem toàn bộ tin nhắn, không cần tham gia lại. B mới tham gia cũng xem được toàn bộ tin nhắn trước thời điểm tham gia. |
| AC-05 | Giữ quyền xem khi tiếp tục tắt cài đặt | A tham gia khi toggle **Thành viên mới xem được tin gửi gần đây = OFF**, sau đó trưởng nhóm đã bật toggle để A xem toàn bộ lịch sử. | Trưởng nhóm chuyển toggle **Thành viên mới xem được tin gửi gần đây = OFF** lần nữa. User có quyền thêm thành viên mời B vào nhóm. | A vẫn xem được toàn bộ tin nhắn trong hội thoại. B chỉ xem được tin từ thời điểm B tham gia, vẫn xem được tin ghim, nhắc hẹn, bình chọn, ghi chú nội bộ và hồ sơ khách hàng. |
| AC-06 | Tham gia nhóm qua link không cần duyệt | Toggle **Duyệt thành viên tham gia qua link = OFF**. A chưa là thành viên.<br><br>[1] Toggle **Thành viên mới xem được tin gửi gần đây = ON**.<br><br>[2] Toggle **Thành viên mới xem được tin gửi gần đây = OFF**. | A truy cập link nhóm và click **Tham gia nhóm**, sau đó mở hội thoại nhóm. | [1] A xem được toàn bộ tin nhắn trong hội thoại nhóm.<br><br>[2] A chỉ xem được tin từ thời điểm tham gia, vẫn xem được tin ghim, nhắc hẹn, bình chọn, ghi chú nội bộ và hồ sơ khách hàng. |
| AC-07 | Tham gia nhóm qua link cần duyệt | Toggle **Duyệt thành viên tham gia qua link = ON**. A đã gửi yêu cầu tham gia và đang chờ duyệt.<br><br>[1] Toggle **Thành viên mới xem được tin gửi gần đây = ON**.<br><br>[2] Toggle **Thành viên mới xem được tin gửi gần đây = OFF**. | Trưởng nhóm duyệt A vào nhóm. A mở hội thoại nhóm. | [1] A xem được toàn bộ tin nhắn trong hội thoại nhóm.<br><br>[2] A chỉ xem được tin từ thời điểm được duyệt vào nhóm, vẫn xem được tin ghim, nhắc hẹn, bình chọn, ghi chú nội bộ và hồ sơ khách hàng. |
| AC-08 | Thay đổi cài đặt trong thời gian chờ duyệt | Toggle **Duyệt thành viên tham gia qua link = ON**. A đang chờ duyệt.<br><br>[1] A gửi yêu cầu khi toggle **Thành viên mới xem được tin gửi gần đây = OFF**.<br><br>[2] A gửi yêu cầu khi toggle **Thành viên mới xem được tin gửi gần đây = ON**. | [1] Trưởng nhóm bật toggle **Thành viên mới xem được tin gửi gần đây**, sau đó duyệt A.<br><br>[2] Trưởng nhóm tắt toggle **Thành viên mới xem được tin gửi gần đây**, sau đó duyệt A. | [1] A xem được toàn bộ tin nhắn trong hội thoại nhóm.<br><br>[2] A chỉ xem được tin từ thời điểm được duyệt vào nhóm, vẫn xem được tin ghim, nhắc hẹn, bình chọn, ghi chú nội bộ và hồ sơ khách hàng. |
| AC-09 | Tham gia nhóm bằng mã QR | A chưa là thành viên. Nhóm đang chia sẻ mã QR tham gia.<br><br>[1] **Duyệt thành viên tham gia qua link = OFF**, xem tin cũ = ON.<br><br>[2] **Duyệt thành viên tham gia qua link = OFF**, xem tin cũ = OFF.<br><br>[3] **Duyệt thành viên tham gia qua link = ON**, xem tin cũ = ON tại thời điểm duyệt.<br><br>[4] **Duyệt thành viên tham gia qua link = ON**, xem tin cũ = OFF tại thời điểm duyệt.<br><br>Cài đặt xem tin cũ là toggle **Thành viên mới xem được tin gửi gần đây**. | A quét mã QR và click **Tham gia nhóm**. Với [3], [4], trưởng nhóm duyệt A vào nhóm. | [1], [3] A xem được toàn bộ tin nhắn trong hội thoại nhóm.<br><br>[2], [4] A chỉ xem được tin từ thời điểm chính thức tham gia, vẫn xem được tin ghim, nhắc hẹn, bình chọn, ghi chú nội bộ và hồ sơ khách hàng. |
| AC-10 | Click tin ghim theo phạm vi lịch sử | [1] A có quyền xem toàn bộ lịch sử nhóm. Tin được ghim gửi trước khi A tham gia.<br><br>[2] B không có quyền xem tin nhắn cũ. Tin được ghim gửi trước khi B tham gia.<br><br>[3] B không có quyền xem tin nhắn cũ. Tin được ghim gửi sau khi B tham gia. | [1] A click tin ghim.<br><br>[2], [3] B click tin ghim tương ứng. | [1], [3] Điều hướng đến đúng tin và highlight theo logic hiện tại.<br><br>[2] Mở popup thông tin đúng tin ghim, không điều hướng đến đoạn chat và không mở các tin xung quanh. |
| AC-11 | Điều hướng tin ghim sau khi bật xem tin cũ | A không có quyền xem tin nhắn trước thời điểm tham gia. Nhóm có tin ghim thuộc giai đoạn đó. | Trưởng nhóm bật toggle **Thành viên mới xem được tin gửi gần đây**. A click tin ghim. | Hệ thống điều hướng đến đúng tin và highlight theo logic hiện tại, không mở popup thông tin tin ghim. |
| AC-12 | Tin văn bản dài trong popup | A không có quyền xem tin nhắn cũ. Tin ghim trước thời điểm tham gia là văn bản nhiều dòng, dài hơn vùng hiển thị popup. | A click tin ghim và cuộn nội dung trong popup. | User xem được đầy đủ nội dung tin nhắn. Không điều hướng đến tin trong đoạn chat. |
| AC-13 | Tin ghim ảnh kèm text | A không có quyền xem tin nhắn cũ. Tin ghim trước khi A tham gia là ảnh.<br><br>[1] Ảnh có mô tả.<br><br>[2] Ảnh không có mô tả riêng nhưng có nội dung văn bản gửi kèm trong cùng tin. | A click tin ghim, click thumbnail, sau đó click icon copy và dán nội dung. | Cả hai trường hợp hiển thị thumbnail cùng đúng phần text của tin đó. Click thumbnail không mở trình xem ảnh. Sao chép đúng phần mô tả/text thuộc tin ảnh. |
| AC-14 | Tin ghim ảnh không kèm text | A không có quyền xem tin nhắn cũ. Tin ghim trước khi A tham gia chỉ có ảnh, không có text. Có một tin văn bản riêng ngay cạnh tin ảnh. | A click tin ghim, sau đó click thumbnail. | Popup hiển thị thumbnail ảnh, icon copy disabled. Click thumbnail không mở trình xem ảnh. Không lấy nội dung của tin văn bản riêng bên cạnh. |
| AC-15 | Tin ghim video | A không có quyền xem tin nhắn cũ. Tin ghim trước khi A tham gia là video.<br><br>[1] Video có text đi kèm.<br><br>[2] Video không có text đi kèm. | A click tin ghim, sau đó click thumbnail. Với [1], A click copy và dán nội dung. | [1] Hiển thị thumbnail video và text đi kèm, sao chép đúng phần mô tả/text thuộc tin video.<br><br>[2] Hiển thị thumbnail video, copy disabled.<br>Cả hai trường hợp click thumbnail không mở trình xem video và không phát video. |
| AC-16 | Hiển thị tin ghim tệp trong popup | A không có quyền xem tin nhắn cũ. Tin ghim trước khi A tham gia là tệp. | A click tin ghim, sau đó click icon tệp. | Popup hiển thị đúng người gửi, icon tệp, nhãn **[File]** và tên tệp. Icon copy enabled. Không điều hướng đến đoạn chat. Click icon tệp không mở tệp và không tải tệp về. |
| AC-17 | Sao chép tên tệp | User đang mở popup tin ghim dạng tệp. | User click icon copy và dán nội dung. | Sao chép đúng tên tệp, không sao chép nhãn **[File]**. |
| AC-18 | Sao chép tin văn bản | A đang mở popup tin ghim văn bản có nhiều dòng. | A click icon copy và dán nội dung. | Sao chép đúng toàn bộ nội dung văn bản của tin ghim. |
| AC-19 | Đóng popup thông tin tin ghim | Popup đang mở. Hội thoại có nội dung đang soạn và vị trí cuộn hiện tại. | [1] User click icon **X**.<br><br>[2] User click nút **Đóng**.<br><br>[3] User click lớp phủ ngoài popup.<br><br>[4] User nhấn **Esc**. | Hệ thống đóng popup, giữ nội dung đang soạn và vị trí cuộn của hội thoại. Không điều hướng đến tin ghim, không đồng thời kích hoạt thao tác ở màn phía sau. |
| AC-20 | Tương tác bên trong popup | User đang mở popup chứa nội dung dài và icon copy enabled. | User click vùng nội dung, cuộn nội dung, click icon copy. | Popup tiếp tục mở. Thao tác chỉ áp dụng trong popup, không kích hoạt tin nhắn và thao tác ở màn phía sau. |
| AC-21 | Tin ghim đã xóa/thu hồi | Tin ghim đã xóa/thu hồi.<br><br>[1] A có quyền xem toàn bộ tin nhắn trong hội thoại nhóm.<br><br>[2] B không có quyền xem tin nhắn cũ, tin được gửi trước khi B tham gia. | [1] A click tin ghim.<br><br>[2] B click tin ghim. | [1] Điều hướng đến đúng tin và highlight theo logic hiện tại.<br><br>[2] Mở popup thông tin tin ghim, giữ trạng thái hiển thị xóa/thu hồi. Với ảnh thu hồi, thumbnail đen trắng và có nhãn trạng thái hiện tại. Không mở các tin xung quanh. |
| AC-22 | Click nội dung media và tệp trong popup | User đang mở popup tin ghim.<br><br>[1] Tin ảnh/video có thumbnail.<br><br>[2] Tin tệp có icon và tên tệp. | [1] User click thumbnail.<br><br>[2] User click icon tệp, tên tệp. | Popup tiếp tục hiển thị. Không mở trình xem ảnh/video, không phát video, không mở tệp, không tải tệp và không điều hướng đến tin trong đoạn chat. |
| AC-23 | Mở toàn bộ lịch sử tại các phần liên quan | A tham gia khi toggle **Thành viên mới xem được tin gửi gần đây = OFF**. Nhóm có tin cũ chứa từ khóa, ảnh/video/tài liệu/liên kết. | Trưởng nhóm bật toggle **Thành viên mới xem được tin gửi gần đây**. A cuộn lên xem tin cũ, tìm từ khóa và mở kho Ảnh/Video/Tài liệu/Liên kết. | A xem được toàn bộ tin trong hội thoại, tìm được tin cũ theo nội dung tìm kiếm và xem được nội dung tương ứng trong kho. Tin hiển thị đúng thứ tự, người gửi, ngày giờ gửi gốc và trạng thái, không trùng tin. |
| AC-24 | Xem các mục liên quan khi không có quyền xem tin nhắn cũ | A là thành viên mới, không có quyền xem tin nhắn trước thời điểm tham gia. | A xem tin ghim tại hội thoại, truy cập các mục thông tin liên quan, sau đó click tin ghim trước thời điểm tham gia. | A xem được:<br>+ Tin nhắn đã ghim.<br>+ Nhắc hẹn.<br>+ Bình chọn.<br>+ Ghi chú nội bộ.<br>+ Hồ sơ khách hàng.<br>Click tin ghim trước thời điểm tham gia mở popup, không mở thêm các tin cũ khác trong chat, tìm kiếm và kho nội dung. |
| AC-25 | Không coi lịch sử cũ là tin mới | A đang trong nhóm, chưa có quyền xem tin nhắn cũ. Hội thoại có số chưa đọc và vị trí trong danh sách hiện tại. Không có tin nhắn mới phát sinh trong lúc thay đổi cài đặt. | Trưởng nhóm bật toggle **Thành viên mới xem được tin gửi gần đây**. | Việc mở lịch sử cũ không cộng thêm chưa đọc, không phát lại thông báo và không đẩy nhóm lên đầu danh sách. Ngày hiển thị của tin cũ là ngày gửi gốc. |
| AC-26 | Giữ quyền xem khi mở lại hội thoại | A có quyền xem toàn bộ tin nhắn trong hội thoại nhóm, toggle **Thành viên mới xem được tin gửi gần đây** hiện OFF. | [1] A đóng rồi mở lại hội thoại.<br><br>[2] A tải lại trang.<br><br>[3] A truy cập hội thoại trên desktop/mobile. | A tiếp tục xem được toàn bộ tin nhắn trong hội thoại nhóm. Không tính lại phạm vi chỉ dựa trên trạng thái OFF hiện tại. |
| AC-27 | Khắc phục lịch sử thiếu trước triển khai | [1] A đã tham gia khi toggle **Thành viên mới xem được tin gửi gần đây = ON**, nhưng không xem được tin cũ do lỗi hiện tại.<br><br>[2] B tham gia khi toggle = OFF, sau đó trưởng nhóm đã bật rồi tắt toggle. B vẫn thiếu tin cũ do lỗi hiện tại. | Triển khai điều chỉnh và hoàn tất xử lý dữ liệu cũ. A, B mở hội thoại nhóm. | A, B xem được toàn bộ tin nhắn trong hội thoại. Không yêu cầu rời nhóm, tham gia lại, bật/tắt lại cài đặt. Không mở tin cũ cho thành viên chưa từng thuộc diện được xem toàn bộ lịch sử. |

## 8. Data Migration

| Phạm vi | Yêu cầu |
| :--- | :--- |
| Cài đặt nhóm | Giữ nguyên trạng thái bật/tắt của tính năng **Thành viên mới xem được tin gửi gần đây** tại các nhóm đã tồn tại. Không tự bật tính năng khi triển khai. Cài đặt mặc định khi tạo nhóm mới giữ nguyên logic hiện tại. |
| Quyền xem tin nhắn của thành viên | • Thành viên đã có quyền xem toàn bộ lịch sử tiếp tục xem được toàn bộ tin nhắn, kể cả khi tính năng hiện đang tắt.<br>• Thành viên không có quyền xem tin nhắn trước thời điểm tham gia tiếp tục chỉ xem được tin từ thời điểm tham gia. Các mục vẫn xem được tại BR-05 không bị ảnh hưởng. |
| Thành viên bị ảnh hưởng trước triển khai | Khắc phục phần lịch sử còn thiếu cho thành viên đã tham gia khi tính năng bật và thành viên đã được cấp quyền xem toàn bộ lịch sử khi tính năng được bật lại. Sau triển khai, các thành viên này xem được đầy đủ tin nhắn thuộc quyền xem đã có, không cần rời nhóm, tham gia lại, bật/tắt lại cài đặt. |
| Dữ liệu tin nhắn | Bổ sung lịch sử còn thiếu, giữ nguyên nội dung, người gửi, ngày giờ gửi và trạng thái tin nhắn. Hiển thị đúng thứ tự, không tạo trùng tin. Cập nhật nội dung tương ứng tại tìm kiếm và kho Ảnh/Video/Tài liệu/Liên kết. |

## 9. Change Log

| Version | Date | Nội dung thay đổi | Reason |
| :--- | :--- | :--- | :--- |
