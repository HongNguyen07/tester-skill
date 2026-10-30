---
featureId: EPIC-SDT-US6
basedOn: 02-alignment-summary.md (gate: open, 2026-10-16; cổng đóng một phần 2026-10-16 — closedScope: AC9 Q-17, nhánh chặn màn 11 Q-18)
designedAt: 2026-10-16
---

# Test Design — EPIC-SDT-US6: Đăng ký bằng email với xác thực OTP

Viết tắt tệp như `01-requirement-analysis.md` (`US6:NN` = dòng NN của tệp US6; `EPIC`, `US1`, `US2`, `US3`, `US4`, `US5`, `US7`, `US9`, `BUG10`, `US4-AS`). Mã `E-xx` = quy tắc chung Epic/story liên quan, QA đánh ở file 01 mục 5b. `02 §4 d.N` = mục 4 dòng N của `02-alignment-summary.md`. Màn 11/12/13/14 theo bảng màn `US6:35-40`; màn 01 = Đăng nhập (`US3:36`); màn 15 = ChatGoni (wireframe `US6:29`). Nền tảng: Android, Web (`US6:3`); iOS chỉ AC2. Case không ghi nền tảng thì chạy trên Android và Web. `FIGMA <frame>` = Figma giao diện thật "Gopany v1.1" (Hồng gửi 2026-10-16; ảnh + lớp text ở `figma/`; đối chiếu 01 §6d) — `[NGUỒN]` cho bố cục / câu chữ theo `US6:33`, **không thay BR/AC**; ảnh xem được 5/9 frame US6, frame 1641:50334, 1641:50302, 1819:5296, 1819:5430 chỉ có tên + lớp text.

Tên nút / nhãn ưu tiên theo Figma khi đã đọc được: "Gửi mã xác thực", "Tiếp tục với Google", "Đăng nhập" (FIGMA 1641:50276); "Xác thực" ở màn 12 (FIGMA 1641:50362 — wireframe ghi "Xác nhận"); "Bắt đầu sử dụng" (FIGMA 1641:50321). Chưa đọc được thì theo wireframe `US6:29`: "Đổi email" (Figma ghi "Đổi số" — Q-09), "Gửi lại mã", "Hiện", "Đăng ký", nhãn "Đã xác thực" (Badge màn 13 chữ chưa đọc). Tên thật khác thì ghi nhận, không tính fail. **Cổng đóng một phần (02 `closedScope`, Hồng 2026-10-16):** AC9 — Q-17 (case mật khẩu giữ Expected theo BA Q-01, `❓`, không pass/fail) · nhánh chặn mới ở màn 11 — Q-18 (chỉ placeholder [US6_79] [US6_80]).

## 1. Use Case

| Mã | Tên | Actor | Nguồn |
| --- | --- | --- | --- |
| UC-01 (mã QA, giữ từ file 01) | Đăng ký bằng email (Android, Web): màn 01 bấm "Đăng ký" → 11 tab Email, nhập email, "Gửi mã xác thực" → 12 nhập OTP, "Xác thực" → 13 email "Đã xác thực", Mật khẩu + Xác nhận mật khẩu, "Đăng ký" → tạo tài khoản → 14 Đăng ký thành công → tạo workspace (nếu chưa có) → ChatGoni chat ngay | Người dùng mới, chưa có tài khoản Gopany | `US6:11`, `US6:57-71`, user flow `US6:21`, `EPIC:74` |
| UC-02 (mã QA, giữ từ file 01) | iOS: dùng app theo mọi đường (back, link trong trang, deep link, Google) → không vào được màn đăng ký | Người dùng app iOS | `US6:58`, `EPIC:108`, `BUG10:28`, `BUG10:34-36` |

Thứ tự kiểm ở bước 1 theo user flow (`US6:21`): đúng định dạng? (AC3) → email đã có tài khoản? (BR1 → AC4) → gửi email được? (không → AC5; được → màn 12).

## 2. Business Rule

