---
period: 2026-10
reportedBy: QA
reportedAt: 2026-10-02
rule: qa-point-scoring
axis: use case (1 dòng = 1 UC, BR nằm bên trong và đi vào Effort)
status: PHƯƠNG ÁN SO SÁNH — không theo rule hiện hành (rule đang tính theo BR). Báo cáo chính vẫn là 2026-10_zalo-otp.md
source: qa/test-cases/ZALO-OTP-nghiep-vu.md   # 102 case
---

# Zalo OTP — bóc theo use case (phương án so sánh)

> Báo cáo chính của kỳ là [2026-10_zalo-otp.md](2026-10_zalo-otp.md) (tính theo BR, tổng 5 point).
> File này chỉ để đặt cạnh nhau. **Chưa thay rule** — nếu chọn đơn vị là use case thì phải sửa
> `qa-point-scoring` rồi chuyển file này thành báo cáo chính.

## 1. Tổng hợp

| # | Task lớn | Phân loại | Số UC | Point |
| ---: | --- | --- | ---: | ---: |
| 1 | QA tính năng xác thực SĐT qua Zalo OTP | Tính năng | 6 | 5 |

Neo mốc **5 point cho cả tính năng** (giống báo cáo BR) nên tổng hai phương án bằng nhau; khác ở cách chia.

## 2. Bảng — use case

Trạng thái mọi dòng: `thiết kế xong — chờ build`. Các nhánh còn chờ trả lời nằm trong cùng dòng (không tách riêng).

