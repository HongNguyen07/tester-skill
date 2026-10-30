# [G028] Tắt / Bật thông báo hội thoại

| Trường | Nội dung |
|--------|----------|
| **Feature ID** | **G028** |
| **Tên** | Tắt / Bật thông báo hội thoại |
| **Module** | Chat / Chăm sóc khách hàng |
| **Owner (BA)** | Trân |
| **Status** | Draft |
| **Last updated** | 2026-08-21 |

---

## 1. Tổng quan

Cho phép **tắt thông báo của một hội thoại** trong thời hạn chọn trước (hoặc đến khi bật lại), để nhân sự tập trung mà không bị làm phiền. Khi tắt, hội thoại **vẫn nhận tin bình thường** — chỉ **không phát thông báo** (xem G027); **số chưa đọc vẫn cập nhật**.

*(Tách từ **G009 UC-05** — nay đặc tả riêng tại tài liệu này.)*

**Người dùng mục tiêu:** mọi nhân sự (Admin / Staff) có quyền xem hội thoại.

**Phụ thuộc:** **G027** (Thông báo đẩy — G028 quyết định có phát thông báo hay không), **G003** (hội thoại & điểm vào), **G002** (Chia sẻ tài khoản Zalo cho Staff — mô hình dùng chung tài khoản).

---

## 2. Điều kiện tiên quyết & Điểm vào

**Điểm vào (Trigger):**
- **Icon chuông** trong panel phải của hội thoại, hoặc
- **Option menu** của hội thoại trong danh sách (hover → ••• → Tắt/Bật thông báo).

**Pre-conditions:**
- [ ] Người dùng đã đăng nhập, có quyền xem hội thoại.
- [ ] Hội thoại đang mở hoặc đang ở màn hình danh sách hội thoại.

---

## 3. Luồng chính (Happy Path)

### UC-01 — Tắt thông báo hội thoại

1. **[Người dùng]** Bấm **icon chuông** (panel phải) hoặc chọn **Tắt thông báo** từ option menu
2. **[Hệ thống]** Hiển thị menu chọn thời hạn: **1 giờ / 4 giờ / Đến 8 giờ sáng / Cho đến khi bật lại** (BR01)
3. **[Người dùng]** Chọn thời hạn
4. **[Hệ thống]** Tắt thông báo cho hội thoại theo thời hạn đã chọn; **icon chuông chuyển trạng thái tắt** (BR02)
5. **[Hệ thống]** Trong thời gian tắt: **không phát thông báo** cho hội thoại này (toast / trình duyệt / push — G027); **số chưa đọc vẫn hiển thị bình thường** (BR05)

*Use case kết thúc.*

### UC-02 — Bật lại thông báo

1. **[Người dùng]** Bấm **icon chuông đang tắt** → chọn **"Bật thông báo"**
2. **[Hệ thống]** Bật lại thông báo ngay; **hủy hẹn giờ** nếu chưa hết hạn (BR03)

*Use case kết thúc.*

---

## 4. Luồng phụ (Alternative Flows)

### AF01 — Tự bật lại khi hết thời hạn
- Hết thời hạn đã chọn (1 giờ / 4 giờ / Đến 8 giờ sáng) → hệ thống **tự bật lại** thông báo, không cần thao tác (BR02).

### AF02 — Tắt lại khi đang trong thời hạn tắt
- Đang tắt mà chọn tắt tiếp với thời hạn khác → **thời hạn reset về mốc mới chọn** (không cộng dồn, không giữ mốc cũ) (BR04).

---

## 5. Luồng ngoại lệ (Exception Flows)

| Code | Trigger | Ứng xử |
|------|---------|--------|
| E01 | Thao tác tắt/bật thất bại (mất kết nối) | Toast: *"Không thực hiện được, vui lòng thử lại"*; giữ nguyên trạng thái trước đó |

---

## 6. Business Rules — Quy tắc nghiệp vụ

| Code | Rule | Lý do |
|------|------|-------|
| BR01 | **Thời hạn tắt:** 1 giờ / 4 giờ / Đến 8 giờ sáng / Cho đến khi bật lại. **"Đến 8 giờ sáng" = 8:00 sáng lần kế tiếp:** tắt trước 8:00 → hết hạn 8:00 cùng ngày; tắt từ 8:00 trở đi → hết hạn 8:00 sáng hôm sau | Linh hoạt theo nhu cầu |
| BR02 | Hết thời hạn (1 giờ / 4 giờ / Đến 8 giờ sáng) → **tự bật lại**; icon chuông trở về trạng thái bật | Không phải nhớ bật lại thủ công |
| BR03 | Người dùng **bật lại thủ công** bất cứ lúc nào → hủy hẹn giờ ngay, không chờ hết hạn | Tôn trọng quyết định người dùng |
| BR04 | Đang trong thời hạn tắt mà chọn tắt lại → **thời hạn reset về mốc mới** (không cộng dồn) | Rõ ràng, tránh nhầm lẫn thời hạn |
| BR05 | **Khi đang tắt:** **không phát thông báo** cho hội thoại (toast / trình duyệt / push — G027); nhưng **số chưa đọc vẫn hiển thị**, hội thoại vẫn nhận & lưu tin bình thường | Chỉ tắt tiếng làm phiền, không bỏ lỡ tin |
| BR06 | **Phạm vi = per-user (theo từng nhân sự):** tắt thông báo chỉ áp dụng cho **chính người thao tác**; nhân sự khác dùng chung tài khoản Zalo **không bị ảnh hưởng**. Xử lý phía Gopany (không dùng chức năng tắt của Zalo) | Khớp cơ chế phát thông báo **per-user** của G027; tránh một người tắt làm cả team mất thông báo (mô hình tài khoản dùng chung — G002) |

