---
featureId: CR-DAN-ANH-SOAN-TIN   # mã tạm của QA — CR ghi "ID: N/A" (CR:5); đổi khi BA cấp mã
title: "[CR] [Zalo Chat] Điều chỉnh hành vi dán ảnh trực tiếp tại khu vực soạn tin"
analyzedAt: 2026-10-20
updatedAt: 2026-10-21   # cập nhật theo CR v1.0.2 (bản (3).md)
analyst: Requirement Analyst (AI) — người dùng: Hồng (QA)
---

# Requirement Analysis — CR-DAN-ANH-SOAN-TIN: Dán ảnh trực tiếp tại khu vực soạn tin

Viết tắt tham chiếu: `CR` = `tailieu/[CR] [Zalo Chat] Điều chỉnh hành vi dán ảnh trực tiếp tại khu vực soạn tin (3).md`;
`G003` = `tailieu/G003 - Chat.md` (v1.11); `G008` = `tailieu/G008 - Quản lý nhóm.md` (v1.1); `G009` = `tailieu/G009 - Tính năng
bổ sung Chat.md` (v1.12); `G036` = `tailieu/G036 - Giao diện khung hội thoại.md` (v1.0); `CR-004` = `tailieu/CR-004 - Nâng mốc
tách tin nhắn dài.md`; `ESC` = `tailieu/[Zalo chat] Điều chỉnh lại hành vi hiển thị khi click nút ESC trong khi ảnh đang mở.md`.
Số sau dấu `:` là số dòng trong **bản (3).md** (v1.0.2) tại thời điểm đọc lại 2026-10-21; bản (1).md đọc ngày 2026-10-20 không còn dùng. Nội dung gạch ngang trong file là bản cũ, không phải yêu cầu.

## 1. Nguồn và phạm vi đã đọc

| # | Tệp | Version ghi trong tệp | Phạm vi đã đọc | Ghi chú |
| ---: | --- | --- | --- | --- |
| 1 | `[CR] [Zalo Chat] Điều chỉnh hành vi dán ảnh trực tiếp tại khu vực soạn tin (3).md` | **v1.0.2** theo Change Log (`CR:286-287`: v1.0.1 và v1.0.2 cùng ngày 20/10/2026); header không ghi version · Date 15/10/2026 · Requested by AVZ - Khách hàng · Priority Medium · Status Approved · BA Nguyễn Thị Phương Thảo | Toàn bộ (288 dòng) | Nguồn chính. **ID: N/A** (`CR:5`). v1.0.1: bỏ giới hạn tổng dung lượng, thay bằng tối đa 25 ảnh (BR-01, BR-03, BR-16, AC-25→28, AC-45). v1.0.2: mô tả ảnh 2000 bytes (BR-08, §6.2, AC-09). UI: link Figma (`CR:9`, `CR:145`) — **chưa mở** (xem dưới) |
| 2 | `G003 - Chat.md` | 1.11 | UC-02a/b/c gửi tin, ảnh, file (`78-100`); E03/E04/E05 (`267-269`); BR03/BR03b/BR03c tách tin dài (`297-299`); BR04 5MB/file, BR05 tổng ≤25MB và tối đa 5 ảnh (`300-301`); BR10 ngắt kết nối (`306`); BR21 nhóm chỉ trưởng/phó nhắn tin (`317`); §7 trạng thái tin (`326-338`); §10D input box (`440-498`) | "Logic hiện tại" về dung lượng, trạng thái gửi, tách tin mà CR dẫn ở `CR:57`, `CR:84`, `CR:103` |
| 3 | `G009 - Tính năng bổ sung Chat.md` | 1.12 | UC-02 Reply (`93-105`), AF01 hủy reply (`186-192`), E04 (`208`), BR04–BR07, BR21 (`232-236`), BR12 (`241`), §10B (`296-304`), AC UC-02 (`368-379`) | Logic reply hiện hành: quote preview trong ô soạn, icon X hủy reply |
| 4 | `G008 - Quản lý nhóm.md` | 1.1 | UC-08 @mention (`221-230`), BR18–BR22 (`303-307`), AC UC-08 (`464-473`), OOS06 (`486`) | Logic @mention hiện hành trong nhóm |
| 5 | `G036 - Giao diện khung hội thoại.md` | 1.0 | BR01 gộp cụm (`134`), BR13 trích dẫn (`146`), BR14 ảnh + chú thích (`147`), BR24 trạng thái gửi / tin lỗi (`157`), BR28 màn cảm ứng (`161`), **OOS01 không gộp nhiều ảnh thành lưới** (`314`) | Cách hiển thị tin ảnh, chú thích, tin trả lời, tin lỗi hiện hành |
| 6 | `CR-004 - Nâng mốc tách tin nhắn dài.md` | CR-004 · last updated 2026-09-29 | Toàn bộ (92 dòng) | Mốc tách tin dài hiện hành = **2.000 ký tự** (`CR-004:36`), hệ thống vẫn tự tách (`CR-004:39`) |
| 7 | `[Zalo chat] Điều chỉnh lại hành vi hiển thị khi click nút ESC….md` | Không ghi | Toàn bộ (27 dòng) | Hiện trạng: Esc trong đoạn chat (ngoài lightbox) **thoát về danh sách** (`ESC:7`) — liên quan Esc đóng modal / popup của CR |

**Chưa đọc / không có trong `tailieu/`:**
- **Figma** `GOPANY--Zalo-Chat?node-id=35-2` (`CR:9`, `CR:145`) — CR dẫn "theo thiết kế" ở `CR:207`, `CR:209`, `CR:218`. Chưa mở trong phiên này (công cụ Figma MCP có giới hạn lượt gọi); sẽ dùng cho CX review (S7). Không có bản xuất ảnh trong `tailieu/`.
- Spec **popup Gửi Media (Ảnh, Video, Âm thanh)** và trường **Ghi chú (tùy chọn)** mà CR mô tả là hiện trạng (`CR:16`): không tìm thấy trong `tailieu/` (grep "Gửi Media" chỉ ra CR này). G003 UC-02b chỉ ghi "chọn ảnh từ máy → kiểm tra dung lượng → upload" (`G003:92-96`), không có popup, không có ghi chú.
- Spec **mention tự động khi reply trong nhóm** mà CR gọi là "logic hiện tại" (`CR:133`, `CR:141`): G009 UC-02 (`G009:93-98`) và G008 UC-08 (`G008:221-228`) không mô tả mention tự động.
- Spec **lưu bản nháp ô soạn tin** khi chuyển hội thoại (CR BR-18 `CR:99`): không có trong G003 / G036.
- Spec **thiết lập phím gửi** (`CR:273` "phím gửi theo thiết lập hiện tại"): G003 chỉ ghi "Nhấn Enter hoặc click icon gửi" (`G003:83`).

Ghi chú dẫn chiếu: CR-004 dẫn G003 bản 1.23 / G009 bản 1.15 (`CR-004:75-77`) trong khi file trong `tailieu/` ghi 1.11 / 1.12 và vẫn ghi mốc 1.000. Theo quy ước, file trong `tailieu/` là bản hiện hành; mốc 2.000 lấy từ CR-004 (đã chốt, "Đã sửa tài liệu · chờ dev làm" `CR-004:84`). Không coi là thiếu tài liệu.

## 2. Mục tiêu và phạm vi feature `[NGUỒN]`

