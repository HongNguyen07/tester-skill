---
period: 2026-10
reportedBy: QA
reportedAt: 2026-10-02
rule: qa-point-scoring
axis: business rule (1 dòng = 1 BR, gộp phân tích + thiết kế + chạy)
scale: ma trận co nửa, neo mốc "một tính năng cỡ trung bình ≈ 5 point"
source: qa/test-cases/ZALO-OTP-nghiep-vu.md   # 102 case, TC-01→TC-102
---

# Báo cáo point QA — 2026-10 · Zalo OTP

> Quy tắc chấm: skill `qa-point-scoring`. Đơn vị là **business rule**. Use case / luồng không phải đơn vị.
> Nguồn bóc: `qa/test-cases/ZALO-OTP-nghiep-vu.md` (102 case) đối chiếu SRS `ZALO-OTP.md`,
> `tailieu/7-send-ma-otp.md`, `tailieu/8-verify-ma-otp.md`.
> Bản kỹ thuật `ZALO-OTP.md` (90 case) là cùng nội dung viết ở dạng khác → không chấm lại.

## 1. Bảng tổng hợp

| # | Task lớn | Phân loại | Số BR | Point BR | Point bảng phụ | Tổng point |
| ---: | --- | --- | ---: | ---: | ---: | ---: |
| 1 | QA tính năng xác thực SĐT qua Zalo OTP | Tính năng | 18 | 5 | 0 | 5 |
| | **Tổng kỳ** | | **18** | **5** | **0** | **5** |

Khớp mốc **5 point** do người chấm xác nhận cho tính năng này. Còn 1 BR chưa chốt (`BR-03`, dự kiến
+0.1) — xem mục 4.

Thang điểm dùng: `S` 0.05 / 0.1 / 0.25 · `M` 0.25 / 0.5 / 0.7 · `L` 0.5 / 0.75 / 1 (cột `E` / `M` / `H`).

## 2. Danh sách business rule

18 BR chia theo nhóm hành vi:

| Nhóm | BR |
| --- | --- |
| Dữ liệu đầu vào | `BR-01` chuẩn hóa SĐT · `BR-02` validate khi nhập mã · `BR-03` validate khi gửi mã *(chưa chốt)* |
| Kiểm tra trước khi gửi | `BR-04` tài khoản tồn tại + không lộ thông tin · `BR-05` đã xác thực thì không gửi/nhập nữa · `BR-06` SĐT không trùng người đã xác thực |
| Gửi mã | `BR-07` thời gian chờ · `BR-08` phân loại gửi mã + bộ đếm · `BR-09` Zalo lỗi không đổi trạng thái · `BR-14` phản hồi + chế độ tắt gửi thật |
| Ba thang khóa | `BR-10` khóa đổi số · `BR-11` khóa gửi lại · `BR-12` khóa nhập sai |
| Nhập mã | `BR-13` hiệu lực + khớp mã · `BR-15` hậu điều kiện xác thực thành công |
| Cấu hình | `BR-16` quy tắc hiển thị Admin · `BR-17` tự làm mới token khi gửi mã · `BR-18` tác vụ làm mới token 03:00 · `BR-19` lỗi cấu hình/refresh chặn gửi |

Luồng **không có dòng riêng**: "gửi mã thành công" đi qua `BR-07`, `BR-10`, `BR-01`… nên mỗi hành vi
được tính ở BR của nó, không tính lại ở luồng.

## 3. Bảng A — business rule

Trạng thái mọi dòng: `thiết kế xong — chờ build` (chốt đủ theo §1.3; kỳ sau chạy **không tính thêm**).

