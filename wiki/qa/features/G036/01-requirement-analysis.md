---
featureId: G036
title: Giao diện khung hội thoại — giống Zalo PC
analyzedAt: 2026-10-13
analyst: Requirement Analyst (AI) — người dùng: Hồng (QA)
---

# Requirement Analysis — G036: Giao diện khung hội thoại — giống Zalo PC

Viết tắt tham chiếu: `G036` = `tailieu/G036 - Giao diện khung hội thoại.md`; `G003`, `G009`, `G014`, `G026` = file
tương ứng trong `tailieu/`; `G032` = bản "Đổi tên gợi nhớ (1)". Số sau dấu `:` là số dòng.

## 1. Nguồn và phạm vi đã đọc

| # | Tệp | Version ghi trong tệp | Phạm vi đã đọc | Ghi chú |
| ---: | --- | --- | --- | --- |
| 1 | `G036 - Giao diện khung hội thoại.md` | 1.0 · Status **Draft** · 2026-10-09 | Toàn bộ (384 dòng) | Nguồn chính. Tự nhận là "nơi duy nhất quy định tin nhắn trông thế nào" (`G036:25`) |
| 2 | `G003 - Chat.md` | 1.11 | §7 trạng thái tin (333–341), UC-06 thu hồi/xoá (181–187), AF05 tin gửi từ điện thoại (252–256), BR06/07/09/19 (302–315), bảng hiển thị tin (456–460) | Tìm theo từ khoá |
| 3 | `G026 - Cài đặt nhóm (1).md` | — | §1 (19), UC-02 (52–54), BR01, BR03 (128–130), AC (175), OOS01 (193), changelog (216) | |
| 4 | `G009 - Tính năng bổ sung Chat.md` | — | BR04, BR06, E02 về thu hồi (103, 206, 232–234) | |
| 5 | `G032 - Đổi tên gợi nhớ (1).md` | 1.0 | BR03, BR04 (137–138) | Chỉ để kiểm dẫn chiếu |
| 6 | `G014 - Ghim tin nhắn (2).md` | — | Vài dòng về hiển thị ghim (39–55, 193) | |

Chưa đọc: G008, G015, G023, G025 (G036 chỉ dẫn làm "spec gốc" cho nghiệp vụ); phần còn lại của G003, G009, G014.
Chỉ có G036 nhắc tới G036 — chưa spec gốc nào trỏ sang.

## 2. Mục tiêu và phạm vi `[NGUỒN]`

- Quy định phần **hiển thị** của khung hội thoại cho giống Zalo PC: gộp cụm, mốc thời gian, tên và ảnh đại diện, từng loại
  tin, thao tác trên tin, trạng thái gửi, thanh ghim, cuộn, chuyển hội thoại (`G036:25`).
- Chỉ phần hiển thị; luật nghiệp vụ ở spec gốc (`G036:27`, `G036:379`).
- Phạm vi: hội thoại **nhóm và 1-1**, khung chat **390px → 1600px**, **tiếng Việt và tiếng Anh** (`G036:31-33`).
- Hai chỗ cố ý khác Zalo: tên nhân viên kèm giờ ở tin cuối cụm (BR07); tin thu hồi / đã xoá giữ nội dung (BR20) (`G036:39-40`).
- Không đổi dữ liệu (`G036:65`). Dev: FE; một chỗ cần BE là trạng thái `Đã nhận` / `Đã xem` (`G036:173`, `G036:363`).

## 3. Actor, precondition, trigger

| Mục | Nội dung | Nguồn | Nhãn |
| --- | --- | --- | --- |
| Actor | Người dùng có quyền xem hội thoại (theo G003) | `G036:63` | `[NGUỒN]` |
| Trigger | Mở một hội thoại (nhóm hoặc 1-1) | `G036:61` | `[NGUỒN]` |
| Post-condition | Khung hội thoại hiển thị đúng quy tắc; không thay đổi dữ liệu | `G036:65` | `[NGUỒN]` |

## 4. Use case và luồng

