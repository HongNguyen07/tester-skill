---
featureId: EPIC-SDT-US4
title: "[EPIC-SĐT] US4 – Quên mật khẩu bằng số điện thoại hoặc email"
analyzedAt: 2026-10-15
analyst: Requirement Analyst (AI) — người dùng: Hồng (QA)
---

# Requirement Analysis — EPIC-SDT-US4: Quên mật khẩu bằng số điện thoại hoặc email

Viết tắt tham chiếu (tất cả nằm trong
`tailieu/Signup] Đăng ký, đăng nhập bằng số điện thoại & hạn mức ChatGoni-export.markdown/`):

| Viết tắt | Tệp |
| --- | --- |
| `US4` | `00  [EPIC].../04  [EPIC-SĐT] US4 – Quên mật khẩu bằng số điện thoại hoặc email.md` |
| `EPIC` | `00  [EPIC][Login%2FSignup] Đăng ký, đăng nhập bằng số điện thoại & hạn mức ChatGoni.md` |
| `US1` / `US2` / `US3` / `US9` | file `01 … US1`, `02 … US2`, `03 … US3`, `09 … US9` cùng thư mục với US4 |
| `BUG10` | `10  [BUG][iOS][Login] App iOS vào được màn đăng ký qua Quên mật khẩu → back.md` |
| `API7` / `API8` | `tailieu/7-send-ma-otp.md` / `tailieu/8-verify-ma-otp.md` |
| `FIGMA` | Figma "Gopany v1.1", trang "↳ Mobile app" (`https://www.figma.com/design/aPKF4iF1YI2FPUwvdrz56V/Gopany-v1.1?node-id=1609-4700`) — Hồng gửi 2026-10-16; **khác** file "Wireframe master" ở `EPIC:88`. Dẫn theo id frame, vd `FIGMA 1754:6840`. Ảnh và lớp text đã lưu trong `figma/` cùng thư mục |

Số sau dấu `:` là số dòng.

## 1. Nguồn và phạm vi đã đọc

