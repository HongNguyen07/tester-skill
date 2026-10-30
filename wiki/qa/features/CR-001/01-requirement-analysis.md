---
featureId: CR-001
title: Quyền kết bạn của nhân sự
analyzedAt: 2026-10-09
analyst: Requirement Analyst (AI) — người dùng: Hồng (QA)
---

# Requirement Analysis — CR-001: Quyền kết bạn của nhân sự

Viết tắt tham chiếu: `CR` = `tailieu/CR-001 - Quyền kết bạn của nhân sự.md`; `G007`, `G017`, `G003`, `G012`,
`G002`, `G032` = file tương ứng trong `tailieu/` (G032 = bản "Đổi tên gợi nhớ (1)"). Số sau dấu `:` là số dòng.

## 1. Nguồn và phạm vi đã đọc

| # | Tệp | Version ghi trong tệp | Phạm vi đã đọc | Ghi chú |
| ---: | --- | --- | --- | --- |
| 1 | `CR-001 - Quyền kết bạn của nhân sự.md` | Last updated 2026-09-24 | Toàn bộ (200 dòng) | Nguồn chính |
| 2 | `G007 - Kết bạn.md` | 1.1 (2026-07-01) | §2, UC-01, UC-01b, E01–E08, BR01–BR17, AC, OOS | CR ghi "G007 v1.2 → v1.3"; file đang là 1.1 |
| 3 | `G017 - Tìm kiếm hợp nhất (2).md` | 1.1 (2026-07-29) | §1, AF01, AF02, E03–E07, BR03–BR23, §10C–10E | CR ghi "v1.1 → v1.2" |
| 4 | `G003 - Chat.md` | 1.11 | BR18, BR26, §10B, AC BR26 | Chỉ các dòng CR dẫn |
| 5 | `G012 - Nút Kết bạn trong hội thoại (2).md` | 1.1 | §10C | Chỉ dòng CR dẫn |
| 6 | `G002 - Chia sẻ tài khoản Zalo cho Staff.md` | 1.2 | Các dòng về quyền "Quản lý tài khoản Zalo" và assign | Đọc lướt bằng tìm kiếm |
| 7 | `G032 - Đổi tên gợi nhớ (1).md` | 1.0 | BR06 | Chỉ dòng CR dẫn |

Chưa đọc / không có trong `tailieu/`: **CR-002**, **Ma trận phân quyền**, **PROJECT_KNOWLEDGE**, **Sổ theo dõi yêu
cầu**. Phần còn lại của G003, G012, G002 chưa đọc toàn văn.

## 2. Mục tiêu và phạm vi feature

- `[NGUỒN]` Nhân sự không có quyền "Quản lý tài khoản Zalo" vẫn phải kết bạn được (`CR:6`).
- `[NGUỒN]` Khách muốn kết bạn ngay từ kết quả tìm kiếm, không phải nhắn tin trước (`CR:14`, `CR:32`, `CR:34`).
- `[NGUỒN]` BA phân loại là CR: "nghiệp vụ đã có trong G007 và G017, phiếu này viết rõ điều đang nói chưa rõ.
  Không tạo Spec mới, không đổi quy tắc" (`CR:190`).
- `[NGUỒN]` Việc cho Dev: ① hiện nút Kết bạn ngay trên kết quả tìm kiếm, gửi qua đúng tài khoản đã dùng để tìm;
  ② gỡ điều kiện quyền "Quản lý tài khoản Zalo" khỏi các lối vào kết bạn, giữ điều kiện assign là duy nhất;
  lối ④ không phải sửa (`CR:192`).

## 3. Actor, precondition, trigger

