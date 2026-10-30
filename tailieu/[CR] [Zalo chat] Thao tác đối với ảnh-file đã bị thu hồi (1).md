# [CR] [Zalo chat] Thao tác đối với ảnh/file đã bị thu hồi

| Trường | Nội dung |
|---|---|
| Mã yêu cầu | Chưa cấp |
| Module | Zalo chat trên web/app Gopany |
| Ngày nhận | 13/10/2026 |
| Phiên bản tài liệu | 1.0 |
| Người yêu cầu | BA - Đỗ Văn An |
| Ưu tiên | Chưa xác định |
| Đầu ra | Đặc tả Markdown |

## 1 Current Situation

**Ảnh:** khi tin nhắn ảnh bị thu hồi, ảnh trong đoạn chat chuyển sang màu đen trắng và hiển thị dòng **“Tin nhắn đã thu hồi”** ngay dưới ảnh. User không thể click mở viewer hoặc thực hiện các thao tác với ảnh.

**File:** khi tin nhắn file bị thu hồi, file hiển thị trạng thái thu hồi tương tự ảnh và không cho user tải xuống.

![Hiện trạng ảnh bị thu hồi trong đoạn chat](hien-trang-anh-thu-hoi.png)

## 2 Expectation

- Trên web/app Gopany, ảnh bị thu hồi vẫn có thể click để mở viewer và thao tác như ảnh chưa bị thu hồi.
- Ảnh mở trong viewer hiển thị **màu nguồn của ảnh**, không áp dụng hiệu ứng đen trắng của trạng thái thu hồi trong đoạn chat.
- File bị thu hồi vẫn có thể tải xuống.
- Trong đoạn chat, tiếp tục giữ cách hiển thị đen trắng của ảnh và dòng **“Tin nhắn đã thu hồi”** để user nhận biết trạng thái.
- Việc mở/xem/tải không làm tin nhắn trở về trạng thái chưa thu hồi.
- Thay đổi chỉ áp dụng trên web/app Gopany. Không thay đổi cách xử lý hoặc khả năng tương tác của Zalo app/Zalo web.

## 3 Scope

### 3.1 In Scope

- Tin nhắn ảnh và tin nhắn file đã bị thu hồi trong đoạn chat trên web/app Gopany.
- Ảnh/file do tài khoản Zalo đang liên kết gửi đi hoặc do bên đối thoại gửi đến, khi Gopany đã có nội dung và ghi nhận trạng thái thu hồi.
- Mở ảnh thu hồi từ đoạn chat; hiển thị màu nguồn và sử dụng bộ thao tác viewer hiện hành.
- Tải ảnh từ viewer và tải file từ tin nhắn đã thu hồi.
- Ảnh/file thu hồi trước hoặc sau thời điểm phát hành thay đổi, với điều kiện dữ liệu nguồn vẫn còn khả dụng.
- Trường hợp tin nhắn bị thu hồi khi user đang mở viewer hoặc đang tải file.

Trong tài liệu này, **“bị gỡ”** được hiểu là **tin nhắn đã bị thu hồi**. Không dùng thuật ngữ này để chỉ file nguồn bị xóa vật lý hoặc hội thoại bị xóa/ẩn.

### 3.2 Out of Scope

- Khôi phục tin nhắn đã thu hồi trên Zalo hoặc gửi lại nội dung lên Zalo.
- Thay đổi quyền xem tài khoản/hội thoại, phân công nhân sự hoặc quyền tải hiện hành.
- Mở lại các thao tác khác của tin nhắn thu hồi như trả lời, phản ứng, chuyển tiếp hoặc thu hồi lại.
- Thay đổi hành vi video, sticker, tin nhắn văn bản và các loại nội dung khác.
- Khôi phục nội dung Gopany chưa từng lưu hoặc file nguồn không còn tồn tại.
- Thay đổi chính sách xóa dữ liệu, thời hạn lưu trữ hoặc hành vi xóa/ẩn hội thoại.
- Bổ sung chức năng mở/xem trước nội dung file; CR này chỉ mở lại thao tác tải file.

