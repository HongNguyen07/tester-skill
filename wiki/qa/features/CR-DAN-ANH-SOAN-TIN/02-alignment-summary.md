---
featureId: CR-DAN-ANH-SOAN-TIN   # mã tạm — CR ghi ID N/A
stage: S4a
gate: closed
materialOpen: 5          # đề xuất của AI — chờ Hồng chốt mức (Q-02, Q-03, Q-04, Q-05, Q-17)
nonMaterialOpen: 11
gateOpenedBy:
gateOpenedAt:
updatedAt: 2026-10-21
---

# Requirement Understanding / Alignment Summary — CR-DAN-ANH-SOAN-TIN: Dán ảnh trực tiếp tại khu vực soạn tin

Trạng thái: **S4a — câu hỏi đã lập theo CR v1.0.2 (bản (3).md), chờ Hồng chốt mức và gửi BA Nguyễn Thị Phương Thảo.**
Debate S4b bắt đầu ngay với BR không phụ thuộc BA (rule 04 §4b: theo thứ tự BR, câu hỏi mở, Hồng nói trước). Lượt 1 (BR-02)
đã đặt câu hỏi ngày 2026-10-20, chưa có câu trả lời của Hồng.

Viết tắt: `CR` = bản (3).md v1.0.2; `G003`, `G008`, `G009`, `G036`, `CR-004`, `ESC` — như mục đầu `01-requirement-analysis.md`.
Số dòng `CR:n` theo bản (3).

## 1. Nguồn và phạm vi đã đọc

Xem mục 1 của `01-requirement-analysis.md`. Nguồn chính: CR **v1.0.2** (Change Log 20/10/2026; header 15/10/2026, BA Phương
Thảo, ID N/A). v1.0.1 bỏ giới hạn tổng dung lượng, thay bằng tối đa 25 ảnh; v1.0.2 mô tả ảnh 2000 bytes. Dùng chung: G003 v1.11,
G008 v1.1, G009 v1.12, G036 v1.0, CR-004, ESC. Thiếu: Figma (chưa mở), spec popup Gửi Media, spec mention tự động khi reply, spec
bản nháp ô soạn, spec thiết lập phím gửi.

## 2. Requirement / Business rule đã trích