| # | UC | Nội dung (người dùng muốn gì) | BR nằm bên trong | Case phủ | Size | Effort | Point | Lý do point |
| ---: | --- | --- | --- | --- | :---: | :---: | ---: | --- |
| 1 | `UC-01` Gửi mã OTP lần đầu | Nhập SĐT → hệ thống kiểm tra dữ liệu, tài khoản, SĐT có trùng không, thời gian chờ → gửi mã qua Zalo (hoặc trả `otp` khi tắt gửi thật) | chuẩn hóa SĐT · validate khi gửi mã · tài khoản tồn tại/không lộ · đã xác thực · SĐT không trùng · thời gian chờ · Zalo lỗi (phần lần đầu) · chế độ tắt gửi thật | `TC-01→15, 25, 64, 89, 90` (19) | M | H | 1 | Size: API + DB + cache + Zalo, hai chế độ gửi. Effort: nhánh >5 (4 dạng dữ liệu sai, 3 loại kiểm tra tài khoản/SĐT, thời gian chờ, Zalo lỗi 2 kiểu) và độ khó cao: tài liệu thiếu (SĐT trùng viết khác cách — #5; mã lỗi validate — #6), phải chứng minh thời gian chờ đặt trước khi gọi Zalo; sót là chiếm được SĐT người khác hoặc lộ tài khoản |
| 2 | `UC-02` Đổi số điện thoại | Đã có SĐT, nhập SĐT khác → nhận mã cho số mới, mã số cũ mất tác dụng, trạng thái xác thực về chưa xác thực; đổi nhiều lần bị khóa | phân loại gửi mã + bộ đếm · khóa đổi số theo bậc · Zalo lỗi không đổi trạng thái (phần đổi số) | `TC-16→20, 26→35, 65` (16) | M | H | 1 | Size: bản ghi tài khoản + cache ghi đè + bộ đếm + Zalo. Effort: thang 3 bậc có reset ở bậc cuối; chạm bậc **vẫn gửi mã**, khóa từ lần sau (phân kỳ với khóa nhập mã); A→B→A đếm 3; Zalo lỗi không được cộng bộ đếm; sót một bậc là sót lỗi bảo vệ tài khoản |
| 3 | `UC-03` Gửi lại mã cho cùng số | Chưa nhận được mã → bấm gửi lại cho đúng số vừa gửi → nhận mã mới; gửi lại quá nhiều bị khóa | khóa gửi lại theo bậc · phân loại gửi mã (phần gửi lại, cùng số đang lưu) · Zalo lỗi không cộng lượt (phần gửi lại) | `TC-21→24, 36→45` (14) | M | M | 0.75 | Size: cache + bộ đếm theo cặp + Zalo. Effort vừa vì **kế thừa** cấu trúc thang của `UC-02`, chỉ tính phần khác (đếm theo cặp tài khoản + SĐT, chỉ đếm khi gửi thành công); chạy thật vẫn phải gửi tới 20 lần |
| 4 | `UC-04` Nhập mã OTP xác thực SĐT | Nhập mã nhận được → đúng thì lưu SĐT và đánh dấu đã xác thực; sai/hết hạn/không khớp thì báo lỗi; sai nhiều lần bị khóa | hiệu lực + khớp mã OTP · khóa nhập sai theo bậc · validate khi nhập mã · đã xác thực · hậu điều kiện xác thực thành công · không lộ tài khoản · chuẩn hóa SĐT (nhập khác cách viết) · SĐT không trùng (người khác xác thực xong giữa chừng) | `TC-46→63, 66→70, 91→102` (35) | L | H | 1.25 | Size: chứa ≥6 quy tắc độc lập (vòng đời mã, 3 loại lỗi, thang khóa ngay lần chạm bậc, validate 11000, hậu điều kiện 5 thay đổi, thứ tự 30029 trước 30014) trên API + DB + 3 loại cache. Effort: rủi ro **suy ra từ cơ chế** — đổi số làm đếm lại bộ đếm nhập sai nên có thể né khóa (#7, bảo mật); thứ tự kiểm tra còn chờ #8; 35 case |
| 5 | `UC-05` Admin cấu hình Zalo | Admin xem JSON cấu hình, bật/tắt gửi thật, bật/tắt tự làm mới token, sửa số lần và thời gian khóa | quy tắc hiển thị (ẩn mục không có trong JSON, ngoại lệ 3 nhóm khóa) | `TC-71→76` (6) | M | E | 0.25 | Size: giao diện + lưu cấu hình dùng chung. Effort: 6 thao tác độc lập, kỳ vọng ghi thẳng, ít suy luận; lỗi nhập JSON chờ #2 |
| 6 | `UC-06` Làm mới token Zalo | Hệ thống tự làm mới token khi gần hết hạn lúc gửi mã, hoặc tác vụ 03:00; lỗi cấu hình/refresh chặn gửi | tự làm mới khi gửi · tác vụ 03:00 · lỗi cấu hình/refresh | `TC-79→86` (8) | M | M | 0.75 | Size: gửi OTP + tác vụ định kỳ + Zalo ngoài + lưu DB/cache. Effort: 8 nhánh, 2 cơ chế kích hoạt, 4 mã lỗi phải dựng được 4 tình huống; tác vụ lỗi giữa chừng chưa có (#3) |

**Tổng: 5 point** (6 UC).

## 3. Cách ra con số

Chấm thẳng từng UC bằng ma trận của rule hiện hành (đã hiệu chỉnh cho BR) ra **3.65**:

| UC | Size × Effort | Ma trận BR |
| --- | --- | ---: |
| `UC-01` | M × H | 0.7 |
| `UC-02` | M × H | 0.7 |
| `UC-03` | M × M | 0.5 |
| `UC-04` | L × H | 1 |
| `UC-05` | M × E | 0.25 |
| `UC-06` | M × M | 0.5 |
| | | **3.65** |

Thấp hơn 5 vì ma trận đó neo ở mức BR (trần 1 point/dòng) — một UC gói nhiều BR nên bị chặn trần.
Để khớp mốc 5 point cho cả tính năng, nhân hệ số **5 ÷ 3.65 ≈ 1.37** rồi làm tròn bội 0.25:
`0.7→1` · `0.5→0.75` · `1→1.25` · `0.25→0.25`. Tổng ra đúng **5.00**.

Con số 5.00 do việc hiệu chỉnh theo mốc của bạn, không phải do chấm tự nhiên. Nếu chọn UC làm đơn vị,
cần một ma trận riêng cho UC thay vì dùng hệ số này.

## 4. Chưa chấm / đã loại

| Đầu việc | Lý do |
| --- | --- |
| `TC-77`, `78` (a11y màn Admin), `TC-87`, `88` (tốc độ phản hồi) | **Không có nguồn tài liệu** → không nằm trong UC nào. Khác bản BR: ở đây `UC-05` chứa `TC-72→74` (thao tác cấu hình) vì thao tác là bước của use case |
| Nhánh chờ trả lời | `TC-11` (#5) · `TC-04→07` (#6) · `TC-67` (#7) · `TC-91, 97, 99` (#8) · `TC-84→86` lỗi giữa chừng (#3). Nằm trong dòng UC tương ứng, nếu đổi kỳ vọng thì mở dòng `mở rộng` |
| Execution, defect, automation | Chưa có build / chưa chạy |

## 5. So với bản theo BR

| | Theo BR | Theo UC |
| --- | ---: | ---: |
| Số dòng | 18 (+1 chưa chốt) | 6 |
| Tổng | 5 | 5 |
| Dòng cao nhất | 0.7 | 1.25 |
| Thao tác cấu hình `TC-72→74` | bị loại | được tính trong `UC-05` |
| Dòng chưa chốt | `BR-03` | không (nhánh chờ nằm trong UC) |
| Chống đếm trùng | mỗi hành vi một BR | một BR dùng chung nhiều UC (vd chuẩn hóa SĐT, bộ đếm) dễ bị tính ở nhiều UC |

## 6. Lịch sử cập nhật

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
| 2026-10-02 | QA | Tạo phương án bóc theo UC để so sánh với bản BR; 6 UC, 5 point |
