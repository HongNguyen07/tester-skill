# CR-001 — Câu hỏi QA gửi BA

| | |
| --- | --- |
| **Phiếu** | CR-001 — Quyền kết bạn của nhân sự (Last updated 2026-09-24) |
| **Gửi** | Trân (BA) |
| **Từ** | Hồng (QA) |
| **Ngày gửi** | 2026-10-09 |
| **Tài liệu đã đối chiếu** | CR-001 · G007 v1.1 · G017 v1.1 · G003 v1.11 · G012 v1.1 · G002 v1.2 · G032 v1.0 |

Chị Trân trả lời giúp em vào cột **BA trả lời**. Với câu có sẵn phương án, chị chỉ cần ghi (a) hoặc (b); nếu
không phương án nào đúng thì ghi cách đúng.

QA cần câu trả lời cho **6 câu ở Phần A** trước khi viết test case. Phần B không chặn việc.

## Phần A — Cần trả lời trước khi viết test case

| # | Câu hỏi | Tài liệu đang ghi | Phương án | BA trả lời |
| --- | --- | --- | --- | --- |
| **Q-01** | Sau khi sửa, ở ô tìm kiếm nhân sự có còn phải bấm **"Tìm & Kết bạn"** rồi mới thấy nút gửi lời mời không? | **CR-001 §1 (dòng 32):** "tìm ra người → nút Kết bạn hiện ngay trên kết quả".<br>**CR-001 sơ đồ "Sau khi sửa":** "Thấy khách trong kết quả tìm kiếm kèm nút Kết bạn ngay tại đó".<br>**CR-001 §2.2, BR26:** nút hiện ngay "(đúng như §7a đang ghi)".<br>**G017 AF02 bước 6a–7a:** bấm "Tìm & Kết bạn" → mới tra cứu → hiện hồ sơ + nút "Gửi lời mời kết bạn". | **(a)** Giữ luồng G017: khối kết bạn → bấm "Tìm & Kết bạn" → hồ sơ + "Gửi lời mời kết bạn".<br>**(b)** Nút kết bạn nằm thẳng trên kết quả, bỏ bước "Tìm & Kết bạn". | |
| **Q-02** | Số điện thoại tìm ra một người **đã có trong danh bạ hoặc đã có hội thoại nhưng chưa là bạn** — kết quả có nút Kết bạn không? | **CR-001 §1:** "Tìm thấy người dùng → Cho phép Kết bạn luôn".<br>**G017 BR07:** khối "Tìm & Kết bạn" chỉ hiện khi số **không có** trong danh bạ.<br>**G017 AF01 bước 4a.iii:** số có trong danh bạ → không hiện khối. | Tài liệu chưa nói trường hợp này. | |
| **Q-03** | Nhân sự **chỉ được assign tài khoản Zalo đang mất kết nối** — khối "Tìm & Kết bạn" ẩn hay vẫn hiện? | **CR-001 §2.2, G007 BR18:** "được assign ít nhất 1 tài khoản Zalo **đang CONNECTED**".<br>**CR-001 §2.2, G017 BR24:** "mọi nhân sự được assign ≥1 tài khoản Zalo" (không có chữ CONNECTED).<br>**G017 E04:** chỉ chặn khi "chưa được assign tài khoản Zalo nào".<br>**G017 E06:** tài khoản đã chọn mất kết nối → toast sau khi bấm. | **(a)** Không thấy khối (theo BR18 và sơ đồ "Sau khi sửa").<br>**(b)** Vẫn thấy khối, bấm thì báo toast E06 (theo BR24 và G017). | |
| **Q-04** | Ở **nút Kết bạn trên header** (lối ①) và **nút Thêm bạn ở Danh bạ** (lối ②): nhân sự chưa được assign tài khoản CONNECTED nào thì nút **ẩn, disable, hay bấm được rồi báo lỗi**? Nếu báo lỗi thì nội dung thông báo là gì? | **CR-001 §1b, bước 1:** mở lối vào cần "được assign ≥1 tài khoản Zalo đang CONNECTED".<br>**G007 UC-01, UC-01b:** điều kiện tiên quyết "Có ít nhất 1 tài khoản Zalo đang hoạt động trong workspace"; không mô tả trường hợp không đạt.<br>**CR-001 §2.4:** dẫn BR-C06 "ẩn / disable / toast" trong PROJECT_KNOWLEDGE — QA chưa có tài liệu này. | Tài liệu QA đang có chưa nói. | |
| **Q-05** | **Admin/Owner không được assign tài khoản Zalo nào** có kết bạn được không? Danh sách tài khoản của Admin ở từng lối gồm những tài khoản nào? | **G017 §10E:** Admin/Owner — ô chọn tài khoản "Mọi tài khoản trong workspace".<br>**G007 BR10:** dropdown chỉ liệt kê tài khoản "user hiện tại được assign".<br>**CR-001 §2.5, dưới bảng ma trận:** "Điều kiện chung cho cả 5 dòng: được assign ≥1 tài khoản Zalo đang CONNECTED" (bảng có cột Admin). | **(a)** Admin dùng được mọi tài khoản của workspace, không cần assign.<br>**(b)** Admin cũng phải được assign như nhân sự. | |
| **Q-06** | Ở **lối ④ (trong hội thoại đang mở)**, điều kiện hiện nút Kết bạn là gì? Có trường hợp nào nhân sự xem được hội thoại nhưng tài khoản Zalo của hội thoại không được assign cho họ (hoặc ngược lại) không? | **G012 §10C:** Staff thấy nút "nếu có quyền truy cập hội thoại — G002".<br>**CR-001 §2.2, G007 BR18:** điều kiện duy nhất là được assign tài khoản CONNECTED, "áp cho cả 4 lối vào".<br>**CR-001 §2.2, G007 BR19:** "Không lối nào được đặt thêm điều kiện quyền riêng".<br>**CR-001 §2.4:** G012 §10C "đã ghi đúng — không phải sửa". | **(a)** Theo quyền truy cập hội thoại (giữ nguyên G012).<br>**(b)** Theo assign tài khoản CONNECTED (BR18). | |

