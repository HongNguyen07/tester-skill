# [CR] Bổ sung các thao tác đối với ảnh đang được mở ra xem trong đoạn chat

| Trường | Nội dung |
|---|---|
| Mã yêu cầu | Chưa cấp |
| Module | Chat Zalo tích hợp CRM/ERP — trình xem ảnh |
| Ngày nhận | 13/10/2026 |
| Phiên bản tài liệu | 1.1 |
| Người yêu cầu | BA - Đỗ Văn An |
| Ưu tiên | Cao |
| Đầu ra | Đặc tả Markdown và 3 wireframe SVG/PNG |

## 1 Current Situation

Trình xem ảnh trong đoạn chat đã có ảnh ở giữa trên nền tối, nút chuyển ảnh trước/sau, nút đóng và dải thumbnail. Cần bổ sung các thao tác tải xuống, xoay, phóng to, thu nhỏ và nhấn giữ chuột để kéo ảnh đến vùng cần xem. Theo yêu cầu bổ sung ngày 13/10/2026, cần có icon Chuyển tiếp ngay trong viewer để mở modal chọn người/nhóm dùng chung với thao tác Chuyển tiếp trên tin nhắn.

## 2 Expectation

- User click icon **Chuyển tiếp** trong viewer để mở modal chọn người/nhóm như khi chuyển tiếp tin nhắn; chuyển tiếp đúng ảnh đang xem.
- User tải được đúng ảnh đang mở mà không phải đóng trình xem ảnh.
- Mỗi lần click Xoay, ảnh xoay 90° theo chiều kim đồng hồ.
- User click icon Phóng to hoặc Thu nhỏ để thay đổi kích thước hiển thị, nhấn giữ chuột trái trên ảnh và kéo để xem phần ảnh ngoài khung.
- Tooltip chỉ hiển thị nội dung tiếng Việt mô tả thao tác; không gợi ý phím tắt.
- Nhấn Esc đóng viewer và giữ user ở đúng đoạn chat, không đóng hội thoại hoặc mất nội dung đang soạn.
- Các thao tác xem ảnh không sửa file nguồn và không ảnh hưởng cách xem của user khác.

## 3 Scope

### 3.1 In Scope

Áp dụng cho trình xem ảnh mở từ tin nhắn ảnh trong đoạn chat trên desktop web:

- Tải xuống một ảnh đang được chọn.
- Chuyển tiếp ảnh đang xem qua modal chọn người/nhóm dùng chung với thao tác Chuyển tiếp trên tin nhắn.
- Xoay theo chiều kim đồng hồ, 90° mỗi lần click.
- Phóng to/thu nhỏ bằng click chuột vào icon.
- Nhấn giữ chuột trái trên ảnh và kéo để dịch chuyển vùng ảnh đang xem.
- Tooltip tiếng Việt cho các icon.
- Thanh công cụ ở dưới vùng ảnh; giữ chuyển ảnh, thumbnail, nút đóng và Esc.

### 3.2 Out of Scope

Không bổ sung phím tắt thao tác ảnh ngoài Esc đóng viewer. Không có nút vừa khung, bảng hướng dẫn phím tắt hoặc nhãn phần trăm zoom. Không bổ sung chọn nhiều ảnh để chuyển tiếp từ viewer; thao tác tại viewer chỉ áp dụng cho ảnh đang xem.

Không zoom bằng cuộn chuột, nhấp đúp hoặc thao tác đa điểm trong phạm vi này. Không sửa/lưu ảnh đã xoay, crop, vẽ lên ảnh, tải nhiều ảnh/ZIP, in ảnh hoặc mở rộng sang video/PDF. Các quyền truy cập và chính sách xử lý ảnh hiện hành tiếp tục được áp dụng.

## 4 Change Details

### 4.1 Bảng thay đổi

