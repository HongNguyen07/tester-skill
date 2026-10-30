---
period: dự kiến (chưa chốt)
reportedBy: QA
reportedAt: 2026-10-02
rule: qa-point-scoring
status: chưa chốt point — chưa có artifact test case
sources:
  - tailieu/luong-dong-bo-gopany.html   # cập nhật 26/09/2026
  - tailieu/thay-doi-28-29-09.html      # thay đổi 28–29/09/2026
---

# Bóc yêu cầu + point dự kiến — Đồng bộ Gopany & Thay đổi 28–29/09

> **Chưa chốt point.** Theo §1.3 của rule, một dòng chỉ chốt khi đã thiết kế case (có `Case phủ`) và
> đã chạy, hoặc thiết kế xong mà chờ build. Hai tài liệu này **chưa có artifact test case** nào trong
> `qa/test-cases/`, nên bảng dưới là **danh sách yêu cầu + point dự kiến**, dùng để:
>
> 1. làm xương sống viết test case (mỗi dòng là một yêu cầu phải phủ),
> 2. ước lượng khối lượng trước khi nhận việc.
>
> Khi có file case, copy bảng này sang báo cáo kỳ, điền `Case phủ` + `Trạng thái` rồi mới chốt.

## 1. Hai tài liệu

| Tài liệu | Loại | Mã yêu cầu | Số yêu cầu |
| --- | --- | --- | ---: |
| `tailieu/luong-dong-bo-gopany.html` (cập nhật 26/09) | Spec luồng nghiệp vụ, 5 bước | `GS-xx` | 44 |
| `tailieu/thay-doi-28-29-09.html` (28–29/09) | Changelog 10 mục, mỗi mục có "Trước đây / Bây giờ" | `TD-xx` | 39 |
| | | **Tổng** | **83** |

Tài liệu không đánh số yêu cầu sẵn → QA tự đánh mã `GS`/`TD` và **giữ ổn định qua các version**
(§2.3). Mã bám theo thứ tự xuất hiện trong tài liệu để tra lại nhanh.

## 2. Bảng A1 — Luồng Đồng bộ Gopany (`GS`)

