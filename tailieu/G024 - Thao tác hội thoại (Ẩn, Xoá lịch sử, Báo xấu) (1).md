# [G024] Thao tác hội thoại: Ẩn trò chuyện · Xoá lịch sử · Báo xấu

| Trường | Nội dung |
|--------|----------|
| **Feature ID** | **G024** |
| **Tên** | Thao tác hội thoại (Ẩn trò chuyện · Xoá lịch sử trò chuyện · Báo xấu) |
| **Module** | Chat / Chăm sóc khách hàng |
| **Owner (BA)** | Trân |
| **Dev assignee** | — |
| **Priority** | — |
| **Version** | ~~1.1~~ ~~1.2~~ **1.3** |
| **Status** | Draft |
| **Last updated** | ~~2026-08-19~~ **2026-08-26** |

---

## 1. Tổng quan (Overview)

Bổ sung 3 thao tác trên **menu tùy chọn của hội thoại**, hiện đang thiếu:

| Thao tác | Bản chất | Phạm vi ảnh hưởng |
|----------|----------|-------------------|
| **Ẩn trò chuyện** | **Nội bộ Gopany** — KHÔNG gọi Zalo | Chỉ danh sách hội thoại **của riêng người thao tác**; tự hiện lại khi có tin mới |
| **Xoá lịch sử trò chuyện** | **Nội bộ Gopany** — KHÔNG gọi Zalo, KHÔNG xoá dữ liệu thật | Chỉ **view của riêng người thao tác**; hệ thống vẫn lưu ngầm cho audit |
| **Báo xấu** | **Zalo-native** — đẩy báo cáo lên Zalo qua tài khoản Zalo của hội thoại | Gửi báo cáo thật lên Zalo; ảnh hưởng cấp **tài khoản Zalo** (không thu hồi được) |

> **Quyết định nền tảng (đã chốt 2026-08-19):**
> - **Ẩn** và **Xoá lịch sử** là thao tác **hiển thị nội bộ Gopany**, thực hiện **hoàn toàn ở phía Gopany**, **KHÔNG** gọi Zalo. Trên app Zalo thật và với nhân sự khác, hội thoại/lịch sử **vẫn nguyên vẹn**.
> - **Báo xấu** là thao tác **Zalo-native duy nhất** trong G024, **bắt buộc chọn lý do** trước khi gửi (BR03).

**Người dùng mục tiêu:** Admin và Staff có quyền xem hội thoại (Ẩn & Xoá lịch sử — đều là thao tác trên view của riêng mình, BR01/BR02). Báo xấu — xem BR03.

**Phụ thuộc:** **G003** (danh sách hội thoại & menu tùy chọn), **G002 — Chia sẻ tài khoản Zalo cho Staff** (nhiều nhân sự dùng chung 1 tài khoản Zalo), **G010 — Soft Delete & Khôi phục dữ liệu** (trạng thái DISCONNECTED), **G011** (đã ghi chú thoáng về "Ẩn trò chuyện" — G024 đặc tả đầy đủ), **G014** (Ghim), **G017** (Tìm kiếm hợp nhất).

---

## 2. Điều kiện tiên quyết (Pre-conditions & Trigger)

**Trigger:**
- **Ẩn trò chuyện / Xoá lịch sử:** ở **panel trái (danh sách hội thoại)**, hover vào một hàng → hiện icon **"•••"** *(hoặc chuột phải)* → **Option menu** → chọn **"Ẩn trò chuyện"** / **"Xoá lịch sử trò chuyện"** (bổ sung 2 mục này vào menu G003 §10B).
- **Báo xấu:** mở hội thoại → **panel thông tin hội thoại (panel phải)** → **"Báo xấu"**.

**Pre-conditions:**
- [ ] Người dùng đã đăng nhập, có quyền xem hội thoại.
- [ ] **Ẩn trò chuyện & Xoá lịch sử:** dùng được cho **mọi nhân sự có quyền xem hội thoại** — **KHÔNG giới hạn Admin** (thao tác trên view của riêng mình — BR01/BR02).
- [ ] **Báo xấu:** cần **quyền nhắn tin** trên hội thoại đó + tài khoản Zalo đang **CONNECTED** (BR03, BR05).
- [ ] Cả 3 thao tác áp dụng cho **cả hội thoại 1:1 và hội thoại nhóm** (BR09).

---

## 3. Luồng chính (Happy Path)

### UC-01 — Ẩn trò chuyện