- Hiện trạng: Ctrl+V ảnh → mở popup **Gửi Media (Ảnh, Video, Âm thanh)**; trường **Ghi chú (tùy chọn)** chưa hỗ trợ @mention nên không vừa đính kèm ảnh vừa soạn nội dung có @mention (`CR:16`).
- Thay đổi: dán ảnh trực tiếp vào khu vực soạn tin, hiển thị **thumbnail**, **không mở popup Gửi Media**; user tiếp tục nhập nội dung, chọn @mention trong nhóm, thêm **mô tả riêng cho từng ảnh** trước khi gửi (`CR:18`, `CR:24-27`).
- In scope (`CR:48-53`): khu vực soạn tin trên **desktop**, hội thoại **cá nhân và nhóm mà user có quyền gửi tin**; dán Ctrl+V; quản lý ảnh đính kèm và mô tả; gửi kèm nội dung, @mention, khi đang trả lời; cách hiển thị một ảnh / nhiều ảnh / mô tả **sau khi gửi**.
- Giữ nguyên logic hiện tại (`CR:57`, v1.0.1 sửa chữ): phân quyền, điều kiện gửi tin, định dạng và dung lượng **từng** ảnh, trạng thái gửi, mở trình xem ảnh, thao tác với ảnh đã gửi — trừ các thay đổi trong CR.
- v1.0.1: quy tắc **tổng dung lượng <25 MB bị gạch bỏ toàn bộ**, thay bằng **tối đa 25 ảnh** trong danh sách đính kèm của một lần gửi (`CR:82`, `CR:84`). v1.0.2: mô tả ảnh tối đa **2000 bytes** thay cho 1.580 ký tự (`CR:89`).
- Out of scope (`CR:61-65`): luồng tải ảnh bằng **icon** (vẫn mở popup Gửi Media); dán video / âm thanh / tệp tin / kéo thả; chỉnh sửa ảnh nguồn; đổi thứ tự ảnh bằng kéo thumbnail; lưu bản nháp ảnh qua tải lại trang / đóng trình duyệt / đăng nhập thiết bị khác.
- Data Migration: không chuyển đổi dữ liệu; không đổi ảnh đã gửi trước triển khai (`CR:280`).

## 3. Actor, precondition, trigger

| Mục | Nội dung | Nguồn | Nhãn |
| --- | --- | --- | --- |
| Actor | User (Staff / Admin) tại khu vực soạn tin trên desktop, trong hội thoại cá nhân hoặc nhóm **mà user có quyền gửi tin** | `CR:48` | `[NGUỒN]` |
| Precondition gửi | Theo điều kiện gửi hiện tại: tài khoản Zalo đang kết nối (G003 BR10), có quyền với hội thoại; nút Gửi "theo điều kiện gửi hiện tại" | `CR:57`, `CR:160`; `G003:306` | `[NGUỒN]` |
| Trigger chính | User **Ctrl+V** ảnh tại ô soạn tin | `CR:82`, `CR:229` | `[NGUỒN]` |
| Trigger phụ | Click icon chỉnh sửa / thumbnail (mở modal); click icon Xóa; click Xóa tất cả; click Gửi hoặc phím gửi; click Hủy / Esc / vùng tối (đóng modal); Huỷ mô tả / Quay lại / icon Đóng / Esc tại popup | `CR:86`, `CR:97-98`, `CR:92-96`, `CR:273` | `[NGUỒN]` |
| Hiện trạng dán | Ctrl+V ảnh → popup Gửi Media; Ghi chú không hỗ trợ @mention | `CR:16` | `[NGUỒN]` — không có spec riêng của popup (mục 1) |
| Hiện trạng @mention | Gõ `@` trong ô soạn nhóm → dropdown thành viên + @all; chọn → tag chèn tại con trỏ; gửi → highlight + push notification | `G008:223-228`, `G008:306` | `[NGUỒN]` |
| Hiện trạng reply | Click icon Reply → quote preview trong ô soạn; icon X hủy reply; không reply được tin đã thu hồi | `G009:95-98`, `G009:188-191`, `G009:232` | `[NGUỒN]` |
| Hiện trạng dung lượng | Mỗi ảnh ≤5MB (BR04, E04 báo lỗi ngay khi chọn); tổng lô **≤25MB, tối đa 5 ảnh × 5MB** (BR05); tổng >25MB → chặn toàn bộ lô (E05) | `G003:300-301`, `G003:268-269` | `[NGUỒN]` — CR v1.0.1 gạch giới hạn tổng (`CR:84`), chỉ còn giữ dung lượng từng ảnh (`CR:57`); G003 chưa cập nhật — Điểm chưa rõ #3 |
| Hiện trạng tách tin dài | Vượt **2.000 ký tự** → hệ thống tự tách tại xuống dòng / khoảng trắng; mỗi phần một tin, Retry riêng | `CR-004:36`, `CR-004:39`, `CR-004:44-45`; `G003:298-299` | `[NGUỒN]` |

## 4. Use case và luồng

Tài liệu CR không đánh mã use case; mã UC dưới đây **do QA tự đánh**, vị trí gốc ở cột Nguồn.

| Mã | Tên | Main flow | Alternate flow | Exception flow | Nguồn |
| --- | --- | --- | --- | --- | --- |
| UC-01 | Dán ảnh vào khu vực soạn tin | Ctrl+V ảnh tại ô soạn → thumbnail xuất hiện tại khu vực ảnh đính kèm dưới ô soạn, hiển thị `{n} ảnh`, không mở popup, chưa gửi → Ctrl+V tiếp → ảnh mới thêm **cuối** danh sách | Dán văn bản → xử lý theo logic hiện tại, không thêm ảnh (AC-24) | Ảnh không đạt định dạng / dung lượng từng ảnh → xử lý theo cơ chế hiện tại, không mất bản nháp hợp lệ (AC-29). Danh sách đã **25 ảnh**, dán ảnh thứ 26 → chặn thêm, thông báo giữa màn hình, giữ nguyên 25 ảnh (BR-03, AC-26/27) | `CR:82`, `CR:84`, `CR:153-155`, `CR:252`, `CR:254-255`, `CR:257` |
| UC-02 | Thêm / sửa / gỡ mô tả ảnh | Click icon chỉnh sửa hoặc thumbnail → Modal Nhập mô tả đúng ảnh → nhập (≤1.580 ký tự, Enter xuống dòng, `@` là text) → có thể chuyển ảnh, giữ tạm nội dung từng ảnh → Lưu → lưu toàn bộ thay đổi, đóng modal, thumbnail hiện dải mô tả (8 ký tự + "…") | Xóa hết mô tả đã lưu → Lưu để gỡ; Hủy / Esc / vùng tối khi không còn nội dung chưa lưu → đóng ngay | Còn nội dung chưa lưu không trống → popup Huỷ mô tả: Huỷ mô tả (bỏ hết, đóng cả hai) / Quay lại · icon Đóng · Esc (chỉ đóng popup) | `CR:86-96`, `CR:168-176`, `CR:184-189`, `CR:197-199` |
| UC-03 | Xóa ảnh đính kèm | Hover thumbnail → icon Xóa → xóa đúng ảnh + mô tả, giữ thứ tự còn lại, tính lại tổng dung lượng | Xóa tất cả → xóa toàn bộ, ẩn khu vực ảnh đính kèm | Không còn ảnh và ô soạn trống → không gửi tin rỗng theo logic hiện tại | `CR:97-98`, `CR:157-158`, `CR:247-250` |
| UC-04 | Gửi thông thường (không reply) | Click Gửi / phím gửi → kiểm tra danh sách không vượt 25 ảnh → gửi theo bảng §5.3: một ảnh không mô tả + nội dung → **cùng một tin**; các trường hợp còn lại có nội dung → **tin nhắn riêng trước** ảnh / cụm ảnh; ô soạn trống → chỉ ảnh / cụm ảnh + mô tả | Có @mention → gửi một lần trước cụm ảnh, không nhân bản | Phần lỗi → Retry riêng (chặn theo tổng dung lượng 25 MB đã bị gạch ở v1.0.1) | `CR:101`, `CR:109-122`, `CR:84`, `CR:103` |
| UC-05 | Gửi khi đang trả lời tin nhắn | Click Reply → dán ảnh (không hủy trạng thái reply) → Gửi: ô soạn có nội dung (kể cả chỉ mention tự động trong nhóm) → tin trả lời (trích dẫn + nội dung) **trước** ảnh / cụm ảnh, kể cả một ảnh không mô tả | User đóng vùng trả lời trước khi gửi → gửi như thông thường | Ô soạn trống (cá nhân) hoặc đã xóa mention và không còn nội dung (nhóm) → chỉ gửi ảnh, không tạo tin trả lời rỗng, không gắn trích dẫn vào ảnh | `CR:102`, `CR:128-141` |
| UC-06 | Bản nháp theo hội thoại | Chuyển sang hội thoại khác → không mang ảnh / mô tả theo → quay lại trong cùng phiên → hiển thị đúng bản nháp chưa gửi | — | Tải lại trang / đóng trình duyệt / thiết bị khác → ngoài phạm vi | `CR:99`, `CR:65`, `CR:251` |

