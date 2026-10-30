---
featureId: CR-005
title: Staff có quyền assign được unassign (gỡ nhân viên khỏi hội thoại)
sourceDoc: tailieu/CR-005 - Staff có quyền assign được unassign.md (89 dòng, ngày nhận 2026-10-06, BA Trân, ưu tiên Cao)
specHienHanh: tailieu/G003 - Chat.md (v1.11, 2026-08-03) — chưa cập nhật theo CR-005. G034, PHÂN QUYỀN - Ma trận tổng hợp, PROJECT_KNOWLEDGE, SỔ THEO DÕI YÊU CẦU — KHÔNG có trong tailieu/
createdBy: QA
createdAt: 2026-10-08
updatedBy: QA
updatedAt: 2026-10-08
phase: 1 — intake & classification (CHƯA có plan / case)
status: high-risk-pending-confirmation
lane: high-risk
---

# INTAKE — CR-005 Staff có quyền assign được unassign

> Phase 1 (qa-intake-classifier). CHƯA viết plan / case.
> Quy ước trích dẫn: `CR:<dòng>` = dòng trong `tailieu/CR-005 - Staff có quyền assign được unassign.md`. `G003:<dòng>` = dòng trong `tailieu/G003 - Chat.md` (741 dòng). `G002:`, `G017:`, `G019:`, `G027:`, `G029:`, `G011a:`, `G014:`, `G024:` tương tự, là file hiện hành trong `tailieu/`.
> **Quy ước project đã áp dụng:** (1) không có `wiki/features/FEAT-*.md`, BR / mục đánh số / luồng / ma trận là AC-source, không trả `blocked-no-ac`; (2) file trong `tailieu/` là bản duy nhất, số version CR dẫn (G003 v1.23 → v1.24, G034 v1.0 → v1.1) chỉ là các lần sửa trực tiếp trên docs; nội dung CR dẫn mà spec hiện hành không có = spec chưa cập nhật / dẫn chiếu treo = câu hỏi cho BA; (3) QA test theo spec hiện hành + delta ghi trong CR; (4) trục truy vết là Business Rule.

## 1. Nguồn và AC-source

- CR-005 đổi một quy tắc đã phát hành của G003: BR15 + UC-07 bước 5 + AC. Phân loại của BA (CR:76): **CR**, "đổi quy tắc đã phát trên G003"; **không migration** (CR:51, CR:78); việc cho Dev: nới điều kiện kiểm quyền thao tác *unassign* ở **cả giao diện lẫn API** + ghi log (CR:78).
- AC-source (B1): CR §2.2 (bảng "Đề nghị đổi thành", 6 dòng, CR:26-32), §2.4 / §2.4b (rà xung đột, lý do giữ "Thay thế chỉ Admin") + AC hiện hành G003:603-604 + BR15 hiện hành G003:311. CR không chép AC Given/When/Then, nhưng BR + luồng đủ để suy ra kỳ vọng cho phần chắc chắn. Không `blocked-no-ac`.
- Trạng thái: CR không ghi trạng thái dev (CR:85 trỏ SỔ THEO DÕI, file không có). Chưa biết build → thực thi chờ build; thiết kế case làm được cho phần không bị chặn.

**Nghĩa của "assign" — đừng lẫn hai nghĩa (G003:735 "Phân quyền 2 cấp: cấp cha = tài khoản Zalo (G002) | cấp con = hội thoại (G003 BR15)"):**

| | Assign cấp CHA (tài khoản Zalo) | Assign cấp CON (hội thoại) |
|---|---|---|
| Là gì | Admin / Staff có quyền "Quản lý tài khoản Zalo" cấp cho Staff quyền xem + gửi trên 1 TK Zalo (G002) | Admin / Staff có quyền **Assign** gán nhân viên phụ trách 1 hội thoại (G003 UC-07, BR14-BR16) |
| Spec | G002; G003 BR02, BR12 ("Staff bị unassign khỏi tài khoản Zalo", G003:308; AC G003:552) | G003 UC-07 (G003:191-197), BR15 (G003:311), AC (G003:602-604) |
| CR-001 dùng nghĩa này | **Có** ("được assign ≥1 tài khoản Zalo CONNECTED") | Không |
| **CR-005 dùng nghĩa này** | Không (chỉ làm phạm vi: "hội thoại người đó được xem theo G002") | **Có** — "unassign" trong CR-005 = bỏ chọn nhân viên trong panel Assign của 1 hội thoại |

Spec hiện hành dùng chữ "unassign" cho cả hai nghĩa (G003:197 vs G003:308 / G003:552; G019:140 "Mất quyền xem (unassign)"; G011a:120 "gỡ gán") → khi viết case luôn ghi "unassign hội thoại" hay "unassign tài khoản".

## 2. Spec CR-005 sửa — đã đọc thật

| Tài liệu CR dẫn | Có trong `tailieu/`? | Ghi chú |
|---|---|---|
| G003 Chat | Có — header v1.11 (G003:11), Last updated 2026-08-03 (G003:13) | CR gọi bản trước CR là v1.23 → sau CR v1.24. Spec hiện hành chưa chứa nội dung CR (ngược lại, vẫn ghi "Staff có quyền assign không thể unassign") |
| G034 v1.0 | **KHÔNG** (tailieu/ chỉ có G001-G033) | Spec của màn gán hàng loạt (kiểu *Thay thế*, 200 hội thoại, BR10/BR12/BR13/OOS06). Xem Q-02 |
| PHÂN QUYỀN — Ma trận tổng hợp | **KHÔNG** | Như INTAKE-CR-001 |
| PROJECT_KNOWLEDGE (§1, §5 BR-C06/BR-C07/C09/C10/C12, §7, glossary) | **KHÔNG** | Mã BR-C06, BR-C12 được dùng ở G003:322, G033:223, G015:99 nên hiểu qua cách dùng, định nghĩa gốc không kiểm được |
| SỔ THEO DÕI YÊU CẦU | **KHÔNG** | Không ảnh hưởng thiết kế test |
| G002 · G003 BR18 (phạm vi) | G002 có (v1.2); G003 có | Xem §3 và Q-03 |

## 3. Baseline "TRƯỚC CR" — hành vi hiện hành về assign / unassign hội thoại

Nguồn G003 v1.11 + các spec phụ thuộc. Chỉ ghi điều spec nói; điều spec không nói ghi riêng.

