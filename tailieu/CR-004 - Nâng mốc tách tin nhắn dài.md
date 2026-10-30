# [CR-004] Nâng mốc tách tin nhắn dài

| Trường | Nội dung |
|--------|----------|
| **Mã yêu cầu** | **CR-004** |
| **Tiêu đề** | Nâng mốc tách tin nhắn từ **1.000** lên **2.000 ký tự** *(trần thật của Zalo)* |
| **Ngày nhận** | 2026-09-23 |
| **Người yêu cầu** | **Khách hàng nội bộ (Mingi)** |
| **Mức ưu tiên** | **Cao** |
| **Owner (BA)** | Trân (BA) |
| **Last updated** | **2026-09-29** |
| **Phân loại** | **CR** — nghiệp vụ **đã có** trong Spec *(G003 BR03 — auto tách ở mốc 1.000)*, nay **đổi con số** |

---

## 1.1 Bối cảnh

Nhân sự gửi một bài giới thiệu khóa học dài **2.069 ký tự**. Trên **Zalo Web** bài này gửi **một tin liền mạch**. Trên **Gopany** nó bị **tách thành 3 tin**.

Gopany đang chạy **đúng tài liệu**: **G003 BR03** quy định vượt **1.000 ký tự** thì tự tách, **BR03b** cắt tại dấu xuống dòng gần nhất. Chạy lại đúng quy tắc trên bài đó ra **932 / 999 / 135 ký tự** — khớp 3 tin nhân sự thấy.

**Khoảng trống:** con số **1.000** đang thấp hơn nhiều so với mức Zalo thực tế cho phép, nên khách nhận được một bài giới thiệu **vỡ làm ba mẩu** thay vì đọc liền một mạch.

## 1.2 Cơ sở của con số mới

**Mốc tách = 2.000 ký tự** — đây là **trần của Zalo**, không phải con số hệ thống tự đặt. Xác nhận qua **log hub**: một đoạn dài gửi từ app Zalo bị **chính Zalo tách** làm hai ở mốc này, gửi lại cho kết quả giống hệt.

**Hai mốc chốt trước đó đều cao hơn trần thật** — 2.200 *(23/09)* và 3.000 *(28/09)*. Gửi quá 2.000 thì Zalo tự cắt: **điểm cắt do Zalo quyết**, và hệ thống nhận về **nhiều tin hơn số đã gửi**.

> Con số **1.000** trong tài liệu cũ ghi là *"giới hạn Zalo API"* — thực tế chưa có tài liệu API nào nêu giới hạn, đó là mức hệ thống tự đặt. Nay đã sửa đúng bản chất.

## 1.3 Bốn điểm chốt

| # | Điểm | Chốt |
|---|---|---|
| **1** | **Mốc tách** | **1.000 → 2.000 ký tự.** Vượt mốc mới tách |
| **2** | **Lý do của con số** | Ghi rõ là **mức hệ thống tự đặt theo kết quả test**, **không phải** giới hạn do Zalo công bố |
| **3** | **Trần nội dung Tin nhắn mẫu** | Đổi từ con số cứng sang **luật: trần mẫu = 3 × mốc tách**. Hiện là **6.000 ký tự** *(3 × 2.000)* — mốc tách đổi thì trần mẫu tự đổi theo, không phải sửa tài liệu lại |
| **3b** | **Ai tách** | **Hệ thống vẫn tự tách**, dù Zalo cũng tự tách ở 2.000. Lý do: mình cắt thì **kiểm soát được điểm cắt** theo BR03b *(xuống dòng, rồi khoảng trắng, không vỡ từ)*, và **mỗi tin gửi đi khớp 1:1 với một tin trên Zalo** — cần cho lịch sử chat, trạng thái gửi và nút Retry từng phần |
| **4** | **Ô soạn tin** | **Không báo gì** — không counter, không cảnh báo "sắp bị tách", không chặn gõ, không chặn gửi. Giữ nguyên hành vi hiện tại |

## 1.4 Những gì KHÔNG đổi

- **Cách cắt** — vẫn cắt tại **dấu xuống dòng** gần nhất trước mốc; không có thì cắt tại **khoảng trắng**; không vỡ từ *(G003 BR03b)*
- **Cách gửi** — các phần gửi **nối tiếp, đúng thứ tự**; mỗi phần là **một tin độc lập**, phần nào lỗi thì **Retry riêng** phần đó *(G003 BR03c)*
- **Ô soạn tin** — vẫn **không giới hạn độ dài**, không chặn gõ, không chặn gửi
- **Cách đếm** — vẫn đếm **plaintext**, không tính markup định dạng, không tính phần quote khi trả lời *(G009 BR12)*

## 1.5 Kết quả mong đợi

| Độ dài tin | Hiện tại *(mốc 1.000)* | Sau CR *(mốc 2.000)* |
|---|---|---|
| ≤ 1.000 ký tự | 1 tin | 1 tin *(không đổi)* |
| 1.500 ký tự | 2 tin | **1 tin** |
| 2.000 ký tự | 2 tin | **1 tin** |
| 3.000 ký tự | 3 tin | **2 tin** |

> Mốc 2.000 **không gộp được mọi tin dài về một tin** — Zalo chặn ở đó. Cái đạt được là **giảm số mảnh** và **mình chọn được chỗ cắt**.

---

## 1.6 Hai câu hỏi cho dev

| # | Câu hỏi | Vì sao cần |
|---|---|---|
| **1** | **Trần 2.000 có áp giống nhau cho tin gửi QUA HUB không?** | Log hiện có đo tin gửi **từ điện thoại**; đường **qua hub/API** có thể khác. Gửi thử một tin 2.000 ký tự qua hub — **Zalo không tách lại** là xác nhận xong. Nếu vẫn tách, báo lại BA con số thật |
| **2** | **Đếm độ dài bằng đơn vị nào?** | Log hub đếm theo **ký tự**, nên tài liệu ghi ký tự là đúng. Còn một điểm nhỏ: **emoji** tính là 1 hay 2 đơn vị tuỳ cách đếm của mã nguồn — tin nhiều emoji có thể bị tách sớm hơn dự tính. Không chặn gì |

---

## 1.7 Spec cần đọc

| Doc | Bản | Phần liên quan |
|---|---|---|
| **G003 — Chat** | **1.23** | **BR03** mốc tách = **2.000** + lý do con số *(trần Zalo, có bằng chứng)* · BR03b/BR03c **giữ nguyên** · AC |
| **G005 — Tin nhắn mẫu** | **1.7** | **BR08** trần nội dung mẫu → **luật 3 × mốc tách = 6.000** |
| **G009 — Tính năng bổ sung Chat** | **1.15** | **BR12** kế thừa mốc mới; cách đếm plaintext giữ nguyên |
| **G015 — Thumbnail khi gửi Link** | **1.4** | Kế thừa mốc mới |

## 1.8 Kết luận BA

| Trường | Nội dung |
|---|---|
| **Trạng thái** | 🔄 **Đã sửa tài liệu · chờ dev làm** |
| **Chặn Prod** | **Không còn chặn** — mốc 2.000 không vượt trần Zalo nên không có rủi ro gửi thất bại. Câu 1 chỉ là xác nhận thêm |
| **Không chặn** | Câu 2 — trả lời lúc nào cũng được, BA bổ sung vào BR03 sau |

---

## 2. Theo dõi phiếu

Trạng thái và danh sách đầy đủ mọi phiếu: xem **[SỔ THEO DÕI YÊU CẦU]** — đó là nơi **duy nhất** cập nhật trạng thái. Phiếu này không giữ bảng riêng.
