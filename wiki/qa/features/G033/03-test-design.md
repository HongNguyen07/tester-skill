---
featureId: G033
basedOn: 02-alignment-summary.md (gate: open, 2026-10-19)
designedAt: 2026-10-19
---

# Test Design — G033: Màn Link nhóm — mời bằng QR hoặc link

Quy ước: `G033:NN` = dòng NN của `tailieu/G033 - Màn Link nhóm (1).md` (v1.0 Draft, 2026-10-02); `G003:NN`, `G008:NN`, `G026:NN`, `G001:NN` tương tự.
`D-nn` = dòng trong mục 4 của `02-alignment-summary.md`; `Q-nn` = câu hỏi mục 3 của file đó. Mã case `[G033_NN]` nằm ở `04-testcases.md`.
Ba nền tảng Web · Android · iOS; **Round 1 chạy Web**, mobile sau (D-14). Chuỗi hiển thị kỳ vọng đúng nguyên văn tài liệu, riêng "Huỷ"/"Hủy" chấp nhận (D-21).

## 1. Use Case

| Mã | Tên | Actor | Nguồn |
| --- | --- | --- | --- |
| UC-01 | Mở màn Link nhóm và sao chép link | Admin / nhân sự có quyền "Quản lý nhóm" | `G033:57-63` `[NGUỒN]` |
| UC-02 | Chia sẻ link vào một hội thoại (hộp chọn G003 UC-08) | Admin / nhân sự có quyền | `G033:67-72` `[NGUỒN]`; `[ĐÃ XÁC NHẬN]` Q-04: chỉ gửi trong tài khoản Zalo đang quản lý nhóm |
| UC-03 | Lưu mã QR (PNG) | Admin / nhân sự có quyền | `G033:76-79` `[NGUỒN]` |
| UC-04 | Tạo link cho nhóm chưa có link (*Tạo ngay*) | Admin / nhân sự có quyền | `G033:83-88` `[NGUỒN]`; điều kiện hub có API — Q-06 |
| UC-05 | Đổi link nhóm (`•••` → hộp xác nhận) | Admin / nhân sự có quyền | `G033:92-98` `[NGUỒN]`; Q-06 |
| UC-06 | Huỷ link nhóm (`•••` → hộp xác nhận) | Admin / nhân sự có quyền | `G033:102-108` `[NGUỒN]`; Q-06 |
| AF01 / AF06 / AF08 | Đóng màn về đúng chỗ vừa đi ra; lối vào *Mời qua link* | — | `G033:152`, `G033:156`, `G033:158` `[NGUỒN]`; `[ĐÃ XÁC NHẬN]` Q-01 |
| AF02 / AF03 / AF05 / AF07 | Dòng nhắc duyệt · nhóm đầy · màn chưa có link · huỷ hộp xác nhận | — | `G033:153-157` `[NGUỒN]`; AF03 không chạy (D-13) |
| E01 – E08 | Ngoại lệ | — | `G033:166-173` `[NGUỒN]` |
| (ngoài Gopany) | Người nhận quét QR / bấm link → màn xem trước Zalo → *Tham gia* → luồng G026 | Người nhận (app Zalo) | `G033:192`, `G033:480-484` `[NGUỒN]`; kiểm phía Gopany theo D-05 |

Tài liệu không có AF04 và BR12 (nhảy số — `01-requirement-analysis.md` mục 4).

## 2. Business Rule