## 5. Business rule

Mã BR-01…BR-22 là **mã gốc của CR** (`CR:82-103`). CR-01, CR-02 là bảng thay đổi (`CR:73-74`).

| Mã | Nội dung (sát nguyên văn) | Loại | Nguồn | Nhãn |
| --- | --- | --- | --- | --- |
| CR-01 | Dán ảnh → thumbnail tại khu vực soạn tin, không mở popup Gửi Media, chưa gửi; dán tiếp để thêm nhiều ảnh; tiếp tục nhập nội dung, chọn @mention, gửi tại khu vực soạn tin | nghiệp vụ | `CR:73` | `[NGUỒN]` |
| CR-02 | Icon chỉnh sửa và Xóa khi hover thumbnail; xóa từng ảnh / tất cả; icon chỉnh sửa → Modal Nhập mô tả; Lưu → lưu mô tả, cập nhật thumbnail, chưa gửi; đóng modal khi còn mô tả chưa lưu → popup Huỷ mô tả | nghiệp vụ | `CR:74` | `[NGUỒN]` |
| BR-01 | Ctrl+V ảnh tại ô soạn → thêm vào khu vực ảnh đính kèm; không mở popup, chưa gửi. Ctrl+V tiếp → thêm vào **cuối** danh sách, không thay thế. Giữ thứ tự ảnh còn lại sau khi xóa. **Danh sách ảnh đính kèm tối đa 25 ảnh** (v1.0.1; câu "điều kiện tổng dung lượng theo logic hiện tại" bị gạch) | nghiệp vụ | `CR:82` | `[NGUỒN]` |
| BR-02 | Dán ảnh không thay thế nội dung ô soạn. Mở modal, lưu / hủy mô tả, xóa ảnh không làm mất nội dung soạn hoặc @mention; không tự hủy trạng thái trả lời; không tự gửi | nghiệp vụ | `CR:83` | `[NGUỒN]` |
| BR-03 | **(v1.0.1) Số lượng ảnh mỗi lần gửi** — toàn bộ quy tắc cũ "tổng dung lượng <25 MB / chặn ≥25 MB / thông báo 25 M" bị gạch. Tối đa **25 ảnh** trong danh sách đính kèm của một lần gửi; đếm trên toàn bộ ảnh còn lại, không tính riêng từng lần Ctrl+V. Danh sách đã 25 ảnh, dán ảnh thứ 26 → **chặn thêm**, thông báo giữa màn hình **"Bạn chỉ nên gửi tối đa 25 ảnh/ lần"**, không để vượt 25. Giữ ảnh, mô tả, nội dung soạn; user xóa bớt rồi thêm. Khi gửi, kiểm tra danh sách không vượt 25 ảnh trước khi gửi | dữ liệu / nghiệp vụ | `CR:84` | `[NGUỒN]` — G003 BR05 / E05 (tổng ≤25MB, tối đa 5 ảnh) chưa cập nhật — Điểm chưa rõ #3 |
| BR-04 | Mỗi ảnh một mô tả tùy chọn; thêm / sửa / gỡ mô tả ảnh này không đổi ảnh khác; không tự sao chép nội dung ô soạn vào mô tả | dữ liệu | `CR:85` | `[NGUỒN]` |
| BR-05 | Icon chỉnh sửa → Modal Nhập mô tả của ảnh tương ứng; click thumbnail ngoài hai icon cũng mở cùng modal; ảnh đã có mô tả → trường nhập hiển thị nội dung đã lưu; icon Xóa chỉ xóa, không mở modal | nghiệp vụ | `CR:86` | `[NGUỒN]` |
| BR-06 | Trong modal chọn thumbnail hoặc nút chuyển ảnh; giữ tạm nội dung vừa chỉnh của từng ảnh trong lần mở; quay lại ảnh đã chỉnh → đúng nội dung vừa nhập, không gán sang ảnh khác | nghiệp vụ | `CR:87` | `[NGUỒN]` |
| BR-07 | Trường mô tả không hỗ trợ @mention; `@` là văn bản thường; Enter xuống dòng, không gửi; chỉ khoảng trắng / xuống dòng → trống | nghiệp vụ | `CR:88` | `[NGUỒN]` |
| BR-08 | **(v1.0.2)** Mô tả tối đa **2000 bytes** (bản cũ 1.580 ký tự bị gạch), tính cả khoảng trắng và ký tự xuống dòng; đủ 2000 bytes → không cho nhập thêm ký tự; dán dài → chỉ nhận phần trong giới hạn còn lại; giới hạn riêng từng ảnh | dữ liệu | `CR:89` | `[NGUỒN]` — đơn vị "bytes" — Điểm chưa rõ #17 |
| BR-09 | Lưu → lưu toàn bộ thay đổi của các ảnh đã chỉnh trong lần mở, đóng modal, cập nhật thumbnail; ảnh có mô tả đã lưu, xóa hết rồi Lưu → gỡ mô tả; Lưu không gửi ảnh | nghiệp vụ | `CR:90` | `[NGUỒN]` |
| BR-10 | Mô tả đã lưu hiển thị trên thumbnail; vượt **8 ký tự** → 8 ký tự đầu + "…"; ≤8 ký tự hiển thị đủ; chỉ rút gọn hiển thị, giữ nguyên nội dung | hiển thị | `CR:91` | `[NGUỒN]` |
| BR-11 | Hủy / đóng modal / Esc / click vùng tối → đóng modal **không popup** khi không còn nội dung mới / chỉnh sửa chưa lưu ở bất kỳ ảnh nào (chưa nhập, nhập rồi xóa hết, hoặc đưa về đúng giá trị đã lưu); chỉnh sửa chưa Lưu không áp dụng; đã xóa mô tả cũ chưa Lưu rồi đóng → mô tả cũ giữ nguyên | nghiệp vụ | `CR:92` | `[NGUỒN]` |
| BR-12 | Ít nhất một ảnh còn nội dung mới / chỉnh sửa **không trống và chưa lưu** → Hủy / đóng / Esc / vùng tối mở popup **Huỷ mô tả**; chưa đóng modal, chưa bỏ nội dung. Chỉ xóa hết mô tả mà không còn nội dung vừa nhập ở ảnh khác → không popup | nghiệp vụ | `CR:93` | `[NGUỒN]` |
| BR-13 | Click **Huỷ mô tả** → đóng popup và modal, không lưu chỉnh sửa của tất cả ảnh trong lần mở; giữ mô tả đã lưu trước, ảnh, nội dung soạn, @mention, trạng thái trả lời; không gửi | nghiệp vụ | `CR:94` | `[NGUỒN]` |
| BR-14 | **Quay lại** / icon Đóng / Esc tại popup → chỉ đóng popup, tiếp tục ở modal, giữ nội dung đang chỉnh | nghiệp vụ | `CR:95` | `[NGUỒN]` |
| BR-15 | Click vùng tối xử lý theo điều kiện của modal; click trường nhập, thumbnail, nút chuyển ảnh, nút thao tác không tính là vùng tối. Popup Huỷ mô tả mở → chỉ popup nhận tương tác, không truyền xuống modal / hội thoại | nghiệp vụ | `CR:96` | `[NGUỒN]` |
| BR-16 | Icon Xóa → xóa đúng ảnh và mô tả; giữ ảnh còn lại đúng mô tả, thứ tự, nội dung soạn, trạng thái trả lời; **cập nhật số lượng ảnh còn lại để user thêm ảnh trong giới hạn 25** (v1.0.1; câu "tính lại tổng dung lượng" bị gạch) | nghiệp vụ / dữ liệu | `CR:97` | `[NGUỒN]` |
| BR-17 | Xóa tất cả → xóa toàn bộ ảnh và mô tả, ẩn khu vực ảnh đính kèm; giữ nội dung, @mention, trạng thái trả lời; không còn ảnh và ô soạn trống → không gửi tin rỗng theo logic hiện tại | nghiệp vụ | `CR:98` | `[NGUỒN]` |
| BR-18 | Ảnh đính kèm và mô tả thuộc đúng bản nháp của **hội thoại và tài khoản Zalo** tương ứng; chuyển hội thoại không mang theo; quay lại trong cùng phiên → hiển thị bản nháp chưa gửi | dữ liệu | `CR:99` | `[NGUỒN]` — Điểm chưa rõ #11 |
| BR-19 | Đang đính kèm ảnh vẫn nhập nội dung và chọn @mention theo logic hiện tại; gửi giữ đúng thành viên và chức năng mention, không nhân bản theo số ảnh; mention đã chọn, **kể cả mention tự động khi reply**, được tính là nội dung | nghiệp vụ | `CR:100` | `[NGUỒN]` — "mention tự động" không có spec — Điểm chưa rõ #7 |
| BR-20 | Một ảnh không mô tả → nội dung đi cùng ảnh. Một ảnh có mô tả → nội dung thành **tin nhắn riêng trước ảnh**. Nhiều ảnh → tin nhắn riêng trước **cụm ảnh**, không lặp trên từng ảnh, không ghép vào ảnh chưa có mô tả. Ô soạn trống → chỉ ảnh / cụm ảnh + mô tả | nghiệp vụ | `CR:101`, bảng `CR:113-122` | `[NGUỒN]` |
| BR-21 | Đang trả lời: ô soạn có nội dung → tin trả lời (trích dẫn + nội dung) **trước** ảnh / cụm ảnh, kể cả một ảnh không mô tả. Nhóm chỉ còn mention tự động → vẫn gửi tin trả lời có mention. Ô soạn trống → chỉ gửi ảnh, không tin trả lời rỗng. Trích dẫn không gắn vào ảnh; mô tả không thay nội dung trả lời | nghiệp vụ | `CR:102`, bảng `CR:132-135`, `CR:139-141` | `[NGUỒN]` |
| BR-22 | Có tin nhắn riêng / tin trả lời → gửi nội dung **trước** ảnh / cụm ảnh. Nội dung dài tự tách, trạng thái gửi và gửi lại kế thừa logic hiện tại. Thử lại phần lỗi không gửi lại phần đã thành công, không làm sai mô tả ảnh | nghiệp vụ | `CR:103` | `[NGUỒN]` — Điểm chưa rõ #5, #10 |

