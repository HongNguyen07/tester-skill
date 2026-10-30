---
featureId: EPIC-SDT-US6
basedOn: 02-alignment-summary.md (gate: open, 2026-10-16; cập nhật 2026-10-20 theo bản final 19/10/2026 — closedScope: Q-17 phần chữ hoa + chữ thường / 17–64 ký tự)
designedAt: 2026-10-16 (cập nhật 2026-10-20)
---

# Test Design — EPIC-SDT-US6: Đăng ký bằng email với xác thực OTP

Viết tắt tệp như `01-requirement-analysis.md` (`US6:NN` = dòng NN của tệp US6 **bản final 19/10/2026**; `EPIC`, `US1`, `US2`, `US3`, `US5`, `US7`, `US9`, `BUG10` cũng là bản final). Mã `E-xx` = quy tắc chung Epic/story liên quan, QA đánh ở file 01 mục 5b (E-01→E-25). `02 §4 d.N` = mục 4 dòng N của `02-alignment-summary.md` (dòng 28–46 trích bản final — căn cứ chính). Màn 11/12/13/14 theo bảng màn `US6:45-50`; màn 01 = Đăng nhập (`US3:47`). Nền tảng: Android, Web (`US6:5`); iOS chỉ AC2. Case không ghi nền tảng thì chạy trên Android và Web. `FIGMA <frame>` = Figma giao diện thật "Gopany v1.1" (đọc 2026-10-16; ảnh ở `figma/`) — chỉ là nguồn **hình** ở chỗ không lệch tài liệu; tài liệu ghi "Giao diện theo Figma final" (`US6:43`) nhưng mô tả màn bằng chữ — chỗ lệch (màn 12 "Đổi số" / thiếu Spam, màn 14 "số điện thoại", email không có nút "Sao chép", chữ lỗi mật khẩu) → **theo tài liệu**, Q-25.

Tên nút / nhãn theo tài liệu: màn 11 "Gửi mã xác thực", "Tiếp tục với Google", "Đã có tài khoản? Đăng nhập" (`US6:47`); màn 12 "Xác thực", link "Đổi email", "Gửi lại mã" (`US6:48`, `US2:49-50`); màn 13 ô "Nhập mật khẩu" / "Nhập lại mật khẩu", nút "Hiện", "Đăng ký", nút Back (`US6:49`); màn 14 "Bắt đầu sử dụng" (`US6:50`). Đối chiếu mã BR/AC cũ (bản 15/10) ↔ mới: `01` §12a (BR1 cũ → BR2; BR2 cũ → BR5 + BR3, BR4; BR3 cũ → BR6; BR4 cũ → BR8; BR5 cũ → BR7; AC3 cũ → AC4; AC4 → AC6; AC5 → AC7; AC6 → AC11; AC7 → AC13; AC8 → AC12; AC9 → AC15 + AC16; AC10 → AC17; AC11 → AC19). **`closedScope` (02, 2026-10-20):** chỉ các case mật khẩu không đủ chữ hoa + chữ thường hoặc dài 17–64 ký tự ([US6_36] [US6_91] [US6_92] `❓` Q-17, không pass/fail).

## 1. Use Case

| Mã | Tên | Actor | Nguồn |
| --- | --- | --- | --- |
| UC-01 (mã QA, giữ từ file 01) | Đăng ký bằng email (Android, Web): màn 01 "Chưa có tài khoản? Đăng ký" → 11 tab Email, nhập email, "Gửi mã xác thực" (nút mờ khi chưa nhập — AC3; đang tải khi bấm — AC9) → 12 nhập OTP, "Xác thực" → 13 email "Đã xác thực", "Nhập mật khẩu" + "Nhập lại mật khẩu", "Đăng ký" (nút mờ khi chưa đủ 2 ô — AC14; trong 10 phút — BR3) → tạo tài khoản **và đăng nhập luôn** → 14 "Đăng ký thành công" → "Bắt đầu sử dụng" → tạo workspace (nếu chưa có) → ChatGoni chat ngay ở hạn mức thấp. **AF:** AF-1 sai định dạng → "Email không đúng định dạng." (AC4) · AF-2 email đã có tài khoản → hộp thoại [Hủy] [Đăng nhập] (AC6) · AF-3 trong 60 giây về 11 gửi lại cùng email → vào thẳng 12 (AC10) · AF-4 "Đổi email" → về 11 giữ giá trị (US2 AC19); đổi quá 3 lần/ngày → lỗi tại ô (AC11a) · AF-5 lỗi OTP theo US2 (AC13) · AF-6 mật khẩu chưa đạt (AC15) / không khớp (AC16) → lỗi dưới ô, chưa tạo · AF-7 Back ở 13 → về 11 giữ email, xác thực cũ hết hiệu lực (AC18) · AF-8 "Tiếp tục với Google" → US9. **E:** E-1 không gửi được email → "Chưa gửi được mã xác thực. Vui lòng thử lại sau." (AC7) · E-2 vượt 5 mã / chặn ngầm / hệ thống bận → thông báo US2, ở lại 11 (AC8) · E-3 bấm Đăng ký khi (a) quá 10 phút (b) người khác vừa đăng ký cùng email — 30103 (c) mất mạng / lỗi hệ thống (d) đã bỏ ngang / tắt app → không tạo tài khoản (AC19) | Người dùng mới, chưa có tài khoản Gopany | `US6:19`, `US6:45-50`, `US6:56-65`, `US6:74-97`, `US3:69`, `EPIC:89-97` |
| UC-02 (mã QA, giữ từ file 01) | iOS: dùng app theo mọi đường (back, link trong trang, deep link, Google) → không vào được màn đăng ký | Người dùng app iOS | `US6:75`, `EPIC:97`, `US3:70`, `BUG10:28`, `BUG10:34-36`, `US9:78` |

Thứ tự kiểm ở bước 1 theo AC (`US6:77-87`): ô trống / khoảng trắng (AC3, FE) → định dạng (AC4, FE + BE) → cắt khoảng trắng, hoa/thường, alias `+` (AC5) → email đã có tài khoản (AC6, BE) → gửi email (lỗi → AC7; giới hạn / chặn ngầm → AC8) → màn 12 (AC11). Ảnh user flow mới (`US6:36`) chưa xem.

## 2. Business Rule

