# [G025] Bình chọn (trong nhóm)

| Trường | Nội dung |
|--------|----------|
| **Feature ID** | **G025** |
| **Tên** | Bình chọn (Poll trong nhóm Zalo) |
| **Module** | Chat / Quản lý nhóm |
| **Owner (BA)** | Trân |
| **Dev assignee** | — |
| **Priority** | — |
| **Version** | 1.0 |
| **Status** | Draft |
| **Last updated** | 2026-08-17 |

---

## 1. Tổng quan (Overview)

Cho phép tạo và tham gia **bình chọn (poll)** trong **hội thoại nhóm** Zalo — Zalo native. Nhân viên tạo bình chọn (câu hỏi + các phương án); thành viên nhóm (kể cả khách) bình chọn; xem kết quả; đóng bình chọn.

**Use Case Description:**
> Là nhân viên CSKH trong một nhóm Zalo, tôi muốn tạo bình chọn để thu ý kiến nhanh của các thành viên và xem kết quả ngay trong nhóm.

**Người dùng mục tiêu:** Mọi thành viên nhóm có quyền nhắn tin (Admin / Staff). Bình chọn hiển thị cho **cả nhóm trên Zalo** (gồm khách).

**Phụ thuộc:** **G003** (hội thoại nhóm & luồng gửi), **G008** (quản lý nhóm — vai trò trưởng nhóm), **G026** (Cài đặt nhóm — "Quyền tạo bình chọn" gate quyền tạo, BR02), **G014** (Ghim — tùy chọn "Ghim lên đầu trò chuyện", BR08), **G010** (trạng thái tài khoản Zalo).

---

## 2. Điều kiện tiên quyết (Pre-conditions & Trigger)

**Trigger — bấm vào đâu để tạo:**
1. Mở **hội thoại NHÓM** → ở **panel thông tin nhóm bên phải màn hình chat** (đúng nơi vào Thành viên / Cài đặt nhóm — G008) → bấm mục **"Bình chọn"**.
2. Màn **Bình chọn** mở ra: **danh sách bình chọn của nhóm** + nút **"+ Tạo bình chọn"** (hoặc empty state nếu chưa có) → bấm để mở form Tạo (UC-01).

*(Panel thông tin nhóm bên phải cũng là nơi **xem lại** mọi bình chọn — giống ảnh Zalo "Tuỳ chọn nhóm → Bình chọn".)*

**Pre-conditions:**
- [ ] Đang ở **hội thoại NHÓM** (không có bình chọn ở chat 1:1 — BR01).
- [ ] Có quyền nhắn tin trong nhóm; tài khoản Zalo **đang hoạt động**.

---

## 3. Luồng chính (Happy Path)

### UC-01 — Tạo bình chọn

1. **[Người dùng]** Trong nhóm → bấm **"Tạo bình chọn"** [→ E01]
2. **[Hệ thống]** Mở form (theo Zalo native):
   - Toggle **"Ghim lên đầu trò chuyện"** (BR08)
   - **Câu hỏi** · danh sách **Phương án** (thêm/bớt dòng)
   - **Tuỳ chọn:** **"Đặt thời hạn"** (mặc định *Không có thời hạn* — BR09) · **"Ẩn kết quả khi chưa bình chọn"** (BR10) · **"Cho chọn nhiều phương án"** · **"Cho phép thành viên thêm phương án"** (BR03)
3. **[Người dùng]** Nhập câu hỏi + ≥2 phương án + chọn tùy chọn → bấm **"Tạo"** [→ E02, E04]
4. **[Hệ thống]** Gửi **bình chọn vào nhóm** (Zalo native); toast *"Đã tạo bình chọn"*

*Use case kết thúc.*

---

### UC-02 — Bình chọn (vote)

1. **[Thành viên]** Trên card bình chọn → chọn **một** (hoặc **nhiều** nếu BR03 bật) phương án
2. **[Hệ thống]** Ghi phiếu; cập nhật **số phiếu** + **người chọn** (không ẩn danh — BR04)
3. **[Thành viên]** (Tùy) Đổi/bỏ phiếu **trước khi bình chọn đóng** (BR06)

*Use case kết thúc.*

---

### UC-03 — Thêm phương án *(nếu bật "Cho phép thành viên thêm phương án")*