**Luật hiện hành liên quan (nguồn ngoài CR, CR dẫn "logic hiện tại"):**

| Mã gốc | Nội dung | Nguồn | Nhãn |
| --- | --- | --- | --- |
| G003 BR04 / E04 | Mỗi file tối đa 5MB mọi định dạng; vượt → thông báo lỗi **ngay khi chọn file, trước khi upload** | `G003:300`, `G003:268` | `[NGUỒN]` |
| G003 BR05 / E05 | Gửi nhiều ảnh: tổng **≤25MB**/lần gửi (**tối đa 5 ảnh × 5MB**); tổng >25MB → chặn toàn bộ lô, thông báo lỗi | `G003:301`, `G003:269` | `[NGUỒN]` |
| G003 BR03/b/c + CR-004 | Vượt mốc tách (2.000 ký tự) → tự tách tại xuống dòng / khoảng trắng; mỗi phần một tin độc lập, Retry riêng; ô soạn không counter, không chặn | `G003:297-299`, `CR-004:36-40`, `CR-004:44-45` | `[NGUỒN]` |
| G003 §7 / E03 | Đang gửi → Đã gửi / Lỗi gửi (sau 3 phút) → Retry | `G003:331-337`, `G003:267` | `[NGUỒN]` |
| G003 BR10, BR21 | Tài khoản ngắt kết nối → không gửi tin mới (input disable `G003:521`); nhóm "chỉ trưởng/phó nhóm được nhắn tin" | `G003:306`, `G003:317` | `[NGUỒN]` |
| G008 BR20, BR21 | Hai loại mention @[tên] và @all; gõ `@` → dropdown, chọn → chèn tag tại con trỏ | `G008:305-306` | `[NGUỒN]` |
| G009 UC-02, AF01, BR05 | Reply: quote preview trong ô soạn; X hủy reply; quote cắt 100 ký tự, tin gốc có ảnh → `[Hình ảnh]` | `G009:95-98`, `G009:188-191`, `G009:233` | `[NGUỒN]` |
| G036 BR14 | Ảnh giữ tỉ lệ, tối đa 360×368px; **chú thích (nếu có) dính liền dưới ảnh, cùng bề ngang** | `G036:147` | `[NGUỒN]` |
| G036 BR24 | Tin gửi lỗi: viền đỏ + "Thử lại" ở mọi vị trí | `G036:157` | `[NGUỒN]` |
| G036 OOS01 | "Gộp nhiều ảnh thành lưới như album Zalo — Đã thống nhất bỏ qua — vẫn hiện từng ảnh" | `G036:314` | `[NGUỒN]` — mâu thuẫn với CR §6.5 "Cụm ảnh" — Điểm chưa rõ #2 |
| ESC (hiện trạng) | Esc trong đoạn chat khi không có lightbox → thoát về danh sách đoạn chat (hành vi hiện tại, CR ESC chỉ sửa cho lightbox) | `ESC:7`, `ESC:27` | `[NGUỒN]` — Điểm chưa rõ #13 |

## 6. Acceptance criteria, mã lỗi, thông báo, giới hạn số

**Giới hạn số và chuỗi nguyên văn trong CR:**

