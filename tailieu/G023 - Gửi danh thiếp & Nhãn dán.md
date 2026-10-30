# [G023] Gửi danh thiếp & Nhãn dán

| Trường | Nội dung |
|--------|----------|
| **Feature ID** | **G023** |
| **Tên** | Gửi danh thiếp & Nhãn dán |
| **Module** | Chat / Chăm sóc khách hàng |
| **Owner (BA)** | Trân |
| **Dev assignee** | — |
| **Priority** | — |
| **Version** | ~~1.0~~ **1.1** |
| **Status** | Draft |
| **Last updated** | ~~2026-08-17~~ **2026-08-21** |

---

## 1. Tổng quan (Overview)

Bổ sung 2 loại nội dung **gửi đi** trong hội thoại (Zalo native), hiện đang thiếu:
- **Gửi danh thiếp:** chia sẻ thông tin liên hệ (từ danh bạ của tài khoản Zalo) cho khách dưới dạng **thẻ danh thiếp** — **chọn được nhiều liên hệ cùng lúc (tối đa 9)**, có tùy chọn **gửi kèm số điện thoại**.
- **Gửi nhãn dán:** gửi **nhãn dán Zalo native** có sẵn (hình minh họa theo bộ — **khác** biểu tượng cảm xúc/emoji).

**Use Case Description:**
> Là nhân viên CSKH, tôi muốn gửi danh thiếp của một liên hệ và gửi nhãn dán cho khách ngay trong khung chat, để chia sẻ thông tin nhanh và tương tác tự nhiên như trên Zalo.

**Người dùng mục tiêu:** Mọi nhân sự có quyền nhắn tin trong hội thoại (Admin / Staff).

**Phụ thuộc:** **G003** (thanh công cụ soạn tin & luồng gửi), **G013** (hiển thị danh thiếp khi nhận), **G007** (danh bạ — nguồn liên hệ để gửi thiếp).

---

## 2. Điều kiện tiên quyết (Pre-conditions & Trigger)

**Trigger:**
- **Gửi danh thiếp:** bấm icon **"Danh thiếp"** trên thanh công cụ dưới ô soạn tin.
- **Gửi nhãn dán:** bấm icon **"Nhãn dán"** trên thanh công cụ.

**Pre-conditions:**
- [ ] Người dùng đang trong một hội thoại và có quyền nhắn tin.
- [ ] Tài khoản Zalo của hội thoại đang **hoạt động** (không gửi được khi DISCONNECTED — G010 BR04).

**Post-conditions:** Danh thiếp / nhãn dán được gửi vào hội thoại và hiển thị cho khách.

---

## 3. Luồng chính (Happy Path)

### UC-01 — Gửi danh thiếp

1. **[Người dùng]** Bấm icon **"Danh thiếp"** dưới ô soạn tin
2. **[Hệ thống]** Mở **picker danh thiếp**: liệt kê **danh bạ (bạn bè) của tài khoản Zalo đang chat** + ô **tìm kiếm** (theo tên/SĐT) + bộ đếm **"Đã chọn: n/9"** + toggle **"Gửi kèm số điện thoại"** [→ E01, E03, E04]
3. **[Người dùng]** **Chọn một hoặc nhiều liên hệ (tối đa 9)**; bật/tắt **"Gửi kèm số điện thoại"** theo nhu cầu → bấm **Gửi**
4. **[Hệ thống]** Gửi **thẻ danh thiếp** của các liên hệ đã chọn vào hội thoại (qua đúng tài khoản Zalo của hội thoại); nếu toggle **BẬT** thì kèm SĐT, **TẮT** thì chỉ avatar + tên [→ E02]
5. **[Khách hàng]** Nhận **các thẻ danh thiếp** — hiển thị theo **G013** (avatar + tên + SĐT nếu có kèm)

*Use case kết thúc.*

> **Không có mục "Gần đây"** cho danh thiếp (đúng Zalo native — "Gần đây" chỉ áp cho nhãn dán).

