---
featureId: CR-ANH-VIEWER   # mã tạm — CR chưa được cấp mã
stage: S4a
gate: closed
materialOpen: 4          # đề xuất của AI — chờ người dùng chốt mức (Q-01, Q-04, Q-15, Q-16)
nonMaterialOpen: 12
gateOpenedBy:
gateOpenedAt:
updatedAt: 2026-10-14
---

# Requirement Understanding / Alignment Summary — CR-ANH-VIEWER: Thao tác với ảnh trong trình xem ảnh

Trạng thái: **S4a — câu hỏi đã lập, chờ người dùng chốt mức và gửi BA Đỗ Văn An.** Debate S4b bắt đầu ngay với BR
không phụ thuộc BA (theo rule 04 §4b: thứ tự BR, câu hỏi mở, Hồng nói trước).

## 1. Nguồn và phạm vi đã đọc

Xem mục 1 của `01-requirement-analysis.md`. Nguồn chính: CR v1.1 (13/10/2026, BA Đỗ Văn An). Dùng chung: G003 v1.11
UC-08 / E09 / BR19–BR23, BR25, BR27 / §10G. Thiếu: 3 wireframe, spec viewer hiện hành.

## 2. Requirement / Business rule đã trích

| Mã | Tóm tắt | Nguồn | Trạng thái hiểu |
| --- | --- | --- | --- |
| BR-01 → BR-03 | Tải xuống: luồng, nội dung file, lỗi | `CR:63-80` | `[NGUỒN]` — còn mở Q-01 (quyền), Q-07 (file mất) |
| BR-04 | Xoay 90° CW, metadata, reset | `CR:84-90` | `[NGUỒN]` rõ |
| BR-05, BR-06 | Zoom: chuỗi hệ số, cơ sở, khóa biên, reset, tâm | `CR:94-111` | `[NGUỒN]` — còn mở Q-03 (ảnh nhỏ), Q-08 (icon khóa) |
| BR-07 | Kéo ảnh | `CR:117-131` | `[NGUỒN]` — Q-02 (click nền) |
| BR-08 | Esc, focus | `CR:136-141` | `[NGUỒN]` — Q-09 (focus) |
| BR-09 | Không phím tắt, không zoom chuột | `CR:43-45`, `CR:113`, `CR:142` | `[NGUỒN]` rõ |
| BR-10 | Tooltip | `CR:146-160` | `[NGUỒN]` — Q-08 |
| BR-11 | Bố cục toolbar | `CR:162-170` | `[NGUỒN]` — Q-02 (hiện hành), Q-10 (wireframe) |
| BR-12, BR-13 | Chuyển tiếp từ viewer | `CR:198-216` + G003 | `[NGUỒN]` — còn mở Q-04 (chú thích), Q-05 (bộ đếm), Q-06 (tin thu hồi) |
| BR-14 | Không sửa nguồn, không ảnh hưởng người khác | `CR:25`, `CR:270` | `[NGUỒN]` rõ |

## 3. Bảng câu hỏi debate

