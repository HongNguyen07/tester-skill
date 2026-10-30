# [G022] Trung tâm thông báo

| Trường | Nội dung |
|--------|----------|
| **Feature ID** | **G022** |
| **Tên** | Trung tâm thông báo (Notification Center) |
| **Module** | Chăm sóc khách hàng / Chat |
| **Owner (BA)** | Trân |
| **Dev assignee** | — |
| **Priority** | — |
| **Version** | 1.0 |
| **Status** | Draft |
| **Last updated** | 2026-08-13 |

---

## 1. Tổng quan (Overview)

**Trung tâm thông báo** là component **dùng chung** cho nhiều tính năng — gom mọi thông báo về một chỗ (icon 🔔 → popup). Tài liệu này định nghĩa **khung chuẩn** của trung tâm thông báo và **catalog các loại thông báo** (mỗi sự kiện hiển thị gì, ở tab nào, bấm ra đâu).

Mỗi tính năng có thông báo (G019 nhắc hẹn, G010 mất kết nối…) **chỉ trỏ sang G022** cho phần hiển thị; G022 là **nguồn sự thật** về khung + catalog.

**Phạm vi hiện tại (2 loại):** **Nhắc hẹn** (tab Hội thoại) và **Mất kết nối tài khoản Zalo** (tab Hệ thống). **@Mention** và **Kết bạn** — **không** đưa vào center ở phase này (xem OOS04/OOS05).

**Người dùng mục tiêu:** Admin và Staff.

**Phụ thuộc:** G019, G010, G002 (phân quyền), G003.

---

## 2. Khung chuẩn Trung tâm thông báo

### 2.1 Bố cục (theo hệ thống đang làm)
| Thành phần | Mô tả |
|---|---|
| Header | Tiêu đề **"Thông báo"** + nút **"Đọc tất cả"** (góc phải) |
| **4 Tab** (theo module) | **Cửa hàng** (CMS) · **Công việc** (dự án) · **Hội thoại** (Zalo) · **Hệ thống** (còn lại). Mỗi tab có **badge số chưa đọc** |
| Nhóm theo ngày | Danh sách nhóm theo **Hôm nay / Hôm qua / ngày cụ thể**; mới nhất trên cùng |
| Empty state | *"Không có thông báo. Khi có thông báo mới, chúng sẽ hiển thị tại đây."* |

### 2.2 Schema 1 item thông báo (chuẩn — mọi loại đều theo)
| Trường | Mô tả |
|---|---|
| **Avatar** | Avatar của **ngữ cảnh** (hội thoại/người) **+ badge avatar tài khoản Zalo** (chồng góc). Sự kiện cấp tài khoản → avatar tài khoản Zalo. **KHÔNG** dùng icon "SYS" mặc định |
| **Title** | Dòng đậm — **loại sự kiện** (vd "Nhắc hẹn", "Lời mời kết bạn") |
| **Nội dung** | Dòng mô tả chi tiết bên dưới |
| **Giờ** | Thời điểm bắn (góc phải) |
| **Chấm chưa đọc** | Chấm xanh; **click item → đánh dấu đã đọc** + đi tới đích (cột Click ở §3) |

> **Phạm vi G022:** khung chuẩn + các loại thông báo thuộc **Zalo/CSKH** (tab **Hội thoại** + phần **Hệ thống** liên quan tài khoản Zalo). Tab **Cửa hàng (CMS)** và **Công việc (dự án)** thuộc **module khác** — ngoài phạm vi tài liệu này.

### 2.3 Mockup

**Tab Hội thoại** (thông báo Nhắc hẹn):
```
┌ Thông báo                                        Đọc tất cả ✓✓ ┐
│  Cửa hàng 0 │ Công việc 0 │ ▎Hội thoại 2▎ │ Hệ thống 1          │
│ ── Hôm nay ──────────────────────────────────────────────────── │
│ [avt HT⁺TK]  Nhắc hẹn                              09:00     ●   │
│              Gọi lại khách chốt đơn — Tết Chat Zalo1 · 🔁 Hàng ngày │
│ [avt HT⁺TK]  Nhắc hẹn                              08:00     ●   │
│              Dậy sớm — Nguyễn Thu Hồng                           │
└──────────────────────────────────────────────────────────────────┘
   (click item → mở hội thoại + đánh dấu đã đọc)
```