| # | Mã | Nguồn | Nội dung yêu cầu | Size | Effort | Point dự kiến |
| ---: | --- | --- | --- | :---: | :---: | ---: |
| 1 | `GS-01` | Bước 1 | "Thêm liên kết" / "Kết nối" → hiện mã QR Zalo PC kèm đếm ngược hết hạn | S | E | 0.125 |
| 2 | `GS-02` | Bước 1 | Lần đầu liên kết một tài khoản: mã thứ 2 hiện **đúng chỗ mã cũ**, cùng cỡ, sống ~12 giây, camera tự quét tiếp | S | H | 0.5 |
| 3 | `GS-03` | Bước 1 | Kết nối lại đúng tài khoản cũ → chỉ có 1 mã | S | M | 0.25 |
| 4 | `GS-04` | Bước 1 | Xác nhận trên điện thoại → "Kết nối thành công!", tài khoản Đang hoạt động | S | E | 0.125 |
| 5 | `GS-05` | Bước 1 | Lưu tài khoản kèm phiên Zalo PC + công ty Gopany đã tạo mã | S | M | 0.25 |
| 6 | `GS-06` | Bước 1 quy tắc | Mỗi Zalo chỉ 1 phiên Zalo PC → app Zalo PC trên Windows bị đăng xuất | S | M | 0.25 |
| 7 | `GS-07` | Bước 1 quy tắc | Phiên Zalo Web ở hệ thống khác vẫn giữ đăng nhập, chỉ chớp mất ~2 giây | S | M | 0.25 |
| 8 | `GS-08` | Bước 1 quy tắc | Quét mã của tài khoản A bằng Zalo B → "Lỗi trong quá trình quét QR.", A không bị đổi | S | M | 0.25 |
| 9 | `GS-09` | Bước 1 quy tắc | Mã hết hạn → "Mã QR đã hết hạn", bấm Làm mới mã lấy mã mới | S | E | 0.125 |
| 10 | `GS-10` | Bước 1 quy tắc | "Đang đồng bộ lịch sử" của Gopany ≠ bước Đồng bộ của zaloHub — không được lẫn | S | H | 0.5 |
| 11 | `GS-11` | Bước 2 | 4 thẻ số liệu, bấm để lọc / bấm lại bỏ lọc, số đếm theo bộ lọc đang chọn | S | M | 0.25 |
| 12 | `GS-12` | Bước 2 | Bộ lọc công ty / company / phiên / trạng thái + tìm tên-SĐT-UID, gõ không dấu, lưu trên URL | S | M | 0.25 |
| 13 | `GS-13` | Bước 2 | Nội dung mỗi dòng: tài khoản, công ty Gopany, phiên, lượt gần nhất của 2 loại, % khi đang chạy, 2 nút | S | E | 0.125 |
| 14 | `GS-14` | Bước 2 | Hộp thoại "Gửi Gopany…": header phiên/công ty/thời điểm + khung 1 + khung 2 + 10 lượt gần đây thu gọn sẵn | S | M | 0.25 |
| 15 | `GS-15` | Bước 2 | Tự làm mới: bảng ~5 giây khi có lượt chạy, hộp thoại ~2 giây | S | M | 0.25 |
| 16 | `GS-16` | Bước 2 | Trạng thái khởi điểm sau liên kết: Zalo PC / Chưa đồng bộ / Chưa gửi | S | E | 0.125 |
| 17 | `GS-17` | Bước 3 bảng | 5 điều kiện bấm được nút Đồng bộ, mỗi điều kiện có đúng lý do hiện khi bị khoá | S | H | 0.5 |
| 18 | `GS-18` | Bước 3 | Hộp xác nhận "Đồng bộ lịch sử tin nhắn?" đúng nội dung; bấm Huỷ thì không có gì chạy | S | E | 0.125 |
| 19 | `GS-19` | Bước 3 | "Đã bắt đầu đồng bộ"; lượt chạy nền — đóng hộp thoại hay tải lại trang vẫn chạy tiếp | S | M | 0.25 |
| 20 | `GS-20` | Bước 3 | Tiến độ 5 bước (Đăng nhập → danh sách hội thoại → lấy tin → điền tên → Xong) kèm % và "N hội thoại · M tin" | S | M | 0.25 |
| 21 | `GS-21` | Bước 3 | Điện thoại phải mở Zalo, màn hình sáng suốt lượt | S | M | 0.25 |
| 22 | `GS-22` | Bước 3 | Xong → "Đã đồng bộ" + giờ kết thúc; nhật ký ghi Thành công, nguồn "Trang admin" + tên admin | S | E | 0.125 |
| 23 | `GS-23` | Bước 3 hủy | Đang chạy → nút đổi thành "Hủy đồng bộ", bấm là hủy luôn không hỏi lại | S | E | 0.125 |
| 24 | `GS-24` | Bước 3 hủy | Hủy chỉ ngừng lấy tin mới; vẫn lưu nốt tin đã lấy + điền tên; nhãn "Đang dừng", nút Hủy ẩn | S | H | 0.5 |
| 25 | `GS-25` | Bước 3 hủy | Đã sang bước điền tên → không hủy được nữa (nút ẩn + dòng báo sắp xong) | S | M | 0.25 |
| 26 | `GS-26` | Bước 3 hủy | Kết thúc hủy → "Đã hủy giữa chừng — dữ liệu có thể thiếu, nên đồng bộ lại."; nhật ký "Đã hủy" | S | E | 0.125 |
| 27 | `GS-27` | Bước 3 quy tắc | Mỗi lần đồng bộ lấy **toàn bộ** lịch sử có trên điện thoại (mốc ~270 hội thoại / 70.000 tin ≈ 2 phút) | S | M | 0.25 |
| 28 | `GS-28` | Bước 3 quy tắc | 1 lượt đồng bộ / tài khoản tại một thời điểm; bấm trùng → đúng thông báo; tài khoản khác chạy song song được | S | M | 0.25 |
| 29 | `GS-29` | Bước 3 quy tắc | 5 lý do dừng giữa chừng được ghi đúng (mất kết nối · điện thoại từ chối · thiếu bộ nhớ · đã đăng xuất · kết nối vừa dựng lại) | S | H | 0.5 |
| 30 | `GS-30` | Bước 4 bảng | 4 điều kiện bấm được nút Gửi Gopany, mỗi điều kiện có đúng lý do khi bị khoá | S | M | 0.25 |
| 31 | `GS-31` | Bước 4 | Hộp xác nhận "Gửi lịch sử sang Gopany?" đúng số tin + đúng công ty + nêu Gopany tự bỏ tin đã có | S | M | 0.25 |
| 32 | `GS-32` | Bước 4 | "Đang gửi N tin"; chạy qua 2 pha (đã gửi chờ nhận → Gopany đang nhận) kèm "đã nhận x/y", số bỏ qua / lỗi | S | M | 0.25 |
| 33 | `GS-33` | Bước 4 | Kết thúc: Nhận đủ / Nhận một phần / Từ chối kèm lý do | S | M | 0.25 |
| 34 | `GS-34` | Bước 4 quy tắc | Luôn gửi lại toàn bộ; gửi nhiều lần **không nhân đôi tin** (Gopany tự bỏ tin đã có) | S | H | 0.5 |
| 35 | `GS-35` | Bước 4 quy tắc | Tin vào đúng công ty đang giữ liên kết; tài khoản cũ hiện công ty "chưa rõ" vẫn gửi đúng chỗ | S | H | 0.5 |
| 36 | `GS-36` | Bước 4 quy tắc | 1 lượt gửi / tài khoản; các tài khoản khác gửi cùng lúc được | S | E | 0.125 |
| 37 | `GS-37` | Bước 4 quy tắc | Đang gửi thì không đồng bộ được, và đang đồng bộ thì không gửi được (loại trừ lẫn nhau) | S | M | 0.25 |
| 38 | `GS-38` | Bước 5 | Hội thoại cũ và tin cũ hiện trong Chat của đúng công ty, đúng thứ tự thời gian | S | M | 0.25 |
| 39 | `GS-39` | Bước 5 | Tin trong nhóm có tên người gửi; ảnh / file cũ hiện được | S | M | 0.25 |
| 40 | `GS-40` | Bước 5 | Tin mới phát sinh sau khi liên kết vẫn nhận bình thường | S | E | 0.125 |
| 41 | `GS-41` | Chưa đồng bộ được | Phiên Zalo Web → nằm ở thẻ "Cần quét QR Zalo PC", phải quét QR mới rồi mới đồng bộ được | S | M | 0.25 |
| 42 | `GS-42` | Chưa đồng bộ được | Mất kết nối → khách phải kết nối lại ở bước 1 | S | E | 0.125 |
| 43 | `GS-43` | Nhật ký | Mỗi lần bấm tạo 1 lượt; lượt ghi đủ loại, người bấm, công ty Gopany, kết quả, số liệu, lỗi | S | M | 0.25 |
| 44 | `GS-44` | Nhật ký | 6 trạng thái lượt đúng nghĩa (Đang chạy · Thành công · Chưa trọn · Thất bại · Đã hủy · Bị gián đoạn — đánh dấu sau ~5 phút) | M | H | 1.5 |