| Q | Mức (đề xuất) | Trích dẫn + nguồn | Vì sao chưa rõ | Các cách hiểu có căn cứ | Ảnh hưởng tới test | Cần ai xác nhận | Trạng thái | Câu trả lời | Ai trả lời · ngày · kênh |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Q-01 | **Trọng yếu** (quyền) | `CR:63`, `CR:80` | "Quyền theo chính sách hiện có" — không tài liệu | (a) Chỉ cần quyền xem hội thoại (G003), không có quyền tải riêng. (b) Có quyền tải riêng — cần tài liệu | Có / không có nhóm case "không có quyền tải"; icon ẩn / khóa / lỗi | BA An | Mở | | |
| Q-02 | Không trọng yếu | `CR:15`, `CR:128`, `CR:130`, `CR:170`, `CR:254` | Không spec viewer hiện hành: dải thumbnail gồm ảnh nào; điều hướng ở ảnh đầu / cuối; click nền có đóng viewer không. **Bổ sung (D7-2):** click đơn **trên ảnh** (không kéo) có đóng viewer không | Tài liệu không nói | Case hồi quy AC-33 và case "nhả chuột không đóng viewer" ĐO & GHI | BA An (cho nguồn) | Mở — cô lập | | |
| Q-03 | Không trọng yếu | `CR:98-99` | Ảnh nhỏ hơn vùng xem: zoom 2 / 4 có vượt kích thước tự nhiên không | (a) "Không phóng vượt tự nhiên" chỉ áp cho cơ sở (hệ số 1); zoom vẫn × hệ số. (b) Áp cho cả zoom — ảnh nhỏ không bao giờ lớn hơn tự nhiên | Kỳ vọng AC-10 cho ảnh nhỏ | BA An | Mở — cô lập | | |
| Q-04 | **Trọng yếu** (nội dung gửi) | `CR:205-206`; `G036:147`; `G003:205` | Tin ảnh có chú thích: chuyển tiếp từ viewer gửi kèm chú thích không | (a) Chỉ ảnh (`CR:205` "một ảnh đang xem"). (b) Ảnh + chú thích ("nội dung tin nhắn gốc", G003 UC-08 b5) | Kỳ vọng AC-37 khi tin có chú thích | BA An | Mở | | |
| Q-05 | Không trọng yếu | `CR:204`; `G003:531-545` | Modal từ viewer có phần "Đã chọn X/50" không; "Gửi (X)" và "X/99" giữ không | `[DIỄN GIẢI AI]` không có X/50 (một tin nguồn); giữ "Gửi (X)", "X/99" | Chi tiết UI modal trong case AC-36 | BA An | Mở — cô lập | | |
| Q-06 | Không trọng yếu | `CR:200`; `G036:153` | Click ảnh của tin đã thu hồi có mở viewer không; nếu mở, Tải xuống ra sao | Tài liệu không nói | Cách dựng AC-41; case tải ảnh tin thu hồi | BA An | Mở — cô lập | | |
| Q-07 | Không trọng yếu | `CR:75` | Khi nào "không còn file nguồn" | Tài liệu không nói | Cách dựng AC-07 | BA An / Dev | Mở — cô lập | | |
| Q-08 | Không trọng yếu | `CR:160`, `CR:233-234`, `CR:89` | Icon khóa có nhận hover hiện tooltip; click icon khóa có phản hồi gì. **Bổ sung (D4-3):** giai đoạn viewer mới hiện thumbnail mờ, chưa có bản nét, có tính là "chưa tải xong" (khóa Xoay / zoom) không | — | Case AC-12, AC-13, AC-30 phần tooltip | BA An | Mở — cô lập | | |
| Q-09 | Không trọng yếu | `CR:140` | Kiểm "trả focus về ảnh" bằng gì | — | Cách kiểm AC-25 | BA An / Dev | Mở — cô lập | | |
| Q-10 | Không trọng yếu | `CR:176-190` | Thiếu 3 wireframe | — | Bố cục kiểm theo chữ §4.7 | BA An (gửi file) | Mở — cô lập | | |
| Q-11 | Không trọng yếu | `CR:5`, `CR:9` | Chưa có mã CR; người yêu cầu là BA An | — | Tên thư mục / trace tạm `CR-ANH-VIEWER` | BA An | Mở — ghi chú | | |
| Q-13 | Không trọng yếu — đề nghị kỹ thuật | `CR:96` | Hệ số zoom không hiển thị nhưng là tiêu chí nghiệm thu; QA phải đo bằng DevTools | — | Nếu Dev gắn thuộc tính đọc được (vd `data-zoom`, `data-rotate` trên phần tử ảnh) thì kiểm nhanh và ít sai; không có thì đo kích thước render | Dev / BA An | Mở — cô lập | | |
| Q-14 | Không trọng yếu — từ debate D1-2 | `CR:78` | Tải A lỗi trong lúc đang xem B (hoặc đã đóng viewer): có hiện thông báo lỗi không; thông báo có nêu rõ là ảnh A không; icon trên B có bị ảnh hưởng không | (a) Hiện *"Không thể tải ảnh…"* kèm nhận diện ảnh A. (b) Không hiện gì khi không còn xem A. Tài liệu chỉ cấm hiện như lỗi của B | Kỳ vọng AC-06 / AC-07 phần thông báo đánh ❓ | BA An | Mở — cô lập | | |
| Q-15 | **Trọng yếu** (theo rule: hai cách đọc đều có căn cứ) — từ debate D2-1 | `CR:74` | Tên nguồn có đuôi **không khớp** định dạng thực tế (`IMG_001.jpg` chứa PNG): giữ nguyên tên hay đổi đuôi | (a) Giữ `IMG_001.jpg` — "giữ tên file nguồn hợp lệ". (b) Đổi thành `IMG_001.png` — "đuôi file khớp định dạng thực tế" | Kỳ vọng tên file trong case tải xuống với dữ liệu đuôi sai | BA An | Mở | | |
| Q-16 | **Trọng yếu** (đề xuất — nguy cơ gửi trùng; thuộc chức năng dùng chung G003 UC-08) — từ debate D13-2 | `CR:207`; `G003:273`, `G003:318` | Chuyển tiếp tới nhiều đích, một phần lỗi: modal hiện gì; Gửi lại gửi cho đích nào; tin lỗi có nằm trong đoạn chat đích với "Thử lại" không | (a) Modal giữ, đánh dấu đích lỗi, Gửi lại chỉ gửi đích lỗi. (b) Modal giữ, Gửi lại gửi cả 3 (trùng). (c) Tin lỗi nằm ở đoạn chat đích như tin gửi thường, thử lại tại đó | Kỳ vọng AC-40 với nhiều đích | BA An (và BA Trân vì là G003) | Mở | | |
| Q-12 | Người dùng chốt | `CR:8`, `CR:280` | CR v1.1 không có ô Status; dùng làm căn cứ viết test case không | — | — | Người dùng | Mở | | |

## 4. Cách hiểu đã thống nhất (Debate S4b)

### 4.1 Từ câu trả lời BA

Chưa có.

### 4.2 Debate Hồng ↔ AI theo thứ tự BR (câu hỏi mở, Hồng nói trước, dò lại tài liệu từng dòng)