| ID | Current Behavior | New Behavior | Reason |
|---|---|---|---|
| CR-01 | Chưa có thao tác tải xuống trong viewer mẫu | Bổ sung icon Tải xuống, tải đúng ảnh nguồn đang được chọn | Lưu ảnh thuận tiện |
| CR-02 | Chưa có thao tác xoay trong viewer mẫu | Mỗi click xoay ảnh 90° theo chiều kim đồng hồ | Đọc ảnh đúng hướng |
| CR-03 | Chưa có bộ thao tác thay đổi kích thước và dịch chuyển ảnh trong viewer mẫu | Click icon để phóng to/thu nhỏ; nhấn giữ chuột trái và kéo ảnh | Xem chi tiết tại vị trí mong muốn |
| CR-04 | Cần xác định hành vi đóng bằng bàn phím | Nhấn Esc chỉ đóng viewer, giữ user tại đoạn chat | Trở lại hội thoại mà không mất ngữ cảnh |
| CR-05 | Chưa có tooltip cho các icon bổ sung | Tooltip chỉ có text tiếng Việt mô tả thao tác hoặc lý do bị khóa | Giúp user hiểu icon |
| CR-06 | Đã có chuyển ảnh, đóng và thumbnail | Bố trí thanh công cụ dưới ảnh, bỏ phần trăm zoom, nút vừa khung và hướng dẫn phím tắt | Giao diện gọn, nhất quán mẫu đã chốt |
| CR-07 | Bản 1.0 loại chuyển tiếp khỏi phạm vi và chưa có icon trong viewer | Bổ sung icon Chuyển tiếp; click mở modal chọn người/nhóm dùng chung với chuyển tiếp tin nhắn, áp dụng cho ảnh đang xem | Chuyển tiếp ngay trong viewer theo yêu cầu bổ sung ngày 13/10/2026 |

### 4.2 Tải xuống

**Điều kiện:** ảnh hiện hành đã tải thành công, tài nguyên nguồn còn khả dụng và user có quyền theo chính sách hiện có.

1. User click icon **Tải xuống**.
2. Hệ thống ghi nhận ảnh được chọn tại thời điểm click, chuẩn bị file tải; icon chuyển trạng thái đang xử lý và không nhận click lặp cho cùng tác vụ.
3. Chuyển file sang cơ chế tải của trình duyệt; viewer vẫn mở, giữ ảnh và vị trí đang xem.
4. Khi chuyển giao xong, icon trở lại trạng thái có thể thao tác. Thông báo: **“Đã bắt đầu tải ảnh. Kiểm tra mục tải xuống của trình duyệt.”**

Quy tắc:

- Tải bản nguồn chất lượng cao nhất hệ thống đang lưu/cung cấp, không thay bằng thumbnail hoặc ảnh chụp màn hình.
- File tải không áp dụng góc xoay, kích thước zoom hoặc vị trí kéo của viewer.
- Giữ tên file nguồn hợp lệ; nếu thiếu tên, dùng `anh-chat-{imageId}.{đuôi-thực-tế}`. Đuôi file khớp định dạng thực tế; trình duyệt/OS xử lý tên trùng.
- Không có file nguồn: hiển thị **“Không còn tệp ảnh để tải xuống.”**
- Lỗi tải: hiển thị **“Không thể tải ảnh. Vui lòng thử lại.”** Giữ viewer để user thử lại.
- Trong lúc ứng dụng chuẩn bị file, click lặp không sinh nhiều yêu cầu. Sau khi đã chuyển cho trình duyệt, click lại được tính là yêu cầu tải mới.
- Tải ảnh A rồi chuyển sang B hoặc đóng viewer: tác vụ đã bắt đầu vẫn gắn với A. Không tải nhầm B hoặc hiển thị lỗi của A như lỗi của B.
- Không báo đã lưu thành công xuống máy nếu ứng dụng chỉ biết đã chuyển tác vụ cho trình duyệt.
- Kiểm tra quyền theo cơ chế hiện hành; không dùng viewer để vượt quyền truy cập ảnh.

### 4.3 Xoay ảnh

- Click icon **Xoay ảnh** một lần: xoay **90° theo chiều kim đồng hồ** quanh tâm ảnh.
- Chuỗi góc: 0° → 90° → 180° → 270° → 0°. Bốn lần click trả ảnh về hướng ban đầu.
- Góc ban đầu tính từ hướng ảnh đã được hiển thị đúng theo metadata, tránh xoay kép.
- Sau mỗi lần xoay, ảnh tự căn giữa và hiển thị vừa vùng xem theo góc mới; vị trí kéo trước đó được reset.
- Xoay chỉ thay đổi hiển thị trong phiên xem hiện tại, không sửa ảnh nguồn hoặc thumbnail.
- Khi ảnh chưa tải xong, icon Xoay ảnh bị khóa.
- Không dùng phím R hoặc phím tắt khác để xoay ảnh.

