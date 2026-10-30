---
featureId: G036
stage: S9
gate: open
materialOpen: 0
nonMaterialOpen: 24
gateOpenedBy: Hồng (QA)
gateOpenedAt: 2026-10-13
updatedAt: 2026-10-13
---

# Requirement Understanding / Alignment Summary — G036: Giao diện khung hội thoại — giống Zalo PC

Trạng thái: **cổng mở ngày 2026-10-13**; S6–S7 đã xong; đang S9. Q-01, Q-02, Q-13, Q-15 đã có BA; 22 điểm không trọng yếu cô lập, chưa có BA (Q-03 → Q-11, Q-14, Q-16, Q-17, Q-19 → Q-28). Không điểm mới nào được xếp trọng yếu → cổng giữ mở.

## 1. Nguồn và phạm vi đã đọc

Xem mục 1 của `01-requirement-analysis.md`. Nguồn chính: `tailieu/G036 - Giao diện khung hội thoại.md` (toàn bộ, v1.0, Draft).
Đối chiếu các dòng liên quan ở G003, G026, G009, G032, G014.

## 2. Requirement / Use case / Business rule đã trích

| Mã | Tóm tắt | Nguồn | Trạng thái hiểu |
| --- | --- | --- | --- |
| UC-01 – UC-03, AF01 – AF06, E01 – E04 | Mở hội thoại, cuộn, thao tác trên tin, các luồng phụ và ngoại lệ hiển thị | `G036:71-126` | `[NGUỒN]` rõ |
| BR01 | Gộp cụm | `G036:134` | `[NGUỒN]` + `[ĐÃ XÁC NHẬN]` Q-02 (tin gửi từ điện thoại gộp thành cụm riêng) — còn mở Q-06 (biên), Q-13 |
| BR02, BR11 – BR18, BR21 – BR23, BR25 | Khoảng cách, khung tin, link, trích dẫn, ảnh, sticker, tệp, thẻ link, danh thiếp, thao tác, cảm xúc, thanh ghim | `G036:135-156`, `G036:233-239` | `[NGUỒN]` rõ |
| BR03 – BR05 | Mốc thời gian | `G036:136-138` | `[NGUỒN]` — còn mở Q-05, Q-06, Q-07 |
| BR06 – BR09 | Tên, avatar, giờ | `G036:139-142` | `[NGUỒN]` + `[ĐÃ XÁC NHẬN]` Q-13 (cụm gửi từ điện thoại: tên Zalo + giờ, avatar tài khoản Zalo) |
| BR10 | Trưởng / phó nhóm | `G036:143` | `[ĐÃ XÁC NHẬN]` Q-01 — theo G036 (G026 chưa cập nhật) |
| BR19 | Tin hệ thống | `G036:152` | `[NGUỒN]` — còn mở Q-10 |
| BR20 | Tin thu hồi / đã xoá | `G036:153` | `[NGUỒN]` — còn mở Q-03 |
| BR24 | Trạng thái gửi | `G036:157` | `[NGUỒN]` — còn mở Q-04, Q-09 |
| BR26 – BR28 | Cuộn, chuyển hội thoại, màn hình và ngôn ngữ | `G036:159-161` | `[NGUỒN]` — còn mở Q-06, Q-08 |

## 3. Bảng câu hỏi debate