| Mã | Tóm tắt | Trạng thái hiểu | Nguồn |
| --- | --- | --- | --- |
| BR1 | Chỉ email chưa gắn tài khoản nào mới được đăng ký; "đã có tài khoản" gồm tài khoản form cũ, Google, email thêm ở US5, tài khoản vừa tạo ở US6; so khớp không phân biệt hoa/thường. Hình thức AC4 theo Figma: **popup** "Email này đã được đăng ký. Bạn có muốn đăng nhập không?" nút "Hủy" / "Đăng nhập" (FIGMA 1819:5176) | `[NGUỒN]` (02 §4 d.14 hoa/thường) · `[NGUỒN]` Figma hình thức popup (câu chữ BA chưa xác nhận — Q-07); email **được mời vào workspace** còn mở Q-01 (02 §4 d.15 `[GIẢ ĐỊNH]`); hai thiết bị song song còn mở Q-06; đích "Hủy" / "Đăng nhập" Q-16 → nhóm B | `US6:46`, `US6:61`, `EPIC:96-97`, `US9:45-46`, `US5:57` |
| BR2 | Chỉ tạo tài khoản khi đã xác thực OTP + mật khẩu hợp lệ + ô Xác nhận khớp ô Mật khẩu; bỏ ngang sau OTP → chưa tạo | `[NGUỒN]`; quy định mật khẩu `[ĐÃ XÁC NHẬN]` (US4-AS Q-01, 02 §4 d.13); thời hạn sau OTP đúng còn mở Q-03 (02 §4 d.16 `[GIẢ ĐỊNH]`); API/mã lỗi còn mở Q-12 | `US6:47`, `US6:66-69`, `EPIC:106`, `EPIC:206` |
| BR3 | Không nhập họ tên, SĐT; họ tên tự tạo = email đăng ký (email đã qua OTP), sửa được ở Thông tin tài khoản (US5); màn 13 có 2 ô Mật khẩu / Xác nhận mật khẩu, mỗi ô nút Hiện | `[NGUỒN]` (02 §4 d.1, d.2, d.3); chữ hoa/thường khi lưu tên/email còn mở Q-08; bấm Hiện ô này ô kia có hiện theo không `[DIỄN GIẢI AI]` → nhóm B | `US6:48`, `EPIC:104-105`, `US5:66-67` |
| BR4 | Không giới hạn IP: IP VN, ngoài VN, không xác định được IP đều đi hết luồng tạo tài khoản; ngoài VN màn 11 chỉ còn Email | `[NGUỒN]` (02 §4 d.4); đổi IP giữa chừng `[DIỄN GIẢI AI]` → nhóm B (02 §4 d.5); cách hiện tab ngoài VN còn mở Q-14 | `US6:49`, `EPIC:107`, `US1:45`, `US1:56-57` |
| BR5 | Tài khoản email mới chưa có SĐT → ChatGoni hạn mức thấp tới khi thêm SĐT (US7); US6 dừng ở dấu hiệu hạn mức thấp | `[NGUỒN]` (02 §4 d.6); % sau một câu `[DIỄN GIẢI AI]` → nhóm B (02 §4 d.7) | `US6:50`, `US7:50`, `US7:54`, `US7:61-65` |
| AC1, AC2 | Hiển thị: tab Email thay form cũ (Android/Web); iOS không vào được đăng ký | `[NGUỒN]`; năm đường iOS theo tài liệu (02 §4 d.8), ba đường ngoài tài liệu → nhóm B (02 §4 d.9); phần tử chỉ có trên wireframe còn mở Q-14 | `US6:57-58`, `EPIC:108`, `US3:53`, `BUG10:34-36`, `US9:64` |
| AC3 | Email sai định dạng → lỗi tại ô "Email không đúng định dạng" (Figma: chữ đỏ ngay dưới ô, viền ô đỏ, nút "Gửi mã xác thực" vẫn bật — FIGMA 1819:5526), không gửi mã; định dạng hợp lệ: `ten@tenmien.duoi`, đúng 1 `@`, tên miền có `.`, đuôi ≥2 chữ cái, không khoảng trắng / dấu tiếng Việt, ≤254 ký tự, cho phép `.` `_` `-` `+` trước `@`; khoảng trắng đầu/cuối tự cắt; FE kiểm tại ô, BE kiểm lại | `[NGUỒN]` + `[ĐÃ XÁC NHẬN]` quy định, bộ mẫu hợp lệ / sai và nguyên văn thông báo (BA qua Hồng 2026-10-16, 02 §4 d.21 — thay cho US4-AS Q-07); lớp BE qua API còn mở Q-12; ô trống không có trong câu trả lời BA → nhóm B | `US6:60`, `EPIC:206`, 02 §4 d.21 |
| AC5 | Không gửi được email → ở lại màn 11, báo lỗi, cho thử lại | `[NGUỒN]` ở màn 11 (02 §4 d.17); thử lại có cooldown / tính lượt còn mở Q-02 `[GIẢ ĐỊNH]`; nguyên văn Q-07 | `US6:62`, user flow `US6:21` |
| AC6 | Gửi mã hợp lệ → OTP qua email (phải có mã; thân email mẫu đăng ký nguyên văn FIGMA 1859:3924); màn 12 hiện email che một phần, nút Đổi email, gợi ý Spam; Gửi lại mã mờ đếm 60 s | `[NGUỒN]` (02 §4 d.11); **Figma khác AC6** (FIGMA 1641:50362): link ghi "Đổi số", **không có** gợi ý Spam, khi đang đếm chỉ có đồng hồ "45s" — Expected theo AC6 + chú Figma, [US6_20] `❓` Q-09; mẫu che (Figma `ng•• ••• @congty.vn`), Đổi email điền sẵn/trống, độ dài mã còn mở Q-09 | `US6:64`, `US2:56-59`, FIGMA 1641:50362, 1859:3924 |
| AC7 | Nhập sai / hết hạn / gửi quá nhiều → theo US2 (màn 12 là cùng màn OTP, kênh email) | `[NGUỒN]`; con số US2 (số lần gửi, số lần sai, khóa) còn mở Q-11 | `US6:65`, `EPIC:90`, `US2:45-48`, `US2:59-67` |
| AC8 | Đúng OTP → màn 13 "Tạo mật khẩu", email hiện nhãn "Đã xác thực" (chỉ nói OTP đúng, tài khoản chưa tồn tại) | `[NGUỒN]` (02 §4 d.12); Figma màn 13 (FIGMA 1641:50302, chỉ lớp text): có Badge (chữ chưa đọc), **có nút Quay lại** (wireframe không) → Q-10, nhóm B [US6_81] | `US6:66`, `EPIC:98`, `EPIC:106` |
| AC9 | Mật khẩu không đạt → lỗi ô Mật khẩu; không khớp → lỗi ô Xác nhận mật khẩu "Mật khẩu xác nhận không khớp."; chưa tạo tài khoản | **Cổng đóng — Q-17 (Hồng chốt trọng yếu 2026-10-16):** helper Figma US4 màn 04 (`FIGMA 1754:6840`) đòi hoa + thường + số + đặc biệt, khác BA Q-01; helper màn 13 (`FIGMA 1641:50302`) chưa đọc được → [US6_30]→[US6_36] giữ Expected theo BA Q-01, `❓`, không pass/fail, không thêm case. `[NGUỒN]` vị trí một ô sai (02 §4 d.13); nguyên văn lỗi không đạt Q-07; cả hai ô cùng sai, nút Đăng ký tắt/bật, ô toàn khoảng trắng còn mở Q-10 → nhóm B | `US6:68`, `US4-AS` Q-01, 02 Q-17 |
| AC10 | Mật khẩu hợp lệ, bấm Đăng ký → tạo tài khoản → màn 14 (tick xanh, "Đăng ký thành công", khung "Tên hiển thị: <email>" + "bạn có thể đổi trong: Tài khoản → Thông tin tài khoản", nút "Bắt đầu sử dụng" — FIGMA 1641:50321) → tạo workspace (nếu chưa có) → ChatGoni chat ngay | `[NGUỒN]`; nút "Bắt đầu sử dụng" nay có trên Figma (`[NGUỒN]`); **Figma màn 14 ghi "tạo với số điện thoại +84 912 345 678"** trong luồng email, ngược wireframe / BR3 → Q-19, [US6_40] `❓` (Expected theo wireframe / BR3); thời điểm tạo tài khoản / workspace, thoát ở màn 14 còn mở Q-05 (02 §4 d.19 `[GIẢ ĐỊNH]`) | `US6:69`, `US1:68`, `US7:61`, FIGMA 1641:50321 |
| AC11 | Bỏ ngang, mất mạng, lỗi hệ thống → chưa tạo tài khoản; báo lỗi tiếng Việt, cho thử lại | `[NGUỒN]` phần chưa tạo tài khoản; ra nền / F5 / tắt app / đóng tab về đâu còn mở Q-04 (02 §4 d.20 `[GIẢ ĐỊNH]`); response rớt sau khi BE tạo xong còn mở Q-13; nguyên văn Q-07 | `US6:71`, `EPIC:106`, 02 §4 d.18 |
| E-01→E-21 | Quy tắc chung Epic / US2 / US5 / US7 / US9 / BUG10 áp vào US6 | `[NGUỒN]`; E-09 `[ĐÃ XÁC NHẬN]` (US4-AS Q-01) — **đang chịu Q-17**; E-10 con số trống (Q-11); E-20 là đề xuất (Q-06) | file 01 mục 5b |
| (chưa có mã) Nhánh chặn màn 11 trên Figma | "Thiết bị đã vượt giới hạn số lượng email được phép sử dụng" (FIGMA 1819:5296) · "Email thuộc danh sách chặn" (FIGMA 1819:5430) — US6 / Epic không có BR/AC; ngưỡng, cách nhận diện thiết bị, ai quản lý danh sách, thông báo chưa có | `[CẦN XÁC NHẬN]` — **Q-18 trọng yếu, cổng đóng** (Hồng 2026-10-16); chỉ placeholder [US6_79] [US6_80], không expected, không suy đoán | tên frame Figma (01 §6d); `EPIC:157` #14, `US2:78` còn mở |

## 3. Decision Table

### DT-1 — Màn 11: kết quả sau khi bấm "Gửi mã xác thực" (AC3, BR1/AC4, AC5, AC6)

Thứ tự điều kiện theo user flow `US6:21`.