1. **[Người dùng]** Menu hội thoại → **"Ẩn trò chuyện"**
2. **[Hệ thống]** **[v1.3]** Nếu hội thoại **đang được ghim** (G009) → **tự bỏ ghim trước** (giải phóng slot của chính người đó — BR11)
3. **[Hệ thống]** **Ẩn hội thoại khỏi danh sách của RIÊNG người thao tác** (nhân sự khác dùng chung tài khoản Zalo **vẫn thấy**; app Zalo thật **không đổi** — BR01); **không** xoá dữ liệu, **không** gọi Zalo
4. **[Hệ thống]** Nếu người dùng đang mở chính hội thoại đó → **đóng khung chat**, về trạng thái rỗng
5. **[Hệ thống]** Toast: *"Đã ẩn trò chuyện"* kèm nút **"Hoàn tác"** (hiển thị ~5 giây) [→ AF03]
6. **[Hệ thống]** Trong lúc đang ẩn: **không** đẩy thông báo, **không** tính badge chưa đọc cho người đó (BR08)
7. **[Hệ thống]** Khi hội thoại **có tin nhắn mới** (từ khách hoặc do nhân sự khác gửi đi) → **tự hiện lại** trong danh sách của người đó, kèm badge chưa đọc bình thường (BR01); **[v1.3] hiện lại KHÔNG còn ghim** (đã bỏ ở b2 — chỉ Hoàn tác mới lấy lại ghim, BR11)

*Use case kết thúc.*

---

### UC-02 — Xoá lịch sử trò chuyện

1. **[Người dùng]** Menu hội thoại → **"Xoá lịch sử trò chuyện"**
2. **[Hệ thống]** Popup xác nhận: *"Xoá lịch sử trò chuyện này? Tin nhắn cũ sẽ không còn hiển thị với bạn. Nhân sự khác và Zalo không bị ảnh hưởng."* (BR02) [→ AF01]
3. **[Người dùng]** Bấm **"Xác nhận"**
4. **[Hệ thống]** Ghi nhận **mốc xoá** = thời điểm xác nhận, **theo từng người dùng × hội thoại**; mọi tin nhắn có thời điểm **≤ mốc** sẽ **không còn hiển thị với người đó** ở tất cả điểm hiển thị (BR07)
5. **[Hệ thống]** Khung hội thoại của người đó trở về **trống**; hội thoại **vẫn nằm trong danh sách** với preview trống; badge chưa đọc về 0; nhân sự khác **không bị ảnh hưởng**; **tin nhắn MỚI vẫn đến bình thường**
6. **[Hệ thống]** **Hệ thống VẪN LƯU NGẦM** toàn bộ dữ liệu cho audit/đối soát — **KHÔNG xoá thật, KHÔNG gọi Zalo** (BR02)
7. **[Hệ thống]** Toast: *"Đã xoá lịch sử hiển thị"*

*Use case kết thúc.*

---

### UC-03 — Báo xấu

1. **[Người dùng]** **Panel thông tin hội thoại (panel phải)** → **"Báo xấu"**
2. **[Hệ thống]** Mở **popup Báo xấu** gồm: danh sách **lý do (bắt buộc chọn 1)** — *Nội dung nhạy cảm · Làm phiền · Lừa đảo · Khác*; nếu chọn **"Khác"** → hiện ô **Mô tả chi tiết (bắt buộc)**; nút **"Gửi"** / **"Huỷ"** (BR03, BR06) [→ AF02, E02, E03, E04, E05]
3. **[Người dùng]** Chọn lý do (nhập mô tả nếu "Khác") → bấm **"Gửi"**
4. **[Hệ thống]** **Gửi báo xấu lên Zalo** (Zalo-native) qua tài khoản Zalo của hội thoại, kèm lý do đã chọn
5. **[Hệ thống]** Ghi **log audit**: ai báo, hội thoại nào, lý do, thời điểm (BR10); toast: *"Đã gửi báo xấu"*

*Use case kết thúc.*

> **Lưu ý:** danh sách lý do **theo danh mục Zalo native** (dev xác nhận từ hub); Gopany hiển thị đúng bộ của Zalo, không tự định nghĩa.

---

## 4. Luồng phụ (Alternative Flows)

### AF01 — Huỷ xoá lịch sử
- Popup xác nhận xoá → bấm **"Huỷ"** → đóng, không thay đổi.

### AF02 — Huỷ báo xấu
- Popup Báo xấu → bấm **"Huỷ"** (hoặc đóng popup) → không gửi, không ghi log.

