# [G021] Gửi số tài khoản ngân hàng (Thẻ chuyển khoản)

| Trường | Nội dung |
|--------|----------|
| **Feature ID** | **G021** |
| **Tên** | Gửi số tài khoản ngân hàng (QR chuyển khoản) |
| **Module** | Chat / Chăm sóc khách hàng |
| **Owner (BA)** | Trân |
| **Dev assignee** | — |
| **Priority** | **Thấp** |
| **Version** | ~~1.0~~ **1.1** |
| **Status** | Draft |
| **Last updated** | ~~2026-08-07~~ **2026-08-11** |

---

## 1. Tổng quan (Overview)

Cho phép nhân viên gửi **số tài khoản ngân hàng** cho khách trong hội thoại. Gopany **quản lý (CRUD) danh sách STK**, **tự sinh mã QR chuẩn VietQR** từ thông tin STK, rồi **gửi text + ảnh QR** vào hội thoại. Khách **quét QR** bằng app ngân hàng để chuyển khoản.

**Bối cảnh chọn hướng (đã trao đổi với dev):**
- ❌ **Không** gửi "thẻ ngân hàng native" từ Gopany — phức tạp/không khả thi (phải mò API + tự dựng thẻ kiểu Zalo).
- ❌ **Không** dựa vào Zalo tự nhận diện text (không kiểm soát được nhân viên gõ đúng từ khóa ngân hàng).
- ✅ **Hướng chọn:** **CRUD STK trên Gopany + sinh QR VietQR + gửi text/ảnh** — kiểm soát được, đáng tin cậy.

**Use Case Description:**
> Là nhân viên CSKH, tôi muốn chọn một số tài khoản công ty đã lưu và gửi kèm mã QR cho khách, để khách quét và chuyển khoản nhanh, đúng.

**Người dùng mục tiêu:**
- **Admin / người được cấp quyền** — quản lý (thêm/sửa/xóa) danh sách STK + gửi.
- **Nhân viên (Staff)** có quyền xem hội thoại — **gửi** STK cho khách.

**Phụ thuộc:** **G003 (Chat)** — ô soạn tin & luồng gửi; **Thiết lập hội thoại** — tab quản lý STK; **VietQR** — sinh mã QR.

---

## 2. Điều kiện tiên quyết (Pre-conditions & Trigger)

**Trigger:**
- **Gửi STK:** nhân viên bấm icon **"Gửi STK"** ở thanh dưới ô soạn tin → chọn STK → gửi.
- **Quản lý STK:** vào **Thiết lập hội thoại** → tab **"Tài khoản ngân hàng"**.

**Pre-conditions:**
- [ ] Người dùng đã đăng nhập, đang trong hội thoại (để gửi).
- [ ] Đã có ít nhất 1 STK trong danh sách.

**Post-conditions chung:**
- Tin STK (text + ảnh QR) được gửi vào hội thoại và hiển thị cho khách.
- Thay đổi danh sách STK **dùng chung toàn workspace**.

---

## 3. Luồng chính (Happy Path)

### UC-01 — Gửi STK cho khách

1. **[Người dùng]** Bấm icon **"Gửi STK"** dưới ô soạn tin
2. **[Hệ thống]** Mở popup danh sách STK đã lưu (ngân hàng · STK · tên chủ TK) + ô tìm kiếm
3. **[Người dùng]** Chọn **một hoặc nhiều** STK → bấm **"Gửi"** (BR07)
4. **[Hệ thống]** Với mỗi STK: **sinh mã QR chuẩn VietQR** (từ ngân hàng + STK + tên chủ TK) rồi gửi vào hội thoại dưới dạng **text (ngân hàng · STK · tên chủ TK) + ảnh QR** (BR05, BR06) [→ E04, E05]
5. **[Khách hàng]** **Quét mã QR** bằng app ngân hàng → app hiện **tên chủ TK thật** + cho nhập số tiền/nội dung → chuyển khoản (BR04, BR05)

*Use case kết thúc.*

---

### UC-02 — Thêm STK vào danh sách