| Mã | Tóm tắt | Trạng thái hiểu | Nguồn |
| --- | --- | --- | --- |
| BR01 | Hai lối vào (dòng *Link nhóm* trên panel · nút *Mời qua link* trong Thêm thành viên) cùng mở một màn, không copy clipboard; đóng về đúng chỗ vừa đi ra | `[ĐÃ XÁC NHẬN]` Q-01 (nút *Mời qua link* mở màn; G008 v1.1 còn ghi copy — bỏ qua), Q-03 (dòng thuộc panel G008 §10C) | `G033:183`, `G033:38`, `G008:395` |
| BR02 | QR chứa đúng link nhóm, không sinh đường tham gia thứ hai; link đổi thì QR đổi; hình thức mã theo nguồn cấp (Zalo trả → có logo; tự sinh → trơn) | `[NGUỒN]`; nhánh logo còn mở Q-05 (OQ01) | `G033:184`, `G033:273`, `G033:429` |
| BR03 | Dùng đúng link có sẵn của nhóm; hệ thống không tự tạo / đổi / huỷ; mỗi lần mở màn ra đúng link cũ | `[NGUỒN]`; mốc đối chiếu = link trên app Zalo (D-02) | `G033:185`, `G033:430`, `G033:469` |
| BR04 | Quyền Gopany (Admin / "Quản lý nhóm") quyết ai thấy dòng; không quyền → ẩn hoàn toàn; vai Zalo không phải điều kiện; Zalo từ chối → E03 | `[NGUỒN]` + `[ĐÃ XÁC NHẬN]` Q-02 (chỉ có trưởng nhóm — AC "phó nhóm" `G033:422`, `G033:457` không áp dụng); còn mở Q-07 (OQ02), Q-09 (endpoint) | `G033:186`, `G033:166`, `G008:292` |
| BR05 | Có link → ba nút *Sao chép link · Chia sẻ link · Lưu mã QR* + `•••`; chưa có link → chỉ *Tạo ngay*, không có ba nút (kể cả mờ), không `•••` | `[NGUỒN]`; D-03 (không có ≠ mờ; mờ là E03) | `G033:187`, `G033:357`, `G033:445`, `G033:449` |
| BR06 | Chia sẻ link dùng hộp chọn G003 UC-08, giữ nguyên luật (99 hội thoại BR27 · quyền xem BR23 · nhóm chặn nhắn tin disable BR21) | `[ĐÃ XÁC NHẬN]` Q-04: **chỉ gửi trong tài khoản Zalo đang quản lý nhóm, không đổi sang tài khoản khác** (khác chữ `G033:188`, AC `G033:438`); còn mở Q-20 (bộ lọc khoá hay ẩn), Q-21 (trưởng nhóm của nhóm đích đang chặn), Q-14 (sau Gửi) | `G033:188`, `G033:316-320`, `G003:317`, `G003:319`, `G003:323`, `G003:538-542` |
| BR07 | Lưu mã QR → PNG `QR - {tên nhóm}.png`; Web vào thư mục tải về, mobile vào thư viện ảnh | `[NGUỒN]`; D-12; còn mở Q-17 (ký tự cấm trong tên) | `G033:189`, `G033:194`, `G033:444` |
| BR08 | Nhóm bật duyệt thành viên → dòng nhắc nguyên văn ngay dưới link; tắt → không hiện | `[NGUỒN]`; D-04 (chưa có link → không dòng nhắc) | `G033:190`, `G033:283`, `G033:473-474` |
| BR09 | Nhóm đủ thành viên tối đa → cảnh báo với `{số}` = `maxMember` Zalo trả; màn vẫn mở, vẫn lấy được link/QR | `[NGUỒN]`; **Không chạy — quyết định QA 2026-10-19 (D-13)**; Q-10 chữ AF03 "100" chỉ ghi chú BA | `G033:191`, `G033:154`, `G033:284-285`, `G033:475-477` |
| BR10 | Người quét / bấm link → app Zalo mở màn xem trước + *Tham gia* → chờ duyệt (G026 bật) hoặc vào thẳng | `[NGUỒN]`; kiểm trên app Zalo người nhận, kết quả trên Gopany theo D-05 | `G033:192`, `G033:480-484`, `G026:90-93`, `G026:131` |
| BR11 | Tài khoản Zalo DISCONNECTED → không mở màn, toast E02 | `[NGUỒN]`; D-06 (áp cho cả hai lối vào) | `G033:193`, `G033:167`, `G033:424` |
| BR13 | Hành vi, chuỗi, giới hạn đồng nhất ba nền tảng; Web popup ~420px có ✕, mobile toàn trang có ← | `[NGUỒN]`; D-14 (ưu tiên Web); Q-15 (popup chồng lên Thêm thành viên) | `G033:194`, `G033:326-330`, `G033:487-488` |
| BR14 | Màn chia sẻ có thẻ xem trước (avatar + tên nhóm + link) và dòng tin kèm mặc định sửa được; tin gửi dạng thẻ; xoá trắng → người nhận chỉ thấy link | `[NGUỒN]`; D-15 (kiểm trên app Zalo người nhận; khung chat Gopany → Q-13) | `G033:195`, `G033:318-322`, `G033:439-443` |
| BR15 | Chưa có link → màn §10F (hai icon, câu mời, *Tạo ngay*); không phải lỗi, không E03 / Thử lại / nút mờ; không bao giờ tự tạo link | `[NGUỒN]`; D-07 (mở lại nhiều lần + đối chiếu app Zalo) | `G033:196`, `G033:352-361`, `G033:448-451` |
| BR16 | *Tạo ngay* → gọi Zalo luôn, không hộp xác nhận; ghi Zalo xong mới đổi màn + toast "Tạo link thành công"; Zalo từ chối → E08, màn giữ nguyên | `[ĐÃ XÁC NHẬN]` Q-02 (chỉ trưởng nhóm; nhánh "thành viên thường bị Zalo từ chối" giữ nguyên); D-16; còn mở Q-06, Q-12 | `G033:197`, `G033:356-359`, `G033:452-456` |
| BR17 | Đổi / Huỷ trong `•••`, bắt buộc hộp xác nhận nêu hậu quả, có nút Huỷ; ghi Zalo xong mới đổi màn; link cũ chết ngay | `[NGUỒN]`; D-17 (lưu link + QR cũ, kiểm ngay sau toast), D-20 (Esc chỉ đóng hộp xác nhận); còn mở Q-06, Q-12 | `G033:198`, `G033:376-410`, `G033:460-468` |
| §7 (BR-C12) | Link đổi / huỷ / tạo trên app Zalo trong lúc màn đang mở → màn cập nhật ngay | `[NGUỒN]`; không có file định nghĩa BR-C12 — chỉ dùng nội dung G033 | `G033:223`, `G033:470` |

Luật dùng lại từ spec khác (căn cứ kỳ vọng nhánh G003 trong BR06): G003 BR21 `G003:317`, BR23 `G003:319`, BR25 `G003:321`, BR27 `G003:323`, §10G `G003:538-542`. Chuỗi cài đặt chặn nhắn tin theo G026 BR01/BR05: "Chỉ trưởng nhóm" (`G026:128`, `G026:133`) — `[ĐÃ XÁC NHẬN]` Q-02.

## 3. Decision Table

**DT-1 — Thành phần màn theo trạng thái link và kết quả Zalo (BR05, BR15, E03)** `[NGUỒN]` `G033:187`, `G033:196`, `G033:168`, `G033:357`

| Điều kiện / Hành động | R1 | R2 | R3 |
| --- | --- | --- | --- |
| C1: Nhóm đã có link mời | Có | Không | Có |
| C2: Zalo trả được link / QR | Có | — | Không |
| → Màn | §10B: avatar + tên · câu hướng dẫn · QR · link chữ · ba nút · `•••` | §10F: hai icon · câu mời · *Tạo ngay*; không ba nút (kể cả mờ), không `•••`, không avatar/tên | Màn mở, vùng QR/link: *"Không lấy được link nhóm. Vui lòng thử lại."* + **Thử lại**; ba nút **disable** |
| → Case | [G033_18] [G033_19] | [G033_59] [G033_60] | [G033_83] |

