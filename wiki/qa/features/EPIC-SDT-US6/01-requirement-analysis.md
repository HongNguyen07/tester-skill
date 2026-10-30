---
featureId: EPIC-SDT-US6
title: "[EPIC-SĐT] US6 – Đăng ký bằng email với xác thực OTP"
analyzedAt: 2026-10-15
analyst: Requirement Analyst (AI) — người dùng: Hồng (QA)
---

# Requirement Analysis — EPIC-SDT-US6: Đăng ký bằng email với xác thực OTP

> **Bản hiệu lực từ 2026-10-20:** tệp `US6` trong `tailieu/` là **bản final 19/10/2026** (Hường; mục 10 "Lịch sử thay đổi" của tệp) — 10 BR, 19 AC + AC11a, có mục Dependencies, Open Questions, Lịch sử thay đổi; Hồng đưa export mới vào `tailieu/` ngày 2026-10-20 (đã đồng bộ vào thư mục gốc). Mục 1, 2, 3, 4, 5a, 5b, 6a, 6b, 7 dưới đây **đã viết lại theo bản final**; mục 6c (wireframe), 6d (Figma), 6e (bảng thông báo), 8, 9 là nội dung ngày 15–16/10 theo **bản cũ** (76 dòng, 5 BR, 11 AC) — giữ để đối chiếu, số dòng `US6:NN` trong các mục đó là của bản cũ. **Mục 12** là bảng đối chiếu mã BR/AC cũ ↔ mới và trạng thái từng điểm chưa rõ sau bản final; mục 13 là điểm chưa rõ mới.

Viết tắt tham chiếu (tất cả nằm trong
`tailieu/Signup] Đăng ký, đăng nhập bằng số điện thoại & hạn mức ChatGoni-export.markdown/`):

| Viết tắt | Tệp |
| --- | --- |
| `US6` | `00  [EPIC].../06  [EPIC-SĐT] US6 – Đăng ký bằng email với xác thực OTP.md` |
| `EPIC` | `00  [EPIC][Login%2FSignup] Đăng ký, đăng nhập bằng số điện thoại & hạn mức ChatGoni.md` |
| `US1` / `US2` / `US3` / `US4` / `US5` / `US7` / `US9` | file `01 … US1`, `02 … US2`, `03 … US3`, `04 … US4`, `05 … US5`, `07 … US7`, `09 … US9` cùng thư mục với US6 |
| `BUG10` | `10  [BUG][iOS][Login] App iOS vào được màn đăng ký qua Quên mật khẩu → back.md` |
| `US4-AS` | `wiki/qa/features/EPIC-SDT-US4/02-alignment-summary.md` — câu trả lời BA đã có cho quy tắc dùng chung (mật khẩu, định dạng email, mẫu che) |
| `FIGMA` | Figma "Gopany v1.1", trang "↳ Mobile app" (`https://www.figma.com/design/aPKF4iF1YI2FPUwvdrz56V/Gopany-v1.1?node-id=1609-4700`) — Hồng gửi 2026-10-16; **khác** file "Wireframe master" ở `EPIC:88`. Dẫn theo id frame, vd `FIGMA 1754:6840`. Ảnh và lớp text đã lưu trong `figma/` cùng thư mục |
| `TB` | "Bảng nội dung thông báo" Hồng cung cấp 2026-10-16; từ 2026-10-20 có trong `tailieu/` tại `Chình - [EPIC-SĐT] US6 – …/Bảng nội dung thông báo.md` (cùng nội dung; nằm trong thư mục con của bản nháp Chình — tác giả vẫn chưa ghi). **Bản final đã gộp nội dung thông báo vào cột AC** (`US6:120`) nên `TB` chỉ còn để đối chiếu. Hai bảng: `TB1` (bảng đầu, bản thô: dòng lệch cột, lỗi chính tả, một dòng gạch bỏ) và `TB2` (bảng sau, đủ cột "Cách hiển thị", chỉ có US1 và US6). Dẫn theo màn + tình huống vì file không có số dòng ổn định |

Số sau dấu `:` là số dòng.

## 1. Nguồn và phạm vi đã đọc

Đọc lại toàn bộ ngày 2026-10-20 theo export mới (bản final 19/10/2026). Số dòng dưới đây là của bản final.

| # | Tệp | Version ghi trong tệp | Phạm vi đã đọc | Ghi chú |
| ---: | --- | --- | --- | --- |
| 1 | `US6` | Bản final 19/10/2026 (Hường) — `US6:115-123`; 123 dòng; Trạng thái READY | Toàn bộ; ảnh user flow mới `US6:36` (`uploads/812faa09…/US6-user-flow.png`) chưa xem | Nguồn chính. Thay đổi lớn so với bản 15/10: 10 BR, 19 AC + AC11a; gộp thông báo vào AC; thêm mục 8 Dependencies, 9 Open Questions (2 câu, Chiến), 10 Lịch sử |
| 2 | `Chình - [EPIC-SĐT] US6 – …md` + thư mục con (`Bảng nội dung thông báo.md`, `Nội dung đề xuất US2.md`) | Bản nháp, không đổi so với export cũ | Diff với `US6` | **Không dùng** làm nguồn (Q-14 vẫn đề nghị đánh dấu / xóa) |
| 3 | `EPIC` | Bản final 19/10/2026 — `EPIC:212`; 219 dòng; READY | §2–§3 (23–55), §6 (76–128), §7 (130–139), §8 (141–154), §9 (156–168), §10–§12 (170–204) | Quy tắc chung đã chốt: 10 phút, đăng nhập luôn, hai phiên, tạm hoãn IP VN, mật khẩu (chờ chữ hoa), thông báo dùng chung `EPIC:121-128`; câu hỏi mở #2 (mật khẩu), #6 (ngưỡng chặn ngầm) |
| 4 | `US2` | Bản final 19/10/2026 — `US2:120`; 123 dòng | Toàn bộ | Con số đã chốt: 6 số, 5 phút, 60 giây, 5 mã/24 giờ trượt, sai 5 lần → khóa 30 phút; AC1–AC22 có nguyên văn; mã lỗi 30115 / 30114 |
| 5 | `US1` | Bản final 19/10/2026 | §3 (23–31), §5 màn 05a/05d (46, 49), AC1–AC2 (72–73), AC17 (92), §8 (102) | Tab mặc định SĐT; **tạm hoãn kiểm tra IP VN** (`US1:31`) |
| 6 | `US3` | Bản final 19/10/2026 | §3 (24–31), §5 (47), BR4, BR6, BR7 (56–59), AC1–AC4 (68–72), AC6 (75), AC9–AC13 (78–84) | Dòng "Chưa có tài khoản? Đăng ký" ở màn 01 (`US3:69`); đăng nhập → workspace gần nhất / tạo workspace (`US3:75`) |
| 7 | `US4` | Bản final 19/10/2026 | Không đọc sâu — US6 không còn dẫn chiếu US4 (10 phút nay ghi thẳng ở `US6:58`) | Quy tắc mật khẩu dùng chung đã chuyển lên `EPIC:101` |
| 8 | `US5` | Bản final 19/10/2026 | BR1, BR2, BR6–BR8 (61–68), AC2–AC3 (81–82), AC21, AC23–AC26 (105–111) | Tên tự tạo giữ nguyên email đầy đủ (`US5:61`); email "Đã xác thực" không có bút sửa (`US5:81`, `US5:109`); không cho đổi email (`US5:67`) |
| 9 | `US7` | Bản final 19/10/2026 | BR1–BR10 (58–67), AC1–AC8 (76–84), AC19 (97) | Hạn mức thấp 3 câu/5 giờ, không Pro (`US7:60`); dấu hiệu màn ChatGoni (`US7:76-79`) |
| 10 | `US9` | Bản final 19/10/2026 | BR1–BR8 (56–63), AC2, AC4–AC6, AC8, AC10–AC11 (73–84) | Nút "Tiếp tục với Google" ở màn 11 (`US9:73`); email Google trùng → đăng nhập (`US9:57`, `US9:80`); iOS (`US9:59`, `US9:78`) |
| 11 | `BUG10` | Không đổi | §5 (28), AC3–AC4 (36–37) | iOS không có đường vào đăng ký |
| 12 | `US4-AS` | updatedAt 2026-10-15 | Chỉ để đối chiếu | **Không còn cần tái dùng**: định dạng email, quy định mật khẩu, con số US2 đều đã ghi trong bản final (`US6:56`, `US6:59`, `US2:58-62`) |
| 13 | `FIGMA` — 9 frame US6 + email 1859:3924 | Figma không ghi version | Như đã đọc 2026-10-16 (mục 6d) | Bản final ghi "Giao diện theo Figma final của Hiếu" (`US6:43`) và mô tả màn 11–14 bằng chữ (`US6:45-50`) → **bảng màn trong tài liệu là `[NGUỒN]` chính cho bố cục / câu chữ**, Figma là nguồn hình. Chỗ Figma khác tài liệu (link "Đổi số", thiếu gợi ý Spam, màn 14 "số điện thoại") → theo tài liệu, ghi nhận nếu app theo Figma (mục 12) |
| 14 | `TB` | Không ghi version / tác giả | Đối chiếu | Nội dung đã vào AC của bản final; chữ lỗi mật khẩu trong `TB2` ("…chữ hoa, chữ thường…") **khác** AC15 ("gồm chữ, số và ký tự đặc biệt") — theo AC15 |

Chưa đọc / ngoài phạm vi: US8 (draft); `tailieu/7-send-ma-otp.md`, `8-verify-ma-otp.md` (API OTP Zalo); ảnh user flow mới của US6 và Epic (chưa mở; nhãn AC/BR trên sơ đồ "khớp với mục 6 và 7" theo `US6:39`).

## 2. Mục tiêu và phạm vi feature `[NGUỒN]`

- Thay form đăng ký email cũ (họ tên, email, SĐT, mật khẩu, xác nhận mật khẩu — không xác thực) bằng luồng 3 bước: nhập email → OTP email → tạo mật khẩu → đăng ký thành công (`US6:5`, `US6:13`, `US6:26`).
- Lý do: tài khoản tạo dễ nên có rủi ro spam ChatGoni; email phải được xác thực bằng OTP (`US6:14`). Dùng chung màn OTP (US2) và bước tạo mật khẩu với đăng ký SĐT (US1) (`US6:15`).
- Người dùng mới "đăng ký bằng email qua vài bước ngắn, để bắt đầu nhanh và chắc chắn email của tôi đúng" (`US6:19`).
- Trong phạm vi: tab "Email" trên màn đăng ký (Android, Web) thay form cũ; luồng 3 bước + màn đăng ký thành công; trên mobile là màn riêng trong app, không mở trang web (`US6:25-27`).
- Ngoài phạm vi: đăng ký trên iOS · giới hạn OTP (US2) · đăng ký bằng Google (US9) · **chặn email tạm thời / danh sách chặn email** (`US6:31-32`) — khép Q-18.
- Nền tảng Android, Web · Màn 11–14 · "Số AC: 19" (bảng có 20 dòng vì thêm AC11a ngày 19/10 — `US6:85`, `US6:119`) · Priority High · Trạng thái READY (`US6:5`). Phụ trách: BE Chiến · FE mobile Hiếu · QA Hồng · Design Hiếu · BA Chình (`US6:7`).

## 3. Actor, precondition, trigger