1. **[Người dùng có quyền]** Vào **Thiết lập hội thoại** → tab **"Tài khoản ngân hàng"** → bấm **"+ Thêm tài khoản"** [→ E07]
2. **[Hệ thống]** Hiển thị form: **Ngân hàng** (chọn từ danh sách) · **Số tài khoản** · **Tên chủ tài khoản**
3. **[Người dùng]** Nhập → bấm **"Lưu"** [→ E01, E02, E03, E06, BR10]
4. **[Hệ thống]** Lưu STK (dùng chung workspace); toast *"Đã thêm tài khoản"*

*Use case kết thúc.*

---

### UC-03 — Sửa STK
1. Trong tab "Tài khoản ngân hàng" → bấm **"Sửa"** → cập nhật → **"Lưu"** [→ E01–E03, E06, E07]
2. **[Hệ thống]** Cập nhật; **tin đã gửi trước đó không đổi** (BR09)

### UC-04 — Xóa STK
1. Bấm **"Xóa"** → popup xác nhận [→ AF02, E07] → xác nhận
2. **[Hệ thống]** Gỡ STK khỏi danh sách; **tin đã gửi vẫn giữ** (BR09); toast *"Đã xóa"*

---

## 4. Luồng phụ (Alternative Flows)

### AF01 — Gửi nhiều STK
- Chọn nhiều STK ở bước UC-01 → gửi **nhiều tin** (mỗi STK một text + ảnh QR) — BR07.

### AF02 — Hủy xóa STK
- Mở popup xác nhận xóa → bấm **"Hủy"** → không thay đổi.

---

## 5. Luồng ngoại lệ (Exception Flows)

| Code | Trigger | UI Response |
|------|---------|-------------|
| E01 | STK trống / sai định dạng (không phải số / độ dài không hợp lệ) | Lỗi inline: *"Số tài khoản không hợp lệ"* |
| E02 | Chưa chọn ngân hàng | Lỗi inline: *"Vui lòng chọn ngân hàng"* |
| E03 | Tên chủ TK trống | Lỗi inline: *"Vui lòng nhập tên chủ tài khoản"* |
| E04 | Sinh mã QR thất bại (lỗi dịch vụ QR) | Toast: *"Không tạo được mã QR, vui lòng thử lại"*; không gửi |
| E05 | Gửi tin thất bại phía Zalo | Toast: *"Không gửi được, vui lòng thử lại"*; cho gửi lại |
| E06 | Mất mạng / lỗi hệ thống khi lưu STK | Toast: *"Không thể kết nối, vui lòng thử lại"*; giữ form |
| E07 | Nhân viên **không có quyền** mở/CRUD tab Tài khoản ngân hàng | Toast: *"Bạn không có quyền thực hiện thao tác này"* |

**Exception Confirmation Log**

| Code | Từ UC | Nguồn | Confirmed |
|------|-------|-------|-----------|
| E01–E03 | UC-02, UC-03 | Happy Path | ✅ |
| E04 | UC-01 | Happy Path | ✅ |
| E05 | UC-01 | Happy Path | ✅ |
| E06 | UC-02, UC-03 | Độc lập | ✅ |
| E07 | UC-02–04 | Độc lập | ✅ |

---

## 6. Business Rules — Quy tắc nghiệp vụ