| Mã | Tóm tắt | Nguồn | Trạng thái hiểu |
| --- | --- | --- | --- |
| BR-01 | Dán trực tiếp, không popup, thêm cuối danh sách, giữ thứ tự, **tối đa 25 ảnh** (v1.0.1) | `CR:82` | `[NGUỒN]` — Q-01 đóng theo v1.0.1; còn mở Q-04 (ảnh lỗi), Q-09 (nhiều file / focus / chỗ trống) |
| BR-02 | Giữ nội dung soạn, mention, trạng thái reply | `CR:83` | `[NGUỒN]` rõ — đang debate lượt 1 |
| BR-03 | **(v1.0.1)** Tối đa 25 ảnh / lần gửi; dán ảnh 26 → chặn + thông báo; kiểm lại khi gửi. Quy tắc tổng 25 MB bị gạch | `CR:84` | `[NGUỒN]` — còn mở Q-03 (G003 BR05/E05 còn hiệu lực?) |
| BR-04 | Mô tả riêng từng ảnh | `CR:85` | `[NGUỒN]` rõ |
| BR-05 | Mở modal đúng ảnh (icon / thumbnail), icon Xóa không mở | `CR:86` | `[NGUỒN]` rõ |
| BR-06 | Chuyển ảnh trong modal, giữ tạm nội dung | `CR:87` | `[NGUỒN]` rõ |
| BR-07 | Không mention, Enter xuống dòng, khoảng trắng = trống | `CR:88` | `[NGUỒN]` rõ |
| BR-08 | **(v1.0.2)** 2000 bytes, chặn gõ và dán vượt | `CR:89` | `[NGUỒN]` — còn mở Q-17 (đơn vị bytes) |
| BR-09 | Lưu toàn bộ, gỡ bằng xóa hết rồi Lưu | `CR:90` | `[NGUỒN]` rõ |
| BR-10 | Dải mô tả 8 ký tự + "…" | `CR:91` | `[NGUỒN]` — Q-14 (đếm, xuống dòng) |
| BR-11 | Đóng modal không popup khi không còn nội dung chưa lưu | `CR:92` | `[NGUỒN]` — Q-13 (Esc lan xuống chat) |
| BR-12 | Popup Huỷ mô tả khi còn nội dung chưa lưu không trống | `CR:93` | `[NGUỒN]` rõ |
| BR-13 | Huỷ mô tả: bỏ hết, đóng cả hai | `CR:94` | `[NGUỒN]` rõ |
| BR-14 | Quay lại / Đóng / Esc tại popup | `CR:95` | `[NGUỒN]` rõ |
| BR-15 | Vùng tối, lớp tương tác của popup | `CR:96` | `[NGUỒN]` rõ |
| BR-16 | Xóa một ảnh; **cập nhật số lượng còn lại trong giới hạn 25** (v1.0.1) | `CR:97` | `[NGUỒN]` rõ |
| BR-17 | Xóa tất cả, không gửi rỗng | `CR:98` | `[NGUỒN]` — Q-08 (ô soạn chỉ khoảng trắng) |
| BR-18 | Bản nháp theo hội thoại và tài khoản Zalo | `CR:99` | `[NGUỒN]` — Q-11 |
| BR-19 | Mention khi đính kèm ảnh; mention tự động là nội dung | `CR:100` | `[NGUỒN]` — Q-07 (spec mention tự động) |
| BR-20 | Quy tắc gửi thông thường (bảng §5.3) | `CR:101`, `CR:113-122` | `[NGUỒN]` — Q-02 (cụm ảnh), Q-05 (nội dung dài + một ảnh), Q-08 |
| BR-21 | Quy tắc gửi khi reply (bảng §5.4) | `CR:102`, `CR:132-141` | `[NGUỒN]` — Q-07 |
| BR-22 | Thứ tự gửi, tách tin, gửi lại | `CR:103` | `[NGUỒN]` — Q-05, Q-10 (lỗi trong cụm) |
| UI §6.1–6.6 | Khu vực đính kèm, modal, popup, hiển thị sau gửi | `CR:149-221` | `[NGUỒN]` — Q-02, Q-06, Q-14, Q-16 (Figma) |

## 3. Bảng câu hỏi debate

