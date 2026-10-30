---
featureId: EPIC-SDT-US4
reviewedAt: 2026-10-16
inputs: [01-requirement-analysis.md, 02-alignment-summary.md, 03-test-design.md, 04-testcases.md, 05-cx-review.md]
---

# Unified QA Review — EPIC-SDT-US4: Quên mật khẩu bằng số điện thoại hoặc email

Hợp nhất kết quả QA và CX. Hai phần giữ phân loại riêng, không trộn. Số liệu đếm lại từ file `04` (85 dòng case, kiểm script 2026-10-16) và `05` (bảng mục 4), không lấy từ báo cáo miệng của sub-agent.

## 1. Trạng thái chung

| Mục | Giá trị |
| --- | --- |
| Cổng Alignment | open — Hồng (QA) · 2026-10-15. Q-03b do AI đề xuất trọng yếu, Hồng hạ xuống không trọng yếu để giữ tiến độ; AC6 cô lập. **Đóng một phần 2026-10-16** (sau khi đọc Figma, Hồng chốt trọng yếu): **BR3/AC9** — Q-26 quy định mật khẩu trên Figma màn 04 khác BA Q-01; xem 02 `closedScope`. Phần còn lại vẫn mở |
| Điểm còn mở (trọng yếu / không trọng yếu) | **1 trọng yếu cô lập theo phạm vi** (Q-26 — cổng đóng cho BR3/AC9) / 23 (Q-01b, Q-03b, Q-07b, Q-09, Q-10, Q-11b, Q-13 → Q-25, Q-27 → Q-30; Q-12 mở lại). Q-11 phần OTP đã đóng 2026-10-16 (PdM Hường) |
| BA đã trả lời | Q-01 → Q-13 (Hồng chuyển 2026-10-15; **tên BA và kênh chưa ghi**); Q-11 phần OTP (PdM Hường, 2026-10-16) |
| Design | **Figma giao diện thật** (Hồng gửi 2026-10-16, `FIGMA`) — đối chiếu ở 01 §4b; ảnh xem được 2/10 frame US4 (màn 04 lỗi không khớp, màn 03 email) + email OTP "Đặt lại mật khẩu" + màn 01 (lưu `figma/`); 8 frame còn lại chỉ có lớp text. Figma MCP gói Starter chạm giới hạn nên chưa lấy thêm được |
| Sub-agent lượt 2 (2026-10-16) | `qa-test-designer` sửa 23 case + ghi chú 13 case theo Figma / closedScope (không thêm, không xóa); `cx-reviewer` cập nhật 13 finding, thu hẹp CX-04, thêm CX-14→CX-20. Orchestrator kiểm 04: 85 dòng case, ID không trùng, đủ 15 cột, không ô Trace BR trống, 18 dòng `❓` (10 do Q-26) |
| Đã thực thi chưa | **Chưa — chỉ thiết kế.** Không có môi trường, không có công cụ; mọi Round đều `Todo` |

## 2. Phần QA (theo requirement)