| Mã | Tóm tắt | Trạng thái hiểu | Nguồn |
| --- | --- | --- | --- |
| BR1 | Email hợp lệ: `ten@tenmien.duoi`, đúng 1 `@`, tên miền có `.`, đuôi ≥2 chữ cái, không khoảng trắng / dấu tiếng Việt, ≤254 ký tự; khoảng trắng đầu/cuối tự cắt; cho phép `. _ - +` trước `@`; alias `+` **là email khác** | `[NGUỒN]` (02 §4 d.28 — thay câu Hường `[ĐÃ XÁC NHẬN]` 2026-10-16); không còn điểm mở | `US6:56`, `EPIC:82` |
| BR2 | Chỉ email chưa gắn tài khoản nào (form cũ, Google, thêm ở US5, tạo ở US6); kiểm trùng không phân biệt hoa/thường | `[NGUỒN]`; email **được mời vào workspace** còn mở Q-01 (02 §4 d.15 `[GIẢ ĐỊNH]`); lớp BE qua API chờ Q-12 | `US6:57`, `EPIC:80`, `US9:57` |
| BR3 | Đúng OTP → **10 phút** để tạo mật khẩu; kết quả xác thực dùng 1 lần, gắn phiên; quá 10 phút / bỏ ngang / Back → nhận mã mới (tính vào 5 mã/24 giờ) | `[NGUỒN]` (02 §4 d.29 — đóng Q-03, thay `[GIẢ ĐỊNH]` "không giới hạn"); Back trong 60 giây ↔ AC10 còn mở Q-24 | `US6:58`, `EPIC:92` |
| BR4 | Mật khẩu 8–16 ký tự, có chữ, có số, có ký tự đặc biệt, không khoảng trắng, không dấu tiếng Việt; ô "Nhập lại mật khẩu" phải khớp | `[NGUỒN]` phần đã ghi (02 §4 d.30) · **`[CẦN XÁC NHẬN]` chữ hoa + chữ thường, nới tối đa 64** (Q-17 thu hẹp, `US6:112`, Chiến) → `closedScope`; cả hai ô cùng sai → nhóm B (Q-10) | `US6:59`, `EPIC:101`, `EPIC:161` |
| BR5 | Chỉ tạo tài khoản khi đã xác thực OTP + mật khẩu hợp lệ + 2 ô khớp; không tạo tài khoản dở dang | `[NGUỒN]`; lớp BE qua API chờ Q-12; response rớt sau khi BE tạo chờ Q-13 | `US6:60`, `EPIC:93` |
| BR6 | Không họ tên / SĐT; tên tự tạo = email đăng ký đầy đủ (email đã qua OTP), sửa ở US5; đăng ký xong **đăng nhập luôn** (API trả token) | `[NGUỒN]` (02 §4 d.2, d.3, d.31 — đóng phần thời điểm tạo tài khoản của Q-05); mở lại app sau khi thoát ở màn 14 còn mở Q-05; dạng lưu hoa/thường Q-08; Hiện liên động `[DIỄN GIẢI AI]` → nhóm B | `US6:61`, `EPIC:87`, `EPIC:94`, `US5:61` |
| BR7 | Tài khoản email mới chưa có SĐT → ChatGoni hạn mức thấp, không dùng Pro tới khi thêm SĐT; US6 dừng ở dấu hiệu | `[NGUỒN]` (02 §4 d.6); % sau một câu `[DIỄN GIẢI AI]` → nhóm B | `US6:62`, `US7:60`, `US7:76-79` |
| BR8 | Không giới hạn IP; Epic tạm hoãn kiểm tra IP VN → màn 11 ngoài VN **vẫn hai tab** | `[NGUỒN]` (02 §4 d.44 — thay d.4 "chỉ còn Email"; đóng Q-14 phần tab); đổi IP giữa chừng `[DIỄN GIẢI AI]` → nhóm B | `US6:63`, `EPIC:96`, `EPIC:134`, `US1:31` |
| BR9 | Hai phiên cùng email: không chặn; phiên tạo trước thành công, phiên sau hộp thoại đã đăng ký, mã 30103 | `[NGUỒN]` (02 §4 d.32 — đóng Q-06); Hủy / Đăng nhập trên hộp thoại ở màn 13 về đâu: không nói → ghi nhận | `US6:64`, `US6:97`, `EPIC:95` |
| BR10 | Kiểm tra 2 lớp: FE định dạng tại ô; BE kiểm lại toàn bộ + nghiệp vụ, trả mã lỗi | `[NGUỒN]`; mã lỗi chỉ có 30103 (US6), 30115 / 30114 (US2); tên API chưa có → Q-12 | `US6:65`, `EPIC:128` |
| AC1–AC19 + AC11a | Nguyên văn `01` §6a; thông báo / con số `01` §6b | `[NGUỒN]`; còn mở: AC6/AC17 email được mời (Q-01) · AC7 tính lượt (Q-02) · AC19 F5 / ra nền ở 13 (Q-04) · AC17 mở lại app (Q-05) · AC8 "hệ thống bận" + ngưỡng chặn ngầm (Q-23) · AC10 email khác, AC10 ↔ AC18 (Q-24) · AC11a cách đếm (Q-22) · AC15 chữ hoa / 64 (Q-17) · lệch Figma (Q-25) | `US6:74-97` |
| E-01→E-25 | Quy tắc chung Epic / US2 / US3 / US5 / US7 / US9 áp vào US6 | `[NGUỒN]`; E-09 `[CẦN XÁC NHẬN]` chữ hoa / 64 (Q-17); E-10 con số đã chốt; E-20 nay là quy tắc (= BR9); E-22 thông báo dùng chung; E-24 US2 AC19–AC21; E-25 nguyên văn AC11/AC12/AC14–AC17 của US2 | file 01 mục 5b |

## 3. Decision Table

### DT-1 — Màn 11: kết quả sau khi bấm "Gửi mã xác thực" (AC3–AC11a, BR1, BR2)

Thứ tự điều kiện theo thứ tự AC (`US6:77-87`); R0 là trạng thái nút trước khi bấm.

| Điều kiện / Hành động | R0 | R1 | R2 | R3 | R4 | R5 | R6 | R7 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| C0: Ô Email trống / chỉ khoảng trắng (AC3) | Có | Không | Không | Không | Không | Không | Không | Không |
| C1: Email đúng định dạng BR1 (sau khi cắt khoảng trắng đầu/cuối) | — | Không | Có | Có | Có | Có | Có | Có |
| C2: Email đã gắn tài khoản (không phân biệt hoa/thường; alias `+` là email khác) | — | — | Có | Không | Không | Không | Không | Không |
| C3: Đang trong 60 giây chờ của **cùng email** (đã gửi mã, quay lại 11) | — | — | — | Có | Không | Không | Không | Không |
| C4: Email đã nhận 5 mã/24 giờ, hoặc thiết bị/IP bị chặn ngầm, hoặc đổi email quá 3 lần/ngày | — | — | — | — | Có | Không | Không | Không |
| C5: Dịch vụ gửi email thành công | — | — | — | — | — | Không | Có | Có |
| C6: Bấm nhiều lần liên tiếp (AC9) | — | — | — | — | — | — | Có | Không |
| → Màn hình | Ở 11, nút mờ | Ở 11 | Ở 11 | **Vào thẳng 12**, đếm ngược còn lại | Ở 11 | Ở 11 | Sang 12 (một lần) | Sang 12 |
| → Kết quả (nguồn) | Không thông báo, không request (`US6:77`) | "Email không đúng định dạng." dưới ô, ô tô đỏ; không gửi mã (`US6:78`) | Không gửi OTP; hộp thoại [Hủy] [Đăng nhập] "Email này đã được đăng ký. Bạn có muốn đăng nhập không?"; Đăng nhập → 01 điền sẵn; Hủy → đóng (`US6:80`) | Không gửi mã mới, không báo lỗi (`US6:84`) | 5 mã: "Bạn đã nhận quá số mã cho phép. Vui lòng thử lại sau HH:MM ngày DD/MM." (`US2:86`) · chặn ngầm: "Bạn đã gửi quá nhiều yêu cầu. Vui lòng thử lại sau." 30115/30114 (`US2:87`) · đổi email >3 lần: cùng câu tại ô (`US6:85`) | "Chưa gửi được mã xác thực. Vui lòng thử lại sau." (`US6:81`) | Nút đang tải và mờ, chỉ 1 yêu cầu (`US6:83`) | OTP mẫu 23; màn 12 (`US6:87`) |
| Case | [US6_78] | [US6_06] [US6_07] | [US6_10]→[US6_14] [US6_72] [US6_16] | [US6_62] | [US6_83] [US6_25] · ❓ [US6_79] (Q-23) [US6_86] (Q-22) | [US6_18] [US6_19] | [US6_84] | [US6_08] [US6_09] [US6_20] [US6_21] [US6_74] [US6_75] [US6_77] [US6_82]; [US6_76] chỉ tới C1 |

Không đưa vào bảng vì kết quả chưa chốt: email **được mời** (Q-01, [US6_15] `❓`); lần gửi lỗi có tính lượt / cooldown (Q-02, [US6_19] bước 2, 4); email **khác** trong 60 giây (Q-24, [US6_85] `❓`); "hệ thống bận" trong AC8 chưa có câu riêng (Q-23, chưa có case); thứ tự C4 so với C3 khi vừa chạm 5 mã vừa còn đếm ngược: tài liệu không nói. Hai nhánh chặn trên Figma (1819:5296, 1819:5430): danh sách chặn **ngoài phạm vi** `US6:32`; giới hạn thiết bị = C4 chặn ngầm (Q-18 đóng).

### DT-2 — Màn 13: kết quả sau khi bấm "Đăng ký" (BR3, BR4, BR5, BR9, AC14–AC19)

