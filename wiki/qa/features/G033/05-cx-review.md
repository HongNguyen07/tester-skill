---
featureId: G033
basedOn: 02-alignment-summary.md (gate: open, 2026-10-19, mở bởi Hồng (QA))
reviewedAt: 2026-10-19
modes: [1, 3]              # 1 = UI/UX/CX Review · 3 = Customer Journey Review (chỉ ở mức phân tích tài liệu)
evidenceLevel: phân tích tài liệu
reviewer: Customer Experience Agent (AI) — người dùng: Hồng (QA)
---

# CX Review — G033: Màn Link nhóm — mời bằng QR hoặc link

> **Mode đã chạy:** Mode 1 (UI/UX/CX Review từ tài liệu đã alignment + mockup ASCII §10A → §10G) và Mode 3 (Customer
> Journey Review) — **cả hai chỉ ở mức phân tích tài liệu**. **Không chạy Mode 2** (Customer Simulation): G033 không có
> file design Figma / prototype; phiên này không có sản phẩm hay công cụ thao tác. **Mức bằng chứng của mọi finding:
> phân tích tài liệu.** Không finding nào được xếp **Defect**; mọi nhận định về hành vi và cảm nhận thực tế là
> `[CX GIẢ THUYẾT]` / "rủi ro giả định". Không có câu nào trong file này nói "đã thao tác" / "đã quan sát".

Viết tắt: `G033:nn` = `tailieu/G033 - Màn Link nhóm (1).md` dòng nn; `G008`, `G026`, `G003` tương tự. `Q-nn` = câu hỏi
trong `02-alignment-summary.md` §3; `D-nn` = kết quả debate S4b trong `02-…` §4; "xác nhận #1–#4" = bốn câu trả lời BA
(Q-01 → Q-04) ở `02-…` §4.

## 1. Phạm vi và nguồn đã xem