## 4 Change Details

### 4.1 Bảng thay đổi

| ID | Current Behavior | New Behavior | Reason |
|---|---|---|---|
| CR-01 | Ảnh thu hồi hiển thị đen trắng, có nhãn và bị chặn click | Giữ đen trắng và nhãn trong chat; cho click để mở viewer | Xem lại nội dung ảnh còn lưu trên Gopany |
| CR-02 | Không mở được viewer cho ảnh thu hồi | Viewer hiển thị màu nguồn và cho thao tác tương tự ảnh chưa thu hồi | Không áp hiệu ứng thu hồi lên ảnh đang xem |
| CR-03 | File thu hồi bị chặn tải xuống | Cho tải file nếu user có quyền và nguồn còn khả dụng | Tiếp tục sử dụng file còn lưu trên Gopany |
| CR-04 | Trạng thái thu hồi chặn các thao tác ảnh/file | Chỉ bỏ chặn mở viewer và tải; giữ trạng thái thu hồi và các quy tắc khác | Không làm thay đổi ý nghĩa của việc thu hồi |
| CR-05 | Cần đồng nhất khi thu hồi xảy ra lúc đang xem/tải | Không đóng viewer hoặc hủy tác vụ chỉ vì tin nhắn vừa chuyển sang thu hồi | Tránh gián đoạn thao tác hợp lệ |

### 4.2 Điều kiện thực hiện

User được mở/xem/tải ảnh hoặc file thu hồi khi:

1. Đang sử dụng web/app Gopany.
2. Có quyền xem hội thoại và truy cập ảnh/file theo chính sách hiện hành.
3. Nội dung nguồn còn được Gopany lưu hoặc có thể truy xuất hợp lệ.

**Trạng thái thu hồi không còn là lý do độc lập để chặn mở viewer hoặc tải xuống.** Các điều kiện về quyền, dữ liệu và khả năng truy xuất vẫn được kiểm tra.

Có thumbnail hoặc thông tin tên file không đồng nghĩa bản nguồn còn tồn tại. Hệ thống không thay file nguồn bằng thumbnail hoặc file rỗng để tạo cảm giác tải thành công.

### 4.3 Ảnh đã bị thu hồi

#### 4.3.1 Hiển thị trong đoạn chat

- Giữ vị trí ảnh trong lịch sử, thời điểm tin nhắn và cách bố trí hiện hành.
- Ảnh tiếp tục hiển thị đen trắng; giữ dòng **“Tin nhắn đã thu hồi”** bên dưới.
- Vùng ảnh nhận click để mở viewer. Trên thiết bị cảm ứng, user chạm vào ảnh để mở.
- Hiệu ứng đen trắng chỉ thuộc cách hiển thị trạng thái trong chat, không được ghi đè lên dữ liệu ảnh nguồn.
- Không thay đổi trạng thái tin nhắn hoặc xóa nhãn sau khi user mở viewer.

#### 4.3.2 Luồng mở viewer

1. User click/chạm ảnh đã bị thu hồi trong đoạn chat.
2. Hệ thống kiểm tra quyền truy cập và tải nguồn ảnh.
3. Viewer mở trên đúng ảnh được chọn.
4. Khi ảnh tải thành công, hiển thị ảnh theo **màu nguồn**, giữ đúng tỷ lệ và hướng ảnh.
5. User thực hiện các thao tác xem ảnh đang được viewer hỗ trợ.
6. Đóng viewer đưa user trở về đúng đoạn chat, giữ vị trí cuộn và nội dung đang soạn; ảnh trong đoạn chat vẫn đen trắng và có nhãn thu hồi.

“Màu nguồn” là màu của bản ảnh Gopany đang lưu/cung cấp. Nếu ảnh nguồn vốn đen trắng, viewer vẫn hiển thị đen trắng; hệ thống không tự tô màu hoặc phục dựng màu không có trong nguồn.

#### 4.3.3 Thao tác trong viewer

