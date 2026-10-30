---
name: "qa-log-bug-web"
description: "Log bug web Gopany theo template QA chuẩn (trình duyệt, OS, môi trường thay cho thiết bị mobile): tiêu đề, Precondition, Steps, Expect/Actual, mức độ, EVD."
---

# QA Log Bug – Web Gopany

Dùng khi người dùng mô tả một lỗi trên **web** Gopany (bằng lời, ảnh, video, testcase Fail) và muốn viết thành bug để log lên Gopany. Viết bằng tiếng Việt, ngắn gọn, cụ thể, tái hiện được.

## 0. Giá trị mặc định

Nếu người dùng không nêu khác, LUÔN dùng mặc định:

- **Môi trường:** `Chrome – Ubuntu – Dev (app-dev.gopany.site)`
- **Người thực hiện:** `Vũ Ngọc Hiếu`
- **Người liên quan (chọn cả 5):** `Tưởng Văn Chiến`, `Trần Thị Trà`, `Nguyễn Thanh Hoàng`, `Hoàng Thị Minh Trang`, `Nguyễn Nhật Minh`

Lưu ý trùng tên khi tìm trong Gopany: "Hoàng" = Nguyễn Thanh Hoàng (không phải Trần Thư Hoàng); "Trang" = Hoàng Thị Minh Trang (không phải Lê Thị Quỳnh Trang); "Minh" = Nguyễn Nhật Minh. Nếu một người vừa là người thực hiện thì Gopany không cho chọn thêm làm người liên quan → bỏ qua người đó ở ô liên quan.

Giữ các mặc định này cho tới khi người dùng yêu cầu đổi. Khi người dùng nêu trình duyệt/OS/môi trường, người thực hiện hoặc người liên quan khác cho một bug cụ thể → chỉ dùng cho bug đó, trừ khi họ nói đổi mặc định. Nếu ảnh/video cho thấy URL khác (vd Staging, Prod) → ghi đúng môi trường theo URL đó. Bug gốc chỉ ghi chung chung (vd "web") → dùng mặc định thay vì để trống.

Các môi trường thường gặp: Dev (app-dev.gopany.site), Staging, Prod, Prod nội bộ.

## 1. Quy tắc chung

- **Mỗi lỗi = 1 task.** Người dùng mô tả nhiều lỗi → tách thành nhiều bug riêng.
- **Tiêu đề**: `[Module/Màn hình] Tên lỗi ngắn gọn` – nêu hiện tượng, không nêu nguyên nhân. Với bug Zalo trên CRM Project, theo quy ước của board: `[Zalo][Bug] Lỗi ...` (vd `[Zalo][Bug] Lỗi thiếu thao tác chuyển tiếp ảnh ở trình xem ảnh`).
- **Steps**: đánh số, mỗi bước 1 dòng, bắt đầu bằng động từ; dùng `>>` cho điều hướng giữa các màn (vd `Truy cập hệ thống >> Chăm sóc khách hàng >> Tin nhắn`); tên nút trong ngoặc kép, đúng như trên UI.
- **Expect Result**: kết quả đúng theo design/tài liệu; thông báo nguyên văn trong ngoặc kép.
- **Actual Result**: mô tả cụ thể cái đang xảy ra (nguyên văn thông báo lỗi, vị trí, tần suất nếu không ổn định – vd "3/5 lần"). Cấm viết chung chung kiểu "bị lỗi", "không hoạt động".
- **Môi trường**: ghi đủ `trình duyệt – OS – môi trường (URL)` (mặc định xem mục 0). Lỗi trên nhiều trình duyệt → liệt kê hết các trình duyệt đã tái hiện; nếu đã thử trình duyệt khác mà không lỗi thì ghi rõ.
- **Bằng chứng (EVD)**: bug UI kèm ảnh design + ảnh actual; bug thao tác kèm video.
- Log xong: nhắc điền mã task vào cột **Error Code** của testcase/checklist bị Fail.
- Thiếu thông tin bắt buộc khác (bước tái hiện, nội dung thông báo theo design) → hỏi lại hoặc để placeholder `...` và nhắc người dùng bổ sung; KHÔNG tự bịa. (Tránh placeholder `__` khi dán vào editor Gopany vì bị hiểu là định dạng in đậm.)

## 2. Các trường của 1 bug