Bắt đầu 2026-10-14. Thứ tự: BR-04 (xoay) → BR-05/06 (zoom, trừ ảnh nhỏ) → BR-07 (kéo) → BR-08 (Esc) → BR-09 →
BR-10 → BR-11 → BR-14 → BR-01/02 (tải, trừ quyền) → BR-12/13 (chuyển tiếp, trừ chú thích) → phần chờ BA.

**BR-04 — Xoay ảnh (đang debate)**

| # | Nội dung đã thống nhất | Nhãn | Dòng tài liệu đã dò | Ghi chú |
| ---: | --- | --- | --- | --- |
| D4-1 | "Hướng ban đầu" (góc 0° của viewer) = ảnh **đã hiển thị đúng chiều theo EXIF**: ảnh chụp điện thoại có metadata xoay 90° thì khi mở viewer đã thấy đứng đúng, **không** phải người dùng bấm Xoay để sửa; từ đó mới đếm 0 → 90 → 180 → 270. Xoay kép = áp EXIF rồi lại áp thêm 90° — là lỗi | `[NGUỒN]` | `CR:86` "góc ban đầu tính từ hướng ảnh đã được hiển thị đúng theo metadata, tránh xoay kép"; `CR:253` AC-32 "có metadata xoay → không xoay kép" | Hồng nói trước: "hiển thị đúng hướng xoay 90 độ" — AI đọc cùng ý; AI xác nhận lại cách diễn đạt ở lượt 2. Dữ liệu test: file có EXIF Orientation ≠ 1 (vd 6 = xoay 90° CW), đối chiếu với cách khung chat hiện ảnh đó (G036 BR14) — `[QA BỔ SUNG]` |

| D4-2 | Xoay khi đang zoom ×2 và đã kéo: ảnh ngang 2000×1000 thành **dọc** (tỉ lệ 1000×2000), **hệ số về 1**, hiển thị **vừa vùng xem theo chiều dọc** (nhỏ hơn trạng thái ×2 trước đó), **căn giữa**, vị trí kéo **bỏ** | `[NGUỒN]` | `CR:87` "căn giữa và hiển thị vừa vùng xem theo góc mới; vị trí kéo trước đó được reset"; `CR:107` "Xoay ảnh → căn giữa, hệ số 1 theo góc mới" | Hồng nói trước: "ảnh xoay dọc 1000×2000" (phần chiều); phần kích thước / hệ số / vị trí AI bổ sung từ tài liệu, Hồng xác nhận ở lượt 3 |
## 5. Các cách hiểu khác nhau còn tồn tại
| D4-3 | "Chưa tải xong" = trình duyệt **chưa nhận đủ dữ liệu ảnh để hiển thị bản nét** trong viewer (tải về để xem) — **không phải** thao tác Tải xuống (BR-01). Tài liệu tách hai trạng thái: tooltip *"Đang tải ảnh"* (đang nạp để xem, khóa Xoay / Phóng to / Thu nhỏ) và *"Đang chuẩn bị tải xuống"* (đang xử lý tác vụ tải file). Giai đoạn chỉ có thumbnail mờ có tính là "chưa tải xong" không → tài liệu không nói | `[NGUỒN]` (hai trạng thái tách biệt) + `[DIỄN GIẢI AI]` (thumbnail mờ = chưa tải xong) | `CR:89`; `CR:251` AC-30; `CR:160` hai lý do khóa; `CR:63` tải xuống cần "ảnh hiện hành đã tải thành công" | Hồng: "là lúc tải ảnh về máy" — AI hiểu là nạp để xem, xác nhận lại ở lượt sau. Cách dựng: DevTools throttle Slow 3G + ảnh dung lượng lớn — `[QA BỔ SUNG]`; thêm ý "thumbnail mờ" vào Q-08 |

BR-04 **xong** (D4-1 → D4-3).

**BR-05 / BR-06 — Zoom (đang debate)**

| # | Nội dung đã thống nhất | Nhãn | Dòng tài liệu đã dò | Ghi chú |
| ---: | --- | --- | --- | --- |
| D5-1 | Hệ số zoom là **tiêu chí nghiệm thu** dù không hiển thị; kích thước cơ sở = ảnh vừa vùng xem (vùng xem trừ toolbar, thumbnail, khoảng nút điều hướng). Giao diện không có số nên **phải đo**: dùng DevTools lấy kích thước khung ảnh đang render (Elements → Computed, hoặc Console `getBoundingClientRect()` của phần tử ảnh) ở hệ số 1, rồi sau mỗi click so tỉ lệ (1,25 → 1,5 → 2 → 3 → 4), dung sai ±1 px. Đo cả chiều rộng và chiều cao để kiểm "giữ tỷ lệ" | `[NGUỒN]` (hệ số là tiêu chí) + `[QA BỔ SUNG]` (cách đo) | `CR:96` "hệ số này phục vụ tính kích thước và nghiệm thu, không hiển thị cho user"; `CR:98-99` | Hồng: "giao diện không hiện số 1,25, tôi chưa biết đo thế nào" → AI đề xuất cách đo; đề nghị Dev gắn thuộc tính kiểm thử (vd `data-zoom`) — Q-13 |