| Q | Mức (đề xuất) | Trích dẫn + nguồn | Vì sao chưa rõ | Các cách hiểu có căn cứ | Ảnh hưởng tới test | Cần ai xác nhận | Trạng thái | Câu trả lời | Ai trả lời · ngày · kênh |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Q-01 | ~~Trọng yếu~~ | Bản (1): `CR:80` không nêu số ảnh; G003 BR05 tối đa 5 ảnh | Bản (1) không nêu giới hạn số ảnh | — | — | BA Thảo | **Đã xác nhận** — tài liệu v1.0.1 | Tối đa **25 ảnh** trong danh sách; dán ảnh thứ 26 → chặn thêm, thông báo "Bạn chỉ nên gửi tối đa 25 ảnh/ lần"; kiểm lại khi gửi (`CR:82`, `CR:84`, AC-25→28). Phần dư chuyển sang Q-09 (iv), Q-14 | BA Thảo · 20/10/2026 · cập nhật tài liệu v1.0.1, Hồng chuyển bản (3) ngày 2026-10-21 |
| Q-02 | **Trọng yếu** (hành vi + phạm vi hồi quy) | `CR:39`, `CR:53`, `CR:207-210` cụm ảnh "trong cùng một khung theo thiết kế"; `G036:314` OOS01 "vẫn hiện từng ảnh" | (i) Cụm là một tin Zalo hay n tin; (ii) áp dụng cho ảnh gửi qua popup / khách gửi / từ điện thoại không; (iii) OOS01 còn hiệu lực không | (i-a) Mỗi ảnh một tin + caption, Gopany chỉ **gộp hiển thị** — căn cứ: mỗi ảnh giữ mô tả riêng (`CR:39`), Retry từng phần (`CR:103`). (i-b) Một tin nhiều ảnh — căn cứ: "cùng một lần gửi", "cùng một khung" (`CR:207`). (ii) Tài liệu không nói. (iii) CR mới hơn và in scope "điều chỉnh cách hiển thị nhiều ảnh" (`CR:53`) | Thu hồi / trả lời / react / chuyển tiếp / ghim **một ảnh trong cụm**; trạng thái gửi và viền lỗi từng ảnh; cụm 25 ảnh hiển thị thế nào; hồi quy ảnh gửi bằng icon và ảnh nhận | BA Thảo (+ Dev về cấu trúc tin) | Mở | | |
| Q-03 | **Trọng yếu** (mâu thuẫn hai nguồn về hành vi) — viết lại theo v1.0.1 | CR v1.0.1 gạch toàn bộ tổng <25 MB (`CR:84`); Note "dung lượng **từng** ảnh" (`CR:57`); AC-25 cho gửi 25 ảnh (`CR:253`). `G003:301` BR05 "≤25MB (tối đa 5 ảnh × 5MB)", `G003:269` E05 ">25MB chặn" chưa cập nhật | Giới hạn tổng 25 MB và 5 ảnh của G003 hết hiệu lực cho luồng dán, hay hệ thống vẫn chặn theo logic đang chạy | (a) Theo CR: chỉ còn 5 MB/ảnh và 25 ảnh; 25 × 5 MB = 125 MB vẫn gửi. (b) G003 vẫn áp: 25 ảnh × 2 MB = 50 MB bị chặn — mâu thuẫn AC-25 | Có / không case tổng dung lượng; dữ liệu AC-25 (25 ảnh bao nhiêu MB); hồi quy popup Gửi Media còn 25 MB / 5 ảnh không; dạng thông báo (toast / popup) | BA Thảo (+ Dev) | Mở | | |
| Q-04 | **Trọng yếu** (hành vi) | AC-29 `CR:257` "theo cơ chế hiện tại… không gửi ảnh không hợp lệ"; `G003:268` E04 "báo lỗi ngay khi chọn file"; `G003:467` "Ảnh PNG/JPG" | Ảnh lỗi bị từ chối lúc dán hay vào danh sách rồi chặn lúc gửi; định dạng chấp nhận; nguyên văn lỗi | (a) Từ chối ngay khi dán, không có thumbnail, báo lỗi — căn cứ E04 "ngay khi chọn"; cùng kiểu với chặn ảnh thứ 26 lúc dán (`CR:84`). (b) Vào danh sách, chặn khi Gửi | Expected AC-29 (thumbnail có xuất hiện không); danh sách định dạng cho case âm (GIF, WebP, SVG, BMP, HEIC); ảnh 5,1 MB; ảnh lỗi có chiếm chỗ trong 25 không | BA Thảo / Dev | Mở | | |
| Q-05 | **Trọng yếu** (dữ liệu, có thể cô lập) | BR-20 `CR:101` "nội dung soạn đi cùng ảnh"; BR-22 `CR:103` "nội dung dài tự tách… kế thừa"; `CR-004:36` mốc 2.000; `CR:89` mô tả 2000 bytes | Một ảnh không mô tả + nội dung > 2.000 ký tự (hoặc > trần caption): tách thế nào | Tài liệu không nói. (a) Chuyển sang "tin nhắn riêng trước ảnh" như trường hợp có mô tả (`CR:116`) rồi tự tách; (b) caption bị cắt — không có căn cứ, chỉ là rủi ro | Nhóm case "nội dung dài + một ảnh không mô tả": số tin, không mất nội dung, Retry từng phần | BA Thảo / Dev | Mở | | |
| Q-06 | Không trọng yếu (hồi quy luồng icon) | `CR:16`, `CR:59` | Không có spec popup Gửi Media; tương tác giữa ảnh đã dán và popup; Ghi chú của popup hiển thị thế nào | Tài liệu không nói | Phạm vi hồi quy; case "đã dán 2 ảnh rồi bấm icon Gửi ảnh" ĐO & GHI | BA Thảo | Mở — cô lập | | |
| Q-07 | Không trọng yếu (cách dựng) | `CR:100`, `CR:133`, `CR:141`, AC-39 `CR:267`, AC-41 `CR:269`; `G009:95-98`, `G008:223-228` không có mention tự động | Spec mention tự động khi reply trong nhóm: ai được tag, có xóa được không | Tài liệu không nói | Dựng AC-39 / AC-41 | BA Thảo | Mở — cô lập | | |
| Q-08 | Không trọng yếu (một case) | `CR:132` "nội dung hợp lệ"; `CR:101` "ô soạn trống"; `CR:88` chỉ định nghĩa trống cho mô tả | Ô soạn chỉ khoảng trắng / xuống dòng khi gửi kèm ảnh | (a) Trống → chỉ gửi ảnh (tương tự BR-07). (b) Là nội dung → tin riêng / caption toàn khoảng trắng | Case "ô soạn chỉ khoảng trắng + ảnh" ❓ | BA Thảo | Mở — cô lập | | |
| Q-09 | Không trọng yếu | `CR:82`, `CR:84`, `CR:155`, `CR:252` | (i) Một lần Ctrl+V nhiều file; (ii) clipboard ảnh + văn bản; (iii) Ctrl+V ảnh khi focus ở trường Mô tả; (iv) còn k chỗ trống mà dán nhiều hơn k file: nhận k ảnh đầu hay từ chối hết | Tài liệu không nói; (iv) có thể suy tương tự BR-08 "chỉ nhận phần trong giới hạn còn lại" nhưng BR-08 nói về chữ, không phải ảnh | Case ĐO & GHI; dữ liệu AC-26 (dán 1 ảnh hay nhiều ảnh khi đã 25) | BA Thảo / Dev | Mở — cô lập | | |
| Q-10 | Không trọng yếu (hiển thị) | `CR:103`, AC-43 `CR:271`; `G036:157` BR24 | Ảnh lỗi trong cụm hiển thị và Thử lại ở đâu; vị trí sau khi gửi lại | Tài liệu không nói | Expected hiển thị AC-43 ĐO & GHI | BA Thảo | Mở — cô lập | | |
| Q-11 | Không trọng yếu | `CR:99`, `CR:63`, AC-23 `CR:251` | Nơi lưu nháp (trình duyệt / server); hai nhân viên chung tài khoản; "phiên" kết thúc khi nào; text ô soạn có giữ không | Tài liệu không nói | Dựng AC-23 (hai tab, hai user) | BA Thảo / Dev | Mở — cô lập | | |
| Q-12 | Không trọng yếu (ngoài phạm vi, cần hành vi) | `CR:48`, `CR:57`; `G003:306`, `G003:521`, `G003:317` | Ctrl+V khi ô soạn disable / không quyền gửi; ngắt kết nối sau khi đã dán | Tài liệu không nói | Case ĐO & GHI | BA Thảo | Mở — cô lập | | |
| Q-13 | Không trọng yếu (QA kiểm) | `CR:92`, `CR:96`, `CR:274`; `ESC:7` | Esc đóng modal có lan xuống hội thoại (thoát đoạn chat) không | CR cấm lan cho popup (`CR:96`); không nói cho modal | Case "Esc đóng modal → vẫn ở đoạn chat" ❓ | BA Thảo | Mở — cô lập | | |
| Q-14 | Không trọng yếu (hiển thị / chữ) | `CR:91`, `CR:172`, `CR:154`, `CR:84` | 8 ký tự đếm gì; xuống dòng trên dải; nút chuyển ảnh đầu / cuối ẩn hay disable; "1 ảnh"; chữ "**chỉ nên** gửi tối đa 25 ảnh/ lần" là khuyến nghị trong khi hành vi là chặn cứng | Tài liệu không nói | Text / trạng thái kỳ vọng vài case; text kỳ vọng AC-26/27 | BA Thảo | Mở — cô lập | | |
| Q-15 | Không trọng yếu | `CR:273`; `G003:83` | Có thiết lập phím gửi không | Tài liệu không nói | AC-45 kiểm bằng Enter hay thêm Ctrl+Enter | BA Thảo | Mở — cô lập | | |
| Q-16 | Không trọng yếu (hành chính) | `CR:5`; Change Log `CR:286-287`; `CR:207`, `CR:209`, `CR:218` | Mã CR; header không ghi version; Change Log v1.0.1 ghi "AC-46" nhưng dòng đổi là AC-45 (`CR:273`), AC-46 không đổi (`CR:274`); quyền xem Figma | — | Tên thư mục / trace tạm; trace AC đúng; CX review cần Figma | BA Thảo | Mở — ghi chú | | |
| Q-17 | **Trọng yếu** (ranh giới + dữ liệu) — mới ở v1.0.2 | BR-08 "tối đa **2000 bytes**… không cho nhập thêm **ký tự**" (`CR:89`); §6.2 (`CR:173`); AC-09 (`CR:237`); Change Log "giới hạn **ký tự**… Max 2000 bytes" (`CR:287`) | Đếm byte theo bảng mã nào; xử lý ký tự làm vượt; xuống dòng mấy byte; có bộ đếm cho người dùng không | (a) UTF-8: chữ Việt có dấu 2–3 bytes, emoji 4 bytes → ~700–1000 chữ Việt. (b) UTF-16: 2 bytes/ký tự → 1000 ký tự. (c) BA viết "bytes" nhưng ý là 2000 ký tự (Change Log dùng chữ "ký tự") — không có căn cứ, chỉ là khả năng | Expected AC-09[1][2][3]; cách dựng chuỗi 1999 / 2000 / 2001 bytes; case emoji / chữ có dấu / xuống dòng; so với mốc tách 2.000 ký tự (CR-004) | BA Thảo / Dev | Mở | | |