### 4.4 Phóng to và thu nhỏ bằng chuột

User di chuyển con trỏ đến icon **Phóng to** hoặc **Thu nhỏ** rồi click. Mỗi click thay đổi một mức. Không hiển thị con số hoặc phần trăm zoom trên giao diện.

Hệ số hiển thị nội bộ lần lượt: **0,5 → 0,75 → 1 → 1,25 → 1,5 → 2 → 3 → 4**. Hệ số này phục vụ tính kích thước và nghiệm thu, không hiển thị cho user.

Kích thước cơ sở là ảnh vừa vùng xem tại góc hiện hành, không phóng ảnh nhỏ vượt kích thước tự nhiên. Vùng xem không bao gồm toolbar, thumbnail và khoảng dành cho nút điều hướng. Kích thước hiển thị bằng kích thước cơ sở nhân hệ số; giữ nguyên tỷ lệ ảnh.

| Tình huống | Kết quả |
|---|---|
| Mở ảnh | Hướng ban đầu, hệ số 1, căn giữa |
| Click Phóng to | Chuyển sang hệ số kế tiếp |
| Click Thu nhỏ | Chuyển sang hệ số trước |
| Đạt hệ số 4 | Khóa Phóng to; tooltip “Đã đạt mức phóng to tối đa” |
| Đạt hệ số 0,5 | Khóa Thu nhỏ; tooltip “Đã đạt mức thu nhỏ tối thiểu” |
| Xoay ảnh | Căn giữa, hệ số 1 theo góc mới |
| Chuyển ảnh / đóng rồi mở lại | Reset hướng ban đầu, hệ số 1 và vị trí căn giữa |
| Thay đổi kích thước cửa sổ | Tính lại kích thước cơ sở, giữ góc và hệ số; giới hạn lại vị trí kéo |

Khi click zoom, điểm ảnh tại tâm vùng xem giữ ở tâm sau khi thay đổi kích thước, trừ trường hợp cần giới hạn vị trí để ảnh nằm trong phạm vi kéo hợp lệ.

Không có nút **Vừa khung**. Muốn giảm mức phóng to, user click **Thu nhỏ**. Phím +, -, 0 và cuộn chuột không được viewer sử dụng để zoom; không ghi đè thao tác zoom trang của trình duyệt.

### 4.5 Nhấn giữ và kéo ảnh

1. User đưa con trỏ vào ảnh đang hiển thị.
2. Nhấn giữ **chuột trái** trên ảnh.
3. Di chuyển chuột trong khi vẫn giữ nút: ảnh dịch chuyển theo hướng và khoảng di chuyển của con trỏ, đưa vùng cần xem đến vị trí mới.
4. Thả chuột: kết thúc kéo và giữ vị trí ảnh vừa đặt.

Quy tắc:

- Kéo để xem phần ảnh nằm ngoài vùng xem sau khi phóng to. Khi ảnh tràn theo một chiều, chỉ cho dịch chuyển theo chiều đó; chiều không tràn tiếp tục căn giữa.
- Khi toàn bộ ảnh nằm trong vùng xem, nhấn giữ/kéo không làm ảnh trôi khỏi vị trí căn giữa.
- Giới hạn tọa độ kéo để không kéo mất toàn bộ ảnh hoặc tạo khoảng trống ở mép khi ảnh vẫn còn nội dung vượt khung.
- Con trỏ ở vùng ảnh có thể kéo hiển thị **bàn tay mở**; đang giữ/kéo hiển thị **bàn tay nắm**.
- Di chuyển từ 4 CSS px được nhận diện là kéo; click đơn không bắt đầu kéo hoặc zoom.
- Thả chuột ngoài vùng ảnh hoặc mất focus cửa sổ phải kết thúc kéo; quay lại không làm ảnh tiếp tục bám con trỏ.
- Kéo ảnh không kéo theo toolbar/thumbnail, không chọn văn bản, không mở thao tác kéo file mặc định của trình duyệt và không cuộn trang chat phía sau.
- Nhả chuột sau kéo không được tính thành click nền để đóng viewer.
- Click icon, thumbnail hoặc nút điều hướng không đồng thời bắt đầu kéo ảnh.

### 4.6 Đóng viewer bằng Esc