### AF03 — Hoàn tác ẩn trò chuyện
- Sau UC-01, bấm **"Hoàn tác"** trên toast → hội thoại hiện lại ngay trong danh sách của người đó; **[v1.3] khôi phục cả trạng thái ghim** nếu trước đó đang ghim (BR11).

### AF04 — Mở hội thoại đang ẩn từ Tìm kiếm
- Hội thoại đang ẩn **vẫn xuất hiện** trong tìm kiếm (G017). Người dùng mở từ kết quả tìm kiếm → **hội thoại tự hiện lại** trong danh sách (bỏ ẩn) — đây là lối thoát ngoài "có tin mới", do phase này chưa có màn quản lý hội thoại đã ẩn (OOS04).

---

## 5. Luồng ngoại lệ (Exception Flows)

| Code | Trigger | UI Response |
|------|---------|-------------|
| E02 | Báo xấu thất bại (lỗi Zalo / mất kết nối) | Toast: *"Không gửi được báo xấu, vui lòng thử lại"*; popup giữ nguyên dữ liệu đã nhập |
| E03 | Tài khoản Zalo **DISCONNECTED** khi báo xấu | Chặn + báo *"Tài khoản Zalo đang mất kết nối"* (báo xấu cần Zalo — G010 BR04) |
| E04 | Bấm **"Gửi"** khi chưa chọn lý do, hoặc chọn **"Khác"** mà bỏ trống mô tả | Nút **Gửi** disabled + lỗi inline *"Vui lòng chọn lý do báo xấu"* / *"Vui lòng nhập mô tả chi tiết"* |
| E05 | Hội thoại **đã được báo xấu trong 24 giờ gần nhất** (bởi bất kỳ nhân sự nào của workspace) | Chặn + báo *"Hội thoại này vừa được báo xấu, vui lòng thử lại sau"* (BR06 — **chờ xác nhận**) |
| E06 | Hội thoại không còn tồn tại / người dùng mất quyền xem tại thời điểm thao tác (Ẩn, Xoá lịch sử, Báo xấu) | Toast: *"Hội thoại không tồn tại hoặc bạn không còn quyền truy cập"* + làm mới danh sách |

> **Ghi chú:** Ẩn & Xoá lịch sử là thao tác nội bộ, **không** phụ thuộc Zalo → không có ngoại lệ "lỗi Zalo" cho 2 thao tác này (ngoài E06).
> *(v1.0 có E01 "nhân viên không có quyền dùng Xoá lịch sử" — đã bỏ hẳn ở v1.1, xem Changelog.)*

**Exception Confirmation Log**

| Code | Từ UC | Nguồn | Confirmed |
|------|-------|-------|-----------|
| E02 | UC-03 | Happy Path | ✅ |
| E03 | UC-03 | Độc lập | ✅ |
| E04 | UC-03 | Happy Path (bước 2–3) | ✅ |
| E05 | UC-03 | BR06 | ⚠️ Ngưỡng 24h là **đề xuất** — chờ dev/Zalo xác nhận |
| E06 | UC-01/02/03 | Độc lập | ✅ |

---

## 6. Business Rules — Quy tắc nghiệp vụ

