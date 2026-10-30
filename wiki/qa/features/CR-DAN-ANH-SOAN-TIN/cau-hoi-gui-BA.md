# [CR] [Zalo Chat] Điều chỉnh hành vi dán ảnh trực tiếp tại khu vực soạn tin — Câu hỏi QA gửi BA

| | |
| --- | --- |
| **Tài liệu** | [CR] [Zalo Chat] Điều chỉnh hành vi dán ảnh trực tiếp tại khu vực soạn tin — **v1.0.2** (Change Log 20/10/2026; ID N/A) |
| **Gửi** | Nguyễn Thị Phương Thảo (BA) |
| **Từ** | Hồng (QA) |
| **Ngày gửi** | 2026-10-21 |
| **Tài liệu đã đối chiếu** | CR v1.0.2 · G003 v1.11 (UC-02b, E04/E05, BR03–BR05) · G008 v1.1 (UC-08 @mention) · G009 v1.12 (UC-02 Reply) · G036 v1.0 (BR14, BR24, OOS01) · CR-004 (mốc tách 2.000) |

Chị Thảo trả lời giúp em vào cột **BA trả lời**. Câu có sẵn phương án thì chỉ cần ghi (a) hoặc (b); không phương án nào đúng
thì ghi cách đúng.

Bản v1.0.1 đã trả lời câu "giới hạn số ảnh" (tối đa 25 ảnh, chặn lúc dán) nên em bỏ câu đó. QA cần câu trả lời cho **5 câu ở
Phần A** trước khi viết test case. Phần B không chặn việc.

## Phần A — Cần trả lời trước khi viết test case

| # | Câu hỏi | Tài liệu đang ghi | Phương án | BA trả lời |
| --- | --- | --- | --- | --- |
| **Q-02** | **Cụm ảnh** (§6.5): (i) trên Zalo là **một tin nhiều ảnh** hay **mỗi ảnh một tin** (có caption riêng) và Gopany chỉ gộp hiển thị? Điều này quyết định thu hồi / trả lời / react / chuyển tiếp / ghim **từng ảnh** và nút Thử lại từng ảnh. (ii) Cách hiển thị cụm có áp dụng cho ảnh gửi qua **popup Gửi Media**, ảnh **khách gửi** nhiều ảnh liên tiếp, ảnh gửi **từ điện thoại** không, hay chỉ ảnh dán Ctrl+V? (iii) G036 OOS01 "không gộp nhiều ảnh thành lưới — vẫn hiện từng ảnh" còn hiệu lực không? (iv) Cụm **25 ảnh** hiển thị thế nào (lưới, cuộn, "+n")? | CR §3: "Cụm ảnh: cách hiển thị nhiều ảnh trong cùng một lần gửi. Mỗi ảnh giữ mô tả tương ứng"; §6.5: "các ảnh trong cùng một khung theo thiết kế". G036 OOS01: đã thống nhất bỏ qua lưới ảnh. | (i) **(a)** mỗi ảnh một tin, gộp hiển thị · **(b)** một tin nhiều ảnh.<br>(ii) ghi rõ luồng nào áp dụng.<br>(iii) **(a)** OOS01 hết hiệu lực, cập nhật G036 · **(b)** chỉ ảnh dán mới gộp. | |
| **Q-03** | v1.0.1 đã **gạch bỏ** giới hạn tổng dung lượng 25 MB và chỉ giữ "dung lượng **từng** ảnh". Vậy **G003 BR05 / E05** (tổng ≤25 MB, tối đa 5 ảnh × 5 MB) **hết hiệu lực** cho luồng dán phải không — tức 25 ảnh × 5 MB = 125 MB vẫn gửi được? Luồng **icon Gửi Media** (ngoài phạm vi CR) còn áp 25 MB / 5 ảnh không? Thông báo "giữa màn hình" (chặn ảnh thứ 26) là **toast tự tắt** hay **popup phải bấm đóng**? | CR v1.0.1 BR-03: toàn bộ quy tắc tổng <25 MB bị gạch; AC-25: "đã dán đúng 25 ảnh… cho phép gửi 25 ảnh". §4.1 Note: giữ logic "dung lượng từng ảnh". G003 BR05: "tổng ≤25MB/lần gửi (tối đa 5 ảnh × 5MB)"; E05: ">25MB chặn toàn bộ lô". | **(a)** Bỏ hẳn giới hạn tổng và 5 ảnh cho luồng dán; cập nhật G003.<br>**(b)** Vẫn chặn tổng 25 MB (khi đó AC-25 cần ghi rõ dung lượng). | |
| **Q-04** | Dán ảnh **sai định dạng** hoặc **>5 MB** (AC-29): ảnh bị **từ chối ngay lúc dán** (không có thumbnail, báo lỗi) hay **vẫn vào danh sách rồi chặn lúc Gửi**? Ảnh lỗi có **chiếm chỗ** trong giới hạn 25 không? Định dạng nào được dán (PNG, JPG; GIF, WebP, SVG, BMP, HEIC?) và **thông báo lỗi nguyên văn**? | AC-29: "kiểm tra và xử lý lỗi theo cơ chế hiện tại". G003 E04: "thông báo lỗi ngay khi chọn file, trước khi upload"; §10D chỉ ghi "Ảnh PNG/JPG". BR-03 mới chặn ảnh thứ 26 **ngay lúc dán**. | **(a)** Từ chối ngay lúc dán.<br>**(b)** Vào danh sách, chặn lúc Gửi. | |
| **Q-05** | **Một ảnh không có mô tả** + nội dung soạn **dài hơn mốc tách** (2.000 ký tự theo CR-004) hoặc dài hơn trần caption ảnh: nội dung "đi cùng ảnh" thế nào — chuyển thành tin nhắn riêng trước ảnh rồi tự tách, hay caption bị cắt, hay chặn? | CR BR-20: "một ảnh không có mô tả: nội dung soạn đi cùng ảnh"; BR-22: "nội dung dài tự tách… kế thừa logic hiện tại". Mô tả ảnh có trần 2000 bytes nhưng nội dung ô soạn không có trần. | | |
| **Q-17** | v1.0.2 đổi trần mô tả ảnh thành **2000 bytes**. (i) Đếm byte theo **bảng mã nào** — UTF-8 (chữ Việt có dấu 2–3 bytes, emoji 4 bytes, tức chỉ ~700–1000 chữ Việt) hay UTF-16 (2 bytes/ký tự = 1000 ký tự)? Hay ý chị là **2000 ký tự** (Change Log ghi "giới hạn ký tự")? (ii) Còn 1 byte mà ký tự kế tiếp cần 2–3 bytes thì **từ chối cả ký tự** đúng không? (iii) Xuống dòng tính 1 hay 2 bytes? (iv) Có **bộ đếm** cho người dùng biết còn bao nhiêu không — vì người dùng không nhìn thấy byte? (v) 2000 bytes có phải trần caption của Zalo? | BR-08: "tối đa 2000 bytes, tính cả khoảng trắng và ký tự xuống dòng… đã đủ 2000 bytes, không cho nhập thêm ký tự"; AC-09: "nhập đủ 2000 bytes rồi click Lưu". Change Log v1.0.2: "Thay đổi giới hạn **ký tự** mô tả ảnh: Max 2000 bytes". | (i) **(a)** UTF-8 · **(b)** UTF-16 · **(c)** thực ra là 2000 ký tự. | |