**Dự kiến bảng A1: 12.5 point / 44 yêu cầu.**

Lý do các dòng vượt `0.25`:

- `GS-02` — hai mã QR nối nhau, mã thứ 2 sống 12 giây và hiện đè đúng chỗ mã cũ: cửa sổ thời gian hẹp, phải phân biệt "tự quét tiếp" với "quét tay kịp", dễ cho kết quả thất thường.
- `GS-10` — tài liệu cảnh báo đúng chỗ dễ nhầm: Gopany cũng hiện "Đang đồng bộ lịch sử" nhưng đó không phải bước Đồng bộ của zaloHub. Case phải chứng minh được mình đang kiểm cái nào.
- `GS-17` — 5 điều kiện × đúng lý do khoá tương ứng, và phải dựng được từng trạng thái chặn.
- `GS-24` — hủy không dừng ngay: còn lưu nốt và điền tên, có trạng thái trung gian "Đang dừng". Nhiều nhánh theo thời điểm bấm hủy.
- `GS-29` — 5 lý do dừng, mỗi lý do phải dựng được một tình huống thật trên điện thoại.
- `GS-34` — tính không nhân đôi khi gửi lại nhiều lần, chạm toàn vẹn dữ liệu.
- `GS-35` — định tuyến tin vào đúng công ty, gồm nhánh công ty "chưa rõ"; sai là dữ liệu khách sang công ty khác.
- `GS-44` — 6 trạng thái là một sơ đồ trạng thái của lượt, cộng độ trễ 5 phút với "Bị gián đoạn"; áp cho cả hai loại lượt nên Size `M`.