| D5-2 | Từ hệ số 1, bấm Phóng to lần lượt: 1,25 → 1,5 → 2 → 3 → 4 = **5 lần**; lần thứ 5 là lần cuối còn làm ảnh to lên; ngay khi đạt 4 icon Phóng to khóa (lần bấm thứ 6 không có tác dụng, tooltip "Đã đạt mức phóng to tối đa"). Chiều ngược từ 1: 0,75 → 0,5 = **2 lần** rồi khóa Thu nhỏ | `[NGUỒN]` | `CR:96` chuỗi 8 mức; `CR:105-106`; AC-12/13 `CR:233-234` | Hồng nói trước: "4 lần, lần 4" — **lệch với tài liệu** (bỏ sót mức 3 hoặc 1,5); AI dò chuỗi → theo tài liệu 5 lần. Case ghi rõ bảng đếm từng lần để dev / tester không nhầm |
Q-01, Q-03, Q-04, Q-15 — hai cách hiểu, xem bảng. Q-02, Q-05 → Q-09 — tài liệu không nói: **Unresolved / BA Clarification Required**.
| D6-1 | Zoom **không** kéo ảnh về tâm ảnh: điểm ảnh **đang nằm ở tâm vùng xem** (ở tình huống này là vùng góc trên trái của ảnh) **vẫn ở tâm** sau khi phóng to; ảnh chỉ dịch thêm khi phải giới hạn để không hở mép. Ảnh chỉ về "tâm ảnh ở giữa" khi xoay, chuyển ảnh, mở lại (BR-06 reset) | `[NGUỒN]` | `CR:111` "điểm ảnh tại tâm vùng xem giữ ở tâm sau khi thay đổi kích thước, trừ trường hợp cần giới hạn vị trí"; `CR:107-108` các trường hợp reset | Hồng nói trước: "phần giữa ảnh" — **lệch với tài liệu**; chốt theo tài liệu. Case: đánh dấu điểm ảnh nhận biết được (góc trên trái) ở tâm trước khi zoom, sau zoom điểm đó vẫn ở tâm (dung sai vài px) |

| D6-2 | Thu nhỏ cửa sổ khi đang hệ số 2: kích thước cơ sở tính lại theo vùng xem mới (nhỏ hơn) → ảnh trên màn hình **nhỏ đi**, nhưng **hệ số vẫn là 2** (gấp đôi cơ sở mới), góc xoay giữ; vị trí kéo được giới hạn lại cho khớp khung mới; toolbar vẫn thấy | `[NGUỒN]` | `CR:109`; AC-31 `CR:252` | Hồng nói trước: "nhỏ đi" — khớp; phần hệ số AI bổ sung từ tài liệu |
| D6-3 | Chuyển ảnh (trước / sau / thumbnail) hoặc đóng rồi mở lại cùng ảnh → viewer khởi tạo như mới: hướng ban đầu, hệ số 1, căn giữa — không nhớ biến đổi của lần xem trước | `[NGUỒN]` | `CR:108`; AC-21, AC-22 `CR:242-243` | AI ghi theo tài liệu, **chưa hỏi Hồng** — nêu lại ở lượt BR-07 để Hồng xác nhận hoặc sửa |

BR-05 / BR-06 **xong** phần không phụ thuộc BA (còn Q-03 ảnh nhỏ, Q-08 icon khóa, Q-13).

**BR-07 — Kéo ảnh (đang debate)**

| # | Nội dung đã thống nhất | Nhãn | Dòng tài liệu đã dò | Ghi chú |
| ---: | --- | --- | --- | --- |
| D7-1 | Ảnh chỉ tràn **ngang**, kéo chéo lên-trái → ảnh **dịch sang trái** theo thành phần ngang của con trỏ (tới giới hạn mép), **không** dịch dọc, chiều dọc vẫn căn giữa. Ảnh chỉ "không di chuyển" khi **không tràn chiều nào** (toàn ảnh trong vùng xem — AC-18) | `[NGUỒN]` | `CR:123` "tràn theo một chiều, chỉ cho dịch chuyển theo chiều đó; chiều không tràn tiếp tục căn giữa"; AC-19 `CR:240` "Kéo chéo → dịch ngang trong giới hạn; chiều dọc giữ căn giữa"; AC-18 `CR:239` | Hồng nói trước: "ảnh không di chuyển" — **lệch với tài liệu** (đó là kỳ vọng của AC-18, không phải AC-19); chốt theo tài liệu |
## 6. Điểm đã thống nhất và điểm còn mở
| D7-2 | Nhấn xuống trên ảnh, rê **2 px** rồi thả: **chưa đủ 4 CSS px → không phải kéo**, hệ thống coi là **click đơn** trên ảnh; không bắt đầu kéo, không zoom; ảnh không dịch. Click đơn **trên ảnh** có đóng viewer không → tài liệu **không nói** (`CR:130` chỉ bảo vệ nhả chuột *sau kéo* khỏi bị tính là click nền; click nền đóng viewer là hành vi "hiện hành" chưa có spec — Q-02) | `[NGUỒN]` (không phải kéo) + `[CẦN XÁC NHẬN]` (click đơn trên ảnh có đóng viewer) | `CR:128` "di chuyển từ 4 CSS px được nhận diện là kéo; click đơn không bắt đầu kéo hoặc zoom"; `CR:130` | Hồng nói trước: "hành vi kéo ảnh, sau khi thả vẫn mở viewer" — phần "kéo" **lệch với tài liệu** (dưới ngưỡng 4 px); phần "viewer vẫn mở" tài liệu không khẳng định → thêm vào Q-02. Case: rê 3 px (không kéo) và 4–5 px (kéo) — cần công cụ đo pixel hoặc script |


