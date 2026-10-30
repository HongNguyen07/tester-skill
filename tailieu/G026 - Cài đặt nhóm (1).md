# [G026] Cài đặt nhóm

| Trường | Nội dung |
|--------|----------|
| **Feature ID** | **G026** |
| **Tên** | Cài đặt nhóm (Thiết lập tin nhắn · Duyệt thành viên · Quyền của thành viên) |
| **Module** | Chat / Quản lý nhóm |
| **Owner (BA)** | Trân |
| **Dev assignee** | — |
| **Priority** | — |
| **Version** | 1.0 |
| **Status** | Draft |
| **Last updated** | 2026-08-17 |

---

## 1. Tổng quan (Overview)

Màn **"Cài đặt nhóm"** (Zalo native) — gom các **tùy chọn** và **phân quyền** của nhóm về một chỗ. Gopany làm **giống Zalo**, chỉ **khác một điểm duy nhất: KHÔNG có "phó nhóm"** — mọi chỗ Zalo ghi *"trưởng và phó nhóm"* → Gopany dùng **"trưởng nhóm"** (BR01).

Màn gồm 3 nhóm:
- **Thiết lập tin nhắn:** *Làm nổi tin nhắn trưởng nhóm* · *Thành viên mới xem được tin gửi gần đây*.
- **Thành viên:** *Quản lý thành viên* (→ G008) · *Duyệt thành viên* (bật/tắt + **danh sách chờ duyệt → Duyệt/Từ chối** — UC-06).
- **Quyền của thành viên:** *sửa thông tin nhóm · tạo ghi chú, nhắc hẹn · tạo bình chọn · ghim tin nhắn · gửi tin nhắn* — mỗi quyền đặt **"Tất cả mọi người"** hoặc **"Chỉ trưởng nhóm"** (user tự chọn). **Riêng *sửa thông tin nhóm* bị KHÓA ở "Chỉ trưởng nhóm"** (G008 đã chốt — BR05b).

**Người dùng mục tiêu:** Admin/Staff xem; **chỉ trưởng nhóm** chỉnh cài đặt (BR02).

**Phụ thuộc:** **G008** (quản lý nhóm, vai trò trưởng nhóm), **G019** (nhắc hẹn), **G025** (bình chọn), **G014** (ghim tin), **G003** (gửi tin), **G002** (phân quyền), **G010** (trạng thái tài khoản Zalo).

---

## 2. Điều kiện tiên quyết (Pre-conditions & Trigger)

**Trigger:** Từ **panel thông tin nhóm** → mở **"Cài đặt nhóm"**.

**Pre-conditions:**
- [ ] Đang ở hội thoại **nhóm**; có quyền xem nhóm.
- [ ] **Chỉnh** cài đặt: là **trưởng nhóm** (BR02) — người khác chỉ **xem**.

---

## 3. Luồng chính (Happy Path)

### UC-01 — Xem màn Cài đặt nhóm
1. **[Người dùng]** Mở **"Cài đặt nhóm"**
2. **[Hệ thống]** Hiển thị 3 nhóm cài đặt (Thiết lập tin nhắn · Thành viên · Quyền của thành viên) theo trạng thái hiện tại; **chỉ trưởng nhóm** thấy các control ở trạng thái **chỉnh được**, người khác **chỉ đọc** (BR02)

*Use case kết thúc.*

---

### UC-02 — Bật/Tắt "Làm nổi tin nhắn trưởng nhóm"
1. **[Trưởng nhóm]** Gạt toggle **"Làm nổi tin nhắn trưởng nhóm"** [→ E01, E02]
2. **[Hệ thống]** Lưu; khi **BẬT** → tin nhắn của **trưởng nhóm** hiển thị **nổi bật** (nhãn **"Trưởng nhóm"** cạnh tên + **màu viền khác** với tin nhắn thường); **TẮT** → hiển thị bình thường (BR03)

*Use case kết thúc.*

---

### UC-03 — Bật/Tắt "Thành viên mới xem được tin gửi gần đây"
1. **[Trưởng nhóm]** Gạt toggle **"Thành viên mới xem được tin gửi gần đây"** [→ E01, E02]
2. **[Hệ thống]** Lưu; khi **BẬT** → thành viên **mới vào nhóm** xem được **một phần lịch sử gần đây** (phạm vi do **Zalo tự quyết**; Gopany chỉ đẩy toggle — quan sát ~2 tuần); **TẮT** → chỉ thấy tin **từ lúc vào** (BR03)

