---
featureId: EPIC-SDT-US6
title: "[EPIC-SĐT] US6 – Đăng ký bằng email với xác thực OTP"
analyzedAt: 2026-10-15
analyst: Requirement Analyst (AI) — người dùng: Hồng (QA)
---

# Requirement Analysis — EPIC-SDT-US6: Đăng ký bằng email với xác thực OTP

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
| `TB` | `bang-noi-dung-thong-bao.md` — "Bảng nội dung thông báo" Hồng cung cấp trong phiên 2026-10-16, **tác giả chưa ghi**, không nằm trong `tailieu/`. Hai bảng: `TB1` (bảng đầu, bản thô: dòng lệch cột, lỗi chính tả, một dòng gạch bỏ) và `TB2` (bảng sau, đủ cột "Cách hiển thị", chỉ có US1 và US6). Dẫn theo màn + tình huống vì file không có số dòng ổn định |

Số sau dấu `:` là số dòng.

## 1. Nguồn và phạm vi đã đọc

| # | Tệp | Version ghi trong tệp | Phạm vi đã đọc | Ghi chú |
| ---: | --- | --- | --- | --- |
| 1 | `US6` | Không ghi version; không có changelog | Toàn bộ (76 dòng) + ảnh user flow (`US6:21`) + ảnh wireframe (`US6:29`) | Nguồn chính. Nội dung trùng khớp tài liệu Hồng đính kèm khi gọi `/qa-flow` |
| 2 | `Chình - [EPIC-SĐT] US6 – …md` (cùng thư mục) | Bản nháp cũ hơn: 12 AC, chữ "Gmail", AC7 ghi "OTP gửi qua Zalo" | Đã diff với `US6` | **Không dùng** — Hồng đính kèm bản `06`, coi bản `06` là hiệu lực (xem mục 9, điểm 14) |
| 3 | `EPIC` | Trạng thái "KHỞI TẠO"; changelog tới 13/10/2026 | §2, §3 (dòng 49, 57), §4 (74, 78, 84), §5 (88, 90), §6 (96–130), §7 (134–136), §8 (144–166), §10–11, §13 | Quy tắc chung; câu hỏi mở #3, #4, #5, #8, #22; changelog 08/10, 12/10, 13/10 |
| 4 | `US2` | — | Toàn bộ (78 dòng) | Giới hạn OTP dùng chung; màn 12, 06; email mẫu 23 |
| 5 | `US1` | — | Toàn bộ (77 dòng) | Luồng song song với US6 (đăng ký SĐT); AC1/AC2 tab; AC11 bỏ ngang |
| 6 | `US3` | — | §5 (36), §7 (52–53, 55) | Link Đăng ký ở màn 01; đăng nhập sau khi tạo tài khoản |
| 7 | `US4` | — | BR7–BR9 (53–55) | Đối chiếu: US4 có thời hạn 10 phút sau OTP, US6 không ghi |
| 8 | `US5` | — | §1 (7–8), §5 (39), BR1, BR2, BR7, BR8 (50–57), AC2–AC3 (66–67) | Sửa tên; email "Đã xác thực" không có nút Đổi |
| 9 | `US7` | — | BR2, BR6 (50, 54), AC1, AC3, AC4 (61, 63, 65) | Hạn mức thấp cho tài khoản chưa có SĐT |
| 10 | `US9` | — | BR1–BR3, BR8 (45–47, 52), AC2 (60) | Email Google = đã xác thực; email trùng → đăng nhập; nút Google ở màn 11 |
| 11 | `BUG10` | — | §5 (28), AC3–AC4 (36–37) | iOS không có đường vào đăng ký, kể cả deep link |
| 12 | `US4-AS` | updatedAt 2026-10-15 | Mục 3 (Q-01, Q-07, Q-11, Q-13), mục 4 dòng 19, 23 | Câu trả lời BA cho quy tắc **dùng chung** (mật khẩu, định dạng email, mẫu che) — tái dùng, không hỏi lại |
| 13 | `FIGMA` — mục "06 [EPIC-SĐT] US6" (9 frame + 1 popup tách), mục "Email OTP" frame 1859:3924 | Figma không ghi version | Lớp text của 10 frame (bóc qua Figma MCP); **ảnh xem được 5/9 frame** (11 trống, 11 lỗi định dạng, 11 email đã dùng, 12, 14) + email mẫu đăng ký — đọc 2026-10-16 | Giao diện thật (`US6:33`). Figma MCP chạm giới hạn gói Starter → 4 frame còn lại (12 bản thứ hai, 13, 11 "thiết bị vượt giới hạn", 11 "danh sách chặn") chỉ có tên frame + lớp text; chữ trong ô nhập / nút / badge **chưa đọc được**. Nội dung trích ở mục 6d |
| 14 | `TB` (`TB1`, `TB2`) | Không ghi version, không ghi tác giả | Toàn bộ hai bảng; chỉ dùng dòng US6 (màn 11, 13), dòng "Dùng chung", dòng US2 màn 05b-12 để đối chiếu | **Dùng `TB2` làm căn cứ cho US6; `TB1` chỉ để đối chiếu** — chưa ai xác nhận bảng nào hiệu lực (mục 9 điểm 17, `02 §4` dòng 27). Dòng US1, US3, US4 trong `TB` thuộc story khác, không đọc sâu |