- Khi viewer đang mở và là lớp tương tác trên cùng, nhấn **Esc** đóng viewer.
- User vẫn ở đúng đoạn chat, giữ vị trí cuộn của đoạn chat và nội dung đang soạn.
- Một lần nhấn không truyền tiếp xuống lớp chat để đóng hội thoại. Nhấn giữ Esc không làm đóng thêm lớp phía sau.
- Nếu tooltip đang hiện, Esc đóng viewer cùng tooltip.
- Nếu một hộp thoại khác đang nằm trên viewer, Esc chỉ xử lý lớp trên cùng theo hành vi của hộp thoại đó.
- Nút **Đóng** bằng chuột vẫn hoạt động. Đóng viewer trả focus về ảnh đã mở; nếu ảnh không còn trong giao diện, trả focus về vùng lịch sử hội thoại.
- Không đăng ký phím tắt D, R, +, -, 0, ?, hoặc phím mũi tên để thao tác ảnh. Điều hướng ảnh dùng các nút và thumbnail hiện có.

### 4.7 Tooltip và bố cục UI

| Icon | Tooltip |
|---|---|
| Tải xuống | Tải xuống |
| Chuyển tiếp | Chuyển tiếp |
| Xoay | Xoay ảnh |
| Zoom in | Phóng to |
| Zoom out | Thu nhỏ |
| Đóng | Đóng |
| Ảnh trước | Ảnh trước |
| Ảnh sau | Ảnh sau |

Tooltip chỉ có text tiếng Việt, không kèm chữ/phím trong ngoặc, biểu tượng bàn phím hoặc tỷ lệ zoom.

Tooltip hiện sau 300 ms hover; ẩn khi rời icon, chuyển ảnh, đóng viewer hoặc kích hoạt thao tác. Tooltip nằm phía trên thanh công cụ dưới ảnh, không che icon hoặc vượt màn hình. Icon đang bị khóa hiển thị lý do tiếng Việt như **“Đang tải ảnh”**, **“Đang chuẩn bị tải xuống”** hoặc thông báo đạt giới hạn zoom.

**Bố cục:**

- Giữ vùng ảnh nền tối, nút trước/sau ở hai bên, nút đóng ở góc trên phải và dải thumbnail.
- Thanh công cụ nằm **phía dưới vùng ảnh**, căn giữa, theo bố cục ảnh tham khảo thứ hai.
- Thứ tự trái sang phải: **Tải xuống → Chuyển tiếp → Xoay ảnh → vạch phân cách → Phóng to → Thu nhỏ**.
- Không hiển thị phần trăm zoom, nút vừa khung, icon bàn phím, bảng phím tắt hoặc dòng gợi ý “0 để vừa khung”.
- Icon **Chuyển tiếp** dùng cùng biểu tượng với thao tác Chuyển tiếp trên tin nhắn; tooltip **“Chuyển tiếp”**. Click mở modal tại §4.9.
- Toolbar luôn nhìn thấy, tách khỏi lớp ảnh biến đổi; dải thumbnail nằm dưới toolbar.
- Vùng bấm icon tối thiểu 40 × 40 CSS px, icon 20–24 px; icon bị khóa có trạng thái phân biệt.
- Giữ nguyên nguồn, thứ tự và quy tắc điều hướng đầu/cuối của danh sách ảnh hiện hành.

### 4.8 Wireframe

**WF-01 — toolbar có icon Chuyển tiếp và tooltip tiếng Việt**

![WF-01](CR-thao-tac-anh-chat-v1.1/WF-01-toolbar-tooltip.png)

[File SVG](CR-thao-tac-anh-chat-v1.1/WF-01-toolbar-tooltip.svg)

**WF-02 — ảnh xoay theo chiều kim đồng hồ, phóng to và kéo vùng ảnh**

![WF-02](CR-thao-tac-anh-chat-v1.1/WF-02-zoom-rotate.png)

[File SVG](CR-thao-tac-anh-chat-v1.1/WF-02-zoom-rotate.svg)

**WF-03 — mở modal Chuyển tiếp từ viewer**

![WF-03](CR-thao-tac-anh-chat-v1.1/WF-03-forward-modal.png)

[File SVG](CR-thao-tac-anh-chat-v1.1/WF-03-forward-modal.svg)

WF-03 minh họa lớp modal, bộ lọc và lựa chọn người/nhóm bằng dữ liệu giả. Khi triển khai, tái sử dụng modal Chuyển tiếp tin nhắn hiện có; hình này không thay thế thiết kế chi tiết của modal dùng chung.

