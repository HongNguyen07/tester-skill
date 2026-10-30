# [G029] Đếm tin nhắn chưa đọc

| Trường | Nội dung |
|--------|----------|
| **Feature ID** | **G029** |
| **Tên** | Đếm tin nhắn chưa đọc |
| **Module** | Chat / Chăm sóc khách hàng |
| **Owner (BA)** | Trân |
| **Status** | Draft |
| **Last updated** | 2026-08-25 |

---

## 1. Tổng quan

Đếm và hiển thị **số tin nhắn chưa đọc** để nhân sự biết hội thoại nào có việc cần xử lý và mức độ dồn tin — ở cả cấp từng hội thoại, từng tài khoản Zalo, tổng toàn ứng dụng, và theo bộ lọc "Chưa đọc". Tài liệu gom logic đếm hiện đang rải rác (G003 badge · G020 tab lọc · G027 tổng trên tab/icon) thành một nguồn chuẩn.

**Người dùng mục tiêu:** mọi nhân sự (Admin / Staff) có quyền xem hội thoại.

**Phụ thuộc:** **G003** (badge hội thoại, tab "Chưa đọc", đánh dấu chưa đọc, trạng thái đã đọc theo Staff), **G027** (tổng chưa đọc toàn app + logic ai-phụ-trách-hội-thoại), **G028** (tắt thông báo không ảnh hưởng đếm), **G020** (tab lọc "Chưa đọc"), **G002** (quyền xem / tài khoản Zalo dùng chung).

---

## 2. Điều kiện tiên quyết & Trigger

**Trigger:**
- Có **tin nhắn mới từ khách** đến một hội thoại → cộng chưa đọc (UC-01).
- Người dùng **mở hội thoại** → xóa chưa đọc của hội thoại đó (UC-02).

**Pre-conditions:**
- [ ] Người dùng đã đăng nhập, có quyền xem hội thoại.

---

## 3. Luồng chính (Happy Path)

### UC-01 — Cộng chưa đọc khi có tin mới
1. **[Khách hàng]** Gửi tin mới vào hội thoại
2. **[Hệ thống]** Xác định **người nhận đếm** theo phạm vi per-user/phân công (BR01): hội thoại đã phân công → người được phân công; chưa phân công → mọi nhân sự có quyền xem
3. **[Hệ thống]** Với mỗi người nhận **chưa mở** hội thoại → **+1 chưa đọc** cho hội thoại đó (BR02, BR03); cập nhật các cấp tổng liên quan (BR05) [→ E01, E02]

*Use case kết thúc.*

### UC-02 — Mở hội thoại → đánh dấu đã đọc
1. **[Người dùng]** Mở hội thoại đang có chưa đọc
2. **[Hệ thống]** Đưa **chưa đọc của hội thoại đó về 0** cho người mở; cập nhật lại các cấp tổng (BR04, BR05) [→ E03]

*Use case kết thúc.*

> **"Đánh dấu chưa đọc" thủ công** — docs G003/G009 có nhắc nhưng **chưa được build** → **Ngoài phạm vi** doc này (OOS05).

---

## 4. Luồng phụ (Alternative Flows)

### AF01 — Đọc ở thiết bị/tab khác
- Người dùng mở hội thoại ở một tab/thiết bị → chưa đọc về 0 và **đồng bộ giảm** ở mọi tab/thiết bị khác của **chính người đó** (BR08).

### AF02 — Đổi phân công / quyền xem giữa chừng
- Hội thoại được phân công lại hoặc quyền xem thay đổi → phạm vi đếm tính lại theo BR01; hội thoại rời phạm vi của một người → **trừ khỏi tổng** của người đó (E04).

---

## 5. Luồng ngoại lệ (Exception Flows)

| Code | Trigger | UI Response |
|------|---------|-------------|
| E01 | Người dùng **không có quyền xem** hội thoại phát sinh tin | Không tính chưa đọc cho người đó (BR01) |
| E02 | **Mất mạng / mất kết nối tạm thời** khi có tin mới | Badge giữ giá trị gần nhất; khi có mạng lại → **đồng bộ về đúng số** |
| E03 | **Đọc đồng thời ở 2 tab/thiết bị** (race) | Chưa đọc về 0 **idempotent** — không về số âm, mọi nơi đồng bộ |
| E04 | **Quyền xem / phân công bị đổi** giữa chừng | Tính lại theo phạm vi mới (BR01); hội thoại rời phạm vi → trừ khỏi tổng |
| E05 | **Không có tin chưa đọc** | Ẩn badge (không hiện số 0) |

**Exception Confirmation Log**

| Code | Từ UC | Nguồn | Confirmed |
|------|-------|-------|-----------|
| E01 | UC-01 | BR01 | ✅ |
| E02 | UC-01 | Độc lập | ✅ |
| E03 | UC-02 | Happy Path | ✅ |
| E04 | UC-01/02 | AF02 | ✅ |
| E05 | UC-01/02 | Empty state | ✅ |

---

## 6. Business Rules — Quy tắc nghiệp vụ

