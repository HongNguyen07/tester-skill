---
featureId: CR-ANH-VIEWER   # mã tạm của QA — CR ghi "Mã yêu cầu: Chưa cấp" (CR:5); đổi khi BA cấp mã
title: Bổ sung các thao tác đối với ảnh đang được mở ra xem trong đoạn chat
analyzedAt: 2026-10-14
analyst: Requirement Analyst (AI) — người dùng: Hồng (QA)
---

# Requirement Analysis — CR-ANH-VIEWER: Thao tác với ảnh trong trình xem ảnh của đoạn chat

Viết tắt tham chiếu: `CR` = `tailieu/[CR] Bổ sung các thao tác đối với ảnh đang được mở ra xem trong đoạn chat (1).md`;
`G003` = `tailieu/G003 - Chat.md` (v1.11); `G036` = `tailieu/G036 - Giao diện khung hội thoại.md`. Số sau dấu `:` là số dòng.

## 1. Nguồn và phạm vi đã đọc

| # | Tệp | Version ghi trong tệp | Phạm vi đã đọc | Ghi chú |
| ---: | --- | --- | --- | --- |
| 1 | `[CR] Bổ sung các thao tác đối với ảnh… (1).md` | 1.1 · 13/10/2026 · người yêu cầu BA Đỗ Văn An · ưu tiên Cao | Toàn bộ (282 dòng) | Nguồn chính. **Mã yêu cầu: Chưa cấp** (`CR:5`) |
| 2 | `G003 - Chat.md` | 1.11 | UC-08 (`201-221`), E09 (`273`), BR19–BR23, BR25, BR27 (`315-323`), §10G (`531-545`), §10D ảnh (`467`) | CR §4.9 dẫn đúng v1.11 — khớp file đang có |
| 3 | `G036 - Giao diện khung hội thoại.md` | 1.0 Draft | BR14 ảnh trong khung chat (`147`), BR20 tin thu hồi (`153`) | Chỉ để kiểm ranh giới: G036 quy định ảnh **trong khung chat**, không quy định trình xem ảnh |

**Không có trong `tailieu/`:**
- 3 wireframe WF-01 → WF-03 (PNG / SVG) ở thư mục `CR-thao-tac-anh-chat-v1.1/` (`CR:176-190`) và snapshot G003 ở `…/references/` (`CR:198`). Snapshot không cần vì G003 v1.11 đã có; wireframe thì **thiếu thật** — bố cục kiểm theo chữ ở §4.7.
- **Đặc tả của trình xem ảnh hiện hành** (ảnh giữa nền tối, nút trước / sau, nút đóng, dải thumbnail, click nền đóng?) — CR §1 mô tả là "đã có" (`CR:15`) nhưng không spec nào trong `tailieu/` quy định; G003 chỉ ghi "Ảnh PNG/JPG: View preview trực tiếp" (`G003:467`).

## 2. Mục tiêu và phạm vi `[NGUỒN]`

- Bổ sung vào trình xem ảnh (viewer) mở từ tin nhắn ảnh trong đoạn chat, **desktop web**: tải xuống, chuyển tiếp (v1.1), xoay 90°, phóng to / thu nhỏ bằng icon, nhấn giữ chuột trái kéo ảnh, tooltip tiếng Việt, Esc đóng viewer (`CR:15`, `CR:31-39`).
- Ngoài phạm vi (`CR:43-45`): phím tắt ngoài Esc; nút vừa khung; nhãn % zoom; bảng phím tắt; chọn nhiều ảnh để chuyển tiếp từ viewer; zoom bằng cuộn chuột / nhấp đúp / đa điểm; sửa, lưu ảnh đã xoay, crop, vẽ; tải nhiều ảnh / ZIP; in; video / PDF.
- Mọi biến đổi (góc, hệ số, vị trí kéo) chỉ tồn tại trong phiên xem; không sửa file nguồn; không ảnh hưởng người dùng khác (`CR:25`, `CR:270`).
- Đầu ra của CR: đặc tả + 3 wireframe (`CR:11`).

