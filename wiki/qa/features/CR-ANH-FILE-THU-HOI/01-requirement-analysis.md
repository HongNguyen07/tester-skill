---
featureId: CR-ANH-FILE-THU-HOI   # mã tạm của QA — CR ghi "Mã yêu cầu: Chưa cấp" (CR:5); đổi khi BA cấp mã
title: "[Zalo chat] Thao tác đối với ảnh/file đã bị thu hồi"
analyzedAt: 2026-10-14
analyst: Requirement Analyst (AI) — người dùng: Hồng (QA)
---

# Requirement Analysis — CR-ANH-FILE-THU-HOI: Thao tác đối với ảnh/file đã bị thu hồi

Viết tắt tham chiếu: `CR` = `tailieu/[CR] [Zalo chat] Thao tác đối với ảnh-file đã bị thu hồi (1).md`;
`CR-V` = `tailieu/[CR] Bổ sung các thao tác đối với ảnh đang được mở ra xem trong đoạn chat (1).md` (v1.1 — tài liệu
CR dẫn ở `CR:112`); `G003` = `tailieu/G003 - Chat.md` (v1.11); `G036` = `tailieu/G036 - Giao diện khung hội thoại.md`;
`ESC` = `tailieu/[Zalo chat] Điều chỉnh lại hành vi hiển thị khi click nút ESC trong khi ảnh đang mở.md`;
`G001` = `tailieu/G001-lien-ket-tai-khoan-zalo.md`. Số sau dấu `:` là số dòng.

## 1. Nguồn và phạm vi đã đọc

| # | Tệp | Version ghi trong tệp | Phạm vi đã đọc | Ghi chú |
| ---: | --- | --- | --- | --- |
| 1 | `[CR] [Zalo chat] Thao tác đối với ảnh-file đã bị thu hồi (1).md` | 1.0 · nhận 13/10/2026 · BA Đỗ Văn An · ưu tiên **chưa xác định** | Toàn bộ (245 dòng) | Nguồn chính. **Mã yêu cầu: Chưa cấp** (`CR:5`). Change log trống (`CR:243-244`) |
| 2 | `[CR] Bổ sung các thao tác đối với ảnh… (1).md` (CR-V) | 1.1 · 13/10/2026 | §4.2 tải xuống (`61-80`), §4.4 zoom (`95-113`), §4.6 Esc (`136-142`), §4.7 tooltip (`146-160`), §4.9 chuyển tiếp (`196-207`), AC-41 (`263`) | CR kế thừa quy tắc viewer từ tài liệu này (`CR:112`). Đã có phân tích riêng ở `wiki/qa/features/CR-ANH-VIEWER/` |
| 3 | `G003 - Chat.md` | 1.11 · Final | UC-06 (`181-187`), BR06 / BR07 / BR09 / BR10 / BR12 (`302-309`), BR19 (`315`), §10D tin thu hồi và file & media (`455-469`), platform (`385-386`), OOS08 (`650`) | Quy tắc thu hồi hiện hành |
| 4 | `G036 - Giao diện khung hội thoại.md` | 1.0 Draft | BR14 ảnh (`147`), BR16 thẻ tệp (`149`), BR20 tin thu hồi (`153`), BR27 (`160`), BR28 màn cảm ứng (`161`) | Cách hiển thị trong khung chat |
| 5 | `[Zalo chat] Điều chỉnh… ESC….md` | không ghi version | Toàn bộ (27 dòng) | Esc chỉ đóng lightbox, giữ đoạn chat |
| 6 | `G001-lien-ket-tai-khoan-zalo.md` | 1.1 | BR03 (`140`), trạng thái Ngắt kết nối (`154-159`) | Chỉ cho tình huống "Zalo ngắt kết nối" (`CR:177`, AC-26) |