---

### UC-02 — Gửi nhãn dán

1. **[Người dùng]** Bấm icon **"Nhãn dán"** dưới ô soạn tin
2. **[Hệ thống]** Mở **picker nhãn dán**: mục **"Gần đây"** (nhãn dán vừa dùng) + các **bộ nhãn dán Zalo native có sẵn** (mặc định + đã tải) [→ E03]
3. **[Người dùng]** Chọn một nhãn dán
4. **[Hệ thống]** **Gửi ngay** nhãn dán vào hội thoại (qua đúng tài khoản Zalo của hội thoại) [→ E02]

*Use case kết thúc.*

---

## 4. Luồng phụ (Alternative Flows)

### AF01 — Tìm liên hệ trong picker danh thiếp
- Gõ tên/SĐT trong ô tìm → danh sách lọc realtime; chọn để gửi (UC-01 b2–b3).

### ~~AF02 — Danh bạ trống~~ → **Đã bỏ v1.1**
- ~~Tài khoản Zalo chưa có bạn bè nào → picker hiển thị **empty state** *"Chưa có liên hệ"* (E01).~~ **[CHANGED v1.1]** Trùng **E01** — empty state là ngoại lệ (Section 5), không phải luồng phụ thành công. Xem **E01**.

---

## 5. Luồng ngoại lệ (Exception Flows)

| Code | Trigger | UI Response |
|------|---------|-------------|
| E01 | Danh bạ trống (UC-01 b2) | Empty state *"Chưa có liên hệ"* trong picker |
| E02 | Gửi danh thiếp / nhãn dán thất bại (lỗi Zalo API / mất kết nối) | Toast: *"Không gửi được, vui lòng thử lại"*; **[v1.1]** **giữ nguyên các liên hệ đã chọn trong picker** (không đóng picker) để thử lại |
| E03 | Tài khoản Zalo **DISCONNECTED** khi mở picker / gửi | Chặn gửi + báo *"Tài khoản Zalo đang mất kết nối"* (G010 BR04) |
| E04 | Chọn **quá 9** danh thiếp (UC-01 b3) | Chặn chọn thêm ở liên hệ thứ 10 + gợi ý *"Tối đa 9 danh thiếp mỗi lần"* |

**Exception Confirmation Log**

| Code | Từ UC | Nguồn | Confirmed |
|------|-------|-------|-----------|
| E01 | UC-01 | Happy Path | ✅ |
| E02 | UC-01, UC-02 | Happy Path | ✅ |
| E03 | UC-01, UC-02 | Độc lập | ✅ |
| E04 | UC-01 | Happy Path | ✅ |

---

## 6. Business Rules — Quy tắc nghiệp vụ

