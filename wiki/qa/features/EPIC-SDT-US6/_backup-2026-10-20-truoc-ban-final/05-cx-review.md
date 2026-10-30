---
featureId: EPIC-SDT-US6
basedOn: 02-alignment-summary.md (gate: open, 2026-10-16)
reviewedAt: 2026-10-16
updatedAt: 2026-10-16      # lượt 2 — cập nhật theo Figma giao diện thật (ảnh 5/9 frame US6 + email mẫu)
modes: [1, 3]              # 1 = UI/UX/CX Review (tài liệu + Figma giao diện thật) · 3 = Customer Journey Review — KHÔNG chạy Mode 2
evidenceLevel: phân tích tài liệu và design thật (Mode 1) · mô phỏng bằng suy luận (Mode 3) — không có tương tác thật
closedScope: AC9 — Q-17 · nhánh chặn mới ở màn 11 — Q-18 (theo 02; file này chỉ ghi rủi ro CX, không đề xuất expected)
---

# CX Review — EPIC-SDT-US6: Đăng ký bằng email với xác thực OTP

**Mode đã chạy:** Mode 1 (review từ tài liệu + ảnh user flow + ảnh wireframe 11–14 + **Figma giao diện thật** từ lượt 2) và Mode 3
(hành trình end-to-end suy ra từ tài liệu: màn đăng nhập → 11 → 12 → 13 → 14 → ChatGoni hạn mức thấp → Thông tin tài khoản sửa tên).
**Không chạy Mode 2**: không có prototype, sản phẩm chạy được hay công cụ thao tác. Không câu nào trong file mô tả việc đã thao tác
hay đã quan sát trên sản phẩm.

**Lượt 2 (2026-10-16) — có Figma giao diện thật** (`FIGMA`: Gopany v1.1, trang "↳ Mobile app", Hồng gửi 2026-10-16; Orchestrator đã
đối chiếu ở `01` mục 6d, bảng 9 dòng). Đã xem **ảnh 5/9 frame** US6 (màn 11 trống, 11 sai định dạng, 11 email đã dùng + popup, 12,
14) và ảnh email OTP đăng ký. Frame 13 (`1641:50302`), frame 12 bản thứ hai (`1641:50334`) và hai frame lỗi Q-18 (`1819:5296`,
`1819:5430`) **không có ảnh** — chỉ có tên frame + lớp text; chữ trong ô nhập / nút / badge không bóc được → file này **không suy
đoán** nội dung bốn frame đó. Nhận định về câu chữ, bố cục, trạng thái vẽ trên 5 frame có ảnh gắn `[NGUỒN]` Figma; nhận định về hành
vi (bấm rồi về đâu, sau 0 s hiện gì, người dùng phản ứng ra sao) vẫn là `[CX GIẢ THUYẾT]`. Figma là design, không phải hành vi sản
phẩm → **không có finding Defect**; chỗ design khác tài liệu BA là việc của Debate (đã có Q-09, Q-16, Q-17, Q-18, Q-19), không phải
Defect. **Phạm vi cổng đóng** (02 `closedScope`): AC9 — Q-17 (quy định mật khẩu Figma ≠ BA) và nhánh chặn mới ở màn 11 — Q-18: với
hai phần này file chỉ ghi rủi ro CX / chuyển QA, **không đề xuất expected**. Lượt 2 **không đóng** finding nào (Figma không giải
quyết điểm cũ nào, chỉ thêm bằng chứng hoặc làm rõ); 14 ID cũ giữ nguyên, finding mới nối số từ CX-15.

Viết tắt tệp và số dòng theo `01-requirement-analysis.md` (`US6`, `EPIC`, `US1`, `US2`, `US3`, `US5`, `US7`, `US9`, `BUG10`).
"02 mục 4 #n" = dòng n trong bảng Cách hiểu đã thống nhất của `02-alignment-summary.md`; "Q-nn" = câu hỏi ở 02 mục 3.
Căn cứ requirement: 02 mục 4 (21 dòng) và file 01. Với 16 điểm không trọng yếu còn mở (Q-01→Q-14, Q-16, Q-19) file này **chỉ ghi
rủi ro CX, không chọn cách hiểu**. Đường dẫn `figma/…` = `wiki/qa/features/EPIC-SDT-US6/figma/…`; `[US6_nn]` = mã case trong
`04-testcases.md`.

## 1. Phạm vi và nguồn đã xem