| Code | Rule | Lý do |
|------|------|-------|
| BR01 | Danh sách STK **dùng chung toàn workspace**. **Thêm/Sửa/Xóa (CRUD):** chỉ **Admin / người được cấp quyền**. **Gửi:** mọi nhân sự có quyền xem hội thoại | Dữ liệu tài khoản tiền nhạy cảm — hạn chế người chỉnh sửa; nhưng ai cũng cần gửi cho khách |
| BR02 | Ngân hàng chọn từ **danh sách ngân hàng hỗ trợ VietQR (Napas)** | Đảm bảo sinh QR đúng, khách quét được ở mọi app ngân hàng |
| BR03 | **Số tài khoản:** chỉ chữ số; kiểm tra độ dài hợp lệ theo ngân hàng | Giảm sai sót |
| BR04 | **Tên chủ TK do nhân viên nhập** — dùng để **in lên thẻ/ảnh cho dễ nhận diện**; hệ thống **không xác minh** tên. Đích đến tiền **căn cứ số tài khoản**; khi khách **quét QR**, app ngân hàng hiện **tên chủ TK thật** theo số tài khoản | Tên chỉ mang tính hiển thị; số tài khoản mới quyết định người nhận. Không cần tra cứu tên (OOS01) |
| BR05 | Hệ thống **tự sinh mã QR chuẩn VietQR** từ ngân hàng + STK + tên chủ TK. **Số tiền & nội dung để trống** — khách tự nhập khi chuyển | Khách quét là chuyển được; tránh sai số tiền |
| BR06 | Gửi vào hội thoại dạng **text (ngân hàng · STK · tên chủ TK) + ảnh QR**. ⚠️ **Không có nút "Chuyển khoản" native** như thẻ Zalo — khách **quét QR** hoặc lưu ảnh | Gửi text/ảnh là cách khả thi từ Gopany (không dựng được thẻ native) |
| BR07 | Gửi được **nhiều STK** một lần → mỗi STK một tin (text + ảnh QR) | Công ty thường có nhiều ngân hàng |
| ~~BR08~~ | ~~⚠️ Hiển thị 2 đầu: phải hiển thị đúng tin STK ở cả chiều gửi đi và chiều nhận vào (khách/Zalo gửi thẻ/QR vào)~~ **[CHANGED v1.1 — dev chốt scope]** G021 **CHỈ gồm: CRUD tài khoản ngân hàng + GỬI ĐI từ Gopany**. **KHÔNG** có luồng "nhận STK (dạng text/thẻ) từ khách". Việc hiển thị tin **do khách gửi vào** (nếu có) thuộc **G003 (render tin nhắn)**, **ngoài phạm vi G021** | Scope do dev chốt: chỉ CRUD + gửi đi, không xử lý inbound |
| BR09 | Sửa/Xóa STK trong danh sách **không** ảnh hưởng **tin đã gửi** trong hội thoại (tin đã gửi là bất biến) | Bản chất tin nhắn đã gửi |
| BR10 | STK trùng (cùng ngân hàng + cùng số) → cảnh báo, không tạo bản trùng | Tránh danh sách rối |
| BR11 | **Chỉ gửi thông tin nhận tiền** (ngân hàng, STK, tên chủ TK). **Tuyệt đối không** gửi mật khẩu, OTP, mã PIN | An toàn tài khoản |

---

## 7. State Machine — Vòng đời STK

| Từ trạng thái | Sự kiện | Sang trạng thái | Ghi chú |
|---------------|---------|-----------------|---------|
| *(chưa có)* | Thêm (UC-02) | **Đang dùng** | Xuất hiện trong danh sách gửi |
| Đang dùng | Sửa (UC-03) | *(không đổi)* | Cập nhật thông tin |
| Đang dùng | Xóa (UC-04) | **Đã xóa** | Gỡ khỏi danh sách; tin đã gửi vẫn giữ (BR09) |

---

## 8. Data Model / 9. API Contract

N/A — Spec thuần nghiệp vụ. *(Việc gọi VietQR để sinh QR và cách gửi text/ảnh sang Zalo do dev triển khai — ngoài phạm vi tài liệu nghiệp vụ.)*

---

## 10. UI/UX Notes — Ghi chú giao diện

### 10A — Icon gửi & popup chọn STK (trong hội thoại)
```
┌ Ô soạn tin ─────────────────────────────────────┐
│ Nhập tin nhắn…                 😊  📎  🏦  ➤      │  🏦 = "Gửi STK"
└──────────────────────────────────────────────────┘
   ▼
┌ Gửi số tài khoản ───────────────────────┐
│ 🔍 Tìm…                                  │
│ ☑ SACOMBANK · 070098734854 · Trân       │
│ ☐ MB Bank   · 0365656110  · Tố Trân     │
│ ─────────────────────────────────────    │
│ [ Quản lý ]                    [  Gửi  ] │
└──────────────────────────────────────────┘
```

