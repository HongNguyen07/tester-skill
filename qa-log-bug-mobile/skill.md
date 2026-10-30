---
name: "qa-log-bug-mobile"
description: "Log bug mobile Gopany theo template QA chuẩn: tiêu đề [EPIC][BUG][S1–S4], Precondition, Steps, Expect/Actual, thiết bị, mức S1–S4, EVD, sẵn để dán vào task."
---

# QA Log Bug – Mobile Gopany

Dùng khi người dùng mô tả một lỗi (bằng lời, ảnh, video, testcase Fail) và muốn viết thành bug để log lên Gopany. Viết bằng tiếng Việt, ngắn gọn, cụ thể, tái hiện được. Mọi bug đều được tạo task trên board theo mẫu và gán mức S1–S4 (theo trang "03. Quản lý task trên ERP").

## 0. Giá trị mặc định

Nếu người dùng không nêu khác, LUÔN dùng mặc định:

- **Thiết bị:** `iPhone 17 – iOS 26 – App v1.0.4(11)`
- **Người thực hiện / Người liên quan:** theo EPIC và loại lỗi FE/BE (xem mục 1a). Mọi bug, mọi EPIC luôn có thêm **Nguyễn Thanh Hoàng** trong Người liên quan.

Giữ các mặc định này cho tới khi người dùng yêu cầu đổi. Khi người dùng nêu giá trị khác cho một bug cụ thể → chỉ dùng cho bug đó, trừ khi họ nói đổi mặc định. Bug gốc chỉ ghi chung chung (vd "ios") → dùng mặc định thay vì để trống.

**Môi trường** (Dev / Staging / Prod / Prod nội bộ) là trường bắt buộc nhưng không có mặc định: lấy theo người dùng nêu hoặc theo ảnh/video (vd URL `dev.gopany.site` → Dev); không rõ → để `...` và nhắc bổ sung.

## 1. Quy tắc chung

- **Mỗi lỗi = 1 task.** Người dùng mô tả nhiều lỗi → tách thành nhiều bug riêng. Thấy thêm lỗi khác trong ảnh/video → nêu ra và đề nghị log riêng, không gộp.
- **Tiêu đề**: `[EPIC][BUG][S1–S4] Mô tả ngắn` – EPIC là epic/module chứa tính năng (vd `Zalo`, `LOGIN`, `TASK`); mức là một trong `S1`, `S2`, `S3`, `S4`; mô tả nêu hiện tượng, không nêu nguyên nhân. Vd `[Zalo][BUG][S4] Tin nhắn ghi âm hiển thị xem trước là "[Hình ảnh]"`, `[LOGIN][BUG][S1] App crash khi mất mạng lúc bấm Đăng nhập`. EPIC không rõ → hỏi lại hoặc dùng module theo màn hình và nhắc người dùng xác nhận.
- **Nội dung bắt buộc**: bước tái hiện, kết quả mong đợi, kết quả thực tế, môi trường, thiết bị + phiên bản OS + phiên bản app, ảnh/video.
- **Steps**: đánh số, mỗi bước 1 dòng, bắt đầu bằng động từ; dùng `>>` cho điều hướng giữa các màn (vd `Truy cập app Gopany >> Zalo >> Tin nhắn mẫu`); tên nút trong ngoặc kép, đúng như trên UI (UI khác tài liệu thì dùng tên trên UI và nhắc người dùng).
- **Expect Result / Actual Result đánh số theo bước**: kết quả của bước nào thì mang đúng số thứ tự của bước đó (vd bước 3 và 4 có kết quả → ghi `3. ...`, `4. ...`, không đánh lại từ 1). Expect và Actual dùng cùng các số để đối chiếu từng dòng.
- **Expect Result**: kết quả đúng theo design/tài liệu (ghi mã AC nếu có); thông báo nguyên văn trong ngoặc kép.
- **Actual Result**: mô tả cụ thể cái đang xảy ra (nguyên văn thông báo lỗi, vị trí, tần suất nếu không ổn định – vd "3/5 lần"). Cấm viết chung chung kiểu "bị lỗi", "không hoạt động".
- **Thiết bị**: ghi đủ `model – OS – App phiên bản` (mặc định xem mục 0). Lỗi trên nhiều máy → liệt kê hết các máy đã tái hiện; nếu đã thử máy khác mà không lỗi thì ghi rõ.
- **Bằng chứng (EVD)**: bug UI kèm ảnh design + ảnh actual; bug thao tác/crash kèm video (crash nên kèm log, số liệu Firebase nếu có).
- Trước khi log: rà board xem đã có bug trùng hoặc liên quan chưa; có → báo người dùng và hỏi log mới hay comment vào bug cũ.
- Log xong: nhắc điền mã task vào cột **Error Code** của testcase/checklist bị Fail.
- Thiếu thông tin bắt buộc khác (bước tái hiện, nội dung thông báo theo design) → hỏi lại hoặc để placeholder `...` và nhắc người dùng bổ sung; KHÔNG tự bịa. (Tránh placeholder `__` khi dán vào editor Gopany vì bị hiểu là định dạng in đậm.)

