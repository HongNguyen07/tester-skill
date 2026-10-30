---
featureId: CR-001
stage: S4
gate: closed
materialOpen: 6
nonMaterialOpen: 4
gateOpenedBy:
gateOpenedAt:
updatedAt: 2026-10-09
---

# Requirement Understanding / Alignment Summary — CR-001: Quyền kết bạn của nhân sự

Trạng thái: **đang Debate — cổng đóng.** Mức trọng yếu ở bảng dưới là đề xuất của AI, chờ người dùng chốt.

## 1. Nguồn và phạm vi đã đọc

Xem mục 1 của `01-requirement-analysis.md`. Nguồn chính: `tailieu/CR-001 - Quyền kết bạn của nhân sự.md` (toàn bộ).
Không có trong `tailieu/`: CR-002, Ma trận phân quyền, PROJECT_KNOWLEDGE.

## 2. Requirement / Use case / Business rule đã trích

| Mã | Tóm tắt | Nguồn | Trạng thái hiểu |
| --- | --- | --- | --- |
| G007 BR18 (mới) | Điều kiện duy nhất để kết bạn: được assign ≥ 1 tài khoản Zalo đang CONNECTED; không đòi quyền "Quản lý tài khoản Zalo", "Quản lý nhóm", không đòi có hội thoại trước; áp cho 4 lối | `CR:119` | `[NGUỒN]` — còn mở Q-03, Q-04, Q-05, Q-06 |
| G007 BR19 (mới) | 4 lối vào bình đẳng về quyền; không lối nào thêm điều kiện riêng | `CR:120` | `[NGUỒN]` — còn mở Q-06 |
| G017 BR24 (mới) | Khối Tìm & Kết bạn hiện với mọi nhân sự được assign ≥ 1 tài khoản Zalo | `CR:121` | `[NGUỒN]` — còn mở Q-03 |
| G017 BR26 (mới) | Nút "Gửi lời mời kết bạn" hiện ngay trên kết quả tìm kiếm; không cần mở hội thoại / nhắn tin trước; gửi qua đúng tài khoản đã dùng để tìm | `CR:122` | `[NGUỒN]` — còn mở Q-01, Q-02 |
| Ma trận §6 (mới) | 5 hành động Danh bạ & Kết bạn, cả 3 vai đều ✓ | `CR:161-169` | `[NGUỒN]` — còn mở Q-05, Q-08 |
| Lối ④ không sửa | Lối trong hội thoại đang chạy đúng qua auto-assign | `CR:88`, `CR:192` | `[NGUỒN]` rõ |
| Không nới bảo mật | Nhân sự vẫn chỉ kết bạn qua tài khoản Zalo mình được assign (G007 BR10) | `CR:147` | `[NGUỒN]` rõ |

## 3. Bảng câu hỏi debate