## Phần B — Không chặn việc, nhờ chị xác nhận hoặc bổ sung tài liệu

| # | Nội dung | Tài liệu đang ghi | Phương án | BA trả lời |
| --- | --- | --- | --- | --- |
| **Q-06** | **Popup Gửi Media** hiện tại có tài liệu không? Khi đã dán 2 ảnh rồi bấm icon Gửi ảnh → popup gửi có kèm 2 ảnh đã dán không? Ảnh gửi qua popup có **Ghi chú** thì hiển thị như "mô tả bên dưới ảnh" ở §6.6 không? | CR §1 mô tả hiện trạng; §4.2: "không thay đổi luồng tải ảnh bằng icon". Không có spec popup trong bộ tài liệu QA nhận. | | |
| **Q-07** | **Mention tự động khi reply trong nhóm** (BR-19, §5.4, AC-39/41) là gì: tự tag người gửi tin được trả lời? User **xóa được** tag này không? Có tài liệu không? | G009 UC-02 và G008 UC-08 không mô tả mention tự động. | | |
| **Q-08** | Ô soạn tin **chỉ có khoảng trắng / xuống dòng** khi gửi kèm ảnh: coi là **trống** (chỉ gửi ảnh) hay là **nội dung** (tạo tin riêng / caption)? | BR-07 chỉ định nghĩa "chỉ khoảng trắng = trống" cho **mô tả ảnh**; §5.4 dùng chữ "nội dung hợp lệ" nhưng không định nghĩa. | **(a)** Trống.<br>**(b)** Là nội dung. | |
| **Q-09** | (i) Một lần Ctrl+V chứa **nhiều file ảnh** (copy từ thư mục): nhận hết không, thứ tự nào? (ii) Clipboard có **cả ảnh và văn bản** (copy từ web / Word): dán gì? (iii) Ctrl+V ảnh khi con trỏ đang ở **trường Mô tả trong modal**: bỏ qua hay thêm ảnh vào danh sách? (iv) Danh sách còn **2 chỗ trống** (23 ảnh) mà dán một lần **3 file**: nhận 2 ảnh đầu hay từ chối hết, thông báo gì? | BR-01 chỉ nói "Ctrl+V ảnh"; §6.1 "thứ tự dán"; AC-24 chỉ nói dán văn bản; BR-03 mới chỉ mô tả "dán thêm ảnh thứ 26". | | |
| **Q-10** | Một ảnh trong **cụm** gửi lỗi: hiển thị thế nào (ảnh lỗi viền đỏ ngay trong cụm hay tách ra), nút **Thử lại** ở đâu, gửi lại thành công có về đúng vị trí trong cụm không? | BR-22 / AC-43: "thử lại phần lỗi… không làm sai mô tả". G036 BR24: tin lỗi viền đỏ + Thử lại ở mọi vị trí. | | |
| **Q-11** | **Bản nháp ảnh** (BR-18) lưu ở trình duyệt hay server? Hai nhân viên dùng chung một tài khoản Zalo có thấy bản nháp của nhau không? "Phiên sử dụng" kết thúc khi nào (đăng xuất, đổi tài khoản Zalo)? Nội dung **chữ** ở ô soạn hiện có được giữ khi chuyển hội thoại không? | BR-18: "thuộc đúng bản nháp của hội thoại và tài khoản Zalo… quay lại trong cùng phiên sử dụng". §4.2 loại trừ tải lại trang. | | |
| **Q-12** | Ctrl+V ảnh khi **không có quyền gửi** / ô soạn **disable** (tài khoản Zalo ngắt kết nối, nhóm chỉ trưởng/phó nhắn tin): bỏ qua, báo lỗi, hay vẫn đính kèm rồi chặn lúc Gửi? Tài khoản **ngắt kết nối sau khi đã dán** thì bản nháp ra sao? | CR §4.1 chỉ áp dụng "hội thoại mà user có quyền gửi tin". G003 BR10: input disable khi ngắt kết nối. | | |
| **Q-13** | Nhấn **Esc để đóng Modal Nhập mô tả** (không có popup): có bị lan xuống hội thoại và **thoát đoạn chat** không? | BR-15 chỉ cấm truyền thao tác xuống dưới cho **popup**. CR ESC ghi hiện trạng Esc trong đoạn chat → về danh sách. | **(a)** Chỉ đóng modal, vẫn ở đoạn chat.<br>**(b)** Khác. | |
| **Q-14** | Dải mô tả trên thumbnail: **8 ký tự** đếm cả khoảng trắng / xuống dòng? Mô tả có xuống dòng hiển thị trên dải một dòng thế nào? Nút chuyển ảnh ở ảnh đầu / cuối: **ẩn** hay **disable**? n = 1 hiển thị "1 ảnh"? Thông báo "Bạn **chỉ nên** gửi tối đa 25 ảnh/ lần" là lời khuyên trong khi hệ thống chặn cứng — chữ này đúng ý chưa? | BR-10, §6.2 "chỉ nhận thao tác khi có ảnh tương ứng để chuyển", §6.1 `{n} ảnh`, BR-03 v1.0.1. | | |
| **Q-15** | AC-45 "phím gửi theo **thiết lập hiện tại**": có thiết lập phím gửi (Enter / Ctrl+Enter) không, ở đâu? | G003 UC-02a chỉ ghi "Nhấn Enter hoặc click icon gửi". | | |
| **Q-16** | **Mã CR** để QA trace (đang dùng tạm `CR-DAN-ANH-SOAN-TIN`); header chưa ghi version. Change Log v1.0.1 ghi điều chỉnh **AC-46** nhưng dòng đổi thực tế là **AC-45** (AC-46 không đổi) — chị sửa giúp. QA cần quyền xem **Figma** node 35-2 để kiểm "theo thiết kế" (§6.5, §6.6). | CR: ID N/A; Change Log v1.0.1, v1.0.2. | | |

## Phản hồi của BA

| | |
| --- | --- |
| **Người trả lời** | |
| **Ngày trả lời** | |
| **Ghi chú thêm** | |

## Lịch sử cập nhật (nội bộ QA — BA không cần đọc)

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
| 2026-10-20 | AI (Orchestrator) | Tạo Phần A (Q-01 → Q-05), Phần B (Q-06 → Q-16) theo CR bản (1); mức là đề xuất, chờ Hồng chốt |
| 2026-10-21 | AI (Orchestrator) — Hồng chuyển bản (3) v1.0.2 | Bỏ Q-01 (đã trả lời bởi v1.0.1: 25 ảnh); viết lại Q-03 (G003 BR05/E05 còn hiệu lực?); thêm Q-17 (2000 bytes) vào Phần A; bổ sung Q-02 (iv), Q-04 (chiếm chỗ), Q-09 (iv), Q-14 (chữ "chỉ nên"), Q-16 (Change Log dẫn nhầm AC-46); đổi ngày gửi, version tài liệu |