| Mục | Nội dung | Nguồn | Nhãn |
| --- | --- | --- | --- |
| Actor | Người dùng mới, chưa có tài khoản Gopany | `US6:19` | `[NGUỒN]` |
| Precondition | Email hợp lệ theo BR1 và chưa gắn tài khoản nào (BR2) | `US6:56-57`, `EPIC:80`, `EPIC:82` | `[NGUỒN]` |
| Precondition (nền tảng) | Android hoặc Web; không giới hạn IP (BR8; Epic tạm hoãn kiểm tra IP VN) | `US6:25`, `US6:63`, `EPIC:96` | `[NGUỒN]` |
| Trigger | Màn 01 dòng "Chưa có tài khoản? Đăng ký" → màn đăng ký, chọn tab "Email" → màn 11 | `US3:69`, `US6:74` | `[NGUỒN]` |
| Post-condition | Tài khoản tạo với email "Đã xác thực", chưa có SĐT; tên tự tạo = email đầy đủ; **đã đăng nhập** (API trả token); bấm "Bắt đầu sử dụng" → tạo workspace (nếu chưa có) → ChatGoni chat ngay ở hạn mức thấp | `US6:61-62`, `US6:94`, `EPIC:94` | `[NGUỒN]` |

## 4. Use case và luồng

| Mã | Tên | Main flow | Alternate flow | Exception flow | Nguồn |
| --- | --- | --- | --- | --- | --- |
| UC-01 | Đăng ký bằng email (Android, Web) | (1) Màn 11 tab Email, nhập email, bấm "Gửi mã xác thực" (nút mờ khi chưa nhập — AC3; đang tải khi bấm — AC9) → (2) màn 12 (component US2) nhập OTP nhận qua email mẫu 23, bấm "Xác thực" → (3) màn 13 email + nhãn "Đã xác thực", nhập "Nhập mật khẩu" + "Nhập lại mật khẩu", bấm "Đăng ký" (nút mờ khi chưa đủ 2 ô — AC14) → tạo tài khoản **và đăng nhập luôn** → (4) màn 14 "Đăng ký thành công", "Tài khoản của bạn đã được tạo với email …", "Tên hiển thị: …" → bấm "Bắt đầu sử dụng" → tạo workspace (nếu chưa có) → ChatGoni chat ngay ở hạn mức thấp (AC17) | AF-1 email sai định dạng → lỗi dưới ô "Email không đúng định dạng.", không gửi mã (AC4) · AF-2 email đã có tài khoản → hộp thoại [Hủy] [Đăng nhập] (AC6) · AF-3 trong 60 giây quay lại màn 11, gửi lại cùng email → vào thẳng 12 với đếm ngược còn lại (AC10) · AF-4 "Đổi email" ở màn 12 → về màn nhập, giữ giá trị (US2 AC19); đổi quá 3 lần/ngày → lỗi tại ô (AC11a) · AF-5 sai mã / hết hạn / gửi quá nhiều / khóa → theo US2 (AC13) · AF-6 mật khẩu chưa đạt (AC15) / không khớp (AC16) → lỗi dưới ô, chưa tạo tài khoản · AF-7 Back ở màn 13 → về 11 giữ email, xác thực cũ hết hiệu lực (AC18) · AF-8 "Tiếp tục với Google" → US9 | E-1 không gửi được email → "Chưa gửi được mã xác thực. Vui lòng thử lại sau.", ở lại 11 (AC7) · E-2 vượt 5 mã/24 giờ, bị chặn ngầm, hệ thống bận → thông báo theo US2, ở lại 11 (AC8) · E-3 bấm Đăng ký khi (a) quá 10 phút sau OTP (b) người khác vừa đăng ký cùng email (c) mất mạng / lỗi hệ thống (d) đã bỏ ngang / tắt app → không tạo tài khoản, xử lý theo AC19 | `US6:74-97`, user flow `US6:36`, màn `US6:45-50` |
| UC-02 | iOS không có đường vào đăng ký | Dùng app iOS theo mọi đường (back, link trong trang, deep link) → không vào được màn đăng ký | — | — | `US6:75`, `EPIC:97`, `BUG10:28`, `BUG10:36` |

Thứ tự kiểm tra ở bước 1 theo AC: ô trống / khoảng trắng (AC3, FE) → định dạng (AC4, FE + BE) → cắt khoảng trắng, hoa/thường, alias `+` (AC5) → email đã có tài khoản (AC6, BE) → gửi email (lỗi → AC7; giới hạn / chặn ngầm → AC8) → màn 12 (AC11). `[NGUỒN]` `US6:77-87`; ảnh user flow mới chưa xem.

## 5. Business rule

### 5a. BR của US6 (mã gốc)

| Mã | Nội dung (sát nguyên văn) | Loại | Nguồn | Nhãn |
| --- | --- | --- | --- | --- |
| BR1 | **Email hợp lệ:** dạng ten@tenmien.duoi, đúng 1 dấu @, tên miền có dấu chấm, đuôi tối thiểu 2 chữ cái, không khoảng trắng, không dấu tiếng Việt, tối đa 254 ký tự. Khoảng trắng đầu/cuối tự cắt. Cho phép `. _ - +` trước @ (VD a.b+1@gmail.com hợp lệ và **được coi là email khác** với a.b@gmail.com). | validation | `US6:56`, `EPIC:82` | `[NGUỒN]` (khớp `[ĐÃ XÁC NHẬN]` Hường 2026-10-16 — nay tài liệu đã ghi) |
| BR2 | Chỉ email chưa gắn tài khoản nào mới được đăng ký. Kiểm tra trùng **không phân biệt hoa/thường** (ABC@gmail.com = abc@gmail.com). | nghiệp vụ / dữ liệu | `US6:57`, `EPIC:80`, `EPIC:82` | `[NGUỒN]` |
| BR3 | Nhập đúng OTP thì có **10 phút** để tạo mật khẩu. Kết quả xác thực chỉ dùng 1 lần, gắn với phiên đăng ký đó. Quá 10 phút, bỏ ngang hoặc bấm Back thì phải nhận mã mới (tính vào giới hạn 5 mã/24 giờ của US2). | nghiệp vụ / thời hạn | `US6:58`, `EPIC:92` | `[NGUỒN]` — đóng Q-03 |
| BR4 | **Mật khẩu:** 8–16 ký tự, có chữ, có số, có ký tự đặc biệt, không khoảng trắng, không dấu tiếng Việt. Ô "Nhập lại mật khẩu" phải khớp. *(Chờ Chiến xác nhận có bắt buộc chữ hoa + chữ thường không)* | validation | `US6:59`, `EPIC:101`; câu hỏi mở `US6:112`, `EPIC:161` | `[NGUỒN]` phần đã ghi · `[CẦN XÁC NHẬN]` chữ hoa + chữ thường, nới tối đa 64 ký tự (Q-17 thu hẹp) |
| BR5 | Chỉ tạo tài khoản khi đã xác thực OTP, mật khẩu hợp lệ và 2 ô khớp. Không tạo tài khoản dở dang. | nghiệp vụ | `US6:60`, `EPIC:93` | `[NGUỒN]` |
| BR6 | Không nhập họ tên, SĐT. Tên tự tạo = email đăng ký đầy đủ (VD nguyenvana@congty.vn), sửa được trong Thông tin tài khoản (US5). Đăng ký xong thì **đăng nhập luôn** (API trả token). | dữ liệu / luồng | `US6:61`, `EPIC:87`, `EPIC:94`, `US5:61` | `[NGUỒN]` — đóng phần "tài khoản tạo lúc bấm Đăng ký, đã đăng nhập" của Q-05 |
| BR7 | Tài khoản email mới **chưa có SĐT** → ChatGoni ở hạn mức thấp, không dùng Pro cho đến khi thêm SĐT (US5, US7). | nghiệp vụ | `US6:62`, `US7:60`, `US7:63` | `[NGUỒN]` |
| BR8 | Không giới hạn IP. | nghiệp vụ | `US6:63`, `EPIC:96` ("tạm hoãn kiểm tra IP Việt Nam"), `US1:31` | `[NGUỒN]` — đăng ký SĐT cũng không còn chặn IP, nên màn 11 ngoài VN không còn khác IP VN (đóng phần "ngoài VN hiện tab thế nào" của Q-14) |
| BR9 | **Hai phiên cùng đăng ký một email:** không chặn phiên nào; phiên tạo tài khoản trước thì thành công, phiên sau báo email đã được đăng ký. BE dùng mã đăng ký 1 lần + khóa khi tạo + ràng buộc duy nhất trong DB. | nghiệp vụ / concurrency | `US6:64`, `EPIC:95` | `[NGUỒN]` — đóng Q-06 (E-20 cũ) |
| BR10 | Kiểm tra 2 lớp: FE kiểm tra định dạng ngay tại ô; BE kiểm tra lại toàn bộ + quy tắc nghiệp vụ và trả mã lỗi. | kỹ thuật | `US6:65`, `EPIC:128` | `[NGUỒN]` — mã lỗi cụ thể chỉ có 30103 (`US6:97`) |

Đối chiếu mã cũ (bản 15/10): BR1 cũ → BR2; BR2 cũ → BR5 (+ BR3, BR4 tách riêng); BR3 cũ → BR6; BR4 cũ → BR8; BR5 cũ → BR7; BR1, BR9, BR10 mới. Chi tiết ở mục 12.

### 5b. Quy tắc chung từ Epic và story liên quan áp vào US6 (mã QA tự đánh `E-xx`)

Giữ mã E-xx đã dùng trong `02`, `03`, `04` (ý nghĩa không đổi); dòng dẫn cập nhật theo bản final. E-22→E-25 thêm 2026-10-20.