| Code | Rule | Lý do |
|------|------|-------|
| BR01 | **Phạm vi đếm = per-user theo phân công:** hội thoại **đã phân công riêng** → chỉ **người được phân công** có chưa đọc; hội thoại **chưa phân công** → **mọi nhân sự có quyền xem** đều có chưa đọc riêng. A đọc **không** xóa chưa đọc của B. **[chốt trước code]** Áp dụng cho **cả Admin** — hội thoại đã phân công cho người khác thì Admin thấy **badge 0** (vẫn mở xem được nội dung); **không ngoại lệ Admin** | Khớp logic "ai nhận thông báo" G027 (BR07) — badge đi cùng người quan tâm hội thoại; ít nhiễu, không bỏ lỡ |
| BR02 | **Chỉ đếm tin từ khách gửi đến (inbound).** Tin do **phía công ty gửi đi** (nhân sự khác gửi, hoặc gửi từ điện thoại của tài khoản Zalo) → **KHÔNG** cộng chưa đọc. **[chốt trước code]** **Tin hệ thống (SYSTEM)** — "X đã thêm Y vào nhóm", đổi tên nhóm, thành viên rời… → **KHÔNG** tính chưa đọc (nhất quán với đẩy thông báo vốn đã loại tin hệ thống) | "Chưa đọc = việc cần xử lý"; tin gửi đi / tin hệ thống không phải việc chờ xử lý |
| BR03 | **Badge từng hội thoại = số tin chưa đọc chính xác**; vượt **99** → hiển thị **"99+"** | Đúng Zalo/đa số app chat; biết mức độ dồn tin |
| BR04 | **Mở hội thoại → chưa đọc của hội thoại đó về 0** cho người mở (đánh dấu đã đọc — kế thừa G003). **[chốt trước code]** **Gửi tin đi từ Gopany cũng đánh dấu đã đọc** hội thoại đó cho **chính người gửi** (chỉ người gửi — không đụng người khác, theo BR01) | Hành vi quen thuộc; gửi tức là đã xem → tránh badge tồn đọng sau khi vừa trả lời |
| BR05 | **Các cấp tổng chưa đọc (đều tính theo BR01):** (a) **từng hội thoại**; (b) **tổng theo từng tài khoản Zalo** (ở filter/switcher tài khoản); (c) **tổng toàn app** — tiêu đề tab + favicon (web) / icon app (mobile); (d) **theo tab lọc "Chưa đọc"** (G020, kết hợp tài khoản + thẻ) | Phủ mọi nơi người dùng cần nhìn |
| BR06 | **Độc lập với tắt thông báo (G028):** hội thoại đã tắt thông báo **vẫn cộng chưa đọc** bình thường | Tắt thông báo chỉ tắt tiếng báo, không bỏ lỡ tin (G028 BR05) |
| BR07 | **Cập nhật realtime:** có tin mới → badge tăng ngay; đọc ở tab/thiết bị khác của cùng người → đồng bộ giảm. *(Riêng danh sách khi đang ở tab lọc "Chưa đọc" chỉ làm mới khi chuyển tab — theo G003, không realtime lúc đang đọc.)* | Số luôn phản ánh đúng; tôn trọng hành vi danh sách đã có ở G003 |
| BR08 | **Tổng toàn app do app/web tự tính** (khớp G027 BR06). Badge trên icon app mobile khi app **đóng** có thể cập nhật trễ tới khi mở app | Đúng quyết định G027 Q6 (a) |
| BR09 | Đếm áp dụng cho **cả hội thoại 1:1 và nhóm** | Nghiệp vụ CSKH cần cả hai |
| BR10 | **[chốt trước code]** **Hội thoại đang ẩn (G024) KHÔNG tính** vào mọi cấp tổng chưa đọc (BR05) cho người đã ẩn; khi có tin mới → hội thoại **tự hiện lại** (G024 BR08) rồi mới tính chưa đọc trở lại | Đúng G024 BR08 — đang ẩn thì không tính badge; ẩn là để tạm dọn danh sách |

---

## 7. State Machine — Trạng thái đọc *(theo người dùng × hội thoại)*

| Từ trạng thái | Sự kiện | Sang trạng thái | Ghi chú |
|---------------|---------|-----------------|---------|
| *(mặc định)* | — | **Đã đọc (0)** | Hội thoại chưa có tin mới cho người đó |
| Đã đọc | Có tin khách gửi đến (BR02) | **Chưa đọc (n)** | n = số tin inbound tích lũy |
| Chưa đọc (n) | Có thêm tin khách | **Chưa đọc (n+1)** | Tối đa hiển thị "99+" |
| Chưa đọc | Mở hội thoại (BR04) | **Đã đọc (0)** | — |

---

## 8. Data Model / 9. API Contract

**N/A — Spec thuần nghiệp vụ.** *(Cơ chế lưu trạng thái đọc theo người dùng × hội thoại và cách tính tổng do dev thiết kế.)*

---

## 10. UI/UX Notes — Ghi chú giao diện

### 10A — Badge từng hội thoại
- Số chưa đọc trên hàng hội thoại (panel trái — G003 §10B); vượt 99 → **"99+"**; không có chưa đọc → ẩn badge.

