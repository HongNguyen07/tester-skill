# [EPIC-SĐT] US9 – Đăng ký & đăng nhập bằng Google — Câu hỏi QA gửi BA

| | |
| --- | --- |
| **Tài liệu** | 09 [EPIC-SĐT] US9 – Đăng ký & đăng nhập bằng Google (bản trong export docs, không ghi version) |
| **Gửi** | BA Chình · PdM Hường (Q-01, Q-02, Q-03, Q-04) · anh Vương (Q-01) · BE Chiến (Q-03, Q-05, Q-11, Q-13, Q-16, Q-17) · Design Hiếu (Q-03) · FE Hoàng (Q-18) |
| **Từ** | Hồng (QA) |
| **Ngày gửi** | 2026-10-16 (Hồng chốt mức; gửi khi tiện) |
| **Tài liệu đã đối chiếu** | Epic §4, §6, §8 (câu hỏi #2, #10, #11, #12, #19) · US1 · US3 · US4 · US5 · US6 · US7 · BUG iOS |

Anh/chị trả lời giúp em vào cột **BA trả lời**. Câu có sẵn phương án thì ghi (a) / (b) / (c); không phương án nào đúng thì ghi
cách đúng. Dòng tài liệu ghi dạng `US9:46` = dòng 46 của file US9.

Không hỏi lại những điểm đã chốt ở US4: tài khoản Google **đặt được mật khẩu** qua Quên mật khẩu (Epic #11 — em áp dụng theo kết
quả này, nhờ anh/chị cập nhật US9 BR6 và Epic #11); đổi mật khẩu đăng xuất mọi thiết bị **kể cả phiên Google**, thiết bị khác về
màn đăng nhập ở lần gọi API kế tiếp; quy định mật khẩu 8–16 ký tự có chữ và số.

**Phần A** là các câu đổi kết quả test — chưa có trả lời thì QA chưa viết được case cho phần liên quan. Phần B không chặn việc.

## Phần A — Đổi kết quả test

| # | Câu hỏi | Tài liệu đang ghi | Phương án | BA trả lời |
| --- | --- | --- | --- | --- |
| **Q-01** (anh Vương, Hường) | Epic **#10** đã chốt chưa: trên **iOS**, bấm Google với email **chưa có tài khoản** → **không tạo** tài khoản (báo "Tài khoản chưa tồn tại…", màn 21) hay **cho tạo mới** như Android? Tài liệu ghi "AC5 cần có trước lần submit iOS tiếp theo" nên em cần kết quả sớm. | BR4 ghi "*Đề xuất – chờ chốt câu hỏi mở #10*" (`US9:48`), nhưng AC5 (`US9:64`), wireframe màn 21 và Epic §4 "iOS: Google chỉ đăng nhập tài khoản đã có" (`EPIC:78`) viết như đã chốt. Epic #10 còn trống (`EPIC:153`). | **(a)** iOS chỉ đăng nhập tài khoản đã có; email mới → AC5.<br>**(b)** iOS cho tạo mới như Android.<br>**(c)** Khác. | Hường (2026-10-16): "out of scope" — Hồng làm rõ 2026-10-16: Epic #10 chưa chốt → nhánh iOS email mới (BR4/AC5) ngoài phạm vi test đợt này<br>*QA tạm theo (Hồng, 2026-10-16): (a) — đưa lại phạm vi đợt này. Nhờ anh/chị xác nhận (Epic #10).*<br>*Hồng chốt 2026-10-16: test theo (a) làm pass/fail, Q-01 không còn chặn cổng; vẫn mong anh/chị chốt Epic #10 — nếu chốt (b) QA sửa case.*<br>**Hường xác nhận (2026-10-16): (a)** — iOS không tạo tài khoản, báo "Tài khoản chưa tồn tại. Vui lòng đăng ký trên web hoặc ứng dụng Android.". Nhờ bỏ chữ "Đề xuất" ở BR4 và điền kết quả Epic #10. |
| **Q-02** (Chình, Hường) | Email **đã được mời vào workspace nhưng chưa có tài khoản** bấm Google: BR2 ghi "được mời" là tài khoản đã có → "đăng nhập vào tài khoản đó" — tài khoản nào (hệ thống đã tạo sẵn khi mời)? Nếu chưa có tài khoản: Android/Web tạo mới rồi vào **workspace đã mời** hay workspace mới? Trên **iOS** email này được vào (AC4) hay bị chặn (AC5)? *(Nối câu Q-01 em đã hỏi ở US6 — chưa có trả lời.)* | BR2: "Email Google trùng email của tài khoản đã có (đăng ký email, form cũ, **được mời**) → đăng nhập vào tài khoản đó" (`US9:46`). US5: "hiện chỉ mời bằng email" (`US5:8`). | **(a)** Email được mời = đã có tài khoản (tạo sẵn khi mời) → AC4 cả 3 nền tảng, vào workspace đã mời.<br>**(b)** Chưa có tài khoản: Android/Web tạo mới → vào workspace đã mời; iOS → AC5.<br>**(c)** Chưa có tài khoản: Android/Web tạo mới → workspace mới, lời mời xử lý riêng; iOS → AC5.<br>**(d)** Khác. | Hường (2026-10-16): **(c)** Chưa có tài khoản: Android/Web tạo mới → workspace mới, lời mời xử lý riêng; iOS → AC5 |
| **Q-03** (Hường, Chiến, Hiếu) | Epic **#19** chốt "Mở google chọn gmail" — là cách nào: **màn chọn tài khoản Google của hệ điều hành** (Google Sign-In, như `US9:17`) hay **mở trang Google** trong app để chọn gmail? Hai câu đang đọc được thành hai cách; nó đổi màn người dùng thấy trên mobile, cách Hủy (AC6) và lỗi (AC10). Epic #2 (token Keycloak cho Google trong app) đã có hướng chưa? | US9: "Trên mobile: dùng màn chọn tài khoản Google của hệ điều hành (Google Sign-In), không mở trang web" (`US9:17`). Epic #19: "Mở google chọn gmail FE có thể triển khai luôn / Mở hệ điều hành chọn gmail, cần đến BE → Mở google chọn gmail" (`EPIC:162`). Epic #2 trống (`EPIC:145`). | **(a)** Màn chọn tài khoản của hệ điều hành (đúng `US9:17`).<br>**(b)** Mở trang Google trong app (cần sửa `US9:17`).<br>**(c)** Khác (web và mobile khác nhau — ghi rõ). | Hường (2026-10-16): "out of scope" — Hồng làm rõ 2026-10-16: Epic #19 chưa chốt → hình thức mở Google trên mobile ngoài phạm vi, QA chỉ ghi nhận<br>**Hường xác nhận lại (2026-10-16): không mở trang web → (a)**. Nhờ sửa câu chữ Epic #19 cho khớp `US9:17`. |
| **Q-04** (Hường) | Tài khoản tạo bằng Google **chưa đặt mật khẩu** bấm **Thêm SĐT** ở Thông tin tài khoản (AC8): màn 09 yêu cầu "mật khẩu hiện tại" thì nhập gì? *(US5 câu hỏi mở đang chờ chị Hường chốt.)* | BR7: "vẫn thêm SĐT bình thường" (`US9:51`). US5 BR3: thêm SĐT phải nhập mật khẩu hiện tại (`US5:52`, `US5:69`). BR6: tài khoản Google không có mật khẩu (`US9:50`). US5 §8: "bỏ bước mật khẩu với tài khoản Google, hoặc yêu cầu đặt mật khẩu trước qua Quên mật khẩu – Hường chốt" (`US5:88`). Luồng ChatGoni (màn 18) không hỏi mật khẩu (`US7:83`). | **(a)** Bỏ bước mật khẩu với tài khoản Google (chưa có mật khẩu) → vào thẳng nhập SĐT → OTP.<br>**(b)** Bắt đặt mật khẩu trước qua Quên mật khẩu (màn 09 báo gì?).<br>**(c)** Chỉ thêm SĐT qua ChatGoni (US7); nút Thêm ở Thông tin tài khoản ẩn/khóa với tài khoản Google.<br>**(d)** Khác. | Hường (2026-10-16): **(b)** Bắt đặt mật khẩu trước qua Quên mật khẩu; màn 09 báo gì — chốt sau |
| **Q-05** (Chình, Chiến) | Android/Web, email Google mới (AC3): sau khi chọn tài khoản Google có **màn "Đăng ký thành công" / nút "Bắt đầu sử dụng"** như US1/US6 không, hay vào **thẳng ChatGoni**? Tài khoản và workspace tạo ở **thời điểm nào** — nếu **mất mạng ngay sau khi chọn tài khoản** thì tài khoản đã tạo chưa (lần sau bấm Google là tạo mới hay đăng nhập)? | AC3: "Tạo tài khoản, họ tên từ Google → (tạo workspace nếu chưa có) → ChatGoni chat ngay" (`US9:62`); user flow không vẽ màn thành công. US1 AC10 có nút "Bắt đầu sử dụng" (`US1:68`). | **(a)** Vào thẳng ChatGoni; tài khoản + workspace tạo ngay khi BE nhận kết quả chọn tài khoản Google.<br>**(b)** Có màn thành công + nút "Bắt đầu sử dụng" như US1/US6; workspace tạo khi bấm nút.<br>**(c)** Khác. | Hường (2026-10-16): **(b)** Có màn thành công + nút "Bắt đầu sử dụng" như US1/US6; workspace tạo khi bấm nút |
| **Q-23** (Hường, Hoàng) | *(Từ thiết kế test)* Chị Hường đã chốt mobile "không mở trang web", dùng màn chọn tài khoản của hệ điều hành. Trên **iOS** không có màn chọn tài khoản Google cấp hệ điều hành như Android; Google Sign-In trên iOS thường hiện một **phiên xác thực web của hệ thống**. Trên iOS, như vậy có tính là "không mở trang web" không? | US9:17; câu trả lời Q-03. | **(a)** Có — chỉ cấm mở trình duyệt / trang web trong app.<br>**(b)** Không — iOS phải dùng cách khác (ghi rõ).<br>**(c)** Khác. | |
| **Q-24** (Hường, Chiến) | *(Từ CX review — chạm bảo mật)* Tài khoản **form cũ** có email **chưa từng xác thực**. Chủ thật của email đó bấm Google → theo BR2 vào tài khoản đó, trong khi người tạo cũ vẫn giữ mật khẩu. Mật khẩu cũ còn hiệu lực không? Có thông báo / tách tài khoản / bắt đặt lại mật khẩu không? | BR2 (US9:46) "form cũ"; Epic: form cũ không xác thực email (EPIC:28). | | |

## Phần B — Không chặn việc, nhờ anh/chị xác nhận hoặc bổ sung tài liệu

| # | Nội dung | Tài liệu đang ghi | Phương án | BA trả lời |
| --- | --- | --- | --- | --- |
| **Q-06** (Chình) | Nhờ cập nhật **US9 BR6** (bỏ chữ "Đề xuất") và **Epic #11** theo kết quả đã chốt ở US4: tài khoản Google đặt được mật khẩu qua Quên mật khẩu. | `US9:50` "Đề xuất – câu hỏi mở #11"; `EPIC:154` trống; `US4:52` đã viết như chốt. | | |
| **Q-07** | AC4 "đúng workspace": tài khoản đã có nhưng **chưa có workspace** (form cũ chưa tạo) hoặc thuộc **nhiều workspace** → sau khi đăng nhập Google vào đâu? Có "tạo workspace (nếu chưa có)" như AC3 không? | AC4 (`US9:63`); AC3 (`US9:62`); US3 AC4 cùng chữ (`US3:55`). | **(a)** Giống đăng nhập email/SĐT hiện tại.<br>**(b)** Khác — ghi rõ. | |
| **Q-08** | AC7 "popup xác thực theo US7": tài khoản Google mở ChatGoni **lần đầu** có popup ngay không, hay chỉ khi chọn Pro / hết 100% như US7? | AC7 (`US9:67`); US7 AC1 "không có popup" (`US7:61`); popup khi chọn Pro (`US7:66`), hết 100% (`US7:68`). | **(a)** Không popup khi vào; theo điều kiện US7.<br>**(b)** Có popup ngay. | |
| **Q-09** | AC10: **thông báo nguyên văn** cho "Google lỗi" và "mất mạng"; lỗi hiện ở màn nào (màn 01/05a hay trong màn chọn tài khoản); "thử lại" là bấm lại nút Google? Với tài khoản **chỉ có Google** (chưa đặt mật khẩu), gợi ý "đăng nhập bằng email/SĐT" có cần đổi không? | AC10 (`US9:71`). | | |
| **Q-10** | AC6 Hủy ở màn chọn tài khoản: "màn trước" = màn 01 hay 05a/11 tùy nơi bấm? Trên web là đóng cửa sổ Google? Email/mật khẩu đã gõ ở màn 01 có giữ không? | AC6 (`US9:65`). | | |
| **Q-11** (Chiến) | BR3 "họ tên lấy từ Google": lấy **trường nào** (tên hiển thị Google)? Tài khoản Google **không có tên** / tên quá dài / ký tự đặc biệt / có dấu → họ tên Gopany là gì (US5 BR1 không cho để trống)? | BR3 (`US9:47`); `EPIC:104`; `US5:50`. | | |
| **Q-12** | BR1 áp cho **mọi** email Google: Google Workspace (tên miền riêng công ty), email Google **chưa được Google xác minh**, alias? | BR1 (`US9:45`). | **(a)** Mọi email Google trả về đều tính đã xác thực.<br>**(b)** Khác. | |
| **Q-13** (Chiến) | **API** đăng nhập Google (web, mobile) và **mã lỗi** cho AC5, AC10. Môi trường mobile có luồng Google **trong app** (Epic #2) từ khi nào để QA test? | `EPIC:206` BE trả mã lỗi; US9 không có cột mã lỗi; Epic #2 (`EPIC:145`). | | |
| **Q-14** | "Lưu đăng nhập" ở màn 01 có áp cho đăng nhập Google không (lần sau mở app có tự vào)? | Wireframe màn 01 (`US9:30`); `US3:51`. | | |
| **Q-15** | Ngoài IP Việt Nam, màn đăng ký chỉ còn tab Email — nút "Tiếp tục với Google" **vẫn có** (BR8 không giới hạn IP)? | BR8 (`US9:52`); US1 AC2 (`US1:57`). | **(a)** Vẫn có.<br>**(b)** Khác. | |
| **Q-16** (Chiến) | Tài khoản Google đã đặt mật khẩu, bị **tạm khóa đăng nhập** do sai mật khẩu nhiều lần (US3 BR2) → bấm "Đăng nhập bằng Google" còn vào được không? | `US3:43`; AC9 (`US9:69`). | **(a)** Vẫn vào được bằng Google.<br>**(b)** Khóa cả Google.<br>**(c)** Khác. | |
| **Q-17** (Chiến) | Tài khoản **form cũ** (email chưa qua xác thực) đăng nhập Google bằng email đó → Thông tin tài khoản hiện email "**Đã xác thực**"? Dữ liệu email cũ được coi là trạng thái gì? | `EPIC:28` form cũ không xác thực; `EPIC:98` không có trạng thái "Chưa xác thực"; AC8 (`US9:68`). | | |
| **Q-18** (Hoàng) | Android **không có tài khoản Google nào trên máy** / không có Google Play Services → bấm nút Google hiện gì (xếp vào AC10)? | AC10 (`US9:71`); `US9:17`. | | |
| **Q-19** | AC5 trên iOS: thông báo hiện ở **màn đăng nhập** (banner như wireframe 21) hay popup; sau đó bấm Google lại được; thông báo mất khi nào? | AC5 (`US9:64`); wireframe màn 21 "ở lại màn đăng nhập với thông báo trên" (`US9:30`). | | |
| **Q-25** (Chình, Hiếu) | AC8 ghi Email "Đã xác thực" (gắn Google, không có nút Đổi): chữ "gắn Google" có **hiển thị trên màn** không, hay chỉ là chú thích? | AC8 (US9:68). | | |
| **Q-26** (Chình) | Thông báo sai thông tin đăng nhập ở màn 01 dùng câu nào: bảng thông báo "Tài khoản hoặc mật khẩu không chính xác. Vui lòng thử lại." hay US3 AC5 "Email/số điện thoại hoặc mật khẩu không đúng"? | bang-noi-dung-thong-bao.md dòng 19; US3:56. | | |
| **Q-28** (Chình, Hường) | Email được mời chưa đăng ký, tạo tài khoản bằng Google → vào workspace mới (Q-02). Người dùng **thấy lời mời ở đâu** và làm gì để vào workspace đã mời? | Câu trả lời Q-02 "lời mời xử lý riêng". | | |

## Lịch sử cập nhật

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
| 2026-10-16 | AI (Orchestrator) — người dùng Hồng | Soạn Q-01→Q-19 từ mục 9 file 01; mức do AI đề xuất, chờ Hồng chốt trước khi gửi |
| 2026-10-16 | Hồng (QA) — AI ghi | Hồng chốt Phần A (Q-01→Q-05) đều trọng yếu; file sẵn sàng gửi |
| 2026-10-16 | PdM Hường qua Hồng chuyển — AI ghi | Điền cột BA trả lời Q-01→Q-05; Q-01, Q-03 "out of scope" cần hỏi lại nghĩa; Q-04 còn phần thông báo màn 09 (Q-04b trong 02) |
| 2026-10-16 | Hồng (QA) — AI ghi | Q-01, Q-03: ghi rõ nghĩa oos (Epic #10, #19 chưa chốt → ngoài phạm vi đợt này) |
| 2026-10-16 | Hồng (QA) + PdM Hường qua Hồng — AI ghi | Q-01: QA tạm theo (a), đưa lại phạm vi; Q-03: Hường xác nhận lại (a) không mở trang web |
| 2026-10-16 | Hồng (QA) — AI ghi | Q-01: hạ không trọng yếu, test theo (a) hiện tại; vẫn chờ chốt Epic #10 |
| 2026-10-16 | PdM Hường qua Hồng — AI ghi | Q-01: Hường xác nhận (a) |
| 2026-10-16 | AI (Orchestrator) — sau S6/S7 | Thêm Q-23, Q-24 (Phần A, đề xuất trọng yếu — chờ Hồng chốt), Q-25, Q-26, Q-28 (Phần B). Q-27 phụ thuộc US4 Q-26, không gửi riêng |