### 10B — Tin STK trong hội thoại (text + ảnh QR)
```
┌ [Nhân viên gửi] ─────────────────────────┐
│ 🏦 Ngân hàng MB Bank                      │
│ STK: 0365656110                           │
│ Chủ TK: Tố Trân                           │
│ ┌───────────┐                             │
│ │ ▛▟ QR ▙▟ │  ← ảnh QR VietQR (khách quét)│
│ └───────────┘                             │
└───────────────────────────────────────────┘
```
- **Không** có nút "Chuyển khoản" native — khách **quét QR** / lưu ảnh (BR06).
- Gửi nhiều STK → nhiều tin liên tiếp.

### 10C — Tab "Tài khoản ngân hàng" (Thiết lập hội thoại)
```
Thiết lập hội thoại: Liên kết tài khoản │ Quản lý thẻ │ Tin nhắn mẫu │ ▎Tài khoản ngân hàng▎
┌───────────────────────────────────────────────────────────┐
│ Danh sách tài khoản ngân hàng         [ + Thêm tài khoản ] │  (chỉ Admin/được cấp quyền)
│ SACOMBANK · 070098734854 · Trân          [Sửa] [Xóa]       │
│ MB Bank   · 0365656110  · Tố Trân        [Sửa] [Xóa]       │
│ Form: [Ngân hàng ▾] [Số tài khoản] [Tên chủ TK] [Lưu]      │
└───────────────────────────────────────────────────────────┘
```
- Tab cạnh *Tin nhắn mẫu*. Empty state: *"Chưa có tài khoản nào."*

---

## 11. Acceptance Criteria — Tiêu chí nghiệm thu

- [ ] Bấm "Gửi STK" → popup danh sách; chọn (nhiều) STK → gửi (AC-BR07)
- [ ] Mỗi STK gửi ra **text (ngân hàng·STK·tên) + ảnh QR VietQR** (AC-BR05, AC-BR06)
- [ ] Khách quét QR → app ngân hàng hiện **tên chủ TK thật** + cho nhập số tiền/nội dung (AC-BR04, AC-BR05)
- [ ] Tin STK **không** có nút "Chuyển khoản" native (AC-BR06)
- [ ] **CRUD STK chỉ Admin/được cấp quyền**; nhân viên thường không mở được tab quản lý (AC-BR01, AC-E07)
- [ ] Gửi STK: mọi nhân sự có quyền xem hội thoại đều gửi được (AC-BR01)
- [ ] Danh sách STK **dùng chung**: A thêm → B thấy & gửi được (AC-BR01)
- [ ] STK sai định dạng / chưa chọn bank / tên trống → lỗi inline (AC-E01–E03)
- [ ] STK trùng → cảnh báo, không tạo trùng (AC-BR10)
- [ ] Sửa/Xóa STK **không** đổi tin đã gửi (AC-BR09)
- [ ] ~~Hiển thị 2 đầu (gửi đi + nhận vào)~~ **[v1.1]** G021 chỉ **gửi đi**; **không** có luồng nhận vào — hiển thị tin khách gửi thuộc G003 (AC-BR08)

---

## 12. Out of Scope — Ngoài phạm vi

| # | Nội dung | Ghi chú |
|---|---------|---------|
| OOS01 | **Tự tra/xác minh tên chủ TK** qua Napas | Không cần — khách quét QR là thấy tên thật; tên nhập chỉ để hiển thị |
| OOS02 | **Thẻ ngân hàng native** (có nút "Chuyển khoản" bấm-nhảy-app) gửi từ Gopany | Không khả thi (theo dev) — gửi ảnh QR thay thế |
| OOS03 | **QR động** có sẵn số tiền + nội dung (mã đơn hàng) | Phase này để trống cho khách nhập (BR05) |
| OOS04 | Đối soát / xác nhận "đã thanh toán" / tích hợp cổng thanh toán, ZaloPay | Ngoài phạm vi |
| OOS05 | Nhãn/tên gợi nhớ cho STK; nhập nhanh STK không lưu | Cân nhắc phase sau |
| OOS06 | **[v1.1]** Nhận / hiển thị STK do **khách gửi vào** (inbound, text/thẻ/QR) | Thuộc **G003** (render tin nhắn); G021 chỉ gửi đi từ Gopany |