| Chỉ số | Giá trị |
| --- | --- |
| BR đã phủ / một phần / chưa phủ | 5 / 4 / 0 — một phần: BR2 (nhánh AC6), **BR3 (cổng đóng Q-26 — quy định mật khẩu không tính phủ; chỉ [US4_18] [US4_24] không `❓`)**, BR4 (AC18, chờ Q-11b), BR5 ("tính chung với luồng khác" chỉ dựng được web ↔ app, Q-16) |
| AC đã phủ / một phần / chưa phủ | **9 / 6 / 3** (trước Figma 13 / 3 / 2) — một phần: AC1, AC3, AC4 (câu chữ Q-27, Spam Q-28), AC2, AC12, AC14; chưa phủ: **AC6** (Q-03b), **AC9 (cổng đóng Q-26)**, **AC18** (Q-11b) — chỉ có case `❓` |
| Case nhóm A (tổng · có `❓`) | 73 · **18** = 8 khác (`[US4_16]` `[US4_17]` Q-03b · `[US4_36]` Q-11b · `[US4_64]` Q-17 · `[US4_01]` `[US4_07]` Q-27 · `[US4_08]` Q-27/Q-28 · `[US4_55]` Q-12) + **10 Q-26** (`[US4_19]`→`[US4_23]`, `[US4_25]`→`[US4_29]`, cổng đóng, không pass/fail). 2026-10-16 trước đó thêm `[US4_78]`→`[US4_81]` (con số OTP) và `[US4_82]`→`[US4_85]` (quy tắc US5) |
| Case nhóm B — QA bổ sung (báo cáo riêng) | 12 (`[US4_66]` → `[US4_77]`), expected đều ĐO & GHI |
| Phân loại nhóm A | Positive 18 · Negative 30 · Edge 16 · UI 2 · Security 7 |
| Lỗ hổng coverage | **AC9 không dùng làm pass/fail** tới khi Q-26 chốt; 8/10 frame US4 chưa có ảnh nên hình thức lỗi AC2, nút Lưu vô hiệu (AC14), lỗi ô Mật khẩu mới chưa kiểm được; AC6, AC18 không có expected; nguyên văn thông báo AC2, AC6, AC9 (không đạt), AC12 không có nguồn → ĐO & GHI; cột Error Code trống toàn bộ (Q-10); BR5 "tính chung" chỉ dựng được giữa web và app trong US4 (Q-16) |
| Rủi ro cao nhất (`[QA BỔ SUNG]`, `03` §5) | (1) AC6 làm lộ tài khoản tồn tại nếu lỗi gửi chỉ hiện với tài khoản thật; (2) biên 10 phút lệch giữa FE và BE (599/600, cần công cụ chặn request); (3) đăng xuất mọi thiết bị không phủ phiên Google / Lưu đăng nhập; (4) định danh chưa có tài khoản tiêu lượt và bị khóa như thật |
| Regression scope (`03` §9) | Màn đăng nhập US3 · màn OTP dùng chung US2 · màn đặt mật khẩu dùng chung US1/US6 · đăng nhập Google US9 · **US5 Thông tin tài khoản** (màn Thêm/Đổi SĐT, Thêm email dùng mật khẩu hiện tại; email mới thêm và số đã đổi đi vào luồng quên mật khẩu) · web không còn liên kết đặt lại cũ · iOS đường vào đăng ký (BUG10) |
| Automation candidate (`03` §10) | 4 nhóm, đều `Candidate`: validate FE màn 02/04; biên 599/600 (cần API, Q-10); đăng nhập mật khẩu cũ/mới qua API; so sánh hành vi định danh có/không tài khoản |

## 3. Phần CX (quan sát và giả thuyết)

| Loại | Số lượng | ID |
| --- | ---: | --- |
| Defect (có bằng chứng thực tế) | 0 | — |
| Usability Issue | 11 | CX-01, CX-04 (thu hẹp), CX-05, CX-10, CX-12 (đổi tiền đề: Figma không có Quay lại), CX-13, **CX-14** (lỗi không khớp sai chính tả, khác AC9), **CX-15** (màn 04 không có Quay lại), **CX-16** (màn 03 email không gợi ý Spam), **CX-17** (đang đếm không có nút Gửi lại), **CX-19** (email mẫu còn placeholder, không subject) |
| CX Risk | 8 | CX-02, CX-03, CX-07, CX-08, CX-09, CX-11, **CX-18** (helper đòi 4 loại ký tự ≠ BA — closedScope Q-26, chỉ rủi ro), **CX-20** (thông báo thành công AC10 chưa có design) |
| Improvement Suggestion | 1 | CX-06 |

Mode đã chạy và mức bằng chứng: **Mode 1** (tài liệu + ảnh user flow + ảnh wireframe) và **Mode 3** (8 hành trình mô phỏng bằng suy luận). **Lượt 2 (2026-10-16):** Mode 1 có thêm **Figma giao diện thật** (ảnh 2/10 frame + email mẫu + màn 01) — 13 finding cũ cập nhật evidence, CX-04 thu hẹp (helper đã đầy đủ nhưng khác BA → tách CX-18), CX-12 đổi tiền đề; 7 finding mới CX-14→CX-20. **Không chạy Mode 2** — không có prototype, sản phẩm hay công cụ. Mọi nhận định `[CX GIẢ THUYẾT]`; 8 persona trong đó 5 có căn cứ tài liệu, 3 là giả thuyết phục vụ review.