## 4. Cách hiểu đã thống nhất (Debate S4b)

### 4.1 Từ câu trả lời BA / tài liệu cập nhật

| # | Nhóm BR | Nội dung đã thống nhất | Nhãn | Từ câu hỏi | Ai xác nhận · ngày | Tài liệu đã cập nhật chưa |
| ---: | --- | --- | --- | --- | --- | --- |
| 1 | BR-01, BR-03, BR-16 | Một lần gửi tối đa 25 ảnh; chặn ngay khi dán ảnh thứ 26, thông báo giữa màn hình "Bạn chỉ nên gửi tối đa 25 ảnh/ lần"; giữ 25 ảnh, mô tả, nội dung; xóa bớt rồi thêm; kiểm lại ≤25 khi gửi | `[NGUỒN]` (`CR:82`, `CR:84`, `CR:97`, `CR:253-256`) | Q-01 | BA Thảo · 20/10/2026 · v1.0.1 | **Đã** — CR v1.0.1. G003 BR05 chưa (Q-03) |

### 4.2 Debate Hồng ↔ AI theo thứ tự BR (câu hỏi mở, Hồng nói trước, dò lại tài liệu từng dòng)

Bắt đầu 2026-10-20. Thứ tự dự kiến: BR-02 (xong 2026-10-21) → **BR-04 (đang)** → BR-05 → BR-06 → BR-07 → BR-09 → BR-12 → BR-13 →
BR-14 → BR-15 → BR-16 → BR-10 (trừ Q-14) → BR-11 (trừ Q-13) → BR-17 (trừ Q-08) → BR-19 (trừ Q-07) → BR-21 (trừ Q-07) → BR-01 (trừ
Q-04/09) → BR-03 (trừ Q-03) → BR-20 (trừ Q-02/05/08) → BR-22 (trừ Q-05/10) → BR-18 (trừ Q-11) → UI §6 → phần chờ BA (BR-08 Q-17,
và các Q còn lại).