**Không có trong `tailieu/`:**
- Ảnh hiện trạng `hien-trang-anh-thu-hoi.png` (`CR:19`).
- Tài liệu **chính sách quyền** xem hội thoại / truy cập ảnh-file mà CR gọi là "chính sách hiện hành" (`CR:70`, `CR:73`, `CR:176`).
- Tài liệu **app Gopany** (viewer trên app, cơ chế tải và lưu file của app). G003 ghi *Platform: Web only* (`G003:385`), *Mobile app* là OOS08 (`G003:650`); CR lại áp dụng cho cả App Gopany (`CR:160`).
- Spec **viewer hiện hành** (dải thumbnail gồm ảnh nào, điều hướng đầu/cuối) — đã ghi thiếu ở CR-ANH-VIEWER Q-02.

## 2. Mục tiêu và phạm vi feature `[NGUỒN]`

- Trên web/app Gopany: ảnh của tin nhắn **đã thu hồi** vẫn click mở được viewer, viewer hiển thị **màu nguồn** và cho thao tác như ảnh chưa thu hồi; file đã thu hồi vẫn **tải xuống** được (`CR:23-25`). Trong đoạn chat vẫn giữ ảnh đen trắng và dòng **“Tin nhắn đã thu hồi”** (`CR:26`); việc mở/xem/tải **không** làm tin trở về chưa thu hồi (`CR:27`); không đổi gì trên Zalo app/web (`CR:28`).
- In scope (`CR:34-39`): tin ảnh và tin file đã thu hồi, do tài khoản Zalo liên kết gửi hoặc bên đối thoại gửi, khi Gopany **đã có nội dung** và đã ghi nhận trạng thái thu hồi; thu hồi trước hoặc sau phát hành; tin bị thu hồi **trong lúc** đang xem/tải.
- Thuật ngữ: “bị gỡ” = tin đã thu hồi; không phải file nguồn bị xóa vật lý hay hội thoại bị xóa/ẩn (`CR:41`).
- Out of scope (`CR:45-51`): khôi phục / gửi lại lên Zalo; đổi quyền xem, phân công, quyền tải; mở lại trả lời / phản ứng / chuyển tiếp / thu hồi lại; video, sticker, văn bản; nội dung Gopany chưa từng lưu hoặc nguồn không còn; chính sách xóa dữ liệu, thời hạn lưu; xem trước nội dung file.
- Đầu ra của CR: đặc tả Markdown (`CR:11`), không có wireframe.

## 3. Actor, precondition, trigger

| Mục | Nội dung | Nguồn | Nhãn |
| --- | --- | --- | --- |
| Actor | User web/app Gopany có quyền xem hội thoại và truy cập ảnh/file "theo chính sách hiện hành" | `CR:69-70` | `[NGUỒN]` — chính sách không có tài liệu (Q-01) |
| Precondition chung | (1) đang dùng web/app Gopany; (2) có quyền xem hội thoại và truy cập ảnh/file; (3) nội dung nguồn còn được Gopany lưu hoặc truy xuất hợp lệ | `CR:67-71` | `[NGUỒN]` |
| Precondition dữ liệu | Gopany đã có nội dung và đã ghi nhận trạng thái thu hồi của tin | `CR:35` | `[NGUỒN]` |
| Trigger ảnh | Click (web) / chạm (cảm ứng) vào vùng ảnh đã thu hồi trong đoạn chat | `CR:83`, `CR:89` | `[NGUỒN]` |
| Trigger file | Click / chạm thao tác tải của file đã thu hồi | `CR:127` | `[NGUỒN]` |
| Nền tảng | Web Gopany và App Gopany; Zalo app / Zalo web không thuộc CR | `CR:159-162` | `[NGUỒN]` |
| Hiện trạng | Ảnh thu hồi: đen trắng + dòng “Tin nhắn đã thu hồi”, không click mở viewer; file thu hồi: trạng thái tương tự, không cho tải | `CR:15-17` | `[NGUỒN]` |
| Hiện trạng theo G003 | Thu hồi chỉ trong 24 giờ (BR06); thực thi trên Zalo, Gopany chuyển tin sang disable + label `Đã thu hồi`, **giữ nội dung gốc** (BR07, §10D); thu hồi là terminal state (BR09) | `G003:302-305`, `G003:459` | `[NGUỒN]` |

## 4. Use case và luồng

