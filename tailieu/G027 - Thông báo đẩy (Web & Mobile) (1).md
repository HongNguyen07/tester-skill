# [G027] Thông báo đẩy (Web & Mobile)

| Trường | Nội dung |
|--------|----------|
| **Feature ID** | **G027** |
| **Tên** | Thông báo đẩy — Web (trình duyệt) & Mobile |
| **Module** | Chat / Chăm sóc khách hàng |
| **Owner (BA)** | Trân |
| **Status** | Draft |
| **Last updated** | 2026-08-20 |

---

## 1. Tổng quan

Báo cho nhân sự ngay khi có việc cần biết — **kể cả khi không đang nhìn màn hình Gopany** — trên **web** và **app mobile**. Tài liệu xác định hai điều: **(1) có những loại thông báo gì** và **(2) thông báo hiển thị ra sao**.

**Người dùng mục tiêu:** mọi nhân sự (Admin / Staff) đang đăng nhập Gopany trên web hoặc mobile.

---

## 2. Các loại thông báo (4 loại)

| # | Loại thông báo | Kích hoạt khi | Bấm vào → mở | Phân loại (G022) |
|---|----------------|---------------|--------------|------------------|
| 1 | **Tin nhắn mới** | Có tin đến trong hội thoại người dùng có quyền xem | Hội thoại tương ứng | Hội thoại |
| 2 | **@Mention trong nhóm** | Có người nhắc tên mình trong nhóm | Nhóm, tại vị trí được nhắc | Hội thoại |
| 3 | **Nhắc hẹn đến hạn** | Tới giờ nhắc hẹn (G019) | Hội thoại liên quan | Hội thoại |
| 4 | **Mất kết nối tài khoản Zalo** | Tài khoản Zalo bị ngắt kết nối (G010) | Thiết lập › Liên kết tài khoản *(màn kết nối lại — G001/G010)* | Hệ thống |

**Ghi chú theo loại:**
- **@Mention (loại 2):** khi tài khoản Zalo dùng chung bị nhắc, báo cho **mọi nhân sự phụ trách tài khoản đó** (không xác định đích danh người được nhắc — Zalo không cung cấp thông tin này). Tin **"@Tất cả"** cũng tính là mention (BR08).
- **Nhắc hẹn (loại 3):** thực tế chỉ phát thông báo đẩy khi **(a) nhắc Cá nhân**, hoặc **(b) nhắc Mọi người lúc tài khoản Zalo mất kết nối**. Khi tài khoản đang kết nối, nhắc "Mọi người" do **chính Zalo nhắc** thành viên nhóm → Gopany **không báo song song** để tránh trùng (BR09).

---

## 3. Thông báo hiển thị ra sao

### 3.1 Dạng hiển thị — theo vị trí người dùng đang ở

| Người dùng đang ở | Dạng thông báo |
|-------------------|----------------|
| **Web — đang mở tab Gopany** | **Toast** nổi ở góc màn hình |
| **Web — tab ở nền / cửa sổ khác** | **Thông báo của trình duyệt/hệ điều hành** |
| **Mobile — app ở nền hoặc đóng** | **Push** trên điện thoại |
| **Mọi trường hợp (kèm theo)** | **Âm thanh** báo + **số chưa đọc** trên tab/icon ứng dụng |

### 3.2 Nội dung mỗi thông báo

- **Avatar** hội thoại
- **Tên hội thoại** (hội thoại nhóm: thêm **tên người gửi**)
- **Trích nội dung tin** (preview)
- **Tên tài khoản Zalo** liên quan (khi dùng nhiều tài khoản)

```
┌ [avatar] ───────────────────────────────┐
│ Tên hội thoại / nhóm                     │
│ Tên người gửi         (chỉ hội thoại nhóm)│
│ Trích nội dung tin nhắn…                  │
└──────────────────────────────────────────┘
```

---

## 4. Luồng chính (Happy Path)

**UC-01 — Nhận & hiển thị thông báo**
1. Phát sinh một sự kiện thuộc §2.
2. Nếu hội thoại **đã tắt thông báo** (G028) và không thuộc ngoại lệ → không báo (số chưa đọc vẫn cập nhật).
3. Hiển thị thông báo theo **dạng phù hợp vị trí người dùng** (§3.1), với **nội dung đầy đủ** (§3.2).
4. Nhiều tin cùng một hội thoại trong khoảng **~5 phút** → **gộp thành một thông báo** ("N tin mới").

**UC-02 — Đồng ý nhận thông báo trên web (lần đầu)**
- Lần đầu, người dùng được mời **đồng ý cho phép hiển thị thông báo**. Đồng ý → nhận thông báo cả khi tab ở nền. Từ chối → chỉ còn toast khi đang mở tab + số chưa đọc.

**UC-03 — Bấm vào thông báo**
- Đưa người dùng tới **đúng nơi liên quan** (§2, cột "Bấm vào → mở") và **đánh dấu đã đọc** phần tương ứng.