## 1a. Phân công Người thực hiện / Người liên quan

Phân công theo EPIC và loại lỗi (FE hay BE). **Mọi bug, mọi EPIC: Người liên quan luôn có thêm Nguyễn Thanh Hoàng.**

| EPIC | Lỗi FE | Lỗi BE | Không phân biệt được |
|---|---|---|---|
| Zalo | Thực hiện: Nguyễn Nhật Minh · Liên quan: Trịnh Xuân Tùng, Nguyễn Thanh Hoàng | Thực hiện: Trịnh Xuân Tùng · Liên quan: Nguyễn Nhật Minh, Nguyễn Thanh Hoàng | Thực hiện: Nguyễn Nhật Minh · Liên quan: Trịnh Xuân Tùng, Nguyễn Thanh Hoàng |
| LOGIN | Thực hiện: Vũ Ngọc Hiếu · Liên quan: Tưởng Văn Chiến, Nguyễn Thanh Hoàng | Thực hiện: Tưởng Văn Chiến · Liên quan: Vũ Ngọc Hiếu, Nguyễn Thanh Hoàng | Thực hiện: Vũ Ngọc Hiếu · Liên quan: Tưởng Văn Chiến, Nguyễn Thanh Hoàng |
| EPIC khác | Hỏi người dùng · Liên quan có Nguyễn Thanh Hoàng | Hỏi người dùng · Liên quan có Nguyễn Thanh Hoàng | Hỏi người dùng · Liên quan có Nguyễn Thanh Hoàng |

Cách phân biệt FE / BE (chỉ kết luận khi có căn cứ rõ, không chắc → coi là "không phân biệt được"):

- **FE**: hiển thị UI sai/lệch design, thiếu hoặc sai thông báo kiểm tra dữ liệu nhập phía client (bỏ trống, sai định dạng), nút enable/disable sai, điều hướng sai màn, bàn phím/scroll/layout, crash do thao tác UI, text/chính tả, dữ liệu API trả đúng nhưng app hiển thị sai, lỗi chỉ xảy ra trên 1 nền tảng (iOS hoặc Android) trong khi nền tảng kia đúng.
- **BE**: dữ liệu trả về sai/thiếu/trùng, lưu không thành công hoặc mất dữ liệu sau khi tải lại, lỗi mã/thông báo từ server (vd 500, "Có lỗi xảy ra"), phân quyền, đồng bộ/realtime giữa thiết bị, thông báo đẩy không gửi, logic nghiệp vụ tính sai (OTP, giới hạn số lần, hết hạn), cùng lỗi xảy ra cả trên web và mobile.

Ghi trường **Phân loại: FE | BE | Chưa rõ** kèm lý do ngắn trong đầu ra để người dùng kiểm tra.

## 2. Các trường của 1 bug

`Tiêu đề`, `[Precondition]`, `[Steps]`, `[Expect Result]`, `[Actual Result]`, `Môi trường`, `Thiết bị / OS / Phiên bản app`, `Mức độ`, `Phân loại`, `Trạng thái`, `Nhãn`, `Nguồn bug`, `Testcase liên quan`, `[EVD] ảnh/video`, `Mã task`, `Người log`, `Người thực hiện`, `Người liên quan`, `Ngày log`

- **Mức độ**: S1 | S2 | S3 | S4 (xem mục 3). Người báo bug đề xuất, PdM chốt khi chuyển bug sang READY; riêng S1, QA lead hoặc người điều phối được chốt ngay và báo PdM sau. Ghi rõ là "đề xuất".
- **Phân loại**: FE | BE | Chưa rõ (xem mục 1a).
- **Người thực hiện / Người liên quan**: theo mục 1a (luôn kèm Nguyễn Thanh Hoàng), trừ khi người dùng chỉ định khác.
- **Trạng thái**: bug mới log = `KHỞI TẠO` (xem mục 4).
- **Nhãn**: S1/S2 chen ngang sprint → `Ngoài kế hoạch`; QA test lại không đạt → `Reopened`. Không có → `-`.
- **Nguồn bug**: QA test trong sprint (QA tạo) | Dogfooding nội bộ (người phát hiện tạo) | Người dùng phản ánh từ store (CSKH-triển khai tạo) | Crash/Firebase sau release (release owner hoặc người phát hiện tạo). Mặc định `QA test trong sprint`.
- **Testcase liên quan**: ID testcase/checklist/AC Fail (vd `[MB_16]`, `AC17`), không có → `-`.
- **Mã task**: điền sau khi tạo task.
- **Ngày log**: dd/mm.