| Code | Rule | Lý do |
|------|------|-------|
| BR01 | **Ẩn trò chuyện = RIÊNG mỗi user, NỘI BỘ Gopany.** Ẩn khỏi danh sách hội thoại **của chính người thao tác**; nhân sự khác dùng chung tài khoản Zalo **không bị ảnh hưởng**; **KHÔNG gọi Zalo** — trên app Zalo hội thoại vẫn hiển thị bình thường. **Tự hiện lại khi hội thoại có tin nhắn mới bất kỳ** (khách gửi đến hoặc nhân sự gửi đi), hoặc khi người dùng **mở hội thoại từ tìm kiếm** (AF04), hoặc bấm **Hoàn tác** (AF03). **Không** xoá dữ liệu | Mỗi người tự dọn danh sách của mình; nhiều người dùng chung tài khoản nên không ẩn cho cả team, và không được đụng vào Zalo thật |
| BR02 | **Xoá lịch sử trò chuyện = RIÊNG mỗi user, NỘI BỘ Gopany.** Xoá **view của chính người thao tác** — nhân sự khác **không bị ảnh hưởng**, **KHÔNG gọi Zalo** (lịch sử trên Zalo giữ nguyên); **mọi nhân sự có quyền xem hội thoại** đều dùng được (**không** giới hạn Admin). **Có popup xác nhận**. Cơ chế: lưu **mốc xoá theo (người dùng × hội thoại)** = thời điểm xác nhận; tin nhắn **≤ mốc** bị ẩn với người đó, tin nhắn **> mốc** hiển thị bình thường. Xoá lại lần nữa → **mốc mới ghi đè mốc cũ**. **Hệ thống VẪN LƯU NGẦM** lịch sử cho **audit/đối soát** — **KHÔNG xoá thật** | Giữ đúng trải nghiệm "mỗi người tự dọn view"; vẫn an toàn vì CSKH cần đối soát nên không xoá vật lý, và không làm mất dữ liệu của người khác |
| BR03 | **Báo xấu = Zalo-native:** gửi báo cáo hội thoại/người lên **Zalo** qua tài khoản Zalo của hội thoại. **BẮT BUỘC chọn 1 lý do** trong danh mục **do Zalo cung cấp** (dev xác nhận từ hub): **Nội dung nhạy cảm · Làm phiền · Lừa đảo · Khác**; chọn **"Khác"** → **bắt buộc nhập mô tả chi tiết**. Có popup xác nhận (chính là popup chọn lý do). Quyền: **nhân sự có quyền nhắn tin** trên hội thoại đó | Zalo yêu cầu lý do mới nhận báo cáo; báo xấu là hành động outbound không thu hồi được nên gắn với quyền nhắn tin, không phải chỉ quyền xem |
| BR04 | ~~Cả 3 thao tác đặt ở **menu tùy chọn của hội thoại** (G003 §10B)…~~ **[CHANGED v1.3]** **Ẩn / Xoá lịch sử** ở **Option menu** (G003 §10B), cạnh Ghim/Bỏ ghim · Tắt/Bật thông báo. **Báo xấu** ở **panel thông tin hội thoại (panel phải)** — KHÔNG ở option menu | Ẩn/Xoá là thao tác nhanh trên hàng hội thoại; Báo xấu ít dùng + cần chọn lý do nên đặt trong panel |
| BR05 | **Tài khoản Zalo DISCONNECTED:** **Báo xấu** (cần đẩy Zalo) → **không** thực hiện được (E03). **Ẩn trò chuyện** và **Xoá lịch sử** (thuần hiển thị nội bộ Gopany) → **vẫn thực hiện được** | Đúng G010 BR04: DISCONNECTED chỉ khoá thao tác outbound Zalo, dữ liệu và hiển thị vẫn dùng bình thường |
| BR06 | **[CHỜ XÁC NHẬN] Chống spam báo xấu:** đề xuất 1 hội thoại chỉ được báo xấu **1 lần / 24 giờ** tính trên toàn workspace (bất kể ai bấm); trong thời gian đó mục "Báo xấu" bị chặn (E05). **Ngưỡng + cơ chế cần dev/Zalo xác nhận trước khi build** — không chốt cứng | Rủi ro có thật: tài khoản Zalo **dùng chung**, báo xấu không thu hồi được, Zalo có thể phạt/khoá tài khoản nếu bị spam báo cáo → cần chốt chặn; nhưng con số 24h chưa được xác nhận |
| BR07 | **Phạm vi ẩn của "Xoá lịch sử" (theo người thao tác):** tin nhắn ≤ mốc xoá **không hiển thị** ở — khung hội thoại, preview tin cuối ở panel trái, **tìm kiếm trong hội thoại & tìm kiếm hợp nhất (G017)**, **tin đã ghim (G014)**, **tab Ảnh/Video/Tài liệu/Liên kết ở panel phải (G011)**. Badge chưa đọc của người đó về **0**. **Không** ảnh hưởng: dữ liệu gốc, nhân sự khác, báo cáo/thống kê, nhắc hẹn, thẻ, phân công. **[v1.2] Với tin đã ghim:** chỉ **ẩn** tin ghim ≤ mốc khỏi **view của riêng người xoá** (kể cả khỏi danh sách "Tin đã ghim" của họ) — **KHÔNG bỏ ghim**; bản ghim (dùng chung, Zalo-native — G014) **giữ nguyên**, nhân sự khác vẫn thấy ghim bình thường | "Xoá lịch sử" phải nhất quán ở mọi nơi hiển thị nội dung tin nhắn; nhưng ghim là dữ liệu dùng chung nên chỉ ẩn view per-user, không được bỏ ghim (trái BR02 per-user/không xoá thật) |
| BR08 | **Hội thoại đang ẩn (với người đã ẩn):** không đẩy thông báo, không tính badge chưa đọc, không hiện ở danh sách; **vẫn** nhận & lưu tin nhắn bình thường; **vẫn** tìm thấy qua tìm kiếm (AF04). ~~Ẩn **không** ảnh hưởng ghim hội thoại, thẻ, phân công nhân sự~~ **[CHANGED v1.3]** Ẩn **không** ảnh hưởng thẻ, phân công nhân sự; **riêng ghim hội thoại thì Ẩn TỰ BỎ GHIM** (xem BR11) | Ẩn là để tạm dọn danh sách, không phải rời hội thoại |
| BR11 | **[v1.3] Ẩn hội thoại đang ghim → tự bỏ ghim** (per-user, giải phóng slot của chính người đó — G009 BR19). **Hoàn tác (~5s, AF03)** khôi phục **cả ẩn lẫn ghim**. Nếu không Hoàn tác: hội thoại **hiện lại do có tin mới → KHÔNG tự ghim lại** (xếp theo thời gian như hội thoại thường) | Theo Zalo: ẩn = bỏ ghim, giải phóng slot để ghim hội thoại mới; tránh bẫy "kẹt slot" (không còn chỗ bấm bỏ ghim) |
| BR09 | Cả 3 thao tác áp dụng cho **hội thoại 1:1 và hội thoại nhóm** | Zalo hỗ trợ cả 2 loại; nghiệp vụ CSKH cần cả 2 |
| BR10 | **Audit log bắt buộc** cho cả 3 thao tác: ai thực hiện, hội thoại nào, thời điểm; riêng **Báo xấu** lưu thêm **lý do + mô tả** | Báo xấu không thu hồi được và gắn với tài khoản Zalo dùng chung → phải truy vết được; ẩn/xoá cần log để giải thích khi nhân sự "mất" hội thoại |

