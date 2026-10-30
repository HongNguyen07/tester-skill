---
featureId: EPIC-SDT-US9
title: "[EPIC-SĐT] US9 – Đăng ký & đăng nhập bằng Google"
analyzedAt: 2026-10-16
analyst: Requirement Analyst (AI) — người dùng: Hồng (QA)
---

# Requirement Analysis — EPIC-SDT-US9: Đăng ký & đăng nhập bằng Google

Viết tắt tham chiếu (tất cả nằm trong
`tailieu/Signup] Đăng ký, đăng nhập bằng số điện thoại & hạn mức ChatGoni-export.markdown/`):

| Viết tắt | Tệp |
| --- | --- |
| `US9` | `00  [EPIC].../09  [EPIC-SĐT] US9 – Đăng ký & đăng nhập bằng Google.md` |
| `EPIC` | `00  [EPIC][Login%2FSignup] Đăng ký, đăng nhập bằng số điện thoại & hạn mức ChatGoni.md` |
| `US1` / `US3` / `US4` / `US5` / `US6` / `US7` | file `01 … US1`, `03 … US3`, `04 … US4`, `05 … US5`, `06 … US6`, `07 … US7` cùng thư mục với US9 |
| `BUG10` | `10  [BUG][iOS][Login] App iOS vào được màn đăng ký qua Quên mật khẩu → back.md` |
| `US4-AS` | `wiki/qa/features/EPIC-SDT-US4/02-alignment-summary.md` — câu trả lời BA đã có cho tài khoản Google (đặt mật khẩu, đăng xuất mọi thiết bị) |
| `US6-AS` | `wiki/qa/features/EPIC-SDT-US6/02-alignment-summary.md` — Q-01 (email được mời), Q-16 (gợi ý Đăng nhập cho tài khoản Google), mục 4 dòng 8 (iOS mọi đường) |
| `FIGMA` | Figma "Gopany v1.1", trang "↳ Mobile app" (`https://www.figma.com/design/aPKF4iF1YI2FPUwvdrz56V/Gopany-v1.1?node-id=1609-4700`) — Hồng gửi 2026-10-16; **khác** file "Wireframe master" ở `EPIC:88`. Dẫn theo id frame, vd `FIGMA 1754:6840`. Ảnh và lớp text đã lưu trong `figma/` cùng thư mục |

Số sau dấu `:` là số dòng.

## 1. Nguồn và phạm vi đã đọc

