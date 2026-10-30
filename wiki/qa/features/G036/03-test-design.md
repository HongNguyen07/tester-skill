---
featureId: G036
basedOn: 02-alignment-summary.md (gate: open, 2026-10-13)
designedAt: 2026-10-13
---

# Test Design — G036: Giao diện khung hội thoại — giống Zalo PC

Viết tắt: `G036` = `tailieu/G036 - Giao diện khung hội thoại.md` (v1.0 Draft, 2026-10-09 — người dùng chốt dùng bản này, Q-12);
`G003`, `G009`, `G014`, `G015`, `G026` = tệp tương ứng trong `tailieu/`; `G032` = bản "Đổi tên gợi nhớ (1)". Số sau `:` là số dòng.
Nguyên tắc áp dụng (`[ĐÃ XÁC NHẬN]` #4 trong `02-…`): phần **trông thế nào** theo G036; phần **được làm gì, kết quả ra sao** theo
spec gốc; chỗ G036 im lặng → spec gốc. Phạm vi: web, hội thoại nhóm và 1-1, khung 390–1600px, tiếng Việt + tiếng Anh. Mobile ngoài phạm vi.

## 1. Use Case

| Mã | Tên | Actor | Nguồn |
| --- | --- | --- | --- |
| UC-01 | Mở hội thoại — hiện ngay / tải từ lúc nhấn chuột, mở ở tin mới nhất, dựng cụm · mốc · tên · avatar · giờ, gửi *đã đọc* sau khi tải xong | Người dùng có quyền xem hội thoại (G003) | `G036:71-77` |
| UC-02 | Cuộn lên đọc tin cũ — tải khi còn ~3 màn hình, tin đang xem đứng yên | Người dùng | `G036:79-83` |
| UC-03 | Thao tác trên một tin — rê chuột hiện Trả lời · Chuyển tiếp · "…" + nút 👍; xử lý theo spec gốc | Người dùng | `G036:85-89` |
| AF01 | Tin mới tới khi đang ở đáy → tự cuộn xuống | Hệ thống | `G036:108` |
| AF02 | Tin mới tới khi đang đọc tin cũ → giữ chỗ | Hệ thống | `G036:109` |
| AF03 | Người dùng tự cuộn khi hệ thống đang chỉnh vị trí → dừng chỉnh ngay | Hệ thống | `G036:110` |
| AF04 | Nhảy tới tin (ghim, trích dẫn, tìm kiếm) → tô sáng vài giây, không kéo về đáy; tin hệ thống đang thu gọn vẫn nhảy tới được | Hệ thống | `G036:111` |
| AF05 | Qua 0 giờ đêm khi đang mở màn chat → nhãn mốc tự đổi | Hệ thống | `G036:112` |
| AF06 | Màn cảm ứng → nút vốn chỉ hiện khi rê chuột thì luôn hiện | Hệ thống | `G036:113` |
| E01 | Tin gửi lỗi → viền đỏ + nút "Thử lại", ở bất kỳ vị trí nào | Hệ thống | `G036:121` |
| E02 | Ngày giờ tin không đọc được → không hiện mốc | Hệ thống | `G036:122` |
| E03 | Ảnh / video đang tải → khung chờ đúng tỉ lệ | Hệ thống | `G036:123` |
| E04 | Trang web không có thông tin xem trước → chỉ dòng link | Hệ thống | `G036:124` |

Ngoại lệ chung (không quyền xem, mất kết nối, lỗi hệ thống, tài khoản Zalo ngắt kết nối) theo G003 (`G036:126`) — không viết lại trong bộ này.

## 2. Business Rule

| Mã | Tóm tắt | Trạng thái hiểu | Nguồn |
| --- | --- | --- | --- |
| BR01 | Gộp cụm khi thoả cả 4: cùng người gửi (phía mình: cùng nhân viên) · cùng ngày · cách ≤ 30 phút **tính theo tin liền trước** · không tin đứng riêng (tin hệ thống, bình chọn) | `[NGUỒN]` + `[ĐÃ XÁC NHẬN]` Q-02, Q-13 (tin gửi từ điện thoại gộp cụm riêng, vẫn theo 3 điều kiện còn lại); Debate D1-1 → D1-5a — còn mở Q-06 (biên đúng 30:00) | `G036:134` |
| BR02 | Khoảng cách 4px trong cụm · 8px giữa cụm · 16px quanh tin đứng riêng · 0 ngay trước mốc | `[NGUỒN]` | `G036:135` |
| BR03 | Hiện mốc: trước tin đầu danh sách · sang ngày (chỉ ngày) · cùng ngày cách > 30 phút (giờ + ngày) · tin thường sau tin đứng riêng (giờ + ngày). Không xét người gửi; giờ trong mốc = giờ tin đứng sau mốc | `[NGUỒN]` (Debate D4-1, D4-2) — còn mở Q-05 (định dạng mốc trước tin đầu) | `G036:136` |
| BR04 | Định dạng mốc: Hôm nay · Hôm qua · trong 30 ngày thứ + ngày · cũ hơn 30 ngày ngày đầy đủ; mốc giờ ghép giờ phía trước; 7 trường hợp §10B | `[NGUỒN]` — còn mở Q-06 (ngày thứ 30) | `G036:137`, `G036:201-211` |
| BR05 | Qua 0 giờ **mọi** mốc đang hiện tự đổi nhãn; ngày giờ lỗi → không mốc; tiếng Anh `Today` · `Yesterday` · `Sun/Mon/…` | `[NGUỒN]` (Debate D4-3: "mọi nhãn tự cập nhật"; các bước chuyển ngoài ví dụ `Hôm nay → Hôm qua` và "không sinh mốc / không tách cụm" D4-4 là `[DIỄN GIẢI AI]` → ĐO & GHI) — còn mở Q-07 (định dạng ngày tiếng Anh) | `G036:138` |
| BR06 | Tên khách: chỉ trong nhóm, chỉ tin đầu cụm; 1-1 không tên; ưu tiên tên gợi nhớ; 13px | `[NGUỒN]` (tên gợi nhớ thay tên Zalo: G032 BR04 — Q-11 chỉ lệch dẫn chiếu) | `G036:139` |
| BR07 | Phía mình không tên phía trên; tên nhân viên + giờ ở tin cuối cụm, đi cùng vị trí giờ theo BR09 | `[NGUỒN]` + `[ĐÃ XÁC NHẬN]` Q-13 (cụm điện thoại: tên Zalo + giờ) | `G036:140` |
| BR08 | Avatar 40px, chỉ tin đầu cụm, căn đỉnh; khách trái, nhân viên phải | `[NGUỒN]` + `[ĐÃ XÁC NHẬN]` Q-13 (cụm điện thoại: avatar tài khoản Zalo) | `G036:141` |
| BR09 | Giờ chỉ ở tin cuối cụm; tin chữ trong khung; ảnh / video / sticker ô nhỏ dưới ảnh | `[NGUỒN]` | `G036:142` |
| BR10 | Phía khách: chìa khoá vàng (trưởng) / xám (phó) ở góc avatar tin đầu cụm, tooltip "Trưởng nhóm" / "Phó nhóm", viền xanh nhạt mọi tin trong cụm. Phía mình (tài khoản Zalo là trưởng / phó): **chỉ viền xanh, không chìa khoá**; áp cho mọi tin phía mình (mọi nhân viên, cụm điện thoại). Chỉ khi nhóm bật "Làm nổi tin nhắn trưởng và phó nhóm" **và** người gửi còn vai trò — dấu phản ánh trạng thái hiện tại (tắt cài đặt / gỡ quyền / rời nhóm → mọi tin cũ mất dấu) | `[ĐÃ XÁC NHẬN]` Q-01 — theo G036; **không dùng G026** cho phần hiển thị; Debate D2-1 → D2-5 `[NGUỒN]` | `G036:143`, `G036:213-219` |
| BR11 | Khung tin: mình xanh nhạt, khách trắng; bo góc, không viền, bóng mờ; chữ 15px; rộng ≤ 90% khung và ≤ 720px | `[NGUỒN]` | `G036:144` |
| BR12 | Link, @tên màu xanh, không gạch chân, @tên không đậm; link dài ngắt dòng | `[NGUỒN]` | `G036:145` |
| BR13 | Trích dẫn trong khung tin chữ: vạch xanh trái, tên người được trích + nội dung; trích ảnh / video: ảnh 40px + `[Hình ảnh]`; trích tin tài khoản mình → tên tài khoản (không phân biệt nhân viên — D5-14); bấm → nhảy tới tin gốc | `[NGUỒN]`; chỗ im lặng (quote cắt 100 ký tự, tệp → `[File]`) theo G009 BR05 `[NGUỒN]` — còn mở Q-29 (trả lời bằng sticker / ảnh, D5-15) | `G036:146`; `G009:233` |
| BR14 | Ảnh / video đúng tỉ lệ, rộng ≤ 360px, cao ≤ 368px; chú thích dính dưới, cùng bề ngang; đang tải → khung chờ | `[NGUỒN]` + `[ĐÃ XÁC NHẬN]` Q-15 (video hiển thị theo BR14); **bấm vào video** còn mở (Q-15, diễn giải AI: tải về theo `G003:468`); ảnh nhỏ hơn trần không phóng to là `[DIỄN GIẢI AI]` → Q-30 (D5-16) | `G036:147` |
| BR15 | Hàng sticker theo §10D: ≤ 3 / hàng, mỗi sticker < 5 phút sau sticker trước, cùng cụm, sticker thu hồi / trả lời đứng riêng, giờ dưới sticker cuối hàng, trạng thái dưới cả hàng, chọn nhiều mỗi sticker một ô; mỗi sticker vẫn là tin riêng | `[NGUỒN]` | `G036:148`, `G036:221-228` |
| BR16 | Thẻ tệp 376px (co khi hẹp), biểu tượng theo loại, dung lượng thật, tên một lần | `[NGUỒN]`; bấm thẻ → tải về theo `G003:469` `[NGUỒN]` | `G036:149` |
| BR17 | Thẻ link: ảnh 306×161 trên, tiêu đề 1 dòng, mô tả 2 dòng, tên miền xanh; không ảnh → ô nhỏ trái; không xem trước → dòng link | `[NGUỒN]`; tên miền viết thường, bỏ `https://`, `www.` theo G015 BR03b; nhiều link → một thẻ cho link đầu theo G015 BR04 `[NGUỒN]` (D5-18); dấu "…" khi cắt: ĐO & GHI (D5-17) | `G036:150`; `G015:145-146` |
| BR18 | Danh thiếp, tài khoản ngân hàng, ghi âm co theo khung, không tràn | `[NGUỒN]` | `G036:151` |
| BR19 | Tin hệ thống: avatar nhỏ người làm + tên in đậm (tên gợi nhớ nếu có); tin ghim không kèm ảnh; ghim / trích dẫn trỏ tới tin hệ thống nhảy tới được kể cả khi thu gọn | `[NGUỒN]` — còn mở Q-10 ("tin ghim không kèm ảnh") | `G036:152` |
| BR20 | Tin thu hồi / đã xoá giữ nội dung; không 👍, không trạng thái gửi | `[NGUỒN]` — còn mở Q-03 (nhãn "Đã thu hồi" + style disable) | `G036:153` |
| BR21 | Rê chuột: 3 nút Trả lời · Chuyển tiếp · "…"; sticker thêm Tải sticker; "…" mở đúng menu chuột phải tại vị trí nút | `[NGUỒN]` — còn mở Q-14 (menu theo loại tin) | `G036:154` |
| BR22 | 👍 góc phải dưới; hiện khi rê; luôn hiện ở tin cuối của khách; bấm = Thích; rê ~0,4 giây = bảng cảm xúc; rời chuột không vào bảng → đóng | `[NGUỒN]` (0,4 giây: không đo chính xác — Q-06 cùng loại số "~") | `G036:155` |
| BR23 | Cảm xúc đã thả ở góc phải dưới, không đè tin dưới | `[NGUỒN]` | `G036:156` |
| BR24 | Một ô trạng thái dưới tin cuối hội thoại nếu là của mình (không phân biệt web / điện thoại — D1-5b); khách nhắn sau → biến mất; `Đang gửi` → `Đã gửi` → `Đã nhận` → `Đã xem`; tin lỗi viền đỏ + "Thử lại" mọi vị trí | `[NGUỒN]` — còn mở Q-04 (BE chỉ trả `Đã gửi`; "Đã xem" chữ hay avatar), Q-09 (thêm ý D1-5c: mức của tin điện thoại), Q-16 | `G036:157`, `G036:365` |
| BR25 | Thanh ghim theo §10E: ghim mới nhất (= ghim gần đây nhất, LIFO theo G014 BR08 — D5-9), `[Hình ảnh]` · `[Nhãn dán]` · `[Tập tin]`, `+N ghim ⌄` (N = tổng − 1, ≤ 2 — D5-8), bảng `Danh sách ghim (tổng số)` nền mờ, "Thu gọn", nút "…" Copy / Bỏ ghim tin nhắn, bàn phím; 0 ghim → ẩn (G014 BR17) | `[NGUỒN]`; thanh chuyển sang ghim kế khi bỏ ghim là `[DIỄN GIẢI AI]` → ĐO & GHI (D5-10) — còn mở Q-17, Q-19 | `G036:158`, `G036:230-239`; `G014:408`, `G014:417` |
| BR26 | Cuộn: mở ở tin mới nhất; tải tin cũ ở ~3 màn hình, tin đang xem đứng yên (AC: lệch 0–1px); không giành quyền cuộn; tin mới ở đáy tự cuộn / đang đọc giữ chỗ; nhảy tới tin tô sáng vài giây | `[NGUỒN]` — "~3 màn hình", "vài giây" là số "~" (Q-06): ĐO & GHI | `G036:159`, `G036:297` |
| BR27 | Chuyển hội thoại: ~5 phút → hiện ngay, không vòng quay, tải ngầm, bổ sung tin / thu hồi / cảm xúc tới trong lúc rời; lần đầu tải từ lúc nhấn chuột xuống; *đã đọc* sau khi tải xong | `[NGUỒN]` — "~5 phút" (Q-06): ĐO & GHI | `G036:160` |
| BR28 | 390–1600px không tràn, không cuộn ngang; thẻ tệp, link, danh thiếp, ngân hàng, ảnh co theo khung; màn cảm ứng nút luôn hiện; mọi nhãn có tiếng Anh | `[NGUỒN]` — còn mở Q-08 (khung chat hay cửa sổ) | `G036:161`, `G036:304-306` |

## 3. Decision Table

### DT-1 — BR01 Gộp cụm (`G036:134` + Q-02, Q-13)

Hai tin liền nhau A (trước) và B (sau). "Cùng người gửi" phía khách = cùng một người trong nhóm; phía mình = cùng một nhân viên; tin chủ tài
khoản gửi từ điện thoại là một "người gửi" riêng (`[ĐÃ XÁC NHẬN]` Q-02).

C3 xét theo **tin liền trước** (A), không tính từ tin đầu cụm (Debate D1-4a `[NGUỒN]`): chuỗi 09:00 · 09:25 · 09:50 · 10:15 là một cụm. Đổi người gửi chỉ tách cụm, **không** sinh mốc (D4-1).

| Điều kiện / Hành động | R1 | R2 | R3 | R4 | R5 | R6 | R7 | R8 | R9 | R10 | R11 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| C1: Cùng người gửi | Có | Không (khách khác) | Không (nhân viên khác, cùng tài khoản Zalo — kể cả xen kẽ A · B · A) | Có | Có | Có | Có | Không (nhân viên ↔ điện thoại) | Có (điện thoại ↔ điện thoại) | Có | Có |
| C2: Cùng ngày | Có | Có | Có | Không | Có | Có | Có | Có | Có | Có | Có |
| C3: B cách A (tin liền trước) ≤ 30 phút | Có | Có | Có | — | Không (> 30) | Có | Có | Có | Có | **= 30:00** | Có (nhưng B cách tin đầu cụm > 30) |
| C4: Không tin nào là tin đứng riêng | Có | Có | Có | Có | Có | Không (B là tin hệ thống / bình chọn) | Không (A là tin đứng riêng) | Có | Có | Có | Có |
| → Kết quả (nguồn) | Cùng cụm | Cụm mới, không mốc (D4-1) | Cụm mới (`G036:134` "hai nhân viên dùng chung một tài khoản Zalo vẫn là hai cụm") | Cụm mới + mốc chỉ ngày (BR03 ❷) | Cụm mới + mốc giờ + ngày (BR03 ❸), giờ = giờ của B (D4-2) | B đứng riêng, 16px quanh (BR02) | B bắt đầu cụm mới + mốc giờ + ngày (BR03 ❹) | Cụm riêng (`[ĐÃ XÁC NHẬN]` Q-02) | Cùng cụm (`[ĐÃ XÁC NHẬN]` Q-13 iii) | ❓ Q-06 | Cùng cụm, không mốc (`G036:134` "tin sau cách tin trước"; D1-4a) |
| Case | 01, 02 | 04, 165 | 03, 163 | 06 | 05, 17 | 07, 08 | 07, 18 | 09 | 10 | 11 | 164 |

### DT-2 — BR03 / BR04 / BR05 Mốc thời gian (`G036:136-138`, `G036:201-211`; ví dụ hôm nay = 09/10/2026)

| Điều kiện / Hành động | R1 | R2 | R3 | R4 | R5 | R6 | R7 | R8 | R9 | R10 | R11 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| C1: Vị trí — sang ngày (S) / cùng ngày cách > 30' hoặc sau tin đứng riêng (G) / trước tin đầu danh sách (Đ) / cùng ngày ≤ 30', tin thường liền nhau (K) | S | S | S | S | G | G | G | Đ | K | S | S |
| C2: Ngày của tin — hôm nay / hôm qua / ≤ 30 ngày / > 30 ngày | hôm nay | hôm qua | ≤ 30 ngày | > 30 ngày | hôm nay | hôm qua | ngày khác | — | — | = ngày thứ 30 | hôm nay |
| C3: Ngôn ngữ | VI | VI | VI | VI | VI | VI | VI | VI | VI | VI | EN |
| C4: Ngày giờ tin đọc được | Có | Có | Có | Có | Có | Có | Có | Có | Có | Có | Có |
| → Mốc (nguồn) | `Hôm nay` | `Hôm qua` | thứ + ngày, vd `T3 23/09/2026`, `CN 04/10/2026` | `23/08/2026` | `20:47 Hôm nay` | `09:05 Hôm qua` | `09:05 23/09/2026` | Có mốc; định dạng ❓ Q-05 | Không mốc | ❓ Q-06 | `Today` (hôm qua: `Yesterday`; thứ: `Sun/Mon/…`; phần ngày ❓ Q-07) |
| Case | 21 | 22 | 23, 24 | 25 | 26 | 27 | 28 | 19 | 20 | 29 | 32, 33, 34 |

R12 (ngoài bảng): C4 = Không (ngày giờ không đọc được) → không hiện mốc, không ô trống (E02) — case 31. Qua 0 giờ khi đang mở → nhãn tự đổi (AF05) — case 30.

### DT-3 — BR10 Trưởng / phó nhóm (`G036:143`, `G036:213-219`, `[ĐÃ XÁC NHẬN]` Q-01)

Hai điều kiện phải **cùng đúng** và dấu phản ánh **trạng thái hiện tại** (Debate D2-1 `[NGUỒN]`): đổi điều kiện → mọi tin cũ cũng đổi theo. Vai trò thuộc **tài khoản Zalo** (D2-4). Phía mình chỉ có viền, **không chìa khoá** (D2-3 — AI sửa cách đọc theo Hồng).

| Điều kiện / Hành động | R1 | R2 | R3 | R4 | R5 | R6 | R7 | R8 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| C1: Nhóm bật "Làm nổi tin nhắn trưởng và phó nhóm" | Có | Có | Không (vừa tắt) | Có | Có | Có | Có | Có |
| C2: Vai trò người gửi **tại lúc xem** | Trưởng (khách) | Phó (khách) | Trưởng / phó | Thành viên thường | Đã rời / bị xoá (từng là trưởng / phó) | Bị gỡ quyền, **vẫn trong nhóm** | Tài khoản Zalo đang dùng là trưởng / phó (tin phía mình, một nhân viên) | Tài khoản Zalo là trưởng / phó (tin phía mình của nhân viên khác và cụm gửi từ điện thoại) |
| → Kết quả (nguồn) | Một chìa vàng ở avatar tin đầu cụm + tooltip "Trưởng nhóm" + viền xanh nhạt mọi tin trong cụm (D2-2) | Chìa xám + tooltip "Phó nhóm" + viền xanh nhạt | Không chìa, không viền — kể cả tin đã gửi trước khi tắt | Không dấu | Không còn dấu ở mọi tin cũ | Không còn dấu ở mọi tin cũ (`G036:143` "vẫn còn… vai trò đó"; AC `G036:265` chỉ nêu rời / bị xoá) | Chỉ viền xanh, **không** chìa khoá (`G036:143`, `G036:218`, `G036:266`) | Chỉ viền xanh ở **mọi** cụm phía mình, không chìa khoá (`G036:143` vai trò thuộc tài khoản) |
| Case | 46 | 47 | 48 | 51 | 49 | 167 | 50 | 168 |

Các BR còn lại không có logic điều kiện kết hợp — không lập bảng.

## 4. State Transition

Không áp dụng — G036 §7 ghi **N/A**: vòng đời trạng thái gửi thuộc G003 §7 (`G003:333-339`); G036 chỉ quy định hiện ở đâu (`G036:167`).
Case BR24 dùng G003 §7 cho bước chuyển `Đang gửi → Đã gửi`, `Lỗi gửi → Đang gửi` khi bấm "Thử lại" (Trace ghi cả hai).

## 5. Risk Analysis `[QA BỔ SUNG]`

| # | Rủi ro | Impact | Likelihood | Căn cứ | Liên quan BR / Q |
| ---: | --- | --- | --- | --- | --- |
| 1 | Gộp cụm sai khi hội thoại có tin nhân viên xen tin gửi từ điện thoại, hoặc hai nhân viên chung tài khoản | Cao (tên / giờ / avatar gắn sai người) | Chưa có dữ liệu | Logic cụm mới hoàn toàn so với build cũ (2 phút → 30 phút + 4 điều kiện); phần điện thoại chỉ mới xác nhận qua Q-02 / Q-13, spec chưa ghi | BR01, BR07, BR08 · Q-02, Q-13 |
| 2 | Mốc thời gian sai quanh biên: 0 giờ, 30 phút, 30 ngày | Trung bình | Chưa có dữ liệu | Biên chưa chốt tới giây / ngày (Q-06); nhãn phải tự đổi không tải lại (AF05) | BR03–BR05 · Q-05, Q-06 |
| 3 | Dấu trưởng / phó nhóm hiện theo cách cũ của G026 (nhãn cạnh tên) hoặc thiếu phó nhóm | Cao (xung đột spec) | Trung bình | G026 BR01 / BR03 chưa cập nhật, Dev có thể theo G026 | BR10 · Q-01, Q-11 |
| 4 | Ô trạng thái gửi: hiện ở nhiều tin, hoặc không biến mất khi khách nhắn; mức `Đã nhận` / `Đã xem` chưa chạy được | Trung bình | Cao (BE chỉ trả `Đã gửi`, `G036:365`) | Giới hạn build ghi trong spec; trường hợp tin hệ thống sau tin mình, tin tách nhiều phần chưa có câu trả lời | BR24 · Q-04, Q-09, Q-16 |
| 5 | Kích thước px (4/8/16/13/15/40/360×368/376/306×161/720) lệch nhỏ, không có dung sai thống nhất → tranh cãi pass / fail | Thấp | Cao | Spec chỉ ghi số, không ghi dung sai | BR02, BR06, BR08, BR11, BR14, BR16, BR17 |
| 6 | Cuộn: tin đang xem nhảy khi chèn tin cũ, ảnh tải muộn đẩy lệch đáy | Cao (trải nghiệm đọc) | Trung bình | Build cũ nhảy 180–350px (`G036:159` "Trước:") | BR26 |
| 7 | Hành vi nghiệp vụ sau thao tác (thu hồi, menu "…" theo loại tin, bấm video) làm theo G036 thay vì spec gốc, hoặc ngược lại | Trung bình | Trung bình | Chia quyền sở hữu hiển thị / nghiệp vụ mới được xác nhận; spec gốc chưa trỏ sang G036 | BR14, BR20, BR21 · Q-03, Q-14, Q-15 |
| 8 | Tiếng Anh thiếu nhãn / hiện tên mã | Trung bình | Trung bình | Build cũ thiếu 14 nhãn (`G036:161` "Trước:"); spec không liệt kê nhãn tiếng Anh ngoài `Today` · `Yesterday` · `Sun/Mon/…` | BR05, BR28 · Q-07 |
| 9 | Bề ngang hẹp 390px làm tràn thẻ tệp / link / danh thiếp | Trung bình | Chưa có dữ liệu | Cách dựng môi trường 390px chưa rõ (khung chat hay cửa sổ) | BR18, BR28 · Q-08 |

## 6. Coverage Matrix

Mã case = `[G036_NN]`. Case `❓` không tính là đã phủ. Trạng thái "Một phần" = có case chắc chắn nhưng một nhánh còn `❓`.

| BR / AC | Use Case | Decision / State | Scenario | Case nhóm A | Trạng thái | Ghi chú |
| --- | --- | --- | --- | --- | --- | --- |
| BR01 · AC-BR01 | UC-01 | DT-1 | SC-01, SC-21 | 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 163, 164 | Một phần | 11 ❓ Q-06 (biên đúng 30:00); 163 (D1-1), 164 (D1-4a) thêm sau Debate |
| BR02 · AC-BR02 | UC-01 | DT-1 | SC-01 | 12, 13, 14, 15 | Đã phủ | px cần dung sai (nhóm B 148) |
| BR03 · AC-BR03 | UC-01 | DT-2 | SC-02 | 16, 17, 18, 19, 20, 165 | Một phần | 19 ❓ Q-05; 17 sửa, 165 thêm theo D4-1, D4-2 |
| BR04 · AC-BR04 | UC-01 | DT-2 | SC-02 | 21, 22, 23, 24, 25, 26, 27, 28, 29 | Một phần | 29 ❓ Q-06 (ngày thứ 30) |
| BR05 · AC-BR05 / AF05 / E02 | AF05, E02 | DT-2 | SC-02 | 30, 166, 31, 32, 33, 34 | Một phần | 34 ❓ Q-07 (phần ngày tiếng Anh); 166 (D4-3 mọi mốc tự đổi; D4-4 ĐO & GHI) |
| BR06 · AC-BR06 | UC-01 | — | SC-03 | 35, 36, 37 | Đã phủ | |
| BR07 · AC-BR07 | UC-01 | — | SC-03, SC-21 | 38, 39, 40 | Đã phủ | 40 theo `[ĐÃ XÁC NHẬN]` Q-13 |
| BR08 · AC-BR08 | UC-01 | — | SC-03, SC-21 | 41, 42, 43 | Đã phủ | 43 theo `[ĐÃ XÁC NHẬN]` Q-13 |
| BR09 · AC-BR09 | UC-01 | — | SC-03 | 44, 45 | Đã phủ | |
| BR10 · AC-BR10 | UC-01 | DT-3 | SC-04 | 46, 47, 48, 49, 50, 51, 167, 168 | Đã phủ | Theo `[ĐÃ XÁC NHẬN]` Q-01; 50 sửa theo D2-3 (bỏ chìa khoá phía mình); 46, 48 sửa theo D2-2, D2-1; 167 (gỡ quyền vẫn trong nhóm), 168 (vai trò thuộc tài khoản) thêm |
| BR11 · AC-BR11 | UC-01 | — | SC-05 | 52, 53, 54 | Đã phủ | |
| BR12 · AC-BR12 | UC-01 | — | SC-05 | 55, 56, 57 | Đã phủ | 55, 56, 57 sửa theo D3-5 (cả hai phía; chữ thường xuống dòng theo từ) |
| BR13 · AC-BR13 | UC-01, AF04 | — | SC-06 | 58, 59, 60, 61, 62, 63, 169 | Một phần | 62, 63 trace thêm G009 BR05; 60 sửa theo D5-14; 169 ❓ Q-29 (trả lời bằng sticker / ảnh — D5-15) |
| BR14 · AC-BR14 / E03 | UC-01, E03 | — | SC-07 | 64, 65, 66, 67, 68, 69, 170 | Một phần | 69 ❓ Q-15 (bấm vào video); 170 ❓ Q-30 (ảnh nhỏ — D5-16) |
| BR15 · AC-BR15 | UC-01, UC-03 | — | SC-08 | 70, 71, 72, 73, 74, 75, 76 | Đã phủ | 70 sửa theo D5-1 (tính theo sticker liền trước); 71 sửa theo D5-2 (hàng mới vẫn cùng cụm, px ĐO & GHI); D5-3 → nhóm B 175 |
| BR16 · AC-BR16 | UC-01 | — | SC-09 | 77, 78, 79, 80 | Đã phủ | 80 trace thêm G003 UC-02c |
| BR17 · AC-BR17 / E04 | UC-01, E04 | — | SC-10 | 81, 82, 83, 84, 171 | Đã phủ | 82 trace thêm G015 BR03b; 171 trace thêm G015 BR04 (nhiều link → một thẻ, D5-18); 81 Note dấu "…" ĐO & GHI (D5-17) |
| BR18 · AC-BR18 | UC-01 | — | SC-11 | 85, 86, 87 | Đã phủ | |
| BR19 · AC-BR19 / AF04 | UC-01, AF04 | — | SC-12 | 88, 89, 90, 91, 92 | Một phần | 92 ❓ Q-10 |
| BR20 · AC-BR20 | UC-03 | — | SC-13 | 93, 94, 95, 96 | Một phần | 95 ❓ Q-03; 96 trace thêm G009 BR04, G003 BR19 |
| BR21 · AC-BR21 | UC-03 | — | SC-14 | 97, 98, 99, 100, 101 | Một phần | 100 ❓ Q-14 |
| BR22 · AC-BR22 | UC-03 | — | SC-15 | 102, 103, 104, 105, 106 | Đã phủ | 0,4 giây không đo chính xác |
| BR23 · AC-BR23 | UC-03 | — | SC-15 | 107, 108 | Đã phủ | 107 sửa theo D3-6: kiểm "không đè", khoảng cách nới thêm ĐO & GHI |
| BR24 · AC-BR24 / E01 | UC-01, E01 | G003 §7 | SC-16 | 109, 110, 111, 112, 113, 114, 115, 116, 172 | Một phần | 112 ❓ Q-04 (chặn BE); 115 ❓ Q-09; 116 ❓ Q-16; 172 (D1-5b: tin điện thoại là tin cuối vẫn có ô — phần "có ô" chắc chắn) ❓ Q-09 chỉ phần mức trong ô (D1-5c) |
| BR25 · AC-BR25 | UC-01, AF04 | — | SC-17 | 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 173, 174 | Một phần | 119 ❓ Q-17; 130 trace thêm G014 BR17; 173 trace thêm G014 BR08 (LIFO — D5-9); 174 bỏ ghim 3 → 0 (D5-10; ghim nào lên thanh ĐO & GHI) |
| BR26 · AC-BR26 / UC-02 / AF01–AF04 | UC-01, UC-02, AF01–AF04 | — | SC-18 | 131, 132, 133, 134, 135, 136 | Đã phủ | "~3 màn hình", "vài giây": ĐO & GHI (nhóm B 156); ranh giới "ở đáy" (D5-5 `[DIỄN GIẢI AI]`) → nhóm B 176, Q-28 |
| BR27 · AC-BR27 / UC-01 | UC-01 | — | SC-19 | 137, 138, 139, 140 | Đã phủ | "~5 phút" và mốc tính từ lúc rời (D5-11): ĐO & GHI (nhóm B 156); không nhảy trang / tự cuộn (D5-12): ĐO & GHI ở 138; tải lại lỗi → đã đọc (D5-13) → nhóm B 177, Q-06 |
| BR28 · AC-BR28 / AF06 | AF06 | — | SC-20 | 141, 142, 143, 144, 145, 146, 147 | Đã phủ | Cách dựng 390–1600 là giả định (Q-08), ghi ở Precondition; 145 Note ngưỡng co ~418px ĐO & GHI (D3-3); 146 thêm Tải sticker, tooltip trên cảm ứng không kiểm (D5-19, Q-22) |
| E01 | E01 | — | SC-16 | 113 | Đã phủ | |
| E02 | E02 | — | SC-02 | 31 | Đã phủ | |
| E03 | E03 | — | SC-07 | 67 | Đã phủ | |
| E04 | E04 | — | SC-10 | 84 | Đã phủ | |
| AF01 / AF02 / AF03 / AF04 | AF01–AF04 | — | SC-18, SC-12, SC-06 | 133, 134, 135, 136, 90, 91, 61 | Đã phủ | |
| AF05 / AF06 | AF05, AF06 | — | SC-02, SC-20 | 30, 166, 146 | Đã phủ | |

Tổng: 28 BR — **17 Đã phủ · 11 Một phần · 0 Chưa phủ** (BR13 chuyển từ Đã phủ sang Một phần vì thêm 169 ❓ Q-29). 4 E, 6 AF đều có case.

Lỗ hổng:
- Requirement không có case: không có.
- Case không có nguồn: không có ở nhóm A; các kỳ vọng không có nguồn đã đưa sang nhóm B (ĐO & GHI).
- Coverage chưa rõ: 15 case `❓` nhóm A (11, 19, 29, 34, 69, 92, 95, 100, 112, 115, 116, 119, 169, 170, 172) chờ Q-03, Q-04, Q-05, Q-06, Q-07, Q-09, Q-10, Q-14, Q-15, Q-16, Q-17, Q-29, Q-30; nhóm B có 2 case `❓` (176 Q-28, 177 Q-06) — không tính vào độ phủ.
- Điểm `[DIỄN GIẢI AI]` của Debate (D1-5c, D3-2, D3-3 ngưỡng ~418, D3-6 số px nới, D4-3 bước ngoài ví dụ, D4-4, D5-2 4px, D5-3, D5-5, D5-10 thanh chuyển ghim kế, D5-11, D5-12, D5-13 tải lỗi, D5-16 không phóng to, D5-17 dấu "…") **không** là tiêu chí pass ở case nào — ghi ĐO & GHI hoặc `❓` theo Q đã gắn. D3-2 (tin ngắn khung ôm chữ) không có case riêng: không có nguồn để viết kỳ vọng, không thêm.

Loại coverage đã cân nhắc và không áp dụng:
- Permission / Security — quyền xem hội thoại theo G003 (`G036:63`, `G036:126`), ngoài phạm vi G036.
- Integration / API — G036 §8/§9 N/A, thuần hiển thị (`G036:173`); chỉ kiểm thứ tự request ở BR27 (case 139, 140) qua Network tab.
- Concurrency — không có yêu cầu; realtime tin tới kiểm ở AF01 / AF02 / BR27.
- Performance — §15 ghi "đo trên môi trường dev", không phải SLA (Q-06) → ĐO & GHI ở nhóm B, không làm tiêu chí pass.
- AI-specific — sản phẩm không có tính năng AI.
- Accessibility — OOS04 (phím Tab) ngoài phạm vi; bàn phím trên thanh ghim có nguồn (§10E) → case 128, 129.

## 7. Test Scenario

| SC | Mô tả | BR / AC | Use Case | Loại coverage | Nhóm |
| --- | --- | --- | --- | --- | --- |
| SC-01 | Dựng cụm và khoảng cách giữa tin / cụm / tin đứng riêng / mốc | BR01, BR02 | UC-01 | Positive, Negative, Boundary, UI | A |
| SC-02 | Mốc thời gian: khi nào hiện, định dạng 7 trường hợp, qua 0 giờ, ngày giờ lỗi, tiếng Anh | BR03, BR04, BR05, E02, AF05 | UC-01, AF05, E02 | Positive, Negative, Boundary, Exception | A |
| SC-03 | Tên người gửi, avatar, giờ gửi ở tin đầu / cuối cụm, nhóm và 1-1 | BR06, BR07, BR08, BR09 | UC-01 | Positive, Negative, UI | A |
| SC-04 | Dấu trưởng / phó nhóm theo toggle và vai trò | BR10 | UC-01 | Positive, Negative, Permission-like (vai trò) | A |
| SC-05 | Khung tin: màu, chữ, bề ngang; link và @tên | BR11, BR12 | UC-01 | UI, Boundary | A |
| SC-06 | Trích dẫn khi trả lời: vị trí, nội dung, nhãn, nhảy tới tin gốc | BR13 (+ G009 BR05) | UC-01, AF04 | Positive, UI | A |
| SC-07 | Ảnh / video: tỉ lệ, kích thước tối đa, chú thích, khung chờ, bấm video | BR14, E03 | UC-01, E03 | UI, Boundary, Exception | A |
| SC-08 | Hàng sticker theo §10D, mỗi sticker là tin riêng | BR15 | UC-01, UC-03 | Positive, Negative, Boundary | A |
| SC-09 | Thẻ tệp: kích thước, biểu tượng, dung lượng, tên, bấm tải | BR16 (+ G003 UC-02c) | UC-01 | UI, Positive | A |
| SC-10 | Thẻ xem trước link: đầy đủ / không ảnh / không xem trước; tên miền | BR17, E04 (+ G015 BR03b) | UC-01, E04 | UI, Exception | A |
| SC-11 | Danh thiếp, tài khoản ngân hàng, ghi âm co theo khung | BR18 | UC-01 | UI, Compatibility | A |
| SC-12 | Tin hệ thống: avatar, tên đậm, nhảy tới khi thu gọn | BR19, AF04 | UC-01, AF04 | Positive, UI | A |
| SC-13 | Tin thu hồi / đã xoá: nội dung, 👍, trạng thái, nút thao tác | BR20 (+ G009 BR04, G003 BR19) | UC-03 | Positive, Negative | A |
| SC-14 | Rê chuột lên tin: 3 nút, Tải sticker, menu "…" | BR21 | UC-03 | Positive, Negative, UI | A |
| SC-15 | Nút 👍 và cảm xúc đã thả | BR22, BR23 (+ G009 BR01, BR03) | UC-03 | Positive, Negative, UI | A |
| SC-16 | Ô trạng thái gửi và tin gửi lỗi | BR24, E01 (+ G003 §7) | UC-01, E01 | Positive, Negative, Exception | A |
| SC-17 | Thanh ghim: ghim mới nhất, `+N ghim`, bảng danh sách, nút "…", bàn phím | BR25 (+ G014 BR17) | UC-01, AF04 | Positive, Negative, UI, Accessibility (bàn phím) | A |
| SC-18 | Cuộn: mở ở tin mới nhất, tải tin cũ, tin mới tới, không giành quyền cuộn, nhảy tới tin | BR26, UC-02, AF01–AF04 | UC-01, UC-02, AF01–AF04 | Positive, UI | A |
| SC-19 | Chuyển hội thoại: hiện ngay / tải ngầm / tải từ lúc nhấn chuột / đã đọc | BR27 | UC-01 | Positive, Integration (thứ tự request) | A |
| SC-20 | Bề ngang 390 · 640 · 1000 · 1600, màn cảm ứng, tiếng Anh | BR28, AF06 | AF06 | Compatibility, UI | A |
| SC-21 | Cụm tin chủ tài khoản gửi từ điện thoại xen tin nhân viên (Q-02, Q-13) | BR01, BR07, BR08 | UC-01 | Positive, Data integrity | A |
| SC-22 | Đo kích thước với dung sai; đo build cũ theo cột "Trước: …" làm mốc hồi quy | BR02, BR11, BR14, BR16, BR17 (liên quan) | — | Baseline, Regression | B |
| SC-23 | Biên 29:59 / 30:01, qua 0 giờ bằng chỉnh đồng hồ, số "~" và §15, tải lại lỗi khi mở lại hội thoại | BR01, BR05, BR26, BR27 (liên quan) | — | Boundary, Performance, Exception (ĐO & GHI) | B |
| SC-24 | Exploratory: hội thoại nhiều trăm tin, nhiều loại tin xen kẽ, đổi ngôn ngữ giữa chừng, kéo đổi bề ngang, avatar lỗi, tin cuối là tin lỗi, cảm xúc ngoài 6 emoji, bảng cảm xúc giữ khi rê vào, tin đang ghim bị thu hồi, tin chữ chen giữa hai sticker, ranh giới "ở đáy" | BR01, BR08, BR15, BR22, BR23, BR24, BR25, BR26, BR28 (liên quan) | — | Edge case, Exploratory | B |

## 8. Testcase Summary

| Nhóm | Số case | Positive | Negative | Edge case | Khác (UI / Performance) | Có `❓ Cần chốt` |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| A. Theo requirement | 159 | 86 | 27 | 12 | 34 (UI) | 15 |
| B. QA bổ sung | 18 | 0 | 0 | 17 | 1 (Performance) | 2 |

Đếm bằng script (Python, tách ô theo `|`) trên `04-testcases.md` ngày 2026-10-13 sau rà Debate S4b (xem Lịch sử cập nhật). Chi tiết case: `04-testcases.md`.

## 9. Regression Scope

| Khu vực | Vì sao bị ảnh hưởng | Căn cứ | Giới hạn phân tích |
| --- | --- | --- | --- |
| Build cũ — toàn bộ khung chat | Cột "Trước: …" của bảng BR mô tả hành vi cũ bị thay: gộp 2 phút, mốc chỉ khi sang ngày dạng `DD/MM/YYYY`, `✓✓` ở mọi tin, ảnh 260×180, dung lượng "1.0 MB", tên tệp lặp, link gạch chân, vương miện cạnh tên, thẻ link có nút "Mở trong…", tải tin cũ làm nhảy 180–350px, luôn vòng quay chờ, thiếu 14 nhãn tiếng Anh | `G036:134-161` cột Chi tiết | Là mô tả build, không phải câu chữ spec gốc; chỉ dùng làm mốc so sánh (nhóm B 149) |
| G003 §10D bảng hiển thị tin, UC-02a b4–b6, AF05, AC | Các dòng sau **không còn là kỳ vọng đúng** cho hiển thị: tên người gửi trên mỗi tin (`G003:457`, `G003:565`, `G003:87`); tin điện thoại "không hiển thị tên" (`G003:255`, `G003:458`); "Đang gửi" inline dưới mỗi tin (`G003:460`, `G003:85`); "màu đỏ + Retry" (`G003:461`, `G003:335`, `G003:576`); icon Reply / React trên mỗi tin (`G003:472-473`); avatar người đã xem (`G003:474`, `G003:249`, `G003:615-616`); video "không view trực tiếp" (`G003:468`); mỗi phần tin tách có trạng thái riêng (`G003:299`); tải lịch sử "scroll lên load thêm" (`G003:691` — thời điểm tải đổi, 20 tin / lần vẫn theo G003) | `01-…` §11.3, §12; `[ĐÃ XÁC NHẬN]` #4 | Khi chạy hồi quy G003 phải đánh dấu "bị G036 thay", không báo fail. Phần "Đã xem" (Q-04) và tin tách nhiều phần (Q-16) chưa chốt → chưa đủ dữ liệu để loại trừ |
| G026 BR01 / BR03 / OOS01 — cài đặt làm nổi tin trưởng nhóm | Hiển thị "nhãn Trưởng nhóm cạnh tên + màu viền khác", "không có phó nhóm" bị thay bằng chìa khoá vàng / xám + viền xanh nhạt, có phó nhóm | `G026:128`, `G026:130`, `G026:193`; Q-01 `[ĐÃ XÁC NHẬN]` | Toggle nằm ở đâu, ai bật, lưu lên Zalo vẫn theo G026 — không kiểm lại trong bộ này |
| G009 §10A / §10B — react, reply | "Bong bóng react dưới tin" (`G009:69`, `G009:289`, `G009:355`) → góc phải dưới (BR23); "quote block phía trên nội dung" (`G009:98`, `G009:304`, `G009:371`) → trong khung tin (BR13); "hover → icon emoji picker" (`G009:65`) → nút 👍 (BR22) | `01-…` §12 | Luật react (6 emoji, nhiều loại, gỡ bằng gạch chéo, tối đa 3 + tổng), quote 100 ký tự, `[File]` vẫn theo G009 — case 62, 63, 105, 108 trace cả hai |
| G014 §10A / §10B — khu vực ghim, popup | Cách hiện khu vực ghim và popup "Tin nhắn đã ghim" (`G014:154`, `G014:186-187`) → thanh ghim §10E (BR25) | `01-…` §12 | Tối đa 3 ghim, tin ghim bị thu hồi giữ ghim (G014 BR07), ẩn khi 0 ghim (BR17) vẫn theo G014 — case 130, nhóm B 158 |
| G015 BR03 / E05 — thẻ xem trước | "Thumbnail 1:1 / 16:9, tiêu đề & mô tả 2 dòng", "icon mặc định thay ảnh" → 306×161, tiêu đề 1 dòng, ô nhỏ trái (BR17) | `G015:144`, `G015:121`; `01-…` §12 | Tên miền viết thường (BR03b) vẫn theo G015 — case 82 |
| G023 / G025 / G032 / G008 | G036 chỉ thêm kích thước / vị trí (BR15, BR18, BR01 bình chọn đứng riêng) hoặc chỉ dùng tên gợi nhớ — không lệch | `01-…` §12 | Chưa đọc toàn bộ G008, G023, G025 → chưa đủ dữ liệu để loại trừ hoàn toàn |
| CR-004 (tách tin dài) | Tin tách nhiều phần: ô trạng thái theo G036 BR24 hay từng phần theo G003 BR03c | Q-16 | Chưa chốt — case 116 ❓ |

## 10. Automation Candidate

| Case | Lý do phù hợp | Dependency · data · môi trường | Trạng thái |
| --- | --- | --- | --- |
| 01–10, 163, 164 (gộp cụm), 16–18, 20–28, 165 (mốc thời gian) | Logic thuần, đầu vào là thời điểm gửi; kiểm được bằng DOM (số cụm, mốc, nhãn); giá trị hồi quy cao | Seed hội thoại với thời điểm gửi cố định (API / DB test); mock đồng hồ trình duyệt; selector ổn định cho cụm / mốc | Candidate |
| 12–15 (khoảng cách), 41, 52–54, 64–65, 77, 81 (kích thước) | Đo bằng `getBoundingClientRect` / computed style, lặp lại được; cần dung sai thống nhất (nhóm B 148) | Dữ liệu mẫu từng loại tin; viewport cố định; dung sai ±1px (giả định, cần chốt) | Candidate |
| 141–144 (4 bề ngang) | Chạy cùng kịch bản ở 4 viewport, kiểm `scrollWidth ≤ clientWidth` | Cách dựng 390–1600 (Q-08); dữ liệu đủ loại tin | Candidate |
| 32–34, 147 (tiếng Anh) | So nhãn theo bảng; phát hiện tên mã | Chuyển ngôn ngữ EN; danh sách nhãn có nguồn | Candidate |
| 109–111, 113 (ô trạng thái, tin lỗi) | Kiểm số ô trạng thái = 1 và vị trí; tin lỗi có viền đỏ + "Thử lại" | Mock hub-chat-zalo trả lỗi / chậm; BE chỉ trả `Đã gửi` | Candidate |
| 30, 139, 140, 132 | Phụ thuộc đồng hồ thật, thứ tự request, đo px khi cuộn — chi phí bảo trì cao | — | Không đề xuất (chạy tay) |

Chưa có script nào — không ghi `Automated`.

## 11. Điểm cần quay lại Debate

### 11.1 Điểm Debate S4b đã xử lý khi rà lại (2026-10-13, D1-1 → D5-19 trong `02-…` §4.2)

| Điểm D | Nhãn | Xử lý trong `04-…` |
| --- | --- | --- |
| D1-1 | `[NGUỒN]` | Thêm 163 (A · A · B · A → ba cụm); 03 giữ nguyên |
| D1-2 | `[NGUỒN]` | 37: ghi rõ avatar vẫn có ở tin đầu cụm 1-1 |
| D1-3 | `[NGUỒN]` | 07: thêm tham chiếu mốc giờ + ngày (chi tiết ở 18) và 16px (14) |
| D1-4a | `[NGUỒN]` | Thêm 164 (chuỗi 09:00 · 09:25 · 09:50 · 10:15 → một cụm); DT-1 thêm R11 |
| D1-4b | `[NGUỒN]` | 06 đã khớp — không đổi |
| D1-5a | `[ĐÃ XÁC NHẬN]` | 09, 40, 43 đã khớp — không đổi |
| D1-5b | `[NGUỒN]` | Thêm 172 (tin điện thoại là tin cuối phía mình vẫn có một ô) |
| D1-5c | `[DIỄN GIẢI AI]` | 172 Note `❓ Q-09` chỉ phần mức trong ô |
| D2-1 | `[NGUỒN]` | 48 sửa (tắt cài đặt → tin cũ cũng mất dấu); thêm 167 (gỡ quyền, vẫn trong nhóm); 49 giữ; DT-3 thêm R6 |
| D2-2 | `[NGUỒN]` | 46 sửa: cụm 2 tin, một chìa khoá ở avatar tin đầu, viền mọi tin |
| D2-3 | `[NGUỒN]` | **50 sửa Expected**: chỉ viền xanh, không chìa khoá ở avatar nhân viên (bản đầu kỳ vọng sai); DT-3 R7 |
| D2-4 | `[NGUỒN]` | Thêm 168 (mọi cụm phía mình — hai nhân viên + điện thoại — đều viền, không chìa khoá); DT-3 R8 |
| D2-5 | `[ĐÃ XÁC NHẬN]` | 46 đã ghi "không nhãn cạnh tên (G026)" — không đổi |
| D3-1 | `[NGUỒN]` | 53 (1600 → ≤ 720), 54 (640 → ≤ 576) đã khớp — không đổi |
| D3-2 | `[DIỄN GIẢI AI]` | Không case nào dùng làm tiêu chí; không thêm case (không có nguồn) |
| D3-3 | `[NGUỒN]` + `[DIỄN GIẢI AI]` | 77, 145 đã khớp; 145 Note: ngưỡng ~418px ĐO & GHI |
| D3-4 | `[NGUỒN]` | 14, 15 đã khớp — không đổi |
| D3-5 | `[NGUỒN]` | 55, 56 sửa: kiểm cả tin khách và tin mình; 57 thêm "chữ thường xuống dòng theo từ" |
| D3-6 | `[NGUỒN]` + `[DIỄN GIẢI AI]` | 107 sửa: bỏ ràng buộc "cách 4px" ở Precondition, kiểm "không đè", khoảng cách ĐO & GHI |
| D4-1 | `[NGUỒN]` | 17 sửa (khách 09:00 → mình 09:45 có mốc); thêm 165 (đổi người ≤ 30 phút không mốc) |
| D4-2 | `[NGUỒN]` | 17 ghi rõ giờ trong mốc = giờ tin đứng sau; 26, 27, 28 đã đúng theo ví dụ nguồn |
| D4-3 | `[NGUỒN]` + `[DIỄN GIẢI AI]` | 30 giữ (ví dụ có nguồn); thêm 166: mọi mốc tự đổi là tiêu chí, nhãn đích của các bước ngoài ví dụ ĐO & GHI |
| D4-4 | `[DIỄN GIẢI AI]` | 166 Note ĐO & GHI: đếm số mốc / số cụm trước – sau 0 giờ |
| D5-1 | `[NGUỒN]` | 70 sửa: 09:00 · 09:04 · 09:08 (tính theo sticker liền trước) |
| D5-2 | `[NGUỒN]` + `[DIỄN GIẢI AI]` | 71 sửa: hàng 2 vẫn cùng cụm; khoảng cách hai hàng ĐO & GHI |
| D5-3 | `[DIỄN GIẢI AI]` | Nhóm B 175 (sticker · chữ · sticker) ĐO & GHI |
| D5-4 | `[NGUỒN]` | 75, 76 đã khớp — không đổi |
| D5-5 | `[DIỄN GIẢI AI]` | 133, 134 chỉ kiểm hai cực; nhóm B 176 `❓ Q-28` cho vùng xám |
| D5-6 | `[NGUỒN]` | 135 đã khớp — không đổi |
| D5-7 | `[NGUỒN]` | 132 (0–1px) và nhóm B 156 (~3 màn hình) đã khớp — không đổi |
| D5-8 | `[NGUỒN]` | 120, 122 đã khớp — không đổi |
| D5-9 | `[NGUỒN]` | Thêm 173, Trace `BR25 · G014 BR08` (LIFO; tin mới đến không đổi thứ tự) |
| D5-10 | `[NGUỒN]` + `[DIỄN GIẢI AI]` | Thêm 174 (bỏ ghim 3 → 2 → 1 → 0: `+N` giảm, 1 ghim không nút, 0 ghim ẩn); ghim nào lên thanh ĐO & GHI |
| D5-11 | `[DIỄN GIẢI AI]` | 137, 156 Note: mốc ~5 phút tính từ lúc rời → Q-06 |
| D5-12 | `[NGUỒN]` + `[DIỄN GIẢI AI]` | 138 Note: không nhảy trang / tự cuộn ĐO & GHI |
| D5-13 | `[NGUỒN]` + `[DIỄN GIẢI AI]` + `[QA BỔ SUNG]` | 140 giữ; nhóm B 177 `❓ Q-06` (tải lỗi → đã đọc); 139 đã dùng DevTools mousedown |
| D5-14 | `[NGUỒN]` | 60 sửa: ghi rõ không hiện tên nhân viên |
| D5-15 | `[CẦN XÁC NHẬN]` | Thêm 169 `❓ Q-29` (trả lời bằng sticker / ảnh) |
| D5-16 | `[NGUỒN]` + `[DIỄN GIẢI AI]` | 64, 65, 66 đã khớp; thêm 170 `❓ Q-30` (ảnh 200×150) |
| D5-17 | `[NGUỒN]` | 81, 83, 84 đã khớp; 81 Note dấu "…" ĐO & GHI |
| D5-18 | `[NGUỒN]` | Thêm 171, Trace `BR17 · G015 BR04` (nhiều link → một thẻ cho link đầu) |
| D5-19 | `[NGUỒN]` | 146 thêm Tải sticker; tooltip trên cảm ứng không kiểm (Q-22); 147 đã khớp |

Không phát hiện điểm tài liệu chưa rõ **mới** khi rà; không có điểm D nào thiếu case tương ứng sau khi rà.

### 11.2 Điểm mới phát hiện khi thiết kế (bản đầu)

Điểm mới phát hiện khi thiết kế, chưa có trong `02-…` lúc đó. Không chọn cách hiểu; case liên quan đánh `❓`. Q-17, Q-19 đã được Hồng chốt không trọng yếu và đưa vào bảng câu hỏi `02-…` (2026-10-13).

| # | Nội dung + nguồn | Đề xuất mức | Case bị ảnh hưởng |
| ---: | --- | --- | --- |
| Q-17 | `G036:234` §10E: "Ghim tin của chính tài khoản mình mà **không có tên** → hiện **tên tài khoản**". Sau Q-13, tin gửi từ điện thoại đã có "tên Zalo" ở tin cuối cụm — vậy "không có tên" chỉ loại tin nào (tin gửi từ điện thoại? tin gửi từ web khi thiếu tên nhân viên?), và "tên tài khoản" có trùng "tên Zalo" của Q-13 không | Không trọng yếu (đề xuất) | 119 |
| Q-18 | ~~`01-…` §11.3 / §12 dẫn video "không view trực tiếp" ở `G003:481-483`; dòng thật là `G003:468-469`~~ **Đã giải quyết** — `01-…` đã được sửa thành `G003:467-469` / `G003:469` trên đĩa lúc 10:00 ngày 2026-10-13 (phát hiện khi thiết kế; giữ mã Q-18 để không tái sử dụng số) | Không còn | 69, 80 (Note ghi `G003:468` / `G003:469`) |
| Q-19 | `G036:146` BR13 "Trích ảnh/video: ảnh nhỏ 40px + `[Hình ảnh]`" — video cũng dùng nhãn `[Hình ảnh]`; `G014:414` BR14 dùng `[Video]` cho danh sách ghim; `G036:234` thanh ghim chỉ có `[Hình ảnh]` · `[Nhãn dán]` · `[Tập tin]`, không có nhãn cho video. Ghim video hiện nhãn gì | Không trọng yếu (đề xuất) | 118 (viết theo 3 nhãn có nguồn; video không đưa vào Data) |

## Lịch sử cập nhật

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
| 2026-10-13 | AI (Test Designer) — người dùng: Hồng (QA) | Tạo bản đầu: 13 UC/AF/E, 28 BR, DT-1 · DT-2 · DT-3, Coverage Matrix 28 BR (18 Đã phủ · 10 Một phần · 0 Chưa phủ), 24 Scenario, Regression Scope, Automation Candidate, 3 điểm mới Q-17 → Q-19 |
| 2026-10-13 | AI (Test Designer) — người dùng: Hồng (QA) | Rà theo Debate S4b (D1-1 → D5-19): §2 cập nhật BR01, BR03, BR05, BR10, BR13, BR14, BR17, BR24, BR25; DT-1 thêm R11 (chuỗi ≤ 30 phút theo tin liền trước); DT-3 sửa R7 (phía mình chỉ viền, không chìa khoá — D2-3), thêm R6 (gỡ quyền vẫn trong nhóm), R8 (vai trò thuộc tài khoản); Coverage Matrix thêm case 163 → 174, BR13 → Một phần (17 Đã phủ · 11 Một phần · 0 Chưa phủ); §8 đếm lại (A 159 / B 18, ❓ 15 / 2); §11 thêm bảng 41 điểm D đã xử lý |