Ảnh đã thu hồi sử dụng cùng bộ thao tác với ảnh chưa thu hồi, không tạo một viewer riêng hoặc một bộ giới hạn riêng do trạng thái thu hồi:

| Thao tác | Hành vi |
|---|---|
| Tải xuống | Tải ảnh nguồn; không áp hiệu ứng đen trắng, góc xoay, zoom hoặc vị trí kéo của phiên xem |
| Xoay | Mỗi click xoay 90° theo chiều kim đồng hồ |
| Phóng to / Thu nhỏ | Click/chạm icon tương ứng; không hiển thị phần trăm zoom |
| Giữ và kéo | Giữ chuột trái và kéo để xem phần ảnh ngoài khung; trên giao diện cảm ứng kế thừa thao tác kéo ảnh của viewer hiện hành |
| Chuyển ảnh / Chọn thumbnail | Ảnh thu hồi vẫn có thể được chọn trong cùng tập ảnh mà viewer đang hiển thị, không bị loại chỉ vì thu hồi |
| Đóng | Dùng nút Đóng; trên môi trường có bàn phím, Esc đóng viewer và giữ user tại đoạn chat |
| Tooltip | Giữ text tiếng Việt của từng icon, không gợi ý phím tắt |

Quy tắc về mức phóng to/thu nhỏ, giới hạn kéo, reset khi chuyển ảnh, toolbar phía dưới và Esc kế thừa [tài liệu thao tác ảnh trong viewer](../CR-thao-tac-anh-chat/[CR]%20Bổ%20sung%20các%20thao%20tác%20đối%20với%20ảnh%20đang%20được%20mở%20ra%20xem%20trong%20đoạn%20chat.md). CR này thay đổi khả năng áp dụng các thao tác đối với ảnh thu hồi, không thay đổi các quy tắc đó.

Không mở rộng tập ảnh sang hội thoại khác hoặc thay đổi thứ tự album. Tại mỗi lần chuyển ảnh, hệ thống lấy đúng trạng thái và nguồn của ảnh đang được chọn; không mang hiệu ứng đen trắng trong chat sang viewer.

### 4.4 File đã bị thu hồi

#### 4.4.1 Hiển thị trong đoạn chat

- Giữ thẻ file, thông tin hiện có và nhãn trạng thái thu hồi.
- Mở lại vùng/nút tải xuống theo cách tương tác với file chưa thu hồi.
- Trạng thái thu hồi không làm vùng tải xuống bị vô hiệu hóa.
- Việc tải không đổi tên, loại, nội dung hoặc trạng thái thu hồi của file trong chat.

#### 4.4.2 Luồng tải file

1. User click/chạm thao tác tải của file đã thu hồi.
2. Hệ thống ghi nhận đúng file tại thời điểm thao tác và kiểm tra quyền truy cập.
3. Nếu nguồn còn khả dụng, bắt đầu tải file bằng cơ chế tải của web/app Gopany.
4. Giữ nguyên đoạn chat, vị trí cuộn và trạng thái tin nhắn.
5. Nếu nguồn không còn hoặc tải lỗi, hiển thị thông báo tương ứng và cho thử lại khi phù hợp.

Quy tắc:

- File tải xuống phải đúng file gắn với tin nhắn user chọn, giữ nội dung và định dạng nguồn.
- Giữ tên file nguồn hợp lệ. Quy tắc tên trùng, chọn vị trí lưu, quyền ghi bộ nhớ và thông báo tải của từng nền tảng dùng cơ chế hiện hành.
- Không hiển thị “Đã lưu thành công” nếu ứng dụng chỉ biết đã chuyển yêu cầu cho trình duyệt hoặc trình quản lý tải.
- Click lặp khi ứng dụng đang chuẩn bị cùng một lượt tải không tạo nhiều yêu cầu đồng thời. Sau khi chuyển giao tác vụ, user có thể chủ động tải lại.
- Chuyển hội thoại hoặc chọn file khác không làm tác vụ tải đã bắt đầu đổi sang tài nguyên khác.
- Không tự gửi lại file lên Zalo, không thay trạng thái tin nhắn thành chưa thu hồi.