*Use case kết thúc.*

---

### UC-04 — Bật/Tắt "Duyệt thành viên"
1. **[Trưởng nhóm]** Gạt toggle **"Duyệt thành viên"** [→ E01, E02]
2. **[Hệ thống]** Lưu; khi **BẬT** → người xin vào nhóm (qua link) vào **danh sách chờ duyệt**, phải được **trưởng nhóm Duyệt** mới vào (UC-06, BR04/BR08); **TẮT** → vào thẳng

*Use case kết thúc.*

---

### UC-05 — Đổi "Quyền của thành viên"
1. **[Trưởng nhóm]** Chọn một quyền (vd *"Quyền tạo bình chọn"*) [→ E01, E02]
2. **[Hệ thống]** Hiển thị lựa chọn: **"Tất cả mọi người"** / **"Chỉ trưởng nhóm"**
3. **[Trưởng nhóm]** Chọn → **Lưu**
4. **[Hệ thống]** Áp quyền: khi **"Chỉ trưởng nhóm"** → thành viên thường bị **chặn/ẩn/disable** hành động tương ứng ở tính năng liên quan (BR05, BR06)

> **Quyền bị KHÓA (BR05b):** *"Quyền sửa thông tin nhóm"* hiển thị ở **"Chỉ trưởng nhóm"** và **không đổi được** (option "Tất cả mọi người" bị disable) — vì G008 đã chốt sửa thông tin nhóm chỉ trưởng nhóm.

*Use case kết thúc.*

---

### UC-06 — Duyệt / Từ chối yêu cầu vào nhóm *(khi "Duyệt thành viên" BẬT)*

1. **[Người xin vào]** Vào nhóm **qua link** (G008 AF01) → vì "Duyệt thành viên" đang **BẬT** → được đưa vào **danh sách CHỜ DUYỆT** (chưa phải thành viên) — BR08
2. **[Trưởng nhóm]** Mở **"Duyệt thành viên"** (badge hiển thị số người đang chờ) → xem danh sách người chờ (avatar · tên) [→ E01]
3. **[Trưởng nhóm]** Với mỗi người: bấm **"Duyệt"** hoặc **"Từ chối"** [→ E02]
4. **[Hệ thống]** **Duyệt** → người đó **thành thành viên nhóm** (xuất hiện trong danh sách thành viên — G008); **Từ chối** → **loại khỏi danh sách chờ**, không vào nhóm (BR08)

*Use case kết thúc.*

> **Quyền:** chỉ **trưởng nhóm** Duyệt/Từ chối. Khi "Duyệt thành viên" **TẮT** → không có danh sách chờ (người vào qua link vào thẳng).

---

## 4. Luồng phụ (Alternative Flows)

### AF01 — Người không phải trưởng nhóm mở Cài đặt nhóm
- Xem được trạng thái các cài đặt nhưng **không chỉnh được** (control ở chế độ chỉ đọc) — BR02.

---

## 5. Luồng ngoại lệ (Exception Flows)

| Code | Trigger | UI Response |
|------|---------|-------------|
| E01 | Người **không phải trưởng nhóm** cố chỉnh cài đặt | Control **chỉ đọc**; gọi trực tiếp → toast *"Chỉ trưởng nhóm mới thay đổi được cài đặt này"* (BR02) |
| E02 | Lưu cài đặt thất bại / tài khoản Zalo **DISCONNECTED** | Toast: *"Không lưu được, vui lòng thử lại"* / *"Tài khoản Zalo đang mất kết nối"*; **hoàn tác** toggle trên UI (G010 BR04, BR07) |

**Exception Confirmation Log**

| Code | Từ UC | Nguồn | Confirmed |
|------|-------|-------|-----------|
| E01 | UC-02/03/04/05 | Happy Path | ✅ |
| E02 | UC-02/03/04/05 | Độc lập | ✅ |

---

## 6. Business Rules — Quy tắc nghiệp vụ