Wireframe dùng ảnh và thumbnail từ ảnh mẫu, thể hiện bố cục và trạng thái giao diện. Các hình là minh họa tĩnh; hành vi thực thi theo các quy tắc tại phần 4.

### 4.9 Chuyển tiếp ảnh đang xem — bổ sung v1.1

**Nguồn dùng chung:** [G003 — Chat, v1.11, UC-08; E09; BR19–BR23, BR25, BR27](CR-thao-tac-anh-chat-v1.1/references/G003-Chat-v1.11.md), snapshot được cung cấp ngày 13/10/2026. CR này bổ sung điểm vào từ viewer; không định nghĩa lại quyền, bộ lọc, giới hạn người nhận hoặc cơ chế gửi của chức năng Chuyển tiếp tin nhắn.

**Điều kiện:** ảnh đang xem xác định được tin nhắn nguồn và đáp ứng cùng điều kiện chuyển tiếp như khi thao tác trên tin nhắn đó. Tin đã thu hồi hoặc thuộc nhóm đã rời/bị xóa: ẩn icon theo BR19/BR25. Các trạng thái hạn chế khác xử lý nhất quán với thao tác trên tin nhắn, không cho phép vượt quyền qua viewer.

1. User click icon **Chuyển tiếp** trên toolbar dưới ảnh.
2. Hệ thống ghi nhận **ảnh đang xem và tin nhắn nguồn tại thời điểm click**, mở modal **Chuyển tiếp** phía trên viewer. Click icon chỉ mở modal, chưa gửi ảnh. Không mở chồng nhiều modal khi click lặp.
3. Modal dùng lại các thành phần của UC-08: bộ lọc tài khoản Zalo (mặc định theo hội thoại nguồn), bộ lọc thẻ, ô tìm kiếm và danh sách người/nhóm hợp lệ. Danh sách, quyền xem/chọn, nhóm không được chọn và giới hạn tối đa 99 hội thoại dùng chung với chuyển tiếp tin nhắn; CR không mở rộng phạm vi chuyển tiếp giữa tài khoản.
4. User tìm và chọn người/nhóm, rồi click **Gửi** theo luồng chuyển tiếp tin nhắn. Không có người nhận hợp lệ thì chưa thực hiện gửi. Nội dung chuyển tiếp là **một ảnh đang xem**, kể cả khi tin nhắn nguồn có nhiều ảnh; không tự chuyển tiếp toàn bộ album hoặc ảnh khác trong dải thumbnail.
5. Khi thành công: hiển thị **“Đã chuyển tiếp”**, đóng modal và trở về viewer đang mở. Ảnh đến đích dưới dạng tin nhắn thường theo BR20.
6. Khi thất bại: hiển thị **“Không thể chuyển tiếp, vui lòng thử lại”**, giữ modal để user thử lại theo E09; trạng thái gửi và xử lý từng đích dùng chung với chuyển tiếp tin nhắn.

**Ngữ cảnh và lớp tương tác:**

- Chuyển tiếp ảnh nguồn, không áp dụng góc xoay, zoom hoặc vị trí kéo trong viewer và không gửi ảnh chụp màn hình.
- Khi modal mở, modal nhận tương tác; toolbar, điều hướng và thumbnail của viewer phía sau không nhận click. Ảnh đã ghi nhận không thay đổi theo cập nhật danh sách ảnh phía sau.
- Hủy hoặc đóng modal không gửi ảnh. Trở về đúng ảnh, góc xoay, mức zoom và vị trí kéo trước đó; focus về icon Chuyển tiếp nếu còn khả dụng.
- Khi modal là lớp trên cùng, Esc chỉ xử lý modal theo hành vi dùng chung, không truyền tiếp để đóng viewer hoặc hội thoại (§4.6).
- Sau khi chuyển tiếp thành công, viewer vẫn giữ trạng thái xem; không tự chuyển hội thoại sang người/nhóm nhận. Nội dung đang soạn và vị trí cuộn chat được giữ nguyên.
- Nếu nguồn bị thu hồi, mất quyền hoặc người/nhóm nhận không còn hợp lệ trước khi Gửi: kiểm tra lại theo cơ chế chuyển tiếp tin nhắn, chặn phần không hợp lệ và hiển thị phản hồi tương ứng; không gửi bằng dữ liệu cũ để vượt điều kiện.

