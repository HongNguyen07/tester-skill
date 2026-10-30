---
featureId: G033
title: Màn Link nhóm — mời người vào nhóm bằng mã QR hoặc link
analyzedAt: 2026-10-19
analyst: Requirement Analyst (AI) — người dùng: Hồng (QA)
---

# Requirement Analysis — G033: Màn Link nhóm — mời bằng QR hoặc link

Viết tắt tham chiếu: `G033` = `tailieu/G033 - Màn Link nhóm (1).md`; `G008`, `G026`, `G011`, `G003`, `G001` = file tương
ứng trong `tailieu/`. Số sau dấu `:` là số dòng.

## 1. Nguồn và phạm vi đã đọc

| # | Tệp | Version ghi trong tệp | Phạm vi đã đọc | Ghi chú |
| ---: | --- | --- | --- | --- |
| 1 | `G033 - Màn Link nhóm (1).md` | 1.0 · Status **Draft** · Last updated 2026-10-02 · Owner Trân (BA) | Toàn bộ (601 dòng) | Nguồn chính. Spec thuần nghiệp vụ, §8/§9 `N/A` (`G033:231`) |
| 2 | `G008 - Quản lý nhóm.md` | 1.1 · Draft · 2026-06-26 | Actor (25–26), precondition (42–44), UC-05 (149), AF01 (238–244), E05 (268), BR02 (287), BR05/BR05b/BR06 (290–292), BR15 (300), BR20–BR22 (305–307), §10C (381–399), AC (455) | Tìm theo từ khoá. **Không có BR25** — BR cao nhất là BR22 |
| 3 | `G026 - Cài đặt nhóm (1).md` | 1.0 · 2026-08-17 | §1 (19, 23), UC-04 (68–69), UC-06 (88–97), BR01–BR08 (128–136), AC (175–181), OOS01 (193) | |
| 4 | `G011 - Panel Thông tin.md` | 1.1 · 2026-08-04 | BR02 (130), mục "không thuộc panel phải" (224), phụ thuộc (38, 238) | **Không có BR02b**, không có cụm "nhóm dòng chức năng", không nhắc G033 |
| 5 | `G003 - Chat.md` | 1.11 | UC-08 (201–218), BR10 (306), BR19–BR27 (315–323), bảng hiển thị tin (456–458), §10F bảng (523–527), §10G (531–542), AC-BR21/23/27 (623–634) | |
| 6 | `G001-lien-ket-tai-khoan-zalo.md` | — | BR01–BR04, BR07 (137–141), §7 trạng thái (147–164) | Trạng thái gọi là **Đang hoạt động / Ngắt kết nối**; G033 dùng CONNECTED / DISCONNECTED |
| 7 | `wiki/qa/features/G036/02-alignment-summary.md` | — | Q-01 (dòng 40) | BA Trân đã trả lời 2026-10-13: hệ thống **có phó nhóm**, lấy theo G036 — dùng làm căn cứ `[ĐÃ XÁC NHẬN]` ở feature khác |

Chưa đọc / ngoài phạm vi: G015 (thẻ xem trước link), G016 / G018 (chỉ bị G033 loại trừ ở OOS07), G002, phần còn lại của
G008, G026, G011, G003, G001. Không có file nào định nghĩa các mã dùng chung **BR-C06 / BR-C07 / BR-C12** trong `tailieu/`
(chỉ được dẫn ở nhiều spec; `PROJECT_KNOWLEDGE §5` được nhắc ở CR-001, CR-005 nhưng không có trong thư mục).

## 2. Mục tiêu và phạm vi feature `[NGUỒN]`

Một màn hiển thị **mã QR và link tham gia nhóm** để mời người ngoài vào nhóm; mở từ dòng **Link nhóm** trên panel thông tin
nhóm hoặc nút **Mời qua link** trong màn Thêm thành viên (`G033:19`, `G033:38`). Bản chất Zalo-native: dùng đúng link nhóm có
sẵn của G008 BR15, QR chỉ là cách mã hoá link đó (`G033:23`). Nhóm chưa có link → màn vẫn mở, có nút **Tạo ngay**; đổi / huỷ
link trong menu `•••` có hộp xác nhận (`G033:24-25`). Nền tảng Web · Android · iOS, hành vi đồng nhất (`G033:34`).

## 3. Actor, precondition, trigger

| Mục | Nội dung | Nguồn | Nhãn |
| --- | --- | --- | --- |
| Actor | **Admin / Owner** · **Nhân sự quản lý** có quyền "Quản lý nhóm" | `G033:32`, `G033:47` | `[NGUỒN]` |
| Precondition 1 | Người dùng là Admin hoặc có quyền quản lý nhóm (BR04) | `G033:47` | `[NGUỒN]` |
| Precondition 2 | Đang mở một **hội thoại nhóm** còn tồn tại | `G033:48` | `[NGUỒN]` |
| Precondition 3 | Tài khoản Zalo của nhóm đang **CONNECTED** (BR11) | `G033:49` | `[NGUỒN]` |
| Trigger 1 | Bấm dòng **Link nhóm** trên panel thông tin nhóm | `G033:44`, `G033:241` | `[NGUỒN]` |
| Trigger 2 | Bấm nút **Mời qua link** trong màn *Thêm thành viên* (G008) | `G033:44`, `G033:242` | `[NGUỒN]` |
| Post-condition | Người dùng có link hoặc ảnh QR; **không thay đổi gì** của nhóm, trừ ba thao tác chủ động: tạo (BR16), đổi, huỷ (BR17) | `G033:51` | `[NGUỒN]` |
| Người quét / bấm link | Không phải actor của Gopany — dùng app Zalo, đi luồng tham gia của G026 (BR10) | `G033:27`, `G033:192` | `[NGUỒN]` |