| Mã | Tên | Luồng | Nguồn |
| --- | --- | --- | --- |
| UC-01 | Mở hội thoại | Đã mở trong ~5 phút → hiện ngay + tải lại ngầm; lần đầu → tải từ lúc nhấn chuột xuống; mở ở tin mới nhất; dựng cụm / mốc / tên / avatar / giờ; gửi *đã đọc* sau khi tải xong | `G036:71-77` |
| UC-02 | Cuộn lên đọc tin cũ | Tải khi còn ~3 màn hình tới đầu; chèn tin cũ, tin đang xem đứng yên | `G036:79-83` |
| UC-03 | Thao tác trên một tin | Rê chuột → Trả lời · Chuyển tiếp · "…" + nút 👍; xử lý theo spec gốc | `G036:85-89` |
| AF01–AF06 | Tin mới khi ở đáy / khi đọc tin cũ · người dùng tự cuộn · nhảy tới tin · qua 0 giờ · màn cảm ứng | | `G036:108-113` |
| E01 | Tin gửi lỗi → viền đỏ + "Thử lại", ở bất kỳ vị trí nào | | `G036:121` |
| E02 | Ngày giờ tin không đọc được → không hiện mốc | | `G036:122` |
| E03 | Ảnh / video đang tải → khung chờ đúng tỉ lệ | | `G036:123` |
| E04 | Trang web không có xem trước → chỉ dòng link | | `G036:124` |
| Ngoại lệ chung | Không quyền xem, mất kết nối, lỗi hệ thống, tài khoản Zalo ngắt kết nối → theo G003 | | `G036:126` |

## 5. Business rule (G036, `G036:134-161`) `[NGUỒN]`

| Mã | Tóm tắt | Nhóm |
| --- | --- | --- |
| BR01 | Gộp cụm khi thoả cả 4: cùng người gửi (phía mình: cùng **nhân viên**) · cùng ngày · cách ≤ 30 phút · không phải tin đứng riêng (tin hệ thống, bình chọn) | Cụm & mốc |
| BR02 | Khoảng cách 4px trong cụm · 8px giữa cụm · 16px quanh tin đứng riêng · 0 ngay trước mốc | Cụm & mốc |
| BR03 | Khi nào hiện mốc: trước tin đầu danh sách · sang ngày (chỉ ngày) · cùng ngày cách > 30 phút (giờ + ngày) · tin thường sau tin đứng riêng (giờ + ngày) | Cụm & mốc |
| BR04 | Định dạng mốc: Hôm nay · Hôm qua · trong 30 ngày thứ + ngày · cũ hơn 30 ngày ngày đầy đủ; bảng 7 trường hợp §10B | Cụm & mốc |
| BR05 | Qua 0 giờ tự đổi nhãn; ngày giờ lỗi → không mốc; tiếng Anh `Today` · `Yesterday` · `Sun/Mon/…` | Cụm & mốc |
| BR06 | Tên khách: chỉ trong nhóm, chỉ tin đầu cụm; 1-1 không tên; ưu tiên tên gợi nhớ; 13px | Tên, avatar, giờ |
| BR07 | Phía mình: không tên phía trên; tên nhân viên đi kèm giờ ở tin cuối cụm | Tên, avatar, giờ |
| BR08 | Avatar 40px, chỉ tin đầu cụm, căn đỉnh; khách trái, nhân viên phải | Tên, avatar, giờ |
| BR09 | Giờ chỉ ở tin cuối cụm; tin chữ trong khung; ảnh / video / sticker ô nhỏ dưới ảnh | Tên, avatar, giờ |
| BR10 | Trưởng / phó nhóm: chìa khoá vàng / xám ở góc avatar, tooltip; viền xanh nhạt; chỉ khi nhóm bật "Làm nổi tin nhắn trưởng và phó nhóm" (G026 BR03) và người gửi còn vai trò đó | Trưởng / phó |
| BR11 | Khung tin: mình xanh nhạt, khách trắng; chữ 15px; rộng ≤ 90% khung và ≤ 720px | Loại tin |
| BR12 | Link, @tên màu xanh, không gạch chân, @tên không đậm; link dài ngắt dòng | Loại tin |
| BR13 | Trích dẫn trong khung tin chữ; trích ảnh 40px + `[Hình ảnh]`; trích tin mình → tên tài khoản; bấm → nhảy tới tin gốc | Loại tin |
| BR14 | Ảnh / video đúng tỉ lệ, ≤ 360 × 368px; chú thích dính dưới; đang tải → khung chờ | Loại tin |
| BR15 | Hàng sticker theo §10D (≤ 3 / hàng, cách < 5 phút, cùng cụm, sticker thu hồi / trả lời đứng riêng…); mỗi sticker vẫn là tin riêng | Loại tin |
| BR16 | Thẻ tệp 376px, biểu tượng theo loại, dung lượng thật, tên một lần | Loại tin |
| BR17 | Thẻ link: ảnh 306 × 161, tiêu đề 1 dòng, mô tả 2 dòng, tên miền xanh; không ảnh → ô nhỏ trái; không xem trước → dòng link | Loại tin |
| BR18 | Danh thiếp, tài khoản ngân hàng, ghi âm co theo khung | Loại tin |
| BR19 | Tin hệ thống: avatar nhỏ + tên đậm; tin ghim không kèm ảnh; ghim / trích dẫn trỏ tới tin hệ thống nhảy tới được kể cả khi thu gọn | Loại tin |
| BR20 | Tin thu hồi / đã xoá giữ nội dung; không 👍, không trạng thái gửi | Loại tin |
| BR21 | Rê chuột: Trả lời · Chuyển tiếp · "…" (sticker thêm Tải sticker); "…" mở đúng menu chuột phải tại vị trí nút | Thao tác |
| BR22 | Nút 👍 góc phải dưới; luôn hiện ở tin cuối của khách; bấm = Thích; rê ~0,4 giây = bảng cảm xúc; rời chuột thì đóng | Thao tác |
| BR23 | Cảm xúc đã thả ở góc phải dưới, không đè tin dưới | Thao tác |
| BR24 | Một ô trạng thái dưới tin cuối hội thoại nếu là của mình; khách nhắn sau thì biến mất; `Đang gửi → Đã gửi → Đã nhận → Đã xem`; tin lỗi viền đỏ + "Thử lại" mọi vị trí | Trạng thái gửi |
| BR25 | Thanh ghim theo §10E (ghim mới nhất, `+N ghim`, bảng danh sách, nút "…", bàn phím) | Thanh ghim |
| BR26 | Cuộn: mở ở tin mới nhất; tải tin cũ ở ~3 màn hình, tin đang xem đứng yên; không giành quyền cuộn; nhảy tới tin tô sáng vài giây | Cuộn & chuyển |
| BR27 | Chuyển hội thoại: ~5 phút → hiện ngay, tải ngầm, bổ sung tin tới; lần đầu tải từ lúc nhấn chuột xuống; *đã đọc* gửi sau khi tải xong | Cuộn & chuyển |
| BR28 | 390–1600px không tràn, không cuộn ngang; co theo khung; màn cảm ứng nút luôn hiện; mọi nhãn có tiếng Anh | Màn hình & ngôn ngữ |

