---
featureId: G036
reviewedAt: 2026-10-13
inputs: [01-requirement-analysis.md, 02-alignment-summary.md, 03-test-design.md, 04-testcases.md, 05-cx-review.md]
---

# Unified QA Review — G036: Giao diện khung hội thoại — giống Zalo PC

Hợp nhất kết quả QA và CX. Hai phần giữ phân loại riêng, không trộn. Mọi số liệu đếm lại bằng script từ file trên đĩa.

## 1. Trạng thái chung

| Mục | Giá trị |
| --- | --- |
| Nguồn | G036 v1.0 **Draft** (2026-10-09) — người dùng chốt dùng bản này (Q-12) |
| Cổng Alignment | open — Hồng (QA) · 2026-10-13 |
| Cách hiểu đã xác nhận bởi BA Trân (2026-10-13) | Q-01 trưởng / phó nhóm theo G036 · Q-02 + Q-13 cụm tin gửi từ điện thoại · Q-15 G036 là bản cập nhật phần hiển thị của G003 |
| Điểm còn mở (trọng yếu / không trọng yếu) | 0 / 24 — Q-03 → Q-11, Q-14, Q-16, Q-17, Q-19 → Q-30; tất cả đã cô lập, case liên quan đánh `❓` |
| Debate S4b | 18 câu, 42 điểm thống nhất (`02-…` §4.2); `03`, `04` đã rà theo: 19 case sửa (gồm [G036_50] phía mình không chìa khoá), 15 case thêm; nhóm 6 (BR20–22, BR24) chờ BA |
| Đã thực thi chưa | Chưa — chỉ thiết kế. Không có môi trường, build, công cụ |
| Giai đoạn | S9 xong. S10 chỉ khi có build và người dùng yêu cầu |

## 2. Phần QA (theo requirement)

| Chỉ số | Giá trị |
| --- | --- |
| BR đã phủ / một phần / chưa phủ | **17 / 11 / 0** trên 28 BR (sau rà theo Debate S4b). Một phần = có case chắc chắn nhưng còn nhánh `❓`: BR01, BR03, BR04, BR05, BR13, BR14, BR19, BR20, BR21, BR24, BR25 |
| E, AF | 4/4 E và 6/6 AF có case |
| Case nhóm A (theo requirement) | **159** — Positive 86 · Negative 27 · Edge case 12 · UI 34; **15 case `❓`** (11, 19, 29, 34, 69, 92, 95, 100, 112, 115, 116, 119, 169, 170, 172) không tính đã phủ |
| Case nhóm B (QA bổ sung, báo cáo riêng) | **18** — Edge case 17 · Performance 1; kỳ vọng đều "ĐO & GHI"; 2 case `❓` (176 Q-28, 177 Q-06) |
| Tự kiểm bảng 15 cột | 177 ID (1 → 177 đủ, không trùng; case thêm 163–174 đặt trong group row BR nên thứ tự trong file không tăng dần); 0 dòng lệch cột; 0 Trace BR trống; 0 Purpose trùng; Round = Todo toàn bộ; Error Code trống (spec không có mã) — Orchestrator kiểm lại bằng script |
| Decision table | DT-1 gộp cụm (10 rule, gồm cụm điện thoại và biên 30:00) · DT-2 mốc thời gian (11 rule) · DT-3 trưởng / phó |
| Case bị chặn bởi build | [G036_112] `Đã nhận` / `Đã xem` — BE chỉ trả `Đã gửi` (Q-04) |
| Lỗ hổng coverage | Không BR nào thiếu case. 11 BR "một phần" chỉ đầy đủ khi BA trả lời Q-03, Q-05, Q-06, Q-07, Q-09, Q-10, Q-14, Q-16, Q-17, Q-19, Q-29, Q-30 |
| Rủi ro cao nhất (QA) | Gộp cụm phía mình theo nhân viên + cụm điện thoại (BR01, Q-13) — nhiều nhánh, sai là đọc nhầm ai nói; mốc thời gian 7 dạng + qua 0 giờ (BR03–05) — cần chỉnh đồng hồ; đo px chưa có dung sai thống nhất |
| Regression scope | Các dòng hiển thị của G003 (§10D, AF05, AC 565 / 576 / 615–616), G009 (react, reply), G014 (§10A–10B), G015 (BR03, E05), G026 (BR03 cách làm nổi) — nay theo G036; CR-004 tin tách nhiều phần (Q-16). G008 / G023 / G025: chưa đủ dữ liệu để loại trừ |
| Automation candidate | Có danh sách ở `03-…` §10, trạng thái `Candidate` — chưa có script |

## 3. Phần CX (quan sát và giả thuyết)