| # | Tệp | Version ghi trong tệp | Phạm vi đã đọc | Ghi chú |
| ---: | --- | --- | --- | --- |
| 1 | `US9` | Không ghi version; không có changelog | Toàn bộ (78 dòng) + ảnh user flow (`US9:23`) + ảnh wireframe (`US9:30`) | Nguồn chính. Nội dung trùng khớp tài liệu Hồng đính kèm khi gọi `/qa-flow` |
| 2 | `EPIC` | Trạng thái "KHỞI TẠO"; changelog tới 13/10/2026 | §2 (28, 31), §3 (52, 59), §4 (76, 78), §6 (96–99, 104, 108, 115, 127), §7 (136), §8 (#2 145, #10 153, #11 154, #12 155, #19 162), §11 (194), §13 (206, 216, 219) | Quy tắc chung; câu hỏi mở #10, #11, #12, #19 liên quan trực tiếp US9 |
| 3 | `US3` | — | §3 (15, 17), §5 (36), BR1–BR3 (42–44), AC1–AC9 (51–61) | Màn 01 dùng chung; AC8 "Đăng nhập Google vẫn hoạt động như cũ" |
| 4 | `US4` | — | BR1, BR2, BR4, BR6–BR8 (47–54), AC5, AC8, AC10, AC11 (66, 70, 73, 74) | Luồng Quên mật khẩu mà AC9 của US9 dẫn tới |
| 5 | `US5` | — | §1 (7–8), §3 (18), §5 (39), BR1–BR5, BR7, BR8 (50–57), AC2, AC4–AC6 (66, 69–71), §8 (88–89) | Thông tin tài khoản (AC8); câu hỏi mở về tài khoản Google thêm SĐT |
| 6 | `US7` | — | §1 (8), §3 (17), BR1–BR3, BR6 (49–51, 54), AC1–AC5, AC9 (61–66, 72), §8 (83) | Hạn mức thấp cho tài khoản Google (AC7) |
| 7 | `US1` | — | §5 (32), BR1 (45), AC1–AC2 (56–57), AC10 (68) | Màn 05a có nút Google; đối chiếu màn thành công / nút "Bắt đầu sử dụng" |
| 8 | `US6` | — | §3 (17), §5 (33) | Màn 11 có nút Google; hành vi thuộc US9 |
| 9 | `BUG10` | — | §1 (7), §5 (28) | iOS không có đường vào đăng ký |
| 10 | `US4-AS` | updatedAt 2026-10-15 | Mục 3 Q-04, Q-05; mục 4 dòng 21, 22 | BA đã chốt: tài khoản Google đặt được mật khẩu qua Quên mật khẩu; đổi mật khẩu đăng xuất cả phiên Google — **tái dùng, không hỏi lại** |
| 11 | `US6-AS` | updatedAt 2026-10-16 | Mục 3 Q-01, Q-16; mục 4 dòng 8, 15 | Email được mời (Hồng tự chọn, chưa có BA); gợi ý Đăng nhập cho tài khoản Google |
| 12 | `FIGMA` — toàn trang "↳ Mobile app" quét theo tên lớp; đọc kỹ màn 01 (`1634:21845`, mục US3) và màn 11 (`1641:50276`, mục US6) | Figma không ghi version | Ảnh 2 frame (lưu `figma/`) + lớp text; quét chữ "Google" trên tên lớp toàn trang — đọc 2026-10-16 | Giao diện thật (`US9:33`). Figma MCP chạm giới hạn gói Starter nên không mở thêm frame. Trang **không có** màn 21, màn chọn tài khoản Google, màn lỗi AC10 → không giúp đóng Q-01→Q-05. Nội dung trích ở mục 6d |
| 13 | `TB` = `tailieu/…/00  [EPIC]…/bang-noi-dung-thong-bao.md` | Không ghi version; **xuất hiện 2026-10-16 17:12** (sau khi S3 xong) | Toàn bộ (63 dòng) — đọc khi tổng hợp S9 | Bảng nội dung thông báo dùng chung. Chạm US9: `TB:19` (sai thông tin đăng nhập, khác `US3:56`), `TB:43` (lỗi dùng chung — có thể là AC10), `TB:24`, `TB:41` (quy định mật khẩu có chữ hoa, chữ thường, số, ký tự đặc biệt — khác BA US4 Q-01). Không có dòng nào cho Google / US9. → 02 Q-26, Q-09, Q-27 |

Chưa đọc / ngoài phạm vi: US2 (OTP — luồng Google không có OTP, `US9:45`; chỉ chạm ở AC9 qua US4); US8 (admin hạn mức);
`tailieu/7-send-ma-otp.md`, `8-verify-ma-otp.md` (API OTP Zalo, không dùng cho Google). Figma "Wireframe master" (`EPIC:88`) không có trong `tailieu/`; Figma giao diện thật (`FIGMA`) Hồng gửi 2026-10-16, đã đọc phần liên quan US9 (dòng 12, mục 6d). Hai ảnh wireframe đã xem, nội dung trích ở mục 4 và 6c.

## 2. Mục tiêu và phạm vi feature `[NGUỒN]`

- Giữ nút Google đang có trên cả 3 nền tảng; bổ sung quy tắc cho tài khoản mới, trùng email, iOS, mật khẩu và hạn mức ChatGoni
  (`US9:3`, `US9:7-8`).
- Người dùng có tài khoản Google "đăng ký và đăng nhập Gopany bằng Google chỉ với một chạm, không phải nhớ thêm mật khẩu" (`US9:13`).
- Trong phạm vi: đăng ký bằng Google (Android, Web); đăng nhập bằng Google (mọi nền tảng); gộp tài khoản trùng email; trạng thái xác
  thực và hạn mức ChatGoni cho tài khoản Google. Trên mobile: dùng màn chọn tài khoản Google của hệ điều hành (Google Sign-In),
  không mở trang web (`US9:17`).
- Ngoài phạm vi: Sign in with Apple · đăng nhập Facebook/Zalo · hủy liên kết Google khỏi tài khoản (`US9:19`).
- Lý do iOS khác biệt: iOS không có đăng ký trong app; nếu Google tự tạo tài khoản trên iOS thì thành đăng ký trong app (rủi ro Apple,
  guideline 4.8) (`US9:9`, `EPIC:31`).
- Nền tảng Android, iOS, Web · Wireframe 01, 05a/11, 21 · 10 AC · Priority High (`US9:3`).

## 3. Actor, precondition, trigger

| Mục | Nội dung | Nguồn | Nhãn |
| --- | --- | --- | --- |
| Actor | Người dùng có tài khoản Google | `US9:13` | `[NGUỒN]` |
| Precondition (mobile) | Có màn chọn tài khoản Google của hệ điều hành (Google Sign-In) — tức thiết bị có tài khoản Google chọn được | `US9:17` | `[NGUỒN]` |
| Precondition (web) | Tài liệu không mô tả cách chọn tài khoản Google trên web | — | `[DIỄN GIẢI AI]` — mục 8 #1 |
| Trigger 1 | Màn 01 Đăng nhập: bấm "Đăng nhập bằng Google" (mọi nền tảng) | `US9:37`, `US9:59` | `[NGUỒN]` |
| Trigger 2 | Màn 05a / 11 Đăng ký: bấm "Tiếp tục với Google" (Android, Web) | `US9:38`, `US9:60` | `[NGUỒN]` |
| Post-condition (email chưa có tài khoản, Android/Web) | Tài khoản mới: họ tên từ Google, email "Đã xác thực", không có mật khẩu, chưa có SĐT; workspace (nếu chưa có); vào ChatGoni chat ngay ở hạn mức thấp | `US9:45`, `US9:47`, `US9:49-50`, `US9:62` | `[NGUỒN]` |
| Post-condition (email đã có tài khoản, mọi nền tảng) | Đăng nhập vào đúng tài khoản đó, đúng workspace; không tạo tài khoản thứ hai | `US9:46`, `US9:63` | `[NGUỒN]` |
| Post-condition (iOS, email chưa có tài khoản) | Không tạo tài khoản; báo lỗi ở màn 21 | `US9:48`, `US9:64` | `[NGUỒN]` — BR4 còn ghi "Đề xuất" |

## 4. Use case và luồng

| Mã | Tên | Main flow | Alternate flow | Exception flow | Nguồn |
| --- | --- | --- | --- | --- | --- |
| UC-01 | Đăng ký bằng Google (Android, Web) | (1) Màn 01 bấm "Đăng nhập bằng Google" **hoặc** màn 05a/11 bấm "Tiếp tục với Google" → (2) màn chọn tài khoản Google → chọn tài khoản → (3) hệ thống kiểm "Email Google đã có tài khoản Gopany?" (BR2) → Chưa → nền tảng Android/Web → (4) tạo tài khoản: email "Đã xác thực" không OTP (BR1), họ tên từ Google (BR3), không giới hạn IP (BR8) → (5) tạo workspace (nếu chưa có) → (6) ChatGoni chat ngay (AC3) | AF-1 hủy ở màn chọn tài khoản → quay lại màn trước, không báo lỗi (AC6) | E-1 Google lỗi, mất mạng → báo lỗi tiếng Việt, cho thử lại, gợi ý đăng nhập email/SĐT (AC10) | `US9:45-47`, `US9:52`, `US9:62`, `US9:65`, `US9:71`; user flow `US9:23` |
| UC-02 | Đăng nhập bằng Google (mọi nền tảng) | (1)–(3) như UC-01 → email Google trùng email của tài khoản đã có (đăng ký email, form cũ, được mời) → đăng nhập vào đúng tài khoản đó, đúng workspace; không tạo tài khoản thứ hai (BR2, AC4) | AF-1 hủy (AC6) | E-1 (AC10) | `US9:46`, `US9:63`, `US9:65`, `US9:71`; user flow `US9:23` |
| UC-03 | iOS, email Google chưa có tài khoản | (1)–(3) như UC-01 trên iOS → Chưa có tài khoản → **không tạo tài khoản**; màn 21 báo "Tài khoản chưa tồn tại. Vui lòng đăng ký trên web hoặc ứng dụng Android." (BR4, AC5) | — | — | `US9:48`, `US9:64`, `US9:39`; wireframe màn 21 `US9:30` |
| UC-04 | Sau khi vào app — tài khoản Google chưa có SĐT | (a) Mở ChatGoni → hạn mức thấp, Pro có khóa, popup xác thực theo US7 (BR5, AC7) · (b) Mở Thông tin tài khoản → email "Đã xác thực" gắn Google, không có nút Đổi; SĐT "Chưa có" với nút Thêm (BR7, AC8) | — | — | `US9:49`, `US9:51`, `US9:67-68` |
| UC-05 | Quên mật khẩu bằng email Google | Màn Quên mật khẩu (US4) nhập email Google → nhận OTP qua email → đặt mật khẩu mới → đăng nhập được bằng email + mật khẩu **và vẫn dùng Google được** (BR6, AC9) | — | — | `US9:50`, `US9:69`, `US4:52` |

Thứ tự rẽ nhánh theo user flow (`US9:23`): màn chọn tài khoản Google → [Hủy → AC6] / [Google lỗi, mất mạng → AC10] / [Chọn tài
khoản → "Email Google đã có tài khoản Gopany? BR2" → Có (mọi nền tảng) → AC4 · Chưa → "Nền tảng?" → iOS → màn 21 AC5/BR4 ·
Android/Web → tạo tài khoản BR1/BR3/BR8 → tạo workspace (nếu chưa có) → ChatGoni AC3] → "Đã xác thực SĐT?" → Chưa → hạn mức
thấp AC7/BR5 · Rồi → hạn mức cao + Pro. Khung cuối: AC8/BR7, AC9/BR6. `[NGUỒN]` ảnh user flow.

Khác với US1/US6: luồng Google **không có** bước OTP, bước tạo mật khẩu, màn "Đăng ký thành công" và nút "Bắt đầu sử dụng" — user
flow đi thẳng từ "Tạo tài khoản" sang "Tạo workspace (nếu chưa có) → ChatGoni" (`US9:23`, `US9:62`; đối chiếu `US1:68`). `[NGUỒN]`
ảnh user flow — mục 8 #3, mục 9 #6.

## 5. Business rule

### 5a. BR của US9 (mã gốc)

| Mã | Nội dung (sát nguyên văn) | Loại | Nguồn | Nhãn |
| --- | --- | --- | --- | --- |
| BR1 | Email Google được tính là **email đã xác thực**, không cần OTP. | dữ liệu / nghiệp vụ | `US9:45` | `[NGUỒN]` |
| BR2 | Email Google trùng email của tài khoản đã có (đăng ký email, form cũ, được mời) → **đăng nhập vào tài khoản đó**, không tạo tài khoản mới. | nghiệp vụ / dữ liệu | `US9:46` | `[NGUỒN]` — phần "được mời" → mục 9 #2 |
| BR3 | Android, Web: email Google chưa có tài khoản → tạo tài khoản mới; họ tên lấy từ Google (sửa được trong Thông tin tài khoản). | nghiệp vụ / dữ liệu | `US9:47` | `[NGUỒN]` |
| BR4 | iOS: email Google chưa có tài khoản → **không tạo tài khoản**, báo hướng dẫn đăng ký trên web/Android. *(Đề xuất – chờ chốt câu hỏi mở #10)* | nghiệp vụ / nền tảng | `US9:48`, `EPIC:153` (#10 trống, anh Vương chốt) | `[NGUỒN]` là **đề xuất**, chưa chốt → mục 9 #1 |
| BR5 | Tài khoản Google chưa có SĐT → ChatGoni hạn mức thấp, không dùng được Pro cho đến khi thêm SĐT (US7). | nghiệp vụ | `US9:49` | `[NGUỒN]` |
| BR6 | Tài khoản tạo bằng Google không có mật khẩu; muốn đăng nhập bằng email/SĐT + mật khẩu thì đặt mật khẩu qua Quên mật khẩu. *(Đề xuất – câu hỏi mở #11)* | nghiệp vụ / bảo mật | `US9:50`, `EPIC:154` (#11 trống); `US4:52` ghi như đã chốt | `[ĐÃ XÁC NHẬN]` — BA đã chốt "có" ở US4 Q-04 (2026-10-15, Hồng chuyển); US9 và Epic #11 **chưa cập nhật** → mục 9 #5 |
| BR7 | Email gắn với Google không đổi được trong Thông tin tài khoản; vẫn thêm SĐT bình thường. *(Đề xuất – câu hỏi mở #12)* | nghiệp vụ | `US9:51`, `US9:77` (đã chốt), `EPIC:155` (#12 đã chốt), `US5:56` | `[NGUỒN]` phần không đổi email (đã chốt 12/10); phần "thêm SĐT bình thường" → mục 9 #4 |
| BR8 | Đăng ký bằng Google không giới hạn IP. | nghiệp vụ | `US9:52` | `[NGUỒN]` |

### 5b. Quy tắc chung từ Epic và story liên quan áp vào US9 (mã QA tự đánh `E-xx`)

| Mã | Nội dung (sát nguyên văn) | Nguồn | Nhãn |
| --- | --- | --- | --- |
| E-01 | Mỗi SĐT và mỗi email chỉ gắn với **một** tài khoản. | `EPIC:96` | `[NGUỒN]` |
| E-02 | Email so khớp không phân biệt hoa/thường. | `EPIC:97` | `[NGUỒN]` — áp cho so khớp email Google với tài khoản đã có (mục 8 #9) |
| E-03 | SĐT/email chỉ được lưu vào tài khoản **sau khi xác thực** (OTP, **hoặc email Google**). Không có trạng thái "Chưa xác thực": mỗi SĐT/email là "Chưa có" hoặc "Đã xác thực". | `EPIC:98`, `US5:51` | `[NGUỒN]` |
| E-04 | Tài khoản luôn phải còn ít nhất một email hoặc SĐT đã xác thực. | `EPIC:99`, `US5:54` | `[NGUỒN]` |
| E-05 | Họ tên tự tạo = SĐT hoặc email đăng ký (**Google: lấy tên Google**); sửa trong Thông tin tài khoản. | `EPIC:104` | `[NGUỒN]` |
| E-06 | iOS: không có bất kỳ đường nào vào màn đăng ký; không có đăng ký tài khoản trong app (theo hướng Apple đã duyệt). | `EPIC:31`, `EPIC:108`, `BUG10:7`, `BUG10:28`, `US3:53` | `[NGUỒN]` |
| E-07 | Google (US9): Android/Web: lần đầu bấm Google → tạo tài khoản (email Google = đã xác thực, họ tên lấy từ Google) → ChatGoni. iOS: Google chỉ đăng nhập tài khoản đã có. | `EPIC:78` | `[NGUỒN]` — Epic viết như đã chốt, US9 BR4 ghi "Đề xuất" (mục 9 #1) |
| E-08 | Epic #19: "Phần đăng nhập Google có hai cách triển khai: Mở google chọn gmail FE có thể triển khai luôn / Mở hệ điều hành chọn gmail, cần đến BE" → Kết quả: **"Mở google chọn gmail"**. | `EPIC:162` | `[NGUỒN]` — có thể lệch với `US9:17` "màn chọn tài khoản Google của hệ điều hành, không mở trang web" → mục 9 #3 |
| E-09 | Epic #2 (còn mở): giải pháp Keycloak … cách cấp token an toàn cho màn đăng nhập riêng trong app và **đăng nhập Google trong app**. | `EPIC:145` | `[NGUỒN]` — kỹ thuật, ảnh hưởng môi trường test mobile (mục 9 #14) |
| E-10 | Chưa xác thực SĐT (tài khoản chưa có SĐT): hạn mức thấp (mặc định 3 câu/5 giờ), không dùng được Pro. "Chưa xác thực SĐT" = tài khoản chưa có SĐT (đăng ký email, **Google**). | `EPIC:127`, `US7:50`, `US7:54` | `[NGUỒN]` |
| E-11 | ChatGoni: đăng ký xong / đăng nhập lần đầu → chat được ngay, **không có popup**; hiện "Hạn mức 5 giờ: X% đã dùng · làm mới lúc HH:MM"; chưa xác thực → link "Xác thực SĐT để nâng hạn mức"; Pro có biểu tượng khóa + "Pro cần xác thực số điện thoại"; chọn Pro khi chưa xác thực → popup (17). | `US7:61-66`, `US7:72` | `[NGUỒN]` — dùng để đọc AC7 (mục 8 #7) |
| E-12 | Thông tin tài khoản: Email "Đã xác thực" (không có nút Đổi) hoặc "Chưa có" (nút Thêm); SĐT "Đã xác thực" (nút Đổi) hoặc "Chưa có" (nút Thêm). Thêm/đổi SĐT: **nhập mật khẩu hiện tại**, rồi OTP Zalo. Tạm thời không cho đổi email với mọi tài khoản (đăng ký email, Google, tài khoản cũ). | `US5:66`, `US5:52`, `US5:69`, `US5:56` | `[NGUỒN]` |
| E-13 | US5 câu hỏi mở: "Tài khoản tạo bằng Google chưa đặt mật khẩu thì thêm SĐT thế nào (màn 09 yêu cầu mật khẩu hiện tại)? Đề xuất: bỏ bước mật khẩu với tài khoản Google, hoặc yêu cầu đặt mật khẩu trước qua Quên mật khẩu. – Hường chốt." Luồng xác thực SĐT ở ChatGoni (18) **không hỏi mật khẩu** (US7 câu hỏi mở). | `US5:88`, `US7:83` | `[NGUỒN]` là câu hỏi mở — chạm BR7 "vẫn thêm SĐT bình thường" (mục 9 #4) |
| E-14 | Quên mật khẩu: SĐT/email đã gắn tài khoản mới nhận OTP; thông báo luôn giống nhau dù tồn tại hay không; đổi thành công → mật khẩu cũ hết hiệu lực, **đăng xuất mọi thiết bị**, về màn đăng nhập (không tự đăng nhập); tài khoản tạo bằng Google cũng đặt được mật khẩu qua luồng này bằng email Google; kết quả xác thực OTP hiệu lực 10 phút. | `US4:48`, `US4:50`, `US4:52-54`, `US4:73` | `[NGUỒN]` |
| E-15 | BA đã chốt (US4 Q-05): "đăng xuất mọi thiết bị" gồm **phiên đăng nhập bằng Google** và phiên "Lưu đăng nhập"; thiết bị khác về màn đăng nhập ở **lần gọi API kế tiếp**. Sau khi đặt mật khẩu, bấm "Đăng nhập bằng Google" lại vẫn vào bình thường (US4 mục 4 dòng 21). | `US4-AS` Q-05, mục 4 dòng 21–22 | `[ĐÃ XÁC NHẬN]` (BA, 2026-10-15, Hồng chuyển ở phiên US4 — tài liệu chưa cập nhật) |
| E-16 | Màn đăng nhập (01): 1 ô "Email hoặc số điện thoại", mật khẩu, Lưu đăng nhập, Quên mật khẩu, **Đăng nhập bằng Google**, link Đăng ký (ẩn trên iOS). Đăng nhập Google, đăng nhập email hiện tại **vẫn hoạt động như cũ** (US3 AC8). Thông báo lỗi đăng nhập không tiết lộ email/SĐT có tồn tại hay không. | `US3:36`, `US3:51-53`, `US3:59`, `US3:44`, `EPIC:115` | `[NGUỒN]` |
| E-17 | Màn đăng ký 05a (US1) / 11 (US6) có nút "Tiếp tục với Google" — hành vi xem US9. Ngoài IP VN: màn đăng ký chỉ còn đăng ký bằng Email (US1 AC2). | `US1:32`, `US6:33`, `US1:57` | `[NGUỒN]` — nút Google ngoài VN: mục 9 #16 |
| E-18 | DoD: luồng email/Google hiện tại không bị ảnh hưởng; thiết bị test 2 iOS, 2 Android, web Chrome/Safari. Release cần Apple/Google duyệt; App Review Notes cập nhật. | `EPIC:194`, `EPIC:59`, `EPIC:176` | `[NGUỒN]` |
| E-19 | Kiểm tra dữ liệu 2 lớp: FE kiểm tại ô, BE kiểm lại toàn bộ + quy tắc nghiệp vụ, trả mã lỗi (13/10, Hường). | `EPIC:206` | `[NGUỒN]` — US9 không có cột mã lỗi (mục 9 #14) |
| E-20 | Epic changelog 09/10: thêm US9 (gộp tài khoản trùng email, iOS chỉ đăng nhập tài khoản đã có); wireframe thêm màn 21, nút Google ở màn đăng ký. | `EPIC:216`, `EPIC:219` | `[NGUỒN]` |
| E-21 | Tài khoản hiện hữu: hiện chỉ đăng ký/đăng nhập được bằng email hoặc Google; form đăng ký email cũ **không xác thực** email/SĐT. | `EPIC:28` | `[NGUỒN]` — tài khoản form cũ có email chưa qua xác thực nào (mục 9 #18) |
| E-22 | Email được mời vào workspace: US6 Q-01 (email được mời nhưng chưa đăng ký) — Hồng tự chọn (c) "được đăng ký; vẫn tạo workspace mới" `[GIẢ ĐỊNH]`, BA chưa trả lời. | `US6-AS` Q-01, mục 4 dòng 15 | `[GIẢ ĐỊNH]` của US6 — US9 BR2 liệt kê "được mời" là tài khoản đã có (mục 9 #2) |

Mã do QA tự đánh: E-01 → E-22 (vị trí gốc ghi ở cột Nguồn). BR1–BR8, AC1–AC10 là mã gốc của `US9`.

## 6. Acceptance criteria, mã lỗi, thông báo, giới hạn số

### 6a. AC của US9 (nguyên văn)

| Mã | Tình huống | Kết quả mong đợi | Nguồn |
| --- | --- | --- | --- |
| AC1 | Màn đăng nhập (mọi nền tảng) | Có nút "Đăng nhập bằng Google" như hiện tại | `US9:59` |
| AC2 | Màn đăng ký (Android, Web) | Có nút "Tiếp tục với Google" | `US9:60` |
| AC3 | Android/Web, email Google chưa có tài khoản | Tạo tài khoản, họ tên từ Google → (tạo workspace nếu chưa có) → ChatGoni chat ngay | `US9:62` |
| AC4 | Email Google đã có tài khoản (mọi nền tảng) | Đăng nhập vào đúng tài khoản đó, đúng workspace; không tạo tài khoản thứ hai | `US9:63` |
| AC5 | iOS, email Google chưa có tài khoản | Không tạo tài khoản; báo "Tài khoản chưa tồn tại. Vui lòng đăng ký trên web hoặc ứng dụng Android." | `US9:64` |
| AC6 | Hủy giữa chừng ở màn chọn tài khoản Google | Quay lại màn trước, không báo lỗi | `US9:65` |
| AC7 | Tài khoản Google chưa có SĐT mở ChatGoni | Hạn mức thấp, Pro có khóa, popup xác thực theo US7 | `US9:67` |
| AC8 | Mở Thông tin tài khoản | Email hiện "Đã xác thực" (gắn Google, không có nút Đổi); SĐT hiện "Chưa có" với nút Thêm | `US9:68` |
| AC9 | Quên mật khẩu bằng email Google | Nhận OTP qua email, đặt mật khẩu mới; đặt xong đăng nhập được bằng email + mật khẩu và vẫn dùng Google được | `US9:69` |
| AC10 | Google lỗi, mất mạng | Báo lỗi tiếng Việt, cho thử lại; gợi ý đăng nhập bằng email/SĐT | `US9:71` |

Ghi chú tài liệu: "AC5 cần có trước lần submit iOS tiếp theo" (`US9:78`).

### 6b. Thông báo, giới hạn số, mã lỗi

| Mục | Nguyên văn | Nguồn | Ghi chú |
| --- | --- | --- | --- |
| Thông báo iOS (AC5) | "Tài khoản chưa tồn tại. Vui lòng đăng ký trên web hoặc ứng dụng Android." | `US9:64`; wireframe màn 21 `US9:30` | Nguyên văn duy nhất trong US9; BR4 còn "Đề xuất" |
| Thông báo AC10 (Google lỗi, mất mạng) | Không có nguyên văn; chỉ "tiếng Việt, cho thử lại; gợi ý đăng nhập bằng email/SĐT" | `US9:71` | → mục 9 #9 |
| Nhãn Thông tin tài khoản (AC8) | "Đã xác thực" (email, không nút Đổi); "Chưa có" + nút Thêm (SĐT) | `US9:68`, `US5:66` | — |
| Tên nút | "Đăng nhập bằng Google" (màn 01); "Tiếp tục với Google" (màn 05a/11) | `US9:37-38`, `US9:59-60` | — |
| Hạn mức thấp | Mặc định 3 câu/5 giờ; chỉnh trong Admin (US8) | `EPIC:127`, `US7:49-50` | Thuộc US7/US8 |
| Hiệu lực xác thực OTP quên mật khẩu | 10 phút | `US4:53` | Thuộc US4 (AC9) |
| Mã lỗi BE | Không có | `EPIC:206` nói BE trả mã lỗi | → mục 9 #14 |

### 6c. Nội dung chỉ có trên wireframe (`US9:30`) — "tham khảo luồng, giao diện thật theo Figma" (`US9:33`)

| Màn | Nội dung trên wireframe | Nhãn |
| --- | --- | --- |
| 01 · Đăng nhập (mọi nền tảng) | Logo Gopany; "Đăng nhập – Chào mừng bạn đến với Gopany"; ô "Email hoặc số điện thoại"; ô "Mật khẩu" + Hiện; "Lưu đăng nhập" (đã tick); "Quên mật khẩu?"; nút "Đăng nhập"; "Hoặc"; nút "Đăng nhập bằng Google" (biểu tượng G); "Chưa có tài khoản? Đăng ký" + nhãn "Chỉ Android · Web — ẩn trên iOS" | `[NGUỒN]` wireframe — chỉ tham khảo |
| 05a / 11 · Đăng ký (Android, Web) | "Quay lại"; "Bước 1/3"; "Đăng ký – Tạo tài khoản Gopany bằng số điện thoại"; tab "Số điện thoại / Email"; ô +84 + "Nhập số điện thoại"; "Mã xác thực sẽ gửi qua Zalo của số này."; nút "Gửi mã xác thực"; "Hoặc"; nút "Tiếp tục với Google"; khung "Báo lỗi ngay ở bước này …"; "Bằng việc đăng ký, bạn đồng ý với Điều khoản và Chính sách bảo mật."; "Đã có tài khoản? Đăng nhập" | `[NGUỒN]` wireframe — nội dung tab thuộc US1/US6 |
| 21 · iOS: email chưa có tài khoản | Màn đăng nhập (giống 01, **không có** dòng "Chưa có tài khoản? Đăng ký") với khung lỗi đỏ phía trên ô nhập: "Tài khoản chưa tồn tại. Vui lòng đăng ký trên web hoặc ứng dụng Android."; ghi chú "Chỉ trên iOS (US9 BR4): Bấm Google với email chưa có tài khoản → không tạo tài khoản mới, ở lại màn đăng nhập với thông báo trên. Không có link Đăng ký. Email Google đã có tài khoản → đăng nhập bình thường. Android/Web: tạo tài khoản mới → ChatGoni (màn 15)." | `[NGUỒN]` wireframe — "ở lại màn đăng nhập" chỉ có ở wireframe, AC5 không nói màn nào |
| Khung "Quy tắc chính" | "Email Google = email đã xác thực, không cần OTP. Trùng email tài khoản đã có → đăng nhập vào tài khoản đó. Android/Web: chưa có tài khoản → tạo mới, tên lấy từ Google → ChatGoni. iOS: chưa có tài khoản → không tạo mới (màn 21)." · "Sau khi vào app: Chưa xác thực SĐT → ChatGoni hạn mức thấp, Pro khóa (US7)." | `[NGUỒN]` wireframe — trùng BR1–BR5 |

### 6d. Nội dung trên Figma giao diện thật (`FIGMA`, đọc 2026-10-16)

| Màn | Frame | Nội dung đọc được trên Figma | So với tài liệu / cách hiểu đã chốt | Nhãn |
| --- | --- | --- | --- | --- |
| 01 · Đăng nhập | `1634:21845` (ảnh `figma/US3_1634-21845_dangnhap.png`) · `1725:10310` · `1725:10598` (chưa xem ảnh; frame sau có lỗi tạm khóa của US3 "Đăng nhập đang tạm bị khóa. Vui lòng thử lại sau [thời gian]. vô hiệu hóa nút đăng nhập") | Logo; "Đăng nhập"; "Chào mừng bạn đến với Gopany"; ô "Nhập email hoặc số điện thoại"; ô "Nhập mật khẩu" + mắt; "Lưu đăng nhập" tick sẵn; "Quên mật khẩu?"; nút "Đăng nhập" mờ khi trống; "Hoặc"; nút **"Đăng nhập bằng Google"** (logo G); "Chưa có tài khoản? Đăng ký" | Khớp AC1 nhãn nút (`US9:59`). Figma **không có** frame riêng cho iOS (bản ẩn "Đăng ký") | `[NGUỒN]` Figma |
| 05a / 11 · Đăng ký | `1609:12528` (US1, tab SĐT — chưa xem ảnh, có lớp "Action and Sign in with Google") · `1641:50276` (US6, tab Email — ảnh `figma/US6_1641-50276_nhap-email.png`) | Tab "Số điện thoại" / "Email"; dưới nút "Gửi mã xác thực" là "Hoặc" + nút **"Tiếp tục với Google"** — có ở cả frame tab SĐT (theo lớp text) lẫn frame tab Email (ảnh) | Khớp AC2 nhãn nút (`US9:60`). Trả lời phần "nút ở cả hai tab" của `02 §4` dòng 16: **có ở cả hai** (theo design) | `[NGUỒN]` Figma |
| Không có trên Figma | Quét tên lớp toàn trang: chữ "Google" chỉ xuất hiện ở nút của màn 01 / 05a / 11 (13 instance "Action and Sign in with Google") | — | Không có màn 21 (iOS "Tài khoản chưa tồn tại…"), màn chọn tài khoản Google (Q-03), màn lỗi AC10 (Q-09), Thông tin tài khoản của tài khoản Google (Q-04), màn thành công / họ tên lấy từ Google (Q-05) → Figma **không giúp** đóng Q-01→Q-05 | `[NGUỒN]` Figma (quét tên lớp) |

Wireframe **không vẽ** màn chọn tài khoản Google, màn lỗi AC10, trạng thái sau khi Hủy (AC6), màn Thông tin tài khoản của tài khoản
Google (AC8). `[NGUỒN]` (thiếu trên ảnh).

## 7. Trạng thái và chuyển trạng thái

Tài liệu không định nghĩa máy trạng thái. Trạng thái dữ liệu có trong nguồn:

| Đối tượng | Trạng thái | Chuyển | Nguồn | Nhãn |
| --- | --- | --- | --- | --- |
| Tài khoản (Android/Web, email Google mới) | Chưa tồn tại → tồn tại | Ngay khi chọn tài khoản Google ở màn chọn (không có bước OTP / mật khẩu / màn thành công) | `US9:47`, `US9:62`, user flow `US9:23` | `[NGUỒN]` — thời điểm chính xác: mục 9 #6 |
| Tài khoản (iOS, email Google mới) | Chưa tồn tại → **vẫn chưa tồn tại** | Màn 21 báo lỗi | `US9:48`, `US9:64` | `[NGUỒN]` (BR4 đề xuất) |
| Email trên tài khoản Google | "Đã xác thực" ngay khi tạo; không đổi được | — | `US9:45`, `US9:51`, `US9:68`, `EPIC:98` | `[NGUỒN]` |
| SĐT trên tài khoản Google mới | "Chưa có" → "Đã xác thực" khi thêm SĐT (US5 màn 09 hoặc US7 màn 18) | Thêm SĐT | `US9:49`, `US9:68`, `US7:54`, `US5:55` | `[NGUỒN]` — đường thêm qua US5 cần mật khẩu: mục 9 #4 |
| Mật khẩu của tài khoản Google | Không có → có (qua Quên mật khẩu) | AC9 | `US9:50`, `US9:69`, `US4:52` | `[ĐÃ XÁC NHẬN]` (US4 Q-04) |
| Hạn mức ChatGoni | Thấp (chưa có SĐT) → cao + Pro (đã có SĐT) | Thêm SĐT | `US9:49`, `US7:50-51`, user flow `US9:23` | `[NGUỒN]` |
| Liên kết Google với tài khoản | Có; không hủy được (ngoài phạm vi) | — | `US9:19` | `[NGUỒN]` |
| Phiên đăng nhập Google | Đang đăng nhập → bị đăng xuất khi đổi mật khẩu (ở lần gọi API kế tiếp) | US4 BR4 | `US4:50`; `US4-AS` Q-05 | `[ĐÃ XÁC NHẬN]` |

## 8. Diễn giải, giả định, QA observation

| # | Nội dung | Nhãn | Liên quan tới |
| ---: | --- | --- | --- |
| 1 | `US9:17` chỉ nói mobile dùng màn chọn tài khoản Google của hệ điều hành; web không mô tả → đọc là web mở cửa sổ/popup chọn tài khoản Google như hiện tại ("như hiện tại", AC1). Epic #19 trả lời "Mở google chọn gmail" (`EPIC:162`) có thể là cách khác với `US9:17` trên mobile. | `[DIỄN GIẢI AI]` | AC1, AC6, AC10 → mục 9 #3 |
| 2 | AC1 "như hiện tại" + US3 AC8 "vẫn hoạt động như cũ" (`US3:59`) → phần hiển thị nút là regression; phần hành vi sau khi bấm mới là US9. | `[DIỄN GIẢI AI]` | AC1 |
| 3 | AC3 đọc theo user flow: tạo tài khoản → tạo workspace → ChatGoni **tự động**, không có màn "Đăng ký thành công", không có nút "Bắt đầu sử dụng" như US1 AC10 (`US1:68`) / US6 màn 14. Tài liệu không nói rõ có màn trung gian hay không. | `[DIỄN GIẢI AI]` | AC3 → mục 9 #6 |
| 4 | "Họ tên lấy từ Google" (BR3): đọc là tên hiển thị của tài khoản Google. Tài liệu không nói lấy trường nào, xử lý tên trống / quá dài / ký tự đặc biệt thế nào; US5 BR1 họ tên "không để trống" (`US5:50`). | `[DIỄN GIẢI AI]` + `[QA BỔ SUNG]` (biên) | BR3 → mục 9 #11 |
| 5 | BR2 liệt kê "đăng ký email, form cũ, được mời"; tài khoản **đăng ký bằng SĐT rồi thêm email ở US5** (`US5:57`) cũng có email đã xác thực → đọc là cũng thuộc "tài khoản đã có". Tài khoản **tạo bằng Google trước Epic** cũng vậy (đăng nhập lại). | `[DIỄN GIẢI AI]` | BR2, AC4 |
| 6 | AC4 "đúng workspace": tài liệu không định nghĩa (US3 AC4 cũng chỉ ghi "đúng workspace", `US3:55`). Tài khoản thuộc nhiều workspace hoặc chưa có workspace nào → vào đâu, tài liệu không nói. "Tạo workspace (nếu chưa có)" chỉ ghi ở AC3. | `[DIỄN GIẢI AI]` | AC4 → mục 9 #7 |
| 7 | AC7 "popup xác thực theo US7": US7 AC1 nói vào lần đầu **không có popup** (`US7:61`); popup chỉ hiện khi chọn Pro (`US7:66`) hoặc hết 100% (`US7:68`). Đọc AC7 là "popup xuất hiện theo điều kiện của US7", không phải hiện ngay khi mở ChatGoni. | `[DIỄN GIẢI AI]` | AC7, BR5 → mục 9 #8 |
| 8 | AC6 "màn trước" = màn 01 hoặc màn 05a/11 tùy nơi bấm nút; trên web là đóng cửa sổ chọn tài khoản Google. | `[DIỄN GIẢI AI]` | AC6 → mục 9 #10 |
| 9 | So khớp email Google với tài khoản đã có **không phân biệt hoa/thường** (`EPIC:97`): email Google `NguyenVanA@gmail.com` và tài khoản `nguyenvana@gmail.com` là một → AC4. Đã chốt cùng nguyên tắc ở US6 Q-15 (theo tài liệu). Không hỏi lại. | `[NGUỒN]` `EPIC:97` | BR2, AC4 |
| 10 | AC9 đi trọn luồng US4 với email Google: thông báo không tiết lộ tồn tại (`US4:48`), OTP hiệu lực 10 phút (`US4:53`), đổi xong đăng xuất mọi thiết bị kể cả phiên Google ở lần gọi API kế tiếp (E-15), về màn đăng nhập không tự đăng nhập (`US4:50`). Sau đó: đăng nhập email + mật khẩu (US3) **và** Google đều vào cùng tài khoản. Chi tiết luồng US4 không viết lại ở US9, chỉ dẫn chiếu. | `[NGUỒN]` + `[ĐÃ XÁC NHẬN]` E-15 | AC9, BR6 |
| 11 | AC10 "gợi ý đăng nhập bằng email/SĐT": với tài khoản **chỉ có Google** (chưa đặt mật khẩu, BR6) gợi ý này không dùng được → ghi để CX. Cách dựng "Google lỗi" (tắt mạng trước / sau khi chọn tài khoản; Google trả lỗi) là phương pháp QA. | `[QA BỔ SUNG]` | AC10 → mục 9 #9 |
| 12 | BR8 "không giới hạn IP": Google từ IP ngoài VN hoặc không xác định IP vẫn tạo tài khoản (Android/Web). Màn 05a ngoài VN chỉ còn Email (`US1:57`) — nút "Tiếp tục với Google" có còn không, tài liệu không nói. | `[DIỄN GIẢI AI]` | BR8, AC2 → mục 9 #16 |
| 13 | BR1 áp cho **mọi** email Google (gmail.com, Google Workspace tên miền riêng, email chưa được Google xác minh)? Tài liệu chỉ nói "email Google". | `[QA BỔ SUNG]` | BR1 → mục 9 #13 |
| 14 | Tài khoản form cũ có email **chưa qua xác thực** (E-21). Sau khi đăng nhập Google bằng email đó (AC4), Thông tin tài khoản hiện email "Đã xác thực"? E-03 nói không có trạng thái "Chưa xác thực" nhưng không nói dữ liệu cũ được coi thế nào. | `[DIỄN GIẢI AI]` | AC4, AC8 → mục 9 #18 |
| 15 | "Lưu đăng nhập" ở màn 01 (wireframe tick sẵn) có áp cho đăng nhập Google không — tài liệu không nói. Phiên Google có bị tạm khóa khi tài khoản bị khóa do sai mật khẩu (US3 BR2) không — không nói. | `[QA BỔ SUNG]` | AC4, AC9 → mục 9 #15, #17 |
| 16 | Android: thiết bị không có tài khoản Google nào / không có Google Play Services → màn chọn tài khoản hiện gì; tài liệu không nói — xếp vào nhóm AC10 "Google lỗi" khi debate. | `[QA BỔ SUNG]` | AC10 → mục 9 #19 |
| 17 | iOS AC5: wireframe màn 21 vẽ thông báo **trên màn đăng nhập**, "ở lại màn đăng nhập"; AC5 chữ không nói màn nào; sau thông báo nút Google vẫn bấm lại được (wireframe còn nút). | `[NGUỒN]` wireframe / `[DIỄN GIẢI AI]` | AC5 → mục 9 #20 |
| 18 | Hai lớp (E-19): gọi thẳng API đăng nhập Google với token của email đã có tài khoản → không tạo tài khoản thứ hai (BR2/E-01); iOS gọi API với email mới → BE không tạo (nếu BR4 chốt). Cách kiểm bằng công cụ là phương pháp QA. | `[QA BỔ SUNG]` trên `[NGUỒN]` `EPIC:206`, `US9:46`, `US9:48` | BR2, BR4 |
| 19 | Regression (E-18, E-16): người dùng Google **hiện hữu** (tạo trước Epic) vẫn đăng nhập được, vào đúng workspace cũ; nút Google ở màn 01 cả 3 nền tảng; link "Đăng ký" ẩn trên iOS. | `[NGUỒN]` phạm vi regression | AC1, AC4 |
| 20 | Epic #2 (Keycloak, token cho đăng nhập Google trong app) còn mở → môi trường mobile có sẵn luồng Google trong app hay không là precondition; không phải câu hỏi nghiệp vụ. | `[NGUỒN]` `EPIC:145` | mục 9 #14 |

## 9. Điểm chưa rõ (chuyển sang Debate)

| # | Loại | Trích dẫn + nguồn | Vì sao chưa rõ | Đề xuất mức |
| ---: | --- | --- | --- | --- |
| 1 | chưa chốt / mâu thuẫn trạng thái | BR4 "*(Đề xuất – chờ chốt câu hỏi mở #10)*" (`US9:48`); AC5 viết như đã chốt (`US9:64`); `US9:78` "AC5 cần có trước lần submit iOS tiếp theo"; Epic #10 trống, anh Vương chốt (`EPIC:153`); `EPIC:78` viết "iOS: Google chỉ đăng nhập tài khoản đã có" như đã chốt | Nếu #10 chốt "cho tạo mới" thì AC5 đảo ngược và iOS đi theo AC3. Hiện BR4 là đề xuất nhưng AC5, wireframe màn 21, Epic §4 đều viết như quyết định | **Trọng yếu** — đổi kết quả AC5 (tạo / không tạo tài khoản trên iOS) |
| 2 | nhiều cách hiểu / thiếu | BR2 "tài khoản đã có (đăng ký email, form cũ, **được mời**) → đăng nhập vào tài khoản đó" (`US9:46`); `US5:8` "hiện chỉ mời bằng email"; US6 Q-01 (email được mời chưa đăng ký — BA chưa trả lời, Hồng tạm chọn "được đăng ký, vẫn tạo workspace mới") | Email **được mời vào workspace nhưng chưa có tài khoản**: bấm Google → "đăng nhập vào tài khoản đó" là tài khoản nào? Tạo tài khoản mới rồi vào workspace đã mời, hay vào workspace mới? Trên **iOS** email này rơi vào AC4 (được vào) hay AC5 (chặn)? | **Trọng yếu** — đổi kết quả AC3/AC4/AC5 và dữ liệu workspace |
| 3 | mâu thuẫn / thiếu | `US9:17` "Trên mobile: dùng màn chọn tài khoản Google của hệ điều hành (Google Sign-In), không mở trang web"; Epic #19 hai cách "Mở google chọn gmail (FE làm luôn)" / "Mở hệ điều hành chọn gmail (cần BE)" → kết quả "Mở google chọn gmail" (`EPIC:162`); Epic #2 còn mở (`EPIC:145`) | "Mở google chọn gmail" là cách nào trong hai cách — có phải là mở trang Google (trái `US9:17`)? Quyết định này đổi màn người dùng thấy trên mobile, cách Hủy (AC6) và lỗi (AC10) hiện ra, và rủi ro Apple | **Trọng yếu** — đổi luồng màn hình mobile, precondition mọi case mobile (AI đề xuất; Hồng có thể hạ nếu coi là kỹ thuật) |
| 4 | mâu thuẫn / chưa chốt | BR7 "vẫn thêm SĐT bình thường" (`US9:51`); US5 BR3 thêm SĐT phải "nhập mật khẩu hiện tại" (`US5:52`, `US5:69`); BR6 tài khoản Google không có mật khẩu (`US9:50`); `US5:88` câu hỏi mở "tài khoản Google chưa đặt mật khẩu thì thêm SĐT thế nào — Hường chốt"; `US7:83` luồng ChatGoni (18) không hỏi mật khẩu | Tài khoản Google chưa đặt mật khẩu bấm "Thêm" SĐT ở Thông tin tài khoản (AC8) → màn 09 đòi mật khẩu hiện tại thì nhập gì? Bỏ bước mật khẩu, bắt đặt mật khẩu trước, hay chỉ thêm được qua ChatGoni (US7)? | **Trọng yếu** — đổi luồng AC8 → thêm SĐT và điều kiện BR5 "cho đến khi thêm SĐT" |
| 5 | tài liệu chưa cập nhật | BR6 "*(Đề xuất – câu hỏi mở #11)*" (`US9:50`); Epic #11 trống (`EPIC:154`); `US4:52` BR6 viết như đã chốt; **BA đã chốt "có"** ở US4 Q-04 (2026-10-15) | Không hỏi lại — chỉ nhắc BA cập nhật US9 BR6 và Epic #11. Ghi để Test Designer dùng nhãn `[ĐÃ XÁC NHẬN]` | Không trọng yếu — đã đóng (tài liệu chưa cập nhật) |
| 6 | thiếu | AC3 "Tạo tài khoản, họ tên từ Google → (tạo workspace nếu chưa có) → ChatGoni chat ngay" (`US9:62`); user flow không có màn thành công (`US9:23`); đối chiếu `US1:68` nút "Bắt đầu sử dụng"; US6 Q-05 (Hồng tạm chọn: tài khoản tạo lúc bấm Đăng ký, workspace tạo khi bấm nút) | Luồng Google có màn "Đăng ký thành công" / nút "Bắt đầu sử dụng" không, hay vào thẳng ChatGoni? Tài khoản và workspace tạo ở thời điểm nào — nếu mất mạng ngay sau khi chọn tài khoản Google thì tài khoản đã tạo chưa (lần sau bấm Google rơi vào AC3 hay AC4)? | **Trọng yếu** — đổi luồng AC3 và dữ liệu tài khoản / workspace (AI đề xuất; cùng loại US6 Q-05 Hồng đã hạ) |
| 7 | thiếu | AC4 "đúng workspace" (`US9:63`); `US3:55` cùng chữ; "tạo workspace (nếu chưa có)" chỉ ở AC3 (`US9:62`) | Tài khoản đã có nhưng **chưa có workspace** (form cũ chưa tạo) hoặc thuộc **nhiều workspace** → sau Google đăng nhập vào đâu? | Không trọng yếu — giống hành vi đăng nhập hiện tại (US3); case ĐO & GHI |
| 8 | dẫn chiếu | AC7 "popup xác thực theo US7" (`US9:67`); US7 AC1 "không có popup" khi vào lần đầu (`US7:61`); popup khi chọn Pro / hết 100% (`US7:66`, `US7:68`) | Mở ChatGoni lần đầu bằng tài khoản Google có popup ngay không — đọc theo US7 là không; AC7 chữ có thể hiểu là có | Không trọng yếu — US7 đã rõ; chốt cách đọc khi debate |
| 9 | thiếu | AC10 (`US9:71`): không nguyên văn; "Google lỗi" và "mất mạng" không tách; gợi ý email/SĐT với tài khoản chỉ có Google (BR6) | Thông báo nguyên văn; lỗi hiện ở màn nào (màn 01/05a hay ngay trong màn chọn tài khoản); "thử lại" là bấm lại nút Google; mất mạng **sau khi** đã chọn tài khoản (request tới BE) → tài khoản tạo chưa (nối #6) | Không trọng yếu — ĐO & GHI (phần "tài khoản tạo chưa" nối #6) |
| 10 | thiếu | AC6 "Quay lại màn trước, không báo lỗi" (`US9:65`) | "Màn trước" = màn 01 hay 05a/11 tùy nơi bấm; web: đóng popup Google; dữ liệu đã gõ ở màn 01 (email/mật khẩu) giữ hay mất | Không trọng yếu — điều hướng / hiển thị |
| 11 | thiếu | BR3 "họ tên lấy từ Google" (`US9:47`); `EPIC:104`; US5 BR1 "không để trống" (`US5:50`) | Lấy trường nào của Google; tài khoản Google không có tên / tên quá dài / ký tự đặc biệt / tên tiếng Việt có dấu → họ tên là gì (rỗng thì trái US5 BR1) | Không trọng yếu — hiển thị; biên là `[QA BỔ SUNG]` ĐO & GHI |
| 12 | thiếu | BR1 "email Google" (`US9:45`) | Email Google thuộc Google Workspace (tên miền riêng), email Google chưa được Google xác minh, tài khoản Google là alias — BR1 áp cho tất cả? | Không trọng yếu — `[QA BỔ SUNG]`; mặc định áp cho mọi email Google trả về |
| 13 | thiếu | `EPIC:206` BE trả mã lỗi; US9 không có cột mã lỗi; Epic #2 Keycloak/token cho Google trong app còn mở (`EPIC:145`) | API đăng nhập Google (web, mobile) và mã lỗi từng AC (AC5, AC10); môi trường mobile có luồng Google trong app khi nào | Không trọng yếu — cột Error Code / precondition môi trường |
| 14 | thiếu | Wireframe màn 01 "Lưu đăng nhập" tick sẵn (`US9:30`); `US3:51`; `US4-AS` Q-05 (phiên Google bị đăng xuất khi đổi mật khẩu) | "Lưu đăng nhập" có áp cho đăng nhập Google không (lần sau mở app có tự vào) | Không trọng yếu — ĐO & GHI |
| 15 | thiếu | `US9:52` BR8; `US1:57` ngoài IP VN chỉ còn đăng ký Email | Màn 05a/11 ngoài IP VN còn nút "Tiếp tục với Google" không | Không trọng yếu — hiển thị; BR8 ngụ ý còn |
| 16 | thiếu | US3 BR2 tạm khóa đăng nhập khi sai mật khẩu (`US3:43`); AC9 (`US9:69`) tài khoản Google đã có mật khẩu | Tài khoản Google đã đặt mật khẩu, bị tạm khóa do sai mật khẩu nhiều lần → đăng nhập bằng Google còn vào được không | Không trọng yếu (đề xuất; chạm bảo mật — Hồng có thể nâng) — `[QA BỔ SUNG]` ĐO & GHI |
| 17 | thiếu | `EPIC:28` form cũ không xác thực email; `EPIC:98` không có trạng thái "Chưa xác thực"; AC8 (`US9:68`) | Tài khoản form cũ (email chưa qua xác thực) đăng nhập Google bằng email đó → Thông tin tài khoản hiện email "Đã xác thực"? Dữ liệu cũ được coi là gì | Không trọng yếu — hiển thị AC8 cho tài khoản cũ; ĐO & GHI |
| 18 | thiếu | AC10 (`US9:71`); `US9:17` màn chọn của hệ điều hành | Android không có tài khoản Google nào trên máy / không có Google Play Services → hiện gì | Không trọng yếu — `[QA BỔ SUNG]` xếp vào AC10 |
| 19 | thiếu / wireframe | AC5 (`US9:64`) không nói màn nào; wireframe màn 21 "ở lại màn đăng nhập với thông báo trên" (`US9:30`) | Thông báo iOS hiện ở màn 01 (banner) hay popup; sau đó bấm Google lại được không; thông báo mất khi nào | Không trọng yếu — hiển thị; wireframe chỉ tham khảo |

## 10. Tự rà soát

- [x] Mọi mã ở mục 4–6 tìm thấy trong nguồn (BR1–BR8 `US9:45-52`; AC1–AC10 `US9:59-71`; E-xx có dòng dẫn, đã kiểm bằng `sed -n`)
- [x] Không mục `[NGUỒN]` nào thiếu tham chiếu
- [x] Mâu thuẫn / khác biệt giữa nguồn đã liệt kê đủ hai phía (BR4 vs AC5/Epic §4; `US9:17` vs Epic #19; BR7 vs US5 BR3; BR6 vs US4 BR6 / US4 Q-04; AC7 vs US7 AC1; AC3 vs US1 AC10)
- [x] Mục 9 không chứa câu trả lời do AI tự chọn
- [x] Số liệu: 8 BR, 22 quy tắc chung, 10 AC, 19 điểm chưa rõ (5 đề xuất trọng yếu: #1, #2, #3, #4, #6; 1 đã đóng: #5; 13 không trọng yếu) — đếm từ bảng

## Lịch sử cập nhật

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
| 2026-10-16 | AI (Requirement Analyst) — người dùng Hồng | Tạo file S3: đọc US9 (toàn bộ + 2 ảnh), Epic, US1, US3–US7, BUG10; tái dùng BA đã trả lời ở US4 (Q-04, Q-05) và trạng thái US6 Q-01/Q-16; 8 BR, E-01→E-22, 10 AC, 19 điểm chưa rõ |
| 2026-10-16 | AI (Orchestrator) — Hồng gửi link Figma giao diện thật | Thêm nguồn #12 `FIGMA` + viết tắt; thêm mục 6d (3 dòng): màn 01, màn 05a/11 khớp nhãn nút AC1/AC2, nút Google ở cả hai tab; trang không có màn 21 / chọn tài khoản / lỗi AC10. Ảnh lưu `figma/` |
| 2026-10-16 | AI (Orchestrator) — sau S6/S7 | Nguồn #13 `TB` (bảng nội dung thông báo, xuất hiện 17:12): 3 chỗ chạm US9, chuyển 02 Q-26, Q-09, Q-27 |