| Mã | Nội dung (sát nguyên văn) | Nguồn | Nhãn |
| --- | --- | --- | --- |
| E-01 | Mỗi SĐT và mỗi email chỉ gắn với **một** tài khoản. | `EPIC:80` | `[NGUỒN]` |
| E-02 | Email hợp lệ (như BR1); kiểm tra trùng không phân biệt hoa/thường. | `EPIC:82` | `[NGUỒN]` |
| E-03 | SĐT/email chỉ được lưu vào tài khoản **sau khi xác thực**; mỗi dòng chỉ có "Chưa có" hoặc "Đã xác thực". | `EPIC:83`, `US5:62` | `[NGUỒN]` |
| E-04 | Họ tên: tên tự tạo = SĐT hoặc email đăng ký (giữ nguyên email đầy đủ); khi người dùng sửa: 1–50 ký tự, chỉ chữ và khoảng trắng. | `EPIC:87`, `US5:61` | `[NGUỒN]` |
| E-05 | Bước tạo mật khẩu có 2 ô Mật khẩu + Nhập lại mật khẩu, mỗi ô có nút Hiện. | `EPIC:91` | `[NGUỒN]` |
| E-06 | Nhập đúng OTP → 10 phút để tạo mật khẩu; xác thực dùng 1 lần, gắn phiên; quá 10 phút, bỏ ngang hoặc Back (quay về luôn, không hỏi) → nhận mã mới. Chỉ tạo tài khoản khi đã xác thực OTP, mật khẩu hợp lệ, 2 ô khớp; không tạo tài khoản dở dang. | `EPIC:92-93` | `[NGUỒN]` |
| E-07 | Không giới hạn đăng ký theo IP (tạm hoãn kiểm tra IP Việt Nam). | `EPIC:96`, `EPIC:134`, `US1:31` | `[NGUỒN]` — khác bản cũ: đăng ký SĐT cũng không chặn IP nữa |
| E-08 | iOS: không có bất kỳ đường nào vào màn đăng ký; Google trên iOS chỉ đăng nhập tài khoản đã có. | `EPIC:97`, `US3:70`, `US9:59`, `BUG10:28` | `[NGUỒN]` |
| E-09 | Quy định mật khẩu: 8–16 ký tự, có chữ, có số, có ký tự đặc biệt, không khoảng trắng, không dấu tiếng Việt; áp dụng mọi luồng. *(Chờ Chiến: bắt buộc chữ hoa + chữ thường? nới tối đa 64?)* | `EPIC:101`, `EPIC:161` | `[NGUỒN]` phần đã ghi · `[CẦN XÁC NHẬN]` chữ hoa / 64 ký tự (Q-17) — thay cho `[ĐÃ XÁC NHẬN]` US4 Q-01 cũ (≥1 chữ, ≥1 số — **không còn hiệu lực**) |
| E-10 | OTP: mã 6 chữ số; email → email; hiệu lực **5 phút**; chờ **60 giây** mới gửi lại; gửi mã mới thì mã cũ hết hiệu lực; mỗi email tối đa **5 mã/24 giờ** (trượt, chung mọi luồng, mọi thiết bị); sai **5 lần** → hủy mã + khóa gửi và nhập OTP **30 phút**; mã cũ và mã hết hạn đều tính 1 lần sai; BE trả mốc thời gian để app đếm ngược; mọi con số cấu hình được, môi trường test rút ngắn được. | `EPIC:108-113`, `US2:58-65` | `[NGUỒN]` — con số đã chốt (đóng Q-11) |
| E-11 | Chưa xác thực SĐT: hạn mức thấp, mặc định 3 câu/5 giờ, không dùng Pro; đã xác thực 30 câu/5 giờ; app chỉ hiện % đã dùng và giờ làm mới. | `EPIC:117-118`, `US7:60-62` | `[NGUỒN]` |
| E-12 | Đăng ký xong đăng nhập luôn → tạo workspace (nếu chưa có) → ChatGoni; vào ChatGoni chat được ngay, không popup, mặc định Tức thì. | `EPIC:94`, `US7:76` | `[NGUỒN]` |
| E-13 | Quy ước chung: lỗi định dạng hiện dưới ô và tô đỏ ô; chưa nhập đủ thì nút chính mờ, không hiện thông báo; đang gửi yêu cầu thì nút chuyển sang đang tải, không gửi trùng. Kiểm tra 2 lớp FE / BE, BE trả mã lỗi. | `EPIC:128` | `[NGUỒN]` |
| E-14 | Màn nhập OTP là một component dùng chung cho cả 2 kênh ở mọi luồng; màn 12 = kênh email. | `US2:24`, `US2:50` | `[NGUỒN]` |
| E-15 | Màn OTP kênh email: "Mã số đã được gửi tới ng•• ••• @congty.vn" · link "Đổi email" · "Không thấy mã? Kiểm tra hộp thư Spam/Quảng cáo." · 6 ô mã · "Chưa nhận được mã?" + đếm ngược 60 giây (VD "45s") → link "Gửi lại mã" · nút "Xác thực" mờ khi chưa đủ 6 số. | `US2:49-50`, `US2:75`, `US2:79-80`, `US2:83` | `[NGUỒN]` — đóng phần hiển thị màn 12 của Q-09 |
| E-16 | Email gửi mã đăng ký = mẫu 23: logo Gopany · tiêu đề theo mục đích · "Xin chào [email]," · mô tả · khung "MÃ XÁC THỰC CỦA BẠN" 6 số + nút "Sao chép" · "Mã có hiệu lực trong 5 phút và chỉ dùng được một lần." · cảnh báo không chia sẻ · "Nếu bạn không thực hiện thao tác này, hãy bỏ qua email này." · không có nút/link đăng nhập; subject "Mã xác thực Gopany của bạn là 488888". | `US2:52`, `US2:76` | `[NGUỒN]` — khác Figma 1859:3924 ở nút "Sao chép" và câu cuối |
| E-17 | Email Google được tính là email đã xác thực; email Google trùng email đã xác thực của tài khoản có sẵn (đăng ký email, SĐT đã thêm email, Google, tài khoản cũ, **được mời**) → đăng nhập vào tài khoản đó, không tạo mới. | `US9:56-57`, `US9:80` | `[NGUỒN]` — "được mời" vẫn chỉ xuất hiện ở US9 (Q-01) |
| E-18 | Màn đăng ký 05a / 11 (Android, Web) có nút "Tiếp tục với Google". | `US9:73`, `US6:47` | `[NGUỒN]` — hành vi nút thuộc US9 |
| E-19 | Không cho đổi email với mọi tài khoản; Thông tin tài khoản hiện email "Đã xác thực" không có bút sửa; SĐT "Thêm số điện thoại" khi chưa có. | `US5:67`, `US5:81`, `US5:109`, `US9:84` | `[NGUỒN]` |
| E-20 | Hai phiên cùng đăng ký một SĐT/email: không chặn phiên nào; phiên tạo trước thành công, phiên sau báo "đã được đăng ký". | `EPIC:95` (= BR9) | `[NGUỒN]` — bản cũ chỉ là đề xuất (`EPIC:165` cũ); nay là quy tắc |
| E-21 | DoD: chạy đúng trên nền tảng của story (QA: 2 iOS, 2 Android; web Chrome/Safari); luồng email/Google hiện tại không bị ảnh hưởng. | `EPIC:201-202` | `[NGUỒN]` |
| E-22 | Thông báo dùng chung: mất mạng → "Không có kết nối mạng. Vui lòng kiểm tra và thử lại." · lỗi hệ thống → "Đã xảy ra lỗi. Vui lòng thử lại sau." | `EPIC:125-126` | `[NGUỒN]` — AC19(c) dẫn tới đây; đóng phần AC11 cũ của Q-07 |
| E-23 | Đăng nhập đúng → vào đúng workspace gần nhất; chưa có workspace thì sang tạo workspace (luồng hiện có) → ChatGoni. | `US3:75` | `[NGUỒN]` — dùng cho đăng nhập lại sau khi thoát ở màn 14 (Q-05 phần còn lại) |
| E-24 | Trên màn OTP: bấm "Đổi số" / "Đổi email" / Back → về màn nhập trước, **giữ sẵn giá trị đã nhập**; lượt gửi và lượt sai vẫn tính · đưa app ra nền rồi quay lại màn OTP → đếm ngược và hạn mã theo mốc BE, không lệch · gửi mã ở luồng này rồi sang luồng khác cùng email → lượt tính tiếp. | `US2:97-99` | `[NGUỒN]` — đóng phần điền sẵn / ra nền ở màn 12 của Q-04, Q-09 |
| E-25 | Vượt 5 mã/24 giờ → "Bạn đã nhận quá số mã cho phép. Vui lòng thử lại sau HH:MM ngày DD/MM." · bị chặn ngầm (thiết bị/IP, reCAPTCHA, ngân sách) → "Bạn đã gửi quá nhiều yêu cầu. Vui lòng thử lại sau." (không nêu lý do; mã 30115 chặn ngầm · 30114 ngân sách) · sai lần 5 → "Bạn đã nhập sai quá nhiều lần. Vui lòng thử lại sau HH:MM." · sai mã → "Mã OTP không đúng. Bạn còn X lần thử." · hết hạn → "Mã đã hết hạn. Vui lòng gửi lại mã mới. Bạn còn X lần thử." | `US2:86-87`, `US2:90-94` | `[NGUỒN]` — nguyên văn cho AC8, AC13 của US6 |

Mã do QA tự đánh: E-01 → E-25. BR1–BR10, AC1–AC19 (+AC11a) là mã gốc của `US6` bản final.

## 6. Acceptance criteria, mã lỗi, thông báo, giới hạn số

### 6a. AC của US6 (nguyên văn)

Quy ước của tài liệu (`US6:69`): **FE** = kiểm tra ngay tại ô · **BE** = kiểm tra sau khi bấm nút · nội dung trong "…" là câu hiển thị chính xác · cột "Mã lỗi BE do Chiến điền" (chỉ có (b) 30103 ở AC19).

| Mã | Tình huống | Kết quả mong đợi | Mã lỗi BE | Nguồn |
| --- | --- | --- | --- | --- |
| AC1 | Mở màn đăng ký trên Android/Web, chọn tab "Email" | Hiện màn 11 thay cho form đăng ký email cũ (không còn ô họ tên, SĐT) | | `US6:74` |
| AC2 | Dùng app iOS theo mọi đường | Không vào được màn đăng ký | | `US6:75` |
| AC3 | Chưa nhập hoặc chỉ nhập khoảng trắng | FE · nút "Gửi mã xác thực" mờ, không hiện thông báo | | `US6:77` |
| AC4 | Email sai định dạng (VD abc@gmail, abc@@gmail.com, a b@gmail.com, abc@gmail.c, nguyễn@gmail.com) | FE + BE · lỗi dưới ô email, ô tô đỏ: "Email không đúng định dạng." · không gửi mã | | `US6:78` |
| AC5 | Nhập " ABC@Gmail.com " hoặc a.b+1@gmail.com | Tự cắt khoảng trắng; kiểm tra trùng không phân biệt hoa/thường; alias có "+" hợp lệ | | `US6:79` |
| AC6 | Email đã có tài khoản | BE · không gửi OTP · hộp thoại [Hủy] [Đăng nhập]: "Email này đã được đăng ký. Bạn có muốn đăng nhập không?" · bấm Đăng nhập → màn 01, điền sẵn email · bấm Hủy → đóng, ở lại 11 | | `US6:80` |
| AC7 | Không gửi được email | BE · thông báo: "Chưa gửi được mã xác thực. Vui lòng thử lại sau." · ở lại 11 | | `US6:81` |
| AC8 | Vượt 5 mã/24 giờ, bị chặn ngầm, hệ thống bận | BE · thông báo theo US2 · ở lại 11 | | `US6:82` |
| AC9 | Bấm "Gửi mã xác thực" nhiều lần liên tiếp | FE · nút chuyển sang trạng thái đang tải và mờ, chỉ gửi 1 yêu cầu | | `US6:83` |
| AC10 | Đang trong 60 giây chờ, quay lại 11 và bấm gửi lại cùng email | Vào thẳng 12 với đếm ngược còn lại; không gửi mã mới, không báo lỗi | | `US6:84` |
| AC11a | Đổi email quá 3 lần một ngày | Thông báo lỗi tại ô nhập "Bạn đã gửi quá nhiều yêu cầu. Vui lòng thử lại sau." | | `US6:85` (thêm 19/10, không ghi người quyết định — `US6:119`) |
| AC11 | Gửi mã với email hợp lệ | OTP gửi qua email (mẫu 23) · màn 12 hiện "Mã số đã được gửi tới ng•• ••• @congty.vn", link "Đổi email", gợi ý kiểm tra Spam, đếm ngược gửi lại 60 giây | | `US6:87` |
| AC12 | Nhập đúng OTP | Sang 13, email hiện nhãn "Đã xác thực" | | `US6:88` |
| AC13 | Sai mã, hết hạn, gửi quá nhiều, bị khóa | Theo US2 | | `US6:89` |
| AC14 | Chưa nhập đủ 2 ô | FE · nút "Đăng ký" mờ, không hiện thông báo | | `US6:91` |
| AC15 | Mật khẩu chưa đạt quy định | FE + BE · dòng quy định dưới ô mật khẩu chuyển đỏ, ô tô đỏ: "Mật khẩu phải có từ 8–16 ký tự, gồm chữ, số và ký tự đặc biệt, không có khoảng trắng hoặc dấu tiếng Việt." · chưa tạo tài khoản | | `US6:92` |
| AC16 | Ô Nhập lại mật khẩu không khớp | FE · lỗi dưới ô Nhập lại mật khẩu, ô tô đỏ: "Mật khẩu xác nhận không khớp. Vui lòng nhập lại." · chưa tạo tài khoản | | `US6:93` |
| AC17 | Mật khẩu hợp lệ, bấm Đăng ký | BE · nút chuyển sang đang tải · tạo tài khoản và đăng nhập luôn → màn 14: "Đăng ký thành công" + "Tài khoản của bạn đã được tạo với email nguyenvana@congty.vn." + "Tên hiển thị: nguyenvana@congty.vn, bạn có thể đổi trong Tài khoản → Thông tin tài khoản" · bấm "Bắt đầu sử dụng" → tạo workspace (nếu chưa có) → ChatGoni chat ngay ở hạn mức thấp | | `US6:94` |
| AC18 | Bấm Back ở 13 (nút trên màn hoặc back hệ thống) | FE · về 11, giữ sẵn email đã nhập, không hỏi xác nhận · kết quả xác thực cũ hết hiệu lực, phải gửi OTP mới | | `US6:95` |
| AC19 | Bấm Đăng ký nhưng: (a) đã quá 10 phút sau khi xác thực OTP · (b) người khác vừa đăng ký xong cùng email · (c) mất mạng / lỗi hệ thống · (d) trước đó đã bỏ ngang hoặc tắt app | Không tạo tài khoản, không có tài khoản dở dang. (a) BE · "Phiên xác thực đã hết hạn. Vui lòng nhận mã mới." → về 11 giữ sẵn email. (b) BE · hộp thoại [Hủy] [Đăng nhập]: "Email này đã được đăng ký. Bạn có muốn đăng nhập không?" (c) Thông báo theo Epic mục 6, ở lại 13, cho bấm lại. (d) Mở lại app thì bắt đầu từ 11. | (b) 30103 | `US6:97` |