| Loại | Số lượng | ID |
| --- | ---: | --- |
| Defect (có bằng chứng thực tế) | 0 | — |
| Usability Issue | 6 | CX-01, 06, 11, 12, 13, 17 |
| CX Risk (đều "rủi ro giả định") | 11 | CX-02, 03, 04, 05, 07, 08, 09, 10, 14, 15, 16 |
| Improvement Suggestion | 0 trong bảng finding; **11 đề xuất** tách riêng ở §6 của `05-…` | IS-01 → IS-11 |

Mode đã chạy: 1 và 3, mức bằng chứng **phân tích tài liệu** — không có design, prototype, sản phẩm, nên chưa quan sát
hành vi thực tế nào; không kiểm được màu, kích thước, tương phản. Persona: 3 có căn cứ (nhân sự CSKH chung tài khoản,
nhân sự quen Zalo PC, Admin / trưởng nhóm), 3 giả thuyết (màn hẹp / cảm ứng, tiếng Anh, nhân sự mới).

Impact cao theo CX: CX-03 cụm điện thoại "tên Zalo + giờ" dễ nhầm là một nhân viên · CX-08 tin thu hồi giữ nội dung
không nhãn → xử lý theo nội dung khách đã rút (phụ thuộc Q-03) · CX-09 👍 luôn hiện ở tin cuối khách, một bấm = Thích
lên Zalo · CX-10 một ô trạng thái → tin của nhân viên A mất dấu khi B / khách nhắn sau · CX-14 tin mới tới khi đang đọc
tin cũ không có tín hiệu.

## 4. Điểm giao nhau QA ↔ CX

| CX finding | Case / BR liên quan | Việc cần làm |
| --- | --- | --- |
| CX-03 cụm điện thoại | BR01, BR07, BR08 + Q-13; DT-1 | Đã có case nhóm A; CX §7.1 #1–2 → thêm "ĐO & GHI" khả năng phân biệt — nhóm B |
| CX-04 mốc lặp khi nhiều tin hệ thống | BR03 ❹; Q-21 | Case BR03 có; đếm số mốc sinh ra — nhóm B |
| CX-05 / CX-06 trưởng / phó | BR10 + Q-01; Q-22 | Case BR10 có; tương phản viền và tooltip trên cảm ứng — ĐO & GHI |
| CX-07 video | BR14 + Q-15; Q-23 | [G036_69] đã `❓` phần bấm |
| CX-08 tin thu hồi | BR20; Q-03 | Case BR20 có; nhãn chờ Q-03; nút Trả lời / Chuyển tiếp ẩn theo G009 BR04 / G003 BR19 — QA xác minh |
| CX-09 👍 | BR22; Q-24 | Case BR22 có; gỡ Thích qua gạch chéo (G009 BR02) — xác minh |
| CX-10 / CX-11 trạng thái gửi, Thử lại | BR24, E01; Q-09, Q-16, Q-25 | Case có; tin A khi B gửi tiếp, vị trí sau Thử lại — ĐO & GHI |
| CX-12 tên tài khoản trong trích dẫn / ghim; nhãn video | BR13, §10E; Q-17, Q-19, Q-26 | [G036_118], [G036_119] đã `❓` |
| CX-13 bảng ghim | BR25; Q-27 | Case §10E có; Esc `❓` |
| CX-14 / CX-15 tin mới khi đọc tin cũ, quay lại hội thoại | BR26, BR27, AF02; Q-28 | Case có; tín hiệu tin mới và đổi nội dung khi quay lại — ĐO & GHI |
| CX-16 390px cảm ứng | BR28, AF06, BR15 | Case 141–145 (dựng môi trường là giả định — Q-08); chồng lấn hàng sticker — nhóm B |
| CX-17 tiếng Anh | BR05, BR28; Q-07 | Case chỉ kiểm 3 nhãn có nguồn; quét nhãn theo `01-…` §6 — nhóm B |

Kết luận: CX không phát hiện mâu thuẫn với requirement; 12 mục ở `05-…` §7.1 đều là "ĐO & GHI" hoặc đã có case.
Không cần thêm case nhóm A; nhóm B có thể bổ sung 6 mục đo (ranh giới cụm, số mốc, tương phản, tin A khi B gửi,
390px hàng sticker, quét nhãn) ở lượt sau.

## 5. Cần con người quyết định