| Khía cạnh | Quy tắc hiện hành (nguyên văn / sát nghĩa) | Dòng |
|---|---|---|
| Ai ASSIGN | "Admin và Staff có quyền assign đều có thể **assign** nhân viên vào hội thoại"; UC-07 bước 1 "[Admin hoặc Staff có quyền assign] click icon `Assign` trên header" | G003:311, G003:193 |
| Ai UNASSIGN | "chỉ **Admin** có thể **unassign**"; UC-07 bước 5 "**[Admin only]** … bỏ chọn checkbox → `Lưu`; Staff có quyền assign **không thể** unassign". Lý do ghi: "Phân tách quyền assign (Staff + Admin) và unassign (Admin only)" | G003:311, G003:197 |
| AC | "Staff có quyền assign → có thể assign nhân viên khác, **không thể** unassign (AC-BR15)"; "Admin → có thể assign và unassign nhân viên (AC-BR15)" | G003:603, G003:604 |
| Quyền Assign là gì | Quyền riêng, cấp con, "khác với Quản lý tài khoản Zalo ở G002" (câu đã gạch ở BR15). OQ01: "Tên quyền: **Assign**. Icon … header … (icon người dùng có dấu +)". Chỗ cấu hình: OQ01 hỏi "Cấu hình ở đâu?" nhưng ô trả lời chỉ nêu tên + icon. G002 không nhắc quyền Assign (chỉ "Quản lý tài khoản Zalo" và "Hiển thị cuộc hội thoại chưa gắn nhân sự") | G003:311, G003:682, G002:147 |
| Hiển thị control | Staff không có quyền assign → icon `Assign` **không hiển thị**; Staff có quyền + TK Ngắt kết nối → icon hiển thị, click → toast "Tài khoản đã ngắt kết nối. Vui lòng kết nối lại" | G003:518-519, AC G003:553 |
| Panel | Panel phải: ô tìm kiếm + checkbox nhân viên; `Lưu`. Bước 4: "Hội thoại xuất hiện trong danh sách chat của nhân viên được assign" | G003:194-196 |
| Cardinality | Mỗi hội thoại assign cho 1 hoặc nhiều nhân viên; được assign → hiển thị trong danh sách của người đó | G003:310, G003:312 |
| Ai thấy hội thoại nào | Staff: hội thoại của TK được assign (BR02); Admin/Owner thấy tất cả không cần assign (BR11); Staff có quyền "Hiển thị cuộc hội thoại chưa gắn nhân sự" thấy thêm hội thoại chưa gán (BR18). G002 BR09: có quyền đó thì thấy (1) chưa gắn ai, (2) gắn cho **chính mình**; gắn cho người khác **không hiển thị**. G017 BR03 cùng quy tắc | G003:296, G003:307, G003:314, G002:139, G017:274 |
| Unassign cấp TK | Staff bị unassign khỏi TK Zalo → hội thoại liên quan ẩn "ngay lập tức" (không nêu ngưỡng) | G003:308 |
| Phản hồi sau khi gỡ (cấp hội thoại) | **Spec không nói**: không có toast, không có E-code, không có log, không có hành vi cho "đang mở giữa chừng" ở G003 (G003 §5 không có exception cho assign). Chỉ G014 AF04 / BR19 có tiền lệ "mất quyền xem giữa chừng" (đóng popup ghim) | G014:352-354 |
| Realtime | G003 §15: tin nhắn mới realtime, không F5. Không có dòng cho thay đổi phân công | G003:692 |
| Phụ thuộc vào "đã phân công / chưa phân công" | Thông báo đẩy: đã phân công riêng → chỉ báo người được phân công; chưa phân công → báo mọi người có quyền xem (G027 BR07). Badge chưa đọc cùng quy tắc, tính lại khi đổi phân công, hội thoại rời phạm vi → trừ khỏi tổng (G029 BR01, AF02, E04). Nhắc hẹn: mất quyền xem (unassign) → ẩn + không thông báo, gán lại → hiện + nhắc lại (G019 BR12). Ghi chú: mất quyền xem → ẩn, gán lại → hiện (G011a BR09). Ẩn hội thoại (G024) không đổi phân công | G027:91, G029:39, :59-60, :71, G019:140, :267, G011a:120, G024:147 |
| Mở từ danh thiếp | G003 BR26: A chưa có hội thoại → nháp + auto-assign khi gửi tin đầu; B đã có & mình có quyền xem → mở; C đã có, gán cho người khác, mình không có quyền xem → chặn + log; "Admin muốn cho tham gia → dùng UC-07" | G003:322, AC :609-612 |

**Spec KHÔNG nói (baseline rỗng, không được đoán):** panel hiển thị gì với Staff khi họ không được bỏ chọn (disable / ẩn / lỗi lúc Lưu); `Lưu` gửi delta hay toàn bộ danh sách; danh sách nhân viên trong panel gồm ai (cả Admin? cả người không thấy TK đó?); log của assign; thông báo cho người bị gán / bị gỡ; Staff có Assign nhìn được hội thoại gán cho người khác hay không (G002 BR09 / G017 BR03 nói không, G003 BR02 nói rộng hơn).

## 4. Delta thật của CR-005

| # | Delta | Trước (spec hiện hành) | Sau CR | Vị trí |
|---|---|---|---|---|
| D1 | Ai unassign được | Chỉ Admin (G003:311, :197) | Admin **và** Staff có quyền Assign; quyền gán và gỡ "đi liền nhau, không tách" | CR:28, CR:31 |
| D2 | Gỡ người khác | Chỉ Admin gỡ được bất kỳ ai | Staff có quyền Assign gỡ được **bất kỳ ai, kể cả người khác** | CR:29 |
| D3 | Gỡ người cuối cùng | Spec không nói (Admin gỡ được hay không cũng không nêu) | Gỡ được cả **người cuối cùng**, hội thoại về "chưa phân công"; không chặn (chốt interview 06/10) | CR:29, CR:89 |
| D4 | Log | Không nêu | **Mọi lần gỡ ghi log**: ai gỡ · gỡ ai · khỏi hội thoại nào · lúc nào. Không cần màn xem | CR:30 |
| D5 | Phạm vi | Staff chỉ thao tác trong hội thoại mình xem được | **Không đổi** ("mở chiều thao tác, không mở tầm với") | CR:28, CR:42 |
| D6 | Kiểm quyền | UI + (ngầm) API chặn Staff | Nới điều kiện unassign ở cả **giao diện lẫn API**; quyền là kiểm tra lúc chạy | CR:51, CR:78 |
| D7 | G034 BR10 "Thay thế" | Lý do cũ "vì gỡ chỉ Admin" | **Giữ** Admin only; đổi lý do thành mức sát thương (gỡ toàn bộ người không tick, tối đa 200 hội thoại, không khôi phục) | CR:32, CR:53-59 |
| D8 | Dữ liệu cũ | — | Không migration; mọi phân công hiện có giữ nguyên; từ ngày phát hành Staff có Assign gỡ được những phân công đó | CR:51 |
| D9 | Bị gỡ khi đang mở hội thoại | Spec không nói | Đề xuất (CR ghi "Cần xác nhận hành vi hiện tại trước khi ghi thành BR"): hội thoại biến khỏi danh sách ngay; nếu đang mở → thông báo *"Bạn không còn phụ trách hội thoại này"* rồi đóng | CR:70 |

**Không đổi theo CR:** Admin vẫn assign + unassign (G003:604); Staff không có quyền Assign vẫn không thấy icon (G003:518); BR-C06 vẫn áp (CR:48); "Thay thế" hàng loạt vẫn chỉ Admin (CR:50, CR:59); quyền xem hội thoại (G002 · G003 BR18).

**Điều QA phải tự kiểm khi nhận build:** lý do CR đưa ra ("gỡ chỉ Admin" không còn đúng) khiến một dev có thể "sửa cho nhất quán" và mở luôn Thay thế (CR:55). Đây là rủi ro regression ngược của CR, cần case âm tính cả UI lẫn API.

## 5. Bảng dẫn chiếu của CR (treo / lệch)