**DT-2 — Dòng nhắc §10C (BR08, BR09, D-04)** `[NGUỒN]` `G033:279-286`, `G033:357`

| Điều kiện / Hành động | R1 | R2 | R3 | R4 | R5 |
| --- | --- | --- | --- | --- | --- |
| C1: Nhóm đã có link | Có | Có | Có | Có | Không |
| C2: Bật duyệt thành viên (G026) | Không | Có | Không | Có | Có |
| C3: Đủ số thành viên tối đa | Không | Không | Có | Có | — |
| → Dòng nhắc ngay dưới link | Không hiện gì | 1 dòng *"Nhóm đang bật duyệt thành viên — người tham gia sẽ chờ trưởng nhóm duyệt"* | 1 dòng ⚠️ *"Nhóm đã đủ {số} thành viên — người mới chưa vào được"* | Cả hai, cảnh báo nhóm đầy **trên** | Không dòng nhắc (§10F "không có gì khác") |
| → Case | [G033_42] | [G033_41] | [G033_44] (không chạy) | [G033_45] (không chạy) | [G033_43] |

**DT-3 — Lối vào theo quyền và trạng thái tài khoản Zalo (BR04, BR11, E01, E02)** `[NGUỒN]` `G033:186`, `G033:193`, `G033:166-167`; `[ĐÃ XÁC NHẬN]` Q-02 (không có phó nhóm)

| Điều kiện / Hành động | R1 | R2 | R3 | R4 |
| --- | --- | --- | --- | --- |
| C1: Người dùng là Admin hoặc có quyền "Quản lý nhóm" | Có | Có | Không | Có |
| C2: Tài khoản Zalo của nhóm CONNECTED | Có | Không | — | Có |
| C3: Vai của tài khoản Zalo trong nhóm | Trưởng nhóm | Trưởng nhóm | — | Thành viên thường |
| → Dòng *Link nhóm* trên panel | Hiện | Hiện | **Ẩn hoàn toàn** (E01) | Hiện (vai Zalo không phải điều kiện) |
| → Bấm | Mở màn | Toast *"Tài khoản Zalo đang ngắt kết nối. Vui lòng kết nối lại"*, không mở màn (E02) | — | Mở màn; §10B hay E03 → Chờ Q-07 |
| → Case | [G033_13] [G033_14] | [G033_49] [G033_50] | [G033_15] | [G033_17] ❓ |

**DT-4 — Hội thoại đích trong hộp chọn (BR06, G003 BR21/BR23/BR27, Q-04, Q-21)** `[NGUỒN]` `G033:188`, `G003:317`, `G003:319`, `G003:323`; `[ĐÃ XÁC NHẬN]` Q-04

| Điều kiện / Hành động | R1 | R2 | R3 | R4 | R5 |
| --- | --- | --- | --- | --- | --- |
| C1: Hội thoại thuộc tài khoản Zalo đang quản lý nhóm (ZA) | Có | Có | Có | Không (thuộc ZB) | Có |
| C2: Người dùng có quyền xem hội thoại | Có | Có | Không | — | Có |
| C3: Nhóm đích bật "Chỉ trưởng nhóm" được nhắn tin | Không | Có (ZA không phải trưởng nhóm) | — | — | Có (ZA là trưởng nhóm) |
| C4: Đã chọn 99 hội thoại | Không | — | — | — | — |
| → Hội thoại trong danh sách | Hiện, tích được | Hiện nhưng **mờ, không tích được**, không tính bộ đếm | Không hiện | Không gửi được vào (Q-04) | Chờ Q-21 |
| → Case | [G033_24] [G033_25] | [G033_27] | [G033_31] | [G033_30] | [G033_28] ❓ |

Biên 99: [G033_26] (chạm 99 → chặn chọn thêm, nhắc *"Tối đa 99 hội thoại"* — G003 BR27).

**DT-5 — Tạo / Đổi / Huỷ theo phản hồi Zalo (BR16, BR17, E08, AF07)** `[NGUỒN]` `G033:197-198`, `G033:173`, `G033:157`

| Điều kiện / Hành động | R1 | R2 | R3 | R4 | R5 | R6 |
| --- | --- | --- | --- | --- | --- | --- |
| C1: Thao tác | Tạo ngay | Tạo ngay | Đổi link | Đổi link | Huỷ link | Đổi / Huỷ |
| C2: Hộp xác nhận | Không có | Không có | Có — bấm *Đổi link* | Có — bấm *Đổi link* | Có — bấm *Huỷ link* | Có — bấm *Huỷ* / ✕ / Esc |
| C3: Zalo chấp nhận | Có | Không | Có | Không | Có | — |
| → Màn | §10F → §10B tại chỗ, toast *"Tạo link thành công"* | Giữ §10F, toast E08 "Không tạo được link nhóm…", bấm lại được | Link + QR mới tại chỗ, toast *"Đã đổi link nhóm"*, link cũ chết ngay | Giữ nguyên link cũ, toast E08 "Không đổi được link nhóm…" | §10B → §10F, toast *"Đã huỷ link nhóm"*, link cũ chết ngay | Đóng hộp, link giữ nguyên, màn không đổi |
| → Case | [G033_63] [G033_64] | [G033_66] | [G033_70] [G033_71] | [G033_77] | [G033_73] [G033_74] | [G033_75] [G033_76] |

## 4. State Transition

Trạng thái của **link mời của nhóm** (màn chỉ phản ánh) — `[NGUỒN]` `G033:204-223`:

| Từ | Sự kiện | Sang | Màn kỳ vọng | Nguồn | Case |
| --- | --- | --- | --- | --- | --- |
| (khởi tạo) | Nhóm chưa có link | CHƯA CÓ LINK | §10F | `G033:208`, `G033:220` | [G033_59] |
| (khởi tạo) | Nhóm đã có link | CÓ LINK | §10B + `•••` | `G033:209`, `G033:221` | [G033_18] [G033_19] |
| CHƯA CÓ LINK | *Tạo ngay*, Zalo trả link (UC-04) | CÓ LINK | §10B tại chỗ + toast | `G033:210` | [G033_64] |
| CHƯA CÓ LINK | Zalo từ chối (E08) | CHƯA CÓ LINK | Giữ §10F | `G033:211` | [G033_66] |
| CÓ LINK | *Đổi link nhóm* (UC-05) | CÓ LINK (chuỗi link + QR mới) | Link + QR mới tại chỗ | `G033:212`, `G033:223` | [G033_70] [G033_71] |
| CÓ LINK | *Huỷ link nhóm* (UC-06) | CHƯA CÓ LINK | §10F | `G033:213` | [G033_73] |
| CÓ LINK | Zalo từ chối đổi / huỷ (E08) | CÓ LINK (không đổi) | Giữ nguyên | `G033:198` | [G033_77] [G033_78] |
| Bất kỳ | Huỷ hộp xác nhận (AF07) | Không đổi | Không đổi | `G033:157` | [G033_75] [G033_76] |
| CÓ LINK / CHƯA CÓ LINK | Trạng thái đổi **trên app Zalo** khi màn đang mở | Theo Zalo | Cập nhật ngay, không tải lại | `G033:223`, `G033:470` | [G033_80] [G033_81] [G033_82] |

Không có trạng thái "link bị tắt" / "link hết hạn" (OQ03, OQ05 — Q-08): không viết case.

## 5. Risk Analysis `[QA BỔ SUNG]`

| # | Rủi ro | Impact | Likelihood | Căn cứ | Liên quan BR / Q |
| ---: | --- | --- | --- | --- | --- |
| 1 | QR không cùng vòng đời với link (QR giải mã ra chuỗi khác, hoặc QR cũ vẫn vào được sau khi đổi / huỷ) → đường tham gia thứ hai, không thu hồi được | Cao | Chưa có dữ liệu | Tài liệu gọi BR02 là "quan trọng nhất" (`G033:580`); OQ01 chưa chốt nguồn QR (`G033:538`) | BR02, BR17, Q-05 — [G033_07] [G033_71] [G033_74] |
| 2 | Link cũ không chết ngay sau đổi / huỷ (độ trễ phía hub) → người giữ link cũ vẫn vào được | Cao | Chưa có dữ liệu | BR17 "chết ngay" (`G033:198`); D-17 kiểm ngay sau toast | BR17 — [G033_71] [G033_74] |
| 3 | Màn đổi sang §10B trước khi Zalo xác nhận → người dùng copy link Zalo chưa cấp | Cao | Chưa có dữ liệu | `G033:587` nhấn mạnh "đừng đổi màn trước"; không có API contract (`G033:231`) | BR16, BR17 — [G033_63] [G033_64] [G033_70] |
| 4 | Gửi link từ tài khoản Zalo khác (ZB) vào hội thoại của ZB — trái câu trả lời BA Q-04, lộ nội dung giữa kênh (G003 BR23) | Trung bình | Trung bình — chữ `G033:188` và AC `G033:438` vẫn ghi "đổi được", Dev có thể làm theo chữ | `[ĐÃ XÁC NHẬN]` Q-04; `G003:319` | BR06, Q-04, Q-20 — [G033_29] [G033_30] |
| 5 | Build theo nhánh OQ04 thiếu API → thao tác bị ẩn, bộ case UC-04/05/06 không chạy được | Trung bình | Chưa có dữ liệu | `G033:541`, `G033:561` | Q-06 — [G033_62] [G033_79] |
| 6 | Hồi quy G008: nút *Mời qua link* vẫn copy clipboard như v1.1 (Dev chưa cập nhật) | Trung bình | Trung bình — G008 trong `tailieu/` chưa lên v1.9 | `[ĐÃ XÁC NHẬN]` Q-01; `G008:242`, `G008:300` | BR01 — [G033_02] |
| 7 | Lộ dòng *Link nhóm* cho nhân sự không quyền (ẩn chỉ ở UI, API không chặn) | Cao | Chưa có dữ liệu | E01 (`G033:166`), không có endpoint (Q-09) | BR04, E01 — [G033_15] [G033_16] |
| 8 | Đồng bộ realtime từ app Zalo (BR-C12) không chạy → màn hiện link đã chết | Trung bình | Chưa có dữ liệu | `G033:223`; không có file định nghĩa BR-C12 | §7 — [G033_80] [G033_81] [G033_82] |
| 9 | Chuỗi hiển thị lệch tài liệu (thiếu dấu "—", thiếu dấu chấm, sai tên nút) — tài liệu yêu cầu "chép đúng chuỗi Zalo" | Thấp | Trung bình — nhiều chuỗi, hai tài liệu G033 / G003 lệch nhau ở bộ đếm | `G033:272`, `G033:355`, `G033:316` vs `G003:538`; D-21 | §10B–§10G — [G033_18] [G033_23] [G033_69] [G033_72] |
| 10 | Tên file PNG lỗi với tên nhóm có ký tự cấm / emoji → không lưu được | Thấp | Chưa có dữ liệu | Tài liệu không nói (Q-17) | BR07 — [G033_95] [G033_96] |

## 6. Coverage Matrix

Trạng thái theo rule 07 §2: Đã phủ = có ≥ 1 case nhóm A không `❓`; Phủ một phần = một phần case `❓` hoặc thiếu nhánh; Chưa phủ = chỉ case `❓` hoặc không có case. Case nhóm B không tính.