| Mã | Tên | Luồng theo nguồn | Nguồn |
| --- | --- | --- | --- |
| UC-01 | Mở viewer từ ảnh đã thu hồi | Click/chạm ảnh → kiểm tra quyền, tải nguồn ảnh → viewer mở **đúng ảnh được chọn** → tải xong hiển thị **màu nguồn**, đúng tỷ lệ và hướng → user thao tác theo bộ viewer hỗ trợ → đóng viewer về đúng đoạn chat, giữ vị trí cuộn và nội dung đang soạn; ảnh trong chat vẫn đen trắng + nhãn | `CR:89-94` |
| UC-02 | Tải ảnh thu hồi từ viewer | Click Tải xuống → tải **ảnh nguồn**, không áp đen trắng, góc xoay, zoom, vị trí kéo | `CR:104`; luồng chi tiết kế thừa `CR-V:63-80` |
| UC-03 | Tải file đã thu hồi | Click/chạm thao tác tải → ghi nhận **đúng file tại thời điểm thao tác**, kiểm tra quyền → nguồn còn: tải bằng cơ chế tải của web/app → giữ đoạn chat, cuộn, trạng thái tin → nguồn mất / lỗi: thông báo, cho thử lại khi phù hợp | `CR:127-131` |
| UC-04 | Tin chuyển sang thu hồi trong lúc thao tác | 6 tình huống ở bảng §4.5 (đang xem, đang tải, đang mở, đóng viewer sau thu hồi, đổi ảnh A→B kết quả A về muộn, mở lại ở phiên khác) | `CR:146-151` |
| E-01 → E-10 | Trạng thái và lỗi | 10 tình huống ở bảng §4.7 — xem BR-09 | `CR:170-179` |

## 5. Business rule

CR không đánh mã BR; có bảng thay đổi CR-01 → CR-05 (`CR:59-63`) và các mục 4.2 → 4.8, 6. QA đánh mã tạm `BR-xx` theo
cơ chế, ghi kèm mục gốc. Mã này dùng chung cho debate, test case và báo cáo point.

