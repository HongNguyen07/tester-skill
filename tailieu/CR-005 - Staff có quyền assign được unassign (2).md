# [CR-005] Quyền Quản lý tài khoản & Phân công khách hàng được unassign

| Trường | Nội dung |
|--------|----------|
| **Mã yêu cầu** | **CR-005** |
| **Tiêu đề** | Nhân sự có quyền **Quản lý tài khoản** hoặc **Phân công khách hàng** được **assign và unassign** nhân sự vào hội thoại |
| **Ngày nhận** | 2026-10-06 |
| **Người yêu cầu** | Khách hàng nội bộ — Trân (CSKH Team Lead) |
| **Spec bị sửa** | **G003 — Chat** `v1.24` · **PHÂN QUYỀN — Ma trận tổng hợp** |
| **Mức ưu tiên** | **Cao** — chặn việc tái phân bổ hằng ngày của đội CSKH |

---

## 2.1 Hiện trạng

**Hệ thống thực tế:**

| Thao tác | Admin | Quyền Quản lý tài khoản | Quyền Phân công khách hàng |
|---|:---:|:---:|:---:|
| Assign nhân sự vào hội thoại | ✓ | ✓ | ✓ |
| Unassign nhân sự khỏi hội thoại | ✓ | **✗** | **✗** |

**Tài liệu đang ghi** *(cũ — không nêu đúng tên 2 quyền, chỉ gọi chung "Staff có quyền assign")*:

| Mã | Nội dung hiện tại | Vị trí |
|---|---|---|
| **BR15** | *"Admin và Staff có quyền assign đều có thể **assign** nhân viên vào hội thoại; chỉ **Admin** có thể **unassign**"* | `G003:313` |
| **UC-07 b5** | *"**[Admin only]** Có thể unassign nhân viên bằng cách bỏ chọn checkbox → click `Lưu`"* | `G003:197` |
| **AC** | *"Staff có quyền assign → có thể assign nhân viên khác, **không thể** unassign"* | `G003:611` |
| **OQ01** | Tên quyền: **Assign** | `G003:691` |
| **Ma trận** | Assign: Nhân sự ⚙️ *(quyền assign)* · Unassign: chỉ Admin | `PHÂN QUYỀN:87–88 · 149` |

## 2.2 Đề nghị đổi thành

| Mã | Nội dung mới |
|---|---|
| **BR15** | Admin và nhân sự có quyền **Quản lý tài khoản** hoặc **Phân công khách hàng** đều **assign và unassign** được nhân sự vào hội thoại |
| **UC-07 b5** | **[Admin / Quản lý tài khoản / Phân công khách hàng]** bỏ chọn checkbox → `Lưu` |
| **AC** | Nhân sự có quyền Quản lý tài khoản hoặc Phân công khách hàng → assign **và** unassign được (AC-BR15) |
| **OQ01** | Đóng — tên quyền đúng là **Quản lý tài khoản** và **Phân công khách hàng**, không phải "Assign" |
| **Ma trận** | Dòng Assign và Unassign: Nhân sự ⚙️ *(Quản lý tài khoản / Phân công khách hàng)* · Đóng điểm §149 *"Assign vs Unassign"* |

## 2.3 Vì sao phải đổi

- Tài liệu cũ, gọi chung "quyền assign" → lệch với 2 quyền thật trên hệ thống.
- Assign được mà không unassign được: bàn giao ca hoặc gán nhầm đều phải chờ Admin, trong khi người điều phối CSKH thường không phải Admin.

## 2.4 Rà xung đột

| Kiểm tra | Kết quả |
|---|---|
| Phá BR dùng chung? | **Không** — `BR-C06` vẫn áp: không có quyền thì không thao tác được |
| Chỗ đang trích dẫn | `G003` UC-07 · BR15 · AC · OQ01 · footer — `PHÂN QUYỀN` 87 · 88 · 149 — `PROJECT_KNOWLEDGE` glossary — `G034` BR10 *(xem dưới)* |
| G034 — *Thay thế* hàng loạt | **Ngoài phạm vi CR này.** G034 BR10 *"Thay thế chỉ Admin"* đang dẫn lý do *"vì unassign chỉ Admin"* → chỉ sửa câu dẫn chiếu cho khỏi sai, **không đổi luật** |
| Dữ liệu cũ | **Không cần migration** — phân công hiện có giữ nguyên |

## 2.5 Phạm vi sửa trong Spec

☑ Happy Path ☐ Alternative Flow ☐ Exception ☑ Business Rule ☐ State Machine ☑ UI Notes ☑ Acceptance Criteria ☑ Dependencies · Open Questions · footer

## 2.6 Kết luận BA

| Trường | Nội dung |
|---|---|
| **Phân loại** | ☑ **CR** |
| **Version sau khi sửa** | ✅ **Đã áp 08/10:** **G003 v1.25** · **G034 v1.1** *(tên quyền + lý do BR10, không đổi luật)* · Ma trận phân quyền §3 · PROJECT_KNOWLEDGE v2.83. CR-006 sẽ lấy **G003 v1.26** |
| **Việc cho Dev** | Mở thao tác **unassign** cho 2 quyền Quản lý tài khoản và Phân công khách hàng — cả **UI và API** |
| **Cập nhật PROJECT_KNOWLEDGE** | ☑ §1 version ☑ §5 glossary *(tên quyền)* ☑ §7 đóng điểm *"Assign vs Unassign"* ☑ Changelog |

---

## 3. Theo dõi phiếu

Xem **[SỔ THEO DÕI YÊU CẦU](SỔ%20THEO%20DÕI%20YÊU%20CẦU.md)**.

---

*Lập ngày 06/10/2026 · viết lại 08/10/2026 theo hiện trạng hệ thống — Trân (BA).*