| Q | Mức (đề xuất) | Trích dẫn + nguồn | Vì sao chưa rõ | Các cách hiểu có căn cứ | Ảnh hưởng tới test | Cần ai xác nhận | Trạng thái | Câu trả lời | Ai trả lời · ngày · kênh |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Q-01 | Trọng yếu | `G036:143`, `G036:217-219`; `G026:19`, `G026:128`, `G026:130`, `G026:193` | G036 có phó nhóm, chìa khoá ở avatar, toggle "trưởng và phó nhóm"; G026 không có phó nhóm, nhãn "Trưởng nhóm" cạnh tên, toggle "trưởng nhóm" | (a) Theo G036: có phó nhóm, chìa khoá vàng / xám + viền xanh. (b) Theo G026: không có phó nhóm, nhãn "Trưởng nhóm" cạnh tên + viền khác | Toàn bộ nhóm case BR10 (4 AC) | BA | Đã xác nhận | (a) Lấy thông tin theo G036 | Trân (BA) · 2026-10-13 · QA chuyển lại trong phiên |
| Q-02 | Trọng yếu | `G036:134`, `G036:140`, `G036:141`; `G003:252-256`, `G003:458` | G036 dựa vào "nhân viên" cho cụm, tên, avatar phía mình; tin chủ tài khoản gửi từ điện thoại không có nhân viên | Tài liệu không nói. G003 chỉ ghi "không hiện tên người gửi" | Case cụm / tên / avatar khi hội thoại có tin gửi từ điện thoại xen tin gửi từ web | BA | Đã xác nhận một phần — phần còn lại tách thành Q-13 | Tin gửi từ điện thoại gộp theo cụm gửi từ điện thoại | Trân (BA) · 2026-10-13 · QA chuyển lại trong phiên |
| Q-03 | Không trọng yếu | `G036:153`; `G003:185`, `G003:303`, `G003:459` | G036 không nhắc label và style disable | (a) Label "Đã thu hồi" / "Đã xóa" + disable của G003 vẫn áp dụng. (b) G036 thay hẳn, không còn label | Một ý kiểm trong case BR20, đánh ❓ | BA | Mở — cô lập | | |
| Q-04 | Không trọng yếu | `G036:157`, `G036:173`, `G036:365`; `G003:333-336` | BE chỉ trả `Đã gửi`; G003 không có "Đã nhận", "Đã xem" là avatar | — | Case `Đã nhận` / `Đã xem` viết nhưng chặn (chờ BE); "Đã xem" dạng chữ hay avatar đánh ❓ | BA / Dev | Mở — cô lập | | |
| Q-05 | Không trọng yếu | `G036:136` | Mốc trước tin đầu danh sách ghi gì | Tài liệu không nói | Một case BR03 ❶ đánh ❓ phần định dạng | BA | Mở — cô lập | | |
| Q-06 | Không trọng yếu | `G036:134`, `G036:137`, `G036:159-160`, `G036:348-355` | Biên 30 phút tới giây; "trong 30 ngày" gồm ngày thứ 30 không; "~5 phút", "vài giây", "~3 màn hình", §15 là tiêu chí pass hay tham khảo. **Bổ sung (debate D5-11, D5-13):** mốc ~5 phút tính từ lúc rời hay lúc mở hội thoại; tải lại thất bại thì có gửi *đã đọc* không | — | Case biên đánh ❓ phần biên; số "~" và §15 ghi "ĐO & GHI", không làm tiêu chí pass | BA | Mở — cô lập | | |
| Q-07 | Không trọng yếu | `G036:138` | Định dạng ngày tiếng Anh | Tài liệu chỉ có Today / Yesterday / Sun… | Case tiếng Anh chỉ kiểm 3 nhãn có nguồn | BA | Mở — cô lập | | |
| Q-08 | Không trọng yếu | `G036:32`, `G036:304` | 390–1600px là khung chat hay cửa sổ | — | Cách dựng môi trường case BR28 | BA | Mở — cô lập | | |
| Q-09 | Không trọng yếu | `G036:157`, `G036:227`; `G003:329` | Sau tin mình có tin hệ thống / bình chọn thì ô trạng thái còn không. **Bổ sung (debate D1-5c):** tin cuối là tin gửi từ điện thoại thì ô hiện mức gì — có `Đang gửi` / viền đỏ không, khi G003 §7 chỉ áp cho tin gửi từ web | Tài liệu không nói | Một case BR24 đánh ❓ | BA | Mở — cô lập | | |
| Q-10 | Không trọng yếu | `G036:152` | "Tin ghim không kèm ảnh" chỉ loại tin nào | (a) Tin hệ thống báo đã ghim. (b) Tin được ghim | Một ý kiểm BR19 đánh ❓ | BA | Mở — cô lập | | |
| Q-11 | Không trọng yếu | `G036:139`, `G036:143`, `G036:27` | Dẫn chiếu G032 BR03, G026 BR03 lệch; spec gốc chưa trỏ sang G036; sau Q-01, G026 (BR01, BR03, OOS01 — không có phó nhóm) cần cập nhật theo G036; G003 §10D (`G003:456-474`), AF05 (`G003:255`), UC-02a b6 (`G003:87`) và AC `G003:565`, `G003:576`, `G003:615-616` còn ghi hiển thị cũ — xem `01-requirement-analysis.md` §11.3 | — | Không đổi case; ghi chú cập nhật tài liệu | BA (ghi chú) | Mở — cô lập | | |
| Q-13 | Không trọng yếu (đề xuất) | Câu trả lời Q-02; `G036:140-141`; `G003:256`, `G003:458` | Câu trả lời chỉ nói cách gộp cụm. Chưa nói: (i) tin cuối cụm gửi từ điện thoại hiện gì ở chỗ "tên nhân viên + giờ"; (ii) ảnh đại diện của cụm đó; (iii) cụm điện thoại có còn theo điều kiện cùng ngày, ≤ 30 phút, tin đứng riêng của BR01 không | (i) Chỉ giờ, không tên — căn cứ G003 "không hiển thị tên người gửi". (ii) Tài liệu không nói. (iii) `[DIỄN GIẢI AI]` các điều kiện còn lại của BR01 vẫn áp dụng, "điện thoại" đóng vai một người gửi | Kỳ vọng phần tên và avatar trong case cụm điện thoại đánh ❓; phần gộp cụm viết được | BA | Đã xác nhận | (i) Bác bỏ G003 — tin cuối cụm hiện **tên Zalo + giờ**. (ii) Avatar của cụm gửi từ điện thoại = **avatar tài khoản Zalo đó**; các cụm khác = avatar nhân viên gửi. (iii) **Có** — vẫn theo cùng ngày, ≤ 30 phút, tin đứng riêng | Trân (BA) · 2026-10-13 · QA chuyển lại trong phiên |
| Q-14 | Không trọng yếu (đề xuất) | `G036:154` BR21 menu "…" = menu chuột phải (Copy, Ghim, Chọn nhiều, Xoá phía tôi, Người đã xem…); `G003:456-458` mỗi loại tin có tập option riêng (tin khách: không có Thu hồi; tin gửi từ điện thoại: chỉ Chuyển tiếp, Thu hồi) | G036 liệt kê một menu chung; G003 cho mỗi loại tin một tập thao tác | (a) `[DIỄN GIẢI AI]` Menu "…" hiện đúng tập thao tác G003 cho phép theo loại tin (`G036:27`, `G036:89` — nghiệp vụ ở spec gốc). (b) Menu giống nhau cho mọi tin | Nội dung menu "…" trong case BR21 theo từng loại tin; phần lệch đánh ❓ | BA | Mở — cô lập | | |
| Q-15 | Không trọng yếu (đề xuất) | `G036:142`, `G036:147`; `G003:481-483` | G003: video chỉ có nút download, không xem trực tiếp; G036: video hiển thị như ảnh, đúng tỉ lệ, có khung chờ | (a) Video hiện ảnh xem trước theo BR14, bấm thì theo G003. (b) G036 đổi cả cách xem video | Case video BR14 đánh ❓ phần bấm / phát | BA | Đã xác nhận | G036 chính là bản cập nhật của G003 — phần hiển thị video theo G036 (BR14), G003 "không view trực tiếp" không còn áp dụng cho hiển thị. Hành vi **bấm vào video** G036 không nói → vẫn theo G003 (tải về) `[DIỄN GIẢI AI]` | Trân (BA) · 2026-10-13 · QA chuyển lại trong phiên (QA xác nhận lại người trả lời 2026-10-13) |
| Q-16 | Không trọng yếu (đề xuất) | `G036:157` BR24; `G003:299` BR03c | Tin dài tách nhiều phần: G003 mỗi phần có trạng thái riêng; G036 chỉ một ô dưới tin cuối | (a) `[DIỄN GIẢI AI]` Vòng đời từng phần vẫn theo G003; chỉ hiện một ô dưới phần cuối, phần lỗi có viền đỏ ở đúng vị trí. (b) Mỗi phần vẫn hiện trạng thái | Case tin tách nhiều phần (liên quan CR-004) đánh ❓ phần ô trạng thái | BA | Mở — cô lập | | |
| Q-17 | Không trọng yếu (đề xuất) | `G036:234` §10E "Ghim tin của chính tài khoản mình mà không có tên → hiện tên tài khoản" | Sau Q-13 tin gửi từ điện thoại đã có "tên Zalo"; "không có tên" chỉ loại tin nào, "tên tài khoản" có trùng "tên Zalo" không | Tài liệu không nói | Case [G036_119] ❓ | BA | Mở — cô lập | | |
| Q-18 | — | `01-…` §11.3 / §12 dẫn `G003:481-483` | Số dòng dẫn sai; dòng thật `G003:467-469` | — | Không ảnh hưởng case | — | Đã giải quyết (sửa `01-…` 2026-10-13, giữ mã) | | |
| Q-19 | Không trọng yếu (đề xuất) | `G036:146` BR13 trích video dùng `[Hình ảnh]`; `G036:234` thanh ghim chỉ có `[Hình ảnh]` · `[Nhãn dán]` · `[Tập tin]`; `G014:414` BR14 có `[Video]` | Ghim video và trích tệp hiện nhãn gì | (a) `[Hình ảnh]` cho video như BR13. (b) `[Video]` như G014 | Case [G036_118] viết theo 3 nhãn có nguồn, video không đưa vào Data | BA | Mở — cô lập | | |
| Q-20 | Không trọng yếu (đề xuất) — từ CX D-01 | BR07, BR09 `G036:140-142` | Tin giữa cụm không có giờ / tên; build có cách xem (tooltip…) không — nếu có thì G036 thiếu | Tài liệu không nói | Không đổi case; nếu có tooltip thì cần BR mới | BA | Mở — cô lập | | |
| Q-21 | Không trọng yếu (đề xuất) — từ CX D-02 | `G036:111`, `G036:152` "nhóm tin hệ thống đang thu gọn" | Thu gọn tin hệ thống quy định ở spec nào; khi thu gọn, BR03 ❹ và BR02 16px áp dụng thế nào | Tài liệu không nói | Case AF04 / BR19 về thu gọn ❓ phần hình dạng nhóm thu gọn | BA | Mở — cô lập | | |
| Q-22 | Không trọng yếu (đề xuất) — từ CX D-03 | `G036:113` AF06, `G036:143`, `G036:155` | AF06 "luôn hiện" có áp cho tooltip Trưởng / Phó nhóm không; màn cảm ứng mở bảng cảm xúc bằng gì | Tài liệu chỉ nói về nút | Case cảm ứng BR10 / BR22 ❓ phần tooltip và bảng cảm xúc | BA | Mở — cô lập | | |
| Q-23 | Không trọng yếu (đề xuất) — từ CX D-04, bổ sung Q-15 | `G036:147`; `G003:468` | Bấm vào video: tải về (diễn giải AI) hay phát; video có dấu hiệu phân biệt với ảnh không | (a) Tải về theo G003. (b) Phát trực tiếp | Case [G036_69] ❓ phần bấm | BA | Mở — cô lập | | |
| Q-24 | Không trọng yếu (đề xuất) — từ CX D-05 | `G036:155` BR22; `G009:66` | Bấm 👍 lần hai trên tin đã Thích: gỡ hay giữ | G009 BR02: gỡ qua icon gạch chéo trong bảng chọn | Case BR22 phần bấm lại ❓ | BA | Mở — cô lập | | |
| Q-25 | Không trọng yếu (đề xuất) — từ CX D-06, liên quan Q-09, Q-16 | `G036:121` E01, `G036:157` BR24; `G003:339` | Sau "Thử lại": tin giữ vị trí hay xuống cuối; viền đỏ tắt lúc nào; có ô "Đang gửi" tạm không | Tài liệu không nói | Case E01 ❓ phần sau khi bấm | BA | Mở — cô lập | | |
| Q-26 | Không trọng yếu (đề xuất) — từ CX D-07, gộp với Q-19 | `G036:146`, `G036:234`; `G009:301` `[File]` | Trích dẫn tệp hiện `[File]` (G009) hay `[Tập tin]` (G036 §10E) | (a) `[Tập tin]` theo G036. (b) `[File]` theo G009 | Case BR13 trích tệp ❓ nhãn | BA | Mở — cô lập | | |
| Q-27 | Không trọng yếu (đề xuất) — từ CX D-08, liên quan Q-03 | `G036:236-239`; `G014:517`, `G014:521` | Esc có đóng bảng danh sách ghim không; ghim của tin thu hồi trong bảng có nhãn "Đã thu hồi" không | G014 cũ có Esc; G036 không nêu | Case §10E bàn phím ❓ phần Esc | BA | Mở — cô lập | | |
| Q-28 | Không trọng yếu (đề xuất) — từ CX D-09 | `G036:109` AF02 | Tin mới tới lúc đang đọc tin cũ: có tín hiệu báo trong khung chat không. **Bổ sung (debate D5-5):** ranh giới "ở đáy" — còn cách tin cuối bao nhiêu thì vẫn tính là ở đáy và tự cuộn | Tài liệu không nói | Case AF02 chỉ kiểm "giữ chỗ"; tín hiệu là ĐO & GHI | BA | Mở — cô lập | | |
| Q-29 | Không trọng yếu (đề xuất) — từ debate D5-15 | `G036:146` BR13; `G036:226` §10D.4 | Tin trả lời bằng sticker / ảnh (không có khung tin chữ): trích dẫn hiện ở đâu, hình dạng gì | Tài liệu không nói | Case BR13 "trả lời bằng sticker / ảnh" ❓ | BA | Mở — cô lập | | |
| Q-30 | Không trọng yếu (đề xuất) — từ debate D5-16 | `G036:147` BR14 | Ảnh nhỏ hơn 360×368 giữ nguyên kích thước hay phóng to tới trần | (a) Giữ nguyên (QA + AI đọc vậy). (b) Phóng to | Case BR14 ảnh nhỏ ❓ | BA | Mở — cô lập | | |
| Q-12 | Người dùng chốt | `G036:12` | Spec đang Draft | — | Có viết test case trên bản Draft không | Người dùng | Đã chốt | Dùng bản Draft v1.0 (2026-10-09) làm căn cứ | Hồng (QA) · 2026-10-13 · phiên /qa-flow (ngầm qua xác nhận mở cổng) |