**BR-08 — Esc (đang debate)**

| # | Nội dung đã thống nhất | Nhãn | Dòng tài liệu đã dò | Ghi chú |
| ---: | --- | --- | --- | --- |
| D8-1 | Tooltip đang hiện + Esc một lần → **đóng viewer và tooltip cùng lúc**; màn hình còn lại **đoạn chat** ở đúng vị trí cuộn, nội dung đang soạn còn nguyên, hội thoại không đóng. Tooltip **không** được tính là "hộp thoại khác" (không có chuyện Esc lần 1 chỉ tắt tooltip, lần 2 mới đóng viewer) | `[NGUỒN]` | `CR:139` "tooltip đang hiện, Esc đóng viewer cùng tooltip"; `CR:137`; `CR:140` "hộp thoại khác" là lớp riêng; AC-23 `CR:244` | Hồng nói trước: "đóng viewer" — khớp |
- Đã thống nhất: chưa có.
| D8-2 | Giữ Esc ~2 giây (bàn phím tự lặp) → chỉ **một** lần "đóng" có hiệu lực: viewer đóng, các lần lặp sau **không** đóng hội thoại hay lớp chat phía sau; kết quả nhìn thấy giống nhấn Esc một lần. Cách kiểm ngoài quan sát: để sẵn trạng thái phía sau dễ mất (panel phải đang mở, nội dung đang soạn, một popup chat có thể đóng bằng Esc) rồi giữ Esc — các thứ đó phải còn nguyên | `[NGUỒN]` (một lần, không truyền xuống) + `[QA BỔ SUNG]` (cách kiểm) | `CR:138` "một lần nhấn không truyền tiếp xuống lớp chat… nhấn giữ Esc không làm đóng thêm lớp phía sau"; AC-24 `CR:245` | Hồng nói trước: "1" — khớp; phần cách kiểm AI bổ sung |

BR-08 **xong** phần không phụ thuộc BA (còn Q-09 focus).

**BR-09 — Không phím tắt, không zoom chuột (đang debate)**

| # | Nội dung đã thống nhất | Nhãn | Dòng tài liệu đã dò | Ghi chú |
| ---: | --- | --- | --- | --- |
| D9-1 | Ctrl + "+" khi viewer mở → **trình duyệt zoom trang như bình thường**, viewer không chặn; **hệ số zoom của ảnh không đổi**. Vì zoom trang làm vùng xem đổi kích thước, ảnh trên màn hình có thể to lên theo trang nhưng đó là hệ quả của BR-06 "thay đổi kích thước cửa sổ" (tính lại cơ sở, giữ hệ số), không phải viewer zoom | `[NGUỒN]` (không ghi đè, không nhận phím) + `[DIỄN GIẢI AI]` (zoom trang ≈ resize) | `CR:113` "không ghi đè thao tác zoom trang của trình duyệt"; AC-26 `CR:247`; `CR:109` | Hồng nói trước: "trang zoom, ảnh trong viewer không nhận thao tác" — khớp. Case: đọc hệ số qua Q-13 / đo tỉ lệ so với cơ sở mới |
- Còn mở — **trọng yếu** (đề xuất): Q-01, Q-04, Q-15 (từ debate D2-1), Q-16 (từ debate D13-2).

**BR-10 — Tooltip (đang debate)**

| # | Nội dung đã thống nhất | Nhãn | Dòng tài liệu đã dò | Ghi chú |
| ---: | --- | --- | --- | --- |
| D10-1 | Click icon khi tooltip đang hiện (chuột vẫn trên icon) → tooltip **ẩn** ngay khi kích hoạt thao tác và **không tự hiện lại** chừng nào chuột chưa rời rồi vào lại icon. Tài liệu chỉ ghi điều kiện ẩn, không ghi "hiện lại sau 300 ms khi chuột vẫn đứng yên" → phần "không tự hiện lại" là suy ra | `[NGUỒN]` (ẩn khi kích hoạt) + `[DIỄN GIẢI AI]` (không hiện lại khi chuột đứng yên) | `CR:159` "ẩn khi… kích hoạt thao tác"; AC-29 `CR:250` | Hồng nói trước: "ẩn" — khớp. Case: kiểm ẩn ngay sau click; chuột đứng yên 1 giây không hiện lại — phần sau ghi ĐO & GHI |
- Còn mở — không trọng yếu (cô lập): Q-02, Q-03, Q-05 → Q-11. Q-12 chờ người dùng.
| D10-2 | Icon Tải xuống có **hai tooltip theo trạng thái**: đang xử lý (khóa) → *"Đang chuẩn bị tải xuống"*; sau khi file đã chuyển cho trình duyệt (icon mở lại) → *"Tải xuống"*. Tương tự Xoay / Phóng to / Thu nhỏ khi ảnh chưa tải → *"Đang tải ảnh"*; Phóng to ở mức 4 → *"Đã đạt mức phóng to tối đa"*; Thu nhỏ ở 0,5 → *"Đã đạt mức thu nhỏ tối thiểu"* | `[NGUỒN]` | `CR:160`; `CR:148` bảng tooltip; `CR:105-106`; `CR:66-68` trạng thái icon | Hồng nói trước: "Tải xuống" — đúng cho trạng thái sau khi chuyển giao; **thiếu** trạng thái đang xử lý ("Đang chuẩn bị tải xuống"); chốt theo tài liệu. Dựng trạng thái đang xử lý: ảnh lớn + Slow 3G (như D4-3) |