| Q | Mức | Trích dẫn + nguồn | Vì sao chưa rõ | Các cách hiểu có căn cứ | Ảnh hưởng tới test | Cần ai xác nhận | Trạng thái | Câu trả lời | Ai trả lời · ngày · kênh |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Q-01 | Trọng yếu | `CR:32`, `CR:76`, `CR:122`, `G017:178-179` | CR tả nút nằm sẵn trên kết quả; G017 §7a cần bấm "Tìm & Kết bạn" trước | (a) Giữ luồng G017: khối → bấm "Tìm & Kết bạn" → hồ sơ + "Gửi lời mời kết bạn" — căn cứ `CR:122` "(đúng như §7a đang ghi)", `CR:190` "không đổi quy tắc". (b) Nút kết bạn hiện thẳng trên kết quả, bỏ bước "Tìm & Kết bạn" — căn cứ `CR:32`, sơ đồ `CR:76-78` | Số bước của case lối ③; thời điểm gọi Zalo (G017 BR06); "tài khoản đã dùng để tìm" là tài khoản nào | BA | Mở | | |
| Q-02 | Trọng yếu | `CR:24`, `G017:157`, `G017:278` | Người tìm thấy đã có trong danh bạ / đã có hội thoại nhưng chưa là bạn: có nút Kết bạn trên kết quả không | Tài liệu không nói. G017 BR07 chỉ hiện khối khi SĐT không có trong danh bạ | Có hay không nhóm case "kết quả Người liên hệ chưa là bạn" | BA | Mở | | |
| Q-03 | Trọng yếu | `CR:119`, `CR:121`, `CR:75`, `G017:235`, `G017:237` | BR18 có "CONNECTED", BR24 và E04 không có | (a) Chỉ được assign tài khoản mất kết nối → không thấy khối (theo BR18, sơ đồ `CR:74-75`). (b) Vẫn thấy khối, bấm thì toast E06 (theo BR24, `G017:237`) | Kỳ vọng case "chỉ có tài khoản mất kết nối" ở lối ③ | BA | Mở | | |
| Q-04 | Trọng yếu | `CR:46`, `G007:53`, `CR:143` | Lối ① ②: không đạt điều kiện thì nút ẩn / disable / báo lỗi | Tài liệu trong `tailieu/` không nói. `CR:143` dẫn BR-C06 "ẩn / disable / toast" ở PROJECT_KNOWLEDGE (không có file) | Kỳ vọng mọi case âm ở lối ① ② | BA | Mở | | |
| Q-05 | Trọng yếu | `G017:396`, `G007:152`, `CR:169` | Admin/Owner không được assign tài khoản nào | (a) Admin dùng được mọi tài khoản workspace (theo `G017:396`). (b) Admin cũng cần được assign (theo `CR:169` "điều kiện chung", `G007:152`) | Case cho vai Admin; nội dung dropdown theo vai | BA | Mở | | |
| Q-06 | Trọng yếu | `G012:240`, `CR:120`, `CR:144` | Lối ④: "quyền truy cập hội thoại" hay "được assign tài khoản CONNECTED" | (a) Giữ nguyên G012: theo quyền truy cập hội thoại (`CR:144` "không phải sửa"). (b) Áp BR18: theo assign tài khoản (`CR:119` "áp cho cả 4 lối") | Case lối ④ với hội thoại nhân sự xem được nhưng tài khoản không được assign, và ngược lại | BA | Mở | | |
| Q-07 | Không trọng yếu | `CR:47`, `CR:92` | BR20 và CR-002 không có trong `tailieu/` | — (dẫn chiếu treo) | Không viết case cho danh sách > 10 tài khoản trong CR-001 | BA (ghi chú) | Mở — cô lập | | |
| Q-08 | Không trọng yếu (đề xuất) | `CR:161-169`, `CR:166`, `CR:192` | R-01 không tồn tại; 4 dòng còn lại của ma trận có thuộc phạm vi test CR-001 không | (a) Chỉ test "Gửi lời mời kết bạn" (theo `CR:192`). (b) Test cả 5 dòng (theo `CR:161-169`) | Thêm / bớt 4 nhóm case quyền | Người dùng chốt phạm vi; BA cho R-01 | Mở | | |
| Q-09 | Không trọng yếu | `CR:27`, `G007:55`, `G007:67`, `CR:122` | Nhãn nút từng lối | Theo spec từng lối: ① "Kết bạn" · ② "Thêm bạn" · ③ "Gửi lời mời kết bạn" | Chữ trên nút trong expected result | BA | Mở — cô lập | | |
| Q-10 | Không trọng yếu | `CR:9`, `CR:106`, `CR:108` | Version và số dòng CR dẫn lệch; G007 / G017 chưa có BR mới | — | Không đổi case; ghi chú để BA cập nhật spec | BA (ghi chú) | Mở — cô lập | | |

## 4. Cách hiểu đã xác nhận `[ĐÃ XÁC NHẬN]`

Chưa có.

## 5. Các cách hiểu khác nhau còn tồn tại

Q-01, Q-03, Q-05, Q-06 (mỗi câu hai cách hiểu, đều có căn cứ trong tài liệu — xem bảng).
Q-02, Q-04: tài liệu không nói — **Unresolved / BA Clarification Required**.

## 6. Điểm đã thống nhất và điểm còn mở