| Điều kiện / Hành động | R1 | R2 | R3 | R4 |
| --- | --- | --- | --- | --- |
| C1: Email đúng định dạng (02 §4 d.21 `[ĐÃ XÁC NHẬN]`: `ten@tenmien.duoi`, đúng 1 `@`, tên miền có `.`, đuôi ≥2 chữ cái, không khoảng trắng / dấu tiếng Việt, ≤254 ký tự; `.` `_` `-` `+` trước `@` hợp lệ; khoảng trắng đầu/cuối tự cắt trước khi kiểm) | Không | Có | Có | Có |
| C2: Email đã gắn tài khoản (form cũ / Google / thêm ở US5 / tạo ở US6; không phân biệt hoa/thường) | — | Có | Không | Không |
| C3: Dịch vụ gửi email thành công | — | — | Không | Có |
| → Màn hình | Ở màn 11 | Ở màn 11 | Ở màn 11 (02 §4 d.17) | Sang màn 12 |
| → Kết quả (nguồn) | Lỗi tại ô Email, không gửi mã (`US6:60`) | Không gửi OTP; báo đã đăng ký, gợi ý Đăng nhập (`US6:61`) | Báo lỗi, cho thử lại (`US6:62`) | OTP gửi qua email; màn 12 hiện email che một phần, nút Đổi email, gợi ý Spam (`US6:64`) |
| → Nguyên văn / hình thức | "Email không đúng định dạng" chữ đỏ dưới ô + viền đỏ, nút vẫn bật (02 §4 d.21; FIGMA 1819:5526) | Popup "Email này đã được đăng ký. Bạn có muốn đăng nhập không?" nút "Hủy" / "Đăng nhập" (FIGMA 1819:5176; BA chưa xác nhận câu chữ — Q-07) | Chờ Q-07 (chưa có trên Figma) | Màn 12 theo FIGMA 1641:50362 — "Đổi số" / không Spam: Q-09 |
| Case | [US6_06] [US6_07] | [US6_10]→[US6_14] [US6_16] | [US6_18] [US6_19] | [US6_08] [US6_09] [US6_20] [US6_74] [US6_75] [US6_77]; [US6_76] chỉ kiểm tới C1 (254 ký tự, không có hộp thư thật) |

Không đưa vào bảng vì kết quả chưa chốt: email **được mời vào workspace nhưng chưa đăng ký** (Q-01, [US6_15] `❓`); hai thiết bị cùng email song song (Q-06, [US6_17] `❓`); thử lại sau lỗi gửi có cooldown / tính lượt (Q-02, [US6_19] `❓`); ô Email trống / toàn khoảng trắng — không có trong câu trả lời BA → nhóm B [US6_78] (Figma: nút mờ khi trống, FIGMA 1641:50276). **Hai nhánh chặn chỉ có trên Figma** ("thiết bị vượt giới hạn số email" 1819:5296, "email thuộc danh sách chặn" 1819:5430) — không có điều kiện nào trong tài liệu để đưa vào bảng → Q-18, placeholder [US6_79] [US6_80]; thứ tự so với C1–C3 chưa biết.

### DT-2 — Màn 13: kết quả sau khi bấm "Đăng ký" (BR2, AC9, AC10)