### 4.5 Tin nhắn chuyển sang thu hồi trong lúc đang thao tác

| Tình huống | Kết quả |
|---|---|
| User đang xem ảnh màu trong viewer thì nhận sự kiện thu hồi | Viewer vẫn mở, giữ ảnh màu và trạng thái xoay/zoom/kéo; không khóa thao tác chỉ do thu hồi |
| User đang tải ảnh/file thì nhận sự kiện thu hồi | Tác vụ tiếp tục nếu nguồn và quyền vẫn hợp lệ; không hủy chỉ do thu hồi |
| User đang mở ảnh từ chat, ảnh chuyển sang thu hồi trước khi tải xong | Vẫn hoàn tất mở viewer nếu nguồn và quyền hợp lệ; không áp đen trắng vào viewer |
| User đóng viewer sau khi ảnh vừa thu hồi | Trong chat, ảnh hiển thị đen trắng và nhãn thu hồi |
| User đổi ảnh A sang B, kết quả tải A về muộn | Không ghi đè nội dung hoặc màu hiển thị của B bằng kết quả A |
| User mở lại ảnh thu hồi ở phiên khác | Ảnh vẫn mở được nếu còn quyền và nguồn, không phụ thuộc việc đã xem trong phiên trước |

Trạng thái thu hồi là trạng thái của tin nhắn; góc xoay, zoom và vị trí kéo là trạng thái của phiên xem từng user. Không đồng bộ các biến đổi cách xem sang user khác.

### 4.6 Phạm vi nền tảng

| Nền tảng | Ảnh thu hồi | File thu hồi |
|---|---|---|
| Web Gopany | Mở viewer, hiển thị màu nguồn, cho thao tác như ảnh chưa thu hồi | Cho tải khi đủ điều kiện |
| App Gopany | Mở viewer, hiển thị màu nguồn, cho thao tác như ảnh chưa thu hồi của cùng app | Cho tải theo cơ chế của app khi đủ điều kiện |
| Zalo app | Không thuộc thay đổi của CR | Không thuộc thay đổi của CR |
| Zalo web | Không thuộc thay đổi của CR | Không thuộc thay đổi của CR |

Không gửi lệnh khôi phục tin nhắn hoặc thay đổi dữ liệu trên Zalo để phục vụ việc xem/tải tại Gopany. Không yêu cầu người dùng chuyển sang Zalo để mở nội dung đã thu hồi.

### 4.7 Trạng thái và lỗi

| Tình huống | Phản hồi |
|---|---|
| Đang lấy nguồn ảnh | Viewer hiển thị trạng thái đang tải; vẫn có thể đóng hoặc chuyển ảnh theo cơ chế hiện hành |
| Ảnh không còn nguồn | Hiển thị **“Ảnh không còn khả dụng.”** Không báo thiếu quyền chỉ vì thu hồi |
| File không còn nguồn | Hiển thị **“File không còn khả dụng để tải xuống.”** |
| Lỗi tải ảnh tạm thời | Hiển thị **“Không thể tải ảnh. Vui lòng thử lại.”** |
| Lỗi tải file tạm thời | Hiển thị **“Không thể tải file. Vui lòng thử lại.”** |
| Link nguồn hết hạn | Làm mới quyền truy xuất/link bằng cơ chế hiện hành nếu còn quyền; nếu không lấy được nguồn, trả lỗi phù hợp |
| User không còn quyền xem | Chặn mở/tải, hiển thị thông báo quyền theo cơ chế hiện hành; không dùng cache để vượt quyền |
| Tài khoản Zalo ngắt kết nối nhưng Gopany còn dữ liệu | Vẫn xem/tải được nếu nguồn khả dụng và quyền hợp lệ |
| App bị từ chối quyền lưu file | Hướng dẫn cấp quyền hoặc chọn vị trí lưu theo cơ chế hiện hành; không báo lỗi thu hồi |
| Chỉ có thumbnail, chưa có bản nguồn | Không coi thumbnail là bản nguồn để tải; thông báo nguồn không khả dụng |