## Phần B — Không chặn việc, nhờ chị xác nhận hoặc cập nhật tài liệu

| # | Nội dung | Tài liệu đang ghi | BA trả lời |
| --- | --- | --- | --- |
| **Q-07** | **BR20** và **CR-002** chưa có tài liệu. QA sẽ **không** test danh sách trên 10 tài khoản trong CR-001. | CR-001 §1b, bước 2: "(BR20 — xem CR-002)". G007 chưa có BR20; BR20 của G017 là rule khác (xoá bản ghi nhớ tra cứu). | |
| **Q-08** | "**⚠️ xem R-01**" ở dòng Xoá bạn trỏ tới đâu? Ngoài ra, bốn dòng Thu hồi · Chấp nhận / Từ chối · Xoá bạn · Đặt tên gợi nhớ có thay đổi gì cần test trong CR-001 không? | CR-001 §2.5, bảng ma trận §6. CR-001 §2.7 "Việc cho Dev" chỉ nhắc gửi lời mời kết bạn. | |
| **Q-09** | Nhãn nút ở từng lối sau khi sửa: ① "Kết bạn" · ② "Thêm bạn" · ③ "Gửi lời mời kết bạn" — đúng không? | CR-001 §1 có nhắc "Kết bạn ngay" (lời khách); G007 UC-01, UC-01b; G017 AF02. | |
| **Q-10** | Ghi chú cập nhật tài liệu:<br>• G007 đang là v1.1 và G017 v1.1, **chưa có** BR18, BR19, BR24, BR26.<br>• Số dòng CR-001 dẫn sang G003 bị lệch: `G003:400` → nội dung ở dòng 398; `G003:324` → 322; `G003:615` → 609.<br>• QA chưa có: Ma trận phân quyền, PROJECT_KNOWLEDGE. | CR-001 dòng 9, §2.1. | |

## Phản hồi của BA

| | |
| --- | --- |
| **Người trả lời** | |
| **Ngày trả lời** | |
| **Ghi chú thêm** | |