## 5 Acceptance Criteria

| ID | Scenarios | Given | When | Then |
|---|---|---|---|---|
| AC-01 | Mở ảnh | User đang ở đoạn chat, có quyền xem ảnh | Click ảnh | Viewer hiển thị ảnh căn giữa, hướng ban đầu, hệ số 1 |
| AC-02 | Toolbar | Viewer đang mở | Quan sát giao diện | Toolbar dưới ảnh có Tải xuống, Chuyển tiếp, Xoay ảnh, Phóng to, Thu nhỏ; không có tỷ lệ zoom, nút vừa khung hoặc bàn phím |
| AC-03 | Tải nguồn | Ảnh đã xoay/phóng to/kéo | Click Tải xuống | Tải đúng nguồn ảnh được chọn, không áp dụng các biến đổi xem, viewer vẫn mở |
| AC-04 | Tên file | File nguồn không có tên | Click Tải xuống | Tên thay thế hợp lệ, đuôi khớp định dạng thực tế |
| AC-05 | Click tải lặp | Đang chuẩn bị file | Click Tải xuống nhiều lần | Chỉ một yêu cầu trong thời gian xử lý |
| AC-06 | Chuyển ảnh khi tải | Tải A đã bắt đầu | Chọn ảnh B | Yêu cầu vẫn tải A; không tải nhầm B |
| AC-07 | Lỗi tải | File mất hoặc tải lỗi | Click Tải xuống | Hiển thị lỗi tương ứng, không báo đã lưu thành công; viewer giữ nguyên |
| AC-08 | Xoay một lần | Ảnh đã tải | Click Xoay ảnh | Xoay 90° theo chiều kim đồng hồ; căn giữa và hiển thị vừa vùng xem |
| AC-09 | Xoay đủ vòng | Ảnh ở hướng ban đầu | Click Xoay ảnh 4 lần | Trở về hướng ban đầu; nguồn và thumbnail không đổi |
| AC-10 | Zoom in | Hệ số nội bộ là 1 | Click icon Phóng to | Hệ số lên 1,25, giữ tỷ lệ ảnh; không hiển thị con số zoom |
| AC-11 | Zoom out | Hệ số nội bộ là 1 | Click icon Thu nhỏ | Hệ số xuống 0,75; không thay đổi zoom trang |
| AC-12 | Zoom tối đa | Hệ số nội bộ là 4 | Hover/click Phóng to | Nút bị khóa, không tăng thêm; tooltip tiếng Việt về giới hạn tối đa |
| AC-13 | Zoom tối thiểu | Hệ số nội bộ là 0,5 | Hover/click Thu nhỏ | Nút bị khóa, không giảm thêm; tooltip tiếng Việt về giới hạn tối thiểu |
| AC-14 | Bắt đầu kéo | Ảnh tràn khung sau phóng to | Giữ chuột trái và di chuyển từ 4 CSS px | Ảnh dịch chuyển theo con trỏ trong giới hạn; con trỏ thành bàn tay nắm |
| AC-15 | Kết thúc kéo | Đang kéo ảnh | Thả chuột | Ảnh giữ vị trí mới; không đóng viewer |
| AC-16 | Kéo ngoài ảnh | Đang kéo ảnh | Thả chuột ngoài ảnh hoặc cửa sổ mất focus | Chấm dứt kéo; ảnh không tiếp tục bám con trỏ |
| AC-17 | Giới hạn kéo | Ảnh lớn hơn khung | Kéo đến biên | Không kéo mất toàn bộ ảnh; không tạo khoảng trống ở chiều còn nội dung vượt khung |
| AC-18 | Ảnh không tràn | Toàn ảnh nằm trong vùng xem | Giữ và kéo | Ảnh vẫn căn giữa, không trôi khỏi khung |
| AC-19 | Tràn một chiều | Ảnh chỉ tràn theo chiều ngang | Kéo chéo | Dịch ngang trong giới hạn; chiều dọc giữ căn giữa |
| AC-20 | Tách lớp thao tác | Viewer đang mở | Kéo ảnh hoặc click toolbar | Toolbar/thumbnail không bị kéo theo; không kích hoạt đồng thời hành động khác |
| AC-21 | Reset khi đổi ảnh | A đã xoay, zoom và kéo | Click thumbnail B | B về hướng ban đầu, hệ số 1, căn giữa |
| AC-22 | Reset khi mở lại | Đã đóng ảnh sau biến đổi | Mở lại ảnh đó | Viewer khởi tạo như mở mới |
| AC-23 | Esc | Viewer đang mở trên đoạn chat | Nhấn Esc một lần | Chỉ đóng viewer; vẫn đúng hội thoại, giữ cuộn và nội dung đang soạn |
| AC-24 | Giữ Esc | Viewer là lớp trên cùng | Nhấn giữ Esc | Không đóng thêm hội thoại/lớp chat phía sau |
| AC-25 | Đóng bằng icon | Viewer đang mở | Click Đóng | Đóng viewer và trả focus đúng, giữ đoạn chat |
| AC-26 | Bỏ phím tắt ảnh | Viewer đang mở | Nhấn D, R, +, -, 0, ?, hoặc mũi tên | Viewer không chạy tải/xoay/zoom/hướng dẫn/chuyển ảnh bằng các phím này |
| AC-27 | Zoom bằng chuột | Viewer đang mở | Cuộn chuột hoặc nhấp đúp ảnh | Không kích hoạt zoom ảnh; click đơn icon zoom mới đổi mức |
| AC-28 | Tooltip | Icon có thể thao tác | Hover 300 ms | Hiện đúng text tiếng Việt, không gợi ý phím hoặc mức zoom |
| AC-29 | Tooltip kết thúc | Tooltip đang hiện | Rời icon, chuyển ảnh hoặc đóng viewer | Tooltip ẩn, không còn treo trên màn hình |
| AC-30 | Chưa tải ảnh | Ảnh đang tải | Click Xoay/Phóng to/Thu nhỏ | Không thực thi biến đổi; icon bị khóa, tooltip “Đang tải ảnh” |
| AC-31 | Resize | Ảnh đã zoom và kéo | Đổi kích thước cửa sổ | Tính lại cơ sở hiển thị, giữ góc/hệ số, giới hạn lại vị trí kéo; toolbar vẫn thấy |
| AC-32 | Ảnh đặc biệt | Ảnh dọc/ngang/nhỏ hoặc có metadata xoay | Mở và xoay | Không bóp méo, không xoay kép; căn giữa đúng |
| AC-33 | Hồi quy điều hướng | Viewer có nhiều ảnh | Click trước/sau hoặc thumbnail | Chuyển ảnh theo quy tắc hiện hành, không thay thứ tự danh sách |
| AC-34 | Không chỉnh nguồn | Một user biến đổi cách xem ảnh | User khác mở cùng ảnh hoặc tải nguồn | Nguồn giữ nguyên; không nhận biến đổi của user trước |