## 4. Cách hiểu đã thống nhất (Debate S4b — bắt đầu 2026-10-13, làm bù sau khi cổng mở)

### 4.1 Từ câu trả lời BA

| # | Nội dung | Từ câu hỏi | Ai xác nhận · ngày | Tài liệu đã cập nhật chưa |
| ---: | --- | --- | --- | --- |
| 1 | Trưởng / phó nhóm hiển thị theo G036 BR10 và §10C: có phó nhóm; chìa khoá vàng = trưởng, xám = phó ở góc ảnh đại diện, tooltip; viền xanh nhạt; điều kiện: nhóm bật toggle và người gửi còn vai trò | Q-01 | Trân (BA) · 2026-10-13 | G036 rồi; **G026 chưa** (BR01, BR03, OOS01 vẫn ghi không có phó nhóm, nhãn cạnh tên) |
| 2 | Tin chủ tài khoản gửi từ điện thoại gộp thành cụm riêng của tin gửi từ điện thoại (không gộp với cụm của nhân viên) | Q-02 | Trân (BA) · 2026-10-13 | Chưa — G036 BR01 chưa ghi |
| 3 | Cụm gửi từ điện thoại: tin cuối cụm hiện **tên Zalo + giờ** (bác bỏ G003 "không hiển thị tên người gửi"); avatar = avatar tài khoản Zalo đó; vẫn theo điều kiện cùng ngày, ≤ 30 phút, tin đứng riêng của BR01. Các cụm khác dùng avatar nhân viên gửi | Q-13 | Trân (BA) · 2026-10-13 | Chưa — G036 BR07, BR08 và G003 AF05 chưa ghi |
| 4 | G036 là **bản cập nhật phần hiển thị** của G003 và các spec gốc khác: mọi quy tắc "trông thế nào" trong khung chat theo G036; nghiệp vụ (quyền, kết quả thao tác, vòng đời trạng thái, ngoại lệ chung, dữ liệu) vẫn theo spec gốc. Chỗ G036 im lặng → theo spec gốc | `G036:25`, `G036:27` + Q-01, Q-13, Q-15 | Trân (BA) · 2026-10-13 (Q-15: "G036 chính là update của G003") | G003, G009, G014, G015, G026 chưa cập nhật — §11, §12 của `01-…` |

