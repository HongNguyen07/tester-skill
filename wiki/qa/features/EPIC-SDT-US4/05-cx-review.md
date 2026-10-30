---
featureId: EPIC-SDT-US4
basedOn: 02-alignment-summary.md (gate: open, 2026-10-15; closedScope BR3/AC9 — Q-26, 2026-10-16)
reviewedAt: 2026-10-15 · cập nhật 2026-10-16 (Figma giao diện thật)
modes: [1, 3]              # 1 = UI/UX/CX Review · 3 = Customer Journey Review — KHÔNG chạy Mode 2
evidenceLevel: phân tích tài liệu + design thật (Mode 1) · mô phỏng bằng suy luận (Mode 3) — không có tương tác thật
---

# CX Review — EPIC-SDT-US4: Quên mật khẩu bằng số điện thoại hoặc email

**Mode đã chạy:** Mode 1 (review từ tài liệu + ảnh user flow + ảnh wireframe + **Figma giao diện thật** từ 2026-10-16) và Mode 3
(hành trình end-to-end suy ra từ tài liệu). **Không chạy Mode 2**: không có prototype bấm được, sản phẩm chạy được hay công cụ
thao tác. Figma là design tĩnh: ảnh xem được **2/10 frame US4** (màn 04 lỗi không khớp `1754:6840`, màn 03 email `1774:7086`) +
email mẫu "Đặt lại mật khẩu" `1872:4430` + màn 01 `1634:21845` (mục US3); 8 frame US4 còn lại chỉ có lớp text
(`figma/lop-text-figma-2026-10-16.txt`) — chữ trong ô nhập / nút / lỗi của 8 frame đó **không có, không suy đoán**. Mọi nhận định về
hành vi người dùng và phản hồi hệ thống vẫn là `[CX GIẢ THUYẾT]`; điều "thấy trên Figma" là thấy trên ảnh design, không phải sản
phẩm. **Không có finding loại Defect**: khác biệt giữa Figma và tài liệu / câu BA là việc của Debate (Q-26, Q-27, Q-28, Q-12) hoặc
chuyển QA, không phải bằng chứng hành vi thực tế. **Phạm vi BR3/AC9 (cổng đóng — Q-26):** chỉ ghi rủi ro và chuyển QA, không đề
xuất expected.

**Cập nhật 2026-10-16:** finding CX-01 → CX-13 giữ ID, rà lại theo Figma (cột "Cập nhật Figma" trong từng khối); thêm CX-14 → CX-20
từ Figma; số finding ở mục 4 đếm lại.

Viết tắt tệp và số dòng theo `01-requirement-analysis.md` (`US4`, `EPIC`, `US2`, `US3`, `US9`, `BUG10`, `API7`). "02 mục 4 #n"
= dòng n trong bảng Cách hiểu đã thống nhất của `02-alignment-summary.md`.

## 1. Phạm vi và nguồn đã xem