| Mã QA | Nội dung (sát nguyên văn) | Mục gốc | Nguồn | Nhãn |
| --- | --- | --- | --- | --- |
| BR-01 | **Điều kiện mở/xem/tải:** (1) đang dùng web/app Gopany; (2) có quyền xem hội thoại và truy cập ảnh/file theo chính sách hiện hành; (3) nội dung nguồn còn được Gopany lưu hoặc truy xuất hợp lệ. **Trạng thái thu hồi không còn là lý do độc lập để chặn** mở viewer / tải; quyền, dữ liệu, khả năng truy xuất vẫn kiểm tra. Có thumbnail hoặc tên file **không đồng nghĩa** bản nguồn còn; **không** thay nguồn bằng thumbnail / file rỗng | §4.2 · CR-03 | `CR:67-75` | `[NGUỒN]` — "chính sách hiện hành" không có tài liệu (Q-01) |
| BR-02 | **Ảnh thu hồi trong đoạn chat:** giữ vị trí trong lịch sử, thời điểm tin, bố trí hiện hành; ảnh **tiếp tục đen trắng**, giữ dòng **“Tin nhắn đã thu hồi”** bên dưới; **vùng ảnh nhận click** (cảm ứng: chạm) để mở viewer; đen trắng chỉ là cách hiển thị trạng thái, **không ghi đè dữ liệu ảnh nguồn**; mở viewer **không** đổi trạng thái tin, **không** xóa nhãn | §4.3.1 · CR-01 | `CR:81-85` | `[NGUỒN]` — nhãn chữ khác G003 §10D "Đã thu hồi" (Q-05) |
| BR-03 | **Mở viewer và màu nguồn:** luồng 6 bước UC-01; viewer mở **đúng ảnh được chọn**; tải xong → **màu nguồn**, đúng tỷ lệ và hướng; đóng → về đúng đoạn chat, giữ cuộn và nội dung soạn. **“Màu nguồn”** = màu bản ảnh Gopany đang lưu/cung cấp; ảnh nguồn vốn đen trắng → viewer vẫn đen trắng, **không tự tô màu** | §4.3.2 · CR-02 | `CR:89-96` | `[NGUỒN]` |
| BR-04 | **Thao tác trong viewer:** ảnh thu hồi dùng **cùng bộ thao tác** với ảnh chưa thu hồi, **không tạo viewer riêng hoặc bộ giới hạn riêng** do thu hồi. Bảng 7 dòng: Tải xuống (ảnh nguồn, không áp đen trắng / xoay / zoom / kéo) · Xoay 90° CW mỗi click · Phóng to / Thu nhỏ bằng icon, không hiện % · Giữ chuột trái và kéo (cảm ứng: kế thừa kéo của viewer hiện hành) · Chuyển ảnh / chọn thumbnail: ảnh thu hồi **vẫn được chọn trong cùng tập ảnh**, không bị loại · Đóng bằng nút; Esc đóng và giữ user tại đoạn chat · Tooltip tiếng Việt, không gợi ý phím tắt. Mức zoom, giới hạn kéo, reset khi chuyển ảnh, toolbar, Esc **kế thừa CR-V**; CR này không đổi các quy tắc đó. **Không mở rộng tập ảnh sang hội thoại khác, không đổi thứ tự album**; mỗi lần chuyển ảnh lấy đúng trạng thái và nguồn của ảnh được chọn; không mang đen trắng sang viewer | §4.3.3 · CR-02 | `CR:100-114`; kế thừa `CR-V:63-80`, `CR-V:95-113`, `CR-V:136-142`, `CR-V:146-160` | `[NGUỒN]` — bảng không có dòng **Chuyển tiếp**, trong khi toolbar CR-V v1.1 có icon Chuyển tiếp (Q-02) |
| BR-05 | **File thu hồi trong đoạn chat:** giữ thẻ file, thông tin hiện có và nhãn thu hồi; **mở lại vùng/nút tải xuống** theo cách tương tác với file chưa thu hồi; thu hồi không làm vùng tải bị vô hiệu hóa; tải **không đổi** tên, loại, nội dung, trạng thái thu hồi của file trong chat | §4.4.1 · CR-03 | `CR:120-123` | `[NGUỒN]` — "cách tương tác với file chưa thu hồi" chỉ có `G003:469` "icon download; click → download ngay" (Q-12) |
| BR-06 | **Luồng và quy tắc tải file:** luồng 5 bước UC-03. Quy tắc: file tải **đúng file gắn với tin user chọn**, giữ nội dung và định dạng; giữ tên file nguồn hợp lệ — tên trùng, chọn vị trí lưu, quyền ghi, thông báo tải **theo cơ chế hiện hành** từng nền tảng; **không** hiển thị “Đã lưu thành công” nếu ứng dụng chỉ biết đã chuyển yêu cầu cho trình duyệt / trình quản lý tải; **click lặp** khi đang chuẩn bị cùng lượt tải **không tạo nhiều yêu cầu**, sau khi chuyển giao user có thể tải lại; chuyển hội thoại / chọn file khác **không** làm tác vụ đã bắt đầu đổi tài nguyên; không tự gửi lại lên Zalo, không đổi trạng thái tin | §4.4.2 · CR-03 | `CR:127-140` | `[NGUỒN]` |
| BR-07 | **Thu hồi xảy ra trong lúc thao tác:** đang xem ảnh màu → viewer vẫn mở, giữ màu + xoay / zoom / kéo, không khóa thao tác; đang tải ảnh / file → tiếp tục nếu nguồn và quyền còn hợp lệ; đang mở ảnh, thu hồi trước khi tải xong → vẫn mở viewer, không áp đen trắng; đóng viewer sau thu hồi → chat đen trắng + nhãn; đổi A → B, kết quả A về muộn → **không ghi đè** B; mở lại ở phiên khác → vẫn mở nếu còn quyền và nguồn. Trạng thái thu hồi là của **tin**; xoay / zoom / kéo là của **phiên xem từng user**, không đồng bộ sang user khác | §4.5 · CR-05 | `CR:146-153` | `[NGUỒN]` |
| BR-08 | **Phạm vi nền tảng:** Web Gopany: mở viewer, màu nguồn, thao tác như ảnh chưa thu hồi; file tải khi đủ điều kiện. App Gopany: như trên **"của cùng app"**; file tải **theo cơ chế của app**. Zalo app / Zalo web: không thuộc CR. Không gửi lệnh khôi phục / đổi dữ liệu trên Zalo; không yêu cầu user sang Zalo để mở | §4.6 | `CR:159-164` | `[NGUỒN]` — không có spec app (Q-07) |
| BR-09 | **Trạng thái và lỗi (10 tình huống):** đang lấy nguồn → viewer hiện **trạng thái đang tải**, vẫn đóng / chuyển ảnh được · ảnh không còn nguồn → **“Ảnh không còn khả dụng.”**, không báo thiếu quyền chỉ vì thu hồi · file không còn nguồn → **“File không còn khả dụng để tải xuống.”** · lỗi tải ảnh tạm thời → **“Không thể tải ảnh. Vui lòng thử lại.”** · lỗi tải file tạm thời → **“Không thể tải file. Vui lòng thử lại.”** · link nguồn hết hạn → làm mới bằng cơ chế hiện hành nếu còn quyền, không lấy được → lỗi phù hợp · user không còn quyền xem → chặn, thông báo quyền theo cơ chế hiện hành, **không dùng cache để vượt quyền** · Zalo ngắt kết nối nhưng Gopany còn dữ liệu → vẫn xem / tải · app bị từ chối quyền lưu → hướng dẫn cấp quyền / chọn vị trí lưu theo cơ chế hiện hành, không báo lỗi thu hồi · chỉ có thumbnail → không coi là nguồn, báo nguồn không khả dụng. Nguồn bị xóa / quyền bị thu hồi **trong lúc** thao tác → xử lý theo lỗi tài nguyên / quyền hiện hành | §4.7 | `CR:170-181` | `[NGUỒN]` — "trạng thái đang tải" (Q-11); thông báo quyền (Q-01); thông báo khi tải ảnh mất nguồn trong viewer (Q-04) |
| BR-10 | **Dữ liệu và tác động:** đen trắng tách khỏi dữ liệu ảnh nguồn; nhận trạng thái thu hồi **không tự xóa** bản ảnh / file đã lưu; chặn thao tác phải bỏ ở **cả UI lẫn xử lý tải nguồn** (không chỉ bật nút UI trong khi backend vẫn từ chối vì cờ thu hồi); giữ định danh tin, ảnh / file, trạng thái, nhãn; áp dụng đồng nhất web / app; kiểm thử **cả tin gửi và tin nhận, thu hồi trước và sau phát hành** | §4.8 | `CR:185-190` | `[NGUỒN]` |
| BR-11 | **Giữ ý nghĩa thu hồi — không mở lại thao tác khác:** chỉ bỏ chặn mở viewer và tải; giữ trạng thái thu hồi và quy tắc khác; **không** mở lại trả lời, phản ứng, chuyển tiếp, thu hồi lại; không tự bật các thao tác khác khi mở lại click ảnh / tải file; xem / tải không xóa trạng thái thu hồi | §3.2, §4.1 CR-04, §4.8 | `CR:47`, `CR:62`, `CR:190`, `CR:27` | `[NGUỒN]` + G003 BR19 (`G003:315`) ẩn Chuyển tiếp với tin thu hồi |
| BR-12 | **Dữ liệu cũ:** không đổi trạng thái tin đã thu hồi; dữ liệu cũ còn nguồn áp dụng hành vi mới; trước triển khai **kiểm tra khả năng truy xuất bản nguồn** của ảnh / file đã thu hồi, nhất là trường hợp chỉ còn thumbnail / metadata; không cam kết phục hồi nếu nguồn đã đổi / xóa; không đồng bộ lại, tải lại hàng loạt, đổi chính sách lưu | §6 | `CR:235-239` | `[NGUỒN]` — "kiểm tra khả năng truy xuất" ai làm, kết quả có cho QA (Q-03) |