Mức ảnh hưởng cao (giả định): CX-02 (nhớ nhầm định danh vẫn thấy "Mã đã được gửi", tiêu lượt, có thể bị khóa), CX-03 (hết 10 phút bị đẩy về màn 02 không thông báo, mất mật khẩu vừa gõ), CX-08 (người có tài khoản thật không biết mã không tới vì lỗi gửi).

## 4. Điểm giao nhau QA ↔ CX

| CX finding | Case / BR liên quan | Việc cần làm |
| --- | --- | --- |
| CX-08 (AC6 vs BR2) | `[US4_16]` `[US4_17]` `❓` · BR2, AC6 · Q-03b | Chờ BA; không thêm case. Đây là chỗ Hồng hạ mức — cần theo dõi sát |
| CX-02 (định danh sai vẫn sang màn 03) | `[US4_13]` `[US4_14]` `[US4_15]` · BR2, AC5 · Q-02 | Hành vi đúng theo BA; thêm case nhóm B: từ màn 03 bấm Đổi số/Đổi email sang định danh đúng → nhận mã, bộ đếm độc lập (CX-reviewer đề xuất, chưa có trong `04`) |
| CX-03 (hết 10 phút không thông báo) | `[US4_50]` `[US4_51]` · AC15/16 · Q-09 | Hành vi đúng theo BA; AC16 câu chữ chưa khớp BA → Q-09; CP-03 là đề xuất, không đổi expected |
| CX-07 (đăng xuất trễ, không lý do) | `[US4_32]` → `[US4_35]` `[US4_45]` · BR4, AC11 · Q-05 | Hành vi đúng theo BA; thêm case nhóm B: dữ liệu nhập dở trên thiết bị 2 khi bị đăng xuất → ĐO & GHI |
| CX-04 (helper màn 04 chưa nêu đủ quy định) | `[US4_19]` → `[US4_23]` · BR3, AC9 · Q-01b | Khi có Q-01b, kiểm helper và thông báo khớp quy định đã chốt |
| CX-09 (iOS không lối ra) | `[US4_65]` · E-15, BUG10 | Giữ case; CX-reviewer đề xuất rà thêm Đổi số / Quay lại / back nhiều lần ở màn 03 trên iOS → nhóm B |
| CX-11 (rời app lấy mã, OS tắt app) | `[US4_52]` → `[US4_54]` · AC17 | Thêm nhóm B: mô phỏng OS tắt app ở màn 03/04; dán mã OTP vào 6 ô → ĐO & GHI |
| CX-12 (Quay lại 04 → 03) | `[US4_55]` · nhóm B `[US4_72]` · Q-18 | Chờ BA; `[US4_72]` ĐO & GHI |
| CX-05, CX-06, CX-10, CX-13 | AC11 câu chữ; màn 01 ô trống; màn 03 Zalo không gợi ý; nhãn "Quên mật khẩu?" cho tài khoản Google | Không thêm case; ghi ở mục 6 chờ Product |
| **CX-14 / CX-20** câu lỗi không khớp sai chính tả, khác AC9; thông báo AC10 chưa có design | `[US4_23]` `❓ Q-27`, `[US4_30]` `[US4_31]` | Q-27 gửi BA + Design Hiếu; Expected theo AC, hình thức ĐO & GHI |
| **CX-15** màn 04 không có nút Quay lại (cả 3 frame) | `[US4_55]` `❓ Q-12`, `[US4_61]` `[US4_65]` `[US4_72]` (bước rời màn 04 đổi sang "Quay lại nếu có, không thì back hệ thống") | Q-12 mở lại, gộp Q-27; BA + Design chốt có nút hay không và back hệ thống về đâu |
| **CX-16 / CX-17** màn 03 email không gợi ý Spam; đang đếm không có nút Gửi lại | `[US4_08]` `❓ Q-28`, `[US4_13]` `[US4_38]` `[US4_42]` | Q-28; hình thức đếm ngược ghi vào Q-27 (màn dùng chung US2 — cùng US6 Q-09); đọc frame "hết chờ" mục US2 khi Figma MCP có quyền lại |
| **CX-18** helper màn 04 đòi 4 loại ký tự (closedScope Q-26) | `[US4_19]`→`[US4_29]` `❓ Q-26` | Chỉ rủi ro; không expected; chờ BA / BE / Design trả lời Q-26 (chung US6 Q-17) |
| **CX-19** email mẫu còn placeholder, không subject, tên frame nhầm US6 | `[US4_11]` | Q-29 (tiêu đề); ĐO & GHI chân thư trên email thật; CP-11 |