| Dẫn chiếu trong CR | Kết quả kiểm với spec hiện hành | Kết luận |
|---|---|---|
| `G003:313` BR15 (CR:18) | Nội dung khớp nguyên văn, nhưng nằm ở **G003:311** | Lệch 2 dòng |
| `G003:197` UC-07 b5 (CR:19) | Đúng G003:197 | Khớp |
| `G003:611` AC "Staff có quyền assign → … không thể unassign" (CR:20) | Nội dung đó ở **G003:603**; G003:611 hiện là AC BR26 Case C, G003:612 là AC Admin click card (CR:63 cũng dẫn "G003:611, 612") | Lệch 8 dòng; AC thật = G003:603-604 |
| `G003 footer (756)` (CR:49) | File chỉ có **741 dòng**; footer "Lưu ý cho AI" ở G003:729-740, changelog G003:710-725 | Dẫn chiếu treo; footer hiện hành không chứa câu "Admin only / không thể unassign" (Grep: chỉ G003:197, :311, :603) |
| `G003 BR18` làm phạm vi "hội thoại được xem" (CR:28, CR:42) | G003 BR18 chỉ là quyền "Hiển thị cuộc hội thoại chưa gắn nhân sự" (G003:314); phạm vi xem đầy đủ = BR02 + BR11 + BR16 + BR18 (và G002 BR09) | Dẫn chiếu thiếu, ghi tiền tố khi truy vết |
| `G034` §1 (30) · §10 (85) · BR10 (184) · OOS06 (366) · footer (432) · BR12 · BR13 (CR:21, CR:49, CR:57, CR:70) | Không có file G034 | **Treo toàn bộ** (Q-02) |
| `PHÂN QUYỀN` dòng 88 · 90 · 149 (CR:22, CR:49) | Không có file; CR chỉ trích nội dung dòng 88 | Treo; dòng 90, 149 không biết nội dung (Q-14) |
| `PROJECT_KNOWLEDGE` §1, §5, §7 điểm số 4, glossary 167, 169 (CR:48-49, CR:79) | Không có file | Treo |
| "G002" làm phạm vi (CR:28) | G002 chỉ nói phân quyền theo **tài khoản Zalo** và quyền xem hội thoại chưa gắn nhân sự (G002:139); không nhắc quyền Assign | Đúng ở mức phạm vi, nhưng G002 không là nơi cấu hình Assign (Q-04) |
| "11 chỗ" cần sửa (CR:49) | Đếm lại theo CR:49: G034 ×5, PHÂN QUYỀN ×3, PROJECT_KNOWLEDGE ×2, G003 footer ×1 = 11 | Khớp số, nhưng 11 chỗ đều **ngoài** G003:197/311/603 và 10/11 chỗ ở file không tồn tại |

## 6. Dòng spec cần sửa NẾU áp CR-005

Chỉ liệt kê dòng kiểm được. "Phải thành" lấy từ CR §2.2; ô có "[chờ BA]" còn phụ thuộc câu hỏi. QA không sửa spec.

| # | File | Dòng | Hiện tại | Phải thành (nếu áp CR) | Câu |
|---|---|---|---|---|---|
| 1 | G003 | 11, 13 | Version `1.11`, Last updated `2026-08-03` | v1.24 + ngày sửa (CR:77) | Q-01 |
| 2 | G003 | 197 (UC-07 b5) | "~~[Admin]~~ **[Admin only]** Có thể unassign … `Lưu`; Staff có quyền assign **không thể** unassign" | "**[Admin hoặc Staff có quyền assign]** bỏ chọn checkbox → `Lưu`" (CR:31); bỏ vế "Staff … không thể unassign" | — |
| 3 | G003 | 311 (BR15) | "…chỉ **Admin** có thể **unassign**"; lý do "Phân tách quyền assign (Staff + Admin) và unassign (Admin only)" | "Admin và Staff có quyền assign đều assign VÀ unassign được … quyền gán và quyền gỡ đi liền nhau … phạm vi khoá trong hội thoại được xem (G002 · G003 BR18)" + "gỡ được bất kỳ ai kể cả người cuối cùng (→ chưa phân công)" + "mọi lần gỡ ghi log" (CR:28-30). **Cột "Lý do": CR đưa lý do ở §2.2 (CR:28) nhưng không nói thay câu lý do cũ ở G003:311 bằng gì** [chờ BA] | Q-10 |
| 4 | G003 | 603 (AC-BR15) | "Staff có quyền assign → … **không thể** unassign" | "… assign và unassign được (kể cả người khác, kể cả người cuối)". CR dẫn nhầm G003:611 (§5) | — |
| 5 | G003 | 604 (AC-BR15, Admin) | "Admin → có thể assign và unassign" | Giữ nguyên | — |
| 6 | G003 | sau 604 | Không có AC về log, người cuối, đang mở | Thêm AC (CR:63 ☑ Acceptance Criteria) — nội dung phụ thuộc Q-06, Q-07, Q-10 | Q-06, Q-07, Q-10 |
| 7 | G003 | §5 (G003:275 "Exception Confirmation Log" / các E) | Không có exception cho assign | CR:63 ☑ Exception "rà lại E liên quan quyền assign". Spec không có E nào để rà → thêm E (mất quyền Assign giữa phiên, từ chối server) [chờ BA] | Q-09, Q-12 |
| 8 | G003 | 518-519, 553 (§10F, AC) | Icon Assign ẩn với Staff không quyền; TK Ngắt kết nối → toast | Không đổi theo CR; xác nhận áp cho cả thao tác gỡ | Q-13 |
| 9 | G003 | 682 (OQ01), §14 | OQ01 đã trả lời tên quyền + icon | CR:63 ☑ Open Questions: thêm OQ cho log và hành vi đang mở (CR:69-70) | Q-04, Q-07, Q-10 |
| 10 | G003 | 710-725 (Changelog) | Dừng ở v1.11 | Thêm dòng v1.24 tham chiếu CR-005 | Q-01 |
| 11 | G034 | 30, 85, 184, 366, 432 | Không có file | Sửa lý do BR10 + 4 chỗ dẫn chiếu (CR:77) | Q-02 |
| 12 | PHÂN QUYỀN | 88, 90, 149 | Không có file; dòng 88: "Unassign hội thoại — Admin ✓ · Nhân sự Quản lý ✗ · Staff ✗" | Dòng 88 → Staff (có quyền Assign) ✓ [chờ BA: cột "Nhân sự Quản lý"?]; dòng 90, 149 không biết | Q-14 |
| 13 | PROJECT_KNOWLEDGE | 167, 169 + §1, §7 | Không có file | CR:79 | — |

## 7. Đối chiếu chéo với CR-001 (và CR-004)

| Điểm | CR-001 (`INTAKE-CR-001.md`, `tailieu/CR-001*`) | CR-005 | Kết luận |
|---|---|---|---|
| "Assign" nghĩa gì | Cấp CHA: được assign ≥1 **tài khoản Zalo** CONNECTED (G002) để kết bạn | Cấp CON: assign **nhân viên vào hội thoại** (G003 UC-07) | Hai nghĩa khác nhau. Không mâu thuẫn nội dung. Cần case chéo: Staff bị gỡ khỏi 1 hội thoại (cấp con) **vẫn** còn assign TK (cấp cha) → vẫn có điều kiện kết bạn của CR-001; ngược lại Staff bị unassign TK → mọi hội thoại ẩn (G003 BR12) bất kể phân công hội thoại |
| Tài liệu cùng sửa | PHÂN QUYỀN: thêm §6 "Danh bạ & Kết bạn" 5 dòng; PROJECT_KNOWLEDGE | PHÂN QUYỀN dòng 88 · 90 · 149 (chỗ "Unassign hội thoại"); PROJECT_KNOWLEDGE §1, §5, §7 | **Phụ thuộc thứ tự áp**: hai CR cùng sửa 2 file không có trong tailieu/; CR-001 chèn mục mới có thể dời số dòng mà CR-005 trích (88/90/149). Cần BA chốt thứ tự / số dòng sau khi áp CR trước |
| Tên vai | CR-001 ma trận cột "Admin \| NS Quản lý \| Nhân sự" (Q-19 CR-001 chưa trả lời "NS Quản lý" là gì) | Ma trận dòng 88 "Admin · Nhân sự Quản lý · Staff" | Cùng khái niệm vai chưa định nghĩa; dùng chung 1 câu trả lời (Q-04, Q-14) |
| Quyền "Quản lý tài khoản Zalo" | CR-001: gỡ điều kiện này khỏi kết bạn | CR-005: quyền Assign hội thoại vốn tách khỏi "Quản lý tài khoản Zalo" (câu đã gạch G003:311) | Không chạm nhau. Case ma trận cần 4 loại Staff: có Assign / có Quản lý TK Zalo mà không có Assign / có cả hai / không có |
| BR26 Case C (trùng khách) | R1 của CR-001: "Case C" chặn người không có quyền xem; Admin dùng UC-07 | Staff có Assign nay gỡ được người phụ trách | Staff chỉ mở panel Assign ở hội thoại mình xem được, nên không "vào" được hội thoại Case C bằng UC-07. Nhưng có thể làm Case "chưa gán" xuất hiện nhiều hơn → Q-06 |
| Cùng chủ đề đổi quyền giữa phiên | CR-001 Q-11 (đổi assign/kết nối khi phiên mở) | CR-005 Q-12 | Nên hỏi BA một lần cho cả hai |
| CR-004 | — | — | Không liên quan |