| Mục | Nội dung | Nguồn | Nhãn |
| --- | --- | --- | --- |
| Actor | Admin/Owner · Nhân viên quản lý · Nhân viên thường — cả ba "Toàn bộ thao tác" | `G007:43-45` | `[NGUỒN]` |
| Actor (tên trong CR) | Admin · NS Quản lý · Nhân sự | `CR:161` | `[NGUỒN]` |
| Điều kiện (mới) | Được assign ≥ 1 tài khoản Zalo đang CONNECTED | `CR:46`, `CR:119` | `[NGUỒN]` |
| Điều kiện tiên quyết UC-01 hiện hành | "Có ít nhất 1 tài khoản Zalo đang hoạt động trong workspace" | `G007:53` | `[NGUỒN]` |
| Trigger | Mở một trong 4 lối vào kết bạn | `CR:46` | `[NGUỒN]` |

## 4. Use case và luồng

| Mã | Tên | Luồng theo nguồn | Nguồn |
| --- | --- | --- | --- |
| Lối ① — G007 UC-01 | Kết bạn từ header màn danh sách hội thoại | Click **Kết bạn** → popup (dropdown tài khoản bắt buộc, mặc định trống + ô SĐT + Tìm kiếm) → hồ sơ + **Kết bạn**, **Nhắn tin** → gửi lời mời qua tài khoản đã chọn; nút đổi thành **Đã gửi lời mời** + **Thu hồi** | `G007:51-61` |
| Lối ② — G007 UC-01b | Kết bạn từ màn Danh bạ | Click **Thêm bạn** → cùng popup như UC-01 | `G007:63-69` |
| Lối ③ — G017 AF02 | Khối **Tìm & Kết bạn** trong tìm kiếm | SĐT không có trong danh bạ → khối kết bạn (ô chọn tài khoản + nút **"Tìm & Kết bạn"**) → bấm mới tra cứu Zalo → hồ sơ + nút **"Gửi lời mời kết bạn"** | `G017:160-180` |
| Lối ④ — G012 | Nút Kết bạn trong hội thoại đang mở | Dùng luôn tài khoản Zalo của hội thoại; không có bước chọn tài khoản | `CR:88`, `G012:240` |
| Luồng 4 bước của CR | Mở lối vào → chọn tài khoản → nhập SĐT / chọn người → bấm Kết bạn | Bảng "các bước thực tế" | `CR:44-49` |

## 5. Business rule

### 5.1 Rule mới do CR bổ sung

| Mã | Nội dung (sát nguyên văn) | Loại | Nguồn | Nhãn |
| --- | --- | --- | --- | --- |
| G007 BR18 (mới) | Kết bạn không đòi quyền quản trị nào. Điều kiện duy nhất: nhân sự được assign ít nhất 1 tài khoản Zalo đang CONNECTED (G002). KHÔNG yêu cầu quyền "Quản lý tài khoản Zalo", KHÔNG yêu cầu quyền "Quản lý nhóm", KHÔNG yêu cầu phải có hội thoại trước. Áp cho cả 4 lối vào | Quyền | `CR:119` | `[NGUỒN]` |
| G007 BR19 (mới) | Bốn lối vào kết bạn, bình đẳng về quyền: ① header danh sách hội thoại (UC-01) · ② màn Danh bạ (UC-01b) · ③ khối Tìm & Kết bạn (G017) · ④ trong hội thoại đang mở (G012). Không lối nào được đặt thêm điều kiện quyền riêng. Lối ④ cần có hội thoại chỉ vì bản chất vị trí | Quyền | `CR:120` | `[NGUỒN]` |
| G017 BR24 (mới) | Khối Tìm & Kết bạn hiện với mọi nhân sự được assign ≥ 1 tài khoản Zalo (nhất quán E04 và G007 BR18). Không đòi quyền quản trị nào | Quyền | `CR:121` | `[NGUỒN]` |
| G017 BR26 (mới) | Nút "Gửi lời mời kết bạn" hiện NGAY trên kết quả tìm kiếm (đúng như §7a đang ghi). Không yêu cầu mở hội thoại, không yêu cầu nhắn tin trước. Lời mời gửi qua đúng tài khoản Zalo đã dùng để tìm — không hỏi lại người dùng chọn tài khoản | Nghiệp vụ | `CR:122` | `[NGUỒN]` |
| Ma trận phân quyền §6 (mới) | 5 dòng: Gửi lời mời · Thu hồi · Chấp nhận / Từ chối · Xoá bạn · Đặt tên gợi nhớ — Admin, NS Quản lý, Nhân sự đều ✓. Điều kiện chung: được assign ≥ 1 tài khoản Zalo đang CONNECTED; không hành động nào đòi quyền "Quản lý tài khoản Zalo" | Quyền | `CR:161-169` | `[NGUỒN]` |