| BR / AC | Use Case | Decision / State | Scenario | Case nhóm A | Trạng thái | Ghi chú |
| --- | --- | --- | --- | --- | --- | --- |
| BR01 · AC `G033:417-420`, AF01, AF06, AF08 | UC-01, UC-04 | DT-3 | SC-01 | [G033_01] [G033_02] [G033_03] [G033_04] [G033_05] [G033_06] | Đã phủ | Q-15 (hình thức popup Web chồng lên Thêm thành viên) → nhóm B [G033_91] |
| BR02 · AC `G033:428-429`, `G033:463`, `G033:484` | UC-01, UC-05 | DT-5, ST | SC-02 | [G033_07] [G033_09] [G033_70] [G033_71]; ❓ [G033_08] | Phủ một phần | Nhánh logo QR chờ Q-05 (OQ01 chặn build) |
| BR03 · AC `G033:430`, `G033:451`, `G033:469` | UC-01, UC-04 | ST | SC-03 | [G033_10] [G033_11] [G033_12] [G033_20] | Đã phủ | Mốc đối chiếu = link trên app Zalo (D-02) |
| BR04 · AC `G033:421-423`, E01 | UC-01 | DT-3 | SC-04 | [G033_13] [G033_14] [G033_15]; ❓ [G033_16] [G033_17] | Phủ một phần | AC `G033:422` "phó nhóm" không áp dụng (`[ĐÃ XÁC NHẬN]` Q-02). API thẳng chờ Q-09; thành viên thường chờ Q-07. Log → Dev xác nhận (D-18) |
| BR05 · AC `G033:427`, `G033:433`, `G033:445`, `G033:449` | UC-01 | DT-1 | SC-02, SC-05 | [G033_18] [G033_19] [G033_20] [G033_21] [G033_59] | Đã phủ | — |
| BR06 · AC `G033:434-438` | UC-02 | DT-4 | SC-06 | [G033_22] [G033_24] [G033_25] [G033_26] [G033_27] [G033_30] [G033_31] [G033_32] [G033_33] [G033_35]; ❓ [G033_23] [G033_28] [G033_29] [G033_34] | Phủ một phần | AC `G033:438` "đổi được bộ lọc" **không áp dụng** — `[ĐÃ XÁC NHẬN]` Q-04 (case [G033_30] kiểm ngược). Hình thức bộ lọc Q-20; trưởng nhóm của nhóm đích Q-21; sau Gửi Q-14; chuỗi bộ đếm → mục 11 #1 |
| BR07 · AC `G033:444`, E07 | UC-03 | — | SC-08 | [G033_36] [G033_37] [G033_38] [G033_39]; ❓ [G033_40] | Phủ một phần | Mất mạng khi lưu QR chờ Q-11 (D-22). Ký tự cấm trong tên → nhóm B (Q-17) |
| BR08 · AC `G033:473-474`, AF02 | UC-01 | DT-2 | SC-09 | [G033_41] [G033_42] [G033_43] | Đã phủ | — |
| BR09 · AC `G033:475-477`, AF03, §10C | UC-01 | DT-2 | SC-09 | [G033_44] [G033_45] | Có case — **Không chạy** (quyết định QA 2026-10-19, D-13) | Round 1–3 ghi `NA`; không viết kỳ vọng thay thế. Q-10 chữ AF03 "100" chỉ là ghi chú cho BA |
| BR10 · AC `G033:480-484` | (người nhận) | — | SC-10 | [G033_46] [G033_47] [G033_48] [G033_09] | Đã phủ | Màn xem trước kiểm trên app Zalo của người nhận; kết quả Gopany theo D-05 |
| BR11 · AC `G033:424`, E02 | UC-01 | DT-3 | SC-11 | [G033_49] [G033_50] [G033_51] | Đã phủ | D-06: cả hai lối vào |
| BR13 · AC `G033:487-488`, §10E | Tất cả | — | SC-12 | [G033_52] [G033_53] [G033_54] [G033_38] | Đã phủ | Round 1 Web; Android / iOS chạy sau (D-14) |
| BR14 · AC `G033:439-443` | UC-02 | — | SC-07 | [G033_55] [G033_56] [G033_57] [G033_58] | Đã phủ | Hình dạng thẻ trong khung chat Gopany và dòng tin có chứa link → nhóm B (Q-13) |
| BR15 · AC `G033:448-451`, AF05 | UC-04 | DT-1, ST | SC-13 | [G033_59] [G033_60] [G033_61] [G033_12] [G033_43]; ❓ [G033_62] | Phủ một phần | Nhánh hub thiếu API tạo (`G033:541`) chờ Q-06 |
| BR16 · AC `G033:452-456`, E08 | UC-04 | DT-5, ST | SC-13 | [G033_63] [G033_64] [G033_65] [G033_66]; ❓ [G033_67] | Phủ một phần | AC `G033:457` "trưởng nhóm và phó nhóm" không áp dụng (`[ĐÃ XÁC NHẬN]` Q-02). Chuỗi E08 phần giữa chờ Q-12 |
| BR17 · AC `G033:460-468`, AF07, E08, §10G | UC-05, UC-06 | DT-5, ST | SC-14 | [G033_68] [G033_69] [G033_70] [G033_71] [G033_72] [G033_73] [G033_74] [G033_75] [G033_76] [G033_77] [G033_78]; ❓ [G033_79] [G033_67] | Phủ một phần | Nhánh hub thiếu API đổi / huỷ chờ Q-06; chuỗi E08 chờ Q-12 |
| §7 BR-C12 · AC `G033:470` | — | ST | SC-15 | [G033_80] [G033_81] [G033_82] | Đã phủ | Cần app Zalo đăng nhập trưởng nhóm |
| E01 · AC `G033:423` | UC-01 b1 | DT-3 | SC-04 | [G033_15]; ❓ [G033_16] | Phủ một phần | Endpoint chờ Q-09; log Dev xác nhận |
| E02 · AC `G033:424` | UC-01 b1 | DT-3 | SC-11 | [G033_49] [G033_50] [G033_51] | Đã phủ | — |
| E03 · AC `G033:491` | UC-01 b2 | DT-1 | SC-16 | [G033_83] | Đã phủ | Cách tạo tình huống (chặn request) là kỹ thuật QA; kỳ vọng theo nguồn. >10 s → E03 (§15) → nhóm B |
| E04 · AC `G033:492` | UC-01 b2 | — | SC-16 | [G033_84] [G033_85] | Đã phủ | Chỉ lúc mở màn; nhóm giải tán khi màn đang mở → nhóm B ❓ Q-22 (D-19) |
| E05 · AC `G033:493` | mọi bước | — | SC-16 | [G033_86]; ❓ [G033_87] [G033_88] [G033_40] | Phủ một phần | Khi mở màn, khi nút đang xử lý, khi lưu QR chờ Q-11 |
| E06 · AC `G033:494` | mọi bước | — | SC-16 | [G033_89]; ❓ [G033_90] | Phủ một phần | AC-E06 "bấm Thử lại được" mâu thuẫn bảng E06 → Q-11. Cần Dev giả lập 500 |
| E07 · AC `G033:495` | UC-03 b2 | — | SC-08 | [G033_39] | Đã phủ | — |
| E08 · AC `G033:456`, `G033:468` | UC-04/05/06 | DT-5 | SC-13, SC-14 | [G033_66] [G033_77] [G033_78]; ❓ [G033_67] | Phủ một phần | Kiểm đầu + đuôi toast; phần giữa Q-12. "phó nhóm" không áp dụng (Q-02). Log mã lỗi Zalo → Dev xác nhận |
| AF01 · AC `G033:419`, `G033:487` | UC-01 | — | SC-01, SC-12 | [G033_03] [G033_52] [G033_61] | Đã phủ | — |
| AF07 · AC `G033:467` | UC-05/06 | DT-5 | SC-14 | [G033_75] [G033_76] | Đã phủ | D-20 |