Không có mâu thuẫn nội dung giữa CR-001 và CR-005; có phụ thuộc tài liệu (ma trận, PROJECT_KNOWLEDGE) và chung khái niệm vai chưa định nghĩa.

## 8. B2-B3: Flag và lane (RISK_LANES § Lanes — QA)

| Flag | Bật? | Lý do |
|---|---|---|
| `security-test` | **Có — HARD GATE** | CR đổi quy tắc quyền (ai được gỡ) và nới điều kiện kiểm quyền ở API (CR:78): cần test phân quyền theo từng vai, từ chối server-side, không rò sang hội thoại ngoài tầm với, "Thay thế" không bị mở nhầm |
| `regression-scope` | **Có** | Luồng assign/phân công đã ship (G003 UC-07/BR14-BR16/BR26), kéo theo G002 BR09, G017 BR03, G019 BR12, G027 BR07, G029 BR01, G011a BR09, G014 AF04 |
| `flaky-risk` | **Có** | Thay đổi phân công truyền tới nhiều phiên (người bị gỡ, người còn lại, nhiều tab) qua realtime; kết quả phụ thuộc thời điểm / thứ tự (hai người sửa panel cùng lúc) |
| `data-integrity` | Không | Không tính tiền / tồn / số dư / migration (CR:51). Mất phân công không khôi phục được (G034 không có lịch sử, CR:57) là rủi ro chức năng, phủ bằng case và log (Q-10) |
| `multi-tenant-isolation` | Không — theo dõi | CR không đổi phạm vi tenant. Case "API gỡ phân công hội thoại thuộc workspace khác" nằm trong `security-test` (Q-09). Nâng nếu dev cho biết kiểm workspace nằm đúng ở logic kiểm quyền bị sửa |
| `cross-service-e2e` | Không — theo dõi | Spec chưa nêu service nào ngoài hub-chat-zalo (G003:662); chưa có contract nhiều bên mới. Nâng nếu log hoặc realtime đi qua service riêng |
| `no-ac-source` | Không | §1 |

Số flag (ngoài no-ac-source): **3**; hard gate: **1** (`security-test`). → **lane high-risk** (căn: hard gate; số flag chưa đạt 4).
Test depth: Happy / Edge / Error đủ BR + **exploratory + a11y + automation regression + confirm scope với user**.
Test types: `acceptance`, `system` (chuỗi assign / unassign / người cuối / hai người sửa panel), `e2e` (UI → server → realtime tới client thứ hai), `regression`, `exploratory`, `a11y` (panel Assign: checkbox, bàn phím, thông báo "Bạn không còn phụ trách…"). Không `perf-smoke`. Unit / integration / contract của việc kiểm quyền thuộc dev.
Skills: `qa-test-design` (bảng quyết định vai × thao tác × quan hệ với hội thoại), `qa-test-types`, `qa-e2e-playwright` (2 phiên song song + a11y), `qa-api-test` (kiểm quyền server, Thay thế), `qa-test-data`, `qa-defect`, `qa-exit-criteria`.

## 9. Business Rule

### 9.1 BR mới / đổi do CR-005 (nguồn: CR-005; spec hiện hành chưa chứa)

| ID | Nội dung rút gọn | Vị trí | Đối chiếu spec hiện hành |
|---|---|---|---|
| G003-BR15a | Admin và Staff có quyền assign đều assign VÀ unassign; quyền gán, gỡ đi liền nhau | CR:28 | Đổi G003:311 |
| G003-BR15b | Phạm vi vẫn khoá trong hội thoại người đó được xem (G002 · G003 BR18) | CR:28, CR:42 | Khớp G002:139, G017:274; xem Q-03 |
| G003-BR15c | Gỡ được bất kỳ ai, kể cả người khác | CR:29 | Mới |
| G003-BR15d | Gỡ được cả người cuối cùng; hội thoại về "chưa phân công" | CR:29 | Mới; trạng thái "chưa phân công" đã có ở G002 BR09, G003 BR18 |
| G003-BR15e | Mọi lần gỡ ghi log (ai gỡ, gỡ ai, hội thoại nào, lúc nào); không cần màn xem | CR:30 | Mới; mâu thuẫn với CR:69 (Q-10) |
| G003-UC07-b5 | [Admin hoặc Staff có quyền assign] bỏ chọn → Lưu | CR:31 | Đổi G003:197 |
| G034-BR10 | "Thay thế" hàng loạt vẫn chỉ Admin; lý do mới = mức sát thương (gỡ toàn bộ người không tick, ≤200 hội thoại, không khôi phục) | CR:32, CR:55-59 | G034 không có file (Q-02) |
| CR5-BR-API | Quyền kiểm lúc chạy; nới ở cả giao diện lẫn API; không migration; phân công hiện có giữ nguyên | CR:51, CR:78 | Mới (hành vi, không có trong spec) |
| CR5-DRAFT | Bị gỡ giữa chừng: hội thoại biến khỏi danh sách ngay; đang mở → "Bạn không còn phụ trách hội thoại này" rồi đóng | CR:70 | **Chưa là BR** — CR ghi cần xác nhận (Q-07) |

Tổng: **9** (8 BR + 1 dự thảo CR5-DRAFT).

### 9.2 BR / quy tắc hiện hành bị chạm (baseline và regression)