Acceptance criteria: 37 mục ở `G036:245-306`, mỗi mục gắn `AC-BRxx`. Ngoài phạm vi OOS01–OOS05 (`G036:314-318`).
State machine, data model, API: N/A (`G036:167`, `G036:173`). §15 có số đo hiệu năng "trên môi trường dev" (`G036:348-355`).

Rule liên quan ở spec khác:

| Mã | Nội dung | Nguồn |
| --- | --- | --- |
| G026 BR01 | Gopany **không có "phó nhóm"**; mọi chỗ Zalo ghi "trưởng và phó nhóm" → dùng "trưởng nhóm", vd toggle *"Làm nổi tin nhắn trưởng nhóm"* | `G026:19`, `G026:128`, `G026:193` |
| G026 BR03 | Toggle **"Làm nổi tin nhắn trưởng nhóm"**: BẬT → tin **trưởng nhóm** nổi bật bằng **nhãn "Trưởng nhóm" cạnh tên + màu viền khác** | `G026:54`, `G026:130` |
| G003 AF05 / bảng hiển thị | Tin gửi từ điện thoại (không qua web Gopany): nội dung + thời gian, **không hiện tên người gửi** | `G003:252-256`, `G003:458` |
| G003 BR07 / bảng hiển thị | Tin thu hồi / xoá: **style disable + label "Đã thu hồi" / "Đã xóa"**, nội dung gốc vẫn hiện | `G003:185`, `G003:303`, `G003:459` |
| G003 §7 | Trạng thái tin: Đang gửi · Đã gửi · Lỗi gửi (sau 3 phút, đỏ + Retry) · Đã xem (icon avatar người xem) · Đã thu hồi · Đã xóa — **không có "Đã nhận"** | `G003:333-341` |
| G009 BR04 | Tin thu hồi: ẩn icon react và reply | `G009:232` |
| G003 BR19 | Tin thu hồi: ẩn "Chuyển tiếp" | `G003:315` |
| G032 BR03 / BR04 | BR03 = ghi tên gợi nhớ lên Zalo; BR04 = khác trường "Họ tên" G011a | `G032:137-138` |

## 6. Mã lỗi, thông báo

Không có mã lỗi API. Nhãn hiển thị nguyên văn: `Hôm nay` · `Hôm qua` · `Today` · `Yesterday` · `Sun/Mon/…` ·
`Thử lại` · `Đang gửi` · `Đã gửi` · `Đã nhận` · `Đã xem` · `[Hình ảnh]` · `[Nhãn dán]` · `[Tập tin]` · `Tin nhắn` ·
`+N ghim` · `Danh sách ghim (tổng số)` · `Thu gọn` · `Copy` · `Bỏ ghim tin nhắn` · `Trưởng nhóm` · `Phó nhóm` ·
`Tải sticker` (`G036:121`, `G036:138`, `G036:157`, `G036:205-211`, `G036:234-238`, `G036:143`, `G036:154`).

## 7. Trạng thái

N/A cho G036 — vòng đời trạng thái gửi ở G003 §7; G036 chỉ quy định hiện ở đâu (`G036:167`).