Nếu nguồn bị xóa vật lý hoặc quyền bị thu hồi trong quá trình thao tác, xử lý theo lỗi tài nguyên/quyền hiện hành. Khả năng xem/tải của CR không vượt qua các điều kiện đó.

### 4.8 Yêu cầu dữ liệu và tác động

- Cách hiển thị đen trắng phải được tách khỏi dữ liệu ảnh nguồn để viewer và file tải còn giữ màu nguồn.
- Việc nhận trạng thái thu hồi không được tự xóa bản ảnh/file đã lưu chỉ nhằm vô hiệu hóa mở/tải. Các chính sách lưu trữ và xóa dữ liệu hiện hành vẫn áp dụng độc lập.
- Kiểm tra việc chặn thao tác trên cả giao diện và xử lý tải nguồn: không chỉ bật nút ở UI trong khi phía xử lý vẫn từ chối vì cờ thu hồi.
- Giữ nguyên định danh tin nhắn, ảnh/file, trạng thái thu hồi và nhãn trong lịch sử.
- Áp dụng đồng nhất trên web/app Gopany; kiểm thử cả tin gửi và tin nhận, thu hồi trước và sau phát hành.
- Không tự bật các thao tác khác của tin nhắn thu hồi khi mở lại quyền click ảnh hoặc tải file.

## 5 Acceptance Criteria

Các tiêu chí dưới đây dùng để kiểm tra tính năng trên web/app Gopany. Với các trường hợp xem hoặc tải thành công, người dùng phải có quyền truy cập và ảnh/file gốc vẫn còn để mở hoặc tải.