| ID | Nội dung rút gọn | Vị trí |
|---|---|---|
| G003-BR14 | Hội thoại assign cho 1 hoặc nhiều nhân viên | G003:310 |
| G003-BR16 | Được assign → hội thoại hiện trong danh sách của người đó | G003:312 |
| G003-BR02 | Staff chỉ thấy hội thoại của TK được assign qua G002 | G003:296 |
| G003-BR11 | Admin/Owner thấy tất cả, không cần assign | G003:307 |
| G003-BR12 | Unassign khỏi TK Zalo (cấp CHA) → hội thoại ẩn ngay | G003:308 |
| G003-BR18 | Quyền "Hiển thị cuộc hội thoại chưa gắn nhân sự" | G003:314 |
| G003-BR10 | TK Ngắt kết nối: xem lịch sử, không gửi mới | G003:306 |
| G003-§10F | Icon Assign ẩn với Staff không quyền; TK ngắt kết nối → toast | G003:518-519, AC :553 |
| G003-BR26 | Mở hội thoại từ danh thiếp A / B / C, auto-assign, log | G003:322, AC :609-612 |
| G003-OQ01 | Tên quyền = Assign, icon header | G003:682 |
| G002-BR04 / BR09 | Nhiều người cùng bật "chưa gắn nhân sự"; thấy chưa gắn + gắn cho mình, không thấy gắn cho người khác | G002:138-139 |
| G017-BR03 | Phạm vi tìm của Staff = TK được assign + gán cho mình + chưa gán (nếu có quyền) | G017:274 |
| G027-BR07 | Thông báo đẩy theo phân công | G027:91 |
| G029-BR01 / AF02 / E04 | Badge chưa đọc theo phân công, tính lại khi đổi | G029:39, :59-60, :71 |
| G019-BR12 | Mất quyền xem (unassign) → ẩn nhắc hẹn, không thông báo; gán lại → hiện + nhắc lại | G019:140, :267 |
| G011a-BR09 | Mất quyền xem → ghi chú ẩn; gán lại → hiện | G011a:120 |
| G014-AF04 / BR19 | Mất quyền giữa chừng → đóng popup ghim | G014:352-354 |
| G024-BR08 | Ẩn hội thoại không đổi phân công | G024:147 |
| BR-C04 / BR-C06 / BR-C12 | Từ chối + log; ẩn / disable / toast; realtime không tải lại (PROJECT_KNOWLEDGE không có file) | G003:322, G033:223 |

Tổng: **19 dòng** BR / quy tắc hiện hành.

## 10. Điều kiện dữ liệu / môi trường

- Vai (kiểm theo spec): **Admin/Owner**; **Staff có Assign**; **Staff có "Quản lý tài khoản Zalo" nhưng không có Assign** (BR15 tách hai quyền); **Staff không có Assign** (icon ẩn); **Staff có Assign + "Hiển thị cuộc hội thoại chưa gắn nhân sự"**; Staff có Assign nhưng **không** có quyền đó. Cần ≥2 Staff có Assign để test "gỡ người khác" và "người này gỡ người kia".
- Hội thoại: 1 người được assign; 2 người; ≥3 (để gỡ từng người đến người cuối); chưa gán; hội thoại nhóm và 1-1 (spec không phân biệt, ghi vào Q-05); trên TK CONNECTED và DISCONNECTED (G003:519).
- Quan hệ giữa **tác nhân và hội thoại**: tác nhân là một trong những người được assign; không được assign nhưng hội thoại chưa gán và có quyền chưa gắn; tác nhân ngoài tầm xem (kiểm chỉ ở API). Theo G002:139, Staff không thấy hội thoại gán cho người khác, nên để "gỡ người khác" tác nhân phải thuộc danh sách phụ trách (Q-03).
- Phiên: 2 phiên trình duyệt trở lên cho cùng một Staff (nhiều tab) và 1 phiên cho người bị gỡ, 1 phiên cho Admin, để kiểm realtime và hành vi đang mở.
- Dữ liệu cũ: phân công có trước phát hành (do Admin tạo) để kiểm D8; ghi nhận danh sách phụ trách trước và sau.
- Quan sát log: cần cách đọc log gỡ (DB / log hệ thống / API) — chưa biết (Q-10). Cần xem được log từ chối (Q-09).
- Hạ tầng: build và môi trường chưa nêu trong CR (SỔ THEO DÕI không có file).

## 11. Regression cần canh

- **R1 Assign (không đổi):** Admin và Staff có Assign vẫn gán được; hội thoại hiện đúng trong danh sách người được gán (BR14, BR16); gán nhiều người.
- **R2 Staff không có Assign:** icon Assign vẫn ẩn (G003:518, :553); gọi API unassign vẫn bị từ chối (Q-09).
- **R3 Admin:** unassign vẫn như cũ (G003:604); Admin vẫn thấy hết (BR11), không phụ thuộc phân công.
- **R4 "Thay thế" hàng loạt (G034) vẫn Admin only:** Staff có Assign không thấy hộp chọn (CR:21), gọi API hàng loạt bị từ chối. Không kiểm được UI do G034 không có file (Q-02).
- **R5 Phạm vi xem:** Staff có Assign không gỡ được trong hội thoại ngoài tầm xem (G002 BR09, G017 BR03); cô lập workspace.
- **R6 Hệ quả hiển thị sau khi gỡ:** danh sách người bị gỡ (BR12-kiểu), badge chưa đọc trừ khỏi tổng (G029 E04), thông báo đẩy chuyển theo phân công mới (G027 BR07), nhắc hẹn ẩn + không thông báo (G019 BR12), ghi chú ẩn (G011a BR09), tìm kiếm không còn trả hội thoại đó (G017 BR03).
- **R7 Gán lại sau gỡ:** hội thoại hiện lại, nhắc hẹn nhắc lại (G019 BR12), ghi chú hiện lại (G011a BR09).
- **R8 Hội thoại chưa phân công sau khi gỡ người cuối:** Admin và Staff có quyền BR18 thấy; Staff khác không; badge và push theo G027 BR07 / G029 BR01 ("chưa phân công → mọi người có quyền xem").
- **R9 BR26:** Case A auto-assign vẫn đúng; Case C vẫn chặn; sau khi gỡ phân công của hội thoại đã có, click danh thiếp rơi vào nhánh nào (Q-06).
- **R10 CR-001:** gỡ phân công hội thoại không ảnh hưởng điều kiện assign TK của kết bạn (§7).
- **R11 Gỡ giữa chừng:** người bị gỡ đang mở hội thoại / đang gõ / đang gửi (Q-07); popup ghim đang mở đóng ngay (G014 AF04).
- **R12 TK DISCONNECTED:** Staff có Assign click icon → toast, panel không mở, kể cả với thao tác gỡ (Q-13).
- **R13 a11y:** panel Assign dùng bàn phím, nhãn checkbox cho trạng thái đã chọn, thông báo bị gỡ đọc được.

## 12. Câu hỏi làm rõ

Nhãn: **CHẶN** = chưa viết được kỳ vọng cho nhóm case nêu; **MỘT PHẦN** = viết được phần suy ra từ spec, phần còn lại chờ; **KHÔNG CHẶN** = QA có cách xử lý tạm.

### Q-01 — G003 hiện hành chưa chứa nội dung CR, dòng CR trích lệch   [KHÔNG CHẶN — Cao/BA]
- **Trích CR:** "Spec bị sửa | G003 — Chat `v1.23` (chính)" (CR:9); "G003 → v1.24" (CR:77); "AC *(G003:611, 612)*" (CR:63); "`G003` footer *(756)*" (CR:49); "BR15 … `G003:313`" (CR:18).
- **Spec hiện hành:** G003 v1.11 (G003:11), 741 dòng; BR15 ở G003:311 (CR:313 trích lệch 2); AC "Staff … không thể unassign" ở G003:603 (CR:611 trích lệch 8; G003:611-612 hiện là AC BR26); footer không có dòng 756; còn nguyên "Admin only" ở G003:197, :311, :603.
- **Vì sao hỏi:** theo quy ước, đây là spec chưa cập nhật theo CR / dẫn chiếu treo, không phải thiếu tài liệu.
- **Đề xuất QA:** BA xác nhận sẽ sửa G003 theo bảng §6 (13 dòng); BA sửa dòng dẫn chiếu trong CR (AC = G003:603-604, BR15 = G003:311, footer). QA tạm test theo "spec hiện hành + delta CR" và gắn nhãn "nguồn: CR-005 only" cho BR15a-e.