## 4. Use case và luồng

| Mã | Tên | Luồng (sát nguyên văn) | Nguồn |
| --- | --- | --- | --- |
| UC-01 | Mở màn Link nhóm và sao chép link | Bấm dòng Link nhóm / nút Mời qua link → mở màn §10B (avatar + tên nhóm · câu hướng dẫn · QR · link chữ · 3 nút) → nếu bật duyệt / đủ thành viên thì hiện dòng nhắc (BR08, BR09) → bấm **Sao chép link** → clipboard + toast *"Đã copy link nhóm"* | `G033:57-63` |
| UC-02 | Chia sẻ link vào hội thoại | Bấm **Chia sẻ link** → màn §10D dùng lại hộp chọn hội thoại của G003 UC-08, kèm thẻ xem trước + dòng tin nhắn mặc định *"Truy cập link để tham gia nhóm"* → chọn 1..99 hội thoại, sửa dòng chữ nếu muốn → **Gửi** → mỗi hội thoại nhận **một tin nhắn** gồm dòng chữ kèm và link → toast *"Đã gửi link nhóm"* | `G033:67-72` |
| UC-03 | Lưu mã QR | Bấm **Lưu mã QR** → tải PNG, tên `QR - {tên nhóm}.png` | `G033:76-79` |
| UC-04 | Tạo link cho nhóm chưa có link | Màn §10F (hai icon QR + link, câu *"Mời bất kỳ ai vào nhóm mà không cần kết bạn"*, nút **Tạo ngay**) → bấm Tạo ngay, **không hộp xác nhận** → chờ Zalo → Zalo trả link → màn **đổi tại chỗ** sang §10B, toast *"Tạo link thành công"* | `G033:83-88` |
| UC-05 | Đổi link nhóm | `•••` → **Đổi link nhóm** → hộp xác nhận *"Đổi link nhóm?"* + *"Link cũ sẽ không dùng được nữa. Người đã nhận link cũ phải xin link mới."* → bấm **Đổi link** → chờ Zalo → link mới + QR mới, toast *"Đã đổi link nhóm"*; link cũ chết ngay | `G033:92-98` |
| UC-06 | Huỷ link nhóm | `•••` → **Huỷ link nhóm** → hộp xác nhận *"Huỷ link nhóm?"* + *"Link hiện tại sẽ không dùng được nữa. Muốn mời bằng link thì phải tạo link mới."* → bấm **Huỷ link** → chờ Zalo → màn về §10F, toast *"Đã huỷ link nhóm"* | `G033:102-108` |
| AF01 | Đóng màn | ← / ✕ / `Esc` → về panel thông tin nhóm, không thay đổi gì | `G033:152` |
| AF02 | Nhóm đang bật duyệt thành viên | Dưới link hiện dòng nhắc BR08; ba thao tác vẫn dùng bình thường | `G033:153` |
| AF03 | Nhóm đã đủ số thành viên tối đa | Cảnh báo *"Nhóm đã đủ {số} thành viên — người mới chưa vào được"*, `{số}` theo loại tài khoản Zalo *(cá nhân: 100 · Business: cao hơn)*; màn vẫn mở, vẫn lấy được link/QR | `G033:154` |
| AF05 | Nhóm chưa có link mời | Màn §10F; muốn có link → UC-04; không thì đóng màn | `G033:155` |
| AF06 | Mở từ nút *Mời qua link* | Mở đúng màn này, không copy clipboard; mọi luật G033 áp dụng; **đóng → về lại màn Thêm thành viên** | `G033:156` |
| AF07 | Huỷ hộp xác nhận đổi / huỷ | Huỷ / ✕ / `Esc` → đóng hộp, link giữ nguyên, màn không đổi | `G033:157` |
| AF08 | Nhóm chưa có link, mở từ *Mời qua link* | Vẫn ra màn Tạo ngay; tạo xong đóng → về lại màn Thêm thành viên | `G033:158` |

Tài liệu **không có AF04** và **không có BR12** (nhảy số, không phải dẫn chiếu treo — không chỗ nào dẫn tới hai mã này).

Luồng ngoại lệ (`G033:164-173`):