---

## 7. State Machine / 8. Data Model / 9. API Contract

**N/A — Spec thuần nghiệp vụ.**

- **§7 State Machine:** không có vòng đời phức tạp — hai trạng thái per-user độc lập: *hiện ↔ ẩn* (BR01) và *mốc xoá lịch sử* (BR02, ghi đè).
- **§8 Data Model:** Ẩn & Xoá lịch sử được lưu **theo từng người dùng × hội thoại** (mỗi người một trạng thái riêng), **không xoá thật** dữ liệu gốc; cách lưu do dev quyết định.
- **§9 API Contract:** Ẩn & Xoá lịch sử **xử lý hoàn toàn phía Gopany, KHÔNG đồng bộ Zalo**; chỉ **Báo xấu** đẩy sang Zalo. **Tuyệt đối không dùng thao tác Ẩn / Xoá lịch sử của Zalo-native** — chúng tác động cấp **tài khoản Zalo** (ảnh hưởng app Zalo thật + mọi nhân sự dùng chung tài khoản), trái BR01/BR02. Chi tiết tích hợp: tài liệu kỹ thuật của dev.

---

## 10. UI/UX Notes — Ghi chú giao diện

### 10A — Option menu (bổ sung Ẩn/Xoá) & entry Báo xấu ở panel

**Nút mở:** hover vào hàng hội thoại ở panel trái → hiện **icon "•••" (Thêm)**; bấm (hoặc **chuột phải** vào hàng) → mở **Option menu** (chính là menu ở **G003 §10B**).

```
Panel trái — danh sách hội thoại
┌──────────────────────────────────────────┐
│ 👤 Nguyễn Văn A     10:24   •••  ◄ hover  │  ← icon ••• hiện khi rê chuột
│ 👤 Khách B          09:10                 │
└──────────────────────────────────────────┘
        │ (bấm ••• / chuột phải)
        ▼
┌ Option menu ────────────────────┐
│ Ghim / Bỏ ghim                  │
│ Tắt / Bật thông báo             │
│ Ẩn trò chuyện                   │  ← UC-01 (mới — G024)
│ Xoá lịch sử trò chuyện          │  ← UC-02 (mới — G024)
└─────────────────────────────────┘
   (Báo xấu KHÔNG ở option menu — nằm ở panel thông tin hội thoại)
```
- **Ẩn / Xoá lịch sử:** hiển thị cho **mọi nhân sự có quyền xem hội thoại**; Xoá lịch sử → **popup xác nhận**.

**Báo xấu — ở panel thông tin hội thoại (panel phải, mở khi vào hội thoại):**
```
┌ Panel thông tin hội thoại ───┐
│ … thông tin / thao tác …     │
│ 🚩 Báo xấu                 › │  ← UC-03 → popup chọn lý do (§10B)
└──────────────────────────────┘
```
- **Báo xấu:** chỉ hiển thị khi có **quyền nhắn tin**; **disable + tooltip** khi tài khoản Zalo DISCONNECTED (E03) hoặc đang trong 24h chống spam (E05); bấm → **popup chọn lý do**.