| # | Điểm chờ quyết định | Nguồn / bằng chứng | Vì sao AI không tự quyết | Lựa chọn tài liệu hỗ trợ | Ảnh hưởng nếu chưa giải quyết | Ai quyết |
| ---: | --- | --- | --- | --- | --- | --- |
| 1 | ~~Mức của 11 câu mới~~ — **đã chốt** không trọng yếu (Hồng, 2026-10-13) | `02-…` §3 | — | — | — | Xong |
| 2 | ~~Q-15 người xác nhận~~ — **đã xác nhận** là BA Trân (Hồng, 2026-10-13) | `02-…` §3 | — | — | — | Xong |
| 3 | 22 câu không trọng yếu chờ BA — ưu tiên Q-03 (nhãn tin thu hồi, CX-08 rủi ro cao), Q-14 (menu "…"), Q-16 (tin tách phần), Q-08 (dựng môi trường 390–1600) | `cau-hoi-gui-BA.md` Phần B, C, D | Tài liệu không nói hoặc hai cách hiểu | Có ở từng câu | 10 BR "một phần" không lên "đã phủ"; 12 case `❓` không chạy được | BA Trân |
| 4 | `Đã nhận` / `Đã xem` chưa có BE | `G036:173`, `G036:365` | Giới hạn build | — | [G036_112] chặn | Dev / BA |
| 5 | Dung sai đo px (DevTools / so ảnh) | `03-…` Risk; nhóm B | Không có trong tài liệu | — | Case kích thước (BR02, 06, 08, 11, 14, 16, 17) không có tiêu chí pass rõ | QA lead / BA |
| 6 | 11 đề xuất cải thiện IS-01 → IS-11 | `05-…` §6 | Không phải requirement | — | Không ảnh hưởng test hiện tại | Product / BA / UX |
| 7 | Cập nhật tài liệu: G026 (có phó nhóm, cách làm nổi), G003 §10D / AF05 / AC, G009, G014, G015 phần hiển thị; dẫn chiếu G032 BR03 → BR04; spec gốc chưa trỏ sang G036 | `01-…` §11, §12; Q-11 | Việc của BA | — | Người đọc spec gốc vẫn thấy quy tắc cũ | BA Trân |

## 6. Change Proposal và đề xuất cải thiện (chưa là requirement)

| ID | Nội dung | Nguồn | Trạng thái |
| --- | --- | --- | --- |
| CP | Không có Change Proposal từ Debate | — | — |
| IS-01 → IS-11 | Tooltip giờ / tên cho tin giữa cụm; dấu hiệu cụm điện thoại; dấu hiệu trưởng / phó không phụ thuộc màu; biểu tượng play cho video; gỡ Thích trên tin; "Đang gửi" tạm cho tin không phải tin cuối; ưu tiên tên nhân viên trong trích dẫn / ghim; đổi "Thu gọn" → "Đóng" + Esc; nút "Tin mới ↓"; bảng nhãn song ngữ; đưa OOS04 vào lộ trình | `05-…` §6 | Đề xuất |

## 7. Giới hạn của lượt review này

- Không có design, prototype, build, công cụ — mọi nhận định CX là giả thuyết; không kiểm được màu, px, tương phản.
- Nguồn chính đang Draft; G026, G003, G009, G014, G015 chưa cập nhật theo G036.
- Spec gốc chỉ đọc các dòng liên quan; G008, G023, G025 chưa đọc toàn văn → regression scope ghi "chưa đủ dữ liệu".
- "Bấm vào video tải về" là diễn giải AI (Q-23).
- Số "~" (0,4 giây, 5 phút, 3 màn hình) và §15 không dùng làm tiêu chí pass.

## 8. Việc tiếp theo

1. Hồng: gửi `cau-hoi-gui-BA.md` (Phần B, C, D — 22 câu) cho chị Trân.
2. Khi BA trả lời: cập nhật `02-…`, bỏ `❓` ở case liên quan, tính lại độ phủ trong `03-…` §6, §8 và `04-…` thống kê.
3. Trước khi chạy: chốt dung sai px, cách dựng bề ngang 390–1600 (Q-08), cách chỉnh đồng hồ cho mốc thời gian; có build và BE trả `Đã nhận` / `Đã xem` thì mở [G036_112].
4. Có build + công cụ → CX chạy Mode 2 cho 5 finding impact cao; QA thêm 6 mục đo nhóm B.
5. S10 chỉ khi người dùng yêu cầu và có môi trường.

## Lịch sử cập nhật

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
| 2026-10-13 | AI (Orchestrator) | Tạo bản hợp nhất QA + CX sau S6–S7: 18/10/0 BR, 162 case, 17 finding, 7 việc cần con người quyết |
| 2026-10-13 | Hồng (QA) | Chốt Q-17, Q-19 → Q-28 không trọng yếu; xác nhận Q-15 là của BA Trân — việc #1, #2 đóng |
| 2026-10-13 | AI (Orchestrator) | Ghi chú: Debate S4b làm bù sau khi mở cổng (42 điểm D1-1 → D5-19, xem `02-…` §4.2); `03`/`04` đang được rà theo đó |
| 2026-10-13 | AI (Orchestrator) | Cập nhật số liệu sau khi Test Designer rà theo Debate S4b: 177 case (A 159 · B 18), 17 `❓`, 17/11/0 BR; 24 câu chờ BA |