- Đã thống nhất: chưa có.
- Còn mở — **trọng yếu**: Q-01, Q-02, Q-03, Q-04, Q-05, Q-06.
- Còn mở — không trọng yếu (cô lập): Q-07, Q-08, Q-09, Q-10.

## 7. Cần BA / Dev / Product xác nhận

| Q | Gửi ai | Nội dung gửi (copy được) |
| --- | --- | --- |
| Q-01 | BA Trân | CR-001 dòng 32 và sơ đồ "Sau khi sửa" ghi nút Kết bạn hiện ngay trên kết quả tìm kiếm, nhưng BR26 lại ghi "đúng như §7a đang ghi" — tức vẫn phải bấm "Tìm & Kết bạn" rồi mới có nút "Gửi lời mời kết bạn". Sau khi sửa, nhân sự có còn phải bấm "Tìm & Kết bạn" không? |
| Q-02 | BA Trân | Khi SĐT tìm ra một người đã có trong danh bạ hoặc đã có hội thoại nhưng chưa là bạn, kết quả có nút Kết bạn không? G017 BR07 chỉ hiện khối kết bạn khi số không có trong danh bạ. |
| Q-03 | BA Trân | Nhân sự chỉ được assign tài khoản Zalo đang mất kết nối: khối Tìm & Kết bạn ẩn (BR18 ghi "đang CONNECTED") hay vẫn hiện rồi báo E06 khi bấm (BR24 không ghi CONNECTED)? |
| Q-04 | BA Trân | Ở lối ① (nút Kết bạn trên header) và lối ② (nút Thêm bạn ở Danh bạ), nhân sự chưa được assign tài khoản CONNECTED nào thì nút ẩn, disable hay bấm được rồi báo lỗi? Thông báo là gì? |
| Q-05 | BA Trân | Admin/Owner không được assign tài khoản Zalo nào có kết bạn được không? G017 §10E ghi Admin chọn được mọi tài khoản workspace, còn ma trận §6 ghi điều kiện chung là được assign ≥ 1 tài khoản. |
| Q-06 | BA Trân | Lối ④ (trong hội thoại): điều kiện hiện nút là "có quyền truy cập hội thoại" như G012 §10C, hay "được assign tài khoản Zalo CONNECTED" như BR18? Hai điều kiện này có trường hợp nào lệch nhau không? |
| Q-07, Q-09, Q-10 | BA Trân | Ghi chú: CR-002 / BR20 chưa có tài liệu; nhãn nút từng lối; G007 và G017 chưa có BR18, BR19, BR24, BR26; số dòng G003 CR dẫn lệch (400→398, 324→322, 615→609). |
| Q-08 | BA Trân | "⚠️ xem R-01" ở dòng Xoá bạn trỏ tới đâu? |

## 8. Ngoài phạm vi / chưa có căn cứ

- Danh sách tài khoản bị cắt ở 10 — thuộc CR-002 (`CR:92`).
- Lối ④ không sửa (`CR:192`); chỉ kiểm hồi quy nếu được yêu cầu.
- Hành vi hiện tại "không có quyền Quản lý tài khoản thì không có nút": không có điều khoản nào ghi (`CR:110`); là quan
  sát của khách (`CR:26-28`).

## 9. Change Proposal / New Requirement Candidate `[ĐỀ XUẤT THAY ĐỔI]`

Chưa có.

## 10. QA coverage bổ sung dự kiến `[QA BỔ SUNG]`

- Đo hiện trạng (baseline) trên build trước khi sửa cho nhân sự có và không có quyền "Quản lý tài khoản Zalo" ở từng
  lối, để chứng minh việc ② "gỡ điều kiện quyền" (`CR:192`).

## 11. Xác nhận mở cổng

- [ ] Điểm trọng yếu còn mở = 0 (hiện còn 6)
- [ ] Người dùng đã đọc mục 2–8
- Người dùng xác nhận: —

## Lịch sử cập nhật

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
| 2026-10-09 | AI (Orchestrator) | Tạo bản đầu sau Requirement Analysis: 10 câu hỏi, 6 đề xuất trọng yếu, cổng đóng |