1. **[Thành viên]** Trên card → **"Thêm phương án"** → nhập nội dung [→ E04]
2. **[Hệ thống]** Thêm phương án vào bình chọn cho cả nhóm thấy (BR03)

*Use case kết thúc.*

---

### UC-04 — Xem kết quả

1. **[Thành viên]** Xem card bình chọn: mỗi phương án hiển thị **số phiếu** + **avatar/tên người đã chọn** + bộ đếm **"N người đã bình chọn"** (BR04). *(Nếu bật "Ẩn kết quả khi chưa bình chọn" — BR10 — thì phải bỏ phiếu xong mới thấy kết quả.)*

*Use case kết thúc.*

---

### UC-05 — Đóng / kết thúc bình chọn

1. **[Người tạo / Trưởng nhóm]** Trên card → **"Kết thúc bình chọn"** (BR05) [→ E03, E05]
2. **[Hệ thống]** Popup xác nhận → đóng bình chọn: **không cho vote / thêm phương án nữa**; kết quả **chốt** và vẫn hiển thị

*Use case kết thúc.*

---

## 4. Luồng phụ (Alternative Flows)

### AF01 — Huỷ tạo / Huỷ kết thúc
- Đóng form tạo / bấm Huỷ ở popup kết thúc → không thay đổi.

---

## 5. Luồng ngoại lệ (Exception Flows)

| Code | Trigger | UI Response |
|------|---------|-------------|
| E01 | Ở **chat 1:1** (không phải nhóm) | Option "Tạo bình chọn" **không hiển thị** (BR01) |
| E02 | Câu hỏi trống **hoặc** < 2 phương án khi Tạo | Lỗi inline: *"Nhập câu hỏi và ít nhất 2 phương án"* |
| E03 | Người **không có quyền đóng** cố kết thúc | Option "Kết thúc" chỉ hiện với người tạo / trưởng nhóm; gọi trực tiếp → toast *"Bạn không có quyền"* (BR05) |
| E04 | Nội dung phương án trống | Lỗi inline: *"Phương án không được để trống"* |
| E05 | Tạo / vote / đóng thất bại (Zalo API) hoặc tài khoản Zalo **DISCONNECTED** | Toast: *"Thao tác thất bại, vui lòng thử lại"* / *"Tài khoản Zalo đang mất kết nối"* (G010 BR04) |

**Exception Confirmation Log**

| Code | Từ UC | Nguồn | Confirmed |
|------|-------|-------|-----------|
| E01 | UC-01 | Happy Path | ✅ |
| E02 | UC-01 | Happy Path | ✅ |
| E03 | UC-05 | Happy Path | ✅ |
| E04 | UC-01, UC-03 | Happy Path | ✅ |
| E05 | UC-01/02/05 | Độc lập | ✅ |

---

## 6. Business Rules — Quy tắc nghiệp vụ