### Q-02 — G034 không có trong tailieu/: "Thay thế chỉ Admin" kiểm bằng gì?   [CHẶN case G034/Thay thế — Cao/BA]
- **Trích:** "Spec bị sửa … **G034** `v1.0`" (CR:9); "Kiểu **Thay thế** chỉ Admin dùng được … Nhân sự có quyền assign **không thấy** hộp chọn | `G034:184`" (CR:21); "*Thay thế* gỡ **toàn bộ người không được tick**, trên **tối đa 200 hội thoại một lượt** (G034 BR12), và **không khôi phục được**" (CR:57); "Quyền gán và quyền gỡ **đi liền nhau**, không tách" (CR:28) vs "**gỡ hàng loạt qua *Thay thế*** = vẫn **chỉ Admin**" (CR:50).
- **Spec hiện hành:** không có G034 (tailieu/ dừng ở G033); không có màn "gán hàng loạt" nào trong G003. Chỉ G004 OOS04 "Gán hàng loạt nhân viên theo thẻ" ghi backlog (G004:400) và G004:334 "không kèm gán nhân viên".
- **Vì sao chưa viết được kỳ vọng:** không biết màn Thay thế nằm ở đâu, "hộp chọn" nào, API nào; không thể test "Staff không thấy hộp chọn" (UI) và "Staff gọi API Thay thế bị từ chối" (API). Đây đúng là rủi ro CR:55 cảnh báo (dev tự "sửa cho nhất quán").
- **Đề xuất QA:** BA đưa G034 vào tailieu/ hoặc xác nhận G034 chưa được đưa vào docs; nêu endpoint / mã lỗi Thay thế. Tạm: QA chỉ ghi case âm tính cấp "Staff có Assign không dùng được gán hàng loạt kiểu Thay thế" ở mức thăm dò, không đóng case.
- **Ghi chú wording:** CR:28 "đi liền nhau, không tách" nói về gán / gỡ **từng hội thoại**; CR:50 nói đây là "2 nguồn sự thật có chủ ý". QA đọc hai câu là nhất quán nếu BR15 giới hạn "từng hội thoại"; đề xuất BA thêm 3 chữ "từng hội thoại" vào BR15 để dev khỏi đọc nhầm.

### Q-03 — "Phạm vi vẫn khoá trong hội thoại người đó được xem": Staff có Assign xem được hội thoại nào?   [MỘT PHẦN — Cao/BA]
- **Trích CR:** "Phạm vi vẫn bị khoá trong **hội thoại người đó được xem** (G002 · G003 BR18)" (CR:28); "Người điều phối CSKH thường **không phải Admin**" (CR:39); "Mỗi lần bàn giao ca … người điều phối chỉ **thêm** được người mới; người cũ vẫn nằm đó" (CR:38).
- **Spec hiện hành:** G002:139 "Hội thoại đã gắn cho nhân sự khác **không hiển thị**"; G017:274 "hội thoại được gán cho mình + chưa gán nếu có quyền"; G003 BR02 (G003:296) nói rộng hơn "Staff chỉ thấy hội thoại của tài khoản Zalo được assign". G003 BR18 chỉ là quyền chưa gắn (G003:314).
- **Hệ quả:** nếu theo G002:139, Staff có Assign chỉ thấy hội thoại **gắn cho mình** (+ chưa gắn nếu BR18) → muốn "gỡ người khác" Staff phải đang là một trong số người phụ trách; gỡ "người cuối cùng" bởi Staff chỉ xảy ra khi Staff tự gỡ chính mình. Người điều phối không được gán sẽ không mở được hội thoại để gỡ (kịch bản CR:38-39 khó xảy ra). Nếu "được xem" rộng (BR02, mọi hội thoại của TK) thì kỳ vọng khác.
- **Vì sao chưa viết được kỳ vọng:** bộ dữ liệu (tác nhân có thuộc danh sách phụ trách không) và case âm tính "ngoài tầm xem" đều phụ thuộc.
- **Đề xuất QA:** BA xác nhận quyền Assign **không** mở rộng tầm xem (đúng như CR:42) và Staff không-gán không gỡ được; nếu CR muốn người điều phối gỡ mà không thuộc danh sách phụ trách thì phải nói rõ tầm xem đó. QA tạm theo G002:139 và G017:274.

### Q-04 — Quyền Assign: ai cấp, ở màn nào; "Nhân sự Quản lý" / "Staff" trong ma trận là gì   [KHÔNG CHẶN kỳ vọng, CHẶN dữ liệu test — Trung bình/BA + Dev]
- **Trích:** "Tên quyền: **Assign**. Icon hiển thị trên header …" (G003:682, OQ01 ghi "Cấu hình ở đâu?" chưa trả lời); ma trận "*Unassign hội thoại* — Admin ✓ · **Nhân sự Quản lý** ✗ · **Staff** ✗" (CR:22).
- **Spec hiện hành:** G002 không nhắc quyền Assign (chỉ "Quản lý tài khoản Zalo" G002:147 và "Hiển thị cuộc hội thoại chưa gắn nhân sự"). "Nhân sự Quản lý" chỉ có ở G007:26, :44 như "role quản lý", không định nghĩa (xem Q-19 của INTAKE-CR-001).
- **Vì sao hỏi:** không biết cách cấp / thu hồi quyền Assign cho tài khoản test; không biết Staff có "Quản lý tài khoản Zalo" có kèm Assign không (G003:311 đã gạch "khác với Quản lý tài khoản Zalo"). Ma trận có 3 cột (Admin / Nhân sự Quản lý / Staff) trong khi quyền là permission cấp con.
- **Đề xuất QA:** BA nêu nơi cấu hình quyền Assign và quan hệ với vai "Nhân sự Quản lý"; QA tạm coi Assign là permission độc lập, gồm 4 tổ hợp ở §10.

### Q-05 — Đối tượng bị gỡ và phản hồi giao diện   [MỘT PHẦN — Trung bình/BA]
- **Trích CR:** "Gỡ được bất kỳ ai, kể cả người khác, kể cả **người cuối cùng**" (CR:29).
- **Spec hiện hành:** không nêu panel hiển thị ai; không nêu phản hồi sau `Lưu` (G003:195-196).
- **Còn mở:** (a) "bất kỳ ai" gồm **chính mình** không (CR:29 "kể cả người khác" ngụ ý có)? sau khi tự gỡ, Staff mất thấy hội thoại (trừ BR18) và không gán lại được; (b) gồm **Admin/Owner** nếu Admin được tick trong hội thoại không (BR11 Admin thấy hết dù không gán)? (c) gồm Staff **cũng có quyền Assign**; (d) panel có phân biệt ai gán, có cảnh báo khi gỡ, có toast "Đã lưu" / lỗi không? (e) hội thoại nhóm và 1-1 có khác không?
- **Vì sao chưa viết được kỳ vọng:** không có kỳ vọng hiển thị / thông điệp.
- **Đề xuất QA:** BA liệt kê quan hệ tác nhân × đối tượng bị gỡ (self / người thường / Staff có Assign / Admin) với kết quả cho phép / chặn; nêu toast.