### 10B — Popup Báo xấu (chọn lý do)

```
┌ Báo xấu hội thoại ─────────────────────┐
│ Chọn lý do báo xấu:                     │
│  ( ) Nội dung nhạy cảm                  │
│  ( ) Làm phiền                          │
│  ( ) Lừa đảo                            │
│  (•) Khác                               │
│      ┌───────────────────────────────┐  │
│      │ Mô tả chi tiết (bắt buộc)     │  │  ← chỉ hiện khi chọn "Khác"
│      └───────────────────────────────┘  │
│                                         │
│            [ Huỷ ]        [ Gửi ]       │  ← Gửi disabled khi chưa hợp lệ (E04)
└─────────────────────────────────────────┘
```
- Danh sách lý do **theo danh mục Zalo native** (dev xác nhận từ hub); Gopany hiển thị đúng bộ của Zalo.

### 10C — Sau khi Xoá lịch sử
- Khung hội thoại **trống**; hội thoại **vẫn ở trong danh sách**, preview tin cuối trống, badge chưa đọc = 0; tin nhắn mới đến vẫn hiển thị bình thường.

### 10D — Sau khi Ẩn trò chuyện
- Hội thoại biến khỏi danh sách của người đó; toast *"Đã ẩn trò chuyện"* kèm **Hoàn tác** (~5 giây).

---

## 11. Acceptance Criteria — Tiêu chí nghiệm thu

### Ẩn trò chuyện (UC-01)
- [ ] Ẩn → hội thoại biến khỏi danh sách **của riêng người thao tác**; nhân sự khác **vẫn thấy** (AC-BR01)
- [ ] Ẩn **không** gọi Zalo — kiểm tra trên app Zalo thật, hội thoại **vẫn hiển thị bình thường** (AC-BR01)
- [ ] Hội thoại đã ẩn **có tin mới** (khách gửi đến **hoặc** nhân sự gửi đi) → **tự hiện lại** trong danh sách người đó (AC-BR01)
- [ ] Bấm **Hoàn tác** trên toast → hiện lại ngay (AC-AF03)
- [ ] **[v1.3]** Ẩn hội thoại **đang ghim** → **tự bỏ ghim**, slot ghim của người đó giảm 1 (ghim được hội thoại mới); nhân sự khác không đổi (AC-BR11)
- [ ] **[v1.3]** Hoàn tác sau khi ẩn hội thoại đang ghim → **khôi phục cả ẩn lẫn ghim** (AC-BR11, AC-AF03)
- [ ] **[v1.3]** Không Hoàn tác → hội thoại hiện lại do có tin mới **không tự ghim lại** (AC-BR11)
- [ ] Mở hội thoại đang ẩn từ **tìm kiếm** → hiện lại trong danh sách (AC-AF04)
- [ ] Trong lúc ẩn: **không** thông báo, **không** badge chưa đọc cho người đó; ghim/thẻ/phân công **không đổi** (AC-BR08)
- [ ] Ẩn **không** xoá dữ liệu (AC-BR01)

### Xoá lịch sử (UC-02)
- [ ] **Mọi nhân sự có quyền xem hội thoại** đều dùng được; xoá **view của riêng mình** — nhân sự khác **không bị ảnh hưởng** (AC-BR02)
- [ ] **Không** gọi Zalo — lịch sử trên app Zalo thật **còn nguyên** (AC-BR02)
- [ ] Có **popup xác nhận**; Huỷ → không đổi (AC-AF01)
- [ ] Xác nhận → khung hội thoại (của người đó) **trống**; hội thoại vẫn nằm trong danh sách, preview trống, badge = 0; tin mới sau đó vẫn đến và hiển thị (AC-BR02, AC-BR07)
- [ ] Tin cũ **không** còn xuất hiện ở tìm kiếm hợp nhất (G017), tin ghim (G014), tab Ảnh/Video/Tài liệu (G011) **với người đó** — nhưng **vẫn hiện đầy đủ với người khác** (AC-BR07)
- [ ] **[v1.2]** Xoá lịch sử **không bỏ ghim**: tin ghim ≤ mốc chỉ ẩn khỏi "Tin đã ghim" của người xoá; nhân sự khác **vẫn thấy ghim**; bản ghim giữ nguyên (AC-BR07)
- [ ] Xoá lần 2 → mốc mới ghi đè, tin phát sinh giữa 2 lần cũng bị ẩn (AC-BR02)
- [ ] Dữ liệu **vẫn lưu ngầm** (audit) — **không xoá thật** (AC-BR02)