| Code | Rule | Lý do |
|------|------|-------|
| BR01 | Bình chọn **chỉ trong hội thoại NHÓM** — không có ở chat 1:1 | Đúng Zalo native |
| BR02 | **Quyền tạo** theo cài đặt **"Quyền tạo bình chọn"** (**G026 BR05**) — **mặc định "Tất cả mọi người"** (mọi thành viên có quyền nhắn tin); khi trưởng nhóm đặt **"Chỉ trưởng nhóm"** → chỉ trưởng nhóm tạo được | Theo quyền cấu hình của Zalo (bỏ "phó") |
| BR03 | **Tùy chọn khi tạo:** (a) **Cho chọn nhiều phương án** (multi-vote); (b) **Cho phép thành viên thêm phương án**; (c) **Ghim lên đầu trò chuyện** (BR08); (d) **Đặt thời hạn** (BR09); (e) **Ẩn kết quả khi chưa bình chọn** (BR10). **KHÔNG** có "Ẩn người bình chọn" (OOS01) | Khớp bộ tùy chọn Zalo native, trừ ẩn danh (chủ động bỏ) |
| BR04 | **Kết quả KHÔNG ẩn danh:** mỗi phương án hiển thị **số phiếu** + **avatar/tên người đã chọn**; có bộ đếm **"N người đã bình chọn"** (bấm để xem chi tiết ai chọn gì). **Zalo có toggle "Ẩn người bình chọn" nhưng Gopany CHỦ ĐỘNG KHÔNG dùng** (không hiển thị toggle này) | Minh bạch trong nhóm CSKH — chủ động lệch Zalo ở điểm này (OOS01) |
| BR08 | Tùy chọn **"Ghim lên đầu trò chuyện"** khi tạo: BẬT → card bình chọn được **ghim lên đầu hội thoại** (liên thông cơ chế Ghim — G014); mặc định TẮT | Đúng Zalo native — nổi bật bình chọn quan trọng |
| BR09 | Tùy chọn **"Đặt thời hạn"**: mặc định **"Không có thời hạn"**; nếu đặt → đến hạn bình chọn **tự động ĐÓNG** (như UC-05, không cần thao tác tay), kết quả chốt và vẫn hiển thị | Đúng Zalo native — tự đóng khi hết hạn |
| BR10 | Tùy chọn **"Ẩn kết quả khi chưa bình chọn"**: BẬT → thành viên **chưa bỏ phiếu** KHÔNG thấy số phiếu/người chọn; **sau khi vote** mới thấy kết quả. Người tạo & trưởng nhóm luôn xem được | Đúng Zalo native — tránh phiếu bị ảnh hưởng bởi kết quả sớm |
| BR05 | **Quyền đóng/kết thúc:** **người tạo** bình chọn **hoặc trưởng nhóm** (G008). Sau khi đóng → **không** vote/thêm phương án; kết quả chốt | Người tạo & quản trị nhóm kiểm soát vòng đời bình chọn |
| BR06 | Trước khi đóng, thành viên **được đổi/bỏ phiếu**; đơn-chọn → thay phiếu, đa-chọn → tick/bỏ tick từng phương án (Zalo native) | Linh hoạt trước khi chốt |
| BR07 | Tạo/vote/đóng thực hiện qua **tài khoản Zalo của nhóm**; bình chọn hiển thị cho **cả nhóm trên Zalo** (gồm khách). **DISCONNECTED → không thao tác được** (E05) | Zalo native; kênh Zalo phải khả dụng |

---

## 7. State Machine — Vòng đời bình chọn

| Từ trạng thái | Sự kiện | Sang trạng thái | Ghi chú |
|---------------|---------|-----------------|---------|
| *(chưa có)* | Tạo (UC-01) | **Đang mở** | Cho vote / thêm phương án |
| Đang mở | Vote / Thêm phương án | *(không đổi)* | Cập nhật phiếu (BR04) |
| Đang mở | Kết thúc thủ công (UC-05) | **Đã đóng** | Chốt kết quả; không vote/thêm nữa |
| Đang mở | **Đến thời hạn** *(nếu đặt — BR09)* | **Đã đóng** | Tự động đóng khi hết hạn, không cần thao tác tay |

> **Terminal:** Đã đóng — kết quả vẫn hiển thị, không thao tác thêm.

---

## 8. Data Model / 9. API Contract

N/A — Spec thuần nghiệp vụ. *(Bình chọn là Zalo-native — dev tích hợp qua Zalo API.)*

---

## 10. UI/UX Notes — Ghi chú giao diện

### 10A — Entry & Form tạo *(chỉ trong nhóm)*
**Entry (bấm vào đâu):** mở nhóm → **panel thông tin nhóm bên phải** → mục **"Bình chọn"** → nút **"+ Tạo bình chọn"**.
```
Panel thông tin nhóm (bên phải màn hình chat)
┌──────────────────────────────┐
│ Ảnh, file, link            › │
│ Tin nhắn đã ghim           › │
│ 📊 Bình chọn               › │  ◄── bấm vào đây
│ Cài đặt nhóm               › │
│ Xem thành viên (N)         › │
└──────────────────────────────┘
        │ (bấm "Bình chọn")
        ▼
┌ Bình chọn (của nhóm) ────────┐
│ {danh sách bình chọn đã tạo} │
│ …                            │
│      [ + Tạo bình chọn ]     │  ◄── bấm để mở form dưới
└──────────────────────────────┘

┌ Tạo bình chọn mới ─────────────────  TẠO ┐
│ ☐ Ghim lên đầu trò chuyện                │  ← BR08
│ ─────────────────────────────────────────│
│ Đặt câu hỏi bình chọn                     │
│ ─────────────────────────────────────────│
│ Phương án 1                            ✕  │
│ Phương án 2                            ✕  │
│ + Thêm phương án                          │
│ ── Tuỳ chọn ──                            │
│ Đặt thời hạn              Không có thời hạn│  ← BR09
│ Ẩn kết quả khi chưa bình chọn       [○ ]  │  ← BR10 (mặc định tắt)
│ Chọn nhiều phương án                [ ●]  │
│ Có thể thêm phương án               [ ●]  │
└──────────────────────────────────────────┘
```
> **Không** có toggle *"Ẩn người bình chọn"* (Zalo có — Gopany chủ động bỏ, BR04/OOS01).