### Q-06 — Hội thoại sau khi gỡ người cuối cùng ("chưa phân công")   [CHẶN case người cuối — Cao/BA]
- **Trích CR:** "kể cả **người cuối cùng** *(hội thoại trở về trạng thái "chưa phân công")*" (CR:29); "Hội thoại **biến mất khỏi danh sách ngay**" (CR:70).
- **Spec hiện hành:** G002:139 / G003 BR18 (G003:314): hội thoại chưa gắn chỉ hiện với Staff có quyền "Hiển thị cuộc hội thoại chưa gắn nhân sự" (+ Admin). G027 BR07, G029 BR01: chưa phân công → báo mọi người có quyền xem.
- **Mâu thuẫn / thiếu:** (a) CR:70 "biến mất khỏi danh sách ngay" đúng với người bị gỡ **khi còn người khác**; nếu người bị gỡ có quyền BR18 và hội thoại thành chưa gán thì theo BR18 họ **vẫn thấy** hội thoại → "biến mất" và "Bạn không còn phụ trách … đóng" (CR:70) không còn đúng; (b) G003 BR26 Case C chỉ định nghĩa "gán cho người khác" và Case B "chưa gán + có BR18"; nhánh **chưa gán + người thực hiện không có BR18** (hội thoại đã tồn tại nhưng không xem được) không thuộc A / B / C — nay dễ xảy ra hơn; (c) có auto-assign lại khi ai đó trả lời hội thoại chưa gán không (spec chỉ nêu ở Case A); (d) bắn push "tin nhắn mới" tới ai ở lần đầu sau khi chưa phân công (G027 BR07).
- **Vì sao chưa viết được kỳ vọng:** kết quả hiển thị phụ thuộc quyền BR18 của người bị gỡ; nhánh Case chưa gán + không BR18 chưa có luật.
- **Đề xuất QA:** BA chốt bảng {người bị gỡ có / không có BR18} × {còn người khác / là người cuối} → hiển thị, thông báo, badge; và bổ sung nhánh BR26 "chưa gán + không BR18". Viết được ngay: người cuối gỡ → Admin vẫn thấy, Staff có BR18 thấy, Staff khác không (suy ra từ BR11, BR18).

### Q-07 — Người bị gỡ đang mở hội thoại / đang gõ / đang gửi   [CHẶN — Cao/BA + Dev]
- **Trích CR:** "Người **đang mở hội thoại** mà bị gỡ giữa chừng thì thấy gì? … Hiện thông báo *"Bạn không còn phụ trách hội thoại này"* rồi đóng. **Cần xác nhận hành vi hiện tại** trước khi ghi thành BR" (CR:70).
- **Spec hiện hành:** G003 không có exception cho mất quyền giữa chừng; chỉ G014 AF04 (đóng popup ghim, G014:352-354) và G012 E04 cho việc khác. Không có chuỗi chuẩn.
- **Còn mở:** (a) chuỗi thông báo có chính xác không (đang là dự thảo); toast hay popup; tự đóng sau bao lâu; (b) tin đang soạn dở bị bỏ hay giữ; bấm Gửi sau khi bị gỡ → từ chối với thông điệp gì (hay vẫn gửi được); (c) tin khách đến sau khi bị gỡ có vào hội thoại đó của người này không; (d) bị gỡ nhưng có quyền BR18 và hội thoại thành chưa gán → còn xem được (Q-06); (e) popup / panel phụ đang mở (ghim, chuyển tiếp) đóng ngay (G014 AF04).
- **Vì sao chưa viết được kỳ vọng:** CR chính nó nói chưa xác nhận hành vi hiện tại; không có ngưỡng thời gian.
- **Đề xuất QA:** Dev chạy thử hành vi hiện tại (khi Admin unassign đang mở) và báo; BA ghi thành BR + chuỗi. QA tạm: chỉ viết "sau khi người kia được thông báo hoặc tải lại, hội thoại không còn trong danh sách" khi người bị gỡ không có BR18 và còn người phụ trách khác.

### Q-08 — Realtime tới các phiên khác và ngưỡng đo được   [CHẶN ngưỡng — Cao/BA + Dev]
- **Trích:** "Hội thoại **biến mất khỏi danh sách ngay** (BR-C12, như G034 BR13)" (CR:70); G003 BR12 "ẩn khỏi danh sách ngay lập tức" (G003:308); G003 §15 "Realtime … không cần F5" (G003:692).
- **Spec hiện hành:** "ngay" không có số; BR-C12 / G034 BR13 không có file.
- **Còn mở:** ai nhận cập nhật: (a) người bị gỡ (nhiều tab / thiết bị); (b) người còn lại trong danh sách phụ trách (panel Assign và danh sách của họ có cập nhật không, hay chỉ sau tải lại); (c) Admin đang xem; (d) người đang mở panel Assign (xem Q-11); ngưỡng (giây).
- **Vì sao chưa viết được kỳ vọng:** không đo được "ngay".
- **Đề xuất QA:** BA / Dev chốt ngưỡng (vd ≤ N giây từ lúc `Lưu`) theo cách G033 / G014 đã dùng "không cần tải lại"; nếu không, QA assert "không cần tải lại trong khoảng chờ tối đa X" và ghi giới hạn.

### Q-09 — Kiểm quyền phía server (API) và cô lập workspace   [CHẶN case security — Cao/Dev + BA]
- **Trích CR:** "Chỉ nới điều kiện kiểm quyền ở thao tác *unassign* — cả **giao diện** lẫn **API**" (CR:78); "BR-C06 vẫn áp: không có quyền → ẩn / không thao tác được" (CR:48).
- **Spec hiện hành:** có tiền lệ "gọi API thẳng → từ chối + ghi log" (G033 E01), BR-C04 "từ chối + log" (G003:322); G003 không nêu API unassign, mã lỗi, thông điệp.
- **Còn mở:** (a) Staff **không có** Assign gọi API unassign: mã / thông điệp / có ghi log từ chối không; (b) Staff **có** Assign gọi API cho hội thoại **ngoài tầm xem** hoặc **workspace khác**; (c) API gỡ đơn lẻ và API Thay thế (G034) có dùng chung hàm kiểm quyền không (rủi ro CR:55); (d) Staff vừa bị thu hồi quyền Assign giữa phiên (xem Q-12).
- **Vì sao chưa viết được kỳ vọng:** không có kết quả mong đợi cho case âm tính (điểm security chính của CR).
- **Đề xuất QA:** Dev + BA nêu mã lỗi / thông điệp / log; QA dựng case qua `qa-api-test`: vai × hội thoại × workspace. Mẫu thông điệp có thể bám G012 E04 nhưng cần BA xác nhận.

### Q-10 — Log gỡ: bắt buộc hay "bổ sung sau"? Xem ở đâu, ghi những gì?   [CHẶN AC log — Cao/BA + Dev]
- **Trích CR (mâu thuẫn):** "**Mọi lần gỡ đều ghi log**: ai gỡ · gỡ ai · khỏi hội thoại nào · lúc nào … log hệ thống là đủ" (CR:30) vs "Chưa có → **vẫn phát hành CR này**, log bổ sung sau; **không chặn build**" (CR:69) vs "Bổ sung ghi log *unassign* *(theo câu hỏi 1)*" (CR:78).
- **Spec hiện hành:** G003 không nêu log phân công (chỉ log Case C, G003:322).
- **Vì sao chưa viết được kỳ vọng:** CR:30 là yêu cầu, CR:69 cho phép phát hành không có log → không biết AC log có nằm trong lần phát hành này không. Cũng không biết: nơi đọc log (QA cần để verify), ghi **assign** không (đối xứng), một lần `Lưu` gỡ N người → N dòng hay 1; ghi cả lần gỡ bị từ chối / thất bại không; múi giờ; tự gỡ chính mình có ghi không.
- **Đề xuất QA:** BA chốt: log nằm trong phát hành này (CR:30) hay sau; Dev nêu nơi đọc log và schema. Nếu "sau" thì AC log ra khỏi phạm vi nghiệm thu lần này và ghi vào exit criteria.