## 3. Bảng A2 — Thay đổi 28–29/09 (`TD`)

Mỗi mục changelog có "Trước đây / Bây giờ" → mỗi hành vi mới là một yêu cầu, **và** phải kiểm hành vi
cũ không còn (regression hai chiều).

| # | Mã | Mục | Nội dung yêu cầu | Size | Effort | Point dự kiến |
| ---: | --- | --- | --- | :---: | :---: | ---: |
| 1 | `TD-01` | 1 Người lạ | Tab "Người lạ" có 2 mục (Tin nhắn từ người lạ · Tài khoản OA), số chưa đọc riêng theo tài khoản đang lọc | S | M | 0.25 |
| 2 | `TD-02` | 1 | Hội thoại 1-1 với người chưa kết bạn **mà mình chưa từng trả lời** → nằm ở tab Người lạ | S | M | 0.25 |
| 3 | `TD-03` | 1 | Tab Tất cả và Chưa đọc chỉ còn danh sách chính; tab Nhóm giữ nguyên | S | E | 0.125 |
| 4 | `TD-04` | 1 | Khi trả lời / gửi hoặc nhận lời mời / kết bạn xong → hội thoại chuyển về danh sách chính | S | H | 0.5 |
| 5 | `TD-05` | 1 | Tin cuối từ năm trước hiện ngày dạng `dd/MM/yy` | S | E | 0.125 |
| 6 | `TD-06` | 1 lưu ý | Phân loại chỉ có **sau khi** tài khoản chạy "Gửi Gopany" — điều kiện tiên quyết của cả mục 1 | S | H | 0.5 |
| 7 | `TD-07` | 2 Khung chat | Nhảy thẳng tới tin cần xem (trích dẫn / ghim / kết quả tìm kiếm), cuộn lên xuống đều tải liền mạch | S | H | 0.5 |
| 8 | `TD-08` | 2 | Nút "xuống cuối" và gửi tin đưa về tin mới nhất | S | E | 0.125 |
| 9 | `TD-09` | 2 | Gửi text/sticker/file/danh thiếp, thu hồi, xoá, gửi lại tin lỗi → chỉ tin đó thay đổi, danh sách không tải lại | S | M | 0.25 |
| 10 | `TD-10` | 2 | Tab Chưa đọc: hội thoại vừa đọc giữ nguyên vị trí | S | M | 0.25 |
| 11 | `TD-11` | 2 | Trên 99 tin chưa đọc hiện "99+" | S | E | 0.125 |
| 12 | `TD-12` | 2 | Danh sách hội thoại, số chưa đọc, đánh dấu đã đọc nhanh hơn rõ rệt | S | M | 0.25 |
| 13 | `TD-13` | 2 | Chuyển sang trang khác của Gopany rồi quay lại Chat vẫn nhận tin realtime | S | M | 0.25 |
| 14 | `TD-14` | 2 | Đang xem tin cũ mà upload file xong thì không bị kéo xuống cuối | S | M | 0.25 |
| 15 | `TD-15` | 3 Nhóm | Nhóm đã từng mở → hiện thành viên và cài đặt ngay, dữ liệu tự làm mới phía sau | S | M | 0.25 |
| 16 | `TD-16` | 3 | Thêm/xoá thành viên, đổi cài đặt hoặc trưởng nhóm trên Zalo → Gopany tự cập nhật | S | M | 0.25 |
| 17 | `TD-17` | 3 | Nhóm chưa có ảnh → hiện chữ cái đầu tên nhóm, tên có emoji hoặc dấu vẫn đúng | S | E | 0.125 |
| 18 | `TD-18` | 3 | Sau khi đồng bộ lịch sử, nhóm trong danh sách có ảnh đại diện mà không cần mở từng nhóm | S | M | 0.25 |
| 19 | `TD-19` | 3 | Trạng thái bạn bè không bị hạ nhầm thành "chưa kết bạn" khi Zalo lỗi tạm thời | S | H | 0.5 |
| 20 | `TD-20` | 4 Media | Ảnh, video, tin thoại, file hết hạn → hiện "… đã hết hạn" | S | M | 0.25 |
| 21 | `TD-21` | 4 | Chỉ lỗi tải → "Không tải được …", bấm để thử lại | S | M | 0.25 |
| 22 | `TD-22` | 4 | Media hiện lỗi → hệ thống tự kiểm lại, còn tải được thì tự thay bằng ảnh thật, không cần F5 | S | H | 0.5 |
| 23 | `TD-23` | 4 | Tin trích dẫn dùng ảnh/video đã lưu nên vẫn xem được sau khi link Zalo chết | S | M | 0.25 |
| 24 | `TD-24` | 4 | Trình xem ảnh bỏ qua ảnh/video đã hết hạn khi bấm mũi tên | S | M | 0.25 |
| 25 | `TD-25` | 4 | Ảnh nhỏ ở Lưu trữ khách hàng và sidebar hiện trong vài giây | S | E | 0.125 |
| 26 | `TD-26` | 5 Tin lịch sử | Tin lịch sử tìm được theo nội dung | S | M | 0.25 |
| 27 | `TD-27` | 5 | Tin lịch sử không cộng vào số chưa đọc; tin mới đến vẫn tính chưa đọc | S | M | 0.25 |
| 28 | `TD-28` | 6 Chuyển tiếp | Chuyển tiếp nhiều hội thoại (cá nhân + nhóm) nhanh hơn, xác nhận "đã gửi" ngay từng nơi nhận, **không sinh tin trùng** | S | H | 0.5 |
| 29 | `TD-29` | 6 | Câu báo lỗi khi chuyển tiếp ảnh/file lỗi dễ hiểu, không phải lỗi kỹ thuật | S | E | 0.125 |
| 30 | `TD-30` | 7 Xoá tài khoản | Xoá xong ngay; hội thoại và tin biến mất ngay, phần còn lại dọn phía sau | S | M | 0.25 |
| 31 | `TD-31` | 7 | Quét QR lại tài khoản đó → hội thoại và tin hiện lại đầy đủ | S | H | 0.5 |
| 32 | `TD-32` | 8 Kết nối lại | Zalo đang ở công ty khác, quay lại công ty cũ bấm Kết nối lại → chỉ quét QR 1 lần | S | M | 0.25 |
| 33 | `TD-33` | 8 | Bấm "Thêm tài khoản" rồi "Kết nối lại" trong thời gian ngắn → mỗi thao tác nhận đúng mã QR của nó | S | H | 0.5 |
| 34 | `TD-34` | 8 | Quét mã "Kết nối lại" bằng một Zalo khác → báo quét sai tài khoản | S | M | 0.25 |
| 35 | `TD-35` | 9 Chuyển công ty | Chuyển Zalo sang công ty B → B nhận **toàn bộ** lịch sử ở lượt gửi đầu tiên | M | H | 1.5 |
| 36 | `TD-36` | 9 | Quét lại ở cùng công ty cũ → vẫn chỉ gửi tin mới | S | M | 0.25 |
| 37 | `TD-37` | 10 Loại tin | GIF, "đã xoá tin nhắn", tin thu hồi, sticker, thẻ thông báo Zalo đều sang được; tin cũ từng bị bỏ qua → gửi lại thì số bỏ qua gần như về 0 | S | H | 0.5 |
| 38 | `TD-38` | 10 | Tài khoản của Gopany: đồng bộ chạy xong thì hệ thống **tự gửi** các tin chưa gửi sang Gopany | S | H | 0.5 |
| 39 | `TD-39` | 10 | Tin đến thiếu thông tin loại nội dung → lưu thành tin chữ thay vì bị mất | S | M | 0.25 |