Bốn BR mới **chưa có** trong file G007 và G017 hiện hành (G007 dừng ở BR17; G017 dừng ở BR23). Coi là spec chưa
cập nhật — xem Q-10.

### 5.2 Rule hiện hành CR dựa vào

| Mã | Nội dung | Nguồn | Nhãn |
| --- | --- | --- | --- |
| G007 BR01 | Gửi lời mời luôn thực thi qua tài khoản Zalo được chọn trong dropdown — không tự động chọn | `G007:143` | `[NGUỒN]` |
| G007 BR10 | Dropdown chỉ liệt kê tài khoản Zalo đang hoạt động mà user hiện tại được assign (theo G002) | `G007:152` | `[NGUỒN]` |
| G007 OOS07 | Phân quyền riêng theo role cho từng thao tác trong Danh bạ — ngoài phạm vi | `G007:328` | `[NGUỒN]` |
| G017 BR06 | Hệ thống không bao giờ tự gọi sang Chat-Zalo Service khi user gõ; chỉ gọi khi user chủ động bấm "Tìm & Kết bạn" | `G017:277` | `[NGUỒN]` |
| G017 BR07 | Khối "Tìm & Kết bạn" chỉ hiện khi đầu vào là SĐT **và** số đó không có trong danh bạ | `G017:278` | `[NGUỒN]` |
| G017 BR08 | Ô chọn tài khoản chỉ liệt kê tài khoản user được assign qua G002 | `G017:279` | `[NGUỒN]` |
| G017 BR09 | Chỉ có 1 tài khoản khả dụng → tự chọn sẵn và ẩn ô chọn | `G017:280` | `[NGUỒN]` |
| G017 BR10 | Mặc định chọn tài khoản user dùng gần nhất | `G017:281` | `[NGUỒN]` |
| G017 §10E | Admin/Owner: ô chọn "Mọi tài khoản trong workspace"; Staff được assign: "Chỉ tài khoản được assign"; Staff chưa assign: trạng thái rỗng E04 | `G017:394-399` | `[NGUỒN]` |
| G003 BR26 (Case A) | Mở hội thoại từ tham chiếu liên hệ, chưa có hội thoại → tạo mới, auto-assign cho người click; "thấy và nhắn được ngay dù không có quyền BR18" | `G003:322`, `G003:609` | `[NGUỒN]` |
| G012 §10C | Thấy và click nút "Kết bạn" — Admin: Có · Staff: Có (nếu có quyền truy cập hội thoại — G002) | `G012:240` | `[NGUỒN]` |
| G032 BR06 | Có quyền xem hội thoại hoặc xem danh bạ là đổi tên được; KHÔNG yêu cầu quyền "Quản lý tài khoản Zalo" | `G032:140` | `[NGUỒN]` |

## 6. Mã lỗi, thông báo (nguyên văn)