Chưa đọc / ngoài phạm vi: US8 (admin hạn mức, không được US6 dẫn chiếu); `tailieu/7-send-ma-otp.md`, `8-verify-ma-otp.md`
(API OTP Zalo nhận `uuid` tài khoản — US6 chưa có tài khoản ở bước OTP nên chưa rõ có liên quan; xem mục 9 điểm 12).
Figma "Wireframe master" (`EPIC:88`) không có trong `tailieu/`; Figma giao diện thật (`FIGMA`) Hồng gửi 2026-10-16, đã đọc một phần (dòng 13, mục 6d). Hai ảnh wireframe đã xem, nội dung trích ở mục 4 và 8.

## 2. Mục tiêu và phạm vi feature `[NGUỒN]`

- Thay form đăng ký email cũ (họ tên, email, SĐT, mật khẩu, xác nhận mật khẩu — không xác thực) bằng luồng 3 bước:
  nhập email → OTP email → mật khẩu → đăng ký thành công (`US6:3`, `US6:7`, `EPIC:28`, `EPIC:221`).
- Người dùng mới "bắt đầu nhanh và chắc chắn email của tôi đúng" (`US6:11`); mục tiêu Epic: mọi tài khoản mới có
  email hoặc SĐT đã xác thực (`EPIC:36`).
- Trong phạm vi: tab "Email" trên màn đăng ký (Android, Web) thay form cũ; luồng 3 bước; màn đăng ký thành công (`US6:15`).
- Ngoài phạm vi: iOS · giới hạn OTP (US2) · Google (US9) (`US6:17`).
- Nền tảng Android, Web · Wireframe 11–14 · 11 AC · Priority High (`US6:3`). Trên mobile: màn riêng trong app, không
  phụ thuộc web (`EPIC:144`, `EPIC:207` — chốt 12/10, Hường).

## 3. Actor, precondition, trigger

| Mục | Nội dung | Nguồn | Nhãn |
| --- | --- | --- | --- |
| Actor | Người dùng mới, chưa có tài khoản Gopany | `US6:11` | `[NGUỒN]` |
| Precondition | Email chưa gắn tài khoản nào | `US6:46`, `EPIC:96` | `[NGUỒN]` |
| Precondition (nền tảng) | Android hoặc Web; không giới hạn IP | `US6:15`, `US6:49`, `EPIC:107` | `[NGUỒN]` |
| Trigger | Từ màn Đăng nhập bấm "Đăng ký" → màn 11, tab "Email" | user flow (`US6:21`), `US3:52` | `[NGUỒN]` |
| Post-condition | Tài khoản tạo với email "Đã xác thực", chưa có SĐT; tên hiển thị = email; workspace (nếu chưa có); vào ChatGoni chat ngay ở hạn mức thấp | `US6:48`, `US6:50`, `US6:69`, `EPIC:98` | `[NGUỒN]` |