| # | Nguồn (tài liệu / design / prototype / sản phẩm) | Phạm vi | Cách xem (đọc tài liệu / xem ảnh / thao tác thật) |
| ---: | --- | --- | --- |
| 1 | `US6` bản `06` (76 dòng) | Toàn bộ: scope, BR1–BR5, AC1–AC11, câu hỏi mở | Đọc tài liệu — **không** dùng bản nháp `Chình - … US6` |
| 2 | Ảnh user flow `US6:21` | Màn đăng nhập → Nền tảng? → 11 → định dạng → BR1 → gửi email được? → 12 → 13 → tạo tài khoản → 14 → workspace → ChatGoni; nhánh AC3, AC4, AC5, AC7, AC9, AC11 | Xem ảnh |
| 3 | Ảnh wireframe 4 màn `US6:29` (11, 12, 13, 14) | Nhãn, câu hướng dẫn, nút, ghi chú trên từng màn | Xem ảnh — **chỉ tham khảo luồng**, giao diện thật theo Figma (`US6:33`) → dòng 14–16 (lượt 2) |
| 4 | `02-alignment-summary.md` (gate open 2026-10-16; `closedScope` AC9 / nhánh chặn màn 11, đóng 2026-10-16) | Mục 3 (Q-01→Q-19), mục 4 (21 dòng), mục 5–8 | Đọc tài liệu (đọc lại ở lượt 2) |
| 5 | `01-requirement-analysis.md` | Mục 3–9: UC, BR, E-01→E-21, AC, wireframe 6c, diễn giải, điểm chưa rõ | Đọc tài liệu |
| 6 | `EPIC` §2, §4, §6, §7, §8 (câu hỏi #5, #8, #22), §10, §13 | Bối cảnh người dùng, quy tắc chung, rủi ro "Email OTP vào Spam / đến chậm" | Đọc tài liệu |
| 7 | `US2` | BR1–BR5, AC1–AC13 (màn 12 dùng chung, email mẫu 23) | Đọc tài liệu |
| 8 | `US1` | AC1–AC2 (tab theo IP), AC10–AC11 (màn 05d, bỏ ngang) — luồng song song | Đọc tài liệu |
| 9 | `US3` + ảnh wireframe màn 01 (`US3:29`) | Màn đăng nhập: link Đăng ký, AC4 "vào đúng workspace", AC5 thông báo | Đọc tài liệu · xem ảnh (điểm xuất phát hành trình) |
| 10 | `US5` + ảnh wireframe màn 07–08 (`US5:30`) | BR1, BR7, AC2–AC3: Thông tin tài khoản, sửa họ tên | Đọc tài liệu · xem ảnh (điểm kết thúc hành trình) |
| 11 | `US7` + ảnh wireframe màn 15–17 (`US7:31`) | BR2, BR4, BR6, AC1–AC6: ChatGoni hạn mức thấp | Đọc tài liệu · xem ảnh (bước sau màn 14) |
| 12 | `US9` | BR1–BR2, BR6, AC2, AC4, AC9: email Google, tài khoản không có mật khẩu | Đọc tài liệu |
| 13 | `BUG10` | iOS không có đường vào đăng ký (AC2) | Đọc tài liệu |
| 14 | **Lượt 2** — `FIGMA` mục "06 [EPIC-SĐT] US6", ảnh 5/9 frame: `figma/US6_1641-50276_nhap-email.png` (màn 11 trống), `figma/US6_1819-5526_email-sai-dinh-dang.png` (AC3), `figma/US6_1819-5176_email-da-dung.png` (AC4 popup), `figma/US6_1641-50362_otp.png` (màn 12), `figma/US6_1641-50321_thanh-cong.png` (màn 14) | Câu chữ, bố cục, trạng thái lỗi inline, popup, trạng thái nút, đồng hồ đếm ngược, thanh tiến trình | Xem ảnh |
| 15 | **Lượt 2** — lớp text `figma/lop-text-figma-2026-10-16.txt` (9 frame US6 + popup tách `1819:5278`; 3 email mẫu; frame US4/US3 để đối chiếu màn dùng chung) | Frame 13 `1641:50302`, frame 12 bản hai `1641:50334`, `1819:5296` "Thiết bị đã vượt giới hạn số lượng email được phép sử dụng", `1819:5430` "Email thuộc danh sách chặn": **chỉ tên frame + lớp text**, chữ trong instance (ô nhập, nút, badge) không có | Đọc text — không suy đoán phần không đọc được |
| 16 | **Lượt 2** — `figma/EMAIL_1859-3924_otp-dangky.png` (email OTP đăng ký, mục "Email OTP") | Toàn bộ nội dung email | Xem ảnh |
| 17 | **Lượt 2** — `01-requirement-analysis.md` mục 6d (bảng 9 dòng đối chiếu Figma ↔ AC/BR/02 §4) | Dùng làm điểm xuất phát; CX chỉ ghi thêm góc nhìn khách hàng, không lặp đối chiếu | Đọc tài liệu |
| 18 | **Lượt 2** — `03-test-design.md`, `04-testcases.md` (77 case `[US6_nn]`), `06-unified-qa-review.md` | Nối cột Trace từ "case: chưa có" sang mã case; xem cách 06 đã xử lý CX-01→CX-14 | Đọc tài liệu |

**Giới hạn (cập nhật lượt 2):** Không có prototype, sản phẩm chạy được hay công cụ truy cập → không chạy Mode 2; không có
Defect. **Có Figma** (5/9 frame có ảnh) → đánh giá được câu chữ, bố cục, trạng thái lỗi inline AC3, popup AC4, nút mờ khi ô trống,
đồng hồ đếm ngược, thanh tiến trình, nội dung email OTP đăng ký. **Chưa đánh giá được:** màn 13 (helper mật khẩu, badge, nhãn nút —
frame không ảnh; thuộc closedScope Q-17), frame 12 bản thứ hai, hai frame chặn Q-18 (chữ lỗi trong ô nhập chưa đọc), trạng thái sau khi
đồng hồ về 0, trạng thái đang gửi / loading, AC5 / AC11 (không có frame), màn sau "Bắt đầu sử dụng", màn 11 ngoài VN, iOS, tiêu đề
(subject) email. Accessibility: ảnh tĩnh không có token màu / cỡ chữ / thứ tự focus → chỉ ghi nhận bằng mắt, không kết luận
contrast hay screen reader. Chữ trong instance Figma (ô nhập, nút, badge) không bóc được → kết luận "không có chữ X" chỉ đúng với
lớp text tự do, ghi rõ ở từng finding. Không có dữ liệu người dùng thật → mọi persona ở mục 2 là phân nhóm theo tài liệu hoặc giả
thuyết phục vụ review. `03`/`04` nay đã có → cột Trace nối mã case `[US6_nn]`; case `❓ Cần chốt` giữ nhãn. Nút "Tiếp tục với
Google" chỉ ghi nhận có mặt (`US9:60`); lỗi OTP (sai, hết hạn, khóa) thuộc US2 — chỉ nhắc khi ảnh hưởng hành trình US6.

## 2. Persona

| Persona | Nhóm khách hàng · bối cảnh | Mục tiêu | Căn cứ |
| --- | --- | --- | --- |
| P1 | **Người dùng mới**, chưa có tài khoản Gopany, đăng ký trên **Web** (máy tính), mở hộp thư ở tab/cửa sổ khác | "Bắt đầu nhanh và chắc chắn email của tôi đúng" | `US6:11`; `US6:3` nền tảng Web; `EPIC:28`. Bối cảnh "tab khác" là **giả thuyết phục vụ review** |
| P2 | Người dùng mới trên **Android**, hộp thư nằm trong app email trên cùng điện thoại → phải rời app Gopany để lấy mã | Đăng ký xong trong một lần ngồi, không bị mất chỗ | `US6:3` nền tảng Android; `EPIC:144` (màn riêng trong app). Việc rời app lấy mã là **giả thuyết phục vụ review** |
| P3 | Người **đã có tài khoản** (form cũ hoặc Google) nhưng không nhớ, thử đăng ký lại bằng cùng email | Vào được tài khoản | `US6:61` (AC4), `US9:46` (email Google trùng → đăng nhập), `US9:50` (tài khoản Google không có mật khẩu), `EPIC:28` (hệ thống đã có người dùng email/Google). Người cụ thể là **persona giả thuyết phục vụ review** |
| P4 | Người truy cập từ **IP ngoài Việt Nam** (người VN ở nước ngoài, VPN) — màn 11 chỉ còn Email | Đăng ký và dùng ChatGoni | `EPIC:107`, `US1:57`, 02 mục 4 #4; wireframe màn 11 "Ngoài IP Việt Nam: chỉ còn lựa chọn Email". Hoàn cảnh cá nhân là **giả thuyết** |
| P5 | Người **bị gián đoạn hoặc gặp mạng/dịch vụ chậm**: email OTP đến chậm, vào Spam, hoặc gửi email lỗi | Nhận được mã và đi tiếp | `US6:62` (AC5), `US6:75` + `EPIC:151` (câu hỏi #8 còn mở), `EPIC:184` (rủi ro "Email OTP vào Spam / đến chậm"). Người cụ thể là **persona giả thuyết phục vụ review** |
| P6 | Người **được mời vào workspace qua email**, chưa có tài khoản, đăng ký bằng chính email được mời | Vào workspace đã mời | `EPIC:136` "hiện chỉ mời bằng email", `US5:8`, `US9:46` liệt kê "được mời"; Q-01 còn mở |
| P7 | Người dùng app **iOS** chưa có tài khoản | Tìm cách đăng ký | `US6:58` (AC2), `EPIC:31`, `BUG10:28` — chỉ trong phạm vi "không vào được" |
| P8 | **(Lượt 2)** Người dùng trên **thiết bị dùng chung** (máy gia đình / máy cửa hàng / máy công ty nhiều người dùng) hoặc có email nằm trong danh sách chặn — có thể gặp hai nhánh chặn Q-18 ở màn 11 | Đăng ký bằng email của chính mình | Tên frame Figma `1819:5296`, `1819:5430`; `EPIC:157` câu hỏi #14 (giới hạn theo thiết bị/IP — chưa chốt). Hoàn cảnh là **persona giả thuyết phục vụ review**; closedScope → chỉ ghi rủi ro |

## 3. Hành trình đã review

Tất cả hành trình là **mô phỏng bằng suy luận** từ tài liệu (Mode 3), chưa thao tác thật.

| Hành trình | Persona | Mục tiêu → các bước → phản hồi hệ thống → kết quả cuối → cách phục hồi | Nguồn |
| --- | --- | --- | --- |
| J1 — Luồng chính Web | P1 | Mục tiêu: có tài khoản và chat ngay. Màn 01 bấm "Đăng ký" → 11 tab Email, gõ email, "Gửi mã xác thực" → 12 "Mã [__] số đã được gửi tới ng•••••@congty.vn", gợi ý Spam, "Gửi lại mã sau 00:59" → mở hộp thư tab khác, lấy mã, quay lại gõ 6 số, Xác nhận → 13 email + nhãn "Đã xác thực", gõ 2 ô mật khẩu, Đăng ký → tạo tài khoản → 14 "Đăng ký thành công", "Tên hiển thị: nguyenvana@congty.vn — Bạn có thể đổi trong Tài khoản › Thông tin tài khoản" → "Bắt đầu sử dụng" → tạo workspace (nếu chưa có) → 15 ChatGoni chat ngay, "Hạn mức 5 giờ: 33% đã dùng" sau 1 câu, link "Xác thực SĐT để nâng hạn mức", Pro có khóa → menu Tài khoản → Thông tin tài khoản: họ tên = email, SĐT "Chưa có", email "Đã xác thực" không nút Đổi → Sửa họ tên → lưu. Phục hồi: sai định dạng → lỗi tại ô (AC3); mật khẩu sai → lỗi tại ô (AC9). | `US3:52`; `US6:57-69`; wireframe 11–14; `US7:61-65`; `US5:66-67`; 02 mục 4 #3, #6, #7 |
| J2 — Luồng chính Android, rời app lấy mã | P2 | Như J1 tới màn 12 → chuyển sang app email lấy mã (app Gopany ra nền) → quay lại: theo Hồng chọn Q-04 (b) còn ở màn 12 `[GIẢ ĐỊNH]`; nếu hệ điều hành tắt app → làm lại từ bước 1 → gửi mã lần nữa → chịu chờ 60 s và cộng lượt gửi (US2). Kết quả cuối như J1. | `US6:71`; 02 mục 4 #20; `US2:46-47`, `US2:70` |
| J3 — Email đã có tài khoản | P3 | 11 gõ email đã có tài khoản → "Gửi mã xác thực" → không gửi OTP; "báo đã đăng ký, gợi ý Đăng nhập" (nguyên văn chưa có, Q-07) → bấm Đăng nhập → 01 gõ email + mật khẩu. Nếu tài khoản là Google (không có mật khẩu, `US9:50`): gõ mật khẩu → AC5 US3 "Email/số điện thoại hoặc mật khẩu không đúng" → lối ra: nút Google ở màn 01 hoặc Quên mật khẩu (`US9:69`) — tài liệu US6 không dẫn tới lối này. | `US6:61`; `US9:46`, `US9:50`, `US9:69`; `US3:56` |
| J4a — Không gửi được email | P5 | 11 bấm "Gửi mã xác thực" → dịch vụ gửi lỗi → ở lại màn 11, báo lỗi, "thử lại" = bấm lại (theo Hồng chọn Q-02 a `[GIẢ ĐỊNH]`: gửi ngay, không tính lượt). Nếu lỗi là timeout mà mail đã đi (02 mục 4 #18) → bấm lại là lần gửi thứ hai → chờ 60 s. Kết quả: hoàn thành nếu lần sau gửi được; bỏ dở nếu lỗi lặp. | `US6:62`; user flow `US6:21`; 02 mục 4 #17, #18 |
| J4b — Email đến chậm / vào Spam | P5 | 12 chờ mã → không thấy → đọc gợi ý Spam → vẫn không thấy → hết 60 s bấm "Gửi lại mã" → mã cũ hết hiệu lực (`US2:45`) → email đầu tiên đến muộn → gõ mã trong email đó → "Mã OTP không đúng" (`US2:64`), tốn lượt sai → nếu sai quá [__] lần → tạm khóa (`US2:67`). Phục hồi: tìm đúng email mới nhất. | `US6:64`; `US2:45`, `US2:60`, `US2:64`, `US2:67`; `EPIC:184` |
| J5 — Đứng lâu ở màn 13 | P2 | 12 xác nhận đúng → 13 → bị gián đoạn 20–30 phút → gõ mật khẩu, Đăng ký → theo Hồng chọn Q-03 (a) tạo được tài khoản `[GIẢ ĐỊNH]`; nếu BE có thời hạn như US4 (10 phút, `US4:53`) → bị từ chối; màn 13 **không vẽ Quay lại** → tài liệu không nói về đâu. | `US6:66`; 02 mục 4 #16; wireframe màn 13 |
| J6 — Thoát ở màn 14 không bấm "Bắt đầu sử dụng" | P1 | 13 Đăng ký → 14 → đóng tab / tắt app → hôm sau màn 01 đăng nhập email + mật khẩu → theo Hồng chọn Q-05 (a) tài khoản đã tồn tại `[GIẢ ĐỊNH]`; đích đến (ChatGoni thẳng hay màn tạo workspace) tài liệu không nói. | `US6:69`; 02 mục 4 #19; `US3:55` |
| J7 — Email được mời vào workspace | P6 | Nhận email mời → mở Gopany (Android/Web) → 11 gõ email được mời → (a) AC4 chặn "đã đăng ký" → bấm Đăng nhập nhưng chưa từng đặt mật khẩu → kẹt; (b) được đăng ký → 14 → "tạo workspace (nếu chưa có)": vào workspace mới hay workspace đã mời — tài liệu không nói. Cả hai nhánh đều chưa có dòng đỡ. | `US6:46`, `US6:61`, `US6:69`; `US9:46`; `EPIC:136`; Q-01; 02 mục 4 #15 |
| J8 — Ngoài Việt Nam | P4 | 01 → 11: không có tab Số điện thoại, chỉ Email, không giải thích → J1 → 15 ChatGoni hạn mức thấp, link "Xác thực SĐT để nâng hạn mức" → màn 18 yêu cầu SĐT di động VN có Zalo (`EPIC:97`, wireframe 18 "+84") → người không có SĐT VN / Zalo không nâng được. | `EPIC:107`, `US1:57`; `US6:50`; `US7:63`; `EPIC:183` |
| J9 — iOS | P7 | Màn 01 không có link Đăng ký (`US3:53`) → mọi đường back/link/deep link không vào màn 11 → không có lối đăng ký trong app; tài liệu không nói app có hướng dẫn "đăng ký trên web/Android" ngoài trường hợp Google (`US9:64`). | `US6:58`; `BUG10:28`, `BUG10:35-36`; 02 mục 4 #8 |
| J10 — **(Lượt 2)** Bị chặn ở màn 11 theo hai nhánh Q-18 (closedScope) | P8 | 11 gõ email hợp lệ, bấm "Gửi mã xác thực" → design có hai frame chặn (tên frame: "Thiết bị đã vượt giới hạn số lượng email được phép sử dụng" / "Email thuộc danh sách chặn"; chữ lỗi chưa đọc, không ảnh) → bước kế: không có frame tiếp theo trong danh sách frame mục US6, tài liệu không có quy tắc → **không ghi nhận được** đường phục hồi; lối còn lại trên màn theo lớp text là "Đã có tài khoản? Đăng nhập" và "Tiếp tục với Google" — không dành cho người chưa có tài khoản. Hành trình dừng ở đây, không suy đoán thêm. | lớp text Figma `1819:5296`, `1819:5430`; `EPIC:157`; Q-18 |

**Đối chiếu lượt 2 với Figma (chỉ 5 frame có ảnh + email mẫu; không đổi cấu trúc hành trình):** J1/J2 màn 11 khớp wireframe về phần
tử (tab, ô, nút "Gửi mã xác thực" mờ khi ô trống, Google, Điều khoản, "Đã có tài khoản? Đăng nhập"); thanh tiến trình 3 vạch không
có chữ "Bước 1/3" (CX-21); lỗi AC3 hiện đỏ ngay dưới ô "Email không đúng định dạng" (khớp 02 §4 d.21). J1 màn 12: tiêu đề "Nhập mã
xác thực", link góc phải **"Đổi số"** (CX-16), **không có** khung gợi ý Spam (CX-17), chỉ "Chưa nhận được mã?" + đồng hồ "45s" không
có nút (CX-18), nút "Xác thực", bàn phím số. J1 màn 14: dòng đầu **"Tài khoản của bạn đã được tạo với số điện thoại +84 912 345 678."**
(CX-15); khung tên hiển thị và nút "Bắt đầu sử dụng" khớp wireframe; dòng "bạn có thể đổi trong: Tài khoản → Thông tin tài khoản" là
chữ thường, không phải link (CX-01). J3: AC4 là **popup** "Email này đã được đăng ký. Bạn có muốn đăng nhập không?" với "Hủy" /
"Đăng nhập" — không có lối Quên mật khẩu / Google (CX-07 cập nhật, Q-16). J4b: email mẫu khớp mẫu 23 về cấu trúc; chân thư còn
placeholder "[email hỗ trợ] · [hotline]" (CX-20). J5 màn 13: không ảnh — không đối chiếu (lớp text cho thấy có nút Quay lại, CX-04).
J4a, J6, J7, J8, J9: Figma mục US6 không có frame tương ứng → không đổi.

## 4. Tổng hợp finding

| ID | Loại | Tóm tắt | Persona | Impact | Mức bằng chứng | Trace (BR / UC / case) |
| --- | --- | --- | --- | --- | --- | --- |
| CX-01 | Usability Issue | Tên hiển thị = email: màn 14 chỉ nhắc "đổi trong Tài khoản → Thông tin tài khoản" (**Figma xác nhận**: chữ thường, không phải link; nút duy nhất "Bắt đầu sử dụng"); email của người dùng trở thành tên hiện với người khác cho tới khi họ tự đổi | P1, P6 | Trung bình | phân tích tài liệu + Figma màn 14 | BR3, AC10, E-04 · UC-01 bước 4 · `US5:67` · [US6_40] [US6_41] [US6_52] |
| CX-02 | CX Risk (rủi ro giả định) | Email OTP đến chậm / vào Spam: bấm "Gửi lại mã" làm mã cũ hết hiệu lực; email đến muộn chứa mã đã vô hiệu → "Mã OTP không đúng", tốn lượt sai, có thể tạm khóa. **Lượt 2:** email mẫu Figma không ghi giờ gửi / không nói mã cũ hết hiệu lực khi gửi lại; màn 12 không có gợi ý Spam (CX-17) → rủi ro giữ nguyên | P5, P2 | Cao | mô phỏng bằng suy luận (+ Figma màn 12, email mẫu) | AC6, AC7, E-10, E-16 · `US2:45`, `US2:64`, `US2:67` · Epic #8 (`EPIC:151`) · Q-11 · [US6_24] [US6_68] |
| CX-03 | CX Risk (rủi ro giả định) | AC5 lỗi gửi email và "thử lại": người dùng không phân biệt lỗi do email mình gõ hay do hệ thống; nếu thử lại chịu chờ 60 s / tính lượt (Q-02 mở) thì bị chặn mà chưa từng thấy màn 12. **Lượt 2:** Figma không có frame AC5 → không đổi | P5, P1 | Trung bình–Cao | mô phỏng bằng suy luận | AC5, AC11 · Q-02, Q-07 · 02 mục 4 #17, #18 · [US6_18] [US6_19] `❓` [US6_53] |
| CX-04 | CX Risk (rủi ro giả định) | Đứng lâu ở màn 13 (Q-03 mở): nếu có thời hạn mà màn không hiện, người dùng gõ xong mật khẩu mới bị từ chối. **Lượt 2:** lớp text frame 13 **có** nút Quay lại (khác wireframe) nhưng về đâu chưa rõ (Q-10 bổ sung); frame không ảnh | P2 | Trung bình | mô phỏng bằng suy luận | BR2, AC8, AC10 · Q-03, Q-10 · 02 mục 4 #16 · [US6_29] `❓` |
| CX-05 | CX Risk (rủi ro giả định) | Android phải rời app để lấy mã; app bị tắt → làm lại từ bước 1, gửi mã lần nữa, chịu 60 s và cộng lượt gửi US2 (Q-04 mở). **Lượt 2:** Figma không thể hiện cơ chế phiên → không đổi | P2 | Trung bình | mô phỏng bằng suy luận | AC11, E-06 · Q-04 · 02 mục 4 #20 · `US2:46-47`, `US2:70` · [US6_57] [US6_58] `❓` |
| CX-06 | CX Risk (rủi ro giả định) | Thoát ở màn 14 không bấm "Bắt đầu sử dụng" (Q-05 mở): màn 14 không cho biết tài khoản đã dùng được. **Lượt 2:** Figma màn 14 cũng viết "đã được tạo" và chỉ có một nút → giữ | P1 | Trung bình | mô phỏng bằng suy luận (+ Figma màn 14) | AC10 · Q-05 · 02 mục 4 #19 · `US1:68`, `US3:55` · [US6_49] `❓` [US6_46] [US6_47] |
| CX-07 | Usability Issue | AC4 "gợi ý Đăng nhập" không đủ cho email đã gắn tài khoản Google (không có mật khẩu) hoặc người được mời. **Lượt 2 — Figma xác nhận:** AC4 là popup "Email này đã được đăng ký. Bạn có muốn đăng nhập không?" chỉ có "Hủy" / "Đăng nhập", không phân biệt loại tài khoản, không có lối Quên mật khẩu / Google; "Hủy" về đâu không rõ | P3, P6 | Cao (hành trình thất bại) | phân tích tài liệu + Figma popup | BR1, AC4, E-17 · `US9:46`, `US9:50`, `US9:69`, `US3:56` · Q-16 · [US6_10] [US6_11] [US6_12] [US6_72] |
| CX-08 | Usability Issue | Helper / câu lỗi / trạng thái nút màn 13 chưa rõ. **Lượt 2:** frame 13 **không có ảnh**, helper và badge chưa đọc được; quy định mật khẩu đang tranh chấp (Q-17 — cổng đóng cho AC9) → giữ finding, **không đề xuất expected / con số** | P1, P2 | Trung bình | phân tích tài liệu (Figma màn 13 chưa đọc được) | AC9, E-09 · Q-07, Q-10, **Q-17 (closedScope)** · 02 mục 4 #13 · [US6_33]→[US6_37] [US6_64] [US6_65] |
| CX-09 | Usability Issue | Màn 12 có hai lối về màn 11 không rõ khác nhau; về màn 11 email điền sẵn hay trống, mã còn hiệu lực không (Q-09 mở). **Lượt 2 — Figma xác nhận** có "Quay lại" + link góc phải (nhãn "Đổi số" → CX-16) | P1 | Thấp–Trung bình | phân tích tài liệu + Figma màn 12 | AC6, E-15 · Q-09 · 02 mục 4 #2 · [US6_20] [US6_42] [US6_62] |
| CX-10 | CX Risk (rủi ro giả định) | Email được mời vào workspace (Q-01 mở): nhánh chặn → người được mời không có mật khẩu để "Đăng nhập"; nhánh cho đăng ký → có thể vào workspace mới thay vì workspace đã mời. **Lượt 2:** popup AC4 trên Figma không có lối nào cho người chưa đặt mật khẩu → nhánh chặn nặng hơn | P6 | Cao | mô phỏng bằng suy luận (+ Figma popup) | BR1, AC4, AC10 · Q-01 · 02 mục 4 #15 · `EPIC:136`, `US5:8`, `US9:46` · [US6_15] `❓` |
| CX-11 | CX Risk (rủi ro giả định) | Hạn mức thấp 3 câu/5 giờ không được báo trước ở màn 11–14; người ngoài VN / không dùng Zalo không có cách nâng. **Lượt 2:** ba frame có ảnh (11, 12, 14) không có chữ nào về hạn mức | P4, P1 | Trung bình | mô phỏng bằng suy luận (+ Figma 11/12/14) | BR5, E-11 · `US7:50`, `US7:63`, `US7:68` · `EPIC:97`, `EPIC:183` · 02 mục 4 #6 · [US6_50] [US6_51] [US6_73] |
| CX-12 | Usability Issue | Ngoài VN, màn 11 bỏ tab Số điện thoại mà không có lời giải thích (thuộc US1 AC2, Q-14). **Lượt 2:** Figma mục US6 chỉ có frame hai tab (IP VN) → không đổi | P4 | Thấp | phân tích tài liệu | BR4, E-07 · `US1:57` · Q-14 · 02 mục 4 #4 · [US6_44] [US6_45] |
| CX-13 | CX Risk (rủi ro giả định) | Response rớt sau khi BE đã tạo tài khoản (Q-13 mở): làm lại sẽ gặp popup AC4 trong khi người dùng tin mình chưa đăng ký xong | P5 | Trung bình | mô phỏng bằng suy luận | AC11, AC4, BR2 · Q-13 · `01` mục 8 #9 · [US6_59] `❓` |
| CX-14 | Improvement Suggestion | Ô OTP màn 12 nhận dán chuỗi 6 số. **Lượt 2:** Figma vẽ 6 ô rời + bàn phím số; dán / tự chuyển ô không thể hiện trên design → giữ | P1, P2 | Thấp–Trung bình | phân tích tài liệu + Figma màn 12 | AC6, AC8, E-14 (màn dùng chung US2) · [US6_20] · dán: nhóm B theo `06` |
| CX-15 | CX Risk (rủi ro giả định) | **(Lượt 2)** Màn 14 Figma ghi "Tài khoản của bạn đã được tạo với **số điện thoại +84 912 345 678**." trong khi người dùng vừa đăng ký bằng email, không hề nhập SĐT (BR3) và tài khoản chưa có SĐT (BR5); cùng màn ghi tên hiển thị = email → mâu thuẫn ngay bước thành công, nghi nhầm tài khoản / lo bảo mật | P1, P4, P2 | Cao nếu lên build như design · Thấp nếu chỉ là lỗi copy | phân tích design (Figma) | BR3, BR5, AC10 · Q-19 · [US6_40] [US6_46] [US6_47] |
| CX-16 | Usability Issue | **(Lượt 2)** Màn 12 trên luồng email ghi link **"Đổi số"** (AC6: "nút Đổi email") — người gõ nhầm email không chắc link này sửa email hay chuyển sang đăng ký bằng SĐT; làm CX-09 nặng thêm | P1, P2 | Thấp–Trung bình | phân tích design (Figma) | AC6, E-15 · Q-09 · [US6_20] [US6_42] [US6_62] · CX-09 |
| CX-17 | CX Risk (rủi ro giả định) | **(Lượt 2)** Màn 12 Figma **không có** gợi ý kiểm tra Spam dù AC6 yêu cầu, Epic #8 còn mở và `EPIC:184` ghi đây là biện pháp đỡ duy nhất; email vào Spam → người dùng chỉ còn cách chờ rồi gửi lại nhiều lần (tốn lượt, mã cũ vô hiệu — CX-02), bỏ dở | P5, P2 | Cao | phân tích design (Figma; giới hạn: chữ trong instance không bóc được) | AC6, E-15 · Epic #8 (`EPIC:151`), `EPIC:184` · Q-09 · [US6_20] [US6_68] · CX-02 |
| CX-18 | Usability Issue | **(Lượt 2)** Màn 12 khi đang đếm chỉ có câu hỏi "Chưa nhận được mã?" và đồng hồ "45s" — không có nút / động từ cho biết hết giờ sẽ có gì; người dùng không biết làm gì tiếp (chờ? bấm Quay lại / Đổi số? gửi lại tự động?). Trạng thái sau 0 s không có ảnh | P1, P2, P5 | Trung bình | phân tích design (Figma) | AC6, AC7 · `US2:46`, `US2:59` · 02 mục 4 #11 · Q-09 · [US6_20] [US6_24] |
| CX-19 | CX Risk (rủi ro giả định) | **(Lượt 2 — closedScope Q-18)** Hai frame chặn ở màn 11 ("Thiết bị đã vượt giới hạn số lượng email…", "Email thuộc danh sách chặn") không có trong US6; không có frame kế tiếp, không có quy tắc → người bị chặn (kể cả người hợp lệ trên thiết bị dùng chung, email bị chặn nhầm) không có đường thoát ghi nhận được. **Chỉ ghi rủi ro, không expected** | P8, P1 | Chưa đánh giá được (thiếu ngưỡng, cách nhận diện thiết bị); nếu là hành vi thật → thất bại hành trình không phục hồi | phân tích design (tên frame + lớp text; không ảnh) | Unlinked với BR/AC US6 · Q-18 · `EPIC:157` #14 · case: placeholder `❓` theo closedScope |
| CX-20 | CX Risk (rủi ro giả định) | **(Lượt 2)** Email OTP mẫu: chân thư còn placeholder "[email hỗ trợ] · [hotline]" (dùng chung cả ba email mẫu); tiêu đề (subject) không có trên design dù mẫu 23 yêu cầu "tiêu đề chứa mã". Nếu lọt lên môi trường thật: email trông chưa hoàn thiện / giống lừa đảo đúng lúc đang nhắc "Gopany không bao giờ hỏi mã"; người cần hỗ trợ không có kênh | P5, P1 | Trung bình | phân tích design (Figma) | AC6, E-16 · `US2:38` · 02 mục 4 #11 · [US6_21] |
| CX-21 | Usability Issue | **(Lượt 2)** Thanh tiến trình 3 vạch màu, không có chữ "Bước x/3" (wireframe có): người dùng không biết còn mấy bước; chỉ dựa vào màu xanh/xám → khó với người khó phân biệt màu, trình đọc màn hình không có gì để đọc (chưa kiểm được) | P1, P2 | Thấp | phân tích design (Figma) | AC1 (hiển thị) · [US6_01] · Unlinked với BR |

Số lượng theo loại: Defect **0** · Usability Issue **8** (CX-01, 07, 08, 09, 12, 16, 18, 21) · CX Risk **12** (CX-02, 03, 04, 05, 06,
10, 11, 13, 15, 17, 19, 20) · Improvement Suggestion **1** (CX-14). Tổng **21** (14 cũ giữ ID, 7 mới từ Figma; đóng 0).

Severity trong cột Impact là **đề xuất của CX** kèm lý do ở từng finding; người có thẩm quyền (PdM Hường / BA Chình) chốt.

## 5. Chi tiết finding

### CX-01 — Tên hiển thị = email: màn 14 chỉ nhắc chỗ đổi, không có lối đi

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-01 |
| Review scope | Màn 14 "Đăng ký thành công" và bước sau (ChatGoni, Thông tin tài khoản) |
| Source evidence | `US6:48` BR3 "họ tên tự tạo = email đăng ký (VD: nguyenvana@congty.vn), sửa được trong Thông tin tài khoản (US5)" · `US6:69` AC10 "tên hiển thị = email đăng ký + gợi ý đổi tên" · wireframe màn 14 (`US6:29`): "Tên hiển thị: nguyenvana@congty.vn — Bạn có thể đổi trong Tài khoản › Thông tin tài khoản." và một nút duy nhất "Bắt đầu sử dụng" · `EPIC:104`, `EPIC:148` (chốt 12/10, Hường) · `US5:7` "cần chỗ sửa tên" · `US5:67` AC3 "tên mới hiện ngay ở mọi nơi" |
| Persona và context | P1 (người dùng mới, Web); P6 (được mời vào workspace — email sẽ hiện như tên trước đồng nghiệp; persona có căn cứ một phần) |
| Customer journey / scenario | J1 bước màn 14 → ChatGoni → Thông tin tài khoản |
| Observation | `[CX GIẢ THUYẾT]` Màn 14 nói "bạn có thể đổi trong Tài khoản › Thông tin tài khoản" nhưng hành động duy nhất là "Bắt đầu sử dụng" đưa thẳng vào ChatGoni; người dùng phải nhớ đường dẫn hai cấp và tự tìm sau. Với người được mời vào workspace, tên = email hiện với thành viên khác ("tên mới hiện ngay ở mọi nơi" `US5:67` ngụ ý tên hiện ở nhiều nơi) cho tới khi tự đổi. Đây là hệ quả của quyết định đã chốt (`EPIC:148`), không phải lỗi; điểm CX là **khoảng cách giữa lời gợi ý và hành động**. |
| Finding type | Usability Issue |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — requirement chỉ yêu cầu "gợi ý đổi tên", không yêu cầu lối đi trực tiếp; không có quan sát thực tế |
| Impact | Trung bình — không chặn hành trình; giảm cảm giác "tài khoản của tôi" ngay sau đăng ký; email có thể hiện với người khác lâu hơn mong muốn. Lý do mức: hành trình vẫn hoàn thành, nhưng gợi ý không hành động được là điểm bỏ dở nhỏ ở bước thành công |
| Evidence và confidence / limitations | **Lượt 2:** ảnh Figma `figma/US6_1641-50321_thanh-cong.png` — khung "Tên hiển thị: nguyenvana@congty.vn / bạn có thể đổi trong: Tài khoản → Thông tin tài khoản" là chữ thường trên nền xám, không có kiểu link; nút duy nhất "Bắt đầu sử dụng" → điểm "gợi ý không hành động được" nay có căn cứ design `[NGUỒN]`. Tên hiện ở đâu trong workspace/chat sau đăng ký: tài liệu và Figma mục US6 không nói. Độ tin cậy trung bình–cao về design; hành vi FE chưa kiểm |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-01: màn 14 thêm lối phụ "Đổi tên hiển thị" mở thẳng Thông tin tài khoản (không đổi BR3 — vẫn không nhập họ tên ở bước đăng ký). QA: ĐO & GHI tên = email hiện ở những đâu ngay sau đăng ký (menu, ChatGoni, workspace) |
| Traceability | BR3 `US6:48` · AC10 `US6:69` · E-04 · UC-01 bước 4 · 02 mục 4 #3 · Test case: [US6_40] (tên = email trên màn 14 và Thông tin tài khoản), [US6_41] (sửa họ tên), [US6_52] · Figma `1641:50321` |
| Open questions / quyết định cần Product · BA · UX | Product/UX: có lối đổi tên ngay ở màn 14 không; Q-08 (tên giữ chữ hoa/thường như gõ) ảnh hưởng chuỗi hiện ở màn 14 |

### CX-02 — Email đến chậm / vào Spam: gửi lại làm mã trong email đến muộn vô hiệu

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-02 |
| Review scope | Màn 12 — chờ mã, "Gửi lại mã", nhập mã |
| Source evidence | `US6:64` AC6 "gợi ý kiểm tra Spam" · wireframe màn 12: "Chưa nhận được mã? Gửi lại mã sau 00:45", khung "Không thấy email? Kiểm tra hộp thư Spam hoặc Quảng cáo." · `US2:45` BR2 "Gửi mã mới → mã cũ hết hiệu lực" · `US2:60` AC5 · `US2:64` AC8 "Nhập mã cũ sau khi đã gửi mã mới → Báo mã không đúng" · `US2:67` AC10 tạm khóa khi sai quá [__] lần · `US2:77` câu hỏi mở "nhập mã cũ có tính 1 lần sai không" · `US6:75` + `EPIC:151` câu hỏi #8 "Dịch vụ gửi email OTP có đủ nhanh, ít vào Spam không?" **còn mở** · `EPIC:184` rủi ro "Email OTP vào Spam / đến chậm → Gợi ý kiểm tra Spam; cho gửi lại mã" · `US2:38` mẫu 23 "tiêu đề chứa mã" |
| Persona và context | P5 (email đến chậm — persona giả thuyết); P2 (Android, chuyển qua lại giữa hai app) |
| Customer journey / scenario | J4b |
| Observation | `[CX GIẢ THUYẾT]` Khi email đến chậm hơn 60 giây, người dùng theo đúng gợi ý trên màn (gửi lại) sẽ tự làm mã đầu tiên vô hiệu. Email đầu tiên đến sau đó, tiêu đề chứa mã (`US2:38`), người dùng gõ mã nhìn thấy đầu tiên → "Mã OTP không đúng" (`US2:64`) → không hiểu vì mã "đúng như trong email". Nếu hai email cùng tới, người dùng không có dấu hiệu nào trên màn 12 hay trong email để biết mã nào còn hiệu lực. Việc nhập mã cũ có tính lượt sai hay không chưa chốt (`US2:77`); nếu có, lặp vài lần dẫn tới tạm khóa (`US2:67`) với con số chưa chốt (Q-11). Hướng xử lý ở `EPIC:184` ("gợi ý Spam, cho gửi lại") chưa đỡ được tình huống này. |
| Finding type | CX Risk — rủi ro giả định |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — hành vi mã cũ hết hiệu lực đúng `US2:45`; không có quan sát thực tế |
| Impact | Cao — là mục tiêu chính của story ("chắc chắn email của tôi đúng" `US6:11`) và là rủi ro Epic tự nêu còn mở; có thể bỏ dở ngay bước 2, mất niềm tin ("mã trong email mà bảo sai"), hoặc bị khóa OTP cho email đó (tính chung mọi luồng `US2:70` → ảnh hưởng cả Quên mật khẩu). Lý do mức: tần suất phụ thuộc dịch vụ gửi (chưa đo), nhưng hậu quả là thất bại hành trình |
| Evidence và confidence / limitations | **Lượt 2:** đã xem email mẫu `figma/EMAIL_1859-3924_otp-dangky.png`: có "Mã có hiệu lực trong 5 phút và chỉ dùng được một lần", **không** có giờ gửi, **không** nói mã cũ hết hiệu lực khi gửi lại → hai email tới gần nhau vẫn không phân biệt được; màn 12 Figma không có gợi ý Spam (CX-17) và khi đang đếm không có nút (CX-18). Không biết độ trễ thực tế của dịch vụ gửi. Độ tin cậy trung bình–cao về hành vi hệ thống theo tài liệu, giả thuyết về phản ứng người dùng |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-02: (a) màn 12 sau khi bấm Gửi lại hiện dòng "Chỉ mã trong email mới nhất có hiệu lực" (câu chữ do UX; thuộc US2 vì màn dùng chung `EPIC:90`); (b) email mẫu 23 ghi giờ gửi để phân biệt. QA: đề xuất case gửi lại rồi nhập mã của email đầu → theo `US2:64`; ĐO & GHI thời gian email tới và tỷ lệ vào Spam trên vài nhà cung cấp hộp thư (câu hỏi #8 Epic) |
| Traceability | AC6 `US6:64` · AC7 `US6:65` · E-10, E-16 · `US2:45`, `US2:60`, `US2:64`, `US2:67` · Q-11 · Test case: [US6_24] (gửi lại, mã cũ hết hiệu lực), [US6_68] (thời gian tới / Spam), [US6_25] `❓`; case "gửi lại rồi nhập mã email đầu" — `06` ghi thêm nhóm B · Figma `1641:50362`, `1859:3924` |
| Open questions / quyết định cần Product · BA · UX | BE Chiến: câu hỏi #8 Epic (dịch vụ gửi, địa chỉ gửi); Hường: `US2:77` nhập mã cũ có tính lần sai không |

### CX-03 — AC5 lỗi gửi email: người dùng không biết lỗi ở đâu và "thử lại" có bị chặn không

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-03 |
| Review scope | Màn 11 — bấm "Gửi mã xác thực" khi dịch vụ gửi lỗi hoặc request không có response |
| Source evidence | `US6:62` AC5 "Không gửi được email → Báo lỗi, cho thử lại" · user flow `US6:21`: nhánh "Gửi email được? Không → Báo lỗi, cho thử lại · AC5" đặt trước màn 12 · wireframe màn 11 khung "Báo lỗi ngay ở bước này: … Không gửi được email" · `US6:71` AC11 "mất mạng, lỗi hệ thống → báo lỗi tiếng Việt, cho thử lại" · `US2:17` "lỗi không gửi được mã – xử lý trong từng luồng" · `US2:46` BR3 chờ 60 s · `US2:47` BR4 giới hạn lượt gửi · 02 mục 3 Q-02 (mở; Hồng chọn (a) `[GIẢ ĐỊNH]`) · 02 mục 4 #17, #18 · Q-07 thông báo chưa có nguyên văn |
| Persona và context | P5 (gặp lỗi gửi — persona giả thuyết); P1 |
| Customer journey / scenario | J4a |
| Observation | `[CX GIẢ THUYẾT]` Ba điểm: (1) Thông báo AC5 chưa có nguyên văn; nếu chỉ là "Không gửi được email, vui lòng thử lại" người dùng sẽ nghi email mình gõ sai và đi sửa email thay vì chờ — hoặc ngược lại, bấm liên tục. (2) Nếu "thử lại" chịu chờ 60 s hoặc tính lượt gửi (Q-02 mở, tài liệu không nói) thì người dùng bị chặn / chạm giới hạn trong khi chưa từng nhận được mã nào — khó hiểu hơn US2 AC6 vì chưa thấy màn 12 có đếm ngược. (3) Trường hợp timeout mà mail đã đi (02 mục 4 #18): bấm lại là lần gửi thứ hai → "chờ 60 s" hiện ở màn 11, nơi wireframe không vẽ đếm ngược. CX không chọn cách hiểu cho Q-02; chỉ ghi rủi ro ở cả hai phương án. |
| Finding type | CX Risk — rủi ro giả định |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — Q-02 chưa có câu trả lời nguồn; không có quan sát thực tế |
| Impact | Trung bình–Cao — bỏ dở ở bước 1 khi dịch vụ gửi chập chờn (rủi ro #8 Epic); tốn lượt gửi cho email đó. Lý do mức: xảy ra theo sự cố dịch vụ chứ không thường xuyên, nhưng người dùng mới chưa có gì để mất nên dễ bỏ đi |
| Evidence và confidence / limitations | Chỉ từ AC5/AC11 và user flow; cách BE nhận biết "không gửi được" chưa có (02 mục 4 #17). **Lượt 2:** Figma mục US6 không có frame AC5 / đang gửi / đếm ngược ở màn 11 → không có gì mới để đối chiếu; màn 11 có ảnh không vẽ chỗ nào cho thông báo lỗi ngoài dòng đỏ dưới ô (dùng cho AC3). Độ tin cậy trung bình |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-03: thông báo AC5 nói rõ lỗi ở phía hệ thống gửi (không phải email người dùng) và nêu hành động cụ thể ("thử lại sau ít phút"); nếu BA chốt thử lại chịu 60 s thì màn 11 cần hiện đếm ngược như màn 12. QA: đề xuất case AC5 với ba trạng thái (lỗi đồng bộ, timeout mail đã đi, timeout mail chưa đi) → ĐO & GHI thông báo và trạng thái nút |
| Traceability | AC5 `US6:62` · AC11 `US6:71` · Q-02, Q-07 · 02 mục 4 #17, #18 · Test case: [US6_18], [US6_19] `❓ Cần chốt`, [US6_53], [US6_56] |
| Open questions / quyết định cần Product · BA · UX | BA Chình / BE Chiến: Q-02 (đã gửi); bổ sung: màn 11 có đếm ngược không nếu thử lại chịu cooldown |

### CX-04 — Đứng lâu ở màn 13: nếu có thời hạn thì người dùng không được báo trước

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-04 |
| Review scope | Màn 13 — từ lúc OTP đúng tới lúc bấm Đăng ký |
| Source evidence | `US6:66` AC8 "Sang bước tạo mật khẩu, email hiện 'Đã xác thực'" · `US6:47` BR2 · `EPIC:106` "Bỏ ngang sau OTP → chưa tạo tài khoản" · wireframe màn 13: không vẽ nút Quay lại; ghi chú "Bỏ ngang ở bước này: chưa tạo tài khoản" · đối chiếu `US4:53-54` (US4 có 10 phút, hết thì BE từ chối) · 02 mục 3 Q-03 (mở; Hồng chọn (a) không giới hạn `[GIẢ ĐỊNH]`) · 02 mục 4 #12, #16 · Q-10 (màn 13 có Quay lại không) |
| Persona và context | P2 (bị gián đoạn — persona giả thuyết) |
| Customer journey / scenario | J5 |
| Observation | `[CX GIẢ THUYẾT]` Tài liệu US6 im lặng về thời hạn sau OTP. Nếu triển khai có thời hạn (giống US4) mà màn 13 không hiện gì: người dùng gõ xong hai ô, bấm Đăng ký, bị từ chối sau khi đã làm việc — giống rủi ro CX-03 của US4. Màn 13 không có Quay lại (wireframe) nên khi bị từ chối không rõ về màn 11 hay 12, email có điền sẵn không. Nếu không có thời hạn (Hồng chọn): không có rủi ro hiển thị, nhưng nhãn "Đã xác thực" đứng vô thời hạn trên một màn chưa có tài khoản — QA đã ghi nhận ở 02 mục 4 #12. CX không chọn cách hiểu. |
| Finding type | CX Risk — rủi ro giả định |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — Q-03 chưa có câu trả lời nguồn; không có quan sát thực tế |
| Impact | Trung bình — chỉ xảy ra khi gián đoạn dài; nhưng mật khẩu vừa gõ mất và người dùng nghi app lỗi. Lý do mức: tần suất thấp, hậu quả là làm lại từ đầu (gửi mã lần nữa, cộng lượt) |
| Evidence và confidence / limitations | Dựa trên so sánh với US4 và wireframe; không biết BE có thời hạn thật hay không. **Lượt 2:** lớp text frame 13 `1641:50302` có `<Button Group 2>` (nút Quay lại, giống màn 11/12) — khác wireframe "không vẽ Quay lại"; frame **không có ảnh**, không biết nút về đâu và email đã xác thực còn giữ không (Q-10 bổ sung ở 02). Phần "màn không hiện gì khi có thời hạn" chưa kiểm được. Độ tin cậy thấp–trung bình |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-04: nếu BA chốt có thời hạn → màn 13 hiện đếm ngược / dòng "hoàn tất trong N phút" và khi hết hạn về màn 11 với email điền sẵn kèm lời giải thích. Nếu không có thời hạn → không cần. QA: case đứng 20 phút ở màn 13 đã có ở 02 mục 4 #16 `❓ Cần chốt` |
| Traceability | BR2 `US6:47` · AC8 `US6:66` · AC10 `US6:69` · Q-03, Q-10 · 02 mục 4 #16 · Test case: [US6_29] `❓ Cần chốt`, [US6_27] · Figma `1641:50302` (lớp text) |
| Open questions / quyết định cần Product · BA · UX | BA / BE Chiến: Q-03 (đã gửi); bổ sung: nếu có thời hạn, màn 13 hiện gì và về đâu |

### CX-05 — Android: rời app lấy mã, app bị tắt → làm lại từ bước 1 và cộng lượt gửi

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-05 |
| Review scope | Màn 12 (và 13) trên Android khi chuyển sang app email rồi quay lại |
| Source evidence | `US6:71` AC11 "Bỏ ngang … Chưa tạo tài khoản; báo lỗi tiếng Việt, cho thử lại" · `EPIC:106` · `US1:70` AC11 US1 "quay lại phải làm từ bước 1" (luồng song song) · `EPIC:144` màn riêng trong app · `US2:46` BR3 chờ 60 s · `US2:47` BR4 giới hạn lượt · `US2:70` AC12 tính tiếp, không đếm lại · 02 mục 3 Q-04 (mở; Hồng chọn (b) giữ màn khi ra nền `[GIẢ ĐỊNH]`) · 02 mục 4 #20 |
| Persona và context | P2 (Android, hộp thư trên cùng điện thoại — bối cảnh giả thuyết) |
| Customer journey / scenario | J2 |
| Observation | `[CX GIẢ THUYẾT]` Trên Android, lấy mã email thường buộc rời app Gopany (mở app email, đọc, nhớ hoặc copy, quay lại). Nếu quay lại còn ở màn 12 (Hồng chọn) thì ổn. Nếu hệ điều hành tắt app (máy ít RAM) hoặc nếu BA chốt làm lại từ bước 1: người dùng gõ lại email, bấm gửi → chịu chờ 60 s (mã cũ còn hạn nhưng màn không cho nhập) và cộng một lượt gửi; lặp vài lần có thể chạm `US2:61`. Người dùng không được giải thích vì sao phải chờ dù "vừa mới có mã trong hộp thư". CX không chọn cách hiểu cho Q-04. |
| Finding type | CX Risk — rủi ro giả định |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — Q-04 chưa có câu trả lời nguồn; không có quan sát thực tế |
| Impact | Trung bình — Android là một trong hai nền tảng của story; mỗi lần làm lại là một lần chờ 60 s và tốn lượt. Lý do mức: không mất dữ liệu quan trọng, nhưng là điểm bỏ dở có thể lặp |
| Evidence và confidence / limitations | Không có app để biết trạng thái được giữ bao lâu. **Lượt 2:** Figma là màn tĩnh, không thể hiện cơ chế phiên / mở lại app → không có gì mới. Độ tin cậy thấp–trung bình |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-05: khi mở lại app trong lúc mã còn hạn, cho về màn 12 với email cũ và cho nhập mã cũ (không bắt gửi lại) — cần BA/BE chốt vì liên quan phiên. QA: đề xuất case mô phỏng OS tắt app ở màn 12 trong lúc mã còn hạn → ĐO & GHI về màn nào, có bắt gửi lại không (đã có `❓` ở 02 mục 4 #20) |
| Traceability | AC11 `US6:71` · E-06 · Q-04 · 02 mục 4 #20 · `US2:46-47`, `US2:70` · Test case: [US6_57], [US6_58] `❓ Cần chốt`; case OS tắt app khi mã còn hạn — `06` ghi thêm nhóm B |
| Open questions / quyết định cần Product · BA · UX | BA / FE Hoàng: Q-04 (đã gửi); bổ sung: mở lại app khi mã còn hạn có được nhập mã cũ không |

### CX-06 — Thoát ở màn 14 không bấm "Bắt đầu sử dụng": màn 14 không cho biết tài khoản đã dùng được

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-06 |
| Review scope | Màn 14 và lần đăng nhập kế tiếp |
| Source evidence | `US6:69` AC10 "Tạo tài khoản → Đăng ký thành công (…) → tạo workspace (nếu chưa có) → ChatGoni chat ngay" — không nhắc nút · wireframe màn 14: "Tài khoản của bạn đã được tạo với email …", nút "Bắt đầu sử dụng", ghi chú "Bấm → tạo workspace (nếu chưa có) → vào ChatGoni (màn 15)" · `US1:68` AC10 US1 ghi rõ "bấm 'Bắt đầu sử dụng' → tạo workspace" · `US3:55` AC4 "Đăng nhập, vào đúng workspace" · 02 mục 3 Q-05 (mở; Hồng chọn (a) `[GIẢ ĐỊNH]`) · 02 mục 4 #19 (Hồng kỳ vọng thấy màn tạo workspace — chưa khớp (a)) |
| Persona và context | P1 (Web, có thể đóng tab sau khi thấy "thành công") |
| Customer journey / scenario | J6 |
| Observation | `[CX GIẢ THUYẾT]` Wireframe màn 14 viết "Tài khoản của bạn đã được tạo" → người dùng hiểu việc đã xong và có thể đóng tab, nhất là trên web khi họ chỉ muốn "có tài khoản" trước. Lần sau đăng nhập, đích đến (ChatGoni thẳng, hay màn tạo workspace) tài liệu không nói; nếu là màn tạo workspace, người dùng không hiểu vì sao "đã đăng ký thành công" mà còn một bước nữa. Ngược lại nếu workspace được tạo ngay lúc bấm Đăng ký thì nút "Bắt đầu sử dụng" chỉ là điều hướng — hai cách hiểu cho hai trải nghiệm khác nhau. CX không chọn cách hiểu cho Q-05. |
| Finding type | CX Risk — rủi ro giả định |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — Q-05 chưa có câu trả lời nguồn; không có quan sát thực tế |
| Impact | Trung bình — không mất tài khoản (theo Hồng chọn tài khoản đã tạo), nhưng lần đầu quay lại có thể gặp màn lạ; nếu BA chốt ngược lại (chưa tạo tài khoản khi chưa bấm nút) thì impact là Cao vì người dùng tin đã có tài khoản mà đăng nhập thất bại. Lý do mức: phụ thuộc Q-05 |
| Evidence và confidence / limitations | **Lượt 2:** Figma màn 14 (`figma/US6_1641-50321_thanh-cong.png`) cũng viết "Tài khoản của bạn đã được tạo…", không có dòng nào về workspace / bước còn lại, một nút duy nhất "Bắt đầu sử dụng", không có Quay lại / đóng → thông điệp "đã xong" trên design mạnh hơn wireframe (tick xanh lớn). Không có hệ thống để biết thời điểm tạo workspace. Độ tin cậy thấp–trung bình về hành vi, cao về nội dung màn |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-06: màn 14 ghi rõ trạng thái ("Bạn có thể đăng nhập bằng email này từ bây giờ") và nếu workspace chỉ tạo khi bấm nút thì nói rõ bước còn lại. QA: case thoát ở màn 14 rồi đăng nhập hôm sau đã có `❓` ở 02 mục 4 #19; thêm ĐO & GHI đích đến sau đăng nhập |
| Traceability | AC10 `US6:69` · Q-05 · 02 mục 4 #19 · `US1:68`, `US3:55` · Test case: [US6_49] `❓ Cần chốt`, [US6_46] [US6_47] bước màn 14 · Figma `1641:50321` |
| Open questions / quyết định cần Product · BA · UX | BA / BE Chiến: Q-05 (đã gửi); bổ sung: đích đến khi đăng nhập lại sau khi bỏ qua màn 14 |

### CX-07 — AC4 "gợi ý Đăng nhập" không đủ cho email đã gắn tài khoản Google (không có mật khẩu)

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-07 |
| Review scope | Màn 11 → thông báo AC4 → màn 01 |
| Source evidence | `US6:61` AC4 "Email đã có tài khoản → Không gửi OTP; báo đã đăng ký, gợi ý Đăng nhập" · `US6:46` BR1 · `US9:45` BR1 US9 email Google = đã xác thực · `US9:46` BR2 US9 "Email Google trùng email của tài khoản đã có … → đăng nhập vào tài khoản đó" · `US9:50` BR6 US9 "Tài khoản tạo bằng Google không có mật khẩu; muốn đăng nhập bằng email + mật khẩu thì đặt mật khẩu qua Quên mật khẩu" · `US9:69` AC9 US9 · `US3:56` AC5 US3 "Email/số điện thoại hoặc mật khẩu không đúng" · `US3:44` BR3 US3 không tiết lộ tồn tại · `01` mục 8 #2, #3, #11 · Q-07 (thông báo AC4 chưa có nguyên văn) |
| Persona và context | P3 (đã có tài khoản Google / form cũ nhưng không nhớ — persona giả thuyết); **lượt 2 thêm** P6 (được mời vào workspace — nếu Q-01 chốt nhánh chặn thì cũng rơi vào popup này mà chưa từng có mật khẩu) |
| Customer journey / scenario | J3 |
| Observation | `[CX GIẢ THUYẾT]` AC4 là nơi duy nhất trong Epic hệ thống chủ động nói "email này đã có tài khoản" (đăng nhập / quên mật khẩu không tiết lộ, `EPIC:115`). Người dùng nghe theo gợi ý → màn 01 → gõ email + một mật khẩu nào đó → "Email/số điện thoại hoặc mật khẩu không đúng" (`US3:56`) — màn 01 lại **không** nói lý do (đúng BR3 US3). Với tài khoản tạo bằng Google, mật khẩu không tồn tại (`US9:50`); lối ra đúng là nút "Đăng nhập bằng Google" hoặc "Quên mật khẩu" (`US9:69`), nhưng thông báo AC4 (chưa có nguyên văn) không dẫn tới đó. Với tài khoản form cũ, lối ra là Quên mật khẩu — cũng không được dẫn. Kết quả: người dùng vòng lại màn 11 thử đăng ký, lại gặp AC4. |
| Finding type | Usability Issue |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — AC4 chỉ yêu cầu "gợi ý Đăng nhập", không quy định nội dung gợi ý; không có quan sát thực tế |
| Impact | Cao — hành trình thất bại cho nhóm có tài khoản Google (nhóm hiện hữu lớn theo `EPIC:28`: "chỉ đăng ký/đăng nhập được bằng email hoặc Google"); không có lối thoát trong câu chữ hiện tại. Lý do mức: thất bại hoàn toàn hành trình chứ không chỉ chậm |
| Evidence và confidence / limitations | **Lượt 2 — Figma đã trả lời phần "nội dung thông báo":** ảnh `figma/US6_1819-5176_email-da-dung.png` + popup tách `1819:5278`: nền tối mờ, biểu tượng thư vàng, **"Email này đã được đăng ký. Bạn có muốn đăng nhập không?"**, hai nút "Hủy" (viền) / "Đăng nhập" (xanh). `[NGUỒN]` Figma: popup **không** phân biệt loại tài khoản, **không** có "Quên mật khẩu" hay nhắc Google → lo ngại của finding không được design xử lý. `[CX GIẢ THUYẾT]` thêm: "Hủy" về đâu (đóng popup, email còn trong ô?) design không nói; popup che toàn màn nên người dùng không thấy ô email mình gõ để tự kiểm tra có gõ nhầm sang email cũ không. Độ tin cậy cao về nội dung design, giả thuyết về phản ứng người dùng; hành vi nút "Đăng nhập" (màn 01 có điền sẵn email?) chưa kiểm |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-07: thông báo AC4 kèm hai lối: "Đăng nhập" và "Quên mật khẩu?" (và/hoặc nhắc "nếu bạn từng dùng Google, hãy đăng nhập bằng Google") — câu chữ do Product/UX; không đổi BR1/AC4. QA: đề xuất case AC4 với email của tài khoản Google → bấm gợi ý → ĐO & GHI đích đến; case tiếp theo đăng nhập Google thành công (`US9:63`) |
| Traceability | BR1 `US6:46` · AC4 `US6:61` · E-17 · `US9:46`, `US9:50`, `US9:69` · `US3:56` · Q-07, **Q-16** · UC-01 AF-2 · Test case: [US6_10] (form cũ), [US6_11] (Google), [US6_12] (email thêm ở US5), [US6_72] (gợi ý Đăng nhập bấm được không, về đâu, điền sẵn email?) · Figma `1819:5176`, `1819:5278` |
| Open questions / quyết định cần Product · BA · UX | **Debate — đã mở Q-16** (02 mục 3, không trọng yếu): "gợi ý Đăng nhập" có phân nhánh theo loại tài khoản không. **Lượt 2 bổ sung vào Q-16:** popup Figma chỉ Hủy / Đăng nhập; bấm "Hủy" về đâu, email còn trong ô không; nút "Đăng nhập" có điền sẵn email sang màn 01 không. PdM Hường / BA Chình / Design Hiếu |

### CX-08 — Màn 13: helper mật khẩu chưa nêu đủ quy định; lỗi không đạt chưa có nguyên văn

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-08 |
| Review scope | Màn 13 — hai ô mật khẩu, nút Đăng ký |
| Source evidence | wireframe màn 13 (`US6:29`): ô Mật khẩu placeholder "Tối thiểu [__] ký tự", ô Xác nhận "Nhập lại mật khẩu", mỗi ô có "Hiện", nút "Đăng ký" · `US6:68` AC9 "Báo lỗi tại ô tương ứng ('Mật khẩu xác nhận không khớp.'), chưa tạo tài khoản" — chỉ có nguyên văn cho vế không khớp · `EPIC:112` quy định để trống; `EPIC:147` "8-16 ký tự gồm chữ và số" · E-09 `[ĐÃ XÁC NHẬN]` BA (US4 Q-01): 8–16, ≥1 chữ và ≥1 số · 02 mục 4 #13 · Q-07, Q-10 (nút tắt/bật, ô toàn khoảng trắng) |
| Persona và context | P1, P2 |
| Customer journey / scenario | J1 bước màn 13 |
| Observation | `[CX GIẢ THUYẾT]` Helper chỉ nói độ dài tối thiểu; người dùng gõ 10 chữ cái (không số) sẽ rớt quy định "≥1 số" mà màn không báo trước; thông báo lỗi "không đạt quy định" chưa có nguyên văn nên có thể không nêu tiêu chí thiếu. Giới hạn trên 16 ký tự cũng không được nhắc — người dùng dùng trình quản lý mật khẩu sinh 20 ký tự sẽ rớt. Nếu nút Đăng ký bật khi chưa đủ hai ô (Q-10), lỗi hiện sau khi bấm; nếu tắt, người dùng không biết vì sao không bấm được. Cùng bản chất với CX-04 của US4 (màn 05c/13 "giống màn 05c"). |
| Finding type | Usability Issue |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — wireframe chỉ tham khảo; frame 13 Figma không có ảnh, helper chưa đọc được; quy định mật khẩu chờ Q-17 (closedScope); không có quan sát thực tế |
| Impact | Trung bình — thêm một vòng sửa ở bước cuối; không chặn. Lý do mức: xảy ra thường xuyên với mật khẩu thuần chữ, nhưng phục hồi tại chỗ |
| Evidence và confidence / limitations | **Lượt 2:** frame 13 `1641:50302` **không có ảnh**; lớp text chỉ có "Tạo mật khẩu", "nguyenvana@congty.vn", một `<Badge>` (chữ chưa đọc; wireframe là "Đã xác thực"), hai `<Input field>`, một `<Button>` — helper quy định mật khẩu và câu lỗi **chưa đọc được**. `01` §6d nêu khả năng dùng chung helper với US4 màn 04 ("8–16 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt", `FIGMA 1754:6840`) khác BA (≥1 chữ, ≥1 số) → **Q-17 trọng yếu, cổng đóng cho AC9**. Finding giữ nguyên bản chất (helper phải nêu đủ quy định; lỗi phải nêu tiêu chí thiếu) nhưng **không nêu con số / không đề xuất expected** cho tới khi Q-17 chốt. Độ tin cậy trung bình |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-08 (sửa lượt 2): helper nêu đủ **quy định mật khẩu đã chốt** — con số và tiêu chí chờ Q-17, CX không chọn; lỗi không đạt nêu tiêu chí thiếu (câu chữ do UX). QA: AC9 đang trong closedScope — case [US6_33]→[US6_37] chờ Q-17; khi mở lại ĐO & GHI helper, câu lỗi, trạng thái nút (Q-07/Q-10, 02 mục 4 #13) |
| Traceability | AC9 `US6:68` · BR2 `US6:47` · E-05, E-09 · Q-07, Q-10, **Q-17 (closedScope)** · 02 mục 4 #13 · Test case: [US6_33]→[US6_37] (chờ Q-17), [US6_64] [US6_65] nhóm B · Figma `1641:50302` (lớp text) |
| Open questions / quyết định cần Product · BA · UX | UX / BA: nội dung helper và câu lỗi không đạt quy định (Q-07) |

### CX-09 — Màn 12: "Quay lại" và "Đổi email" cùng về màn 11, không rõ khác nhau

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-09 |
| Review scope | Màn 12 — điều hướng ngược |
| Source evidence | wireframe màn 12 (`US6:29`): "< Quay lại" góc trên và link "Đổi email" ngay sau email che · `US6:64` AC6 "nút Đổi email" · `US2:56` AC2 US2 · `EPIC:90` cùng một màn OTP · 02 mục 3 Q-09 (mở: về màn 11 điền sẵn hay trống; mẫu che) · 02 mục 4 #2 ("email đăng ký" = email đã qua OTP sau Đổi email) · `US2:45` mã cũ hết hiệu lực chỉ khi gửi mã mới |
| Persona và context | P1 |
| Customer journey / scenario | J1 bước màn 12; J4b (muốn đổi sang email khác khi mã không tới) |
| Observation | `[CX GIẢ THUYẾT]` Hai điều khiển cùng đưa về màn 11 nhưng ngữ nghĩa khác ("Quay lại" = hủy bước; "Đổi email" = sửa email). Tài liệu không nói: về màn 11 email có điền sẵn không; mã đã gửi cho email A còn hiệu lực không nếu người dùng quay lại rồi bấm gửi cho chính A (chịu 60 s?); bộ đếm gửi/sai theo từng email (`US2:47`) nên đổi sang B thì A vẫn bị tính. Người dùng gõ nhầm 1 ký tự email, bấm Đổi email, sửa, gửi mã cho B — không có rủi ro; nhưng bấm "Quay lại" rồi gửi lại cho A có thể gặp "chờ 60 s" ở màn 11 (nơi không vẽ đếm ngược, xem CX-03). |
| Finding type | Usability Issue |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — Q-09 chưa có câu trả lời; không có quan sát thực tế |
| Impact | Thấp–Trung bình — gây lưỡng lự, không chặn. Lý do mức: phục hồi dễ |
| Evidence và confidence / limitations | **Lượt 2:** ảnh Figma `figma/US6_1641-50362_otp.png` xác nhận hai lối: nút tròn "<" góc trên trái và link góc phải (ghi **"Đổi số"** — nhãn sai kênh, tách thành CX-16). Hai lối về đâu, điền sẵn hay trống: design tĩnh không nói. Màn dùng chung US2 nên quyết định thuộc US2. Độ tin cậy cao về bố cục, chưa kiểm hành vi |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-09: màn 12 giữ một lối ("Đổi email") hoặc "Quay lại" về màn 11 với email điền sẵn — UX chốt. QA: ĐO & GHI hai lối về màn 11 (điền sẵn / trống; gửi lại cho cùng email có chịu 60 s) |
| Traceability | AC6 `US6:64` · E-14, E-15 · Q-09 · 02 mục 4 #2 · Test case: [US6_20], [US6_42], [US6_62] (nhóm B: hai lối về màn nào, điền sẵn hay trống) · Figma `1641:50362` · CX-16 |
| Open questions / quyết định cần Product · BA · UX | BA (Q-09 đã gửi); bổ sung: "Quay lại" ở màn 12 có hủy mã đã gửi không |

### CX-10 — Email được mời vào workspace: cả hai cách hiểu Q-01 đều có điểm kẹt cho người được mời

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-10 |
| Review scope | Màn 11 (AC4) và sau màn 14 (workspace) với email đã được mời |
| Source evidence | `US6:46` BR1 "Chỉ email chưa gắn tài khoản nào" · `US6:61` AC4 · `US6:69` AC10 "tạo workspace (nếu chưa có)" · `US9:46` "tài khoản đã có (đăng ký email, form cũ, được mời)" · `EPIC:136` "hiện chỉ mời bằng email" · `US5:8` "không được mời vào workspace (hiện chỉ mời bằng email)" · `US5:57` BR8 US5 "nhận lời mời vào workspace" · 02 mục 3 Q-01 (mở; Hồng chọn (c) `[GIẢ ĐỊNH]`) · 02 mục 4 #15 (Hồng nêu thêm màn chọn tạo workspace / nhận lời mời — chưa khớp (c)) |
| Persona và context | P6 (được mời qua email, chưa có tài khoản) |
| Customer journey / scenario | J7 |
| Observation | `[CX GIẢ THUYẾT]` Người được mời là nhóm có động cơ rõ nhất (có người chờ họ vào workspace). Nhánh (a) chặn ở AC4: họ chưa từng đặt mật khẩu, "gợi ý Đăng nhập" không dùng được (như CX-07), Quên mật khẩu chưa chắc áp dụng cho "tài khoản được mời" — tài liệu không nói. Nhánh (b)/(c) cho đăng ký rồi "tạo workspace mới": họ đi hết 3 bước, bấm "Bắt đầu sử dụng" và rơi vào một workspace trống thay vì workspace đã mời, không thấy đồng nghiệp — nghĩ lời mời hỏng. Hồng kỳ vọng màn chọn (02 mục 4 #15) là một cách đỡ nhưng chưa có trong tài liệu. CX không chọn cách hiểu; ghi rủi ro cho cả hai nhánh để BA cân nhắc khi trả lời Q-01. |
| Finding type | CX Risk — rủi ro giả định |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — Q-01 chưa có câu trả lời nguồn; không có quan sát thực tế |
| Impact | Cao — ảnh hưởng nhóm được mời (kênh onboarding theo `US5:12` "để được mời vào workspace"); hậu quả là vào sai nơi hoặc kẹt ở AC4. Lý do mức: thất bại hành trình, có người thứ hai (người mời) bị ảnh hưởng |
| Evidence và confidence / limitations | Không có tài liệu về luồng mời / chấp nhận lời mời trong `tailieu/`; "được mời" chỉ xuất hiện ở `US9:46`, `EPIC:136`, `US5:8`, `US5:57`. **Lượt 2:** popup AC4 trên Figma (`1819:5176`) chỉ có Hủy / Đăng nhập → nếu BA chốt nhánh chặn, người được mời chưa có mật khẩu đứng trước popup không có lối ra (cùng CX-07); Figma mục US6 không có frame nào về workspace / lời mời sau màn 14. Độ tin cậy thấp về hành vi hệ thống, cao về tầm quan trọng của câu hỏi |
| Recommendation | Không đề xuất phương án (là câu hỏi cách hiểu — Debate/BA). Gợi ý cho BA khi chốt Q-01: ghi rõ đích đến sau màn 14 với email đã được mời. QA: case `❓ Cần chốt` đã có ở 02 mục 4 #15 |
| Traceability | BR1 `US6:46` · AC4 `US6:61` · AC10 `US6:69` · E-17 · Q-01 · 02 mục 4 #15 · Test case: [US6_15] `❓ Cần chốt` · Figma `1819:5176` |
| Open questions / quyết định cần Product · BA · UX | PdM Hường / BA Chình: Q-01 (đã gửi) — bổ sung tác động CX ở đây |

### CX-11 — Hạn mức thấp không được báo trước; người ngoài VN / không dùng Zalo không có cách nâng

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-11 |
| Review scope | Sau màn 14 → ChatGoni màn 15 (bước cuối hành trình US6) |
| Source evidence | `US6:50` BR5 "Tài khoản email mới chưa có SĐT → ChatGoni ở hạn mức thấp cho đến khi thêm SĐT (US7)" · `US6:69` AC10 "ChatGoni chat ngay" · `US7:9` "Sếp chốt: không chặn ngay sau đăng ký (dễ đuổi người dùng); cho chat ít, rồi yêu cầu xác thực SĐT" · `US7:50` BR2 mặc định 3 câu/5 giờ · `US7:52` BR4 chỉ hiện %, không hiện số câu · `US7:63` AC3 link "Xác thực SĐT để nâng hạn mức" · `US7:68` AC6 hết 100% → thẻ xác thực · wireframe màn 15 "33% đã dùng" sau 1 câu; màn 18 "+84", "Nhập số điện thoại có dùng Zalo" · `EPIC:97` SĐT hợp lệ = số di động VN · `EPIC:183` rủi ro "Người dùng không dùng Zalo không xác thực được SĐT → vẫn dùng ChatGoni ở hạn mức thấp" · `EPIC:107` đăng ký email không giới hạn IP · 02 mục 4 #6, #7 · wireframe màn 11–14: không có chữ nào về hạn mức |
| Persona và context | P4 (ngoài VN — không có SĐT VN / Zalo; hoàn cảnh giả thuyết); P1 |
| Customer journey / scenario | J8; J1 đoạn cuối |
| Observation | `[CX GIẢ THUYẾT]` (1) Suốt 4 màn đăng ký không có dòng nào nói tài khoản email sẽ ở hạn mức thấp; người dùng thấy "33% đã dùng" ngay sau câu đầu (3 câu/5 giờ) có thể bất ngờ — đây là chủ trương đã chốt (`US7:9`), CX chỉ ghi nhận kỳ vọng sai ở điểm chuyển tiếp. (2) Đăng ký email mở cho mọi IP (`EPIC:107`) nhưng cách nâng hạn mức duy nhất là SĐT di động VN có Zalo (`EPIC:97`, màn 18); người ngoài VN hoặc không dùng Zalo thấy link "Xác thực SĐT để nâng hạn mức" lặp lại trên màn 15/16 mà không thể làm — Epic đã chấp nhận rủi ro này (`EPIC:183`) nhưng không nói màn hình có giải thích gì. Phần nâng hạn mức thuộc US7; ghi ở đây vì là kết quả cuối của hành trình US6. |
| Finding type | CX Risk — rủi ro giả định |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — hành vi đúng BR5/US7; không có quan sát thực tế |
| Impact | Trung bình — không chặn đăng ký; ảnh hưởng cảm nhận ngay sau onboarding và giữ chân nhóm ngoài VN (Epic chấp nhận). Lý do mức: đã là quyết định sản phẩm; CX chỉ đề nghị quản lý kỳ vọng |
| Evidence và confidence / limitations | Dựa trên US7 và wireframe US7 (ngoài phạm vi test US6). **Lượt 2:** ba frame US6 có ảnh (11, 12, 14) và lớp text của cả 9 frame **không có chữ nào** về hạn mức / số điện thoại để nâng hạn mức (riêng màn 14 nhắc "số điện thoại" theo nghĩa khác — CX-15); frame "Chat Goni" `1641:50744` mục US7 chưa đọc → phần màn 15 vẫn theo wireframe. Độ tin cậy trung bình |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-10: màn 14 (hoặc lần đầu vào màn 15) một dòng "Tài khoản chưa có số điện thoại dùng được N câu/5 giờ; thêm SĐT để nâng" — Product chốt vì có thể trái tinh thần "không đuổi người dùng". CP-11 (thuộc US7): với tài khoản không thể xác thực SĐT VN, nội dung link/thẻ nên nói rõ điều kiện (số di động VN, Zalo). QA US6: giữ phạm vi "vào ChatGoni chat ngay, hạn mức thấp" như 02 mục 4 #6; chuyển phần ngoài VN cho US7 |
| Traceability | BR5 `US6:50` · AC10 `US6:69` · E-07, E-11, E-12 · `US7:50`, `US7:63`, `US7:68` · 02 mục 4 #4, #6 · Test case: [US6_50], [US6_51], [US6_73] (US6 chỉ kiểm dấu hiệu hạn mức thấp) |
| Open questions / quyết định cần Product · BA · UX | PdM Hường: có báo trước hạn mức thấp ở bước đăng ký không; US7: trải nghiệm cho tài khoản không có SĐT VN |

### CX-12 — Ngoài VN: tab Số điện thoại biến mất không giải thích

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-12 |
| Review scope | Màn 11 khi IP ngoài VN |
| Source evidence | wireframe màn 11 (`US6:29`) khung ghi chú "Ngoài IP Việt Nam: chỉ còn lựa chọn Email." · `US1:57` AC2 US1 "Mở màn đăng ký từ IP ngoài VN → Chỉ có đăng ký bằng Email" · `US1:45` BR1 US1 · `EPIC:107` · 02 mục 4 #4 (ba tình huống IP, "không thông báo chặn") · Q-14 (ngoài VN bỏ thanh tab hay giữ tab Email đơn lẻ — thuộc US1 AC2) |
| Persona và context | P4 |
| Customer journey / scenario | J8 bước màn 11 |
| Observation | `[CX GIẢ THUYẾT]` Người dùng ở nước ngoài (hoặc bật VPN) thấy màn 11 chỉ có Email; nếu đã quen thấy tab Số điện thoại (ví dụ trên máy khác) sẽ không hiểu vì sao. Tài liệu không yêu cầu giải thích; 02 mục 4 #4 chốt "không thông báo chặn" cho đăng ký email. Phần hiển thị tab thuộc US1 AC2 — US6 chỉ kiểm tab Email. |
| Finding type | Usability Issue |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — không có requirement về lời giải thích; không có quan sát thực tế |
| Impact | Thấp — vẫn đăng ký được bằng email. Lý do mức: không chặn, chỉ gây thắc mắc |
| Evidence và confidence / limitations | Chỉ từ ghi chú wireframe. **Lượt 2:** Figma mục US6 chỉ có frame màn 11 với hai tab (IP VN); không có frame "ngoài VN" → cách ẩn tab và lời giải thích vẫn chưa biết (Q-14). Độ tin cậy trung bình |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-12 (thuộc US1): một dòng ngắn "Đăng ký bằng số điện thoại chỉ áp dụng tại Việt Nam" khi ẩn tab — Product/UX chốt. QA: ĐO & GHI màn 11 ngoài VN theo 02 mục 4 #4 |
| Traceability | BR4 `US6:49` · E-07 · `US1:57` · Q-14 · 02 mục 4 #4 · Test case: [US6_44] bước 1, [US6_45] |
| Open questions / quyết định cần Product · BA · UX | US1 (Q-14 phần ngoài VN) |

### CX-13 — Response rớt sau khi BE đã tạo tài khoản: người dùng bị bảo "đã có tài khoản" khi làm lại

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-13 |
| Review scope | Màn 13 bấm Đăng ký → mất mạng / timeout đúng lúc BE đã tạo tài khoản |
| Source evidence | `US6:71` AC11 "mất mạng, lỗi hệ thống → Chưa tạo tài khoản; báo lỗi tiếng Việt, cho thử lại" · `US6:61` AC4 · `US6:47` BR2 · `EPIC:206` BE kiểm lại và trả mã lỗi · 02 mục 3 Q-13 (mở) · `01` mục 8 #9 `[QA BỔ SUNG]` |
| Persona và context | P5 (mạng chập chờn — persona giả thuyết) |
| Customer journey / scenario | J1 biến thể ở bước Đăng ký |
| Observation | `[CX GIẢ THUYẾT]` AC11 hứa "chưa tạo tài khoản" nhưng về kỹ thuật request có thể đã tới BE trước khi response rớt. Người dùng thấy lỗi "thử lại": (a) bấm Đăng ký lần nữa ở màn 13 — tài liệu không nói BE trả gì; (b) làm lại từ màn 11 → AC4 "email đã có tài khoản, gợi ý Đăng nhập" → họ không biết mật khẩu vừa đặt có hiệu lực không, có thể vào Quên mật khẩu. Tài liệu không có hướng dẫn cho trường hợp này. |
| Finding type | CX Risk — rủi ro giả định |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — Q-13 chưa có câu trả lời; không có quan sát thực tế |
| Impact | Trung bình — hiếm, nhưng khi xảy ra người dùng mất phương hướng ở bước cuối; nếu mật khẩu đã lưu thì đăng nhập được, nếu không thì phải Quên mật khẩu. Lý do mức: tần suất thấp, phục hồi có (Quên mật khẩu) nhưng không được dẫn |
| Evidence và confidence / limitations | Hoàn toàn suy luận từ AC11/AC4; phụ thuộc cách BE xử lý. Độ tin cậy thấp |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-13: BE/BA chốt hành vi bấm lại Đăng ký khi tài khoản đã tạo (idempotent hoặc trả "tài khoản đã được tạo, vui lòng đăng nhập") và thông báo tương ứng. QA: case `❓` đã nêu ở Q-13; ĐO & GHI mật khẩu có hiệu lực không |
| Traceability | AC11 `US6:71` · AC4 `US6:61` · BR2 `US6:47` · E-13 · Q-13 · Test case: [US6_59] `❓` · (lượt 2: khi làm lại từ màn 11 sẽ gặp popup AC4 Figma `1819:5176` — chỉ Hủy / Đăng nhập, không nhắc mật khẩu vừa đặt) |
| Open questions / quyết định cần Product · BA · UX | BA / BE Chiến: Q-13 (đã gửi) |

### CX-14 — Ô OTP màn 12 nhận dán chuỗi 6 số

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-14 |
| Review scope | Màn 12 — nhập mã |
| Source evidence | wireframe màn 12 (`US6:29`): 6 ô rời, "Mã [__] số đã được gửi tới …" · `US6:64` AC6, `US6:66` AC8 · `EPIC:90` màn OTP dùng chung · `US2:38` email mẫu 23 "tiêu đề chứa mã" · tài liệu không nói về dán mã hay tự động điền |
| Persona và context | P1 (web, copy từ tab hộp thư); P2 (Android, copy từ app email) |
| Customer journey / scenario | J1, J2 bước màn 12 |
| Observation | `[CX GIẢ THUYẾT]` OTP qua email không có autofill như SMS trên Android; cách nhanh nhất là copy mã từ email (tiêu đề đã chứa mã) rồi dán. Nếu 6 ô rời không nhận dán, người dùng phải nhớ 6 số và chuyển app hai lần — tăng nguy cơ gõ sai (tốn lượt sai) và rủi ro CX-05 (rời app). Không phải requirement; là đề xuất. |
| Finding type | Improvement Suggestion |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — không có requirement làm căn cứ |
| Impact | Thấp–Trung bình — tiện dụng; gián tiếp giảm lượt sai. Lý do mức: không chặn |
| Evidence và confidence / limitations | **Lượt 2:** ảnh Figma màn 12 vẽ 6 ô rời đã điền "4 6 8 0 1 2" và bàn phím số; dán chuỗi / tự chuyển ô là hành vi FE, design tĩnh không thể hiện → chưa kiểm được. Độ tin cậy thấp |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-14 (thuộc US2, màn dùng chung): ô OTP nhận dán cả chuỗi và tự chuyển ô; trùng CP-08 của US4. QA: ĐO & GHI dán mã trên web và Android |
| Traceability | AC6 `US6:64` · AC8 `US6:66` · E-14 · Test case: [US6_20] (màn 12), [US6_26]; dán mã — `06` ghi thêm nhóm B · Figma `1641:50362` |
| Open questions / quyết định cần Product · BA · UX | FE Hoàng / UX (US2) |

### CX-15 — Màn 14 báo "đã được tạo với số điện thoại +84 912 345 678" khi người dùng vừa đăng ký bằng email

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-15 |
| Review scope | Màn 14 "Đăng ký thành công" — Figma `1641:50321` (lượt 2) |
| Source evidence | Ảnh `figma/US6_1641-50321_thanh-cong.png`: tick xanh; "Đăng ký thành công"; **"Tài khoản của bạn đã được tạo với số điện thoại +84 912 345 678."**; khung "Tên hiển thị: nguyenvana@congty.vn / bạn có thể đổi trong: Tài khoản → Thông tin tài khoản"; nút "Bắt đầu sử dụng" · lớp text `figma/lop-text-figma-2026-10-16.txt` frame `1641:50321` (cùng câu) · wireframe màn 14 (`US6:29`): "Tài khoản của bạn đã được tạo với email nguyenvana@congty.vn." · `US6:48` BR3 "Không nhập họ tên, SĐT" · `US6:50` BR5 "Tài khoản email mới **chưa có SĐT**" · `US6:69` AC10 · `01` §6d dòng màn 14 · 02 mục 3 **Q-19** (không trọng yếu, mở: lỗi copy của design hay hành vi thật) |
| Persona và context | P1 (mới, Web); P4 (ngoài VN — không có SĐT VN, không thể có số "+84" nào); P2 |
| Customer journey / scenario | J1 bước màn 14 — thời điểm người dùng xác nhận "mình đã có tài khoản đúng chưa" |
| Observation | `[NGUỒN]` Figma: dòng đầu màn 14 nêu một số điện thoại trong khi luồng email không hỏi SĐT (BR3) và tài khoản chưa có SĐT (BR5); ngay dưới lại ghi tên hiển thị là email → hai dòng trên cùng một màn nói hai định danh khác nhau. Wireframe cùng màn ghi "với email …". `[CX GIẢ THUYẾT]` Người dùng vừa gõ email, chưa từng nhập số, thấy "+84 912 345 678" → có thể hiểu: tài khoản bị gắn nhầm số của ai đó / mình vừa đăng ký vào tài khoản người khác / app lỗi; với P4 (không có SĐT VN) càng không giải thích được. Đây là bước "thành công" — nơi người dùng cần chắc chắn nhất; nghi ngờ ở đây dễ dẫn tới liên hệ hỗ trợ hoặc thử đăng ký lại (rơi vào AC4). CX **không kết luận** đây là hành vi sản phẩm: có thể là lỗi copy từ màn 05d của US1 (Q-19). |
| Finding type | CX Risk — rủi ro giả định (chỉ từ design; nếu build hiện đúng như design thì là **nghi vi phạm BR3/BR5** → QA xác minh, không phải CX kết luận Defect) |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — Figma là design, không phải quan sát; AC10 chỉ quy định "tên hiển thị = email đăng ký + gợi ý đổi tên", không quy định dòng định danh tài khoản → không có vế expected nguyên văn cho dòng này |
| Impact | **Cao** nếu lên build như design (ảnh hưởng 100% người đi hết luồng, mất niềm tin đúng lúc thành công, có thể nghi bảo mật); **Thấp** nếu chỉ là lỗi copy được sửa trước khi làm. Lý do mức: tần suất tối đa, hậu quả là niềm tin chứ không mất dữ liệu |
| Evidence và confidence / limitations | Ảnh Figma rõ, lớp text trùng khớp → tin cậy cao về nội dung design. Không biết FE sẽ render chuỗi nào (email thật của tài khoản hay chuỗi cứng); không có frame màn 14 nào khác trong mục US6 để so |
| Recommendation | Không đề xuất câu chữ — là câu hỏi cách hiểu đang mở (Q-19, Design Hiếu / BA Chình). QA: [US6_40], [US6_46], [US6_47] bước màn 14 **ĐO & GHI dòng đầu**; nếu build hiện SĐT trong luồng email → ghi nhận lệch BR3/BR5 và báo (QA xác minh, có bằng chứng thực tế mới thành Defect) |
| Traceability | BR3 `US6:48` · BR5 `US6:50` · AC10 `US6:69` · Q-19 · Test case: [US6_40] [US6_46] [US6_47] · Figma `1641:50321` |
| Open questions / quyết định cần Product · BA · UX | Q-19 (đã có ở 02): lỗi copy hay hành vi thật — Design Hiếu, BA Chình |

### CX-16 — Màn 12 trên luồng email ghi link "Đổi số"

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-16 |
| Review scope | Màn 12 — link sửa email, Figma `1641:50362` (lượt 2) |
| Source evidence | Ảnh `figma/US6_1641-50362_otp.png`: "Mã số đã được gửi tới ng•• ••• @congty.vn" và link góc phải **"Đổi số"** · lớp text frame `1641:50362` (`<Button - Link Brand>`); frame `1641:50334` (không ảnh) cũng có một `<Button - Link Brand>`, chữ chưa đọc · US4 frame `1774:7086` cùng câu "Mã số đã được gửi tới ng•• ••• @congty.vn" (màn OTP dùng chung, `EPIC:90`) · `US6:64` AC6 "nút Đổi email" · 02 mục 4 #11 ("nút Đổi email") · Q-09 (đã bổ sung ý Figma ở 02) |
| Persona và context | P1, P2 — người gõ nhầm một ký tự email ở màn 11 và nhận ra ở màn 12 |
| Customer journey / scenario | J1 / J4b bước màn 12 — muốn sửa email |
| Observation | `[NGUỒN]` Figma: màn OTP dùng chung giữ nhãn "Đổi số" của luồng Zalo dù dòng trên cho biết mã gửi tới một địa chỉ email. `[CX GIẢ THUYẾT]` Người dùng tìm "Đổi email" (như AC6 mô tả) chỉ thấy "Đổi số" → không chắc link này sửa email, chuyển sang đăng ký bằng SĐT, hay "đổi mã số"; có thể dùng "Quay lại" thay thế → làm CX-09 (hai lối không rõ) nặng thêm, hoặc gõ tiếp mã cho email sai rồi chờ vô ích. Frame `1641:50334` có thể là trạng thái khác của link — không suy đoán. |
| Finding type | Usability Issue |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — Figma là design; AC6 có chữ "nút Đổi email" → **nghi lệch câu chữ**, chuyển QA xác minh trên build, không điền vế observed |
| Impact | Thấp–Trung bình — không chặn (còn "Quay lại"), gây lưỡng lự ở bước có tần suất gõ nhầm email cao. Lý do mức: phục hồi được tại chỗ |
| Evidence và confidence / limitations | Ảnh Figma rõ; không biết FE có đổi nhãn theo kênh gửi hay dùng chung chuỗi. Tin cậy cao về design |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-15 (US2 — màn dùng chung): nhãn link theo kênh gửi ("Đổi email" khi mã gửi qua email) — UX Hiếu chốt. QA: [US6_20] ĐO & GHI nhãn link trên build; [US6_62] đích đến của link |
| Traceability | AC6 `US6:64` · E-15 · Q-09 · Test case: [US6_20] [US6_42] [US6_62] · Figma `1641:50362`, `1641:50334` · CX-09 |
| Open questions / quyết định cần Product · BA · UX | Q-09 bổ sung (đã ghi ở 02): nhãn "Đổi số" là lỗi copy hay dùng chung chủ ý — Design Hiếu / BA Chình |

### CX-17 — Màn 12 Figma không có gợi ý kiểm tra Spam dù AC6 yêu cầu và rủi ro Epic #8 còn mở

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-17 |
| Review scope | Màn 12 — trạng thái chờ mã, Figma `1641:50362` / `1641:50334` (lượt 2) |
| Source evidence | Ảnh `figma/US6_1641-50362_otp.png`: dưới 6 ô chỉ có "Chưa nhận được mã?" + đồng hồ "45s", nút "Xác thực", bàn phím số — **không có** khung gợi ý Spam · lớp text hai frame màn 12 không có chữ "Spam" / "Quảng cáo" (giới hạn: chữ trong instance không bóc được) · wireframe màn 12 (`US6:29`): khung "Không thấy email? Kiểm tra hộp thư Spam hoặc Quảng cáo." · `US6:64` AC6 "gợi ý kiểm tra Spam" · 02 mục 4 #11 · `US6:75` + `EPIC:151` câu hỏi #8 mở "ít vào Spam không?" · `EPIC:184` rủi ro "Email OTP vào Spam / đến chậm → Gợi ý kiểm tra Spam; cho gửi lại mã" · Q-09 (đã bổ sung ý Figma ở 02) |
| Persona và context | P5 (email vào Spam — persona giả thuyết); P2 (hộp thư công ty lọc gắt — giả thuyết) |
| Customer journey / scenario | J4b |
| Observation | `[NGUỒN]` Figma: không có gợi ý Spam trên frame màn 12 có ảnh; lớp text của frame còn lại cũng không có. `[CX GIẢ THUYẾT]` Khi email nằm trong Spam, màn 12 chỉ còn một đường: chờ đồng hồ rồi gửi lại — mỗi lần gửi lại email vẫn vào Spam, mã cũ vô hiệu (CX-02), lượt gửi tăng tới giới hạn US2, rồi bỏ dở; người dùng không được nhắc nhìn vào Spam — biện pháp đỡ duy nhất mà Epic ghi ở `EPIC:184`. Đây là **nghi lệch requirement từ design** (AC6 có yêu cầu), không phải Defect; QA kiểm trên build. Nếu Design bỏ chủ ý thì cần BA sửa AC6 — không phải CX quyết. |
| Finding type | CX Risk — rủi ro giả định |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — Figma là design; AC6 có yêu cầu "gợi ý kiểm tra Spam" → chuyển QA xác minh, không điền vế observed |
| Impact | Cao — cùng chuỗi với CX-02 (mục tiêu chính của story, rủi ro Epic tự nêu còn mở); bỏ dở ở bước 2 với nhóm hộp thư lọc gắt. Lý do mức: tần suất phụ thuộc dịch vụ gửi (chưa đo), hậu quả là thất bại hành trình |
| Evidence và confidence / limitations | Ảnh một frame + lớp text hai frame; nếu gợi ý Spam nằm trong một instance (vd tooltip) thì không thấy được — ghi giới hạn. Tin cậy trung bình–cao về design, giả thuyết về phản ứng người dùng |
| Recommendation | Không cần CP riêng — AC6 đã yêu cầu. QA: [US6_20] giữ bước kiểm "gợi ý Spam" theo AC6 (ĐO & GHI trên build); [US6_68] đo tỷ lệ vào Spam. Debate: Q-09 bổ sung (đã ghi) — Design Hiếu xác nhận thiếu hay bỏ chủ ý; nếu bỏ chủ ý → BA Chình quyết AC6 |
| Traceability | AC6 `US6:64` · E-15 · Epic #8 `EPIC:151` · `EPIC:184` · Q-09 · Test case: [US6_20] [US6_68] · Figma `1641:50362`, `1641:50334` · CX-02 |
| Open questions / quyết định cần Product · BA · UX | Design Hiếu / BA Chình: Q-09 phần Spam (đã ghi ở 02) |

### CX-18 — Màn 12 khi đang đếm: "Chưa nhận được mã?" + "45s", không có nút hay động từ — người dùng không biết làm gì tiếp

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-18 |
| Review scope | Màn 12 — khu vực gửi lại mã trong lúc đếm ngược, Figma `1641:50362` (lượt 2) |
| Source evidence | Ảnh `figma/US6_1641-50362_otp.png`: dòng "Chưa nhận được mã?" bên trái, biểu tượng đồng hồ + "45s" bên phải; không có nút "Gửi lại" · lớp text: "Chưa nhận được mã?", "45s" (không có chữ "Gửi lại") · wireframe màn 12: "Chưa nhận được mã? Gửi lại mã sau 00:45" · 02 mục 4 #11 "nút Gửi lại mờ đếm ngược 60 s" · `US2:46` BR3 chờ 60 s · `US2:59` · `01` §6d: "sau 0 s hiện gì chưa thấy (mục US2 frame `1754:5797` chưa đọc)" · Q-09 (đã bổ sung ý Figma ở 02) |
| Persona và context | P1, P2, P5 — đang chờ email chưa tới |
| Customer journey / scenario | J1 / J4b bước màn 12, giây thứ 1–60 |
| Observation | `[NGUỒN]` Figma: câu hỏi "Chưa nhận được mã?" không đi kèm câu trả lời hay hành động; đồng hồ "45s" không nói đếm tới việc gì. `[CX GIẢ THUYẾT]` Người dùng không biết: hết giờ hệ thống tự gửi lại? sẽ hiện nút? hay mã sẽ hết hạn (nhầm với 5 phút hiệu lực)? → có thể bấm "Quay lại" / "Đổi số" để tự gửi lại (gặp cooldown, CX-09), hoặc bấm "Xác thực" với ô trống. Trạng thái sau 0 s **không có ảnh** → không kết luận. Con số 45 s trên design so với 60 s của `US2:46`: có thể chỉ là ảnh chụp giữa chừng — **không kết luận**, thuộc Q-09 / US2. |
| Finding type | Usability Issue |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — Figma là design; 02 mục 4 #11 mô tả "nút Gửi lại mờ đếm ngược" là cách hiểu từ US2, chưa phải quan sát → chuyển QA |
| Impact | Trung bình — bước có nguy cơ bỏ dở cao nhất (chờ email); gặp ở mọi người dùng mà email tới chậm hơn vài chục giây. Lý do mức: không mất dữ liệu, nhưng là điểm "không biết làm gì" lặp lại |
| Evidence và confidence / limitations | Ảnh một frame trong lúc đếm; không có frame sau 0 s; màn dùng chung US2 (frame `1754:5797` "yêu cầu gửi lại khi hết thời gian chờ" chưa đọc). Tin cậy cao về trạng thái đang đếm, không biết trạng thái kế |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-16 (US2 — màn dùng chung): câu đủ nghĩa trong lúc đếm ("Gửi lại mã sau 45s") hoặc nút "Gửi lại mã" mờ kèm đếm ngược; sau 0 s nút bật — UX Hiếu chốt. QA: [US6_20] ĐO & GHI trạng thái khu vực này trong lúc đếm; [US6_24] ĐO & GHI sau 0 s hiện gì và con số đếm ngược thật |
| Traceability | AC6 `US6:64` · AC7 `US6:65` · US2 BR3 `US2:46` · E-10 · 02 mục 4 #11 · Q-09 · Test case: [US6_20] [US6_24] · Figma `1641:50362` |
| Open questions / quyết định cần Product · BA · UX | Q-09 bổ sung (đã ghi): sau 0 s hiện gì; 45 s hay 60 s — Design Hiếu / US2 |

### CX-19 — Hai nhánh chặn ở màn 11 (Q-18, closedScope): người bị chặn không có đường thoát nào ghi nhận được

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-19 |
| Review scope | Màn 11 — frame `1819:5296` "Thiết bị đã vượt giới hạn số lượng email được phép sử dụng", `1819:5430` "Email thuộc danh sách chặn" (lượt 2; **closedScope**) |
| Source evidence | Lớp text `figma/lop-text-figma-2026-10-16.txt`: hai frame có tên như trên; phần tử giống hệt màn 11 trống (tab, ô, nút, Google, Điều khoản, "Đã có tài khoản? Đăng nhập"); **không có lớp text nào thêm** → chữ lỗi nằm trong instance ô nhập, chưa đọc; **không có ảnh** · danh sách frame mục US6 không có frame nào sau hai frame này · `US6:46-50` BR1–BR5, `US6:57-71` AC1–AC11, Epic §6: không có quy tắc về giới hạn theo thiết bị hay danh sách chặn · `EPIC:157` câu hỏi #14, `US2:78` (giới hạn theo thiết bị/IP — chưa chốt) · 02 mục 3 **Q-18 trọng yếu, cổng đóng cho nhánh này** · `01` §6d dòng "hai trạng thái lỗi không có trong US6" (US1 trên Figma có cặp tương ứng cho SĐT) |
| Persona và context | P8 (thiết bị dùng chung / email bị chặn — persona giả thuyết phục vụ review); P1 |
| Customer journey / scenario | J10 |
| Observation | `[NGUỒN]` Tên frame cho biết design có hai trạng thái chặn ngay bước 1; không có frame kế tiếp và tài liệu không có quy tắc → **không ghi nhận được** đường phục hồi (dùng email khác? chờ bao lâu? liên hệ ai? khiếu nại thế nào?). `[CX GIẢ THUYẾT]` — chỉ là rủi ro, **không phải expected**: (1) người hợp lệ trên thiết bị dùng chung (gia đình, máy cửa hàng, máy công ty) có thể bị chặn dù chưa từng đăng ký; (2) người có email bị đưa nhầm vào danh sách chặn không có cách phản hồi; (3) cả hai nhóm đều chưa có tài khoản nên "Đã có tài khoản? Đăng nhập" và "Tiếp tục với Google" không phải lối ra. Nếu thông báo (chưa đọc được) không nêu lý do và bước kế → bỏ dở ngay bước 1 với nhóm chưa có gì để mất. Mâu thuẫn design ↔ tài liệu là việc của Debate (Q-18), không phải Defect. |
| Finding type | CX Risk — rủi ro giả định |
| Steps to reproduce | N/A — chưa có sản phẩm; nhánh chưa có trong tài liệu |
| Expected vs observed | N/A — không có requirement; closedScope → không điền |
| Impact | **Chưa đánh giá được mức** (không biết ngưỡng email/thiết bị, cách nhận diện "thiết bị" trên web, quy mô danh sách chặn). Nếu là hành vi thật: thất bại hành trình không phục hồi với nhóm bị ảnh hưởng |
| Evidence và confidence / limitations | Chỉ tên frame + lớp text; không ảnh; không có câu BA. Tin cậy cao rằng design có hai nhánh này, không có thông tin về nội dung hay hành vi |
| Recommendation | **Không đề xuất** (closedScope). Ghi để BA / Design cân nhắc khi trả lời Q-18: nội dung thông báo có nêu lý do và đường thoát không. QA: không viết case tới khi Q-18 chốt (placeholder `❓` theo 02) |
| Traceability | Unlinked với BR/AC US6 (không có quy tắc) · Q-18 · `EPIC:157` #14 · Test case: placeholder `❓` theo closedScope · Figma `1819:5296`, `1819:5430` (lớp text) |
| Open questions / quyết định cần Product · BA · UX | Q-18 (đã có ở 02) — BA Chình · PdM Hường · BE Chiến · Design Hiếu |

### CX-20 — Email OTP mẫu: chân thư còn placeholder "[email hỗ trợ] · [hotline]"; tiêu đề thư không có trên design

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-20 |
| Review scope | Email OTP đăng ký — Figma `1859:3924` (lượt 2) |
| Source evidence | Ảnh `figma/EMAIL_1859-3924_otp-dangky.png`: logo; "Nhập mã xác thực đăng ký"; "Xin chào huongmt@gopany.com,"; "Bạn đang đăng ký tài khoản Gopany bằng email này. Nhập mã dưới đây vào màn hình đăng ký để tiếp tục."; "MÃ XÁC THỰC CỦA BẠN" 6 số; "Mã có hiệu lực trong **5 phút** và chỉ dùng được một lần."; khung vàng "Không chia sẻ mã này với bất kỳ ai… Gopany không bao giờ hỏi mã xác thực của bạn."; "Nếu bạn không đăng ký tài khoản Gopany, hãy bỏ qua email này. Sẽ không có tài khoản nào được tạo."; chân: "Đây là email tự động, vui lòng không trả lời. Cần hỗ trợ? Liên hệ **[email hỗ trợ] · [hotline]** © 2026 Gopany" · lớp text: cùng placeholder ở cả `1872:4430` (đặt lại mật khẩu) và `1872:4483` (thêm email US5) · `US2:38` mẫu 23 "tên Gopany, mã, thời hạn, lời nhắc không chia sẻ, không nút/liên kết, **tiêu đề chứa mã**" · 02 mục 4 #11 · `US6:64` AC6 |
| Persona và context | P5 (mã không tới / nghi email lừa đảo, cần kênh hỗ trợ — persona giả thuyết); P1 |
| Customer journey / scenario | J1 / J4b bước mở hộp thư |
| Observation | `[NGUỒN]` Figma: nội dung email khớp mẫu 23 về cấu trúc (tên Gopany, mã 6 số, thời hạn, lời nhắc, không nút / liên kết); câu "Sẽ không có tài khoản nào được tạo" là điểm tốt cho người nhận nhầm. Hai điểm chưa xong: (1) chân thư còn hai placeholder trong ngoặc vuông, dùng chung cho cả ba email mẫu; (2) tiêu đề (subject) không có trên design dù mẫu 23 yêu cầu "tiêu đề chứa mã" — không rõ ai cầm. `[CX GIẢ THUYẾT]` Nếu lên môi trường thật với placeholder: email trông chưa hoàn thiện hoặc giống lừa đảo — đúng lúc email đang nhắc "Gopany không bao giờ hỏi mã" → mất niềm tin; người cần hỗ trợ (mã không tới, nghi ngờ) không có kênh. Đây là rủi ro "quên điền", không phải lỗi hiện tại. |
| Finding type | CX Risk — rủi ro giả định |
| Steps to reproduce | N/A — chưa có sản phẩm / email thật để tái hiện |
| Expected vs observed | N/A — design, chưa có email thật; mẫu 23 không quy định chân thư |
| Impact | Trung bình — nếu lọt lên môi trường thật ảnh hưởng mọi email OTP (đăng ký, đặt lại mật khẩu, thêm email) vì dùng chung chân thư. Lý do mức: dễ sửa trước khi làm, hậu quả là niềm tin |
| Evidence và confidence / limitations | Ảnh Figma rõ; lớp text ba email trùng khớp. Không biết BE dựng email từ design hay từ mẫu riêng; tiêu đề thật chưa thấy. Tin cậy cao về design |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-17: Design / BE thay placeholder bằng kênh hỗ trợ thật trước khi dựng mẫu; design ghi cả tiêu đề mẫu. QA: [US6_21] thêm bước kiểm chân thư không còn "[…]" và tiêu đề chứa mã (mẫu 23); áp cả email US4 / US5 dùng chung mẫu |
| Traceability | AC6 `US6:64` · E-16 · `US2:38` · 02 mục 4 #11 · Test case: [US6_21] · Figma `1859:3924` (US4 `1872:4430`, US5 `1872:4483`) |
| Open questions / quyết định cần Product · BA · UX | BE Chiến / Design Hiếu: kênh hỗ trợ thật; ai cầm tiêu đề email |

### CX-21 — Thanh tiến trình 3 vạch không có chữ "Bước x/3"

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-21 |
| Review scope | Màn 11, 12 (và 13 theo lớp text) — thanh tiến trình, Figma `1641:50276`, `1641:50362` (lượt 2) |
| Source evidence | Ảnh `figma/US6_1641-50276_nhap-email.png`: 3 vạch ngang dưới nút Quay lại, vạch 1 xanh, 2 vạch xám; ảnh `figma/US6_1641-50362_otp.png`: 2 vạch xanh; không có chữ · lớp text 9 frame không có chữ "Bước" · wireframe (`US6:29`): "Bước 1/3", "Bước 2/3", "Bước 3/3" · `01` §6d dòng màn 11 ("**không** có chữ 'Bước 1/3'") · màn 14 Figma không có thanh |
| Persona và context | P1 (mới, chưa biết luồng dài bao nhiêu); P2 (phải rời app lấy mã — cần biết còn mấy bước để quyết định đi tiếp); người khó phân biệt màu hoặc dùng trình đọc màn hình — **bối cảnh giả thuyết phục vụ review**, không có số liệu |
| Customer journey / scenario | J1 / J2 màn 11 → 12 → 13 |
| Observation | `[NGUỒN]` Figma: tiến trình chỉ thể hiện bằng màu vạch; không có nhãn chữ. `[CX GIẢ THUYẾT]` Người dùng không biết đây là bước mấy và còn bao nhiêu bước (đặc biệt ở màn 12 trước khi rời app lấy mã — biết "còn 1 bước" giúp đi tiếp); vạch xanh / xám tương phản thấp trên ảnh nhìn bằng mắt — không kết luận contrast vì không có token màu; trình đọc màn hình không có gì để đọc nếu không có accessibility label — chưa kiểm được (không có build). |
| Finding type | Usability Issue (định hướng + tiếp cận) |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — không có requirement về thanh tiến trình; wireframe chỉ tham khảo |
| Impact | Thấp — không chặn. Lý do mức: chỉ ảnh hưởng cảm giác kiểm soát và tiếp cận |
| Evidence và confidence / limitations | Ảnh hai frame + lớp text; không đo được contrast, không biết label accessibility. Tin cậy cao về việc không có chữ, thấp về tác động |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-18: thêm nhãn "Bước x/3" cạnh thanh (hoặc tối thiểu accessibility label) — UX Hiếu. QA: [US6_01] ĐO & GHI thanh tiến trình; nếu môi trường cho phép, ĐO & GHI với TalkBack (Android) |
| Traceability | AC1 `US6:57` (hiển thị màn 11) · Test case: [US6_01] · Unlinked với BR (không có quy tắc) · Figma `1641:50276`, `1641:50362` |
| Open questions / quyết định cần Product · BA · UX | UX Hiếu |

## 6. Đề xuất cải thiện (luồng riêng — không phải requirement)

Tất cả là `[ĐỀ XUẤT THAY ĐỔI]`; không dùng làm expected result cho tới khi người có thẩm quyền quyết định và tài liệu BA được cập nhật.

| ID | Đề xuất | Lý do | Cần ai quyết định | Trạng thái |
| --- | --- | --- | --- | --- |
| CP-01 | Màn 14: lối phụ "Đổi tên hiển thị" mở thẳng Thông tin tài khoản (giữ BR3 không nhập họ tên ở bước đăng ký) | CX-01 | Product (Hường) + UX | Đề xuất — chưa ai quyết |
| CP-02 | Màn 12 sau Gửi lại: dòng "Chỉ mã trong email mới nhất có hiệu lực"; email mẫu 23 ghi giờ gửi | CX-02 | Product + UX (US2, màn dùng chung) · BE Chiến (mẫu email) | Đề xuất — chưa ai quyết |
| CP-03 | Thông báo AC5 nêu lỗi ở phía hệ thống gửi và hành động cụ thể; nếu thử lại chịu 60 s thì màn 11 hiện đếm ngược | CX-03 | BA Chình (chồng lên Q-02, Q-07) | Đề xuất — chờ Q-02 |
| CP-04 | Nếu có thời hạn sau OTP: màn 13 hiện đếm ngược / dòng "hoàn tất trong N phút"; hết hạn về màn 11 điền sẵn kèm giải thích | CX-04 | BA / BE Chiến (chồng lên Q-03) | Đề xuất — chờ Q-03 |
| CP-05 | Mở lại app khi mã còn hạn: về màn 12 với email cũ, cho nhập mã cũ, không bắt gửi lại | CX-05 | BA / FE Hoàng / BE Chiến (chồng lên Q-04) | Đề xuất — chờ Q-04 |
| CP-06 | Màn 14 ghi rõ "có thể đăng nhập bằng email này từ bây giờ" và bước còn lại (nếu workspace chỉ tạo khi bấm nút) | CX-06 | BA / Product (chồng lên Q-05) | Đề xuất — chờ Q-05 |
| CP-07 | Thông báo AC4 kèm lối "Đăng nhập" và "Quên mật khẩu?" (và nhắc Google nếu từng dùng) | CX-07 | Product (Hường) + BA Chình | Đề xuất — chưa ai quyết |
| CP-08 | (sửa lượt 2) Helper màn 13 nêu đủ **quy định mật khẩu đã chốt** — con số / tiêu chí chờ Q-17, CX không nêu; lỗi không đạt nêu tiêu chí thiếu | CX-08 | UX + BA (Q-07, Q-17) | Đề xuất — chờ Q-17 (cổng đóng cho AC9) |
| CP-09 | Màn 12 một lối về màn 11 (hoặc "Quay lại" điền sẵn email) | CX-09 | UX (US2, màn dùng chung) | Đề xuất — chờ Q-09 |
| CP-10 | Màn 14 hoặc lần đầu vào màn 15: một dòng về hạn mức thấp và cách nâng | CX-11 | Product (Hường) — có thể trái `US7:9` | Đề xuất — chưa ai quyết |
| CP-11 | (US7) Link/thẻ nâng hạn mức nói rõ điều kiện SĐT di động VN có Zalo | CX-11 | Product (US7) | Đề xuất — ngoài phạm vi US6 |
| CP-12 | (US1) Ngoài VN: dòng ngắn giải thích vì sao chỉ còn Email | CX-12 | Product / UX (US1) | Đề xuất — ngoài phạm vi US6 |
| CP-13 | Bấm lại Đăng ký khi tài khoản đã tạo: BE idempotent hoặc thông báo "tài khoản đã được tạo, vui lòng đăng nhập" | CX-13 | BA / BE Chiến (chồng lên Q-13) | Đề xuất — chờ Q-13 |
| CP-14 | (US2) Ô OTP nhận dán chuỗi 6 số, tự chuyển ô | CX-14 | FE Hoàng / UX (US2) — trùng US4 CP-08 | Đề xuất — chưa ai quyết |
| CP-15 | **(Lượt 2, US2 màn dùng chung)** Nhãn link ở màn 12 theo kênh gửi: "Đổi email" khi mã gửi qua email | CX-16 | UX Hiếu (US2) | Đề xuất — chồng lên Q-09 |
| CP-16 | **(Lượt 2, US2 màn dùng chung)** Trong lúc đếm: câu đủ nghĩa "Gửi lại mã sau Ns" hoặc nút "Gửi lại mã" mờ kèm đếm ngược; sau 0 s nút bật | CX-18 | UX Hiếu (US2) | Đề xuất — chồng lên Q-09 |
| CP-17 | **(Lượt 2)** Email OTP mẫu: thay "[email hỗ trợ] · [hotline]" bằng kênh thật trước khi dựng; design ghi tiêu đề mẫu (mẫu 23 "tiêu đề chứa mã") | CX-20 | BE Chiến + Design Hiếu | Đề xuất — chưa ai quyết |
| CP-18 | **(Lượt 2)** Thanh tiến trình kèm nhãn "Bước x/3" (hoặc accessibility label) | CX-21 | UX Hiếu | Đề xuất — chưa ai quyết |

Không có CP cho CX-15 (màn 14 ghi SĐT — là câu hỏi Q-19, Design/BA trả lời), CX-17 (AC6 đã yêu cầu gợi ý Spam — chuyển QA / Q-09)
và CX-19 (closedScope Q-18 — không đề xuất).

## 7. Chuyển cho QA / quay lại Debate

| # | Nội dung | Chuyển đi đâu (QA xác minh / Debate — câu hỏi về cách hiểu tài liệu) | Nguồn |
| ---: | --- | --- | --- |
| 1 | AC4 "gợi ý Đăng nhập": là link về màn 01 đơn thuần hay có phân nhánh cho tài khoản Google (không mật khẩu) / form cũ (Quên mật khẩu)? Tài liệu không nói; ảnh hưởng expected đích đến sau AC4 | **Debate** — câu hỏi cách hiểu mới (đề xuất ghép vào Q-07 hoặc mở Q-16); CX không chọn | `US6:61`; `US9:46`, `US9:50`, `US9:69`; `US3:56`; CX-07 |
| 2 | Q-01 email được mời: bổ sung tác động CX cho cả hai nhánh (chặn → không có mật khẩu để đăng nhập; cho đăng ký → có thể vào workspace mới thay vì workspace đã mời) để BA chốt kèm đích đến sau màn 14 | **Debate** — bổ sung vào Q-01 đang mở | `US6:46`, `US6:61`, `US6:69`; `EPIC:136`; 02 mục 4 #15; CX-10 |
| 3 | Q-02 AC5: bổ sung "màn 11 có đếm ngược không nếu thử lại chịu 60 s"; timeout mà mail đã đi thì bấm lại hiện gì ở màn 11 | **Debate** — bổ sung vào Q-02 đang mở | `US6:62`; 02 mục 4 #17, #18; CX-03 |
| 4 | Q-03 thời hạn sau OTP: bổ sung "nếu có thời hạn, màn 13 hiện gì, hết hạn về màn nào (13 không có Quay lại)" | **Debate** — bổ sung vào Q-03 / Q-10 đang mở | `US6:66`; wireframe màn 13; `US4:53-54`; CX-04 |
| 5 | Q-04: bổ sung "mở lại app trong lúc mã còn hạn có được nhập mã cũ không hay bắt gửi lại (chịu 60 s, cộng lượt)" | **Debate** — bổ sung vào Q-04 đang mở | `US6:71`; `US2:45-47`, `US2:70`; CX-05 |
| 6 | Q-05: bổ sung "đăng nhập lại sau khi bỏ qua màn 14 → đích đến (ChatGoni / màn tạo workspace)"; hai ý của Hồng ở 02 mục 4 #19 chưa khớp | **Debate** — bổ sung vào Q-05 đang mở | `US6:69`; `US1:68`; `US3:55`; CX-06 |
| 7 | Q-09: bổ sung "'Quay lại' ở màn 12 có hủy mã đã gửi không; gửi lại cho cùng email ở màn 11 có chịu 60 s" | **Debate** — bổ sung vào Q-09 đang mở | wireframe màn 12; `US2:45-46`; CX-09 |
| 8 | Gửi lại mã rồi nhập mã của email đầu (đến muộn) → theo `US2:64` "mã không đúng"; có tính lượt sai không (`US2:77` mở) | **QA xác minh** — đề xuất case nhóm AC7 (dẫn US2), kẹp Q-11; ĐO & GHI thời gian email tới / vào Spam trên vài nhà cung cấp hộp thư (Epic #8) | `US2:45`, `US2:64`, `US2:77`; `EPIC:151`; CX-02 |
| 9 | AC4 với email của tài khoản Google → bấm gợi ý → đích đến; sau đó đăng nhập Google vào đúng tài khoản (`US9:63`) | **QA xác minh** — đề xuất case AC4 theo loại tài khoản (form cũ, Google, email thêm ở US5) | `US6:61`; `US9:63`; CX-07 |
| 10 | Tên = email hiện ở những đâu ngay sau đăng ký (màn 14, menu Tài khoản, ChatGoni, workspace); chuỗi giữ hoa/thường như gõ (Q-08) | **QA xác minh** — ĐO & GHI, nối 02 mục 4 #3 | `US6:48`, `US6:69`; `US5:66-67`; CX-01 |
| 11 | Helper / câu lỗi / trạng thái nút Đăng ký ở màn 13; mật khẩu 17–20 ký tự từ trình quản lý mật khẩu | **QA xác minh** — ĐO & GHI, đã kẹp Q-07/Q-10 ở 02 mục 4 #13 | wireframe màn 13; E-09; CX-08 |
| 12 | Mô phỏng OS tắt app ở màn 12 khi mã còn hạn; dán mã vào 6 ô (web, Android); mở hộp thư ở tab khác rồi quay lại | **QA xác minh** — đề xuất case nhóm AC11 / AC6, ĐO & GHI | `US6:71`; 02 mục 4 #20; CX-05, CX-14 |
| 13 | AC5 ba trạng thái: lỗi đồng bộ từ dịch vụ gửi, timeout mail đã đi, timeout mail chưa đi → thông báo, trạng thái nút, hộp thư | **QA xác minh** — mở rộng case AC5/AC11 ở 02 mục 4 #17, #18 (`❓ Cần chốt`) | `US6:62`, `US6:71`; CX-03 |
| 14 | Sau màn 14 vào ChatGoni: dấu hiệu hạn mức thấp theo 02 mục 4 #6; phần "tài khoản không có SĐT VN không nâng được" chuyển US7 | **QA xác minh** (US6 phần dấu hiệu) · **chuyển US7** (phần nâng hạn mức ngoài VN) | `US6:50`; `US7:63`, `US7:68`; `EPIC:183`; CX-11 |
| 15 | Response rớt sau khi BE đã tạo tài khoản: bấm lại Đăng ký ở màn 13 → BE trả gì; làm lại từ màn 11 → AC4; mật khẩu vừa đặt có hiệu lực | **QA xác minh** — case `❓` theo Q-13 | `US6:71`, `US6:61`; CX-13 |
| 16 | Màn 11 ngoài VN: cách ẩn tab, có lời giải thích không; link Điều khoản / Chính sách mở ở đâu (app vs web) | **QA xác minh** — ĐO & GHI theo Q-14 (US1 AC2); [US6_44] [US6_71] | wireframe màn 11; `US1:57`; CX-12 |
| 17 | **(Lượt 2)** Màn 14 Figma ghi "tạo với số điện thoại +84 912 345 678" trong luồng email: bổ sung tác động CX (nghi nhầm tài khoản / lo bảo mật đúng bước thành công; P4 không có SĐT VN) để Design/BA trả lời Q-19 | **Debate** — bổ sung vào Q-19 đang mở; CX không chọn | Figma `1641:50321`; `US6:48`, `US6:50`; CX-15 |
| 18 | **(Lượt 2)** Màn 12 Figma: link "Đổi số" trên luồng email; không có gợi ý Spam (AC6); khi đang đếm chỉ "Chưa nhận được mã?" + "45s", không nút; sau 0 s hiện gì; 45 s hay 60 s (`US2:46`) | **Debate** — bổ sung vào Q-09 đang mở (02 đã ghi ý Figma; CX thêm tác động); phần Spam: nếu Design bỏ chủ ý thì BA quyết AC6 | Figma `1641:50362`, `1641:50334`; `US6:64`; 02 mục 4 #11; CX-16, CX-17, CX-18 |
| 19 | **(Lượt 2)** Popup AC4 Figma chỉ "Hủy" / "Đăng nhập", không phân biệt loại tài khoản, không có Quên mật khẩu / Google; "Hủy" về đâu, email còn trong ô không; "Đăng nhập" có điền sẵn email sang màn 01 không | **Debate** — bổ sung vào Q-16 đang mở | Figma `1819:5176`, `1819:5278`; `US9:50`; CX-07, CX-10 |
| 20 | **(Lượt 2 — closedScope)** Hai frame chặn ở màn 11 (Q-18): người bị chặn không có đường thoát ghi nhận được — chỉ ghi rủi ro để BA/Design cân nhắc nội dung thông báo và bước kế khi trả lời; **không expected** | **Debate** — Q-18 (trọng yếu, đã có) | Figma `1819:5296`, `1819:5430` (lớp text); `EPIC:157`; CX-19 |
| 21 | **(Lượt 2 — closedScope)** Màn 13: frame không ảnh, helper mật khẩu chưa đọc được; CX-08 giữ nguyên bản chất, không nêu con số; lớp text có nút Quay lại (về đâu?) | **Debate** — Q-17 (trọng yếu, đã có) · Q-10 (đã bổ sung ở 02) | Figma `1641:50302` (lớp text); CX-08, CX-04 |
| 22 | **(Lượt 2)** Màn 12 trên build đối chiếu AC6: có gợi ý Spam không; nhãn link ("Đổi email" / "Đổi số"); khu vực gửi lại trong lúc đếm và sau 0 s; con số đếm ngược thật | **QA xác minh** — [US6_20] giữ bước kiểm theo AC6 (ĐO & GHI, nghi lệch chỉ từ design); [US6_24] sau 0 s; [US6_68] tỷ lệ Spam | Figma `1641:50362`; `US6:64`; CX-16, CX-17, CX-18 |
| 23 | **(Lượt 2)** Màn 14 trên build: dòng đầu ghi email hay SĐT; nếu hiện SĐT trong luồng email → ghi nhận lệch BR3/BR5 và báo (QA có bằng chứng thực tế mới xét Defect) | **QA xác minh** — [US6_40] [US6_46] [US6_47] bước màn 14 ĐO & GHI | Figma `1641:50321`; `US6:48`, `US6:50`; Q-19; CX-15 |
| 24 | **(Lượt 2)** Email OTP thật: chân thư không còn "[email hỗ trợ] · [hotline]"; tiêu đề chứa mã (mẫu 23); áp cả email US4 / US5 dùng chung mẫu | **QA xác minh** — [US6_21] thêm bước kiểm | Figma `1859:3924`; `US2:38`; CX-20 |
| 25 | **(Lượt 2)** Popup AC4 trên build: bấm "Hủy" về đâu, email còn trong ô không; "Đăng nhập" về màn 01 có điền sẵn email; với tài khoản Google sau đó đăng nhập Google vào đúng tài khoản | **QA xác minh** — [US6_10] [US6_11] [US6_12] [US6_72] | Figma `1819:5176`; `US9:63`; CX-07 |
| 26 | **(Lượt 2)** Thanh tiến trình trên build: có chữ "Bước x/3" không, TalkBack đọc gì; nút "Gửi mã xác thực" mờ khi ô trống như design | **QA xác minh** — [US6_01] ĐO & GHI; [US6_78] (nút mờ khi ô trống — khớp design `1641:50276`) | Figma `1641:50276`, `1641:50362`; CX-21 |

## 8. Tự rà soát

- [x] Mỗi finding có loại, persona, bằng chứng nguồn, mức bằng chứng, giới hạn
- [x] Không Defect nào thiếu bằng chứng thực tế (không có Defect ở lượt này)
- [x] Không câu nào nói đã thao tác / đã thấy khi chỉ phân tích tài liệu — mọi nhận định gắn `[CX GIẢ THUYẾT]`
- [x] Persona giả thuyết đã đánh dấu (P3, P5 giả thuyết; P1, P2, P4 có căn cứ nền tảng, bối cảnh cá nhân giả thuyết; P6, P7 có căn cứ)
- [x] Đề xuất cải thiện tách ở mục 6, nhãn `[ĐỀ XUẤT THAY ĐỔI]`, không lẫn vào requirement
- [x] Không sửa requirement / BR / AC; không chọn cách hiểu cho Q-01→Q-14; không ghi "Expected vs observed" khi thiếu căn cứ
- [x] Mọi `[NGUỒN]`/tham chiếu `tệp:dòng` trích từ file đã đọc (US6 bản `06`, Epic, US1, US2, US3, US5, US7, US9, BUG10, file 01, 02)
- [x] Số đếm (lượt 2): 21 finding (0 Defect / 8 Usability / 12 CX Risk / 1 Improvement; 14 cũ giữ ID, 7 mới, 0 đóng), 8 persona, 10 hành trình, 18 CP, 26 mục chuyển (12 Debate, 14 QA) — đếm lại từ nội dung
- [x] Lượt 2: mọi nhận định từ Figma ghi rõ frame / ảnh; bốn frame không ảnh (13, 12 bản hai, hai frame Q-18) không suy đoán nội dung; kết luận "không có chữ X" ghi giới hạn lớp text
- [x] Lượt 2: closedScope (AC9 — Q-17; nhánh chặn màn 11 — Q-18) không có expected, không có con số, không có CP; CX-15/16/17 nghi lệch requirement chỉ từ design → chuyển QA, không Defect
- [x] Lượt 2: không câu nào nói "Figma không có" còn sót — mục 1 dòng 3, giới hạn, CX-01/02/05/07/08/09/11/12/14 đã sửa theo tình trạng mới

## Lịch sử cập nhật

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
| 2026-10-16 | AI (CX Reviewer) — người dùng Hồng | Tạo file S7: Mode 1 + Mode 3 từ US6 bản `06`, user flow, wireframe 11–14, wireframe US3/US5/US7 cho hành trình end-to-end, 02 (gate open 2026-10-16); 14 finding (0 Defect · 5 Usability · 8 CX Risk · 1 Improvement), 14 CP, 7 điểm quay lại Debate (AC4 gợi ý Đăng nhập — mới; bổ sung Q-01, Q-02, Q-03, Q-04, Q-05, Q-09), 9 mục chuyển QA |
| 2026-10-16 | AI (CX Reviewer, lượt 2) — người dùng Hồng gửi Figma giao diện thật | Cập nhật theo Figma (ảnh 5/9 frame US6 + email mẫu; `01` §6d; 02 `closedScope` Q-17/Q-18): sửa frontmatter, mode / mức bằng chứng, mục 1 (+5 nguồn, giới hạn mới), persona P8, hành trình J10 + đoạn đối chiếu Figma; rà 14 finding cũ — cập nhật Evidence / Trace sang `[US6_nn]` + Figma, **đóng 0**; thêm CX-15→CX-21 (3 Usability · 4 CX Risk; 0 Defect), CP-15→CP-18, CP-08 sửa theo Q-17; mục 7 thêm #17–#26 (5 Debate: Q-19, Q-09, Q-16, Q-18, Q-17/Q-10 · 5 QA). Giới hạn: không Mode 2; frame 13, 12 bản hai, hai frame Q-18 không ảnh |