| Mục | Nguyên văn | Nguồn |
| --- | --- | --- |
| Số lượng ảnh | Tối đa **25 ảnh** / lần gửi; dán ảnh thứ **26** → chặn thêm (v1.0.1). Bản cũ "<25 MB cho gửi / ≥25 MB chặn" bị gạch | `CR:82`, `CR:84`, `CR:253-256` |
| Thông báo chặn | **Bạn chỉ nên gửi tối đa 25 ảnh/ lần** — hiển thị "giữa màn hình" (v1.0.1). Bản cũ "Tổng kích thước ảnh tải lên phải nhỏ hơn 25 M" bị gạch | `CR:84`, `CR:254-255` |
| Độ dài mô tả | **2000 bytes** (v1.0.2), tính cả khoảng trắng và xuống dòng; bản cũ 1.580 ký tự bị gạch | `CR:89`, `CR:173`, `CR:237` |
| Rút gọn thumbnail | **8 ký tự** đầu + "…" | `CR:91`, `CR:197` |
| Số lượng ảnh | `{n} ảnh` | `CR:154` |
| Tooltip | **Thêm mô tả** / **Chỉnh sửa mô tả** (icon chỉnh sửa); **Xóa ảnh** (icon Xóa) | `CR:156-157` |
| Modal | Tiêu đề **Nhập mô tả**; placeholder **Nhập mô tả cho ảnh**; nút **Lưu**, **Hủy** | `CR:169`, `CR:173-175` |
| Popup | Tiêu đề **Huỷ mô tả**; nội dung **Nội dung mô tả vừa nhập sẽ không được lưu. Bạn có chắc muốn tiếp tục?**; nút **Quay lại**, **Huỷ mô tả**, icon Đóng | `CR:185-189` |
| Nút Lưu | Default "Disable khi chưa nhập mô tả"; enable khi đã nhập; nhập rồi xóa hết (không thay đổi ảnh khác) → disable; ảnh có mô tả đã lưu, xóa hết → **vẫn cho Lưu** để gỡ | `CR:174` |
| Ví dụ AC | Đúng 25 ảnh cho gửi (AC-25); 25 → 24 → 25 ảnh (AC-28); mô tả 8 và 9 ký tự (AC-07); `@Lan` (AC-18) | `CR:253`, `CR:256`, `CR:235`, `CR:246` |

**Acceptance Criteria (mã gốc AC-01…AC-46, `CR:229-274`)** — tóm tắt, nguyên văn xem file:

| Mã | Tóm tắt | Nguồn |
| --- | --- | --- |
| AC-01 | Ctrl+V một ảnh → thumbnail, không popup, chưa gửi | `CR:229` |
| AC-02 | Dán B, C sau A (A đã có mô tả) → A, B, C đúng thứ tự; A giữ mô tả | `CR:230` |
| AC-03 | Nội dung + mention + đang reply giữ nguyên qua dán / mở modal / Lưu / hủy | `CR:231` |
| AC-04 | Icon chỉnh sửa và click thumbnail đều mở modal đúng ảnh B, trường hiển thị mô tả đã lưu | `CR:232` |
| AC-05 | Lưu mô tả mới cho A → đóng modal, thumbnail A có mô tả, ảnh khác không đổi | `CR:233` |
| AC-06 | Nút Lưu disable khi chưa nhập, enable sau khi nhập | `CR:234` |
| AC-07 | 8 ký tự hiển thị đủ; 9 ký tự → 8 + "…"; mở lại modal và gửi dùng đủ 9 | `CR:235` |
| AC-08 | Chỉnh A, chuyển B chỉnh, quay A còn nguyên; Lưu giữ A và B, C không đổi | `CR:236` |
| AC-09 | (v1.0.2) Đủ **2000 bytes** lưu được; gõ thêm không nhận; dán dài chỉ nhận phần còn lại | `CR:237` |
| AC-10 | Còn nội dung chưa lưu → Hủy / vùng tối / đóng / Esc đều mở popup, modal vẫn mở | `CR:238` |
| AC-11 | Huỷ mô tả → bỏ thay đổi A, B; đóng popup + modal; giữ mô tả cũ, ảnh, nội dung | `CR:239` |
| AC-12 | Quay lại / icon Đóng / Esc tại popup → chỉ đóng popup | `CR:240` |
| AC-13 | Chưa nhập → Hủy / vùng tối / đóng / Esc đóng modal, không popup | `CR:241` |
| AC-14 | Nhập mới rồi xóa hết → Lưu disable; Hủy / vùng tối đóng ngay | `CR:242` |
| AC-15 | A có nội dung chưa lưu, đang ở B trống → Hủy vẫn popup; Lưu vẫn cho lưu A | `CR:243` |
| AC-16 | Xóa hết mô tả đã lưu của A: Lưu → gỡ; Hủy / vùng tối → đóng không popup, giữ mô tả cũ | `CR:244` |
| AC-17 | Chỉ khoảng trắng / xuống dòng → trống, Lưu disable, đóng không popup | `CR:245` |
| AC-18 | Enter xuống dòng; `@Lan` là text, không mở danh sách | `CR:246` |
| AC-19 | Xóa B → A, C giữ mô tả và thứ tự, còn 2 ảnh, giữ nội dung, không mở modal | `CR:247` |
| AC-20 | Kéo thumbnail C trước A → thứ tự không đổi, gửi theo A, B, C | `CR:248` |
| AC-21 | Xóa tất cả → ẩn khu vực, giữ nội dung, mention, trạng thái reply | `CR:249` |
| AC-22 | Xóa ảnh cuối, ô soạn trống → ẩn khu vực, không cho gửi rỗng | `CR:250` |
| AC-23 | Bản nháp A không sang B; quay lại A còn nguyên trong cùng phiên | `CR:251` |
| AC-24 | Ctrl+V văn bản → theo logic hiện tại, không popup, không thêm ảnh | `CR:252` |
| AC-25 | (v1.0.1) Đúng **25 ảnh** → cho gửi; nội dung, ảnh, mô tả đúng quy tắc. Bản cũ "24,9 MB" bị gạch | `CR:253` |
| AC-26 | (v1.0.1) Danh sách đã 25 ảnh qua nhiều lần dán → Ctrl+V thêm → không thêm ảnh 26, thông báo giữa màn hình, giữ 25 ảnh; đếm theo tổng danh sách | `CR:254` |
| AC-27 | (v1.0.1) 25 ảnh có mô tả + nội dung → dán ảnh 26 → chặn thêm, thông báo, danh sách vẫn 25, không tự gửi | `CR:255` |
| AC-28 | (v1.0.1) Bị chặn ở 25 ảnh → xóa một (24) → dán một (25) → gửi được; giữ mô tả, không mất / trùng nội dung | `CR:256` |
| AC-29 | Dán ảnh sai định dạng / dung lượng từng ảnh → xử lý theo cơ chế hiện tại, không mất bản nháp hợp lệ | `CR:257` |
| AC-30 | Một ảnh, không mô tả, ô trống → chỉ gửi ảnh | `CR:258` |
| AC-31 | Một ảnh, không mô tả, có nội dung → **cùng một tin**, giữ mention | `CR:259` |
| AC-32 | Một ảnh có mô tả, ô trống → ảnh + mô tả bên dưới trong cùng khung | `CR:260` |
| AC-33 | Một ảnh có mô tả + nội dung → tin riêng trước ảnh; ảnh giữ mô tả | `CR:261` |
| AC-34 | Nhiều ảnh không mô tả: ô trống → chỉ cụm; có nội dung → tin riêng trước cụm | `CR:262` |
| AC-35 | A, C có mô tả, B không: cụm đúng mô tả; nội dung không gán vào B | `CR:263` |
| AC-36 | Nhiều ảnh đều có mô tả: cụm từng ảnh đúng mô tả; nội dung tin riêng trước | `CR:264` |
| AC-37 | Nhóm, nhiều ảnh, mention → mention một lần trước cụm | `CR:265` |
| AC-38 | Reply + nội dung + ảnh → tin trả lời trước ảnh / cụm, kể cả một ảnh không mô tả | `CR:266` |
| AC-39 | Reply nhóm chỉ còn mention tự động → tin trả lời có mention trước ảnh; không coi là trống | `CR:267` |
| AC-40 | Reply cá nhân, ô trống → chỉ gửi ảnh, không tin trả lời rỗng | `CR:268` |
| AC-41 | Reply nhóm đã xóa mention, không nội dung → chỉ gửi ảnh | `CR:269` |
| AC-42 | Đóng vùng trả lời rồi gửi → như gửi thông thường | `CR:270` |
| AC-43 | Thử lại phần lỗi → không gửi trùng phần đã thành công, giữ ảnh / mô tả / mention | `CR:271` |
| AC-44 | Click ảnh đã gửi → trình xem hiện tại, thao tác giữ nguyên | `CR:272` |
| AC-45 | Phím gửi → gửi cả nội dung và ảnh, không bỏ ảnh lại (v1.0.1: precondition "danh sách có tối đa 25 ảnh" thay "tổng <25 MB") | `CR:273` |
| AC-46 | Popup đang mở: click modal phía sau không tác dụng; Esc chỉ đóng popup | `CR:274` |