### Báo xấu (UC-03)
- [ ] Popup **bắt buộc chọn 1 trong các lý do**; chọn "Khác" → **bắt buộc nhập mô tả**; chưa hợp lệ → nút Gửi disabled + lỗi inline (AC-BR03, AC-E04)
- [ ] Huỷ → không gửi, không ghi log (AC-AF02)
- [ ] Gửi hợp lệ → báo xấu lên Zalo kèm đúng lý do; toast *"Đã gửi báo xấu"* (AC-BR03)
- [ ] Chỉ nhân sự có **quyền nhắn tin** thấy/dùng được mục Báo xấu (AC-BR03)
- [ ] Báo xấu thất bại → toast lỗi, dữ liệu đã nhập **giữ nguyên** trong popup (AC-E02)
- [ ] Tài khoản DISCONNECTED → **báo xấu bị chặn**; **ẩn & xoá lịch sử vẫn dùng được bình thường** (AC-BR05, AC-E03)
- [ ] *(Chờ xác nhận BR06)* Báo xấu lần 2 cùng hội thoại trong 24h (kể cả người khác bấm) → **bị chặn** (AC-BR06, AC-E05)
- [ ] Audit log ghi đủ: người thực hiện, hội thoại, lý do, mô tả (AC-BR10)

### Chung
- [ ] Cả 3 thao tác chạy đúng với **hội thoại 1:1 và hội thoại nhóm** (AC-BR09)
- [ ] Thao tác trên hội thoại đã bị xoá / mất quyền → báo lỗi + làm mới danh sách (AC-E06)
- [ ] **Ẩn / Xoá lịch sử KHÔNG gọi Zalo** — chỉ đổi view per-user; **chỉ Báo xấu** đẩy Zalo (AC-BR01, AC-BR02, AC-BR03)

---

## 12. Out of Scope — Ngoài phạm vi

| # | Nội dung | Ghi chú |
|---|---------|---------|
| OOS01 | **Xoá thật** lịch sử (xoá vật lý khỏi hệ thống) và **xoá lịch sử trên Zalo** (Zalo-native) | Chỉ ẩn hiển thị phía Gopany, giữ ngầm cho audit (BR02) |
| OOS02 | **Ẩn hội thoại Zalo-native** (đồng bộ trạng thái ẩn sang app Zalo, mã PIN hội thoại ẩn) | Đã chốt: G024 chỉ ẩn nội bộ (BR01) |
| OOS03 | **Chặn người dùng** | Giai đoạn sau (G011 đã ghi chú; mục đã có trong menu G003 §10B) |
| OOS04 | Màn hình quản lý / khôi phục hội thoại đã ẩn | Phase này chỉ hiện lại qua: có tin mới, Hoàn tác (AF03), mở từ tìm kiếm (AF04) |
| OOS05 | Xem lại lịch sử đã "xoá" từ giao diện người dùng | Dữ liệu chỉ truy xuất qua **audit/log** (không mở UI) |
| OOS06 | Xem lại / quản lý danh sách báo xấu đã gửi | Chỉ lưu audit log, chưa có UI |

---

## 13. Dependencies — Phụ thuộc

| Phụ thuộc | Ghi chú |
|-----------|---------|
| **G003 — Chat** | Danh sách hội thoại & menu tùy chọn (§10B); cần cập nhật G003 với 3 mục mới + hành vi chuột phải |
| **G002 — Chia sẻ tài khoản Zalo cho Staff** | Nhiều nhân sự dùng chung 1 tài khoản Zalo → lý do bắt buộc per-user cho Ẩn/Xoá lịch sử |
| **G010 — Soft Delete & Khôi phục dữ liệu** | DISCONNECTED → chặn Báo xấu, không ảnh hưởng Ẩn/Xoá (BR05, G010 BR04) |
| **G011 — Panel Thông tin & Ghi chú** | Tab Ảnh/Video/Tài liệu/Liên kết phải tôn trọng mốc xoá lịch sử (BR07) — *cần cập nhật theo sau* |
| **G014 — Ghim tin nhắn** | Tin ghim ≤ mốc xoá không hiển thị với người đã xoá (BR07) — *cần cập nhật theo sau* |
| **G009 — Ghim hội thoại (UC-06)** | **[v1.3]** Ẩn hội thoại đang ghim → tự bỏ ghim (per-user, giải phóng slot — BR11 ↔ G009 BR19) |
| **G017 — Tìm kiếm hợp nhất** | Lọc theo mốc xoá lịch sử; hội thoại đang ẩn vẫn tìm được (BR07, BR08, AF04) — *cần cập nhật theo sau* |