## 8. Diễn giải, giả định, QA observation

| # | Nội dung | Nhãn | Liên quan |
| ---: | --- | --- | --- |
| 1 | Với tin thu hồi, nút Trả lời và Chuyển tiếp trong BR21 bị ẩn theo luật nghiệp vụ ở G009 BR04 và G003 BR19; G036 chỉ nói thêm "không có 👍" | `[DIỄN GIẢI AI]` | BR20, BR21 |
| 2 | "Trước: …" ở cột Chi tiết của bảng BR là mô tả hiện trạng cũ, dùng được làm căn cứ cho case hồi quy (đo trên build trước sửa) | `[DIỄN GIẢI AI]` | BR01–BR28 |
| 3 | Nhiều kích thước px (4 / 8 / 16 / 13 / 15 / 40 / 360 × 368 / 376 / 306 × 161 / 720) chỉ kiểm được bằng DevTools hoặc so ảnh; cần thống nhất dung sai | `[QA BỔ SUNG]` | BR02, BR06, BR08, BR11, BR14, BR16, BR17 |
| 4 | Kiểm qua 0 giờ, mốc 30 ngày, tin cũ hơn 30 phút cần dữ liệu có thời điểm gửi khác nhau hoặc chỉnh đồng hồ | `[QA BỔ SUNG]` | BR03–BR05 |

## 9. Điểm chưa rõ (chuyển sang Debate)

| # | Loại | Trích dẫn + nguồn | Vì sao chưa rõ | Đề xuất mức |
| ---: | --- | --- | --- | --- |
| 1 | Mâu thuẫn | `G036:143` BR10 chìa khoá **vàng = trưởng, xám = phó**, toggle *"Làm nổi tin nhắn trưởng **và phó** nhóm"* (G026 BR03); `G026:128` BR01 **không có phó nhóm**, toggle *"Làm nổi tin nhắn trưởng nhóm"*; `G026:130` cách nổi là **nhãn "Trưởng nhóm" cạnh tên** + viền khác | (i) Hệ thống có vai trò phó nhóm không. (ii) Tên toggle. (iii) Cách hiển thị: chìa khoá ở avatar hay nhãn cạnh tên | Trọng yếu |
| 2 | Thiếu | `G036:134` BR01 phía mình gộp theo **nhân viên**; `G036:140` BR07 tên nhân viên + giờ; `G036:141` BR08 avatar nhân viên; `G003:252-256`, `G003:458` tin gửi từ điện thoại **không có nhân viên**, không hiện tên | Tin chủ tài khoản gửi từ điện thoại: gộp cụm với ai, tin cuối cụm hiện gì thay tên nhân viên, avatar là ảnh gì | Trọng yếu |
| 3 | Thiếu / lệch | `G036:153` BR20 chỉ ghi "giữ nội dung, không 👍, không trạng thái gửi"; `G003:185`, `G003:459` style disable + label "Đã thu hồi" / "Đã xóa" | Label và style disable của G003 còn áp dụng không, khi G036 là nơi duy nhất quy định hiển thị | Không trọng yếu |
| 4 | Giới hạn build | `G036:157` 4 mức trạng thái; `G036:173`, `G036:365` BE chỉ trả `Đã gửi`; `G003:333-336` không có "Đã nhận", "Đã xem" là icon avatar | Case `Đã nhận` / `Đã xem` chưa chạy được; "Đã xem" ở G036 là chữ hay avatar | Không trọng yếu |
| 5 | Thiếu | `G036:136` BR03 ❶ "trước tin đầu tiên của danh sách" | Mốc này ghi chỉ ngày hay giờ + ngày | Không trọng yếu |
| 6 | Mơ hồ ngưỡng | `G036:134` "không quá 30 phút"; `G036:137` "trong 30 ngày"; `G036:160` "~5 phút"; `G036:159` "vài giây", "khoảng 3 màn hình"; `G036:348-355` số đo "trên môi trường dev" | Biên tính tới giây; 30 ngày có tính ngày thứ 30 không; các số "~" và §15 là tiêu chí pass hay tham khảo | Không trọng yếu |
| 7 | Thiếu | `G036:138` BR05 tiếng Anh chỉ có `Today` · `Yesterday` · `Sun/Mon/…` | Định dạng ngày đầy đủ và "thứ + ngày" bằng tiếng Anh | Không trọng yếu |
| 8 | Mơ hồ | `G036:32` "Bề ngang khung chat 390px → 1600px"; `G036:304` AC "390 · 640 · 1000 · 1600px" | Là bề ngang khung chat hay cửa sổ trình duyệt | Không trọng yếu |
| 9 | Thiếu | `G036:157` BR24 "dưới tin cuối cùng của hội thoại nếu tin đó là của phía mình"; `G036:227` §10D.5 trạng thái dưới cả hàng sticker | Sau tin mình là một tin hệ thống / bình chọn thì ô trạng thái còn không | Không trọng yếu |
| 10 | Mơ hồ | `G036:152` BR19 "Tin ghim không kèm ảnh" | "Tin ghim" là tin hệ thống báo đã ghim, hay tin được ghim | Không trọng yếu |
| 11 | Dẫn chiếu lệch | `G036:139` BR06 "ưu tiên tên gợi nhớ (G032 BR03)" — G032 BR03 là ghi tên lên Zalo; `G036:143` dẫn "G026 BR03" với tên toggle khác G026; chưa spec gốc nào trỏ sang G036 dù `G036:27` nói "Spec gốc trỏ sang G036" | Ghi chú cho BA cập nhật | Không trọng yếu |
| 12 | Trạng thái tài liệu | `G036:12` Status **Draft** | Viết test case trên bản Draft không | Người dùng chốt |