## 3. Actor, precondition, trigger

| Mục | Nội dung | Nguồn | Nhãn |
| --- | --- | --- | --- |
| Actor | User đang ở đoạn chat, có quyền xem ảnh | `CR:222` AC-01 | `[NGUỒN]` |
| Trigger | Click ảnh trong tin nhắn → viewer mở | `CR:222` | `[NGUỒN]` |
| Precondition tải xuống | Ảnh hiện hành đã tải xong, tài nguyên nguồn còn khả dụng, user có quyền "theo chính sách hiện có" | `CR:63` | `[NGUỒN]` — chính sách không có tài liệu (Q-01) |
| Precondition chuyển tiếp | Ảnh xác định được tin nhắn nguồn và đáp ứng cùng điều kiện chuyển tiếp như trên tin nhắn | `CR:200` | `[NGUỒN]` |
| Nền tảng | Desktop web | `CR:31` | `[NGUỒN]` |

## 4. Use case và luồng

| Mã | Tên | Luồng theo nguồn | Nguồn |
| --- | --- | --- | --- |
| UC-01 | Tải xuống | Click **Tải xuống** → ghi nhận ảnh tại thời điểm click, icon sang trạng thái đang xử lý, không nhận click lặp → chuyển file sang cơ chế tải của trình duyệt, viewer vẫn mở → icon trở lại, thông báo *"Đã bắt đầu tải ảnh. Kiểm tra mục tải xuống của trình duyệt."* | `CR:65-68` |
| UC-02 | Xoay ảnh | Click **Xoay ảnh** → xoay 90° CW quanh tâm; 0 → 90 → 180 → 270 → 0; tự căn giữa, vừa vùng xem, reset vị trí kéo | `CR:84-90` |
| UC-03 | Phóng to / thu nhỏ | Click **Phóng to** / **Thu nhỏ** → đổi một mức theo chuỗi 0,5 → 0,75 → 1 → 1,25 → 1,5 → 2 → 3 → 4; không hiện số | `CR:94-111` |
| UC-04 | Nhấn giữ và kéo | Đưa con trỏ vào ảnh → nhấn giữ chuột trái → di chuyển → ảnh dịch theo → thả, giữ vị trí | `CR:117-131` |
| UC-05 | Đóng bằng Esc | Viewer là lớp trên cùng → Esc đóng viewer; user ở đúng đoạn chat, giữ cuộn và nội dung soạn | `CR:136-142` |
| UC-06 | Chuyển tiếp ảnh đang xem (v1.1) | Click **Chuyển tiếp** → ghi nhận ảnh + tin nguồn tại click → mở modal Chuyển tiếp dùng chung (G003 UC-08) → chọn đích → Gửi → thành công: *"Đã chuyển tiếp"*, đóng modal, về viewer; thất bại: *"Không thể chuyển tiếp, vui lòng thử lại"*, giữ modal (E09) | `CR:202-207` |
| Hồi quy | Chuyển ảnh trước / sau, thumbnail, nút Đóng — "theo quy tắc hiện hành" | `CR:170`, `CR:254` AC-33 — **không có spec hiện hành** |

## 5. Business rule

CR không đánh mã BR; có bảng thay đổi CR-01 → CR-07 (`CR:53-59`) và các mục 4.2 → 4.9. QA đánh mã tạm `BR-xx`
theo cơ chế, ghi kèm mục gốc. Mã này ổn định qua các version, dùng chung với báo cáo point.