---

## 7. State Machine — Vòng đời trạng thái thông báo (theo người dùng × hội thoại)

| Từ trạng thái | Sự kiện | Sang trạng thái | Ghi chú |
|---------------|---------|-----------------|---------|
| *(chưa cài đặt)* | Mặc định | **Đang bật** | Mặc định cho mọi hội thoại |
| Đang bật | Tắt có hẹn giờ (1 giờ / 4 giờ / Đến 8 giờ sáng) | **Đang tắt (hẹn giờ)** | — |
| Đang bật | Tắt "Cho đến khi bật lại" | **Đang tắt (vô thời hạn)** | — |
| Đang tắt (hẹn giờ) | Hết thời hạn | **Đang bật** | Tự động (BR02) |
| Đang tắt (hẹn giờ) | Bật lại thủ công | **Đang bật** | Hủy hẹn giờ (BR03) |
| Đang tắt (vô thời hạn) | Bật lại thủ công | **Đang bật** | — |

---

## 8. Data Model / 9. API Contract

**N/A — Spec thuần nghiệp vụ.**

---

## 10. UI/UX Notes — Ghi chú giao diện

| Element | Mô tả |
|---------|-------|
| **Điểm vào 1** | Icon chuông trong panel phải của hội thoại |
| **Điểm vào 2** | Option menu hội thoại trong danh sách (hover → ••• → Tắt thông báo) |
| **Menu thời hạn** | Dropdown: *1 giờ / 4 giờ / Đến 8 giờ sáng / Cho đến khi bật lại* |
| **Icon trạng thái** | Chuông có gạch chéo (đang tắt) / chuông bình thường (đang bật) |
| **Số chưa đọc** | Vẫn hiển thị khi đang tắt thông báo |
| **Bật lại** | Bấm icon chuông gạch chéo → chọn *"Bật thông báo"* |

---

## 11. Acceptance Criteria — Tiêu chí nghiệm thu

- [ ] Tắt thông báo 1 giờ → không phát thông báo trong 1 giờ; số chưa đọc vẫn hiển thị (AC-BR01, AC-BR05)
- [ ] Hết 1 giờ → tự bật lại (AC-BR02)
- [ ] Chọn "Cho đến khi bật lại" → tắt đến khi bật tay (AC-BR01)
- [ ] Bật lại thủ công giữa chừng → hủy hẹn giờ ngay (AC-BR03)
- [ ] Đang tắt "Đến 8 giờ sáng", chọn tắt lại 1 giờ → thời hạn reset về 1 giờ (không cộng dồn) (AC-BR04)
- [ ] Tắt lúc 06:00 chọn "Đến 8 giờ sáng" → hết hạn 08:00 cùng ngày (AC-BR01)
- [ ] Tắt lúc 09:00 chọn "Đến 8 giờ sáng" → hết hạn 08:00 hôm sau (AC-BR01)
- [ ] Đang tắt → hội thoại vẫn nhận tin, số chưa đọc vẫn cập nhật (AC-BR05)
- [ ] **Nhân sự A tắt thông báo hội thoại X → nhân sự B dùng chung tài khoản vẫn nhận thông báo bình thường** (AC-BR06, per-user)
- [ ] Icon chuông đổi trạng thái đúng sau mỗi thao tác (AC-10)

---

## 12. Out of Scope — Ngoài phạm vi

| # | Nội dung | Ghi chú |
|---|---------|---------|
| OOS01 | Tắt thông báo **toàn bộ** hội thoại (mute all) | Phase sau — scope lớn hơn |
| OOS02 | Cấu hình chi tiết loại thông báo được tắt/giữ | Phase sau |
| OOS03 | Nội dung & cách hiển thị thông báo | Thuộc **G027** |
| OOS04 | **Tắt cho cả team** (tắt thông báo hộ mọi nhân sự dùng chung tài khoản) | Backlog — cân nhắc thành action riêng nếu có nhu cầu |

---

## 13. Dependencies — Phụ thuộc

| Phụ thuộc | Ghi chú |
|-----------|---------|
| **G027 — Thông báo đẩy (Web & Mobile)** | G028 quyết định hội thoại có được phát thông báo hay không; G027 tôn trọng trạng thái tắt |
| **G003 — Chat** | Hội thoại, điểm vào (panel phải / option menu), số chưa đọc |
| **G002 — Chia sẻ tài khoản Zalo cho Staff** | Mô hình tài khoản dùng chung → lý do tắt thông báo phải **per-user** (BR06) |

---

## Ghi chú

- Tài liệu **thuần nghiệp vụ**.
- **Phạm vi per-user (đã chốt 2026-08-21):** tắt thông báo áp dụng theo **từng nhân sự**, khớp cơ chế phát **per-user** của G027 — một người tắt không làm cả team mất thông báo. Tùy chọn "tắt cho cả team" để **backlog** (OOS04).