Đối chiếu mã AC cũ (bản 15/10): AC1→AC1 · AC2→AC2 · AC3→AC4 · AC4→AC6 · AC5→AC7 · AC6→AC11 · AC7→AC13 · AC8→AC12 · AC9→AC15 + AC16 · AC10→AC17 · AC11→AC19. **Mới, không có mã cũ:** AC3, AC5, AC8, AC9, AC10, AC11a, AC14, AC18. Chi tiết ở mục 12.

### 6b. Thông báo, giới hạn số, mã lỗi

Bản final đã ghi nguyên văn hầu hết thông báo vào AC; bảng này gom lại kèm con số và mã lỗi.

| Mục | Nguyên văn / giá trị | Nguồn | Ghi chú |
| --- | --- | --- | --- |
| Sai định dạng email (AC4) | "Email không đúng định dạng." — lỗi dưới ô, ô tô đỏ | `US6:78` | Đóng Q-07 phần AC3 cũ (có dấu chấm cuối) |
| Email đã có tài khoản (AC6, AC19b) | Hộp thoại [Hủy] [Đăng nhập] "Email này đã được đăng ký. Bạn có muốn đăng nhập không?" · Đăng nhập → màn 01 điền sẵn email · Hủy → đóng, ở lại 11 | `US6:80`, `US6:97` | Đóng Q-16 (không phân nhánh theo loại tài khoản — tài liệu ghi một hành vi) |
| Không gửi được email (AC7) | "Chưa gửi được mã xác thực. Vui lòng thử lại sau." — ở lại 11 | `US6:81`; cùng câu `US2:85` | Đóng Q-07 phần AC5 cũ, Q-02 phần "màn nào" |
| Vượt giới hạn / chặn ngầm (AC8, AC11a) | "Bạn đã nhận quá số mã cho phép. Vui lòng thử lại sau HH:MM ngày DD/MM." (5 mã/24 giờ) · "Bạn đã gửi quá nhiều yêu cầu. Vui lòng thử lại sau." (chặn ngầm 30115 / ngân sách 30114; AC11a đổi email quá 3 lần/ngày) | `US2:86-87`, `US6:85` | "Hệ thống bận" (AC8) không có câu riêng → mục 13 |
| Lỗi OTP màn 12 (AC13) | "Mã OTP không đúng. Bạn còn X lần thử." · "Mã đã hết hạn. Vui lòng gửi lại mã mới. Bạn còn X lần thử." · "Bạn đã nhập sai quá nhiều lần. Vui lòng thử lại sau HH:MM." | `US2:90-94` | Thuộc US2 |
| Mật khẩu chưa đạt (AC15) | "Mật khẩu phải có từ 8–16 ký tự, gồm chữ, số và ký tự đặc biệt, không có khoảng trắng hoặc dấu tiếng Việt." — dòng quy định dưới ô chuyển đỏ, ô tô đỏ | `US6:92` | Khác `TB2` / Figma US4 ("chữ hoa, chữ thường…") — theo tài liệu; chữ hoa còn chờ Chiến (Q-17) |
| Không khớp (AC16) | "Mật khẩu xác nhận không khớp. Vui lòng nhập lại." — dưới ô Nhập lại mật khẩu | `US6:93` | Đóng Q-20 |
| Quá 10 phút (AC19a) | "Phiên xác thực đã hết hạn. Vui lòng nhận mã mới." → về 11 giữ email | `US6:97` | Đóng Q-03 |
| Mất mạng / lỗi hệ thống (AC19c) | "Không có kết nối mạng. Vui lòng kiểm tra và thử lại." · "Đã xảy ra lỗi. Vui lòng thử lại sau." — ở lại 13, cho bấm lại | `EPIC:125-126`, `US6:97` | Đóng Q-07 phần AC11 cũ |
| Màn 14 (AC17) | "Đăng ký thành công" · "Tài khoản của bạn đã được tạo với email nguyenvana@congty.vn." · "Tên hiển thị: nguyenvana@congty.vn, bạn có thể đổi trong Tài khoản → Thông tin tài khoản" · nút "Bắt đầu sử dụng" | `US6:50`, `US6:94` | Đóng Q-19 (Figma ghi "số điện thoại" là lỗi design) |
| Nút ở màn 13 | "Đăng ký" (mờ khi chưa đủ 2 ô) | `US6:49`, `US6:91` | Đóng Q-21 |
| Màn 12 | "Mã số đã được gửi tới ng•• ••• @congty.vn" · link "Đổi email" · "Không thấy mã? Kiểm tra hộp thư Spam/Quảng cáo." · 6 ô · "Chưa nhận được mã?" + "45s" → "Gửi lại mã" · nút "Xác thực" | `US6:48`, `US2:49-50` | Đóng Q-09 phần hiển thị (Figma "Đổi số" là lỗi design) |
| Con số | OTP 6 số · 5 phút · 60 giây · 5 mã/24 giờ trượt · sai 5 lần → khóa 30 phút · 10 phút tạo mật khẩu · đổi email tối đa 3 lần/ngày · hạn mức thấp 3 câu/5 giờ | `US2:58-62`, `US6:58`, `US6:85`, `US7:60` | Đóng Q-11 |
| Mã lỗi BE | 30103 (AC19b — email đã được đăng ký) · 30115 (chặn ngầm) · 30114 (ngân sách gửi) — còn lại cột trống "do Chiến điền" | `US6:97`, `US2:87` | Q-12 còn mở phần lớn |

### 6c. Nội dung chỉ có trên wireframe (bản cũ `US6:29`) — *bản final không còn wireframe; màn 11–14 mô tả bằng chữ ở `US6:45-50` (giữ mục này để đối chiếu)*

| Màn | Nội dung trên wireframe | Nhãn |
| --- | --- | --- |
| 11 | "Quay lại"; "Bước 1/3"; tiêu đề "Đăng ký – Tạo tài khoản Gopany bằng email"; thanh tab "Số điện thoại / Email"; ô Email placeholder "Nhập email", gợi ý "Mã xác thực sẽ gửi tới email này."; nút "Gửi mã xác thực"; "Hoặc" + "Tiếp tục với Google"; khung ghi chú "Báo lỗi ngay ở bước này: Email sai định dạng · Email đã có tài khoản (gợi ý Đăng nhập) · Không gửi được email. Ngoài IP Việt Nam: chỉ còn lựa chọn Email."; dòng "Bằng việc đăng ký, bạn đồng ý với Điều khoản và Chính sách bảo mật."; "Đã có tài khoản? Đăng nhập" | `[NGUỒN]` wireframe — chỉ tham khảo, không làm expected nguyên văn |
| 12 | "Quay lại"; "Bước 2/3"; "Xác thực email"; "Mã \[__\] số đã được gửi tới ng•••••@congty.vn. Đổi email"; 6 ô mã; "Chưa nhận được mã? Gửi lại mã sau 00:45"; khung "Không thấy email? Kiểm tra hộp thư Spam hoặc Quảng cáo."; nút "Xác nhận"; ghi chú "Cùng màn OTP với 05b, chỉ đổi kênh gửi: email thay vì Zalo. Lỗi OTP: xem màn 06." | `[NGUỒN]` wireframe |
| 13 | "Bước 3/3"; "Tạo mật khẩu"; "nguyenvana@congty.vn" + nhãn "Đã xác thực"; ô Mật khẩu placeholder "Tối thiểu \[__\] ký tự" + Hiện; ô Xác nhận mật khẩu "Nhập lại mật khẩu" + Hiện; nút "Đăng ký"; ghi chú "Giống màn 05c. Không nhập họ tên – họ tên tự tạo = email đăng ký. Ô Xác nhận mật khẩu phải khớp ô Mật khẩu. Bỏ ngang ở bước này: chưa tạo tài khoản." **Không vẽ nút Quay lại.** | `[NGUỒN]` wireframe |
| 14 | "Đăng ký thành công"; "Tài khoản của bạn đã được tạo với email nguyenvana@congty.vn."; "Tên hiển thị: nguyenvana@congty.vn — Bạn có thể đổi trong Tài khoản › Thông tin tài khoản."; nút "Bắt đầu sử dụng"; ghi chú "Bấm → tạo workspace (nếu chưa có) → vào ChatGoni (màn 15), chat ngay." | `[NGUỒN]` wireframe — AC10 không nhắc nút này (mục 9 điểm 5) |

### 6d. Nội dung trên Figma giao diện thật (`FIGMA`, đọc 2026-10-16) — *từ 2026-10-20 tài liệu ghi "Giao diện theo Figma final" (`US6:43`) và mô tả màn bằng chữ; cột "So với tài liệu" dưới đây là so với bản cũ — kết luận mới xem mục 12*

Figma ưu tiên hơn wireframe về câu chữ và bố cục (`US6:33`); không thay được BR/AC — chỗ Figma khác tài liệu hoặc khác câu BA thì nêu thành câu hỏi. Giới hạn: ảnh 5/9 frame; 4 frame còn lại chỉ đọc được tên frame và lớp text.