| Mã QA | Nội dung (sát nguyên văn) | Mục gốc | Nguồn | Nhãn |
| --- | --- | --- | --- | --- |
| BR-01 | **Tải xuống — luồng và trạng thái icon:** ghi nhận ảnh tại thời điểm click; icon đang xử lý, không nhận click lặp cho cùng tác vụ; sau khi chuyển cho trình duyệt, click lại là yêu cầu mới; viewer vẫn mở, giữ ảnh và vị trí; thông báo *"Đã bắt đầu tải ảnh…"*; **không** báo đã lưu thành công | CR-01 · §4.2 | `CR:65-68`, `CR:77-79` | `[NGUỒN]` |
| BR-02 | **Tải xuống — nội dung file:** bản nguồn chất lượng cao nhất đang lưu, không thumbnail / chụp màn hình; **không áp** góc xoay, zoom, vị trí kéo; giữ tên file nguồn, thiếu tên → `anh-chat-{imageId}.{đuôi-thực-tế}`; đuôi khớp định dạng thực tế; trùng tên do trình duyệt / OS xử lý | §4.2 | `CR:72-74` | `[NGUỒN]` |
| BR-03 | **Tải xuống — lỗi và ràng buộc:** không có file nguồn → *"Không còn tệp ảnh để tải xuống."*; lỗi tải → *"Không thể tải ảnh. Vui lòng thử lại."*, giữ viewer; tải A rồi chuyển sang B / đóng viewer → tác vụ vẫn gắn A, không tải nhầm B, không hiện lỗi của A như của B; kiểm tra quyền theo cơ chế hiện hành, không vượt quyền qua viewer | §4.2 | `CR:75-80` | `[NGUỒN]` — "quyền" không có tài liệu (Q-01) |
| BR-04 | **Xoay:** 90° CW quanh tâm mỗi click; chuỗi 0 → 90 → 180 → 270 → 0; góc ban đầu tính từ hướng đã hiển thị đúng theo metadata (tránh xoay kép); sau xoay: căn giữa, vừa vùng xem theo góc mới, reset vị trí kéo; chỉ trong phiên xem, không sửa nguồn / thumbnail; ảnh chưa tải xong → icon khóa; không phím R | CR-02 · §4.3 | `CR:84-90` | `[NGUỒN]` |
| BR-05 | **Zoom — mức và cơ sở:** chuỗi hệ số nội bộ 0,5 → 0,75 → 1 → 1,25 → 1,5 → 2 → 3 → 4, không hiển thị số; kích thước cơ sở = ảnh vừa vùng xem tại góc hiện hành, **không phóng ảnh nhỏ vượt kích thước tự nhiên**; vùng xem không gồm toolbar, thumbnail, khoảng nút điều hướng; kích thước hiển thị = cơ sở × hệ số, giữ tỷ lệ; đạt 4 → khóa Phóng to, tooltip *"Đã đạt mức phóng to tối đa"*; đạt 0,5 → khóa Thu nhỏ, tooltip *"Đã đạt mức thu nhỏ tối thiểu"* | CR-03 · §4.4 | `CR:94-106` | `[NGUỒN]` — ảnh nhỏ (Q-03) |
| BR-06 | **Zoom — reset và tâm:** mở ảnh → hướng ban đầu, hệ số 1, căn giữa; xoay → căn giữa, hệ số 1 theo góc mới; chuyển ảnh / đóng rồi mở lại → reset hướng, hệ số 1, căn giữa; đổi kích thước cửa sổ → tính lại cơ sở, giữ góc và hệ số, giới hạn lại vị trí kéo; khi zoom, điểm ảnh tại tâm vùng xem giữ ở tâm (trừ khi phải giới hạn vị trí) | §4.4 | `CR:104-111` | `[NGUỒN]` |
| BR-07 | **Kéo ảnh:** chỉ dịch theo chiều ảnh tràn, chiều không tràn giữ căn giữa; toàn ảnh trong vùng xem → không trôi; giới hạn toạ độ: không kéo mất ảnh, không tạo khoảng trống ở mép khi còn nội dung vượt khung; con trỏ bàn tay mở / bàn tay nắm; di chuyển **từ 4 CSS px** mới là kéo, click đơn không kéo / không zoom; thả ngoài ảnh hoặc mất focus → kết thúc kéo, quay lại không bám con trỏ; không kéo theo toolbar / thumbnail, không chọn văn bản, không kéo file mặc định, không cuộn trang chat; nhả chuột sau kéo **không** tính là click nền đóng viewer; click icon / thumbnail / nút điều hướng không bắt đầu kéo | CR-03 · §4.5 | `CR:117-131` | `[NGUỒN]` |
| BR-08 | **Esc:** viewer là lớp trên cùng → Esc đóng viewer; giữ đoạn chat, vị trí cuộn, nội dung soạn; một lần nhấn không truyền xuống lớp chat; nhấn giữ không đóng thêm lớp sau; tooltip đang hiện → đóng cùng; hộp thoại khác đang trên viewer → Esc chỉ xử lý lớp trên cùng; nút Đóng vẫn hoạt động; đóng trả focus về ảnh đã mở, ảnh không còn → vùng lịch sử hội thoại | CR-04 · §4.6 | `CR:136-141` | `[NGUỒN]` |
| BR-09 | **Không phím tắt, không zoom chuột:** không đăng ký D, R, +, -, 0, ?, mũi tên; điều hướng ảnh chỉ bằng nút và thumbnail; cuộn chuột / nhấp đúp không zoom; không ghi đè zoom trang của trình duyệt | §3.2, §4.4, §4.6 | `CR:43-45`, `CR:113`, `CR:142` | `[NGUỒN]` |
| BR-10 | **Tooltip:** bảng 8 icon ↔ text (`Tải xuống` · `Chuyển tiếp` · `Xoay ảnh` · `Phóng to` · `Thu nhỏ` · `Đóng` · `Ảnh trước` · `Ảnh sau`); chỉ text tiếng Việt, không phím / biểu tượng bàn phím / tỷ lệ; hiện sau **300 ms** hover; ẩn khi rời icon, chuyển ảnh, đóng viewer, kích hoạt thao tác; nằm phía trên toolbar, không che icon, không vượt màn hình; icon khóa hiện lý do: *"Đang tải ảnh"*, *"Đang chuẩn bị tải xuống"*, thông báo giới hạn zoom | CR-05 · §4.7 | `CR:146-160` | `[NGUỒN]` |
| BR-11 | **Bố cục:** giữ vùng ảnh nền tối, nút trước / sau hai bên, nút đóng góc trên phải, dải thumbnail; toolbar **phía dưới vùng ảnh**, căn giữa; thứ tự **Tải xuống → Chuyển tiếp → Xoay ảnh → vạch phân cách → Phóng to → Thu nhỏ**; không % zoom, nút vừa khung, icon bàn phím, bảng phím tắt, dòng "0 để vừa khung"; icon Chuyển tiếp cùng biểu tượng với thao tác trên tin nhắn; toolbar luôn thấy, tách khỏi lớp ảnh biến đổi; thumbnail dưới toolbar; vùng bấm ≥ 40 × 40 CSS px, icon 20–24 px; icon khóa có trạng thái phân biệt; giữ nguyên nguồn, thứ tự, quy tắc điều hướng đầu / cuối hiện hành | CR-06 · §4.7 | `CR:162-170` | `[NGUỒN]` — "hiện hành" không có spec (Q-02) |
| BR-12 | **Chuyển tiếp — điểm vào và modal:** điều kiện như trên tin nhắn; tin thu hồi / nhóm đã rời-bị xóa → **ẩn icon** (G003 BR19 / BR25); click → ghi nhận ảnh + tin nguồn tại click, mở modal Chuyển tiếp **dùng chung** (UC-08) phía trên viewer, click chỉ mở modal chưa gửi, không mở chồng khi click lặp; modal dùng lại filter tài khoản Zalo (mặc định theo hội thoại nguồn), filter thẻ, tìm kiếm, danh sách; quyền, nhóm không chọn được, tối đa 99 đích như UC-08; không mở rộng chuyển tiếp giữa tài khoản; chưa có đích hợp lệ → không gửi; nội dung = **một ảnh đang xem**, kể cả tin nguồn nhiều ảnh | CR-07 · §4.9 | `CR:198-205` | `[NGUỒN]` + G003 `315`, `317-321`, `323` |
| BR-13 | **Chuyển tiếp — kết quả, lớp, ngữ cảnh:** thành công → *"Đã chuyển tiếp"*, đóng modal, về viewer, ảnh đến đích là tin thường (G003 BR20); thất bại → *"Không thể chuyển tiếp, vui lòng thử lại"*, giữ modal (E09); chuyển ảnh nguồn, không áp biến đổi, không chụp màn hình; modal mở → viewer phía sau không nhận click, ảnh đã ghi nhận không đổi theo danh sách phía sau; hủy / đóng modal → không gửi, về đúng ảnh + góc + zoom + vị trí, focus về icon Chuyển tiếp; Esc chỉ xử lý modal; sau thành công viewer giữ trạng thái, không tự chuyển hội thoại; giữ nội dung soạn và cuộn; nguồn / đích / quyền mất điều kiện trước khi Gửi → kiểm tra lại, chặn phần không hợp lệ, không gửi bằng dữ liệu cũ | §4.9 | `CR:206-216` | `[NGUỒN]` + G003 `273`, `316` |
| BR-14 | **Không sửa nguồn, không ảnh hưởng người khác:** góc, hệ số, vị trí chỉ trong phiên; user khác mở cùng ảnh hoặc tải nguồn không nhận biến đổi; không di chuyển dữ liệu | §2, §6 | `CR:25`, `CR:255`, `CR:270` | `[NGUỒN]` |