## 10. Tự rà soát

- [x] Mọi BR / AC / E ở mục 4–6 tìm thấy trong G036
- [x] Không mục `[NGUỒN]` nào thiếu tham chiếu
- [x] Mâu thuẫn G036 ↔ G026, G036 ↔ G003 đã liệt kê đủ hai phía
- [x] Mục 9 không chứa câu trả lời do AI tự chọn
- Giới hạn: G008, G015, G023, G025 chưa đọc; G003, G009, G014, G026 chỉ đọc các dòng liên quan

## 11. Quan hệ G036 ↔ G003: tham khảo hay bằng chứng thay đổi

Đọc lại ngày 2026-10-13 theo yêu cầu người dùng. Đối chiếu 8 chỗ G036 nhắc G003, cột "Trước: …" của bảng BR, và §10D,
§7, §11 của G003.

### 11.1 Tám chỗ G036 dẫn G003 — đều là **tham khảo / phụ thuộc nghiệp vụ còn hiệu lực**

| Dòng G036 | Nội dung | Loại | Hệ quả cho test |
| --- | --- | --- | --- |
| `G036:46` | Bảng "Spec gốc ↔ hiển thị": gửi, nhận, trạng thái tin thuộc G003; hiển thị ở BR01–09, BR11, BR24 | Chia quyền sở hữu: nghiệp vụ ở G003, hiển thị ở G036 | Kỳ vọng **hiển thị** lấy từ G036; kỳ vọng **nghiệp vụ** lấy từ G003 |
| `G036:55`, `G036:326` | Danh sách phụ thuộc | Tham khảo | — |
| `G036:63` | Quyền xem hội thoại theo G003 | G003 còn hiệu lực | Precondition |
| `G036:89` | Chọn thao tác — xử lý theo G003, G009 | G003 còn hiệu lực | Kết quả của thao tác (thu hồi, chuyển tiếp…) theo G003 |
| `G036:126` | Ngoại lệ chung theo G003 | G003 còn hiệu lực | Không viết lại case ngoại lệ chung trong G036 |
| `G036:167` | Vòng đời trạng thái gửi thuộc G003 §7 | G003 còn hiệu lực cho vòng đời; G036 chỉ quy định vị trí | — |
| `G036:173` | BE chỉ trả `Đã gửi` (G003 §7) | Tham khảo + giới hạn build | G003 §7 **không có** mức `Đã nhận` — G036 thêm mức mới mà G003 chưa có (Q-04) |

Không chỗ nào trong 8 chỗ trên là bằng chứng G003 đã đổi.

### 11.2 Bằng chứng thay đổi nằm ở đâu

- **Tuyên bố thẩm quyền:** G036 là "nơi duy nhất quy định tin nhắn trông thế nào"; "Spec gốc trỏ sang G036 cho phần hiển thị" (`G036:25`, `G036:27`). Đây là căn cứ để phần hiển thị của G003 bị thay.
- **Xác nhận của BA:** Q-13 (Trân, 2026-10-13) — "bác bỏ G003" cho tên của tin gửi từ điện thoại. Q-01 — "lấy theo G036" khi G036 lệch G026. `[ĐÃ XÁC NHẬN]`
- **Cột "Trước: …" của bảng BR mô tả bản build cũ, không phải câu chữ G003.** Tìm trong G003 không thấy "2 phút", "260×180", "✓✓", "vương miện", "DD/MM/YYYY", "1.0 MB", "vòng quay", "khối trích dẫn tách riêng". Vậy cột này là căn cứ cho case **hồi quy so với build cũ**, không phải chứng cứ G003 từng quy định như vậy. `[NGUỒN]` (kết quả tìm kiếm) + `[DIỄN GIẢI AI]` (kết luận)
- **G003 chưa được cập nhật:** G003 không nhắc G036; §10D và AC vẫn ghi cách hiển thị cũ (bảng 11.3).