## 5. Cần con người quyết định

| # | Điểm chờ quyết định | Nguồn / bằng chứng | Vì sao AI không tự quyết | Lựa chọn tài liệu hỗ trợ | Ảnh hưởng nếu chưa giải quyết | Ai quyết |
| ---: | --- | --- | --- | --- | --- | --- |
| 1 | **Q-03b** — AC6 hiển thị gì khi gửi lỗi thật mà không lộ tồn tại; "kênh còn lại" với tài khoản chỉ có SĐT | `US4:67` vs `US4:48`, `EPIC:116`; BA chốt "không lộ" (Q-03) | Chọn một cách là tự tạo hành vi; chạm bảo mật | Tài liệu không có phương án không lộ cho AC6 | `[US4_16]` `[US4_17]` không chạy được; CX-08 mức cao treo | BA Chình / Product |
| 2 | Tên BA và kênh của đợt trả lời Q-01→Q-13 | Cột "Ai trả lời" đang ghi "BA (tên/kênh chưa ghi)" | Rule 04 §4a yêu cầu ai, ngày, kênh | — | Truy vết `[ĐÃ XÁC NHẬN]` chưa đủ | Hồng |
| 3 | Q-11b — con số khóa đăng nhập do sai mật khẩu (US3 BR2); Q-11 phần OTP đã có (5 mã/ngày, sai 5 lần → hủy mã + khóa 1 ngày) | `US3:43`, `EPIC:114`; Q-11 Hường 2026-10-16 | US3 chưa chốt | — | AC18: `[US4_36]` `❓`. **Mới:** hạn mức 5 mã/ngày làm bộ test tự tiêu định danh — cần ≈20 định danh test hoặc Dev cho reset bộ đếm (Q-10) | Chiến / Hường |
| 4 | Q-10 — API gửi OTP / verify / đổi mật khẩu của US4 và mã lỗi từng AC; cách giả lập "lỗi hệ thống" (AC12) | Cột "Mã lỗi BE" trống `US4:59-83`; `API7`/`API8` là API theo uuid | Không bịa mã lỗi, endpoint | — | Cột Error Code trống; case biên 599/600 và `[US4_63]` cần tên API để chặn request bằng proxy | BE Chiến |
| 5 | Q-17 — kết quả xác thực OTP dùng một hay nhiều lần trong 10 phút | `US4:76`, `US4:53`, `US4:73` | Hai cách cho hai expected ở lần Lưu thứ hai | (a) một lần · (b) nhiều lần — tài liệu không nói | `[US4_64]` `❓` | BE Chiến / BA |
| 6 | Q-09 — AC16 ghi "thông báo và điều hướng như AC15" nhưng BA trả lời "không hiển thị thông báo"; màn 04 có đếm ngược không | `US4:80-81`; Q-09 | Câu chữ tài liệu và BA lệch nhau | — | `[US4_50]` `[US4_51]` phần thông báo ĐO & GHI; CX-03 | BA Chình |
| 7 | Q-01b, Q-07b, Q-15 — nguyên văn thông báo AC9 (không đạt), AC2, AC6, AC12 | `US4:63`, `US4:67`, `US4:72`, `US4:76` | Không bịa thông báo | — | Expected phần thông báo ĐO & GHI | BA Chình |
| 8 | Q-13, Q-18 → Q-25 (Q-24: US1/US6/US5 báo "đã đăng ký" trong khi US4 che tồn tại — Product cân nhắc cùng Q-03b; Q-25: số cũ sau đổi SĐT còn "gắn tài khoản" với quên mật khẩu không) — (thêm: bộ đếm còn X lần thử reset khi nào; "ngày" là 24h hay ngày lịch; vượt hạn mức thì mã còn hiệu lực có nhập được) che `+84…`; màn 03 sau khi Quay lại từ 04; đếm ngược Gửi lại sau khi về màn 02 do hết hạn; giữ dữ liệu đã gõ khi gián đoạn và màn đích khi mở lại app | `US4:64-65`, `US4:30`, `US4:80`, `US4:82`, `US4:76` | Hiển thị / điều hướng chưa có nguồn | — | ĐO & GHI; không chặn | BA Chình |
| 10 | **Q-26** (trọng yếu, Hồng chốt 2026-10-16): quy định mật khẩu — Figma màn 04 "8–16 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt" vs BA Q-01 "≥1 chữ và ≥1 số" (`EPIC:147`) | 01 §4b; `FIGMA 1754:6840` | Hai nguồn mâu thuẫn, đổi pass/fail của 10 case | (a) theo BA, Design sửa · (b) theo Figma, Epic cập nhật | `[US4_19]`→`[US4_29]` không dùng pass/fail; AC9 chưa phủ; lan sang US6 Q-17, US1 | BA Chình · BE Chiến · Design Hiếu |
| 11 | Q-27 (câu chữ Figma ≠ AC1/AC3/AC4/AC9/AC10, nút "Xác thực", màn 04 không có Quay lại, hình thức đếm ngược) — expected nguyên văn theo bên nào | 01 §4b; 03 §11 #9–#13 | Không tự chọn giữa tài liệu và design | (a) theo tài liệu, Design sửa · (b) theo Figma, BA cập nhật AC | `[US4_01]` `[US4_07]` `[US4_08]` `[US4_23]` `[US4_55]` `❓`; 11 case chú thích | BA Chình · Design Hiếu |
| 12 | Q-28 (AC4 gợi ý Spam không có trên Figma), Q-29 (tiêu đề email OTP), Q-30 (Figma màn 01 chưa có bản iOS ẩn Đăng ký) | 01 §4b; `US2:38`; `BUG10:35` | Thiếu trên design hay AC đã bỏ — không tự kết luận | — | `[US4_08]` `❓`; `[US4_11]` `[US4_65]` ĐO & GHI | BA Chình · Design Hiếu · FE Hoàng |
| 9 | Q-14, Q-08 — sửa tài liệu: bảng màn "1 ô", "Số AC 12", gạch câu hỏi mở về liên kết cũ; chép quy định mật khẩu (Q-01) và các câu trả lời Q-02→Q-07 vào US4/Epic | `US4:40`, `US4:3`, `US4:87`, `EPIC:113` | Không sửa `tailieu/` | — | Tài liệu và cách hiểu đã chốt lệch nhau; người sau đọc US4 sẽ hiểu sai | BA Chình |