BR-10 **xong** phần không phụ thuộc BA (còn Q-08 icon khóa có nhận hover).

**BR-11 — Bố cục (đang debate)**

| # | Nội dung đã thống nhất | Nhãn | Dòng tài liệu đã dò | Ghi chú |
| ---: | --- | --- | --- | --- |
| D11-1 | Từ trên xuống: **nút Đóng** ở góc trên phải (ngoài toolbar) → **vùng ảnh** nền tối, nút Ảnh trước / Ảnh sau ở hai bên → **toolbar** căn giữa phía dưới vùng ảnh → **dải thumbnail** dưới toolbar. Toolbar luôn nhìn thấy, tách khỏi lớp ảnh biến đổi | `[NGUỒN]` | `CR:163-164`, `CR:168` | Hồng nói trước: "nút đóng không nằm trong toolbar" — khớp; thứ tự vùng AI bổ sung từ tài liệu |
| D11-2 | Thứ tự icon toolbar trái → phải: **Tải xuống → Chuyển tiếp → Xoay ảnh → vạch phân cách → Phóng to → Thu nhỏ** (Phóng to **trước** Thu nhỏ) | `[NGUỒN]` | `CR:165`; AC-02 `CR:223` | Hồng nói trước: "… xoay – zoom out – zoom in" — **lệch** thứ tự hai icon zoom; chốt theo tài liệu. Case AC-02 kiểm đúng thứ tự và có vạch phân cách sau Xoay ảnh |

BR-11 **xong** phần không phụ thuộc BA (còn Q-02 hiện hành, Q-10 wireframe; kích thước 40 × 40 / 20–24 px đo bằng DevTools).

**BR-01 / BR-02 / BR-03 — Tải xuống (đang debate; phần quyền chờ Q-01)**

| # | Nội dung đã thống nhất | Nhãn | Dòng tài liệu đã dò | Ghi chú |
| ---: | --- | --- | --- | --- |
| D1-1 | Trách nhiệm của ứng dụng **kết thúc khi đã chuyển tác vụ cho trình duyệt**: tiêu chí pass của BR-01 là thông báo đúng chữ *"Đã bắt đầu tải ảnh. Kiểm tra mục tải xuống của trình duyệt."* + icon trở lại thao tác được + viewer vẫn mở; **không** được báo "đã lưu thành công". File có xuất hiện trong Downloads hay chưa (đang tải dở, hộp thoại chọn nơi lưu, tên trùng) là việc của trình duyệt / OS → **không phải tiêu chí pass / fail của case này**, chỉ ĐO & GHI để đối chiếu nội dung file (BR-02) | `[NGUỒN]` | `CR:67-68`; `CR:79` "không báo đã lưu thành công… nếu ứng dụng chỉ biết đã chuyển tác vụ cho trình duyệt"; `CR:74` "trình duyệt / OS xử lý tên trùng" | Hồng nói trước: "pass vì chưa chọn thư mục lưu" — kết luận pass **khớp**, nhưng lý do là một hành vi của trình duyệt (hộp thoại lưu), không phải căn cứ của tài liệu; chốt theo căn cứ tài liệu |

| D1-2 | Tải A đang xử lý rồi chuyển sang B: khóa click lặp chỉ áp cho **cùng tác vụ** (A), nên trên B icon Tải xuống **bấm được** (tác vụ mới, gắn B). Tác vụ A vẫn chạy, không tải nhầm B. Nếu A lỗi khi đang xem B: tài liệu chỉ cấm **hiển thị lỗi của A như lỗi của B** — có hiện thông báo không, và thông báo có nêu rõ ảnh A không → tài liệu **không nói** | `[NGUỒN]` (icon B bấm được; không tải nhầm) + `[CẦN XÁC NHẬN]` (lỗi của A hiện thế nào khi đang xem B) | `CR:66` "không nhận click lặp cho cùng tác vụ"; `CR:77-78`; AC-06 `CR:227` | Hồng nói trước: "bấm được, có báo lỗi" — phần icon khớp; phần "có báo lỗi" tài liệu không khẳng định, chỉ cấm báo nhầm → thêm Q-14 |
## 7. Cần BA xác nhận
| D2-1 | Tên nguồn `IMG_001.jpg` nhưng nội dung là PNG: **hai quy tắc của cùng một dòng mâu thuẫn** — "giữ tên file nguồn hợp lệ" → `IMG_001.jpg` (Hồng); "đuôi file khớp định dạng thực tế" → `IMG_001.png` (AI). Tài liệu không nói quy tắc nào ưu tiên; ví dụ `anh-chat-{imageId}.{đuôi-thực-tế}` chỉ cho trường hợp thiếu tên | `[CẦN XÁC NHẬN]` | `CR:74`; AC-04 `CR:225` chỉ nói trường hợp "file nguồn không có tên" | Hai bên lệch, **cả hai có căn cứ** → theo rule 04 §4b.6.4 nâng thành câu hỏi trọng yếu Q-15. Case AC-04 giữ; case "tên có đuôi sai" ❓ Q-15 |