**BR-02 — Giữ nội dung đang soạn (xong, 3 lượt)**

| # | Nội dung đã thống nhất | Nhãn | Dòng tài liệu đã dò | Ghi chú |
| ---: | --- | --- | --- | --- |
| D2-1 | Ctrl+V ảnh khi con trỏ đứng giữa đoạn chữ: **chữ hai bên giữ nguyên**, không bị thay thế, không bị chèn gì vào giữa — ảnh đi xuống khu vực đính kèm **bên dưới** ô soạn, không nằm trong dòng chữ. **Con trỏ vẫn nằm giữa** đúng chỗ cũ (Hồng và AI đọc như nhau nhưng tài liệu không có dòng nào nói về con trỏ). Cách dựng: gõ "abc def", đặt con trỏ sau "abc", Ctrl+V ảnh, gõ tiếp một ký tự để lộ vị trí con trỏ | `[NGUỒN]` (chữ không đổi, ảnh ở khu vực riêng) + `[GIẢ ĐỊNH]` (con trỏ vẫn ở giữa — kiểm ĐO & GHI, không phải căn cứ pass/fail) | `CR:83` "Dán ảnh không thay thế nội dung tại ô soạn tin"; `CR:159` Ô soạn tin "Giữ giá trị hiện tại… Dán ảnh không thay thế nội dung đang soạn"; `CR:153` khu vực ảnh đính kèm "hiển thị bên dưới ô soạn tin"; AC-03 `CR:231`. Grep "con trỏ" trong CR chỉ ra `CR:156` (con trỏ chuột trên icon) | Hồng nói trước: "vẫn nằm giữa". Không nâng thành câu hỏi BA: không đổi hành vi nghiệp vụ; nếu con trỏ nhảy về cuối thì ghi nhận là Usability cho CX review |
| D2-2 | Bằng chứng "@mention đã chọn" còn là mention sau khi mở modal / Lưu / Hủy / xóa ảnh rồi Gửi: (1) trong tin đã gửi, tag @Lan **được highlight (màu xanh)**; (2) **Lan nhận browser push notification** riêng, kể cả khi Lan đang tắt thông báo hội thoại; (3) tin được đánh dấu **liên quan** tới Lan trong danh sách hội thoại của Lan. Trước khi gửi: tag trong ô soạn vẫn hiển thị dạng tag như lúc chèn — tài liệu chỉ nói "tag được chèn", không mô tả hình dạng, nên kiểm ĐO & GHI. Cách dựng: Lan đăng nhập trình duyệt khác, đã **tắt thông báo** hội thoại (để kiểm override BR19) | `[NGUỒN]` (highlight, push notification, đánh dấu liên quan) + `[QA BỔ SUNG]` (hình dạng tag trong ô soạn trước khi gửi — ĐO & GHI) | `G008:228` "tin hiển thị trong khung chat với tag @mention được highlight; gửi browser push notification riêng đến người được mention — kể cả khi họ đang tắt thông báo"; `G008:304` BR19 đánh dấu liên quan; `G008:226` tag chèn vào ô soạn; `CR:100` BR-19 "gửi đi giữ đúng thành viên được nhắc và chức năng mention"; `CR:83` | Hồng nói trước: "khi gửi đi, @Lan sẽ xanh và Lan nhận được thông báo" — khớp `G008:228`. AI thêm (3) và điều kiện tắt thông báo để một case kiểm được cả BR19. Mention tự động khi reply để lại Q-07 |
| D2-3 | Sau mỗi thao tác (dán ảnh, mở modal, Lưu, Hủy / Huỷ mô tả, xóa một ảnh, Xóa tất cả) khi đang trả lời: (1) **không tự gửi** — không có tin mới nào xuất hiện trong khung chat, nội dung ô soạn và ảnh đính kèm vẫn ở trạng thái soạn; (2) **trạng thái trả lời còn nguyên** — **quote preview của tin gốc vẫn hiển thị phía trên ô nhập**, kèm icon X; chỉ khi user tự bấm X thì mới về soạn tin thường. Hai bằng chứng độc lập, kiểm cả hai | `[NGUỒN]` | `CR:83` "không tự hủy trạng thái đang trả lời tin nhắn và không tự gửi tin"; `CR:128` "Dán ảnh không tự hủy trạng thái trả lời"; `CR:141` "user chủ động đóng vùng trả lời"; `G009:96` "preview quote của tin nhắn gốc trong ô soạn thảo (block quote thu gọn phía trên input)"; `G009:303` "Icon X trong quote preview để hủy reply"; AC-03 `CR:231`, AC-21 `CR:249` | Hồng nói trước: "tin nhắn đang soạn vẫn giữ nguyên, không có tin nào được gửi đi" — đủ cho (1). AI bổ sung (2): chỗ nhìn là quote preview + icon X theo G009 |