---

## 14. Câu hỏi mở — cần BA xác nhận

| # | Câu hỏi | Đề xuất trong v1.1 |
|---|---------|--------------------|
| Q1 | Quyền Báo xấu: "quyền nhắn tin" hay siết chỉ **Admin**? | Quyền nhắn tin (BR03) |
| Q2 | Ngưỡng chống spam báo xấu | 1 lần / 24h / hội thoại, tính toàn workspace — **chờ dev/Zalo xác nhận** (BR06) |
| Q3 | Mở hội thoại đang ẩn từ tìm kiếm có tự bỏ ẩn không? | Có — tránh hội thoại kẹt ẩn vĩnh viễn (AF04) |
| Q4 | Toast ẩn có nút **Hoàn tác** không? | Có, ~5 giây (AF03) |

---

## Changelog

| Ngày | Version | Người thay đổi | Sections | Nội dung | File:Line |
|------|---------|----------------|----------|----------|-----------|
| 2026-08-17 | v1.0 | Trân (BA) | Toàn bộ | Tạo spec **Thao tác hội thoại.** Ẩn trò chuyện = riêng mỗi user, tự hiện lại khi có tin mới (BR01). Xoá lịch sử = riêng mỗi user + popup xác nhận, hệ thống vẫn lưu ngầm (BR02). Báo xấu = gửi lên Zalo + popup xác nhận (BR03). Cả 3 ở menu hội thoại (BR04). DISCONNECTED chặn Báo xấu (BR05) | — |
| 2026-08-19 | v1.1 | Trân (BA) | §1–§6, §10–§14 | Chốt bản chất: **Ẩn & Xoá lịch sử = nội bộ Gopany, KHÔNG gọi Zalo**; **Báo xấu = Zalo-native duy nhất, bắt buộc chọn lý do** (BR03/BR06/E04). Thêm BR06–BR10, AF03/AF04, E06; cơ chế **"mốc xoá" per-user** (BR07). §7/8/9 = N/A. | — |
| 2026-08-26 | v1.2 | Trân (BA) | 6 (BR07), 11 | Làm rõ **Xoá lịch sử × Ghim tin nhắn (G014):** chỉ **ẩn** tin ghim ≤ mốc khỏi view người xoá, **KHÔNG bỏ ghim** (bản ghim dùng chung giữ nguyên). | — |
| 2026-08-26 | v1.3 | Trân (BA) | 2, 3 (UC-01/03), 4, 6 (BR04/BR08/BR11), 10, 11, 13 | **🔺 CHANGE REQUEST (dev).** (a) **Ẩn hội thoại đang GHIM → tự bỏ ghim** (per-user, giải phóng slot; Hoàn tác ~5s khôi phục cả ẩn lẫn ghim — BR08/BR11, đồng bộ G009 v1.12). (b) **Option menu bỏ Báo xấu** — Báo xấu chuyển sang **panel thông tin hội thoại** (BR04/§10A); option menu chỉ còn Ẩn/Xoá cạnh Ghim & Tắt-Bật thông báo. | — |

---

> **Lưu ý cho Dev & AI:**
> - **BR01 & BR02 — nội bộ Gopany, KHÔNG đồng bộ Zalo.** Tuyệt đối không dùng thao tác Ẩn/Xoá lịch sử của **Zalo-native** — chúng tác động cấp **tài khoản Zalo** (ảnh hưởng app Zalo thật + mọi nhân sự dùng chung tài khoản).
> - **Ẩn = per-user**, tự hiện khi có tin mới / Hoàn tác / mở từ tìm kiếm.
> - **Xoá lịch sử = per-user, theo mốc thời điểm**, KHÔNG xoá thật; phải lọc nhất quán ở **mọi** điểm hiển thị (khung chat, preview, tìm kiếm G017, tin ghim G014, panel media G011) — xem BR07.
> - **Báo xấu = Zalo-native duy nhất**, bắt buộc chọn lý do (danh mục **do Zalo cung cấp** — dev xác nhận từ hub); lưu lý do vào audit log (BR10); chống spam 24h **[chờ xác nhận]** (BR06).
> - **BR05:** DISCONNECTED chặn Báo xấu; Ẩn/Xoá lịch sử vẫn chạy (nội bộ Gopany).