Rule dùng chung từ G003 (CR không định nghĩa lại — `CR:198`): UC-08 (`G003:201-221`), E09 (`273`), BR19 ẩn Chuyển tiếp với tin thu hồi (`315`), BR20 tin thường (`316`), BR21 nhóm "chỉ trưởng / phó nhắn tin" disable (`317`), BR22 nhiều đích (`318`), BR23 cùng tài khoản Zalo (`319`), BR25 nhóm đã rời / bị xóa cấm hai chiều (`321`), BR27 tối đa 50 tin / 99 hội thoại (`323`), §10G bộ đếm "Đã chọn X/99", nút "Gửi (X)" disable khi chưa chọn (`531-545`).

## 6. Acceptance criteria, thông báo, nhãn

- 44 AC dạng Given / When / Then, `CR:222-266` (AC-35 → AC-44 thêm ở v1.1).
- Thông báo nguyên văn: *"Đã bắt đầu tải ảnh. Kiểm tra mục tải xuống của trình duyệt."* (`CR:68`) · *"Không còn tệp ảnh để tải xuống."* (`CR:75`) · *"Không thể tải ảnh. Vui lòng thử lại."* (`CR:76`) · *"Đã đạt mức phóng to tối đa"* (`CR:105`) · *"Đã đạt mức thu nhỏ tối thiểu"* (`CR:106`) · *"Đang tải ảnh"*, *"Đang chuẩn bị tải xuống"* (`CR:160`) · *"Đã chuyển tiếp"* (`CR:206`) · *"Không thể chuyển tiếp, vui lòng thử lại"* (`CR:207`).
- Tooltip 8 icon (`CR:148-155`). Tên file dự phòng `anh-chat-{imageId}.{đuôi-thực-tế}` (`CR:74`).
- Không có mã lỗi API; CR không có data model / API (`CR:268-270`).