Rule hiện hành dùng chung (CR không định nghĩa lại): G003 BR06 thu hồi ≤ 24 giờ (`G003:302`), BR07 Gopany giữ nội dung gốc + label (`303`), BR09 terminal (`305`), BR10 Zalo ngắt kết nối vẫn xem lịch sử (`306`), BR12 Staff unassign → hội thoại ẩn ngay (`308`), BR19 ẩn Chuyển tiếp tin thu hồi (`315`), UC-06 ghi chú thu hồi tin gửi từ điện thoại hiện tên Staff (`187`); G036 BR20 tin thu hồi giữ nội dung, không 👍, không trạng thái gửi (`G036:153`), BR14 ảnh ≤ 360 × 368 (`147`), BR16 thẻ tệp 376px (`149`), BR28 màn cảm ứng nút luôn hiện (`161`); ESC AC-01 → AC-03 (`ESC:21-23`); G001 BR03 tài khoản Ngắt kết nối không gửi / nhận (`G001:140`).

## 6. Acceptance criteria, thông báo, nhãn

- 32 AC dạng "Tình huống và thao tác → Kết quả cần đạt", `CR:198-229`. Điều kiện chung cho AC thành công: có quyền và ảnh / file gốc còn (`CR:194`).
- Nhóm AC theo BR: AC-01 (BR-02) · AC-02, AC-03 (BR-03, BR-08) · AC-04, AC-05 (BR-03 màu nguồn) · AC-06 → AC-13 (BR-04) · AC-14 → AC-17 (BR-05, BR-06) · AC-18 → AC-20, AC-27 (BR-07) · AC-21 (BR-12) · AC-22 → AC-26, AC-32 (BR-09) · AC-28, AC-29, AC-30 (BR-11) · AC-31 (BR-10 tin gửi / tin nhận).
- Thông báo nguyên văn: **“Tin nhắn đã thu hồi”** (`CR:15`, `CR:26`, `CR:82`) · **“Ảnh không còn khả dụng.”** (`CR:171`) · **“File không còn khả dụng để tải xuống.”** (`CR:172`) · **“Không thể tải ảnh. Vui lòng thử lại.”** (`CR:173`) · **“Không thể tải file. Vui lòng thử lại.”** (`CR:174`) · **không** hiện “Đã lưu thành công” khi chỉ chuyển giao (`CR:137`).
- Gợi ý dữ liệu kiểm thử của BA (`CR:231`): ảnh màu, ảnh đen trắng, dọc / ngang, nhiều ảnh trong một tin, file tên tiếng Việt / ký tự đặc biệt; mất mạng, Zalo ngắt kết nối, chuyển ảnh liên tục, đổi quyền trong lúc thao tác.
- Không có mã lỗi API, data model hay endpoint trong CR.