**Tab Hệ thống** (thông báo Mất kết nối):
```
┌ Thông báo                                        Đọc tất cả ✓✓ ┐
│  Cửa hàng 0 │ Công việc 0 │ Hội thoại 2 │ ▎Hệ thống 1▎          │
│ ── Hôm nay ──────────────────────────────────────────────────── │
│ [avt TK Zalo] Tài khoản Zalo mất kết nối          14:56     ●   │
│               Tết Chat Zalo đã ngắt kết nối — bấm để kết nối lại │
└──────────────────────────────────────────────────────────────────┘
   (click → mở Thiết lập › Liên kết tài khoản)
```
- `avt HT⁺TK` = avatar hội thoại + badge avatar tài khoản Zalo (chồng góc). `avt TK Zalo` = avatar tài khoản Zalo.
- **Không** dùng icon "SYS".

---

## 3. Catalog các loại thông báo

> **Lưu ý:** cột **Title / Nội dung** dưới đây là **đề xuất câu chữ** — chốt lại nếu team muốn đổi wording. `{…}` là biến động.

| # | Sự kiện | Tab | Title | Nội dung | Avatar | Bấm (Click) → | Nguồn |
|---|---------|-----|-------|----------|--------|--------------|-------|
| 1 | **Nhắc hẹn đến giờ** (loại Cá nhân) | Hội thoại | **Nhắc hẹn** | *{nội dung nhắc} — {tên hội thoại}* (+ 🔁 lặp); nội dung trống → chỉ {tên hội thoại} | Avatar hội thoại + badge tài khoản | **Mở hội thoại** liên quan | **G019** |
| 2 | **Tài khoản Zalo mất kết nối / xóa liên kết** | **Hệ thống** | **Tài khoản Zalo mất kết nối** | *{tên tài khoản Zalo} đã ngắt kết nối — bấm để kết nối lại* | Avatar tài khoản Zalo | **Mở Thiết lập › Liên kết tài khoản** | **G010** |

**Không tạo thông báo trong center (đã cân nhắc, để phase sau / không cần):**
- **Tin nhắn mới từ khách** — đã thể hiện bằng **badge chưa đọc ở danh sách hội thoại**, không nhân đôi (BR07).
- **@Mention** — **không cần** thông báo ở center (OOS04).
- **Kết bạn** (lời mời đến / được chấp nhận) — **chưa đưa vào** vì còn liên quan **phân quyền** (ai được nhận), tách xử lý sau (OOS05).

---

## 4. Business Rules

| Code | Rule | Lý do |
|------|------|-------|
| BR01 | Thông báo là **per-user** — mỗi người có Trung tâm thông báo riêng | Riêng tư, đúng ngữ cảnh từng người |
| BR02 | Mỗi thông báo có trạng thái **đã đọc / chưa đọc**. **Badge số** trên mỗi tab = số chưa đọc của tab đó. **Click 1 item** → đánh dấu đã đọc item đó + đi tới đích. **"Đọc tất cả"** → đánh dấu đã đọc **toàn bộ** thông báo | Quản lý cái đã xem/chưa xem |
| BR03 | Danh sách **nhóm theo ngày** (Hôm nay / Hôm qua / ngày cụ thể), **mới nhất trên cùng** | Dễ theo dõi |
| BR04 | **Quyền xem thông báo theo ngữ cảnh (G002):** nhắc hẹn **Cá nhân** → chỉ người tạo (G019); **mất kết nối tài khoản Zalo** → người có quyền với **tài khoản Zalo** đó *(chốt thêm nếu muốn hẹp hơn — vd chỉ Admin/người quản tài khoản)* | Không lộ thông báo ngoài quyền |
| BR05 | **Avatar** = avatar ngữ cảnh (hội thoại/người) **+ badge = ẢNH AVATAR THẬT (thu nhỏ) của tài khoản Zalo** (chồng góc); sự kiện cấp tài khoản (mất kết nối) → **avatar tài khoản Zalo**. **KHÔNG** dùng icon "SYS" và **KHÔNG** dùng icon/logo chung — badge phải là **ảnh avatar của đúng tài khoản Zalo đó** | Zalo liên kết nhiều tài khoản → nhìn badge biết ngay nhắc/việc thuộc **tài khoản Zalo nào** |
| BR06 | **Phân loại tab theo module:** Hội thoại = Zalo · Hệ thống = sự kiện hệ thống/tài khoản · Cửa hàng = CMS · Công việc = dự án. Loại Zalo/CSKH chỉ vào **Hội thoại** hoặc **Hệ thống** | Nhất quán cách chia của hệ thống |
| BR07 | **Tin nhắn mới KHÔNG tạo thông báo** trong center (đã có badge chưa đọc ở danh sách hội thoại) | Tránh nhân đôi/nhiễu |
| BR08 | Loại **Mọi người** của nhắc hẹn nhắc theo **Zalo native** — **không** vào center này (chỉ loại Cá nhân — G019) | Đúng mô hình G019 |

