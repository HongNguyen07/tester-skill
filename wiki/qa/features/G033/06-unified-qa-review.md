---
featureId: G033
reviewedAt: 2026-10-19
inputs: [01-requirement-analysis.md, 02-alignment-summary.md, 03-test-design.md, 04-testcases.md, 05-cx-review.md]
---

# Unified QA Review — G033: Màn Link nhóm — mời bằng QR hoặc link

Hợp nhất kết quả QA và CX. Hai phần giữ phân loại riêng, không trộn. Số liệu đếm lại bằng script từ file trên đĩa (2026-10-19).

## 1. Trạng thái chung

| Mục | Giá trị |
| --- | --- |
| Nguồn | G033 v1.0 **Draft** (2026-10-02, BA Trân) — người dùng chốt dùng bản này (Q-18); OQ01 của BA còn "chặn build" |
| Cổng Alignment | open — Hồng (QA) · 2026-10-19, sau debate S4b đủ 16 BR |
| Cách hiểu đã xác nhận bởi BA Trân (2026-10-19) | Q-01 nút *Mời qua link* mở màn · Q-02 hệ thống chỉ có trưởng nhóm · Q-03 dòng *Link nhóm* thuộc panel G008 §10C · Q-04 chỉ gửi trong tài khoản đang quản lý nhóm — **cả bốn làm tài liệu lệch**, G033 / G008 / G026 chưa cập nhật |
| Điểm còn mở (trọng yếu / không trọng yếu) | **0 / 20** — Q-05 → Q-17, Q-19 → Q-25; tất cả đã cô lập, case liên quan đánh `❓` |
| Debate S4b | 22 điểm thống nhất D-01 → D-22 (`02-…` mục 4), gồm hai quyết định phạm vi của QA: BR09 nhóm đầy không chạy (D-13), ba nền tảng ưu tiên Web (D-14) |
| Đã thực thi chưa | Chưa — chỉ thiết kế. Không có build, môi trường, công cụ |
| Giai đoạn | S9 xong. S10 chỉ khi có build và người dùng yêu cầu |

## 2. Phần QA (theo requirement)

| Chỉ số | Giá trị |
| --- | --- |
| BR đã phủ / một phần / chưa phủ | **8 / 7 / 0** trên 16 BR (không có BR12). Một phần = có case chắc chắn nhưng còn nhánh `❓`: BR02 (Q-05 logo), BR04 (Q-07, Q-09), BR06 (Q-14, Q-20, Q-21, Q-23), BR07 (Q-11 mất mạng khi lưu), BR15 (Q-06), BR16 (Q-12), BR17 (Q-06, Q-12). **BR09**: 2 case [G033_44] [G033_45], Round = `NA` — không chạy theo quyết định QA (D-13) |
| E, AF, §7 | Coverage Matrix 26 dòng: 16 BR, §7 trạng thái link, E01 → E08, AF01, AF07 (AF02/03/05/06/08 nằm trong dòng BR tương ứng) |
| Case nhóm A (theo requirement) | **90** — Positive 49 · Negative 23 · Edge case 5 · UI 10 · Security 3; **14 case `❓`** ([G033_08] Q-05 · [G033_16] Q-09 · [G033_17] Q-07 · [G033_23] Q-23 · [G033_28] Q-21 · [G033_29] Q-20 · [G033_34] Q-14 · [G033_40] Q-11 · [G033_62] [G033_79] Q-06 · [G033_67] Q-12 · [G033_87] [G033_88] [G033_90] Q-11) không tính đã phủ |
| Case nhóm B (QA bổ sung, báo cáo riêng) | **19** — Edge case 14 · UI 3 · Performance 2; kỳ vọng đều "ĐO & GHI"; 10 case `❓` (Q-13, Q-14, Q-15, Q-16, Q-17, Q-22) |
| Tự kiểm bảng 15 cột (Orchestrator chạy script) | 109 ID liên tục 01 → 109, không trùng; 109/109 dòng đủ 15 cột; 0 Trace BR trống; Category chỉ 6 giá trị hợp lệ; Round: Todo 107 · NA 2; Error Code trống (spec không có mã) |
| Decision table | DT-1 thành phần màn theo trạng thái link / E03 · DT-2 dòng nhắc §10C · DT-3 quyền × CONNECTED · DT-4 hội thoại đích trong hộp chọn · DT-5 tạo / đổi / huỷ × Zalo chấp nhận |
| Scenario | 17 (SC-01 → SC-16 nhóm A, SC-17 nhóm B) |
| Xử lý Q-06 (hub thiếu API) | Case chính UC-04/05/06 ghi precondition "hub có API (Q-06)", **không** đánh `❓`; chỉ hai case nhánh thiếu API [G033_62] [G033_79] đánh `❓`. Orchestrator chấp nhận cách này — đúng brief giao việc |
| Case chờ Dev / công cụ | [G033_16] API thẳng E01 (Q-09); [G033_83] tái hiện E03; [G033_89] [G033_90] giả lập 500 |
| Lỗ hổng coverage | Không BR nào thiếu case. 7 BR "một phần" chỉ đầy đủ khi có trả lời Q-05, Q-06, Q-07, Q-09, Q-11, Q-12, Q-14, Q-20, Q-21, Q-23 |
| Rủi ro cao nhất (QA) | Mốc đối chiếu link phải lấy từ app Zalo (D-02) — thiếu tài khoản trưởng nhóm trên điện thoại thì cả nhóm BR03 / BR16 / BR17 chỉ kiểm được "màn ổn định"; link cũ và QR cũ (PNG đã lưu) phải chết ngay sau đổi / huỷ (D-17) — cần tài khoản Zalo ngoài nhóm; thứ tự "ghi Zalo xong mới đổi màn" (D-16) chỉ thấy khi làm chậm mạng |
| Regression scope | 7 khu vực ở `03-…` §9: G008 UC-05 / AF01 nút *Mời qua link* (đổi hành vi — breaking change `G033:563`), G008 §10C panel, G003 UC-08 hộp chọn (dùng chung, nay có ràng buộc không đổi tài khoản — Q-04), G026 duyệt thành viên, G001 trạng thái kết nối, clipboard / toast "Đã copy link nhóm" dùng chung, G011 panel |
| Automation candidate | 7 nhóm ở `03-…` §10, trạng thái `Candidate` — chưa có script; phần quét QR và app Zalo người nhận là thủ công |