| AC-35 | Mở modal chuyển tiếp | Ảnh đủ điều kiện chuyển tiếp, viewer đang mở | Click Chuyển tiếp, kể cả click lặp | Chỉ mở một modal Chuyển tiếp dùng chung với tin nhắn, chưa gửi ảnh; viewer vẫn ở phía sau |
| AC-36 | Chọn người/nhóm | Modal mở từ ảnh A | Tìm kiếm, lọc, chọn người/nhóm | Thành phần, dữ liệu, quyền chọn và giới hạn 99 hội thoại như UC-08; chưa chọn đích hợp lệ thì không gửi |
| AC-37 | Chuyển tiếp đúng ảnh | A đã xoay/zoom/kéo; tin nguồn có thể chứa nhiều ảnh | Chọn đích hợp lệ rồi Gửi thành công | Chỉ gửi nguồn ảnh A, không áp biến đổi và không gửi toàn album; toast “Đã chuyển tiếp”, đóng modal, giữ trạng thái viewer |
| AC-38 | Hủy modal | Modal đang mở trên viewer | Hủy hoặc đóng modal | Không gửi ảnh; trở về đúng ảnh và trạng thái xem, focus về Chuyển tiếp nếu còn khả dụng |
| AC-39 | Esc trên modal | Modal là lớp tương tác trên cùng | Nhấn Esc | Xử lý theo modal dùng chung; không đồng thời đóng viewer/hội thoại |
| AC-40 | Chuyển tiếp thất bại | Đã chọn người/nhóm | Gửi bị lỗi | Toast “Không thể chuyển tiếp, vui lòng thử lại”; modal giữ nguyên theo E09, xử lý thử lại như chuyển tiếp tin nhắn |
| AC-41 | Nguồn không được chuyển tiếp | Tin đã thu hồi hoặc thuộc nhóm đã rời/bị xóa | Quan sát toolbar | Icon Chuyển tiếp ẩn theo BR19/BR25, không tạo điểm vào vượt quyền |
| AC-42 | Điều kiện thay đổi | Modal mở, sau đó nguồn/đích mất điều kiện hoặc user mất quyền | Click Gửi | Kiểm tra lại theo luồng dùng chung, không gửi phần không hợp lệ; hiển thị phản hồi tương ứng |
| AC-43 | Khóa tương tác phía sau | Modal đang mở cho ảnh A | Click toolbar, thumbnail hoặc điều hướng phía sau | Viewer không nhận tương tác; nội dung chờ chuyển tiếp vẫn là A |
| AC-44 | Giữ ngữ cảnh chat | Chat có nội dung đang soạn và vị trí cuộn | Hủy hoặc gửi thành công từ modal | Giữ hội thoại nguồn, nội dung soạn và vị trí cuộn; không tự mở hội thoại đích |