| # | Nguồn (tài liệu / design / prototype / sản phẩm) | Phạm vi | Cách xem |
| ---: | --- | --- | --- |
| 1 | `tailieu/G033 - Màn Link nhóm (1).md` (v1.0, Draft, 2026-10-02) | Toàn bộ 601 dòng: §1–§16, mockup ASCII §10B / §10D / §10F / §10G, AC, OOS, OQ, lưu ý cho AI | Đọc tài liệu |
| 2 | `wiki/qa/features/G033/02-alignment-summary.md` | Toàn bộ: §2, §3 (Q-01 → Q-22), §4 (xác nhận #1–#4, D-01 → D-22), §5–§11 | Đọc tài liệu |
| 3 | `wiki/qa/features/G033/01-requirement-analysis.md` | §1–§4 (nguồn đã đọc, actor, UC) | Đọc tài liệu |
| 4 | `tailieu/G008 - Quản lý nhóm.md` (v1.1) | AF01 (`G008:238-242`), E05 (`G008:268`), BR02 / BR06 / BR15 (`G008:287`, `G008:292`, `G008:300`), §10C (`G008:390`, `G008:395`), AC (`G008:455`) | Đọc các dòng tìm theo từ khoá |
| 5 | `tailieu/G026 - Cài đặt nhóm (1).md` (v1.0) | §1 (`G026:19`), UC-06 (`G026:88-93`), BR01 / BR04 / BR08 / BR06 (`G026:128`, `G026:131-132`, `G026:135`), mockup (`G026:157`) | Đọc các dòng tìm theo từ khoá |
| 6 | `tailieu/G003 - Chat.md` (v1.11) | UC-08 (`G003:201-214`), E09 (`G003:273`), BR21 / BR23 / BR27 (`G003:317`, `G003:319`, `G003:323`), §10G (`G003:531-542`), AC (`G003:623-634`) | Đọc các dòng tìm theo từ khoá |
| 7 | `wiki/qa/features/G036/05-cx-review.md` | Định dạng tham chiếu | Đọc tài liệu |

**Giới hạn:**

- Không có design, prototype, sản phẩm hay công cụ thao tác → **không chạy Mode 2**; không có screenshot / log; thư mục
  `evidence/` không được tạo.
- Mọi nhận định về kích thước, màu, độ tương phản, vị trí nút, cảm giác khi dùng là suy luận từ câu chữ và mockup ASCII,
  **chưa quan sát thực tế**.
- Không có dữ liệu người dùng thật (số nhân sự, tần suất gửi link, thiết bị) → persona chỉ dựa vào câu chữ của nguồn
  hoặc ghi rõ là giả thuyết.
- Phần trên app Zalo của người nhận (màn xem trước, nút *Tham gia*, thông báo link chết) là OOS03 — chỉ nêu **tác động
  ngược lại nhân sự**, không review màn của Zalo.
- Các điểm không trọng yếu còn mở (Q-05 → Q-17, Q-19 → Q-22) **không tự chọn cách hiểu**; finding chạm tới ghi
  "phụ thuộc Q-nn". BR09 nhóm đầy ngoài phạm vi chạy (D-13) — chỉ nêu rủi ro, không viết kịch bản.
- Chưa đọc G011, G001, G002, G015, G016 / G018 và phần còn lại của G008 / G026 / G003.

## 2. Persona

| Persona | Nhóm khách hàng · bối cảnh | Mục tiêu | Căn cứ |
| --- | --- | --- | --- |
| P1 | **Nhân sự CSKH có quyền "Quản lý nhóm", quản nhiều nhóm khách**, gửi link cho khách ở xa, thường gửi nhiều người cùng lúc | Lấy đúng link của đúng nhóm, gửi đi nhanh, biết trước khách sẽ gặp gì | `G033:19` "gửi link khi ở xa"; `G033:32`; `G033:188` "Gửi link cho nhiều người cùng lúc đúng là việc CSKH hay làm"; `G033:195` "nhân sự quản nhiều nhóm, link nhóm nào cũng là một chuỗi ký tự vô nghĩa giống nhau" |
| P2 | **Admin / Owner** — ít thao tác hằng ngày, là người đổi / huỷ link khi link bị lộ | Đổi / huỷ đúng nhóm, hiểu hậu quả trước khi bấm | `G033:32`; `G033:198` lý do BR17 |
| P3 | **Nhân sự gặp khách trực tiếp, dùng mã QR** (đưa màn điện thoại cho khách quét, in QR, chèn slide / email) | Khách quét được ngay; QR đã in còn dùng được | `G033:19` "quét QR khi gặp trực tiếp"; `G033:189` "gửi email, chèn slide hay in ra"; `G033:194` mobile lưu thư viện ảnh |
| P4 | **Nhân sự đã quen hành vi cũ của nút *Mời qua link*** (bấm → đã copy, dán ngay) | Làm như cũ mà không bị hụt | `G008:300` BR15 cũ; `G033:563` "Breaking change"; `G033:564` ❷ |
| P5 | **Khách được mời** — người ngoài, dùng app Zalo trên điện thoại; không phải actor của Gopany | Bấm link / quét QR rồi vào nhóm; nếu chưa vào được thì biết vì sao | `G033:192` BR10; `G033:195` "Khách nhận một đường link trần thường không dám bấm"; `G033:190` "khách quét xong tưởng hỏng rồi hỏi ngược" |
| P6 | **Nhân sự dùng tài khoản Zalo đã gán nhưng tài khoản đó chỉ là thành viên thường của nhóm** (không phải trưởng nhóm trên Zalo) | Lấy link / tạo link như người khác; khi bị từ chối thì biết phải làm gì | `G033:186` BR04 "Vai trò trên Zalo không phải điều kiện của Gopany"; `G033:197` "thành viên thường bấm sẽ bị Zalo từ chối → E08"; xác nhận #2 (chỉ có trưởng nhóm) |
| P7 | **Nhân sự mới, chưa quen Zalo và chưa quen hệ thống** — **persona giả thuyết phục vụ review**: nguồn không nhắc nhóm này | Hiểu màn, nút, hộp xác nhận mà không cần được giải thích | Giả thuyết |
| P8 | **Nhân sự dùng mạng chậm / không ổn định** — **persona giả thuyết phục vụ review**: nguồn có E05 và trạng thái "đang xử lý" (`G033:170`, `G033:358`, `G033:408`) nhưng không nói ai, khi nào | Biết thao tác đang chạy, xong hay hỏng | Phạm vi: `G033:170`, `G033:358`, `G033:408`; người dùng: giả thuyết |

## 3. Hành trình đã review

Mode 3 ở mức phân tích tài liệu: cột "phản hồi hệ thống" lấy từ nguồn; chỗ nguồn im lặng ghi `[CX GIẢ THUYẾT]`.

| Hành trình | Persona | Mục tiêu → các bước → phản hồi hệ thống → kết quả cuối → cách phục hồi | Nguồn |
| --- | --- | --- | --- |
| J1 — Lấy link từ panel, dán gửi khách | P1 | **Mục tiêu:** có link nhóm để dán vào tin cho khách. **Bước:** mở hội thoại nhóm → panel → dòng *Link nhóm* → màn §10B → *Sao chép link*. **Phản hồi:** màn hiện avatar + tên nhóm · câu hướng dẫn · QR · link chữ · ba nút; dòng nhắc nếu nhóm bật duyệt; toast *"Đã copy link nhóm"*. **Kết quả:** link trong clipboard. **Phục hồi:** DISCONNECTED → toast E02, không mở màn; Zalo không trả → E03 + *Thử lại*. `[CX GIẢ THUYẾT]` nhân sự đọc hay bỏ qua dòng nhắc duyệt trước khi dán link cho khách (CX-04). | UC-01 `G033:57-63`; §10B `G033:247-275`; §10C `G033:279-286`; E02 / E03 `G033:167-168` |
| J2 — Chia sẻ link vào nhiều hội thoại | P1 | **Mục tiêu:** gửi link cho nhiều khách một lượt. **Bước:** *Chia sẻ link* → màn §10D (hộp chọn G003 UC-08 + thẻ xem trước + dòng tin kèm) → chọn tới 99 → sửa dòng tin → *Gửi (n)*. **Phản hồi:** toast *"Đã gửi link nhóm"*; tin tới dạng thẻ. **Kết quả:** mỗi hội thoại nhận một tin. **Phục hồi:** E05 / E06 toast. `[CX GIẢ THUYẾT]` sau *Gửi* màn chia sẻ có đóng không (Q-14), gửi lỗi một phần thì biết tới đâu (CX-12); bộ lọc tài khoản khoá hay ẩn (Q-20, CX-13). | UC-02 `G033:67-72`; §10D `G033:290-322`; xác nhận #4; `G003:213-214`, `G003:273` |
| J3 — Lấy QR khi gặp khách trực tiếp / in QR | P3 | **Mục tiêu:** khách đứng trước mặt quét được; hoặc có file để in. **Bước:** mở màn trên điện thoại → đưa QR cho khách quét; hoặc *Lưu mã QR* → PNG `QR - {tên nhóm}.png`. **Phản hồi:** ảnh vào thư viện (mobile) / thư mục tải về (Web); toast E07 nếu tải lỗi. **Kết quả:** khách thấy màn xem trước trên Zalo → *Tham gia*. **Phục hồi:** bấm lại *Lưu mã QR*. `[CX GIẢ THUYẾT]` QR trên popup Web ~420px có quét được ở khoảng cách thực tế không — nguồn không nói kích thước (CX-15); QR đã in chết khi ai đó đổi link mà không có cách nào biết (CX-09). | UC-03 `G033:76-79`; BR07 `G033:189`; BR13 `G033:194`; E07 `G033:172`; OOS01 `G033:503` |
| J4 — Nhóm chưa có link → Tạo ngay | P1, P6, P7 | **Mục tiêu:** có link cho nhóm mới. **Bước:** mở màn → §10F (hai icon, câu mời, *Tạo ngay*) → bấm. **Phản hồi:** nút sang trạng thái đang xử lý; Zalo trả → màn đổi tại chỗ sang §10B + toast *"Tạo link thành công"*; Zalo từ chối → toast E08, giữ §10F. **Kết quả:** có link / không có. **Phục hồi:** bấm lại hoặc "làm trên app Zalo". `[CX GIẢ THUYẾT]` §10F không có tên nhóm → tạo cho nhóm nào (CX-03); E08 với P6 không nói phải làm gì cụ thể (CX-07); chờ bao lâu thì thôi (CX-10). | UC-04 `G033:83-88`; §10F `G033:334-361`; BR16 `G033:197`; E08 `G033:173` |
| J5 — Đổi / huỷ link | P2, P1 | **Mục tiêu:** vô hiệu link đã lộ hoặc dọn link không dùng. **Bước:** `•••` → *Đổi link nhóm* / *Huỷ link nhóm* → hộp xác nhận → *Đổi link* / *Huỷ link*. **Phản hồi:** link + QR mới và toast *"Đã đổi link nhóm"*, hoặc về §10F và toast *"Đã huỷ link nhóm"*; link cũ chết ngay. **Kết quả:** link cũ vô hiệu, người giữ link cũ không được báo. **Phục hồi:** không gỡ lại được (OOS02); huỷ xong tạo lại được bằng *Tạo ngay* nhưng là link khác. `[CX GIẢ THUYẾT]` hai nút "Huỷ" / "Huỷ link" cạnh nhau (CX-08); câu hậu quả không nhắc QR đã in (CX-09). | UC-05 / UC-06 `G033:92-108`; §10G `G033:365-410`; BR17 `G033:198`; OOS02 `G033:504` |
| J6 — Từ màn Thêm thành viên → *Mời qua link* | P4 | **Mục tiêu:** như trước: bấm là có link để dán. **Bước:** *Thêm thành viên* → *Mời qua link*. **Phản hồi (mới):** mở màn Link nhóm, **không** copy; đóng màn → về lại Thêm thành viên. **Kết quả:** phải bấm thêm *Sao chép link*. **Phục hồi:** N/A. `[CX GIẢ THUYẾT]` nhân sự quen tay đóng màn rồi dán → dán nhầm nội dung cũ trong clipboard (CX-01); trên Web popup chồng lên Thêm thành viên ở trạng thái nào (Q-15, CX-02). | AF06 `G033:156`; BR01 `G033:183`; `G033:563-564`; xác nhận #1; `G008:241-242`, `G008:300` |
| J7 — Khách nhận link / quét QR → Zalo → *Tham gia* → chờ duyệt → hỏi nhân sự | P5, P1 | **Mục tiêu (khách):** vào nhóm. **Bước:** bấm link / quét QR → app Zalo mở màn xem trước → *Tham gia* → nhóm bật duyệt: vào hàng chờ (G026 UC-06); tắt: vào thẳng. **Phản hồi phía Gopany:** người chờ hiện ở *Cài đặt nhóm → Duyệt thành viên* (badge), chỉ trưởng nhóm duyệt. **Kết quả:** khách chờ; nếu không ai duyệt, khách hỏi nhân sự "bấm link rồi sao chưa vào nhóm". **Phục hồi:** nhân sự phải biết BR08 / BR10 để trả lời và đi duyệt. `[CX GIẢ THUYẾT]` thông tin "sẽ chờ duyệt" không đi theo tin gửi cho khách (CX-04); thông điệp §16 không báo nhân sự về bước *Tham gia* / chờ duyệt (CX-18); dòng nhắc không dẫn tới chỗ duyệt (CX-05). Phần màn Zalo là OOS03, không review. | BR10 `G033:192`; BR08 `G033:190`; D-05; `G026:88-93`, `G026:131-132`, `G026:157`; §16 `G033:564` |

## 4. Tổng hợp finding

| ID | Loại | Tóm tắt | Persona | Impact | Mức bằng chứng | Trace (BR / UC / case) |
| --- | --- | --- | --- | --- | --- | --- |
| CX-01 | CX Risk (rủi ro giả định) | Nút *Mời qua link* đổi hành vi (copy → mở màn); không có dấu hiệu trên màn báo "chưa copy"; toast cũ và mới cùng chuỗi *"Đã copy link nhóm"* | P4 | Trung bình — dán nhầm nội dung cũ trong clipboard cho khách | Phân tích tài liệu | BR01, AF06, §16; AC `G033:418` |
| CX-02 | Usability Issue | Trên Web, popup Link nhóm mở từ trong giao diện Thêm thành viên: lớp nào đang hiện, đóng về trạng thái nào — tài liệu chưa nói | P1, P4 | Thấp–Trung bình | Phân tích tài liệu | AF06, AF08, BR13, §10E; Q-15 |
| CX-03 | Usability Issue | Màn §10F không có avatar / tên nhóm; *Tạo ngay* không hộp xác nhận → nhân sự quản nhiều nhóm có thể tạo link cho nhầm nhóm, nhất là mobile toàn trang | P1, P3, P7 | Trung bình | Phân tích tài liệu | BR15, BR16, §10F; AC `G033:448-453` |
| CX-04 | CX Risk (rủi ro giả định) | Dòng nhắc "chờ trưởng nhóm duyệt" chỉ nằm trên màn Link nhóm; không đi theo màn chia sẻ, thẻ xem trước hay tin gửi cho khách → khách chờ không biết, hỏi ngược nhân sự. Cùng cơ chế với cảnh báo nhóm đầy (ngoài phạm vi chạy, D-13) | P1, P5 | Cao — đúng rủi ro tài liệu tự nêu ở BR08 / BR10 | Phân tích tài liệu | BR08, BR09, BR10, BR14, §10C, §10D |
| CX-05 | Improvement Suggestion | Dòng nhắc duyệt không dẫn tới nơi duyệt (G026 *Duyệt thành viên*) và không nói ai phải làm gì tiếp | P1, P2 | Thấp | Phân tích tài liệu | BR08, §10C; `G026:88-93`, `G026:132` |
| CX-06 | CX Risk (rủi ro giả định) | Nếu Zalo chặn thành viên thường xem link (Q-07) → P6 gặp E03 *"Không lấy được link nhóm. Vui lòng thử lại."* + *Thử lại* — thử lại mãi không ra, thông điệp không nói nguyên nhân | P6 | Trung bình — phụ thuộc Q-07 | Phân tích tài liệu | BR04, E03, OQ02; Q-07 |
| CX-07 | Usability Issue | Toast E08 *"… Vui lòng kiểm tra lại trên app Zalo"* không nói kiểm tra gì; P6 thường không cầm điện thoại của tài khoản Zalo đó; nút *Tạo ngay* hiện với mọi người có quyền nhưng chỉ Zalo biết ai tạo được | P6, P7 | Trung bình | Phân tích tài liệu | BR16, BR17, E08; Q-12 |
| CX-08 | CX Risk (rủi ro giả định) | Hộp *"Huỷ link nhóm?"*: nút thoát **Huỷ** đứng cạnh nút xác nhận **Huỷ link** — hai nút cùng bắt đầu bằng "Huỷ" cho một hành động không gỡ lại được | P1, P2, P7 | Cao — bấm nhầm làm chết link đã phát | Phân tích tài liệu | BR17, UC-06, AF07, §10G `G033:400` |
| CX-09 | CX Risk (rủi ro giả định) | Câu hậu quả trong hai hộp xác nhận chỉ nói "link cũ"; không nhắc **mã QR đã lưu / đã in** cũng chết theo (OOS01) | P3, P2 | Trung bình–Cao với nhóm đã in QR | Phân tích tài liệu | BR17, OOS01, §10G `G033:384-386`, `G033:396-398` |
| CX-10 | Usability Issue | Trạng thái "đang xử lý" khi chờ Zalo: không mô tả hình thức, không có mốc thời gian tối đa cho tạo / đổi / huỷ (§15 chỉ có mốc mở màn), không nói Esc / click nền mờ lúc đang xử lý | P8, P1 | Trung bình | Phân tích tài liệu | BR16, BR17, §10F `G033:358`, §10G `G033:408`, §15; Q-11 |
| CX-11 | Usability Issue | Màn chia sẻ: dòng tin kèm trong mockup bị cắt *"Truy cập link để tham gia..."*, không nói giới hạn ký tự; xoá trắng → gửi link trần — điều tài liệu tự nhận là khách "không dám bấm" — mà không nhắc gì | P1, P5 | Thấp–Trung bình | Phân tích tài liệu | BR14, §10D `G033:308`, `G033:319`; AC `G033:443`; Q-13 |
| CX-12 | CX Risk (rủi ro giả định) | Gửi tới nhiều hội thoại: chỉ một toast *"Đã gửi link nhóm"*; gửi lỗi một phần thì nhân sự không biết tới ai; sau *Gửi* màn có đóng không (Q-14) | P1 | Trung bình | Phân tích tài liệu | BR06, UC-02 b4; `G003:213-214`, `G003:273`; Q-14 |
| CX-13 | Usability Issue | Bộ lọc tài khoản Zalo: hộp chọn dùng lại của Chuyển tiếp (đổi được, `G003:205`) nhưng ở đây không đổi được (xác nhận #4). Khoá → nhân sự quen popup Chuyển tiếp tưởng lỗi; ẩn → khác popup gốc | P1 | Thấp–Trung bình — phụ thuộc Q-20 | Phân tích tài liệu | BR06, §10D; xác nhận #4; Q-20 |
| CX-14 | CX Risk (rủi ro giả định) | Link đổi / huỷ trên app Zalo khi màn đang mở → màn "cập nhật ngay" không có toast → link đổi dưới tay nhân sự đang đọc / sắp copy mà không biết | P1 | Trung bình | Phân tích tài liệu | §7 `G033:223`; AC `G033:470`; Q-22 |
| CX-15 | Improvement Suggestion | Quét QR trực tiếp từ màn hình (popup Web ~420px, màn điện thoại): tài liệu không nói kích thước tối thiểu của QR; logo Zalo ở giữa (nhánh Q-05) | P3 | Thấp — ĐO & GHI | Phân tích tài liệu | BR02, §10B `G033:273`, §10E; Q-05 |
| CX-16 | Usability Issue | *Chia sẻ link* trên mobile mở danh sách hội thoại trong hệ thống, không phải bảng chia sẻ của máy — khác kỳ vọng phổ biến của nút "Chia sẻ"; hai nút *Sao chép link* / *Chia sẻ link* cùng chữ "link" dòng dưới | P7, P3 | Thấp | Phân tích tài liệu | BR05, BR06, BR13 `G033:194`, §10B `G033:261-263` |
| CX-17 | Improvement Suggestion | Chuỗi toast không cùng giọng: *"Đã copy link nhóm"* (Anh–Việt) · *"Tạo link thành công"* · *"Đã gửi / đổi / huỷ link nhóm"* | P7 | Thấp | Phân tích tài liệu | UC-01 → UC-06 toast; D-21 |
| CX-18 | CX Risk (rủi ro giả định) | Thông điệp §16 cho nhân sự có bốn việc nhưng không có việc tài liệu tự nói "nhân sự CSKH phải nắm": khách phải bấm *Tham gia* trên màn xem trước và có thể phải chờ duyệt | P1, P5 | Trung bình–Cao | Phân tích tài liệu | BR08, BR10, §16 `G033:564` |

Số lượng theo loại: **Defect 0 · Usability Issue 7 · CX Risk 8 · Improvement Suggestion 3** (tổng 18).

## 5. Chi tiết finding

### CX-01 — Nút *Mời qua link* đổi hành vi: không có dấu hiệu "chưa copy", toast cũ và mới trùng chuỗi

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-01 |
| Review scope | Lối vào thứ hai (màn *Thêm thành viên* → *Mời qua link*) và màn §10B |
| Source evidence | `G033:156` AF06 "bấm **Mời qua link** → **mở đúng màn Link nhóm này**, không copy thẳng vào clipboard"; `G033:563` "Breaking change … Thao tác cũ vẫn làm được — thêm một lần bấm *Sao chép link*"; `G033:564` ❷; `G033:63` toast mới *"Đã copy link nhóm"*; `G008:242` hành vi cũ "copy vào clipboard → Toast: *"Đã copy link nhóm"*"; xác nhận #1 |
| Persona và context | P4 — nhân sự quen bấm *Mời qua link* rồi dán ngay; có căn cứ `G033:563-564` |
| Customer journey / scenario | J6 — đang ở màn Thêm thành viên, cần link để dán cho khách |
| Observation | `[NGUỒN]` Hành vi đổi từ "bấm là đã copy" sang "bấm mở màn, phải bấm thêm *Sao chép link*". `[CX GIẢ THUYẾT]` Nhân sự quen tay bấm *Mời qua link* → thấy màn mở → đóng (✕ / Esc) → dán: clipboard là nội dung cũ, không phải link nhóm; trên màn không có gì nói "link chưa được copy". `[CX GIẢ THUYẾT]` Vì toast sau khi bấm *Sao chép link* vẫn là *"Đã copy link nhóm"* (giống toast cũ), người đã từng thấy toast này có thể nhớ nhầm là nút *Mời qua link* vẫn copy. |
| Finding type | CX Risk — rủi ro giả định |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — không có quan sát; requirement (mở màn, không copy) đã rõ và là chủ ý của BA |
| Impact | Dán nhầm nội dung cũ trong clipboard vào tin gửi khách; mất niềm tin vào nút quen thuộc trong vài ngày đầu |
| Evidence và confidence / limitations | Chỉ từ tài liệu; mức tin cậy trung bình (tài liệu tự gọi đây là breaking change). Chưa biết nhân sự có đọc thông điệp §16 không |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-08: khi vào từ *Mời qua link*, làm nổi nút *Sao chép link* (focus / nhấn mạnh) hoặc nhắc một dòng "Bấm Sao chép link để lấy link" trong vài lần đầu — BA / UX quyết. Tối thiểu: §16 ❷ nên nói rõ "**chưa copy** cho tới khi bấm *Sao chép link*" |
| Traceability | BR01 `G033:183`, AF06 `G033:156`, AC `G033:418` — case lối vào thứ hai của Test Designer |
| Open questions / quyết định cần Product · BA · UX | Có kèm nhắc trong sản phẩm hay chỉ truyền thông — Product / BA |

### CX-02 — Web: popup Link nhóm mở từ trong giao diện Thêm thành viên — lớp nào đang hiện, đóng về trạng thái nào

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-02 |
| Review scope | Lối vào thứ hai trên Web; §10E |
| Source evidence | `G033:156` AF06 "Đóng màn → **về lại màn Thêm thành viên**, không nhảy về panel"; `G033:158` AF08; `G033:326` "popup giữa màn, bề rộng ~420px, nền phía sau làm mờ"; `G008:390` *Thêm thành viên* "Mở giao diện tìm kiếm"; Q-15 (`02-…` §3) |
| Persona và context | P1, P4 — đang tìm / đã chọn vài thành viên trong giao diện Thêm thành viên rồi bấm *Mời qua link* |
| Customer journey / scenario | J6 |
| Observation | `[NGUỒN]` Tài liệu chốt "về lại màn Thêm thành viên" nhưng không nói popup Link nhóm chồng lên hay thay thế giao diện đó (Q-15), và không nói giao diện Thêm thành viên có **giữ** từ khoá tìm / danh sách đã tích khi quay lại không. `[CX GIẢ THUYẾT]` Nếu thay thế rồi dựng lại từ đầu, nhân sự mất phần đã chọn; nếu chồng hai lớp popup, nền mờ chồng nền mờ dễ làm người dùng không rõ ✕ / Esc đóng lớp nào. |
| Finding type | Usability Issue |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — requirement chưa nói hình thức (Q-15) |
| Impact | Mất thao tác đang dở; nhầm lớp khi đóng |
| Evidence và confidence / limitations | Chỉ từ tài liệu; phụ thuộc Q-15. Chưa đọc UI màn Thêm thành viên của G008 ngoài `G008:390` |
| Recommendation | Không đề xuất hình thức; chuyển Debate: bổ sung vào Q-15 câu "giao diện Thêm thành viên có giữ trạng thái tìm / đã chọn khi đóng popup Link nhóm không" (`G033:156`, `G008:390`) |
| Traceability | AF06 `G033:156`, AF08 `G033:158`, BR13 `G033:194`, AC `G033:419`, `G033:454`; Q-15 |
| Open questions / quyết định cần Product · BA · UX | Q-15 + câu bổ sung trên — BA |

### CX-03 — Màn §10F không có tên nhóm; *Tạo ngay* không hộp xác nhận → nguy cơ tạo link cho nhầm nhóm

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-03 |
| Review scope | Màn chưa có link §10F; UC-04 |
| Source evidence | `G033:334-349` mockup §10F (tiêu đề chỉ "Link nhóm"); `G033:357` "**Không** avatar/tên nhóm · **không** vùng QR …"; `G033:86` "Bấm **Tạo ngay** — **không có hộp xác nhận** (BR16)"; `G033:195` "nhân sự quản nhiều nhóm"; `G033:194` mobile "màn toàn trang"; `G033:271` §10B có avatar + tên nhóm |
| Persona và context | P1 (quản nhiều nhóm), P3 (mobile toàn trang), P7 |
| Customer journey / scenario | J4 — mở màn của một nhóm chưa có link, nhất là khi vừa chuyển qua lại nhiều nhóm |
| Observation | `[NGUỒN]` Màn §10B có avatar + tên nhóm; màn §10F cố ý không có (bám Zalo). `[CX GIẢ THUYẾT]` Trên mobile màn toàn trang, nhân sự không còn thấy hội thoại phía sau → màn §10F chỉ có câu mời và nút, không cho biết đang tạo link cho **nhóm nào**; *Tạo ngay* lại không hỏi xác nhận (chủ ý BR16 "không có gì để mất"). Tạo nhầm nhóm không mất dữ liệu nhưng nhân sự phải huỷ lại (qua hộp xác nhận) và có thể gửi nhầm link nhóm A cho khách nhóm B ngay sau đó. Trên Web popup có nền mờ nên còn thấy tên hội thoại phía sau — rủi ro thấp hơn. |
| Finding type | Usability Issue |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — màn §10F đúng requirement `G033:357`; đây là góp ý trải nghiệm, không phải lệch |
| Impact | Tạo link nhầm nhóm; sau đó gửi nhầm link |
| Evidence và confidence / limitations | Chỉ từ mockup ASCII và câu chữ; mức tin cậy trung bình. Chưa biết mobile có header hội thoại phía trên màn không |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-03: hiện avatar + tên nhóm ở §10F như §10B (hoặc tiêu đề "Link nhóm · {tên nhóm}") — cần BA quyết vì BR15 bám đúng Zalo |
| Traceability | BR15 `G033:196`, BR16 `G033:197`, §10F `G033:357`, AC `G033:448-453` — case §10F của Test Designer kiểm "không avatar / tên nhóm" theo tài liệu hiện hành |
| Open questions / quyết định cần Product · BA · UX | BA: có chấp nhận lệch Zalo-native ở điểm này không |

### CX-04 — Dòng nhắc "chờ trưởng nhóm duyệt" không đi theo link tới khách

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-04 |
| Review scope | Dòng nhắc §10C; màn chia sẻ §10D; tin gửi dạng thẻ (BR14); hành trình khách J7 |
| Source evidence | `G033:279` "Đặt **ngay dưới link**, chỉ hiện khi đúng tình huống"; `G033:283` *"Nhóm đang bật duyệt thành viên — người tham gia sẽ chờ trưởng nhóm duyệt"*; `G033:190` lý do BR08 "Người gửi link biết trước để báo lại cho khách, tránh khách quét xong tưởng hỏng rồi hỏi ngược"; `G033:192` lý do BR10 "Nhân sự CSKH phải nắm bước này để trả lời khách *"bấm link rồi mà sao chưa thấy vào nhóm"*"; `G033:318-319` thẻ xem trước = avatar + tên nhóm + link, dòng tin kèm mặc định *"Truy cập link để tham gia nhóm"*; `G033:153` AF02 "Ba thao tác vẫn dùng bình thường"; `G033:191` BR09 nhóm đầy vẫn lấy được link; D-04, D-13 |
| Persona và context | P1 (gửi nhiều khách một lượt), P5 (khách bấm *Tham gia* rồi chờ) |
| Customer journey / scenario | J1, J2 → J7 |
| Observation | `[NGUỒN]` Dòng nhắc chỉ có trên màn Link nhóm, là dòng chữ dưới link; màn chia sẻ và tin gửi đi không mang thông tin "chờ duyệt". `[CX GIẢ THUYẾT]` Nhân sự bấm *Chia sẻ link* ngay (một chạm từ §10B) có thể không đọc dòng nhắc; dòng tin kèm mặc định *"Truy cập link để tham gia nhóm"* hứa "tham gia" trong khi khách sẽ phải chờ → khách hỏi ngược đúng như tài liệu lo. Toàn bộ gánh "báo lại cho khách" đặt lên trí nhớ của nhân sự. `[CX GIẢ THUYẾT]` Với nhóm đầy (BR09) cơ chế giống hệt: màn vẫn cho chia sẻ, khách bấm *Tham gia* bị từ chối phía Zalo — ngoài phạm vi chạy (D-13), chỉ nêu rủi ro. |
| Finding type | CX Risk — rủi ro giả định |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — không có requirement nói dòng nhắc phải đi theo tin |
| Impact | Khách tưởng link hỏng; nhân sự nhận câu hỏi lặp; mất niềm tin vào link mời |
| Evidence và confidence / limitations | Chỉ từ tài liệu; mức tin cậy trung bình–cao vì chính tài liệu nêu rủi ro này làm lý do BR08 / BR10. Chưa biết màn xem trước của Zalo có tự báo "cần duyệt" không (OOS03) |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-01: khi nhóm bật duyệt, dòng tin kèm mặc định (sửa được) gợi thêm ý chờ duyệt, hoặc màn §10D nhắc lại dòng §10C phía trên thẻ xem trước — Product / BA quyết. ĐO & GHI (QA): màn xem trước Zalo có hiện trạng thái duyệt không |
| Traceability | BR08 `G033:190`, BR10 `G033:192`, BR14 `G033:195`, §10C `G033:283`, §10D `G033:318-319`; AC `G033:473`, `G033:482`; D-04, D-05, D-15 |
| Open questions / quyết định cần Product · BA · UX | Product / BA |

### CX-05 — Dòng nhắc duyệt không dẫn tới chỗ duyệt, không nói ai phải làm gì tiếp

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-05 |
| Review scope | Dòng nhắc §10C; hành trình J7 phía nhân sự |
| Source evidence | `G033:283` dòng nhắc; `G026:88-93` UC-06 trưởng nhóm mở *Duyệt thành viên* → Duyệt / Từ chối; `G026:132` BR08 "Chỉ trưởng nhóm Duyệt/Từ chối … badge ở mục *Duyệt thành viên*"; `G026:157` mockup "Duyệt thành viên — Đã bật · 2 chờ ›"; xác nhận #2 (chỉ có trưởng nhóm) |
| Persona và context | P1 (tài khoản Zalo đang dùng là trưởng nhóm → chính nhân sự phải duyệt), P2 |
| Customer journey / scenario | J7 — khách đã bấm *Tham gia*, đang chờ |
| Observation | `[NGUỒN]` Dòng nhắc nói "chờ trưởng nhóm duyệt" và nơi duyệt nằm ở màn Cài đặt nhóm (G026). `[CX GIẢ THUYẾT]` Nhân sự gửi link xong đóng màn; không có gì nối từ màn Link nhóm tới mục *Duyệt thành viên*, nên người duyệt phải tự nhớ đi tới G026 — khách chờ lâu hơn cần thiết. |
| Finding type | Improvement Suggestion |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — không có requirement làm căn cứ |
| Impact | Khách chờ duyệt lâu; nhân sự không biết có người đang chờ nếu không mở Cài đặt nhóm |
| Evidence và confidence / limitations | Chỉ từ tài liệu; mức tin cậy thấp–trung bình. Badge ở G026 đã là một tín hiệu; chưa biết panel G008 có hiện badge không |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-02: dòng nhắc §10C có thể bấm được → mở *Duyệt thành viên* (G026), hoặc hiện kèm số người đang chờ — BA / Product quyết |
| Traceability | BR08 `G033:190`, §10C `G033:283`; G026 UC-06 / BR08; `Unlinked` với case G033 (ngoài phạm vi G033) |
| Open questions / quyết định cần Product · BA · UX | Product / BA |

### CX-06 — E03 với tài khoản Zalo là thành viên thường (Q-07): nút *Thử lại* có thể vô ích, thông điệp không nói nguyên nhân

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-06 |
| Review scope | E03; BR04 trục "Zalo quyết có trả link không"; §10F vs E03 |
| Source evidence | `G033:168` E03 "vùng QR và link hiện: *"Không lấy được link nhóm. Vui lòng thử lại."* + nút **Thử lại**. Ba nút thao tác **disable**"; `G033:186` BR04 "Zalo từ chối thì rơi vào **E03** … hiện chưa biết Zalo có chặn thành viên thường hay không (**OQ02**)"; `G033:539` OQ02; `G033:173` E08 có đuôi "Vui lòng kiểm tra lại trên app Zalo" còn E03 không; Q-07 |
| Persona và context | P6 — nhân sự dùng tài khoản Zalo chỉ là thành viên thường của nhóm; có căn cứ `G033:186`, `G033:197` |
| Customer journey / scenario | J1 — mở màn lần đầu |
| Observation | `[NGUỒN]` Nếu Zalo chặn thành viên thường (chưa đo), P6 sẽ thấy đúng màn lỗi E03 với lời gọi *Thử lại*. `[CX GIẢ THUYẾT]` *Thử lại* trong trường hợp này không bao giờ thành công; thông điệp giống lỗi tạm thời nên nhân sự thử nhiều lần rồi báo "hệ thống lỗi", trong khi nguyên nhân là vai trò trên Zalo — chính nhầm lẫn mà tài liệu muốn tránh giữa §10F và E03 (`G033:361`) lặp lại theo hướng khác. |
| Finding type | CX Risk — rủi ro giả định, phụ thuộc Q-07 |
| Steps to reproduce | N/A — chưa có sản phẩm; nhánh phụ thuộc kết quả đo OQ02 |
| Expected vs observed | N/A — OQ02 chưa chốt |
| Impact | Thử lại vô ích, báo lỗi sai địa chỉ; mất thời gian support |
| Evidence và confidence / limitations | Chỉ từ tài liệu; chỉ thành vấn đề nếu Q-07 đo ra "có chặn". Không có mã lỗi Zalo (§9 N/A) để biết hệ thống phân biệt được hay không |
| Recommendation | Nếu Q-07 = có chặn: đề nghị BA bổ sung nhánh chuỗi riêng cho E03 (nêu nguyên nhân vai trò, gợi ý làm trên app Zalo như E08) — chuyển Debate gắn Q-07. QA: case "thành viên thường mở màn" ĐO & GHI đúng như Q-07 đã ghi |
| Traceability | BR04 `G033:186`, E03 `G033:168`, OQ02 `G033:539`; AC `G033:491`; Q-07 |
| Open questions / quyết định cần Product · BA · UX | Q-07 (Dev / hub qua BA); chuỗi E03 nhánh vai trò — BA |

### CX-07 — Toast E08 "Vui lòng kiểm tra lại trên app Zalo" không hành động được với nhân sự không cầm điện thoại của tài khoản

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-07 |
| Review scope | E08 ở UC-04 / UC-05 / UC-06; nút *Tạo ngay* và menu `•••` |
| Source evidence | `G033:173` E08 "*"Không tạo được link nhóm…"* · … cùng đuôi *"Vui lòng kiểm tra lại trên app Zalo"* … Recovery: Bấm lại, hoặc làm trên app Zalo"; `G033:197` BR16 "Gopany **không thêm điều kiện vai trò Zalo** … thành viên thường bấm sẽ bị **Zalo** từ chối → **E08**"; `G033:594` lưu ý "Gopany không chặn theo vai trò Zalo — thành viên thường bấm thì để Zalo từ chối"; Q-12 (phần giữa "…" chưa có); xác nhận #2 |
| Persona và context | P6, P7 |
| Customer journey / scenario | J4, J5 |
| Observation | `[NGUỒN]` Chủ ý BA: không chặn trước theo vai Zalo, để Zalo từ chối. `[CX GIẢ THUYẾT]` Hệ quả trải nghiệm: nút *Tạo ngay* / *Đổi link* / *Huỷ link* hiện và bấm được với mọi người có quyền Gopany, nhưng chỉ khi bấm xong mới biết mình không được phép; toast chỉ nói "kiểm tra lại trên app Zalo" — không nói kiểm tra gì, với ai. Nhân sự thao tác trên Web thường không cầm điện thoại của tài khoản Zalo đó, nên "làm trên app Zalo" không phải lựa chọn của họ. Phần giữa chuỗi (Q-12) là chỗ duy nhất có thể nêu nguyên nhân. |
| Finding type | Usability Issue |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — chuỗi E08 chưa đủ (Q-12) |
| Impact | Bấm lại nhiều lần vô ích; không biết phải nhờ ai (trưởng nhóm trên Zalo) |
| Evidence và confidence / limitations | Chỉ từ tài liệu; mức tin cậy trung bình. Không biết Zalo trả mã lỗi có phân biệt "không đủ vai" với lỗi khác không (§9 N/A) |
| Recommendation | Khi BA chốt Q-12: nếu mã lỗi Zalo phân biệt được, phần giữa nêu nguyên nhân ("tài khoản không phải trưởng nhóm") và việc cần làm — gửi BA kèm Q-12. Không đề xuất chặn trước (trái chủ ý BR16) |
| Traceability | BR16 `G033:197`, BR17 `G033:198`, E08 `G033:173`; AC `G033:456`, `G033:468`; D-16 nhánh âm; Q-12 |
| Open questions / quyết định cần Product · BA · UX | Q-12 — BA |

### CX-08 — Hộp *"Huỷ link nhóm?"*: nút thoát **Huỷ** đứng cạnh nút xác nhận **Huỷ link**

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-08 |
| Review scope | Hộp xác nhận Huỷ link §10G; AF07 |
| Source evidence | `G033:394-401` mockup "( Huỷ )  ( Huỷ link )"; `G033:105-106` UC-06 b2–b3; `G033:406` "Nút **Huỷ** · ✕ · `Esc` — Đóng hộp, link giữ nguyên"; `G033:410` "Hai việc này **không gỡ lại được**"; `G033:198` BR17 "với nút **Huỷ** để thoát"; `G033:504` OOS02 không khôi phục; D-20, D-21 (chuỗi đúng nguyên văn) |
| Persona và context | P1, P2, P7 — bấm nhanh, hoặc mới dùng |
| Customer journey / scenario | J5 — đã mở hộp xác nhận huỷ |
| Observation | `[NGUỒN]` Hai nút trong hộp *"Huỷ link nhóm?"* đều bắt đầu bằng "Huỷ": "Huỷ" (thoát, giữ link) và "Huỷ link" (xác nhận, link chết ngay, không gỡ lại được). `[CX GIẢ THUYẾT]` Người đọc lướt thấy "Huỷ … Huỷ …" khó phân biệt nút nào là thoát; bấm nhầm sang "Huỷ link" là hậu quả không đảo ngược được, còn bấm nhầm sang "Huỷ" chỉ phải làm lại. Mockup không ghi màu / độ nhấn khác nhau của hai nút nên không có thêm tín hiệu phân biệt từ tài liệu. Hộp *"Đổi link nhóm?"* ít rủi ro hơn ("Huỷ" / "Đổi link" khác chữ). |
| Finding type | CX Risk — rủi ro giả định |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — chuỗi đúng requirement, đây là rủi ro trải nghiệm |
| Impact | Huỷ nhầm link đã phát cho khách; không khôi phục được (OOS02) |
| Evidence và confidence / limitations | Chỉ từ mockup ASCII; mức tin cậy trung bình. Chưa thấy màu / vị trí nút thật |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-04: nút thoát dùng chữ khác ("Đóng" / "Giữ link") hoặc nút xác nhận mang màu cảnh báo và không là nút mặc định khi bấm Enter — BA / UX quyết (chuỗi hiện bám Zalo-native). QA: case AF07 kiểm đúng chuỗi hiện hành theo D-21 |
| Traceability | BR17 `G033:198`, UC-06 `G033:102-108`, AF07 `G033:157`, §10G `G033:400`, `G033:406`; AC `G033:465-467`; D-20 |
| Open questions / quyết định cần Product · BA · UX | BA / UX |

### CX-09 — Câu hậu quả không nhắc mã QR đã lưu / đã in cũng chết theo link

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-09 |
| Review scope | Hai hộp xác nhận §10G; UC-05 b2, UC-06 b2 |
| Source evidence | `G033:95` *"Link cũ sẽ không dùng được nữa. Người đã nhận link cũ phải xin link mới."*; `G033:105` *"Link hiện tại sẽ không dùng được nữa. Muốn mời bằng link thì phải tạo link mới."*; `G033:198` lý do BR17 "có thể đang nằm trong tin nhắn gửi khách, trong email, **trên một tờ rơi đã in**"; `G033:503` OOS01 "Đổi hoặc huỷ **link** thì QR đổi/mất theo"; `G033:189` BR07 "chèn slide hay in ra"; D-09 (QR đã lưu phải chết cùng link cũ) |
| Persona và context | P3 (đã in QR, dán tại quầy), P2 (người bấm đổi) |
| Customer journey / scenario | J5 → J3 |
| Observation | `[NGUỒN]` Tài liệu biết QR đã in sẽ chết (lý do BR17, OOS01) nhưng câu hậu quả trong hộp chỉ nói "link". `[CX GIẢ THUYẾT]` Người bấm *Đổi link* nghĩ "link" là chuỗi chữ đã gửi qua tin nhắn; không nghĩ tới tờ QR in ở quầy hay QR chèn trong slide / email đã gửi — vẫn để khách quét mã chết trong nhiều ngày; không có cách nào biết (hệ thống không báo, OOS02). |
| Finding type | CX Risk — rủi ro giả định |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — chuỗi đúng requirement |
| Impact | Khách quét QR in sẵn không vào được, không ai biết vì sao; tốn công in lại |
| Evidence và confidence / limitations | Chỉ từ tài liệu; mức tin cậy trung bình–cao vì mối liên hệ QR ↔ link đã được tài liệu khẳng định |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-05: câu hậu quả thêm ý "mã QR đã lưu hoặc đã in cũng không dùng được" — BA quyết (chuỗi bám Zalo). Thông điệp §16 ❹ cũng nên nhắc QR |
| Traceability | BR17 `G033:198`, OOS01 `G033:503`, §10G `G033:384-386`, `G033:396-398`; AC `G033:462`, `G033:465`; D-09, D-17 |
| Open questions / quyết định cần Product · BA · UX | BA |

### CX-10 — Trạng thái "đang xử lý" chờ Zalo: hình thức, thời gian tối đa, Esc / click nền mờ lúc đang chạy chưa được mô tả

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-10 |
| Review scope | *Tạo ngay* (§10F), nút xác nhận Đổi / Huỷ (§10G), popup Web §10E |
| Source evidence | `G033:358` "Nút chuyển trạng thái đang xử lý, **không bấm được lần hai**"; `G033:408` cùng câu cho hộp xác nhận; `G033:87`, `G033:97`, `G033:107` "chờ Zalo xác nhận"; `G033:550-553` §15 chỉ có mốc mở màn (≤ 2 s, > 10 s → E03), tải QR (≤ 3 s), hộp chọn (≤ 1 s) — không có mốc cho tạo / đổi / huỷ; `G033:326` Web đóng bằng ✕ · Esc · click nền mờ; `G033:406` Esc đóng hộp xác nhận; `G033:170-171` E05 / E06; Q-11; D-16, D-20 |
| Persona và context | P8 (mạng chậm — giả thuyết), P1 |
| Customer journey / scenario | J4, J5 — đã bấm, đang chờ |
| Observation | `[NGUỒN]` Tài liệu chốt "không bấm được lần hai" nhưng không nói: (1) hình thức báo đang xử lý (vòng quay, chữ "Đang tạo…"); (2) chờ tối đa bao lâu, quá mốc thì nút về trạng thái nào và toast gì (Q-11 mới hỏi E05 / E06 lúc đang xử lý, chưa hỏi timeout); (3) Esc / ✕ / click nền mờ **trong lúc** đang xử lý đổi / huỷ có đóng hộp hoặc popup không — nếu đóng được, nhân sự không thấy kết quả và không biết link cũ đã chết hay chưa. `[CX GIẢ THUYẾT]` Với mạng chậm, nút kẹt ở "đang xử lý" không có mốc dừng làm người dùng đóng màn giữa chừng, rồi mở lại thấy link đã đổi (hoặc chưa) mà không có toast. |
| Finding type | Usability Issue |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — requirement chưa nói |
| Impact | Không biết thao tác xong hay hỏng; đóng giữa chừng → trạng thái link mập mờ với chính người vừa bấm |
| Evidence và confidence / limitations | Chỉ từ tài liệu; mức tin cậy trung bình. D-16 đã có cách kéo dài khoảng chờ bằng throttling để QA quan sát |
| Recommendation | Chuyển Debate (bổ sung Q-11 hoặc câu mới): mốc thời gian tối đa cho tạo / đổi / huỷ và trạng thái nút khi quá mốc (`G033:358`, `G033:408`, `G033:550-553`); Esc / ✕ / click nền mờ khi đang xử lý (`G033:326`, `G033:406-408`). QA: ĐO & GHI hình thức "đang xử lý" |
| Traceability | BR16 `G033:197`, BR17 `G033:198`, §10F `G033:358`, §10G `G033:408`, §15 `G033:550-553`; AC `G033:455`; Q-11; D-16, D-20, D-22 |
| Open questions / quyết định cần Product · BA · UX | BA (hành vi), Dev (timeout thực tế) |

### CX-11 — Dòng tin kèm: hiển thị bị cắt trong mockup, không có giới hạn ký tự; xoá trắng gửi link trần không nhắc

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-11 |
| Review scope | Màn chia sẻ §10D — dòng tin nhắn kèm |
| Source evidence | `G033:308` mockup "Truy cập link để tham gia..."; `G033:319` "Mặc định *"Truy cập link để tham gia nhóm"*, **sửa được**; xoá trắng → gửi chỉ link"; `G033:195` "Khách nhận một đường link trần thường không dám bấm; có câu dẫn thì biết là gì, và nhân sự CSKH hay muốn viết lại theo giọng của mình"; `G033:443` AC xoá trắng → chỉ nhận link; Q-13; `02-…` §10 "Dòng tin kèm: … rất dài" |
| Persona và context | P1 (viết lại theo giọng mình), P5 (nhận link trần) |
| Customer journey / scenario | J2 — sửa dòng tin trước khi *Gửi* |
| Observation | `[NGUỒN]` Dòng tin kèm là ô sửa được, trong mockup hiện một dòng và cắt bằng "..."; tài liệu không nói giới hạn ký tự, không nói ô có nhiều dòng không. `[CX GIẢ THUYẾT]` Nhân sự viết câu dài theo giọng mình sẽ không thấy đủ nội dung mình vừa gõ trước khi gửi tới 99 hội thoại. `[CX GIẢ THUYẾT]` Xoá trắng là thao tác được phép và dẫn tới chính tình huống tài liệu đánh giá là xấu (khách không dám bấm) mà không có nhắc nào. |
| Finding type | Usability Issue |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — requirement không nói về hiển thị dài / giới hạn |
| Impact | Gửi nhầm câu chưa xem lại tới nhiều khách; gửi link trần làm khách ngại bấm |
| Evidence và confidence / limitations | Chỉ từ mockup ASCII một dòng; mức tin cậy thấp–trung bình |
| Recommendation | QA: ĐO & GHI giới hạn ký tự, ô có mở rộng nhiều dòng không (đã nằm trong `02-…` §10 "rất dài"). `[ĐỀ XUẤT THAY ĐỔI]` CP-10: khi dòng trống, nhắc nhẹ "Khách sẽ chỉ nhận link" (không chặn) — BA quyết |
| Traceability | BR14 `G033:195`, §10D `G033:308`, `G033:319`; AC `G033:440`, `G033:442-443`; D-15; Q-13 |
| Open questions / quyết định cần Product · BA · UX | BA |

### CX-12 — Gửi tới nhiều hội thoại: một toast chung, không có kết quả theo từng đích; sau *Gửi* màn đóng hay không (Q-14)

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-12 |
| Review scope | UC-02 b4; màn chia sẻ §10D |
| Source evidence | `G033:72` "Gửi vào từng hội thoại đã chọn **một tin nhắn** … → toast *"Đã gửi link nhóm"* [→ E05, E06]"; `G033:71` tối đa 99; `G003:213-214` UC-08 "Toast: *"Đã chuyển tiếp"*; popup đóng lại"; `G003:273` E09 "popup giữ nguyên để user thử lại"; `G003:542` "sau khi gửi → toast *"Đã chuyển tiếp"*, popup đóng"; Q-14 |
| Persona và context | P1 — gửi một lượt cho nhiều khách |
| Customer journey / scenario | J2 — bước cuối |
| Observation | `[NGUỒN]` G033 chỉ chốt toast thành công và trỏ E05 / E06; không nói màn chia sẻ đóng hay giữ (Q-14), không nói trường hợp gửi được một phần. Hộp chọn gốc G003 có E09 giữ popup để thử lại. `[CX GIẢ THUYẾT]` Nếu 99 đích mà vài đích lỗi, nhân sự chỉ thấy một toast (thành công hoặc lỗi chung) — không biết khách nào chưa nhận; gửi lại cả lượt thì khách đã nhận bị gửi trùng. |
| Finding type | CX Risk — rủi ro giả định, phụ thuộc Q-14 |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — Q-14 chưa chốt |
| Impact | Khách bị sót hoặc nhận trùng; nhân sự không có cách đối soát |
| Evidence và confidence / limitations | Chỉ từ tài liệu; phụ thuộc cách G003 UC-08 xử lý lỗi một phần (chưa đọc hết G003) |
| Recommendation | Giữ ở Q-14 (đã hỏi "gửi lỗi một phần thì toast nào"); CX đề nghị BA cân nhắc khi trả lời: kết quả theo từng đích hoặc giữ nguyên các đích chưa gửi được để thử lại (như E09 của G003) |
| Traceability | BR06 `G033:188`, UC-02 `G033:72`; AC `G033:434`; Q-14; `02-…` §10 (chọn 1 / 98 / 99) |
| Open questions / quyết định cần Product · BA · UX | Q-14 — BA |

### CX-13 — Bộ lọc tài khoản Zalo trên màn chia sẻ: không đổi được (xác nhận #4) nhưng dùng lại hộp chọn vốn cho đổi

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-13 |
| Review scope | Màn chia sẻ §10D — bộ lọc tài khoản |
| Source evidence | Xác nhận #4 "chỉ gửi trong tài khoản Zalo đang quản lý nhóm; không đổi sang tài khoản khác"; `G033:188` chữ cũ "**đổi được** sang tài khoản khác"; `G033:594` lưu ý cũ "**không khoá** bộ lọc tài khoản Zalo"; `G003:205` UC-08 "**Filter tài khoản Zalo** (single select) — mặc định là tài khoản Zalo của hội thoại nguồn"; `G003:623` AC "chuyển sang account khác → danh sách hội thoại cập nhật theo"; Q-20 |
| Persona và context | P1 — dùng popup Chuyển tiếp hằng ngày |
| Customer journey / scenario | J2 |
| Observation | `[ĐÃ XÁC NHẬN]` Không gửi sang tài khoản khác. `[NGUỒN]` Hộp chọn gốc có bộ lọc đổi được. `[CX GIẢ THUYẾT]` Nếu bộ lọc hiện nhưng khoá (Q-20 nhánh "khoá"), nhân sự quen popup Chuyển tiếp sẽ bấm vào, không đổi được, tưởng lỗi; nếu đổi được nhưng không gửi (nhánh thứ ba của Q-20) thì tệ nhất — chọn xong mới biết. Nhánh "ẩn" ít gây nhầm nhất nhưng làm hai popup giống nhau khác nhau một thành phần. |
| Finding type | Usability Issue — phụ thuộc Q-20 |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — hình thức bộ lọc chưa chốt (Q-20) |
| Impact | Nhầm lỗi; mất thời gian |
| Evidence và confidence / limitations | Chỉ từ tài liệu; phụ thuộc Q-20 |
| Recommendation | Góp ý cho BA khi chốt Q-20: nếu giữ bộ lọc thì hiện tên tài khoản đang gửi ở dạng chỉ đọc (không giống dropdown); tránh nhánh "đổi được nhưng không gửi" |
| Traceability | BR06 `G033:188`; AC `G033:437-438`; xác nhận #4; Q-20; D-11 |
| Open questions / quyết định cần Product · BA · UX | Q-20 — BA |

### CX-14 — Link đổi / huỷ trên app Zalo khi màn đang mở: màn cập nhật ngay nhưng không có tín hiệu báo

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-14 |
| Review scope | §7 state machine — cập nhật realtime; màn §10B |
| Source evidence | `G033:223` "Trạng thái đổi **trên app Zalo** trong lúc màn đang mở → màn cập nhật **ngay**, không cần tải lại (**BR-C12**)"; `G033:470` AC; `02-…` §10 "Hai người cùng mở màn, một người đổi link → người kia thấy cập nhật ngay"; Q-22 (nhóm giải tán khi màn đang mở) |
| Persona và context | P1 — đang đọc link cho khách qua điện thoại hoặc đang chuẩn bị bấm *Sao chép link* |
| Customer journey / scenario | J1 |
| Observation | `[NGUỒN]` Màn cập nhật ngay; tài liệu không nói có toast hay dấu hiệu nào khi link thay đổi từ bên ngoài. `[CX GIẢ THUYẾT]` Link và QR đổi dưới tay người đang nhìn; nếu họ vừa đọc nửa link cho khách, hoặc màn chuyển sang §10F đúng lúc họ định bấm *Chia sẻ link*, họ không hiểu chuyện gì xảy ra và có thể đã gửi link cũ (vừa chết) trước đó vài giây. |
| Finding type | CX Risk — rủi ro giả định |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — requirement không nói về tín hiệu |
| Impact | Gửi link vừa chết; hoang mang khi màn tự đổi |
| Evidence và confidence / limitations | Chỉ từ tài liệu; tình huống hiếm (phải có người khác đổi link cùng lúc); mức tin cậy thấp–trung bình |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-06: toast ngắn khi link bị đổi / huỷ từ bên ngoài (vd *"Link nhóm vừa được thay đổi"*) — BA quyết. Chuyển Debate (nhẹ): màn "cập nhật ngay" có kèm toast không (`G033:223`) — để Test Designer biết có kiểm hay ĐO & GHI |
| Traceability | §7 `G033:223`, BR17 `G033:198`; AC `G033:470`; Q-22; D-19 |
| Open questions / quyết định cần Product · BA · UX | BA |

### CX-15 — Quét QR trực tiếp từ màn hình: kích thước QR, logo giữa mã chưa được định

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-15 |
| Review scope | Mã QR §10B trên Web popup ~420px và mobile |
| Source evidence | `G033:19` "quét QR khi gặp trực tiếp"; `G033:273` "Đặt giữa màn … Zalo trả về ảnh QR *(có logo Zalo ở giữa)* … tự sinh → mã trơn"; `G033:326` popup ~420px; `G033:429` AC hai nhánh logo; Q-05 |
| Persona và context | P3 — đưa màn (laptop hoặc điện thoại) cho khách quét |
| Customer journey / scenario | J3 |
| Observation | `[NGUỒN]` Tài liệu định vị trí và nhánh logo, không định kích thước tối thiểu của QR hay độ tương phản. `[CX GIẢ THUYẾT]` Trong popup 420px còn phải chứa avatar, tên, câu hướng dẫn, link, ba nút, dòng nhắc — QR có thể nhỏ; khách quét từ màn laptop ở khoảng cách tay với có thể không nhận. Logo ở giữa (nhánh Zalo trả) ăn vào vùng dữ liệu của mã — Zalo đã dùng nên có thể chấp nhận, nhưng chỉ đúng khi dùng nguyên ảnh của Zalo. |
| Finding type | Improvement Suggestion |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — không có requirement làm căn cứ |
| Impact | Khách không quét được tại chỗ; nhân sự phải chuyển sang gửi link |
| Evidence và confidence / limitations | Chỉ từ tài liệu; mức tin cậy thấp. Phụ thuộc Q-05 và design thật |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-11: định kích thước QR tối thiểu trên Web / mobile — UX / BA. QA `[QA BỔ SUNG]`: ĐO & GHI quét QR từ màn hình Web bằng app Zalo và app đọc QR thường ở khoảng cách thực tế (đã có một phần ở `02-…` §10 "quét QR bằng app Zalo và app đọc QR thường") |
| Traceability | BR02 `G033:184`, §10B `G033:273`, §10E `G033:326`; AC `G033:428-429`; D-08; Q-05 |
| Open questions / quyết định cần Product · BA · UX | UX / BA |

### CX-16 — *Chia sẻ link* không phải bảng chia sẻ của máy; hai nút cùng chữ "link" ở dòng dưới

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-16 |
| Review scope | Ba nút §10B; BR13 (1) |
| Source evidence | `G033:261-263` mockup "⧉ Sao chép / link · ↗ Chia sẻ / link · ↓ Lưu mã QR"; `G033:275` "hàng ngang, icon trên chữ dưới"; `G033:194` BR13 "*Chia sẻ link* — **cả hai nền tảng đều mở danh sách hội thoại trong hệ thống**, đúng như Zalo làm"; `G033:188` lý do BR06 "**không** bật bảng chia sẻ của hệ điều hành"; `G033:189` BR07 "PNG để gửi email, chèn slide" |
| Persona và context | P7 (mới), P3 (mobile, muốn gửi qua kênh ngoài) |
| Customer journey / scenario | J1, J2 trên mobile |
| Observation | `[NGUỒN]` *Chia sẻ link* chỉ gửi vào hội thoại Zalo trong hệ thống (chủ ý, bám Zalo). `[CX GIẢ THUYẾT]` Trên mobile, nút "Chia sẻ" với icon ↗ thường được hiểu là bảng chia sẻ của máy (SMS, email, app khác); nhân sự muốn gửi link qua email sẽ bấm *Chia sẻ link*, thấy danh sách hội thoại Zalo, rồi phải quay lại *Sao chép link*. Hai nút đầu có dòng dưới cùng là "link", chỉ khác dòng trên và icon — người đọc lướt dễ bấm nhầm; không mất gì nhưng tốn một bước. |
| Finding type | Usability Issue |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — đúng requirement BR06 / BR13 |
| Impact | Thấp — thêm một bước, không mất dữ liệu |
| Evidence và confidence / limitations | Chỉ từ mockup ASCII; mức tin cậy thấp |
| Recommendation | Không đề xuất đổi hành vi (bám Zalo). Nếu BA muốn: §16 ❶ nói rõ "Chia sẻ link = gửi vào hội thoại Zalo; gửi kênh khác thì Sao chép link" |
| Traceability | BR05 `G033:187`, BR06 `G033:188`, BR13 `G033:194`, §10B `G033:275`; AC `G033:427`, `G033:434` |
| Open questions / quyết định cần Product · BA · UX | — |

### CX-17 — Chuỗi toast không cùng giọng

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-17 |
| Review scope | Toast của UC-01 → UC-06 |
| Source evidence | `G033:63` *"Đã copy link nhóm"*; `G033:72` *"Đã gửi link nhóm"*; `G033:88` *"Tạo link thành công"*; `G033:98` *"Đã đổi link nhóm"*; `G033:108` *"Đã huỷ link nhóm"*; `G033:197` "Zalo cũng làm đúng vậy — bấm là ra toast *"Tạo link thành công"*"; D-21 (kỳ vọng đúng nguyên văn) |
| Persona và context | P7 |
| Customer journey / scenario | Tất cả |
| Observation | `[NGUỒN]` Bốn toast dạng "Đã … link nhóm", một toast dạng "… thành công"; "copy" là tiếng Anh giữa chuỗi tiếng Việt (kế thừa từ G008 BR15). `[CX GIẢ THUYẾT]` Không gây hiểu sai; chỉ là độ đồng nhất của giọng chuỗi. |
| Finding type | Improvement Suggestion |
| Steps to reproduce | N/A |
| Expected vs observed | N/A — chuỗi là requirement, kỳ vọng QA theo D-21 |
| Impact | Thấp |
| Evidence và confidence / limitations | Chỉ từ tài liệu; chuỗi bám Zalo nên khả năng đổi thấp |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-09: đồng giọng ("Đã tạo link nhóm", "Đã sao chép link nhóm") — BA quyết; QA không dùng đề xuất này làm kỳ vọng |
| Traceability | UC-01 → UC-06; D-21 |
| Open questions / quyết định cần Product · BA · UX | BA |

### CX-18 — Thông điệp §16 cho nhân sự thiếu việc tài liệu tự nói "nhân sự CSKH phải nắm": màn xem trước, nút *Tham gia*, chờ duyệt

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-18 |
| Review scope | §16 User communication; hành trình J7 |
| Source evidence | `G033:564` "Báo cho nhân sự bốn việc: ❶ … ❷ … ❸ … ❹ đổi hoặc huỷ link … chết ngay — nhắc kỹ chỗ này"; `G033:192` lý do BR10 "Nhân sự CSKH phải nắm bước này để trả lời khách *"bấm link rồi mà sao chưa thấy vào nhóm"*"; `G033:190` lý do BR08 "Người gửi link biết trước để báo lại cho khách" |
| Persona và context | P1, P5 |
| Customer journey / scenario | J7 |
| Observation | `[NGUỒN]` §16 liệt kê bốn việc, không có việc về bước *Tham gia* và chờ duyệt, dù BR10 nói nhân sự phải nắm. `[CX GIẢ THUYẾT]` Nhân sự mới (hoặc chưa từng mời ai qua link) không biết khách sẽ gặp màn xem trước và có thể phải chờ duyệt → không trả lời được khách, hoặc đổi link vì tưởng link hỏng (làm chết link với những khách khác). |
| Finding type | CX Risk — rủi ro giả định |
| Steps to reproduce | N/A |
| Expected vs observed | N/A — §16 là kế hoạch truyền thông, không phải hành vi sản phẩm |
| Impact | Trả lời sai khách; đổi link oan |
| Evidence và confidence / limitations | Chỉ từ tài liệu; mức tin cậy trung bình–cao (mâu thuẫn nội bộ giữa lý do BR10 và danh sách §16) |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-07: thêm ❺ vào §16: "khách bấm link / quét QR thấy màn xem trước và phải bấm *Tham gia*; nhóm bật duyệt thì khách chờ trưởng nhóm duyệt ở *Cài đặt nhóm → Duyệt thành viên*" — BA quyết (không phải requirement sản phẩm) |
| Traceability | BR08 `G033:190`, BR10 `G033:192`, §16 `G033:564`; `Unlinked` với test case (nội dung truyền thông, không kiểm được) |
| Open questions / quyết định cần Product · BA · UX | BA |

## 6. Đề xuất cải thiện (luồng riêng — không phải requirement) `[ĐỀ XUẤT THAY ĐỔI]`

Mọi dòng dưới đây là ý tưởng ngoài tài liệu; không dùng làm kỳ vọng test; chỉ thành requirement khi BA / Product quyết và
cập nhật nguồn chính thức.

| ID | Đề xuất | Lý do | Cần ai quyết định | Trạng thái |
| --- | --- | --- | --- | --- |
| CP-01 | Khi nhóm bật duyệt, màn chia sẻ nhắc lại dòng §10C hoặc dòng tin kèm mặc định gợi ý chờ duyệt | CX-04 — thông tin "chờ duyệt" không đi theo link tới khách | Product / BA | Đề xuất |
| CP-02 | Dòng nhắc duyệt bấm được → mở *Duyệt thành viên* (G026) hoặc hiện số người đang chờ | CX-05 | Product / BA | Đề xuất |
| CP-03 | Màn §10F hiện avatar + tên nhóm (hoặc tiêu đề kèm tên nhóm) | CX-03 — tạo link nhầm nhóm, nhất là mobile toàn trang | BA (lệch Zalo-native) | Đề xuất |
| CP-04 | Hộp *"Huỷ link nhóm?"*: nút thoát đổi chữ ("Đóng" / "Giữ link") hoặc nút xác nhận mang màu cảnh báo, không là nút mặc định | CX-08 — hai nút cùng "Huỷ" cho hành động không gỡ lại được | BA / UX | Đề xuất |
| CP-05 | Câu hậu quả trong hai hộp xác nhận thêm "mã QR đã lưu / đã in cũng không dùng được"; §16 ❹ nhắc QR | CX-09 | BA | Đề xuất |
| CP-06 | Toast ngắn khi link bị đổi / huỷ từ app Zalo trong lúc màn đang mở | CX-14 | BA | Đề xuất |
| CP-07 | §16 thêm ❺: khách thấy màn xem trước, phải bấm *Tham gia*, có thể chờ duyệt; nơi duyệt | CX-18 | BA | Đề xuất |
| CP-08 | Khi vào từ *Mời qua link*: làm nổi nút *Sao chép link* hoặc nhắc "chưa copy" vài lần đầu; §16 ❷ nói rõ "chưa copy cho tới khi bấm Sao chép link" | CX-01 | Product / BA | Đề xuất |
| CP-09 | Đồng giọng chuỗi toast ("Đã tạo link nhóm", "Đã sao chép link nhóm") | CX-17 | BA | Đề xuất |
| CP-10 | Dòng tin kèm trống → nhắc nhẹ "Khách sẽ chỉ nhận link", không chặn | CX-11 | BA | Đề xuất |
| CP-11 | Định kích thước QR tối thiểu trên Web / mobile để quét từ màn hình | CX-15 | UX / BA | Đề xuất |

## 7. Chuyển cho QA / quay lại Debate

| # | Nội dung | Chuyển đi đâu | Nguồn |
| ---: | --- | --- | --- |
| 1 | Vào từ *Mời qua link* → clipboard **không** bị ghi trước khi bấm *Sao chép link* (kiểm clipboard trước / sau) | QA xác minh — đã có AC, thêm bước kiểm clipboard trước | `G033:418`; CX-01 |
| 2 | Giao diện Thêm thành viên có **giữ** từ khoá tìm / danh sách đã tích sau khi đóng popup Link nhóm không; popup chồng hay thay thế | **Debate** — bổ sung vào Q-15 | `G033:156`, `G033:326`, `G008:390`; CX-02 |
| 3 | Mốc thời gian tối đa cho *Tạo ngay* / *Đổi link* / *Huỷ link*; quá mốc nút về trạng thái nào, toast gì | **Debate** — bổ sung Q-11 (hoặc Q mới) | `G033:358`, `G033:408`, `G033:550-553`; CX-10 |
| 4 | Esc / ✕ / click nền mờ **trong lúc** nút đang xử lý đổi / huỷ: đóng hộp, đóng popup, hay bị khoá | **Debate** — mở rộng D-20 | `G033:326`, `G033:406-408`; CX-10 |
| 5 | E03 (ba nút disable): menu `•••` lúc đó hiện, ẩn hay mờ — tài liệu chỉ nói "ba nút thao tác disable" | **Debate** — câu hỏi mới về cách hiểu | `G033:168`, `G033:187`, `G033:270`; liên quan CX-06 |
| 6 | Màn "cập nhật ngay" khi link đổi trên app Zalo có kèm toast / dấu hiệu nào không | **Debate** (nhẹ) — để Test Designer biết kiểm hay ĐO & GHI | `G033:223`, `G033:470`; CX-14 |
| 7 | Nếu Q-07 đo ra Zalo **có chặn** thành viên thường: chuỗi E03 có nhánh riêng không | **Debate** — gắn Q-07 | `G033:168`, `G033:186`, `G033:539`; CX-06 |
| 8 | Chuỗi E08 phần giữa: có nêu nguyên nhân (vai trò) khi Zalo trả mã lỗi phân biệt được không | Gửi BA kèm Q-12 (đã có) | `G033:173`; CX-07 |
| 9 | Gửi lỗi một phần trong nhiều hội thoại: kết quả theo từng đích / giữ đích chưa gửi để thử lại | Gửi BA kèm Q-14 (đã có) | `G033:72`, `G003:273`; CX-12 |
| 10 | Hình thức bộ lọc tài khoản (khoá / ẩn / chỉ đọc) | Gửi BA kèm Q-20 (đã có) | `G033:188`, `G003:205`; CX-13 |
| 11 | ĐO & GHI: quét QR từ màn hình Web ~420px và từ màn điện thoại bằng app Zalo và app đọc QR thường ở khoảng cách thực tế | QA `[QA BỔ SUNG]` — không làm tiêu chí pass | `G033:273`, `G033:326`; CX-15 |
| 12 | ĐO & GHI: giới hạn ký tự dòng tin kèm; ô có mở rộng nhiều dòng không | QA `[QA BỔ SUNG]` — đã có "rất dài" ở `02-…` §10 | `G033:308`, `G033:319`; CX-11 |
| 13 | ĐO & GHI: hình thức "đang xử lý" của nút *Tạo ngay* / nút xác nhận (có spinner / chữ) | QA `[QA BỔ SUNG]` | `G033:358`, `G033:408`; CX-10 |
| 14 | ĐO & GHI: màn xem trước của Zalo (OOS03) có tự báo "cần duyệt" cho khách không — ghi để Product cân nhắc CP-01 | QA — quan sát trên app Zalo người nhận, không chấm | `G033:192`; CX-04 |

Không có mục nào chuyển QA dưới dạng "nghi vi phạm requirement": review từ tài liệu không phát hiện chỗ nào mô tả hành vi
trái với requirement đã xác nhận; mọi mục trên là bổ sung kiểm / câu hỏi cách hiểu.

## 8. Tự rà soát

- [x] Mỗi finding có loại, persona, bằng chứng nguồn (`G033:dòng` / `G008` / `G026` / `G003`), mức bằng chứng (phân tích tài liệu), giới hạn
- [x] Không Defect nào — không có bằng chứng thực tế (không chạy Mode 2)
- [x] Không câu nào nói đã thao tác / đã thấy; mọi nhận định hành vi gắn `[CX GIẢ THUYẾT]`; "Expected vs observed" chỉ ghi `N/A` kèm lý do
- [x] Persona giả thuyết (P7, P8) đã đánh dấu; P1–P6 có dòng nguồn
- [x] Đề xuất cải thiện nằm riêng ở §6 với nhãn `[ĐỀ XUẤT THAY ĐỔI]`, không lẫn vào requirement; không sửa `01-…` → `04-…`, không sửa `tailieu/`
- [x] Điểm còn mở (Q-05, Q-07, Q-11 → Q-15, Q-20, Q-22) không tự chọn cách hiểu; finding chạm tới ghi "phụ thuộc Q-nn"
- [x] Số liệu đếm lại từ §4: 18 finding = 0 Defect + 7 Usability Issue (CX-02, 03, 07, 10, 11, 13, 16) + 8 CX Risk (CX-01, 04, 06, 08, 09, 12, 14, 18) + 3 Improvement Suggestion (CX-05, 15, 17); 11 CP; 14 mục chuyển

## Lịch sử cập nhật

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
| 2026-10-19 | AI (Customer Experience Agent) — người dùng: Hồng (QA) | Tạo bản đầu sau khi cổng mở (S7): Mode 1 + Mode 3 ở mức phân tích tài liệu, không Mode 2; 8 persona (P7, P8 giả thuyết); 7 hành trình; 18 finding (0 Defect · 7 Usability Issue · 8 CX Risk · 3 Improvement Suggestion); 11 đề xuất CP-01 → CP-11; 14 mục chuyển QA / Debate |