| # | Nguồn (tài liệu / design / prototype / sản phẩm) | Phạm vi | Cách xem (đọc tài liệu / xem ảnh / thao tác thật) |
| ---: | --- | --- | --- |
| 1 | `US4` (98 dòng) | Toàn bộ: scope, BR1–BR9, AC1–AC18, câu hỏi mở | Đọc tài liệu |
| 2 | Ảnh user flow `US4:22` | Nhánh 01 → 02 → 03 → 04 → 01 và các nhánh lỗi | Xem ảnh |
| 3 | Ảnh wireframe 4 màn `US4:30` (02, 03, 04, 01) | Nhãn, câu hướng dẫn, nút, ghi chú trên từng màn | Xem ảnh — **chỉ tham khảo luồng** (`US4:34`); từ 2026-10-16 chỗ nào Figma (#11) có thì lấy Figma, wireframe chỉ còn dùng cho màn/trạng thái Figma chưa đọc được |
| 4 | `02-alignment-summary.md` (gate open) | Mục 3 câu trả lời BA, mục 4 cách hiểu đã thống nhất (25 dòng), mục 6 điểm còn mở | Đọc tài liệu |
| 5 | `01-requirement-analysis.md` | Mục 4 màn hình, 5b quy tắc Epic, 8 diễn giải, 9 điểm chưa rõ | Đọc tài liệu |
| 6 | `US2` | BR1–BR5, AC1–AC13 (màn OTP dùng chung, màn 06 lỗi) | Đọc tài liệu |
| 7 | `US3` §5–§7 | Màn 01 đăng nhập, tạm khóa, link Đăng ký ẩn trên iOS | Đọc tài liệu |
| 8 | `US9` §6–§8 | BR6 Google đặt mật khẩu qua Quên mật khẩu; AC5, AC9 | Đọc tài liệu |
| 9 | `BUG10` | iOS không được có đường vào đăng ký | Đọc tài liệu |
| 10 | `EPIC` §2, §6, §8 (câu hỏi #4, #11, #16, #20–#23), §13 | Quy tắc chung, bối cảnh người dùng, câu hỏi mở | Đọc tài liệu |
| 11 | `FIGMA` — file Gopany v1.1, trang "↳ Mobile app" (Hồng gửi 2026-10-16); mục "04 US4" 10 frame, mục "Email OTP" frame `1872:4430`, mục "03 US3" frame `1634:21845` | **Ảnh 2/10 frame US4**: `figma/US4_1754-6840_matkhau-khong-khop.png` (màn 04, lỗi không khớp), `figma/US4_1774-7086_otp-email.png` (màn 03 email); `figma/EMAIL_1872-4430_otp-datlai-mk.png`; `figma/US3_1634-21845_dangnhap.png`. 8 frame US4 còn lại: chỉ tên frame + lớp text (`figma/lop-text-figma-2026-10-16.txt`). Đối chiếu AC/BR ở `01` mục 4b | Xem ảnh (4 ảnh) + đọc lớp text — **không** thao tác, không prototype; không có frame cho AC5/AC6, AC10 (thông báo thành công), AC12, AC15/AC16, đếm ngược màn 04; lỗi OTP màn 03 nằm ở mục US2 (8 frame) **chưa đọc** |
| 12 | `03-test-design.md`, `04-testcases.md` (đã có từ S6/S7) | ID case để điền cột Trace | Đọc tài liệu |

**Giới hạn:** Không có prototype, sản phẩm chạy được hay công cụ truy cập → không chạy Mode 2. Figma có từ 2026-10-16 nhưng
**chỉ xem được ảnh 2/10 frame US4** (giới hạn gói Figma MCP): đánh giá được bố cục, nhãn, trạng thái lỗi inline, nút mờ/bật của
đúng 2 màn đó (+ email mẫu, màn 01); 8 frame còn lại chỉ biết tên frame và lớp text — placeholder, chữ trên nút, nội dung lỗi của
màn 02, màn 03 Zalo, màn 04 "Chưa nhập đầy đủ" / "Mật khẩu không hợp lệ" **chưa đọc được**. Không đo được contrast, cỡ chữ thật,
vùng chạm, screen reader từ ảnh PNG → accessibility vẫn ngoài tầm. Không có frame cho thông báo thành công AC10, lỗi gửi AC6, hết
hạn AC15/16, mất mạng AC12. Không có dữ liệu người dùng thật → mọi persona ở mục 2 là phân nhóm theo tài liệu hoặc giả thuyết phục
vụ review. Cột Trace nay trỏ ID case trong `04-testcases.md` (theo bảng đối chiếu ở `06-unified-qa-review.md`).

## 2. Persona

| Persona | Nhóm khách hàng · bối cảnh | Mục tiêu | Căn cứ |
| --- | --- | --- | --- |
| P1 | Người đăng ký bằng SĐT, **không có email**, dùng app Android, nhận OTP qua Zalo trên cùng điện thoại | Lấy lại mật khẩu để vào app, không nhờ hỗ trợ | `US4:7` "Người đăng ký bằng SĐT có thể không có email"; `US4:12`; `EPIC:44` (US1 Android/Web) |
| P2 | Người tạo tài khoản bằng Google, **chưa từng có mật khẩu**, muốn đăng nhập bằng email + mật khẩu (vd trên máy không đăng nhập Google) | Đặt mật khẩu lần đầu qua luồng này | `US4:52`; `US9:50`; `US9:69`; 02 mục 4 #21 (Q-04 đã chốt có) |
| P3 | Người dùng app **iOS** | Lấy lại mật khẩu; không được thấy đường vào đăng ký | `EPIC:31`; `BUG10:7`; `BUG10:35`; `US3:53` |
| P4 | Người đang **bị tạm khóa đăng nhập** vì sai mật khẩu nhiều lần | Vào lại tài khoản sớm hơn thời gian khóa | `US4:83` (AC18); `US3:43`; 02 mục 4 #2 |
| P5 | Người **nhớ nhầm** định danh (gõ email cũ / SĐT khác) hoặc chưa có tài khoản | Nhận mã để đặt lại mật khẩu | `US4:66` (AC5) chỉ mô tả tình huống, không mô tả người → **persona giả thuyết phục vụ review** |
| P6 | Người đang có **phiên đăng nhập ở thiết bị thứ hai** (web máy tính, "Lưu đăng nhập") khi đổi mật khẩu — kể cả trường hợp đổi vì nghi tài khoản bị người khác dùng | Mọi thiết bị khác bị đăng xuất | `US4:74` (AC11); 02 mục 4 #22 (Q-05); phần "nghi bị chiếm" là **giả thuyết phục vụ review** |
| P7 | Người **bị gián đoạn** ở màn 04 (nghe điện thoại, chuyển app) và hoàn tất sau mốc 10 phút | Lưu mật khẩu mới | `US4:53-55`, `US4:80-82` mô tả tình huống; người dùng cụ thể là **persona giả thuyết phục vụ review** |
| P8 | Người dùng SĐT **không có / không dùng Zalo**, hoặc gặp lỗi gửi Zalo/email | Nhận được mã bằng cách nào đó | `EPIC:159` (câu hỏi #16 nêu "người dùng không dùng Zalo hoặc Zalo lỗi", còn mở); `US4:67` (AC6); `API7:35` mã 30015 "SĐT không tồn tại trên Zalo" (chưa xác nhận là API của US4) — căn cứ một phần, hành vi là giả thuyết |

## 3. Hành trình đã review

Tất cả hành trình là **mô phỏng bằng suy luận** từ tài liệu (Mode 3), chưa thao tác thật. Cập nhật 2026-10-16 theo Figma: màn 03
nút là "Xác thực" (không phải "Xác nhận"), khi đang đếm chỉ có đồng hồ "45s" không có nút Gửi lại (CX-17); màn 04 **không có nút
Quay lại** (CX-15) nên bước "04 Quay lại → 03" ở J5 chỉ còn là back hệ thống, đích chưa biết (Q-12 mở lại); thông báo thành công
AC10 ở J1/J2 chưa có frame (CX-20).

| Hành trình | Persona | Mục tiêu → các bước → phản hồi hệ thống → kết quả cuối → cách phục hồi | Nguồn |
| --- | --- | --- | --- |
| J1 — Luồng chính SĐT (Android) | P1 | Mục tiêu: vào lại app. 01 bấm "Quên mật khẩu?" → 02 gõ SĐT, Tiếp tục → 03 "Mã đã được gửi qua Zalo tới 09•• ••• 678", mở Zalo lấy mã (app ra nền), quay lại gõ 6 số, Xác nhận → 04 gõ 2 ô, Lưu mật khẩu → 01 "Đổi mật khẩu thành công. Vui lòng đăng nhập lại." → gõ lại SĐT + mật khẩu mới → vào app. Phục hồi: sai mã → theo US2; sai mật khẩu → lỗi tại ô, sửa, Lưu lại. | `US4:62-74`; `US4:82` (ra nền quay lại giữ phiên); ảnh user flow |
| J2 — Luồng chính email Google (Web) | P2 | Mục tiêu: đặt mật khẩu lần đầu. 01 → 02 gõ email Google → 03 "Mã đã được gửi tới ng•••@…", gợi ý kiểm tra Spam; mở hộp thư ở tab khác → gõ mã → 04 → Lưu → 01 → đăng nhập bằng email + mật khẩu mới; Google vẫn dùng được. Phục hồi: đóng tab giữa chừng → làm lại từ 02 (Q-06). | `US4:65`, `US4:52`; `US9:69`; 02 mục 4 #21, #24 |
| J3 — Nhớ nhầm định danh | P5 | 02 gõ email cũ (không có tài khoản) → vẫn sang 03 "Mã đã được gửi tới …" → chờ, không có mã → thử gõ mã → "Mã OTP không đúng" → "Gửi lại mã" đếm ngược, không gửi, có tính lượt → lặp → có thể chạm giới hạn gửi / tạm khóa cho định danh đó. Kết quả: **hành trình không hoàn thành**. Phục hồi duy nhất theo wireframe: "Đổi email"/"Đổi số"/"Quay lại" → 02 gõ định danh đúng (bộ đếm theo từng định danh, 02 mục 4 #4). | `US4:48`, `US4:66`; 02 mục 3 Q-02; 02 mục 4 #18 |
| J4 — Quá 10 phút ở màn 04 | P7 | 03 verify thành công → 04 → bị gián đoạn > 10 phút → (a) FE phát hiện hết hạn: **không thông báo**, về 02 điền sẵn; (b) chưa phát hiện, bấm Lưu: BE từ chối, điều hướng như (a). Người dùng bấm Tiếp tục → 03 nhận mã mới (lượt gửi cộng vào bộ đếm US2) → 04 gõ lại từ đầu → Lưu → 01. | `US4:80-82`; 02 mục 3 Q-09 "Không hiển thị thông báo"; 02 mục 4 #13 |
| J5 — iOS, các đường quay lại | P3 | 01 (không có Đăng ký) → 02 "Quay lại đăng nhập" → 01; 03 "Quay lại" → 02; 04: Figma không vẽ nút Quay lại → chỉ còn back hệ thống, đích chưa chốt (Q-12 mở lại, CX-15); back cứng nhiều lần → mọi màn không lộ Đăng ký. Nếu P3 chưa có tài khoản: kẹt ở J3 và **không có lối đăng ký nào trong app** (đúng chủ trương Apple). | `BUG10:28`, `BUG10:35`; `EPIC:108`; wireframe màn 01 "ẩn trên iOS"; 02 mục 3 Q-12 |
| J6 — Thiết bị thứ hai | P6 | P1 đổi mật khẩu xong trên điện thoại → web máy tính (phiên "Lưu đăng nhập") **chưa văng ngay**; thao tác tiếp (mở hội thoại, gửi tin) → bị đưa về màn đăng nhập. Tài liệu không nói web hiện thông báo lý do gì. | `US4:50`, `US4:74`; 02 mục 4 #22 (Q-05) |
| J7 — Tài khoản đang bị tạm khóa đăng nhập | P4 | 01 báo khóa (US3 AC6) → bấm Quên mật khẩu → J1 → đổi xong gỡ khóa, đăng nhập được ngay bằng mật khẩu mới. Tài liệu không nói màn khóa có gợi ý "Quên mật khẩu" hay không; con số khóa chưa chốt (Q-11). | `US4:83`; `US3:57`; 02 mục 4 #2 |
| J8 — Gửi mã lỗi / SĐT không có Zalo | P8 | 02 gõ SĐT thật → Zalo lỗi hoặc SĐT không có Zalo → AC6 "Báo lỗi; gợi ý thử kênh còn lại hoặc liên hệ hỗ trợ" **nhưng** BA chốt không lộ tồn tại (Q-03) → hành trình **chưa mô phỏng được** vì tài liệu chưa có cách hiển thị (Q-03b). P1 không có email → "kênh còn lại" không tồn tại. | `US4:67`, `US4:48`; 02 mục 4 #25; `01` mục 8 #12 |

## 4. Tổng hợp finding

| ID | Loại | Tóm tắt | Persona | Impact | Mức bằng chứng | Trace (BR / UC / case) |
| --- | --- | --- | --- | --- | --- | --- |
| CX-01 | Usability Issue | Màn 02 không cho biết SĐT cần có Zalo mới nhận được mã; người không dùng Zalo chỉ biết sau khi đã bấm Tiếp tục — **giữ**, Figma màn 02 (lớp text) cũng không có | P1, P8 | Trung bình | phân tích tài liệu + lớp text Figma | BR1, AC1, AC6, Q-03b · `[US4_01]` `[US4_16]` |
| CX-02 | CX Risk (rủi ro giả định) | Người nhớ nhầm định danh vẫn sang màn 03 "Mã đã được gửi…", đợi mã không bao giờ tới, tiêu lượt gửi/sai, có thể bị tạm khóa mà không có lời giải thích — **giữ**; Figma màn 03: lối thoát là link "Đổi email"/"Đổi số" góc phải | P5, P3 | Cao (bỏ dở, gọi hỗ trợ — trái mục tiêu `US4:12`) | mô phỏng bằng suy luận + ảnh Figma màn 03 | BR2, AC5, BR5, Q-02 · `[US4_13]` `[US4_14]` `[US4_15]` |
| CX-03 | CX Risk (rủi ro giả định) | Hết 10 phút ở màn 04: bị đưa về màn 02 **không thông báo**, mật khẩu vừa gõ mất; thêm lượt gửi vào bộ đếm US2 — **giữ**; Figma không có frame AC15/16 và 3 frame màn 04 không vẽ đếm ngược | P7 | Cao (mất niềm tin, nghi app lỗi, không biết mật khẩu đã đổi chưa) | mô phỏng bằng suy luận + ảnh Figma màn 04 | BR7, BR8, AC15, AC16, Q-09 · `[US4_50]` `[US4_51]` `[US4_75]` |
| CX-04 | Usability Issue | **Thu hẹp**: phần "helper chưa nêu đủ" đóng — Figma màn 04 đã có helper đầy đủ (nhưng nội dung khác BA → Q-26, xem CX-18); phần "thông báo không đạt quy định chưa có nguyên văn" **giữ** (frame "Mật khẩu không hợp lệ" `1641:22759` chưa đọc được chữ) | P1, P2 | Trung bình | phân tích tài liệu + ảnh Figma màn 04 | BR3, AC9, Q-01b, Q-26 · `[US4_19]` → `[US4_22]` (`❓ Cần chốt: Q-26`) |
| CX-05 | Usability Issue | Câu "Mật khẩu mới dùng để đăng nhập bằng cả email và số điện thoại" sai với tài khoản chỉ có một định danh — **giữ, xác nhận trên Figma** (cả 3 frame màn 04 dùng đúng câu này) | P1, P2 | Thấp | ảnh Figma + lớp text | AC11, E-01 · `01` mục 8 #2 · `[US4_18]` (ĐO & GHI nội dung) |
| CX-06 | Improvement Suggestion | Màn 01 sau khi đổi thành công: người dùng gõ lại định danh vừa gõ ở màn 02 — **giữ**; Figma không có frame màn 01 sau khi đổi, frame màn 01 chung (US3) vẽ ô trống | P1 | Thấp | phân tích tài liệu + ảnh Figma màn 01 | AC10, BR4 · 02 mục 4 #17 · `[US4_74]` |
| CX-07 | CX Risk (rủi ro giả định) | Thiết bị khác chỉ bị đăng xuất ở lần gọi API kế tiếp; không có thông báo lý do trên thiết bị bị đăng xuất — **giữ**; Figma màn 01 tick sẵn "Lưu đăng nhập" → phiên lưu lâu trên nhiều thiết bị là mặc định, tình huống này phổ biến hơn | P6 | Trung bình (niềm tin khi đổi vì nghi bị chiếm; mất dữ liệu đang nhập dở) | mô phỏng bằng suy luận + ảnh Figma màn 01 | BR4, AC11, Q-05 · `[US4_34]` `[US4_35]` `[US4_45]` |
| CX-08 | CX Risk (rủi ro giả định) | AC6 lỗi gửi vs BR2 không lộ tồn tại: người có tài khoản thật không biết mã không tới vì lỗi gửi; "kênh còn lại" vô nghĩa với tài khoản 1 định danh — **giữ**; Figma mục US4 không có frame lỗi gửi (frame "gửi không thành công" nằm ở mục US2, chưa đọc) | P1, P8 | Cao | phân tích tài liệu | BR2, AC6, Q-03b · `[US4_16]` `[US4_17]` `❓ Cần chốt` |
| CX-09 | CX Risk (rủi ro giả định) | iOS: người chưa có tài khoản đi luồng Quên mật khẩu không có lối ra (không được lộ Đăng ký) — **giữ**; frame màn 01 Figma có "Chưa có tài khoản? Đăng ký" nhưng không ghi nền tảng, biến thể iOS chưa thấy | P3 | Trung bình | phân tích tài liệu + ảnh Figma màn 01 | E-15, BUG10 AC2 · `[US4_65]` |
| CX-10 | Usability Issue | Màn 03 kênh Zalo: không có gợi ý khi không nhận được mã — **giữ**; lớp text Figma 2 frame Zalo chỉ có "Chưa nhận được mã?" + "45s", không có câu hướng dẫn nào (và frame email cũng không có Spam → CX-16) | P8, P1 | Trung bình | phân tích tài liệu + lớp text Figma | AC3, AC4, US2 AC1–AC2 · `[US4_07]` |
| CX-11 | CX Risk (rủi ro giả định) | Lấy mã phải rời app (mở Zalo/email); app bị hệ điều hành tắt → làm lại từ màn 02; không rõ có dán được mã vào 6 ô — **giữ**; Figma màn 03 vẽ 6 ô rời + bàn phím số, không cho biết có nhận dán | P1 | Trung bình | mô phỏng bằng suy luận + ảnh Figma màn 03 | AC17, BR9, Q-06 · `[US4_52]` → `[US4_54]` |
| CX-12 | Usability Issue | Quay lại từ màn 04 về màn 03 — màn 03 sau khi đã verify hiện gì: tài liệu không nói — **giữ nhưng tiền đề đổi**: Figma màn 04 **không có nút Quay lại** (CX-15), câu hỏi còn lại áp cho back hệ thống / gesture (nếu được phép) | P5 | Thấp–Trung bình | phân tích tài liệu + ảnh Figma màn 04 | BR9, Q-12 (mở lại), Q-18, Q-27 · `[US4_55]` `[US4_72]` |
| CX-13 | Usability Issue | Tài khoản Google đặt mật khẩu lần đầu qua lối tên "Quên mật khẩu?" — nhãn không khớp ý định, khó tìm — **giữ, xác nhận trên Figma màn 01**: chỉ có link "Quên mật khẩu?" cạnh "Lưu đăng nhập", không có lối nào khác | P2 | Thấp | ảnh Figma màn 01 | BR6, US9 BR6, Q-04 · `[US4_43]` |

| CX-14 | Usability Issue | Màn 04 (Figma): lỗi không khớp ghi "Mật khẩu không khớp vui lòng nhập lạ" — thiếu chữ "i", không dấu câu, khác nguyên văn AC9 "Mật khẩu xác nhận không khớp." | P1, P2 | Trung bình (khả năng đọc; nghi app lỗi) | ảnh Figma màn 04 `1754:6840` | AC9 `US4:72` · Q-27 · `[US4_23]` |
| CX-15 | Usability Issue | Màn 04 (Figma): **không có nút Quay lại** ở cả 3 frame; người bấm nhầm / muốn đổi định danh chỉ còn back hệ thống, đích chưa chốt (Q-12 mở lại) — khác wireframe và câu BA Q-12 | P5, P3 | Trung bình (bỏ dở, kẹt ở màn 04 trong khi đồng hồ 10 phút chạy) | ảnh Figma màn 04 + lớp text 3 frame | BR9 `US4:55` · Q-12, Q-27 · `[US4_55]` |
| CX-16 | Usability Issue | Màn 03 email (Figma): **không có gợi ý kiểm tra Spam** như AC4 yêu cầu; người không thấy mã chỉ còn chờ đồng hồ hoặc "Đổi email" | P2 | Trung bình (tiêu lượt gửi 5 mã/ngày, bỏ dở) | ảnh Figma màn 03 `1774:7086` | AC4 `US4:65` · US2 AC2 · Q-28 · `[US4_08]` |
| CX-17 | Usability Issue | Màn 03 (Figma): khi đang đếm chỉ hiện "Chưa nhận được mã?" + đồng hồ "45s", **không có nút "Gửi lại mã" (mờ)** như US2 AC4; người dùng không biết hết 45 s sẽ có gì, bấm được gì | P1, P8 | Thấp–Trung bình | ảnh Figma màn 03 + lớp text 4 frame màn 03 | US2 AC4 `US2:59`, US2 BR3 `US2:46` · `[US4_38]` |
| CX-18 | CX Risk (rủi ro giả định) | Màn 04 (Figma): helper "Mật khẩu phải có từ 8–16 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt" đòi 4 loại ký tự, **khác** quy định BA Q-01; nếu FE/BE kiểm theo bên kia, người dùng làm đúng helper vẫn bị lỗi hoặc ngược lại — **phạm vi cổng đóng, chỉ ghi rủi ro** | P1, P2 | Cao nếu hai bên kiểm khác nhau (lặp thử–sai trong 10 phút) | ảnh Figma màn 04 `1754:6840` | BR3, AC9 · **Q-26 (trọng yếu, cổng đóng)** · `[US4_19]` → `[US4_29]` `❓ Cần chốt: Q-26` |
| CX-19 | Usability Issue | Email OTP "Đặt lại mật khẩu" (Figma): chân thư còn placeholder "[email hỗ trợ] · [hotline]"; design không có tiêu đề (subject) email; tên frame ghi nhầm "Đăng ký bằng email (US6)" (nội bộ) | P2 | Thấp (nội dung chính rõ; placeholder nếu lọt ra thật làm mất tin) | ảnh Figma email `1872:4430` | US2 mẫu 23 `US2:38` · `[US4_11]` |
| CX-20 | CX Risk (rủi ro giả định) | Thông báo thành công AC10 "Đổi mật khẩu thành công. Vui lòng đăng nhập lại." **chưa có design**: hình thức (toast / banner / popup) và thời gian hiện chưa biết → người dùng có thể không biết đã đổi xong, nhất là khi về màn 01 trông y như lúc bắt đầu | P1, P2, P7 | Trung bình (không biết thành công; gõ lại mật khẩu cũ) | lớp text 10 frame US4 + ảnh màn 01 US3 (không có frame thông báo) | AC10 `US4:73` · BR4 · Q-27 · `[US4_30]` `[US4_31]` |

Số lượng theo loại (đếm lại 2026-10-16): Defect **0** · Usability Issue **11** (CX-01, 04, 05, 10, 12, 13, 14, 15, 16, 17, 19) · CX Risk **8**
(CX-02, 03, 07, 08, 09, 11, 18, 20) · Improvement Suggestion **1** (CX-06). Tổng **20** (13 cũ giữ ID — CX-04 thu hẹp phạm vi, không
finding nào đóng hẳn; 7 mới CX-14 → CX-20 từ Figma).

## 5. Chi tiết finding

### CX-01 — Màn 02 không báo trước SĐT cần có Zalo

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-01 |
| Review scope | Màn 02 — câu hướng dẫn và hành động "Tiếp tục" |
| Source evidence | `US4:62` "Nhập email hoặc số điện thoại đã đăng ký. Chúng tôi sẽ gửi mã xác thực qua email hoặc Zalo." · wireframe màn 02 (`US4:30`) cùng câu này · `US4:18` "OTP qua SMS" ngoài phạm vi · `EPIC:159` câu hỏi #16 (SMS dự phòng khi không dùng Zalo) còn mở · `API7:35` mã 30015 "SĐT không tồn tại trên Zalo" (chưa xác nhận là API của US4) |
| Persona và context | P1 (đăng ký bằng SĐT, không có email); P8 (SĐT không có/không dùng Zalo) — P8 căn cứ một phần |
| Customer journey / scenario | J1 bước 02; J8 |
| Observation | `[CX GIẢ THUYẾT]` Câu hướng dẫn nói "qua email hoặc Zalo" nhưng không nói rõ *điều kiện* SĐT phải có Zalo; người dùng không dùng Zalo vẫn bấm Tiếp tục và chỉ biết không nhận được mã ở màn 03 (hoặc gặp AC6 — chưa chốt cách hiển thị). Với P1 không có email, đây là kênh duy nhất. |
| Finding type | Usability Issue |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — không có requirement quy định phải cảnh báo trước; không có quan sát thực tế |
| Impact | Người dùng không có Zalo mất thời gian chờ mã, có thể bấm Gửi lại nhiều lần (tiêu lượt US2) rồi bỏ dở; trái mục tiêu "không cần nhờ hỗ trợ" (`US4:12`) |
| Evidence và confidence / limitations | Câu chữ AC1 và **lớp text Figma 3 frame màn 02** (`1641:22403`, `1754:6239`, `1754:6293`): "Nhập email hoặc số điện thoại đã đăng ký. Mã xác thực sẽ được gửi qua email hoặc Zalo" — không có chú thích về điều kiện Zalo; placeholder ô nhập và lỗi tại ô của 3 frame chưa đọc được (có thể có helper trong ô — không suy đoán). Độ tin cậy trung bình–cao. |
| Cập nhật Figma 2026-10-16 | **Giữ.** Figma dùng câu khác AC1 về chữ (Q-27) nhưng cùng ý; vẫn không báo trước SĐT cần có Zalo. |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-01: câu hướng dẫn / helper màn 02 nêu rõ "Số điện thoại cần có tài khoản Zalo để nhận mã" (câu chữ do Product/UX chốt). Không đổi BR1. |
| Traceability | BR1 `US4:47` · AC1 `US4:62` · AC6 / Q-03b · UC-01 · `[US4_01]` (màn 02 câu hướng dẫn), `[US4_16]` (Zalo lỗi, `❓`) |
| Open questions / quyết định cần Product · BA · UX | Product: có cảnh báo trước về Zalo không; câu hỏi #16 Epic (SMS dự phòng) khi nào chốt |

### CX-02 — Người nhớ nhầm định danh kẹt ở màn 03 không lời giải thích

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-02 |
| Review scope | Màn 02 → 03 với SĐT/email chưa có tài khoản (AC5) |
| Source evidence | `US4:48` BR2 "Thông báo sau khi bấm Tiếp tục luôn giống nhau dù SĐT/email có tồn tại hay không" · `US4:66` AC5 "Không gửi mã; thông báo chung giống AC3/AC4" · 02 mục 3 Q-02 câu trả lời BA: sang màn 03, nhập mã → "Mã OTP không đúng", Gửi lại chạy đếm ngược nhưng không gửi, có tính vào bộ đếm · 02 mục 4 #18 "Mọi thứ quan sát được giống hệt tài khoản có tồn tại" · wireframe màn 03 có "Đổi số" / "Đổi email" / "Quay lại" |
| Persona và context | P5 (nhớ nhầm — persona giả thuyết); P3 iOS chưa có tài khoản |
| Customer journey / scenario | J3 |
| Observation | `[CX GIẢ THUYẾT]` Theo cách hiểu đã chốt, người gõ nhầm email cũ thấy "Mã đã được gửi tới …", chờ mã không tới, gửi lại (không gửi, vẫn đếm ngược và tính lượt), thử gõ mã → sai → sau N lần bị tạm khóa OTP cho định danh đó (US2 BR5). Không có tín hiệu nào cho biết "định danh này không có tài khoản" — đây là **chủ ý bảo mật** (BR2, `EPIC:116`), không phải lỗi. Điểm CX: lối thoát duy nhất là tự nghĩ ra việc bấm "Đổi email"/"Đổi số" để thử định danh khác. |
| Finding type | CX Risk — rủi ro giả định |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — hành vi hiện tại đúng requirement đã xác nhận; không có quan sát thực tế |
| Impact | Bỏ dở, mất lòng tin ("app gửi mã mà không thấy"), gọi hỗ trợ; nếu bị tạm khóa OTP, định danh nhầm bị khóa (định danh đúng không ảnh hưởng — bộ đếm theo từng định danh, 02 mục 4 #4). Trên iOS (P3) nặng hơn vì không có đường đăng ký (CX-09). |
| Evidence và confidence / limitations | Dựa trên câu trả lời BA đã ghi trong 02; chưa thấy màn 06 lỗi của US2 (ảnh không nằm trong phạm vi US4). Độ tin cậy trung bình–cao về hành vi, giả thuyết về phản ứng người dùng. |
| Recommendation | Không đổi BR2. `[ĐỀ XUẤT THAY ĐỔI]` CP-02: dưới "Chưa nhận được mã?" ở màn 03 thêm gợi ý **trung tính** (không lộ tồn tại), vd "Kiểm tra lại số điện thoại/email đã dùng khi đăng ký" + làm nổi nút "Đổi số"/"Đổi email". QA: thêm case nhóm B — từ màn 03 (định danh không tồn tại) bấm "Đổi số/Đổi email" → về 02 → gõ định danh đúng → nhận mã bình thường, bộ đếm định danh đúng không bị ăn theo. |
| Cập nhật Figma 2026-10-16 | **Giữ.** Ảnh màn 03 email (`1774:7086`): lối thoát duy nhất là link "Đổi email" cỡ nhỏ ở góc phải trên, cùng hàng với câu "Mã số đã được gửi tới…"; không có câu gợi ý nào dưới "Chưa nhận được mã?". Với con số Q-11 mới (5 mã/ngày, sai 5 lần khóa 1 ngày — 02 mục 4 #26, #28) tác động nặng hơn: người gõ nhầm có thể khóa định danh nhầm cả ngày. `[CX GIẢ THUYẾT]` về việc người dùng có nhìn thấy link. |
| Traceability | BR2 `US4:48` · AC5 `US4:66` · BR5 `US4:51` · Q-02, Q-11 · UC-01 alt flow · `[US4_13]` `[US4_14]` `[US4_15]` |
| Open questions / quyết định cần Product · BA · UX | Product/UX: nội dung gợi ý trung tính ở màn 03 (thuộc US2 vì màn dùng chung, `EPIC:90`) |

### CX-03 — Hết 10 phút ở màn 04: bị đẩy về màn 02 không thông báo

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-03 |
| Review scope | Màn 04 → 02 khi kết quả xác thực hết hiệu lực (AC15, AC16) |
| Source evidence | `US4:54` BR8 · `US4:80` AC15 "về màn 02, điền sẵn email/SĐT, người dùng bấm Tiếp tục để nhận mã mới" · `US4:81` AC16 "Backend từ chối cập nhật dù mật khẩu hợp lệ … thông báo và điều hướng như AC15" · 02 mục 3 Q-09 câu trả lời BA "**Không hiển thị thông báo**, chỉ chuyển về màn 02"; đếm ngược trên màn 04 **chưa trả lời** · 02 mục 4 #13 lượt gửi mới cộng vào bộ đếm US2 |
| Persona và context | P7 (bị gián đoạn — persona giả thuyết) |
| Customer journey / scenario | J4 |
| Observation | `[CX GIẢ THUYẾT]` Người dùng vừa gõ xong hai ô mật khẩu, bấm "Lưu mật khẩu" và thấy mình ở màn 02 với ô đã điền sẵn, không có lời giải thích. Họ không biết: (1) mật khẩu đã đổi chưa (thực tế chưa — BE từ chối); (2) vì sao bị đưa về; (3) phải bấm Tiếp tục và nhập OTP lần nữa. Nếu màn 04 cũng không có đếm ngược (Q-09 mở), người dùng không có cách nào biết mình đang chạy đua với 10 phút. Thêm nữa, lượt gửi mới cộng vào bộ đếm US2 — người đã dùng vài lượt "Gửi lại" trước đó có thể gặp "thử lại sau 14:30" (`US2:61`) ngay sau khi bị đẩy về. Lưu ý AC16 có chữ "thông báo và điều hướng như AC15" nhưng BA trả lời không hiển thị thông báo — câu chữ AC16 và câu trả lời BA chưa khớp hẳn. |
| Finding type | CX Risk — rủi ro giả định |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — hành vi đã xác nhận với BA (không thông báo); không có quan sát thực tế |
| Impact | Cao: nghi app lỗi, thử lại nhiều lần, hoặc tưởng đã đổi rồi quay ra đăng nhập bằng mật khẩu mới → thất bại → gọi hỗ trợ. Người dùng đã verify OTP (đã chứng minh sở hữu định danh) nên thông báo ở bước này **không** làm lộ tồn tại tài khoản. |
| Evidence và confidence / limitations | Dựa trên câu trả lời BA ghi trong 02 mục 3. Figma mục US4 **không có frame** cho AC15/AC16 (hết hạn, về màn 02 điền sẵn) và 3 frame màn 04 (`1754:6468`, `1641:22759`, `1754:6840`) **không vẽ đếm ngược** → không có bằng chứng design nào về toast hay đồng hồ. Độ tin cậy trung bình. |
| Cập nhật Figma 2026-10-16 | **Giữ.** Design hiện tại không trả lời phần đếm ngược của Q-09; `[US4_75]` vẫn ĐO & GHI. |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-03: một dòng ngắn ở màn 02 khi được đưa về do hết hạn (vd "Phiên xác thực đã hết hạn. Bấm Tiếp tục để nhận mã mới.") và/hoặc đếm ngược còn lại ở màn 04. Quyết định thuộc Product/BA; CX không chọn thay. QA: khi Q-09 chốt, thêm case nhóm B — về màn 02 do hết hạn rồi Tiếp tục khi bộ đếm gửi đã chạm giới hạn → hành vi theo `US2:61`. |
| Traceability | BR7 `US4:53` · BR8 `US4:54` · AC15 `US4:80` · AC16 `US4:81` · Q-09 · 02 mục 4 #7, #8, #13 · `[US4_50]` `[US4_51]` `[US4_75]` |
| Open questions / quyết định cần Product · BA · UX | Quay lại Debate (bổ sung vào Q-09): AC16 ghi "thông báo … như AC15" nhưng BA trả lời "không hiển thị thông báo" — xác nhận lại câu chữ; màn 04 có đếm ngược không |

### CX-04 — Helper mật khẩu màn 04 chưa nêu đủ quy định đã chốt

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-04 |
| Review scope | Màn 04 — helper dưới ô "Mật khẩu mới" và lỗi AC9 |
| Source evidence | Wireframe màn 04 (`US4:30`): "Tối thiểu [__] ký tự, theo quy định mật khẩu hiện tại." · `US4:72` AC9 chỉ có nguyên văn cho lỗi không khớp · 02 mục 3 Q-01 BA chốt "8–16 ký tự, phải có ≥1 chữ và ≥1 số; ký tự khác cho phép — tài liệu chưa cập nhật" · Q-01b (nguyên văn lỗi không đạt) còn mở · `US4:79` AC14 nút Lưu bấm được khi đã nhập đủ |
| Persona và context | P1, P2 |
| Customer journey / scenario | J1, J2 bước 04 |
| Observation | `[CX GIẢ THUYẾT]` Helper chỉ nói "tối thiểu … ký tự" nên người dùng gõ 20 ký tự hoặc toàn số sẽ bấm Lưu rồi mới bị lỗi tại ô (AC14 + AC9); lỗi không đạt quy định chưa có câu chữ nên không biết thông báo có nói rõ *thiếu gì* hay không. Cụm "theo quy định mật khẩu hiện tại" không có giá trị với người dùng vì họ không biết quy định đó. |
| Finding type | Usability Issue |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — không có quan sát thực tế; helper trên Figma và quy định BA đang mâu thuẫn (Q-26) nên không có "expected" duy nhất để đối chiếu |
| Impact | Lặp lại thử–sai ở màn 04 trong khi đồng hồ 10 phút đang chạy (BR7) → tăng nguy cơ rơi vào CX-03 |
| Evidence và confidence / limitations | Ảnh Figma màn 04 `1754:6840`: helper **đã điền đầy đủ** "Mật khẩu phải có từ 8–16 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt", nằm ngay dưới ô Mật khẩu mới, chữ xám nhỏ hơn chữ trong ô; frame "Mật khẩu không hợp lệ" `1641:22759` tồn tại (có trạng thái lỗi không đạt quy định) nhưng **chữ lỗi chưa đọc được**. Độ tin cậy cao cho phần helper, không có cho phần lỗi. |
| Cập nhật Figma 2026-10-16 | **Thu hẹp.** (a) "Helper chưa nêu đủ quy định" → **đóng**: Figma đã nêu đủ tiêu chí, cụm "theo quy định mật khẩu hiện tại" của wireframe không còn. Nhưng nội dung helper **khác BA Q-01** → không coi là đã giải quyết, chuyển thành rủi ro riêng CX-18 trong phạm vi Q-26 (cổng đóng, không đề xuất expected). (b) "Lỗi không đạt quy định chưa có nguyên văn" → **giữ**, chờ Q-01b và đọc frame `1641:22759`. Recommendation cũ ("helper nêu đủ 8–16, 1 chữ 1 số") **thu hồi** — không còn phù hợp khi quy định đang tranh chấp. |
| Recommendation | Khi Q-01b chốt: helper nêu đủ "8–16 ký tự, có ít nhất 1 chữ và 1 số"; lỗi AC9 phần không đạt nói rõ tiêu chí thiếu. QA: case AC9 đã dự kiến; đề xuất thêm case nhóm B "helper text màn 04 khớp quy định đã chốt Q-01" → ĐO & GHI. |
| Traceability | BR3 `US4:49` · AC9 `US4:72` · AC14 `US4:79` · Q-01, Q-01b, Q-26 · 02 mục 4 #19 · `[US4_19]` → `[US4_22]`, `[US4_25]` (`❓ Cần chốt: Q-26`) |
| Open questions / quyết định cần Product · BA · UX | BA: Q-01b nguyên văn; UX: helper text cuối trong Figma |

### CX-05 — Câu mô tả màn 04 không đúng với tài khoản chỉ có một định danh

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-05 |
| Review scope | Màn 04 — câu dưới tiêu đề |
| Source evidence | Wireframe màn 04 (`US4:30`): "Mật khẩu mới dùng để đăng nhập bằng cả email và số điện thoại." · `US4:74` AC11 "đăng nhập được bằng cả email và SĐT" · `EPIC:97` mỗi SĐT/email gắn một tài khoản; tài khoản có thể chỉ có một định danh (`US4:7`, `US9:68` SĐT "Chưa có") · `01` mục 8 #2 diễn giải "chỉ áp dụng khi tài khoản có cả hai định danh" |
| Persona và context | P1 (chỉ có SĐT), P2 (Google, chỉ có email) |
| Customer journey / scenario | J1, J2 bước 04 |
| Observation | `[CX GIẢ THUYẾT]` P1 đọc câu này có thể tưởng mình đăng nhập được bằng email dù chưa có email; P2 tưởng đăng nhập được bằng SĐT. Không gây hỏng hành trình nhưng gieo kỳ vọng sai cho lần đăng nhập sau. |
| Finding type | Usability Issue |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — câu chữ là nội dung design, không phải AC |
| Impact | Thấp |
| Evidence và confidence / limitations | **Figma dùng đúng câu này** ở cả 3 frame màn 04 (ảnh `1754:6840` + lớp text `1754:6468`, `1641:22759`): "Mật khẩu mới dùng để đăng nhập bằng cả email và số điện thoại" (không dấu chấm cuối). Độ tin cậy cao về nội dung; phản ứng người dùng vẫn giả thuyết. |
| Cập nhật Figma 2026-10-16 | **Giữ, nâng bằng chứng** từ wireframe lên design thật. CP-04 vẫn là đề xuất cho UX. |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-04: câu trung tính, vd "Mật khẩu mới dùng để đăng nhập bằng email hoặc số điện thoại đã xác thực của bạn." QA: không thêm case; ghi nội dung thực tế khi ĐO & GHI màn 04. |
| Traceability | AC11 `US4:74` · E-01 `EPIC:97` · `[US4_18]` (ĐO & GHI nội dung màn 04) |
| Open questions / quyết định cần Product · BA · UX | UX chốt câu trong Figma |

### CX-06 — Màn 01 sau khi đổi xong: gõ lại định danh vừa nhập

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-06 |
| Review scope | Màn 01 sau AC10 |
| Source evidence | `US4:73` AC10 → màn đăng nhập · `US4:50` BR4 "không tự đăng nhập" · wireframe màn 01 vẽ placeholder trống · 02 mục 4 #17 "ô định danh trống — ĐO & GHI, không làm expected" |
| Persona và context | P1 |
| Customer journey / scenario | J1 bước cuối |
| Observation | `[CX GIẢ THUYẾT]` Người dùng vừa gõ SĐT ở màn 02 (và màn 02 còn giữ nó khi quay về do hết hạn, AC15) nhưng ở màn 01 có thể phải gõ lại. Không tự đăng nhập là chủ ý bảo mật — không đề xuất đổi. |
| Finding type | Improvement Suggestion |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — tài liệu không quy định ô có điền sẵn hay không |
| Impact | Thấp — thêm một bước gõ |
| Evidence và confidence / limitations | Wireframe + ảnh Figma màn 01 chung `1634:21845` (mục US3): ô "Nhập email hoặc số điện thoại" là placeholder trống, nút Đăng nhập mờ; Figma mục US4 **không có frame màn 01 sau khi đổi xong** nên không biết design có điền sẵn hay không. |
| Cập nhật Figma 2026-10-16 | **Giữ.** Chưa có căn cứ design cho trạng thái sau AC10; `[US4_74]` ĐO & GHI. |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-05: điền sẵn định danh vừa dùng vào ô "Email hoặc số điện thoại" ở màn 01 (vẫn không tự đăng nhập). Product quyết. QA: giữ ĐO & GHI như 02 mục 4 #17. |
| Traceability | AC10 `US4:73` · BR4 `US4:50` · `[US4_74]` |
| Open questions / quyết định cần Product · BA · UX | Product |

### CX-07 — Thiết bị khác đăng xuất trễ và không có lời giải thích

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-07 |
| Review scope | Thiết bị thứ hai sau AC11 |
| Source evidence | `US4:50` BR4 "đăng xuất mọi thiết bị" · `US4:74` AC11 · 02 mục 3 Q-05 BA: "thiết bị khác về màn đăng nhập ở lần gọi API kế tiếp" · 02 mục 4 #22 "trước thao tác màn hình vẫn như cũ là đúng theo BA" · tài liệu **không nói** thiết bị bị đăng xuất hiện thông báo gì |
| Persona và context | P6 — phần "đổi vì nghi bị chiếm" là giả thuyết phục vụ review |
| Customer journey / scenario | J6 |
| Observation | `[CX GIẢ THUYẾT]` (1) Người đổi mật khẩu vì nghi có người khác đang dùng tài khoản kỳ vọng thiết bị kia bị văng ngay; theo BA, thiết bị kia vẫn hiển thị nội dung đã tải cho tới khi thao tác tiếp. Đây là giới hạn kỹ thuật đã chốt, CX chỉ ghi rủi ro niềm tin. (2) Trên thiết bị bị đăng xuất, nếu chỉ "về màn đăng nhập" không kèm lý do, người dùng (chính chủ đang dùng web ở máy tính) không hiểu vì sao; nội dung đang gõ dở (vd tin nhắn ChatGoni) có thể mất. |
| Finding type | CX Risk — rủi ro giả định |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — hành vi đã xác nhận với BA; không có quan sát thực tế |
| Impact | Trung bình: niềm tin bảo mật; mất dữ liệu nhập dở trên thiết bị 2 |
| Evidence và confidence / limitations | Dựa trên Q-05; Keycloak (Epic #2) chưa chốt nên cơ chế thực có thể khác. Độ tin cậy trung bình. |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-06: thiết bị bị đăng xuất hiện thông báo lý do (vd "Mật khẩu tài khoản đã được thay đổi. Vui lòng đăng nhập lại."). QA: thêm case nhóm B ĐO & GHI — (a) thông báo trên thiết bị 2 khi bị đưa về đăng nhập; (b) thiết bị 2 đang gõ dở nội dung → thao tác gọi API → nội dung còn/mất. |
| Cập nhật Figma 2026-10-16 | **Giữ.** Ảnh màn 01 `1634:21845`: checkbox "Lưu đăng nhập" **tick sẵn** → phiên lưu lâu trên nhiều thiết bị là mặc định, nên tình huống P6 không phải cá biệt. Không có frame cho thiết bị bị đăng xuất. `[CX GIẢ THUYẾT]` |
| Traceability | BR4 `US4:50` · AC11 `US4:74` · AC18 `US4:83` · Q-05 · `[US4_34]` `[US4_35]` `[US4_45]` |
| Open questions / quyết định cần Product · BA · UX | BA/BE: thiết bị bị đăng xuất hiện gì — tài liệu không nói (QA ĐO & GHI, không phải câu hỏi cách hiểu) |

### CX-08 — AC6 lỗi gửi vs không lộ tồn tại: người có tài khoản thật không biết vì sao mã không tới

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-08 |
| Review scope | Màn 02/03 khi gửi Zalo/email lỗi (AC6) |
| Source evidence | `US4:67` AC6 "Báo lỗi; gợi ý thử kênh còn lại hoặc liên hệ hỗ trợ" · `US4:48` BR2 · `EPIC:116` · 02 mục 3 Q-03 BA đổi thành **không lộ** · 02 mục 4 #25 "Khi gửi lỗi thật, người dùng thấy gì — chưa có câu trả lời (Q-03b)" · `01` mục 8 #12 "kênh còn lại" chỉ có nghĩa khi tài khoản có cả hai định danh · `US2:17` lỗi không gửi được xử lý trong từng luồng |
| Persona và context | P1 (chỉ có SĐT), P8 (Zalo/email lỗi) |
| Customer journey / scenario | J8 — chưa mô phỏng được tới cùng |
| Observation | `[CX GIẢ THUYẾT]` Hai yêu cầu kéo ngược nhau về trải nghiệm: nếu không lộ tồn tại thì lỗi gửi thật phải trông giống AC5 (sang màn 03 "Mã đã được gửi…") → người có tài khoản thật chờ mã vô ích, tiêu lượt, bỏ dở, không bao giờ biết là do Zalo lỗi; nếu báo lỗi gửi rõ ràng thì chỉ xảy ra với tài khoản có thật → lộ tồn tại. "Gợi ý thử kênh còn lại" không áp dụng được cho P1. CX không chọn cách hiểu; chỉ ghi rủi ro và tác động để Debate/Product cân nhắc. |
| Finding type | CX Risk — rủi ro giả định |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — requirement phần này đang `❓ Cần chốt` (Q-03b) |
| Impact | Cao với P1/P8: hành trình thất bại không phục hồi được trong app; phải "liên hệ hỗ trợ" — trái mục tiêu `US4:12` |
| Evidence và confidence / limitations | Hoàn toàn từ tài liệu; chưa biết tần suất lỗi gửi thực tế. |
| Recommendation | Không đề xuất phương án nghiệp vụ (thuộc Q-03b). Gợi ý cho Product khi chốt: cân nhắc thông báo lỗi gửi **chung** không gắn với tồn tại tài khoản (vd lỗi hệ thống gửi mã, cho thử lại) và phương án cho tài khoản chỉ có SĐT (Epic #16 SMS dự phòng). QA: giữ case AC6 `❓ Cần chốt`. |
| Cập nhật Figma 2026-10-16 | **Giữ.** Mục US4 trên Figma không có frame lỗi gửi; frame "gửi không thành công" nằm ở mục US2 (chưa đọc được) — khi đọc được cần đối chiếu xem có lộ tồn tại không. Không thay đổi phân loại. |
| Traceability | BR2 `US4:48` · AC6 `US4:67` · Q-03, Q-03b · 02 mục 4 #25 · `[US4_16]` `[US4_17]` `❓ Cần chốt` |
| Open questions / quyết định cần Product · BA · UX | **Quay lại Debate Q-03b** kèm tác động CX ở trên |

### CX-09 — iOS: người chưa có tài khoản đi luồng Quên mật khẩu không có lối ra

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-09 |
| Review scope | iOS, màn 01/02/03 khi định danh không có tài khoản |
| Source evidence | `EPIC:31`, `EPIC:108` iOS không có đường vào đăng ký · `BUG10:28` "không có đường nào tới màn/nút đăng ký – kể cả back, link trong trang, deep link" · `BUG10:35` AC2 rà mọi màn kể cả quên mật khẩu · wireframe màn 01 "Chỉ Android · Web — ẩn trên iOS" · `US9:64` US9 AC5 iOS Google: "Tài khoản chưa tồn tại. Vui lòng đăng ký trên web hoặc ứng dụng Android." (chỉ cho Google) · `US4:66` AC5 không lộ tồn tại |
| Persona và context | P3 |
| Customer journey / scenario | J5 + J3 |
| Observation | `[CX GIẢ THUYẾT]` P3 chưa có tài khoản gõ SĐT ở màn 02 → kẹt ở J3 (CX-02) và vì không được lộ Đăng ký nên không có hướng dẫn nào tiếp theo. Khác với US9 AC5 (Google trên iOS được báo rõ "chưa tồn tại"), luồng US4 không được báo (BR2). Đây là hệ quả của hai ràng buộc đúng (Apple + bảo mật), không phải lỗi; ghi để Product biết điểm cụt của hành trình. |
| Finding type | CX Risk — rủi ro giả định |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — requirement cấm lộ Đăng ký; không có quan sát thực tế |
| Impact | Trung bình: bỏ dở trên iOS; tăng liên hệ hỗ trợ |
| Evidence và confidence / limitations | Ảnh Figma màn 01 `1634:21845` có "Chưa có tài khoản? Đăng ký" ở đáy nhưng frame không ghi nền tảng; không thấy biến thể iOS (ẩn Đăng ký) trong các frame đã đọc; không biết có màn hướng dẫn chung nào ngoài US4. |
| Cập nhật Figma 2026-10-16 | **Giữ.** Chuyển QA: khi đọc được thêm frame, kiểm Figma có biến thể màn 01 iOS không (`[US4_65]`). |
| Recommendation | Không đề xuất thêm link/câu hướng dẫn đăng ký trên iOS (rủi ro Apple, `BUG10:3`). Chuyển Product cân nhắc kênh hỗ trợ chung (ngoài phạm vi US4). QA: case iOS không lộ Đăng ký đã có ở 02 mục 10; đề xuất bổ sung nhóm B — iOS màn 03 với định danh không tồn tại, bấm "Đổi số"/"Quay lại"/back nhiều lần → không lộ Đăng ký, không văng app. |
| Traceability | E-15 · BUG10 AC1–AC3 · BR2 `US4:48` · `[US4_65]` |
| Open questions / quyết định cần Product · BA · UX | Product: chính sách hỗ trợ người iOS chưa có tài khoản |

### CX-10 — Màn 03 kênh Zalo không có gợi ý khi không nhận được mã

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-10 |
| Review scope | Màn 03 — khu "Chưa nhận được mã? / Gửi lại mã sau 00:45" |
| Source evidence | `US4:64` AC3 Zalo: chỉ "Mã đã được gửi qua Zalo tới 09•• ••• 678" · `US4:65` AC4 email: có "gợi ý kiểm tra Spam" · `US2:55-56` AC1 Zalo (nút "Đổi số"), AC2 email (gợi ý Spam/Quảng cáo) · wireframe màn 03 "Chưa nhận được mã?" không kèm hướng dẫn cho Zalo |
| Persona và context | P8, P1 |
| Customer journey / scenario | J1 bước 03 |
| Observation | `[CX GIẢ THUYẾT]` Với email có gợi ý "kiểm tra Spam"; với Zalo người dùng không được gợi ý mở Zalo, kiểm tra tin nhắn từ OA Gopany, hay kiểm tra SĐT có Zalo không. "Chưa nhận được mã?" trên wireframe là nhãn, không rõ bấm vào làm gì (có thể chỉ là chữ dẫn cho "Gửi lại mã"). |
| Finding type | Usability Issue |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — không có requirement về gợi ý cho kênh Zalo |
| Impact | Trung bình: bấm Gửi lại nhiều lần (tiêu lượt US2) thay vì mở Zalo |
| Evidence và confidence / limitations | Lớp text Figma 2 frame màn 03 Zalo (`1641:22535`, `1641:22563`): "Mã số đã được gửi qua Zalo tới số 09•• ••• 678.", một link (chữ chưa đọc — frame email là "Đổi email"), "Chưa nhận được mã?", "45s", một nút — **không có câu hướng dẫn nào khác**; ảnh 2 frame này chưa xem. Màn 03 dùng chung thuộc US2. Độ tin cậy trung bình–cao. |
| Cập nhật Figma 2026-10-16 | **Giữ.** Thêm: "Chưa nhận được mã?" trên ảnh frame email là chữ xám thường, không phải link — nhiều khả năng chỉ là nhãn dẫn cho đồng hồ (`[CX GIẢ THUYẾT]`, xem CX-17). |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-07: với kênh Zalo thêm gợi ý ngắn "Mở Zalo để xem tin nhắn từ Gopany" (câu chữ Product/UX chốt; thuộc US2 vì màn dùng chung). QA: không thêm case trong US4; ĐO & GHI nội dung màn 03 kênh Zalo. |
| Traceability | AC3 `US4:64` · AC4 `US4:65` · US2 AC1–AC2 · `[US4_07]` |
| Open questions / quyết định cần Product · BA · UX | UX (US2): "Chưa nhận được mã?" có hành động gì |

### CX-11 — Lấy mã phải rời app; app bị tắt → làm lại từ đầu; dán mã

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-11 |
| Review scope | Màn 03 (và 04) khi người dùng chuyển sang Zalo/email để lấy mã |
| Source evidence | `US4:82` AC17 "Chuyển app ra nền rồi quay lại màn 04: còn hạn thì làm tiếp … Tắt hẳn app rồi mở lại: làm lại từ màn 02 (app không lưu kết quả xác thực xuống máy)" · `US4:55` BR9 · 02 mục 3 Q-06 web: đóng tab → từ màn 02 · `US2:46` chờ 60 s mới gửi lại · `US4:18` không có SMS (không có tự điền mã từ SMS) · wireframe màn 03: 6 ô mã rời |
| Persona và context | P1 (điện thoại cấu hình thấp — giả thuyết phục vụ review) |
| Customer journey / scenario | J1 bước 03 |
| Observation | `[CX GIẢ THUYẾT]` Mã qua Zalo/email buộc người dùng rời app trên cùng điện thoại. AC17 chỉ nói "ra nền rồi quay lại" và "tắt hẳn"; trường hợp hệ điều hành tự tắt app khi thiếu bộ nhớ (hành vi phổ biến trên mobile) rơi vào "tắt hẳn" → làm lại từ màn 02, chờ cooldown 60 s để gửi mã mới (nếu mã cũ còn hạn thì có thể không cần gửi lại — tài liệu không nói). Tài liệu cũng không nói 6 ô mã có nhận **dán** chuỗi 6 số từ Zalo/email không; nếu không, người dùng phải nhớ 6 số khi chuyển qua lại. |
| Finding type | CX Risk — rủi ro giả định |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — tài liệu chỉ định nghĩa "ra nền" và "tắt hẳn"; không có quan sát thực tế |
| Impact | Trung bình: lặp lại bước, tiêu lượt gửi; nặng hơn với người lớn tuổi/thiết bị yếu (giả thuyết) |
| Evidence và confidence / limitations | Không có app để kiểm; tần suất OS kill app phụ thuộc thiết bị. Độ tin cậy thấp–trung bình. |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-08: hỗ trợ dán mã vào ô OTP (thuộc US2, màn dùng chung). QA: thêm case nhóm B — (a) ở màn 03 chuyển sang Zalo rồi quay lại → còn ở màn 03, nhập mã được; (b) mô phỏng OS tắt app ở màn 03 và 04 (Android "Don't keep activities" / iOS swipe-kill) → hành vi theo AC17 "tắt hẳn"; (c) dán 6 số vào ô OTP → ĐO & GHI; (d) web: mở hộp thư ở tab khác rồi quay lại tab luồng → còn ở màn 03. |
| Cập nhật Figma 2026-10-16 | **Giữ.** Ảnh màn 03 `1774:7086`: 6 ô rời, ô đầu đang focus, bàn phím số hệ thống — design không cho biết có nhận dán / tự điền; `[CX GIẢ THUYẾT]` giữ nguyên. |
| Traceability | AC17 `US4:82` · BR9 `US4:55` · Q-06 · US2 BR3 `US2:46` · `[US4_52]` → `[US4_54]` |
| Open questions / quyết định cần Product · BA · UX | BA: sau khi app bị tắt và mở lại từ màn 02 trong lúc mã OTP cũ còn hạn — bấm Tiếp tục gửi mã mới hay dùng mã cũ? (tài liệu không nói; QA ĐO & GHI) |

### CX-12 — Quay lại từ màn 04 về màn 03: trạng thái màn 03 chưa rõ

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-12 |
| Review scope | Màn 04 nút "Quay lại" → màn 03 |
| Source evidence | Wireframe màn 04 có "Quay lại" (`US4:30`) · `US4:55` BR9 "quay lại màn đặt mật khẩu … không làm reset" · 02 mục 3 Q-12 BA: về màn 03 · `01` mục 9 #12 "Ở màn 03 sau khi đã verify, bấm Xác nhận lại / Gửi lại có nghĩa gì?" chưa có câu trả lời |
| Persona và context | P5 (muốn đổi số/email sau khi đã verify — giả thuyết) |
| Customer journey / scenario | J5; J1 rẽ nhánh |
| Observation | `[CX GIẢ THUYẾT]` Người dùng bấm Quay lại ở màn 04 (vd muốn dùng định danh khác, hoặc chỉ bấm nhầm) thấy màn 03 — với 6 ô còn mã cũ hay trống, nút Xác nhận bấm lại được không, "Gửi lại mã" có làm mốc 10 phút tính lại không (`01` mục 8 #8). Không rõ hành động nào đưa họ trở lại màn 04 mà không mất kết quả xác thực. Đây là câu hỏi về cách hiểu tài liệu, không phải đề xuất. |
| Finding type | Usability Issue |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — tài liệu không mô tả trạng thái màn 03 sau verify |
| Impact | Thấp–trung bình: lúng túng, có thể gửi lại mã không cần thiết |
| Evidence và confidence / limitations | Wireframe có nút Quay lại; **Figma 3 frame màn 04 không có** (ảnh `1754:6840` không có mũi tên back ở góc trên — so với màn 03 `1774:7086` có; lớp text 3 frame không có `Button Group 2`). Tiền đề "bấm nút Quay lại" của finding này không còn trên design. |
| Cập nhật Figma 2026-10-16 | **Giữ nhưng đổi tiền đề.** Nếu BA/Design chốt không có nút (Q-12/Q-27) thì câu hỏi "màn 03 hiện gì sau khi quay lại" chỉ còn áp cho back hệ thống Android / gesture iOS / nút Back trình duyệt (nếu không chặn). Vấn đề "không có lối quay lại" tách thành CX-15. `[US4_55]` tạm treo theo Q-12. |
| Recommendation | Không đề xuất phương án. **Quay lại Debate**: trạng thái màn 03 khi quay lại từ 04 và cách trở lại 04. QA: sau khi chốt, thêm case nhóm B 04 → Quay lại → 03 → (hành động đã chốt) → 04, mốc 10 phút không reset (BR9). |
| Traceability | BR9 `US4:55` · Q-12 (mở lại), Q-18, Q-27 · `01` mục 8 #8, mục 9 #12 · `[US4_55]` `[US4_72]` |
| Open questions / quyết định cần Product · BA · UX | BA: như trên |

### CX-13 — Tài khoản Google đặt mật khẩu lần đầu qua lối "Quên mật khẩu?"

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-13 |
| Review scope | Màn 01 → 02, persona Google |
| Source evidence | `US4:52` BR6 · `US9:50` "Tài khoản tạo bằng Google không có mật khẩu; muốn đăng nhập bằng email/SĐT + mật khẩu thì đặt mật khẩu qua Quên mật khẩu" · `US9:68` AC8 Thông tin tài khoản không nhắc tới mật khẩu · wireframe màn 01 link "Quên mật khẩu?" · 02 mục 4 #21 |
| Persona và context | P2 |
| Customer journey / scenario | J2 bước 01 |
| Observation | `[CX GIẢ THUYẾT]` P2 chưa từng có mật khẩu nên không "quên"; không có chỗ nào trong app nói "muốn đặt mật khẩu, dùng Quên mật khẩu". Người dùng có thể thử đăng nhập email + mật khẩu bất kỳ → "Email/số điện thoại hoặc mật khẩu không đúng" (`US3:56`) → không biết bước tiếp. Hành trình hoàn thành được nếu người dùng tự đoán; tiêu đề màn 02 "Quên mật khẩu" và màn 04 "Đặt mật khẩu mới" vẫn hợp lý với họ. |
| Finding type | Usability Issue |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — requirement chỉ nói "đặt được qua luồng này", không nói cách dẫn người dùng tới |
| Impact | Thấp: khó tìm, nhưng không hỏng luồng |
| Evidence và confidence / limitations | Ảnh Figma màn 01 `1634:21845`: "Quên mật khẩu?" là link nhỏ bên phải hàng "Lưu đăng nhập"; không có lối "Đặt mật khẩu" nào khác trên màn 01. Figma Thông tin tài khoản (US5) chưa đọc. |
| Cập nhật Figma 2026-10-16 | **Giữ, nâng bằng chứng** cho phần màn 01. |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-09: trong Thông tin tài khoản (US5) hoặc US9 AC8 thêm lối "Đặt mật khẩu" trỏ sang luồng này — ngoài phạm vi US4, Product quyết. QA: không thêm case trong US4. |
| Traceability | BR6 `US4:52` · US9 BR6 `US9:50` · US9 AC9 `US9:69` · Q-04 · `[US4_43]` |
| Open questions / quyết định cần Product · BA · UX | Product (US5/US9) |

### CX-14 — Màn 04: lỗi không khớp sai chính tả, khác nguyên văn AC9

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-14 |
| Review scope | Màn 04 — thông báo lỗi dưới ô Xác nhận mật khẩu mới |
| Source evidence | Ảnh Figma `figma/US4_1754-6840_matkhau-khong-khop.png` (frame `1754:6840` "Nhập mật khẩu không khớp"): ô 2 viền đỏ, biểu tượng khóa đỏ, dòng đỏ "**Mật khẩu không khớp vui lòng nhập lạ**" · `US4:72` AC9 "Báo lỗi tại ô tương ứng (\"Mật khẩu xác nhận không khớp.\")" · 02 mục 4 #19 (câu không khớp đã thống nhất theo AC9) · 02 mục 3 Q-27 (đã ghi lệch này) |
| Persona và context | P1, P2 — đang gõ hai ô mật khẩu dưới áp lực 10 phút (BR7) |
| Customer journey / scenario | J1, J2 bước 04 — nhánh lỗi |
| Observation | `[NGUỒN]` Figma: câu lỗi thiếu chữ "i" ("lạ" thay vì "lại"), không có dấu phẩy / dấu chấm, và khác câu AC9 cả về từ ("Mật khẩu không khớp" vs "Mật khẩu xác nhận không khớp."). `[CX GIẢ THUYẾT]` Người đọc nhanh vẫn hiểu ý, nhưng lỗi chính tả ở đúng chỗ báo lỗi làm giảm cảm giác sản phẩm được chăm chút; nếu đây là chữ sẽ đưa vào code (không phải chữ mẫu), người dùng thật sẽ thấy. Vị trí lỗi tại ô Xác nhận và nút "Lưu mật khẩu" vẫn bật khi có lỗi **khớp** AC9/AC14 (02 mục 4 #11, #19). |
| Finding type | Usability Issue (khả năng đọc, nhất quán câu chữ) — **không phải Defect**: chỉ từ design, chưa có hành vi sản phẩm |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — không có quan sát thực tế; nguyên văn chốt theo tài liệu hay Figma đang là Q-27 |
| Impact | Trung bình: giảm tin cậy; nếu test lấy nguyên văn AC9 làm expected mà build theo Figma thì `[US4_23]` fail vì câu chữ — cần chốt trước |
| Evidence và confidence / limitations | Ảnh design thật, độ tin cậy cao về nội dung chữ; không biết chữ này có đúng là chuỗi sẽ dùng trong code. |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-10: Design sửa chính tả; BA + Design chốt một nguyên văn duy nhất cho AC9 (Q-27) rồi cập nhật tài liệu hoặc Figma. QA: `[US4_23]` giữ expected theo AC9 nhưng ghi chú Q-27 cho tới khi chốt. |
| Traceability | BR3 `US4:49` · AC9 `US4:72` · Q-27 · `[US4_23]` |
| Open questions / quyết định cần Product · BA · UX | **Debate Q-27 (đã có)**: nguyên văn thông báo lấy theo tài liệu hay Figma |

### CX-15 — Màn 04 không có nút Quay lại

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-15 |
| Review scope | Màn 04 — điều hướng ngược |
| Source evidence | Ảnh Figma `1754:6840`: góc trên trái **không có** mũi tên back (so với màn 03 `1774:7086` có) · lớp text 3 frame màn 04 (`1754:6468`, `1641:22759`, `1754:6840`) đều không có `Button Group 2`, trong khi mọi frame màn 02/03 đều có · wireframe màn 04 (`US4:30`) **có** "Quay lại" · 02 mục 3 Q-12: BA trả lời "(b) về màn 03", **mở lại 2026-10-16** vì lệch Figma · `US4:55` BR9 "quay lại màn đặt mật khẩu … không làm reset" |
| Persona và context | P5 (vừa verify xong mới nhận ra dùng nhầm định danh — giả thuyết); P3 iOS (không có nút back cứng) |
| Customer journey / scenario | J5; J1/J2 rẽ nhánh ở màn 04 |
| Observation | `[NGUỒN]` Figma: màn 04 không vẽ nút Quay lại. `[CX GIẢ THUYẾT]` Người muốn thoát khỏi màn 04 (đổi ý, nhận ra định danh nhầm, hoặc chỉ muốn về đăng nhập) không có hành động nào trên màn ngoài "Lưu mật khẩu"; họ phải dùng back hệ thống (Android) hoặc gesture vuốt (iOS) — tài liệu và design không nói back hệ thống đưa về đâu, có bị chặn không. Có thể là **chủ ý** (không cho quay về màn 03 sau khi đã verify, tránh câu hỏi Q-18) — nếu vậy cần một lối "Hủy / Về đăng nhập" rõ ràng, nếu không người dùng cảm thấy bị nhốt. Không chọn thay BA/Design. |
| Finding type | Usability Issue — **không phải Defect** (chưa biết đâu là requirement đúng: wireframe + Q-12 hay Figma) |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — hai nguồn mâu thuẫn (wireframe/BA Q-12 có nút; Figma không), chưa chốt |
| Impact | Trung bình: bỏ dở hoặc bấm back hệ thống với kết quả không đoán được; `[US4_61]` (bỏ ngang ở màn 04) chưa có cách thực hiện cụ thể trên design |
| Evidence và confidence / limitations | Ảnh 1 frame + lớp text 3 frame → tin cậy cao là design không vẽ nút; không biết back hệ thống được xử lý thế nào. |
| Recommendation | Không đề xuất phương án điều hướng (thuộc Debate). Nếu chốt không có nút: cần BA ghi rõ back hệ thống / gesture về đâu để QA có expected cho `[US4_55]`, `[US4_61]`, `[US4_65]`. |
| Traceability | BR9 `US4:55` · Q-12 (mở lại), Q-18, Q-27 · `[US4_55]` `[US4_61]` `[US4_72]` |
| Open questions / quyết định cần Product · BA · UX | **Debate Q-12 / Q-27 (đã có)**: màn 04 có nút Quay lại không; back hệ thống về đâu |

### CX-16 — Màn 03 email không có gợi ý kiểm tra Spam (AC4)

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-16 |
| Review scope | Màn 03 kênh email — khu dưới ô nhập mã |
| Source evidence | Ảnh Figma `figma/US4_1774-7086_otp-email.png` (frame `1774:7086`): "Nhập mã xác thực" · "Mã số đã được gửi tới ng•• ••• @congty.vn" · link "Đổi email" · 6 ô · "Chưa nhận được mã?" + đồng hồ "45s" · nút "Xác thực" mờ — **không có dòng Spam** · lớp text frame `1774:7189` cũng không có · `US4:65` AC4 "gợi ý kiểm tra Spam" · `US2:56` AC2 "gợi ý kiểm tra hộp thư Spam/Quảng cáo" · 02 mục 3 Q-28 |
| Persona và context | P2 (email Google; thư OTP từ domain mới dễ vào Spam — `[CX GIẢ THUYẾT]`) |
| Customer journey / scenario | J2 bước 03 |
| Observation | `[NGUỒN]` Figma không vẽ gợi ý Spam mà AC4 và US2 AC2 yêu cầu. `[CX GIẢ THUYẾT]` Người không thấy mã trong hộp thư đến sẽ chờ hết 45 s rồi gửi lại (tiêu 1 trong 5 mã/ngày — 02 mục 4 #26), thay vì mở thư mục Spam; thư đã nằm trong Spam thì gửi lại cũng vào Spam → có thể tiêu hết hạn mức ngày mà không lấy được mã. |
| Finding type | Usability Issue — **không phải Defect** (chưa biết AC4 còn hiệu lực hay design thiếu: Q-28) |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — không có quan sát thực tế; AC4 vs design đang Q-28 |
| Impact | Trung bình: tiêu hạn mức 5 mã/ngày, bỏ dở, liên hệ hỗ trợ |
| Evidence và confidence / limitations | Ảnh 1 frame + lớp text frame thứ hai; frame email mẫu không có dòng nào về Spam để bù. Độ tin cậy cao là design hiện không có. |
| Recommendation | Không chọn (a)/(b) của Q-28. Nếu giữ AC4: gợi ý ngắn dưới "Chưa nhận được mã?" (câu chữ UX). QA: `[US4_08]` giữ expected theo AC4, ghi chú Q-28. |
| Traceability | AC4 `US4:65` · US2 AC2 `US2:56` · Q-28 · `[US4_08]` `[US4_14]` |
| Open questions / quyết định cần Product · BA · UX | **Debate Q-28 (đã có)** |

### CX-17 — Màn 03: khi đang đếm không có nút "Gửi lại mã", chỉ có đồng hồ "45s"

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-17 |
| Review scope | Màn 03 — hàng "Chưa nhận được mã?" |
| Source evidence | Ảnh Figma `1774:7086`: bên trái chữ xám "Chưa nhận được mã?", bên phải biểu tượng đồng hồ + "45s" đậm; **không có nút/link "Gửi lại mã"** (mờ hay không) · lớp text 4 frame màn 03 US4 (`1641:22535`, `1641:22563`, `1774:7086`, `1774:7189`) đều chỉ có "Chưa nhận được mã?" và "45s" · `US2:59` AC4 "Nút \"Gửi lại mã\" mờ, đếm ngược 60 giây (\"Gửi lại mã sau 00:59\" → 00:00)" · `US2:60` AC5 hết chờ bấm "Gửi lại mã" · wireframe màn 03 (`US4:30`) "Gửi lại mã sau 00:45" · `01` mục 4b: frame "yêu cầu gửi lại khi hết chờ" nằm ở mục US2, **chưa đọc** |
| Persona và context | P1, P8 (đang chờ mã Zalo không tới) |
| Customer journey / scenario | J1, J3 bước 03 |
| Observation | `[NGUỒN]` Figma: trong 60 s đầu màn 03 không có chữ "Gửi lại" nào; chỉ có nhãn + đồng hồ. `[CX GIẢ THUYẾT]` Người dùng không biết hết 45 s thì sẽ có gì (nút hiện ra? tự gửi lại?) và "Chưa nhận được mã?" có bấm được không (trên ảnh trông như chữ thường). Khác US2 AC4 (nút mờ + "Gửi lại mã sau 00:59") — US2 AC4 nói rõ hành động sắp có, design hiện tại thì không. Trạng thái sau khi hết đếm có thể đã vẽ ở frame US2 chưa đọc → chưa kết luận là thiếu. |
| Finding type | Usability Issue (biết hành động tiếp theo) — **không phải Defect** |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — US2 AC4 là requirement của US2; design trạng thái hết đếm chưa đọc được |
| Impact | Thấp–Trung bình: lúng túng trong 60 s; không hỏng luồng |
| Evidence và confidence / limitations | Chỉ thấy trạng thái đang đếm; trạng thái 0 s chưa thấy. Độ tin cậy trung bình. |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-12 (thuộc US2, màn dùng chung): hiện rõ "Gửi lại mã sau 45s" hoặc nút Gửi lại mờ kèm đồng hồ như US2 AC4 — UX quyết. QA (US4): `[US4_38]` ĐO & GHI giao diện trước/sau 60 s; đối chiếu US2 AC4 ở story US2. |
| Traceability | BR5 `US4:51` · US2 AC4 `US2:59`, AC5 `US2:60`, BR3 `US2:46` · `[US4_38]` `[US4_15]` |
| Open questions / quyết định cần Product · BA · UX | UX / BA US2: "Chưa nhận được mã?" có bấm được không; sau 0 s hiện gì (chuyển QA đọc frame US2 khi có quyền Figma) |

### CX-18 — Màn 04: helper đòi 4 loại ký tự, khác quy định BA — rủi ro trong phạm vi Q-26 (cổng đóng)

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-18 |
| Review scope | Màn 04 — helper dưới ô Mật khẩu mới · **phạm vi BR3/AC9 đang đóng cổng (Q-26)** |
| Source evidence | Ảnh Figma `1754:6840`: helper "**Mật khẩu phải có từ 8–16 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt**"; ô 1 giá trị mẫu "Nguyenvana@1" (đủ 4 loại), ô 2 "nguyenvana1" (không có hoa, không ký tự đặc biệt) · 02 mục 3 Q-01 BA `[ĐÃ XÁC NHẬN]`: 8–16 ký tự, ≥1 chữ và ≥1 số, ký tự khác cho phép · `EPIC:147` "8-16 ký tự gồm chữ và số" · 02 mục 3 Q-26 (Hồng chốt trọng yếu 2026-10-16) · 02 frontmatter `closedScope: BR3/AC9 — Q-26` |
| Persona và context | P1 (quen đặt mật khẩu đơn giản — giả thuyết); P2 |
| Customer journey / scenario | J1, J2 bước 04 |
| Observation | `[NGUỒN]` Hai nguồn mâu thuẫn về điều kiện bắt buộc (Figma: đủ 4 loại; BA: chữ + số). `[CX GIẢ THUYẾT]` Hệ quả trải nghiệm tùy bên nào được code: (a) FE hiện helper Figma nhưng BE kiểm theo BA → người dùng bị ép đặt mật khẩu phức tạp hơn cần thiết, khó nhớ, nhưng không bị lỗi; (b) FE/BE kiểm theo Figma, tài liệu/test theo BA → người gõ "gopany123" đúng theo BA vẫn bị lỗi, và nếu câu lỗi (frame `1641:22759`, chưa đọc) không nêu tiêu chí thiếu thì lặp thử–sai trong 10 phút (→ CX-03); (c) FE kiểm theo BA nhưng helper nói 4 loại → helper sai, người dùng mất tin vào hướng dẫn. Mẫu dữ liệu trên frame ("Nguyenvana@1") gợi ý Design đang nghĩ theo 4 loại. **CX không đề xuất expected, không chọn (a)/(b) của Q-26.** |
| Finding type | CX Risk — rủi ro giả định · **không phải Defect**: mâu thuẫn Figma ↔ BA là việc của Debate (Q-26 đã có) |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — requirement phần này đang `❓ Cần chốt: Q-26`; không điền |
| Impact | Cao nếu hai bên kiểm khác nhau; trung bình nếu chỉ là helper sai |
| Evidence và confidence / limitations | Ảnh 1 frame; helper của 2 frame còn lại chỉ biết qua lớp text (cùng câu). Không biết FE/BE đang code theo bên nào. |
| Recommendation | Không có đề xuất nghiệp vụ. Chuyển QA: nhóm `[US4_19]` → `[US4_29]` giữ `❓ Cần chốt: Q-26` (đã làm trong `04`); khi Q-26 chốt, thêm kiểm "helper màn 04 khớp quy định đã chốt" và "lỗi không đạt nêu tiêu chí thiếu" (nối CX-04). |
| Traceability | BR3 `US4:49` · AC9 `US4:72` · Q-26 (trọng yếu), Q-01, Q-01b · 02 mục 4 #19 · `[US4_19]` → `[US4_29]` `❓ Cần chốt: Q-26` |
| Open questions / quyết định cần Product · BA · UX | **Debate Q-26 (đã có, trọng yếu)** — BA Chình · Hường · Chiến · Design Hiếu |

### CX-19 — Email OTP "Đặt lại mật khẩu": placeholder hỗ trợ, không có tiêu đề thư

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-19 |
| Review scope | Email OTP quên mật khẩu (kênh email) |
| Source evidence | Ảnh Figma `figma/EMAIL_1872-4430_otp-datlai-mk.png` (frame `1872:4430`): tiêu đề trong thân "Đặt lại mật khẩu"; "Xin chào huongmt@gopany.com,"; đoạn giải thích; khung mã 6 số; "Mã có hiệu lực trong **5 phút** và chỉ dùng được một lần."; khung vàng cảnh báo không chia sẻ; "Nếu bạn không yêu cầu đặt lại mật khẩu, hãy bỏ qua email này. Mật khẩu hiện tại của bạn không thay đổi."; chân thư "Cần hỗ trợ? Liên hệ **[email hỗ trợ] · [hotline]**" · tên frame "Đăng ký bằng email (US6)" (nhầm) · `US2:38` mẫu 23–25 "không có nút/liên kết, **tiêu đề chứa mã** (AC3)" · 02 mục 4 #26 (5 phút — khớp) |
| Persona và context | P2 (mở thư trên điện thoại/tab khác, cần lấy mã nhanh) |
| Customer journey / scenario | J2 bước 03 (ngoài app) |
| Observation | `[NGUỒN]` Nội dung chính rõ, không có liên kết (đúng `US4:18` ngoài phạm vi link đặt lại; đúng mẫu US2), thời hạn 5 phút khớp Q-11, câu "mật khẩu hiện tại không thay đổi" tốt cho người không yêu cầu. Ba điểm chưa xong: (1) "[email hỗ trợ] · [hotline]" là placeholder — nếu lọt ra thư thật, người cần hỗ trợ không có kênh; (2) design không thể hiện **tiêu đề (subject)** thư, trong khi US2 mẫu ghi "tiêu đề chứa mã" — người dùng đọc mã từ thông báo đẩy/preview phụ thuộc subject; (3) tên frame nhầm US6 — nội bộ, không ảnh hưởng khách nhưng dễ ghép nhầm template khi code. `[CX GIẢ THUYẾT]` cho (1), (2). |
| Finding type | Usability Issue — **không phải Defect** (design chưa hoàn thiện, chưa có thư thật) |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — không có thư thật để quan sát |
| Impact | Thấp với luồng chính; trung bình cho người cần hỗ trợ nếu placeholder lọt ra |
| Evidence và confidence / limitations | Ảnh design đầy đủ thân thư; subject không nằm trong frame nên "không có" chỉ nghĩa là không thấy trên design. |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-11: Design/Product điền kênh hỗ trợ thật; bổ sung subject vào design hoặc tài liệu. QA: `[US4_11]` thêm bước ĐO & GHI subject có chứa mã (theo US2 AC3) và chân thư không còn ngoặc vuông. |
| Traceability | BR1 `US4:47` · AC4 `US4:65` · US2 mẫu 23 `US2:38`, US2 AC3 · `[US4_11]` |
| Open questions / quyết định cần Product · BA · UX | Product: kênh hỗ trợ chính thức; BA US2: subject chuẩn |

### CX-20 — Thông báo thành công AC10 chưa có design

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-20 |
| Review scope | Chuyển màn 04 → 01 sau khi Lưu thành công |
| Source evidence | Lớp text 10 frame US4 (`figma/lop-text-figma-2026-10-16.txt`): **không có frame nào** chứa "Đổi mật khẩu thành công" hay màn 01 kèm thông báo · ảnh màn 01 chung `1634:21845` (mục US3): không có vùng thông báo · `US4:73` AC10 "Thông báo \"Đổi mật khẩu thành công. Vui lòng đăng nhập lại.\" → màn đăng nhập" · `US4:50` BR4 không tự đăng nhập · 02 mục 4 #16 · 02 mục 3 Q-27 (hình thức thông báo AC10 chưa biết) · đối chiếu: US6 có frame riêng "Đăng ký thành công" `1641:50321` (màn kết quả đầy đủ) |
| Persona và context | P1, P2; P7 (vừa qua gián đoạn, không chắc thao tác đã xong) |
| Customer journey / scenario | J1, J2 bước cuối; J4 |
| Observation | `[NGUỒN]` Design chưa có trạng thái thành công của US4, trong khi US6 có màn thành công riêng. `[CX GIẢ THUYẾT]` Nếu thông báo là toast ngắn hoặc không có, người dùng về màn 01 — trông **y hệt lúc bắt đầu** (ô trống, nút mờ) — không chắc mật khẩu đã đổi; có thể thử lại mật khẩu cũ (fail theo AC11) rồi nghi app lỗi, hoặc làm lại luồng (tiêu thêm 1 mã/ngày). Đây là điểm "biết thành công" quan trọng nhất của hành trình. |
| Finding type | CX Risk — rủi ro giả định (design thiếu, chưa quan sát sản phẩm) |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — có nguyên văn AC10 nhưng không có quan sát / design để đối chiếu |
| Impact | Trung bình: không biết thành công; gọi hỗ trợ; tiêu hạn mức OTP |
| Evidence và confidence / limitations | Dựa trên danh sách 10 frame US4 + 3 frame US3 đã bóc; có thể tồn tại frame ở mục khác chưa bóc — ghi là "chưa thấy", không phải "không có". |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-13: Design bổ sung trạng thái thành công (hình thức do UX; gợi ý thông báo tồn tại đủ lâu / cần người dùng đóng). Không đổi AC10. QA: `[US4_30]` `[US4_31]` giữ expected nguyên văn AC10, thêm ĐO & GHI hình thức và thời gian hiển thị. |
| Traceability | AC10 `US4:73` · BR4 `US4:50` · Q-27 · 02 mục 4 #16, #17 · `[US4_30]` `[US4_31]` `[US4_74]` |
| Open questions / quyết định cần Product · BA · UX | Design Hiếu: frame thành công US4; BA: hình thức thông báo (Q-27) |

## 6. Đề xuất cải thiện (luồng riêng — không phải requirement)

Tất cả là `[ĐỀ XUẤT THAY ĐỔI]`; không dùng làm expected result cho tới khi người có thẩm quyền quyết định và tài liệu BA được cập nhật.

| ID | Đề xuất | Lý do | Cần ai quyết định | Trạng thái |
| --- | --- | --- | --- | --- |
| CP-01 | Màn 02: nêu rõ SĐT cần có Zalo để nhận mã (câu chữ do UX) | CX-01 — người không dùng Zalo biết trước khi bấm | Product (Hường) + UX | Đề xuất — chưa ai quyết |
| CP-02 | Màn 03: gợi ý trung tính "Kiểm tra lại số/email đã dùng khi đăng ký" + làm nổi "Đổi số"/"Đổi email" (không lộ tồn tại) | CX-02 — lối thoát cho người nhớ nhầm định danh | Product + UX (US2, màn dùng chung) | Đề xuất — chưa ai quyết |
| CP-03 | Khi hết 10 phút: một dòng giải thích ở màn 02 và/hoặc đếm ngược ở màn 04 | CX-03 — tránh nghi app lỗi; người dùng đã verify nên không lộ tồn tại | BA Chình / Product | Đề xuất — chồng lên Q-09 đang mở |
| CP-04 | Màn 04: câu mô tả trung tính "đăng nhập bằng email hoặc SĐT đã xác thực của bạn" | CX-05 | UX | Đề xuất — chưa ai quyết |
| CP-05 | Màn 01 sau khi đổi xong: điền sẵn định danh vừa dùng (vẫn không tự đăng nhập) | CX-06 | Product | Đề xuất — chưa ai quyết |
| CP-06 | Thiết bị bị đăng xuất hiện lý do "Mật khẩu đã được thay đổi…" | CX-07 | BA / BE Chiến | Đề xuất — chưa ai quyết |
| CP-07 | Màn 03 kênh Zalo: gợi ý "Mở Zalo để xem tin nhắn từ Gopany" | CX-10 | Product + UX (US2) | Đề xuất — chưa ai quyết |
| CP-08 | Ô OTP nhận dán chuỗi 6 số | CX-11 | FE Hoàng / UX (US2) | Đề xuất — chưa ai quyết |
| CP-09 | Thông tin tài khoản: lối "Đặt mật khẩu" cho tài khoản Google trỏ sang luồng US4 | CX-13 | Product (US5/US9) | Đề xuất — ngoài phạm vi US4 |
| CP-10 | Màn 04: sửa chính tả câu lỗi không khớp; chốt một nguyên văn duy nhất với AC9 | CX-14 — khả năng đọc, nhất quán tài liệu ↔ design | Design Hiếu + BA Chình (Q-27) | Đề xuất 2026-10-16 — chờ Q-27 |
| CP-11 | Email OTP: thay "[email hỗ trợ] · [hotline]" bằng kênh thật; bổ sung subject vào design/tài liệu | CX-19 | Product (Hường) + Design | Đề xuất 2026-10-16 |
| CP-12 | Màn 03 khi đang đếm: hiện rõ hành động sắp có ("Gửi lại mã sau 45s" hoặc nút Gửi lại mờ như US2 AC4) | CX-17 — biết hành động tiếp theo | UX + BA US2 (màn dùng chung) | Đề xuất 2026-10-16 |
| CP-13 | Bổ sung design trạng thái thành công sau Lưu mật khẩu (AC10), đủ lâu để đọc | CX-20 — biết thành công | Design Hiếu + Product | Đề xuất 2026-10-16 — chồng Q-27 |
| — | CP-04 (câu màn 04) giữ nguyên; bằng chứng nay là Figma thật. Recommendation cũ của CX-04 về helper "8–16, 1 chữ 1 số" **thu hồi** vì quy định đang tranh chấp (Q-26) | CX-04, CX-05, CX-18 | — | Ghi chú 2026-10-16 |

## 7. Chuyển cho QA / quay lại Debate

| # | Nội dung | Chuyển đi đâu (QA xác minh / Debate — câu hỏi về cách hiểu tài liệu) | Nguồn |
| ---: | --- | --- | --- |
| 1 | AC6 khi gửi lỗi thật: người dùng thấy gì để vừa không lộ tồn tại vừa đúng AC6; "kênh còn lại" với tài khoản chỉ có SĐT — kèm tác động CX ở CX-08 | **Debate** — Q-03b (đang mở); CX không chọn cách hiểu | `US4:67`, `US4:48`; CX-08 |
| 2 | AC16 ghi "thông báo và điều hướng như AC15" nhưng BA trả lời Q-09 "không hiển thị thông báo"; màn 04 có đếm ngược không | **Debate** — bổ sung vào Q-09 | `US4:81`; 02 mục 3 Q-09; CX-03 |
| 3 | Quay lại từ màn 04 về màn 03: màn 03 hiện trạng thái gì sau khi đã verify; hành động nào đưa về 04; Gửi lại ở đó có đổi mốc 10 phút không | **Debate** — câu hỏi cách hiểu, nối Q-12 và `01` mục 8 #8 | `US4:30`, `US4:55`; CX-12 |
| 4 | Thiết bị bị đăng xuất hiện thông báo gì; nội dung đang nhập dở còn/mất | **QA xác minh** — ĐO & GHI (tài liệu không nói, không phải câu hỏi cách hiểu); đề xuất case nhóm B | `US4:74`; CX-07 |
| 5 | Từ màn 03 với định danh không tồn tại, bấm "Đổi số/Đổi email" → 02 → định danh đúng → nhận mã; bộ đếm định danh đúng độc lập | **QA xác minh** — đề xuất case nhóm B | `US4:66`; 02 mục 4 #4, #18; CX-02 |
| 6 | Về màn 02 do hết hạn rồi Tiếp tục khi bộ đếm gửi đã chạm giới hạn → hành vi theo `US2:61` | **QA xác minh** — đề xuất case nhóm B (chờ Q-11 con số) | 02 mục 4 #13; CX-03 |
| 7 | Helper text màn 04 khớp quy định đã chốt Q-01; thông báo AC9 phần không đạt nêu tiêu chí thiếu | **QA xác minh** — ĐO & GHI, chờ Q-01b | wireframe màn 04; CX-04 |
| 8 | Màn 03 → chuyển sang Zalo/email rồi quay lại (ra nền) → còn ở màn 03; mô phỏng OS tắt app ở màn 03/04 → theo AC17 "tắt hẳn"; dán mã vào ô OTP; web mở hộp thư ở tab khác | **QA xác minh** — đề xuất case nhóm B | `US4:82`; CX-11 |
| 9 | iOS: màn 03 với định danh không tồn tại, bấm Đổi số / Quay lại / back nhiều lần → không lộ Đăng ký | **QA xác minh** — bổ sung vào nhóm iOS đã có ở 02 mục 10 | `BUG10:35`; CX-09 |
| 10 | Sau khi app bị tắt, mở lại từ màn 02 trong lúc mã OTP cũ còn hạn → Tiếp tục gửi mã mới hay nhận mã cũ | **QA xác minh** — ĐO & GHI (tài liệu không nói) | `US4:82`, `US2:45`; CX-11 |
| 11 | Helper màn 04 trên Figma đòi 4 loại ký tự ≠ BA Q-01; giá trị mẫu trên frame ("Nguyenvana@1") theo hướng 4 loại | **Debate — Q-26 (đã có, trọng yếu, cổng đóng BR3/AC9)**; CX không đề xuất expected. QA: nhóm `[US4_19]` → `[US4_29]` giữ `❓ Cần chốt: Q-26` | `FIGMA 1754:6840`; CX-18 |
| 12 | Nguyên văn lỗi không khớp: Figma "Mật khẩu không khớp vui lòng nhập lạ" (sai chính tả) vs AC9 "Mật khẩu xác nhận không khớp." | **Debate — Q-27 (đã có)**: nguyên văn theo tài liệu hay Figma. QA: `[US4_23]` ghi chú Q-27 | `US4:72`; `FIGMA 1754:6840`; CX-14 |
| 13 | Màn 04 không có nút Quay lại trên Figma (3 frame) vs wireframe + BA Q-12 "về màn 03"; back hệ thống / gesture về đâu, có bị chặn không | **Debate — Q-12 (mở lại) / Q-27 (đã có)**; Q-18 phụ thuộc kết quả. QA: `[US4_55]` `[US4_61]` tạm treo | `US4:30`, `US4:55`; CX-15, CX-12 |
| 14 | Màn 03 email không có gợi ý Spam (AC4, US2 AC2) | **Debate — Q-28 (đã có)**. QA: `[US4_08]` giữ expected AC4, ghi chú Q-28 | `US4:65`; `FIGMA 1774:7086`; CX-16 |
| 15 | Màn 03 khi đang đếm không có nút "Gửi lại mã" (US2 AC4 nói nút mờ + "Gửi lại mã sau 00:59"); "Chưa nhận được mã?" có bấm được không; sau 0 s hiện gì | **QA xác minh** — `[US4_38]` ĐO & GHI trước/sau 60 s; đọc frame "yêu cầu gửi lại khi hết chờ" ở mục US2 khi có quyền Figma; đối chiếu US2 AC4 thuộc story US2 | `US2:59-60`; `FIGMA 1774:7086`; CX-17 |
| 16 | Email OTP: subject có chứa mã không (US2 mẫu 23 / AC3); chân thư còn "[email hỗ trợ] · [hotline]" | **QA xác minh** — `[US4_11]` thêm bước ĐO & GHI subject và chân thư | `US2:38`; `FIGMA 1872:4430`; CX-19 |
| 17 | Thông báo AC10 chưa có design: hình thức (toast / banner / popup), thời gian hiển thị, có cần đóng không | **QA xác minh** — `[US4_30]` `[US4_31]` ĐO & GHI hình thức; nguyên văn vẫn theo AC10 (Q-27 chỉ hỏi hình thức) | `US4:73`; lớp text Figma; CX-20 |
| 18 | Màn 04 trên frame `1754:6840` vẽ hai ô **hiện rõ chữ** mật khẩu ("Nguyenvana@1", "nguyenvana1") kèm biểu tượng mắt — không rõ đây là trạng thái "Hiện" đang bật hay mặc định; trạng thái che mặc định chưa có frame đọc được | **QA xác minh** — `[US4_18]` ĐO & GHI trạng thái mặc định che/hiện và biểu tượng mắt đổi theo trạng thái (BR3 "mỗi ô có nút Hiện") | `US4:49`; `FIGMA 1754:6840` |
| 19 | 8 frame US4 chưa xem được ảnh (màn 02 ×3, màn 03 Zalo ×2, màn 04 "Chưa nhập đầy đủ" / "Mật khẩu không hợp lệ", màn 03 email `1774:7189`) và 8 frame lỗi OTP mục US2 | **QA / Orchestrator** — khi Figma MCP có quyền lại: đọc ảnh, đối chiếu AC2/AC13 (màn 02), AC14 và lỗi không đạt quy định (màn 04), US2 AC3–AC8 (màn 03); CX sẽ bổ sung finding nếu có | `01` mục 4b dòng cuối |

## 8. Tự rà soát

- [x] Mỗi finding có loại, persona, bằng chứng nguồn, mức bằng chứng, giới hạn
- [x] Không Defect nào thiếu bằng chứng thực tế (không có Defect ở lượt này)
- [x] Không câu nào nói đã thao tác / đã thấy khi chỉ phân tích tài liệu — mọi nhận định gắn `[CX GIẢ THUYẾT]`
- [x] Persona giả thuyết đã đánh dấu (P5, P7; phần giả thuyết của P6, P8 ghi rõ)
- [x] Đề xuất cải thiện tách ở mục 6, nhãn `[ĐỀ XUẤT THAY ĐỔI]`, không lẫn vào requirement
- [x] Không sửa requirement / BR / AC; không chọn cách hiểu cho Q-03b, Q-09, Q-12 và các điểm mở khác
- [x] Số đếm (2026-10-16): 20 finding (0 Defect / 11 Usability / 8 CX Risk / 1 Improvement), 8 persona, 8 hành trình, 13 CP, 19 mục chuyển — đếm lại từ nội dung
- [x] Figma: không câu nào nói "đã thấy trên sản phẩm"; điều thấy trên Figma ghi là ảnh design / lớp text; 8 frame chưa xem ảnh không suy đoán nội dung ô nhập / nút / lỗi
- [x] Phạm vi cổng đóng BR3/AC9 (Q-26): CX-18 chỉ ghi rủi ro, không đề xuất expected, không chọn cách hiểu; recommendation cũ của CX-04 về helper đã thu hồi
- [x] Mâu thuẫn Figma ↔ tài liệu / BA (Q-12, Q-26, Q-27, Q-28) đưa về Debate, không phân loại Defect

## Lịch sử cập nhật

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
| 2026-10-15 | AI (CX Reviewer) — người dùng Hồng | Tạo file S6: Mode 1 + Mode 3 từ US4, wireframe, user flow, 02 (gate open); 13 finding (0 Defect · 6 Usability · 6 CX Risk · 1 Improvement), 9 CP, 3 điểm quay lại Debate (Q-03b, Q-09 bổ sung, trạng thái màn 03 khi quay lại từ 04), 7 mục chuyển QA |
| 2026-10-16 | AI (CX Reviewer) — Hồng gửi Figma giao diện thật | Cập nhật theo Figma (ảnh 2/10 frame US4 + email mẫu + màn 01; lớp text 10 frame): sửa header/mục 1/giới hạn (không còn "không có Figma"); rà 13 finding cũ — giữ 12, CX-04 thu hẹp (helper đã có nhưng khác BA → CX-18/Q-26), CX-12 đổi tiền đề (không có nút Quay lại); thêm CX-14 → CX-20 (5 Usability · 2 CX Risk); cột Trace trỏ ID case `04`; thêm CP-10 → CP-13; mục 7 thêm #11–#19 (Debate: Q-26, Q-27, Q-12, Q-28 đã có; QA: 15–19). Không Defect; phạm vi BR3/AC9 (cổng đóng) chỉ ghi rủi ro |
