# \[CR\] \[Zalo Chat\] Điều chỉnh hành vi dán ảnh trực tiếp tại khu vực soạn tin

| Request |  |  |  |
| :---- | :---- | :---- | :---- |
| Component | \[Zalo Chat\]<br>Điều chỉnh hành vi dán ảnh trực tiếp tại khu vực soạn tin | ID | N/A |
| Requested by | AVZ \- Khách hàng | Date | 15/10/2026 |
| Priority | Medium |  |  |
| Status | Approved |  |  |
| UI&nbsp; | [Link](https://www.figma.com/design/JJmutumExOgUdrTmukxGDL/GOPANY--Zalo-Chat?node-id=35-2&t=glrNHS3BsP2ZoUJE-4) |  |  |
| Written by | BA \- Nguyễn Thị Phương Thảo |  |  |

&nbsp;

## 1\. Current Situation

Hiện tại, khi user dán ảnh bằng Ctrl+V, hệ thống mở popup **Gửi Media (Ảnh, Video, Âm thanh)**. Trường **Ghi chú (tùy chọn)** tại popup chưa hỗ trợ @mention thành viên trong nhóm, nên user chưa thể vừa đính kèm ảnh vừa soạn nội dung có @mention để gửi.

Tại Zalo Chat, bổ sung dán ảnh trực tiếp vào khu vực soạn tin, hiển thị thumbnail ảnh mà không mở popup Gửi Media. Cho phép user tiếp tục nhập nội dung, chọn @mention trong nhóm và thêm mô tả riêng cho từng ảnh trước khi gửi.

## 2\. Expectation

| Mục tiêu | Nội dung |
| :---- | :---- |
| Dán một hoặc nhiều ảnh trực tiếp | Cho phép user Ctrl+V ảnh vào khu vực soạn tin và tiếp tục dán để thêm nhiều ảnh. Ảnh hiển thị dưới dạng thumbnail đính kèm, không mở popup Gửi Media. |
| Soạn nội dung có @mention khi gửi ảnh | User tiếp tục nhập nội dung và chọn @mention thành viên trong nhóm tại ô soạn tin trước khi gửi ảnh. |
| Thêm mô tả cho từng ảnh | Cho phép xem trước, thêm, chỉnh sửa và gỡ mô tả riêng của từng ảnh. Mô tả đã lưu hiển thị trên thumbnail để user nhận biết. |
| Quản lý ảnh trước khi gửi | Cho phép xóa từng ảnh và xóa tất cả ảnh đang đính kèm, giữ nguyên nội dung tại ô soạn tin. |

&nbsp;

## 3\. Định nghĩa và thuật ngữ

| Thuật ngữ | Định nghĩa |
| :---- | :---- |
| Ô soạn tin | Ô nhập nội dung tại hội thoại, hỗ trợ @mention trong nhóm theo logic hiện tại. |
| Khu vực ảnh đính kèm | Khu vực hiển thị thumbnail của các ảnh đã dán, đang chuẩn bị gửi. |
| Mô tả ảnh | Nội dung tùy chọn thuộc riêng một ảnh, được nhập tại Modal Nhập mô tả. Không hỗ trợ chọn @mention. |
| Tin nhắn riêng | Tin nhắn chứa nội dung từ ô soạn tin, được gửi riêng trước ảnh/cụm ảnh. |
| Cụm ảnh | Cách hiển thị nhiều ảnh trong cùng một lần gửi. Mỗi ảnh giữ mô tả tương ứng nếu có. |
| Mô tả chưa lưu | Phần thêm, chỉnh sửa hoặc gỡ mô tả chưa được xác nhận bằng nút Lưu trong lần mở Modal Nhập mô tả hiện tại. |

&nbsp;

## 4\. Scope

### 4.1. In Scope

Áp dụng tại khu vực soạn tin trên desktop, trong hội thoại cá nhân và hội thoại nhóm mà user có quyền gửi tin.

- Cho phép user dán ảnh trực tiếp vào khu vực soạn tin bằng Ctrl+V, hiển thị thumbnail ảnh đính kèm mà không mở popup Gửi Media.  
- Bổ sung quản lý ảnh đính kèm và mô tả riêng của từng ảnh trước khi gửi.  
- Hỗ trợ gửi ảnh cùng nội dung soạn, @mention trong nhóm và khi đang trả lời tin nhắn.  
- Điều chỉnh cách hiển thị một ảnh, nhiều ảnh và mô tả tương ứng sau khi gửi.

*~~Note: Giữ nguyên logic nghiệp vụ hiện tại về phân quyền, điều kiện gửi tin, định dạng và dung lượng ảnh, trạng thái gửi, mở trình xem ảnh và các thao tác với ảnh đã gửi, ngoại trừ các thay đổi được mô tả trong Change Request này.~~*

*Note: Giữ nguyên logic nghiệp vụ hiện tại về phân quyền, điều kiện gửi tin, định dạng và dung lượng từng ảnh, trạng thái gửi, mở trình xem ảnh và các thao tác với ảnh đã gửi, ngoại trừ các thay đổi được mô tả trong Change Request này.*

### 4.2. Out of Scope

- Không thay đổi luồng tải ảnh bằng icon hiện tại đang mở popup Gửi Media.  
- Không bổ sung dán video, âm thanh, tệp tin và thao tác kéo thả.  
- Không bổ sung chỉnh sửa ảnh nguồn.  
- Không hỗ trợ thay đổi thứ tự ảnh bằng thao tác kéo thumbnail tại dải ảnh đính kèm trong khu vực soạn tin.  
- Không bổ sung lưu bản nháp ảnh qua tải lại trang, đóng trình duyệt hoặc đăng nhập trên thiết bị khác.

## 5\. Change Details

### 5.1. Bảng thay đổi

| ID | Current Behavior | New Behavior | Reason |
| :---- | :---- | :---- | :---- |
| CR-01 | Khi user Ctrl+V ảnh, hệ thống mở popup Gửi Media. Trường Ghi chú tại popup chưa hỗ trợ @mention. | • Dán ảnh hiển thị thumbnail tại khu vực soạn tin, không mở popup Gửi Media và chưa gửi ảnh.<br>• Cho phép dán tiếp để thêm nhiều ảnh vào cùng danh sách gửi.<br>• User tiếp tục nhập nội dung, chọn @mention trong nhóm và gửi ảnh tại khu vực soạn tin. | Cho phép user đính kèm ảnh và soạn nội dung có @mention ngay tại hội thoại. |
| CR-02 | N/A | • Bổ sung icon chỉnh sửa và Xóa khi hover thumbnail, cho phép xóa từng ảnh và xóa tất cả ảnh đính kèm.<br>• Click icon chỉnh sửa hiển thị Modal Nhập mô tả để thêm/chỉnh sửa mô tả riêng của ảnh.<br>• Click Lưu lưu mô tả và cập nhật thumbnail, chưa gửi ảnh.<br>• Khi yêu cầu đóng modal trong lúc còn nội dung mô tả vừa nhập chưa lưu, hiển thị popup Huỷ mô tả để xác nhận. | Giúp user xem trước ảnh, bổ sung thông tin cho đúng ảnh và xóa ảnh không cần gửi. Tránh mất nội dung mô tả vừa nhập khi đóng modal. |

&nbsp;

### 5.2. Business Rules

| ID | Nội dung | Mô tả |
| :---- | :---- | :---- |
| BR-01 | Dán ảnh trực tiếp | ~~• User Ctrl+V ảnh tại ô soạn tin để thêm ảnh vào khu vực ảnh đính kèm. Hệ thống không mở popup Gửi Media và chưa gửi ảnh.~~<br>~~• Cho phép Ctrl+V tiếp để thêm nhiều ảnh vào cùng danh sách. Ảnh mới được thêm vào cuối danh sách, không thay thế các ảnh đã có.~~<br>~~• Giữ thứ tự của các ảnh còn lại sau khi xóa. Điều kiện tổng dung lượng ảnh thực hiện theo logic hiện tại.~~<br>• User Ctrl+V ảnh tại ô soạn tin để thêm ảnh vào khu vực ảnh đính kèm. Hệ thống không mở popup Gửi Media và chưa gửi ảnh.<br>• Cho phép Ctrl+V tiếp để thêm nhiều ảnh vào cùng danh sách. Ảnh mới được thêm vào cuối danh sách, không thay thế các ảnh đã có.<br>• Giữ thứ tự của các ảnh còn lại sau khi xóa. Danh sách ảnh đính kèm tối đa 25 ảnh. |
| BR-02 | Giữ nội dung đang soạn | • Dán ảnh không thay thế nội dung tại ô soạn tin.<br>• Mở modal, lưu mô tả, hủy chỉnh sửa và xóa ảnh không làm mất nội dung soạn hoặc @mention đã chọn.<br>• Các thao tác này không tự hủy trạng thái đang trả lời tin nhắn và không tự gửi tin. |
| BR-03 | ~~Tổng dung lượng ảnh~~<br>Số lượng ảnh mỗi lần gửi | ~~• Giữ nguyên logic hiện tại: tổng kích thước ảnh tải lên trong một lần gửi phải **nhỏ hơn 25 MB**.~~<br>~~• Tổng dung lượng được tính trên tất cả ảnh còn lại trong danh sách gửi, không tính riêng từng lần Ctrl+V.~~<br>~~• Khi user Gửi với tổng dung lượng **bằng hoặc lớn hơn 25 MB**, chặn toàn bộ lần gửi, gồm nội dung soạn và ảnh. Hiển thị thông báo giữa màn hình: **Tổng kích thước ảnh tải lên phải nhỏ hơn 25 M**.~~<br>~~• Không tự gửi một phần ảnh để đáp ứng giới hạn. Giữ ảnh, mô tả và nội dung soạn để user xóa bớt. Khi tổng dung lượng nhỏ hơn 25 MB và đáp ứng các điều kiện khác, cho phép gửi lại.~~<br>• Tối đa **25 ảnh** trong danh sách ảnh đính kèm của một lần gửi.<br>• Số lượng tính trên toàn bộ ảnh còn lại trong danh sách, không tính riêng từng lần Ctrl+V.<br>• Khi danh sách đã có 25 ảnh, user dán thêm ảnh thứ 26 thì chặn thêm ảnh và hiển thị thông báo giữa màn hình: **Bạn chỉ nên gửi tối đa 25 ảnh/ lần**. Không thêm ảnh làm danh sách vượt quá 25 ảnh.<br>• Giữ các ảnh đã có, mô tả và nội dung soạn. User có thể xóa bớt ảnh rồi thêm ảnh khác, bảo đảm danh sách không vượt quá 25 ảnh.<br>• Khi gửi, kiểm tra danh sách không vượt quá 25 ảnh trước khi gửi nội dung và ảnh. |
| BR-04 | Mô tả riêng của từng ảnh | Mỗi ảnh có một mô tả tùy chọn. Thêm, chỉnh sửa hoặc gỡ mô tả của ảnh này không thay đổi mô tả ảnh khác. Không tự sao chép nội dung ô soạn tin vào mô tả ảnh. |
| BR-05 | Mở Modal Nhập mô tả | Click icon chỉnh sửa hiển thị Modal Nhập mô tả của ảnh tương ứng. Click trực tiếp thumbnail ngoài hai icon cũng mở cùng modal. Nếu ảnh đã có mô tả, trường nhập hiển thị nội dung đã lưu để user chỉnh sửa. Click icon Xóa chỉ xóa ảnh, không đồng thời mở modal. |
| BR-06 | Chuyển ảnh trong modal | User có thể chọn thumbnail hoặc nút chuyển ảnh trong modal. Hệ thống giữ tạm nội dung vừa chỉnh của từng ảnh trong lần mở modal đó. Khi quay lại ảnh đã chỉnh, hiển thị đúng nội dung vừa nhập, không gán mô tả sang ảnh khác. |
| BR-07 | Nhập mô tả | Trường mô tả không hỗ trợ chọn @mention. Ký tự `@` là văn bản thông thường, không tạo mention. Nhấn Enter để xuống dòng, không gửi tin. Nội dung chỉ gồm khoảng trắng/xuống dòng được xem là trống. |
| BR-08 | Độ dài mô tả ảnh | • Mỗi ảnh có mô tả tối đa **~~1.580~~  2000 bytes**, tính cả khoảng trắng và ký tự xuống dòng.<br>• Khi đã đủ ~~1.580~~ 2000 **bytes**, không cho nhập thêm ký tự.<br>• Khi dán nội dung dài, chỉ nhận phần nội dung trong giới hạn còn lại của trường, không để mô tả vượt 1\.~~580~~ 2000 **bytes**.<br>• Giới hạn áp dụng riêng cho từng ảnh, không cộng độ dài mô tả của nhiều ảnh. |
| BR-09 | Lưu và gỡ mô tả | Click Lưu lưu toàn bộ thay đổi mô tả của các ảnh đã chỉnh trong lần mở modal đó, đóng modal và cập nhật thumbnail. Với ảnh có mô tả đã lưu, xóa hết nội dung rồi Lưu để gỡ mô tả khỏi ảnh. Lưu mô tả không gửi ảnh. |
| BR-10 | Hiển thị mô tả trên thumbnail | Mô tả đã lưu hiển thị trên thumbnail để nhận biết ảnh có mô tả. Nếu vượt **8 ký tự**, hiển thị **8 ký tự đầu \+ “…”**. Mô tả có tối đa 8 ký tự hiển thị đầy đủ. Chỉ rút gọn phần hiển thị, giữ nguyên nội dung đầy đủ để chỉnh sửa và gửi. |
| BR-11 | Đóng modal khi không còn nội dung vừa nhập | Click Hủy, đóng modal, nhấn Esc hoặc click vùng tối ngoài ảnh để đóng Modal Nhập mô tả mà không hiển thị popup khi không còn nội dung mô tả mới/chỉnh sửa chưa lưu ở bất kỳ ảnh nào. Áp dụng khi chưa nhập, nhập rồi xóa hết hoặc đưa nội dung về đúng giá trị đã lưu. Các chỉnh sửa chưa Lưu không được áp dụng. Nếu đã xóa mô tả cũ nhưng chưa Lưu rồi đóng modal, mô tả đã lưu trước đó vẫn giữ nguyên. |
| BR-12 | Hiển thị popup Huỷ mô tả | Khi ít nhất một ảnh còn nội dung mô tả mới/chỉnh sửa **không trống và chưa lưu**, click Hủy, đóng modal, nhấn Esc hoặc click vùng tối ngoài ảnh sẽ mở popup **Huỷ mô tả**. Chưa đóng Modal Nhập mô tả và chưa bỏ nội dung. Chỉ xóa hết mô tả mà không còn nội dung vừa nhập ở ảnh khác không làm hiển thị popup. |
| BR-13 | Xác nhận Huỷ mô tả | Click **Huỷ mô tả** tại popup để đóng popup và Modal Nhập mô tả, không lưu các chỉnh sửa của tất cả ảnh trong lần mở modal hiện tại. Giữ mô tả đã lưu trước khi mở modal, các ảnh, nội dung soạn, @mention và trạng thái trả lời tin nhắn. Không gửi ảnh. |
| BR-14 | Quay lại chỉnh sửa | Click **Quay lại**, icon Đóng hoặc nhấn Esc tại popup Huỷ mô tả để chỉ đóng popup, tiếp tục ở Modal Nhập mô tả và giữ toàn bộ nội dung đang chỉnh. |
| BR-15 | Vùng tối và lớp tương tác | Click vùng tối ngoài ảnh xử lý theo điều kiện tại modal. Click trường nhập, thumbnail, nút chuyển ảnh và các nút thao tác không được tính là click vùng tối để đóng modal. Khi popup Huỷ mô tả mở, chỉ popup nhận tương tác, không truyền thao tác xuống modal hoặc hội thoại phía sau. |
| BR-16 | Xóa một ảnh | ~~Click icon Xóa để xóa đúng ảnh và mô tả tương ứng khỏi danh sách gửi. Giữ các ảnh còn lại, đúng mô tả, đúng thứ tự, nội dung soạn và trạng thái trả lời tin nhắn. Tính lại tổng dung lượng trên các ảnh còn lại.~~<br>Click icon Xóa để xóa đúng ảnh và mô tả tương ứng khỏi danh sách gửi. Giữ các ảnh còn lại, đúng mô tả, đúng thứ tự, nội dung soạn và trạng thái trả lời tin nhắn. Cập nhật số lượng ảnh còn lại để user có thể thêm ảnh trong giới hạn 25 ảnh. |
| BR-17 | Xóa tất cả ảnh | Click Xóa tất cả để xóa toàn bộ ảnh và mô tả khỏi danh sách gửi, ẩn khu vực ảnh đính kèm. Giữ nội dung soạn, @mention và trạng thái trả lời tin nhắn. Nếu không còn ảnh và ô soạn trống, không gửi tin rỗng theo logic hiện tại. |
| BR-18 | Bản nháp theo hội thoại | Ảnh đính kèm và mô tả đã lưu thuộc đúng bản nháp của hội thoại và tài khoản Zalo tương ứng. Chuyển sang hội thoại khác không mang ảnh/mô tả sang hội thoại đó. Quay lại trong cùng phiên sử dụng hiển thị bản nháp chưa gửi. |
| BR-19 | Soạn tin và @mention | Khi đang đính kèm ảnh, user tiếp tục nhập nội dung và chọn @mention trong nhóm theo logic hiện tại. Gửi đi giữ đúng thành viên được nhắc và chức năng mention, không nhân bản mention theo số ảnh. Mention đã chọn, kể cả mention tự động khi reply, được tính là nội dung. |
| BR-20 | Gửi thông thường | • Một ảnh không có mô tả: nội dung soạn đi cùng ảnh.<br>• Một ảnh có mô tả: nội dung soạn được gửi thành tin nhắn riêng trước ảnh.<br>• Nhiều ảnh: nội dung soạn được gửi thành tin nhắn riêng trước cụm ảnh, không lặp trên từng ảnh hoặc ghép vào riêng một ảnh chưa có mô tả.<br>• Nếu ô soạn trống, chỉ gửi ảnh/cụm ảnh và mô tả tương ứng. |
| BR-21 | Gửi khi đang trả lời tin nhắn | • Khi ô soạn có nội dung, gửi tin nhắn trả lời gồm trích dẫn và nội dung soạn trước ảnh/cụm ảnh, kể cả chỉ có một ảnh không có mô tả.<br>• Trong nhóm, nếu chỉ còn mention tự động thì vẫn gửi tin nhắn trả lời có mention trước ảnh.<br>• Ô soạn trống thì chỉ gửi ảnh/cụm ảnh và mô tả, không tạo tin nhắn trả lời rỗng.<br>• Trích dẫn không gắn vào ảnh. Mô tả ảnh không được dùng thay nội dung trả lời. |
| BR-22 | Thứ tự và gửi lại | Khi có tin nhắn riêng hoặc tin nhắn trả lời, gửi nội dung trước ảnh/cụm ảnh. Nội dung dài tự tách, trạng thái gửi và gửi lại kế thừa logic hiện tại. Thử lại phần lỗi không gửi lại phần đã thành công và không làm sai mô tả của ảnh. |

&nbsp;

### 5.3. Quy tắc gửi và hiển thị thông thường

Áp dụng khi user không đang trả lời tin nhắn. Nội dung soạn có thể bao gồm @mention trong nhóm. Mô tả ảnh sử dụng nội dung đã Lưu.

| Số ảnh | Mô tả ảnh | Nội dung tại ô soạn tin | Kết quả |
| :---- | :---- | :---- | :---- |
| Một ảnh | Không có | Trống | Chỉ gửi ảnh. |
| Một ảnh | Không có | Có | Gửi ảnh kèm nội dung đã soạn trong cùng một tin nhắn. Giữ @mention nếu có. |
| Một ảnh | Có | Trống | Gửi ảnh kèm mô tả bên dưới ảnh. |
| Một ảnh | Có | Có | Nội dung soạn được gửi thành tin nhắn riêng trước ảnh. Ảnh đi kèm mô tả đã lưu. |
| Nhiều ảnh | Không ảnh nào có | Trống | Chỉ gửi cụm ảnh. Không hiển thị dải mô tả trên ảnh. |
| Nhiều ảnh | Không ảnh nào có | Có | Nội dung soạn được gửi thành tin nhắn riêng trước cụm ảnh. Không lặp nội dung trên từng ảnh. |
| Nhiều ảnh | Một số ảnh có | Trống | Gửi cụm ảnh. Chỉ ảnh có mô tả hiển thị mô tả tương ứng. |
| Nhiều ảnh | Một số ảnh có | Có | Nội dung soạn được gửi thành tin nhắn riêng trước cụm ảnh. Mô tả chỉ hiển thị tại ảnh tương ứng, không lấy nội dung soạn gán cho ảnh chưa có mô tả. |
| Nhiều ảnh | Tất cả ảnh có | Trống | Gửi cụm ảnh, từng ảnh hiển thị mô tả riêng. |
| Nhiều ảnh | Tất cả ảnh có | Có | Nội dung soạn được gửi thành tin nhắn riêng trước cụm ảnh, từng ảnh hiển thị mô tả riêng. |

&nbsp;

### 5.4. Gửi ảnh khi đang trả lời tin nhắn

User click Reply rồi dán ảnh, thêm mô tả và nhập nội dung như thao tác soạn thông thường. Dán ảnh không tự hủy trạng thái trả lời tin nhắn.

| Hội thoại | Nội dung tại ô soạn tin | Kết quả |
| :---- | :---- | :---- |
| Cá nhân/nhóm | Có nội dung hợp lệ, có thể kèm @mention trong nhóm | Gửi tin nhắn trả lời gồm trích dẫn và nội dung soạn trước ảnh/cụm ảnh. Mô tả đi cùng đúng ảnh. |
| Nhóm | Không nhập thêm chữ, vẫn giữ @mention tự động khi reply | Gửi tin nhắn trả lời gồm trích dẫn và @mention trước ảnh/cụm ảnh. |
| Cá nhân | Trống | Chỉ gửi ảnh/cụm ảnh và mô tả nếu có. Không tạo tin nhắn trả lời rỗng, không gắn trích dẫn vào ảnh. |
| Nhóm | Đã xóa mention và không còn nội dung hợp lệ | Chỉ gửi ảnh/cụm ảnh và mô tả nếu có. Không tạo tin nhắn trả lời rỗng, không gắn trích dẫn vào ảnh. |

&nbsp;

Các trường hợp trên áp dụng cho một ảnh và nhiều ảnh, có mô tả và không có mô tả. Khi đang trả lời tin nhắn, kể cả chỉ có một ảnh không có mô tả, nội dung soạn vẫn nằm trong tin nhắn trả lời riêng trước ảnh.

Nếu user chủ động đóng vùng trả lời trước khi gửi, gửi nội dung và ảnh còn lại như gửi thông thường. Auto @mention trong nhóm, cách hiển thị tên, thay đổi tin được trả lời và xử lý khi tin gốc bị thu hồi giữ nguyên logic hiện tại. Sau khi hoàn tất lần gửi, trạng thái trả lời kết thúc theo logic hiện tại.

## 6\. UI Specification

Link UI: [https\://www\.figma.com/design/JJmutumExOgUdrTmukxGDL/GOPANY--Zalo-Chat?node-id=35-2\&t=glrNHS3BsP2ZoUJE-4](https://www.figma.com/design/JJmutumExOgUdrTmukxGDL/GOPANY--Zalo-Chat?node-id=35-2&t=glrNHS3BsP2ZoUJE-4)&nbsp;

*Note: Bảng dưới mô tả các thành phần UI được bổ sung, điều chỉnh và hành vi liên quan trong Change Request này. Các thành phần UI và logic còn lại giữ nguyên theo hệ thống hiện tại.*

### 6.1. Khu vực soạn tin khi đính kèm ảnh

| UI Element | Control Type | Required? | Default Value | Mô tả |
| :---- | :---- | :---- | :---- | :---- |
| Khu vực ảnh đính kèm | Container | N/A | Ẩn | Hiển thị bên dưới ô soạn tin khi có ảnh được dán bằng Ctrl+V. Gồm số lượng ảnh, các thumbnail và Xóa tất cả. Hiển thị một hàng thumbnail, cuộn ngang khi vượt chiều rộng khu vực. |
| Số lượng ảnh | Text | N/A | N/A | Hiển thị `{n} ảnh`, cập nhật theo số ảnh đang đính kèm sau mỗi lần thêm/xóa. |
| Thumbnail ảnh | Image | N/A | N/A | Hiển thị ảnh đang chuẩn bị gửi theo thứ tự dán. Click thumbnail mở Modal Nhập mô tả của ảnh tương ứng. |
| Icon chỉnh sửa | Icon Button | N/A | Ẩn | Hiển thị khi user hover trong phạm vi thumbnail, tiếp tục hiển thị khi con trỏ trên icon. Click icon chỉnh sửa hiển thị Modal Nhập mô tả. Tooltip là **Thêm mô tả** khi ảnh chưa có mô tả, **Chỉnh sửa mô tả** khi ảnh đã có mô tả. |
| Icon Xóa | Icon Button | N/A | Ẩn | Hiển thị cùng icon chỉnh sửa khi hover thumbnail. Tooltip **Xóa ảnh**. Click để xóa đúng ảnh và mô tả tương ứng, không mở modal. |
| Xóa tất cả | Text Button | N/A | N/A | Hiển thị tại khu vực ảnh đính kèm. Click để xóa toàn bộ ảnh và mô tả đang đính kèm, giữ nội dung soạn, @mention và trạng thái trả lời tin nhắn. |
| Ô soạn tin | Textbox | N/A | Giữ giá trị hiện tại | Tiếp tục nhập nội dung, chọn @mention trong nhóm và hiển thị vùng trả lời theo logic hiện tại. Dán ảnh không thay thế nội dung đang soạn. |
| Gửi | Button | N/A | Theo điều kiện gửi hiện tại | Click để gửi nội dung và ảnh đang đính kèm. |

&nbsp;

### 6.2. Modal Nhập mô tả

| UI Element | Control Type | Required? | Default Value | Mô tả |
| :---- | :---- | :---- | :---- | :---- |
| Modal Nhập mô tả | Modal | N/A | Ẩn | Mở khi user click icon chỉnh sửa hoặc thumbnail ảnh. Hiển thị đúng ảnh được chọn. |
| Tiêu đề | Text | N/A | N/A | Hiển thị **Nhập mô tả** tại đầu modal. |
| Ảnh đang chọn | Image | N/A | Ảnh được click | Hiển thị ảnh để user xem trước và nhập mô tả. |
| Danh sách ảnh | Image List | N/A | Danh sách ảnh đính kèm | Hiển thị các thumbnail, đánh dấu ảnh đang chọn. Click thumbnail để chuyển ảnh, giữ tạm nội dung mô tả vừa chỉnh của các ảnh khác trong lần mở modal. |
| Nút chuyển ảnh | Icon Button | N/A | Theo ảnh đang chọn | Chuyển ảnh trước/sau theo thứ tự danh sách. Chỉ nhận thao tác khi có ảnh tương ứng để chuyển. |
| Mô tả ảnh | Textarea | No | Mô tả đã lưu của ảnh nếu có | Placeholder **Nhập mô tả cho ảnh**. Hiển thị mô tả đã lưu để chỉnh sửa. Tối đa **~~1.580~~ 2000 bytes** cho mỗi ảnh, không cho nhập vượt giới hạn. Khi chuyển qua lại giữa các ảnh, hiển thị nội dung vừa chỉnh của từng ảnh. Enter xuống dòng. Không hỗ trợ chọn @mention. |
| Lưu | Button | N/A | Disable khi chưa nhập mô tả | • Chưa nhập mô tả và không có thay đổi nào cần lưu: disable.<br>• Đã nhập nội dung mô tả: enable. Nhập mới rồi xóa hết, không còn thay đổi ở ảnh khác: disable.<br>• Nút Lưu áp dụng cho toàn bộ thay đổi trong lần mở modal. Chuyển sang ảnh chưa có mô tả vẫn cho phép lưu nội dung đã chỉnh của ảnh khác.<br>• Với ảnh có mô tả đã lưu từ trước, xóa hết nội dung vẫn cho phép Lưu để gỡ mô tả.<br>• Click Lưu cập nhật mô tả của các ảnh đã chỉnh, đóng modal và không gửi ảnh. |
| Hủy | Button | N/A | N/A | Nếu còn nội dung mô tả mới/chỉnh sửa chưa lưu ở ít nhất một ảnh, mở popup Huỷ mô tả. Nếu chưa nhập hoặc đã xóa hết nội dung vừa nhập, không còn nội dung mới/chỉnh sửa ở ảnh khác, đóng modal và không lưu, không mở popup. |
| Vùng tối ngoài ảnh | Overlay | N/A | Hiển thị khi mở modal | Click để đóng modal theo cùng điều kiện với nút Hủy. Click trường nhập, thumbnail và các nút điều khiển không được tính là click vùng tối. |

&nbsp;

### 6.3. Popup huỷ mô tả

| UI Element | Control Type | Required? | Default Value | Mô tả |
| :---- | :---- | :---- | :---- | :---- |
| Popup Huỷ mô tả | Confirmation Popup | N/A | Ẩn | Hiển thị giữa màn hình, phía trên Modal Nhập mô tả khi user yêu cầu đóng modal trong lúc còn nội dung mô tả mới/chỉnh sửa chưa lưu. |
| Tiêu đề | Text | N/A | N/A | Hiển thị **Huỷ mô tả**. |
| Nội dung xác nhận | Text | N/A | N/A | Hiển thị: **Nội dung mô tả vừa nhập sẽ không được lưu. Bạn có chắc muốn tiếp tục?** |
| Quay lại | Button | N/A | N/A | Đóng popup, quay về Modal Nhập mô tả và giữ các nội dung đang chỉnh. |
| Huỷ mô tả | Button | N/A | N/A | Đóng popup và Modal Nhập mô tả, không lưu các chỉnh sửa. Giữ mô tả đã lưu trước khi mở modal. |
| Icon Đóng | Icon Button | N/A | N/A | Chỉ đóng popup, giữ Modal Nhập mô tả và các nội dung đang chỉnh. |

&nbsp;

### 6.4. Khu vực soạn tin sau khi lưu mô tả ảnh

| UI Element | Control Type | Required? | Default Value | Mô tả |
| :---- | :---- | :---- | :---- | :---- |
| Mô tả trên thumbnail | Text Overlay | N/A | Ẩn khi chưa có mô tả | Ảnh đã lưu mô tả hiển thị dải nền tối ở cạnh dưới thumbnail, chữ sáng. Hiển thị đầy đủ nếu mô tả có tối đa 8 ký tự. Nếu vượt 8 ký tự, hiển thị 8 ký tự đầu \+ “…”. Chỉ rút gọn phần hiển thị, không cắt nội dung đã lưu. |
| Thumbnail chưa có mô tả | Image | N/A | N/A | Không hiển thị dải mô tả. Nếu user gỡ mô tả rồi Lưu, thumbnail trở về trạng thái này. |
| Icon chỉnh sửa | Icon Button | N/A | Ẩn | Hiển thị khi hover. Click mở Modal Nhập mô tả với nội dung đã lưu để tiếp tục chỉnh sửa. |

&nbsp;

### 6.5. Hiển thị nhiều ảnh sau khi gửi

| UI Element | Control Type | Required? | Default Value | Mô tả |
| :---- | :---- | :---- | :---- | :---- |
| Cụm ảnh | Image Container | N/A | N/A | Hiển thị các ảnh trong cùng một khung theo thiết kế. Bo góc tại biên ngoài của khung, các cạnh tiếp giáp bên trong giữ thẳng. |
| Mô tả từng ảnh | Text Overlay | N/A | Ẩn nếu ảnh không có mô tả | Hiển thị trên dải nền tối ở cạnh dưới của đúng ảnh có mô tả. Ảnh chưa có mô tả không hiển thị dải nền tối rỗng. |
| Tin nhắn trước cụm ảnh | Message | N/A | N/A | Nếu ô soạn có nội dung, nội dung được gửi thành tin nhắn riêng trước cụm ảnh. Nếu đang reply, tin nhắn này có trích dẫn và nội dung trả lời. Giữ khoảng cách giữa tin nhắn và cụm ảnh theo thiết kế. |
| Ảnh trong cụm | Image | N/A | N/A | Click ảnh mở trình xem ảnh theo logic hiện tại. |

&nbsp;

### 6.6. Hiển thị một ảnh sau khi gửi

| UI Element | Control Type | Required? | Default Value | Mô tả |
| :---- | :---- | :---- | :---- | :---- |
| Khung tin ảnh | Message Container | N/A | N/A | Hiển thị ảnh và phần nội dung đi kèm trong cùng khung tin theo thiết kế. |
| Mô tả ảnh | Text | N/A | Ẩn nếu ảnh không có mô tả | Nếu ảnh có mô tả, hiển thị mô tả bên dưới ảnh. Nếu ảnh không có mô tả và không đang reply, nội dung soạn đi cùng ảnh tại vị trí nội dung theo cơ chế hiện tại. Không hiển thị vùng nội dung rỗng. |
| Tin nhắn trước ảnh | Message | N/A | N/A | Khi ảnh có mô tả và ô soạn có nội dung, nội dung soạn được gửi thành tin nhắn riêng trước ảnh. Khi đang reply và ô soạn có nội dung, tin nhắn trả lời luôn hiển thị trước ảnh, kể cả ảnh chưa có mô tả. |
| Ảnh đã gửi | Image | N/A | N/A | Click ảnh mở trình xem ảnh, các thao tác tiếp theo giữ nguyên logic hiện tại. |

&nbsp;

## 7\. Acceptance Criteria

| ID | Scenarios | Given | When | Then |
| :---- | :---- | :---- | :---- | :---- |
| AC-01 | Dán một ảnh trực tiếp | User đang tại ô soạn tin của một hội thoại. | User Ctrl+V một ảnh. | Hệ thống hiển thị thumbnail tại khu vực soạn tin, không mở popup Gửi Media và chưa gửi ảnh. |
| AC-02 | Dán tiếp nhiều ảnh | User đã dán ảnh A và lưu mô tả cho A. | User tiếp tục Ctrl+V ảnh B rồi ảnh C. | Danh sách gồm A, B, C theo thứ tự dán. A giữ mô tả đã lưu, B và C chưa có mô tả. Không thay thế ảnh đã có, chưa gửi ảnh. |
| AC-03 | Giữ nội dung khi chuẩn bị ảnh | Ô soạn có nội dung, mention trong nhóm và đang trả lời một tin nhắn. | User dán ảnh, mở Modal Nhập mô tả rồi Lưu hoặc quay lại ô soạn sau khi hủy chỉnh sửa. | Nội dung, mention và tin đang được trả lời giữ nguyên. Không tự gửi tin và ảnh. |
| AC-04 | Mở mô tả của đúng ảnh | User đã dán nhiều ảnh, mỗi ảnh có trạng thái mô tả khác nhau. | \[1\] User click icon chỉnh sửa của ảnh B.<br><br>\[2\] User click thumbnail B ngoài các icon. | Cả hai cách đều mở Modal Nhập mô tả tại B. Trường nhập hiển thị mô tả đã lưu của B nếu có, chưa có thì để trống. |
| AC-05 | Lưu mô tả mới | Ảnh A chưa có mô tả, user đang mở Modal Nhập mô tả của A. | User nhập mô tả rồi click Lưu. | Lưu mô tả vào A, đóng modal và hiển thị mô tả trên thumbnail A. Không thay đổi ảnh khác, không gửi ảnh. |
| AC-06 | Trạng thái nút Lưu khi nhập mô tả | User mở Modal Nhập mô tả của ảnh chưa có mô tả, không có thay đổi ở ảnh khác. | \[1\] User chưa nhập mô tả.<br><br>\[2\] User nhập nội dung mô tả. | \[1\] Nút Lưu disable.<br><br>\[2\] Sau khi nhập nội dung, nút Lưu enable để user lưu mô tả. |
| AC-07 | Truncate mô tả trên thumbnail | User lưu mô tả cho hai ảnh: A có 8 ký tự, B có 9 ký tự. | User click Lưu và xem các thumbnail. | A hiển thị đủ 8 ký tự. B hiển thị 8 ký tự đầu \+ “…” trên thumbnail. Mở lại modal vẫn hiển thị đủ 9 ký tự của B, khi gửi sử dụng mô tả đầy đủ. |
| AC-08 | Chuyển ảnh và lưu nhiều mô tả | Modal Nhập mô tả có các ảnh A, B, C. | User chỉnh mô tả A, chuyển sang B để chỉnh, quay lại A kiểm tra rồi click Lưu. | Khi quay lại A vẫn hiển thị nội dung vừa chỉnh. Lưu giữ đúng thay đổi của A và B, C không thay đổi. Đóng modal, chưa gửi ảnh. |
| AC-09 | Giới hạn mô tả tối đa ~~1.580~~  2000 **bytes** | User đang nhập mô tả cho một ảnh tại Modal Nhập mô tả. | \[1\] User nhập đủ ~~1.580~~ 2000 **bytes**rồi click Lưu.<br><br>\[2\] Khi trường đã đủ ~~1.580~~ 2000 **bytes**, user tiếp tục gõ.<br><br>\[3\] User dán nội dung dài hơn số ký tự còn được nhập. | \[1\] Lưu đầy đủ mô tả ~~1.580~~ 2000 **bytes** vào đúng ảnh.<br><br>\[2\] Không thêm ký tự mới, giữ nội dung đã nhập.<br><br>\[3\] Chỉ nhận phần nội dung trong giới hạn còn lại, không để trường vượt ~~1.580~~ 2000 **bytes**. Các thao tác không thay đổi mô tả của ảnh khác. |
| AC-10 | Yêu cầu hủy khi còn nội dung mô tả chưa lưu | User đã nhập/sửa mô tả của một hoặc nhiều ảnh. Ít nhất một ảnh còn nội dung không trống, khác mô tả đã lưu trước đó. | \[1\] User click Hủy.<br><br>\[2\] User click vùng tối ngoài ảnh.<br><br>\[3\] User thực hiện đóng modal hoặc nhấn Esc. | Mỗi cách đều mở popup Huỷ mô tả. Modal Nhập mô tả vẫn mở phía sau, các nội dung vừa chỉnh chưa bị bỏ. |
| AC-11 | Xác nhận bỏ mô tả chưa lưu | User đã chỉnh mô tả A và B chưa lưu, popup Huỷ mô tả đang mở. | User click Huỷ mô tả tại popup. | Bỏ toàn bộ thay đổi chưa lưu của A và B, đóng cả popup và Modal Nhập mô tả. Giữ mô tả đã lưu trước đó, các ảnh và nội dung ô soạn. Không gửi ảnh. |
| AC-12 | Quay lại tiếp tục chỉnh sửa | Popup Huỷ mô tả đang mở, có nhiều ảnh đã chỉnh mô tả chưa lưu. | \[1\] User click Quay lại.<br><br>\[2\] User click icon Đóng của popup.<br><br>\[3\] User nhấn Esc. | Mỗi cách đều chỉ đóng popup, giữ Modal Nhập mô tả và toàn bộ nội dung đang chỉnh của từng ảnh. Không bỏ mô tả chưa lưu. |
| AC-13 | Đóng modal khi chưa nhập mô tả | User mở Modal Nhập mô tả của ảnh chưa có mô tả. Chưa nhập nội dung và không có thay đổi ở ảnh khác. | User click Hủy, click vùng tối ngoài ảnh, thực hiện đóng modal hoặc nhấn Esc. | Đóng modal, không hiển thị popup Huỷ mô tả. Giữ các ảnh và nội dung soạn tin. |
| AC-14 | Nhập mới rồi xóa hết mô tả | User mở ảnh chưa có mô tả, nhập nội dung rồi xóa hết. Không có nội dung mới/chỉnh sửa ở ảnh khác. | \[1\] User kiểm tra nút Lưu.<br><br>\[2\] User click Hủy hoặc vùng tối ngoài ảnh. | \[1\] Nút Lưu disable.<br><br>\[2\] Đóng modal ngay, không hiển thị popup Huỷ mô tả. Không lưu mô tả, giữ ảnh đính kèm. |
| AC-15 | Ảnh đang chọn trống nhưng ảnh khác còn mô tả vừa nhập | Trong cùng lần mở modal, user đã nhập mô tả mới chưa lưu cho A, chuyển sang B chưa có mô tả và để trường của B trống. | User click Hủy hoặc vùng tối ngoài ảnh. | Vẫn hiển thị popup Huỷ mô tả vì A còn nội dung vừa nhập. Nút Lưu vẫn cho phép lưu mô tả của A. Không bỏ nội dung của A chỉ vì B đang trống. |
| AC-16 | Gỡ mô tả đã lưu | A có mô tả đã lưu từ trước. User mở modal và xóa hết nội dung mô tả A, không nhập mô tả mới ở ảnh khác. | \[1\] User click Lưu.<br><br>\[2\] Trong lần thử khác, user click Hủy hoặc vùng tối ngoài ảnh. | \[1\] Cho phép Lưu để gỡ mô tả khỏi A, thumbnail không còn dải mô tả.<br><br>\[2\] Đóng modal, không hiển thị popup Huỷ mô tả. Không áp dụng thao tác gỡ, giữ mô tả đã lưu của A. |
| AC-17 | Mô tả chỉ chứa khoảng trắng | Ảnh chưa có mô tả, modal không có thay đổi nào khác cần lưu. | User nhập khoảng trắng/xuống dòng rồi click Hủy hoặc vùng tối ngoài ảnh. | Trường được xem là trống, nút Lưu disable. Đóng modal, không hiển thị popup Huỷ mô tả, không tạo mô tả rỗng. |
| AC-18 | Enter và ký tự @ trong mô tả | User đang nhập nội dung tại Modal Nhập mô tả. | \[1\] User nhấn Enter.<br><br>\[2\] User nhập `@Lan`. | \[1\] Xuống dòng trong trường mô tả, không gửi tin.<br><br>\[2\] Hiển thị văn bản đã nhập, không mở danh sách thành viên và không tạo mention. |
| AC-19 | Xóa từng ảnh | Danh sách có A, B, C với mô tả riêng, ô soạn có nội dung. | User click icon Xóa của B. | Xóa B và mô tả B khỏi danh sách. A, C giữ đúng mô tả và thứ tự, số lượng còn 2 ảnh. Giữ nội dung soạn, không mở modal. |
| AC-20 | Kéo thumbnail không thay đổi thứ tự ảnh | User đã dán các ảnh A, B, C theo thứ tự, mỗi ảnh có mô tả riêng tại dải thumbnail trong khu vực soạn tin. | User kéo thumbnail C đến trước A rồi thả chuột. | Không thay đổi thứ tự ảnh. Dải thumbnail vẫn là A, B, C, mô tả giữ đúng từng ảnh. Khi user Gửi, sử dụng thứ tự A, B, C. |
| AC-21 | Xóa tất cả ảnh | Danh sách có nhiều ảnh và mô tả, ô soạn có nội dung/mention và đang trả lời tin nhắn. | User click Xóa tất cả. | Xóa toàn bộ ảnh và mô tả, ẩn khu vực ảnh đính kèm. Giữ nội dung, mention và trạng thái trả lời tin nhắn. |
| AC-22 | Xóa ảnh cuối cùng | Ô soạn trống, chỉ còn một ảnh đính kèm. | User xóa ảnh đó. | Không còn ảnh và mô tả, ẩn khu vực ảnh đính kèm. Không cho gửi tin rỗng theo điều kiện hiện tại. |
| AC-23 | Bản nháp thuộc đúng hội thoại | Hội thoại A có nội dung, ảnh đính kèm và mô tả đã lưu chưa gửi. | User chuyển sang B rồi quay lại A trong cùng phiên sử dụng. | B không nhận bản nháp của A. Quay lại A hiển thị đúng nội dung, ảnh và mô tả chưa gửi của A. |
| AC-24 | Dán văn bản | User đang ở ô soạn tin. | User Ctrl+V văn bản. | Xử lý văn bản theo logic hiện tại, không mở popup Gửi Media và không tự thêm ảnh. |
| AC-25 | ~~Gửi ảnh có tổng dung lượng nhỏ hơn 25 MB~~<br>Gửi tối đa 25 ảnh | ~~User đã dán nhiều ảnh, mỗi ảnh đáp ứng điều kiện hiện tại, tổng dung lượng là 24,9 MB. User có quyền và đáp ứng các điều kiện gửi khác.~~<br>User đã dán đúng 25 ảnh vào danh sách đính kèm, có quyền và đáp ứng các điều kiện gửi khác. | User click Gửi. | ~~Cho phép gửi. Nội dung soạn, ảnh và mô tả được gửi đúng quy tắc tương ứng.~~<br>Cho phép gửi 25 ảnh. Nội dung soạn, ảnh và mô tả được gửi đúng quy tắc tương ứng. |
| AC-26 | ~~Cộng dung lượng qua nhiều lần dán~~<br>Cộng số lượng ảnh qua nhiều lần dán | ~~User dán ảnh qua nhiều lần Ctrl+V. Mỗi lần dán dưới 25 MB nhưng tổng các ảnh trong danh sách bằng hoặc lớn hơn 25 MB.~~<br>User dán ảnh qua nhiều lần Ctrl+V, tổng số ảnh trong danh sách đã là 25\. Mỗi lần dán trước đó đều dưới 25 ảnh. | ~~User thực hiện Gửi.~~<br>User tiếp tục Ctrl+V thêm một ảnh. | ~~Chặn cả lần gửi và hiển thị **Tổng kích thước ảnh tải lên phải nhỏ hơn 25 M**. Kiểm tra theo tổng ảnh trong danh sách, không tính tách từng lần dán.~~<br>Không thêm ảnh thứ 26\. Hiển thị giữa màn hình: **Bạn chỉ nên gửi tối đa 25 ảnh/ lần**. Giữ danh sách 25 ảnh, mô tả và nội dung soạn. Giới hạn tính theo tổng số ảnh trong danh sách, không theo từng lần dán. |
| AC-27 | ~~Chặn gửi khi tổng dung lượng đạt hoặc vượt 25 MB~~<br>Chặn thêm ảnh khi đã đạt 25 ảnh | ~~User có nội dung soạn và các ảnh hợp lệ theo dung lượng từng ảnh.~~<br>\~\~\~\~<br>~~\[1\] Tổng dung lượng các ảnh bằng 25 MB.~~<br>\~\~\~\~<br>~~\[2\] Tổng dung lượng các ảnh lớn hơn 25 MB.~~<br>User có 25 ảnh đính kèm cùng mô tả tương ứng và nội dung tại ô soạn tin. | ~~User click Gửi trong từng trường hợp.~~<br>User dán thêm ảnh thứ 26\. | ~~Cả hai trường hợp đều chặn toàn bộ lần gửi và hiển thị giữa màn hình: **Tổng kích thước ảnh tải lên phải nhỏ hơn 25 M**. Không gửi nội dung hoặc một phần ảnh. Giữ ảnh, mô tả và nội dung để user xóa bớt.~~<br>Chặn thêm ảnh và hiển thị giữa màn hình: **Bạn chỉ nên gửi tối đa 25 ảnh/ lần**. Danh sách vẫn có 25 ảnh, giữ đúng mô tả và nội dung soạn. Không tự gửi ảnh hoặc nội dung. |
| AC-28 | ~~Xóa bớt ảnh để gửi lại~~<br>Xóa bớt ảnh để thêm ảnh khác | ~~Lần gửi bị chặn do tổng dung lượng ảnh bằng hoặc lớn hơn 25 MB, bản nháp còn nguyên.~~<br>Danh sách có 25 ảnh. User đã bị chặn khi dán thêm ảnh. | ~~User xóa bớt ảnh để tổng còn dưới 25 MB, rồi Gửi khi các điều kiện khác hợp lệ.~~<br>User xóa một ảnh, dán một ảnh khác rồi click Gửi khi các điều kiện gửi khác đáp ứng. | ~~Tính lại dung lượng trên danh sách còn lại và cho phép gửi. Giữ đúng mô tả của ảnh còn lại, nội dung soạn không bị mất hoặc gửi trùng.~~<br>Sau khi xóa, danh sách còn 24 ảnh. Cho phép thêm một ảnh để danh sách trở về 25 ảnh và gửi. Giữ đúng mô tả của từng ảnh còn lại, không mất hoặc gửi trùng nội dung soạn. |
| AC-29 | Lỗi định dạng hoặc dung lượng từng ảnh | User đã có nội dung và ảnh hợp lệ trong bản nháp. | User dán ảnh không đáp ứng định dạng hoặc dung lượng từng ảnh theo giới hạn hiện tại. | Kiểm tra và xử lý lỗi theo cơ chế hiện tại. Không gửi ảnh không hợp lệ, không làm mất phần bản nháp hợp lệ trước đó. |
| AC-30 | Gửi một ảnh không có mô tả, ô soạn trống | User đã dán một ảnh, chưa thêm mô tả, ô soạn trống và không đang trả lời tin nhắn. | User click Gửi. | Chỉ gửi ảnh, không tạo tin nhắn văn bản rỗng. |
| AC-31 | Gửi một ảnh không có mô tả kèm nội dung | User đã dán một ảnh, chưa thêm mô tả, đã nhập nội dung tại ô soạn và không đang trả lời tin nhắn. | User click Gửi. | Gửi ảnh kèm nội dung đã soạn trong cùng một tin nhắn. Không tạo thêm tin nhắn văn bản riêng. Nếu có mention trong nhóm, giữ đúng thành viên và chức năng mention. |
| AC-32 | Gửi một ảnh có mô tả, ô soạn trống | User đã dán một ảnh, lưu mô tả của ảnh, ô soạn trống và không đang trả lời tin nhắn. | User click Gửi. | Gửi ảnh kèm mô tả đã lưu bên dưới ảnh, trong cùng khung tin. Không tạo tin nhắn văn bản riêng. |
| AC-33 | Gửi một ảnh có mô tả kèm nội dung | User đã dán một ảnh, lưu mô tả, nhập nội dung tại ô soạn và không đang trả lời tin nhắn. | User click Gửi. | Gửi nội dung đã soạn thành tin nhắn riêng trước ảnh. Ảnh hiển thị kèm mô tả đã lưu, không thay mô tả bằng nội dung soạn. |
| AC-34 | Gửi nhiều ảnh chưa có mô tả | User đã dán nhiều ảnh, chưa ảnh nào có mô tả và không đang trả lời tin nhắn. | \[1\] User để ô soạn trống rồi Gửi.<br><br>\[2\] User nhập nội dung tại ô soạn rồi Gửi. | \[1\] Chỉ gửi cụm ảnh, không có dải mô tả trên các ảnh.<br><br>\[2\] Gửi nội dung thành tin nhắn riêng trước cụm ảnh, không lặp nội dung trên từng ảnh. |
| AC-35 | Gửi nhiều ảnh, chỉ một số có mô tả | User có A và C đã lưu mô tả, B chưa có mô tả, không đang trả lời tin nhắn. | \[1\] User để ô soạn trống rồi Gửi.<br><br>\[2\] User nhập nội dung tại ô soạn rồi Gửi. | \[1\] Gửi cụm ảnh với đúng mô tả A và C, B không có dải mô tả.<br><br>\[2\] Gửi thêm nội dung soạn thành tin nhắn riêng trước cụm ảnh. Không lấy nội dung soạn gán vào ảnh B. |
| AC-36 | Gửi nhiều ảnh đều có mô tả | User đã dán nhiều ảnh, lưu mô tả riêng cho từng ảnh và không đang trả lời tin nhắn. | \[1\] User để ô soạn trống rồi Gửi.<br><br>\[2\] User nhập nội dung tại ô soạn rồi Gửi. | \[1\] Gửi cụm ảnh, từng ảnh hiển thị đúng mô tả đã lưu.<br><br>\[2\] Gửi nội dung thành tin nhắn riêng trước cụm ảnh, từng ảnh vẫn giữ đúng mô tả. |
| AC-37 | Mention khi gửi nhiều ảnh | User đang trong nhóm, có nhiều ảnh với mô tả tùy chọn, ô soạn có mention đã chọn, không đang trả lời tin nhắn. | User click Gửi. | Gửi nội dung có mention một lần trước cụm ảnh, giữ đúng thành viên được nhắc. Không nhân bản mention theo số ảnh. |
| AC-38 | Reply có nội dung và ảnh | User đang trả lời tin nhắn trong hội thoại cá nhân/nhóm, đã nhập nội dung tại ô soạn, đính kèm một hoặc nhiều ảnh. | User click Gửi. | Gửi tin nhắn trả lời có trích dẫn và nội dung soạn trước ảnh/cụm ảnh. Mô tả đi cùng đúng ảnh. Áp dụng cả khi chỉ có một ảnh không có mô tả, không ghép nội dung trả lời vào ảnh. |
| AC-39 | Reply nhóm chỉ giữ mention tự động | User đang trả lời tin nhắn trong nhóm, ô soạn chỉ còn mention tự động của người gửi tin được trả lời, có ảnh đính kèm. | User click Gửi mà không nhập thêm chữ. | Gửi tin nhắn trả lời gồm trích dẫn và mention trước ảnh/cụm ảnh. Không coi ô soạn là trống. |
| AC-40 | Reply cá nhân chỉ gửi ảnh | User đang trả lời tin nhắn trong hội thoại cá nhân, ô soạn trống, có ảnh đính kèm với mô tả tùy chọn. | User click Gửi. | Chỉ gửi ảnh/cụm ảnh và mô tả tương ứng. Không tạo tin nhắn trả lời rỗng và không gắn trích dẫn vào ảnh. |
| AC-41 | Reply nhóm đã xóa mention và nội dung | User đang trả lời tin nhắn trong nhóm, đã xóa mention và không còn nội dung tại ô soạn, vẫn có ảnh đính kèm. | User click Gửi. | Chỉ gửi ảnh/cụm ảnh và mô tả tương ứng. Không tạo tin nhắn trả lời rỗng, không gắn trích dẫn vào ảnh. |
| AC-42 | Chủ động bỏ trạng thái trả lời | User đang trả lời tin nhắn, có nội dung và ảnh đính kèm. | User đóng vùng trả lời rồi click Gửi. | Không tạo tin nhắn trả lời. Nếu chỉ có một ảnh chưa có mô tả, nội dung đi cùng ảnh. Nếu một ảnh có mô tả hoặc có nhiều ảnh, nội dung được gửi thành tin nhắn riêng trước ảnh/cụm ảnh. |
| AC-43 | Gửi lại phần bị lỗi | Một lần gửi có tin nhắn riêng/tin nhắn trả lời và ảnh, trong đó có phần đã thành công và phần lỗi. | User thử lại phần lỗi theo cơ chế hiện tại. | Chỉ thử lại phần lỗi, không gửi trùng phần đã thành công. Giữ đúng ảnh, mô tả và thông tin mention của phần cần thử lại. |
| AC-44 | Xem ảnh sau khi gửi | User đã gửi ảnh từ luồng Ctrl+V. | User click một ảnh đã gửi. | Mở đúng ảnh trong trình xem hiện tại. Các thao tác xem, chuyển, zoom, xoay, tải xuống giữ nguyên logic hiện tại. |
| AC-45 | Phím gửi tại ô soạn tin | ~~User đã đính kèm ảnh, modal đã đóng, tổng dung lượng ảnh nhỏ hơn 25 MB và các điều kiện gửi khác hợp lệ.~~<br>User đã đính kèm ảnh, modal đã đóng, danh sách có tối đa 25 ảnh và các điều kiện gửi khác đáp ứng. | User sử dụng phím gửi theo thiết lập hiện tại. | Thực hiện gửi cả nội dung và ảnh theo đúng quy tắc của trường hợp đang soạn, không chỉ gửi text và bỏ ảnh lại. |
| AC-46 | Chỉ popup Huỷ mô tả nhận tương tác khi đang mở | User đã nhập mô tả chưa lưu. Popup Huỷ mô tả đang mở phía trên Modal Nhập mô tả. | \[1\] User click vùng ảnh, thumbnail hoặc nút Lưu của Modal Nhập mô tả phía sau popup.<br><br>\[2\] User nhấn Esc khi popup đang mở. | \[1\] Không chuyển ảnh, không lưu mô tả và không đóng modal phía sau. Popup Huỷ mô tả tiếp tục hiển thị, nội dung đang chỉnh được giữ nguyên.<br><br>\[2\] Chỉ đóng popup Huỷ mô tả, quay về Modal Nhập mô tả và giữ nội dung chưa lưu. Không đồng thời đóng modal hoặc kích hoạt thao tác gửi tin phía sau. |

&nbsp;

## 8\. Data Migration

Không yêu cầu chuyển đổi dữ liệu lịch sử. Không thay đổi nội dung hoặc mô tả của ảnh đã gửi trước khi triển khai.

## 9\. Change Log

| Version | Date | Nội dung thay đổi | Reason |
| :---- | :---- | :---- | :---- |
| v1.0.1 | 20/10/2026 | Điều chỉnh BR-01, BR-03, BR-16, AC-26, AC-27, AC-28, AC-46: Thay giới hạn tổng dung lượng ảnh bằng tối đa 25 ảnh mỗi lần.&nbsp; | Điều chỉnh logic hệ thống |
| v1.0.2 | 20/10/2026 | Điều chỉnh BR-08, AC-09: Thay đổi giới hạn ký tự mô tả ảnh: Max 2000 bytes | Điều chỉnh logic hệ thống |

&nbsp;