| Mã | Tình huống và thao tác | Kết quả cần đạt |
|---|---|---|
| AC-01 | Người dùng xem ảnh đã thu hồi trong đoạn chat. | Ảnh vẫn hiển thị đen trắng, có dòng “Tin nhắn đã thu hồi” bên dưới và có thể bấm vào để xem. |
| AC-02 | Trên web Gopany, người dùng bấm vào ảnh đã thu hồi. | Màn hình xem ảnh mở ra đúng ảnh vừa chọn. |
| AC-03 | Trên app Gopany, người dùng chạm hoặc bấm vào ảnh đã thu hồi. | Màn hình xem ảnh mở ra và cho phép thao tác như với ảnh chưa thu hồi. |
| AC-04 | Người dùng mở một ảnh có màu nhưng đang hiển thị đen trắng trong đoạn chat do bị thu hồi. | Ảnh trên màn hình xem ảnh hiển thị lại màu gốc. |
| AC-05 | Người dùng mở một ảnh vốn đã có màu đen trắng từ trước khi thu hồi. | Ảnh vẫn giữ màu đen trắng ban đầu. |
| AC-06 | Khi đang xem ảnh đã thu hồi, người dùng bấm nút Xoay ảnh một lần. | Ảnh xoay 90° theo chiều kim đồng hồ. Mỗi lần bấm tiếp theo xoay thêm 90°. |
| AC-07 | Khi đang xem ảnh đã thu hồi, người dùng bấm Phóng to hoặc Thu nhỏ. | Ảnh được phóng to hoặc thu nhỏ như ảnh chưa thu hồi. Không hiển thị phần trăm phóng to trên màn hình. |
| AC-08 | Ảnh đã thu hồi được phóng to, có phần nằm ngoài khung xem. Người dùng giữ chuột trái và kéo ảnh; trên thiết bị cảm ứng, giữ và kéo bằng ngón tay. | Ảnh di chuyển theo hướng kéo để người dùng xem phần bị khuất. Khi thả tay, ảnh dừng di chuyển. Giới hạn kéo giống ảnh chưa thu hồi. |
| AC-09 | Người dùng đã xoay hoặc phóng to ảnh thu hồi, sau đó bấm Tải xuống. | Tải về đúng ảnh gốc, giữ màu và hướng ban đầu. Các thao tác xoay, phóng to hoặc kéo khi xem không làm thay đổi ảnh tải về. |
| AC-10 | Trong danh sách ảnh đang xem có ảnh đã thu hồi. Người dùng chuyển đến ảnh đó bằng nút chuyển ảnh hoặc chọn ảnh nhỏ bên dưới. | Vẫn chọn và xem được ảnh đã thu hồi với màu gốc. Ảnh không bị bỏ khỏi danh sách chỉ vì đã thu hồi. |
| AC-11 | Khi đang xem ảnh đã thu hồi, người dùng bấm Đóng. | Trở về đúng đoạn chat, giữ vị trí đang đọc và nội dung đang soạn. Ảnh trong chat vẫn đen trắng và có dòng “Tin nhắn đã thu hồi”. |
| AC-12 | Khi đang xem ảnh đã thu hồi trên thiết bị có bàn phím, người dùng nhấn Esc. | Đóng màn hình xem ảnh và giữ người dùng ở đoạn chat hiện tại. |
| AC-13 | Người dùng đưa con trỏ chuột lên một biểu tượng thao tác trong màn hình xem ảnh. | Hiển thị tên thao tác bằng tiếng Việt, không kèm gợi ý phím tắt. |
| AC-14 | Trên web Gopany, người dùng bấm tải một file đã thu hồi. | File được tải xuống. Người dùng vẫn ở đoạn chat hiện tại và tin nhắn vẫn hiển thị đã thu hồi. |
| AC-15 | Trên app Gopany, người dùng bấm tải một file đã thu hồi. | App cho phép tải và lưu đúng file đã chọn, giống cách tải file chưa thu hồi. |
| AC-16 | Người dùng tải thành công một file đã thu hồi. | File tải về giữ đúng nội dung và loại file ban đầu. Tên file được giữ như khi tải file chưa thu hồi; nếu trùng tên thì xử lý theo cách hiện có. |
| AC-17 | Người dùng bấm tải liên tục nhiều lần trong lúc ứng dụng đang chuẩn bị tải cùng một file. | Không bắt đầu nhiều lượt tải chỉ vì các lần bấm liên tiếp này. Sau đó, người dùng vẫn có thể chủ động tải lại file. |
| AC-18 | Người dùng đang xem ảnh thì tin nhắn chứa ảnh đó bị thu hồi. | Màn hình xem ảnh vẫn mở; giữ nguyên màu, góc xoay, độ phóng to và vị trí ảnh đang xem. Trong chat, ảnh chuyển sang trạng thái đã thu hồi. |
| AC-19 | Người dùng đang tải ảnh hoặc file thì tin nhắn bị thu hồi. | Việc tải vẫn tiếp tục nếu ảnh/file còn và người dùng vẫn có quyền truy cập. Không dừng tải chỉ vì tin nhắn vừa bị thu hồi. |
| AC-20 | Người dùng vừa bấm mở ảnh, ảnh chưa hiện xong thì tin nhắn bị thu hồi. | Ảnh vẫn được mở với màu gốc nếu ảnh còn và người dùng vẫn có quyền truy cập. |
| AC-21 | Người dùng mở ảnh hoặc tải file đã bị thu hồi từ trước khi tính năng này được đưa vào sử dụng. | Vẫn xem hoặc tải được nếu ảnh/file gốc còn. Không cần gửi lại tin nhắn. |
| AC-22 | Người dùng mở ảnh đã thu hồi nhưng ảnh gốc không còn, dù trong chat vẫn có thể còn ảnh nhỏ. | Hiển thị “Ảnh không còn khả dụng.” Không dùng ảnh nhỏ để thay cho ảnh gốc. |
| AC-23 | Trong chat vẫn còn tên file đã thu hồi, nhưng file gốc không còn. Người dùng bấm tải. | Hiển thị “File không còn khả dụng để tải xuống.” Không tải về một file rỗng. |
| AC-24 | Người dùng mở ảnh hoặc tải file nhưng gặp lỗi mạng hoặc lỗi tải tạm thời. | Hiển thị “Không thể tải ảnh. Vui lòng thử lại.” hoặc “Không thể tải file. Vui lòng thử lại.” Người dùng có thể thử lại; tin nhắn vẫn giữ trạng thái đã thu hồi. |
| AC-25 | Người dùng không còn quyền truy cập hội thoại hoặc ảnh/file, sau đó thử mở hoặc tải. | Không cho phép mở hoặc tải và hiển thị thông báo về quyền truy cập, kể cả khi người dùng đã từng xem nội dung đó. |
| AC-26 | Tài khoản Zalo bị ngắt kết nối, nhưng Gopany vẫn còn ảnh/file và người dùng vẫn có quyền truy cập. Người dùng mở hoặc tải nội dung đã thu hồi. | Vẫn xem ảnh hoặc tải file được trên Gopany. |
| AC-27 | Người dùng đang chờ ảnh A mở ra thì chuyển sang ảnh B. Sau đó ảnh A mới tải xong. | Màn hình tiếp tục hiển thị ảnh B đã chọn, không tự chuyển lại ảnh A. |
| AC-28 | Người dùng xem hoặc tải ảnh/file đã thu hồi trên Gopany, sau đó kiểm tra tin nhắn trên Zalo app/Zalo web. | Tin nhắn trên Zalo vẫn giữ trạng thái đã thu hồi. Gopany không khôi phục hoặc gửi lại tin nhắn lên Zalo. |
| AC-29 | Người dùng mở danh sách thao tác của một tin nhắn đã thu hồi. | Chỉ bổ sung khả năng xem ảnh và tải ảnh/file trong phạm vi tính năng này. Các thao tác trả lời, phản ứng và chuyển tiếp không được mở lại. |
| AC-30 | Người dùng đã xem ảnh hoặc tải file, sau đó quay về chat hoặc mở lại lịch sử tin nhắn. | Tin nhắn vẫn hiển thị đã thu hồi; việc xem hoặc tải không xóa trạng thái này. |
| AC-31 | Người dùng mở hoặc tải ảnh/file đã thu hồi, lần lượt với tin mình gửi và tin nhận từ người khác. | Cả hai trường hợp đều xem hoặc tải được nếu còn ảnh/file gốc và có quyền truy cập. |
| AC-32 | Người dùng tải file đã thu hồi trên app nhưng app chưa được cấp quyền lưu file. | App hướng dẫn cấp quyền hoặc chọn nơi lưu như khi tải file chưa thu hồi. Không báo rằng không tải được vì tin nhắn đã thu hồi. |