| Điều kiện / Hành động | R1 | R2 | R3 | R4 |
| --- | --- | --- | --- | --- |
| C1: OTP của email này đã xác thực (BE) | Không (gọi API bỏ qua FE) | Có | Có | Có |
| C2: Ô Mật khẩu đạt quy định (8–16 ký tự, ≥1 chữ và ≥1 số — BA Q-01; **đang chịu Q-17, cổng đóng cho AC9**: helper Figma US4 đòi thêm hoa / thường / đặc biệt) | — | Không | Có | Có |
| C3: Ô Xác nhận mật khẩu khớp ô Mật khẩu | — | — | Không | Có |
| → Kết quả (nguồn) | BE từ chối, không tạo tài khoản (`US6:47`, `EPIC:206`) | Lỗi tại ô Mật khẩu; chưa tạo tài khoản (`US6:68`, 02 §4 d.13) | Lỗi tại ô Xác nhận mật khẩu "Mật khẩu xác nhận không khớp."; chưa tạo tài khoản (`US6:68`) | Tạo tài khoản → màn 14 (`US6:69`) |
| → Nguyên văn / mã lỗi | Mã lỗi: Chờ Q-12 | Nguyên văn: Chờ Q-07 | Nguyên văn có trong nguồn | — |
| Case | [US6_28] `❓` | [US6_33]→[US6_36] `❓` Q-17 | [US6_37] (giá trị `Gopany@123` đạt cả hai quy định — không `❓`, 03 §11 #11) | [US6_30] [US6_31] [US6_32] `❓` Q-17 · [US6_46] [US6_47] |

Không đưa vào bảng: cả hai ô cùng sai (`abc` / `abcd`) — tài liệu không nói hiện một hay hai lỗi (02 §4 d.13 `[GIẢ ĐỊNH]`, Q-10) → nhóm B [US6_65]; chưa nhập đủ 2 ô / ô toàn khoảng trắng (Q-10) → nhóm B [US6_64]; đứng lâu ở màn 13 rồi bấm Đăng ký (Q-03) → [US6_29] `❓`.

## 4. State Transition

Nguồn không định nghĩa máy trạng thái cho phiên đăng ký (file 01 mục 7). Bảng dưới dựng lại từ `US6:47`, `US6:66-71`, `EPIC:98`, `EPIC:106` (`[NGUỒN]`) — ô ghi Q-nn là chỗ tài liệu không nói.

| Trạng thái phiên \ Sự kiện | Bấm "Gửi mã xác thực" hợp lệ | Nhập đúng OTP + "Xác thực" | Bấm "Đăng ký" hợp lệ | App ra nền → quay lại / web F5 | Tắt hẳn app / đóng tab | Mất mạng, lỗi hệ thống |
| --- | --- | --- | --- | --- | --- | --- |
| S0 Màn 11 — chưa có gì | → S1 (màn 12), mã đã gửi (`US6:64`) | — | — | Tài liệu không nói | Tài liệu không nói | Ở màn 11, báo lỗi, thử lại (`US6:71`, 02 §4 d.18) |
| S1 Màn 12 — OTP đã gửi, chưa xác thực | Gửi lại sau 60 s, mã cũ hết hiệu lực (`US2:45-46`) | → S2 (màn 13) (`US6:66`) | — | Q-04 (`[GIẢ ĐỊNH]` giữ màn) | Q-04 (`[GIẢ ĐỊNH]` làm lại từ bước 1) | Chưa tạo tài khoản, báo lỗi, thử lại (`US6:71`) |
| S2 Màn 13 — OTP đã xác thực, tài khoản **chưa tồn tại** (`EPIC:106`) | — | — | → S3: tài khoản tạo, email "Đã xác thực", SĐT "Chưa có" (`US6:69`, `EPIC:98`) | Q-04 | Q-04; chắc chắn: chưa tạo tài khoản (`US6:71`) | Chưa tạo tài khoản (`US6:71`); response rớt sau khi BE tạo: Q-13 |
| S3 Màn 14 — tài khoản đã tồn tại | — | — | — | — | Q-05 (workspace tạo lúc nào, lần sau vào đâu) | — |

Thời hạn S2 (đứng lâu ở màn 13): tài liệu không ghi (Q-03, [US6_29] `❓`). Sự kiện "Quay lại" ở S1 / S2: Figma có nút ở màn 11, 12 (`1641:50276`, `1641:50362`) và màn 13 (`1641:50302`, wireframe không) — tài liệu không nói về đâu → Q-09 / Q-10, nhóm B [US6_62] [US6_81]. Case: [US6_27] [US6_29] [US6_55]→[US6_59].

## 5. Risk Analysis `[QA BỔ SUNG]`

| # | Rủi ro | Impact | Likelihood | Căn cứ | Liên quan BR / Q |
| ---: | --- | --- | --- | --- | --- |
| 1 | Tạo được tài khoản thứ hai cho cùng email (khác hoa/thường, hai thiết bị song song, gọi API bỏ qua FE) → vi phạm "mỗi email một tài khoản" | Cao (dữ liệu, đăng nhập) | Chưa có dữ liệu | `EPIC:96-97`; Epic #22 chưa chốt (`EPIC:165`); FE/BE hai lớp mới chốt 13/10 (`EPIC:206`) | BR1, E-01, E-02, E-13, Q-06, Q-12 |
| 2 | Tài khoản tạo dở (BE tạo xong nhưng FE báo lỗi; hoặc tạo khi chưa verify OTP) | Cao (người dùng không đăng nhập được, email bị "chiếm") | Chưa có dữ liệu | `US6:71` chỉ nói "chưa tạo tài khoản"; Q-13 chưa có câu trả lời; US1 AC12 "không tạo tài khoản dở dang" (`US1:71`) chưa có dòng tương ứng ở US6 | BR2, AC11, Q-13 |
| 3 | Email OTP chậm / vào Spam → người dùng gửi lại nhiều lần, chạm giới hạn US2 | Trung bình (bỏ dở đăng ký) | Chưa có dữ liệu | Epic #8 mở (`EPIC:151`, `US6:75`); Figma màn 12 (`1641:50362`) **không có** gợi ý kiểm tra Spam dù AC6 yêu cầu (Q-09) | AC6, AC7, Q-09, Q-11 |
| 4 | Quy định mật khẩu FE ≠ BE, hoặc ≠ luồng US1/US4 (cùng màn 05c); **Figma ≠ BA** | Trung bình | **Có dấu hiệu** — helper Figma US4 màn 04 (`FIGMA 1754:6840`) đòi hoa + thường + số + đặc biệt, BA Q-01 chỉ ≥1 chữ và ≥1 số | Quy định chưa chép vào Epic (`EPIC:112` trống), chỉ có qua BA (US4-AS Q-01); wireframe "Tối thiểu [__] ký tự"; helper màn 13 chưa đọc được → Hồng chốt Q-17 trọng yếu, cổng đóng cho AC9 | BR2, AC9, E-09, Q-17 |
| 5 | Kết quả xác thực OTP không có thời hạn (khác US4 10 phút) → email đã verify ở thiết bị A dùng được mãi | Trung bình (bảo mật) | Chưa có dữ liệu | US6 im lặng; US4 có BR7–BR8 (`US4:53-54`); Q-03 chưa chốt | BR2, Q-03 |
| 6 | iOS lộ đường vào đăng ký (Apple reject) qua link trong email OTP / deep link | Cao (release) | Đã từng xảy ra (`BUG10:7`) | Lịch sử defect BUG10; US6 có email gửi tới người dùng | AC2, E-08 |
| 7 | Tài khoản mới vào ChatGoni không ở hạn mức thấp (dùng được Pro / hạn mức cao dù chưa có SĐT) | Trung bình (chi phí) | Chưa có dữ liệu | `US7:50`, `US7:54`; con số Admin chỉnh được (US8 chỉ có bản nháp) | BR5, E-11 |
| 8 | Thoát ở màn 14 (không bấm "Bắt đầu sử dụng") → không có workspace, lần sau đăng nhập không vào được đâu | Trung bình | Chưa có dữ liệu | AC10 không nhắc nút; wireframe và Figma màn 14 (`1641:50321`) có nút "Bắt đầu sử dụng"; Q-05 chưa chốt | AC10, Q-05 |
| 9 | Dev làm theo Figma hai nhánh chặn ở màn 11 (giới hạn email / thiết bị, danh sách chặn) mà tài liệu không có → người dùng hợp lệ bị chặn đăng ký, QA không có tiêu chí kiểm; hoặc ngược lại Design vẽ mà không làm | Cao (chặn đăng ký ở bước 1) | Chưa có dữ liệu | Tên frame FIGMA 1819:5296, 1819:5430; US6 / Epic §6 không có BR/AC; `EPIC:157` #14, `US2:78` còn là câu hỏi mở; US1 trên Figma có cặp frame tương ứng cho SĐT | BR1, AC4, Q-18 (cổng đóng) |
| 10 | Màn 14 hiện "tạo với số điện thoại +84 …" cho tài khoản email (như Figma) → người dùng hiểu sai, tài khoản email không có SĐT | Thấp (hiển thị) | Chưa có dữ liệu | FIGMA 1641:50321 ngược wireframe `US6:29` và BR3 `US6:48` | BR3, AC10, Q-19 |

## 6. Coverage Matrix

Chỉ tính case nhóm A. `❓` = case đang `❓ Cần chốt`, không tính là đã phủ. Case chỉ "Chờ Q-07" phần nguyên văn thông báo vẫn tính phủ phần hành vi (giống cách làm ở US4).

| BR / AC | Use Case | Decision / State | Scenario | Case nhóm A | Trạng thái | Ghi chú |
| --- | --- | --- | --- | --- | --- | --- |
| AC1 | UC-01 | — | SC-01 | [US6_01] [US6_02] | Đã phủ | Form cũ không còn đường vào (web URL cũ) → nhóm B [US6_70]; phần tử chỉ có trên wireframe → nhóm B [US6_71] (Q-14) |
| AC2 / E-08 | UC-02 | — | SC-02 | [US6_03] [US6_04] [US6_05] | Đã phủ | Năm đường theo tài liệu (02 §4 d.8); ba đường ngoài tài liệu → nhóm B [US6_67] |
| AC3 / E-13 | UC-01 | DT-1 R1, R4 | SC-03 | [US6_06] [US6_08] [US6_74] [US6_75] [US6_76] [US6_77] · ❓ [US6_07] | Phủ một phần | Hình thức lỗi inline đỏ + viền đỏ, nút vẫn bật theo FIGMA 1819:5526 (đã ghi vào [US6_06]). Lớp FE **đã phủ đủ** theo quy định BA 02 §4 d.21 (bộ sai 6 + 255 ký tự + tên miền có dấu; bộ hợp lệ `+`/`.`, `_`/`-`/`.com.vn`, 254 ký tự, khoảng trắng hai đầu; nguyên văn "Email không đúng định dạng" đã có). Còn `một phần` chỉ vì lớp BE qua API [US6_07] `❓` Q-12. Ô trống → nhóm B [US6_78]; [US6_61] đã chuyển lên |
| BR1 | UC-01 | DT-1 R2, R4 | SC-04 | [US6_09]→[US6_14] · ❓ [US6_15] [US6_16] [US6_17] | Phủ một phần | Email được mời chờ Q-01; song song chờ Q-06; API chờ Q-12. Hai nhánh chặn trên Figma (Q-18) **không** thuộc BR1 — dòng riêng cuối bảng |
| AC4 | UC-01 | DT-1 R2 | SC-04 | [US6_10] [US6_11] [US6_12] [US6_13] [US6_14] · ❓ [US6_15] | Phủ một phần | Hình thức + nguyên văn popup theo FIGMA 1819:5176 (Expected đã dùng; BA chưa xác nhận câu chữ — Q-07, §11 #6); đích "Hủy" / "Đăng nhập", phân nhánh theo loại tài khoản → nhóm B [US6_72] `❓` Q-16 |
| AC5 | UC-01 | DT-1 R3 | SC-05 | [US6_18] · ❓ [US6_19] | Phủ một phần | Thử lại: cooldown / tính lượt chờ Q-02; cách dựng lỗi gửi cần Dev |
| AC6 / E-15 / E-16 | UC-01 | DT-1 R4; ST S0→S1 | SC-04, SC-06 | [US6_09] [US6_21] [US6_42] · ❓ [US6_20] | Phủ một phần | [US6_20] chuyển `❓` Q-09: Figma màn 12 ghi "Đổi số", không có gợi ý Spam, đang đếm chỉ có đồng hồ — Expected theo AC6 + chú Figma; email mẫu [US6_21] có nguyên văn FIGMA 1859:3924; mẫu che, điền sẵn/trống, độ dài mã Chờ Q-09 (nhóm B [US6_62]); thời gian đến / Spam → nhóm B [US6_68] |
| AC7 / E-10 | UC-01 | ST S1 | SC-07 | [US6_22] [US6_23] [US6_24] · ❓ [US6_25] | Phủ một phần | Gửi quá nhiều, tạm khóa cần con số (Q-11); chi tiết thuộc US2 case dùng chung |
| AC8 | UC-01 | ST S1→S2 | SC-08 | [US6_26] [US6_27] | Đã phủ | Màn 13 theo Figma chỉ có lớp text (tiêu đề "Tạo mật khẩu", Badge chữ chưa đọc) — nhãn "Đã xác thực" vẫn theo `US6:66`; nút Quay lại màn 13 → nhóm B [US6_81] `❓` Q-10 |
| BR2 / E-06 | UC-01 | DT-2; ST S2→S3 | SC-08, SC-09, SC-10, SC-13 | [US6_27] [US6_37] [US6_46] [US6_47] [US6_48] · ❓ [US6_28] [US6_29] [US6_49] · ❓ Q-17 [US6_30]→[US6_36] | Phủ một phần | Phần "mật khẩu hợp lệ" của BR2 chịu Q-17 (cổng đóng AC9): 7 case quy định / biên `❓`; phần OTP + khớp + tạo tài khoản vẫn phủ bằng [US6_27] [US6_37] [US6_46]→[US6_48]; BE kiểm qua API chờ Q-12; thời hạn sau OTP chờ Q-03; thoát màn 14 chờ Q-05; mật khẩu trùng email → nhóm B [US6_69] |
| AC9 / E-09 | UC-01 | DT-2 R2–R3 | SC-10 | [US6_37] · ❓ Q-17 [US6_33] [US6_34] [US6_35] [US6_36] (và [US6_30]→[US6_32] phía đạt) | **Phủ một phần — cổng đóng (Q-17)** | Chỉ còn [US6_37] (không khớp, `Gopany@123` đạt cả hai quy định) không `❓` — Orchestrator / Hồng xác nhận có đánh `❓` nốt hay không (§11 #11); nhóm quy định / biên / không đạt giữ Expected theo BA Q-01, không pass/fail; nguyên văn lỗi không đạt Chờ Q-07; cả hai ô cùng sai, nút Đăng ký, khoảng trắng → nhóm B [US6_64] [US6_65] (Q-10) |
| AC10 | UC-01 | DT-2 R4; ST S2→S3 | SC-13 | [US6_46] [US6_47] [US6_48] · ❓ [US6_49] [US6_40] (Q-19) [US6_30] [US6_31] [US6_32] (Q-17) | Phủ một phần | Hình thức màn 14 + nút "Bắt đầu sử dụng" theo FIGMA 1641:50321 (đã ghi vào [US6_46] [US6_40]); dòng mô tả "số điện thoại" trên Figma → [US6_40] `❓` Q-19 (Expected theo wireframe / BR3); thời điểm tạo workspace / thoát màn 14 chờ Q-05 |
| BR3 / E-04 / E-05 | UC-01 | — | SC-11 | [US6_38] [US6_39] [US6_41] [US6_42] · ❓ [US6_43] [US6_40] (Q-19) | Phủ một phần | Tên hiển thị = email vẫn kiểm ở [US6_40] bước 3 và [US6_46] bước 4; [US6_40] `❓` chỉ vì dòng mô tả màn 14 (Q-19); chữ hoa/thường khi lưu chờ Q-08; Hiện liên động → nhóm B [US6_63]; màn 13 có Quay lại (Figma) → [US6_81] |
| BR4 / E-07 | UC-01 | — | SC-12 | [US6_01] [US6_44] [US6_45] [US6_46] | Đã phủ | Cách hiện tab ngoài VN Chờ Q-14 (chỉ hiển thị); đổi IP giữa chừng → nhóm B [US6_66]; không dựng được IP không xác định thì ghi "không chạy được" |
| BR5 / E-11 / E-12 | UC-01 | — | SC-14 | [US6_50] [US6_51] [US6_52] | Đã phủ | Dừng ở dấu hiệu hạn mức thấp (02 §4 d.6); % sau một câu → nhóm B [US6_73] |
| AC11 | UC-01 | ST cột mất mạng / ra nền / tắt | SC-15 | [US6_53] [US6_54] [US6_55] [US6_56] · ❓ [US6_57] [US6_58] [US6_59] | Phủ một phần | Nguyên văn Chờ Q-07; ra nền / F5 / tắt app / đóng tab chờ Q-04; response rớt chờ Q-13; lỗi hệ thống cần Dev cách giả lập |
| E-01, E-02, E-03 | UC-01 | DT-1 R2 | SC-04, SC-14 | [US6_13] [US6_14] [US6_08] [US6_52] | Đã phủ | E-02 hoa/thường khi kiểm trùng có thêm căn cứ `[ĐÃ XÁC NHẬN]` 02 §4 d.21 (ABC@gmail.com = abc@gmail.com) |
| E-17, E-18 | UC-01 | DT-1 R2 | SC-01, SC-04 | [US6_02] [US6_11] | Đã phủ | Hành vi nút Google thuộc US9, không kiểm |
| E-19 | UC-01 | — | SC-14 | [US6_52] | Đã phủ | Hậu kiểm sau đăng ký |
| E-20 | UC-01 | — | SC-04 | ❓ [US6_17] | Chưa phủ | Là đề xuất, không phải quy tắc (Q-06) |
| E-21 | UC-01 | — | SC-13, SC-16 | [US6_47] [US6_60] | Đã phủ | Luồng Google không đổi: chỉ kiểm nút ở [US6_02]; chi tiết thuộc US9 |
| Nhánh chặn màn 11 trên Figma (chưa có BR/AC) | UC-01 | DT-1 — không đưa vào bảng | SC-18 | ❓ [US6_79] [US6_80] (placeholder, Trace `N/A — Q-18`) | **Chưa phủ — cổng đóng (Q-18)** | Không có BR/AC, ngưỡng, thông báo → không viết expected; chờ BA bổ sung BR/AC hoặc xác nhận chỉ là màn dự phòng của Design |

Lỗ hổng:

- Requirement không có case (không `❓`): E-20 — chỉ có case `❓` (Q-06); **nhánh chặn màn 11 trên Figma (Q-18)** — chưa có requirement nên chỉ có placeholder; **AC9** — cổng đóng Q-17, chỉ còn [US6_37] không `❓`. Còn lại mọi BR/AC đều có ≥ 1 case nhóm A không `❓`.
- Case không có nguồn: không có ở nhóm A. Phần nguyên văn thông báo của AC5, AC9 (không đạt), AC11 không có nguồn → ghi `Chờ Q-07` trong Expected, không làm tiêu chí pass (AC3 đã có nguyên văn từ 2026-10-16; **AC4 có nguyên văn popup trên Figma 1819:5176** — dùng làm Expected hình thức, BA chưa xác nhận câu chữ). Hình thức có nhãn `FIGMA <frame>` chỉ là `[NGUỒN]` Figma theo `US6:33` — không thay AC; chỗ Figma khác AC ([US6_20] màn 12, [US6_40] màn 14) Expected giữ theo AC + `❓`. Giá trị `qa@côngty.vn` trong [US6_06] suy từ quy định chung "không dấu tiếng Việt" — BA chưa có ví dụ dấu ở tên miền (§11 #5).
- Coverage chưa rõ: 4 frame Figma chỉ có lớp text (màn 12 bản 1641:50334, màn 13 1641:50302, hai frame Q-18) — chữ trong ô / nút / badge chưa đọc được, không suy đoán; helper quy định mật khẩu màn 13 chưa thấy (Q-17); cột Error Code trống toàn bộ vì chưa có API / mã lỗi (Q-12); "tạo workspace (nếu chưa có)" chỉ quan sát được qua dấu hiệu QA đề xuất (02 §4 d.19 `[QA BỔ SUNG]`), không có tiêu chí trong tài liệu; AC7 chỉ kiểm màn 12 hành xử theo US2 với kênh email, số lần / khóa dẫn chiếu case dùng chung US2.

Loại coverage đã cân nhắc và không áp dụng: Performance — nguồn không có SLA (Epic #8 "đủ nhanh" chưa có con số, chỉ ghi nhận ở nhóm B [US6_68]) · AI-specific — ChatGoni chỉ kiểm tới dấu hiệu hạn mức, không kiểm chất lượng trả lời · Accessibility — nguồn không có yêu cầu · Concurrency — chỉ có đề xuất (Epic #22), đưa vào [US6_17] `❓`.

## 7. Test Scenario

| SC | Mô tả | BR / AC | Use Case | Loại coverage | Nhóm |
| --- | --- | --- | --- | --- | --- |
| SC-01 | Màn 11 trên Android / Web: tab Email thay form cũ, nút Google | AC1, E-18 | UC-01 | UI | A |
| SC-02 | iOS không có đường vào đăng ký: màn đăng nhập, Quên mật khẩu → Back, màn khác, deep link / URL, Google với email chưa có tài khoản | AC2, E-08 | UC-02 | Security · Compatibility | A |
| SC-03 | Kiểm định dạng email tại ô (FE) và BE kiểm lại theo quy định BA 02 §4 d.21: bộ sai 6 giá trị + 255 ký tự + tên miền có dấu; bộ hợp lệ chữ hoa / subdomain, `.`+`+`, `_`/`-`/`.com.vn`, 254 ký tự, khoảng trắng hai đầu tự cắt | AC3, E-13, E-02 | UC-01 | Negative · Positive · Boundary · Integration | A |
| SC-04 | Email chưa có tài khoản → gửi OTP; email đã có tài khoản (form cũ, Google, US5, US6, khác hoa/thường) → AC4; email được mời; hai thiết bị song song; BE kiểm qua API | BR1, AC4, AC6, E-01, E-02, E-13, E-17, E-20 | UC-01 | Positive · Negative · Security · Concurrency | A |
| SC-05 | Dịch vụ gửi email thất bại: ở màn 11, báo lỗi, thử lại | AC5 | UC-01 | Exception & recovery | A |
| SC-06 | Màn 12 hiển thị (che email, Đổi email, Spam, Gửi lại mã đếm ngược — Expected theo AC6, hình thức Figma 1641:50362 ghi "Đổi số" / không Spam → `❓` Q-09) và email OTP mẫu 23 (nguyên văn Figma 1859:3924) | AC6, E-15, E-16 | UC-01 | UI · Integration email | A (`❓` một phần) |
| SC-07 | Màn 12 hành xử theo US2 với kênh email: sai mã, hết hạn, gửi lại, gửi quá nhiều | AC7, E-10 | UC-01 | Negative · Integration | A |
| SC-08 | Đúng OTP → màn 13 với nhãn "Đã xác thực"; bỏ ngang ở màn 13 → tài khoản chưa tồn tại | AC8, BR2, E-06 | UC-01 | Positive · Data integrity | A |
| SC-09 | BE giữ BR2 khi gọi API bỏ qua FE; đứng lâu ở màn 13 rồi Đăng ký | BR2, E-13 | UC-01 | Security · Boundary | A (`❓`) |
| SC-10 | Màn 13: quy định mật khẩu (biên 7/8/16/17, chỉ chữ, chỉ số, ký tự đặc biệt) — **cổng đóng Q-17**, case giữ Expected theo BA Q-01 và `❓`; hai ô khớp vẫn kiểm | BR2, AC9, AC10, E-09, E-05 | UC-01 | Boundary · Negative · Positive | A (`❓` Q-17 trừ [US6_37]) |
| SC-11 | Không ô họ tên / SĐT; hai ô + Hiện; tên hiển thị = email đã qua OTP; sửa tên ở US5; đổi email giữa chừng; chữ hoa | BR3, E-04, E-05 | UC-01 | UI · Data integrity | A |
| SC-12 | IP ngoài VN, IP không xác định vẫn đăng ký email được | BR4, E-07 | UC-01 | Positive · Compatibility | A |
| SC-13 | Đăng ký thành công trên Android, Web Chrome/Safari (màn 14 hình thức Figma 1641:50321, dòng mô tả "số điện thoại" → Q-19); đăng nhập bằng tài khoản mới; thoát ở màn 14 | AC10, BR2, E-21 | UC-01 | Positive · E2E · Compatibility | A |
| SC-14 | Sau màn 14: ChatGoni chat ngay, dấu hiệu hạn mức thấp, Pro khóa; Thông tin tài khoản email "Đã xác thực", SĐT "Chưa có" | BR5, E-03, E-11, E-12, E-19 | UC-01 | Positive · Data integrity | A |
| SC-15 | Lỗi chung: mất mạng ở từng bước, lỗi hệ thống, ra nền / F5 / tắt app / đóng tab, response rớt | AC11, E-06 | UC-01 | Exception & recovery | A |
| SC-16 | Regression: tài khoản form cũ vẫn đăng nhập | E-21 | UC-01 | Regression | A |
| SC-17 | Exploratory: ô Email trống / toàn khoảng trắng (Figma nút mờ), Quay lại / Đổi email điền sẵn, **màn 13 Quay lại (Figma có — Q-10)**, Hiện liên động, nút Đăng ký khi chưa đủ ô, hai ô cùng sai, đổi IP giữa chừng, iOS đường ngoài tài liệu, thời gian email / Spam, mật khẩu trùng email, URL form cũ, phần tử màn 11 (Figma xác nhận có mặt), **popup AC4 Hủy / Đăng nhập (Q-16)**, % sau câu đầu | BR liên quan | UC-01, UC-02 | Edge case | B |
| SC-18 | Placeholder — hai nhánh chặn ở màn 11 chỉ có trên Figma ("thiết bị vượt giới hạn số email" 1819:5296, "email thuộc danh sách chặn" 1819:5430): chưa có BR/AC, không viết expected; cổng đóng Q-18 | N/A — Q-18 | UC-01 | — | A (placeholder, `❓`) |

## 8. Testcase Summary

| Nhóm | Số case | Positive | Negative | Edge case | Khác (UI / Security) | Có `❓ Cần chốt` |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| A. Theo requirement | 66 (gồm 2 placeholder Q-18) | 21 | 20 | 14 | 11 (UI 5 · Security 6) | 24 = 15 không trọng yếu + 7 Q-17 ([US6_30]→[US6_36]) + 2 Q-18 ([US6_79] [US6_80]) |
| B. QA bổ sung | 14 ([US6_62]→[US6_73], [US6_78], [US6_81]; [US6_61] đã chuyển lên nhóm A) | 0 | 0 | 14 | 0 | 2 ([US6_72] Q-16 · [US6_81] Q-10) |

Chi tiết case: `04-testcases.md`. Số đếm bằng script trên bảng case 2026-10-16 (80 dòng case).

## 9. Regression Scope

| Khu vực | Vì sao bị ảnh hưởng | Căn cứ | Giới hạn phân tích |
| --- | --- | --- | --- |
| Form đăng ký email cũ (web) và tài khoản tạo bằng form cũ | Form cũ bị thay bằng tab Email; tài khoản form cũ phải đăng nhập được và bị AC4 chặn đăng ký lại | `US6:15`, `EPIC:28`, `EPIC:194`, `EPIC:221` | [US6_10] [US6_60]; đường vào URL cũ chỉ ĐO & GHI ([US6_70]) |
| Màn đăng nhập (US3, màn 01) | Link "Đăng ký" là lối vào màn 11; tài khoản mới đăng nhập bằng email + mật khẩu | `US3:52-55` | [US6_01] [US6_48]; không kiểm lại US3 |
| Màn OTP dùng chung (US2, màn 12 / 06) | Màn 12 là cùng màn OTP với các luồng khác; bộ đếm gửi / sai tính chung mọi luồng | `EPIC:90`, `US2:36`, `US2:70` | Chỉ kiểm trong US6; "tính chung" với US4/US5 chưa đủ dữ liệu để loại trừ |
| Màn tạo mật khẩu dùng chung (US1 màn 05c, US4 màn 04) | Màn 13 "giống màn 05c"; quy định mật khẩu áp dụng chung | wireframe `US6:29`, `EPIC:112`, `EPIC:215` | Không kiểm lại US1/US4 trong bộ này |
| Đăng nhập / đăng ký Google (US9) | Nút Google trên màn 11; email Google trùng email đang đăng ký → AC4 | `US9:45-46`, `US9:60`, `EPIC:194` | Chỉ kiểm có nút và AC4; hành vi Google thuộc US9 |
| Thông tin tài khoản (US5) | Tài khoản mới: họ tên = email, email "Đã xác thực" không nút Đổi, SĐT "Chưa có" | `US5:66-67`, `US5:56` | [US6_40] [US6_41] [US6_52]; quy tắc sửa tên thuộc US5 |
| ChatGoni hạn mức (US7, US8) | Tài khoản mới chưa có SĐT → hạn mức thấp | `US7:50`, `US7:54`, `US7:61-65` | Dừng ở dấu hiệu; hết hạn mức, popup xác thực SĐT thuộc US7 |
| iOS | Email OTP / link trong email có thể mở trên iPhone | `BUG10:36` | [US6_04]; đường ngoài tài liệu ĐO & GHI ([US6_67]) |
| Mời thành viên vào workspace | Email được mời rồi đăng ký ở US6 | `US9:46`, `EPIC:136` | Chưa đủ dữ liệu — chờ Q-01 |
| Màn 11 tab "Số điện thoại" (US1) | Figma mục US1 có cặp frame chặn tương ứng ("Thiết bị yêu cầu quá hạn mức gửi số điện thoại", "Số điện thoại bị ghi nhận trong danh sách đen") — nếu BA bổ sung BR cho Q-18 thì áp cả hai tab | 01 §6d (tên frame) | Chưa đủ dữ liệu — chờ Q-18; không kiểm US1 trong bộ này |

## 10. Automation Candidate

| Case | Lý do phù hợp | Dependency · data · môi trường | Trạng thái |
| --- | --- | --- | --- |
| [US6_06] [US6_76] [US6_33]→[US6_37] | Validate thuần FE, dữ liệu cố định (bộ mẫu BA 02 §4 d.21), chạy mỗi build | Môi trường test; để tới màn 13 cần OTP test cố định hoặc mock dịch vụ email; [US6_33]→[US6_36] chờ Q-17 chốt quy định mới viết script | Candidate ([US6_33]→[US6_36] chờ Q-17) |
| [US6_10]→[US6_14] | AC4 với nhiều loại tài khoản, lặp lại ổn định | Tài khoản mẫu TK-CŨ, TK-G, TK-US5 có sẵn trên môi trường test; không cần OTP thật | Candidate |
| [US6_07] [US6_16] [US6_28] | Kiểm lớp BE qua API, không phụ thuộc UI | Tên API và mã lỗi (Q-12); email test; cách reset tài khoản sau chạy | Candidate (chờ Q-12) |
| [US6_46] [US6_48] | E2E tạo tài khoản + đăng nhập, giá trị regression cao | OTP test cố định hoặc đọc hộp thư test qua API; BE xóa được tài khoản sau chạy | Candidate |

## 11. Điểm cần quay lại Debate

| # | Nội dung + nguồn | Đề xuất mức | Case bị ảnh hưởng |
| ---: | --- | --- | --- |
| 1 | AC11 "lỗi hệ thống" (`US6:71`): tài liệu không nói lỗi nào; case giả lập BE trả 5xx qua proxy — cần Dev xác nhận cách giả lập chấp nhận được (US4 cũng có điểm này, Debate #4 của US4). | Không trọng yếu | [US6_56] |
| 2 | AC5 (`US6:62`) "không gửi được email": cách dựng lỗi gửi (BE tắt dịch vụ / email "đen") là đề xuất QA (02 §4 d.17 `[QA BỔ SUNG]`), chưa có Dev xác nhận — nếu không dựng được thì [US6_18] [US6_19] "không chạy được". Gộp vào Q-02 khi gửi BA/BE. | Không trọng yếu | [US6_18] [US6_19] |
| 3 | BR4 "không xác định được IP" (`US1:45`, 02 §4 d.4 (3)): chưa có cách dựng môi trường; nếu Dev không giả lập được thì [US6_45] ghi "không chạy được" kèm lý do. | Không trọng yếu | [US6_45] |
| 4 | AC10 "tạo workspace (nếu chưa có)" (`US6:69`): tài liệu không có tiêu chí quan sát "đã có workspace"; case dùng dấu hiệu QA đề xuất (tên workspace trên menu, 02 §4 d.19) — cần BA xác nhận dấu hiệu, gộp vào Q-05. | Không trọng yếu | [US6_46] [US6_47] [US6_49] |
| 5 | AC3 — quy định BA 02 §4 d.21 (2026-10-16) nói "không dấu tiếng Việt" chung, ví dụ sai chỉ có dấu trước `@` (`nguyễn@gmail.com`); dấu ở **tên miền** (`qa@côngty.vn`) QA xếp vào bộ sai của [US6_06] theo quy định chung — nếu hệ thống chấp nhận thì ghi nhận, hỏi lại BA. Ô Email **trống / toàn khoảng trắng** không có trong câu trả lời BA (nút tắt hay báo lỗi?) → nhóm B [US6_78]. Quy định này chưa được ghi vào US6 / Epic (02 §4 d.21 cột "Tài liệu đã cập nhật": chưa). | Không trọng yếu | [US6_06] [US6_78] |

| 6 | AC4 — nguyên văn popup đã có trên Figma (`FIGMA 1819:5176` "Email này đã được đăng ký. Bạn có muốn đăng nhập không?", nút "Hủy" / "Đăng nhập"); 02 Q-07 vẫn ghi AC4 "còn chờ". Expected [US6_10]→[US6_14] đã dùng câu Figma làm hình thức — đề xuất Orchestrator đóng Q-07 phần AC4 theo Figma (`US6:33`) hoặc giữ chờ BA xác nhận câu chữ. | Không trọng yếu | [US6_10]→[US6_14] |
| 7 | Màn 12 — Figma `1641:50362` khi đang đếm chỉ có "Chưa nhận được mã?" + đồng hồ "45s", không có nút "Gửi lại mã"; trạng thái sau 0 s (nút hiện ở đâu, tên gì) chưa có trên Figma (US2 frame `1754:5797` "yêu cầu gửi lại khi hết thời gian chờ" chưa đọc); `US2:59-60` nói "nút Gửi lại mã mờ, đếm ngược". Gộp vào Q-09 / US4 Q-28; case giữ theo US2. | Không trọng yếu | [US6_20] [US6_24] |
| 8 | Màn 13 — Figma `1641:50302` chỉ có lớp text: Badge (chữ chưa đọc — wireframe "Đã xác thực"), nút chính (chữ chưa đọc — wireframe "Đăng ký"), helper quy định mật khẩu không có lớp text ngoài ô (Q-17). Cần ảnh frame hoặc Design xác nhận chữ; case giữ theo `US6:66` / wireframe. | Không trọng yếu (phần helper thuộc Q-17 trọng yếu) | [US6_26] [US6_38] [US6_30]→[US6_37] |
| 9 | AC3 — Figma `1819:5526` vẽ trạng thái lỗi nhưng không nói lỗi hiện **lúc bấm nút** hay **lúc rời ô** (blur); `EPIC:206` chỉ nói "FE kiểm tại ô". Case ghi nhận thời điểm, không tính fail; hỏi Design / FE nếu cần tiêu chí. | Không trọng yếu | [US6_06] |
| 10 | Màn 11 — Figma `1641:50276` không có chữ "Bước 1/3" và khung "Báo lỗi ngay ở bước này" như wireframe; helper "Mã xác thực sẽ gửi **qua** email này" thay "tới email này."; Figma chỉ vẽ mobile, Web chưa có frame. Chỉ hình thức — ghi để CX / Design biết, không cần Q. | Không trọng yếu | [US6_01] |
| 11 | Phạm vi cổng đóng AC9 (Q-17): Designer đánh `❓ Q-17` cho [US6_30]→[US6_36] (quy định / biên / không đạt) theo hướng dẫn; **[US6_37]** (không khớp, `Gopany@123` đạt cả hai quy định) và [US6_28] (API, `gopanyyyyy` rớt cả hai) **không** đánh `❓` — nếu Hồng muốn đóng trọn AC9 thì đánh nốt [US6_37] (AC9 thành "Chưa phủ"). Cần Orchestrator / Hồng xác nhận. | Trọng yếu (thuộc Q-17 đã chốt) | [US6_37] [US6_28] |
| 12 | Q-18 — placeholder [US6_79] [US6_80] đặt ở **nhóm A** (Trace `N/A — Q-18`, không tính phủ) để BA thấy ngay cạnh AC3–AC5; nếu team muốn giữ nhóm A "chỉ case có nguồn" thì chuyển xuống nhóm B, giữ ID. | Không trọng yếu (hình thức file) | [US6_79] [US6_80] |

#6–#12 bổ sung 2026-10-16 sau khi đối chiếu Figma; không có điểm trọng yếu mới ngoài Q-17 / Q-18 Hồng đã chốt (02). #1–#5 giữ nguyên.

## Lịch sử cập nhật

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
| 2026-10-16 | AI (Test Designer) — người dùng: Hồng (QA) | Tạo file S6: UC-01, UC-02; BR1–BR5 + AC1–AC11 + E-xx; DT-1, DT-2; bảng trạng thái S0–S3; 8 rủi ro; Coverage Matrix 21 dòng; SC-01→SC-17; 60 case A + 13 case B; regression; automation candidate; 4 điểm quay lại Debate |
| 2026-10-16 | AI (Test Designer) — người dùng: Hồng (QA); căn cứ BA trả lời quy định định dạng email (02 §4 d.21) | §2 dòng AC3; DT-1 C1 + nguyên văn R1 "Email không đúng định dạng" + case R4 [US6_74]→[US6_77]; Coverage Matrix dòng AC3 (lớp FE đã phủ đủ, còn `một phần` do [US6_07] `❓` Q-12), dòng E-02, lỗ hổng; SC-03, SC-17; §8: A 64 (Positive 21, Edge 14), B 13 ([US6_61] chuyển lên, thêm [US6_78]); §10; §11 thêm #5 (tên miền có dấu, ô trống) |
| 2026-10-16 | AI (Test Designer) — người dùng: Hồng (QA); căn cứ Figma giao diện thật (01 §6d) và cổng đóng một phần (02 `closedScope` Q-17, Q-18) | Frontmatter + mở đầu: nguồn `FIGMA`, tên nút theo Figma ("Xác thực" thay "Xác nhận"), phạm vi cổng đóng; §2: BR1 (popup AC4), AC3, AC6 (Figma khác AC → Q-09), AC8 (Quay lại màn 13), **AC9 cổng đóng Q-17**, AC10 (màn 14, Q-19), E-09 chịu Q-17, thêm dòng nhánh chặn màn 11 (Q-18); §3 DT-1 hình thức / nguyên văn R1–R4 + ghi chú Q-18, DT-2 C2 chịu Q-17, case `❓`; §4 sự kiện Quay lại; §5 rủi ro #3, #4 (có dấu hiệu), #8 cập nhật, thêm #9 (Q-18), #10 (Q-19); §6 Coverage: AC3, BR1, AC4, AC6 ([US6_20] `❓`), AC8, BR2, AC9 (một phần — cổng đóng), AC10, BR3 ([US6_40] `❓`), thêm dòng Q-18 chưa phủ, lỗ hổng; §7 SC-06, SC-10, SC-13, SC-17, thêm SC-18; §8 A 66 / B 14, `❓` A 24 (15 + 7 Q-17 + 2 Q-18), B 2; §9 thêm màn 11 US1; §10; §11 thêm #6–#12 |