## 4. Use case và luồng

| Mã | Tên | Main flow | Alternate flow | Exception flow | Nguồn |
| --- | --- | --- | --- | --- | --- |
| UC-01 | Đăng ký bằng email (Android, Web) | (1) Màn 11 tab Email, nhập email, bấm "Gửi mã xác thực" → (2) màn 12 nhập OTP nhận qua email, bấm Xác nhận → (3) màn 13 email "Đã xác thực", nhập Mật khẩu + Xác nhận mật khẩu, bấm Đăng ký → tạo tài khoản → (4) màn 14 Đăng ký thành công, tên hiển thị = email → tạo workspace (nếu chưa có) → ChatGoni chat ngay | AF-1 email sai định dạng → lỗi tại ô, không gửi mã, ở màn 11 (AC3) · AF-2 email đã có tài khoản → không gửi OTP, báo đã đăng ký, gợi ý Đăng nhập (AC4) · AF-3 nhập sai / hết hạn / gửi quá nhiều → theo US2 (AC7) · AF-4 bấm "Đổi email" ở màn 12 → về nhập email (AC6, wireframe) · AF-5 mật khẩu không đạt / không khớp → lỗi tại ô, chưa tạo tài khoản (AC9) · AF-6 bấm "Tiếp tục với Google" → US9 | E-1 không gửi được email → báo lỗi, cho thử lại (AC5) · E-2 bỏ ngang, mất mạng, lỗi hệ thống → chưa tạo tài khoản, báo lỗi tiếng Việt, cho thử lại (AC11) | `US6:57-71`, user flow `US6:21`, wireframe `US6:29`, `EPIC:74` |
| UC-02 | iOS không có đường vào đăng ký | Dùng app iOS theo mọi đường (back, link trong trang, deep link) → không vào được màn đăng ký | — | — | `US6:58`, `EPIC:108`, `BUG10:28`, `BUG10:36` |

Thứ tự kiểm tra ở bước 1 theo user flow (`US6:21`): định dạng (AC3) → email đã có tài khoản? (BR1 → AC4) → gửi email
được? (không → AC5; được → màn 12). `[NGUỒN]` ảnh user flow.

## 5. Business rule

### 5a. BR của US6 (mã gốc)

| Mã | Nội dung (sát nguyên văn) | Loại | Nguồn | Nhãn |
| --- | --- | --- | --- | --- |
| BR1 | Chỉ email chưa gắn tài khoản nào mới được đăng ký. | nghiệp vụ / dữ liệu | `US6:46` | `[NGUỒN]` |
| BR2 | Chỉ tạo tài khoản khi đã xác thực OTP, mật khẩu hợp lệ và ô "Xác nhận mật khẩu" khớp với ô "Mật khẩu". | nghiệp vụ | `US6:47` | `[NGUỒN]` |
| BR3 | Không nhập họ tên, SĐT; họ tên tự tạo = email đăng ký (VD: nguyenvana@congty.vn), sửa được trong Thông tin tài khoản (US5). Bước 3 có 2 ô: Mật khẩu và Xác nhận mật khẩu, mỗi ô có nút Hiện. | dữ liệu / UI | `US6:48` | `[NGUỒN]` |
| BR4 | Không giới hạn IP. | nghiệp vụ | `US6:49` | `[NGUỒN]` |
| BR5 | Tài khoản email mới **chưa có SĐT** → ChatGoni ở hạn mức thấp cho đến khi thêm SĐT (US7). | nghiệp vụ | `US6:50` | `[NGUỒN]` |