| Màn | Frame | Nội dung đọc được trên Figma | So với tài liệu / cách hiểu đã chốt | Nhãn |
| --- | --- | --- | --- | --- |
| 11 | `1641:50276` (ảnh `figma/US6_1641-50276_nhap-email.png`) | Quay lại; thanh tiến trình 3 vạch (vạch 1 xanh; **không** có chữ "Bước 1/3"); "Đăng ký"; "Tạo tài khoản Gopany bằng email"; tab "Số điện thoại" / "Email" (Email đang chọn); ô "Nhập email" (biểu tượng thư); helper "Mã xác thực sẽ gửi qua email này"; nút "Gửi mã xác thực" **mờ** khi ô trống; "Hoặc"; "Tiếp tục với Google" (logo G); "Bằng việc đăng ký, bạn đồng ý với Điều khoản và Chính sách bảo mật" (2 link); "Đã có tài khoản? Đăng nhập" | Khớp AC1 (tab Email), US9 AC2 (nút Google), wireframe 6c màn 11 — trừ: không có khung "Báo lỗi ngay ở bước này"; helper "qua email này" thay "tới email này."; không có "Bước 1/3". Nút mờ khi trống: US6 không có AC (US4 AC13 tương tự cho màn 02) → ĐO & GHI theo design | `[NGUỒN]` Figma |
| 11 — sai định dạng (AC3) | `1819:5526` (ảnh `figma/US6_1819-5526_email-sai-dinh-dang.png`) | Ô viền đỏ, giá trị "nguyenvanacongty.vn", lỗi đỏ ngay dưới ô **"Email không đúng định dạng"**; nút "Gửi mã xác thực" **vẫn bật** | Khớp câu BA Hường (`02 §4` dòng 21) và AC3 "tại ô" (`US6:60`). Lỗi hiện lúc bấm nút hay lúc rời ô: design không nói → ĐO & GHI | `[NGUỒN]` Figma |
| 11 — email đã có tài khoản (AC4) | `1819:5176` (ảnh `figma/US6_1819-5176_email-da-dung.png`) + `1819:5278` (popup tách riêng) | Nền tối mờ; popup giữa màn: biểu tượng thư vàng; **"Email này đã được đăng ký. Bạn có muốn đăng nhập không?"**; nút viền "Hủy" + nút xanh "Đăng nhập" | AC4 (`US6:61`) "báo đã đăng ký, gợi ý Đăng nhập" → hình thức là **popup**, không phải lỗi tại ô. Popup không phân biệt loại tài khoản (Q-16). Bấm "Hủy" về đâu, email còn trong ô không: design không nói (bổ sung Q-16) | `[NGUỒN]` Figma |
| 11 — hai trạng thái lỗi **không có trong US6** | `1819:5296` "Thiết bị đã vượt giới hạn số lượng email được phép sử dụng" · `1819:5430` "Email thuộc danh sách chặn" (chưa xem ảnh; chữ lỗi nằm trong ô nhập, chưa bóc được) | Tên frame cho thấy hai nhánh chặn ngay bước 1: (1) một thiết bị chỉ được dùng tối đa [__] email để đăng ký; (2) email nằm trong danh sách chặn. Mục US1 trên Figma có cặp tương ứng cho SĐT ("Thiết bị yêu cầu quá hạn mức gửi số điện thoại", "Số điện thoại bị ghi nhận trong danh sách đen") | US6 BR1–BR5, AC1–AC11 và Epic §6 **không có** quy tắc nào về giới hạn theo thiết bị hay danh sách chặn; Epic #14 (`EPIC:157`) và `US2:78` mới là câu hỏi mở "có cần giới hạn theo thiết bị/IP không", chưa chốt → **Q-18, AI đề xuất trọng yếu** (phạm vi mới, cô lập được: case chưa viết được) | `[NGUỒN]` Figma (tên frame) · `[CẦN XÁC NHẬN]` |
| 12 | `1641:50334` (chưa xem ảnh) · `1641:50362` (ảnh `figma/US6_1641-50362_otp.png`) | Quay lại; tiến trình 2/3; "Nhập mã xác thực"; "Mã số đã được gửi tới ng•• ••• @congty.vn"; link góc phải **"Đổi số"** (frame `1641:50362`; frame `1641:50334` cũng có một link, chữ chưa đọc); 6 ô đã điền "4 6 8 0 1 2"; "Chưa nhận được mã?" + đồng hồ "45s"; nút "Xác thực" bật; bàn phím số; **không có** khung "Không thấy email? Kiểm tra Spam" | AC6 (`US6:64`) "nút Đổi email, gợi ý kiểm tra Spam" → frame này ghi **"Đổi số"** và **không có gợi ý Spam** (bổ sung Q-09; cùng màn với US4 Q-28). Tiêu đề "Nhập mã xác thực" thay "Xác thực email"; nút "Xác thực" thay "Xác nhận" (câu chữ). `02 §4` dòng 11 ghi "nút Gửi lại mờ đếm ngược 60 s" → design chỉ có đồng hồ "45s", không có nút khi đang đếm; sau 0 s hiện gì chưa thấy (mục US2 frame `1754:5797` "yêu cầu gửi lại khi hết thời gian chờ" chưa đọc) | `[NGUỒN]` Figma |
| 13 | `1641:50302` (chưa xem ảnh) | **Có nút Quay lại** (lớp Button Group 2); "Tạo mật khẩu"; "nguyenvana@congty.vn" + một Badge (chữ chưa đọc; wireframe là "Đã xác thực"); 2 ô nhập; 1 nút (chữ chưa đọc). Helper quy định mật khẩu: không có lớp text ngoài ô — có thể nằm trong ô như màn 04 US4 (`FIGMA 1754:6840`: "8–16 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt") | Wireframe không vẽ Quay lại (6c); Figma có → bổ sung Q-10 (về màn 12 hay 11, email đã xác thực còn giữ không). Quy định mật khẩu nếu dùng chung helper với US4 màn 04 → chịu US4 Q-26 → **Q-17 của US6** | `[NGUỒN]` Figma · `[DIỄN GIẢI AI]` phần helper |
| 14 | `1641:50321` (ảnh `figma/US6_1641-50321_thanh-cong.png`) | Dấu tick xanh lớn; "Đăng ký thành công"; **"Tài khoản của bạn đã được tạo với số điện thoại +84 912 345 678."**; khung "Tên hiển thị: nguyenvana@congty.vn / bạn có thể đổi trong: Tài khoản → Thông tin tài khoản"; nút "Bắt đầu sử dụng"; không có Quay lại / đóng | Dòng đầu nói **số điện thoại** trong luồng đăng ký **email** — ngược wireframe ("với email nguyenvana@congty.vn") và BR3 → **Q-19** (lỗi copy của design hay hành vi thật). Phần tên hiển thị + nút "Bắt đầu sử dụng" khớp AC10 (`US6:69`) và mục 9 điểm 5 | `[NGUỒN]` Figma |
| Email OTP đăng ký | `1859:3924` (ảnh `figma/EMAIL_1859-3924_otp-dangky.png`; thuộc mục "Email OTP (thay email 'Verify email' dạng nút bấm)") | Logo; "Nhập mã xác thực đăng ký"; "Xin chào huongmt@gopany.com,"; "Bạn đang đăng ký tài khoản Gopany bằng email này. Nhập mã dưới đây vào màn hình đăng ký để tiếp tục."; "MÃ XÁC THỰC CỦA BẠN" 6 số; "Mã có hiệu lực trong 5 phút và chỉ dùng được một lần."; khung vàng không chia sẻ mã; "Nếu bạn không đăng ký tài khoản Gopany, hãy bỏ qua email này. Sẽ không có tài khoản nào được tạo."; chân "[email hỗ trợ] · [hotline] © 2026 Gopany"; **không có nút / liên kết** | Khớp mẫu 23 (`US2:38`). Tiêu đề (subject) không có trên design. Tên mục xác nhận email "Verify email" dạng nút bị thay — khớp scope "thay form đăng ký email cũ" (`US6:3`) | `[NGUỒN]` Figma |
| Chưa có trên Figma (mục US6) | — | AC5 (không gửi được email), AC11 (mất mạng / lỗi hệ thống), trạng thái sau khi đồng hồ về 0, màn tạo workspace / ChatGoni sau "Bắt đầu sử dụng" (mục US7 có frame "Chat Goni" `1641:50744`, chưa đọc), iOS | Case của các AC này vẫn chỉ dựa trên chữ tài liệu | `[NGUỒN]` Figma (danh sách frame) |

### 6e. Bảng nội dung thông báo (`TB`, Hồng cung cấp 2026-10-16) — đối chiếu với AC/BR *bản cũ; bản final đã gộp thông báo vào AC (mục 6b mới)*

`TB2` được dùng làm căn cứ; `TB1` là bản nháp, chỉ ghi ở cột cuối. Tác giả chưa ghi (mục 9 điểm 17).

| Màn | Tình huống (`TB2`) | Cách hiển thị + nội dung | AC/BR | So với tài liệu và cách hiểu đã chốt | Nhãn |
| --- | --- | --- | --- | --- | --- |
| 11 | Email đã được sử dụng | Hộp thoại giữa màn hình, nút Đăng nhập / Hủy: "Email này đã được đăng ký. Bạn có muốn đăng nhập không?" | AC4, BR1 | Khớp `FIGMA 1819:5176`. Tài khoản Google (Q-16) và "Hủy" chưa nói | `[NGUỒN]` `TB2` + `FIGMA` |
| 11 | Email không đúng định dạng | Lỗi dưới ô Email, ô trạng thái lỗi: "Email không đúng định dạng." | AC3 | Khớp `02 §4` dòng 21 và `FIGMA 1819:5526` | `[NGUỒN]` |
| 11 | Chưa nhập email | Nút "Gửi mã xác thực" vô hiệu; không thông báo | AC3 (phần ô trống) | Khớp `FIGMA 1641:50276` (nút mờ). Chỉ toàn khoảng trắng: không nói | `[NGUỒN]` |
| 11 | Thiết bị vượt giới hạn email | Thông báo trên form, nút Gửi mã vô hiệu: "Bạn đã vượt giới hạn \[X\] email trên thiết bị này. Vui lòng thử lại sau \[Y\] giờ." | — (không có BR) | `02` Q-18 | `[CẦN XÁC NHẬN]` |
| 11 | Email thuộc danh sách chặn | Lỗi dưới ô Email, ô trạng thái lỗi: "Email này hiện không được phép sử dụng. Vui lòng nhập email khác." | — (không có BR) | `02` Q-18 | `[CẦN XÁC NHẬN]` |
| 13 | Một hoặc cả hai ô trống | Nút "Lưu mật khẩu" vô hiệu; không thông báo | AC9 | Trả lời phần "nút tắt khi chưa đủ 2 ô" của Q-10; tên nút ≠ wireframe "Đăng ký" (Q-21) | `[NGUỒN]` `TB2` |
| 13 | Mật khẩu không đáp ứng quy định | Lỗi dưới ô Mật khẩu, ô trạng thái lỗi: "Mật khẩu phải có từ 8–16 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt." | AC9, E-09 | **Khác BA** (US4 Q-01: ≥1 chữ và ≥1 số); trùng chữ Figma US4 màn 04 → `02` Q-17 | `[NGUỒN]` `TB2` nhưng mâu thuẫn `[ĐÃ XÁC NHẬN]` → không làm expected |
| 13 | Xác nhận mật khẩu không khớp | Lỗi dưới ô Xác nhận mật khẩu, ô trạng thái lỗi: "Mật khẩu xác nhận không khớp. Vui lòng nhập lại." | AC9 | Chứa nguyên văn `US6:68`, thêm hậu tố → Q-20 | `[NGUỒN]` `TB2` |
| Dùng chung | Các màn liên quan | "Đã xảy ra lỗi. Vui lòng kiểm tra và thử lại." — **chỉ có trong `TB1`** | AC5, AC11 (ứng viên) | `TB2` bỏ dòng này; không áp | `[GIẢ ĐỊNH]` |
| 05b-12 (`TB1`) | US2: nút xác thực theo số ô, gửi lại, sai mã, hết hạn, quá nhiều lần, khóa | Chữ ở `TB1` nhắc "số điện thoại" cho kênh email; "Mã không đúng bạn còn \[\] lần thử" ≠ `US2:63` "Mã OTP không đúng"; có lỗi chính tả ("VuI", "Tạp") | AC7 ("theo US2") | Thuộc US2, bản nháp → **không áp** cho US6; ghi nhận, chuyển phiên US2 | `[GIẢ ĐỊNH]` |

## 7. Trạng thái và chuyển trạng thái

Tài liệu không định nghĩa máy trạng thái; trạng thái dữ liệu có trong nguồn (cập nhật theo bản final):