**BR-12 / BR-13 — Chuyển tiếp từ viewer (đang debate; chú thích chờ Q-04)**

| # | Nội dung đã thống nhất | Nhãn | Dòng tài liệu đã dò | Ghi chú |
| ---: | --- | --- | --- | --- |
| D13-1 | Modal Chuyển tiếp đang mở, nhấn Esc một lần → **chỉ modal đóng** (theo hành vi modal dùng chung), **viewer vẫn mở**, hội thoại không đóng; ảnh A **giữ nguyên góc 90° và mức zoom** như trước khi mở modal, vị trí kéo giữ; focus về icon Chuyển tiếp; không gửi ảnh | `[NGUỒN]` | `CR:212` "Esc chỉ xử lý modal… không truyền tiếp để đóng viewer"; `CR:211` "trở về đúng ảnh, góc xoay, mức zoom và vị trí kéo trước đó"; AC-38, AC-39 `CR:260-261` | Hồng nói trước: "Esc đóng ảnh trong viewer, ảnh reset về ban đầu" — **lệch cả hai ý** với tài liệu (viewer không đóng; không reset); chốt theo tài liệu. Reset chỉ xảy ra khi chuyển ảnh / đóng rồi mở lại (D6-3) |
Nội dung gửi BA Đỗ Văn An: `cau-hoi-gui-BA.md` cùng thư mục.
| D12-1 | Ảnh gửi đi là **ảnh A đã ghi nhận tại thời điểm click Chuyển tiếp**; ảnh mới tới làm dải thumbnail phía sau thay đổi **không** đổi nội dung chờ gửi; click Chuyển tiếp lặp không mở thêm modal. Cách dựng: hai tài khoản — tài khoản 2 gửi ảnh vào hội thoại trong lúc modal đang mở ở tài khoản 1 | `[NGUỒN]` + `[QA BỔ SUNG]` (cách dựng) | `CR:203` "ghi nhận ảnh đang xem và tin nhắn nguồn tại thời điểm click"; `CR:210` "ảnh đã ghi nhận không thay đổi theo cập nhật danh sách ảnh phía sau"; AC-43 `CR:265` | Hồng nói trước: "ảnh đã được select" — khớp |

| D13-2 | Thất bại khi chuyển tiếp: tài liệu chỉ ghi **toast "Không thể chuyển tiếp, vui lòng thử lại" + modal giữ nguyên để thử lại** (E09). Trường hợp **3 đích, 2 thành công 1 lỗi**: cả CR lẫn G003 **không nói** (i) modal có đánh dấu đích nào lỗi không, (ii) bấm Gửi lại gửi cho cả 3 hay chỉ đích lỗi (nguy cơ gửi trùng 2 đích đã thành công), (iii) tin lỗi có xuất hiện trong đoạn chat đích dạng "lỗi gửi + Thử lại" (G003 §7) để gửi lại từ đó không | `[NGUỒN]` (toast + giữ modal) + `[CẦN XÁC NHẬN]` (lỗi từng đích) | `CR:207`; `G003:273` E09; `G003:318` BR22 "gửi song song đến từng đích"; `G003:211-213` UC-08 b5–b6 | Hồng nói trước: "tin không gửi được vẫn ở đoạn chat của đích cuối, gửi lại từ đoạn chat đó" — là cơ chế của G003 §7 cho tin gửi thường, **không có dòng nào** nói áp cho chuyển tiếp; AI đọc theo E09 (thử lại từ modal). Hai bên lệch, tài liệu không ủng hộ bên nào đủ → Q-16 |
## 8. Ngoài phạm vi / chưa có căn cứ

- Theo `CR:43-45`: phím tắt ngoài Esc; nút vừa khung; % zoom; bảng phím tắt; chọn nhiều ảnh từ viewer; zoom cuộn chuột / nhấp đúp / đa điểm; sửa, lưu ảnh đã xoay, crop, vẽ; tải nhiều / ZIP; in; video / PDF.
- Mobile / cảm ứng: CR chỉ áp desktop web (`CR:31`).
- Quyền, bộ lọc, giới hạn, cơ chế gửi của Chuyển tiếp: theo G003, CR không định nghĩa lại (`CR:198`).

## 9. Change Proposal / New Requirement Candidate `[ĐỀ XUẤT THAY ĐỔI]`