Kiểm tra các trường hợp phù hợp trên cả web và các app Gopany được hỗ trợ. Dùng thêm ảnh màu, ảnh đen trắng, ảnh dọc/ngang, nhiều ảnh trong cùng tin nhắn và file có tên tiếng Việt hoặc ký tự đặc biệt. Kiểm tra cả khi mất mạng, Zalo ngắt kết nối, chuyển ảnh liên tục và người dùng bị thay đổi quyền trong lúc thao tác.

## 6 Data Migration (Optional)

Không đổi trạng thái các tin nhắn đã thu hồi và không biến chúng thành tin chưa thu hồi. Dữ liệu cũ còn nguồn được áp dụng hành vi mới.

Trước triển khai, kiểm tra khả năng truy xuất bản nguồn của ảnh/file đã thu hồi, đặc biệt trường hợp hiện chỉ còn thumbnail hoặc metadata. Không cam kết phục hồi màu/nội dung nếu bản nguồn đã bị thay đổi hoặc xóa. Trường hợp thiếu nguồn được xử lý bằng các thông báo ở phần 4.7.

Không thực hiện đồng bộ lại, tải lại hàng loạt hoặc thay đổi chính sách lưu trữ trong phạm vi CR này.

## 7 Change Log

| Version | Date | Description / Change | Reason |
|---|---|---|---|