| Đối tượng | Trạng thái | Chuyển | Nguồn | Nhãn |
| --- | --- | --- | --- | --- |
| Email trên tài khoản | "Chưa có" / "Đã xác thực" | Tài khoản tạo xong (AC17) → email "Đã xác thực" | `EPIC:83`, `US5:62`, `US6:88` | `[NGUỒN]` |
| SĐT trên tài khoản mới | "Chưa có" | Thêm SĐT ở US5 hoặc US7 → "Đã xác thực" | `US6:62`, `US7:63` | `[NGUỒN]` |
| Tài khoản | Chưa tồn tại → tồn tại **và đã đăng nhập** | Tại thời điểm bấm Đăng ký với OTP đã xác thực còn hiệu lực + mật khẩu hợp lệ + 2 ô khớp; mọi bỏ ngang trước đó → chưa tồn tại, không có tài khoản dở dang | `US6:60-61`, `US6:94`, `US6:97` | `[NGUỒN]` |
| Kết quả xác thực OTP (phiên đăng ký) | Chưa có → **còn hiệu lực (10 phút, dùng 1 lần)** → hết hiệu lực (quá 10 phút / bỏ ngang / Back / đã dùng) | Hết hiệu lực → phải nhận mã mới (tính vào 5 mã/24 giờ); bấm Đăng ký khi hết → AC19(a) về 11 giữ email | `US6:58`, `US6:95`, `US6:97` | `[NGUỒN]` — thay `[DIỄN GIẢI AI]` cũ (Q-03 đóng) |
| Đếm ngược gửi lại (theo email) | Đang đếm (60 giây từ lần gửi gần nhất) → hết | Trong 60 giây quay lại 11 gửi lại **cùng email** → vào thẳng 12 với đếm ngược còn lại, không gửi mã mới (AC10); email khác → gửi mã mới cho email đó (US2 BR3 tính theo email) | `US6:84`, `US2:60` | `[NGUỒN]` phần cùng email · `[DIỄN GIẢI AI]` phần email khác |
| Workspace | Chưa có → có | Khi bấm "Bắt đầu sử dụng" (nếu chưa có); đăng nhập lại khi chưa có → luồng tạo workspace hiện có | `US6:94`, `US3:75` | `[NGUỒN]` |

## 8. Diễn giải, giả định, QA observation

*Bảng dưới viết ngày 15–16/10 theo bản cũ. Sau bản final: #3 (được mời) vẫn mở; #4, #6, #7, #8, #10 (một phần), #12, #16 đã thành `[NGUỒN]` (xem mục 5a, 5b, 7); #9, #13 giữ nguyên; #15 đã có BR1. Không sửa từng dòng để giữ dấu vết.*