Mã lỗi: CR không định nghĩa mã lỗi. Thông báo duy nhất có nguyên văn là chặn ảnh thứ 26 (`CR:84`); thông báo chặn 25 MB của bản cũ đã bị gạch. Lỗi định dạng / dung lượng từng ảnh và lỗi gửi dẫn "cơ chế hiện tại" (`CR:257`, `CR:271`) — G003 E04 / E03 không ghi nguyên văn thông báo.

## 7. Trạng thái và chuyển trạng thái

**7a. Khu vực ảnh đính kèm (QA tự dựng từ `CR:82`, `CR:97-99`, `CR:153`):**

| Từ | Sự kiện | Sang | Nguồn |
| --- | --- | --- | --- |
| Ẩn (0 ảnh) | Ctrl+V ảnh hợp lệ | Hiển thị, n = số ảnh dán | `CR:82`, `CR:153` |
| Hiển thị (n) | Ctrl+V thêm | Hiển thị (n + k), ảnh mới ở cuối | `CR:82` |
| Hiển thị (25) | Ctrl+V thêm | Không đổi (vẫn 25), thông báo giữa màn hình | `CR:84`, `CR:254` |
| Hiển thị (n) | Xóa một ảnh | n − 1; n − 1 = 0 → Ẩn | `CR:97`, `CR:250` |
| Hiển thị (n) | Xóa tất cả | Ẩn | `CR:98` |
| Hiển thị (n) | Chuyển hội thoại khác | Hội thoại khác: Ẩn (bản nháp riêng); quay lại: Hiển thị (n) | `CR:99` |
| Hiển thị (n) | Gửi thành công | *(tài liệu không ghi rõ — xem mục 8 #1)* | — |

**7b. Modal Nhập mô tả / popup Huỷ mô tả (`CR:86-96`):**

| Từ | Sự kiện | Điều kiện | Sang | Nguồn |
| --- | --- | --- | --- | --- |
| Đóng | Click icon chỉnh sửa / thumbnail | — | Modal mở tại ảnh được chọn | `CR:86` |
| Modal mở | Chọn thumbnail / nút chuyển ảnh | — | Modal mở tại ảnh khác, giữ tạm nội dung | `CR:87` |
| Modal mở | Lưu | Nút enable | Đóng; mô tả cập nhật | `CR:90`, `CR:174` |
| Modal mở | Hủy / đóng / Esc / vùng tối | Không còn nội dung chưa lưu không trống | Đóng; không áp dụng chỉnh sửa | `CR:92` |
| Modal mở | Hủy / đóng / Esc / vùng tối | Còn ≥1 ảnh có nội dung chưa lưu không trống | Popup Huỷ mô tả mở (modal vẫn mở) | `CR:93` |
| Popup mở | Huỷ mô tả | — | Đóng cả popup và modal; bỏ mọi chỉnh sửa | `CR:94` |
| Popup mở | Quay lại / icon Đóng / Esc | — | Modal mở, giữ nội dung | `CR:95` |
| Popup mở | Click modal phía sau | — | Không đổi | `CR:96`, `CR:274` |

**7c. Trạng thái gửi:** kế thừa G003 §7 (`G003:331-337`) — Đang gửi → Đã gửi / Lỗi gửi → Retry. CR không thêm trạng thái mới (`CR:103`).

## 8. Diễn giải, giả định, QA observation

| # | Nội dung | Nhãn | Liên quan tới |
| ---: | --- | --- | --- |
| 1 | Sau khi gửi thành công, khu vực ảnh đính kèm ẩn và ô soạn trống — CR không ghi câu này; suy từ "bản nháp chưa gửi" (`CR:99`) và "sau khi hoàn tất lần gửi, trạng thái trả lời kết thúc" (`CR:141`) | `[DIỄN GIẢI AI]` | BR-18, UC-04 |
| 2 | "Cụm ảnh" là cách **hiển thị** trên Gopany; mỗi ảnh có mô tả riêng nên trên Zalo nhiều khả năng mỗi ảnh là một tin (ảnh + caption) — CR chỉ nói "cách hiển thị nhiều ảnh trong cùng một lần gửi" (`CR:39`) | `[DIỄN GIẢI AI]` | BR-20, §6.5 — Điểm chưa rõ #2 |
| 3 | "Nội dung soạn đi cùng ảnh" (một ảnh không mô tả) = ảnh có caption là nội dung soạn, hiển thị như "chú thích dính liền dưới ảnh" G036 BR14 (`G036:147`) và "vị trí nội dung theo cơ chế hiện tại" (`CR:219`) | `[DIỄN GIẢI AI]` | BR-20, AC-31, §6.6 |
| 4 | Mô tả có khoảng trắng đầu / cuối khi Lưu: có trim không — tài liệu không nói | `[QA BỔ SUNG]` | BR-07, BR-09 |
| 5 | Giới hạn 25 ảnh: dựng 24 / 25 / 26 ảnh nhỏ (vd 100 KB) để không chạm 5 MB/ảnh. 25 ảnh × 5 MB = 125 MB một lần gửi — CR không còn chặn tổng, cần quan sát thời gian upload và hành vi khi mạng chậm | `[QA BỔ SUNG]` | BR-03, AC-25–28 |
| 6 | Ctrl+V trên macOS là Cmd+V; CR chỉ ghi Ctrl+V và "desktop" (`CR:48`) | `[QA BỔ SUNG]` | BR-01 |
| 7 | Dán cùng một ảnh hai lần → hai thumbnail giống nhau (CR: "ảnh mới thêm vào cuối, không thay thế" `CR:82`) — không khử trùng | `[DIỄN GIẢI AI]` | BR-01 |
| 8 | Màn cảm ứng / không có hover: G036 BR28 nói nút vốn hiện khi rê chuột thì luôn hiện (`G036:161`); CR chỉ nói hover (`CR:156`). Phạm vi CR là desktop | `[QA BỔ SUNG]` | §6.1 |
| 9 | Hai nhân viên dùng chung một tài khoản Zalo (G036:39) — bản nháp ảnh thuộc trình duyệt của từng người, không đồng bộ | `[GIẢ ĐỊNH]` | BR-18 — Điểm chưa rõ #11 |
| 10 | Khi dán, ảnh có đi qua kiểm tra từng ảnh (5MB, định dạng) ngay lúc dán như E04 "ngay khi chọn file" | `[DIỄN GIẢI AI]` | AC-29 — Điểm chưa rõ #4 |
| 11 | Giới hạn 2000 bytes: dựng mô tả bằng chuỗi ASCII (1 byte/ký tự), chữ Việt có dấu (2–3 bytes/ký tự UTF-8), emoji (4 bytes) để kiểm ranh giới; cần biết bảng mã đếm trước khi dựng | `[QA BỔ SUNG]` | BR-08, AC-09 — Điểm chưa rõ #17 |
| 12 | Change Log v1.0.1 ghi "AC-46" nhưng dòng đổi nội dung là AC-45 (`CR:273`), AC-46 không đổi (`CR:274`) — nhiều khả năng dẫn chiếu nhầm | `[DIỄN GIẢI AI]` | Điểm chưa rõ #16 |

## 9. Điểm chưa rõ (chuyển sang Debate)

| # | Loại | Trích dẫn + nguồn | Vì sao chưa rõ | Đề xuất mức |
| ---: | --- | --- | --- | --- |
| 1 | ~~Thiếu / mâu thuẫn~~ **Đã rõ theo v1.0.1** | `CR:82` "Danh sách ảnh đính kèm tối đa 25 ảnh"; `CR:84` dán ảnh thứ 26 → chặn thêm, thông báo "Bạn chỉ nên gửi tối đa 25 ảnh/ lần", kiểm lại khi gửi; AC-25→28 (`CR:253-256`) | Bản (1) không nêu số ảnh tối đa; bản (3) đã nêu số lượng (25) và thời điểm chặn (lúc dán, kiểm lại lúc gửi). Phần còn lại tách sang #9 (iv) (dán nhiều file khi chỗ trống không đủ) và #14 (chữ "chỉ nên") | **Đóng** — tài liệu cập nhật 20/10/2026 |
| 2 | Mâu thuẫn / nhiều cách hiểu | CR §6.5 "Cụm ảnh: hiển thị các ảnh trong cùng một khung theo thiết kế" (`CR:207`), "Cụm ảnh: cách hiển thị nhiều ảnh trong cùng một lần gửi" (`CR:39`), in scope "điều chỉnh cách hiển thị… nhiều ảnh" (`CR:53`). G036 OOS01: "Gộp nhiều ảnh thành lưới như album Zalo — Đã thống nhất bỏ qua — vẫn hiện từng ảnh" (`G036:314`) | (i) Cụm ảnh trên Zalo là **một tin** hay **n tin** (mỗi ảnh một tin + caption)? Quyết định cách thu hồi / trả lời / react / chuyển tiếp / ghim **từng ảnh**, trạng thái gửi, Retry từng ảnh. (ii) Cách hiển thị cụm có áp dụng cho ảnh gửi qua **popup Gửi Media**, ảnh **khách gửi**, ảnh gửi **từ điện thoại** (nhiều ảnh liên tiếp) không, hay chỉ ảnh từ luồng Ctrl+V? (iii) G036 OOS01 còn hiệu lực không | **Trọng yếu** |
| 3 | Mâu thuẫn giữa nguồn (viết lại theo v1.0.1) | CR v1.0.1 gạch toàn bộ quy tắc tổng <25 MB (`CR:84`); Note chỉ còn "dung lượng **từng** ảnh" (`CR:57`); AC-25 cho gửi đúng 25 ảnh (`CR:253`). G003 BR05 "tổng ≤25MB/lần gửi (tối đa 5 ảnh × 5MB)" (`G003:301`), E05 ">25MB chặn toàn bộ lô" (`G003:269`) chưa cập nhật | Giới hạn **tổng 25 MB** (và 5 ảnh) của G003 **hết hiệu lực** cho luồng dán, hay hệ thống vẫn chặn tổng theo logic đang chạy? Nếu còn chặn, 25 ảnh × 2 MB = 50 MB mâu thuẫn AC-25. Luồng icon Gửi Media (ngoài phạm vi) còn áp 25 MB / 5 ảnh không? Thông báo "giữa màn hình" là toast hay popup phải đóng? | **Trọng yếu** |
| 4 | Thiếu / nhiều cách hiểu | AC-29: dán ảnh sai định dạng / vượt dung lượng từng ảnh → "kiểm tra và xử lý lỗi theo cơ chế hiện tại. Không gửi ảnh không hợp lệ, không làm mất bản nháp hợp lệ" (`CR:257`). G003 E04: "thông báo lỗi ngay khi chọn file, trước khi upload" (`G003:268`); G003 §10D chỉ ghi "Ảnh PNG/JPG view preview" (`G003:467`) | (a) Ảnh lỗi bị **từ chối ngay khi dán**, không xuất hiện thumbnail, báo lỗi; (b) ảnh vẫn vào danh sách, **chặn khi Gửi**. Hai cách cho expected result khác nhau ở AC-29. Thêm: định dạng nào được dán (PNG, JPG, GIF, WebP, SVG, BMP, HEIC?) và nguyên văn thông báo lỗi | **Trọng yếu** |
| 5 | Thiếu | BR-20 "Một ảnh không có mô tả: nội dung soạn đi cùng ảnh" (`CR:101`, `CR:114`); BR-22 "Nội dung dài tự tách… kế thừa logic hiện tại" (`CR:103`); mốc tách 2.000 (`CR-004:36`), mô tả ảnh tối đa 1.580 (`CR:89`) | Một ảnh không mô tả + nội dung soạn **> 2.000 ký tự** (hoặc > giới hạn caption của ảnh): nội dung đi cùng ảnh thế nào — tách thành tin riêng trước ảnh, cắt caption, hay chặn? Có thể mất nội dung | **Trọng yếu** (có thể cô lập vào nhóm case "nội dung dài") |
| 6 | Thiếu (hiện trạng) | CR:16 popup Gửi Media + Ghi chú; OOS "không thay đổi luồng tải ảnh bằng icon" (`CR:61`) | Không có spec popup Gửi Media trong `tailieu/`. Khi đã có ảnh dán rồi click icon Gửi ảnh → popup: ảnh gửi từ popup có kèm ảnh đã dán không; ảnh gửi qua popup có Ghi chú hiển thị như "mô tả bên dưới ảnh" §6.6 không. Cần để khoanh hồi quy | Không trọng yếu (cô lập: hồi quy luồng icon) |
| 7 | Thiếu (hiện trạng) | "mention tự động khi reply" (`CR:100`, `CR:133`, `CR:141`, AC-39 `CR:267`) | G009 UC-02 và G008 UC-08 không mô tả mention tự động khi reply trong nhóm: tag là ai, có xóa được không (AC-41 giả định xóa được). Cần để dựng AC-39 / AC-41 | Không trọng yếu (hành vi CR đã rõ; thiếu cách dựng) |
| 8 | Thiếu | §5.4 "có nội dung hợp lệ" (`CR:132`), BR-20 "ô soạn trống" (`CR:101`); BR-07 định nghĩa "chỉ khoảng trắng = trống" **chỉ cho mô tả** (`CR:88`) | Ô soạn chỉ có khoảng trắng / xuống dòng khi gửi kèm ảnh: coi là trống (chỉ gửi ảnh) hay là nội dung (tạo tin riêng / caption)? | Không trọng yếu (cô lập một case) |
| 9 | Thiếu | BR-01 Ctrl+V (`CR:82`); thumbnail "theo thứ tự dán" (`CR:155`); AC-24 dán văn bản (`CR:252`) | (i) Một lần Ctrl+V chứa **nhiều file ảnh** (copy từ Explorer): có nhận hết không, thứ tự nào? (ii) Clipboard có **cả ảnh và văn bản** (copy từ web / Word): dán gì? (iii) Ctrl+V ảnh khi focus đang ở **trường Mô tả trong modal**: bỏ qua hay thêm ảnh? (iv) Danh sách còn k chỗ trống (vd 23 ảnh), một lần dán nhiều hơn k file: nhận k ảnh đầu hay từ chối hết, thông báo nào? | Không trọng yếu (ĐO & GHI nếu BA không trả lời) |
| 10 | Thiếu (hiển thị) | BR-22 "thử lại phần lỗi" (`CR:103`), AC-43 (`CR:271`); G036 BR24 tin lỗi viền đỏ + Thử lại (`G036:157`) | Một ảnh trong cụm gửi lỗi: cụm hiển thị thế nào (ảnh lỗi viền đỏ trong cụm, hay tách ra), nút Thử lại ở đâu; ảnh lỗi gửi lại thành công có quay về đúng vị trí trong cụm không | Không trọng yếu (hiển thị) |
| 11 | Mơ hồ | BR-18 "bản nháp của hội thoại và tài khoản Zalo tương ứng… trong cùng phiên sử dụng" (`CR:99`); OOS tải lại trang (`CR:65`) | Bản nháp giữ ở trình duyệt của user hay server; hai nhân viên dùng chung tài khoản Zalo có thấy bản nháp của nhau không; "phiên sử dụng" kết thúc khi nào (đăng xuất? đổi tài khoản Zalo đang chọn?); nội dung text ô soạn hiện có được giữ khi chuyển hội thoại không (CR chỉ nói ảnh / mô tả) | Không trọng yếu (dữ liệu nháp cục bộ; cô lập AC-23) |
| 12 | Thiếu (ngoài phạm vi nhưng cần hành vi) | Phạm vi "hội thoại mà user có quyền gửi tin" (`CR:48`); G003 BR10 input disable khi ngắt kết nối (`G003:306`, `G003:521`); BR21 nhóm chỉ trưởng/phó nhắn (`G003:317`) | Ctrl+V ảnh khi ô soạn bị disable / không có quyền gửi: bỏ qua im lặng, báo lỗi, hay vẫn cho đính kèm rồi chặn khi gửi? Tài khoản ngắt kết nối **sau khi** đã dán ảnh | Không trọng yếu (cô lập; ĐO & GHI) |
| 13 | Thiếu | BR-11 Esc đóng modal (`CR:92`); BR-15 chỉ nói popup không truyền thao tác xuống (`CR:96`); AC-46[2] (`CR:274`). Hiện trạng: Esc trong đoạn chat → thoát về danh sách (`ESC:7`) | Esc đóng **Modal Nhập mô tả** (khi không có popup) có bị lan xuống hội thoại và thoát đoạn chat không? CR chỉ cấm lan cho popup | Không trọng yếu (QA kiểm, nếu lỗi là defect theo AC-46 tinh thần) |
| 14 | Mơ hồ (hiển thị / chữ) | BR-10 "8 ký tự" (`CR:91`); nút chuyển ảnh "chỉ nhận thao tác khi có ảnh tương ứng" (`CR:172`); `{n} ảnh` (`CR:154`) | 8 ký tự đếm cả khoảng trắng / xuống dòng? Mô tả có xuống dòng hiển thị trên dải một dòng ra sao? Nút chuyển ảnh ở ảnh đầu / cuối: ẩn hay disable? n = 1 hiển thị "1 ảnh"? Thông báo "Bạn **chỉ nên** gửi tối đa 25 ảnh/ lần" (`CR:84`) là lời khuyên trong khi hành vi là chặn cứng — chữ có đúng ý không? | Không trọng yếu |
| 15 | Dẫn chiếu treo | AC-45 "phím gửi theo thiết lập hiện tại" (`CR:273`); G003 chỉ ghi "Nhấn Enter hoặc click icon gửi" (`G003:83`) | Có thiết lập phím gửi (Enter / Ctrl+Enter) không? Nếu có, nằm ở đâu | Không trọng yếu |
| 16 | Thiếu / dẫn chiếu sai (hành chính) | ID N/A (`CR:5`); header không ghi version; Change Log v1.0.1 ghi đổi "AC-46" (`CR:286`) nhưng dòng đổi là AC-45 (`CR:273`), AC-46 không đổi (`CR:274`); "theo thiết kế" (`CR:207`, `CR:209`, `CR:218`) trỏ Figma | Mã CR để trace; Change Log dẫn nhầm AC; QA cần quyền xem Figma node 35-2 để kiểm bố cục cụm ảnh / dải mô tả / khoảng cách | Không trọng yếu |
| 17 | Mơ hồ (đơn vị đếm) — mới ở v1.0.2 | BR-08 "tối đa **2000 bytes**, tính cả khoảng trắng và ký tự xuống dòng… đã đủ 2000 bytes, không cho nhập thêm **ký tự**" (`CR:89`); §6.2 (`CR:173`); AC-09 "nhập đủ 2000 bytes" (`CR:237`); Change Log "giới hạn **ký tự** mô tả ảnh: Max 2000 bytes" (`CR:287`) | Đếm **byte** theo bảng mã nào (UTF-8: chữ Việt có dấu 2–3 bytes, emoji 4 bytes; UTF-16: 2 bytes/ký tự)? Còn 1 byte mà ký tự kế tiếp cần 2–3 bytes → từ chối cả ký tự? Xuống dòng tính 1 hay 2 bytes? Đây có phải trần caption của Zalo? Người dùng không nhìn thấy byte — có bộ đếm không? | **Trọng yếu** (ranh giới AC-09 và cách dựng dữ liệu) |

## 10. Tự rà soát

- [x] Mọi mã BR-01…BR-22, AC-01…AC-46, CR-01/02 tìm thấy trong CR bằng grep (dòng 71-72, 80-101, 227-272); mã G003 / G008 / G009 / G036 / CR-004 / ESC tìm thấy đúng dòng đã dẫn.
- [x] Không mục `[NGUỒN]` nào thiếu tham chiếu.
- [x] Mâu thuẫn giữa nguồn liệt kê đủ hai phía: #2 (cụm ảnh ↔ G036 OOS01), #3 (CR bỏ tổng 25 MB ↔ G003 BR05 / E05), #4 (chặn khi dán ↔ khi gửi).
- [x] Mục 9 không chứa câu trả lời do AI tự chọn; diễn giải để ở mục 8 với nhãn riêng.
- [x] Số liệu: 22 BR, 2 CR-xx, 46 AC, 6 UC (QA đánh), 17 điểm chưa rõ — #1 đã đóng theo v1.0.1; còn mở 16: 5 đề xuất trọng yếu (#2, #3, #4, #5, #17), 11 không — đếm lại từ bảng.
- [x] Mọi `CR:n` đã dịch sang số dòng bản (3).md (dòng ≥55 lệch +2 so với bản (1)); kiểm xác suất ở BR-03 (84), BR-08 (89), AC-25 (253), AC-45 (273), Change Log (286-287).
- [ ] Figma chưa mở — ghi rõ ở mục 1.

## Lịch sử cập nhật

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
| 2026-10-20 | AI (Requirement Analyst) | Tạo bản đầu từ CR bản (1) (284 dòng) + G003 v1.11, G008 v1.1, G009 v1.12, G036 v1.0, CR-004, tài liệu ESC. 22 BR gốc, 46 AC, 16 điểm chưa rõ (đề xuất 5 trọng yếu: #1 số ảnh tối đa, #2 cụm ảnh, #3 ranh giới 25 MB, #4 ảnh lỗi khi dán, #5 nội dung dài + một ảnh) |
| 2026-10-21 | AI (Requirement Analyst) — Hồng chuyển bản (3) | Cập nhật theo CR v1.0.1 + v1.0.2 (20/10/2026): dịch mọi `CR:n` sang bản (3).md; BR-01/BR-03/BR-16 bỏ tổng 25 MB → tối đa 25 ảnh, thông báo mới; BR-08/§6.2/AC-09 → 2000 bytes; AC-25→28, AC-45 viết lại; đóng #1; viết lại #3; thêm #17 (đơn vị bytes); bổ sung #9 (iv), #14, #16; §8 thêm #11, #12 |