`Tiêu đề`, `[Precondition]`, `[Steps]`, `[Expect Result]`, `[Actual Result]`, `Trình duyệt / OS`, `Môi trường`, `Mức độ`, `Trạng thái`, `Testcase liên quan`, `[EVD] ảnh/video`, `Mã task`, `Người log`, `Người thực hiện`, `Người liên quan`, `Ngày log`

- **Mức độ**: Nghiêm trọng | Cao | Trung bình | Thấp
- **Trạng thái**: Mới | Đang sửa | Chờ retest | Đã đóng | Reopen | Không phải bug (bug mới log mặc định `Mới`)
- **Testcase liên quan**: ID testcase/checklist Fail (vd `[WEB_16]`), không có → `-`.
- **Người thực hiện**: mặc định `Vũ Ngọc Hiếu` (xem mục 0).
- **Người liên quan**: mặc định `Tưởng Văn Chiến`, `Trần Thị Trà`, `Nguyễn Thanh Hoàng`, `Hoàng Thị Minh Trang`, `Nguyễn Nhật Minh` (xem mục 0).
- **Mã task**: điền sau khi tạo task (vd `#260910003_024`).
- **Ngày log**: dd/mm.

## 3. Định nghĩa mức độ

| Mức độ | Khi nào |
|---|---|
| Nghiêm trọng | Crash/trang trắng, mất/sai dữ liệu, lỗi bảo mật/phân quyền, chặn luồng chính không có cách khác. |
| Cao | Chức năng chính sai nhưng còn cách đi vòng; ảnh hưởng nhiều người dùng. |
| Trung bình | Chức năng phụ sai; UI lệch design gây khó dùng. |
| Thấp | Lỗi hiển thị nhỏ, chính tả, góp ý UX. |

Tự đề xuất mức độ theo bảng trên và giải thích ngắn nếu không hiển nhiên. Trên Gopany, ô Mức độ ưu tiên chỉ có Cao / Trung bình / Thấp → Nghiêm trọng chọn Cao.

## 4. Form mô tả (dán vào ô Mô tả trên Gopany, các nhãn in đậm)

```
[Precondition]: Đã đăng nhập thành công web Gopany, thiết bị có kết nối mạng
[Steps]:
1. Truy cập hệ thống >> <màn hình>
2. <thao tác>
3. <thao tác / quan sát>
[Expect Result]: <kết quả đúng>
[Actual Result]: <kết quả thực tế, mô tả cụ thể>
Môi trường: Chrome – Ubuntu – Dev (app-dev.gopany.site)
[EVD]: <ảnh / video>
```

## 5. Định dạng đầu ra

Với mỗi bug, trả về:

1. **Tiêu đề** (1 dòng, sẵn để copy).
2. **Mô tả** theo form mục 4 trong code block (sẵn để dán vào Gopany).
3. Các trường còn lại dạng danh sách: Trình duyệt / OS, Môi trường, Mức độ, Trạng thái, Testcase liên quan, EVD cần đính kèm, Mã task, Người log, Người thực hiện, Người liên quan, Ngày log.
4. Một dòng nhắc: thông tin còn thiếu cần bổ sung (nếu có) và điền mã task vào Error Code của testcase.

### Tạo task trực tiếp trên Gopany

Khi người dùng nhờ log/tạo task (vd "log cho tôi", chuyển bug sang project khác), bấm "Tạo mới" trên board và điền:

- Tên tác vụ = tiêu đề.
- Người giao việc: giữ mặc định (người dùng hiện tại).
- Người thực hiện và Người liên quan theo mục 0 (trừ khi người dùng chỉ định khác). Gõ tên để lọc (dùng cụm tên riêng như "Thanh Hoàng", "Minh Trang", "Nhật Minh" để chỉ còn 1 kết quả), chờ danh sách lọc xong rồi chọn bằng bàn phím (mũi tên + Enter) thay vì bấm chuột, và kiểm tra lại tên đã chọn (danh sách chưa lọc xong dễ chọn nhầm người). Không nhấn Esc để đóng dropdown vì có thể đóng luôn form — bấm vào tiêu đề form để đóng dropdown.
- Ngày kết thúc (bắt buộc) = ngày log, trừ khi người dùng nêu hạn khác.
- Mức độ ưu tiên theo mục 3 (hoặc theo bug gốc khi chuyển bug).
- Mô tả = form mục 4, nhãn in đậm; Steps dùng danh sách đánh số.
- Đính kèm ảnh/video EVD người dùng gửi vào File đính kèm (ảnh ≤ 2MB, tệp ≤ 5MB), đặt tên file mô tả (vd `actual-<tóm-tắt-lỗi>.png`).
- Khi chuyển bug sang project khác: ghi mã bug gốc cuối mô tả để truy vết.
- Kiểm tra lại toàn bộ trường trước khi bấm "Xác nhận"; sau khi tạo, báo lại mã task cho người dùng.
- Sửa người liên quan của task đã tạo: mở task >> "..." >> "Sửa" (panel Tổng quan chỉ để xem); sau khi lưu kiểm tra có thông báo "Cập nhật tác vụ thành công".