## 3. Phần CX (quan sát và giả thuyết)

| Loại | Số lượng | ID |
| --- | ---: | --- |
| Defect (có bằng chứng thực tế) | 0 | — |
| Usability Issue | 7 | CX-02, CX-03, CX-07, CX-10, CX-11, CX-13, CX-16 |
| CX Risk | 8 | CX-01, CX-04, CX-06, CX-08, CX-09, CX-12, CX-14, CX-18 |
| Improvement Suggestion | 3 | CX-05, CX-15, CX-17 |

Mode đã chạy và mức bằng chứng: **Mode 1** (tài liệu + mockup ASCII §10B/§10D/§10F/§10G) và **Mode 3** ở mức tài liệu (7 hành trình J1–J7; J7 khách nhận link → Zalo → Tham gia → chờ duyệt, phần app Zalo là OOS03). **Không Mode 2** — không có design, prototype, sản phẩm hay công cụ. Mọi nhận định là `[CX GIẢ THUYẾT]`; 8 persona, trong đó P7, P8 là giả thuyết phục vụ review. 11 đề xuất CP-01 → CP-11 `[ĐỀ XUẤT THAY ĐỔI]`.

Finding đáng chú ý: CX-04 dòng nhắc "chờ trưởng nhóm duyệt" không đi theo link tới khách (tài liệu tự nêu rủi ro này ở lý do BR08 / BR10); CX-08 hộp *"Huỷ link nhóm?"* có nút thoát **Huỷ** cạnh nút xác nhận **Huỷ link** cho hành động không gỡ lại được; CX-09 câu hậu quả không nhắc QR đã lưu / đã in cũng chết; CX-03 màn §10F không có tên nhóm mà *Tạo ngay* không hỏi xác nhận; CX-01 nút *Mời qua link* đổi hành vi, toast cũ / mới trùng chuỗi; CX-18 §16 thiếu việc "khách phải bấm Tham gia / chờ duyệt".

## 4. Điểm giao nhau QA ↔ CX