| Mã | Nguyên văn | Nguồn |
| --- | --- | --- |
| G017 E04 | Staff chưa được assign tài khoản Zalo nào → trạng thái rỗng: *"Bạn chưa được phân quyền tài khoản Zalo nào"* | `G017:235` |
| G017 E06 | Bấm "Tìm & Kết bạn" nhưng tài khoản Zalo đã chọn đang Ngắt kết nối → toast: *"Tài khoản Zalo «[tên]» đang mất kết nối. Vui lòng chọn tài khoản khác hoặc kết nối lại."* | `G017:237` |
| G017 E07 | Bấm "Tìm & Kết bạn" với người đã là bạn bè → toast: *"Đã là bạn bè"* + nút **"Mở hội thoại"** | `G017:238` |
| G007 E01 | Dropdown tài khoản Zalo chưa được chọn → inline: "Chọn tài khoản Zalo" | `G007:128` |
| G007 E03 | Tài khoản Zalo được chọn bị ngắt kết nối → toast: "Lỗi kết nối. Vui lòng thử lại" | `G007:130` |

CR không định nghĩa mã lỗi hay thông báo mới.

## 7. Trạng thái và chuyển trạng thái

Không áp dụng cho phạm vi CR — CR ghi State Machine không sửa (`CR:154`); "đây là quy tắc hiển thị nút, không sinh
dữ liệu" (`CR:146`).

## 8. Diễn giải, giả định, QA observation

| # | Nội dung | Nhãn | Liên quan tới |
| ---: | --- | --- | --- |
| 1 | Hiện trạng "không có quyền Quản lý tài khoản thì không có nút Kết bạn" là điều khách quan sát (`CR:26-28`) và sơ đồ CR vẽ (`CR:56-59`). Không điều khoản hiện hành nào ghi điều kiện này (`CR:110`). Muốn chứng minh "đã gỡ" cần đo hiện trạng trên build trước khi sửa | `[QA BỔ SUNG]` | BR18, CR:192 ② |
| 2 | "Tài khoản đang hoạt động" (G007) và "CONNECTED" (CR) có vẻ cùng nghĩa; G007 không dùng chữ CONNECTED | `[DIỄN GIẢI AI]` | BR18, BR10 |
| 3 | Mã "BR18" trong G003 (quyền "Hiển thị cuộc hội thoại chưa gắn nhân sự", `G003:314`) khác "G007 BR18" mới của CR; câu trích G003 BR26 "dù không có quyền BR18" nói về BR18 của G003 | `[DIỄN GIẢI AI]` | BR18 |

## 9. Điểm chưa rõ (chuyển sang Debate)