## 7. Trạng thái và chuyển trạng thái

CR không có state machine riêng. Trạng thái **tin nhắn** theo G003 §7: Đã gửi / Đã xem → **Đã thu hồi** (terminal, `G003:337-341`). CR
chỉ đổi **hệ quả** của trạng thái này (bỏ chặn mở / tải), không đổi chuyển trạng thái (`CR:27`, `CR:235`).

`[DIỄN GIẢI AI]` — có thể dùng ở bước thiết kế, không phải requirement: ba trạng thái dữ liệu của một ảnh / file trên Gopany
suy từ `CR:71`, `CR:75`, `CR:179`: (a) có bản nguồn, (b) chỉ có thumbnail / metadata, (c) nguồn không còn / link hết hạn; kết hợp
với trạng thái quyền (còn / mất) tạo decision table cho BR-01 và BR-09.

## 8. Diễn giải, giả định, QA observation

| # | Nội dung | Nhãn | Liên quan |
| ---: | --- | --- | --- |
| 1 | "Viewer" trong CR = viewer của CR-V (toolbar Tải xuống → Chuyển tiếp → Xoay → Phóng to → Thu nhỏ; Esc; tooltip) — suy từ `CR:112` dẫn tài liệu CR-V và bảng `CR:102-110` trùng tên thao tác với CR-V | `[DIỄN GIẢI AI]` | BR-04, Q-02, Q-08 |
| 2 | Viewer của ảnh thu hồi **ẩn icon Chuyển tiếp** vì `CR:47` (không mở lại chuyển tiếp) + `CR-V:200` / AC-41 (`CR-V:263`) + G003 BR19 — nhưng `CR:100` "không tạo bộ giới hạn riêng" đọc được ngược lại | `[DIỄN GIẢI AI]` | BR-04, BR-11, Q-02 |
| 3 | Tin ảnh **nhiều ảnh** bị thu hồi → mọi ảnh của tin đó đen trắng; trong viewer, các ảnh này vẫn thuộc tập ảnh và mỗi ảnh lấy nguồn riêng (`CR:108`, `CR:114`, `CR:231`) | `[DIỄN GIẢI AI]` | BR-04 |
| 4 | Thu hồi của **bên đối thoại** (khách) đến Gopany qua sự kiện đồng bộ từ Zalo; dựng case cần Zalo app của khách thu hồi trong 24 giờ (G003 BR06) | `[QA BỔ SUNG]` | BR-07, BR-10 |
| 5 | Để kiểm AC-22 / AC-23 cần dựng được ảnh / file **mất nguồn** và trường hợp **chỉ còn thumbnail**; CR không nói cách tạo | `[QA BỔ SUNG]` | BR-09, Q-03 |
| 6 | Để kiểm "chặn ở cả UI lẫn xử lý tải" (`CR:187`) cần quan sát response tải nguồn (DevTools Network) chứ không chỉ nút | `[QA BỔ SUNG]` | BR-10 |
| 7 | AC-06 → AC-13 (xoay / zoom / kéo / Esc / tooltip) chỉ kiểm được khi CR-V đã phát hành; nếu CR này ra trước, viewer hiện hành không có các thao tác đó | `[GIẢ ĐỊNH]` | BR-04, Q-08 |
| 8 | "Màu nguồn" của ảnh vốn đen trắng (AC-05): cần ảnh nguồn thật là grayscale để phân biệt với hiệu ứng đen trắng của chat | `[QA BỔ SUNG]` | BR-03 |