### 10B — Card bình chọn (màn xem — khớp ảnh Zalo)
```
┌ Bình chọn ─────────────────── ✕      ••• ┐
│ {Câu hỏi}                                 │
│ {Người tạo} • {thời gian}                 │
│ ☰ Chọn được nhiều phương án  (nếu bật)    │
│ ───────────────────────────────────────── │
│ 🔽 N người đã bình chọn  (bấm → ai chọn gì)│  ← BR04; ẩn nếu BR10 & chưa vote
│ ○ Phương án A          ▓▓▓▓░░  5   (avatar)│
│ ○ Phương án B          ▓▓░░░░  2           │
│ + Thêm phương án            (nếu bật BR03) │
│ ───────────────────────────────────────── │
│              [ Bình chọn ]                 │  ← xác nhận phiếu (mờ tới khi chọn)
│  Người tạo / trưởng nhóm ••• → Kết thúc    │
└───────────────────────────────────────────┘
```
- Đơn-chọn = radio (◉); đa-chọn = checkbox. Chọn phương án → nút **"Bình chọn"** ở đáy sáng lên để xác nhận.
- **BR10 bật + chưa vote:** ẩn số phiếu/avatar & dòng "N người đã bình chọn"; vote xong mới hiện.
- **Đã đóng / hết hạn** → nhãn **"Đã kết thúc"**, khoá vote & thêm phương án.
- **Kết thúc thủ công:** người tạo / trưởng nhóm mở **•••** → "Kết thúc bình chọn".

---

## 11. Acceptance Criteria — Tiêu chí nghiệm thu

- [ ] "Tạo bình chọn" **chỉ hiện trong nhóm**, không có ở 1:1 (AC-BR01, AC-E01)
- [ ] Tạo: câu hỏi + ≥2 phương án; thiếu → lỗi (AC-E02, AC-E04)
- [ ] Tùy chọn **chọn nhiều phương án** + **cho thành viên thêm phương án** hoạt động đúng (AC-BR03)
- [ ] **"Ghim lên đầu trò chuyện"** → card bình chọn ghim lên đầu hội thoại (AC-BR08)
- [ ] **"Đặt thời hạn"** → đến hạn bình chọn **tự đóng**, kết quả chốt (AC-BR09)
- [ ] **"Ẩn kết quả khi chưa bình chọn"** → người chưa vote không thấy số phiếu/người chọn; vote xong mới thấy (AC-BR10)
- [ ] **Không** có toggle "Ẩn người bình chọn" (AC-OOS01)
- [ ] Card có bộ đếm **"N người đã bình chọn"** (bấm xem ai chọn gì) + **avatar người vote** + nút **"Bình chọn"** xác nhận ở đáy (AC-BR04)
- [ ] Quyền tạo theo **"Quyền tạo bình chọn"** (G026): mặc định **tất cả**; đặt "Chỉ trưởng nhóm" → chỉ trưởng nhóm tạo (AC-BR02)
- [ ] Vote → cập nhật **số phiếu + tên người chọn** (không ẩn danh) (AC-BR04)
- [ ] Đổi/bỏ phiếu trước khi đóng (AC-BR06)
- [ ] Thành viên thêm phương án (khi bật) → cả nhóm thấy (AC-UC03, AC-BR03)
- [ ] **Kết thúc:** chỉ **người tạo / trưởng nhóm** đóng được; sau đóng không vote/thêm nữa, kết quả chốt (AC-BR05, AC-E03)
- [ ] Tài khoản Zalo DISCONNECTED → không tạo/vote/đóng được (AC-BR07, AC-E05)