| Mã | Trigger | Phản hồi (nguyên văn rút gọn) | Nguồn |
| --- | --- | --- | --- |
| E01 | Không có quyền | **Ẩn hoàn toàn** dòng Link nhóm (BR-C06); gọi API thẳng → từ chối; ghi log truy cập trái phép | `G033:166` |
| E02 | Tài khoản Zalo DISCONNECTED (UC-01 b1) | Toast *"Tài khoản Zalo đang ngắt kết nối. Vui lòng kết nối lại"* — **không mở màn** | `G033:167` |
| E03 | Zalo không trả được link hoặc QR (UC-01 b2) | Màn mở, vùng QR/link hiện *"Không lấy được link nhóm. Vui lòng thử lại."* + nút **Thử lại**; ba nút **disable** | `G033:168` |
| E04 | Nhóm đã giải tán / đã rời nhóm (UC-01 b2) | Toast *"Nhóm không còn tồn tại"*; đóng màn, panel tải lại | `G033:169` |
| E05 | Mất mạng (mọi bước) | Toast *"Mất kết nối, vui lòng thử lại"*; giữ nguyên màn | `G033:170` |
| E06 | Lỗi hệ thống 500 (mọi bước) | Toast *"Lỗi hệ thống. Vui lòng thử lại sau"* | `G033:171` |
| E07 | Tải ảnh QR thất bại (UC-03 b2) | Toast *"Không tải được mã QR. Vui lòng thử lại."*; màn giữ nguyên | `G033:172` |
| E08 | Zalo từ chối tạo / đổi / huỷ (UC-04 b3 · UC-05 b4 · UC-06 b4) — người bấm không phải trưởng / phó nhóm trên Zalo, hoặc Zalo chặn vì lý do khác | Toast *"Không tạo được link nhóm…"* / *"Không đổi được link nhóm…"* / *"Không huỷ được link nhóm…"* + đuôi *"Vui lòng kiểm tra lại trên app Zalo"*; màn giữ nguyên trạng thái trước; bấm lại được; log **kèm nguyên văn mã lỗi Zalo** | `G033:173` |

## 5. Business rule

| Mã | Nội dung (sát nguyên văn) | Loại | Nguồn | Nhãn |
| --- | --- | --- | --- | --- |
| BR01 | **Hai lối vào, cùng một màn**: ❶ dòng *Link nhóm* trên panel (G033 tự khai — dẫn G011 BR02b); ❷ nút *Mời qua link* trong màn Thêm thành viên (G008 BR15). Cả hai **mở màn**, không copy clipboard. Đóng màn → **về đúng chỗ vừa đi ra** | Nghiệp vụ | `G033:183` | `[NGUỒN]` |
| BR02 | **QR chứa đúng link nhóm**, không sinh đường tham gia thứ hai; link đổi thì QR đổi. Zalo trả ảnh QR → dùng nguyên (kể cả logo Zalo); hệ thống tự sinh → **mã trơn, không logo** (gắn OQ01) | Nghiệp vụ / dữ liệu | `G033:184` | `[NGUỒN]` |
| BR03 | Dùng **đúng link có sẵn** (G008 BR15); hệ thống **không tự tạo, không tự đổi, không tự huỷ**; mở màn nhiều lần vẫn ra link cũ; chỉ đổi khi người dùng bấm Tạo ngay / Đổi / Huỷ | Dữ liệu | `G033:185` | `[NGUỒN]` |
| BR04 | **Quyền Gopany quyết ai THẤY dòng Link nhóm**: Admin hoặc quyền "Quản lý nhóm" (G008 BR06); không quyền → **ẩn hoàn toàn** (BR-C06). **Vai trò Zalo không phải điều kiện** của Gopany; Zalo từ chối trả link → E03 | Quyền | `G033:186` | `[NGUỒN]` |
| BR05 | Thao tác đổi theo trạng thái: ❶ **đã có link** → 3 nút *Sao chép · Chia sẻ · Lưu mã QR* + menu `•••` (Đổi / Huỷ); ❷ **chưa có link** → không có 3 nút, không `•••`, chỉ **Tạo ngay**. Ngoài đó **không thêm gì** | Nghiệp vụ | `G033:187` | `[NGUỒN]` |
| BR06 | *Chia sẻ link* → hộp chọn hội thoại của **G003 UC-08, giữ nguyên mọi luật**: tối đa 99 (G003 BR27) · chỉ hội thoại có quyền xem (BR23) · nhóm "chỉ trưởng nhóm được nhắn tin" hiện nhưng disable (BR21). Bộ lọc tài khoản Zalo **mặc định = tài khoản đang quản lý nhóm**, **đổi được** sang tài khoản khác có quyền; link gửi từ tài khoản nào cũng dùng được | Nghiệp vụ / quyền | `G033:188` | `[NGUỒN]` |
| BR07 | *Lưu mã QR* → PNG, tên `QR - {tên nhóm}.png` | Nghiệp vụ | `G033:189` | `[NGUỒN]` |
| BR08 | Nhóm bật duyệt thành viên (G026) → dưới link hiện *"Nhóm đang bật duyệt thành viên — người tham gia sẽ chờ trưởng nhóm duyệt"*; tắt → không hiện | Nghiệp vụ | `G033:190` | `[NGUỒN]` |
| BR09 | Nhóm đủ thành viên tối đa → cảnh báo *"Nhóm đã đủ {số} thành viên — người mới chưa vào được"*; màn vẫn mở, vẫn lấy được link/QR. `{số}` = giá trị Zalo trả về cho từng nhóm (`maxMember`), **không ghi cứng** | Nghiệp vụ / dữ liệu | `G033:191` | `[NGUỒN]` |
| BR10 | Người quét QR / bấm link **không vào nhóm ngay**; app Zalo mở **màn xem trước nhóm** (avatar · tên · số thành viên · "Nhóm của {chủ nhóm}" · "Đã tạo … trước" · bạn chung) + nút **Tham gia** → rồi đi luồng G026 (chờ duyệt / vào thẳng). Màn xem trước **do Zalo dựng**, G033 không can thiệp (OOS03) | Nghiệp vụ (ngoài Gopany) | `G033:192` | `[NGUỒN]` |
| BR11 | Tài khoản Zalo DISCONNECTED → không mở được màn (E02); nhất quán BR-C07 | Nghiệp vụ | `G033:193` | `[NGUỒN]` |
| BR13 | Nền tảng đồng nhất Web · Android · iOS. Mobile: màn toàn trang, nút ←; Web: popup giữa màn, nút ✕. Hai điểm được khác: Chia sẻ link (cả hai mở danh sách hội thoại trong hệ thống), Lưu mã QR (Web → thư mục tải về; điện thoại → thư viện ảnh) | Nghiệp vụ | `G033:194` | `[NGUỒN]` |
| BR14 | Màn chia sẻ có **thẻ xem trước** (avatar + tên nhóm + link) và **dòng tin nhắn kèm** mặc định *"Truy cập link để tham gia nhóm"*, sửa được. **Tin gửi đi ở dạng thẻ xem trước**. Dòng chữ không chứa link → Zalo tự nối link vào cuối; xoá trắng → người nhận chỉ thấy link | Nghiệp vụ | `G033:195` | `[NGUỒN]` |
| BR15 | Nhóm chưa có link → màn §10F (hai icon, câu mời, nút Tạo ngay); **không** QR, link, ba nút, `•••`. Là **trạng thái bình thường, không phải lỗi**: không dùng E03, không nút Thử lại, không ba nút mờ. Không bao giờ tự tạo link khi mở màn | Nghiệp vụ | `G033:196` | `[NGUỒN]` |
| BR16 | *Tạo ngay* → gọi Zalo luôn, **không hộp xác nhận**; Zalo trả link → đổi tại chỗ sang §10B + toast *"Tạo link thành công"*; Zalo từ chối → không đổi gì, E08. Ai bấm được = ai thấy dòng Link nhóm (BR04); Gopany không thêm điều kiện vai trò Zalo. Trên Zalo chỉ trưởng / phó nhóm đổi được cài đặt (dẫn G008 BR25) → thành viên thường bị Zalo từ chối → E08 | Nghiệp vụ / quyền | `G033:197` | `[NGUỒN]` |
| BR17 | *Đổi link · Huỷ link* trong `•••`, chỉ khi đã có link. Đổi → link mới + QR mới, toast *"Đã đổi link nhóm"*; Huỷ → về §10F, toast *"Đã huỷ link nhóm"*. **Cả hai bắt buộc qua hộp xác nhận** nêu hậu quả, có nút Huỷ (AF07). Ghi lên Zalo xong mới đổi màn; Zalo từ chối → E08. Điều kiện người bấm giống BR16. **Link cũ chết ngay**; không báo người giữ link cũ, không lưu link cũ | Nghiệp vụ / dữ liệu | `G033:198` | `[NGUỒN]` |