## 6. Ví dụ

**[Zalo][Bug] Lỗi thiếu thao tác chuyển tiếp ảnh ở trình xem ảnh**

```
[Precondition]: Đã đăng nhập thành công web Gopany, đã kết nối tài khoản Zalo, có hội thoại chứa ảnh, thiết bị có kết nối mạng
[Steps]:
1. Truy cập hệ thống >> Chăm sóc khách hàng >> Tin nhắn
2. Mở hội thoại có ảnh
3. Bấm vào 1 ảnh để mở trình xem ảnh
4. Quan sát thanh thao tác góc trên bên phải
[Expect Result]: Thanh thao tác có nút "Chuyển tiếp" để chuyển tiếp ảnh sang hội thoại khác (theo design)
[Actual Result]: Thanh thao tác chỉ có 5 nút: Tải xuống, Phóng to, Thu nhỏ, Xoay, Đóng – không có nút "Chuyển tiếp"
Môi trường: Chrome (Incognito) – Ubuntu – Dev (app-dev.gopany.site)
[EVD]: Ảnh đính kèm
```

- Mức độ: Trung bình · Trạng thái: Mới · Testcase liên quan: - · Mã task: #260910003_023 · Người log: Hồng · Người thực hiện: Vũ Ngọc Hiếu · Người liên quan: Tưởng Văn Chiến, Trần Thị Trà, Nguyễn Thanh Hoàng, Hoàng Thị Minh Trang, Nguyễn Nhật Minh · Ngày log: 14/10

**[Đăng nhập] Trang trắng khi mất mạng lúc bấm Đăng nhập**

```
[Precondition]: Đã đăng xuất web Gopany
[Steps]:
1. Truy cập hệ thống >> Đăng nhập
2. Nhập tài khoản hợp lệ
3. Ngắt kết nối mạng
4. Bấm "Đăng nhập"
[Expect Result]: Hiện thông báo không có kết nối mạng, giữ nguyên dữ liệu đã nhập
[Actual Result]: Trang chuyển trắng, tải lại phải nhập lại
Môi trường: Firefox – Windows 11 – Staging
[EVD]: trang-trang.mp4
```

- Mức độ: Nghiêm trọng · Trạng thái: Mới · Testcase liên quan: [WEB_16] · Mã task: (điền sau khi tạo) · Người log: Hồng · Người thực hiện: Vũ Ngọc Hiếu · Người liên quan: Tưởng Văn Chiến, Trần Thị Trà, Nguyễn Thanh Hoàng, Hoàng Thị Minh Trang, Nguyễn Nhật Minh · Ngày log: 14/10

## 7. Tự rà trước khi trả

- Tiêu đề có `[Module/Màn hình]` (bug Zalo: `[Zalo][Bug]`) và nêu đúng hiện tượng.
- Steps tái hiện được từ đầu, dùng `>>` cho điều hướng.
- Expect và Actual đối chiếu được với nhau, không chung chung.
- Đủ trình duyệt – OS – môi trường (mặc định `Chrome – Ubuntu – Dev (app-dev.gopany.site)` nếu không có thông tin khác; ưu tiên môi trường theo URL trong ảnh/video).
- Người thực hiện là `Vũ Ngọc Hiếu`; người liên quan đủ 5 người `Tưởng Văn Chiến`, `Trần Thị Trà`, `Nguyễn Thanh Hoàng`, `Hoàng Thị Minh Trang`, `Nguyễn Nhật Minh` (trừ khi người dùng chỉ định khác; bỏ người trùng với người thực hiện).
- EVD đúng loại (UI → ảnh design + actual; thao tác → video).
- Mỗi bug chỉ 1 lỗi; mức độ đúng định nghĩa.