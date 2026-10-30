---
featureId: EPIC-SDT-US9
basedOn: 02-alignment-summary.md (gate: open, 2026-10-16 — Hồng)
reviewedAt: 2026-10-16
modes: [1, 3]              # 1 = UI/UX/CX Review (tài liệu + wireframe + Figma giao diện thật) · 3 = Customer Journey Review — KHÔNG chạy Mode 2
evidenceLevel: phân tích tài liệu và design (Mode 1) · mô phỏng bằng suy luận (Mode 3) — không có tương tác thật
---

# CX Review — EPIC-SDT-US9: Đăng ký & đăng nhập bằng Google

**Mode đã chạy:** Mode 1 (review từ tài liệu US9 + ảnh user flow + ảnh wireframe 01, 05a/11, 21 + Figma giao diện thật 2 frame
có ảnh và lớp text) và Mode 3 (hành trình end-to-end suy ra từ tài liệu: nút Google → màn chọn tài khoản → đăng ký / đăng nhập /
bị chặn trên iOS → ChatGoni hạn mức thấp → Thông tin tài khoản → thêm SĐT / đặt mật khẩu).
**Không chạy Mode 2:** không có prototype, sản phẩm chạy được hay công cụ thao tác trong phiên này. Không câu nào trong file mô tả
việc đã thao tác hay đã quan sát trên sản phẩm. Thư mục `evidence/` không được tạo vì không có screenshot / log.