## 9. Điểm chưa rõ (chuyển sang Debate)

| # | Loại | Trích dẫn + nguồn | Vì sao chưa rõ | Đề xuất mức |
| ---: | --- | --- | --- | --- |
| 1 | Thiếu (quyền) | `CR:70` "quyền xem hội thoại và truy cập ảnh/file theo chính sách hiện hành"; `CR:176` "hiển thị thông báo quyền theo cơ chế hiện hành"; AC-25 `CR:222` | Không tài liệu nào trong `tailieu/` định nghĩa "chính sách hiện hành" cho truy cập ảnh / file; không có text thông báo quyền. Cùng câu hỏi với CR-ANH-VIEWER Q-01 | **Trọng yếu** (quyền hạn) |
| 2 | Mâu thuẫn | `CR:100` "cùng bộ thao tác… không tạo một bộ giới hạn riêng do trạng thái thu hồi" ↔ `CR:47` "không mở lại… chuyển tiếp"; `CR-V:200` + AC-41 `CR-V:263` ẩn icon Chuyển tiếp với tin thu hồi; `G003:315` BR19 | Viewer của ảnh thu hồi: icon Chuyển tiếp **ẩn**, **khóa**, hay **hiện và dùng được**? Bảng `CR:102-110` không có dòng Chuyển tiếp | **Trọng yếu** (hành vi: phát tán nội dung đã thu hồi) |
| 3 | Thiếu (dữ liệu) | `CR:75` "có thumbnail… không đồng nghĩa bản nguồn còn"; `CR:179` "chỉ có thumbnail, chưa có bản nguồn"; `CR:237` "trước triển khai, kiểm tra khả năng truy xuất bản nguồn" | Khi nào Gopany chỉ còn thumbnail / mất nguồn; cách dựng để test AC-22 / AC-23; ai kiểm tra trước triển khai và kết quả có gửi QA | Không trọng yếu — cô lập (cách dựng) |
| 4 | Mâu thuẫn thông báo | `CR:171` "Ảnh không còn khả dụng." (mở viewer); `CR-V:75` "Không còn tệp ảnh để tải xuống." (bấm Tải xuống trong viewer) | Bấm **Tải xuống** trong viewer với ảnh thu hồi mà nguồn mất: hiện thông báo nào | Không trọng yếu (chữ) — cô lập |
| 5 | Mâu thuẫn nhãn | `CR:15`, `CR:26`, `CR:82` “Tin nhắn đã thu hồi” ↔ `G003:185`, `G003:459` label `Đã thu hồi`; `G003:187` thu hồi tin gửi từ điện thoại hiện **tên Staff** | Nhãn chính xác trong chat là gì; có kèm tên Staff thu hồi không | Không trọng yếu (chữ) — cô lập |
| 6 | Thiếu (phạm vi) | `CR:41` "bị gỡ" = thu hồi; `G003:181-185` UC-06 có cả **Xóa chỉ phía tôi** → label `Đã xóa`, giữ nội dung (BR07) | Ảnh / file của tin **Đã xóa** có được mở / tải theo CR này không, hay giữ hành vi hiện hành | Không trọng yếu — cô lập (case ĐO & GHI) |
| 7 | Thiếu tài liệu | `CR:160` App Gopany "thao tác như ảnh chưa thu hồi **của cùng app**"; AC-03, AC-15, AC-32; `G003:385` Platform Web only, `G003:650` OOS08 Mobile app | Không spec viewer / tải file trên app; app có Xoay / Phóng to / Kéo như CR-V không (AC-06 → AC-09 không nêu nền tảng) | Không trọng yếu — cô lập (case app ĐO & GHI) |
| 8 | Phụ thuộc | `CR:112` kế thừa CR-V; `CR-V:281` "Chưa thực thi kiểm thử sản phẩm" | Thứ tự phát hành CR-V và CR này; nếu CR này ra trước thì AC-06 → AC-13 kiểm thế nào | Không trọng yếu — người dùng / BA chốt lịch |
| 9 | Ghi chú | `CR:5` "Mã yêu cầu: Chưa cấp"; `CR:10` ưu tiên chưa xác định | Cần mã CR chính thức; QA dùng tạm `CR-ANH-FILE-THU-HOI` | Không trọng yếu |
| 10 | Thiếu tài liệu | `CR:19` ảnh hiện trạng `hien-trang-anh-thu-hoi.png` | Không có trong `tailieu/` — hiện trạng chỉ kiểm theo chữ `CR:15-17` | Không trọng yếu |
| 11 | Mơ hồ | `CR:170` "Viewer hiển thị trạng thái đang tải"; `CR:114` "không mang hiệu ứng đen trắng trong chat sang viewer" | Trong lúc chờ nguồn, viewer hiện gì: khung chờ, thumbnail (màu hay đen trắng), hay trống | Không trọng yếu — cô lập |
| 12 | Thiếu spec hiện hành | `CR:121` "theo cách tương tác với file chưa thu hồi"; `CR:136` "thông báo tải của từng nền tảng dùng cơ chế hiện hành"; `G003:469` "icon download; click → download ngay" | Vùng click tải của thẻ file (cả thẻ hay chỉ icon), thông báo sau khi tải trên web / app hiện hành — không có spec | Không trọng yếu — cô lập (ĐO & GHI) |

## 10. Tự rà soát

- [x] Mọi mã AC-xx, CR-0x, BR của G003 / G036 / G001 ở mục 3–6 đã mở kiểm đúng dòng bằng Grep / sed
- [x] Mã BR-xx là mã QA tự đánh — ghi rõ ở đầu mục 5
- [x] Không mục `[NGUỒN]` nào thiếu tham chiếu
- [x] Mâu thuẫn (Q-02, Q-04, Q-05) ghi đủ hai phía
- [x] Mục 9 không chứa câu trả lời do AI tự chọn
- Giới hạn: không có spec app Gopany, chính sách quyền, ảnh hiện trạng; CR-V đọc các mục CR dẫn, không đọc lại toàn bộ

## Lịch sử cập nhật

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
| 2026-10-14 | AI (Orchestrator) | Tạo bản đầu: 6 nguồn, 12 BR (mã QA), 32 AC, 12 điểm chưa rõ (2 đề xuất trọng yếu: Q-01 quyền, Q-02 icon Chuyển tiếp trong viewer ảnh thu hồi) |