| Code | Rule | Lý do |
|------|------|-------|
| BR01 | **Gửi danh thiếp:** nguồn liên hệ = **danh bạ (bạn bè) của tài khoản Zalo đang chat** (G007); có ô tìm kiếm theo tên/SĐT. **KHÔNG** có mục "Gần đây" cho danh thiếp. *(Zalo mobile còn lấy "danh bạ máy" của điện thoại; Gopany là web dùng tài khoản Zalo chung nên chỉ có **danh bạ Zalo**.)* | Đúng Zalo native — gửi thiếp của người trong danh bạ |
| BR01b | **Chọn nhiều danh thiếp cùng lúc — tối đa 9/lần** (đúng Zalo native "Đã chọn: n/9"). Chọn ≥1 rồi bấm **Gửi**; vượt 9 → chặn chọn thêm (E04) | Đúng Zalo native; giới hạn 9 để tránh spam |
| BR01c | Toggle **"Gửi kèm số điện thoại"** trong picker danh thiếp: **BẬT** → thẻ danh thiếp kèm SĐT; **TẮT** → chỉ avatar + tên. Áp cho **cả lô** đang chọn. **[v1.1]** Liên hệ **không có SĐT** → thẻ chỉ **avatar + tên** dù toggle BẬT | Đúng Zalo native — người gửi tự quyết có lộ SĐT hay không; liên hệ thiếu SĐT thì không có gì để kèm |
| BR02 | **Gửi nhãn dán:** dùng **nhãn dán Zalo native có sẵn** của tài khoản (bộ mặc định + đã tải); có **mục "Gần đây"** hiển thị nhãn dán vừa dùng. **KHÔNG** hỗ trợ nhãn dán tùy chỉnh/tự tải lên (OOS01). *(Nhãn dán = hình minh họa theo bộ — **khác** biểu tượng cảm xúc/emoji.)* | Đúng Zalo native; giới hạn phạm vi |
| BR03 | Danh thiếp/nhãn dán gửi qua **đúng tài khoản Zalo của hội thoại** đang mở | Mỗi hội thoại thuộc 1 tài khoản Zalo |
| BR04 | **Quyền:** mọi nhân sự có quyền nhắn tin trong hội thoại đều gửi được (như gửi tin nhắn thường). ~~Không thêm phân quyền riêng.~~ **[CHANGED v1.1]** Danh thiếp/Nhãn dán nằm trong **thanh soạn tin** → quyền gửi **theo thanh soạn tin (G003)**: hội thoại nhóm đặt **"Quyền gửi tin nhắn = Chỉ trưởng nhóm" (G026)** thì thành viên không có quyền gửi → **cả thanh soạn tin (gồm 2 icon Danh thiếp/Nhãn dán) bị vô hiệu** như G003, không có luật riêng | Nhất quán quyền gửi tin với G003/G026 |
| BR05 | **Thẻ danh thiếp khi nhận** hiển thị theo **G013** (avatar + tên + SĐT nếu có); ở đích có thể **chuyển tiếp** (G003 v1.14) | Nhất quán với luồng danh thiếp đã có |
| BR06 | **Gửi nhãn dán chọn-là-gửi-ngay** (không có bước xem lại); danh thiếp chọn liên hệ rồi gửi | Đúng trải nghiệm quen thuộc |
| BR07 | Tài khoản Zalo **DISCONNECTED** → **không** gửi được danh thiếp/nhãn dán (G010 BR04) | Kênh Zalo không khả dụng |

---

## 7. State Machine / 8. Data Model / 9. API Contract

N/A — Spec thuần nghiệp vụ. *(Danh sách bạn bè & bộ nhãn dán do Zalo/hub cung cấp — dev tích hợp; ngoài phạm vi tài liệu nghiệp vụ.)*

---

## 10. UI/UX Notes — Ghi chú giao diện

### 10A — Thanh công cụ (dưới ô soạn tin)
Bổ sung 2 icon: **🪪 Danh thiếp** · **🏷️ Nhãn dán** *(cạnh Gửi ảnh / Gửi tệp / Nhắc hẹn hiện có — G003 §10D)*.

### 10B — Picker Danh thiếp
```
┌ Gửi danh thiếp ───────────── Đã chọn: 2/9 ┐
│ 🔍 Tìm tên / số điện thoại…                │
│ ─────────────────────────────────────────  │
│ ☑ 👤 Nguyễn Văn A      0901 234 567        │
│ ☑ 👤 Trần Thị B        0912 345 678        │
│ ☐ 👤 …                                      │
│ ─────────────────────────────────────────  │
│ Gửi kèm số điện thoại            [ ●] BẬT   │
│                              [ Gửi (2) ]    │
└────────────────────────────────────────────┘
   (chọn NHIỀU, tối đa 9 → Gửi · KHÔNG có "Gần đây")
```