## 6. Change Proposal và đề xuất cải thiện (chưa là requirement)

| ID | Nội dung | Nguồn | Trạng thái |
| --- | --- | --- | --- |
| CP-01 | Màn 02 báo trước SĐT cần có Zalo | CX-01 | `[ĐỀ XUẤT THAY ĐỔI]` chờ Product |
| CP-02 | Màn 03 gợi ý trung tính khi không nhận được mã (không lộ tồn tại) | CX-02, CX-10 | chờ Product |
| CP-03 | Thông báo / đếm ngược khi hết 10 phút ở màn 04 | CX-03 | chờ Product — trái câu trả lời Q-09 hiện tại |
| CP-04 | Sửa câu màn 04 "đăng nhập bằng cả email và số điện thoại" theo định danh thật của tài khoản | CX-05 | chờ Product |
| CP-05 | Điền sẵn định danh ở màn 01 sau khi đổi thành công | CX-06 | chờ Product |
| CP-06 | Thiết bị bị đăng xuất hiện lý do | CX-07 | chờ Product |
| CP-07 | Gợi ý Zalo ở màn 03 | CX-10 | chờ Product |
| CP-08 | Cho dán mã OTP vào 6 ô | CX-11 | chờ Product |
| CP-09 | Lối "Đặt mật khẩu" cho tài khoản Google ngoài "Quên mật khẩu?" | CX-13 | ngoài phạm vi US4 |
| CP-10 | Màn 04: sửa chính tả câu lỗi không khớp; chốt một nguyên văn duy nhất với AC9 | CX-14 | đề xuất 2026-10-16 — chờ Q-27 |
| CP-11 | Email OTP: thay "[email hỗ trợ] · [hotline]" bằng kênh thật; bổ sung subject vào design/tài liệu | CX-19 | đề xuất 2026-10-16 (chung US6 CP-17) |
| CP-12 | Màn 03 khi đang đếm: hiện rõ hành động sắp có ("Gửi lại mã sau 45s" hoặc nút Gửi lại mờ như US2 AC4) | CX-17 | đề xuất 2026-10-16 — màn dùng chung US2 (chung US6 CP-16) |
| CP-13 | Bổ sung design trạng thái thành công sau Lưu mật khẩu (AC10), đủ lâu để đọc | CX-20 | đề xuất 2026-10-16 — chồng Q-27 |