### 4.2 Debate Hồng ↔ AI theo nhóm BR (từng câu, có dò lại tài liệu)

**Nhóm 1 — Gộp cụm, tên, avatar, giờ (BR01, BR06–BR09) — xong 2026-10-13**

| # | Nội dung đã thống nhất | Nhãn | Dòng tài liệu đã dò | Ghi chú |
| ---: | --- | --- | --- | --- |
| D1-1 | Hai nhân viên chung tài khoản gửi xen kẽ (A 09:00, 09:01 · B 09:02 · A 09:03) → **ba cụm** A · B · A; mỗi cụm avatar nhân viên ở tin đầu, "tên nhân viên + giờ" ở tin cuối | `[NGUỒN]` | `G036:134` BR01 ❶ "hai nhân viên dùng chung một tài khoản Zalo vẫn là hai cụm"; `G036:140-141` | Hồng: đúng |
| D1-2 | Chat 1-1: tin đầu cụm của khách **vẫn có avatar**, chỉ **không có dòng tên** | `[NGUỒN]` | `G036:139` BR06 chỉ bỏ tên; `G036:141` BR08 không có ngoại lệ 1-1; AC `G036:257`, `G036:259` | Hồng: đúng |
| D1-3 | Tin hệ thống chen giữa hai tin của cùng người (09:00 · hệ thống 09:05 · 09:06) → **hai cụm**; tin 09:06 có avatar lại, mốc `giờ + ngày` phía trước, cách tin hệ thống 16px | `[NGUỒN]` | `G036:134` BR01 ❹; `G036:136` BR03 ❹; `G036:135` BR02 | Hồng: đúng |
| D1-4a | "Cách tin trước ≤ 30 phút" tính theo **tin liền trước**, không tính từ tin đầu cụm → 09:00 · 09:25 · 09:50 · 10:15 là **một cụm** | `[NGUỒN]` | `G036:134` "Hai tin liền nhau… tin sau cách tin trước"; `G036:136` BR03 ❸; `G036:246` AC; `G036:316` OOS03 ngưỡng cố định | Hồng: đúng. Biên 30:00 tới giây → Q-06 |
| D1-4b | Sang ngày thì tách cụm dù cách < 30 phút (23:50 · 00:05) ; giữa hai cụm là mốc ngày theo §10B | `[NGUỒN]` | `G036:134` BR01 ❷; `G036:136` BR03 ❷; `G036:182`; `G036:205-208` | Múi giờ của "ngày" → Q-04 |
| D1-5a | Tin chủ tài khoản gửi từ điện thoại là **cụm riêng**, nằm **bên phải**; avatar = avatar tài khoản Zalo; tin cuối cụm "tên Zalo + giờ"; cụm nhân viên kế tiếp là cụm khác | `[ĐÃ XÁC NHẬN]` | Q-02, Q-13 (Trân 2026-10-13); `G036:141` BR08 phía mình bên phải | Hồng: chỉ phân biệt tên và avatar, không phân biệt gì khác |
| D1-5b | Ô trạng thái gửi (BR24) **không phân biệt** tin từ web hay điện thoại: tin điện thoại là tin cuối phía mình thì vẫn có ô | `[NGUỒN]` | `G036:157` BR24 chỉ phân biệt phía mình / khách | Hồng: đúng |
| D1-5c | Ô trạng thái của tin điện thoại chỉ có thể từ `Đã gửi` trở lên — không `Đang gửi`, không viền đỏ "Thử lại", vì vòng trạng thái của G003 §7 chỉ áp cho tin gửi từ web Gopany | `[DIỄN GIẢI AI]` | `G003:329` "Entity: Tin nhắn gửi đi (từ web Gopany)"; `G003:252-256` AF05 không nhắc trạng thái | Tài liệu không viết thẳng → thêm ý vào Q-09 / Q-25 |

**Nhóm 2 — Trưởng / phó nhóm (BR10) — xong 2026-10-13**