| Code | Rule | Lý do |
|------|------|-------|
| BR01 | **Làm giống Zalo, chỉ khác: KHÔNG có "phó nhóm".** Mọi chỗ Zalo ghi *"trưởng và phó nhóm"* → Gopany dùng **"trưởng nhóm"** (vd toggle *"Làm nổi tin nhắn trưởng nhóm"*, lựa chọn quyền *"Chỉ trưởng nhóm"*) | Hệ thống không có vai trò phó nhóm (G008 v1.3) |
| BR02 | **Chỉ trưởng nhóm** được thay đổi cài đặt nhóm & quyền; thành viên khác **chỉ xem** | Đúng Zalo native (quản trị nhóm) |
| BR03 | **Thiết lập tin nhắn — 2 toggle:**<br>• **Làm nổi tin nhắn trưởng nhóm** (bật/tắt): BẬT → tin của **trưởng nhóm** hiển thị **nổi bật** trong khung chat — **cách nổi:** gắn **nhãn "Trưởng nhóm"** cạnh tên người gửi **+ màu viền bong bóng tin khác** với tin nhắn thường; TẮT → hiển thị bình thường.<br>• **Thành viên mới xem được tin gửi gần đây** (bật/tắt): BẬT → thành viên **mới vào** thấy **một phần lịch sử gần đây** (trước khi họ vào); TẮT → chỉ thấy tin **từ lúc vào**. **Phạm vi "gần đây" do Zalo tự quyết** (Gopany chỉ đẩy toggle, **KHÔNG tự gate/định nghĩa phạm vi**). *Quan sát thực tế 17/08: thành viên mới thấy đến ~04/08 (≈2 tuần) — chỉ là tham chiếu, không cố định.* | Đúng Zalo native; phần gating lịch sử nằm ở phía Zalo |
| BR04 | **Duyệt thành viên** (bật/tắt): BẬT → người xin vào nhóm **qua link** (G008 AF01) **KHÔNG vào thẳng** mà vào **danh sách chờ duyệt**, phải được **trưởng nhóm Duyệt** mới thành thành viên (UC-06); TẮT → vào thẳng | Đúng Zalo native; khớp với luồng mời-qua-link G008 |
| **BR08** | **[NEW] Duyệt/Từ chối yêu cầu vào nhóm (UC-06):** khi "Duyệt thành viên" BẬT, người xin vào ở trạng thái **CHỜ DUYỆT** (chưa là thành viên). **Chỉ trưởng nhóm** Duyệt/Từ chối: **Duyệt** → thành thành viên (vào danh sách thành viên — G008); **Từ chối** → loại khỏi danh sách chờ, không vào nhóm. Số người đang chờ hiển thị **badge** ở mục "Duyệt thành viên" | Kiểm soát người vào nhóm |
| BR05 | **Quyền của thành viên** — mỗi quyền đặt **"Tất cả mọi người"** hoặc **"Chỉ trưởng nhóm"** (Zalo cho **user tự chọn**, không mặc định cứng). 5 quyền: **(1) sửa thông tin nhóm** · **(2) tạo ghi chú, nhắc hẹn** · **(3) tạo bình chọn** · **(4) ghim tin nhắn** · **(5) gửi tin nhắn** | Đúng Zalo native (bỏ "phó" — BR01) |
| **BR05b** | **[Chốt tránh conflict]** Quyền nào **hệ thống đã CHỐT "Chỉ trưởng nhóm"** ở doc chức năng → trong Cài đặt nhóm **hiển thị ở "Chỉ trưởng nhóm" và KHÓA** (option "Tất cả mọi người" bị disable — không cho nới lỏng). Hiện: **(1) Sửa thông tin nhóm = "Chỉ trưởng nhóm" (KHÓA)** — theo G008 (sửa tên/avatar/mô tả chỉ trưởng nhóm). **4 quyền còn lại (2)(3)(4)(5)** = **"Tất cả mọi người"** và **cho user đổi** (Tất cả / Chỉ trưởng) | Không để Cài đặt nhóm nới lỏng quyết định đã chốt ở doc, tránh mâu thuẫn |
| BR06 | **Các quyền BR05 GATE hành động ở tính năng tương ứng** — khi đặt **"Chỉ trưởng nhóm"** thì thành viên thường **bị chặn/ẩn/disable**:<br>• Sửa thông tin nhóm (tên/avatar/**mô tả**) → **G008**<br>• Tạo ghi chú, nhắc hẹn → **G019**<br>• Tạo bình chọn → **G025**<br>• Ghim tin nhắn → **G014**<br>• Gửi tin nhắn → **G003** *(khi "Chỉ trưởng nhóm" = chế độ chỉ trưởng nhóm được nhắn tin — ô nhập của thành viên bị disable, nhất quán G003 BR21)* | Một nguồn định nghĩa quyền; các doc chức năng chỉ tuân theo |
| BR07 | Tài khoản Zalo **DISCONNECTED** → **không** đổi cài đặt được (cần đẩy Zalo — E02) | Kênh Zalo phải khả dụng |

---

## 7. State Machine / 8. Data Model / 9. API Contract

N/A — Spec thuần nghiệp vụ. *(Cài đặt nhóm là Zalo-native — dev đọc/ghi qua Zalo API.)*

---

## 10. UI/UX Notes — Ghi chú giao diện

### 10A — Màn "Cài đặt nhóm" (theo Zalo, bỏ "phó")
```
┌ Cài đặt nhóm ───────────────────────────────────────┐
│ THIẾT LẬP TIN NHẮN                                   │
│  Làm nổi tin nhắn trưởng nhóm            [ ●══ ]  ON │  ← BR03 (bỏ "và phó")
│  Thành viên mới xem được tin gửi gần đây [ ●══ ]  ON │  ← BR03
│                                                      │
│ THÀNH VIÊN                                           │
│  Quản lý thành viên                              ›   │  → G008
│  Duyệt thành viên                  Đã bật · 2 chờ ›   │  ← BR04/BR08 (badge số người chờ → UC-06 Duyệt/Từ chối)
│                                                      │
│ QUYỀN CỦA THÀNH VIÊN                                 │
│  Quyền sửa thông tin nhóm       Chỉ trưởng nhóm 🔒   │  ← BR05(1) KHÓA (BR05b)
│  Quyền tạo ghi chú, nhắc hẹn    Tất cả mọi người ›   │  ← BR05(2) đổi được
│  Quyền tạo bình chọn            Tất cả mọi người ›   │  ← BR05(3) đổi được
│  Quyền ghim tin nhắn            Tất cả mọi người ›   │  ← BR05(4) đổi được
│  Quyền gửi tin nhắn             Tất cả mọi người ›   │  ← BR05(5) đổi được
└──────────────────────────────────────────────────────┘
```
- Mỗi dòng "Quyền …" (trừ dòng KHÓA) → mở lựa chọn **"Tất cả mọi người" / "Chỉ trưởng nhóm"** (không có "phó").
- **"Quyền sửa thông tin nhóm"** = **Chỉ trưởng nhóm, KHÓA** (🔒 — không đổi sang Tất cả; BR05b).
- **Không** phải trưởng nhóm → các control ở chế độ **chỉ đọc** (BR02).

---

## 11. Acceptance Criteria — Tiêu chí nghiệm thu

- [ ] Màn Cài đặt nhóm hiển thị 3 nhóm đúng như Zalo, **không có "phó nhóm"** ở đâu (AC-BR01)
- [ ] **Chỉ trưởng nhóm** chỉnh được; người khác chỉ xem (AC-BR02, AC-E01)
- [ ] Toggle **Làm nổi tin nhắn trưởng nhóm** bật → tin trưởng nhóm có **nhãn "Trưởng nhóm" + màu viền khác** tin thường; tắt → bình thường (AC-BR03)
- [ ] Toggle **Thành viên mới xem tin gần đây** bật → thành viên mới thấy **một phần lịch sử gần đây** (phạm vi do Zalo quyết, Gopany chỉ đẩy toggle); tắt → chỉ thấy tin từ lúc vào (AC-BR03)
- [ ] Toggle **Duyệt thành viên** bật → người vào qua link vào **danh sách chờ duyệt**, không vào thẳng (AC-BR04)
- [ ] **[UC-06]** Trưởng nhóm mở "Duyệt thành viên" (badge số chờ) → **Duyệt** → thành thành viên; **Từ chối** → loại khỏi chờ (AC-BR08)
- [ ] Chỉ **trưởng nhóm** Duyệt/Từ chối; Duyệt thành viên TẮT → không có danh sách chờ (AC-BR08)
- [ ] 4 quyền (nhắc hẹn/bình chọn/ghim/gửi tin) đặt được **"Tất cả mọi người" / "Chỉ trưởng nhóm"** (AC-BR05)
- [ ] **"Quyền sửa thông tin nhóm"** hiển thị ở **"Chỉ trưởng nhóm"** và **KHÓA** — không đổi sang "Tất cả" được (AC-BR05b)
- [ ] Đặt "Chỉ trưởng nhóm" cho một quyền → thành viên thường **bị chặn** hành động tương ứng (ghi chú-nhắc hẹn/bình chọn/ghim/gửi tin) (AC-BR06)
- [ ] Tài khoản Zalo DISCONNECTED → không lưu được cài đặt (AC-BR07, AC-E02)

---

## 12. Out of Scope — Ngoài phạm vi

| # | Nội dung | Ghi chú |
|---|---------|---------|
| OOS01 | **Vai trò "phó nhóm"** | Hệ thống không có phó nhóm (BR01) — mọi "trưởng và phó" → "trưởng nhóm" |
| OOS02 | Quyền cấu hình **theo từng thành viên** (khác trưởng nhóm/tất cả) | Chỉ 2 mức "Tất cả mọi người" / "Chỉ trưởng nhóm" như Zalo |

---

## 13. Dependencies — Phụ thuộc

| Phụ thuộc | Ghi chú |
|-----------|---------|
| **G008 — Quản lý nhóm** | Vai trò trưởng nhóm; Quản lý thành viên; sửa thông tin nhóm (tên/avatar/mô tả) bị gate bởi BR05(1) |
| **G019 — Nhắc hẹn** | Tạo ghi chú/nhắc hẹn gate bởi BR05(2) |
| **G025 — Bình chọn** | Tạo bình chọn gate bởi BR05(3) |
| **G014 — Ghim tin nhắn** | Ghim tin gate bởi BR05(4) |
| **G003 — Chat** | Gửi tin gate bởi BR05(5) — nhất quán BR21 (chế độ chỉ trưởng nhóm được nhắn tin) |
| **G002 — Phân quyền** | Quyền chỉnh cài đặt = trưởng nhóm (BR02) |
| **G010** | DISCONNECTED → không đổi cài đặt (BR07) |

---

## Changelog

| Ngày | Version | Người thay đổi | Sections | Nội dung | File:Line |
|------|---------|----------------|----------|----------|-----------|
| 2026-08-17 | v1.0 | Trân (BA) | Toàn bộ | Tạo spec **Cài đặt nhóm** theo màn Zalo native, **chỉ khác: không có phó nhóm** (BR01). **Thiết lập tin nhắn:** toggle *Làm nổi tin nhắn trưởng nhóm* + *Thành viên mới xem tin gần đây* (BR03). **Duyệt thành viên** (BR04) **+ luồng Duyệt/Từ chối yêu cầu vào nhóm** (UC-06, BR08 — chỉ trưởng nhóm; khớp mời-qua-link G008). **Quyền của thành viên** (BR05): 5 quyền — sửa thông tin nhóm/tạo ghi chú-nhắc hẹn/tạo bình chọn/ghim tin/gửi tin — mỗi cái **"Tất cả mọi người"** hoặc **"Chỉ trưởng nhóm"** (user tự chọn); các quyền **gate** hành động ở G008/G019/G025/G014/G003 (BR06). **BR05b:** quyền nào doc đã chốt "Chỉ trưởng nhóm" → **hiển thị + KHÓA** ở "Chỉ trưởng nhóm" (hiện: **sửa thông tin nhóm** — G008); 4 quyền còn lại đổi được. Chỉ trưởng nhóm chỉnh (BR02). DISCONNECTED không đổi được (BR07) | — |

---

> **Lưu ý cho Dev & AI:**
> - Spec **thuần nghiệp vụ**, làm **giống Zalo** — **chỉ khác: không có phó nhóm** (mọi "trưởng và phó" → "trưởng nhóm").
> - **BR05/BR06:** 5 quyền cấu hình gate hành động ở các doc chức năng; "Chỉ trưởng nhóm" → chặn thành viên thường.
> - **BR02:** chỉ trưởng nhóm chỉnh cài đặt.
> - **[BR03] Làm nổi tin trưởng nhóm:** cách nổi = **nhãn "Trưởng nhóm" + màu viền bong bóng tin khác** với tin nhắn còn lại.
> - **[BR03] "Thành viên mới xem tin gần đây":** phạm vi "gần đây" **do Zalo quyết** — Gopany **chỉ đẩy toggle, KHÔNG tự gate**. Quan sát 17/08: thấy đến ~04/08 (≈2 tuần) — chỉ tham chiếu.