BR-02 **xong**.

**BR-04 — Mô tả riêng của từng ảnh (đang debate)**

| # | Nội dung đã thống nhất | Nhãn | Dòng tài liệu đã dò | Ghi chú |
| ---: | --- | --- | --- | --- |
| D4-1 | Ô soạn đã có chữ, mở modal của ảnh **chưa có mô tả**: trường mô tả **trống**, không ký tự nào, không mang chữ của ô soạn sang; hiện placeholder nguyên văn **"Nhập mô tả cho ảnh"** (tiêu đề modal là "Nhập mô tả" — hai chuỗi khác nhau, kiểm đúng từng chỗ); nút Lưu **disable**. Cách dựng: gõ sẵn nội dung ở ô soạn rồi dán ảnh, mở modal bằng cả icon chỉnh sửa và click thumbnail | `[NGUỒN]` | `CR:85` "Không tự sao chép nội dung ô soạn tin vào mô tả ảnh"; `CR:173` Default "Mô tả đã lưu của ảnh nếu có", "Placeholder **Nhập mô tả cho ảnh**"; `CR:169` tiêu đề "Nhập mô tả"; `CR:174` Lưu "Chưa nhập mô tả… disable"; AC-04 `CR:232` "chưa có thì để trống"; AC-06 `CR:234` | Hồng nói trước: "trống, không có ký tự gì, có placeholder Nhập mô tả" — khớp; AI chỉnh chữ placeholder theo `CR:173` là "Nhập mô tả cho ảnh" và thêm trạng thái nút Lưu |