**Dự kiến bảng A2: 12.625 point / 39 yêu cầu.**

Lý do các dòng vượt `0.25`:

- `TD-04` — điều kiện chuyển hội thoại khỏi tab Người lạ có 4 đường kích hoạt (trả lời · gửi lời mời · nhận lời mời · kết bạn xong), mỗi đường phải dựng riêng.
- `TD-06` — toàn bộ mục 1 phụ thuộc việc đã chạy "Gửi Gopany"; không dựng đúng tiền đề này thì mọi kết quả của mục 1 vô nghĩa.
- `TD-07` — nhảy tới tin cũ rồi cuộn hai chiều liền mạch: nhiều nhánh (trích dẫn / ghim / tìm kiếm × cuộn lên / xuống) và dễ thất thường ở hội thoại dài.
- `TD-19` — hành vi chỉ xuất hiện khi Zalo lỗi tạm thời, phải giả lập được lỗi phía Zalo.
- `TD-22` — tự chữa khi media lỗi, phải chứng minh ảnh tự thay mà không F5.
- `TD-28` — "không sinh tin trùng" khi chuyển tiếp nhiều nơi là tính toàn vẹn dữ liệu.
- `TD-31` — xoá rồi quét lại phải hiện **đầy đủ** lại: kiểm chứng việc dọn dữ liệu phía sau không làm mất dữ liệu cần giữ.
- `TD-33` — hai thao tác tạo mã QR gần nhau, dễ lẫn mã; phải tạo được tình huống đua.
- `TD-35` — chuyển tài khoản sang công ty khác và nhận đủ lịch sử: chạm định tuyến dữ liệu khách giữa hai công ty, Size `M` vì phủ cả hai phía.
- `TD-37` — 5 loại tin trước đây bị bỏ qua, mỗi loại cần dữ liệu thật để dựng.
- `TD-38` — tự gửi sau đồng bộ (xem mâu thuẫn §4).