---

## 5. Acceptance Criteria

- [ ] Popup thông báo: header "Thông báo" + "Đọc tất cả"; 4 tab có **badge số chưa đọc**; nhóm theo ngày (AC-BR02, AC-BR03)
- [ ] Mỗi item đúng schema: avatar (ngữ cảnh + badge tài khoản, **không "SYS"**) · Title · Nội dung · giờ · chấm chưa đọc (AC-BR05)
- [ ] **Nhắc hẹn** → tab Hội thoại, click → mở hội thoại (AC-catalog #1, G019)
- [ ] **Mất kết nối tài khoản Zalo** → tab **Hệ thống**, click → mở Thiết lập › Liên kết tài khoản (AC-catalog #2, G010)
- [ ] **@Mention** và **Kết bạn** → **KHÔNG** tạo thông báo trong center (AC-OOS04, AC-OOS05)
- [ ] **Tin nhắn mới** → KHÔNG xuất hiện trong center (AC-BR07)
- [ ] Click item → đánh dấu đã đọc; "Đọc tất cả" → đánh dấu đã đọc toàn bộ; badge cập nhật (AC-BR02)
- [ ] Thông báo chỉ hiển thị đúng người có quyền theo ngữ cảnh (AC-BR04)

---

## 6. Out of Scope

| # | Nội dung | Ghi chú |
|---|---------|---------|
| OOS01 | Thông báo module **Cửa hàng (CMS)** & **Công việc (dự án)** | Thuộc module khác; G022 chỉ định nghĩa khung chung + loại Zalo/CSKH |
| OOS02 | **Tin nhắn mới** đưa vào center | Đã có badge ở danh sách hội thoại (BR07) |
| OOS03 | Cấu hình bật/tắt từng loại thông báo, âm thanh, push ngoài app | Cân nhắc phase sau |
| OOS04 | **Thông báo @Mention** trong center | **Không cần** (đã có đánh dấu "liên quan" ở danh sách hội thoại — G008) |
| OOS05 | **Thông báo Kết bạn** (lời mời đến / được chấp nhận) trong center | **Chưa đưa vào** — còn liên quan **phân quyền** (ai được nhận thông báo); tách xử lý sau |

---

## 7. Dependencies

| Phụ thuộc | Ghi chú |
|-----------|---------|
| **G019** | Nhắc hẹn (loại Cá nhân) — catalog #1 |
| **G010** | Mất kết nối / xóa liên kết tài khoản Zalo — catalog #2 |
| **G002** | Phân quyền xem thông báo theo ngữ cảnh (BR04) |
| **G003** | Mở hội thoại từ thông báo |

---

## Changelog

| Ngày | Version | Người thay đổi | Sections | Nội dung | File:Line |
|------|---------|----------------|----------|----------|-----------|
| 2026-08-13 | v1.0 | Trân (BA) | Toàn bộ | Tạo spec **Trung tâm thông báo**: khung chuẩn (header + "Đọc tất cả" · 4 tab có badge · nhóm theo ngày · schema item avatar/Title/Nội dung/giờ/chấm chưa đọc) + **mockup** (tab Hội thoại / Hệ thống) + **catalog 2 loại thông báo:** **Nhắc hẹn** (tab Hội thoại — G019) · **Mất kết nối tài khoản Zalo** (tab Hệ thống — G010). **@Mention** và **Kết bạn** KHÔNG vào center (OOS04/OOS05 — kết bạn còn liên quan phân quyền). **Tin nhắn mới** KHÔNG vào center. Avatar = ngữ cảnh + badge tài khoản (bỏ "SYS"). G019/G010 trỏ sang G022 | — |

---

> **Lưu ý cho Dev & AI:**
> - Spec **thuần nghiệp vụ**. G022 là **nguồn sự thật** về khung + catalog thông báo; feature khác trỏ về đây.
> - **BR05:** avatar = ngữ cảnh + badge tài khoản Zalo, **KHÔNG** dùng "SYS".
> - **BR07:** tin nhắn mới **không** vào center.
> - Cột **Title/Nội dung** ở §3 là **đề xuất câu chữ** — có thể chốt lại wording.
> - **BR04** (quyền xem thông báo mất kết nối theo tài khoản Zalo) — cần chốt thêm nếu muốn giới hạn hẹp hơn (vd chỉ Admin).
> - **@Mention & Kết bạn** hiện **KHÔNG** vào center (OOS04/OOS05); kết bạn để lại vì còn liên quan phân quyền.