### Q-11 — Hai người sửa panel Assign cùng lúc; `Lưu` gửi gì?   [CHẶN case đồng thời — Trung bình/Dev + BA]
- **Trích:** UC-07 b2-3,5 "panel … checkbox … `Lưu`" (G003:194-197).
- **Spec hiện hành:** không nêu `Lưu` gửi toàn bộ danh sách hay thay đổi; không nêu xử lý khi dữ liệu đã đổi (panel cũ).
- **Vì sao hỏi:** khi gỡ trở nên phổ biến, A mở panel (thấy X, Y), B gỡ Y rồi Lưu, A bỏ chọn X rồi Lưu: nếu `Lưu` gửi toàn bộ danh sách thì A có thể gán lại Y ngoài ý muốn; nếu gửi delta thì ổn. Kết quả là dữ liệu phân công (không khôi phục được theo CR:57).
- **Đề xuất QA:** BA / Dev nêu quy tắc (delta hay full-set, panel cũ báo gì). QA dựng case 2 phiên.

### Q-12 — Quyền Assign bị thu hồi / cấp giữa phiên   [CHẶN case — Trung bình/BA]
- **Trích CR:** "☑ Exception *(rà lại E liên quan quyền assign)*" (CR:63).
- **Spec hiện hành:** G003 §5 không có E nào liên quan Assign; G003:518 chỉ nói icon ẩn khi không có quyền. Tiền lệ: G012 E04 "mất quyền giữa chừng … toast … ghi log" (cho kết bạn).
- **Còn mở:** Staff đang mở panel, Admin thu hồi quyền Assign, Staff bấm `Lưu` có thao tác gỡ → thành công hay từ chối (thông điệp, log); icon có biến mất realtime không; được cấp quyền giữa phiên → icon hiện khi nào (liên quan CR-001 Q-11).
- **Đề xuất QA:** BA thêm E; QA test sau khi có thông điệp. Bỏ vào đợt hỏi chung với CR-001 Q-11.

### Q-13 — TK Zalo DISCONNECTED: gỡ phân công có bị chặn không?   [KHÔNG CHẶN — Thấp/BA]
- **Trích:** "Staff có quyền assign, tài khoản Zalo Ngắt kết nối | Icon `Assign` hiển thị; click → toast 'Tài khoản đã ngắt kết nối. Vui lòng kết nối lại'" (G003:519).
- **Vấn đề:** panel Assign dùng chung cho gán và gỡ, nên theo spec hiện hành toast chặn cả hai; việc gỡ phân công không cần gửi qua Zalo. Spec không nói rõ có chủ ý chặn gỡ hay không, và áp cho Admin không.
- **Đề xuất QA:** theo spec hiện hành (toast chặn, panel không mở) cho Staff có Assign; Admin chờ BA xác nhận.

### Q-14 — Ma trận PHÂN QUYỀN: dòng 88 phải thành gì, dòng 90 và 149 là gì?   [KHÔNG CHẶN — Thấp/BA]
- **Trích:** "*Unassign hội thoại* — Admin ✓ · Nhân sự Quản lý ✗ · Staff ✗ | `PHÂN QUYỀN:88`" (CR:22); "`PHÂN QUYỀN` dòng **88 · 90 · 149**" (CR:49); "**PHÂN QUYỀN** cập nhật 3 dòng" (CR:77).
- **Vấn đề:** CR chỉ trích dòng 88; dòng 90, 149 không có nội dung; sau CR cột "Staff" là ✓ (khi có quyền Assign) hay cột mới "Staff có Assign"; "Nhân sự Quản lý" ✓ hay ✗; trùng với việc CR-001 chèn §6 vào cùng file (thứ tự áp, §7).
- **Đề xuất QA:** BA đưa ma trận vào tailieu/ hoặc nêu nội dung 3 dòng sau sửa; QA không viết case cho ma trận (chỉ đối chiếu).

**Tổng: 14 câu.** CHẶN việc viết kỳ vọng (một phần hoặc toàn bộ nhóm case): **Q-02, Q-03 (một phần), Q-05 (một phần), Q-06, Q-07, Q-08, Q-09, Q-10, Q-11, Q-12**. KHÔNG CHẶN kỳ vọng: Q-01, Q-04 (chặn dữ liệu test), Q-13, Q-14.

## 13. Viết được ngay (không chờ BA)

- D1/AC: Staff có Assign gỡ được người khác trong hội thoại mà Staff thuộc danh sách phụ trách; người bị gỡ không còn thấy hội thoại (trong điều kiện Q-06: không có BR18, còn người khác phụ trách).
- Regression R1-R3, R5, R6 (trừ ngưỡng), R10, R13.
- Âm tính: Staff không có Assign không thấy icon; Staff có Assign không dùng được "Thay thế" nếu UI tồn tại (không đóng khi chưa có G034).
- Admin: assign + unassign như cũ.
- Không viết: ngưỡng thời gian, chuỗi thông báo, log, người cuối trong quan hệ BR18, đồng thời, API lỗi.

## 14. Kết quả intake (output block)

```yaml
status: high-risk-pending-confirmation
featureId: "CR-005"
lane: high-risk
flags: [security-test, regression-scope, flaky-risk]
hardGatesTriggered: [security-test]
watch: [multi-tenant-isolation, cross-service-e2e]   # nâng nếu kiểm workspace nằm đúng ở logic kiểm quyền bị sửa (Q-09) hoặc log/realtime đi qua service riêng (Q-08, Q-10)
testDepth: "Happy/Edge/Error đủ BR + exploratory + a11y + automation regression, confirm scope với user"
recommendedTestTypes: [acceptance, system, e2e, regression, exploratory, a11y]
suggestedSkills: [qa-test-design, qa-test-types, qa-e2e-playwright, qa-api-test, qa-test-data, qa-defect, qa-exit-criteria]
reason: "CR đổi quy tắc quyền (Staff có quyền Assign nay unassign được, kể cả người khác và người cuối) và nới kiểm quyền ở cả UI và API: hard gate security-test -> high-risk; thêm regression-scope (phân công ảnh hưởng G002/G017/G019/G027/G029/G011a/G014) và flaky-risk (realtime nhiều phiên). 'Assign' ở đây là assign nhân viên vào HỘI THOẠI (cấp con, G003 BR15), khác assign tài khoản Zalo của CR-001. G034, PHÂN QUYỀN, PROJECT_KNOWLEDGE không có trong tailieu/ và G003 hiện hành (v1.11) chưa cập nhật theo CR."
nextAction:
  - "high-risk-pending-confirmation -> parent DỪNG, hỏi user xác nhận scope (regression + automation + a11y + exploratory + e2e) và chuyển Q-01...Q-14 cho BA/Dev"
  - "Chuyển BA ưu tiên: Q-10 (log bắt buộc hay sau), Q-06 (người cuối), Q-07 (đang mở), Q-09 (API/server), Q-03 (tầm xem), Q-02 (G034)"
  - "Sau khi có trả lời: qa-test-planner theo quy ước 'spec hiện hành + delta CR-005'; KHÔNG viết kỳ vọng cho ngưỡng realtime, chuỗi thông báo, log, người cuối, đồng thời, API lỗi, Thay thế"
```

## Lịch sử cập nhật

| Ngày | Người | Thay đổi |
|---|---|---|
| 2026-10-08 | QA (qa-intake-classifier) | Tạo intake lần đầu cho CR-005: nguồn, baseline trước CR (G003 + G002/G017/G019/G027/G029/G011a/G014/G024), delta D1-D9, bảng dẫn chiếu treo/lệch, bảng 13 dòng spec cần sửa, đối chiếu chéo CR-001 (phân biệt assign cấp TK vs cấp hội thoại), flag + lane (high-risk, hard gate security-test), 9 BR mới + 19 BR hiện hành bị chạm, 14 câu hỏi (Q-01...Q-14), điều kiện dữ liệu, 13 mục regression. |