## 5. Các cách hiểu khác nhau còn tồn tại

Q-02, Q-03, Q-04, Q-08, Q-17 — hai cách hiểu có căn cứ, xem bảng. Q-05, Q-06, Q-07, Q-09 → Q-15 — tài liệu không nói:
**Unresolved / BA Clarification Required**. Q-01 — đã đóng theo v1.0.1.

## 6. Điểm đã thống nhất và điểm còn mở

- Đã thống nhất: Q-01 (tài liệu v1.0.1).
- Còn mở — **trọng yếu** (đề xuất): Q-02, Q-03, Q-04, Q-05, Q-17.
- Còn mở — không trọng yếu (cô lập): Q-06 → Q-16.

## 7. Cần BA xác nhận

Nội dung gửi BA Nguyễn Thị Phương Thảo: `cau-hoi-gui-BA.md` cùng thư mục (đã cập nhật theo v1.0.2).

## 8. Ngoài phạm vi / chưa có căn cứ

- Theo `CR:61-65`: luồng icon Gửi ảnh (vẫn popup Gửi Media); dán video / âm thanh / tệp / kéo thả; chỉnh sửa ảnh nguồn; đổi thứ tự bằng kéo thumbnail (AC-20 chỉ kiểm "không đổi"); bản nháp qua tải lại trang / đóng trình duyệt / thiết bị khác.
- Mobile / app Gopany: CR chỉ áp dụng desktop (`CR:48`).
- Hành vi trên Zalo app / Zalo web của người nhận: CR không mô tả; chỉ kiểm được gián tiếp (cụm ảnh là mấy tin — Q-02).
- Giới hạn tổng dung lượng: CR v1.0.1 đã gạch; không còn là yêu cầu của CR (Q-03 chỉ hỏi G003 còn hiệu lực không).
- Tài liệu không nói: xem Q-05 → Q-15.

## 9. Change Proposal / New Requirement Candidate `[ĐỀ XUẤT THAY ĐỔI]`

Chưa có.

## 10. QA coverage bổ sung dự kiến `[QA BỔ SUNG]`