### 10C — Picker Nhãn dán
```
┌ Nhãn dán ───────────────────────────────┐
│ [ Gần đây ] [ Bộ 1 ] [ Bộ 2 ] …          │  ← tab các bộ nhãn dán
│  [🖼️] [🖼️] [🖼️] [🖼️]                     │  ← lưới nhãn dán (hình minh họa)
│  [🖼️] [🖼️] [🖼️] [🖼️]                     │
└──────────────────────────────────────────┘
   (chọn nhãn dán → gửi ngay; "Gần đây" = nhãn dán vừa dùng)
```
> **Lưu ý:** ô [🖼️] là **nhãn dán** (hình minh họa theo bộ), **không phải** emoji/biểu tượng cảm xúc.

---

## 11. Acceptance Criteria — Tiêu chí nghiệm thu

- [ ] Toolbar có icon **Danh thiếp** và **Nhãn dán** (AC-10A)
- [ ] **Danh thiếp:** bấm → picker liệt kê **danh bạ tài khoản Zalo đang chat** + ô tìm; **không có "Gần đây"** (AC-BR01)
- [ ] **Chọn nhiều danh thiếp (tối đa 9)**; bộ đếm "Đã chọn: n/9"; chọn liên hệ thứ 10 bị chặn (AC-BR01b, AC-E04)
- [ ] Toggle **"Gửi kèm số điện thoại"**: BẬT → thẻ kèm SĐT; TẮT → chỉ avatar + tên (AC-BR01c)
- [ ] **[v1.1]** Liên hệ **không có SĐT** + toggle BẬT → thẻ chỉ avatar + tên (AC-BR01c)
- [ ] **[v1.1]** Trong nhóm **"Chỉ trưởng nhóm gửi tin" (G026)** → thành viên thường **không dùng được** icon Danh thiếp/Nhãn dán (theo thanh soạn tin G003) (AC-BR04)
- [ ] Chọn liên hệ → gửi **các thẻ danh thiếp**; khách nhận hiển thị theo **G013** (AC-UC01, AC-BR05)
- [ ] **Nhãn dán:** bấm → picker có **"Gần đây"** + bộ nhãn dán Zalo native; chọn → **gửi ngay** (AC-BR02, AC-UC02)
- [ ] **Không** hỗ trợ nhãn dán tùy chỉnh (AC-OOS01)
- [ ] Danh bạ trống → empty state *"Chưa có liên hệ"* (AC-E01)
- [ ] Gửi thất bại → toast lỗi (AC-E02)
- [ ] Tài khoản Zalo DISCONNECTED → không gửi được, báo lỗi (AC-BR07, AC-E03)
- [ ] Gửi qua đúng tài khoản Zalo của hội thoại (AC-BR03)

---

## 12. Out of Scope — Ngoài phạm vi

| # | Nội dung | Ghi chú |
|---|---------|---------|
| OOS01 | **Nhãn dán tùy chỉnh / tự tải lên** | Chỉ dùng nhãn dán Zalo native có sẵn (BR02) |
| OOS02 | Mục **"Gần đây" cho danh thiếp** | Zalo native chỉ có "Gần đây" cho nhãn dán (BR01) |
| OOS03 | **Chuyển tiếp nhãn dán** | Danh sách forward hiện gồm Text/Ảnh/File/Video/Danh thiếp (G003 v1.14) — nhãn dán chưa nằm trong |
| OOS04 | Gửi **quá 9 danh thiếp** cùng lúc / gửi **nhiều nhãn dán** cùng lúc | Danh thiếp: tối đa 9/lần (BR01b); nhãn dán: gửi từng cái |
| OOS05 | **Biểu tượng cảm xúc (emoji)** chèn vào tin | Khác nhãn dán — ngoài phạm vi doc này |

---

## 13. Dependencies — Phụ thuộc