Chưa có.

## 10. QA coverage bổ sung dự kiến `[QA BỔ SUNG]`

- Dung sai đo: hệ số zoom (đo kích thước hiển thị), 4 CSS px, 300 ms, 40 × 40 px.
- Ảnh đặc biệt: rất dài / rất rộng, ảnh nhỏ hơn vùng xem, ảnh có EXIF xoay, ảnh GIF / WebP, ảnh lỗi tải.
- Tổ hợp: xoay → zoom → kéo → chuyển ảnh → quay lại; tải trong lúc đang kéo; mở modal chuyển tiếp trong lúc đang tải.
- Cửa sổ nhỏ (390px) tuy CR chỉ nói desktop — ĐO & GHI.

## 11. Xác nhận mở cổng

- [ ] Điểm trọng yếu còn mở = 0 (hiện 4: Q-01, Q-04, Q-15, Q-16 — chờ BA An)
- [ ] Debate S4b đã đi hết các BR có điểm trọng yếu (mục 4.2 có nội dung)
- [ ] Người dùng đã chốt Q-12
- Người dùng xác nhận: —

## Lịch sử cập nhật

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
| 2026-10-14 | AI (Orchestrator) | Tạo bản đầu sau Requirement Analysis: 12 câu, 2 đề xuất trọng yếu (Q-01 quyền tải, Q-04 chú thích khi chuyển tiếp), cổng đóng |
| 2026-10-14 | Hồng (QA) + AI | Debate S4b BR-04 lượt 1: D4-1 (hướng ban đầu theo EXIF) |
| 2026-10-14 | Hồng (QA) + AI | Debate S4b BR-04 lượt 2: D4-2 (xoay khi đang zoom / kéo) |
| 2026-10-14 | Hồng (QA) + AI | Debate S4b BR-04 lượt 3: D4-3 (chưa tải xong); bổ sung Q-08. BR-04 xong |
| 2026-10-14 | Hồng (QA) + AI | Debate S4b BR-05 lượt 1: D5-1 (cách đo hệ số zoom); thêm Q-13 |
| 2026-10-14 | Hồng (QA) + AI | Debate S4b BR-05 lượt 2: D5-2 (5 lần tới mức 4) — Hồng đọc 4 lần, chốt theo tài liệu |
| 2026-10-14 | Hồng (QA) + AI | Debate S4b BR-06 lượt 1: D6-1 (tâm vùng xem giữ nguyên khi zoom) — Hồng đọc "giữa ảnh", chốt theo tài liệu |
| 2026-10-14 | Hồng (QA) + AI | Debate S4b BR-06 lượt 2: D6-2, D6-3. BR-05/06 xong phần không chờ BA |
| 2026-10-14 | Hồng (QA) + AI | Debate S4b BR-07 lượt 1: D7-1 (tràn một chiều) — Hồng đọc "không di chuyển", chốt theo tài liệu |
| 2026-10-14 | Hồng (QA) + AI | Debate S4b BR-07 lượt 2: D7-2 (ngưỡng 4 px) — phần "kéo" chốt theo tài liệu; bổ sung Q-02 |
| 2026-10-14 | Hồng (QA) + AI | Debate S4b BR-08 lượt 1: D8-1 (Esc khi tooltip đang hiện) |
| 2026-10-14 | Hồng (QA) + AI | Debate S4b BR-08 lượt 2: D8-2 (giữ Esc). BR-08 xong phần không chờ BA |
| 2026-10-14 | Hồng (QA) + AI | Debate S4b BR-09 lượt 1: D9-1 (Ctrl +) |
| 2026-10-14 | Hồng (QA) + AI | Debate S4b BR-10 lượt 1: D10-1 (tooltip ẩn khi click) |
| 2026-10-14 | Hồng (QA) + AI | Debate S4b BR-10 lượt 2: D10-2 (tooltip theo trạng thái). BR-10 xong phần không chờ BA |
| 2026-10-14 | Hồng (QA) + AI | Debate S4b BR-11 lượt 1: D11-1, D11-2 — Hồng đọc ngược thứ tự zoom, chốt theo tài liệu |
| 2026-10-14 | Hồng (QA) + AI | Debate S4b BR-01 lượt 1: D1-1 (ranh giới trách nhiệm tải xuống) |
| 2026-10-14 | Hồng (QA) + AI | Debate S4b BR-01 lượt 2: D1-2 (tải A, chuyển B); thêm Q-14 |
| 2026-10-14 | Hồng (QA) + AI | Debate S4b BR-02 lượt 1: D2-1 — hai cách đọc đều có căn cứ → Q-15 trọng yếu |
| 2026-10-14 | Hồng (QA) + AI | Debate S4b BR-13 lượt 1: D13-1 (Esc trên modal) — Hồng đọc đóng viewer + reset, chốt theo tài liệu |
| 2026-10-14 | Hồng (QA) + AI | Debate S4b BR-12 lượt 2: D12-1 (ảnh ghi nhận tại click) |
| 2026-10-14 | Hồng (QA) + AI | Debate S4b BR-13 lượt 2: D13-2 (lỗi từng đích) → Q-16 trọng yếu |