## 7. Trạng thái và chuyển trạng thái

CR không có state machine. Có thể suy ra hai máy trạng thái nhỏ — `[DIỄN GIẢI AI]`, dùng cho decision table / state transition ở bước thiết kế, không phải requirement:
- Icon Tải xuống: sẵn sàng → đang xử lý (khóa) → sẵn sàng (sau khi chuyển cho trình duyệt) (`CR:66-68`).
- Trạng thái xem (góc × hệ số × vị trí) với các sự kiện xoay / zoom / kéo / chuyển ảnh / resize / đóng-mở lại (`CR:104-109`).

## 8. Diễn giải, giả định, QA observation

| # | Nội dung | Nhãn | Liên quan |
| ---: | --- | --- | --- |
| 1 | Viewer hiện hành có "click nền đóng viewer" — suy từ `CR:130` "nhả chuột sau kéo không được tính thành click nền để đóng viewer"; không spec nào ghi | `[DIỄN GIẢI AI]` | BR-07, BR-11, Q-02 |
| 2 | "Ảnh" mở viewer là tin ảnh theo G036 BR14 / G003 §10D; video, tệp, danh thiếp không mở viewer này (`CR:45` "không mở rộng sang video / PDF") | `[DIỄN GIẢI AI]` | Trigger |
| 3 | Modal Chuyển tiếp từ viewer chỉ có **một** tin nguồn (ảnh đang xem) nên không có "Chọn nhiều" / bộ đếm "X/50" của §10G; bộ đếm đích "X/99" và "Gửi (X)" vẫn có | `[DIỄN GIẢI AI]` | BR-12, Q-05 |
| 4 | Kiểm hệ số zoom, 4 CSS px, 300 ms, 40 × 40 px cần DevTools / đo; CR gọi hệ số là "phục vụ nghiệm thu" (`CR:96`) nên hệ số là tiêu chí, còn cách đo cần thống nhất dung sai | `[QA BỔ SUNG]` | BR-05, BR-07, BR-10, BR-11 |
| 5 | Để kiểm AC-06 (tải A rồi chuyển B) và AC-07 (file mất) cần dựng ảnh lớn / mạng chậm và ảnh bị xóa nguồn | `[QA BỔ SUNG]` | BR-01, BR-03 |