**Lỗ hổng:**

- Requirement không có case chạy được: BR09 / AF03 (không chạy theo D-13); AC `G033:422`, `G033:438`, `G033:457` (không áp dụng theo BA — không viết case theo chữ cũ); OQ03 link hết hạn, OQ05 "tắt link mời" (Q-08 — không có luật).
- Case không có nguồn: không có ở nhóm A. Cách tạo tình huống kỹ thuật (throttling, chặn request, Dev giả lập 500) là `[QA BỔ SUNG]`, kỳ vọng vẫn theo nguồn.
- Coverage chưa rõ: E05 / E06 lúc mở màn và lúc nút đang xử lý (Q-11); hình thức bộ lọc tài khoản (Q-20); nhánh build OQ01 / OQ04 (Q-05, Q-06); endpoint E01 (Q-09).

**Loại coverage đã cân nhắc và không áp dụng:** Performance — §15 có số nhưng Q-16 chưa chốt là tiêu chí, chỉ ĐO & GHI ở nhóm B ([G033_100] [G033_101] [G033_107]); AI-specific — sản phẩm không có tính năng AI; Integration / API — §8/§9 `N/A` (`G033:231`), không có endpoint; Concurrency — chỉ nhóm B ([G033_97] [G033_98]) vì tài liệu không đặt luật.

## 7. Test Scenario