Mã do QA tự đánh: không có — tài liệu đã đánh mã đầy đủ.

Rule liên quan ở spec khác (căn cứ cho kỳ vọng nhánh dùng lại):

| Mã | Nội dung | Nguồn | Nhãn |
| --- | --- | --- | --- |
| G008 BR15 | *Mời qua link* (AF01, UC-05): hệ thống tự tạo link nhóm có sẵn; click → **copy vào clipboard** → toast *"Đã copy link nhóm"*; người nhận click link → vào nhóm | `G008:300`, `G008:241-244` | `[NGUỒN]` — **hành vi cũ**, G033 nói đã đổi (xem mục 9 #1) |
| G008 §10C | Dòng **Link nhóm** trên panel: "Hiển thị link mời nhóm để copy và gửi" — quyền Admin + có quyền | `G008:395` | `[NGUỒN]` |
| G008 BR02 | Tối đa **100 thành viên** với Zalo cá nhân; Zalo Business có thể vượt 100 (cần xác nhận con số) | `G008:287` | `[NGUỒN]` |
| G008 BR05 / BR06 | Chỉ Admin + nhân viên có quyền "Quản lý nhóm" được tạo nhóm, thêm thành viên; không có quyền → nút quản lý bị ẩn | `G008:290`, `G008:292` | `[NGUỒN]` |
| G008 BR05b | Sửa tên / avatar nhóm cần thêm điều kiện **là trưởng nhóm hoặc phó nhóm** (Zalo có thể khoá) | `G008:291` | `[NGUỒN]` — gần nhất với "G008 BR25" mà G033 dẫn |
| G026 BR01 / OOS01 | Gopany **KHÔNG có "phó nhóm"**; mọi chỗ Zalo ghi "trưởng và phó nhóm" → "trưởng nhóm" | `G026:128`, `G026:193` | `[NGUỒN]` |
| G026 BR02 | **Chỉ trưởng nhóm** được thay đổi cài đặt nhóm & quyền | `G026:129` | `[NGUỒN]` |
| G026 BR04 / BR08 | Duyệt thành viên BẬT → người vào qua link vào **danh sách chờ duyệt**, chỉ trưởng nhóm Duyệt / Từ chối; TẮT → vào thẳng | `G026:131-132` | `[NGUỒN]` |
| G026 BR05 / BR06 | Quyền (5) *gửi tin nhắn* = "Chỉ trưởng nhóm" → ô nhập của thành viên disable, nhất quán G003 BR21 | `G026:133`, `G026:135` | `[NGUỒN]` |
| G003 UC-08 | Popup Chuyển tiếp: filter tài khoản Zalo (mặc định tài khoản hội thoại nguồn), filter tag, ô tìm kiếm, danh sách hội thoại có quyền xem; nhóm "Chỉ trưởng/phó nhóm được nhắn tin" disable; chọn tối đa 99; Gửi → toast *"Đã chuyển tiếp"*, popup đóng | `G003:201-213` | `[NGUỒN]` |
| G003 BR21 | Nhóm có cài đặt **"Chỉ trưởng/phó nhóm được nhắn tin"** → hiện nhưng disable | `G003:317` | `[NGUỒN]` |
| G003 BR23 | Popup chỉ hiện hội thoại **cùng một tài khoản Zalo** đang chọn; **không forward cross-account**; filter mặc định theo tài khoản nguồn | `G003:319`; AC `G003:623-624` | `[NGUỒN]` |
| G003 BR27 / §10G | Tối đa 99 hội thoại; chạm 99 → chặn + nhắc *"Tối đa 99 hội thoại"*; bộ đếm *"Đã chọn X/99"*; nút **"Gửi (X)"**, disable khi chưa chọn; nhóm disable theo BR21 không tính vào bộ đếm | `G003:323`, `G003:538-542` | `[NGUỒN]` |
| G001 | Trạng thái tài khoản Zalo: **Đang hoạt động** ↔ **Ngắt kết nối**; Ngắt kết nối → không thực thi hành động qua tài khoản đó (BR03) | `G001:140`, `G001:151-157` | `[NGUỒN]` |

## 6. Acceptance criteria, mã lỗi, thông báo, giới hạn số

AC trong `G033:414-495`, nhóm theo BR (nguyên văn rút gọn):

| Nhóm | AC | Nguồn |
| --- | --- | --- |
| Lối vào & quyền | Hai lối vào mở màn, không copy clipboard; đóng về đúng chỗ; cùng một link / QR; Admin + có quyền thấy dòng; **phó nhóm** thấy dòng và lấy được link; không quyền → không thấy, API thẳng bị từ chối + log; DISCONNECTED → toast, không mở màn | `G033:417-424` |
| Nội dung màn | Đủ thành phần §10B; quét QR ra đúng link; tự sinh → không logo, Zalo trả → giữ nguyên; mở nhiều lần vẫn cùng link | `G033:427-430` |
| Ba thao tác | Sao chép → clipboard + toast; Chia sẻ → hộp chọn, gửi vào từng hội thoại; 99 → chặn; nhóm chặn nhắn tin → disable; filter mặc định tài khoản quản lý nhóm, đổi được; thẻ xem trước đúng nhóm; dòng tin mặc định sửa được; tin gửi dạng thẻ; sửa / xoá trắng → nhận đúng; Lưu QR → PNG đúng tên; đã có link → 3 nút + `•••`, không Tạo ngay | `G033:433-445` |
| Chưa có link — tạo | Màn §10F đúng thành phần, không có gì khác, không lỗi / Thử lại; không tự tạo; Tạo ngay không hộp xác nhận; đổi tại chỗ + toast; vào từ Mời qua link → về lại Thêm thành viên; chờ Zalo → không bấm lần hai; Zalo từ chối → E08, giữ màn trống, log mã lỗi; trưởng + phó nhóm tạo được | `G033:448-457` |
| Đổi · Huỷ | `•••` đúng hai mục; chưa có link → không `•••`; hộp xác nhận đúng câu, không đổi ngay; đổi → link + QR đổi tại chỗ, QR mới ra link mới; link cũ không vào được; huỷ → về §10F, tạo lại được ngay; Huỷ / ✕ / Esc → giữ nguyên; Zalo từ chối → E08 đúng việc; mở nhiều lần không tự đổi / huỷ; **đổi / huỷ trên app Zalo khi màn đang mở → cập nhật ngay** (BR-C12) | `G033:460-470` |
| Dòng nhắc | Bật duyệt → dòng nhắc, 3 nút vẫn dùng; tắt → không; đủ thành viên → cảnh báo, vẫn lấy được link; số lấy từ Zalo, không ghi cứng; cả hai → hai dòng, cảnh báo đầy ở trên | `G033:473-477` |
| Luồng tham gia | App Zalo mở màn xem trước + Tham gia; tắt duyệt → vào ngay; bật → hàng chờ G026; Gopany không dựng màn đó; link và QR cho kết quả giống nhau | `G033:480-484` |
| Nền tảng | Web popup ~420px; ✕ / Esc / click nền mờ đóng; không chênh lệch hành vi | `G033:487-488` |
| Ngoại lệ | E03 vùng QR + Thử lại, 3 nút disable; E04 toast + đóng; E05 toast + giữ màn; **E06 khi mở màn → toast, màn giữ nguyên, bấm Thử lại được**; E07 toast + giữ màn | `G033:491-495` |

Thông báo (nguyên văn): *"Đã copy link nhóm"* (`G033:63`) · *"Đã gửi link nhóm"* (`G033:72`) · *"Tạo link thành công"* (`G033:88`) ·
*"Đã đổi link nhóm"* (`G033:98`) · *"Đã huỷ link nhóm"* (`G033:108`) · các toast E02–E08 (`G033:167-173`) · câu hướng dẫn *"Mời mọi
người tham gia nhóm bằng mã QR hoặc link dưới đây:"* (`G033:272`) · câu mời *"Mời bất kỳ ai vào nhóm mà không cần kết bạn"*
(`G033:355`) · hộp xác nhận (`G033:383-401`) · dòng nhắc §10C (`G033:283-284`).

Giới hạn số: tối đa **99** hội thoại (`G033:70`, G003 BR27) · popup Web ~**420px** (`G033:326`) · `{số}` thành viên tối đa theo
Zalo (`G033:191`) · hiệu năng: mở màn ≤ 2 giây, > 10 giây → E03; tải QR ≤ 3 giây; hộp chọn ≤ 1 giây (`G033:550-553`).

Mã lỗi API: không có (§8/§9 `N/A`, `G033:231`). Log E08 phải kèm **nguyên văn mã lỗi Zalo** (`G033:173`).

## 7. Trạng thái và chuyển trạng thái `[NGUỒN]` (`G033:204-223`)

Theo **link mời của nhóm** (màn chỉ phản ánh):

| Từ | Sự kiện | Sang | Nguồn |
| --- | --- | --- | --- |
| (khởi tạo) | Nhóm chưa có link mời | CHƯA CÓ LINK | `G033:208` |
| (khởi tạo) | Nhóm đã có link mời | CÓ LINK | `G033:209` |
| CHƯA CÓ LINK | Tạo ngay, Zalo trả link (UC-04) | CÓ LINK | `G033:210` |
| CHƯA CÓ LINK | Zalo từ chối (E08) | CHƯA CÓ LINK | `G033:211` |
| CÓ LINK | Đổi link nhóm — link cũ chết (UC-05) | CÓ LINK (chuỗi link + QR mới) | `G033:212`, `G033:223` |
| CÓ LINK | Huỷ link nhóm (UC-06) | CHƯA CÓ LINK | `G033:213` |

Màn theo trạng thái: CHƯA CÓ LINK = §10F; CÓ LINK = §10B + `•••` (`G033:220-221`). Mọi chuyển trạng thái do người dùng bấm;
đổi trên app Zalo trong lúc màn mở → màn cập nhật ngay (`G033:223`). Trạng thái người tham gia (chờ duyệt → thành viên) thuộc
G026 (`G033:225`). Không có trạng thái "link bị tắt" — chưa đo (OQ05, `G033:542`).

## 8. Diễn giải, giả định, QA observation

| # | Nội dung | Nhãn | Liên quan tới |
| ---: | --- | --- | --- |
| 1 | G033 là tài liệu mới hơn (2026-10-02) và Changelog ghi rõ "kéo theo G008 BR15 → v1.9"; G008 trong `tailieu/` là v1.1 chưa có thay đổi đó. Đọc hai tài liệu cùng nhau thì hành vi nút *Mời qua link* theo G033 | `[DIỄN GIẢI AI]` | BR01, AF06, mục 9 #1 |
| 2 | "G008 BR25" mà G033 dẫn cho "trưởng nhóm và phó nhóm đổi được cài đặt nhóm" gần nhất với G008 BR05b (sửa tên / avatar cần là trưởng / phó nhóm) | `[DIỄN GIẢI AI]` | BR16, E08, mục 9 #3 |
| 3 | Vì BR04 / BR16 nói Gopany **không chặn theo vai trò Zalo**, kết quả phía Gopany cho phó nhóm hay thành viên thường là như nhau; khác nhau chỉ ở việc Zalo có từ chối (E08) hay không — là hành vi của Zalo, QA chỉ **đo & ghi** | `[DIỄN GIẢI AI]` | BR04, BR16, AC `G033:422`, `G033:457`, mục 9 #2 |
| 4 | BA đã trả lời ở G036 Q-01 (2026-10-13) rằng hệ thống **có phó nhóm** (theo G036, G026 chưa cập nhật). Câu trả lời đó là về hiển thị khung chat, chưa phải câu trả lời cho G033 | `[ĐÃ XÁC NHẬN]` ở G036 — với G033 là `[CẦN XÁC NHẬN]` | Mục 9 #2 |
| 5 | AC `G033:470` (đổi / huỷ trên app Zalo → màn cập nhật ngay) chỉ kiểm được khi có app Zalo đăng nhập tài khoản trưởng nhóm của nhóm test | `[QA BỔ SUNG]` | BR-C12 |
| 6 | AC nhóm "Luồng tham gia" (`G033:480-484`) kiểm trên **app Zalo của người nhận**, không phải trên Gopany; cần một tài khoản Zalo ngoài nhóm trên điện thoại | `[QA BỔ SUNG]` | BR10 |
| 7 | Tên nhóm chứa ký tự cấm trong tên file (`/ \ : * ? " < > \|`) hoặc rất dài → tên file `QR - {tên nhóm}.png` ra sao; tài liệu không nói | `[QA BỔ SUNG]` | BR07, mục 9 #17 |
| 8 | Kiểm BR03 (mở màn nhiều lần vẫn cùng link) và BR09 cần biết link / `maxMember` thật mà Zalo trả cho nhóm test — cần Dev hoặc app Zalo để đối chiếu | `[QA BỔ SUNG]` | BR03, BR09 |
| 9 | Precondition "đang mở một hội thoại nhóm": Admin không phải thành viên nhóm có mở được hội thoại nhóm không thuộc G003 / G008, không phải điểm chưa rõ của G033 | `[QA BỔ SUNG]` | Precondition 2 |
| 10 | G001 gọi trạng thái là "Đang hoạt động / Ngắt kết nối"; G033 dùng CONNECTED / DISCONNECTED — cùng một trạng thái, chỉ khác cách gọi | `[DIỄN GIẢI AI]` | BR11, E02 |

## 9. Điểm chưa rõ (chuyển sang Debate)

| # | Loại | Trích dẫn + nguồn | Vì sao chưa rõ | Đề xuất mức |
| ---: | --- | --- | --- | --- |
| 1 | Mâu thuẫn giữa spec | `G033:38`, `G033:183`, `G033:563`: nút *Mời qua link* nay **mở màn** (G008 BR15 v1.9). `G008:300`, `G008:241-242`, `G008:395`, `G008:455` (v1.1): click → **copy clipboard** + toast *"Đã copy link nhóm"* | G008 trong `tailieu/` chưa có v1.9; hai tài liệu mô tả hai hành vi cho cùng một nút | **Không trọng yếu** — G033 là tài liệu chủ quản và mới hơn, Changelog nêu rõ thay đổi; test theo G033; ghi chú BA cập nhật G008 BR15, AF01, §10C, AC |
| 2 | Mâu thuẫn giữa spec | `G033:422` "Phó nhóm thấy dòng Link nhóm…"; `G033:457` "Trưởng nhóm và phó nhóm tạo được link"; `G033:173`, `G033:197` "trưởng nhóm hoặc phó nhóm". `G026:128`, `G026:193` "KHÔNG có phó nhóm"; `G026:129` "Chỉ trưởng nhóm được thay đổi cài đặt nhóm". `G003:317` chuỗi "Chỉ trưởng/phó nhóm được nhắn tin" vs `G033:188` "chỉ trưởng nhóm được nhắn tin" | Có vai phó nhóm hay không; phó nhóm có được Zalo cho tạo / đổi / huỷ link không; chuỗi cài đặt chặn nhắn tin ghi thế nào | **Không trọng yếu** (đề xuất) — Gopany không chặn theo vai Zalo (BR04, BR16) nên kết quả phía Gopany không đổi; chỉ ảnh hưởng dữ liệu test và một AC (`G033:457`) về hành vi Zalo → ĐO & GHI. BA đã trả lời "có phó nhóm" ở G036 Q-01 |
| 3 | Dẫn chiếu treo | `G033:183`, `G033:522` dẫn **G011 BR02b** "nhóm dòng chức năng" — G011 v1.1 chỉ có BR02 (`G011:130`, panel 2 tab), không có BR02b; `G011:224` ghi "Thêm thành viên · Rời nhóm" không thuộc panel phải. `G033:197`, `G033:520` dẫn **G008 BR25** — G008 v1.1 không có BR25 (cao nhất BR22, `G008:305-307`) | Hai mã không tồn tại trong bản hiện hành; dòng *Link nhóm* nằm trong panel nào (G008 §10C `G008:395` hay G011) | **Không trọng yếu** — case chỉ kiểm "có dòng Link nhóm trên panel thông tin nhóm"; ghi chú BA sửa dẫn chiếu |
| 4 | Nhiều cách hiểu | `G033:188` bộ lọc tài khoản Zalo "đổi được sang tài khoản khác người dùng có quyền — link gửi đi từ tài khoản nào cũng dùng được"; `G003:319` BR23 "không forward cross-account", nhưng AC `G003:623` cho đổi filter | Đổi filter sang tài khoản B rồi gửi link vào hội thoại của B có đúng "giữ nguyên mọi luật G003 UC-08" không | **Không trọng yếu** — G033 nói rõ cho phép; ghi chú BA về chữ "cross-account" ở G003 BR23 |
| 5 | Thiếu — chờ Dev (OQ01) | `G033:184`, `G033:273`, `G033:429`, `G033:538`: Zalo trả ảnh QR (có logo) hay hệ thống tự sinh (mã trơn) | Kỳ vọng về logo trên QR phụ thuộc nhánh được build; tài liệu chốt sẵn cả hai | **Không trọng yếu** — case BR02 viết hai nhánh, chọn theo câu trả lời Dev |
| 6 | Thiếu — chờ Dev (OQ04) | `G033:541`, `G033:561`: hub thiếu API tạo / đổi / huỷ → ẩn đúng thao tác đó | Toàn bộ UC-04 / UC-05 / UC-06 và `•••` có được build không; tài liệu chốt sẵn mọi nhánh | **Không trọng yếu** (đề xuất, người dùng chốt) — case UC-04/05/06 ghi điều kiện "khi hub có API"; cần Dev báo nhánh build để chốt phạm vi chạy |
| 7 | Thiếu — chờ Dev (OQ02) | `G033:186`, `G033:539`: chưa biết Zalo có chặn thành viên thường xem link không → nếu chặn thì E03 | Tài khoản Zalo quản lý nhóm chỉ là thành viên thường mở màn → kỳ vọng §10B hay E03 | **Không trọng yếu** — một case ĐO & GHI |
| 8 | Thiếu — chờ Dev / BA đo (OQ03, OQ05) | `G033:540`: link có hạn dùng (`expirationDate`) không; `G033:542`: có trạng thái "tắt link mời" không | Chưa có luật cho link hết hạn, cho trạng thái thứ ba | **Không trọng yếu** — không viết case; ghi ngoài phạm vi tới khi có luật |
| 9 | Thiếu | `G033:166`, `G033:423` "Gọi API thẳng → từ chối, ghi log"; `G033:231` §8/§9 `N/A` | Không có endpoint để kiểm | **Không trọng yếu** — case API chờ Dev cung cấp endpoint |
| 10 | Mâu thuẫn nội bộ | `G033:154` AF03 ghi "(cá nhân: 100 · Business: cao hơn)", `G008:287` "100"; `G033:191`, `G033:476` "không ghi cứng ở bất kỳ đâu", lấy `maxMember` Zalo trả | Chữ trong AF03 trái BR09; QA cần cách biết `maxMember` của nhóm test | **Không trọng yếu** — kỳ vọng theo BR09; hỏi Dev cách lấy `maxMember` |
| 11 | Mâu thuẫn nội bộ | `G033:171` E06 (mọi bước): chỉ toast *"Lỗi hệ thống. Vui lòng thử lại sau"*; `G033:494` AC-E06 "khi mở màn → toast, màn giữ nguyên, **bấm Thử lại được**" — nút Thử lại chỉ có ở E03 (`G033:168`). `G033:170` E05 "giữ nguyên màn"; không nói nút *Tạo ngay* / *Đổi link* đang xử lý (`G033:358`, `G033:408`) trở lại thế nào khi mất mạng / 500 | 500 lúc mở màn thì màn có mở không, Thử lại ở đâu; mất mạng lúc nút đang xử lý thì nút về trạng thái nào | **Không trọng yếu** — hai case đánh ❓ |
| 12 | Mơ hồ | `G033:173` toast E08: *"Không tạo được link nhóm…"* + đuôi *"Vui lòng kiểm tra lại trên app Zalo"* | Phần giữa "…" chưa có chuỗi đầy đủ | **Không trọng yếu** — case kiểm đầu + đuôi |
| 13 | Thiếu | `G033:195`: "Dòng chữ kèm không chứa link thì Zalo tự nối link vào cuối"; `G033:441` tin gửi dạng thẻ | Dòng chữ **có chứa** một link (khác hoặc chính link nhóm) thì gửi ra sao; thẻ xem trước hiện thế nào trong khung chat Gopany (G015?) | **Không trọng yếu** — QA bổ sung, ĐO & GHI |
| 14 | Thiếu | `G033:72` Gửi → toast *"Đã gửi link nhóm"*; `G003:213` UC-08 "popup đóng lại" | Sau Gửi, màn chia sẻ có đóng không, có về lại màn Link nhóm không; gửi lỗi một phần (E05/E06) thì toast nào | **Không trọng yếu** — một case ❓ |
| 15 | Thiếu | `G033:156`, `G033:326`: Web mở popup giữa màn; màn *Thêm thành viên* của G008 (`G008:390`) cũng là giao diện riêng | Trên Web, popup Link nhóm mở chồng lên Thêm thành viên hay thay thế; đóng về lại Thêm thành viên ở trạng thái nào | **Không trọng yếu** — hình thức; một case ❓ |
| 16 | Thiếu | `G033:550-553` §15: ≤ 2 s, > 10 s → E03, ≤ 3 s, ≤ 1 s | Là tiêu chí đạt hay tham khảo (tiền lệ G036 Q-06) | **Không trọng yếu** — ĐO & GHI |
| 17 | Thiếu | `G033:189` tên file `QR - {tên nhóm}.png`; `G033:194` mobile lưu thư viện ảnh | Tên nhóm có ký tự cấm / rất dài; trên mobile tên ảnh có theo quy tắc này không | **Không trọng yếu** — QA bổ sung |
| 18 | Trạng thái tài liệu | `G033:12` Status **Draft**; `G033:538` OQ01 "chặn build" | Dùng bản Draft (và khi OQ01 chưa chốt) làm căn cứ viết test case không | Người dùng chốt |

## 10. Tự rà soát

- [x] Mọi mã ở mục 4–6 tìm thấy trong nguồn bằng Grep (UC-01..06, AF01..03/05..08, E01..08, BR01..11/13..17, OQ01..05, OOS01..08)
- [x] Không mục `[NGUỒN]` nào thiếu tham chiếu
- [x] Mâu thuẫn giữa nguồn đã liệt kê đủ hai phía (#1 G033 ↔ G008; #2 G033 ↔ G026 / G003; #4 G033 ↔ G003)
- [x] Mục 9 không chứa câu trả lời do AI tự chọn — nhận định của AI nằm ở mục 8, có nhãn
- Giới hạn: G008, G026, G011, G003, G001 đọc theo từ khoá; G015, G016, G018, G002 chưa đọc; không có file định nghĩa BR-C06 / C07 / C12

## Lịch sử cập nhật

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
| 2026-10-19 | AI (Requirement Analyst) | Tạo bản đầu: 6 UC, 7 AF, 8 E, 16 BR, 5 OQ; 18 điểm chưa rõ, AI đề xuất không có điểm trọng yếu (#2, #6 cần người dùng chốt) |