Viết tắt tệp và số dòng theo `01-requirement-analysis.md` (`US9`, `EPIC`, `US1`, `US3`, `US4`, `US5`, `US6`, `US7`, `BUG10`,
`FIGMA`). Thêm `TB` = `tailieu/…/00  [EPIC]…/bang-noi-dung-thong-bao.md` (63 dòng, bảng nội dung thông báo — **file 01 của US9
chưa liệt kê nguồn này**; US4 đã dùng bản 59 dòng lưu tại `wiki/qa/features/EPIC-SDT-US4/nguon/`; xem mục 7 #3). "02 §4 #n" =
dòng n bảng Cách hiểu đã thống nhất của `02-alignment-summary.md`; "Q-nn" = câu hỏi ở 02 mục 3. "US6 CX-nn" =
`wiki/qa/features/EPIC-SDT-US6/05-cx-review.md`. Đường dẫn `figma/…` = `wiki/qa/features/EPIC-SDT-US9/figma/…`.

Căn cứ requirement: 02 §4 (23 dòng; dòng 21 bị thay một phần bởi dòng 22 và việc Q-01 đã xác nhận), Q-01→Q-05 có trả lời của PdM
Hường, file 01. Với 15 điểm không trọng yếu còn mở (Q-04b, Q-05b, Q-07→Q-19) file này **chỉ ghi rủi ro CX, không chọn cách hiểu**.
Figma là design, không phải hành vi sản phẩm → **không có finding Defect**.

## 1. Phạm vi và nguồn đã xem

| # | Nguồn (tài liệu / design / prototype / sản phẩm) | Phạm vi | Cách xem (đọc tài liệu / xem ảnh / thao tác thật) |
| ---: | --- | --- | --- |
| 1 | `US9` (78 dòng) | Toàn bộ: background, story, scope, BR1–BR8, AC1–AC10, open questions | Đọc tài liệu |
| 2 | Ảnh user flow `US9:23` | Nút Google → màn chọn tài khoản → Hủy (AC6) / lỗi (AC10) / chọn → BR2 → AC4 · Nền tảng? → iOS 21 (AC5) · Android/Web tạo tài khoản → workspace → ChatGoni (AC3) → Đã xác thực SĐT? → hạn mức thấp (AC7) · khung AC8/AC9 | Xem ảnh |
| 3 | Ảnh wireframe `US9:30` (01, 05a/11, 21, khung Quy tắc chính) | Nhãn, vị trí nút, khung lỗi đỏ màn 21, ghi chú "ở lại màn đăng nhập", "Chỉ Android · Web — ẩn trên iOS" | Xem ảnh — chỉ tham khảo luồng (`US9:33`) |
| 4 | `figma/US3_1634-21845_dangnhap.png` (màn 01) | Logo, ô nhập, Lưu đăng nhập, Quên mật khẩu, nút Đăng nhập mờ, "Hoặc", "Đăng nhập bằng Google", "Chưa có tài khoản? Đăng ký" | Xem ảnh |
| 5 | `figma/US6_1641-50276_nhap-email.png` (màn 11 tab Email) | Thanh 3 vạch, tab, ô email, nút mờ, "Tiếp tục với Google", dòng Điều khoản / Chính sách | Xem ảnh |
| 6 | `figma/lop-text-figma-2026-10-16.txt` | Frame US4 (02, 03, 04 đặt mật khẩu mới), US6 (11, 12, 13, 14 thành công, popup email đã dùng), 3 email mẫu (`1859:3924`, `1872:4430` đặt lại mật khẩu, `1872:4483`), US3 (`1634:21845`, `1725:10310`, `1725:10598`) | Đọc text — chữ trong instance (nút, ô nhập) không bóc được, không suy đoán |
| 7 | `02-alignment-summary.md` | Trạng thái đầu file, mục 2–11 (Q-01→Q-19, 23 dòng §4) | Đọc tài liệu |
| 8 | `01-requirement-analysis.md` | Mục 2–9: actor, UC-01→UC-05, BR, E-01→E-22, AC, 6c wireframe, 6d Figma, 8, 9 | Đọc tài liệu |
| 9 | `EPIC` §2 (28, 31), §4 (78, 80), §6 (96–100, 104–108, 112–115, 126–128), §7 (134–137), §8 (#1, #2, #4, #10, #11, #12, #19), §10 (182–185), §11 (194), §13 (206) | Bối cảnh tài khoản hiện hữu, quy tắc chung, rủi ro | Đọc tài liệu |
| 10 | `US3` (36–61) | Màn 01, BR2–BR3, AC1–AC9 | Đọc tài liệu |
| 11 | `US4` (44–76) | BR1–BR9, AC1–AC12 (luồng AC9 dẫn tới) | Đọc tài liệu |
| 12 | `US5` (5–89) | Thông tin tài khoản 07–10b, BR1–BR9, AC1–AC16, câu hỏi mở `US5:88` | Đọc tài liệu |
| 13 | `US7` (5–83) | Hạn mức, popup, luồng xác thực SĐT ở ChatGoni (18) không hỏi mật khẩu | Đọc tài liệu |
| 14 | `US1` (30–72) | AC2 ngoài VN, AC10 màn thành công + "Bắt đầu sử dụng" (Q-05 (b) tái dùng) | Đọc tài liệu |
| 15 | `BUG10` (1–37) | iOS không có đường nào tới đăng ký, kể cả link trong trang | Đọc tài liệu |
| 16 | `TB` (63 dòng) | Dòng 15–20 (US3 màn 01), 43 (Dùng chung), 47–64 (US1/US6) — US9 **không có dòng nào** trong bảng | Đọc tài liệu |
| 17 | `wiki/qa/features/EPIC-SDT-US6/05-cx-review.md` (CX-06, CX-07, CX-10, CX-11, CX-15) | Luồng liền kề — để không lặp finding | Đọc tài liệu |
| 18 | `wiki/qa/features/EPIC-SDT-US4/02-alignment-summary.md` (Q-15, Q-26, Q-30, §4 #19) | Thông báo dùng chung, quy định mật khẩu đã debate lại | Đọc tài liệu (đối chiếu) |

**Giới hạn:** Không có prototype, sản phẩm, công cụ truy cập → không chạy Mode 2; mọi nhận định về hành vi thực tế và phản ứng của
người dùng là `[CX GIẢ THUYẾT]`. Figma **không có** màn 21 (iOS báo lỗi), màn chọn tài khoản Google, màn lỗi AC10, trạng thái đang
xử lý, màn thành công cho Google, Thông tin tài khoản của tài khoản Google, thông báo Q-04b; Figma cũng **không có** bản màn 01 cho
iOS (đã có US4 Q-30). Màn chọn tài khoản của hệ điều hành (Q-03 (a)) là UI của Google/hệ điều hành, ngoài design Gopany → không
đánh giá câu chữ. Accessibility: ảnh tĩnh không có token màu / cỡ chữ / thứ tự focus → không kết luận contrast hay screen reader.
Không có dữ liệu người dùng thật → mọi persona là phân nhóm theo tài liệu hoặc giả thuyết. `03-test-design.md` / `04-testcases.md`
của US9 chưa có (S6 chạy song song) → cột Trace ghi BR/AC/UC, "case: chưa có". Rủi ro Apple guideline 4.8 (Sign in with Apple,
`US9:9`) là quyết định phạm vi của Epic, ngoài CX.

## 2. Persona

| Persona | Nhóm khách hàng · bối cảnh | Mục tiêu | Căn cứ |
| --- | --- | --- | --- |
| P1 | **Người dùng mới** có tài khoản Google, đăng ký trên **Android hoặc Web** | "Một chạm" là vào dùng, không nhớ mật khẩu | `US9:13` (actor, mục tiêu); `US9:47`, `US9:62`. Bối cảnh cá nhân là **persona giả thuyết phục vụ review** |
| P2 | Người dùng **iOS chưa có tài khoản** bấm "Đăng nhập bằng Google" | Vào dùng app trên iPhone | `US9:48`, `US9:64`, `EPIC:31`, `BUG10:28`. Trường hợp "chỉ có iPhone, không có máy Android" là **persona giả thuyết phục vụ review** |
| P3 | Người **đã có tài khoản** bằng email (US6), form cũ, hoặc Google trước Epic | Đăng nhập nhanh vào đúng tài khoản cũ | `US9:46`, `US9:63`, `EPIC:28`, 02 §4 #2 |
| P4 | Người **đã đăng ký bằng SĐT** (US1), tài khoản chưa có email hoặc có email khác email Google | Đăng nhập lại cho nhanh bằng nút Google | `US5:8` "người đăng ký bằng SĐT chưa có email"; `US1:68`. Việc người này bấm Google là **persona giả thuyết phục vụ review** |
| P5 | Người **được mời vào workspace qua email**, chưa từng đăng ký | Vào workspace của đồng nghiệp đã mời | `EPIC:136`, `US5:8`, Q-02 (c) `[ĐÃ XÁC NHẬN]`, 02 §4 #18 |
| P6 | Người **đang dùng tài khoản Google** (chưa có SĐT, chưa có mật khẩu) muốn nâng hạn mức / thêm SĐT / đăng nhập bằng mật khẩu | Dùng nhiều hơn, mở Pro, có thêm cách đăng nhập | `US9:49-51`, `US9:67-69`, Q-04 (b) `[ĐÃ XÁC NHẬN]`, 02 §4 #19 |
| P7 | Người **có nhiều tài khoản Google** trên cùng thiết bị / trình duyệt (cá nhân + công việc) | Chọn đúng tài khoản | **Persona giả thuyết phục vụ review** — tài liệu không nói |
| P8 | Người gặp **mạng chập chờn / Google lỗi / trình duyệt chặn popup** | Hoàn tất đăng nhập hoặc biết phải làm gì | `US9:71` (AC10); cách dựng lỗi 02 §4 #14–#15. Bối cảnh cá nhân là **persona giả thuyết phục vụ review** |
| P9 | Chủ email thật mà **email đó đã bị người khác dùng ở form đăng ký cũ** (không xác thực email) | Đăng nhập bằng Google vào tài khoản của chính mình | `EPIC:28` (form cũ không xác thực email), `US9:46` (form cũ → đăng nhập vào tài khoản đó). Tình huống là **persona giả thuyết phục vụ review** |

## 3. Hành trình đã review

Tất cả hành trình là **mô phỏng bằng suy luận** từ tài liệu (Mode 3), chưa thao tác thật.

| Hành trình | Persona | Mục tiêu → các bước → phản hồi hệ thống → kết quả cuối → cách phục hồi | Nguồn |
| --- | --- | --- | --- |
| J1 — Đăng ký mới Android/Web | P1 | Mục tiêu: dùng ngay. Màn 01 bấm "Đăng nhập bằng Google" **hoặc** màn 05a/11 bấm "Tiếp tục với Google" → màn chọn tài khoản (Android: của hệ điều hành; Web: cửa sổ Google) → chọn → (trạng thái đang xử lý: tài liệu/design không có — CX-10) → tài khoản tạo, email "Đã xác thực", họ tên = tên Google → **màn thành công + "Bắt đầu sử dụng"** (Q-05 (b); nội dung màn chưa định nghĩa — CX-12) → bấm → tạo workspace → ChatGoni chat ngay, không popup, "Hạn mức 5 giờ: X% đã dùng", link "Xác thực SĐT để nâng hạn mức", Pro khóa → sau 3 câu chạm 100% → thẻ "Bạn đã dùng hết hạn mức miễn phí" + nút Xác thực. Phục hồi: Hủy ở màn chọn → về màn vừa bấm, không báo lỗi. Ghi chú: bấm từ màn 01 thì không thấy dòng Điều khoản (CX-04). | `US9:47`, `US9:62`, `US9:65`; 02 §4 #6, #13, #20, #22; `US7:61-68`; Figma `1634:21845`, `1641:50276` |
| J2 — Đăng nhập tài khoản đã có (mọi nền tảng) | P3 | Bấm Google → chọn tài khoản → BR2 khớp (không phân biệt hoa/thường) → vào đúng tài khoản, đúng workspace; dữ liệu cũ giữ (ĐO & GHI). Không có màn trung gian. Kết quả: hoàn thành. Điểm vướng: tài khoản form cũ (email chưa xác thực) — CX-13. | `US9:46`, `US9:63`; 02 §4 #2, #3; `EPIC:28`, `EPIC:97` |
| J3 — Người đã có tài khoản SĐT bấm Google | P4 | Android/Web: màn 01 bấm "Đăng nhập bằng Google" (nghĩ là cách đăng nhập nhanh) → email Google không gắn tài khoản SĐT → **tạo tài khoản thứ hai** (AC3) → màn thành công → workspace mới trống → "dữ liệu của tôi đâu?" → quay lại thêm email Google vào tài khoản SĐT ở Thông tin tài khoản → "… đã được dùng cho một tài khoản khác" → không gộp, không hủy liên kết, không xóa email được. iOS: cùng thao tác → "Tài khoản chưa tồn tại…" dù người đó có tài khoản. → CX-01, CX-02. | `US9:47`, `US9:62`, `US9:64`; `EPIC:96`; `US5:53`, `US5:72`; `US9:19`; `US5:18` |
| J4 — iOS, email chưa có tài khoản | P2, P7 | Màn 01 (không có link Đăng ký) bấm Google → màn chọn của hệ điều hành → chọn → "Tài khoản chưa tồn tại. Vui lòng đăng ký trên web hoặc ứng dụng Android." (wireframe: khung đỏ trên ô nhập, ở lại màn 01; hình thức Q-19) → không có địa chỉ web, không có lối đi (BUG10 cấm link đăng ký) → người chỉ có iPhone tự tìm web → đăng ký trên web bằng Google → quay lại iOS bấm Google → AC4 vào được. Người có nhiều tài khoản Google: thông báo không nói email nào đã kiểm → không biết mình chọn nhầm. → CX-02, CX-03. | `US9:48`, `US9:64`; wireframe 21; 02 §4 #23; `BUG10:28`, `BUG10:35-36` |
| J5 — Được mời vào workspace, chưa đăng ký | P5 | Nhận lời mời qua email → mở Gopany → Android/Web bấm Google bằng email được mời → AC3: tài khoản mới, màn thành công, **workspace mới**; lời mời "xử lý riêng" (người dùng thấy gì: tài liệu không nói) → không thấy workspace đồng nghiệp. iOS: "Tài khoản chưa tồn tại…" dù vừa được mời. → CX-05. | Q-02 (c); 02 §4 #18, #23; `EPIC:136`; US6 CX-10 |
| J6 — Hủy | P1, P7 | Bấm Google → màn chọn → Hủy / Back / chạm ngoài (mobile) hoặc đóng cửa sổ (web) → về màn vừa bấm, không báo lỗi; dữ liệu đã gõ còn hay mất (Q-10). Kết quả hợp lý; không finding riêng. | `US9:65`; 02 §4 #13, #22 |
| J7 — Lỗi / mất mạng | P8 | Ba thời điểm (02 §4 #14): trước khi bấm, sau khi chọn tài khoản, khi đang gọi BE → báo lỗi tiếng Việt (nguyên văn Q-09; `TB:43` có câu dùng chung "Đã xảy ra lỗi. Vui lòng kiểm tra và thử lại.") → "thử lại" = bấm lại Google → gợi ý "đăng nhập bằng email/SĐT" → người chỉ có Google (không mật khẩu) đi theo gợi ý → màn 01 gõ mật khẩu nào cũng sai. Web chặn popup → có thể không thấy gì. Thời điểm (3): không biết tài khoản đã tạo chưa (Q-05b). → CX-09, CX-10. | `US9:71`; 02 §4 #14–#15; `US9:50`; `US3:56` |
| J8 — Thêm SĐT ở Thông tin tài khoản (Q-04 (b)) | P6 | Menu Tài khoản → Thông tin tài khoản (email "Đã xác thực" không nút Đổi; SĐT "Chưa có" + Thêm) → bấm Thêm → hệ thống yêu cầu đặt mật khẩu trước (hình thức Q-04b) → tới Quên mật khẩu (lối vào ghi trong tài liệu là ở **màn đăng nhập**, `US4:62`) → nhập email Google → OTP email → đặt 2 ô mật khẩu → "Đổi mật khẩu thành công. Vui lòng đăng nhập lại." → màn 01 → đăng nhập lại → Menu → Thông tin tài khoản → Thêm → màn 09 nhập mật khẩu vừa đặt + SĐT → OTP Zalo → SĐT "Đã xác thực". Đồng thời mọi thiết bị khác (kể cả phiên Google) bị đăng xuất ở lần gọi API kế tiếp. So sánh: ChatGoni → link "Xác thực SĐT…" → popup → SĐT → OTP Zalo, không hỏi mật khẩu. → CX-06, CX-07, CX-08, CX-11. | 02 §4 #7, #9, #19; Q-04 (b); `US4:50`, `US4:62`, `US4:73-74`; `US5:52`, `US5:69`; `US7:63`, `US7:72`, `US7:75`, `US7:83` |
| J9 — Đặt mật khẩu để đăng nhập bằng email (AC9) | P6 | Muốn có mật khẩu → không có mục "Đặt mật khẩu" trong Thông tin tài khoản (đổi mật khẩu ngoài phạm vi US5, `US5:18`) → phải tự nghĩ ra "Quên mật khẩu" dù chưa từng có mật khẩu → email "Đặt lại mật khẩu … Mật khẩu hiện tại của bạn không thay đổi" → màn "Đặt mật khẩu mới — dùng để đăng nhập bằng cả email và số điện thoại" (tài khoản chưa có SĐT) → xong → bị đăng xuất mọi nơi → đăng nhập lại; Google vẫn dùng được. → CX-07, CX-08, CX-14. | `US9:50`, `US9:69`; `US4:52`, `US4:73`; Figma `1872:4430`, `1754:6468`; 02 §4 #8, #9 |
| J10 — Chủ email thật, email đã bị dùng ở form cũ | P9 | Bấm Google bằng email của mình → BR2 khớp tài khoản form cũ (email chưa từng xác thực, `EPIC:28`) → vào tài khoản người khác đã tạo (tên, dữ liệu, workspace lạ); người tạo cũ vẫn giữ mật khẩu → hai người cùng vào một tài khoản. Tài liệu không có quy tắc nào cho trường hợp này. → CX-13. | `US9:46`; `EPIC:28`, `EPIC:98`; Q-17 |

## 4. Tổng hợp finding

| ID | Loại | Tóm tắt | Persona | Impact | Mức bằng chứng | Trace (BR / UC / case) |
| --- | --- | --- | --- | --- | --- | --- |
| CX-01 | CX Risk (rủi ro giả định) | Người đã có tài khoản (SĐT, hoặc email khác) bấm "**Đăng nhập** bằng Google" ở màn 01 → Android/Web lặng lẽ **tạo tài khoản thứ hai**; email Google bị khóa vào tài khoản mới, không gộp / không hủy liên kết / không thêm vào tài khoản cũ được | P4, P7 | Cao | mô phỏng bằng suy luận | BR2, BR3, AC3, E-01 · UC-01 · `US5:53`, `US5:72`, `US9:19` · case: chưa có |
| CX-02 | Usability Issue | Thông báo AC5 không cho biết **email nào** đã kiểm; "Tài khoản chưa tồn tại" dễ đọc thành "tài khoản của tôi mất rồi" với người có tài khoản bằng SĐT / email khác hoặc chọn nhầm tài khoản Google | P2, P4, P7 | Trung bình | phân tích tài liệu + wireframe 21 | BR4, AC5 · UC-03 · Q-19 · case: chưa có |
| CX-03 | CX Risk (rủi ro giả định) | iOS AC5 bảo "đăng ký trên web hoặc ứng dụng Android" nhưng không có địa chỉ, không có lối đi (BUG10 cấm link đăng ký) → người chỉ có iPhone dừng ở màn 01 | P2 | Cao (hành trình iOS dừng) — đúng requirement | phân tích tài liệu + wireframe 21 | BR4, AC5, E-06 · UC-03 · `BUG10:28`, `BUG10:36` · case: chưa có |
| CX-04 | CX Risk (rủi ro giả định) | Màn 01 tạo được tài khoản mới (AC3) nhưng **không có dòng Điều khoản / Chính sách bảo mật** như màn 05a/11 → tài khoản tạo mà không kèm thông báo đồng ý | P1, P4 | Trung bình–Cao (niềm tin / pháp lý — Product chốt) | phân tích design (Figma + wireframe) | AC1, AC3 · UC-01 bước 1 · Figma `1634:21845` vs `1641:50276` · case: chưa có |
| CX-05 | CX Risk (rủi ro giả định) | Người được mời chưa đăng ký (Q-02 (c)): Android/Web vào **workspace mới**, không thấy workspace đã mời — mục đích chính của họ thất bại; iOS báo "chưa tồn tại" dù vừa được mời; "lời mời xử lý riêng" không nói người dùng thấy gì | P5 | Cao | mô phỏng bằng suy luận | BR2, AC3, AC5 · Q-02 (c) · 02 §4 #18 · US6 CX-10 · case: chưa có |
| CX-06 | CX Risk (rủi ro giả định) | Thêm SĐT ở Thông tin tài khoản (Q-04 (b)): ~15 bước, rời luồng sang Quên mật khẩu (lối vào ở màn đăng nhập), bị đăng xuất mọi thiết bị, đăng nhập lại, quay về Thêm — trong khi ChatGoni cho thêm SĐT không cần mật khẩu | P6 | Cao (nguy cơ bỏ dở; BR5 giữ hạn mức thấp) | mô phỏng bằng suy luận | BR5, BR6, BR7, AC8 · UC-04 (b) · Q-04 (b), Q-04b · 02 §4 #7, #19 · case: chưa có |
| CX-07 | Usability Issue | Đặt mật khẩu **lần đầu** cho tài khoản Google phải đi qua "Quên mật khẩu"; câu chữ dọc đường viết cho người **đã có** mật khẩu ("Đặt lại mật khẩu", "Mật khẩu hiện tại của bạn không thay đổi", "Đổi mật khẩu thành công", "đăng nhập bằng cả email và số điện thoại") | P6 | Trung bình | phân tích tài liệu + Figma lớp text | BR6, AC9 · UC-05 · `US4:62`, `US4:73` · Figma `1872:4430`, `1754:6468` · case: chưa có |
| CX-08 | CX Risk (rủi ro giả định) | Đặt mật khẩu lần đầu → **mọi thiết bị đang đăng nhập Google bị đăng xuất** ở lần gọi API kế tiếp (`[ĐÃ XÁC NHẬN]`) → điện thoại đột ngột về màn đăng nhập, tài liệu không có lời giải thích nào cho người dùng | P6 | Trung bình | mô phỏng bằng suy luận | BR6, AC9, E-15 · 02 §4 #9 · `US4:50`, `US4:74` · case: chưa có |
| CX-09 | Usability Issue | AC10 "gợi ý đăng nhập bằng email/SĐT" dẫn vào ngõ cụt cho người chỉ có Google (không mật khẩu) và vô nghĩa với người đang đăng ký; nếu dùng câu dùng chung `TB:43` thì không phân biệt mất mạng / Google lỗi | P8, P1, P6 | Trung bình–Cao | phân tích tài liệu | AC10, BR6 · UC-01/02 E-1 · Q-09, Q-18 · 02 §4 #14–#15 · case: chưa có |
| CX-10 | CX Risk (rủi ro giả định) | Không có trạng thái **đang xử lý** giữa lúc chọn tài khoản Google và kết quả (tài liệu, wireframe, Figma đều không có); web chặn popup có thể "bấm mà không có gì xảy ra"; mất mạng lúc gọi BE → không biết tài khoản đã tạo chưa | P8 | Trung bình | phân tích tài liệu + design | AC3, AC4, AC10 · Q-05b, Q-09, Q-13 · 02 §4 #14–#15 · case: chưa có |
| CX-11 | Usability Issue | Thông tin tài khoản không cho người dùng biết **vì sao** email không đổi được và **tài khoản chưa có mật khẩu** → bấm Thêm SĐT bị bắt đặt mật khẩu là bất ngờ | P6 | Thấp–Trung bình | phân tích tài liệu | BR6, BR7, AC8 · `US5:56`, `US5:66` · Q-04b · case: chưa có |
| CX-12 | CX Risk (rủi ro giả định) | Màn thành công cho Google (Q-05 (b)) chưa có nội dung; frame thành công hiện có của US6 ghi "đã được tạo với số điện thoại …", "Tên hiển thị: <email>" — nếu tái dùng thì sai với tài khoản Google (tên = tên Google, không có SĐT); thoát ở màn này → đích lần sau chưa rõ (Q-05b) | P1, P4 | Trung bình | phân tích tài liệu + Figma lớp text | BR3, AC3 · Q-05 (b), Q-05b, Q-11 · 02 §4 #20 · Figma `1641:50321` · US6 CX-06, CX-15 · case: chưa có |
| CX-13 | CX Risk (rủi ro giả định) | Tài khoản form cũ có email **chưa từng xác thực**: BR2 cho chủ email Google vào tài khoản đó, người tạo cũ vẫn giữ mật khẩu → hai người cùng vào một tài khoản / thấy dữ liệu của nhau; tài liệu không có quy tắc | P9, P3 | Cao nếu xảy ra (bảo mật, dữ liệu — cần người có thẩm quyền) | phân tích tài liệu | BR1, BR2, AC4, E-21 · `EPIC:28`, `EPIC:98` · Q-17 · case: chưa có |
| CX-14 | Improvement Suggestion | Lối "Đặt mật khẩu" trong app cho tài khoản Google (không phải đăng xuất rồi đi Quên mật khẩu) | P6 | Trung bình | phân tích tài liệu | BR6, AC9, AC8 · CX-06, CX-07 · Unlinked với AC (không có requirement) |

Số lượng theo loại: Defect **0** · Usability Issue **4** (CX-02, 07, 09, 11) · CX Risk **9** (CX-01, 03, 04, 05, 06, 08, 10, 12,
13) · Improvement Suggestion **1** (CX-14). Tổng **14**.

Impact là **đề xuất của CX** kèm lý do ở từng finding; người có thẩm quyền (PdM Hường / BA Chình) chốt severity.

## 5. Chi tiết finding

### CX-01 — Bấm "Đăng nhập bằng Google" với email khác tài khoản đang có → tài khoản thứ hai, không gộp lại được

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-01 |
| Review scope | Màn 01 nút "Đăng nhập bằng Google" → nhánh "Chưa có tài khoản" (Android/Web) → màn thành công → ChatGoni; sau đó Thông tin tài khoản của tài khoản cũ |
| Source evidence | `US9:47` BR3 "Android, Web: email Google chưa có tài khoản → tạo tài khoản mới" · `US9:62` AC3 · `US9:59` AC1 nhãn "Đăng nhập bằng Google" ở màn đăng nhập · user flow `US9:23` (không có bước xác nhận trước "Tạo tài khoản") · `EPIC:96` "Mỗi SĐT và mỗi email chỉ gắn với một tài khoản" · `US5:8` "người đăng ký bằng SĐT chưa có email" · `US5:53` BR4 "SĐT/email đã thuộc tài khoản khác → không cho lưu" · `US5:72` AC7 "… đã được dùng cho một tài khoản khác" · `US9:19` hủy liên kết Google ngoài phạm vi · `US5:18` xóa SĐT/email ngoài phạm vi · Q-05 (b) có màn thành công |
| Persona và context | P4 (đã đăng ký bằng SĐT — persona giả thuyết về việc bấm Google); P7 (nhiều tài khoản Google, chọn nhầm — persona giả thuyết) |
| Customer journey / scenario | J3 — muốn đăng nhập nhanh, chọn nút Google ở màn đăng nhập |
| Observation | `[CX GIẢ THUYẾT]` Nút ở màn 01 mang nhãn "Đăng nhập", người dùng bấm với ý định vào tài khoản cũ. Theo BR3, nếu email Google không trùng email của tài khoản nào thì hệ thống tạo tài khoản mới, không hỏi lại. Tín hiệu duy nhất là màn thành công (Q-05 (b)) — nhưng người dùng đã "lỡ" tạo xong. Hậu quả nối tiếp có căn cứ trong tài liệu: email Google giờ thuộc tài khoản mới (`EPIC:96`), nên tài khoản SĐT cũ không thêm được email này (`US5:53`, `US5:72`); không có hủy liên kết (`US9:19`) hay xóa email (`US5:18`). Người dùng có hai tài khoản, dữ liệu tách đôi, workspace mới trống. Đây là hành vi **đúng requirement**, điểm CX là thiếu cảnh báo và không có đường phục hồi. |
| Finding type | CX Risk (rủi ro giả định) |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — requirement không yêu cầu cảnh báo hay xác nhận; không có quan sát thực tế |
| Impact | Cao — mất niềm tin ("mất dữ liệu"), tài khoản rác gắn vĩnh viễn với email người dùng, cần hỗ trợ thủ công. Lý do mức: hậu quả không tự phục hồi được trong phạm vi tài liệu |
| Evidence và confidence / limitations | Chuỗi hậu quả có nguồn đầy đủ; tần suất người dùng SĐT bấm Google không có dữ liệu. Nội dung màn thành công cho Google chưa định nghĩa (CX-12) — nếu màn đó ghi rõ email Google vừa dùng, rủi ro giảm một phần |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-01: trước khi tạo tài khoản từ nút ở **màn 01**, hoặc ngay trên màn thành công, hiện email Google vừa dùng và một câu "Nếu bạn đã có tài khoản bằng số điện thoại / email khác, hãy đăng nhập bằng cách đó" kèm lối quay lại. Không đổi BR3. QA: ĐO & GHI toàn chuỗi J3 trên build (có cảnh báo gì không; thêm email Google vào tài khoản SĐT sau đó báo gì) |
| Traceability | BR2 `US9:46`, BR3 `US9:47` · AC1, AC3 · E-01 · UC-01 · `US5:53`, `US5:72` · case: chưa có |
| Open questions / quyết định cần Product · BA · UX | Product (Hường): có muốn bước xác nhận / cảnh báo khi tạo tài khoản từ màn đăng nhập không; hỗ trợ gộp tài khoản thủ công có quy trình không |

### CX-02 — Thông báo AC5 không cho biết email nào đã kiểm; "chưa tồn tại" gây hiểu nhầm

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-02 |
| Review scope | iOS màn 01 sau khi chọn tài khoản Google (màn 21) |
| Source evidence | `US9:64` AC5 nguyên văn "Tài khoản chưa tồn tại. Vui lòng đăng ký trên web hoặc ứng dụng Android." · wireframe màn 21 (`US9:30`): khung đỏ phía trên ô nhập, ở lại màn đăng nhập, nút Google còn · Q-01 (a) `[ĐÃ XÁC NHẬN]` · 02 §4 #23 · Q-19 (hiển thị, mất khi nào — mở) |
| Persona và context | P2 (iOS chưa có tài khoản); P4 (có tài khoản bằng SĐT — persona giả thuyết); P7 (chọn nhầm tài khoản Google — persona giả thuyết) |
| Customer journey / scenario | J4, J3 nhánh iOS |
| Observation | `[CX GIẢ THUYẾT]` Màn chọn tài khoản của hệ điều hành đóng lại, người dùng chỉ thấy câu thông báo. Câu không nhắc email đã chọn, nên người có hai tài khoản Google không biết mình chọn nhầm; người có tài khoản bằng SĐT đọc "Tài khoản chưa tồn tại" như tài khoản của họ không còn, trong khi thực tế là "email Google này chưa gắn với tài khoản nào". Câu cũng không gợi ý lối đúng cho P4 (đăng nhập bằng SĐT + mật khẩu ở ngay màn này). |
| Finding type | Usability Issue |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — nguyên văn AC5 đã chốt; không có quan sát thực tế |
| Impact | Trung bình — gây hoảng / hiểu sai, dẫn tới CX-01 (đi đăng ký trên web thành tài khoản thứ hai) hoặc CX-03 |
| Evidence và confidence / limitations | Câu chữ có nguồn; hình thức (banner / popup), thời điểm mất, nút Google bấm lại được không còn mở (Q-19) |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-02: thông báo có email Google đã chọn (che một phần nếu cần) và câu phụ "Bạn đã có tài khoản bằng số điện thoại hoặc email khác? Đăng nhập ở trên." / "Thử tài khoản Google khác". Câu chữ do Product/UX; giữ BR4 không tạo tài khoản. QA: kiểm nguyên văn AC5 theo `US9:64`; ĐO & GHI có hiện email không, bấm Google lại chọn tài khoản khác được không |
| Traceability | BR4 `US9:48` · AC5 `US9:64` · UC-03 · Q-19 · case: chưa có |
| Open questions / quyết định cần Product · BA · UX | Product / UX: câu AC5 có thêm email và gợi ý không (đổi nguyên văn đã xác nhận → cần BA cập nhật nếu đồng ý) |

### CX-03 — iOS: "đăng ký trên web hoặc ứng dụng Android" nhưng không có lối đi

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-03 |
| Review scope | iOS màn 21 → bước tiếp theo của người dùng |
| Source evidence | `US9:64` AC5 · `US9:48` BR4 · `EPIC:31`, `EPIC:108` iOS không có đường nào vào đăng ký · `BUG10:28` "Trên iOS không có đường nào tới màn/nút đăng ký – kể cả back, link trong trang, deep link" · `BUG10:36` AC3 mở link đăng ký trực tiếp trên iOS không vào được · wireframe 21 "Không có link Đăng ký" |
| Persona và context | P2 — chỉ dùng iPhone, không có máy Android (persona giả thuyết phục vụ review) |
| Customer journey / scenario | J4 |
| Observation | `[CX GIẢ THUYẾT]` Câu thông báo chỉ hướng chung "trên web hoặc ứng dụng Android", không có địa chỉ trang, không có nút. Người chỉ có iPhone phải tự đoán tên miền, mở trình duyệt, tìm trang đăng ký, đăng ký (bằng Google), rồi quay lại app. Ràng buộc BUG10 / Apple giải thích vì sao không có link — điểm CX là hành trình iOS cho người mới **dừng ở màn 01** trừ khi người dùng tự tìm được web. |
| Finding type | CX Risk (rủi ro giả định) |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — hành vi đúng requirement; không có quan sát thực tế |
| Impact | Cao với nhóm người mới chỉ có iPhone — bỏ dở hoàn toàn; không ảnh hưởng nhóm đã có tài khoản |
| Evidence và confidence / limitations | Ràng buộc có nguồn. Việc ghi tên miền dạng chữ (không phải link) có vi phạm hướng Apple đã duyệt không — CX không đánh giá được, cần Product / người phụ trách App Review |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-03: Product cân nhắc câu hướng dẫn cụ thể hơn trong giới hạn BUG10 / Apple (vd nêu tên ứng dụng / trang dạng chữ, không link), hoặc giữ nguyên và chấp nhận rủi ro. Không đề xuất thêm link đăng ký (trái `BUG10:28`) |
| Traceability | BR4, AC5 · E-06 · UC-03 · `BUG10:28`, `BUG10:36` · case: chưa có |
| Open questions / quyết định cần Product · BA · UX | Product (Hường) + người phụ trách App Review: được phép ghi gì trong câu hướng dẫn |

### CX-04 — Màn 01 tạo được tài khoản nhưng không có dòng Điều khoản / Chính sách bảo mật

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-04 |
| Review scope | Màn 01 "Đăng nhập bằng Google" → AC3 (tạo tài khoản) |
| Source evidence | Figma `figma/US3_1634-21845_dangnhap.png`: từ trên xuống — logo, "Đăng nhập", ô nhập, Lưu đăng nhập, Quên mật khẩu, nút Đăng nhập, "Hoặc", "Đăng nhập bằng Google", "Chưa có tài khoản? Đăng ký" — **không có** dòng Điều khoản · Figma `figma/US6_1641-50276_nhap-email.png`: dưới "Tiếp tục với Google" có "Bằng việc đăng ký, bạn đồng ý với Điều khoản và Chính sách bảo mật" · wireframe `US9:30` màn 01 không có, màn 05a/11 có · user flow `US9:23` nút ở màn 01 dẫn được tới "Tạo tài khoản" · `US9:62` AC3 |
| Persona và context | P1 bấm Google ngay ở màn 01 (cách ngắn nhất); P4 bấm nhầm (CX-01) |
| Customer journey / scenario | J1 nhánh bắt đầu từ màn 01 |
| Observation | `[NGUỒN]` design: dòng đồng ý chỉ có ở màn đăng ký. `[CX GIẢ THUYẾT]` Người dùng tạo tài khoản qua màn 01 không được thấy Điều khoản / Chính sách ở bất kỳ màn Gopany nào (màn thành công chưa có nội dung — CX-12). Màn chọn tài khoản Google có hiện chính sách của ứng dụng hay không phụ thuộc cấu hình Google, tài liệu không nói. |
| Finding type | CX Risk (rủi ro giả định) |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — tài liệu không có requirement về đồng ý Điều khoản trong luồng Google |
| Impact | Trung bình–Cao — niềm tin và có thể pháp lý (đánh giá pháp lý ngoài thẩm quyền CX). Lý do mức: chạm toàn bộ người đăng ký mới qua màn 01 |
| Evidence và confidence / limitations | Hai ảnh Figma đã xem; chưa xem frame màn 01 khác (`1725:10310`, `1725:10598`) bằng ảnh — lớp text của chúng cũng không có dòng Điều khoản |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-04: thêm dòng đồng ý dưới nút Google ở màn 01 (Android/Web) hoặc trên màn thành công của luồng Google. Product + pháp chế quyết |
| Traceability | AC1 `US9:59`, AC3 `US9:62` · UC-01 bước 1 · Figma `1634:21845`, `1641:50276` · case: chưa có |
| Open questions / quyết định cần Product · BA · UX | Product (Hường) / pháp chế: tài khoản tạo từ màn 01 có cần hiển thị Điều khoản không |

### CX-05 — Người được mời chưa đăng ký: vào workspace mới, không thấy workspace đã mời

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-05 |
| Review scope | Android/Web AC3 và iOS AC5 với email được mời |
| Source evidence | Q-02 (c) `[ĐÃ XÁC NHẬN]` PdM Hường: "Chưa có tài khoản: Android/Web tạo mới → workspace mới, lời mời xử lý riêng; iOS → AC5" · 02 §4 #18 ("lời mời cũ còn chờ hay mất — tài liệu không nói → ĐO & GHI") · `EPIC:136` hiện chỉ mời bằng email · `US5:8`, `US5:12` (mục tiêu "được mời vào workspace") · US6 CX-10 (cùng nhóm, luồng email, lúc Q-01 US6 còn mở) |
| Persona và context | P5 |
| Customer journey / scenario | J5 |
| Observation | `[CX GIẢ THUYẾT]` Người này mở Gopany **vì** có lời mời. Theo (c), sau màn thành công họ vào workspace mới trống; không có câu nào trong tài liệu cho biết lời mời hiện ở đâu, có thông báo, có nút "Tham gia" hay không ("xử lý riêng"). Trên iOS câu "Tài khoản chưa tồn tại" mâu thuẫn với trải nghiệm vừa nhận email mời. Điểm khác US6 CX-10: ở US9 cách hiểu đã được BA chốt, nên rủi ro nằm ở phần **người dùng thấy gì sau đó**. |
| Finding type | CX Risk (rủi ro giả định) |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — "xử lý riêng" chưa có requirement về hiển thị |
| Impact | Cao — mục tiêu chính của persona thất bại; người mời cũng không thấy đồng nghiệp vào |
| Evidence và confidence / limitations | Quyết định có nguồn; phần hiển thị lời mời hoàn toàn chưa có tài liệu |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-05: sau khi tạo tài khoản, nếu email có lời mời đang chờ → hiện thông báo / lối "Tham gia workspace <tên>" trên màn thành công hoặc ChatGoni. QA: ĐO & GHI lời mời sau AC3 (theo 02 §4 #18) |
| Traceability | BR2 `US9:46`, AC3, AC5 · Q-02 (c) · 02 §4 #18, #23 · US6 CX-10 · case: chưa có |
| Open questions / quyết định cần Product · BA · UX | BA / Product: "lời mời xử lý riêng" — người dùng thấy và chấp nhận lời mời ở đâu (mục 7 #6) |

### CX-06 — Thêm SĐT ở Thông tin tài khoản (Q-04 (b)): hành trình dài, phải rời luồng và bị đăng xuất

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-06 |
| Review scope | Thông tin tài khoản → Thêm SĐT với tài khoản Google chưa có mật khẩu |
| Source evidence | Q-04 (b) `[ĐÃ XÁC NHẬN]` "Bắt đặt mật khẩu trước qua Quên mật khẩu" · 02 §4 #19 (luồng đầy đủ) · Q-04b mở (thông báo, có link thẳng không) · `US4:62` AC1 "Bấm 'Quên mật khẩu' ở **màn đăng nhập**" · `US5:18` đổi mật khẩu ngoài phạm vi US5 · `US4:50` BR4 đăng xuất mọi thiết bị, về màn đăng nhập không tự đăng nhập · `US4:73` "Đổi mật khẩu thành công. Vui lòng đăng nhập lại." · `US5:52`, `US5:69` màn 09 nhập mật khẩu hiện tại · `US7:63`, `US7:72`, `US7:75` luồng ChatGoni · `US7:83` luồng 18 không hỏi mật khẩu (câu hỏi mở US7) · `US9:49` BR5 |
| Persona và context | P6 — dùng điện thoại, muốn thêm SĐT để hết hạn mức thấp |
| Customer journey / scenario | J8 |
| Observation | `[CX GIẢ THUYẾT]` Đếm theo tài liệu (CX tự đếm, không phải requirement): (1) Menu → (2) Thông tin tài khoản → (3) Thêm → (4) thông báo phải đặt mật khẩu → (5) tới Quên mật khẩu — tài liệu chỉ ghi lối vào ở màn đăng nhập, nên nếu thông báo Q-04b không có link thẳng thì người dùng phải **tự đăng xuất** → (6) nhập email Google → (7) rời app mở hộp thư lấy OTP → (8) nhập OTP → (9) nhập 2 ô mật khẩu theo quy định → (10) Lưu → "Vui lòng đăng nhập lại" → (11) đăng nhập lại → (12) Menu → Thông tin tài khoản → Thêm → (13) màn 09 nhập mật khẩu vừa đặt + SĐT → (14) rời app sang Zalo lấy OTP → (15) nhập OTP. Cùng lúc mọi thiết bị khác bị đăng xuất (CX-08). Cùng mục tiêu "thêm SĐT", đường qua ChatGoni chỉ cần popup → SĐT → OTP. Người dùng không được tài liệu nói cho biết có đường ngắn này khi đứng ở Thông tin tài khoản. |
| Finding type | CX Risk (rủi ro giả định) |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — luồng (b) đúng quyết định BA; hình thức thông báo còn mở (Q-04b) |
| Impact | Cao — nguy cơ bỏ dở giữa chừng (ba lần rời app / đăng nhập lại), người dùng ở lại hạn mức thấp (BR5); có thể khiến người dùng nghĩ app lỗi khi bị đẩy về màn đăng nhập |
| Evidence và confidence / limitations | Các bước có nguồn từng đoạn; số bước thực tế phụ thuộc Q-04b (có link thẳng sang Quên mật khẩu, có điền sẵn email không). CX **không chọn** hình thức Q-04b |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-06: thông báo khi bấm Thêm (Q-04b) có hai lối: "Xác thực SĐT qua ChatGoni (không cần mật khẩu)" và "Đặt mật khẩu" mở thẳng luồng US4 với email điền sẵn, không bắt đăng xuất; nói trước "sau khi đặt mật khẩu bạn sẽ cần đăng nhập lại". QA: ĐO & GHI số bước và lối vào Quên mật khẩu khi đang đăng nhập |
| Traceability | BR5 `US9:49`, BR6 `US9:50`, BR7 `US9:51`, AC8 `US9:68` · UC-04 (b) · Q-04 (b), Q-04b · 02 §4 #7, #19 · CX-07, CX-08, CX-14 · case: chưa có |
| Open questions / quyết định cần Product · BA · UX | Câu hỏi cách hiểu: người đang đăng nhập vào Quên mật khẩu bằng cách nào (mục 7 #2). Product / UX: nội dung thông báo Q-04b |

### CX-07 — Đặt mật khẩu lần đầu qua "Quên mật khẩu": câu chữ dọc đường sai ngữ cảnh

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-07 |
| Review scope | Luồng US4 khi dùng cho tài khoản Google chưa có mật khẩu (AC9, Q-04 (b)) |
| Source evidence | `US9:50` BR6 "đặt mật khẩu qua Quên mật khẩu" · `US4:52` BR6 · `US4:62` AC1 câu hướng dẫn "Nhập email hoặc số điện thoại đã đăng ký…" · Figma lớp text `1872:4430` email: tiêu đề "Đặt lại mật khẩu", "Chúng tôi nhận được yêu cầu đặt lại mật khẩu…", "Nếu bạn không yêu cầu đặt lại mật khẩu, hãy bỏ qua email này. Mật khẩu hiện tại của bạn không thay đổi." · Figma `1754:6468` / `1641:22759` / `1754:6840` "Đặt mật khẩu mới — Mật khẩu mới dùng để đăng nhập bằng cả email và số điện thoại" · `US4:73` AC10 "Đổi mật khẩu thành công. Vui lòng đăng nhập lại." · `US4:74` AC11 "mật khẩu cũ không dùng được" |
| Persona và context | P6 |
| Customer journey / scenario | J9, J8 bước 5–10 |
| Observation | `[CX GIẢ THUYẾT]` (1) Người chưa từng có mật khẩu khó nghĩ tới nút "Quên mật khẩu" là nơi **tạo** mật khẩu — BR6 dựa hoàn toàn vào việc người dùng biết điều này. (2) Email nói "mật khẩu hiện tại của bạn không thay đổi" với người không có mật khẩu; (3) màn đặt mật khẩu nói "đăng nhập bằng cả email và số điện thoại" với tài khoản chưa có SĐT; (4) "Đổi mật khẩu thành công" với người vừa đặt lần đầu. Mỗi câu nhỏ, nhưng cộng lại làm người dùng nghi mình đang ở nhầm luồng / tài khoản. |
| Finding type | Usability Issue |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — luồng dùng chung US4; không có requirement câu chữ riêng cho tài khoản Google |
| Impact | Trung bình — giảm khả năng tự tìm ra AC9, tăng nghi ngờ; không chặn hành trình nếu người dùng đi tiếp |
| Evidence và confidence / limitations | Câu chữ email và màn 04 từ lớp text Figma (không có ảnh); nút trong instance không đọc được |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-07: biến thể câu chữ khi tài khoản chưa có mật khẩu ("Đặt mật khẩu", "Đặt mật khẩu thành công"), hoặc ít nhất bỏ các câu ngụ ý đã có mật khẩu / đã có SĐT. Đi kèm CP-11 (lối riêng) |
| Traceability | BR6, AC9 · UC-05 · `US4:62`, `US4:73-74` · Figma `1872:4430`, `1754:6468` · CX-14 · case: chưa có |
| Open questions / quyết định cần Product · BA · UX | UX Hiếu / BE Chiến (mẫu email): có biến thể cho tài khoản chưa có mật khẩu không |

### CX-08 — Đặt mật khẩu lần đầu đăng xuất mọi thiết bị, kể cả phiên Google, không có lời giải thích

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-08 |
| Review scope | Sau AC9 trên các thiết bị khác đang đăng nhập bằng Google |
| Source evidence | E-15 `[ĐÃ XÁC NHẬN]` (US4 Q-05): đăng xuất mọi thiết bị gồm phiên Google, ở lần gọi API kế tiếp · 02 §4 #9 (điện thoại "không tự văng ngay", về màn đăng nhập ở lần gọi API kế tiếp) · `US4:50` BR4 · `US4:74` AC11 · Q-04 (b) biến việc đặt mật khẩu thành bước bắt buộc để thêm SĐT ở Thông tin tài khoản |
| Persona và context | P6 — đặt mật khẩu trên web, điện thoại vẫn đang mở app |
| Customer journey / scenario | J8, J9 sau bước Lưu |
| Observation | `[CX GIẢ THUYẾT]` Với người đổi mật khẩu vì quên, đăng xuất mọi nơi là điều họ hiểu được. Với người **đặt lần đầu** (không có mật khẩu cũ bị lộ) — đặc biệt khi chỉ để thêm SĐT — việc điện thoại đang dùng Google bỗng về màn đăng nhập lúc đang chat là bất ngờ. Tài liệu không có câu nào báo trước (trên màn đặt mật khẩu) hay giải thích sau (trên thiết bị bị đăng xuất). Người dùng có thể nghĩ bị hack hoặc app lỗi. |
| Finding type | CX Risk (rủi ro giả định) |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — hành vi đúng quyết định BA; không có requirement về thông báo |
| Impact | Trung bình — gián đoạn, mất niềm tin; phục hồi được bằng đăng nhập Google lại |
| Evidence và confidence / limitations | Quyết định có nguồn; màn đăng nhập sau khi bị đăng xuất có thông báo gì — tài liệu không nói |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-08: màn đặt mật khẩu báo trước "các thiết bị khác sẽ phải đăng nhập lại"; thiết bị bị đăng xuất hiện câu "Mật khẩu tài khoản vừa được đặt / đổi, vui lòng đăng nhập lại". Không đổi BR4 US4 |
| Traceability | BR6, AC9 · E-15 · 02 §4 #9 · `US4:50`, `US4:74` · case: chưa có |
| Open questions / quyết định cần Product · BA · UX | Product: có thông báo khi phiên bị đăng xuất do đổi mật khẩu không (chạm US4, màn dùng chung) |

### CX-09 — AC10: gợi ý "đăng nhập bằng email/SĐT" là ngõ cụt với người chỉ có Google

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-09 |
| Review scope | Màn báo lỗi AC10 ở màn 01 và màn 05a/11 |
| Source evidence | `US9:71` AC10 "Báo lỗi tiếng Việt, cho thử lại; gợi ý đăng nhập bằng email/SĐT" · user flow `US9:23` "Báo lỗi, cho thử lại, gợi ý đăng nhập email/SĐT · AC10" (cả khi bắt đầu từ màn đăng ký) · `US9:50` BR6 tài khoản Google không có mật khẩu · `US3:56` AC5 US3 · 02 §4 #14 ("có gợi ý đăng nhập email/SĐT"), #15 ("gợi ý … không dùng được với tài khoản chỉ có Google → để CX review") · `01` mục 8 #11 · `TB:43` "Dùng chung — Các màn liên quan — Đã xảy ra lỗi. Vui lòng kiểm tra và thử lại." · Q-09, Q-18 mở |
| Persona và context | P8 gặp lỗi; trong đó (a) người chỉ có tài khoản Google (P6), (b) người mới đang đăng ký ở 05a/11 (P1) |
| Customer journey / scenario | J7 |
| Observation | `[CX GIẢ THUYẾT]` (a) Người chỉ có Google theo gợi ý → màn 01 gõ email + mật khẩu → "không đúng" (họ không có mật khẩu) → vòng lặp; gợi ý đúng cho họ là "thử lại Google" hoặc "đặt mật khẩu qua Quên mật khẩu". (b) Người chưa có tài khoản bấm "Tiếp tục với Google" ở màn đăng ký gặp lỗi → gợi ý "đăng nhập" không áp dụng; lối thật là đăng ký bằng SĐT/email ngay trên màn đó. (c) Nếu FE dùng câu dùng chung `TB:43` cho AC10 (Q-09 chưa chốt), "kiểm tra" không nói kiểm gì, không phân biệt mất mạng với Google lỗi; người dùng không biết nên đợi mạng hay đổi cách. (d) Android không có tài khoản Google (Q-18) — gợi ý "đăng nhập email/SĐT" là lối đúng cho người đã có tài khoản, nhưng không cho người mới. |
| Finding type | Usability Issue |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — AC10 không có nguyên văn (Q-09); không có quan sát thực tế |
| Impact | Trung bình–Cao — với nhóm (a) là vòng lặp không thoát; với (b) mất người đăng ký mới ở bước đầu |
| Evidence và confidence / limitations | Câu AC10 có nguồn; nguyên văn và vị trí lỗi chưa có; `TB` không có dòng nào cho US9 nên việc AC10 dùng `TB:43` chỉ là khả năng, CX không chọn |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-09: câu lỗi tách "mất kết nối mạng" / "không kết nối được Google"; gợi ý theo ngữ cảnh — ở màn đăng nhập: "Thử lại" + "Đăng nhập bằng email/SĐT" + "Quên mật khẩu?"; ở màn đăng ký: "Thử lại" + "Đăng ký bằng số điện thoại / email". QA: ĐO & GHI nguyên văn ở từng thời điểm lỗi (02 §4 #14) và đích đến của gợi ý |
| Traceability | AC10 `US9:71`, BR6 · UC-01/UC-02 E-1 · Q-09, Q-18 · 02 §4 #14–#15 · `TB:43` · case: chưa có |
| Open questions / quyết định cần Product · BA · UX | BA (Q-09): nguyên văn AC10 — có dùng `TB:43` không (mục 7 #3) |

### CX-10 — Không có trạng thái đang xử lý; popup bị chặn; mất mạng giữa chừng không biết tài khoản đã tạo chưa

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-10 |
| Review scope | Khoảng giữa "chọn tài khoản Google" và kết quả (AC3 / AC4 / AC5 / AC10) |
| Source evidence | User flow `US9:23` (chọn tài khoản → quyết định BR2, không có trạng thái chờ) · wireframe `US9:30` và `01` §6d: không vẽ màn chọn tài khoản, màn lỗi AC10, trạng thái đang xử lý · 02 §4 #14 (3) "chọn xong, tắt mạng khi app đang gọi BE … tài khoản đã tạo chưa … ĐO & GHI" · 02 §4 #15 (c) "web chặn popup hoặc tắt cookie bên thứ ba" · 02 §4 #20 tài khoản tạo trước màn thành công · Q-05b, Q-13 |
| Persona và context | P8 — mạng chậm, trình duyệt chặn popup |
| Customer journey / scenario | J7, J1 sau bước chọn tài khoản |
| Observation | `[CX GIẢ THUYẾT]` Màn chọn tài khoản đóng, app gọi BE; nếu không có chỉ báo đang xử lý và nút Google không bị khóa, người dùng bấm lại (mở màn chọn lần hai) hoặc thoát app. Trên web, nếu trình duyệt chặn cửa sổ Google mà app không phát hiện, bấm nút "không có gì xảy ra" — không phải AC6 cũng không phải AC10. Mất mạng ở thời điểm (3): theo 02 §4 #20 tài khoản có thể đã tạo; lần sau bấm Google người dùng không thấy màn thành công (AC4) mà không hiểu vì sao, hoặc rơi vào đích chưa rõ của Q-05b. |
| Finding type | CX Risk (rủi ro giả định) |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — không có requirement về trạng thái chờ |
| Impact | Trung bình — gây thao tác lặp, bỏ dở; với web chặn popup có thể là thất bại không lời giải thích |
| Evidence và confidence / limitations | Thiếu trên mọi nguồn design đã xem; hành vi thật chưa kiểm |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-10: Design bổ sung trạng thái đang xử lý (khóa nút, chỉ báo) sau khi chọn tài khoản; web phát hiện popup bị chặn → báo theo AC10. QA: ĐO & GHI bấm Google hai lần liên tiếp, chặn popup trên Chrome/Safari (02 §4 #15 (c)) |
| Traceability | AC3, AC4, AC10 · Q-05b, Q-09, Q-13 · 02 §4 #14, #15, #20 · case: chưa có |
| Open questions / quyết định cần Product · BA · UX | Design Hiếu: trạng thái chờ và lỗi popup trên web |

### CX-11 — Thông tin tài khoản không giải thích vì sao không đổi được email, không cho thấy tài khoản chưa có mật khẩu

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-11 |
| Review scope | Màn 08 Thông tin tài khoản của tài khoản Google (AC8) |
| Source evidence | `US9:68` AC8 "Email hiện 'Đã xác thực' (gắn Google, không có nút Đổi); SĐT hiện 'Chưa có' với nút Thêm" · user flow `US9:23` khung "email gắn Google Đã xác thực, không có nút Đổi" · 02 §4 #10 expected AC8 (không nhắc chữ "Google" trên màn) · `US5:56` "Cần đổi email → liên hệ hỗ trợ" · `US5:66` AC2 · `US9:50` BR6 · Q-04 (b) · `01` §6d: Figma không có Thông tin tài khoản của tài khoản Google |
| Persona và context | P6 |
| Customer journey / scenario | J8 bước 2–4 |
| Observation | `[CX GIẢ THUYẾT]` Dòng email chỉ có "Đã xác thực", không nút Đổi; nếu màn không ghi "gắn với Google" và "cần đổi → liên hệ hỗ trợ" thì người dùng không biết đây là giới hạn có chủ ý. Màn cũng không cho thấy tài khoản đăng nhập bằng gì và **chưa có mật khẩu**, nên khi bấm Thêm SĐT bị yêu cầu đặt mật khẩu (Q-04 (b)) là bất ngờ. Chữ "(gắn Google, …)" trong AC8 có thể là nhãn hiển thị hoặc chỉ là chú thích — xem mục 7 #1. |
| Finding type | Usability Issue |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — chưa rõ "gắn Google" có phải chữ hiển thị (mục 7 #1); không có quan sát thực tế |
| Impact | Thấp–Trung bình — gây thắc mắc, góp phần vào CX-06 |
| Evidence và confidence / limitations | Không có design màn này cho tài khoản Google |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-11 (gộp với CX-14): dòng email ghi "Đăng nhập bằng Google · không đổi được — liên hệ hỗ trợ"; thêm dòng "Mật khẩu: Chưa đặt — Đặt mật khẩu" |
| Traceability | AC8 `US9:68`, BR6, BR7 · 02 §4 #10 · `US5:56`, `US5:66` · case: chưa có |
| Open questions / quyết định cần Product · BA · UX | BA: "gắn Google" có là chữ trên màn không (mục 7 #1) |

### CX-12 — Màn thành công cho Google chưa có nội dung; frame US6 không dùng lại được

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-12 |
| Review scope | Màn thành công + "Bắt đầu sử dụng" của luồng Google (Q-05 (b)) |
| Source evidence | Q-05 (b) `[ĐÃ XÁC NHẬN]` "Có màn thành công + nút 'Bắt đầu sử dụng' như US1/US6; workspace tạo khi bấm nút" · 02 §4 #20 · `US1:68` AC10 US1 (tên hiển thị = SĐT + gợi ý đổi tên) · Figma lớp text `1641:50321` (US6): "Đăng ký thành công — Tài khoản của bạn đã được tạo với số điện thoại +84 912 345 678. — Tên hiển thị: nguyenvana@congty.vn — bạn có thể đổi trong: Tài khoản → Thông tin tài khoản" · `US9:47` BR3 họ tên = tên Google · `US9:49` chưa có SĐT · Q-05b (đích khi chưa bấm nút), Q-11 (tên Google trống / dài) · US6 CX-06, CX-15 |
| Persona và context | P1; P4 (vừa lỡ tạo tài khoản — CX-01) |
| Customer journey / scenario | J1 bước sau khi chọn tài khoản; J3 |
| Observation | `[NGUỒN]` Tài liệu US9 không mô tả nội dung màn này; design chỉ có frame của US6. `[CX GIẢ THUYẾT]` Nếu FE dùng lại frame US6, người dùng Google sẽ đọc "được tạo với số điện thoại …" (họ không nhập SĐT) và "Tên hiển thị: <email>" (trái BR3). Tên Google trống / quá dài (Q-11) hiện thế nào trên màn này chưa rõ. Màn này cũng là chỗ duy nhất có thể nói cho P4 biết họ vừa tạo **tài khoản mới** bằng email nào (CX-01). Thoát ở màn này mà chưa bấm nút → lần sau vào đâu (Q-05b) — cùng rủi ro US6 CX-06, không lặp. |
| Finding type | CX Risk (rủi ro giả định) |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — nội dung màn chưa có requirement |
| Impact | Trung bình — nhầm lẫn / mất niềm tin ngay bước thành công nếu tái dùng sai; bỏ lỡ cơ hội giảm CX-01, CX-04 |
| Evidence và confidence / limitations | Frame US6 chỉ có lớp text (ảnh nằm ở thư mục US6); không có frame cho Google |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-12: màn thành công Google ghi "Tài khoản đã được tạo với Google <email>", "Tên hiển thị: <tên Google>", dòng Điều khoản (CP-04), câu phụ cho người đã có tài khoản khác (CP-01). Nội dung do BA/Design |
| Traceability | BR3, AC3 · Q-05 (b), Q-05b, Q-11 · 02 §4 #20 · Figma `1641:50321` · US6 CX-06, CX-15 · case: chưa có |
| Open questions / quyết định cần Product · BA · UX | BA / Design: nội dung màn thành công của luồng Google (mục 7 #5) |

### CX-13 — Tài khoản form cũ có email chưa xác thực: chủ email Google và người tạo cũ cùng vào một tài khoản

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-13 |
| Review scope | AC4 với loại tài khoản (2) "form cũ, email chưa xác thực" (02 §4 #2) |
| Source evidence | `EPIC:28` "Form đăng ký email dài … và **không xác thực** email/SĐT" · `US9:46` BR2 "Email Google trùng email của tài khoản đã có (đăng ký email, **form cũ**, được mời) → đăng nhập vào tài khoản đó" · `US9:45` BR1 email Google = đã xác thực · `EPIC:98` không có trạng thái "Chưa xác thực" · 02 §4 #2 loại (2) · Q-17 (AC8 hiện gì — chỉ hỏi hiển thị) · `01` mục 8 #14 |
| Persona và context | P9 — chủ thật của email; người tạo tài khoản form cũ là người khác (gõ nhầm / cố ý) — persona giả thuyết phục vụ review |
| Customer journey / scenario | J10 |
| Observation | `[CX GIẢ THUYẾT]` Form cũ không xác thực email, nên một tài khoản có thể mang email của người khác. Khi chủ thật bấm Google, BR2 cho họ vào tài khoản đó: họ thấy tên, hội thoại, workspace của người lạ; người tạo cũ vẫn đăng nhập được bằng email + mật khẩu họ đã đặt. Tài liệu không nói mật khẩu cũ có bị vô hiệu, có thông báo, hay có cách tách tài khoản. Đây là rủi ro bảo mật / dữ liệu theo `10-human-in-the-loop` §1 — CX không tự đánh giá mức, chỉ nêu để người có thẩm quyền quyết. |
| Finding type | CX Risk (rủi ro giả định) |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — tài liệu không có quy tắc cho trường hợp này |
| Impact | Cao nếu xảy ra — lộ dữ liệu giữa hai người, mất niềm tin nghiêm trọng; tần suất phụ thuộc dữ liệu form cũ (không có số liệu) |
| Evidence và confidence / limitations | Các mảnh có nguồn; tần suất và cách BE xử lý thật chưa biết |
| Recommendation | Không đề xuất CP — chuyển Debate (mục 7 #4) để BA / BE / Product quyết quy tắc; QA đề xuất dữ liệu test: tài khoản form cũ có mật khẩu, đăng nhập Google bằng cùng email → ĐO & GHI mật khẩu cũ còn dùng được không |
| Traceability | BR1, BR2, AC4 · E-21 · 02 §4 #2 loại (2) · Q-17 · case: chưa có |
| Open questions / quyết định cần Product · BA · UX | BA / BE Chiến / Product: xem mục 7 #4; Hồng xét mức trọng yếu |

### CX-14 — Lối "Đặt mật khẩu" trong app cho tài khoản Google

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-14 |
| Review scope | Thông tin tài khoản / menu Tài khoản của tài khoản Google |
| Source evidence | `US9:50` BR6 · `US4:62` lối vào Quên mật khẩu ở màn đăng nhập · `US5:18` đổi mật khẩu ngoài phạm vi US5 · Q-04 (b) · CX-06, CX-07, CX-11 |
| Persona và context | P6 |
| Customer journey / scenario | J8, J9 |
| Observation | `[CX GIẢ THUYẾT]` Mọi đường để tài khoản Google có mật khẩu đều đi qua "Quên mật khẩu" ở màn đăng nhập. Một lối "Đặt mật khẩu" ngay trong app (dùng lại màn OTP email + màn 04 của US4) sẽ rút ngắn J8, J9, bỏ nhu cầu đăng xuất, và khớp câu chữ với người chưa có mật khẩu. |
| Finding type | Improvement Suggestion |
| Steps to reproduce | N/A — đề xuất |
| Expected vs observed | N/A — không có requirement |
| Impact | Trung bình — giảm bỏ dở cho CX-06, CX-07 |
| Evidence và confidence / limitations | Ngoài phạm vi US9 hiện tại; chạm US4, US5 |
| Recommendation | `[ĐỀ XUẤT THAY ĐỔI]` CP-11 |
| Traceability | Unlinked với AC (đề xuất ngoài tài liệu) · liên quan BR6, AC8, AC9 |
| Open questions / quyết định cần Product · BA · UX | Product (Hường) |

## 6. Đề xuất cải thiện (luồng riêng — không phải requirement)

Tất cả là `[ĐỀ XUẤT THAY ĐỔI]`; không dùng làm expected result cho tới khi người có thẩm quyền quyết định và tài liệu BA được cập
nhật. Mã CP là mã cục bộ của file này (02 mục 9 hiện chưa có CP).

| ID | Đề xuất | Lý do | Cần ai quyết định | Trạng thái |
| --- | --- | --- | --- | --- |
| CP-01 | Khi tạo tài khoản từ nút Google (nhất là từ màn 01): hiện email Google vừa dùng + câu "Nếu bạn đã có tài khoản bằng số điện thoại / email khác, hãy đăng nhập bằng cách đó" kèm lối quay lại | CX-01 | Product (Hường) + UX Hiếu | Đề xuất — chưa ai quyết |
| CP-02 | Thông báo AC5 kèm email Google đã chọn và gợi ý "Đăng nhập bằng SĐT/email ở trên" / "Thử tài khoản Google khác" | CX-02 | Product + BA (đổi nguyên văn đã xác nhận) | Đề xuất — chưa ai quyết |
| CP-03 | Câu hướng dẫn iOS cụ thể hơn trong giới hạn BUG10 / Apple (không link) | CX-03 | Product + người phụ trách App Review | Đề xuất — chưa ai quyết |
| CP-04 | Dòng đồng ý Điều khoản / Chính sách dưới nút Google ở màn 01 (Android/Web) hoặc trên màn thành công Google | CX-04 | Product + pháp chế | Đề xuất — chưa ai quyết |
| CP-05 | Người có lời mời đang chờ: sau khi tạo tài khoản hiện lối "Tham gia workspace <tên>" | CX-05 | Product + BA | Đề xuất — chờ làm rõ "xử lý riêng" (mục 7 #6) |
| CP-06 | Thông báo khi bấm Thêm SĐT (Q-04b) có hai lối: "Xác thực qua ChatGoni" và "Đặt mật khẩu" (mở thẳng, điền sẵn email, báo trước sẽ phải đăng nhập lại) | CX-06 | PdM Hường + Design Hiếu (đang chốt Q-04b) | Đề xuất — chồng lên Q-04b |
| CP-07 | Biến thể câu chữ luồng US4 cho tài khoản chưa có mật khẩu (email mẫu, màn 04, thông báo thành công) | CX-07 | UX Hiếu + BE Chiến | Đề xuất — chưa ai quyết |
| CP-08 | Báo trước "các thiết bị khác sẽ phải đăng nhập lại"; thiết bị bị đăng xuất hiện lý do | CX-08 | Product (chạm US4) | Đề xuất — chưa ai quyết |
| CP-09 | AC10 tách câu "mất mạng" / "không kết nối được Google"; gợi ý theo màn (đăng nhập: thử lại + email/SĐT + Quên mật khẩu; đăng ký: thử lại + đăng ký SĐT/email) | CX-09 | BA (Q-09) + UX | Đề xuất — chồng lên Q-09 |
| CP-10 | Trạng thái đang xử lý sau khi chọn tài khoản Google; web phát hiện popup bị chặn | CX-10 | Design Hiếu + FE Hoàng | Đề xuất — chưa ai quyết |
| CP-11 | Thông tin tài khoản: dòng email ghi "Đăng nhập bằng Google · liên hệ hỗ trợ để đổi"; dòng "Mật khẩu: Chưa đặt — Đặt mật khẩu" mở luồng đặt mật khẩu trong app | CX-11, CX-14 | Product + BA (chạm US4, US5) | Đề xuất — chưa ai quyết |
| CP-12 | Nội dung màn thành công riêng cho Google (email Google, tên Google, Điều khoản, câu phụ CP-01) | CX-12 | BA + Design | Đề xuất — chồng lên mục 7 #5 |

Không có CP cho CX-13 (rủi ro bảo mật — cần quy tắc nghiệp vụ, chuyển Debate).

## 7. Chuyển cho QA / quay lại Debate

| # | Nội dung | Chuyển đi đâu (QA xác minh / Debate — câu hỏi về cách hiểu tài liệu) | Nguồn |
| ---: | --- | --- | --- |
| 1 | AC8 "Email hiện 'Đã xác thực' **(gắn Google, không có nút Đổi)**": "gắn Google" là chữ hiển thị trên dòng Email hay chỉ là chú thích của BA? 02 §4 #10 không nói → expected AC8 có kiểm chữ "Google" trên màn hay không | **Debate** — câu hỏi cách hiểu mới (đề xuất không trọng yếu, gửi BA cùng Q-17) | `US9:68`; user flow `US9:23`; 02 §4 #10; CX-11 |
| 2 | Q-04 (b) "đặt mật khẩu trước qua Quên mật khẩu": tài liệu chỉ có lối vào Quên mật khẩu ở **màn đăng nhập** (`US4:62`), đổi mật khẩu ngoài phạm vi US5 (`US5:18`) → người đang đăng nhập có phải **đăng xuất** để đi luồng này không, hay thông báo Q-04b mở thẳng luồng US4? Đổi số bước và expected của 02 §4 #19 | **Debate** — bổ sung vào Q-04b đang mở; CX không chọn | `US4:62`; `US5:18`; Q-04 (b); 02 §4 #19; CX-06 |
| 3 | Nguồn `TB` (`tailieu/…/bang-noi-dung-thong-bao.md`, 63 dòng) **chưa có trong file 01 US9**. Ba điểm chạm US9: (a) `TB:19` sai mật khẩu ở màn 01 "Tài khoản hoặc mật khẩu không chính xác. Vui lòng thử lại." ≠ `US3:56` "Email/số điện thoại hoặc mật khẩu không đúng" — 02 §4 #8 dùng câu `US3:56` cho cặp đối chiếu BR6 (US4 đã ghi lệch này là TB-09); (b) `TB:43` "Đã xảy ra lỗi. Vui lòng kiểm tra và thử lại." có là thông báo AC10 không (US4 Q-15 đã áp cho lỗi hệ thống US4, mất mạng là `[DIỄN GIẢI AI]`); (c) `TB:24`, `TB:55` quy định mật khẩu "8–16 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt" — US4 đã debate lại theo quy định này (US4 Q-26, US4 02 §4 #19), trong khi US9 02 mục 3 (đoạn "Tái dùng từ US4") còn ghi "8–16 ký tự, ≥1 chữ và ≥1 số (US4 Q-01)" → AC9 / Q-04 (b) đặt mật khẩu theo quy định nào | **Debate** — Orchestrator nạp `TB` vào 01, rà lại 02 mục 3 (dòng "Tái dùng") và 02 §4 #8; (a) (c) có thể đổi expected → Hồng xét mức; (b) bổ sung Q-09 | `TB:19`, `TB:24`, `TB:43`, `TB:55`; `US3:56`; 02 mục 3, §4 #8; US4 02 Q-15, Q-26; CX-07, CX-09 |
| 4 | Tài khoản **form cũ có email chưa từng xác thực** (`EPIC:28`) và có mật khẩu do người tạo đặt: sau khi chủ email đăng nhập bằng Google (BR2), mật khẩu cũ còn hiệu lực không, có thông báo / tách tài khoản không? Q-17 chỉ hỏi phần hiển thị AC8. Chạm bảo mật / dữ liệu | **Debate** — câu hỏi cách hiểu mới; AI đề xuất Hồng xét **trọng yếu** (bảo mật, `10-human-in-the-loop` §1); BA / BE Chiến / Product | `US9:46`; `EPIC:28`, `EPIC:98`; 02 §4 #2 loại (2); Q-17; CX-13 |
| 5 | Q-05 (b) "màn thành công + nút như US1/US6": nội dung màn cho Google là gì — dòng "đã được tạo với …" ghi gì (US6 frame `1641:50321` ghi SĐT), tên hiển thị = tên Google (BR3) hay email, có gợi ý đổi tên như `US1:68` không | **Debate** — bổ sung vào Q-05b đang mở (hoặc tách câu mới không trọng yếu); expected màn thành công hiện chỉ có "có màn + nút" | Q-05 (b); `US1:68`; `US9:47`; Figma `1641:50321`; CX-12 |
| 6 | Q-02 (c) "lời mời xử lý riêng": người dùng thấy lời mời ở đâu sau khi tạo tài khoản (thông báo, nút tham gia, email mới?) — 02 §4 #18 mới ghi ĐO & GHI phần còn chờ hay mất | **Debate** — câu hỏi mới không trọng yếu cho BA / Product (requirement về hiển thị, không đổi kết quả (c)) | Q-02 (c); 02 §4 #18; `EPIC:136`; CX-05 |
| 7 | J3 trên build: tài khoản SĐT (không email) → màn 01 bấm Google bằng email chưa gắn → có cảnh báo gì không; màn thành công ghi gì; sau đó ở tài khoản SĐT bấm Thêm email = email Google → thông báo (theo `US5:72`) | **QA xác minh** — ĐO & GHI (dữ liệu test cho nhóm AC3 + US5 AC7) | `US9:47`; `US5:53`, `US5:72`; CX-01 |
| 8 | AC5 trên build: nguyên văn theo `US9:64`; có hiện email đã chọn không; vị trí, thời điểm mất, bấm Google lại chọn tài khoản khác được không (Q-19); tài khoản SĐT bấm Google trên iOS → cũng nhận câu "chưa tồn tại" | **QA xác minh** — pass/fail nguyên văn; phần còn lại ĐO & GHI | `US9:64`; wireframe 21; Q-19; CX-02 |
| 9 | Màn 01 Android/Web: có dòng Điều khoản / Chính sách không; luồng tạo tài khoản từ màn 01 có hiện Điều khoản ở bất kỳ bước nào không | **QA xác minh** — ĐO & GHI; chuyển Product nếu không có | Figma `1634:21845`; CX-04 |
| 10 | AC10 từng thời điểm lỗi (02 §4 #14) và từng cách dựng (02 §4 #15): nguyên văn, vị trí, gợi ý dẫn tới đâu; với tài khoản chỉ có Google đi theo gợi ý → kết quả; lỗi khi bắt đầu từ màn 05a/11 gợi ý gì | **QA xác minh** — ĐO & GHI (Q-09) | `US9:71`; 02 §4 #14–#15; CX-09 |
| 11 | Sau khi chọn tài khoản: có trạng thái đang xử lý, nút có khóa không; bấm Google hai lần nhanh; web chặn popup (Chrome, Safari) hiện gì | **QA xác minh** — ĐO & GHI | 02 §4 #15 (c); CX-10 |
| 12 | Luồng Q-04 (b) trên điện thoại: thông báo khi bấm Thêm (Q-04b), lối vào Quên mật khẩu khi đang đăng nhập, email có điền sẵn không, đếm số bước thật; các thiết bị khác bị đăng xuất có hiện lý do không | **QA xác minh** — ĐO & GHI; phụ thuộc mục 7 #2 | 02 §4 #9, #19; CX-06, CX-08 |
| 13 | Email OTP và màn đặt mật khẩu khi tài khoản Google chưa có mật khẩu: tiêu đề / câu chữ thật (đối chiếu Figma `1872:4430`, `1754:6468`) | **QA xác minh** — ĐO & GHI | Figma lớp text; `US4:73`; CX-07 |
| 14 | Người được mời chưa đăng ký: sau AC3 lời mời hiện ở đâu, còn hay mất; iOS nhận AC5 | **QA xác minh** — ĐO & GHI theo 02 §4 #18, #23 | Q-02 (c); CX-05 |
| 15 | Thông tin tài khoản của tài khoản Google: chữ thật trên dòng Email (có "Google" không), có câu "liên hệ hỗ trợ" không, có hiện trạng thái mật khẩu không | **QA xác minh** — ĐO & GHI; phụ thuộc mục 7 #1 | `US9:68`; CX-11 |
| 16 | Tài khoản form cũ có mật khẩu + đăng nhập Google cùng email: mật khẩu cũ còn dùng được không; Thông tin tài khoản hiện gì (Q-17) | **QA xác minh** — ĐO & GHI; phụ thuộc mục 7 #4 | `EPIC:28`; `US9:46`; CX-13 |

Ghi chú rủi ro cho các điểm không trọng yếu còn mở không có finding riêng (CX không chọn cách hiểu):

- Q-08 (popup khi vào ChatGoni lần đầu): nếu popup hiện ngay, người dùng "một chạm" bị chặn trước câu đầu tiên — trái tinh thần
  `US7:9`; đã có US6 CX-11 cho hạn mức thấp nói chung, không lặp.
- Q-10 (dữ liệu đã gõ khi Hủy): mất email/mật khẩu đã gõ ở màn 01 là phiền nhỏ; không finding.
- Q-14 ("Lưu đăng nhập" với Google): trên thiết bị dùng chung, người bỏ tick vẫn có thể bị nhớ phiên Google nếu hộp này không áp
  cho Google — rủi ro riêng tư, chỉ ghi nhận.
- Q-16 (tạm khóa vs Google): nếu Google vẫn vào được khi đã bị tạm khóa do sai mật khẩu, người dùng thấy hai quy tắc trái nhau;
  nếu không vào được, người khác có thể cố ý gõ sai để khóa người chỉ quen dùng Google — rủi ro hai chiều, chờ BA.
- Q-07, Q-12, Q-13, Q-15, Q-17 (phần hiển thị), Q-18 (đã gộp vào CX-09), Q-19 (gộp vào CX-02), Q-04b (CX-06), Q-05b (CX-10,
  CX-12), Q-09 (CX-09), Q-11 (CX-12): không có finding riêng.

## 8. Tự rà soát

- [x] Mỗi finding có loại, persona, bằng chứng nguồn, mức bằng chứng, giới hạn
- [x] Không Defect nào thiếu bằng chứng thực tế (không có Defect — không có sản phẩm)
- [x] Không câu nào nói đã thao tác / đã thấy khi chỉ phân tích tài liệu — nhận định về hành vi gắn `[CX GIẢ THUYẾT]`; "đã xem" chỉ dùng cho ảnh / text design
- [x] Persona giả thuyết đã đánh dấu (P7, P9 hoàn toàn giả thuyết; P1, P2, P4, P8 có căn cứ nhóm, bối cảnh giả thuyết; P3, P5, P6 có căn cứ)
- [x] Đề xuất cải thiện tách ở mục 6, nhãn `[ĐỀ XUẤT THAY ĐỔI]`, không lẫn vào requirement
- [x] Không sửa requirement / BR / AC, không sửa `01`, `02`, `cau-hoi-gui-BA.md`, `tailieu/`; không chọn cách hiểu cho Q-04b, Q-05b, Q-07→Q-19
- [x] "Expected vs observed" ghi N/A ở mọi finding (không có quan sát thực tế)
- [x] Không lặp US6 CX-06, CX-07, CX-10, CX-11, CX-15 — chỉ dẫn chiếu; CX-05, CX-12 nêu phần khác biệt riêng của luồng Google
- [x] Số đếm: 14 finding (0 Defect · 4 Usability · 9 CX Risk · 1 Improvement), 9 persona, 10 hành trình, 12 CP, 16 mục chuyển (6 Debate: #1–#6 · 10 QA: #7–#16) — đếm lại từ nội dung

## Lịch sử cập nhật

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
| 2026-10-16 | AI (CX Reviewer) — người dùng Hồng | Tạo file S7: Mode 1 + Mode 3 từ US9, user flow, wireframe, Figma (2 ảnh + lớp text), Epic, US1/US3/US4/US5/US7, BUG10, `TB`, 02 (gate open 2026-10-16); 14 finding (0 Defect · 4 Usability · 9 CX Risk · 1 Improvement), 12 CP, 6 điểm quay lại Debate (AC8 "gắn Google"; lối vào Quên mật khẩu khi đang đăng nhập — Q-04b; nguồn `TB` chưa nạp + quy định mật khẩu cũ trong 02; form cũ email chưa xác thực — bảo mật; nội dung màn thành công Google — Q-05b; "lời mời xử lý riêng"), 10 mục chuyển QA. Không chạy Mode 2 |