Không mục nào ở đây là requirement. Chi tiết ở `05-cx-review.md` §6. Debate S4b không phát sinh Change Proposal từ phía QA.

## 7. Giới hạn của lượt review này

- Chưa chạy test; chưa có môi trường, tài khoản test, công cụ chặn request. Mọi kết quả là thiết kế.
- `04-testcases.md` đã viết lại Expected Result theo từng bước (rule mới Hồng chốt 2026-10-15); nội dung kỳ vọng không đổi, chỉ đổi hình thức.
- 2026-10-16: con số OTP của Hường chưa được chép vào US2/Epic; test case đang đi trước tài liệu ở điểm này (`[ĐÃ XÁC NHẬN]`, ghi chú "tài liệu chưa cập nhật").
- Rủi ro vận hành test: 5 mã/ngày/định danh và khóa 1 ngày khi sai 5 lần → cần ≈20 định danh test hoặc cách reset bộ đếm (03 Risk #8).
- 2026-10-16 đã rà toàn bộ story của Epic cho từ khóa liên quan US4 (01 mục 1 dòng 9–10). 4 case `[US4_82]`→`[US4_85]` chỉ chạy được khi US5 đã có trên môi trường.
- **Figma giao diện thật đã có từ 2026-10-16** (link Hồng gửi, khác "Wireframe master" ở `EPIC:88`) nhưng chỉ xem được ảnh 2/10 frame US4; 8 frame còn lại (màn 02 ×3, màn 03 Zalo ×2, màn 03 email bản hai, màn 04 "Chưa nhập đầy đủ" / "Mật khẩu không hợp lệ") và 8 frame lỗi OTP mục US2 chỉ có lớp text → hình thức lỗi AC2, AC14, lỗi ô Mật khẩu mới, trạng thái hết đếm chưa kiểm. Không có frame cho AC5/AC6, AC12, AC15/AC16, thông báo AC10, đếm ngược màn 04.
- Cổng **đóng một phần** cho BR3/AC9 (Q-26, Hồng chốt trọng yếu): 10 case `❓ Q-26` giữ Expected theo BA Q-01 nhưng không làm pass/fail.
- `API7`/`API8` chưa được xác nhận là API của US4; không dùng làm expected.
- Con số US2/US3 chưa chốt nên 4 case precondition `❓`.
- Câu trả lời BA Q-01→Q-13 chưa có tên người và kênh.
- Q-03b được hạ mức theo quyết định của Hồng, không theo đề xuất của AI; AC6 vẫn không có expected result.

## 8. Việc tiếp theo

1. Hồng: gửi Q-03b (và các câu Phần B còn lại) cho BA Chình; bổ sung tên BA và kênh cho đợt trả lời 2026-10-15.
2. Hồng: review `04-testcases.md` (85 case, 18 `❓`) và `05-cx-review.md` (20 finding); duyệt 5 case nhóm B mới CX đề xuất ở mục 4 trước khi tôi giao Test Designer bổ sung.
2b. Hồng gửi Q-26 (Phần A, trọng yếu — trả lời chung US6 Q-17) và Q-27→Q-30 (Phần B) cho BA Chình, BE Chiến, **Design Hiếu**; khi có trả lời → debate BR3/AC9, mở lại cổng phần này, Test Designer bỏ `❓ Q-26`.
2c. Khi Figma MCP cho gọi tiếp: lấy ảnh 8 frame US4 còn lại + 8 frame lỗi OTP mục US2 → giao Test Designer / CX rà nốt hình thức AC2, AC14, lỗi OTP.
3. BA Chình: trả Q-03b, Q-09, Q-01b/Q-07b/Q-15, Q-13, Q-18, Q-19; sửa tài liệu theo Q-14, Q-08 và chép các câu trả lời đã chốt vào US4/Epic.
4. BE Chiến: Q-10 (API, mã lỗi), Q-17; Q-11 cùng Hường.
5. Khi có Q-03b: debate AC6 (phần còn lại của BR2), Test Designer điền expected `[US4_16]` `[US4_17]`, bỏ `❓`.
6. S10 chỉ khi có môi trường và người dùng yêu cầu.

## Lịch sử cập nhật

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
| 2026-10-15 | AI (Orchestrator) — người dùng Hồng | Tạo file S9: hợp nhất `03`/`04` (77 case, 8 `❓`) và `05` (13 finding); 9 điểm cần con người quyết định; 9 CP |
| 2026-10-15 | AI (Orchestrator) | Cập nhật sau khi 04 viết lại Expected theo bước: điểm không trọng yếu 13→14 (Q-20); ghi chú ở mục 7 |
| 2026-10-16 | AI (Orchestrator) | Cập nhật theo con số OTP (Q-11, PdM Hường): 81 case, 5 `❓`, AC 13/3/2; thêm Q-11b, Q-21→Q-23; không trọng yếu 17; rủi ro hạn mức định danh test |
| 2026-10-16 | AI (Orchestrator) | Rà nốt Epic: thêm 4 case phụ thuộc US5 (85 case, A 73), Q-24, Q-25, Q-15 mở rộng; regression thêm US5; không trọng yếu 19 |
| 2026-10-16 | AI (Orchestrator) — sau S6/S7 lượt 2 (Figma giao diện thật) | Cập nhật: cổng đóng một phần BR3/AC9 (Q-26); 85 case, 18 `❓` (10 Q-26); AC 9/6/3; CX 20 finding (0/11/8/1), CP-10→CP-13; mục 1 thêm Design + sub-agent lượt 2; mục 4 thêm 5 dòng; mục 5 thêm #10–#12; mục 7, 8 cập nhật; điểm mở 1 cô lập / 23 |
| 2026-10-16 | AI (Orchestrator) — phiên 1 | Hường trả lời 8 câu Phần A: Q-01 (b) chỉ chữ+số và Q-26 (b) theo Figma **mâu thuẫn nhau** → chờ xác nhận; Q-06 đổi web làm lại từ màn 02 (đã áp, 04 = 87 case, 19 `❓`); phát hiện hai phiên Orchestrator chạy song song trên cùng feature — cần một phiên duy nhất |
| 2026-10-16 | AI (Orchestrator) — phiên 1 | Q-26 đóng theo Figma, BR3/AC9 mở lại (Hồng); 93 case (A 81, B 12), 13 `❓`; BR3, AC9 phủ một phần (Q-31, Q-27); thêm Q-31, Q-32; không trọng yếu 23; mật khẩu mẫu `Gopany@123`, mật khẩu cũ mẫu `OldPass@123` |
| 2026-10-16 | AI (Orchestrator) — phiên 1 | Áp bảng nội dung thông báo (`nguon/…`): 94 case (A 82, B 12), 17 `❓`; Q-01b đóng, Q-15/Q-27 đóng một phần; **Q-33 trọng yếu (Hồng chốt) → cổng đóng BR2/AC5**; thêm Q-34, Q-35; AC: phủ 8 / một phần 7 / cổng đóng 1 / chưa phủ 2 |