## 9. Điểm chưa rõ (chuyển sang Debate)

| # | Loại | Trích dẫn + nguồn | Vì sao chưa rõ | Đề xuất mức |
| ---: | --- | --- | --- | --- |
| 1 | Thiếu (quyền) | `CR:63` "user có quyền theo chính sách hiện có"; `CR:80` "kiểm tra quyền theo cơ chế hiện hành; không dùng viewer để vượt quyền truy cập ảnh" | Không tài liệu nào trong `tailieu/` định nghĩa quyền tải ảnh. Có quyền riêng cho tải xuống, hay chỉ cần quyền xem hội thoại (G003)? Không có quyền thì icon ẩn, khóa, hay báo lỗi gì | **Trọng yếu** (quyền hạn) |
| 2 | Thiếu spec hiện hành | `CR:15` viewer "đã có"; `CR:170` "giữ nguyên nguồn, thứ tự và quy tắc điều hướng đầu / cuối hiện hành"; `CR:254` AC-33 "theo quy tắc hiện hành"; `CR:130` click nền đóng viewer | Không spec nào mô tả viewer hiện hành: dải thumbnail gồm ảnh nào (ảnh của tin, hay mọi ảnh hội thoại), điều hướng ở ảnh đầu / cuối, click nền có đóng không | Không trọng yếu — case hồi quy điều hướng ghi "ĐO & GHI", nhưng cần BA cho nguồn |
| 3 | Mơ hồ | `CR:98` "kích thước cơ sở là ảnh vừa vùng xem… **không phóng ảnh nhỏ vượt kích thước tự nhiên**"; `CR:99` "kích thước hiển thị = cơ sở × hệ số" | Ảnh nhỏ hơn vùng xem: hệ số 1 = kích thước tự nhiên (không phóng tới vừa khung) — rõ. Nhưng zoom 2 / 4 có được vượt kích thước tự nhiên không, hay "không phóng vượt tự nhiên" áp cho cả zoom | Không trọng yếu — ảnh hưởng case ảnh nhỏ; cô lập |
| 4 | Thiếu (nội dung gửi) | `CR:205` "Nội dung chuyển tiếp là một ảnh đang xem"; `CR:206` "ảnh đến đích dưới dạng tin nhắn thường theo BR20"; G036 BR14 ảnh có **chú thích** (`G036:147`); G003 UC-08 b5 "gửi nội dung tin nhắn gốc" | Tin ảnh có chú thích: chuyển tiếp từ viewer gửi kèm chú thích hay chỉ ảnh | **Trọng yếu** (nội dung gửi đi = hành vi nghiệp vụ) |
| 5 | Thiếu | `CR:204` modal "dùng lại các thành phần của UC-08"; `G003:531-545` §10G có "Chọn nhiều", bộ đếm X/50 | Từ viewer chỉ có một tin nguồn: modal có hiện phần "Đã chọn X/50" không; nút "Gửi (X)" và bộ đếm "X/99" có giữ | Không trọng yếu |
| 6 | Thiếu | `CR:200` "Tin đã thu hồi… ẩn icon"; G036 BR20 tin thu hồi **giữ nội dung** (`G036:153`) | Click vào ảnh của tin đã thu hồi có mở viewer không? Nếu mở → icon Chuyển tiếp ẩn (AC-41); Tải xuống thì sao — "không còn tệp" hay vẫn tải | Không trọng yếu — cô lập |
| 7 | Thiếu | `CR:75` "Không có file nguồn" | Khi nào một ảnh "không còn file nguồn" (xóa phía tôi? thu hồi? hết hạn lưu trữ?) — cần cách dựng để test AC-07 | Không trọng yếu |
| 8 | Thiếu | `CR:233-234` AC-12/13 "Hover/click" trên nút bị khóa → tooltip; `CR:160` | Icon khóa có nhận hover để hiện tooltip (thường disabled không hover) — cách làm UI; và click vào icon khóa có phản hồi gì ngoài tooltip | Không trọng yếu |
| 9 | Thiếu | `CR:140` "đóng viewer trả focus về ảnh đã mở" | Focus là focus bàn phím trên phần tử ảnh — kiểm bằng gì (viền focus? Tab tiếp theo?) | Không trọng yếu |
| 10 | Thiếu tài liệu | `CR:176-190` 3 wireframe; `CR:11` "Đầu ra… 3 wireframe" | WF-01 → WF-03 không có trong `tailieu/` — bố cục chỉ kiểm theo chữ §4.7 | Không trọng yếu — xin file |
| 11 | Ghi chú | `CR:5` "Mã yêu cầu: Chưa cấp"; `CR:9` người yêu cầu BA Đỗ Văn An | Cần mã CR chính thức để đặt tên thư mục / trace; câu hỏi gửi **BA An**, không phải chị Trân | Không trọng yếu |
| 12 | Trạng thái tài liệu | `CR:8` v1.1; change log ghi "Chưa thực thi kiểm thử sản phẩm" (`CR:280`) | CR v1.1 đã được duyệt để làm chưa (không có ô Status) | Người dùng chốt |

## 10. Tự rà soát

- [x] Mọi mục ở 4–6 có `CR:dòng`; mã G003 đã mở kiểm đúng dòng
- [x] Mã BR-xx là mã QA tự đánh — ghi rõ ở đầu mục 5
- [x] Không mục `[NGUỒN]` nào thiếu tham chiếu
- [x] Mục 9 không chứa câu trả lời do AI tự chọn
- Giới hạn: wireframe không có; spec viewer hiện hành không có; G003 chỉ đọc các mục CR dẫn

## Lịch sử cập nhật

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
| 2026-10-14 | AI (Orchestrator) | Tạo bản đầu: 3 nguồn, 14 BR (mã QA), 44 AC, 12 điểm chưa rõ (2 đề xuất trọng yếu) |