## 4. Phát hiện khi bóc yêu cầu — cần xác nhận trước khi viết case

### 4.1. Mâu thuẫn giữa hai tài liệu

| # | Mâu thuẫn | Chi tiết |
| --- | --- | --- |
| **Q-01** | Tài liệu luồng (26/09) đã lỗi thời ở chỗ gửi thủ công | `luong-dong-bo-gopany.html` viết ở đầu: *"Đồng bộ và Gửi Gopany là 2 bước riêng, **đều do admin zaloHub bấm**"*. Nhưng `thay-doi-28-29-09.html` mục 1 ghi trong phần lưu ý: *"sau khi tài khoản chạy Gửi Gopany (**bấm tay, hoặc tự chạy sau Đồng bộ**)"*, và mục 10: *"đồng bộ chạy xong thì hệ thống tự gửi"*. Như vậy **cả hai chế độ đều tồn tại** ở hiện tại, và tài liệu luồng chưa cập nhật. Cần xác nhận để biết `GS-30`→`GS-37` test ở chế độ nào, và tài liệu luồng có được sửa hay không |
| **Q-02** | Phạm vi của việc tự gửi | Mục 10 nói "tài khoản **của Gopany**" — nghĩa là chỉ một số tài khoản, hay mọi tài khoản liên kết qua Gopany? Quyết định `TD-38` test trên tập nào. Đây là phần **còn thật sự chưa rõ** sau khi đã gộp Q-01 |
| **Q-03** | Tài liệu bước 1 có cần cập nhật theo 28–29/09 không | Mục 8 của changelog đổi hành vi "Kết nối lại" (từ 2 lần quét còn 1 lần), nhưng `GS-02` trong tài liệu luồng vẫn mô tả lần đầu liên kết phải quét 2 mã. Cần xác nhận hai chỗ này nói về hai tình huống khác nhau, hay tài liệu luồng đã cũ |

### 4.2. Điều kiện dữ liệu mà tài liệu đã nêu — phải chuẩn bị trước, không dựng được thì không test được