| # | Nội dung đã thống nhất | Nhãn | Dòng tài liệu đã dò | Ghi chú |
| ---: | --- | --- | --- | --- |
| D2-1 | Hai điều kiện phải **cùng đúng**: nhóm bật "Làm nổi tin nhắn trưởng và phó nhóm" **và** người gửi còn vai trò. Dấu hiệu phản ánh **trạng thái hiện tại**: tắt cài đặt, gỡ quyền, rời / bị xoá khỏi nhóm → **mọi tin cũ** cũng mất chìa khoá và viền | `[NGUỒN]` | `G036:143` BR10 "vẫn còn trong nhóm với vai trò đó"; `G036:219` §10C; AC `G036:264-265` | Hồng: gỡ quyền hoặc tắt → tất cả tin cũ mất dấu. AC chỉ nêu "rời / bị xoá", trường hợp "gỡ quyền mà vẫn trong nhóm" suy từ chữ "vẫn còn vai trò" → thêm case riêng để lộ nếu dev chỉ làm theo AC |
| D2-2 | **Phía khách** (thành viên là trưởng / phó): chìa khoá vàng / xám ở avatar **tin đầu cụm** (1 cái / cụm), viền xanh nhạt **mọi tin** trong cụm, tooltip khi rê chuột | `[NGUỒN]` | `G036:143`, `G036:217-218`, `G036:263` | — |
| D2-3 | **Phía mình** (tài khoản Zalo đang dùng là trưởng / phó): chỉ **viền xanh**, **không chìa khoá** | `[NGUỒN]` | `G036:143` câu cuối, `G036:218`, `G036:266` — cả ba chỗ chỉ cấp viền cho phía mình | Hồng chỉ ra; AI trước đó đọc quá tài liệu (gán chìa khoá lên avatar nhân viên) — bỏ |
| D2-4 | Vai trò thuộc **tài khoản Zalo**: tài khoản là trưởng nhóm → **mọi tin phía mình** viền xanh — của mọi nhân viên dùng tài khoản đó và cả cụm gửi từ điện thoại; không có chuyện nhân viên A có viền, B không | `[NGUỒN]` | `G036:143` "Tài khoản Zalo đang dùng là trưởng/phó → tin mình gửi cũng có viền xanh" | Hồng: đúng |
| D2-5 | G026 (không có phó nhóm, nhãn "Trưởng nhóm" cạnh tên) **không dùng** cho phần hiển thị; theo G036 | `[ĐÃ XÁC NHẬN]` | Q-01 (Trân 2026-10-13) | G026 cần cập nhật — Q-11 |

Còn mở trong nhóm: tooltip trên màn cảm ứng (Q-22); tương phản viền xanh nhạt trên khung xanh nhạt phía mình (CX-05, ĐO & GHI).
**Nhóm 3 — Khoảng cách, khung tin, link, thẻ tệp, danh thiếp, cảm xúc (BR02, BR11, BR12, BR16, BR18, BR23) — xong 2026-10-13**

| # | Nội dung đã thống nhất | Nhãn | Dòng tài liệu đã dò | Ghi chú |
| ---: | --- | --- | --- | --- |
| D3-1 | Bề ngang khung tin: **hai trần cùng áp**, lấy cái nhỏ hơn — khung chat 600px → tối đa 540px; khung 1000px → tối đa 720px | `[NGUỒN]` | `G036:144` BR11; AC `G036:269` "≤ 90% khung và ≤ 720px" | Hồng: đúng |
| D3-2 | Tin ngắn thì khung ôm theo chữ, không kéo đủ 90% | `[DIỄN GIẢI AI]` | `G036:144` chỉ ghi "tối đa" | Không viết thành tiêu chí pass; ĐO & GHI |
| D3-3 | Thẻ tệp **cố định 376px** khi khung đủ rộng, chỉ co khi màn hẹp; danh thiếp / ngân hàng / ghi âm không có số cố định, chỉ cần không tràn | `[NGUỒN]` | `G036:149` BR16; `G036:151` BR18; `G036:161` BR28 | Ngưỡng bắt đầu co (~418px = 376 ÷ 0,9) là AI tính, tài liệu không ghi → `[DIỄN GIẢI AI]` |
| D3-4 | Khoảng cách: mốc thời gian đứng giữa hai cụm thì **không cộng thêm 8px** (mốc tự có khoảng trống); tin đứng riêng chen giữa hai cụm → 16px **mỗi phía**, không phải 8 | `[NGUỒN]` | `G036:135` BR02 "ngay trước mốc 0", "trước và sau tin đứng riêng 16px" | Hồng: đúng |
| D3-5 | BR12 áp **cả hai phía** (tin khách và tin mình): link, @tên xanh, không gạch chân, @tên không đậm; chữ thường xuống dòng theo từ, link dài bẻ giữa chuỗi để không tràn | `[NGUỒN]` | `G036:145` BR12 không giới hạn phía | Hồng: đúng |
| D3-6 | Tin có cảm xúc đã thả: khoảng cách tới tin kế **được nới hơn 4px** để chứa hàng cảm xúc — BR23 "không đè" ưu tiên hơn số 4px của BR02 trong trường hợp này | `[NGUỒN]` (BR23) + `[DIỄN GIẢI AI]` (cách dung hoà với BR02) | `G036:156` BR23; `G036:135` BR02 | Hồng: đúng. Tài liệu không nói số px nới thêm → case kiểm "không đè", không kiểm số |
**Nhóm 4 — Mốc thời gian (BR03–BR05) — đang debate (phần biên chờ Q-05/06/07)**

| # | Nội dung đã thống nhất | Nhãn | Dòng tài liệu đã dò | Ghi chú |
| ---: | --- | --- | --- | --- |
| D4-1 | Mốc "giờ + ngày" (BR03 ❸) chỉ xét **thời gian**, không xét người gửi: khách 09:00 → mình 09:45 có mốc `09:45 Hôm nay`; khách 09:00 → mình 09:10 không có mốc (đổi người chỉ tách cụm, không sinh mốc) | `[NGUỒN]` | `G036:136` BR03 ❸ "cùng ngày, cách tin trước hơn 30 phút" — không có điều kiện người gửi | Hồng: đúng |
| D4-2 | Giờ ghi trong mốc là **giờ của tin đứng sau mốc** (tin mở đầu khoảng mới) | `[NGUỒN]` | §10A `G036:198` mốc `10:05 23/09/2026` đứng sau tin 09:12 — là giờ tin kế tiếp; `G036:137` BR04 "mốc giờ ghép giờ phía trước" | Hồng: đúng |
**Nhóm 5 — Trích dẫn, ảnh, sticker, thẻ link (BR13–BR15, BR17), thanh ghim (BR25), cuộn / chuyển (BR26–27), màn hình (BR28) — đang debate**