| SC | Mô tả | BR / AC | Use Case | Loại coverage | Nhóm |
| --- | --- | --- | --- | --- | --- |
| SC-01 | Hai lối vào mở cùng một màn, không copy clipboard; đóng về đúng chỗ vừa đi ra; lối *Mời qua link* với nhóm chưa có link | BR01, AF01, AF06, AF08 · AC 417-420, 454 | UC-01, UC-04 | Positive, UI | A |
| SC-02 | Nội dung màn §10B: thành phần, chuỗi nguyên văn, QR giải mã ra đúng link, hình thức QR theo nguồn cấp | BR02, BR05 · AC 427-429, 445 | UC-01 | Positive, UI, Data integrity | A |
| SC-03 | Dùng đúng link có sẵn: trùng app Zalo, mở nhiều lần không đổi, nhóm chưa có link không tự tạo | BR03, BR15 · AC 430, 451, 469 | UC-01 | Positive, Data integrity | A |
| SC-04 | Quyền thấy dòng *Link nhóm*: Admin, quyền "Quản lý nhóm", không quyền (E01), vai Zalo không phải điều kiện | BR04, E01 · AC 421-423 | UC-01 | Permission / security | A |
| SC-05 | Sao chép link vào clipboard + toast | BR05, BR03 · AC 433 | UC-01 | Positive | A |
| SC-06 | Chia sẻ link — hộp chọn hội thoại G003 UC-08: thành phần, chọn 1 / nhiều / 99, nhóm chặn nhắn tin, chỉ tài khoản đang quản lý nhóm, quyền xem, nhóm đã rời | BR06, G003 BR21/23/25/27, §10D · AC 434-438 | UC-02 | Positive, Negative, Boundary, Permission | A |
| SC-07 | Chia sẻ link — thẻ xem trước và dòng tin kèm; tin nhận dạng thẻ; sửa / xoá trắng | BR14 · AC 439-443 | UC-02 | Positive, Data integrity | A |
| SC-08 | Lưu mã QR: PNG đúng tên, quét file ra đúng link, hành vi cuối, mobile lưu thư viện ảnh, E07, mất mạng | BR07, BR13, E07 · AC 444, 495 | UC-03 | Positive, Negative, Compatibility | A |
| SC-09 | Dòng nhắc §10C theo trạng thái nhóm: duyệt thành viên, nhóm đầy (không chạy), chưa có link | BR08, BR09, AF02, AF03 · AC 473-477 | UC-01 | Positive, Negative | A |
| SC-10 | Luồng tham gia phía người nhận: màn xem trước Zalo, *Tham gia*, chờ duyệt / vào thẳng kiểm trên Gopany | BR10 · AC 480-484 | (người nhận) | Integration (Zalo), E2E | A |
| SC-11 | Tài khoản Zalo ngắt kết nối: cả hai lối vào, kết nối lại | BR11, E02 · AC 424 | UC-01 | Negative, Recovery | A |
| SC-12 | Nền tảng: Web popup ~420px và ba cách đóng; Android / iOS toàn trang, nội dung giống Web | BR13, §10E, AF01 · AC 487-488 | Tất cả | UI, Compatibility | A |
| SC-13 | Nhóm chưa có link: màn §10F, không phải lỗi, *Tạo ngay* không hộp xác nhận, chờ Zalo, E08, nhánh thiếu API | BR15, BR16, AF05, E08 · AC 448-456 | UC-04 | Positive, Negative, State | A |
| SC-14 | Đổi / Huỷ link: menu, hộp xác nhận nguyên văn, link + QR cũ chết ngay, AF07, E08, nhánh thiếu API | BR17, BR02, AF07, E08, §10G · AC 460-468 | UC-05, UC-06 | Positive, Negative, State, Data integrity | A |
| SC-15 | Trạng thái link đổi trên app Zalo khi màn đang mở → cập nhật ngay | §7 BR-C12 · AC 470 | — | Data sync | A |
| SC-16 | Ngoại lệ chung: E03 vùng lỗi + Thử lại, E04 nhóm giải tán / rời nhóm, E05 mất mạng, E06 lỗi 500 | E03–E06 · AC 491-494 | UC-01, UC-02 | Exception / recovery | A |
| SC-17 | QA bổ sung: hình thức popup Web (Q-15), dòng tin có link / rất dài (Q-13), tên file với ký tự cấm (Q-17), đồng thời, hiệu năng §15 (Q-16), nhóm giải tán khi đang mở (Q-22), gửi lỗi một phần (Q-14), a11y, hội thoại cá nhân | BR liên quan / `N/A — QA bổ sung` | — | Edge case, Performance, Concurrency, Usability | B |

## 8. Testcase Summary

Đếm bằng script từ `04-testcases.md` (2026-10-19).

| Nhóm | Số case | Positive | Negative | Edge case | Khác (UI / Security / Performance) | Có `❓ Cần chốt` |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| A. Theo requirement | 90 | 49 | 23 | 5 | 13 (UI 10 · Security 3 · Performance 0) | 14 |
| B. QA bổ sung | 19 | 0 | 0 | 14 | 5 (UI 3 · Security 0 · Performance 2) | 10 |

BR đã phủ / tổng BR (16 BR, không có BR12): **8 đã phủ** (BR01, BR03, BR05, BR08, BR10, BR11, BR13, BR14) · **7 phủ một phần** (BR02, BR04, BR06, BR07, BR15, BR16, BR17) · **1 có case nhưng không chạy** (BR09 — D-13) · 0 chưa phủ.

Chi tiết case: `04-testcases.md`.

## 9. Regression Scope

| Khu vực | Vì sao bị ảnh hưởng | Căn cứ | Giới hạn phân tích |
| --- | --- | --- | --- |
| G008 — màn *Thêm thành viên*, nút *Mời qua link* (AF01, BR15, §10C) | Nút đổi hành vi: mở màn G033 thay vì copy clipboard — breaking change | `G033:563`, `G033:530`; `[ĐÃ XÁC NHẬN]` Q-01 | G008 v1.1 trong `tailieu/` chưa cập nhật; chưa đọc toàn bộ G008 — chưa đủ dữ liệu để loại trừ phần khác của Thêm thành viên |
| G008 §10C — panel thông tin nhóm | Thêm / đổi hành vi dòng *Link nhóm* (`G008:395`); quyền hiển thị theo G008 BR06 | `[ĐÃ XÁC NHẬN]` Q-03; `G033:241-243` | Các dòng khác trên panel: chưa đủ dữ liệu để loại trừ |
| G003 UC-08 — popup chuyển tiếp (hộp chọn hội thoại) | G033 dùng lại thành phần này; nếu Dev sửa hộp chọn cho *Chia sẻ link* (bộ lọc tài khoản, thẻ xem trước, dòng tin kèm) thì luồng chuyển tiếp tin nhắn có thể bị ảnh hưởng | `G033:188`, `G033:523`; `G003:201-213` | Chưa có thông tin kỹ thuật về cách dùng lại (component chung hay bản sao) |
| G026 — Duyệt thành viên (UC-06, BR04, BR08) | Người vào qua link / QR của G033 đi vào hàng chờ duyệt; dòng nhắc BR08 đọc cài đặt G026 | `G033:192`, `G033:521`; `G026:90-93` | Chỉ kiểm phần "người nhận xuất hiện ở chờ duyệt / danh sách thành viên" (D-05); thao tác Duyệt / Từ chối thuộc G026 |
| G001 — trạng thái tài khoản Zalo | E02 phụ thuộc trạng thái CONNECTED / "Đang hoạt động"; kết nối lại → mở được | `G033:193`, `G001:151-157` | Không kiểm luồng ngắt / kết nối lại của G001, chỉ dùng làm precondition |
| G011 — Panel Thông tin | G033 dẫn G011 BR02b (không tồn tại trong bản hiện hành) — chưa rõ G011 có phải sửa gì | `G033:522`; Q-03 | Chưa đủ dữ liệu để loại trừ; chờ BA sửa dẫn chiếu |
| G016 / G018 — QR liên kết tài khoản Zalo | Cùng chữ "QR" nhưng OOS07 nói không áp luật cache / tần suất; rủi ro Dev dùng chung module QR | `G033:509`, `G033:592` | Chưa đọc G016 / G018 — chưa đủ dữ liệu để loại trừ |