| Yêu cầu | Điều kiện |
| --- | --- |
| `TD-20`→`TD-24` | Link ảnh Zalo chỉ sống ~15–20 ngày → cần tài khoản có lịch sử **cũ hơn mốc đó** mới thấy trạng thái hết hạn |
| `TD-26`, `TD-27` | Chỉ áp dụng cho tin lịch sử đồng bộ **từ trưa 29/09** → phải dùng tài khoản đồng bộ mới, tài khoản đồng bộ trước đó cho kết quả cũ |
| `TD-01`→`TD-06` | Phải chạy "Gửi Gopany" xong mới có phân loại người lạ |
| `GS-27` | Cần tài khoản có lịch sử lớn (mốc tham chiếu ~270 hội thoại / 70.000 tin) để đo |
| `GS-17`, `GS-30` | Phải dựng được từng trạng thái chặn: không quyền, phiên Zalo Web, mất kết nối, đang có lượt chạy, lượt gần nhất bị lỗi |
| `GS-29` | Cần dựng 5 tình huống dừng thật trên điện thoại (từ chối gửi, hết bộ nhớ, đăng xuất…) |
| `TD-35`, `TD-36` | Cần 2 công ty Gopany và một tài khoản Zalo chuyển qua lại giữa chúng |
| `GS-06`, `GS-07` | Cần máy tính có app Zalo PC và một hệ thống khác đang giữ phiên Zalo Web |

### 4.3. Chỗ chưa đủ để viết kỳ vọng

| # | Thiếu gì |
| --- | --- |
| **Q-04** | `GS-44` "Bị gián đoạn" đánh dấu sau *khoảng* 5 phút — ngưỡng chính xác là bao nhiêu để case không thất thường? |
| **Q-05** | `TD-12`, `TD-25`, `GS-27` nói "nhanh hơn rõ rệt" / "vài giây" / "tầm 2 phút" — chưa có ngưỡng số để phán pass/fail |
| **Q-06** | `GS-33` "Gopany từ chối kèm lý do" — danh sách lý do từ chối có những gì? |
| **Q-07** | `TD-02` "chưa từng trả lời" tính theo mốc nào: chưa từng gửi tin trong hội thoại đó, hay chưa từng gửi kể từ lúc liên kết? |
| **Q-08** | Việc gửi **theo lô** chỉ xuất hiện trong sơ đồ của tài liệu luồng (*"Gửi lại toàn bộ tin đã đồng bộ, theo lô"* · *"Kết quả từng lô (tin đã có thì bỏ qua)"*), phần Bước 4 không nhắc. Một lô lỗi thì lượt thành "Chưa trọn" hay dừng hẳn? Có retry lô lỗi không? Ảnh hưởng `GS-32`, `GS-33` và trạng thái "Chưa trọn" ở `GS-44` |

## 5. Tổng dự kiến

| Bảng | Số yêu cầu | Point dự kiến |
| --- | ---: | ---: |
| A1 — Luồng Đồng bộ Gopany | 44 | 12.5 |
| A2 — Thay đổi 28–29/09 | 39 | 12.625 |
| **Tổng** | **83** | **25.125** |

Bảng B (defect · automation · regression · dựng môi trường) chưa ước lượng được: phụ thuộc số lỗi
thật tìm ra khi chạy, và việc dựng dữ liệu ở §4.2 có thể phải tách dòng riêng nếu nặng hơn việc chạy.

**Điều kiện để chốt point** (theo §1.3):

1. Có file `qa/test-cases/GOPANY-SYNC.md` và `qa/test-cases/TD-2809.md` với khoảng mã TC cho từng yêu cầu.
2. Mỗi dòng điền `Case phủ` + `Trạng thái`.
3. Trả lời `Q-01` (mâu thuẫn thủ công / tự động) — nếu không, `GS-30`→`GS-37` và `TD-38` phải để ở mục "chưa chốt point" vì kỳ vọng chưa rõ.

## 6. Lịch sử cập nhật

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
| 2026-10-02 | QA | Bóc 2 tài liệu thành 83 yêu cầu, point dự kiến 25.125; ghi 7 câu hỏi và 8 điều kiện dữ liệu |
| 2026-10-02 | QA | Đối chiếu lại với nguyên văn 2 file HTML: số dòng khớp (44 GS + 39 TD). Sửa Q-01 (hai chế độ gửi đều tồn tại, tài liệu luồng lỗi thời — không phải mâu thuẫn hành vi), thêm Q-08 (gửi theo lô chỉ có trong sơ đồ) |