---

## 12. Out of Scope — Ngoài phạm vi

| # | Nội dung | Ghi chú |
|---|---------|---------|
| OOS01 | **Bình chọn ẩn danh** ("Ẩn người bình chọn") | **Zalo CÓ toggle này nhưng Gopany chủ động KHÔNG dùng** — CSKH cần minh bạch ai chọn gì (BR04). *Điểm chủ động lệch Zalo.* |
| OOS02 | Bình chọn ở **chat 1:1** | Zalo native chỉ có ở nhóm (BR01) |
| OOS03 | **Giới hạn số phiếu** mỗi người / mỗi phương án | Zalo không có; cân nhắc phase sau *(hẹn giờ tự đóng nay ĐÃ hỗ trợ — BR09)* |
| OOS04 | Sửa câu hỏi/phương án sau khi đã tạo | Phase này chỉ thêm phương án (nếu bật), không sửa nội dung cũ |

---

## 13. Dependencies — Phụ thuộc

| Phụ thuộc | Ghi chú |
|-----------|---------|
| **G003 — Chat** | Hội thoại nhóm & luồng gửi |
| **G008 — Quản lý nhóm** | Vai trò **trưởng nhóm** cho quyền đóng bình chọn (BR05) |
| **G026 — Cài đặt nhóm** | **"Quyền tạo bình chọn"** gate quyền tạo (mặc định Tất cả / Chỉ trưởng nhóm — BR02) |
| **G014 — Ghim tin nhắn** | Tùy chọn **"Ghim lên đầu trò chuyện"** khi tạo bình chọn (BR08) |
| **G010** | DISCONNECTED → không thao tác bình chọn (BR07) |

---

## Changelog

| Ngày | Version | Người thay đổi | Sections | Nội dung | File:Line |
|------|---------|----------------|----------|----------|-----------|
| 2026-08-17 | v1.0 | Trân (BA) | Toàn bộ | Tạo spec **Bình chọn (nhóm)** — **đối chiếu Zalo native.** **Chỉ trong nhóm** (BR01); **entry = panel thông tin nhóm bên phải → mục "Bình chọn" → "+ Tạo bình chọn"** (khớp G008, ảnh Zalo). **Quyền tạo:** theo "Quyền tạo bình chọn" (G026) — mặc định **Tất cả mọi người** / **"Chỉ trưởng nhóm"** (BR02). **Bộ tùy chọn khi tạo (khớp Zalo):** chọn nhiều phương án · cho thành viên thêm phương án · **Ghim lên đầu trò chuyện** (BR08, G014) · **Đặt thời hạn → tự đóng khi hết hạn** (BR09) · **Ẩn kết quả khi chưa bình chọn** (BR10). **KHÔNG ẩn danh** — Zalo có "Ẩn người bình chọn" nhưng **Gopany chủ động bỏ** để minh bạch CSKH (BR04/OOS01); card hiện số phiếu + avatar người chọn + "N người đã bình chọn" + nút "Bình chọn" xác nhận. **Đóng:** người tạo + trưởng nhóm (BR05, bỏ phó) hoặc **tự đóng khi hết hạn**. Đổi/bỏ phiếu trước khi đóng (BR06). DISCONNECTED chặn thao tác (BR07). OOS: ẩn danh (chủ động), 1:1, giới hạn số phiếu, sửa nội dung | — |

---

> **Lưu ý cho Dev & AI:**
> - Spec **thuần nghiệp vụ**; bình chọn là **Zalo-native** — dev tích hợp qua Zalo API.
> - **BR01:** chỉ nhóm. **BR02:** quyền tạo theo G026 (mặc định tất cả, có thể "Chỉ trưởng nhóm"). **BR05:** đóng = người tạo + trưởng nhóm.
> - **BR04:** **không ẩn danh** — hiện avatar/tên người chọn. **Zalo có "Ẩn người bình chọn" nhưng Gopany CHỦ ĐỘNG bỏ** (OOS01).
> - **BR08/09/10 (khớp Zalo):** Ghim lên đầu trò chuyện · Đặt thời hạn (tự đóng) · Ẩn kết quả khi chưa bình chọn.
> - **BR07:** DISCONNECTED chặn mọi thao tác bình chọn.