## 6 Data Migration (Optional)

Không di chuyển dữ liệu lịch sử hoặc chỉnh sửa file ảnh. Góc xoay, hệ số hiển thị và vị trí kéo chỉ tồn tại trong phiên xem. Các quyền truy cập, trạng thái ảnh và chính sách tải hiện hành được giữ nguyên.

## 7 Change Log

| Version | Date | Description / Change | Reason |
|---|---|---|---|
| 1.0 | 13/10/2026 | Bản nền được cung cấp: tải xuống, xoay 90°, zoom bằng icon, kéo ảnh, tooltip, Esc; 2 wireframe; chuyển tiếp được ghi ngoài phạm vi. Dòng lịch sử được bổ sung khi cập nhật v1.1 để truy vết, không phải xác nhận triển khai. | Ghi nhận baseline trước thay đổi |
| 1.1 | 13/10/2026 | **Phạm vi (§1–3):** đưa chuyển tiếp một ảnh đang xem vào In Scope; bỏ nội dung loại chuyển tiếp khỏi phạm vi; chưa bổ sung chọn nhiều ảnh từ viewer. | Yêu cầu bổ sung của người dùng ngày 13/10/2026 |
| 1.1 | 13/10/2026 | **UI (§4.1 CR-07, §4.7):** thêm icon và tooltip “Chuyển tiếp” sau Tải xuống; thứ tự toolbar: Tải xuống → Chuyển tiếp → Xoay ảnh → phân cách → Phóng to → Thu nhỏ. | Có điểm chuyển tiếp trực tiếp trong lightbox |
| 1.1 | 13/10/2026 | **Luồng (§4.9):** click icon mở modal chọn người/nhóm dùng chung với Chuyển tiếp tin nhắn (G003 UC-08); ghi nhận đúng ảnh tại lúc click; tìm kiếm/lọc/chọn đích/Gửi, quyền và giới hạn theo chức năng dùng chung; chỉ gửi một ảnh nguồn, không gửi toàn album hoặc biến đổi hiển thị. | Nhất quán với tương tác chuyển tiếp tin nhắn |
| 1.1 | 13/10/2026 | **Trạng thái (§4.9, liên hệ §4.6):** mô tả thành công, thất bại, hủy/đóng, Esc theo lớp modal, click lặp, khóa viewer phía sau, kiểm tra lại nguồn/đích/quyền; giữ trạng thái xem và ngữ cảnh chat. | Làm rõ kết quả và tránh gửi nhầm hoặc đóng sai lớp |
| 1.1 | 13/10/2026 | **Nghiệm thu (§5):** sửa AC-02; thêm AC-35–AC-44 cho modal, quyền, ảnh nguồn, kết quả gửi, hủy, Esc và ngữ cảnh. Chưa thực thi kiểm thử sản phẩm. | QA có tiêu chí kiểm tra cho yêu cầu bổ sung |
| 1.1 | 13/10/2026 | **Ảnh (§4.8):** cập nhật WF-01/WF-02 (SVG và PNG) có icon Chuyển tiếp; WF-01 hiển thị tooltip “Chuyển tiếp”; thêm WF-03 (SVG và PNG) minh họa modal chọn người/nhóm trên viewer. Lưu bộ v1.0 trong archive-v1.0. | Đồng bộ hình minh họa với đặc tả và giữ bản trước thay đổi |
