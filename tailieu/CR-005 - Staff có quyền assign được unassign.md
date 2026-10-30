# [CR-005] Staff có quyền assign được unassign

| Trường | Nội dung |
|--------|----------|
| **Mã yêu cầu** | **CR-005** |
| **Tiêu đề** | Nhân sự được cấp quyền assign **gỡ được** người phụ trách khỏi hội thoại, không còn chỉ Admin |
| **Ngày nhận** | 2026-10-06 |
| **Người yêu cầu** | Nội bộ — Trân (CSKH Team Lead) |
| **Spec bị sửa** | **G003 — Chat** `v1.23` *(chính)* · **G034** `v1.0` · **PHÂN QUYỀN — Ma trận tổng hợp** |
| **Mức ưu tiên** | **Cao** — chặn việc tái phân bổ hằng ngày của đội CSKH |

---

## 2.1 Điều khoản hiện hành

| Mã | Nội dung hiện tại | Vị trí |
|---|---|---|
| **BR15** | *"Admin và Staff có quyền assign đều có thể **assign** nhân viên vào hội thoại; chỉ **Admin** có thể **unassign**"* — lý do ghi: *"Phân tách quyền assign (Staff + Admin) và unassign (Admin only)"* | `G003:313` |
| **UC-07 b5** | *"**[Admin only]** Có thể unassign nhân viên bằng cách bỏ chọn checkbox → click `Lưu`"* | `G003:197` |
| **AC** | *"Staff có quyền assign → có thể assign nhân viên khác, **không thể** unassign"* | `G003:611` |
| **BR10** | *"Kiểu **Thay thế** chỉ Admin dùng được — vì nó gỡ người, mà **gỡ chỉ Admin** (G003 BR15). Nhân sự có quyền assign **không thấy** hộp chọn"* | `G034:184` |
| **Ma trận** | *Unassign hội thoại* — Admin ✓ · Nhân sự Quản lý ✗ · Staff ✗ | `PHÂN QUYỀN:88` |

## 2.2 Đề nghị đổi thành

| Mã | Nội dung mới | Lý do đổi |
|---|---|---|
| **BR15** | **Admin và Staff có quyền assign đều **assign** VÀ **unassign** được** nhân viên khỏi hội thoại. Quyền gán và quyền gỡ **đi liền nhau**, không tách. Phạm vi vẫn bị khoá trong **hội thoại người đó được xem** (G002 · G003 BR18) | Gán và gỡ là **hai nửa của cùng một việc**: điều phối ai làm gì. Tách đôi thì chỉ còn một chiều chạy được |
| | **Gỡ được bất kỳ ai**, kể cả người khác, kể cả **người cuối cùng** *(hội thoại trở về trạng thái "chưa phân công")* | Chốt qua interview 06/10 |
| | **Mọi lần gỡ đều ghi log**: ai gỡ · gỡ ai · khỏi hội thoại nào · lúc nào | Mở quyền cho nhiều người thì phải lần được dấu vết. Không cần màn hình xem — log hệ thống là đủ |
| **UC-07 b5** | **[Admin hoặc Staff có quyền assign]** bỏ chọn checkbox → `Lưu` | Khớp BR15 mới |
| **BR10** *(G034)* | **GIỮ NGUYÊN** *"Thay thế chỉ Admin"* — nhưng **viết lại lý do** | Xem **2.4** — lý do cũ *(“vì gỡ chỉ Admin”)* sau CR này **không còn đúng**, phải thay bằng lý do thật |

## 2.3 Vì sao phải đổi

Luật hiện hành cho Staff có quyền assign **thêm người vào** hội thoại nhưng **không cho lấy ra**. Hệ quả trong vận hành CSKH:

1. **Hội thoại dồn người, không ai dọn được.** Mỗi lần bàn giao ca hoặc đổi người phụ trách, người điều phối chỉ **thêm** được người mới; người cũ vẫn nằm đó. Sau vài vòng, một hội thoại có 3–4 người cùng "phụ trách" mà thực tế chỉ 1 người làm.
2. **Mọi thao tác sửa sai đều phải qua Admin.** Gán nhầm một người thì chính người gán **không tự sửa được** — phải chờ Admin. Người điều phối CSKH thường **không phải Admin**.
3. **Bất đối xứng không bảo vệ được gì.** Staff đã **thêm được bất kỳ ai** vào hội thoại, tức đã đổi được ai phụ trách việc gì. Chặn riêng chiều gỡ không ngăn được sai sót, chỉ khiến sai sót **không khắc phục được tại chỗ**.

Phạm vi không nới ra: người đó vẫn **chỉ thao tác trong hội thoại mình được xem** theo **G002** và **G003 BR18**. CR này mở **chiều thao tác**, không mở **tầm với**.

## 2.4 Rà xung đột