## 3. Mức độ nghiêm trọng và thời hạn

| Mức | Định nghĩa | Ví dụ | Thời hạn | Cách xử lý |
|---|---|---|---|---|
| S1 | Sập app hoặc mất dữ liệu, không có cách lách | Crash, mất dữ liệu, không đăng nhập được | Trong ngày | Chen ngang sprint, bỏ qua bước 3–7 của workflow; có thể hotfix |
| S2 | Chặn một chức năng chính | Không gửi được tin Zalo, không tạo được công việc/workspace | 1–2 ngày | Chen ngang sprint, bỏ qua bước 3–7 |
| S3 | Lỗi chức năng nhưng có cách lách | Lọc tin nhắn chưa đọc bị sai, phải tìm thủ công | Sprint gần nhất | Theo workflow bình thường |
| S4 | Lỗi hiển thị nhỏ, không ảnh hưởng thao tác | Lệch chữ, sai màu, sai chính tả | Backlog | PdM xếp ưu tiên |

Tự đề xuất mức theo bảng trên và giải thích ngắn nếu không hiển nhiên. Bug S1/S2 → nhắc gắn nhãn `Ngoài kế hoạch` và báo người điều phối. Nếu ô "Mức độ ưu tiên" trên Gopany chỉ có Cao / Trung bình / Thấp: S1, S2 → Cao; S3 → Trung bình; S4 → Thấp.

## 4. Đường đi trạng thái

`KHỞI TẠO → READY → IN PROGRESS → REVIEWED → TESTING → TESTED → READY TO RELEASE → DONE`

- Bug ảnh hưởng giao diện hoặc hành vi người dùng: qua thêm bước UAT trước READY TO RELEASE.
- QA test lại không đạt: chuyển về IN PROGRESS, gắn nhãn `Reopened`, ghi lý do vào comment.
- Escalation: S1/S2 không tự gỡ được sau khoảng 4 giờ → anh Vương; không thống nhất mức độ/ưu tiên → PdM; bug do BE dùng chung với web → Chiến báo PdM, PdM và anh Vương quyết ưu tiên.

## 5. Form mô tả (dán vào ô Mô tả trên Gopany, các nhãn in đậm)

```
[Precondition]: Đã cài đặt và đăng nhập thành công Gopany, thiết bị có kết nối mạng
[Steps]:
1. Truy cập app Gopany >> <màn hình>
2. <thao tác>
3. <thao tác / quan sát>
[Expect Result]:
<số bước>. <kết quả đúng của bước đó>
[Actual Result]:
<số bước>. <kết quả thực tế của bước đó, mô tả cụ thể>
Môi trường: <Dev / Staging / Prod>
Thiết bị: iPhone 17 – iOS 26 – App v1.0.4(11)
[EVD]: <ảnh / video>
[Note]: <tùy chọn: lỗi tương tự ở luồng khác, bug liên quan>
```

## 6. Định dạng đầu ra

Với mỗi bug, trả về:

1. **Tiêu đề** `[EPIC][BUG][Sx] ...` (1 dòng, sẵn để copy).
2. **Mô tả** theo form mục 5 trong code block (sẵn để dán vào Gopany).
3. Các trường còn lại dạng danh sách: Mức độ (đề xuất + lý do ngắn), Phân loại FE/BE (+ lý do ngắn), Trạng thái, Nhãn, Nguồn bug, Testcase liên quan, EVD cần đính kèm, Mã task, Người log, Người thực hiện, Người liên quan, Ngày log.
4. Một dòng nhắc: thông tin còn thiếu cần bổ sung (nếu có), PdM chốt mức khi chuyển READY, và điền mã task vào Error Code của testcase.