### 5b. Quy tắc chung từ Epic và story liên quan áp vào US6 (mã QA tự đánh `E-xx`)

| Mã | Nội dung (sát nguyên văn) | Nguồn | Nhãn |
| --- | --- | --- | --- |
| E-01 | Mỗi SĐT và mỗi email chỉ gắn với **một** tài khoản. | `EPIC:96` | `[NGUỒN]` |
| E-02 | Email so khớp không phân biệt hoa/thường. | `EPIC:97` | `[NGUỒN]` |
| E-03 | SĐT/email chỉ được lưu vào tài khoản **sau khi xác thực**; không có trạng thái "Chưa xác thực" — chỉ "Chưa có" hoặc "Đã xác thực". | `EPIC:98`, `US5:51` | `[NGUỒN]` |
| E-04 | Không nhập họ tên: họ tên tự tạo = SĐT hoặc email đăng ký; sửa trong Thông tin tài khoản. Chốt 12/10 (Hường). | `EPIC:104`, `EPIC:148`, `EPIC:209` | `[NGUỒN]` |
| E-05 | Bước tạo mật khẩu có 2 ô Mật khẩu và Xác nhận mật khẩu – phải khớp nhau; mỗi ô có nút Hiện. Thêm 12/10. | `EPIC:105`, `EPIC:215` | `[NGUỒN]` |
| E-06 | Chỉ tạo tài khoản khi đã xác thực OTP **và** nhập mật khẩu hợp lệ. Bỏ ngang sau OTP → chưa tạo tài khoản. | `EPIC:106` | `[NGUỒN]` |
| E-07 | Đăng ký email không giới hạn IP (đăng ký SĐT chỉ IP VN; không xác định được IP → coi như ngoài VN). | `EPIC:107`, `US1:45` | `[NGUỒN]` |
| E-08 | iOS: không có bất kỳ đường nào vào màn đăng ký. | `EPIC:108`, `EPIC:31`, `BUG10:28` | `[NGUỒN]` |
| E-09 | Quy định mật khẩu: Epic để trống "\[ghi quy định hiện tại – BE xác nhận\]", áp dụng chung mọi luồng; câu hỏi #4: "8-16 ký tự gồm chữ và số". **BA đã trả lời ở US4 Q-01:** 8–16 ký tự, ≥1 chữ **và** ≥1 số, ký tự khác cho phép. | `EPIC:112`, `EPIC:147`; `US4-AS` mục 3 Q-01, mục 4 dòng 19 | `[ĐÃ XÁC NHẬN]` (BA, 2026-10-15, Hồng chuyển ở phiên US4 — tài liệu chưa cập nhật) |
| E-10 | OTP: kênh theo thông tin nhập (email → email); email gửi mã ghi rõ Gopany, mã, thời hạn, nhắc không chia sẻ; hiệu lực 5 phút; chờ 1 phút mới gửi lại; tối đa \[__\] lần/\[__\] giờ mỗi email tính chung mọi luồng; sai \[__\] lần → khóa \[__\] phút; gửi mã mới thì mã cũ hết hiệu lực. | `EPIC:121-122`, `US2:44-48` | `[NGUỒN]` — con số trong \[__\] chưa chốt (`EPIC:146`, `US2:75`) |
| E-11 | Chưa xác thực SĐT (tài khoản chưa có SĐT): hạn mức thấp, mặc định 3 câu/5 giờ, không dùng Pro; chỉnh trong Admin (US8). | `EPIC:127`, `EPIC:129`, `US7:50`, `US7:54` | `[NGUỒN]` |
| E-12 | ChatGoni: vào là chat ngay (mặc định Tức thì); đăng ký xong vào ChatGoni không có popup. | `EPIC:84`, `US7:61` | `[NGUỒN]` |
| E-13 | Kiểm tra dữ liệu 2 lớp: FE kiểm định dạng tại ô, BE kiểm lại toàn bộ + quy tắc nghiệp vụ, trả mã lỗi (13/10, Hường). | `EPIC:206` | `[NGUỒN]` |
| E-14 | Màn OTP ở các luồng là **cùng một màn**, chỉ khác tiêu đề, kênh gửi và màn tiếp theo. Màn 12 = nhập OTP email. | `EPIC:90`, `US2:36` | `[NGUỒN]` |
| E-15 | Màn OTP email: email che một phần, nút "Đổi email", gợi ý kiểm tra Spam/Quảng cáo; nút "Gửi lại mã" mờ, đếm ngược 60 giây. | `US2:56`, `US2:59` | `[NGUỒN]` |
| E-16 | Email gửi mã đăng ký là mẫu 23: có tên Gopany, mã, thời hạn, lời nhắc không chia sẻ; không có nút/liên kết, tiêu đề chứa mã. | `US2:38`, `US2:57` | `[NGUỒN]` |
| E-17 | Email Google được tính là email đã xác thực; email Google trùng email tài khoản đã có (đăng ký email, form cũ, được mời) → đăng nhập, không tạo mới. | `US9:45-46` | `[NGUỒN]` — dùng để đối chiếu BR1 (xem mục 9 điểm 1) |
| E-18 | Màn đăng ký (Android, Web) có nút "Tiếp tục với Google". | `US9:60`, `US6:33` | `[NGUỒN]` — hành vi nút thuộc US9 |
| E-19 | Tạm thời không cho đổi email với mọi tài khoản; Thông tin tài khoản hiện email "Đã xác thực" không có nút Đổi; họ tên sửa tự do, không để trống. | `US5:56`, `US5:66`, `US5:50` | `[NGUỒN]` — hậu kiểm sau đăng ký |
| E-20 | Hai phiên xác thực đồng thời cùng SĐT/email: Chiến **đề xuất** chặn phiên đang diễn ra — chưa chốt. | `EPIC:165` (#22) | `[NGUỒN]` là đề xuất, không phải quy tắc |
| E-21 | DoD: luồng email/Google hiện tại không bị ảnh hưởng; test Android + web Chrome/Safari. | `EPIC:193-194` | `[NGUỒN]` |

Mã do QA tự đánh: E-01 → E-21 (vị trí gốc ghi ở cột Nguồn). BR1–BR5, AC1–AC11 là mã gốc của `US6`.

## 6. Acceptance criteria, mã lỗi, thông báo, giới hạn số

### 6a. AC của US6 (nguyên văn)

| Mã | Tình huống | Kết quả mong đợi | Nguồn |
| --- | --- | --- | --- |
| AC1 | Mở đăng ký trên Android/Web | Tab "Email" thay cho form cũ | `US6:57` |
| AC2 | Dùng app iOS theo mọi đường | Không vào được màn đăng ký | `US6:58` |
| AC3 | Email sai định dạng | Báo lỗi tại ô, không gửi mã | `US6:60` |
| AC4 | Email đã có tài khoản | Không gửi OTP; báo đã đăng ký, gợi ý Đăng nhập | `US6:61` |
| AC5 | Không gửi được email | Báo lỗi, cho thử lại | `US6:62` |
| AC6 | Bấm "Gửi mã xác thực" hợp lệ | OTP gửi qua email; màn OTP hiện email che một phần, nút Đổi email, gợi ý kiểm tra Spam | `US6:64` |
| AC7 | Nhập sai / hết hạn / gửi quá nhiều | Theo US2 | `US6:65` |
| AC8 | Nhập đúng OTP | Sang bước tạo mật khẩu, email hiện "Đã xác thực" | `US6:66` |
| AC9 | Mật khẩu không đạt quy định, hoặc ô Xác nhận mật khẩu không khớp | Báo lỗi tại ô tương ứng ("Mật khẩu xác nhận không khớp."), chưa tạo tài khoản | `US6:68` |
| AC10 | Mật khẩu hợp lệ, bấm Đăng ký | Tạo tài khoản → Đăng ký thành công (tên hiển thị = email đăng ký + gợi ý đổi tên) → tạo workspace (nếu chưa có) → ChatGoni chat ngay | `US6:69` |
| AC11 | Bỏ ngang, mất mạng, lỗi hệ thống | Chưa tạo tài khoản; báo lỗi tiếng Việt, cho thử lại | `US6:71` |

### 6b. Thông báo, giới hạn số, mã lỗi

| Mục | Nguyên văn | Nguồn | Ghi chú |
| --- | --- | --- | --- |
| Thông báo không khớp | "Mật khẩu xác nhận không khớp." (AC9) · `TB2` màn 13: "Mật khẩu xác nhận không khớp. Vui lòng nhập lại." · `TB1` màn 13 (nháp): "Mật khẩu không khớp vui lòng nhập lại" | `US6:68`; `TB2`; `TB1` | Ba chữ khác nhau; `TB2` chứa nguyên văn AC9 và thêm hậu tố → mục 9 điểm 15 |
| Thông báo AC3 | "Email không đúng định dạng" (PdM Hường, 2026-10-16) · `TB2` màn 11: "Email không đúng định dạng." | `02 §4` dòng 21; `TB2` | Khác nhau dấu chấm cuối; cùng nội dung. Hiện **dưới ô Email**, ô ở trạng thái lỗi (`TB2`) |
| Thông báo AC4 | "Email này đã được đăng ký. Bạn có muốn đăng nhập không?" — hộp thoại giữa màn hình, nút "Đăng nhập" và "Hủy" | `TB2` màn 11; `FIGMA 1819:5176` | Khớp Figma. `TB1` (nháp): "Email đã đăng kí. đăng nhập". "Hủy" làm gì không nói |
| Thông báo AC5, AC11 | Không có trong `TB2` và không có frame Figma. `TB1` (nháp) có hai chữ chung: "Đã xảy ra lỗi. Vui lòng kiểm tra và thử lại." (dùng chung) và "Chưa thể gửi mã xác thực. Vui lòng thử lại sau." (màn 05b-12 "Gửi OTP không thành công") | `TB1` | Ứng viên, **không áp** làm expected; → mục 9 điểm 16 / Q-07 |
| Thông báo AC9 — không đạt quy định | `TB2` màn 13: "Mật khẩu phải có từ 8–16 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt." — hiện **dưới ô Mật khẩu** | `TB2` | **Mâu thuẫn** với BA (US4 Q-01: ≥1 chữ và ≥1 số) → `02` Q-17, cổng đóng cho phần này |
| Nút ở màn 13 / màn 11 khi ô trống | Màn 11 chưa nhập email → nút "Gửi mã xác thực" vô hiệu, không thông báo. Màn 13 một hoặc cả hai ô trống → "nút **Lưu mật khẩu**" vô hiệu, không thông báo | `TB2` | Nút màn 13 wireframe là "Đăng ký" (`US6:29`) → mục 9 điểm 16 / Q-21 |
| Hai nhánh chặn màn 11 | Thiết bị vượt giới hạn: thông báo trên form gần ô email, vô hiệu nút "Gửi mã xác thực" trong thời gian bị giới hạn — "Bạn đã vượt giới hạn \[X\] email trên thiết bị này. Vui lòng thử lại sau \[Y\] giờ." · Email thuộc danh sách chặn: lỗi dưới ô Email — "Email này hiện không được phép sử dụng. Vui lòng nhập email khác." | `TB2` | Không có BR/AC trong US6, Epic; \[X\], \[Y\] trống → `02` Q-18 (đã đóng cổng) |
| Quy định mật khẩu | "8-16 ký tự gồm chữ và số" (Epic #4); BA chốt ở US4: 8–16, ≥1 chữ và ≥1 số | `EPIC:147`; `US4-AS` Q-01 | E-09; wireframe màn 13 "Tối thiểu \[__\] ký tự" |
| OTP: hiệu lực 5 phút, gửi lại sau 1 phút (60 giây) | — | `US2:45-46`, `US2:59` | Đã chốt 12/10 |
| OTP: số lần gửi/giờ, số lần sai, thời gian khóa | \[__\] | `US2:47-48`, `EPIC:146` | Chưa chốt — thuộc US2 (US4 Q-11 cũng chờ) |
| Độ dài mã OTP | "Mã \[__\] số" | wireframe màn 12 (`US6:29`) | Wireframe vẽ 6 ô; không có chữ → mục 9 |
| Hạn mức thấp | Mặc định 3 câu/5 giờ | `EPIC:127`, `US7:50` | Thuộc US7/US8 |
| Mã lỗi BE | Không có | `EPIC:206` nói BE trả mã lỗi | → mục 9 |

### 6c. Nội dung chỉ có trên wireframe (`US6:29`) — "tham khảo luồng, giao diện thật theo Figma" (`US6:33`)

| Màn | Nội dung trên wireframe | Nhãn |
| --- | --- | --- |
| 11 | "Quay lại"; "Bước 1/3"; tiêu đề "Đăng ký – Tạo tài khoản Gopany bằng email"; thanh tab "Số điện thoại / Email"; ô Email placeholder "Nhập email", gợi ý "Mã xác thực sẽ gửi tới email này."; nút "Gửi mã xác thực"; "Hoặc" + "Tiếp tục với Google"; khung ghi chú "Báo lỗi ngay ở bước này: Email sai định dạng · Email đã có tài khoản (gợi ý Đăng nhập) · Không gửi được email. Ngoài IP Việt Nam: chỉ còn lựa chọn Email."; dòng "Bằng việc đăng ký, bạn đồng ý với Điều khoản và Chính sách bảo mật."; "Đã có tài khoản? Đăng nhập" | `[NGUỒN]` wireframe — chỉ tham khảo, không làm expected nguyên văn |
| 12 | "Quay lại"; "Bước 2/3"; "Xác thực email"; "Mã \[__\] số đã được gửi tới ng•••••@congty.vn. Đổi email"; 6 ô mã; "Chưa nhận được mã? Gửi lại mã sau 00:45"; khung "Không thấy email? Kiểm tra hộp thư Spam hoặc Quảng cáo."; nút "Xác nhận"; ghi chú "Cùng màn OTP với 05b, chỉ đổi kênh gửi: email thay vì Zalo. Lỗi OTP: xem màn 06." | `[NGUỒN]` wireframe |
| 13 | "Bước 3/3"; "Tạo mật khẩu"; "nguyenvana@congty.vn" + nhãn "Đã xác thực"; ô Mật khẩu placeholder "Tối thiểu \[__\] ký tự" + Hiện; ô Xác nhận mật khẩu "Nhập lại mật khẩu" + Hiện; nút "Đăng ký"; ghi chú "Giống màn 05c. Không nhập họ tên – họ tên tự tạo = email đăng ký. Ô Xác nhận mật khẩu phải khớp ô Mật khẩu. Bỏ ngang ở bước này: chưa tạo tài khoản." **Không vẽ nút Quay lại.** | `[NGUỒN]` wireframe |
| 14 | "Đăng ký thành công"; "Tài khoản của bạn đã được tạo với email nguyenvana@congty.vn."; "Tên hiển thị: nguyenvana@congty.vn — Bạn có thể đổi trong Tài khoản › Thông tin tài khoản."; nút "Bắt đầu sử dụng"; ghi chú "Bấm → tạo workspace (nếu chưa có) → vào ChatGoni (màn 15), chat ngay." | `[NGUỒN]` wireframe — AC10 không nhắc nút này (mục 9 điểm 5) |

### 6d. Nội dung trên Figma giao diện thật (`FIGMA`, đọc 2026-10-16)

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

### 6e. Bảng nội dung thông báo (`TB`, Hồng cung cấp 2026-10-16) — đối chiếu với AC/BR

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

Tài liệu không định nghĩa máy trạng thái cho phiên đăng ký. Trạng thái dữ liệu có trong nguồn:

| Đối tượng | Trạng thái | Chuyển | Nguồn | Nhãn |
| --- | --- | --- | --- | --- |
| Email trên tài khoản | "Chưa có" / "Đã xác thực" (không có "Chưa xác thực") | Tài khoản tạo xong (AC10) → email "Đã xác thực" | `EPIC:98`, `US5:51`, `US6:66` | `[NGUỒN]` |
| SĐT trên tài khoản mới | "Chưa có" | Thêm SĐT ở US5 hoặc US7 → "Đã xác thực" | `US6:50`, `US7:54` | `[NGUỒN]` |
| Tài khoản | Chưa tồn tại → tồn tại | Chỉ tại thời điểm "Tạo tài khoản" sau bấm Đăng ký với OTP đã xác thực + mật khẩu hợp lệ; mọi bỏ ngang trước đó → chưa tồn tại | `US6:47`, `US6:69`, `US6:71`, `EPIC:106` | `[NGUỒN]` |
| Phiên đăng ký (bước 1 → 2 → 3) | Email nhập → OTP đã gửi → OTP đã xác thực → tài khoản tạo | Không ghi thời hạn giữa "OTP đã xác thực" và "tạo tài khoản" (US4 có 10 phút, US6 không) | `US6:66-69`; đối chiếu `US4:53-54` | `[DIỄN GIẢI AI]` — mục 9 điểm 3 |

## 8. Diễn giải, giả định, QA observation

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

## 9. Điểm chưa rõ (chuyển sang Debate)

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

- [x] Mọi mã ở mục 4–6 tìm thấy trong nguồn (BR1–BR5 `US6:46-50`; AC1–AC11 `US6:57-71`; E-xx có dòng dẫn)
- [x] Không mục `[NGUỒN]` nào thiếu tham chiếu
- [x] Mâu thuẫn / khác biệt giữa nguồn đã liệt kê đủ hai phía (US6 vs US1 AC10/AC11; US6 vs US4 thời hạn sau OTP; AC10 vs wireframe màn 14)
- [x] Mục 9 không chứa câu trả lời do AI tự chọn
- [x] Số liệu: 5 BR, 21 quy tắc chung, 11 AC, 17 điểm chưa rõ ở mục 9 (5 đề xuất trọng yếu, 12 không; Q-17→Q-19 phát sinh từ Figma ghi ở mục 6d) — đếm từ bảng

## Lịch sử cập nhật

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
| 2026-10-15 | AI (Requirement Analyst) — người dùng Hồng | Tạo file S3: đọc US6 (bản `06`), Epic, US1–US5, US7, US9, BUG10, tái dùng BA đã trả lời ở US4 (Q-01, Q-07, Q-11, Q-13); 5 BR, E-01→E-21, 11 AC, 14 điểm chưa rõ |
| 2026-10-16 | AI (Orchestrator) — Hồng gửi link Figma giao diện thật | Thêm nguồn #13 `FIGMA` + viết tắt; thêm mục 6d (9 dòng) đối chiếu 9 frame US6 + email mẫu với AC/BR và `02 §4`; ảnh 5/9 frame + lớp text lưu `figma/`. Phát sinh Q-17, Q-18 (đề xuất trọng yếu), Q-19; Q-09, Q-10, Q-16 bổ sung ý |
| 2026-10-16 | AI (Orchestrator) — Hồng gửi bảng nội dung thông báo, nhờ rà soát và áp vào chỗ cần thông báo | Thêm nguồn #14 `TB` + viết tắt; sửa mục 6b (thông báo AC3, AC4, AC5/AC11, AC9, nút ô trống, nhánh chặn); thêm mục 6e (11 dòng đối chiếu `TB`); mục 9 thêm điểm 15–17; số liệu mục 10 |