| Điều kiện / Hành động | R0 | R1 | R2 | R3 | R4 | R5 | R6 | R7 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| C0: Đã nhập đủ 2 ô (AC14) | Không | Có | Có | Có | Có | Có | Có | Có |
| C1: Kết quả xác thực OTP còn hiệu lực (BE: đã xác thực, ≤10 phút, chưa dùng, chưa Back) | — | Không (gọi API bỏ qua FE) | Không (quá 10 phút) | Có | Có | Có | Có | Có |
| C2: "Nhập mật khẩu" đạt BR4 (8–16, chữ, số, đặc biệt, không khoảng trắng / dấu TV) | — | — | — | Không | Có | Có | Có | Có |
| C3: "Nhập lại mật khẩu" khớp | — | — | — | — | Không | Có | Có | Có |
| C4: Email vừa bị phiên khác đăng ký xong (BR9) | — | — | — | — | — | Có | Không | Không |
| C5: Mạng / BE lỗi khi gửi request | — | — | — | — | — | — | Có | Không |
| → Kết quả (nguồn) | Nút "Đăng ký" mờ, không thông báo (`US6:91`) | BE từ chối, không tạo tài khoản (`US6:60`, `US6:65`) | "Phiên xác thực đã hết hạn. Vui lòng nhận mã mới." → về 11 giữ email (`US6:97` a) | Dòng quy định đỏ, ô tô đỏ: "Mật khẩu phải có từ 8–16 ký tự, gồm chữ, số và ký tự đặc biệt, không có khoảng trắng hoặc dấu tiếng Việt."; chưa tạo (`US6:92`) | Dưới ô Nhập lại, ô tô đỏ: "Mật khẩu xác nhận không khớp. Vui lòng nhập lại."; chưa tạo (`US6:93`) | Hộp thoại [Hủy] [Đăng nhập] "Email này đã được đăng ký…", 30103, không tạo (`US6:97` b) | "Không có kết nối mạng. Vui lòng kiểm tra và thử lại." / "Đã xảy ra lỗi. Vui lòng thử lại sau."; ở lại 13, cho bấm lại; không tạo (`US6:97` c, `EPIC:125-126`) | Nút đang tải; tạo tài khoản + đăng nhập luôn → màn 14 (`US6:94`) |
| Case | [US6_64] | [US6_28] `❓` Q-12 | [US6_29] | [US6_32]→[US6_35] [US6_90] · ❓ Q-17 [US6_36] [US6_91] [US6_92] | [US6_37] | [US6_17] | [US6_55] [US6_56] · ❓ [US6_59] (Q-13) | [US6_30] [US6_31] [US6_46] [US6_47] [US6_88] [US6_93] |

Không đưa vào bảng: cả hai ô cùng sai (Q-10) → nhóm B [US6_65]; ô toàn khoảng trắng → C2 Không ([US6_32] bước 4); nút mờ hay bật với toàn khoảng trắng: tài liệu không nói, ghi nhận; mật khẩu trùng email → nhóm B [US6_69].

## 4. State Transition

Nguồn không định nghĩa máy trạng thái; bảng dựng từ `US6:58`, `US6:60-61`, `US6:84`, `US6:94-97`, `US2:59-60`, `US2:97-98` (`[NGUỒN]`) — ô ghi Q-nn là chỗ tài liệu không nói.

| Trạng thái phiên \ Sự kiện | "Gửi mã xác thực" hợp lệ | Đúng OTP + "Xác thực" | "Đăng ký" hợp lệ | "Đổi email" / Back | App ra nền → quay lại / web F5 | Tắt hẳn app / đóng tab | Hết thời gian |
| --- | --- | --- | --- | --- | --- | --- | --- |
| S0 Màn 11 — chưa gửi mã | → S1 (màn 12), mã đã gửi, đếm ngược 60 giây theo email (`US6:87`, `US2:60`) | — | — | Back ở 11 về đâu: không nói | Không nói | Không nói | — |
| S1 Màn 12 — mã đã gửi, **đang đếm ngược 60 giây** | Cùng email → **vào thẳng 12, đếm ngược còn lại, không mã mới** (`US6:84`); email khác: Q-24 | → S3 (`US6:88`) | — | → S0' màn 11 **giữ sẵn email** (`US2:97`); đếm ngược vẫn chạy theo email | Giữ màn 12, đếm theo mốc BE (`US2:98`); web F5: Q-04 | Mở lại app → màn 11 (`US6:97` d) | Hết 60 giây → S2 |
| S2 Màn 12 — hết đếm ngược, mã còn hạn (≤5 phút) | "Gửi lại mã" → mã mới, mã cũ hết hiệu lực, xóa 6 ô, đếm lại (`US2:84`); mã thứ 6/24 giờ → AC11 US2 | → S3 | — | → S0' giữ email; gửi lại → mã mới | Như S1 | Như S1 | Quá 5 phút → nhập mã báo hết hạn, tính 1 lần sai (`US2:92`); sai 5 lần → khóa 30 phút (`US2:94`) |
| S3 Màn 13 — **xác thực còn hiệu lực (10 phút, dùng 1 lần)**, tài khoản chưa tồn tại | — | — | → S4: tạo tài khoản, **đã đăng nhập**, email "Đã xác thực", SĐT "Chưa có" (`US6:94`, `EPIC:83`) | Back → S0' màn 11 giữ email, **xác thực hết hiệu lực**, phải gửi OTP mới (`US6:95`); trong 60 giây: Q-24 | Q-04 (ra nền / F5 ở 13); chắc chắn chưa tạo tài khoản | Mở lại app → màn 11 (`US6:97` d); xác thực hết hiệu lực (`US6:58`) | Quá 10 phút → bấm Đăng ký: "Phiên xác thực đã hết hạn…" → S0' giữ email (`US6:97` a) |
| S4 Màn 14 — tài khoản đã tồn tại, đã đăng nhập | — | — | — | — | — | Q-05 (còn phiên đăng nhập không); đăng nhập lại → tạo workspace (`US3:75`) | — |
| S5 ChatGoni — sau "Bắt đầu sử dụng", workspace đã tạo (nếu chưa có) | — | — | — | — | — | — | — |

Case: [US6_62] [US6_85] [US6_94] (S1) · [US6_24] [US6_25] [US6_23] [US6_87] (S2) · [US6_27] [US6_29] [US6_81] [US6_88] [US6_89] [US6_57] [US6_58] (S3) · [US6_49] [US6_93] (S4).

## 5. Risk Analysis `[QA BỔ SUNG]`