| Kiểm tra | Kết quả |
|---|---|
| BR dùng chung (`PROJECT_KNOWLEDGE §5`) có bị phá không? | **Không.** **BR-C06** vẫn áp: không có quyền → ẩn/không thao tác được. Không chạm BR-C07 · C09 · C10 · C12 |
| Spec khác đang trích dẫn điều khoản này? | **11 chỗ:** `G034` §1 *(dòng 30)* · §10 *(85)* · **BR10** *(184)* · **OOS06** *(366)* · footer *(432)* — `PHÂN QUYỀN` dòng **88 · 90 · 149** — `PROJECT_KNOWLEDGE` §glossary dòng **167 · 169** — `G003` footer *(756)* |
| Có tạo ra 2 nguồn sự thật không? | ⚠️ **CÓ — và là chủ ý.** Sau CR này: **gỡ từng hội thoại** = Admin + Staff có quyền assign; **gỡ hàng loạt qua *Thay thế*** = vẫn **chỉ Admin** (G034 BR10 giữ nguyên, chốt 06/10). Đây **không phải sót** — xem **2.4b** |
| Dữ liệu đã phát sinh theo quy tắc cũ xử lý ra sao? | **Không cần migration.** Quyền là **kiểm tra lúc chạy**, không sinh dữ liệu. Mọi phân công hiện có **giữ nguyên**; từ ngày phát hành, Staff có quyền assign gỡ được những phân công đó |

### 2.4b — Vì sao giữ "Thay thế chỉ Admin" ở G034

**Lý do cũ ghi trong BR10 — *"vì nó gỡ người, mà gỡ chỉ Admin"* — sau CR này KHÔNG CÒN ĐÚNG.** Phải thay, nếu không dev đọc thấy tiền đề sai sẽ tự "sửa cho nhất quán" và mở luôn cả màn hàng loạt.

**Lý do thật để giữ:** *Thay thế* gỡ **toàn bộ người không được tick**, trên **tối đa 200 hội thoại một lượt** (G034 BR12), và **không khôi phục được** — G034 không có lịch sử phân công. Rủi ro của một lần bấm nhầm ở đây **khác hẳn** việc bỏ tick một người trong một hội thoại. Giữ cho Admin là giữ theo **mức sát thương**, không phải theo **loại thao tác**.

> Mở *Thay thế* cho Staff là **một quyết định riêng**, cần phiếu riêng — chốt 06/10.

## 2.5 Phạm vi sửa trong Spec

☑ Happy Path *(G003 UC-07 b5)* ☐ Alternative Flow ☑ Exception *(rà lại E liên quan quyền assign)* ☑ Business Rule *(G003 BR15 · G034 BR10 — đổi lý do)* ☐ State Machine ☑ UI Notes *(panel Assign — checkbox bỏ chọn nay Staff dùng được)* ☑ Acceptance Criteria *(G003:611, 612)* ☑ Dependencies · Open Questions · footer *(G003:756 · G034 §1/§10/OOS06/footer · PHÂN QUYỀN 88/90/149 · PROJECT_KNOWLEDGE 167/169)*

## 2.6 Điểm nghiệp vụ chưa rõ

| # | Câu hỏi | Phương án khuyến nghị + lý do | Người quyết |
|---|---|---|---|
| 1 | Hệ thống **đã có bảng log phân công** chưa, hay phải dựng mới? | Có rồi → ghi thêm sự kiện *unassign*. Chưa có → **vẫn phát hành CR này**, log bổ sung sau; **không chặn build** vì luật nghiệp vụ không phụ thuộc log | Dev / BE |
| 2 | Người **đang mở hội thoại** mà bị gỡ giữa chừng thì thấy gì? | Hội thoại **biến mất khỏi danh sách ngay** (BR-C12, như G034 BR13). Nếu đang mở → hiện thông báo *"Bạn không còn phụ trách hội thoại này"* rồi đóng. **Cần xác nhận hành vi hiện tại** trước khi ghi thành BR | Dev + BA |

## 2.7 Kết luận BA

| Trường | Nội dung |
|---|---|
| **Phân loại** | ☑ **CR** — đổi quy tắc đã phát hành trong `G003` |
| **Version sau khi sửa** | **G003 → v1.24** · **G034 → v1.1** *(chỉ sửa lý do BR10 + 4 chỗ dẫn chiếu, **không đổi luật**)* · **PHÂN QUYỀN** cập nhật 3 dòng |
| **Việc phát sinh cho Dev** | **Không có migration.** Chỉ nới điều kiện kiểm quyền ở thao tác *unassign* — cả **giao diện** lẫn **API**. Bổ sung ghi log *unassign* *(theo câu hỏi 1)* |
| **Cập nhật PROJECT_KNOWLEDGE** | ☑ §1 bảng version ☑ §5 glossary *(dòng 167, 169)* ☑ §7 — **đóng điểm số 4** của ma trận phân quyền *("Assign vs Unassign — dễ nhầm")* ☑ Changelog |

---

## 3. Theo dõi phiếu

Xem **[SỔ THEO DÕI YÊU CẦU](SỔ%20THEO%20DÕI%20YÊU%20CẦU.md)** — phiếu này không giữ bảng theo dõi riêng.

---

*Lập ngày 06/10/2026 — Trân (BA). Hai điểm chốt qua interview cùng ngày: **gỡ được bất kỳ ai** (không chặn người cuối cùng) · **chưa mở *Thay thế* hàng loạt cho Staff**.*