### 11.3 Phần hiển thị của G003 bị G036 thay (G003 chưa sửa)

| G003 đang ghi | G036 quy định | Trạng thái |
| --- | --- | --- |
| Tin gửi từ web: "Nội dung + **tên người gửi** + thời gian" trên mỗi tin (`G003:457`); AC "tin hiển thị ngay với tên người gửi + thời gian" (`G003:565`); mỗi phần tin tách "hiển thị tên người gửi + thời gian" (`G003:87`) | Không tên phía trên; tên nhân viên + giờ chỉ ở **tin cuối cụm** (BR07, BR09) | Bị thay — `[NGUỒN]` G036:25 |
| Tin gửi từ điện thoại: "**không hiển thị tên người gửi**" (`G003:255`, `G003:458`) | Tên Zalo + giờ ở tin cuối cụm; avatar tài khoản Zalo; cụm riêng | Bị thay — `[ĐÃ XÁC NHẬN]` Q-02, Q-13 |
| Tin đang gửi: "icon loading tĩnh + label Đang gửi inline dưới tin" (`G003:460`, `G003:85`) | **Một** ô trạng thái dưới tin cuối của hội thoại (BR24) | Bị thay |
| Tin gửi thất bại: "**màu đỏ** + nút **Retry**" (`G003:461`, `G003:335`, `G003:576`) | **Viền đỏ** + nút **"Thử lại"**, ở mọi vị trí (BR24, E01) | Bị thay (nhãn nút đổi Retry → Thử lại) |
| Per-message: "Icon Reply", "Icon React" trên mỗi tin; hover → danh sách option (`G003:470-473`, `G003:456-458`) | Rê chuột: Trả lời · Chuyển tiếp · "…" (menu như chuột phải); 👍 góc phải dưới (BR21, BR22) | Bị thay về cách hiển thị; **tập thao tác được phép** theo từng loại tin vẫn ở G003 — Q-14 |
| Trạng thái đã xem: "icon avatar người đã đọc; nhóm → list avatar ngang" (`G003:474`, `G003:249`, `G003:615-616`, `G003:336`) | Mức `Đã xem` trong ô trạng thái (BR24); "Người đã xem…" trong menu "…" (BR21) | Bị thay một phần — Q-04 |
| Video: "nút download; **không view trực tiếp**" (`G003:467-469`) | Ảnh, video đúng tỉ lệ ≤ 360 × 368, khung chờ, giờ là ô nhỏ dưới ảnh (BR09, BR14) | Lệch — Q-15 |
| Mỗi phần tin tách có **trạng thái riêng** Đang gửi / Đã gửi / Lỗi gửi (`G003:299` BR03c) | Chỉ **một** ô trạng thái dưới tin cuối; lỗi thì viền đỏ ở mọi vị trí (BR24) | Lệch — Q-16 |
| Tin thu hồi / xoá: "style disable + label Đã thu hồi / Đã xóa" (`G003:459`, `G003:185`, BR07 `G003:303`) | Giữ nội dung, không 👍, không trạng thái gửi (BR20) — không nhắc label | Chưa rõ — Q-03 |
| Lịch sử tin: "20 tin gần nhất; scroll lên load thêm" (`G003:691`) | Tải tin cũ khi còn ~3 màn hình (BR26) | Thời điểm tải bị thay; số tin mỗi lần vẫn theo G003 `[DIỄN GIẢI AI]` |
| File: "icon download; click → download" (`G003:469`) | Thẻ tệp 376px, biểu tượng theo loại, dung lượng thật (BR16) | Hiển thị bị thay; hành vi click vẫn theo G003 `[DIỄN GIẢI AI]` |

### 11.4 Hệ quả cho test

- Case **G036**: kỳ vọng hiển thị theo G036 (+ câu trả lời BA); kỳ vọng hành vi sau thao tác theo G003.
- Case **hồi quy G003** (bộ cũ hoặc test G003 về sau): các AC `G003:565`, `G003:576`, `G003:615-616` và dòng §10D ở bảng 11.3 **không còn là kỳ vọng đúng** cho phần hiển thị; cần đánh dấu "bị G036 thay" thay vì báo fail.
- Đo build cũ theo cột "Trước: …" của G036 chỉ để làm mốc so sánh, không phải đối chiếu G003.

## 12. Từng spec phụ thuộc: lấy gì từ tài liệu gốc, phần nào bị G036 thay