### 10B — Tổng theo tài khoản Zalo
- Ở filter/switcher tài khoản: mỗi tài khoản Zalo hiện **tổng chưa đọc** gộp của tài khoản đó (theo phạm vi BR01).

### 10C — Tổng toàn app
- **Web:** số tổng trên **tiêu đề tab** (vd "(12) Gopany…") + **favicon**. **Mobile:** số trên **icon app**.

### 10D — Tab lọc "Chưa đọc"
- Tab "Chưa đọc" (G020) hiển thị/đếm hội thoại chưa đọc, kết hợp filter tài khoản + thẻ; danh sách làm mới khi chuyển tab (G003).

---

## 11. Acceptance Criteria — Tiêu chí nghiệm thu

- [ ] Tin khách gửi đến hội thoại **đã phân công** → chỉ **người được phân công** +1 chưa đọc; người khác không đổi (AC-BR01)
- [ ] Tin khách gửi đến hội thoại **chưa phân công** → **mọi nhân sự có quyền xem** đều +1 chưa đọc (AC-BR01)
- [ ] Nhân sự A mở hội thoại → chưa đọc của A về 0; **B không bị ảnh hưởng** (AC-BR01, AC-BR04)
- [ ] Tin **công ty gửi đi** (nhân sự khác / từ điện thoại) → **không** cộng chưa đọc (AC-BR02)
- [ ] **Tin hệ thống (SYSTEM)** ("X đã thêm Y vào nhóm"…) → **không** cộng chưa đọc (AC-BR02)
- [ ] Hội thoại đã phân công cho A → **Admin thấy badge 0** (AC-BR01)
- [ ] Nhân sự **gửi tin đi từ Gopany** → hội thoại đó về 0 chưa đọc cho **chính người gửi**; người khác không đổi (AC-BR04)
- [ ] **Hội thoại đang ẩn (G024)** → không cộng vào tổng chưa đọc; có tin mới → tự hiện lại rồi mới tính (AC-BR10)
- [ ] Badge hiện **số chính xác**; 100 tin → hiện **"99+"** (AC-BR03)
- [ ] Mở hội thoại → badge hội thoại về 0 (AC-BR04)
- [ ] Tổng hiển thị đủ 4 cấp: từng hội thoại · tổng theo tài khoản Zalo · tổng toàn app (tab/icon) · tab lọc "Chưa đọc" (AC-BR05)
- [ ] Hội thoại **đã tắt thông báo (G028)** → vẫn cộng chưa đọc (AC-BR06)
- [ ] Có tin mới → badge tăng realtime; đọc ở thiết bị khác → đồng bộ giảm (AC-BR07)
- [ ] Không có chưa đọc → ẩn badge (không hiện 0) (AC-E05)
- [ ] Đọc đồng thời 2 thiết bị → badge về 0, không âm (AC-E03)
- [ ] Áp dụng đúng cho hội thoại 1:1 và nhóm (AC-BR09)

---

## 12. Out of Scope — Ngoài phạm vi

| # | Nội dung | Ghi chú |
|---|---------|---------|
| OOS01 | **Trạng thái "đã xem" của khách/thành viên** (read receipt — ai đã đọc) | Thuộc G003 (trạng thái đã xem theo Staff/nhóm) |
| OOS02 | Đếm chưa đọc cho module **Cửa hàng / Công việc** | Module khác |
| OOS03 | Làm nổi riêng **@Mention** trong đếm | @Mention thuộc G027 (thông báo) / G008 |
| OOS04 | Cấu hình bật/tắt hiển thị badge theo ý người dùng | Phase sau |
| OOS05 | **"Đánh dấu chưa đọc" thủ công** | Docs G003/G009 có nhắc nhưng **chưa được build** → ngoài phạm vi; khi làm sẽ bổ sung (chưa đọc dạng chấm, không số) |

---

## 13. Dependencies — Phụ thuộc

| Phụ thuộc | Ghi chú |
|-----------|---------|
| **G003 — Chat** | Badge hội thoại (§10B), tab "Chưa đọc", mở hội thoại = đã đọc. *("Đánh dấu chưa đọc" chưa build — OOS05)* |
| **G027 — Thông báo đẩy** | Logic phạm vi per-user theo phân công (BR01 ↔ G027 BR07); tổng toàn app tự tính (BR08) |
| **G028 — Tắt/Bật thông báo** | Tắt thông báo **không** ảnh hưởng đếm chưa đọc (BR06) |
| **G020 — Bộ lọc hội thoại & Folder thẻ** | Tab lọc "Chưa đọc" + kết hợp tài khoản/thẻ (BR05d) |
| **G024 — Thao tác hội thoại (Ẩn…)** | Hội thoại đang ẩn không tính chưa đọc; có tin mới tự hiện lại (BR10 ↔ G024 BR08) |
| **G002 — Chia sẻ tài khoản Zalo cho Staff** | Quyền xem + tài khoản dùng chung → cơ sở phạm vi đếm (BR01) |