| # | Loại | Trích dẫn + nguồn | Vì sao chưa rõ | Đề xuất mức |
| ---: | --- | --- | --- | --- |
| 1 | Nhiều cách hiểu | `CR:32` "tìm ra người → nút Kết bạn hiện ngay trên kết quả"; `CR:76` "Thấy khách trong kết quả tìm kiếm kèm nút Kết bạn ngay tại đó"; `CR:122` "(đúng như §7a đang ghi)"; `G017:178-179` bấm "Tìm & Kết bạn" rồi mới hiện hồ sơ + "Gửi lời mời kết bạn" | Mô tả của CR đọc như nút nằm sẵn trên kết quả; G017 §7a vẫn cần bấm "Tìm & Kết bạn" trước. Hai cách cho số bước và thời điểm gọi Zalo khác nhau | Trọng yếu |
| 2 | Thiếu | `CR:24` "Tìm thấy người dùng → Cho phép Kết bạn luôn"; `G017:157` SĐT có trong danh bạ thì không hiện khối; `G017:278` BR07 | CR không nói trường hợp người tìm thấy đã có trong danh bạ / đã có hội thoại nhưng chưa là bạn: có nút Kết bạn trên kết quả không | Trọng yếu |
| 3 | Mâu thuẫn | `CR:119` "được assign ít nhất 1 tài khoản Zalo đang CONNECTED"; `CR:121` "mọi nhân sự được assign ≥1 tài khoản Zalo" (không có chữ CONNECTED); `CR:75` không đạt → "Không thấy khối… G017 E04"; `G017:235` E04 chỉ nói "chưa được assign"; `G017:237` E06 xử lý tài khoản mất kết nối bằng toast sau khi bấm | Nhân sự chỉ được assign tài khoản đang mất kết nối: khối ③ ẩn (theo BR18 / sơ đồ) hay vẫn hiện rồi báo E06 (theo BR24 / G017) | Trọng yếu |
| 4 | Thiếu | `CR:46` bước 1 có điều kiện; `G007:53` điều kiện tiên quyết; `CR:143` "BR-C06 (ẩn / disable / toast)" nằm ở PROJECT_KNOWLEDGE (không có) | Lối ① và ②: nhân sự không đạt điều kiện thì nút **Kết bạn** / **Thêm bạn** ẩn, disable, hay bấm được rồi báo lỗi — không tài liệu nào trong `tailieu/` nói | Trọng yếu |
| 5 | Mâu thuẫn | `G017:396` Admin/Owner: ô chọn "Mọi tài khoản trong workspace"; `G007:152` BR10 dropdown chỉ tài khoản "được assign"; `CR:169` "Điều kiện chung cho cả 5 dòng: được assign ≥1…" (bảng có cột Admin) | Admin/Owner không được assign tài khoản nào: kết bạn được không, và dropdown / ô chọn liệt kê gì ở từng lối | Trọng yếu |
| 6 | Mâu thuẫn | `G012:240` "Staff: Có (nếu có quyền truy cập hội thoại — G002)"; `CR:120` "Không lối nào được đặt thêm điều kiện quyền riêng"; `CR:144` G012 §10C "đã ghi đúng — không phải sửa" | Lối ④: điều kiện là "quyền truy cập hội thoại" (G012) hay "được assign tài khoản CONNECTED" (BR18), và hai điều kiện có luôn trùng nhau không (vd hội thoại chưa gán ai mà nhân sự xem được) | Trọng yếu |
| 7 | Dẫn chiếu treo | `CR:47` "(BR20 — xem CR-002)"; `CR:92` "Bước 2 là phạm vi của [CR-002]" | G007 không có BR20; G017 BR20 là rule khác (xoá bản ghi nhớ, `G017:299`); CR-002 không có trong `tailieu/` | Không trọng yếu (CR tự nói thuộc CR-002) |
| 8 | Dẫn chiếu treo + phạm vi | `CR:161-169` bảng 5 dòng; `CR:166` "⚠️ xem R-01"; `CR:192` việc cho Dev chỉ có ① và ② | R-01 không có trong CR hay tài liệu nào. Bốn dòng Thu hồi / Chấp nhận-Từ chối / Xoá bạn / Đặt tên gợi nhớ có thuộc phạm vi test của CR-001 không, khi việc cho Dev không nhắc | Không trọng yếu nếu ngoài phạm vi test; cần người dùng chốt phạm vi |
| 9 | Mơ hồ | `CR:27` "Kết bạn ngay"; `G007:55` **Kết bạn**; `G007:67` **Thêm bạn**; `CR:122` "Gửi lời mời kết bạn" | Nhãn nút ở từng lối sau khi sửa | Không trọng yếu |
| 10 | Dẫn chiếu lệch | `CR:9` "G007 v1.2" (file là 1.1); `CR:106` `G003:400` (nội dung nằm ở `G003:398`); `CR:108` `G003:324` · `G003:615` (nội dung ở `G003:322` · `G003:609`); G007 / G017 chưa có BR18, BR19, BR24, BR26 | Spec chưa cập nhật theo CR; số dòng CR dẫn lệch vài dòng | Không trọng yếu — ghi chú cho BA |

## 10. Tự rà soát

- [x] Mọi mã ở mục 4–6 tìm thấy trong nguồn (BR mới của G007 / G017 chỉ có trong CR — đã ghi rõ)
- [x] Không mục `[NGUỒN]` nào thiếu tham chiếu
- [x] Mâu thuẫn giữa nguồn đã liệt kê đủ hai phía
- [x] Mục 9 không chứa câu trả lời do AI tự chọn
- Giới hạn: G003, G012, G002 mới đọc các dòng liên quan, chưa đọc toàn văn; số dòng lấy từ file ngày 2026-10-09