| CX finding | Case / BR liên quan | Việc cần làm |
| --- | --- | --- |
| CX-01 (Mời qua link đổi hành vi, clipboard) | BR01, [G033_02] đã kiểm clipboard bằng CLIP-MARK trước / sau | QA xác minh — đã có case; CP-08 (làm nổi *Sao chép link*) chờ Product |
| CX-02 (Web popup chồng Thêm thành viên) | AF06, Q-15 (đã bổ sung), [G033_05] nhóm lối vào | Chờ BA Q-15; case đánh `❓` phần hình thức |
| CX-03 (§10F không tên nhóm, tạo nhầm nhóm) | BR15, BR16, [G033_59] nhóm §10F | Không thêm case — tài liệu cố ý không có tên nhóm (`G033:357`); CP-03 chờ Product |
| CX-04 (dòng nhắc không đi theo link tới khách) | BR08, BR10, BR14 | Không thêm case — hành vi đúng tài liệu; CP-01 chờ Product; QA ĐO & GHI màn xem trước Zalo có báo "cần duyệt" không (CX §7 #14) |
| CX-06 (E03 với thành viên thường) | BR04, E03, Q-07 (đã bổ sung), Q-24, [G033_17] [G033_83] | Chờ Dev Q-07; `•••` ở E03 chờ BA Q-24 |
| CX-07 (toast E08 không hành động được) | E08, Q-12, [G033_67] | Gửi BA kèm Q-12 (chuỗi đầy đủ, có nêu nguyên nhân không) |
| CX-08, CX-09 (hộp xác nhận Huỷ / Đổi) | BR17, AF07, [G033_71] → [G033_76] | Không thêm case — chuỗi và nút đúng tài liệu; CP-04, CP-05 chờ Product |
| CX-10 (đang xử lý: hình thức, mốc thời gian, Esc) | BR16, BR17, §10F/§10G, Q-11 (đã bổ sung ii, iii), Q-16 | Chờ BA Q-11; QA ĐO & GHI hình thức "đang xử lý" — thêm 1 case nhóm B ở lượt rà sau |
| CX-11 (dòng tin kèm dài, xoá trắng) | BR14, Q-13, nhóm B [G033_9x] dòng tin dài | Đã có case nhóm B ĐO & GHI; CP-10 chờ Product |
| CX-12 (gửi nhiều đích, lỗi một phần) | UC-02, Q-14, [G033_34] | Gửi BA kèm Q-14 |
| CX-13 (bộ lọc tài khoản không đổi được) | BR06, Q-04 `[ĐÃ XÁC NHẬN]`, Q-20, [G033_29] [G033_30] | Chờ BA Q-20 hình thức bộ lọc |
| CX-14 (cập nhật realtime không tín hiệu) | §7 BR-C12, Q-25, AC `G033:470` | Chờ BA Q-25; case BR-C12 phần dấu hiệu ĐO & GHI |
| CX-15 (kích thước QR, logo) | BR02, Q-05, nhóm B quét QR từ màn hình | Đã có case nhóm B ĐO & GHI; logo chờ Dev Q-05 |
| CX-16, CX-17 (hai nút cùng chữ "link", giọng toast) | §10B, D-21 | Không thêm case — chuỗi đúng tài liệu; CP-09 chờ Product |
| CX-18 (§16 thiếu "khách phải bấm Tham gia") | BR10, §16 | Không có case — nội dung truyền thông; CP-07 chờ BA |

## 5. Cần con người quyết định

| # | Điểm chờ quyết định | Nguồn / bằng chứng | Vì sao AI không tự quyết | Lựa chọn tài liệu hỗ trợ | Ảnh hưởng nếu chưa giải quyết | Ai quyết |
| ---: | --- | --- | --- | --- | --- | --- |
| 1 | Mức của Q-23, Q-24, Q-25 (AI đề xuất không trọng yếu) | `02-…` mục 3 | Mức trọng yếu do người dùng chốt | — | Nếu nâng trọng yếu → đóng cổng cho [G033_23], [G033_83], case BR-C12 | Hồng (QA) |
| 2 | 20 điểm không trọng yếu chưa có BA / Dev (Q-05 → Q-17, Q-19 → Q-25) | `cau-hoi-gui-BA.md` Phần B, C, D | Cách hiểu điểm tài liệu chỉ BA / Dev đóng được | Mỗi Q có phương án nếu tài liệu hỗ trợ | 24 case `❓` chưa chạy được đúng kỳ vọng; 7 BR ở mức "một phần" | BA Trân; Dev / hub qua BA |
| 3 | Q-19: câu trả lời "chỉ có trưởng nhóm" (G033) và "có phó nhóm theo G036" (G036 Q-01) khác nhau | `02-…` Q-19; G036 `02-…` Q-01 | Mâu thuẫn giữa hai câu trả lời của cùng BA | (a) G036 giữ vì chỉ hiển thị dữ liệu Zalo; (b) G036 Q-01 xem lại | Không đổi case G033; ảnh hưởng G036 BR10 nếu (b) | BA Trân |
| 4 | OQ01 (QR nguồn Zalo hay tự sinh) — BA ghi "chặn build" | `G033:538` | Quyết định kỹ thuật | Hai nhánh đã chốt trong BR02 | [G033_08] `❓`; build chưa bắt đầu được theo tài liệu | Dev / hub |
| 5 | Tài liệu cần cập nhật theo bốn câu trả lời BA: G008 BR15 / AF01 / §10C / AC (Q-01); G033 E08, BR16, AC 422, 457 bỏ "phó nhóm" (Q-02); dẫn chiếu G011 BR02b, G008 BR25 (Q-03); G033 BR06, AC 438 (Q-04); chữ AF03 "100" (Q-10) | `02-…` mục 4 | QA không sửa `tailieu/` | — | Người đọc tài liệu sau này hiểu sai; case trace về chữ cũ | BA Trân |
| 6 | CP-01 → CP-11 (đề xuất CX) có thành requirement không | `05-…` §6 | Chỉ Product / BA được đưa vào requirement | — | Không ảnh hưởng case hiện tại | Product / BA |
| 7 | Dữ liệu test: tài khoản Zalo trưởng nhóm trên điện thoại (mốc đối chiếu D-02), tài khoản Zalo ngoài nhóm để nhận link / quét QR (D-09, D-17), tài khoản thành viên thường (E08), cách làm chậm mạng trên Web (D-16) | `04-…` quy ước dữ liệu | Thuộc môi trường, không phải tài liệu | — | Nhóm BR03 / BR10 / BR16 / BR17 không chạy đủ | Hồng (QA) + Dev |

## 6. Change Proposal và đề xuất cải thiện (chưa là requirement)

| ID | Nội dung | Nguồn | Trạng thái |
| --- | --- | --- | --- |
| CP-01 | Nhắc "nhóm đang bật duyệt" ngay trên màn chia sẻ / trong thẻ gửi khách | CX-04 | Đề xuất — chờ Product |
| CP-02 | Dòng nhắc duyệt dẫn tới mục Duyệt thành viên | CX-05 | Đề xuất — chờ Product |
| CP-03 | Hiện tên nhóm ở màn §10F | CX-03 | Đề xuất — chờ Product |
| CP-04 | Đổi nhãn / màu nút thoát ở hộp *Huỷ link nhóm?* | CX-08 | Đề xuất — chờ Product |
| CP-05 | Thêm "QR đã lưu / đã in" vào câu hậu quả | CX-09 | Đề xuất — chờ Product |
| CP-06 | Toast / dấu hiệu khi link đổi realtime | CX-14 | Đề xuất — chờ Product (liên quan Q-25) |
| CP-07 | §16 thêm ❺ "khách phải bấm Tham gia / chờ duyệt" | CX-18 | Đề xuất — chờ BA |
| CP-08 | Làm nổi *Sao chép link* khi vào từ *Mời qua link* | CX-01 | Đề xuất — chờ Product |
| CP-09 | Đồng giọng chuỗi toast | CX-17 | Đề xuất — chờ Product |
| CP-10 | Nhắc khi dòng tin kèm trống | CX-11 | Đề xuất — chờ Product |
| CP-11 | Kích thước QR tối thiểu | CX-15 | Đề xuất — chờ Product |

Debate S4b không phát sinh Change Proposal từ phía QA.

## 7. Giới hạn của lượt review này

- Chưa có build, môi trường, design Figma hay prototype → không Mode 2, không case nào có Pass / Fail; mọi finding CX là giả thuyết.
- Nguồn đối chiếu G008, G026, G011, G003, G001 đọc theo từ khoá; G002, G015, G016 / G018 chưa đọc; không có file định nghĩa BR-C06 / C07 / C12.
- Phần app Zalo của người nhận (màn xem trước, thông báo link chết) không có nguồn → chỉ ĐO & GHI.
- BR09 nhóm đầy không chạy theo quyết định QA (D-13); OQ03 / OQ05 (link hết hạn, trạng thái tắt link) không có luật → không có case.
- Q-23 → Q-25 mới cấp sau S6 / S7: [G033_23] đã gắn Q-23; [G033_83] (Q-24) và case BR-C12 (Q-25) chưa sửa Note — Test Designer rà ở lượt sau.

## 8. Việc tiếp theo

1. Hồng chốt mức Q-23 → Q-25 (mục 5 #1); gửi `cau-hoi-gui-BA.md` (Phần B, C, D đã có Q-05 → Q-25) cho chị Trân, nhờ chuyển Dev các câu Phần C.
2. Khi có trả lời: Orchestrator ghi vào `02-…` mục 3 / 4, giao Test Designer rà 24 case `❓` và gắn Note Q-24, Q-25.
3. BA cập nhật G008, G026, G033 theo mục 5 #5; QA rà lại Trace BR sau khi tài liệu đổi.
4. Chuẩn bị dữ liệu test mục 5 #7 trước Round 1 (Web).
5. S10 chỉ khi có build và người dùng yêu cầu; kết quả ghi vào `04-…` cột Round, không ghi vào file này.

## Lịch sử cập nhật

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
| 2026-10-19 | AI (Orchestrator) — người dùng: Hồng (QA) | Tạo bản đầu sau S6 / S7: 90 + 19 case (24 `❓`), 16 BR phủ 8 / một phần 7 / BR09 không chạy, 17 scenario; CX 18 finding (0 / 7 / 8 / 3), 11 CP; cấp Q-23 → Q-25; 7 điểm cần con người quyết định |