---

## 13. Dependencies — Phụ thuộc

| Phụ thuộc vào | Ghi chú |
|---------------|---------|
| **G003 — Chat** | Icon gửi dưới ô soạn tin; luồng gửi tin. **[v1.1]** Hiển thị tin STK **do khách gửi vào** (nếu có) thuộc G003, **ngoài phạm vi G021** (BR08) |
| **Thiết lập hội thoại** | Tab "Tài khoản ngân hàng" (cạnh Quản lý thẻ / Tin nhắn mẫu) |
| **VietQR (Napas)** | Sinh mã QR chuyển khoản từ ngân hàng + STK + tên. *(Cách tích hợp do dev — ngoài phạm vi nghiệp vụ.)* |

---

## 14. Performance & Scalability

| Mục | Yêu cầu |
|-----|---------|
| Danh sách STK | Số lượng nhỏ, không phân trang |
| Sinh QR | Tạo khi gửi; nhanh, không chặn thao tác |

---

## Changelog — Lịch sử thay đổi

| Ngày | Version | Người thay đổi | Sections | Nội dung | File:Line |
|------|---------|----------------|----------|----------|-----------|
| 2026-08-07 | v1.0 | Trân (BA) | Toàn bộ | Tạo spec **Gửi số tài khoản ngân hàng** theo **hướng CRUD trên Gopany + sinh QR VietQR + gửi text/ảnh** (đã trao đổi & thống nhất với dev — bỏ hướng thẻ native/tự-nhận-diện vì không khả thi/không kiểm soát). **CRUD STK** (Admin/được cấp quyền, dùng chung workspace) ở **tab "Tài khoản ngân hàng" trong Thiết lập hội thoại**; **gửi** = mọi nhân viên có quyền xem hội thoại, chọn nhiều STK. Tên chủ TK **nhập tay** (chỉ để hiển thị; khách quét QR thấy tên thật — OOS01). Số tiền/nội dung để trống (BR05). ⚠️ **Không nút "Chuyển khoản" native** — khách quét QR (BR06); **hiển thị 2 đầu** gửi đi + nhận vào (BR08). **Priority: Thấp** | — |
| 2026-08-11 | **v1.1** | Trân (BA) | 6 (BR08), 11, 12, 13 | **Chốt scope theo dev: G021 CHỈ gồm CRUD tài khoản ngân hàng + GỬI ĐI từ Gopany.** **Bỏ chiều "nhận vào" / "hiển thị 2 đầu"** ở BR08 (trước đây thêm nhầm theo comment "xử lý 2 đầu") — **KHÔNG** có luồng nhận STK dạng text/thẻ từ khách. Hiển thị tin do khách gửi vào (nếu có) thuộc **G003**, đưa vào **OOS06**. Cập nhật AC, Dependencies, ghi chú dev |

---

> **Lưu ý cho Dev & AI khi đọc spec này:**
> - Spec **thuần nghiệp vụ** — không entity/API/DB. Hướng: **CRUD + VietQR + gửi text/ảnh** (không thẻ native).
> - **BR04:** tên chủ TK chỉ để hiển thị; **số tài khoản** mới quyết định người nhận; khách quét QR thấy tên thật.
> - **BR06:** gửi text + ảnh QR → **không có nút "Chuyển khoản" native**; khách quét QR.
> - **BR08 [v1.1 — scope]:** G021 = **CRUD + gửi đi từ Gopany**. **KHÔNG** xử lý nhận STK (text/thẻ) từ khách; hiển thị tin khách gửi vào (nếu có) thuộc **G003**.
> - **BR01:** CRUD chỉ Admin/được cấp quyền; gửi thì mọi nhân viên.
> - **BR11:** chỉ gửi thông tin nhận tiền — KHÔNG kèm mật khẩu/OTP/PIN.
> - **Priority: Thấp** (theo trao đổi team — cân nhắc làm sau).