| # | Tệp | Version ghi trong tệp | Phạm vi đã đọc | Ghi chú |
| ---: | --- | --- | --- | --- |
| 1 | `US4` | Không ghi version; changelog 14/10/2026 (`US4:95`) | Toàn bộ (98 dòng) + ảnh user flow (`US4:22`) + ảnh wireframe (`US4:30`) | Nguồn chính |
| 2 | `EPIC` | Trạng thái "KHỞI TẠO"; changelog tới 13/10/2026 | §2, §3, §4 (dòng 81), §6 (92–131), §7, §8 câu hỏi mở (141–167), §13 | Quy tắc chung, câu hỏi mở #3, #4, #11, #20–#23 |
| 3 | `US2` | — | Toàn bộ (78 dòng) | Giới hạn OTP dùng chung; màn 06, 12 |
| 4 | `US3` | — | §3, §6, §7 (39–61) | Tạm khóa đăng nhập; màn 01 |
| 5 | `US9` | — | §6, §7, §8 (41–78) | BR6 Google đặt mật khẩu qua Quên mật khẩu; AC9 |
| 6 | `US1` | — | §5 bảng màn (36–39), BR4 (48), AC9 (67) | Màn 05c dùng chung với màn 04 |
| 7 | `BUG10` | — | Toàn bộ (37 dòng) | iOS không có đường vào đăng ký từ Quên mật khẩu |
| 8 | `API7`, `API8` | Changelog tới 2026-10-02 | Toàn bộ | API OTP Zalo hiện có; **chưa rõ có phải API dùng cho US4** (xem mục 9) |
| 9 | `US5` (Thông tin tài khoản) | — | Toàn bộ (89 dòng) — đọc 2026-10-16 | BR8, AC11, AC13 (email mới thêm → lấy lại mật khẩu được); AC14 (đổi SĐT → số cũ không đăng nhập được); BR3 (thêm/đổi SĐT cần mật khẩu hiện tại); §8 câu hỏi Google chưa có mật khẩu |
| 10 | `US6`, bản "Chình – US6", `US7`, bản nháp `US8` | — | Quét theo từ khóa (quên mật khẩu, mật khẩu, đăng xuất, khóa, OTP, phiên) 2026-10-16 | Không có quy tắc nào về luồng quên mật khẩu ngoài US1/US6 AC "đã có tài khoản → báo đã đăng ký" (xem mục 9 #18). US8 không có cấu hình OTP |
| 11 | `nguon/bang-noi-dung-thong-bao-2026-10-16.md` (viết tắt `TB`) | Không ghi version, không ghi tác giả; Hồng gửi 2026-10-16 | Toàn bộ (64 dòng). Áp cho US4: dòng 5–25 (US2 màn OTP 05b-12, US3 màn 01, US4 màn 02/04) và dòng 43 (Dùng chung). Dòng 26–42, 47–64 thuộc US1/US6 — chỉ dùng để đối chiếu | Hai bảng: bảng 1 (dòng 3–43) có dòng thiếu ô Story, dòng trống, lỗi chính tả ("VuI", "Tạp khóa"), một dòng chưa viết xong (dòng 14 "Không thể"); bảng 2 (dòng 47–64) đã chuẩn hóa nhưng chỉ có US1/US6 |
| 11 | `FIGMA` — mục "04 [EPIC-SĐT] US4" (10 frame), mục "Email OTP" frame 1872:4430, mục "03 US3" frame 1634:21845 | Figma không ghi version | Lớp text của 10 frame US4 (bóc qua Figma MCP); **ảnh chỉ xem được 2/10 frame** (1754:6840 màn 04 lỗi không khớp, 1774:7086 màn 03 email) + email mẫu "Đặt lại mật khẩu" + màn 01 — đọc 2026-10-16 | Giao diện thật (`US4:34`). Figma MCP chạm giới hạn gói Starter giữa chừng → 8 frame còn lại chỉ có tên frame + lớp text; **chữ trong ô nhập / nút / lỗi của 8 frame đó chưa đọc được**. Nội dung trích ở mục 4b |
Chưa đọc trọn: US6 (hai bản), US7, US8 — chỉ quét từ khóa (dòng 10), vì không quy định hành vi quên mật khẩu. Figma "Wireframe master" (`EPIC:88`) không có trong `tailieu/`; Figma giao diện thật (`FIGMA`) Hồng gửi 2026-10-16, đã đọc một phần (dòng 11, mục 4b). Ảnh user flow và wireframe đã xem; nội dung trích ở mục 4 và 8. US5 đọc trọn ngày 2026-10-16 sau khi Hường nêu bộ đếm OTP tính chung với "thêm/đổi SĐT".

## 2. Mục tiêu và phạm vi feature `[NGUỒN]`

- Người dùng quên mật khẩu lấy lại bằng SĐT hoặc email qua OTP, "không cần nhờ hỗ trợ" (`US4:12`).
- Thay cách hiện tại chỉ gửi **liên kết** qua email, vì người đăng ký bằng SĐT có thể không có email (`US4:7-8`).
- Trong phạm vi: 1 ô "Email hoặc số điện thoại"; OTP qua Zalo (SĐT) hoặc email; màn mật khẩu mới + xác nhận; đăng xuất
  mọi thiết bị sau khi đổi; mobile làm màn riêng trong app thay trang app.gopany.com (`US4:16`).
- Ngoài phạm vi: liên kết đặt lại mật khẩu qua email (bỏ) · đổi mật khẩu khi đang đăng nhập · OTP qua SMS (`US4:18`).
- Nền tảng: Android, iOS, Web · Priority High (`US4:3`).

## 3. Actor, precondition, trigger

| Mục | Nội dung | Nguồn | Nhãn |
| --- | --- | --- | --- |
| Actor | Người dùng Gopany quên mật khẩu (chưa đăng nhập) | `US4:12` | `[NGUỒN]` |
| Precondition | SĐT/email đã gắn tài khoản mới nhận được OTP | `US4:48` | `[NGUỒN]` |
| Precondition (Google) | Tài khoản tạo bằng Google cũng đi được luồng này bằng email Google | `US4:52`, `US9:50` | `[NGUỒN]` — nhưng US9 BR6 ghi "Đề xuất – câu hỏi mở #11", xem mục 9 |
| Trigger | Bấm "Quên mật khẩu" ở màn đăng nhập (màn 01) | `US4:62`, `US3:51` | `[NGUỒN]` |
| Post-condition | Mật khẩu cũ hết hiệu lực; đăng xuất mọi thiết bị; gỡ tạm khóa đăng nhập; về màn đăng nhập, không tự đăng nhập | `US4:50`, `EPIC:115` | `[NGUỒN]` |

## 4. Use case và luồng

| Mã | Tên | Main flow | Alternate flow | Exception flow | Nguồn |
| --- | --- | --- | --- | --- | --- |
| UC-01 (mã QA đặt) | Quên mật khẩu bằng SĐT/email | 01 Đăng nhập → bấm Quên mật khẩu → 02 nhập email/SĐT → Tiếp tục → đúng định dạng? → đã gắn tài khoản? → SĐT hay email? → gửi OTP Zalo (AC3) / email (AC4) → 03 nhập OTP → đúng mã (AC8) → 04 mật khẩu mới + xác nhận → Lưu → đổi mật khẩu, đăng xuất mọi thiết bị, gỡ tạm khóa (BR4, AC11) → 01 với thông báo thành công (AC10) | Email/SĐT chưa gắn tài khoản → không gửi mã, vẫn hiện thông báo chung (AC5) · Hết 10 phút ở màn 04 → về màn 02 điền sẵn, bấm Tiếp tục nhận mã mới (AC15) · App ra nền rồi quay lại (AC17) | Sai định dạng → lỗi tại ô (AC2) · Lỗi gửi Zalo/email → báo lỗi, gợi ý kênh còn lại hoặc hỗ trợ (AC6) · Sai/hết hạn/gửi quá nhiều → theo US2 (AC7) · Mật khẩu không đạt/không khớp → lỗi tại ô (AC9) · Bỏ ngang, mất mạng, lỗi hệ thống → mật khẩu chưa đổi (AC12) · Lưu sau mốc hết hạn → BE từ chối (AC16) | Ảnh user flow `US4:22`; `US4:62-83` |

Màn hình (`US4:38-41`, ảnh wireframe `US4:30`):

| Màn | Nội dung trong bảng US4 | Nội dung đọc được trên ảnh wireframe | Nhãn |
| --- | --- | --- | --- |
| 02 | Nhập email hoặc số điện thoại | Link "Quay lại đăng nhập"; tiêu đề "Quên mật khẩu"; câu hướng dẫn như AC1; ô "Email hoặc số điện thoại", placeholder "Nhập email hoặc số điện thoại"; nút "Tiếp tục"; ghi chú "Sau khi bấm Tiếp tục, luôn hiện cùng một thông báo dù email/SĐT có tồn tại hay không" | `[NGUỒN]` |
| 03 | Nhập OTP (Zalo hoặc email) | "Quay lại"; "Nhập mã xác thực"; "Mã [__] số đã được gửi qua **Zalo** tới số 09•• ••• 678. Đổi số"; 6 ô mã; "Chưa nhận được mã?" / "Gửi lại mã sau 00:45"; nút "Xác nhận"; ghi chú: nhập email → hiện email che một phần, nút "Đổi email", gợi ý kiểm tra Spam (giống màn 12); lỗi OTP xem màn 06 | `[NGUỒN]` |
| 04 | **"Đặt mật khẩu mới – 1 ô, có nút Hiện"** (`US4:40`) | "Quay lại"; "Đặt mật khẩu mới"; "Mật khẩu mới dùng để đăng nhập bằng cả email và số điện thoại."; ô "Mật khẩu mới" + Hiện; helper "Tối thiểu [__] ký tự, theo quy định mật khẩu hiện tại."; ô "Xác nhận mật khẩu mới" + Hiện; nút "Lưu mật khẩu"; ghi chú "Có ô Xác nhận mật khẩu mới – phải khớp; mỗi ô có nút Hiện (giống màn 05c)" | `[NGUỒN]` — bảng ghi 1 ô, ảnh và BR3 ghi 2 ô, xem mục 9 #8 |
| 01 | Quay về Đăng nhập với thông báo đổi mật khẩu thành công | Màn đăng nhập: ô Email hoặc SĐT, Mật khẩu + Hiện, Lưu đăng nhập, "Quên mật khẩu?", Đăng nhập, Google, "Chưa có tài khoản? Đăng ký" (chỉ Android · Web — ẩn trên iOS) | `[NGUỒN]` |

### 4b. Màn hình theo Figma giao diện thật (`FIGMA`, đọc 2026-10-16)

Figma là "giao diện thật" (`US4:34`) nên **ưu tiên hơn wireframe** về câu chữ và bố cục; **không** thay được BR/AC — chỗ Figma khác tài liệu hoặc khác câu BA đã trả lời thì nêu thành câu hỏi, không tự chọn. Giới hạn: xem được ảnh 2/10 frame; 8 frame còn lại chỉ đọc tên frame và lớp text (chữ trong ô nhập, nút, lỗi của các frame đó chưa đọc được).

| Màn | Frame | Nội dung đọc được trên Figma | So với tài liệu / cách hiểu đã chốt | Nhãn |
| --- | --- | --- | --- | --- |
| 02 | `1641:22403` · `1754:6239` · `1754:6293` — ba frame cùng tên "Nhập số điện thoại hoặc email" (chưa xem ảnh) | Nút Quay lại; tiêu đề "Quên mật khẩu"; câu hướng dẫn "Nhập email hoặc số điện thoại đã đăng ký. Mã xác thực sẽ được gửi qua email hoặc Zalo"; 1 ô nhập; 1 nút. Placeholder, chữ trên nút và lỗi tại ô **chưa đọc được** | AC1 ghi "…Chúng tôi sẽ gửi mã xác thực qua email hoặc Zalo." (`US4:62`) → Figma **khác câu chữ** AC1 (Q-27). Ba biến thể có thể là trống / đã nhập / lỗi định dạng (AC2, AC13) — chưa xác nhận được | `[NGUỒN]` Figma · `[DIỄN GIẢI AI]` phần ba biến thể |
| 03 — Zalo | `1641:22535` · `1641:22563` (chưa xem ảnh) | Quay lại; "Nhập mã xác thực"; "Mã số đã được gửi qua Zalo tới số 09•• ••• 678."; một link (chữ chưa đọc; frame email là "Đổi email", frame US6 là "Đổi số"); 6 ô; "Chưa nhận được mã?" + đồng hồ "45s"; một nút (chữ chưa đọc; frame email là "Xác thực") | AC3 "Mã đã được gửi qua Zalo tới 09•• ••• 678" (`US4:64`) → Figma thêm "số", "tới số", dấu chấm (Q-27). Wireframe "Gửi lại mã sau 00:45" / nút "Xác nhận" → Figma chỉ còn đồng hồ "45s" và nút "Xác thực" | `[NGUỒN]` Figma |
| 03 — email | `1774:7086` (ảnh `figma/US4_1774-7086_otp-email.png`) · `1774:7189` (chưa xem ảnh) | Quay lại; "Nhập mã xác thực"; "Mã số đã được gửi tới ng•• ••• @congty.vn"; link "Đổi email" góc phải; 6 ô, ô đầu đang focus; "Chưa nhận được mã?" + biểu tượng đồng hồ "45s" (**không có nút Gửi lại** khi đang đếm); nút "Xác thực" **mờ** khi chưa nhập; bàn phím số | AC4 yêu cầu "gợi ý kiểm tra Spam" (`US4:65`) → frame này **không có** dòng gợi ý Spam (Q-28). Mẫu che email "ng•• ••• @congty.vn" (bổ sung Q-13). Nút mờ khi chưa đủ số: US4 không có AC, kiểm theo US2 | `[NGUỒN]` Figma |
| 04 | `1754:6468` "Chưa nhập đầy đủ thông tin" · `1641:22759` "Mật khẩu không hợp lệ" (hai frame chưa xem ảnh) · `1754:6840` "Nhập mật khẩu không khớp" (ảnh `figma/US4_1754-6840_matkhau-khong-khop.png`) | "Đặt mật khẩu mới"; "Mật khẩu mới dùng để đăng nhập bằng cả email và số điện thoại"; 2 ô có biểu tượng khóa + biểu tượng mắt (nút Hiện); helper dưới ô 1: **"Mật khẩu phải có từ 8–16 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt"**; ô 2 viền đỏ + lỗi đỏ "Mật khẩu không khớp vui lòng nhập lạ" (thiếu chữ "i", không dấu câu); nút "Lưu mật khẩu" **vẫn bật** khi có lỗi; **không có nút Quay lại** (cả 3 frame không có lớp Button Group 2) | Helper **khác quy định BA đã xác nhận** (Q-01: 8–16 ký tự, ≥1 chữ và ≥1 số, ký tự khác cho phép; `EPIC:147` "8-16 ký tự gồm chữ và số") → **Q-26, AI đề xuất trọng yếu**: giá trị mẫu "Gopany 123", "gopany123" đạt theo BA nhưng rớt theo Figma. Câu lỗi khác AC9 "Mật khẩu xác nhận không khớp." (`US4:72`) → Q-27. Vị trí lỗi dưới ô Xác nhận khớp `02 §4` dòng 19; lỗi inline + viền đỏ trả lời phần ĐO & GHI ở dòng 20. Nút bật khi lỗi khớp AC14 (`US4:79`). 2 ô khớp BR3 (bảng `US4:40` "1 ô" là lỗi bảng, Q-14). **Không có Quay lại** ≠ wireframe (`US4:30`) và câu BA Q-12 "(b) về màn 03" → Q-12 mở lại. Frame "Chưa nhập đầy đủ thông tin" → có trạng thái cho AC14, nội dung chưa đọc | `[NGUỒN]` Figma |
| Email OTP "Đặt lại mật khẩu" | `1872:4430` (ảnh `figma/EMAIL_1872-4430_otp-datlai-mk.png`; **tên frame ghi nhầm** "Đăng ký bằng email (US6)") | Logo GOPANY; "Đặt lại mật khẩu"; "Xin chào huongmt@gopany.com,"; "Chúng tôi nhận được yêu cầu đặt lại mật khẩu cho tài khoản Gopany gắn với email này. Nhập mã dưới đây để đặt mật khẩu mới."; khung "MÃ XÁC THỰC CỦA BẠN" 6 số; "Mã có hiệu lực trong **5 phút** và chỉ dùng được một lần."; khung vàng "Không chia sẻ mã này với bất kỳ ai, kể cả người tự nhận là nhân viên Gopany. Gopany không bao giờ hỏi mã xác thực của bạn."; "Nếu bạn không yêu cầu đặt lại mật khẩu, hãy bỏ qua email này. Mật khẩu hiện tại của bạn không thay đổi."; chân "Đây là email tự động, vui lòng không trả lời. Cần hỗ trợ? Liên hệ [email hỗ trợ] · [hotline] © 2026 Gopany"; **không có nút / liên kết** | Khớp mẫu 23 (`US2:38`: tên Gopany, mã, thời hạn, lời nhắc, không nút). Tiêu đề (subject) email không có trên design; "[email hỗ trợ]", "[hotline]" còn là placeholder | `[NGUỒN]` Figma |
| 01 sau khi đổi xong | Mục US4 trên Figma **không có** frame màn 01 kèm thông báo thành công. Màn 01 chung ở mục US3: `1634:21845` (ảnh `figma/US3_1634-21845_dangnhap.png`) · `1725:10310` · `1725:10598` (chưa xem ảnh; có lỗi tạm khóa của US3) | Logo; "Đăng nhập"; "Chào mừng bạn đến với Gopany"; ô "Nhập email hoặc số điện thoại"; ô "Nhập mật khẩu" + mắt; "Lưu đăng nhập" tick sẵn; "Quên mật khẩu?"; nút "Đăng nhập" mờ khi trống; "Hoặc"; "Đăng nhập bằng Google"; "Chưa có tài khoản? Đăng ký" | Thông báo AC10 "Đổi mật khẩu thành công. Vui lòng đăng nhập lại." (`US4:73`) **chưa có trên Figma** → hình thức (toast / banner / popup) chưa biết (Q-27). Ô định danh trống hay điền sẵn (`02 §4` dòng 17) vẫn chưa có frame riêng để đối chiếu | `[NGUỒN]` Figma |
| Chưa có trên Figma (mục US4) | — | Trạng thái AC5 / AC6 (lỗi gửi), AC15 / AC16 (hết 10 phút, về màn 02 điền sẵn), AC12 (mất mạng), đếm ngược ở màn 04 (Q-09). Lỗi OTP nằm ở mục "02 US2" (8 frame: không đủ 6 số, đủ 6 số, yêu cầu gửi lại khi hết chờ, gửi không thành công, sai mã, mã hết hạn, nhập sai quá nhiều lần, gửi quá nhiều lần) — **chưa đọc** | Case của các AC này vẫn chỉ dựa trên chữ tài liệu | `[NGUỒN]` Figma (danh sách frame) |

## 5. Business rule

### 5a. BR trong US4 (`US4:47-55`)

| Mã | Nội dung (sát nguyên văn) | Loại | Nguồn | Nhãn |
| --- | --- | --- | --- | --- |
| BR1 | Hệ thống tự nhận biết: SĐT → gửi OTP qua **Zalo**; email → gửi OTP qua **email**. | nghiệp vụ | `US4:47` | `[NGUỒN]` |
| BR2 | Chỉ SĐT/email đã gắn tài khoản mới nhận OTP. Thông báo sau khi bấm Tiếp tục luôn giống nhau dù SĐT/email có tồn tại hay không. | nghiệp vụ / bảo mật | `US4:48` | `[NGUỒN]` |
| BR3 | Mật khẩu mới theo quy định mật khẩu chung; có 2 ô: Mật khẩu mới và Xác nhận mật khẩu mới (phải khớp), mỗi ô có nút Hiện. | dữ liệu / UI | `US4:49` | `[NGUỒN]` — "quy định mật khẩu chung" chưa có trong US4, xem mục 9 #1 |
| BR4 | Đổi thành công → mật khẩu cũ hết hiệu lực, **đăng xuất mọi thiết bị**, gỡ tạm khóa đăng nhập (nếu có), quay về màn đăng nhập (không tự đăng nhập). | nghiệp vụ / phiên | `US4:50` | `[NGUỒN]` |
| BR5 | Giới hạn OTP theo US2 (tính chung với các luồng khác). | nghiệp vụ | `US4:51` | `[NGUỒN]` — con số ở US2 BR4/BR5 còn trống |
| BR6 | Tài khoản tạo bằng Google cũng đặt được mật khẩu qua luồng này bằng email Google (US9 BR6). | nghiệp vụ | `US4:52` | `[NGUỒN]` — US9 BR6 là "Đề xuất – câu hỏi mở #11", xem mục 9 #4 |
| BR7 | Kết quả xác thực OTP cho mục đích đặt lại mật khẩu có hiệu lực **10 phút kể từ thời điểm backend xác nhận OTP thành công**. | nghiệp vụ / thời gian | `US4:53` | `[NGUỒN]` |
| BR8 | Tại hoặc sau thời điểm hết 10 phút, kết quả xác thực hết hiệu lực. Hệ thống không cho cập nhật mật khẩu; người dùng phải xác thực OTP lại trước khi tiếp tục. | nghiệp vụ | `US4:54` | `[NGUỒN]` |
| BR9 | Thoát/mở lại ứng dụng, quay lại màn đặt mật khẩu hoặc chỉnh sửa dữ liệu nhập không làm reset hay kéo dài thời hạn 10 phút. | nghiệp vụ | `US4:55` | `[NGUỒN]` |

### 5b. Quy tắc chung của Epic và story liên quan áp vào US4 (mã QA tự đánh `E-xx`, vị trí gốc kèm theo)

| Mã QA | Nội dung (sát nguyên văn) | Nguồn | Nhãn |
| --- | --- | --- | --- |
| E-01 | Mỗi SĐT và mỗi email chỉ gắn với **một** tài khoản. | `EPIC:97` | `[NGUỒN]` |
| E-02 | SĐT hợp lệ: `0xxxxxxxxx` hoặc `+84xxxxxxxxx` (số di động VN); hai dạng là cùng một số. Email so khớp không phân biệt hoa/thường. | `EPIC:98` | `[NGUỒN]` |
| E-03 | Câu hỏi #20 (Hường): "nhập có 84 hay không đều được". #21: BE lưu định dạng 84. #23: "chấp nhận các đầu ví dụ: 84908.., +84979.., 0909..(10 chữ số), 300940(9 chữ số)". | `EPIC:164-165`, `EPIC:167` | `[NGUỒN]` — "300940(9 chữ số)" chưa rõ, xem mục 9 #7 |
| E-04 | Quy định mật khẩu: "\[ghi quy định hiện tại – BE xác nhận\], áp dụng chung mọi luồng." | `EPIC:113` | `[NGUỒN]` — chỗ trống |
| E-05 | Câu hỏi #4 "Quy định mật khẩu hiện tại" — người chốt Chiến — kết quả: "8-16 ký tự gồm chữ và số". | `EPIC:148` | `[NGUỒN]` — chưa được chép vào §6 Epic / US4, xem mục 9 #1 |
| E-06 | Sai mật khẩu \[__\] lần → tạm khóa đăng nhập \[__\] phút. | `EPIC:114`, `US3:43` | `[NGUỒN]` — con số trống |
| E-07 | Thông báo lỗi đăng nhập/quên mật khẩu không tiết lộ email/SĐT có tồn tại hay không. | `EPIC:116`, `US3:44` | `[NGUỒN]` |
| E-08 | Bước đặt mật khẩu mới (quên mật khẩu) có 2 ô: Mật khẩu và Xác nhận mật khẩu – phải khớp nhau; mỗi ô có nút Hiện. | `EPIC:106`, `EPIC:216` | `[NGUỒN]` |
| E-09 | Kiểm tra dữ liệu 2 lớp: FE kiểm tra định dạng tại ô, BE kiểm tra lại toàn bộ + quy tắc nghiệp vụ, trả mã lỗi (13/10/2026, Hường). | `EPIC:207` | `[NGUỒN]` |
| E-10 | OTP: mã hiệu lực **5 phút**; chờ **1 phút** mới được gửi lại (cả Zalo và email); gửi mã mới → mã cũ hết hiệu lực; tối đa \[__\] lần/\[__\] giờ; sai \[__\] lần → khóa \[__\] phút. | `US2:45-48`, `EPIC:123` | `[NGUỒN]` — 4 con số trống (Epic #3) |
| E-11 | Số lần gửi và số lần sai tính tiếp giữa các luồng với cùng SĐT/email, không đếm lại. | `US2:70` | `[NGUỒN]` |
| E-12 | Lỗi không gửi được mã (Zalo/email) xử lý trong từng luồng (US2 ngoài phạm vi). | `US2:17` | `[NGUỒN]` |
| E-13 | Email Google được tính là email đã xác thực; tài khoản tạo bằng Google không có mật khẩu; muốn đăng nhập bằng email/SĐT + mật khẩu thì đặt qua Quên mật khẩu *(Đề xuất – câu hỏi mở #11)*. | `US9:45`, `US9:50`, `EPIC:155` | `[NGUỒN]` — còn mở |
| E-14 | US9 AC9: Quên mật khẩu bằng email Google → nhận OTP qua email, đặt mật khẩu mới; đặt xong đăng nhập được bằng email + mật khẩu **và vẫn dùng Google được**. | `US9:69` | `[NGUỒN]` |
| E-15 | iOS: không có bất kỳ đường nào vào màn đăng ký — rà mọi màn (đăng nhập, quên mật khẩu, lỗi, hết phiên…), kể cả back, link trong trang, deep link. | `EPIC:109`, `BUG10:28`, `BUG10:35` | `[NGUỒN]` |
| E-16 | Màn OTP ở nhiều luồng là **cùng một màn**, chỉ khác tiêu đề, kênh gửi và màn tiếp theo. | `EPIC:90` | `[NGUỒN]` |
| E-17 | Xác thực qua SSO Keycloak; BE làm mới dùng chung cho 3 nền tảng. | `EPIC:6` | `[NGUỒN]` |
| E-18 | Email vừa thêm (đã xác thực) dùng được ngay để đăng nhập, **lấy lại mật khẩu bằng email** và nhận lời mời; tài khoản đăng ký bằng SĐT được gợi ý thêm email để "lấy lại mật khẩu bằng email". | `US5:57` (BR8), `US5:77` (AC11), `US5:79` (AC13) | `[NGUỒN]` — thêm 2026-10-16 |
| E-19 | Đổi SĐT thành công → đăng nhập được bằng số mới, **số cũ không đăng nhập được nữa**; trong lúc đổi, số cũ giữ nguyên đến khi số mới xác thực xong. | `US5:81` (AC14), `US5:51` (BR2) | `[NGUỒN]` — thêm 2026-10-16. Ghép E-01 + US4 BR2 → số cũ sau đổi là định danh "chưa gắn tài khoản" với luồng quên mật khẩu (`[DIỄN GIẢI AI]`, mục 8 #13) |
| E-20 | Thêm/đổi SĐT, thêm email phải nhập **mật khẩu hiện tại** rồi xác thực OTP. | `US5:52` (BR3), `US5:71` (AC6) | `[NGUỒN]` — regression sau khi đổi mật khẩu qua US4 |
### 5c. Thông báo theo bảng nội dung thông báo (`TB`, thêm 2026-10-16) `[NGUỒN]`

| Mã QA | Màn | Tình huống | Nội dung / trạng thái (nguyên văn) | Nguồn | Ghi chú đối chiếu |
| --- | --- | --- | --- | --- | --- |
| TB-01 | 03 (OTP, US2 05b-12) | Chưa nhập đủ 6 chữ số / nhập đủ | Vô hiệu hóa nút xác thực / Nút xác thực được mở | `TB:5-6` | Mới — US2 chưa có AC này |
| TB-02 | 03 | Hết thời gian chờ gửi lại | Ẩn đếm ngược; bật **Gửi lại mã** | `TB:7` | Khớp US2 AC4–AC5 |
| TB-03 | 03 | Gửi OTP không thành công | "Chưa thể gửi mã xác thực. Vui lòng thử lại sau." (thông báo) | `TB:8` | AC6 `US4:67` còn đòi "gợi ý thử kênh còn lại hoặc liên hệ hỗ trợ" — bảng không có; vẫn chạm BR2 không lộ (Q-03b) |
| TB-04 | 03 | Sai mã | "Mã không đúng bạn còn [X] lần thử." (validate ô nhập) | `TB:10` | Lệch chữ US2 AC7 `US2:63` "Mã OTP không đúng" và Q-02 (Hường) |
| TB-05 | 03 | Mã hết hạn | "Mã hết hạn. Vui lòng gửi lại mã mới" (validate ô nhập; bảng gõ "VuI") | `TB:11` | Lệch chữ US2 AC9 `US2:65` "Mã đã hết hạn" |
| TB-06 | 03 | Gửi quá nhiều lần | "Bạn đã yêu cầu quá nhiều lần vui lòng thử lại sau [X] phút" (validate ô nhập) | `TB:12` | Đơn vị **phút**; Hường (Q-11) "thử lại vào ngày hôm sau" |
| TB-07 | 03 | Nhập sai quá nhiều lần | "Bạn đã nhập sai quá nhiều lần. Tạm khóa xác thực cho số điện thoại này trong [X] phút" (validate ô nhập; bảng gõ "Tạp khóa") | `TB:13` | Đơn vị **phút**; Hường (Q-11) khóa **1 ngày**; chữ "số điện thoại" cả khi kênh email |
| TB-08 | 03 | Không gửi được qua Zalo | "Không thể" — **dòng chưa viết xong** | `TB:14` | Không dùng được |
| TB-09 | 01 (US3) | Sai email/SĐT hoặc mật khẩu | "Tài khoản hoặc mật khẩu không chính xác. Vui lòng thử lại." | `TB:19` | Lệch chữ US3 AC5 `US3:56` "Email/số điện thoại hoặc mật khẩu không đúng" |
| TB-10 | 01 (US3) | Nhập sai quá X lần | "Đăng nhập đang tạm bị khóa. Vui lòng thử lại sau [thời gian]." + vô hiệu hóa nút đăng nhập | `TB:20` | Con số X / thời gian vẫn trống (Q-11b) |
| TB-11 | 01 (US3) | iOS | Không hiển thị link đăng ký | `TB:15` | Khớp E-15 |
| TB-12 | 02 | Chưa nhập thông tin | Vô hiệu hóa nút Tiếp tục | `TB:21` | Khớp AC13 |
| TB-13 | 02 | **Email hoặc số điện thoại không tồn tại** | **"Email hoặc số điện thoại không đúng"** | `TB:22` | **Mâu thuẫn BR2 `US4:48`, AC5 `US4:66`, `EPIC:116`, Q-02 (Hường 2026-10-16 "Sang màn 03 như bình thường")** — xem mục 9 #19 |
| TB-14 | 04 | Chưa nhập đầy đủ | Vô hiệu hóa nút lưu mật khẩu | `TB:23` | Khớp AC14 |
| TB-15 | 04 | Mật khẩu không hợp lệ | "Mật khẩu phải có từ 8–16 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt" (validate dưới ô nhập) | `TB:24` | Khớp helper Figma; lấp Q-01b |
| TB-16 | 04 | Mật khẩu không khớp | "Mật khẩu không khớp vui lòng nhập lại" (validate dưới ô nhập mật khẩu) | `TB:25` | Khớp Figma; lệch AC9 `US4:72` "Mật khẩu xác nhận không khớp." và bảng 2 cho US1/US6 `TB:56`, `TB:64` "Mật khẩu xác nhận không khớp. Vui lòng nhập lại." (Q-27) |
| TB-17 | Các màn liên quan | (bỏ trống) | "Đã xảy ra lỗi. Vui lòng kiểm tra và thử lại." | `TB:43` | Dùng chung — áp cho lỗi hệ thống AC12; mất mạng: `[DIỄN GIẢI AI]` cũng dùng câu này vì ô Tình huống để trống |

Bảng không có dòng cho: sai định dạng ở màn 02 của US4 (chỉ có US1 "Số điện thoại không đúng định dạng." `TB:52`, US6 "Email không đúng định dạng." `TB:60`); sai mật khẩu hiện tại ở US5 AC6; gợi ý kiểm tra Spam (AC4).

Mã QA tự đánh: UC-01 (mục 4), E-01 → E-17 (bảng trên). US4 có sẵn BR1–BR9 và AC1–AC18, giữ nguyên.

## 6. Acceptance criteria, mã lỗi, thông báo, giới hạn số

### 6a. AC của US4 (`US4:59-83`) — cột "Mã lỗi BE" **trống ở mọi dòng**

| Mã | Tình huống | Kết quả mong đợi (nguyên văn) | Nguồn |
| --- | --- | --- | --- |
| AC1 | Bấm "Quên mật khẩu" ở màn đăng nhập | Màn có 1 ô "Email hoặc số điện thoại", câu hướng dẫn: "Nhập email hoặc số điện thoại đã đăng ký. Chúng tôi sẽ gửi mã xác thực qua email hoặc Zalo." | `US4:62` |
| AC2 | Sai định dạng | Báo lỗi tại ô, không gửi mã | `US4:63` |
| AC3 | Nhập SĐT đã gắn tài khoản | OTP gửi qua Zalo → màn OTP ghi "Mã đã được gửi qua Zalo tới 09•• ••• 678" | `US4:64` |
| AC4 | Nhập email đã gắn tài khoản | OTP gửi qua email → màn OTP ghi "Mã đã được gửi tới ng•••@…", gợi ý kiểm tra Spam | `US4:65` |
| AC5 | Nhập SĐT/email chưa có tài khoản | Không gửi mã; thông báo chung giống AC3/AC4 (không tiết lộ tồn tại hay không) | `US4:66` |
| AC6 | Không gửi được (Zalo/email lỗi) | Báo lỗi; gợi ý thử kênh còn lại hoặc liên hệ hỗ trợ | `US4:67` |
| AC7 | Nhập sai / hết hạn / gửi quá nhiều | Theo US2 | `US4:69` |
| AC8 | Nhập đúng OTP | Sang màn nhập mật khẩu mới | `US4:70` |
| AC9 | Mật khẩu không đạt quy định, hoặc ô Xác nhận mật khẩu mới không khớp | Báo lỗi tại ô tương ứng ("Mật khẩu xác nhận không khớp."), chưa đổi | `US4:72` |
| AC10 | Mật khẩu hợp lệ và 2 ô khớp nhau, bấm Lưu | Thông báo "Đổi mật khẩu thành công. Vui lòng đăng nhập lại." → màn đăng nhập | `US4:73` |
| AC11 | Sau khi đổi | Thiết bị khác đang đăng nhập bị đăng xuất; mật khẩu cũ không dùng được; mật khẩu mới đăng nhập được bằng cả email và SĐT | `US4:74` |
| AC12 | Bỏ ngang, mất mạng, lỗi hệ thống | Mật khẩu chưa đổi nếu chưa hoàn tất; báo lỗi tiếng Việt, cho thử lại | `US4:76` |
| AC13 | Màn 02 chưa nhập email/SĐT hoặc chỉ nhập khoảng trắng | Vô hiệu hóa nút **Tiếp tục**; không gửi OTP. | `US4:78` |
| AC14 | Không nhập đủ thông tin 2 ô nhập | Lưu mật khẩu chỉ vô hiểu hóa khi CHƯA NHẬP ĐỦ 2 ô. Đã nhập đủ nhưng sai quy định/không khớp thì nút vẫn bấm được và báo lỗi tại ô theo AC9. | `US4:79` |
| AC15 | Hết 10 phút sau khi backend xác nhận OTP thành công, người dùng vẫn ở màn 04 | "chuyển về bước xác thực" → ghi rõ: về màn 02, điền sẵn email/SĐT, người dùng bấm Tiếp tục để nhận mã mới. Thêm: FE tính hết hạn theo expiresIn BE trả về, không tự đếm giờ trên máy. | `US4:80` |
| AC16 | Người dùng nhấn Lưu tại hoặc sau mốc hết 10 phút nhưng giao diện chưa cập nhật | Backend từ chối cập nhật dù mật khẩu hợp lệ và hai ô khớp; thông báo và điều hướng như AC15. | `US4:81` |
| AC17 | Người dùng thoát/mở lại ứng dụng hoặc quay lại màn 04 | Chuyển app ra nền rồi quay lại màn 04: còn hạn thì làm tiếp với thời gian còn lại; hết hạn thì xử lý như AC15. Tắt hẳn app rồi mở lại: làm lại từ màn 02 (app không lưu kết quả xác thực xuống máy). | `US4:82` |
| AC18 | Đổi mật khẩu thành công khi tài khoản đang bị tạm khóa đăng nhập | Gỡ tạm khóa đăng nhập theo BR4; đăng xuất mọi thiết bị, quay về màn đăng nhập và không tự đăng nhập. | `US4:83` |

Tóm tắt ghi "Số AC: 12" (`US4:3`) nhưng bảng có 18 AC (AC13–AC18 bổ sung 14/10, `US4:95`).

### 6b. Thông báo và giới hạn số nguyên văn

| Nội dung | Nguyên văn | Nguồn |
| --- | --- | --- |
| Hướng dẫn màn 02 | "Nhập email hoặc số điện thoại đã đăng ký. Chúng tôi sẽ gửi mã xác thực qua email hoặc Zalo." | `US4:62` |
| Màn 03 (SĐT) | "Mã đã được gửi qua Zalo tới 09•• ••• 678" | `US4:64` |
| Màn 03 (email) | "Mã đã được gửi tới ng•••@…", gợi ý kiểm tra Spam | `US4:65` |
| Lỗi không khớp | "Mật khẩu xác nhận không khớp." | `US4:72` |
| Thành công | "Đổi mật khẩu thành công. Vui lòng đăng nhập lại." | `US4:73` |
| Hiệu lực xác thực OTP cho đặt lại mật khẩu | 10 phút kể từ khi backend xác nhận OTP thành công | `US4:53` |
| Hiệu lực OTP / chờ gửi lại | 5 phút / 1 phút (60 giây) | `US2:45-46` |
| Số lần gửi, số lần sai, thời gian khóa OTP | \[__\] — chưa chốt (Epic #3) | `US2:47-48`, `EPIC:147` |
| Quy định mật khẩu | "8-16 ký tự gồm chữ và số" (câu hỏi #4, Chiến) — §6 Epic vẫn để trống | `EPIC:148`, `EPIC:113` |
| Tạm khóa đăng nhập | \[__\] lần / \[__\] phút — chưa chốt | `US3:43`, `EPIC:114` |
| Thông báo lỗi khi hết 10 phút (AC15/AC16) | **Không có nguyên văn** trong US4 | `US4:80-81` |
| Thông báo lỗi AC2, AC6, AC12 | **Không có nguyên văn** | `US4:63`, `US4:67`, `US4:76` |

### 6c. Mã lỗi BE hiện có trong `tailieu/` (API OTP Zalo — **chưa rõ có dùng cho US4**)

`API7` `POST /api/v1/auth/phone/send-zalo-otp` (`API7:43`): 11000 Lỗi dữ liệu · 30016 Tài khoản không tồn tại · 30014 SĐT đã
được xác thực · 30018 chờ gửi lại (cooldown) · 30019 khóa đổi số · 30020 khóa resend · 30017/30021/30022/30023 cấu hình Zalo ·
30024 gửi Zalo thất bại · 30015 SĐT không tồn tại trên Zalo (`API7:24-35`). Response thành công có `expiresIn: 300` (`API7:86`).

`API8` `POST /api/v1/auth/phone/verify-zalo-otp` (`API8:38`): 11000 · 30029 tài khoản đã xác thực · 30014 · 30025 OTP hết hạn/không
tồn tại · 30026 không khớp uuid+phone · 30027 OTP không đúng · 30028 khóa verify (`API8:24-30`).

Hai API này nhận `uuid` của account đã có và kiểm `is_verify_phone` (`API7:45`, `API8:40`) — thiết kế cho xác thực SĐT của
tài khoản đang đăng nhập, không phải luồng quên mật khẩu. Không dùng làm căn cứ expected result cho US4 cho tới khi Dev xác nhận.

## 7. Trạng thái và chuyển trạng thái

Nguồn không mô tả bảng trạng thái. Có hai "trạng thái thời gian" đọc được từ BR7–BR9 và AC15–AC17 `[NGUỒN]`:

| Trạng thái kết quả xác thực OTP (đặt lại mật khẩu) | Bắt đầu | Kết thúc | Hành vi | Nguồn |
| --- | --- | --- | --- | --- |
| Còn hiệu lực | BE xác nhận OTP thành công | Đúng mốc 10 phút | Cho Lưu mật khẩu | `US4:53` |
| Hết hiệu lực | Tại hoặc sau mốc 10 phút | — | BE từ chối cập nhật; về màn 02, điền sẵn, bấm Tiếp tục nhận mã mới | `US4:54`, `US4:80-81` |
| Mất (không lưu xuống máy) | Tắt hẳn app rồi mở lại | — | Làm lại từ màn 02 | `US4:82` |

Thao tác **không** đổi mốc: thoát/mở lại app, quay lại màn 04, sửa dữ liệu nhập (`US4:55`).

## 8. Diễn giải, giả định, QA observation

| # | Nội dung | Nhãn | Liên quan tới |
| ---: | --- | --- | --- |
| 1 | "Đăng xuất mọi thiết bị" đọc là mọi phiên đã đăng nhập của tài khoản trên app và web, kể cả phiên có "Lưu đăng nhập" và phiên đăng nhập bằng Google; US4 không nói rõ phạm vi. | `[DIỄN GIẢI AI]` | BR4, AC11, Q-05 |
| 2 | AC11 "đăng nhập được bằng cả email và SĐT" chỉ áp dụng khi tài khoản có cả hai định danh đã xác thực; tài khoản chỉ có SĐT thì chỉ đăng nhập bằng SĐT. | `[DIỄN GIẢI AI]` | AC11, E-01 |
| 3 | Ở AC5, "thông báo chung giống AC3/AC4" đọc là người dùng vẫn được đưa sang màn 03 với dòng "Mã đã được gửi…", dù thực tế không có mã. | `[DIỄN GIẢI AI]` | BR2, AC5, Q-02 |
| 4 | "FE tính hết hạn theo expiresIn BE trả về" đọc là BE trả số giây còn lại tại thời điểm verify OTP thành công; FE tính mốc hết hạn từ đó. | `[DIỄN GIẢI AI]` | AC15 |
| 5 | Màn 03 và 04 là màn dùng chung với US1/US2/US6 (`EPIC:90`, `US4:8`), nên lỗi OTP (sai, hết hạn, khóa) kiểm theo US2 và không lặp lại chi tiết ở US4. | `[DIỄN GIẢI AI]` | BR5, AC7 |
| 6 | Nhập SĐT có khoảng trắng / dấu gạch / dấu chấm ("0909 123 456") — tài liệu không nói; QA sẽ đo và ghi. | `[QA BỔ SUNG]` | AC2, E-02 |
| 7 | Hai thiết bị cùng vào luồng quên mật khẩu với cùng SĐT/email; mỗi thiết bị verify OTP riêng rồi cùng Lưu — Epic #22 chỉ nói về đăng ký. | `[QA BỔ SUNG]` | BR7, E-10 |
| 8 | Gửi lại mã (màn 03) sau khi đã verify thành công nhưng chưa Lưu, rồi verify mã mới → mốc 10 phút tính lại từ lần verify sau? Tài liệu không nói. | `[QA BỔ SUNG]` | BR7, BR9 |
| 9 | Email nhập chữ hoa ("Abc@Gmail.com") vẫn tìm thấy tài khoản — theo `EPIC:98`. | `[NGUỒN]` | E-02, AC4 |
| 10 | Mật khẩu mới trùng mật khẩu cũ — tài liệu không cấm; QA đo và ghi. | `[QA BỔ SUNG]` | BR3 |
| 11 | Đang ở màn 03/04 của luồng quên mật khẩu trên iOS, bấm Quay lại nhiều lần — không được lộ nút/link Đăng ký. | `[NGUỒN]` (`BUG10:35`) | E-15 |
| 12 | AC6 "gợi ý thử kênh còn lại" chỉ có nghĩa khi tài khoản có cả SĐT và email; tài khoản chỉ có SĐT không có "kênh còn lại". | `[DIỄN GIẢI AI]` | AC6, Q-03 |
| 13 | Sau khi đổi SĐT (US5 AC14), gõ **số cũ** vào màn 02 → hệ thống coi là chưa gắn tài khoản: không gửi mã, vẫn màn 03 giống AC5; gõ **số mới** → nhận OTP. Suy từ E-01, E-19 và BR2. | `[DIỄN GIẢI AI]` | BR2, AC5, E-19 |
| 14 | Sau khi đổi mật khẩu qua US4, màn Thêm/Đổi SĐT và Thêm email (US5 BR3) phải nhận **mật khẩu mới**, từ chối mật khẩu cũ. | `[DIỄN GIẢI AI]` — hệ quả BR4 "mật khẩu cũ hết hiệu lực" | BR4, E-20 |
## 9. Điểm chưa rõ (chuyển sang Debate)

| # | Loại | Trích dẫn + nguồn | Vì sao chưa rõ | Đề xuất mức |
| ---: | --- | --- | --- | --- |
| 1 | thiếu / dẫn chiếu treo | BR3 "theo quy định mật khẩu chung" (`US4:49`); Epic §6 "\[ghi quy định hiện tại – BE xác nhận\]" (`EPIC:113`); Epic #4 kết quả "8-16 ký tự gồm chữ và số" (`EPIC:148`); US4 §8 vẫn ghi câu hỏi mở (`US4:88`); wireframe màn 04 "Tối thiểu [__] ký tự" | Quy định đã có câu trả lời ở bảng câu hỏi nhưng chưa chép vào §6 Epic / US4. "Gồm chữ và số" chưa rõ là **bắt buộc có cả chữ lẫn số** hay **chỉ cho phép chữ và số** (không ký tự đặc biệt, không khoảng trắng). Thông báo lỗi khi không đạt quy định (AC9) không có nguyên văn. | **Trọng yếu** — quyết định AC9 pass/fail |
| 2 | mơ hồ | AC5 "Không gửi mã; thông báo chung giống AC3/AC4" (`US4:66`); AC3 nói màn OTP ghi "Mã đã được gửi…" (`US4:64`) | Sau Tiếp tục với SĐT/email chưa có tài khoản, người dùng **có sang màn 03** không? Nếu có: nhập mã bất kỳ → báo gì; "Gửi lại mã" có hoạt động và có bị tính vào giới hạn gửi của US2 (`US2:47`, `US2:70`) không? | **Trọng yếu** — hành vi và bộ đếm |
| 3 | mâu thuẫn | AC6 "Không gửi được (Zalo/email lỗi) → Báo lỗi; gợi ý thử kênh còn lại hoặc liên hệ hỗ trợ" (`US4:67`) vs BR2 "Thông báo … luôn giống nhau dù SĐT/email có tồn tại hay không" (`US4:48`), `EPIC:116` | Nếu lỗi gửi chỉ xảy ra với SĐT/email **có** tài khoản (SĐT không có Zalo → `API7:35`, Zalo lỗi, email bounce) thì thông báo AC6 tự tiết lộ tài khoản tồn tại. Chưa rõ AC6 hiện **ngay ở màn 02** hay ở **màn 03**; SĐT không có Zalo có thuộc AC6 không. | **Trọng yếu** — bảo mật |
| 4 | dẫn chiếu treo | BR6 "Tài khoản tạo bằng Google cũng đặt được mật khẩu … (US9 BR6)" (`US4:52`); US9 BR6 ghi "*(Đề xuất – câu hỏi mở #11)*" (`US9:50`); Epic #11 cột kết quả trống (`EPIC:155`) | US4 viết như quy tắc đã chốt; US9 và Epic ghi còn chờ Hường. | **Trọng yếu** — có test case Google hay không |
| 5 | thiếu | BR4 "đăng xuất mọi thiết bị" (`US4:50`); AC11 "Thiết bị khác đang đăng nhập bị đăng xuất" (`US4:74`); US9 AC9 "vẫn dùng Google được" (`US9:69`) | Phạm vi "mọi thiết bị": phiên web + app, phiên "Lưu đăng nhập", phiên đăng nhập bằng Google — có bị đăng xuất hết không? Thiết bị bị đăng xuất thấy gì (bị văng ra ngay, hay khi thao tác tiếp)? Keycloak (`EPIC:6`, Epic #2 chưa chốt). | **Trọng yếu** — hành vi và điều kiện chấp nhận AC11 |
| 6 | thiếu | AC17 chỉ nói "app" (`US4:82`); nền tảng gồm Web (`US4:3`) | Trên web: tải lại trang (F5), đóng tab rồi mở lại, mở tab mới trong 10 phút → giữ kết quả xác thực hay làm lại từ màn 02? | **Trọng yếu** — hành vi trên web |
| 7 | mơ hồ | AC2 "Sai định dạng" (`US4:63`); `EPIC:98` "0xxxxxxxxx hoặc +84xxxxxxxxx"; Epic #23 "84908.., +84979.., 0909..(10 chữ số), 300940(9 chữ số)" (`EPIC:167`) | Định dạng SĐT hợp lệ ở màn 02: `0` + 9 số, `84` + 9 số, `+84` + 9 số — còn "300940 (9 chữ số)" là gì? Email kiểm theo quy tắc nào? Thông báo lỗi AC2 nguyên văn? | **Trọng yếu** — biên pass/fail AC2 |
| 8 | mâu thuẫn nội bộ | Bảng màn: "04 — Đặt mật khẩu mới – 1 ô, có nút Hiện" (`US4:40`) vs BR3 "có 2 ô" (`US4:49`), `EPIC:106`, ảnh wireframe 2 ô | Bảng màn chưa cập nhật sau 12/10 (`EPIC:216`). | Không trọng yếu — 3 nguồn còn lại thống nhất 2 ô; chỉ nhờ BA sửa |
| 9 | thiếu | AC15/AC16 (`US4:80-81`): điều hướng rõ, **thông báo** khi hết 10 phút không có nguyên văn; cột mã lỗi BE trống | Cần nguyên văn để điền expected; cần mã lỗi để ghi cột Error Code. | Không trọng yếu — câu chữ; cô lập AC15/AC16 `❓ Cần chốt` phần thông báo |
| 10 | thiếu | Cột "Mã lỗi BE" trống ở AC1–AC18 (`US4:59-83`); `EPIC:207` BE trả mã lỗi; `API7`/`API8` là API xác thực SĐT theo `uuid` | US4 dùng API nào cho gửi OTP / verify / đổi mật khẩu? Mã lỗi từng AC? | Không trọng yếu — black-box UI vẫn test được; cần cho cột Error Code |
| 11 | thiếu con số (phụ thuộc US2, US3) | BR5 → `US2:47-48` \[__\]; AC18 cần tài khoản đang tạm khóa → `US3:43` \[__\] | Không dựng được precondition cho AC7 (giới hạn) và AC18 khi chưa có số. Epic #3 "còn: số lần gửi, số lần sai, thời gian khóa" (`EPIC:147`). | Không trọng yếu với US4 — cô lập AC7, AC18 `❓ Cần chốt` (thuộc US2/US3) |
| 12 | mơ hồ | Wireframe màn 04 có "Quay lại" (`US4:30`); BR9 "quay lại màn đặt mật khẩu … không làm reset" (`US4:55`) | Bấm Quay lại ở màn 04 về màn 03 hay màn 02? Ở màn 03 sau khi đã verify, bấm Xác nhận lại / Gửi lại có nghĩa gì? | Không trọng yếu — điều hướng, không đổi kết quả chính |
| 13 | mơ hồ | AC3 "09•• ••• 678" (`US4:64`); AC4 "ng•••@…" (`US4:65`) | Quy tắc che: nhập `+84…` thì hiện "09•• ••• 678" hay "+84•• ••• 678"? Email che bao nhiêu ký tự, phần domain hiện đủ không? | Không trọng yếu — hiển thị |
| 14 | dẫn chiếu không khớp | "Số AC: 12" (`US4:3`) vs 18 AC (`US4:62-83`) | Tóm tắt chưa cập nhật. | Không trọng yếu — nhờ BA sửa |
| 15 | câu hỏi mở còn treo | US4 §8 "Bỏ hẳn liên kết đặt lại mật khẩu qua email trên web? – Hường chốt" (`US4:87`); Scope đã ghi ngoài phạm vi (`US4:18`); Epic changelog 09/10 "bỏ liên kết" (`EPIC:221`) | Scope và changelog cho thấy đã bỏ, nhưng §8 chưa gạch. Nếu web còn giữ link cũ thì có đường song song cần regression. | Không trọng yếu — nhờ BA xác nhận và gạch câu hỏi |
| 16 | thiếu | AC12 "Bỏ ngang, mất mạng, lỗi hệ thống → báo lỗi tiếng Việt" (`US4:76`); AC6 (`US4:67`) | Không có nguyên văn thông báo. | Không trọng yếu — câu chữ; QA đo và ghi |
| 17 | câu hỏi mở ở story khác chạm BR6 | US5 §8 `US5:88`: "Tài khoản tạo bằng Google chưa đặt mật khẩu thì thêm SĐT thế nào…? Đề xuất: bỏ bước mật khẩu với tài khoản Google, hoặc yêu cầu đặt mật khẩu trước qua Quên mật khẩu – Hường chốt." | Nếu chọn "đặt mật khẩu trước qua Quên mật khẩu" thì luồng US4 trở thành bước bắt buộc của US5 với tài khoản Google — tăng tầm quan trọng BR6, không đổi hành vi US4. | Không trọng yếu với US4 — theo dõi |
| 18 | mâu thuẫn thiết kế giữa story | US4 BR2 / `EPIC:116` không tiết lộ định danh có tài khoản; nhưng US1 AC5 `US1:61`, US6 AC4 `US6:61`, US5 AC7 `US5:72` báo thẳng "đã đăng ký" / "đã được dùng cho một tài khoản khác" khi định danh đã có tài khoản. | Kẻ dò có thể biết SĐT/email tồn tại qua màn đăng ký hoặc thêm SĐT, nên việc che ở US4 chỉ chặn một đường. Không phải lỗi US4, nhưng Product nên biết khi cân nhắc Q-03b. | Không trọng yếu với US4 — nêu cho Product |
| 19 | mâu thuẫn | `TB:22` màn 02 "Email hoặc số điện thoại không tồn tại → Email hoặc số điện thoại không đúng" vs BR2 `US4:48` "Thông báo sau khi bấm Tiếp tục luôn giống nhau dù SĐT/email có tồn tại hay không", AC5 `US4:66`, `EPIC:116`, Q-02 Hường 2026-10-16 | Bảng thông báo cho màn 02 báo lỗi khi định danh không tồn tại → lộ tồn tại, và không sang màn 03; ngược hẳn hành vi đã chốt | **Trọng yếu** (bảo mật + luồng) — đề xuất |
| 20 | lệch câu chữ / đơn vị | `TB:10-13` vs US2 AC7, AC9, Q-11 (Hường) | "Mã không đúng…" vs "Mã OTP không đúng"; "Mã hết hạn…" vs "Mã đã hết hạn"; khóa "[X] phút" vs "1 ngày"; "số điện thoại này" cả với email | Không trọng yếu — câu chữ; đơn vị phút có thể là 1440 |
| 21 | thiếu | `TB:14` "Không thể" | Dòng thông báo không gửi được qua Zalo chưa viết xong | Không trọng yếu |
## 10. Tự rà soát

- [x] Mọi mã ở mục 4–6 tìm thấy trong nguồn (BR1–BR9 `US4:47-55`, AC1–AC18 `US4:62-83`, E-xx có dòng dẫn)
- [x] Không mục `[NGUỒN]` nào thiếu tham chiếu
- [x] Mâu thuẫn giữa nguồn đã liệt kê đủ hai phía (#3, #4, #8, #14, #15)
- [x] Mục 9 không chứa câu trả lời do AI tự chọn
- [x] Không có expected result nào dựa trên `API7`/`API8` (chưa xác nhận là API của US4)
- [x] 2026-10-16: đã quét toàn bộ story của Epic (US1–US9, US8 nháp, hai bản US6) cho từ khóa liên quan US4

## Lịch sử cập nhật

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
| 2026-10-15 | AI (Requirement Analyst) — người dùng Hồng | Tạo file S3: đọc US4 + EPIC, US1, US2, US3, US9, BUG10, API7/API8; trích BR1–BR9, AC1–AC18, E-01→E-17; 16 điểm chưa rõ (7 đề xuất trọng yếu) |
| 2026-10-16 | AI (Requirement Analyst) — người dùng Hồng hỏi "đã rà soát toàn bộ Epic chưa" | Đọc trọn US5, quét US6 (hai bản), US7, US8 nháp; thêm nguồn #9–#10, E-18→E-20, mục 8 #13–#14, mục 9 #17–#18 |
| 2026-10-16 | AI (Orchestrator) — Hồng gửi link Figma giao diện thật | Thêm nguồn #11 `FIGMA` + viết tắt; thêm mục 4b (7 dòng) đối chiếu 10 frame US4 + email mẫu + màn 01 với AC/BR và `02 §4`; ảnh 2/10 frame + lớp text lưu `figma/`. Phát sinh Q-26 (đề xuất trọng yếu), Q-27, Q-28; Q-12, Q-13 bổ sung ý |
| 2026-10-16 | AI (Requirement Analyst) — Hồng gửi bảng nội dung thông báo | Thêm nguồn #11 `TB`, mục 5c TB-01→TB-17, mục 9 #19 (đề xuất trọng yếu: màn 02 báo "không đúng" khi định danh không tồn tại), #20, #21 |
| 2026-10-16 | AI (Orchestrator) | Sửa số dòng dẫn tới bảng thông báo (`TB` có 64 dòng: định dạng SĐT `TB:52`, email `TB:60`, xác nhận không khớp US1/US6 `TB:56`/`TB:64`) — Test Designer phát hiện |