| # | Nội dung đã thống nhất | Nhãn | Dòng tài liệu đã dò | Ghi chú |
| ---: | --- | --- | --- | --- |
| D5-1 | Hàng sticker: "dưới 5 phút" là điều kiện **thêm** vào 30 phút của BR01, xét theo **sticker liền trước** — 09:00 · 09:04 · 09:08 là một hàng dù đầu-cuối cách 8 phút | `[NGUỒN]` | `G036:224` §10D.2 "sau sticker trước"; `G036:225` §10D.3 cùng cụm | Hồng: đúng |
| D5-2 | Sticker thứ 4 sang hàng mới nhưng **vẫn cùng cụm** nếu đủ BR01 → hai hàng cách 4px (trong cụm), không phải 8px | `[NGUỒN]` (hàng mới) + `[DIỄN GIẢI AI]` (4px) | `G036:223` §10D.1; `G036:135` BR02 | Tài liệu không ghi khoảng cách giữa hai hàng sticker → kiểm "cùng cụm, không có avatar / giờ chen giữa", số px ĐO & GHI |
| D5-3 | Tin chữ chen giữa hai sticker (sticker · chữ · sticker, cùng người, < 5 phút) → hai sticker **không chung hàng** ("liên tiếp" = kề nhau), nhưng cả ba vẫn **một cụm** | `[DIỄN GIẢI AI]` | `G036:148` BR15 "sticker gửi liên tiếp"; §10D không nói trường hợp chen | Hồng: đúng. Tài liệu không viết thẳng → ghi Note ở case |
| D5-4 | Mỗi sticker trong hàng vẫn là **một tin riêng**: thả cảm xúc, trả lời, chọn nhiều (mỗi sticker một ô), tải về **từng cái**; giờ gửi dưới sticker cuối hàng; trạng thái gửi và người đã xem dưới **cả hàng** | `[NGUỒN]` | `G036:148` BR15; `G036:227-228` §10D.5–6 | — |
| D4-3 | Qua 0 giờ khi đang mở màn chat: **mọi mốc đang hiện** đều cập nhật nhãn, không chỉ mốc gần nhất — `Hôm nay` → `Hôm qua`; `Hôm qua` → thứ + ngày; mốc ở ngày thứ 30 → ngày đầy đủ; phần ngày của mốc "giờ + ngày" cũng đổi (`20:47 Hôm nay` → `20:47 Hôm qua`) | `[NGUỒN]` cho "mọi nhãn tự cập nhật"; `[DIỄN GIẢI AI]` cho các bước chuyển ngoài ví dụ "Hôm nay → Hôm qua" | `G036:138` BR05 "nhãn tự cập nhật" không giới hạn mốc nào; `G036:112` AF05 chỉ ví dụ một bước; bảng §10B `G036:205-211` | Hồng: đúng. Case kiểm cả ba bước chuyển, bước ngoài ví dụ ghi Note là suy từ BR04 |
| D5-5 | "Ở đáy" = đang nhìn **tin mới nhất**; cuộn lên dù ít (không còn thấy tin cuối) là "đang đọc tin cũ" → tin mới tới thì giữ chỗ, không tự cuộn. Tài liệu không cho ngưỡng px | `[DIỄN GIẢI AI]` (ranh giới "ở đáy") | `G036:108-109` AF01, AF02; `G036:159` BR26 | Hồng: đúng. Case kiểm hai cực (đang ở tin cuối / đã cuộn lên rõ ràng); vùng xám "cách đáy vài tin" ĐO & GHI, thêm ý vào Q-28 |
| D5-6 | AF03: người dùng lăn chuột khi hệ thống đang chỉnh vị trí → dừng chỉnh **ngay**, vị trí cuối cùng theo tay người dùng; hệ thống không kéo lại sau đó | `[NGUỒN]` | `G036:110` AF03 "dừng chỉnh ngay, không giành quyền cuộn"; AC `G036:299` | Hồng: đúng |
| D5-7 | "Lệch 0–1px" khi chèn tin cũ là **tiêu chí cứng** (AC); "~3 màn hình" chỉ là mốc kích hoạt tải, không kiểm số chính xác | `[NGUỒN]` (0–1px) | AC `G036:297`; `G036:159` "khoảng 3 màn hình" | "~3 màn hình" thuộc Q-06 — ĐO & GHI |
| D4-4 | Đổi nhãn **không** sinh mốc mới, **không** tách cụm; mốc `Hôm nay` mới chỉ xuất hiện khi có **tin mới** sau 0 giờ (BR03 ❷) | `[DIỄN GIẢI AI]` | `G036:136` BR03 mốc gắn với tin; `G036:138` BR05 chỉ nói "nhãn" | Hồng: đúng. Tài liệu không viết thẳng → kiểm như kỳ vọng tối thiểu "không có mốc thừa", ghi Note |
| D5-8 | Thanh ghim: 3 ghim → thanh hiện ghim mới nhất + nút `+2 ghim ⌄`; bảng ghi `Danh sách ghim (3)`. N = **tổng − 1**. Tối đa 3 ghim (G014 BR01) → N ≤ 2 | `[NGUỒN]` | `G036:235-236` §10E; `G014:401` BR01 | Hồng: đúng |
| D5-9 | "Ghim mới nhất" = tin được **ghim gần đây nhất** (LIFO), không phải tin có giờ gửi mới nhất; ghim một tin cũ thì nó lên thanh; tin mới đến không đổi thứ tự | `[NGUỒN]` (G036 im lặng → theo spec gốc) | `G036:234` "ghim mới nhất"; `G014:408` BR08 LIFO, "tin nhắn mới đến không làm thay đổi thứ tự ghim" | Hồng: đúng. Trace case ghi `G036 BR25 + G014 BR08` |
| D5-10 | Bỏ ghim cái đang trên thanh → thanh chuyển sang ghim kế tiếp theo LIFO; còn 1 ghim → nút `+N` biến mất; còn 0 ghim → thanh ẩn hẳn | `[NGUỒN]` (0 ghim ẩn, 1 ghim không nút) + `[DIỄN GIẢI AI]` (thanh chuyển sang ghim kế) | `G036:235`; `G014:193`, G014 BR17; `G014:408` | Hồng: đúng |
**Nhóm 6 — Tin thu hồi (BR20), thao tác (BR21–22), trạng thái gửi (BR24):** chờ BA (Q-03, Q-04, Q-09, Q-14, Q-16, Q-24, Q-25). Debate khi có trả lời.

**Cách debate từ 2026-10-13 (sau câu 18):** theo thứ tự BR, mỗi BR một lượt; AI trích nguyên văn không kèm cách đọc, hỏi câu mở; Hồng nói trước; AI dò lại tài liệu cho cả hai; chốt nhãn. 42 điểm D1-1 → D5-19 (làm theo cách cũ: AI nêu cách đọc, Hồng trả lời có / không) **giữ nguyên**; cách mới áp cho BR còn lại.