| # | Nội dung | Nhãn | Liên quan tới |
| ---: | --- | --- | --- |
| 1 | "Tab Email thay cho form cũ" (AC1) đọc là: màn 11 không còn các ô họ tên, SĐT, và form cũ không còn đường vào; thanh tab "Số điện thoại / Email" ở IP VN và chỉ Email ở ngoài VN là nội dung của US1 AC1/AC2 (`US1:56-57`), US6 chỉ kiểm phần tab Email. | `[DIỄN GIẢI AI]` | AC1, BR4 |
| 2 | AC4 chủ động cho người dùng biết email đã có tài khoản ("báo đã đăng ký, gợi ý Đăng nhập"). Nguyên tắc "không tiết lộ tồn tại" ở `EPIC:115` chỉ nêu cho đăng nhập / quên mật khẩu, không nêu cho đăng ký → không mâu thuẫn; ghi để Test Designer không áp nguyên tắc US4 Q-03 sang US6. | `[DIỄN GIẢI AI]` | AC4, BR1 |
| 3 | "Email đã có tài khoản" (BR1/AC4) gồm: tài khoản đăng ký form cũ, tài khoản Google (email Google = đã xác thực, `US9:45`), email đã thêm ở US5 (`US5:57`). So khớp không phân biệt hoa/thường (`EPIC:97` → `[NGUỒN]`). Trường hợp email **được mời vào workspace nhưng chưa đăng ký**: `US9:46` liệt kê "được mời" như một loại "tài khoản đã có" — chưa rõ áp cho US6. | `[DIỄN GIẢI AI]` phần Google/US5; phần "được mời" → mục 9 điểm 1 | BR1, AC4, AC10 |
| 4 | Theo user flow, AC5 (không gửi được email) xảy ra **trước** khi sang màn 12 → lỗi hiện ở màn 11; "cho thử lại" = bấm lại "Gửi mã xác thực". Chữ trong AC5 không nói màn nào. | `[DIỄN GIẢI AI]` | AC5 → mục 9 điểm 2 |
| 5 | "Theo US2" (AC7): US6 chỉ kiểm màn 12 hành xử như US2 AC4–AC11 với kênh email; chi tiết giới hạn thuộc US2. Con số còn trống → precondition các case này `❓ Cần chốt` cho tới khi US2 chốt. | `[DIỄN GIẢI AI]` | AC7, E-10 |
| 6 | AC8 "email hiện 'Đã xác thực'": nhãn hiển thị trên màn 13 (wireframe) — chưa phải trạng thái lưu trên tài khoản, vì tài khoản chưa tồn tại tới khi bấm Đăng ký (BR2). | `[DIỄN GIẢI AI]` | AC8, BR2, E-03 |
| 7 | AC10 "ChatGoni chat ngay" ngụ ý người dùng **đã đăng nhập** ngay sau đăng ký (khác US4 không tự đăng nhập, `US4:50`). Tài liệu không nói rõ chữ "đăng nhập". | `[DIỄN GIẢI AI]` | AC10 |
| 8 | "Bỏ ngang" (AC11) → quay lại làm từ bước 1: US1 AC11 ghi rõ (`US1:70`), US6 không ghi; Epic chỉ nói "chưa tạo tài khoản" (`EPIC:106`). | `[DIỄN GIẢI AI]` theo US1 | AC11 → mục 9 điểm 4 |
| 9 | Mất mạng đúng lúc bấm Đăng ký mà request đã tới BE: tài khoản đã tạo, màn báo lỗi; bấm lại sẽ rơi vào AC4. Tài liệu không nói. | `[QA BỔ SUNG]` | AC11 → mục 9 điểm 13 |
| 10 | Tên hiển thị = "email đăng ký": chuỗi như người dùng gõ hay đã chuẩn hóa chữ thường; email lưu ở dạng nào (Epic #21 chỉ chuẩn hóa SĐT, `EPIC:164`). | `[DIỄN GIẢI AI]` | BR3, AC10 → mục 9 điểm 8 |
| 11 | Nút "Tiếp tục với Google" ở màn 11: US6 chỉ kiểm có nút (`US9:60`); hành vi thuộc US9. Email Google trùng email đang đăng ký ở US6 → BR1 chặn ở AC4 (vì email Google đã gắn tài khoản). | `[DIỄN GIẢI AI]` | E-17, E-18 |
| 12 | BR2 đọc là ràng buộc phía BE (E-13 hai lớp): gọi API tạo tài khoản khi chưa xác thực OTP, hoặc mật khẩu không đạt, phải bị từ chối dù FE bị bỏ qua. Cách kiểm bằng công cụ là phương pháp QA. | `[QA BỔ SUNG]` (cách kiểm) trên `[NGUỒN]` `US6:47`, `EPIC:206` | BR2 |
| 13 | BR5: US6 kiểm tới đâu trong US7 — chỉ "vào ChatGoni chat ngay, hạn mức thấp, Pro có khóa" (`US7:61`, `US7:63`, `US7:65`) hay cả hết hạn mức 3 câu. Cần chốt phạm vi khi debate (không phải câu hỏi BA). | `[QA BỔ SUNG]` | BR5 |
| 14 | Wireframe màn 11 có "Điều khoản", "Chính sách bảo mật", "Đã có tài khoản? Đăng nhập", "Quay lại" — không có trong BR/AC; wireframe chỉ tham khảo. | `[DIỄN GIẢI AI]` | AC1 → mục 9 điểm 14 |
| 15 | Email form: khoảng trắng đầu/cuối, chữ hoa, dấu `+` (plus-addressing), tên miền có dấu, email dài, email không có TLD — quy tắc BA chốt ở US4 Q-07 "chuẩn chung có @ và tên miền"; biên cụ thể là coverage QA. | `[QA BỔ SUNG]` | AC3 |
| 16 | Hai thiết bị cùng đăng ký một email song song (Epic #22 chưa chốt): dù hành vi phiên thế nào, BR1/E-01 bảo đảm chỉ một tài khoản được tạo. | `[DIỄN GIẢI AI]` | BR1, E-20 → mục 9 điểm 6 |
| 17 | Regression: người đăng ký bằng form cũ vẫn đăng nhập được; luồng Google không đổi (`EPIC:194`); link "Đăng ký" ở màn đăng nhập Android/Web (`US3:52`). | `[NGUỒN]` phạm vi regression | E-21 |

## 9. Điểm chưa rõ (chuyển sang Debate) — *theo bản cũ; trạng thái sau bản final xem mục 12 (bảng Q) và mục 13 (điểm mới)*

| # | Loại | Trích dẫn + nguồn | Vì sao chưa rõ | Đề xuất mức |
| ---: | --- | --- | --- | --- |
| 1 | nhiều cách hiểu / thiếu | BR1 "Chỉ email chưa gắn tài khoản nào" (`US6:46`); AC4 (`US6:61`); AC10 "tạo workspace (nếu chưa có)" (`US6:69`); `US9:46` "tài khoản đã có (đăng ký email, form cũ, **được mời**)"; `EPIC:136` "hiện chỉ mời bằng email" | Email **đã được mời vào workspace nhưng chưa đăng ký** có tính là "đã gắn tài khoản" (→ AC4 chặn) hay được đăng ký (→ AC10)? Nếu được: "tạo workspace (nếu chưa có)" nghĩa là vào workspace đã mời hay vẫn tạo workspace mới? Với tài khoản hoàn toàn mới, khi nào "đã có" workspace? | **Trọng yếu** — đổi kết quả AC4/AC10 và dữ liệu workspace |
| 2 | thiếu | AC5 "Không gửi được email → Báo lỗi, cho thử lại" (`US6:62`); user flow đặt AC5 trước màn 12 (`US6:21`); `US2:17` "lỗi không gửi được mã – xử lý trong từng luồng"; `US2:46-47` cooldown và số lần gửi | Lỗi hiện ở màn 11 hay màn 12? "Thử lại" có chịu chờ 60 giây và có tính vào số lần gửi của US2 không? Hệ thống biết "không gửi được" bằng cách nào (dịch vụ gửi trả lỗi ngay, hay email bị trả về sau) — QA cần để mô phỏng | **Trọng yếu** — đổi luồng và precondition nhóm case AC5/AC7 |
| 3 | thiếu | AC8 (`US6:66`), BR2 (`US6:47`), `EPIC:106`; đối chiếu `US4:53-54` (US4 có thời hạn 10 phút sau OTP, hết thì BE từ chối) | Sau khi OTP đúng, kết quả xác thực có **thời hạn** để sang bước 3 không? Người dùng đứng ở màn 13 lâu (vd 30 phút) rồi bấm Đăng ký → tạo tài khoản hay bị từ chối, và từ chối thì về đâu? | **Trọng yếu** — đổi kết quả AC10 (tạo / không tạo tài khoản) |
| 4 | thiếu / nhiều cách hiểu | AC11 "Bỏ ngang" (`US6:71`); `US1:70` "quay lại phải làm từ bước 1"; `EPIC:106`; wireframe màn 13 "Bỏ ngang ở bước này: chưa tạo tài khoản"; US4 Q-06 (web F5 giữ màn, đóng tab làm lại) | Ở màn 12 hoặc 13: app ra nền rồi quay lại, tắt hẳn app, web F5, đóng tab → ở lại màn đó hay làm lại từ bước 1? US6 không ghi, US1 ghi "từ bước 1" | **Trọng yếu** — đổi luồng expected của nhóm case AC11 |
| 5 | thiếu / mâu thuẫn nhẹ | AC10 (`US6:69`) không nhắc nút; wireframe màn 14 có nút "Bắt đầu sử dụng" + ghi chú "Bấm → tạo workspace"; `US1:68` ghi rõ "bấm 'Bắt đầu sử dụng' → tạo workspace (nếu chưa có) → vào ChatGoni" | Tài khoản tạo lúc bấm Đăng ký (trước màn 14) — thoát ở màn 14 không bấm "Bắt đầu sử dụng": tài khoản có đăng nhập được ngay bằng US3 không; workspace đã tạo chưa; lần đăng nhập sau vào đâu (ChatGoni hay tạo workspace)? | **Trọng yếu** — dữ liệu tài khoản / workspace |
| 6 | thiếu | `EPIC:165` #22: Chiến "đề xuất chặn các phiên xác thực đang diễn ra nếu cùng SĐT/email" — chưa chốt | Thiết bị B nhập cùng email khi A đang ở màn 12: B bị chặn (thông báo gì) hay cả hai nhận mã; A tạo xong tài khoản, B bấm Đăng ký → gì? | Không trọng yếu (BR1 bảo đảm một tài khoản; phần còn lại là trải nghiệm) — cô lập, case `❓` |
| 7 | thiếu | AC3, AC4, AC5, AC11 (`US6:60-62`, `US6:71`); AC9 phần "không đạt quy định" (`US6:68`) | Không có nguyên văn thông báo; wireframe không vẽ trạng thái lỗi | Không trọng yếu — ĐO & GHI |
| 8 | mơ hồ | BR3 "họ tên tự tạo = email đăng ký" (`US6:48`); `EPIC:97` so khớp không phân biệt hoa/thường; `EPIC:164` #21 chỉ chuẩn hóa SĐT | Gõ `NguyenVanA@Congty.VN` → tên hiển thị và email lưu giữ nguyên hay về chữ thường? Khoảng trắng đầu/cuối có tự cắt? | Không trọng yếu (hiển thị; đăng nhập vẫn khớp theo E-02) |
| 9 | thiếu | AC6 (`US6:64`); wireframe màn 12 "Mã \[__\] số", "Đổi email", "Quay lại"; US4 Q-13 BA chốt mẫu che "ng•••@…" cho US4 | "Đổi email"/"Quay lại" về màn 11 với email điền sẵn hay trống? Mẫu che email US4 có áp chung cho màn 12 (cùng một màn, `EPIC:90`)? Độ dài mã OTP (thuộc US2) | Không trọng yếu — hiển thị / điều hướng |
| 10 | thiếu | AC9 (`US6:68`); wireframe màn 13 không vẽ Quay lại; US4 AC14 có quy tắc nút Lưu tắt khi chưa đủ 2 ô (`US4:79`), US6 không có | Nút Đăng ký tắt khi chưa nhập đủ 2 ô hay bật và báo lỗi? Ô chỉ toàn khoảng trắng? Màn 13 có nút Quay lại không, nếu có về đâu? | Không trọng yếu — UI; không đổi kết quả "chưa tạo tài khoản" |
| 11 | dẫn chiếu treo (thuộc US2) | `US2:47-48` \[__\]; `EPIC:146` | Số lần gửi / giờ, số lần sai, thời gian khóa — cần cho precondition AC7. Trùng US4 Q-11, **không hỏi lại**, chỉ theo dõi | Không trọng yếu (thuộc US2) — case AC7 `❓ Cần chốt` precondition |
| 12 | thiếu | `EPIC:206` BE trả mã lỗi; US6 không có cột mã lỗi; `tailieu/7-send-ma-otp.md`, `8-verify-ma-otp.md` nhận `uuid` tài khoản | API gửi OTP email / verify / tạo tài khoản cho US6 là gì (chưa có tài khoản nên API Zalo hiện có không áp dụng?); mã lỗi từng AC | Không trọng yếu — cột Error Code |
| 13 | thiếu | AC11 (`US6:71`), AC4 (`US6:61`) | Request Đăng ký đã tới BE nhưng response rớt: tài khoản đã tạo, màn báo lỗi, bấm lại → AC4? Người dùng được hướng dẫn gì; mật khẩu vừa đặt có hiệu lực? | Không trọng yếu (edge) — case `❓` |
| 14 | mơ hồ / tài liệu | Wireframe màn 11 (`US6:29`): "Điều khoản", "Chính sách bảo mật", "Đã có tài khoản? Đăng nhập", "Quay lại", "Ngoài IP Việt Nam: chỉ còn lựa chọn Email"; `US6:33` wireframe chỉ tham khảo; file nháp `Chình - … US6 …md` còn trong thư mục export | Các phần tử chỉ có trên wireframe có là yêu cầu không (link Điều khoản mở đâu)? Ngoài VN màn 11 bỏ thanh tab hay giữ tab Email đơn lẻ (thuộc US1 AC2)? Bản nháp "Chình" có còn hiệu lực không — AI dùng bản `06` theo tài liệu Hồng đính kèm | Không trọng yếu — hiển thị; bản hiệu lực hỏi Hồng |
| 15 | mơ hồ | AC9 `US6:68` "Mật khẩu xác nhận không khớp."; `TB2` màn 13 "Mật khẩu xác nhận không khớp. Vui lòng nhập lại."; `TB1` "Mật khẩu không khớp vui lòng nhập lại" | Ba chữ khác nhau cho cùng một tình huống; AC9 có thể chỉ trích phần đầu | Không trọng yếu — chữ hiển thị (`02` Q-20) |
| 16 | thiếu / mâu thuẫn nhẹ | `TB2` màn 13 "vô hiệu hóa nút **Lưu mật khẩu**"; wireframe màn 13 nút "Đăng ký" (`US6:29`); `TB1`/`TB2` không có dòng cho AC5 (không gửi được email), AC11 (mất mạng / lỗi hệ thống); `TB1` có chữ chung "Đã xảy ra lỗi…" | Tên nút ở màn 13 là gì (bảng có thể sao từ US1 05c / US4 04); AC5, AC11 vẫn không có nguyên văn | Không trọng yếu — chữ hiển thị (`02` Q-21, Q-07) |
| 17 | mơ hồ / nguồn | `bang-noi-dung-thong-bao.md` có hai bảng; không ghi tác giả, ngày, hiệu lực; `TB1` có dòng email nhắc "Số điện thoại", dòng US1 danh sách đen bị gạch ở `TB1` nhưng còn ở `TB2` | Bảng nào là bản hiệu lực; ai viết (BA, Design hay QA tự ghi); `TB` có đủ thẩm quyền để thành `[ĐÃ XÁC NHẬN]` không | Hồng trả lời (không gửi BA) — hiện coi `TB2` là `[NGUỒN]` chờ xác nhận |

## 10. Tự rà soát

- [x] Mọi mã ở mục 4–6 tìm thấy trong nguồn bản final (BR1–BR10 `US6:56-65`; AC1–AC19 + AC11a `US6:74-97`; E-xx có dòng dẫn, đã mở lại từng dòng của Epic / US2 / US3 / US5 / US7 / US9 bản final)
- [x] Không mục `[NGUỒN]` nào thiếu tham chiếu
- [x] Khác biệt giữa nguồn đã liệt kê: tài liệu ↔ Figma (link "Đổi số", gợi ý Spam, màn 14 "số điện thoại", nút Sao chép trong email, chữ lỗi mật khẩu) — theo tài liệu, ghi ở mục 12; tài liệu ↔ `TB2` (chữ lỗi mật khẩu) — theo tài liệu
- [x] Mục 13 không chứa câu trả lời do AI tự chọn
- [x] Số liệu: 10 BR, 25 quy tắc chung (E-01→E-25), 20 dòng AC (AC1–AC19 + AC11a), 21 câu hỏi cũ rà lại ở mục 12 (12 đóng hẳn, 5 đóng một phần, 4 còn mở), 4 điểm mới ở mục 13 — đếm từ bảng

## 12. Đối chiếu bản cũ (15/10) ↔ bản final (19/10) — thêm 2026-10-20

### 12a. Mã BR / AC

| Mã cũ | Nội dung cũ (rút gọn) | Mã mới | Thay đổi nội dung |
| --- | --- | --- | --- |
| BR1 | Chỉ email chưa gắn tài khoản | **BR2** | Thêm "kiểm tra trùng không phân biệt hoa/thường" |
| — | — | **BR1** (mới) | Quy định định dạng email (= câu Hường 2026-10-16, nay vào tài liệu); alias `+` là email khác |
| BR2 | Chỉ tạo tài khoản khi OTP + mật khẩu hợp lệ + khớp | **BR5** (+ **BR3**, **BR4** tách) | BR3 10 phút sau OTP; BR4 quy định mật khẩu (có ký tự đặc biệt, không khoảng trắng, không dấu TV; chữ hoa chờ Chiến) |
| BR3 | Không họ tên/SĐT; tên = email; 2 ô Hiện | **BR6** | Thêm "đăng nhập luôn (API trả token)"; phần 2 ô + Hiện chuyển lên mô tả màn 13 (`US6:49`) và `EPIC:91` |
| BR4 | Không giới hạn IP | **BR8** | Không đổi; Epic tạm hoãn kiểm tra IP VN cho cả US1 |
| BR5 | Chưa có SĐT → hạn mức thấp | **BR7** | Thêm "không dùng Pro" |
| — | — | **BR9** (mới) | Hai phiên cùng email (đóng Q-06) |
| — | — | **BR10** (mới) | Kiểm tra 2 lớp FE/BE (= E-13 cũ) |
| AC1 | Tab Email thay form cũ | **AC1** | Ghi rõ "không còn ô họ tên, SĐT" |
| AC2 | iOS | **AC2** | Không đổi |
| — | — | **AC3** (mới) | Ô trống / khoảng trắng → nút mờ (trả lời [US6_78] nhóm B) |
| AC3 | Sai định dạng | **AC4** | Có nguyên văn, bộ mẫu sai, vị trí lỗi, FE + BE |
| — | — | **AC5** (mới) | Cắt khoảng trắng, hoa/thường, alias `+` (đã có case [US6_74] [US6_77] [US6_14]) |
| AC4 | Email đã có tài khoản | **AC6** | Popup nguyên văn + đích hai nút (đóng Q-16, [US6_72]) |
| AC5 | Không gửi được email | **AC7** | Nguyên văn; ở lại 11 |
| — | — | **AC8** (mới) | Vượt 5 mã / chặn ngầm / hệ thống bận ở màn 11 → theo US2 |
| — | — | **AC9** (mới) | Bấm nhiều lần → đang tải, 1 yêu cầu |
| — | — | **AC10** (mới) | Trong 60 giây quay lại 11, gửi lại cùng email → vào thẳng 12 (trả lời [US6_62] bước 4 nhóm B) |
| — | — | **AC11a** (mới 19/10, không ghi người quyết định) | Đổi email quá 3 lần/ngày → lỗi tại ô |
| AC6 | Gửi mã hợp lệ → màn 12 | **AC11** | Có nguyên văn màn 12, "Đổi email", gợi ý Spam, đếm ngược 60 giây (đóng Q-09 phần hiển thị) |
| AC7 | Theo US2 | **AC13** | Không đổi; US2 đã có con số và nguyên văn |
| AC8 | OTP đúng → màn 13 | **AC12** | Không đổi |
| AC9 | Không đạt / không khớp | **AC15** + **AC16** (+ **AC14** mới nút mờ) | Nguyên văn hai lỗi; quy định mới (đóng Q-20, Q-21; Q-17 thu hẹp) |
| AC10 | Hợp lệ → tạo → màn 14 → workspace → ChatGoni | **AC17** | Thêm "đăng nhập luôn", nguyên văn màn 14 "với email" (đóng Q-19) |
| — | — | **AC18** (mới) | Back ở 13 → về 11 giữ email, xác thực cũ hết hiệu lực (đóng Q-10 phần Quay lại, [US6_81]) |
| AC11 | Bỏ ngang, mất mạng, lỗi hệ thống | **AC19** (a)(b)(c)(d) | Tách 4 tình huống, có nguyên văn (a), popup (b) + mã 30103, (c) theo Epic §6, (d) mở lại từ 11 (đóng Q-03, Q-04 phần tắt app, Q-06, Q-07 phần AC11) |

### 12b. Câu hỏi Q-01→Q-21 sau bản final

| Q | Trạng thái mới | Căn cứ trong bản final | Còn lại |
| --- | --- | --- | --- |
| Q-01 | **Mở** (không trọng yếu, giữ) | US6 / Epic bản final vẫn không nói về email đã được mời; `US9:57` vẫn liệt kê "được mời" | Case [US6_15] giữ `❓` |
| Q-02 | Đóng một phần | AC7: lỗi ở màn 11, nguyên văn `US6:81`; thử lại = bấm lại nút | Lần gửi thất bại có tính vào 5 mã/24 giờ không — tài liệu không nói → giữ `❓` cho [US6_19] bước 4 |
| Q-03 | **Đóng** | BR3 10 phút `US6:58`; AC19(a) `US6:97` | — |
| Q-04 | Đóng một phần | AC19(d) tắt app → mở lại từ 11; BR3 bỏ ngang → nhận mã mới; US2 AC20 ra nền ở màn OTP (`US2:98`) | Web F5 ở màn 12/13 và app ra nền ở màn 13 — tài liệu không nói → `❓` cho [US6_57] |
| Q-05 | Đóng một phần | BR6 / AC17: tài khoản tạo và **đăng nhập luôn** lúc bấm Đăng ký; workspace khi bấm "Bắt đầu sử dụng"; đăng nhập lại chưa có workspace → luồng tạo workspace (`US3:75`) | Thoát ở màn 14 rồi mở lại app: đã đăng nhập sẵn hay về màn 01 — không nói → `❓` cho [US6_49] |
| Q-06 | **Đóng** | BR9 `US6:64`; AC19(b) + 30103 | — |
| Q-07 | **Đóng** | Nguyên văn AC4, AC6, AC7, AC15, AC16, AC19(a); AC19(c) → `EPIC:125-126` | — |
| Q-08 | Mở (không trọng yếu) | BR6 "email đăng ký đầy đủ" không nói hoa/thường khi lưu | [US6_43] giữ `❓` |
| Q-09 | **Đóng** | Màn 12 `US6:48`, `US2:49-50`; US2 AC19 giữ sẵn giá trị khi Đổi email / Back; 6 số `US2:58`; "Gửi lại mã" sau đếm ngược | Figma "Đổi số" / thiếu Spam là lệch design → ghi nhận, không tính fail |
| Q-10 | Đóng một phần | AC14 nút mờ; AC18 Back; BR4 "không khoảng trắng" → ô toàn khoảng trắng là mật khẩu không hợp lệ | Cả hai ô cùng sai hiện lỗi ở ô nào — không nói → nhóm B giữ |
| Q-11 | **Đóng** | `US2:58-62` | — |
| Q-12 | Mở (không trọng yếu) | Chỉ có 30103, 30115, 30114; tên API chưa có | Cột Error Code |
| Q-13 | Mở (không trọng yếu) | AC19(c) "không có tài khoản dở dang"; bấm lại sau khi BE đã tạo → không nói rõ (gần AC19(b)/AC6) | [US6_59] giữ `❓` |
| Q-14 | Đóng một phần | Màn 11 `US6:47` có Điều khoản, Chính sách, "Đã có tài khoản? Đăng nhập", Back; ngoài VN không còn khác (BR8, `EPIC:96`) | Đích hai link Điều khoản / Chính sách; bản nháp Chình vẫn trong thư mục |
| Q-15 | Đóng (từ 15/10) | BR2 | — |
| Q-16 | **Đóng** | AC6: Đăng nhập → màn 01 điền sẵn email; Hủy → đóng, ở lại 11; một hành vi cho mọi loại tài khoản | — |
| Q-17 | **Thu hẹp** — còn `[CẦN XÁC NHẬN]` chữ hoa + chữ thường và nới 64 ký tự (`US6:112`, Chiến) | BR4 / AC15 đã chốt: 8–16, chữ, số, **ký tự đặc biệt**, không khoảng trắng, không dấu TV; nguyên văn lỗi | Mức trọng yếu do Hồng chốt lại (xem `02`) |
| Q-18 | **Đóng** | "Chặn email tạm thời / danh sách chặn email" ngoài phạm vi `US6:32`; giới hạn theo thiết bị là chặn ngầm US2 AC12 / AC8 `US6:82` với câu chung; `EPIC:137` | [US6_79] → chuyển sang AC8 (chặn ngầm); [US6_80] → ngoài phạm vi |
| Q-19 | **Đóng** | Màn 14 "với email" `US6:50`, `US6:94` | — |
| Q-20 | **Đóng** | AC16 `US6:93` | — |
| Q-21 | **Đóng** | Nút "Đăng ký" `US6:49`, `US6:91` | — |

## 13. Điểm chưa rõ mới từ bản final (chuyển sang Debate) — thêm 2026-10-20

| # | Loại | Trích dẫn + nguồn | Vì sao chưa rõ | Đề xuất mức |
| ---: | --- | --- | --- | --- |
| 18 | thiếu | AC11a "Đổi email quá 3 lần một ngày → Thông báo lỗi tại ô nhập 'Bạn đã gửi quá nhiều yêu cầu. Vui lòng thử lại sau.'" (`US6:85`); lịch sử "Thêm AC11a" không ghi người quyết định (`US6:119`); US2 BR6 chặn ngầm "không nêu lý do" (`US2:63`) | "Đổi email" đếm cái gì: số lần bấm "Đổi email" ở màn 12, hay số **email khác nhau** đã gửi mã từ một thiết bị / phiên trong ngày? "Một ngày" là 24 giờ trượt hay theo ngày lịch? Lần thứ 4 chặn ở đâu (màn 11 khi bấm Gửi mã, hay ngay khi bấm Đổi email)? Có tính chung với chặn ngầm thiết bị/IP của US2 BR6 không? | Không trọng yếu — cô lập: case riêng `❓`; các case khác không đổi email quá 3 lần |
| 19 | thiếu | AC8 "Vượt 5 mã/24 giờ, bị chặn ngầm, **hệ thống bận** → thông báo theo US2, ở lại 11" (`US6:82`); US2 chỉ có câu cho vượt giới hạn (AC11) và chặn ngầm (AC12) | "Hệ thống bận" ứng với câu nào — "Đã xảy ra lỗi. Vui lòng thử lại sau." (`EPIC:126`) hay câu chặn ngầm? Ngưỡng chặn ngầm theo thiết bị/IP chưa có (`US2:113`, `EPIC:165`) → không dựng được precondition | Không trọng yếu — case chặn ngầm `❓` precondition; vượt 5 mã kiểm được (môi trường test reset được bộ đếm, `EPIC:152`) |
| 20 | thiếu | AC10 "Đang trong 60 giây chờ, quay lại 11 và bấm gửi lại **cùng email** → vào thẳng 12 với đếm ngược còn lại" (`US6:84`); US2 BR3 chờ 60 giây "kể từ lần gửi gần nhất" (`US2:60`) | Quay lại 11 bằng Back / "Đổi email" rồi gõ **email khác** trong 60 giây → gửi mã mới ngay (đếm theo email) hay cũng bị chờ? Tài liệu chỉ nói "cùng email" | Không trọng yếu — case email khác trong 60 giây ghi `❓` |
| 21 | khác biệt nguồn | Tài liệu ↔ Figma: màn 12 link "Đổi email" (`US6:48`) / Figma "Đổi số"; có gợi ý Spam (`US6:48`) / Figma không; màn 14 "với email" (`US6:50`) / Figma "với số điện thoại"; email mẫu có nút "Sao chép" (`US2:52`) / Figma không; lỗi mật khẩu "gồm chữ, số và ký tự đặc biệt" (`US6:92`) / `TB2` + Figma US4 "chữ hoa, chữ thường…" | Tài liệu ghi "Giao diện theo Figma final" (`US6:43`) nhưng câu chữ hai bên lệch; tài liệu là bản 19/10 nên theo tài liệu; app theo Figma thì là lỗi design hay lỗi app? | Không trọng yếu — Expected theo tài liệu; app khác → ghi nhận + báo Design, không tự tính pass |

## Lịch sử cập nhật

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
| 2026-10-15 | AI (Requirement Analyst) — người dùng Hồng | Tạo file S3: đọc US6 (bản `06`), Epic, US1–US5, US7, US9, BUG10, tái dùng BA đã trả lời ở US4 (Q-01, Q-07, Q-11, Q-13); 5 BR, E-01→E-21, 11 AC, 14 điểm chưa rõ |
| 2026-10-16 | AI (Orchestrator) — Hồng gửi link Figma giao diện thật | Thêm nguồn #13 `FIGMA` + viết tắt; thêm mục 6d (9 dòng) đối chiếu 9 frame US6 + email mẫu với AC/BR và `02 §4`; ảnh 5/9 frame + lớp text lưu `figma/`. Phát sinh Q-17, Q-18 (đề xuất trọng yếu), Q-19; Q-09, Q-10, Q-16 bổ sung ý |
| 2026-10-16 | AI (Orchestrator) — Hồng gửi bảng nội dung thông báo, nhờ rà soát và áp vào chỗ cần thông báo | Thêm nguồn #14 `TB` + viết tắt; sửa mục 6b (thông báo AC3, AC4, AC5/AC11, AC9, nút ô trống, nhánh chặn); thêm mục 6e (11 dòng đối chiếu `TB`); mục 9 thêm điểm 15–17; số liệu mục 10 |
| 2026-10-20 | AI (Orchestrator) — Hồng đưa export mới vào `tailieu/` (bản final 19/10/2026) và yêu cầu cập nhật test case US6 | Viết lại theo bản final: banner đầu file; mục 1 (14 nguồn, version bản final), 2, 3, 4 (UC-01 theo AC mới), 5a (BR1–BR10), 5b (E-01→E-21 dòng dẫn mới, E-09/E-10/E-20 đổi nhãn, thêm E-22→E-25), 6a (AC1–AC19 + AC11a), 6b (thông báo / con số / mã lỗi theo bản final), 7 (trạng thái 10 phút, đếm ngược, workspace), 10 (số liệu). Mục 6c, 6d, 6e, 8, 9 giữ nguyên (bản cũ) với ghi chú đầu mục. Thêm mục 12 (đối chiếu mã cũ ↔ mới; Q-01→Q-21: 12 đóng, 5 đóng một phần, 4 mở) và mục 13 (điểm mới #18–#21: AC11a, AC8 hệ thống bận, AC10 email khác, lệch tài liệu ↔ Figma) |