---

## 5. Quy tắc nghiệp vụ

| Code | Rule |
|------|------|
| BR01 | Đẩy đúng **4 loại** thông báo ở §2, dùng chung phân loại Hội thoại/Hệ thống với **G022**. |
| BR02 | **Nội dung đầy đủ:** avatar + tên hội thoại (+ tên người gửi nếu nhóm) + trích nội dung tin + tên tài khoản Zalo liên quan. |
| BR03 | **Tôn trọng cài đặt tắt thông báo** của hội thoại (G028): đã tắt thì không báo, **số chưa đọc vẫn cập nhật**. |
| BR04 | **Ngoại lệ luôn báo** dù đã tắt: **@Mention** (trong nhóm), **Mất kết nối tài khoản Zalo**, và **Nhắc hẹn Cá nhân** (do chính người đó đặt). **Nhắc hẹn Mọi người → tôn trọng tắt thông báo** (BR09). |
| BR05 | Nhiều tin cùng một hội thoại trong khoảng **~5 phút** → **gộp một thông báo** ("N tin mới"); nhiều thiết bị/tab của cùng người → **không báo trùng**. |
| BR06 | **Âm thanh** có thể tắt trong cài đặt thông báo; **số chưa đọc** = tổng chưa đọc, do **app/web tự tính** hiển thị trên tab/icon ứng dụng. |
| BR07 | **Ai nhận** thông báo "tin nhắn mới": hội thoại **đã phân công riêng → chỉ báo người được phân công**; hội thoại **chưa phân công → báo mọi nhân sự có quyền xem** (admin + người phụ trách tài khoản + người bật "xem hội thoại chưa phân công"). |
| BR08 | **@Mention khi tài khoản dùng chung:** Zalo không cho biết đích danh người được nhắc → báo cho **mọi nhân sự phụ trách tài khoản** bị nhắc; **"@Tất cả" tính là mention**. |
| BR09 | **Nhắc hẹn:** loại **Cá nhân → luôn báo** (kể cả khi tắt thông báo). Loại **Mọi người → tôn trọng tắt**; và khi tài khoản Zalo **đang kết nối, Gopany KHÔNG báo song song** (Zalo đã tự nhắc) — chỉ báo khi tài khoản **mất kết nối**. |

---

## 6. Luồng ngoại lệ

| Code | Trigger | Ứng xử |
|------|---------|--------|
| E01 | Hội thoại đã tắt thông báo và không thuộc ngoại lệ (BR04) | Không báo; số chưa đọc vẫn cập nhật |
| E02 | Người dùng không có quyền xem hội thoại phát sinh tin | Không báo cho người đó |
| E03 | Người dùng chưa/không đồng ý nhận thông báo web | Chỉ toast khi đang mở tab + số chưa đọc |

---

## 7. Tiêu chí nghiệm thu

- [ ] Đẩy đúng 4 loại: Tin nhắn mới, @Mention, Nhắc hẹn đến hạn, Mất kết nối.
- [ ] Đang mở tab → **toast góc màn hình**; tab ở nền → **thông báo trình duyệt/hệ điều hành**; mobile nền/đóng → **push**; kèm âm thanh + số chưa đọc.
- [ ] Nội dung thông báo đầy đủ: avatar + tên hội thoại (+ người gửi nếu nhóm) + preview.
- [ ] Hội thoại đã tắt thông báo → không báo, số chưa đọc vẫn cập nhật; **@Mention & Mất kết nối vẫn báo**.
- [ ] Bấm thông báo → mở đúng nơi + đánh dấu đã đọc.
- [ ] Nhiều tin cùng hội thoại → gộp một thông báo; nhiều thiết bị → không báo trùng.
- [ ] Âm thanh tắt được trong cài đặt.

---

## 8. Ngoài phạm vi

| # | Nội dung | Ghi chú |
|---|---------|---------|
| OOS01 | Danh sách/lịch sử thông báo | Đã có ở **G022** |
| OOS02 | Thông báo module Cửa hàng / Công việc | Module khác |
| OOS03 | Cấu hình chi tiết từng loại (bật/tắt riêng, giờ im lặng) | Phase sau |
| OOS04 | Thông báo qua Email / SMS / Zalo OA | Ngoài phạm vi |

---

## 9. Phụ thuộc

| Phụ thuộc | Ghi chú |
|-----------|---------|
| **G022 — Trung tâm thông báo** | Phân loại (Hội thoại/Hệ thống); G027 đẩy chủ động 4 loại này |
| **G028 — Tắt/Bật thông báo hội thoại** | Quyết định hội thoại có được phát thông báo hay không (BR03) |
| **G019 — Nhắc hẹn** | Nội dung & đích thông báo Nhắc hẹn |
| **G010 — Soft Delete & Khôi phục dữ liệu** | Sự kiện Mất kết nối tài khoản Zalo |
| **G003 — Chat** | Hội thoại, số chưa đọc, đích khi bấm thông báo |