Đọc lại ngày 2026-10-13 theo yêu cầu người dùng, sau câu trả lời Q-15 ("G036 chính là update của G003"). Nguyên tắc
rút ra từ `G036:25-27` và các xác nhận Q-01, Q-13, Q-15: **G036 thay toàn bộ phần "trông thế nào" trong khung hội
thoại của mọi spec gốc; spec gốc giữ phần "được làm gì, kết quả ra sao, dữ liệu gì".** Khi hai bên cùng nói về hiển
thị mà lệch nhau → theo G036, không cần hỏi lại (trừ chỗ G036 im lặng hoàn toàn).

| Spec gốc | **Lấy từ gốc** (nghiệp vụ, quyền, dữ liệu — vẫn hiệu lực) | **Bị G036 thay** (hiển thị trong khung chat) | Dòng gốc chưa cập nhật |
| --- | --- | --- | --- |
| **G003** Chat | Quyền xem hội thoại; luồng gửi / nhận; vòng đời trạng thái §7 (Đang gửi → Đã gửi → Lỗi gửi sau 3 phút → Đã xem; thu hồi ≤ 24h; xoá phía tôi); tập thao tác cho phép theo loại tin (`G003:456-458`, Q-14); ngoại lệ chung; chọn nhiều; 20 tin mỗi lần tải (`G003:691`); hành vi click file = tải về (`G003:469`) | Tên người gửi trên mỗi tin → chỉ tin cuối cụm (BR07); tin điện thoại "không tên" → tên Zalo + giờ (Q-13); "Đang gửi" dưới mỗi tin → một ô (BR24); "màu đỏ + Retry" → "viền đỏ + Thử lại" (BR24); icon Reply / React trên mỗi tin → 3 nút + 👍 khi rê chuột (BR21–22); avatar người xem → mức `Đã xem` trong ô trạng thái (BR24, còn Q-04); video "chỉ nút download" → hiện đúng tỉ lệ như ảnh (BR14, **Q-15 đã xác nhận**); thời điểm tải tin cũ → ~3 màn hình (BR26); file "icon download" → thẻ tệp 376px (BR16) | `G003:85-87`, `G003:255`, `G003:456-461`, `G003:470-474`, `G003:467-469`, `G003:565`, `G003:576`, `G003:615-616` |
| **G008** Quản lý nhóm | Vai trò trưởng / phó nhóm do Zalo giao; ai sửa tên / avatar nhóm; thành viên và role badge trong **panel thông tin nhóm** (`G008:117`) — panel này **ngoài** khung chat, không thuộc G036 | Dấu hiệu trưởng / phó **trên tin nhắn trong khung chat**: chìa khoá vàng / xám + viền xanh (BR10, Q-01) | Không có mục nào trong G008 nói cách hiện trên tin — không lệch. **Lưu ý:** G008 có "Phó nhóm" (`G008:25-26`, `G008:117`), khớp G036 và trái G026 BR01 — thêm bằng chứng cho Q-01 |
| **G009** React, Reply | Được react / reply tin nào (BR04: tin thu hồi ẩn cả hai); 6 emoji Zalo native, nhiều loại cùng lúc, gỡ react bằng icon gạch chéo; quote tối đa 100 ký tự, `[Hình ảnh]` / `[File]`, không đệ quy (BR05, BR07); quote preview **trong ô soạn** (`G009:301-303`) | Trên tin: "bong bóng hiện tối đa 3 emoji + tổng" dưới tin (`G009:69`, `G009:289`, `G009:355`) → cảm xúc ở **góc phải dưới** khung tin, không đè tin dưới (BR23); "quote block thu gọn phía trên nội dung" (`G009:98`, `G009:304`, `G009:371`) → trích dẫn **trong** khung tin, vạch xanh trái, ảnh 40px (BR13); "hover → icon emoji picker" (`G009:65`) → nút 👍 góc phải dưới, rê ~0,4s mở bảng (BR22) | `G009:65`, `G009:69`, `G009:98`, `G009:289`, `G009:304`, `G009:355`, `G009:371` |
| **G014** Ghim tin | Ai ghim được, tối đa 3 ghim, popup thay thế, đồng bộ hai chiều với Zalo, tin ghim bị thu hồi giữ ghim (BR07, BR14), danh sách đầy đủ cho mọi người có quyền (BR18), khu vực ghim ẩn khi 0 ghim (BR17) | Cách hiện khu vực ghim và popup: `G014 §10A-10B` (dòng "tên người gửi · nội dung rút gọn 100 ký tự", "số đếm", popup "Tin nhắn đã ghim") → thanh ghim §10E của G036 (ghim mới nhất, `+N ghim ⌄`, bảng `Danh sách ghim (tổng số)` nền mờ, nút "…" Copy / Bỏ ghim, bàn phím) (BR25) | `G014:154`, `G014:186-187`, `G014:494-523` |
| **G015** Thẻ xem trước link | Khi nào có xem trước (chỉ http/https, link đầu tiên, Open Graph → title/meta); lưu kèm tin, không crawl lại (BR09); crawl lỗi → text thường (E01); đóng preview trước khi gửi (AF01) | Hình dạng thẻ: "thumbnail 1:1 / 16:9, tiêu đề & mô tả **tối đa 2 dòng mỗi phần**" (`G015:144` BR03), "icon mặc định thay ảnh" (`G015:121` E05) → ảnh lớn **306×161**, tiêu đề **1 dòng**, mô tả 2 dòng, tên miền xanh, không ảnh → ô nhỏ trái (BR17). Tên miền viết thường bỏ `https://`, `www.` (BR03b) — G036 không nói ngược → **vẫn lấy từ G015** | `G015:121`, `G015:144` |
| **G023** Danh thiếp, nhãn dán | Gửi qua tài khoản nào, toggle kèm SĐT, picker, "Gần đây", quyền, DISCONNECTED; danh thiếp khi nhận hiển thị theo **G013** (SĐT text bên trên + card avatar + tên) | Kích thước: danh thiếp "co theo khung chat, không tràn" (BR18); sticker xếp **hàng** theo §10D, mỗi sticker vẫn là tin riêng (BR15); nút "Tải sticker" khi rê chuột (BR21) | G013 / G023 không quy định kích thước — không lệch; "Trước: mỗi sticker một dòng" (`G036:148`) là build cũ |
| **G025** Bình chọn | Ai tạo / đóng, quyền theo G026 BR05, kết quả không ẩn danh, thời hạn, card bình chọn và mọi thứ **bên trong** card (`G025:200-218`) | Chỉ **vị trí** của card trong dòng chảy tin: luôn là tin đứng riêng, tách cụm, 16px quanh, mốc giờ + ngày cho tin thường sau nó (BR01–BR03) | Không lệch — G025 không nói về cụm |
| **G026** Cài đặt nhóm | Toggle nằm ở đâu, ai bật, lưu lên Zalo | Cách làm nổi tin trưởng nhóm: "nhãn Trưởng nhóm cạnh tên + màu viền khác" (`G026:54`, `G026:130`) → chìa khoá ở avatar + viền xanh nhạt; có cả phó nhóm (BR10, **Q-01 đã xác nhận**) | `G026:19`, `G026:128`, `G026:130`, `G026:193` (không có phó nhóm) |
| **G032** Tên gợi nhớ | Tên là gì, ai đặt, ghi lên Zalo, dùng chung workspace (BR01), thay tên Zalo ở mọi nơi hiển thị (BR04), đồng bộ, lỗi E01–E09 | **Không thay gì** — G036 chỉ **dùng** tên gợi nhớ ở ba chỗ (tên khách đầu cụm BR06, tên trong trích dẫn BR13, tên trong tin hệ thống BR19) | `G036:139` dẫn "G032 BR03" nhưng quy tắc "thay tên ở mọi nơi" là **G032 BR04** (`G032:67`) — Q-11 |