| # | Rủi ro | Impact | Likelihood | Căn cứ | Liên quan BR / Q |
| ---: | --- | --- | --- | --- | --- |
| 1 | Tạo được tài khoản thứ hai cho cùng email (khác hoa/thường, hai phiên song song, gọi API bỏ qua FE) | Cao (dữ liệu, đăng nhập) | Chưa có dữ liệu | `EPIC:80`, `US6:57`, `US6:64` (BE khóa khi tạo + ràng buộc duy nhất); API chưa có (Q-12) | BR2, BR9, BR10, Q-12 |
| 2 | Tài khoản tạo dở (BE tạo xong nhưng FE báo lỗi; hoặc tạo khi chưa xác thực / quá 10 phút) | Cao (email bị "chiếm", không đăng nhập được) | Chưa có dữ liệu | `US6:97` "không có tài khoản dở dang" nhưng Q-13 chưa trả lời; mốc 10 phút mới thêm 19/10 | BR3, BR5, AC19, Q-13 |
| 3 | Alias `+` bị coi là cùng email (hoặc ngược lại chuẩn hóa sai) → chặn nhầm / tạo nhầm | Trung bình | Chưa có dữ liệu | Quy tắc mới 19/10 (`US6:56`, `EPIC:82`); nhiều hệ thống mặc định bỏ phần sau `+` | BR1, BR2 |
| 4 | Quy định mật khẩu FE ≠ BE, hoặc ≠ US1/US4 (cùng bước tạo mật khẩu); chữ hoa / 64 ký tự chưa chốt | Trung bình | **Có dấu hiệu** — `TB2` / Figma US4 ghi "chữ hoa, chữ thường…", tài liệu ghi "chữ"; câu hỏi mở #1 `US6:112` | BR4, AC15, E-09, Q-17, Q-25 |
| 5 | AC10 ↔ AC18 xung đột trong 60 giây (Back từ 13 rồi gửi lại cùng email) → Dev chọn một đằng, QA không có tiêu chí | Trung bình | Chưa có dữ liệu | `US6:84` và `US6:95` không nói tới nhau; Q-24 | BR3, AC10, AC18, Q-24 |
| 6 | AC11a không rõ cách đếm → chặn nhầm người dùng gõ sai email vài lần, hoặc không chặn được spam | Trung bình | Chưa có dữ liệu | `US6:85` thêm 19/10 không ghi người quyết định (`US6:119`); Q-22 | AC11a, Q-22 |
| 7 | Email OTP chậm / vào Spam → gửi lại nhiều, chạm 5 mã/24 giờ | Trung bình (bỏ dở đăng ký) | Chưa có dữ liệu | Câu hỏi mở #2 `US6:113`; dòng Spam ở màn 12 có trong tài liệu nhưng Figma không vẽ (Q-25) | AC11, AC13, Q-25 |
| 8 | iOS lộ đường vào đăng ký (Apple reject) qua link trong email OTP / deep link | Cao (release) | Đã từng xảy ra (`BUG10:7`) | Lịch sử defect BUG10; US6 gửi email tới người dùng | AC2, E-08 |
| 9 | Tài khoản mới vào ChatGoni không ở hạn mức thấp / dùng được Pro | Trung bình (chi phí) | Chưa có dữ liệu | `US7:60`, `US7:63`; con số Admin chỉnh được | BR7, E-11 |
| 10 | "Đăng nhập luôn" sau đăng ký phụ thuộc giải pháp Keycloak (BE1) chưa chốt → màn 14 bấm tiếp lại về màn đăng nhập | Cao (luồng chính) | **Có dấu hiệu** — `US6:102` Dependencies BE1; `EPIC:160` câu hỏi mở #1 quá hạn | BR6, AC17 |
| 11 | Dev làm theo Figma ở chỗ lệch tài liệu (màn 12 "Đổi số", không Spam; màn 14 "số điện thoại"; email không "Sao chép") | Thấp (hiển thị) | **Có dấu hiệu** — 5 chỗ lệch đã đối chiếu (01 §13 #21) | AC11, AC17, Q-25 |

## 6. Coverage Matrix

Chỉ tính case nhóm A. `❓` = case đang `❓ Cần chốt`, không tính là đã phủ. Đếm bằng script trên `04-testcases.md` ngày 2026-10-20 (83 case A, 16 `❓`).

| BR / AC | Use Case | Decision / State | Scenario | Case nhóm A | Trạng thái | Ghi chú |
| --- | --- | --- | --- | --- | --- | --- |
| BR1 | UC-01 | DT-1 C1 | SC-03 | [US6_06] [US6_08] [US6_74] [US6_75] [US6_76] [US6_77] [US6_82] | Đã phủ | Bộ sai AC4 + 255 ký tự + dấu ở tên miền; bộ hợp lệ hoa/subdomain, `+`, `_`/`-`/`.com.vn`, 254, khoảng trắng hai đầu; alias `+` hai tài khoản. Lớp BE → BR10 |
| BR2 | UC-01 | DT-1 C2 | SC-04 | [US6_09]→[US6_14] [US6_72] · ❓ [US6_15] (Q-01) | Phủ một phần | Email được mời chờ Q-01; lớp BE [US6_16] → BR10 |
| BR3 | UC-01 | DT-2 C1; ST S3 | SC-09 | [US6_29] [US6_81] [US6_88] [US6_89] · ❓ [US6_94] (Q-24) | Phủ một phần | 10 phút (trong / quá), Back, dùng 1 lần đã phủ; Back trong 60 giây ↔ AC10 chờ Q-24 |
| BR4 | UC-01 | DT-2 C2–C3 | SC-10 | [US6_30] [US6_31] [US6_32] [US6_33] [US6_34] [US6_35] [US6_37] [US6_64] [US6_90] · ❓ Q-17 [US6_36] [US6_91] [US6_92] | Phủ một phần | Biên 7/8/16, thiếu số / đặc biệt, khoảng trắng, dấu TV, không khớp, nút mờ đã phủ; chữ hoa + thường và 17 ký tự `closedScope` (Q-17); hai ô cùng sai → nhóm B [US6_65] |
| BR5 | UC-01 | DT-2; ST S3→S4 | SC-08, SC-13 | [US6_27] [US6_46] [US6_47] [US6_48] | Đã phủ | Lớp BE [US6_28] → BR10; response rớt [US6_59] → AC19 |
| BR6 | UC-01 | ST S4 | SC-11 | [US6_38] [US6_39] [US6_40] [US6_41] [US6_42] [US6_93] · ❓ [US6_43] (Q-08) [US6_49] (Q-05) | Phủ một phần | Không họ tên / SĐT, tên = email đã qua OTP, đăng nhập luôn đã phủ; dạng lưu hoa/thường Q-08; mở lại app sau khi thoát ở 14 Q-05; Hiện liên động → nhóm B [US6_63] |
| BR7 | UC-01 | — | SC-14 | [US6_50] [US6_51] [US6_52] | Đã phủ | Dừng ở dấu hiệu (02 §4 d.6); % → nhóm B [US6_73] |
| BR8 | UC-01 | — | SC-12 | [US6_44] [US6_45] | Đã phủ | Màn 11 ngoài VN vẫn hai tab; đổi IP giữa chừng → nhóm B [US6_66] |
| BR9 | UC-01 | DT-2 C4 | SC-04 | [US6_17] | Đã phủ | Có mã 30103; Hủy / Đăng nhập trên hộp thoại ở màn 13 về đâu: ghi nhận |
| BR10 | UC-01 | DT-1 C1, DT-2 C1 | SC-03, SC-09 | Lớp FE: [US6_06] [US6_32]→[US6_35] [US6_90] (FE tại ô) · lớp BE: ❓ [US6_07] [US6_16] [US6_28] (Q-12) | Phủ một phần | Lớp BE chỉ chạy được khi có tên API / mã lỗi (Q-12) |
| AC1 | UC-01 | — | SC-01 | [US6_01] [US6_02] | Đã phủ | URL form cũ → nhóm B [US6_70]; đích link Điều khoản → nhóm B [US6_71] |
| AC2 / E-08 | UC-02 | — | SC-02 | [US6_03] [US6_04] [US6_05] | Đã phủ | Năm đường theo tài liệu (02 §4 d.8); ba đường ngoài tài liệu → nhóm B [US6_67] |
| AC3 | UC-01 | DT-1 R0 | SC-03 | [US6_78] | Đã phủ | Chuyển từ nhóm B (AC mới 16/10) |
| AC4 | UC-01 | DT-1 R1 | SC-03 | [US6_06] · ❓ [US6_07] (Q-12) | Phủ một phần | Lớp FE đủ; lớp BE chờ API |
| AC5 | UC-01 | DT-1 C1–C2 | SC-03, SC-04 | [US6_08] [US6_14] [US6_74] [US6_77] [US6_82] | Đã phủ | Cắt khoảng trắng, hoa/thường khi kiểm trùng, alias `+` hợp lệ và là email khác |
| AC6 | UC-01 | DT-1 R2 | SC-04 | [US6_10] [US6_11] [US6_12] [US6_13] [US6_14] [US6_72] · ❓ [US6_15] (Q-01) [US6_16] (Q-12) | Phủ một phần | Nguyên văn hộp thoại + đích hai nút đã phủ (Q-16 đóng); email được mời Q-01 |
| AC7 | UC-01 | DT-1 R5 | SC-05 | [US6_18] · ❓ [US6_19] (Q-02) | Phủ một phần | Nguyên văn + ở lại 11 đã phủ; tính lượt / cooldown của lần lỗi Q-02; cách dựng lỗi cần Dev (§11 #2) |
| AC8 / E-25 | UC-01 | DT-1 R4 | SC-05 | [US6_83] · ❓ [US6_79] (Q-23) | Phủ một phần | Vượt 5 mã ở màn 11 đã phủ; chặn ngầm chờ ngưỡng (Q-23); **"hệ thống bận" chưa có case** — không có câu riêng (Q-23) |
| AC9 | UC-01 | DT-1 R6 | SC-03 | [US6_84] | Đã phủ | Chứng minh bằng Network + hộp thư (`[QA BỔ SUNG]` cách chứng minh) |
| AC10 / E-24 | UC-01 | DT-1 R3; ST S1 | SC-06 | [US6_62] · ❓ [US6_85] (Q-24) | Phủ một phần | Cùng email đã phủ (Đổi email và Back); email khác Q-24; Back từ 13 trong 60 giây → BR3 [US6_94] |
| AC11a | UC-01 | DT-1 R4 | SC-06 | ❓ [US6_86] (Q-22) | **Chưa phủ** | Nguyên văn có; cách đếm / mốc ngày / điểm chặn chưa có → chỉ case `❓` |
| AC11 / E-15 / E-16 | UC-01 | DT-1 R7; ST S0→S1 | SC-04, SC-06 | [US6_09] [US6_20] [US6_21] [US6_42] | Đã phủ | Màn 12 và email mẫu 23 theo tài liệu; Figma lệch → Q-25 ghi nhận; thời gian đến / Spam → nhóm B [US6_68] |
| AC12 | UC-01 | ST S1→S3 | SC-08 | [US6_26] | Đã phủ | Màn 13 theo `US6:49` |
| AC13 / E-10 / E-25 | UC-01 | ST S2 | SC-07 | [US6_22] [US6_23] [US6_24] [US6_25] [US6_87] | Đã phủ | Sai mã, hết hạn, gửi lại + mã cũ, mã thứ 6, sai 5 lần khóa 30 phút — nguyên văn US2 bản final; chi tiết nhập ô (US2 AC4) thuộc US2 |
| AC14 | UC-01 | DT-2 R0 | SC-10 | [US6_64] | Đã phủ | Chuyển từ nhóm B |
| AC15 / E-09 | UC-01 | DT-2 R3 | SC-10 | [US6_32] [US6_33] [US6_34] [US6_35] [US6_90] · ❓ Q-17 [US6_36] [US6_91] [US6_92] | Phủ một phần | Nguyên văn lỗi theo `US6:92` (khác `TB2` — theo tài liệu); phần `closedScope` không pass/fail |
| AC16 | UC-01 | DT-2 R4 | SC-10 | [US6_37] | Đã phủ | Nguyên văn đầy đủ (Q-20 đóng) |
| AC17 | UC-01 | DT-2 R7; ST S3→S4→S5 | SC-11, SC-13, SC-14 | [US6_30] [US6_31] [US6_40] [US6_46] [US6_47] [US6_48] [US6_88] [US6_93] · ❓ [US6_49] (Q-05) [US6_15] (Q-01) | Phủ một phần | Màn 14 nguyên văn, đăng nhập luôn, workspace → ChatGoni đã phủ; mở lại app sau khi thoát ở 14 Q-05; "đã có workspace" quan sát qua dấu hiệu QA (§11 #4) |
| AC18 | UC-01 | ST S3 Back | SC-09 | [US6_81] [US6_89] · ❓ [US6_94] (Q-24) | Phủ một phần | Nút trên màn + back hệ thống, giữ email, không hỏi, phải gửi OTP mới, mã cũ không dùng lại; trong 60 giây Q-24 |
| AC19 / E-22 | UC-01 | DT-2 R2, R5, R6; ST S3 | SC-15 | (a) [US6_29] · (b) [US6_17] · (c) [US6_55] [US6_56] · (d) [US6_58] · ❓ [US6_57] (Q-04) [US6_59] (Q-13) | Phủ một phần | Bốn nhánh (a)–(d) đều có case không `❓`; web F5 / ra nền ở 13 Q-04; response rớt Q-13; mất mạng ở màn 11, 12 [US6_53] [US6_54] theo thông báo dùng chung Epic |
| E-01, E-02, E-03 | UC-01 | DT-1 C2 | SC-04, SC-14 | [US6_10] [US6_13] [US6_14] [US6_08] [US6_12] [US6_52] | Đã phủ | — |
| E-04, E-05 | UC-01 | — | SC-11 | [US6_38] [US6_39] [US6_40] | Đã phủ | — |
| E-06 | UC-01 | ST S3 | SC-08, SC-15 | [US6_27] [US6_58] | Đã phủ | — |
| E-07 | UC-01 | — | SC-12 | [US6_44] [US6_45] | Đã phủ | — |
| E-11, E-12 | UC-01 | ST S5 | SC-14 | [US6_46] [US6_50] | Đã phủ | — |
| E-13 | UC-01 | DT-1 R0, R6; DT-2 R0 | SC-03, SC-10 | [US6_78] [US6_84] [US6_64] [US6_06] | Đã phủ | Quy ước chung `EPIC:128` |
| E-14, E-15, E-16 | UC-01 | — | SC-06 | [US6_20] [US6_21] | Đã phủ | — |
| E-17, E-18 | UC-01 | DT-1 R2 | SC-01, SC-04 | [US6_02] [US6_11] | Đã phủ | Hành vi nút Google thuộc US9 |
| E-19 | UC-01 | — | SC-14 | [US6_52] | Đã phủ | — |
| E-20 | UC-01 | DT-2 C4 | SC-04 | [US6_17] | Đã phủ | Nay là quy tắc (= BR9) — thay "chưa phủ" bản cũ |
| E-21 | UC-01 | — | SC-13, SC-16 | [US6_47] [US6_60] | Đã phủ | — |
| E-22 | UC-01 | DT-2 R6 | SC-15 | [US6_53] [US6_54] [US6_55] [US6_56] | Đã phủ | — |
| E-23 | UC-01 | ST S4 | SC-13 | [US6_48] · ❓ [US6_49] (Q-05) | Phủ một phần | Đăng nhập lại chưa có workspace → tạo workspace chỉ kiểm được ở [US6_49] |
| E-24 | UC-01 | ST S1 | SC-06, SC-15 | [US6_62] [US6_42] [US6_57] bước 1 · ❓ [US6_85] (Q-24) | Phủ một phần | — |
| E-25 | UC-01 | DT-1 R4; ST S2 | SC-05, SC-07 | [US6_83] [US6_25] [US6_22] [US6_23] [US6_87] · ❓ [US6_79] (Q-23) | Phủ một phần | — |

Tổng: BR1–BR10 — đã phủ 5 (BR1, BR5, BR7, BR8, BR9), một phần 5 (BR2, BR3, BR4, BR6, BR10), chưa phủ 0. AC1–AC19 + AC11a (20 dòng) — đã phủ 10, một phần 9, **chưa phủ 1 (AC11a)**. E-01→E-25 — đã phủ 21, một phần 4 (E-09 trong AC15, E-23, E-24, E-25), chưa phủ 0.

Lỗ hổng:

- Requirement không có case không `❓`: **AC11a** (Q-22); phần chữ hoa / 17–64 ký tự của BR4/AC15 (Q-17, `closedScope`); phần "hệ thống bận" của AC8 (Q-23 — không có câu riêng, chưa viết case); phần email khác / Back trong 60 giây của AC10 ↔ AC18 (Q-24); lớp BE của BR10 (Q-12). Còn lại mọi BR/AC đều có ≥ 1 case nhóm A không `❓`.
- Case không có nguồn: không có ở nhóm A. Mọi nguyên văn lấy từ `US6:74-97`, `US2:75-98`, `EPIC:125-126`. Phần tài liệu không nói nhưng case cần ghi nhận (không làm tiêu chí): email còn trong ô sau "Hủy" ([US6_72]); nút "Đăng ký" mờ hay bật với toàn khoảng trắng ([US6_32]); ô Email điền sẵn khi mở lại app ([US6_58]); đích Hủy / Đăng nhập trên hộp thoại ở màn 13 ([US6_17]); thời điểm hiện lỗi FE (rời ô hay bấm nút, [US6_06]); nút vẫn bật khi lỗi định dạng (Figma, [US6_06]).
- Coverage chưa rõ: cột Error Code trống vì chỉ có 3 mã (Q-12); "đã có workspace" chỉ quan sát qua dấu hiệu QA (02 §4 d.19); ảnh user flow mới `US6:36` chưa xem — nhãn AC/BR trên sơ đồ "khớp với mục 6 và 7" theo `US6:39`, chưa đối chiếu; Figma chưa đọc lại sau 16/10 (Q-25); "Hệ thống bận" (AC8) không có nguyên văn.

Loại coverage đã cân nhắc và không áp dụng: Performance — nguồn không có SLA (câu hỏi mở #2 `US6:113` chỉ nói "giảm vào Spam"; nhóm B [US6_68] đo) · AI-specific — ChatGoni chỉ kiểm tới dấu hiệu hạn mức · Accessibility — nguồn không có yêu cầu · Concurrency — có BR9, đã phủ [US6_17].

## 7. Test Scenario

| SC | Mô tả | BR / AC | Use Case | Loại coverage | Nhóm |
| --- | --- | --- | --- | --- | --- |
| SC-01 | Màn 11 trên Android / Web theo bảng màn `US6:47`: tab Email thay form cũ, nút Google | AC1, E-18 | UC-01 | UI | A |
| SC-02 | iOS không có đường vào đăng ký: màn đăng nhập, Quên mật khẩu → Back, màn khác, deep link / URL, Google với email chưa có tài khoản | AC2, E-08 | UC-02 | Security · Compatibility | A |
| SC-03 | Bước 1 — ô trống / khoảng trắng (nút mờ); định dạng BR1 tại ô (bộ sai AC4 + 255 + dấu tên miền; bộ hợp lệ) và BE kiểm lại qua API; bấm nhiều lần 1 request | AC3, AC4, AC5, AC9, BR1, BR10, E-13 | UC-01 | Negative · Positive · Boundary · Security | A |
| SC-04 | Email chưa có tài khoản → OTP; email đã có tài khoản (form cũ, Google, US5, US6, khác hoa/thường) → hộp thoại AC6 + đích hai nút; alias `+` hai tài khoản; email được mời; hai phiên song song (BR9, 30103); BE kiểm qua API | BR2, BR9, AC5, AC6, AC11, E-01, E-02, E-17, E-20 | UC-01 | Positive · Negative · Security · Concurrency | A |
| SC-05 | Không gửi được email (AC7) và thử lại; vượt 5 mã ở màn 11; chặn ngầm (Q-23) | AC7, AC8, E-25 | UC-01 | Exception & recovery · Negative | A (`❓` một phần) |
| SC-06 | Đếm ngược theo email: về 11 gửi lại cùng email trong 60 giây (AC10), email khác (Q-24); đổi email quá 3 lần (AC11a, Q-22); màn 12 hiển thị và email mẫu 23 theo tài liệu | AC10, AC11, AC11a, E-15, E-16, E-24 | UC-01 | Positive · UI · Integration email | A (`❓` một phần) |
| SC-07 | Màn 12 hành xử theo US2 kênh email: sai mã, hết hạn, gửi lại + mã cũ, mã thứ 6/24 giờ, sai 5 lần khóa 30 phút | AC13, E-10, E-25 | UC-01 | Negative · Integration | A |
| SC-08 | Đúng OTP → màn 13 theo `US6:49`; bỏ ngang ở 13 → tài khoản chưa tồn tại | AC12, BR5, E-06 | UC-01 | Positive · Data integrity | A |
| SC-09 | 10 phút sau OTP (phút 9 tạo được, phút 11 "Phiên xác thực đã hết hạn…"); Back ở 13 (nút + back hệ thống) về 11 giữ email, phải gửi OTP mới; mã cũ không dùng lại; Back trong 60 giây (Q-24); BE kiểm BR5 qua API | BR3, AC18, AC19(a), BR10 | UC-01 | Boundary · Positive · Negative · Security | A (`❓` một phần) |
| SC-10 | Màn 13: nút mờ khi chưa đủ 2 ô; quy định mật khẩu BR4 (biên 7/8/16, thiếu số / đặc biệt, khoảng trắng, dấu TV, không khớp); chữ hoa / 17 ký tự `closedScope` | BR4, AC14, AC15, AC16, E-09, E-13 | UC-01 | Boundary · Negative · Positive | A (`❓` Q-17: 3 case) |
| SC-11 | Không ô họ tên / SĐT; hai ô + Hiện; tên hiển thị = email đã qua OTP; sửa tên ở US5; đổi email giữa chừng; đăng nhập luôn; chữ hoa khi lưu | BR6, AC17, E-04, E-05 | UC-01 | UI · Data integrity | A |
| SC-12 | IP ngoài VN (vẫn hai tab), IP không xác định vẫn đăng ký email được | BR8, E-07 | UC-01 | Positive · Compatibility | A |
| SC-13 | Đăng ký thành công trên Android, Web Chrome/Safari (màn 14 nguyên văn); đăng nhập bằng tài khoản mới; thoát ở màn 14 | BR5, AC17, E-21, E-23 | UC-01 | Positive · E2E · Compatibility | A (`❓` một phần) |
| SC-14 | Sau màn 14: ChatGoni chat ngay, mặc định Tức thì, thanh hạn mức, link xác thực SĐT, Pro khóa; Thông tin tài khoản email "Đã xác thực", "Thêm số điện thoại" | BR7, E-03, E-11, E-12, E-19 | UC-01 | Positive · Data integrity | A |
| SC-15 | Lỗi chung: mất mạng ở từng bước, lỗi hệ thống khi Đăng ký (nguyên văn Epic), ra nền / F5 / tắt app, response rớt | AC19(c)(d), E-22, E-24, BR5 | UC-01 | Exception & recovery | A (`❓` một phần) |
| SC-16 | Regression: tài khoản form cũ vẫn đăng nhập | E-21 | UC-01 | Regression | A |
| SC-17 | Exploratory: Hiện liên động, hai ô cùng sai, đổi IP giữa chừng, iOS đường ngoài tài liệu, thời gian email / Spam, mật khẩu trùng email, URL form cũ, đích link Điều khoản, % sau câu đầu | BR liên quan | UC-01, UC-02 | Edge case | B |
| SC-18 | *(bỏ 2026-10-20)* Placeholder hai nhánh chặn màn 11 — danh sách chặn ngoài phạm vi (`US6:32`); giới hạn thiết bị = chặn ngầm → SC-05 | — | — | — | — |

## 8. Testcase Summary

| Nhóm | Số case | Positive | Negative | Edge case | Khác (UI / Security) | Có `❓ Cần chốt` |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| A. Theo requirement | 83 ([US6_01]→[US6_60], [US6_62] [US6_64] [US6_72] [US6_74]→[US6_79] [US6_81]→[US6_94]) | 26 | 27 | 19 | 11 (UI 5 · Security 6) | 16 = Q-01 [US6_15] · Q-02 [US6_19] · Q-04 [US6_57] · Q-05 [US6_49] · Q-08 [US6_43] · Q-12 [US6_07] [US6_16] [US6_28] · Q-13 [US6_59] · Q-17 [US6_36] [US6_91] [US6_92] · Q-22 [US6_86] · Q-23 [US6_79] · Q-24 [US6_85] [US6_94] |
| B. QA bổ sung | 9 ([US6_63] [US6_65]→[US6_71] [US6_73]; [US6_61] [US6_80] bỏ; 5 case chuyển lên A) | 0 | 0 | 9 | 0 | 0 |

Chi tiết case: `04-testcases.md`. Số đếm bằng script trên bảng case 2026-10-20 (92 dòng case).

## 9. Regression Scope

| Khu vực | Vì sao bị ảnh hưởng | Căn cứ | Giới hạn phân tích |
| --- | --- | --- | --- |
| Form đăng ký email cũ (web) và tài khoản tạo bằng form cũ | Form cũ bị thay bằng tab Email (web thay khi web cập nhật); tài khoản form cũ phải đăng nhập được và bị AC6 chặn đăng ký lại | `US6:13`, `US6:74`, `US6:105`, `EPIC:202` | [US6_10] [US6_60]; đường vào URL cũ chỉ ĐO & GHI ([US6_70]) |
| Màn đăng nhập (US3, màn 01) | "Chưa có tài khoản? Đăng ký" là lối vào; AC6 "Đăng nhập" điền sẵn email vào màn 01; tài khoản mới đăng nhập bằng email + mật khẩu | `US3:47`, `US3:69`, `US3:75`, `US6:80` | [US6_01] [US6_48] [US6_72]; không kiểm lại US3 |
| Màn OTP dùng chung (US2, màn 12) | Component dùng chung; bộ đếm gửi / sai tính chung mọi luồng, mọi thiết bị; đếm ngược theo email (AC10) | `US2:24`, `US2:61-62`, `US2:99`, `US6:84` | Chỉ kiểm trong US6; "tính chung" với US4/US5 chưa đủ dữ liệu để loại trừ |
| Bước tạo mật khẩu dùng chung (US1 05c, US4 04) | Quy định BR4 áp mọi luồng (`EPIC:101`); 10 phút sau OTP áp chung | `US6:15`, `US6:101`, `EPIC:92`, `EPIC:101` | Không kiểm lại US1/US4; Q-17 trả lời chung |
| Keycloak / token (BE1) | "Đăng nhập luôn" sau đăng ký cần API trả token cho màn riêng trong app | `US6:61`, `US6:102`, `EPIC:160` | [US6_93]; chưa đủ dữ liệu — BE1 chưa chốt |
| Đăng nhập / đăng ký Google (US9) | Nút Google trên màn 11; email Google trùng → AC6 | `US9:57`, `US9:73`, `EPIC:202` | Chỉ kiểm có nút và AC6; hành vi Google thuộc US9 |
| Thông tin tài khoản (US5) | Tên = email, email "Đã xác thực" không bút sửa, "Thêm số điện thoại" + hộp gợi ý | `US5:61`, `US5:67`, `US5:81-82` | [US6_40] [US6_41] [US6_52]; quy tắc sửa tên thuộc US5 |
| ChatGoni hạn mức (US7, US8) | Tài khoản mới chưa có SĐT → hạn mức thấp, Pro khóa | `US7:60`, `US7:76-79` | Dừng ở dấu hiệu; hết hạn mức thuộc US7 |
| iOS | Email OTP / link trong email có thể mở trên iPhone | `BUG10:36` | [US6_04]; đường ngoài tài liệu ĐO & GHI ([US6_67]) |
| Mời thành viên vào workspace | Email được mời rồi đăng ký ở US6 | `US9:57`, `EPIC:133` | Chưa đủ dữ liệu — chờ Q-01 |
| Màn 11 tab "Số điện thoại" (US1) | Cùng màn đăng ký; AC3 / AC9 / chặn ngầm là quy ước chung | `US1:46`, `US1:72`, `EPIC:128` | Không kiểm US1 trong bộ này |

## 10. Automation Candidate

| Case | Lý do phù hợp | Dependency · data · môi trường | Trạng thái |
| --- | --- | --- | --- |
| [US6_06] [US6_76] [US6_78] | Validate thuần FE màn 11, dữ liệu cố định (bộ AC4 + BR1), chạy mỗi build | Môi trường test; không cần OTP | Candidate |
| [US6_32]→[US6_35] [US6_37] [US6_64] [US6_90] | Validate FE màn 13, dữ liệu cố định (02 §4 d.30) | Cần tới màn 13: OTP test cố định hoặc mock dịch vụ email; [US6_36] [US6_91] [US6_92] chờ Q-17 mới viết script | Candidate |
| [US6_10]→[US6_14] [US6_72] | AC6 với nhiều loại tài khoản, lặp lại ổn định, nguyên văn cố định | Tài khoản mẫu TK-CŨ, TK-G, TK-US5 có sẵn trên môi trường test; không cần OTP thật | Candidate |
| [US6_07] [US6_16] [US6_28] | Kiểm lớp BE qua API, không phụ thuộc UI | Tên API và mã lỗi (Q-12); email test; reset tài khoản sau chạy | Candidate (chờ Q-12) |
| [US6_46] [US6_48] [US6_93] | E2E tạo tài khoản + đăng nhập luôn + đăng nhập lại, giá trị regression cao | OTP test cố định hoặc đọc hộp thư test qua API; BE xóa được tài khoản sau chạy | Candidate |
| [US6_22]→[US6_25] [US6_87] | Lỗi OTP theo US2, nguyên văn và con số cố định; dùng chung script với US2 | Môi trường rút ngắn 60 giây / 5 phút / 30 phút; reset bộ đếm | Candidate |

## 11. Điểm cần quay lại Debate

| # | Nội dung + nguồn | Đề xuất mức | Case bị ảnh hưởng |
| ---: | --- | --- | --- |
| 1 | AC19(c) "lỗi hệ thống" (`US6:97`): tài liệu không nói lỗi nào; case giả lập BE trả 5xx qua proxy — cần Dev xác nhận cách giả lập chấp nhận được. | Không trọng yếu | [US6_56] |
| 2 | AC7 (`US6:81`) "không gửi được email": cách dựng lỗi gửi (BE tắt dịch vụ / email "đen") là đề xuất QA (02 §4 d.17 `[QA BỔ SUNG]`), chưa có Dev xác nhận — nếu không dựng được thì [US6_18] [US6_19] "không chạy được". Gộp vào Q-02 khi gửi BE. | Không trọng yếu | [US6_18] [US6_19] |
| 3 | BR8 "không xác định được IP": chưa có cách dựng môi trường; nếu Dev không giả lập được thì [US6_45] ghi "không chạy được" kèm lý do. Bản final tạm hoãn kiểm tra IP nên case có giá trị thấp. | Không trọng yếu | [US6_45] |
| 4 | AC17 "tạo workspace (nếu chưa có)" (`US6:94`): tài liệu không có tiêu chí quan sát "đã có workspace"; case dùng dấu hiệu QA đề xuất (tên workspace trên menu, 02 §4 d.19) — cần BA xác nhận dấu hiệu, gộp vào Q-05. | Không trọng yếu | [US6_46] [US6_47] [US6_49] |
| 5 | BR1 "không dấu tiếng Việt" (`US6:56`): ví dụ sai của AC4 chỉ có dấu trước `@` (`nguyễn@gmail.com`); dấu ở **tên miền** (`qa@côngty.vn`) QA xếp vào bộ sai của [US6_06] theo câu chung — nếu hệ thống chấp nhận thì ghi nhận, hỏi lại BA. | Không trọng yếu | [US6_06] |
| 6 | *(đóng 2026-10-20)* AC4 cũ nguyên văn popup — bản final `US6:80` đã ghi; Q-07, Q-16 đóng. | — | — |
| 7 | *(đóng 2026-10-20)* Màn 12 trạng thái sau 0 s — `US2:84` AC9 "Gửi lại mã"; Q-09 đóng. Figma lệch → Q-25. | — | — |
| 8 | *(đóng 2026-10-20)* Màn 13 chữ badge / nút — `US6:49` "Đã xác thực", "Đăng ký"; Q-21 đóng. Helper quy định → Q-17 thu hẹp. | — | — |
| 9 | AC4 — lỗi FE hiện **lúc rời ô** hay **lúc bấm nút**: `US6:78` chỉ ghi "FE + BE", `US6:69` "FE = kiểm tra ngay tại ô". Case ghi nhận thời điểm, không tính fail; hỏi FE Hiếu nếu cần tiêu chí. Cùng câu hỏi cho dòng quy định mật khẩu (AC15 "FE + BE"). | Không trọng yếu | [US6_06] [US6_32]→[US6_35] [US6_90] |
| 10 | *(đóng 2026-10-20)* Màn 11 hình thức — bảng màn `US6:47` là nguồn; Figma chỉ là hình. | — | — |
| 11 | *(đóng 2026-10-20)* Phạm vi `closedScope` — 02 thu hẹp còn chữ hoa + thường / 17–64 ký tự: chỉ [US6_36] [US6_91] [US6_92] `❓`; [US6_30]→[US6_35] [US6_37] [US6_90] có expected. Hồng chốt lại mức Q-17 (02 đầu file). | Trọng yếu cô lập (Hồng chốt mức) | [US6_36] [US6_91] [US6_92] |
| 12 | *(đóng 2026-10-20)* Placeholder Q-18 — [US6_80] bỏ, [US6_79] → AC8. | — | — |
| 13 | **Mới 2026-10-20** — AC8 "hệ thống bận" (`US6:82`): không có câu riêng trong US2 / Epic → chưa viết case; nếu BA xác nhận dùng "Đã xảy ra lỗi. Vui lòng thử lại sau." (`EPIC:126`) thì thêm case. Thuộc Q-23, không tự chọn. | Không trọng yếu | (chưa có case) |
| 14 | **Mới 2026-10-20** — Thứ tự kiểm ở màn 11 khi hai điều kiện cùng đúng: email đang trong 60 giây (AC10) **và** đã chạm 5 mã/24 giờ (AC8) — vào thẳng 12 hay báo vượt giới hạn? Tài liệu không xếp thứ tự; DT-1 đặt C3 trước C4 theo thứ tự AC, chưa phải căn cứ. | Không trọng yếu | [US6_62] [US6_83] (không đổi expected khi chạy tách riêng) |
| 15 | **Mới 2026-10-20** — AC19(b) ở màn 13: hộp thoại [Hủy] [Đăng nhập] — bấm Hủy ở lại 13 hay về 11; Đăng nhập → màn 01 điền sẵn email như AC6? `US6:97` không nói (AC6 chỉ nói cho màn 11). Case ghi nhận. | Không trọng yếu | [US6_17] |
| 16 | **Mới 2026-10-20** — AC19(d) "Mở lại app thì bắt đầu từ 11" (`US6:97`): ô Email có điền sẵn không; áp cho web (đóng tab) không — tài liệu nói "app". Phần web giữ trong Q-04. | Không trọng yếu | [US6_58] [US6_57] |
| 17 | **Mới 2026-10-20** — Tiêu đề màn 12 kênh email: `US2:49` ghi "Nhập mã xác thực" cho kênh Zalo, `US2:50` kênh email "còn lại giống kênh Zalo"; `US6:48` không ghi tiêu đề. Case [US6_20] kiểm theo US2 — nếu Design đặt tiêu đề khác thì ghi nhận (Q-25). | Không trọng yếu | [US6_20] |

#13–#17 bổ sung 2026-10-20 sau bản final; không có điểm trọng yếu mới ngoài Q-17 (Hồng chốt lại mức). #1–#5, #9 giữ; #6, #7, #8, #10, #12 đóng theo tài liệu; #11 cập nhật theo `closedScope` mới.

## Lịch sử cập nhật

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
| 2026-10-16 | AI (Test Designer) — người dùng: Hồng (QA) | Tạo file S6: UC-01, UC-02; BR1–BR5 + AC1–AC11 + E-xx; DT-1, DT-2; bảng trạng thái S0–S3; 8 rủi ro; Coverage Matrix 21 dòng; SC-01→SC-17; 60 case A + 13 case B; regression; automation candidate; 4 điểm quay lại Debate |
| 2026-10-16 | AI (Test Designer) — người dùng: Hồng (QA); căn cứ BA trả lời quy định định dạng email (02 §4 d.21) | §2 dòng AC3; DT-1 C1 + nguyên văn R1 "Email không đúng định dạng" + case R4 [US6_74]→[US6_77]; Coverage Matrix dòng AC3 (lớp FE đã phủ đủ, còn `một phần` do [US6_07] `❓` Q-12), dòng E-02, lỗ hổng; SC-03, SC-17; §8: A 64 (Positive 21, Edge 14), B 13 ([US6_61] chuyển lên, thêm [US6_78]); §10; §11 thêm #5 (tên miền có dấu, ô trống) |
| 2026-10-16 | AI (Test Designer) — người dùng: Hồng (QA); căn cứ Figma giao diện thật (01 §6d) và cổng đóng một phần (02 `closedScope` Q-17, Q-18) | Frontmatter + mở đầu: nguồn `FIGMA`, tên nút theo Figma ("Xác thực" thay "Xác nhận"), phạm vi cổng đóng; §2: BR1 (popup AC4), AC3, AC6 (Figma khác AC → Q-09), AC8 (Quay lại màn 13), **AC9 cổng đóng Q-17**, AC10 (màn 14, Q-19), E-09 chịu Q-17, thêm dòng nhánh chặn màn 11 (Q-18); §3 DT-1 hình thức / nguyên văn R1–R4 + ghi chú Q-18, DT-2 C2 chịu Q-17, case `❓`; §4 sự kiện Quay lại; §5 rủi ro #3, #4 (có dấu hiệu), #8 cập nhật, thêm #9 (Q-18), #10 (Q-19); §6 Coverage: AC3, BR1, AC4, AC6 ([US6_20] `❓`), AC8, BR2, AC9 (một phần — cổng đóng), AC10, BR3 ([US6_40] `❓`), thêm dòng Q-18 chưa phủ, lỗ hổng; §7 SC-06, SC-10, SC-13, SC-17, thêm SC-18; §8 A 66 / B 14, `❓` A 24 (15 + 7 Q-17 + 2 Q-18), B 2; §9 thêm màn 11 US1; §10; §11 thêm #6–#12 |
| 2026-10-20 | AI (Test Designer) — người dùng: Hồng (QA); căn cứ tài liệu nguồn **bản final 19/10/2026** (10 BR / 19 AC + AC11a), `01` §12a, `02` §3b + §4 dòng 28–46 | **Viết lại tại chỗ theo mã mới.** Frontmatter + mở đầu (bản final, tên nút theo tài liệu, bảng đối chiếu mã cũ ↔ mới, `closedScope` thu hẹp, Figma chỉ là nguồn hình — Q-25); §1 UC-01 AF-1→AF-8, E-1→E-3 theo AC1–AC19 + AC11a, thứ tự kiểm bước 1; §2 BR1–BR10 + trạng thái hiểu (BR4 `[CẦN XÁC NHẬN]` chữ hoa / 64), AC, E-01→E-25; §3 DT-1 8 cột (thêm C0 ô trống, C3 trong 60 giây, C4 vượt 5 mã / chặn ngầm / đổi email >3 lần, C6 bấm nhiều lần), DT-2 8 cột (thêm C0 nút mờ, C1 quá 10 phút, C4 phiên khác đã đăng ký, C5 mạng / BE lỗi); §4 bảng trạng thái S0–S5 (S1 đang đếm ngược theo email, S3 xác thực còn hiệu lực 10 phút, S4 đã đăng nhập); §5 11 rủi ro (thêm alias `+`, AC10 ↔ AC18, AC11a, Keycloak, lệch Figma; bỏ Q-03 / Q-18 / Q-19); §6 Coverage Matrix theo BR1–BR10 + AC1–AC19 + AC11a + E-01→E-25 (BR: 5 đã phủ / 5 một phần; AC: 10 / 9 / 1 chưa phủ AC11a; E: 21 / 4), lỗ hổng, loại không áp dụng; §7 SC-01→SC-17 viết lại, SC-18 bỏ; §8 A 83 (26 / 27 / 19 / 11; `❓` 16) · B 9 (`❓` 0) — đếm bằng script trên 92 dòng; §9 thêm Keycloak, cập nhật dòng dẫn; §10 thêm nhóm AC13, màn 13 FE; §11 #6–#8, #10, #12 đóng, #11 theo `closedScope` mới, thêm #13–#17 (hệ thống bận; AC10 ∩ AC8; hộp thoại AC19(b) ở màn 13; AC19(d) web / điền sẵn; tiêu đề màn 12) |