- Dữ liệu ảnh: PNG / JPG, ảnh chụp màn hình (bitmap từ clipboard), ảnh dọc / ngang / vuông, ảnh có EXIF xoay, ảnh rất nhỏ (1×1), ảnh trùng nhau dán hai lần; GIF / WebP / SVG / BMP / HEIC cho case âm (Q-04).
- Số lượng: 1 / 2 / 24 / 25 / 26 ảnh; dán một lần 3 ảnh khi còn 2 chỗ (Q-09 iv); xóa về 24 rồi dán lại; Xóa tất cả ở 25 rồi dán 25 lần nữa; dải thumbnail 25 ảnh cuộn ngang; modal chuyển qua 25 ảnh.
- Dung lượng từng ảnh: 4,9 / 5,0 / 5,1 MB (G003 BR04); 25 ảnh × ~4,9 MB để quan sát upload lớn (Q-03).
- Mô tả (bytes, Q-17): chuỗi ASCII 1999 / 2000 / 2001 bytes; chữ Việt có dấu, emoji, ký tự ghép; chỉ khoảng trắng; có xuống dòng; dán chuỗi dài vào trường trống và vào trường còn vài byte; khoảng trắng đầu / cuối (trim?); so hiển thị 8 ký tự trên thumbnail với chuỗi nhiều byte.
- Modal: chuyển ảnh bằng thumbnail và nút; sửa A, sang B, sang C, về A; sửa rồi trả về đúng giá trị cũ; gỡ A + thêm B rồi Hủy; mở modal từ icon và từ thumbnail; Esc nhiều lần.
- Reply: reply tin của khách / của mình / tin ảnh / tin đã có reply (nested, G009 BR07); reply rồi tin gốc bị thu hồi trong lúc soạn (G009 BR06) khi đang có ảnh đính kèm.
- Mention: @[tên], @all, nhiều mention, mention tự động + xóa mention; hội thoại 1-1 không có mention (G008 OOS06).
- Gửi: Enter, nút Gửi; gửi khi modal mở (không gửi); gửi liên tiếp hai lần nhanh; chuyển hội thoại trong lúc đang gửi 25 ảnh.
- Hồi quy: icon Gửi ảnh vẫn mở popup và còn chặn 25 MB / 5 ảnh hay không (Q-03, Q-06); dán văn bản; dán link (G015 thumbnail); gộp cụm tin G036 BR01 giữa tin riêng và ảnh; trạng thái gửi một ô (G036 BR24); trình xem ảnh (CR-ANH-VIEWER) với cụm 25 ảnh; Esc trong chat (ESC).
- Màn hẹp 390–1600px (G036 BR28): dải thumbnail cuộn ngang, cụm ảnh co theo khung.

## 11. Xác nhận mở cổng

- [ ] Điểm trọng yếu còn mở = 0 (hiện 5: Q-02, Q-03, Q-04, Q-05, Q-17 — chờ BA Thảo)
- [ ] Debate S4b đã đi hết các BR (mục 4.2 có nội dung)
- [ ] Hồng đã chốt mức các Q
- Người dùng xác nhận: —

## Lịch sử cập nhật

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
| 2026-10-20 | AI (Orchestrator) | Tạo bản đầu sau Requirement Analysis theo CR bản (1): 16 câu, 5 đề xuất trọng yếu (Q-01 số ảnh tối đa, Q-02 cụm ảnh, Q-03 ranh giới 25 MB, Q-04 ảnh lỗi khi dán, Q-05 nội dung dài + một ảnh), cổng đóng |
| 2026-10-20 | AI (Orchestrator) | Mở debate S4b lượt 1 BR-02 (câu hỏi về vị trí con trỏ khi dán giữa đoạn chữ) — chờ Hồng |
| 2026-10-21 | AI (Orchestrator) — Hồng chuyển CR bản (3) v1.0.2 | Dịch mọi `CR:n` sang bản (3); Q-01 **đóng** theo v1.0.1 (25 ảnh), ghi mục 4.1; Q-03 viết lại (CR bỏ tổng 25 MB ↔ G003 BR05/E05); thêm **Q-17** đơn vị 2000 bytes (trọng yếu); bổ sung Q-09 (iv), Q-14 (chữ "chỉ nên"), Q-16 (Change Log dẫn nhầm AC-46); mục 10 đổi dữ liệu dung lượng → số lượng và bytes. Trọng yếu còn mở: 5 |
| 2026-10-21 | Hồng (QA) + AI | Debate S4b BR-02 lượt 1: D2-1 (dán giữa đoạn chữ — chữ giữ nguyên `[NGUỒN]`, con trỏ ở giữa `[GIẢ ĐỊNH]`) |
| 2026-10-21 | Hồng (QA) + AI | Debate S4b BR-02 lượt 2: D2-2 (bằng chứng mention còn là mention: highlight + push notification + đánh dấu liên quan `[NGUỒN]`; hình dạng tag trước gửi ĐO & GHI) |
| 2026-10-21 | Hồng (QA) + AI | Debate S4b BR-02 lượt 3: D2-3 (không tự gửi: không tin mới; trạng thái trả lời: quote preview + icon X theo G009:96/303). **BR-02 xong**; sang BR-04 |
| 2026-10-21 | Hồng (QA) + AI | Debate S4b BR-04 lượt 1: D4-1 (modal ảnh chưa có mô tả mở ra trống, placeholder "Nhập mô tả cho ảnh", Lưu disable; không sao chép ô soạn) |