### 12.1 Cách áp khi viết test case

- **Trace BR**: case hiển thị → `G036 BRxx`; case nghiệp vụ phát sinh từ thao tác trong khung chat → BR của spec gốc
  (vd `G003 BR06` thu hồi ≤ 24h, `G009 BR04`, `G014 BR07`). Case ghép (bấm "…" → Thu hồi → tin đổi hiển thị) ghi cả hai.
- **Kỳ vọng**: phần "trông thế nào" chỉ lấy từ G036 + câu trả lời BA; phần "chuyện gì xảy ra" lấy từ spec gốc.
- **Khi test hồi quy spec gốc** sau này: các dòng ở cột "Dòng gốc chưa cập nhật" không còn là kỳ vọng đúng — đánh dấu
  "bị G036 thay", không báo fail.
- **Chỗ G036 im lặng** mà spec gốc có nói về hiển thị (tên miền viết thường — G015 BR03b; quote 100 ký tự — G009 BR05;
  `[Hình ảnh]` / `[File]` trong quote — G009 BR05 so với `[Hình ảnh]` ở G036 BR13): vẫn theo spec gốc, ghi Trace cả hai.

## Lịch sử cập nhật

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
| 2026-10-13 | AI (Orchestrator) | Tạo bản đầu: 7 nguồn, 28 BR, 12 điểm chưa rõ (2 đề xuất trọng yếu) |
| 2026-10-13 | AI (Orchestrator) | Thêm §11 (G036 ↔ G003: tham khảo hay bằng chứng thay đổi) sau khi Hồng chuyển Q-13 của BA Trân |
| 2026-10-13 | AI (Orchestrator) | Thêm §12 (từng spec gốc: lấy gì / bị G036 thay gì) sau Q-15 của BA Trân |
| 2026-10-13 | AI (Orchestrator) | Sửa số dòng dẫn G003 `481-483` → `467-469` (CX phát hiện) |