**Tình trạng debate 2026-10-13:** 18 câu, 42 điểm thống nhất (D1-1 → D5-19). Nhóm 1–3 xong; nhóm 4–5 xong phần không phụ thuộc BA; nhóm 6 chờ BA. AI sửa cách đọc theo Hồng 1 lần (D2-3). Phát sinh 2 câu hỏi mới (Q-29, Q-30) và 4 bổ sung (Q-06, Q-09, Q-28).
| D5-11 | "~5 phút gần nhất" tính từ **lúc rời** hội thoại đó; quá 5 phút → như mở lần đầu (tải từ lúc nhấn chuột, không hiện bản cũ trước) | `[DIỄN GIẢI AI]` (mốc tính từ lúc rời) | `G036:74` UC-01 b2 "đã mở trong ~5 phút gần nhất"; `G036:160` BR27 | Hồng: đúng. Tài liệu không nói mốc tính từ đâu → thêm ý vào Q-06 |
| D5-12 | Mở lại trong 5 phút: hiện **bản đã có** trước, tin mới / thu hồi / cảm xúc tới trong lúc rời đi chèn vào sau, **không làm trang nhảy**; đang ở đáy thì tự cuộn xuống tin mới (BR26) | `[NGUỒN]` (hiện ngay, bổ sung sau) + `[DIỄN GIẢI AI]` (không nhảy, tự cuộn) | `G036:74`, `G036:160`; `G036:159` BR26 | Hồng: đúng |
| D5-13 | Đánh dấu *đã đọc* chỉ gửi **sau khi tải lại xong**; tải lại thất bại (mất mạng) → **không** gửi đã đọc, số chưa đọc ở danh sách giữ nguyên. "Tải từ lúc nhấn chuột xuống" chỉ kiểm được bằng DevTools (request bắt đầu ở mousedown) | `[NGUỒN]` (sau khi tải xong) + `[DIỄN GIẢI AI]` (tải lỗi → không gửi) + `[QA BỔ SUNG]` (cách kiểm mousedown) | `G036:77` UC-01 b5; `G036:160` | Hồng: đúng. Thêm ý "tải lỗi" vào Q-06 |

| D5-14 | Trích dẫn: nhân viên A trả lời tin của nhân viên B (cùng tài khoản Zalo) → trích dẫn ghi **tên tài khoản Zalo**, không ghi "B"; trích dẫn không phân biệt nhân viên, khác BR07 ở tin thường | `[NGUỒN]` | `G036:146` BR13 "trích tin của chính tài khoản mình: hiện tên tài khoản"; AC `G036:271` | Hồng: đúng. Cùng loại với Q-17 (thanh ghim) |
| D5-15 | BR13 chỉ tả trích dẫn **trong khung tin chữ**; tin trả lời bằng **sticker / ảnh** không được tả trích dẫn hiện ở đâu (§10D.4 chỉ nói sticker trả lời "đứng riêng") | `[CẦN XÁC NHẬN]` | `G036:146`; `G036:226` §10D.4 | Hồng: đúng, tài liệu để trống → Q-29 |
| D5-16 | BR14: ảnh dọc 1000×2000 → 184×368; ảnh ngang 2000×1000 → 360×180; chú thích rộng đúng bằng ảnh. Ảnh nhỏ hơn trần (200×150) **giữ nguyên, không phóng to** | `[NGUỒN]` (tỉ lệ, trần, chú thích) + `[DIỄN GIẢI AI]` (không phóng to) | `G036:147` BR14 "đúng tỉ lệ thật, rộng tối đa 360, cao tối đa 368"; AC `G036:272` | Hồng: đúng. "Không phóng to" tài liệu không nói → Q-30 |
## 5. Các cách hiểu khác nhau còn tồn tại
| D5-17 | Thẻ link có **ba hình dạng** theo dữ liệu G015: đủ ảnh → thẻ lớn 306×161; có tiêu đề / mô tả, không ảnh → ô nhỏ trái; không có gì → chỉ dòng link (E04). Tiêu đề cắt 1 dòng, mô tả cắt 2 dòng. Tên miền viết thường, bỏ `https://`, `www.` theo G015 BR03b | `[NGUỒN]` | `G036:150` BR17; `G036:124` E04; `G015:145` BR03b | Hồng: đúng. Dấu "…" khi cắt tài liệu không nói → ĐO & GHI |
| D5-18 | Tin có **nhiều link** → chỉ **một** thẻ cho link đầu tiên (G036 im lặng → theo spec gốc) | `[NGUỒN]` | `G015:146` BR04 "chỉ preview link đầu tiên"; `G015:96` | Hồng: đúng. Trace `G036 BR17 + G015 BR04` |
| D5-19 | Màn cảm ứng "nút vốn chỉ hiện khi rê chuột thì luôn hiện" áp cho Trả lời · Chuyển tiếp · "…" · 👍 · Tải sticker · nút "…" của ghim; tooltip Trưởng / Phó chưa rõ (Q-22). "Mọi nhãn có bản tiếng Anh" = **không hiện tên mã**; nội dung dịch chỉ kiểm được 3 nhãn có nguồn (Q-07) | `[NGUỒN]` | `G036:161` BR28; `G036:238` §10E; AC `G036:306` "không hiện tên mã" | Hồng: đúng |

Nhóm 5 **tạm xong** phần không phụ thuộc BA. Còn chờ: Q-05/06/07/08, Q-17, Q-19, Q-22, Q-23, Q-26, Q-27, Q-28, Q-29, Q-30.

Q-03, Q-10, Q-14, Q-16 — hai cách hiểu, xem bảng. Q-05, Q-07, Q-09 — tài liệu không nói: **Unresolved / BA Clarification Required**.

## 6. Điểm đã thống nhất và điểm còn mở

- Đã thống nhất: Q-01, Q-02, Q-13, Q-15 (BA Trân, 2026-10-13).
- Còn mở — **trọng yếu**: không có.
- Đã chốt: Q-12 (người dùng).
- Còn mở — không trọng yếu (cô lập): Q-03 → Q-11, Q-14, Q-16 (người dùng chấp nhận khi mở cổng); Q-17, Q-19 → Q-28 phát sinh sau khi mở cổng (người dùng chốt không trọng yếu 2026-10-13; Q-18 đã giải quyết).
- Bổ sung lý do / mở rộng từ CX (không đổi mức): Q-03 (CX-08 — rủi ro xử lý theo nội dung khách đã rút, đề nghị BA ưu tiên); Q-04 / Q-09 (CX-10); Q-05 (khi tải thêm tin cũ, mốc đầu danh sách có dịch lên không); Q-07 (thứ tự "giờ + Today", 12h / 24h, bản tiếng Anh của `+N ghim`, `Thu gọn`, `Thử lại`, `Phó nhóm`…).