| # | Mã | Nguồn tài liệu | Nội dung | Case phủ | Size | Effort | Point | Lý do point |
| ---: | --- | --- | --- | --- | :---: | :---: | ---: | --- |
| 1 | `BR-01` | SRS §1 (chuẩn hóa SĐT) | Nhận `0xxx`, `84xxx`, `+84xxx`; lưu giữ nguyên cách gõ sau khi bỏ khoảng trắng; gọi Zalo dùng `84xxx`; gửi bằng cách viết này, nhập mã bằng cách viết khác vẫn là cùng một số | `TC-02, 03, 90, 100, 101` | S | M | 0.1 | Size: một phép chuẩn hóa, một loại kết quả. Effort: 5 case nhưng thực chất 3 nhánh (chấp nhận / lưu / so khớp); `TC-100,101` phải suy ra "cùng số khác cách viết không báo không khớp" từ tailieu/8 L28 |
| 2 | `BR-02` | tailieu/8 L24, L46, L48, L87→88 | Validate khi **nhập mã**: OTP rỗng / 5 số / 7 số / có chữ, mã tài khoản thiếu / sai định dạng, SĐT sai định dạng → Lỗi dữ liệu (11000), OTP phải đúng 6 chữ số | `TC-91→97` | S | M | 0.1 | Size: một endpoint, một loại lỗi. Effort: 3 trường × thiếu/sai định dạng ≈ 6 nhánh nhưng cùng khuôn kết quả, độ khó thấp; chờ câu hỏi #8 (có tính là lần nhập sai không) |
| 3 | `BR-04` | tailieu/7 (30016); tailieu/8 L27 (30025) | Tài khoản không tồn tại → 30016 khi gửi; **không lộ** tài khoản có tồn tại hay không: nhập mã cho tài khoản không tồn tại phải giống hệt nhập mã khi chưa từng gửi (30025) | `TC-08, 13, 68` | S | M | 0.1 | Size: một điều kiện kiểm tra. Effort: phải so phản hồi hai endpoint để chứng minh không lộ thông tin (suy từ tailieu/8 L27); chạm bảo mật nên nâng lên M. `TC-13` không có nguồn nên không nâng thêm |
| 4 | `BR-05` | tailieu/8 (30029, 30014) | Tài khoản đã xác thực → không gửi thêm mã (30014) và không nhập thêm mã (30029); kiểm tra "tài khoản đã xác thực" đứng **trước** kiểm tra "SĐT trùng người khác" | `TC-09, 60, 69, 99` | S | M | 0.1 | Size: một trạng thái chặn. Effort: hai mã lỗi khác nhau theo endpoint và có thứ tự ưu tiên phải suy từ tailieu/8; `TC-99` phụ thuộc câu hỏi #8 (khóa nhập mã hay đã xác thực thắng) |
| 5 | `BR-06` | SRS §2 S2-05; tailieu/7 (30014) | SĐT đã được **người khác xác thực** thì không dùng được (30014); trùng nhưng người kia **chưa** xác thực thì vẫn cho; người khác xác thực xong giữa chừng thì lúc nhập mã vẫn bị chặn | `TC-10, 11, 12, 98` | S | H | 0.25 | Size: một kiểm tra trùng. Effort: tài liệu **thiếu** (3 cách viết có được so khớp ở bước này không — câu hỏi #5), `TC-12` phải suy ra "chưa xác thực thì không chặn", `TC-98` là đua giữa hai tài khoản; sót là chiếm được SĐT người khác. `TC-11` chờ câu hỏi #5 |
| 6 | `BR-07` | SRS §2 S2-07, S2-08 | Thời gian chờ gửi lại (30018): được **đặt ngay khi yêu cầu hợp lệ vào API, trước khi gọi Zalo**; trong lúc chờ không cộng bộ đếm; Zalo lỗi vẫn bị chờ | `TC-15, 25, 64` | S | M | 0.1 | Size: một điều kiện. Effort: bất biến "đặt trước khi gọi Zalo" chỉ chứng minh được bằng cách dựng Zalo lỗi rồi gửi lại ngay (`TC-25`). `TC-64` (bấm hai lần cùng lúc) không có nguồn nên không nâng thêm |
| 7 | `BR-08` | SRS §2 S2-06, S2-14→S2-16 | Phân loại yêu cầu gửi mã và bộ đếm: **gửi lần đầu** không cộng bộ đếm nào; **đổi số** (số khác số gần nhất) +1 bộ đếm đổi số và reset trạng thái xác thực; **gửi lại** (cùng cặp) +1 bộ đếm gửi lại, mã cũ hết tác dụng; **cùng số đang lưu** không cộng đổi số; A→B→A đếm 3 lần đổi số | `TC-14, 16, 21, 24, 65` | M | H | 0.7 | Size: bản ghi tài khoản + cache OTP theo tài khoản + hai bộ đếm (trạng thái nhiều bước). Effort: bảng quyết định nhiều nhánh với bộ đếm tính theo hai khóa khác nhau (theo tài khoản / theo cặp); là nền của hai thang khóa nên sai là hỏng cả hai |
| 8 | `BR-09` | SRS §2 S2-12 và BR gửi OTP; tailieu/7 (30015, 30024) | Gửi Zalo thất bại thì **không** đổi SĐT, **không** tạo cache OTP, **không** cộng đổi số, **không** cộng gửi lại; phân biệt số không dùng Zalo (30015) với lỗi khác (30024); Zalo chậm không treo | `TC-18, 19, 23, 89` | M | M | 0.5 | Size: giữ 4 bất biến trên nhiều hệ thống (DB, cache, hai bộ đếm) khi dịch vụ ngoài lỗi. Effort: phải giả lập Zalo lỗi hai kiểu và quá thời gian; `TC-89` suy diễn từ cấu hình `timeout` |
| 9 | `BR-10` | SRS §4, S2-09, S2-17; L156→L158, L165→L168 | Khóa **đổi số** theo bậc 5/10/20 lần → 1/10/60 phút; chạm bậc **vẫn gửi mã**, khóa áp từ lần sau; chạm bậc cuối thì reset về bậc đầu; đang khóa thì không gọi Zalo | `TC-17, 20, 26→35` | M | H | 0.7 | Size: thang 3 bậc có bộ đếm và trạng thái khóa. Effort: biên ở 3 bậc × (trước/chạm/ngay sau/hết khóa) + reset; hành vi "chạm bậc vẫn thành công" **phân kỳ** với khóa nhập mã nên không dùng chung khuôn; sót một bậc là sót lỗi bảo vệ tài khoản |
| 10 | `BR-11` | SRS §4, S2-10; L152, L229 | Khóa **gửi lại** theo cùng thang bậc nhưng đếm theo **cặp tài khoản + SĐT**, chỉ đếm sau khi gửi thành công; lỗi 30020; hết khóa và reset ở bậc cuối | `TC-22, 36→45` | M | M | 0.5 | Size: thang 3 bậc. Effort vừa vì **kế thừa** cấu trúc của `BR-10`, chỉ tính phần khác (khóa đếm theo cặp, chỉ đếm khi thành công); nhưng khi chạy thật vẫn phải gửi tới 20 lần |
| 11 | `BR-12` | SRS §3 S3-07, §4; L108→L113, L164 | Khóa **nhập sai mã** 5/10/20 lần → 1/10/60 phút; khóa **ngay lần chạm bậc** (khác BR-10/11); cả mã hết hạn, không khớp, sai đều tính; đang khóa thì mã đúng cũng bị chặn (30028); đoán mã liên tục bị chặn; kịch bản ghép sai → khóa → hết khóa → đúng; **đổi số làm đếm lại từ 0 nên có thể né khóa** | `TC-46→55, 66, 67, 70` | M | H | 0.7 | Size: thang 3 bậc + 3 loại lỗi cùng cộng vào một bộ đếm. Effort: hành vi khóa **ngay** trái với BR-10/11; `TC-67` là rủi ro **suy ra** từ cơ chế (khóa theo cặp tài khoản + SĐT trong khi đổi số cho phép tạo cặp mới) chạm bảo mật brute-force; chờ câu hỏi #7. `TC-66` không có nguồn nên không nâng |
| 12 | `BR-13` | SRS §6, S3-03→S3-06; tailieu/8 L27→L29, L102→L107 | Vòng đời mã OTP: hết hạn (30025), không khớp tài khoản/SĐT (30026), sai (30027, báo kèm số lần đã sai); chỉ **một mã hiệu lực** cho mỗi tài khoản — đổi số thì mã của số cũ không dùng được; biên ngay trước/sau giờ hết hạn | `TC-56, 57, 58, 61, 62, 63, 102` | M | M | 0.5 | Size: cache theo tài khoản + payload SĐT + TTL + bộ đếm (vòng đời nhiều bước). Effort: giá trị biên TTL (suy diễn), mã cũ bị thay khi đổi số, 3 mã lỗi phải phân biệt đúng; `TC-61` suy diễn |
| 13 | `BR-14` | SRS §2 S2-11, S2-18; BR gửi OTP | Phản hồi gửi mã: OTP 6 số + thời hạn mã; khi **tắt gửi Zalo thật** thì không gọi Zalo, trả thêm `otp`, vẫn chạy đủ kiểm tra, cache, thời gian chờ | `TC-01` | S | E | 0.05 | Size: một cờ cấu hình, một kết quả phản hồi. Effort: 1 nhánh kỳ vọng ghi thẳng (SRS L66, L81→82), chỉ cần dựng hai chế độ gửi |
| 14 | `BR-15` | SRS §3 S3-08, S3-09; tailieu/8 | Hậu điều kiện xác thực thành công: lưu SĐT giữ nguyên cách gõ, đánh dấu đã xác thực, xóa mã OTP + bộ đếm sai + khóa nhập mã | `TC-59` | M | E | 0.25 | Size: giữ 5 thay đổi trạng thái (2 cột DB + 3 loại cache) phải đồng thời đúng. Effort: 1 nhánh kỳ vọng ghi thẳng, nhưng là điểm kết của cả vòng nên phải kiểm đủ cả 5 |
| 15 | `BR-16` | SRS §5 (nguyên tắc hiển thị) | Quy tắc hiển thị cấu hình Admin: chỉ hiện ô nhập/nút bật tắt cho mục có trong JSON; JSON tổng luôn hiện; ngoại lệ 3 nhóm bậc khóa luôn hiện kèm giá trị mặc định | `TC-71, 75, 76` | S | E | 0.05 | Size: một màn hình, một quy tắc. Effort: 2 nhánh (ẩn / ngoại lệ luôn hiện), kỳ vọng ghi thẳng |
| 16 | `BR-17` | SRS §7 (cách 1); tailieu/7 | Tự làm mới token khi `expires_in` gần hết hạn lúc gửi mã; token mới (+25 giờ, refresh +3 tháng) dùng được ngay cho request sau | `TC-79` | S | M | 0.1 | Size: một điều kiện kích hoạt, một kết quả (token mới dùng được). Effort: phải dựng token sắp hết hạn và kiểm token mới được lưu lẫn đồng bộ cache |
| 17 | `BR-18` | SRS §7 (cách 2) | Tác vụ 03:00 chỉ làm mới token khi **bật** tự động refresh và token còn **dưới 2 ngày**; tắt hoặc còn dài hạn thì không làm | `TC-84, 85, 86` | S | M | 0.1 | Size: một tác vụ định kỳ, một kết quả (làm/không làm). Effort: 3 nhánh theo 2 điều kiện, phải dựng cờ và hạn token; `TC-85` suy diễn; tác vụ lỗi giữa chừng chưa có (câu hỏi #3) |
| 18 | `BR-19` | tailieu/7 (30017, 30021→30023) | Thiếu/hỏng cấu hình thì chặn gửi mã bằng đúng mã lỗi: thiếu cấu hình cơ bản (30017), thiếu cấu hình refresh (30021), refresh token hết hạn (30022), Zalo từ chối làm mới (30023) | `TC-80→83` | S | M | 0.1 | Size: một loại kết quả (chặn + mã lỗi). Effort: 4 mã lỗi phải dựng đủ 4 tình huống cấu hình/token khác nhau |

**Tổng bảng A: 5 point** (18 BR).

## 4. Chưa chốt point

| Mã | Dự kiến | Chờ gì |
| --- | ---: | --- |
| `BR-03` Validate khi **gửi mã** (`TC-04, 05, 06, 07`): SĐT rỗng / sai định dạng, mã tài khoản thiếu / sai định dạng | 0.1 (`S × M`) | Câu hỏi **#6**: tài liệu chỉ nêu mã lỗi cho phía **nhập mã** (11000); phía **gửi mã** chưa có mã lỗi và thông báo. Hiện cả 4 case chỉ biết "bị từ chối", chưa có kỳ vọng đo được |

Khi `BR-03` được chốt, tổng tính năng thành **5.1**. Nếu muốn giữ đúng 5, cần quyết định gộp `BR-03`
vào `BR-02` (cùng là validate dữ liệu đầu vào) — việc này bạn quyết, mình chưa tự gộp.

Các nhánh biên đang chờ — nếu câu trả lời làm đổi kỳ vọng thì mở dòng `mở rộng`, chỉ tính delta:

| BR | Nhánh chờ | Câu hỏi |
| --- | --- | --- |
| `BR-06` | `TC-11` cùng số khác cách viết | #5 |
| `BR-12` | `TC-67` đổi số để né khóa nhập mã | **#7** (bảo mật) |
| `BR-02`, `BR-05` | `TC-91`, `TC-97` có tính là lần nhập sai không · `TC-99` khóa nhập mã hay đã xác thực thắng | **#8** |
| `BR-18` | Tác vụ 03:00 lỗi giữa chừng | #3 |
| IP không cần xác thực OTP | Chưa biết áp ở bước nào nên chưa có BR | #1 |

## 5. Phần đã loại khỏi báo cáo

| Đầu việc | Lý do loại |
| --- | --- |
| `TC-72`, `73`, `74` — bật/tắt gửi thật, bật/tắt tự refresh, sửa số lần/thời gian khóa trên màn Admin | **Thao tác cấu hình, không chứa quy tắc** (§1.1): không có điều kiện/kết quả riêng ngoài việc lưu giá trị. Hệ quả của việc chỉ tính theo BR |
| Luồng "gửi mã thành công" và "xác thực mã thành công" như luồng | Không phải đơn vị. Quy tắc trong luồng đã tách thành `BR-14`, `BR-15`; phần còn lại là thao tác |
| `TC-77`, `TC-78` — tiếp cận (a11y) màn Admin | **Không có nguồn tài liệu** (QA tự bổ sung). BR chỉ gồm case không nguồn thì không có dòng |
| `TC-87`, `TC-88` — tốc độ phản hồi gửi / nhập mã | **Không có nguồn**, ngưỡng "< 2 giây", "< 1 giây" chưa được thống nhất |
| `TC-13`, `TC-64`, `TC-66` | Không có nguồn nhưng nằm trong BR có nguồn (`BR-04`, `BR-07`, `BR-12`) → có phủ, **không nâng point** |
| `TC-26, 29, 32, 36, 39, 42, 61, 85` (case "suy diễn") | Giá trị biên suy ra từ ngưỡng có trong tài liệu → hợp lệ, thuộc `BR-10`, `BR-11`, `BR-13`, `BR-18` |
| Bản kỹ thuật `ZALO-OTP.md` (90 case) | Cùng nội dung với bản nghiệp vụ, đã chấm một lần |
| Bảng mã lỗi (mục 15), thuật ngữ, câu hỏi (mục 14) | Không phải BR riêng — mã lỗi thuộc BR đã trích nó; câu hỏi nâng Effort của BR liên quan |

## 6. Bảng B — chưa có

Chưa có defect, automation, thay đổi regression suite. Khi chạy thật, việc dựng dữ liệu (tài khoản nhiều
trạng thái, số điện thoại thật đã đăng ký Zalo, chỉnh cấu hình để chạm bậc khóa, reset cache theo từng
khóa) mới xét có tách dòng hay không (§3 của rule).

## 7. Tự kiểm trước khi gửi

- [x] Mọi dòng có mã `BR-xx` trỏ về mục tài liệu
- [x] Mỗi mã TC chỉ xuất hiện ở đúng một dòng
- [x] Luồng thuần và thao tác không chứa quy tắc không có dòng; quy tắc trong luồng đã tách thành BR
- [x] Case không có nguồn không tạo dòng và không nâng point (trừ `TC-67`, suy ra từ cơ chế, đã ghi rõ)
- [x] Không dòng nào dùng Size `L`
- [x] Không dòng nào vượt 0.7 — dòng cao nhất là ba thang khóa/bảng quyết định (`BR-08`, `BR-10`, `BR-12`)
- [x] `BR-11` kế thừa `BR-10` nên chỉ tính phần khác → 0.5, không phải 0.7
- [x] BR chưa có kỳ vọng đo được (`BR-03`) để ở mục chưa chốt
- [x] Tổng kỳ = 5 = tổng bảng A + bảng B (0)

## 8. Lịch sử cập nhật

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
| 2026-10-02 | QA | Tạo báo cáo chấm theo **cơ chế nghiệp vụ**: 9 subtask, 7.75 point |
| 2026-10-02 | QA | Sửa subtask rà soát tài liệu `M × M` → `M × H` (7.75 → 8.25) |
| 2026-10-02 | QA | Chấm lại theo **use case + business rule**: 16 đơn vị, 12.75 point |
| 2026-10-02 | QA | Rule đổi sang **chỉ tính theo business rule**: bỏ 4 use case, tách quy tắc trong luồng thành `BR-14→BR-19`; 18 BR chốt |
| 2026-10-02 | QA | Người chấm xác nhận **tổng tính năng OTP = 5 point** → hiệu chỉnh ma trận co nửa, làm tròn bội 0.05 (`S` 0.05/0.1/0.25 · `M` 0.25/0.5/0.7 · `L` 0.5/0.75/1). Phân loại Size × Effort của 18 BR giữ nguyên; tổng 10.75 → 5 |