| Phụ thuộc | Ghi chú |
|-----------|---------|
| **G003 — Chat** | Thanh công cụ soạn tin, luồng gửi tin; **quyền gửi 2 icon theo thanh soạn tin** (BR04) |
| **G026 — Cài đặt nhóm** | **[v1.1]** "Quyền gửi tin nhắn = Chỉ trưởng nhóm" → chặn thành viên gửi danh thiếp/nhãn dán trong nhóm (BR04) |
| **G013 — Danh thiếp** | Hiển thị thẻ danh thiếp khi nhận (BR05) |
| **G007 — Kết bạn/Danh bạ** | Nguồn danh bạ (bạn bè) để chọn gửi thiếp (BR01) |
| **G010** | DISCONNECTED → không gửi được (BR07) |

---

## Changelog

| Ngày | Version | Người thay đổi | Sections | Nội dung | File:Line |
|------|---------|----------------|----------|----------|-----------|
| 2026-08-17 | v1.0 | Trân (BA) | Toàn bộ | Tạo spec **Gửi danh thiếp & Sticker.** **Danh thiếp:** chọn từ **danh bạ (bạn bè) của tài khoản Zalo đang chat** + ô tìm, **không có "Gần đây"**; **chọn nhiều cùng lúc — tối đa 9/lần** ("Đã chọn: n/9", vượt 9 chặn — BR01b, E04) + toggle **"Gửi kèm số điện thoại"** (BẬT kèm SĐT / TẮT chỉ avatar+tên — BR01c); gửi thẻ danh thiếp (hiển thị nhận theo G013). Gopany **chỉ có danh bạ Zalo** (không có "danh bạ máy" như Zalo mobile). **Sticker:** bộ **Zalo native có sẵn** + mục **"Gần đây"** (chỉ sticker), **không custom**; chọn-là-gửi-ngay. Gửi qua đúng tài khoản Zalo của hội thoại; DISCONNECTED không gửi được. OOS: sticker custom, "gần đây" cho danh thiếp, forward sticker, gửi >9 danh thiếp | — |
| 2026-08-21 | v1.1 | Trân (BA) | 4 (AF02), 5 (E02), 6 (BR01c, BR04), 11, 13 | **Review theo /ba-spec + interview.** **BR04:** quyền gửi 2 icon **theo thanh soạn tin (G003)** — nhóm đặt "Quyền gửi tin nhắn = Chỉ trưởng nhóm" (G026) thì thành viên không gửi được (thanh soạn tin vô hiệu), không luật riêng + thêm AC. **BR01c:** liên hệ **không có SĐT** → thẻ chỉ avatar + tên dù toggle BẬT + thêm AC. **E02:** mất mạng/thất bại → **giữ nguyên các liên hệ đã chọn** trong picker. **AF02** (danh bạ trống) bỏ vì trùng E01. Thêm **G026** vào Dependencies. **Đổi thuật ngữ "Sticker" → "Nhãn dán"** (đúng tên Zalo native) toàn bộ + đổi tên file + sửa mockup §10C (nhãn dán = hình minh họa theo bộ, **không phải** emoji); thêm OOS05 (emoji ngoài phạm vi) | — |

---

> **Lưu ý cho Dev & AI:**
> - Spec **thuần nghiệp vụ**. Danh bạ & bộ nhãn dán do Zalo/hub cấp — dev tích hợp.
> - **Thuật ngữ:** **Nhãn dán** = hình minh họa theo bộ (Zalo native) — **không phải** biểu tượng cảm xúc/emoji.
> - **BR01:** danh thiếp **không** có "Gần đây"; **BR02:** nhãn dán **có** "Gần đây" (đúng Zalo native).
> - **BR01b:** danh thiếp **chọn nhiều — tối đa 9/lần**; **BR01c:** toggle **"Gửi kèm số điện thoại"**.
> - **BR05:** thẻ danh thiếp nhận hiển thị theo **G013**.
> - **BR04 [v1.1]:** quyền gửi 2 icon **theo thanh soạn tin (G003)** — nhóm "Chỉ trưởng nhóm gửi tin" (G026) thì thành viên không dùng được.
> - **OOS01:** không hỗ trợ nhãn dán tùy chỉnh.