## 10. Automation Candidate

Trạng thái mặc định `Candidate` — chưa có script.

| Case | Lý do phù hợp | Dependency · data · môi trường | Trạng thái |
| --- | --- | --- | --- |
| [G033_01] [G033_02] [G033_03] [G033_04] | Lối vào / đóng màn ổn định, chạy mỗi build, kiểm được bằng DOM + clipboard API | Web; TK-ADMIN; NH-1 có link; đặt clipboard trước khi thao tác | Candidate |
| [G033_18] [G033_59] [G033_68] | So chuỗi nguyên văn §10B / §10F / `•••` — dễ assert, giá trị regression cao (D-21) | Web; NH-1 (có link) và NH-0 (chưa có link) | Candidate |
| [G033_07] [G033_10] | Giải mã QR từ ảnh trên màn (thư viện đọc QR) và so với link chữ; so với link lấy từ hub / app Zalo | Cần cách lấy link nhóm ngoài màn (API hub — chờ Dev) để làm mốc | Candidate — phụ thuộc Q-09 / hub |
| [G033_15] [G033_49] | Quyền và trạng thái tài khoản: assert phần tử không tồn tại / toast | Tài khoản TK-NV; cách đặt ZA về Ngắt kết nối trên môi trường test | Candidate |
| [G033_26] [G033_33] | Biên 99 hội thoại và nút *Gửi (n)* mờ — thao tác lặp, phù hợp script | Tài khoản ZA có ≥ 100 hội thoại trên môi trường test | Candidate |
| [G033_69] [G033_72] [G033_75] [G033_76] | Hộp xác nhận nguyên văn + AF07 (Huỷ / ✕ / Esc) — không đổi dữ liệu Zalo | Web; NH-1 | Candidate |
| [G033_63] [G033_64] [G033_70] [G033_73] | Tạo / đổi / huỷ — đổi dữ liệu thật trên Zalo, cần nhóm dùng riêng và dọn dữ liệu; chỉ nên tự động khi hub có API (Q-06) | Nhóm test riêng cho automation; app Zalo để đối chiếu không tự động được | Candidate — chưa khuyến nghị tự động ở đợt đầu |

## 11. Điểm cần quay lại Debate

Điểm tài liệu chưa rõ mới phát hiện khi thiết kế, Alignment Summary chưa có — không tự chọn cách hiểu.

| # | Nội dung + nguồn | Đề xuất mức | Case bị ảnh hưởng |
| ---: | --- | --- | --- |
| 1 | Chuỗi bộ đếm trên màn chia sẻ: G033 ghi *"Đã chọn: n"* (`G033:292`, `G033:316`) nhưng dẫn "theo G003 §10G" — G003 ghi *"Đã chọn X/99"* (`G003:538`). Hai chuỗi khác nhau; D-21 yêu cầu đúng nguyên văn tài liệu nên cần chốt chuỗi nào | Không trọng yếu | [G033_23] (❓ Q-23); [G033_22] bỏ chuỗi bộ đếm ra khỏi kỳ vọng |
| 2 | E08 khi người bấm *không phải trưởng nhóm* Zalo: tài liệu nói "để Zalo từ chối" (`G033:197`, `G033:589`). Để dựng nhóm NH-2 (ZA là thành viên thường) **có link** cho case đổi / huỷ ([G033_77] [G033_78]), link phải do trưởng nhóm ZX tạo trên app Zalo — tài liệu không nói ZA (thành viên thường) có **thấy** link đó trên màn G033 không (trùng Q-07). Nếu Zalo chặn xem → rơi E03 và hai case E08 đổi / huỷ không dựng được | Không trọng yếu — gộp vào Q-07 | [G033_17] [G033_77] [G033_78] |
| 3 | AC-E06 `G033:494` "Lỗi hệ thống khi mở màn → toast, màn giữ nguyên, bấm Thử lại được" — khi *mở màn* chưa có màn nào để "giữ nguyên"; chữ "màn giữ nguyên" có thể chỉ panel. Đã nằm trong Q-11 nhưng phần "màn nào giữ nguyên" chưa được nêu | Không trọng yếu — bổ sung vào Q-11 | [G033_90] |
| 4 | Cách tạo tình huống E03 trên môi trường test: tài liệu chỉ nói "Zalo không trả được link hoặc QR" (`G033:168`). Chưa có cách tái hiện chắc chắn ngoài chặn request (kỹ thuật QA) hoặc chờ kết quả Q-07; cần Dev xác nhận cách giả lập | Không trọng yếu — hỏi Dev cùng Q-09 | [G033_83] |

## Lịch sử cập nhật

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
| 2026-10-19 | AI (qa-test-designer) — người dùng: Hồng (QA) | Tạo bản đầu sau cổng mở 2026-10-19: 10 UC/AF, 16 BR + §7, 5 decision table, state transition, 10 rủi ro, Coverage Matrix 26 dòng, 17 scenario (SC-01 → SC-17), regression 7 khu vực, 7 nhóm automation candidate, 4 điểm quay lại Debate |
| 2026-10-19 | AI (Orchestrator) | Mục 11: #1 → Q-23; #2 gộp Q-07; #3 bổ sung Q-11; #4 bổ sung Q-09. Thêm từ CX: Q-24 (`•••` ở E03), Q-25 (dấu hiệu cập nhật realtime), Q-11 (iii) Esc lúc đang xử lý, Q-15 (giữ từ khoá) |