## 7. Cần BA / Dev / Product xác nhận

Nội dung gửi BA: xem `cau-hoi-gui-BA.md` cùng thư mục.

## 8. Ngoài phạm vi / chưa có căn cứ

- OOS01 lưới album · OOS02 giao diện tối · OOS03 ngưỡng 30 phút theo cấu hình · OOS04 hiện nút khi dùng phím Tab ·
  OOS05 ẩn nội dung tin thu hồi (`G036:314-318`).
- Luật nghiệp vụ của các thao tác (ghim tối đa mấy tin, ai được thả cảm xúc, trả lời gửi gì lên Zalo) — ở spec gốc (`G036:27`).
- Ngoại lệ không quyền xem, mất kết nối, lỗi hệ thống, tài khoản Zalo ngắt kết nối — theo G003 (`G036:126`).

## 9. Change Proposal / New Requirement Candidate `[ĐỀ XUẤT THAY ĐỔI]`

Chưa có.

## 10. QA coverage bổ sung dự kiến `[QA BỔ SUNG]`

- Dung sai khi đo kích thước px (DevTools / so ảnh) — cần thống nhất trước khi chạy.
- Đo hiện trạng (build trước sửa) theo các mô tả "Trước: …" ở bảng BR để làm mốc hồi quy.
- Hội thoại dài (nhiều trăm tin), nhiều loại tin xen kẽ trong một cụm.

## 11. Xác nhận mở cổng

- [x] Điểm trọng yếu còn mở = 0 (Q-01, Q-02, Q-13, Q-15 đã có trả lời BA Trân, 2026-10-13)
- [x] Người dùng đã chốt Q-12 (dùng bản Draft)
- [x] Người dùng đã được trình bày mục 2–8 trong phiên
- Người dùng xác nhận: Hồng (QA) · 2026-10-13 · nguyên văn: "ddoofng ys mo cong" — trả lời đề nghị "Q-14, Q-16 không trọng yếu; Q-12 dùng bản Draft; nói đồng ý mở cổng"
- Q-15: QA đã xác nhận lại là chị Trân trả lời (2026-10-13). Bấm vào video vẫn tải về theo G003 là diễn giải AI (Q-23).

## Lịch sử cập nhật

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
| 2026-10-13 | AI (Orchestrator) | Tạo bản đầu sau Requirement Analysis: 12 câu, 2 đề xuất trọng yếu, cổng đóng |
| 2026-10-13 | Hồng (QA) chuyển trả lời của BA Trân | Q-01 → theo G036; Q-02 → tin gửi từ điện thoại gộp cụm riêng. Tách phần chưa trả lời của Q-02 thành Q-13 |
| 2026-10-13 | Hồng (QA) chuyển trả lời của BA Trân | Q-13 → tên Zalo + giờ, avatar tài khoản Zalo, vẫn theo điều kiện BR01 |
| 2026-10-13 | AI (Orchestrator) | Đối chiếu G036 ↔ G003 theo yêu cầu người dùng (§11 của `01-…`): thêm Q-14, Q-15, Q-16; mở rộng ghi chú Q-11 |
| 2026-10-13 | Hồng (QA) chuyển trả lời của BA Trân | Q-15 → G036 là bản cập nhật của G003 |
| 2026-10-13 | AI (Orchestrator) | Đối chiếu G036 với cả 9 spec phụ thuộc (§12 của `01-…`): phân rõ lấy từ gốc / bị G036 thay; ghi cách hiểu đã xác nhận #4 |
| 2026-10-13 | Hồng (QA) | Chấp nhận mức Q-14, Q-16; chốt Q-12; xác nhận mở cổng |
| 2026-10-13 | AI (Orchestrator) | Sau S6–S7: nhận Q-17, Q-19 từ Test Designer và D-01 → D-09 từ CX (đánh mã Q-20 → Q-28); Q-18 đã giải quyết; bổ sung lý do Q-03, Q-04, Q-05, Q-07, Q-09; không điểm trọng yếu mới |
| 2026-10-13 | Hồng (QA) | Chốt Q-17, Q-19 → Q-28 không trọng yếu; xác nhận Q-15 là của BA Trân |
| 2026-10-13 | Hồng (QA) + AI | Debate S4b nhóm 1 (5 câu, từng câu một, dò lại tài liệu từng dòng): D1-1 → D1-5c; bổ sung ý vào Q-09 |
| 2026-10-13 | Hồng (QA) + AI | Debate S4b nhóm 2 (3 câu): D2-1 → D2-5; AI sửa cách đọc về chìa khoá phía mình theo Hồng |
| 2026-10-13 | Hồng (QA) + AI | Debate S4b nhóm 3 (2 câu): D3-1 → D3-6 |
| 2026-10-13 | Hồng (QA) + AI | Debate S4b nhóm 4 câu 11: D4-1, D4-2 |
| 2026-10-13 | Hồng (QA) + AI | Debate S4b nhóm 4 câu 12: D4-3, D4-4 |
| 2026-10-13 | Hồng (QA) + AI | Debate S4b nhóm 5 câu 13: D5-1 → D5-4 |
| 2026-10-13 | Hồng (QA) + AI | Debate S4b nhóm 5 câu 14: D5-5 → D5-7; bổ sung ý Q-28 |
| 2026-10-13 | Hồng (QA) + AI | Debate S4b nhóm 5 câu 15: D5-8 → D5-10 |
| 2026-10-13 | Hồng (QA) + AI | Debate S4b nhóm 5 câu 16: D5-11 → D5-13; bổ sung ý Q-06 |
| 2026-10-13 | Hồng (QA) + AI | Debate S4b nhóm 5 câu 17: D5-14 → D5-16; thêm Q-29, Q-30 |
| 2026-10-13 | Hồng (QA) + AI | Debate S4b nhóm 5 câu 18: D5-17 → D5-19. Tạm dừng debate chờ BA trả lời 24 câu |
| 2026-10-13 | Hồng (QA) | Chốt cách debate mới (câu hỏi mở, Hồng nói trước, theo thứ tự BR); giữ 42 điểm đã có |