Khi người dùng nhờ tạo task trực tiếp trên Gopany (vd "log đi", chuyển bug sang project khác): điền Tên tác vụ = tiêu đề, Mô tả = form mục 5 (nhãn in đậm), Người thực hiện / Người liên quan theo mục 1a (luôn thêm Nguyễn Thanh Hoàng) hoặc người dùng chỉ định, Ngày bắt đầu = ngày log, Ngày kết thúc theo thời hạn mục 3, mức độ ưu tiên theo mục 3, gắn nhãn theo mục 2 (form tạo task không có ô Nhãn → nhắc người dùng gắn tay), đính kèm ảnh người dùng gửi; ghi mã bug gốc cuối mô tả để truy vết. Khi chọn người trong dropdown, gõ phần tên phân biệt được (vd "Nhật" để không nhầm Nguyễn Nhật Minh với Nguyễn Minh Vương; "Thanh Hoàng" để không nhầm với Trần Thư Hoàng) và kiểm tra lại tên đã chọn. Kiểm tra lại toàn bộ trường trước khi bấm xác nhận và báo lại mã task. Sửa task đã tạo: mở task >> menu "..." >> "Sửa".

## 7. Ví dụ

**[Zalo][BUG][S4] Nút X bị cắt khi upload ảnh ở Tin nhắn mẫu**

```
[Precondition]: Đã cài đặt và đăng nhập thành công Gopany, thiết bị có kết nối mạng
[Steps]:
1. Truy cập app Gopany >> Zalo >> Tin nhắn mẫu
2. Bấm "Thêm ảnh"
3. Chọn 1 ảnh bất kỳ
4. Quan sát ảnh preview
[Expect Result]:
4. Nút X hiển thị đầy đủ ở góc trên phải ảnh (theo design)
[Actual Result]:
4. Nút X bị cắt mất nửa phía trên
Môi trường: Dev
Thiết bị: iPhone 17 – iOS 26 – App v1.0.4(11)
[EVD]: design.png, actual.png
```

- Mức độ: S4 (đề xuất) · Phân loại: FE (lỗi layout) · Trạng thái: KHỞI TẠO · Nhãn: - · Nguồn: QA test trong sprint · Testcase liên quan: - · Người log: Hồng · Người thực hiện: Nguyễn Nhật Minh · Người liên quan: Trịnh Xuân Tùng, Nguyễn Thanh Hoàng · Ngày log: 06/10

**[Zalo][BUG][S2] Tin nhắn đã gửi biến mất sau khi tải lại hội thoại**

- Phân loại: BE (gửi thành công nhưng không được lưu) · Người thực hiện: Trịnh Xuân Tùng · Người liên quan: Nguyễn Nhật Minh, Nguyễn Thanh Hoàng

**[LOGIN][BUG][S1] App crash khi mất mạng lúc bấm Đăng nhập**

```
[Precondition]: Đã cài đặt Gopany, đã đăng xuất
[Steps]:
1. Mở app Gopany >> Đăng nhập
2. Nhập tài khoản hợp lệ
3. Tắt Wifi và 4G
4. Bấm "Đăng nhập"
[Expect Result]:
4. Hiện thông báo không có kết nối mạng, giữ nguyên dữ liệu đã nhập
[Actual Result]:
4. App đóng đột ngột (crash), mở lại phải nhập lại
Môi trường: Staging
Thiết bị: Samsung A54 – Android 15 – App v2.3.1
[EVD]: crash.mp4
```

- Mức độ: S1 (đề xuất) · Phân loại: FE (app không xử lý mất mạng) · Trạng thái: KHỞI TẠO · Nhãn: Ngoài kế hoạch · Nguồn: QA test trong sprint · Testcase liên quan: [MB_16] · Người log: Hồng · Người thực hiện: Vũ Ngọc Hiếu · Người liên quan: Tưởng Văn Chiến, Nguyễn Thanh Hoàng · Ngày log: 06/10

## 8. Tự rà trước khi trả

- Tiêu đề đúng dạng `[EPIC][BUG][S1–S4] Mô tả ngắn`, mức trong tiêu đề khớp trường Mức độ, mô tả nêu đúng hiện tượng.
- Đủ nội dung bắt buộc: bước tái hiện, mong đợi, thực tế, môi trường, thiết bị + OS + app, ảnh/video.
- Steps tái hiện được từ đầu, dùng `>>` cho điều hướng.
- Expect và Actual đánh số theo đúng số bước có kết quả, đối chiếu được từng dòng, không chung chung.
- Mức độ đúng định nghĩa S1–S4; S1/S2 có nhãn `Ngoài kế hoạch`.
- Người thực hiện / Người liên quan khớp bảng mục 1a theo EPIC và Phân loại FE/BE; Người liên quan có Nguyễn Thanh Hoàng; EPIC ngoài bảng → đã hỏi người dùng.
- Trạng thái bug mới là `KHỞI TẠO`.
- EVD đúng loại (UI → ảnh design + actual; thao tác/crash → video).
- Mỗi bug chỉ 1 lỗi; đã rà bug trùng trên board.