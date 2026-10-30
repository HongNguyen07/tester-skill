---
featureId: G033
stage: S9
gate: open
materialOpen: 0
nonMaterialOpen: 20
gateOpenedBy: Hồng (QA)
gateOpenedAt: 2026-10-19
updatedAt: 2026-10-19
---

# Requirement Understanding / Alignment Summary — G033: Màn Link nhóm — mời bằng QR hoặc link

Trạng thái: **cổng mở ngày 2026-10-19** do người dùng xác nhận sau S4b. S6–S7 đã xong (03, 04, 05 trên đĩa); đang S9. Sub-agent trả về 10 điểm quay lại Debate → Q-23 → Q-25 mới và bổ sung Q-07, Q-09, Q-11, Q-15; không điểm nào trọng yếu → cổng giữ mở. BA Trân đã trả lời **Q-01 → Q-04** (2026-10-19, Hồng chuyển lại); ba câu trả lời làm
G033 / G008 / G026 lệch với tài liệu hiện có — ghi `[ĐÃ XÁC NHẬN]`, tài liệu chưa cập nhật. Phát sinh Q-19, Q-20 (không trọng yếu).
**S4b đã đi hết** 16 BR, E01 / E04 / E07, AF01 / AF07, chuỗi UI (D-01 → D-22); E05 / E06 chờ Q-11. AI đề xuất **không có điểm trọng yếu**; chờ người dùng chốt mức Q-06, Q-21 và chốt Q-18 (bản Draft), — Hồng chốt cả ba khi nói "mo cong" 2026-10-19.

## 1. Nguồn và phạm vi đã đọc

Xem mục 1 của `01-requirement-analysis.md`. Nguồn chính: `tailieu/G033 - Màn Link nhóm (1).md` (toàn bộ 601 dòng, v1.0, Draft,
2026-10-02). Đối chiếu các dòng liên quan ở G008 v1.1, G026 v1.0, G011 v1.1, G003 v1.11, G001; câu trả lời BA ở G036 Q-01.

## 2. Requirement / Use case / Business rule đã trích

| Mã | Tóm tắt | Nguồn | Trạng thái hiểu |
| --- | --- | --- | --- |
| UC-01 – UC-06 | Mở màn + sao chép · chia sẻ · lưu QR · tạo · đổi · huỷ link | `G033:57-108` | `[NGUỒN]` rõ — UC-02: `[ĐÃ XÁC NHẬN]` Q-04 (chỉ gửi trong tài khoản đang quản lý nhóm), còn mở Q-13, Q-14, Q-20; UC-04/05/06 còn mở Q-06 |
| AF01 – AF03, AF05 – AF08 | Đóng màn, dòng nhắc, màn chưa có link, lối vào Mời qua link, huỷ hộp xác nhận | `G033:152-158` | `[NGUỒN]` rõ — AF03 còn mở Q-10; AF06 còn mở Q-01, Q-15 |
| E01 – E08 | Ngoại lệ | `G033:166-173` | `[NGUỒN]` rõ — E01 còn mở Q-09; E05/E06 còn mở Q-11; E08 còn mở Q-02, Q-12 |
| BR01 | Hai lối vào, cùng một màn; đóng về đúng chỗ | `G033:183` | `[ĐÃ XÁC NHẬN]` Q-01 (nút Mời qua link không copy clipboard — G008 chưa cập nhật), Q-03 (dòng Link nhóm thuộc panel G008 §10C; dẫn chiếu G011 BR02b vẫn treo) |
| BR02 | QR chứa đúng link; logo theo nguồn cấp | `G033:184` | `[NGUỒN]` — còn mở Q-05 (nhánh build) |
| BR03 | Dùng link có sẵn, không tự tạo / đổi / huỷ | `G033:185` | `[NGUỒN]` rõ |
| BR04 | Quyền Gopany quyết ai thấy dòng; vai Zalo không phải điều kiện | `G033:186` | `[NGUỒN]` rõ + `[ĐÃ XÁC NHẬN]` Q-02 (hệ thống chỉ có trưởng nhóm) — còn mở Q-07 (OQ02) |
| BR05 | Thao tác theo trạng thái link | `G033:187` | `[NGUỒN]` rõ — còn mở Q-06 (OQ04) |
| BR06 | Chia sẻ link dùng hộp chọn G003 UC-08, giữ nguyên luật; filter tài khoản đổi được | `G033:188` | `[ĐÃ XÁC NHẬN]` Q-04 — **khác chữ BR06**: không đổi được sang tài khoản khác, chỉ gửi trong tài khoản đang quản lý nhóm; còn mở Q-20 (bộ lọc khoá hay ẩn) |
| BR07 | Lưu QR → PNG `QR - {tên nhóm}.png` | `G033:189` | `[NGUỒN]` rõ — còn mở Q-17 (biên tên file) |
| BR08 | Dòng nhắc duyệt thành viên | `G033:190` | `[NGUỒN]` rõ |
| BR09 | Cảnh báo nhóm đầy, số theo Zalo | `G033:191` | `[NGUỒN]` — còn mở Q-10 |
| BR10 | Người nhận → màn xem trước Zalo → Tham gia → luồng G026 | `G033:192` | `[NGUỒN]` rõ (kiểm trên app Zalo) |
| BR11 | DISCONNECTED → không mở màn | `G033:193` | `[NGUỒN]` rõ |
| BR13 | Nền tảng đồng nhất; Web popup, mobile toàn trang | `G033:194` | `[NGUỒN]` rõ — còn mở Q-15 |
| BR14 | Thẻ xem trước + dòng tin kèm; tin gửi dạng thẻ | `G033:195` | `[NGUỒN]` — còn mở Q-13 |
| BR15 | Chưa có link = trạng thái bình thường, màn §10F | `G033:196` | `[NGUỒN]` rõ |
| BR16 | Tạo ngay không hộp xác nhận; ghi Zalo xong mới đổi màn | `G033:197` | `[ĐÃ XÁC NHẬN]` Q-02 — chỉ trưởng nhóm; các chỗ "phó nhóm" ở BR16 / E08 / AC không áp dụng (G033 chưa cập nhật); dẫn chiếu G008 BR25 vẫn treo; còn mở Q-06 |
| BR17 | Đổi / Huỷ bắt buộc hộp xác nhận; link cũ chết ngay | `G033:198` | `[NGUỒN]` — còn mở Q-06, Q-12 |
| §7 | Hai trạng thái CHƯA CÓ LINK ↔ CÓ LINK; cập nhật realtime khi đổi trên app Zalo | `G033:204-223` | `[NGUỒN]` rõ — còn mở Q-08 (OQ05) |
| §15 | Hiệu năng | `G033:550-553` | `[NGUỒN]` — còn mở Q-16 |

## 3. Bảng câu hỏi debate

| Q | Mức (đề xuất) | Trích dẫn + nguồn | Vì sao chưa rõ | Các cách hiểu có căn cứ | Ảnh hưởng tới test | Cần ai xác nhận | Trạng thái | Câu trả lời | Ai trả lời · ngày · kênh |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Q-01 | Không trọng yếu | `G033:38`, `G033:183`, `G033:563`; `G008:241-242`, `G008:300`, `G008:395`, `G008:455` | G033 nói nút *Mời qua link* nay mở màn (G008 BR15 v1.9); G008 trong `tailieu/` là v1.1, còn ghi copy clipboard | (a) Theo G033 — tài liệu chủ quản, mới hơn, Changelog nêu rõ. (b) Theo G008 v1.1 — chữ hiện có | Case AF06 / AC `G033:418-419` viết theo G033; nếu (b) thì nhóm case lối vào thứ hai đổi hẳn | BA (xác nhận + cập nhật G008) | Đã xác nhận | (a) **Không copy thẳng vào clipboard** — nút *Mời qua link* mở màn. G008 BR15 / AF01 / §10C / AC chưa cập nhật | Trân (BA) · 2026-10-19 · Hồng chuyển lại trong phiên |
| Q-02 | Không trọng yếu (đề xuất — người dùng chốt) | `G033:422`, `G033:457`, `G033:173`, `G033:197`; `G026:128-129`, `G026:193`; `G003:317` vs `G033:188` | G033 có phó nhóm và cho phó nhóm tạo link; G026 không có phó nhóm, chỉ trưởng nhóm đổi cài đặt; chuỗi "chỉ trưởng/phó nhóm được nhắn tin" (G003) vs "chỉ trưởng nhóm" (G033) | (a) Theo G033 — BA đã trả lời ở G036 Q-01 (2026-10-13) là có phó nhóm, theo G036. (b) Theo G026 — không có phó nhóm | Dữ liệu test cần tài khoản phó nhóm; AC `G033:457` về hành vi Zalo → ĐO & GHI; kết quả phía Gopany không đổi vì BR04 / BR16 không chặn theo vai Zalo | BA | Đã xác nhận | (b) **Hiện tại trên hệ thống chỉ có trưởng nhóm.** → G033 các chỗ "phó nhóm" (`G033:173`, `G033:197`, `G033:422`, `G033:457`) không áp dụng, tài liệu chưa cập nhật; chuỗi chặn nhắn tin theo G026 BR01 = "chỉ trưởng nhóm". Khác câu BA trả lời ở G036 Q-01 → tách Q-19 | Trân (BA) · 2026-10-19 · Hồng chuyển lại trong phiên |
| Q-03 | Không trọng yếu | `G033:183`, `G033:522` (G011 BR02b); `G033:197`, `G033:520` (G008 BR25); `G011:130`, `G011:224`; `G008:305-307`, `G008:395` | G011 BR02b và G008 BR25 không có trong bản hiện hành; dòng *Link nhóm* thuộc panel của G008 §10C hay G011 | Tài liệu không nói — G008 §10C có dòng Link nhóm (`G008:395`); G011 không nhắc | Không đổi case; case kiểm "có dòng Link nhóm trên panel thông tin nhóm" | BA (sửa dẫn chiếu) | Đã xác nhận | **G008 §10C** — dòng *Link nhóm* thuộc panel của G008 §10C (`G008:395`). Câu trả lời chưa nói về hai dẫn chiếu treo (G011 BR02b, G008 BR25) → ghi chú BA sửa, không hỏi lại | Trân (BA) · 2026-10-19 · Hồng chuyển lại trong phiên |
| Q-04 | Không trọng yếu | `G033:188`; `G003:319`, `G003:623` | G033 cho đổi filter tài khoản Zalo và gửi từ tài khoản khác; G003 BR23 ghi "không forward cross-account" | (a) Theo G033: đổi được filter, gửi link từ tài khoản B vào hội thoại của B. (b) Theo chữ G003 BR23: không gửi sang tài khoản khác | Case AC `G033:437-438`; nếu (b) thì case "đổi filter" là negative | BA | Đã xác nhận | (b) **Không — chỉ gửi trong tài khoản đang quản lý nhóm.** → Khác chữ `G033:188` và AC `G033:438`; tài liệu chưa cập nhật. Chưa nói bộ lọc khoá hay ẩn → tách Q-20 | Trân (BA) · 2026-10-19 · Hồng chuyển lại trong phiên |
| Q-05 | Không trọng yếu | `G033:184`, `G033:273`, `G033:429`, `G033:538` (OQ01) | QR do Zalo trả (có logo) hay hệ thống tự sinh (mã trơn) — chờ Dev; tài liệu chốt sẵn cả hai nhánh | — | Case BR02 viết hai nhánh, đánh ❓ chọn theo build | Dev / hub (qua BA) | Mở — cô lập | | |
| Q-06 | Không trọng yếu (Hồng chốt 2026-10-19) | `G033:541`, `G033:561` (OQ04) | Hub có đủ ba API tạo · đổi · huỷ không; thiếu → ẩn thao tác | Tài liệu chốt sẵn mọi nhánh | Nhóm case UC-04 / UC-05 / UC-06, `•••`, §10F nút Tạo ngay ghi điều kiện "khi hub có API"; chạy theo nhánh build | Dev / hub (qua BA) | Mở — cô lập | | |
| Q-07 | Không trọng yếu | `G033:186`, `G033:539` (OQ02) | Zalo có chặn thành viên thường xem link không → E03 **Bổ sung (S6/S7):** nếu Zalo chặn thì (i) không dựng được nhóm "thành viên thường + đã có link" cho case E08 đổi / huỷ [G033_77] [G033_78]; (ii) chuỗi E03 có nhánh riêng nêu nguyên nhân không (CX-06) | Tài liệu không nói | Case "tài khoản quản lý nhóm là thành viên thường mở màn" ĐO & GHI | Dev / hub (qua BA) | Mở — cô lập | | |
| Q-08 | Không trọng yếu | `G033:540` (OQ03), `G033:542` (OQ05) | Link có hạn dùng không; có trạng thái "tắt link mời" không | Tài liệu không nói, chưa đo | Không viết case; ghi ngoài phạm vi | Dev / BA đo | Mở — cô lập | | |
| Q-09 | Không trọng yếu | `G033:166`, `G033:423`; `G033:231` | "Gọi API thẳng → từ chối + log" nhưng không có endpoint **Bổ sung (S6):** cách Dev giả lập E03 (Zalo không trả link) và E06 (500) trên môi trường test — [G033_83], [G033_89], [G033_90] | — | Case API chờ Dev cung cấp endpoint | Dev | Mở — cô lập | | |
| Q-10 | Không trọng yếu | `G033:154` vs `G033:191`, `G033:476`; `G008:287` | AF03 ghi "(cá nhân: 100 · Business: cao hơn)" trong khi BR09 / AC nói không ghi cứng | Kỳ vọng theo BR09 (`maxMember` Zalo trả) | Case BR09 cần cách lấy `maxMember` của nhóm test | BA (chữ AF03) + Dev (cách lấy số) | Mở — cô lập | | |
| Q-11 | Không trọng yếu | `G033:171` vs `G033:494`; `G033:170`, `G033:358`, `G033:408` | AC-E06 nói "bấm Thử lại được" nhưng bảng E06 chỉ toast, Thử lại chỉ có ở E03; mất mạng / 500 lúc nút đang xử lý thì nút về trạng thái nào. **Bổ sung (debate D-22):** mất mạng khi bấm *Lưu mã QR* → toast E05 hay E07 **Bổ sung (S6/S7):** (i) AC-E06 "màn giữ nguyên" khi *mở màn* — màn nào giữ nguyên, hay là panel [G033_90]; (ii) mốc thời gian tối đa cho Tạo / Đổi / Huỷ, quá mốc nút về trạng thái nào, toast gì (CX-10); (iii) Esc / ✕ / click nền mờ **trong lúc** nút đang xử lý — đóng hộp, đóng popup hay bị khoá (CX-10) | (a) 500 lúc mở màn → màn hiện như E03 (vùng lỗi + Thử lại). (b) Chỉ toast, màn không mở hoặc giữ nguyên | Hai case E05 / E06 và case mất mạng khi lưu QR đánh ❓ | BA | Mở — cô lập | | |
| Q-12 | Không trọng yếu | `G033:173` | Toast E08 chỉ có đầu "Không tạo được link nhóm…" và đuôi "Vui lòng kiểm tra lại trên app Zalo" | — | Case E08 kiểm đầu + đuôi, phần giữa ❓ | BA | Mở — cô lập | | |
| Q-13 | Không trọng yếu | `G033:195`, `G033:441` | Dòng chữ kèm **có chứa** link thì Zalo nối thêm không; thẻ xem trước hiện thế nào trong khung chat Gopany | Tài liệu không nói | Case QA bổ sung ĐO & GHI | BA | Mở — cô lập | | |
| Q-14 | Không trọng yếu | `G033:72`; `G003:213` | Sau Gửi, màn chia sẻ có đóng và về màn Link nhóm không; gửi lỗi một phần thì toast nào | (a) Theo G003 UC-08: popup đóng. (b) Tài liệu G033 không nói | Case UC-02 bước cuối ❓ | BA | Mở — cô lập | | |
| Q-15 | Không trọng yếu | `G033:156`, `G033:326`; `G008:390` | Trên Web popup Link nhóm chồng lên hay thay thế giao diện Thêm thành viên; đóng về lại ở trạng thái nào **Bổ sung (S7):** giao diện Thêm thành viên có giữ từ khoá tìm / danh sách đã tích sau khi đóng popup không (CX-02) | Tài liệu không nói | Case AF06 trên Web ❓ phần hình thức | BA | Mở — cô lập | | |
| Q-16 | Không trọng yếu | `G033:550-553` | Số hiệu năng là tiêu chí đạt hay tham khảo | — | ĐO & GHI, không làm tiêu chí pass | BA | Mở — cô lập | | |
| Q-17 | Không trọng yếu | `G033:189`, `G033:194` | Tên nhóm có ký tự cấm / rất dài → tên file; mobile lưu thư viện ảnh có tên này không | Tài liệu không nói | Case QA bổ sung ĐO & GHI | BA / Dev | Mở — cô lập | | |
| Q-18 | Người dùng chốt | `G033:12` Draft; `G033:538` OQ01 chặn build | Có viết test case trên bản Draft khi OQ01 chưa chốt không | — | Toàn bộ | Người dùng | Đã chốt | Dùng bản Draft v1.0 làm căn cứ viết test case; OQ01 chưa chốt thì case BR02 viết hai nhánh | Hồng (QA) · 2026-10-19 · phiên /qa-flow |
| Q-19 | Không trọng yếu | Câu trả lời Q-02 (G033): "hiện tại trên hệ thống chỉ có trưởng nhóm"; câu trả lời G036 Q-01 (2026-10-13): "(a) có phó nhóm, lấy theo G036" (`wiki/qa/features/G036/02-alignment-summary.md:40`) | Hai câu trả lời của BA về vai phó nhóm khác nhau | (a) G033 theo "chỉ trưởng nhóm", G036 vẫn giữ (a) vì là hiển thị dữ liệu Zalo. (b) G036 Q-01 cần xem lại | Không đổi case G033; ảnh hưởng G036 BR10 nếu (b) | BA | Mở — cô lập | | |
| Q-20 | Không trọng yếu | Câu trả lời Q-04; `G033:188`, `G033:205` (G003 UC-08 có filter tài khoản Zalo) | "Chỉ gửi trong tài khoản đang quản lý nhóm" — bộ lọc tài khoản Zalo trên màn chia sẻ **khoá** ở tài khoản đó, hay **ẩn** hẳn, hay đổi được nhưng không gửi | Tài liệu không nói | Case AC `G033:437-438` phần hình thức bộ lọc ❓; kỳ vọng "không gửi được sang tài khoản khác" viết được | BA | Mở — cô lập | | |
| Q-21 | Không trọng yếu (Hồng chốt 2026-10-19; một case biên) | `G033:188`, `G003:317` BR21 "hiện nhưng disable"; `G026:135` BR06 chế độ chỉ trưởng nhóm được nhắn tin khoá **ô nhập của thành viên** | Tài khoản Zalo đang gửi là **trưởng nhóm** của nhóm đích đang bật "chỉ trưởng nhóm được nhắn tin": nhóm đích tích được hay vẫn mờ | (a) Tích được, gửi được — căn cứ G026 BR06 (trưởng nhóm không bị khoá). (b) Vẫn mờ — căn cứ chữ G003 BR21 / G033 BR06 không có ngoại lệ | Một case biên trong nhóm BR06 / G003 BR21 đánh ❓ | BA | Mở — cô lập | | |
| Q-22 | Không trọng yếu | `G033:169` E04 gắn ở UC-01 b2 (lúc mở màn); `G033:223` chỉ nói trạng thái **link** đổi trên app Zalo thì màn cập nhật ngay | Nhóm bị **giải tán** hoặc người dùng **bị xoá / rời nhóm** trong lúc màn Link nhóm (hoặc màn chia sẻ) **đang mở** → màn làm gì; bấm một trong ba nút lúc đó ra gì | Tài liệu không nói. QA + AI tạm đọc: xử lý như E04 (toast *"Nhóm không còn tồn tại"*, đóng màn, panel tải lại) `[GIẢ ĐỊNH]` | Một case QA bổ sung đánh ❓ | BA | Mở — cô lập | | |
| Q-23 | Không trọng yếu (đề xuất) — từ Test Designer #1 | `G033:292`, `G033:316` bộ đếm *"Đã chọn: n"* nhưng dẫn "theo G003 §10G"; `G003:538` *"Đã chọn X/99"* | Hai chuỗi khác nhau; D-21 đòi đúng nguyên văn nên cần chốt chuỗi nào | (a) "Đã chọn: n" theo G033. (b) "Đã chọn X/99" theo G003 §10G | [G033_23] ❓; [G033_22] bỏ chuỗi bộ đếm khỏi kỳ vọng | BA | Mở — cô lập | | |
| Q-24 | Không trọng yếu (đề xuất) — từ CX #5 | `G033:168` E03 "ba nút thao tác disable"; `G033:187`, `G033:270` menu `•••` | Ở E03 menu `•••` hiện, ẩn hay mờ — tài liệu chỉ nói ba nút | Tài liệu không nói | Case E03 [G033_83] phần `•••` ❓; CX-06 | BA | Mở — cô lập | | |
| Q-25 | Không trọng yếu (đề xuất) — từ CX #6 | `G033:223`, `G033:470` "màn cập nhật ngay, không cần tải lại" | Khi link đổi / huỷ trên app Zalo lúc màn đang mở, có toast hay dấu hiệu báo không | Tài liệu không nói | Case BR-C12 [theo Trace §7] phần dấu hiệu → ĐO & GHI; CX-14 | BA | Mở — cô lập | | |

## 4. Cách hiểu đã thống nhất (kết quả Debate S4b)

Phần có BA (chưa debate):

| # | Nhóm BR / luồng | Nội dung đã thống nhất | Nhãn | Từ câu hỏi | Ai xác nhận · ngày | Tài liệu đã cập nhật chưa |
| ---: | --- | --- | --- | --- | --- | --- |
| 1 | BR01, AF06 | Nút *Mời qua link* trong màn Thêm thành viên **mở màn Link nhóm, không copy thẳng vào clipboard** | `[ĐÃ XÁC NHẬN]` | Q-01 | Trân (BA) · 2026-10-19 | Chưa — G008 v1.1 BR15, AF01, §10C, AC còn ghi copy clipboard; ghi chú BA |
| 2 | BR04, BR16, BR17, E08 | Hệ thống **chỉ có trưởng nhóm**, không có phó nhóm. Các AC / điều kiện nhắc "phó nhóm" (`G033:173`, `G033:197`, `G033:422`, `G033:457`) không áp dụng; chuỗi chặn nhắn tin là "chỉ trưởng nhóm được nhắn tin" (G026 BR01) | `[ĐÃ XÁC NHẬN]` | Q-02 | Trân (BA) · 2026-10-19 | Chưa — G033 còn ghi phó nhóm; ghi chú BA. Lệch với G036 Q-01 → Q-19 |
| 3 | BR01, §10A | Dòng *Link nhóm* nằm trên **panel thông tin nhóm của G008 §10C** (`G008:395`) | `[ĐÃ XÁC NHẬN]` | Q-03 | Trân (BA) · 2026-10-19 | Chưa — dẫn chiếu G011 BR02b, G008 BR25 vẫn treo; ghi chú BA |
| 4 | BR06, UC-02 | Màn chia sẻ link **chỉ gửi trong tài khoản Zalo đang quản lý nhóm**; **không** đổi sang tài khoản khác | `[ĐÃ XÁC NHẬN]` | Q-04 | Trân (BA) · 2026-10-19 | Chưa — `G033:188` và AC `G033:438` còn ghi "đổi được"; ghi chú BA. Hình thức bộ lọc → Q-20 |

Kết quả debate S4b (Hồng ↔ AI):

| # | Nhóm BR / luồng | Nội dung đã thống nhất | Nhãn | Từ câu hỏi | Ai xác nhận · ngày | Tài liệu đã cập nhật chưa |
| ---: | --- | --- | --- | --- | --- | --- |
| D-01 | BR03 | Kiểm BR03 bằng cách **so chuỗi link** (phần `zalo.me/g/…`) giữa các lần mở màn, giữa hai lối vào và giữa các nền tảng: phải **giống nhau từng ký tự**; mã QR giải mã ra cũng phải là chuỗi đó | `[NGUỒN]` `G033:185`, `G033:420`, `G033:430`, `G033:469`, `G033:428` | — | Hồng · 2026-10-19 | — |
| D-02 | BR03 | "Link cũ" ở BR03 là link **nhóm đã có trước khi mở màn** (khác "link cũ" ở BR17 = link trước khi bấm *Đổi link*, `G033:198`, `G033:464`). Mốc đối chiếu lần đầu lấy **ngoài màn G033**: link nhóm trên **app Zalo** của nhóm đó (G033 nói "link nhóm có sẵn" của Zalo, `G033:23`), hoặc giá trị hub trả — so hai lần mở cùng màn với nhau chỉ chứng minh màn **ổn định**, chưa chứng minh **dùng đúng link có sẵn** | `[DIỄN GIẢI AI]` cho mốc đối chiếu (tài liệu không nói lấy ở đâu); rule là `[NGUỒN]` `G033:185` | — | Hồng + AI · 2026-10-19 | — |
| D-03 | BR05, BR15 | Ở màn chưa có link (§10F), ba nút và `•••` **không xuất hiện trên UI** — quan sát: không có phần tử nào, không phải nút mờ / disable. "Có nhưng mờ" là trạng thái của **E03** (ba nút disable khi Zalo không trả được link), không phải §10F | `[NGUỒN]` `G033:187`, `G033:196`, `G033:357`, `G033:449`; E03 `G033:168` | — | Hồng · 2026-10-19 | — |
| D-04 | BR08, BR09, BR15 | Nhóm bật duyệt thành viên (hoặc đã đầy) nhưng **chưa có link** → chỉ hiện màn §10F (icon + câu mời + *Tạo ngay*), **không có dòng nhắc** — dòng nhắc chỉ đặt "ngay dưới link" và §10F "không có gì khác". Sau khi *Tạo ngay* thành công, màn đổi sang §10B thì dòng nhắc phải xuất hiện theo BR08 / BR09 | `[NGUỒN]` `G033:155`, `G033:279`, `G033:357`; phần "sau khi tạo xong hiện dòng nhắc" là `[DIỄN GIẢI AI]` từ `G033:88` + `G033:279` | — | Hồng · 2026-10-19 | — |
| D-05 | BR10 (phần kiểm được trên Gopany) | Màn xem trước và nút *Tham gia* chỉ quan sát trên **app Zalo của người nhận** (OOS03). Kết quả sau *Tham gia* kiểm trên **Gopany**: nhóm bật duyệt → người nhận xuất hiện ở *Cài đặt nhóm → Duyệt thành viên → Thành viên chờ duyệt* (bộ đếm + danh sách, G026 UC-06 b2 / BR08); nhóm tắt duyệt → người nhận xuất hiện trong **danh sách thành viên** của panel nhóm (G008 AF01). Ảnh màn Cài đặt nhóm Hồng gửi 2026-10-19 cho thấy mục "Thành viên chờ duyệt — 0 thành viên đang chờ duyệt" và toggle "Duyệt thành viên tham gia qua link" — là **quan sát sản phẩm**, không thay nguồn | `[NGUỒN]` `G033:192`; `G026:90-91`, `G026:132`, `G026:157`; `G008:244`. Ảnh sản phẩm = quan sát, không gắn `[NGUỒN]` | — | Hồng · 2026-10-19 | — |
| D-06 | BR11, E02, AF06 | Tài khoản Zalo ngắt kết nối → **cả hai lối vào** (dòng *Link nhóm* trên panel và nút *Mời qua link* trong Thêm thành viên) đều ra toast *"Tài khoản Zalo đang ngắt kết nối. Vui lòng kết nối lại"* và **không mở màn**. Căn cứ: UC-01 b1 gộp hai lối vào và trỏ E02; AF06 "mọi luật của G033 áp dụng y như khi vào từ panel". Việc màn *Thêm thành viên* có mở được khi ngắt kết nối hay không thuộc G008 — ghi làm precondition của case, không phải kỳ vọng G033 | `[NGUỒN]` `G033:59`, `G033:156`, `G033:167`, `G033:175`, `G033:193` | — | Hồng · 2026-10-19 | — |
| D-07 | BR15, BR03 (không tự tạo link) | Kiểm "không tự tạo link khi mở màn" gồm hai bước: (1) bấm dòng *Link nhóm* → màn §10F; đóng, mở lại **nhiều lần, cả hai lối vào** → vẫn §10F, không lúc nào tự chuyển sang §10B; (2) đối chiếu **ngoài màn**: trên app Zalo nhóm vẫn **chưa có link** sau các lần mở (cùng mốc đối chiếu với D-02). Chỉ nhìn màn §10F một lần (cách Hồng nêu) chưa đủ chứng minh hệ thống không âm thầm tạo link ở Zalo | Bước (1) `[NGUỒN]` `G033:185`, `G033:196`, `G033:451`; bước (2) `[DIỄN GIẢI AI]` — tài liệu không nói kiểm ở Zalo | — | Hồng + AI · 2026-10-19 (Hồng nêu bước 1, AI thêm bước 2) | — |
| D-08 | BR01, BR02 (hai lối vào cùng link / QR) | Hai cách kiểm, dùng cả hai: (1) **so trực tiếp** — chuỗi link ở hai lối vào giống nhau (D-01) và **quét QR ở mỗi lối vào** giải mã ra đúng chuỗi đó; (2) **kiểm hành vi cuối** (cách Hồng nêu) — gửi link lấy từ hai lối vào cho hai người, cả hai vào (hoặc vào hàng chờ duyệt) **cùng một nhóm**. Cách (2) một mình chưa kiểm được "cùng một mã QR" nên vẫn cần quét QR | `[NGUỒN]` `G033:420`, `G033:428`, `G033:484`; cách (2) là cách kiểm QA chọn, kỳ vọng vẫn theo các AC trên | — | Hồng + AI · 2026-10-19 | — |
| D-09 | BR02 (không sinh đường tham gia thứ hai), BR17, OOS01 | "Đường tham gia thứ hai" lộ ra khi QR **không cùng vòng đời với link**. Hai tình huống kiểm: (1) quét QR giải mã ra chuỗi **khác** link dạng chữ bên dưới; (2) **Lưu mã QR** (PNG) trước, rồi *Đổi link* hoặc *Huỷ link* → quét **ảnh QR đã lưu** phải **không vào được nhóm** nữa (QR cũ chết cùng link cũ), còn QR mới trên màn giải mã ra link mới. Kịch bản Hồng nêu — *Tạo ngay* từ lối vào panel rồi mở bằng *Mời qua link* thấy QR — là case cho **AF08 / BR01** (hai lối vào phản ánh cùng trạng thái), ghi vào coverage, không phải case "đường thứ hai" | `[NGUỒN]` `G033:184`, `G033:428`, `G033:463-464`, `G033:503` (OOS01: đổi / huỷ link thì QR đổi / mất theo); case AF08 `G033:158` | — | AI nêu, Hồng chưa phản đối · 2026-10-19 | — |
| D-10 | BR04 (phạm vi quyền "Quản lý nhóm") | Quyền "Quản lý nhóm" là **quyền của nhân sự, chung cho cả module** (G008: "toàn quyền tương đương Admin trong module này"), không cấp theo từng tài khoản Zalo. Nhóm nào nhân sự **thấy được** thì do tài khoản Zalo **được gán** (G002) quyết định; nhân sự không được gán tài khoản của nhóm thì không mở được hội thoại nhóm → không tới panel → **ngoài case G033** (precondition `G033:48`). Có quyền + được gán tài khoản → thấy dòng *Link nhóm* ở mọi nhóm của các tài khoản được gán | `[NGUỒN]` `G008:26`, `G008:42`, `G033:48`, `G033:186`; ý "áp dụng cho mọi tài khoản đã gán" là `[DIỄN GIẢI AI]` — G002 v1.2 không nhắc quyền Quản lý nhóm | — | Hồng · 2026-10-19 | — |
| D-11 | BR06 / G003 BR21 (nhóm đích chặn nhắn tin) | Nhóm đích bật "chỉ trưởng nhóm được nhắn tin" → mờ, không tích được (`[NGUỒN]`). Riêng khi tài khoản đang gửi **là trưởng nhóm** của nhóm đích: Hồng đọc là tích được (căn cứ G026 BR06 chỉ khoá ô nhập của thành viên); chữ G003 BR21 / G033 BR06 không có ngoại lệ → hai bên lệch, cả hai có căn cứ → **Q-21** | `[NGUỒN]` `G033:188`, `G003:317` cho nhánh chính; nhánh trưởng nhóm `[CẦN XÁC NHẬN]` Q-21 | Q-21 | Hồng + AI · 2026-10-19 | — |
| D-12 | BR07, BR13, E07 | Kiểm ảnh PNG tải về: (1) **kiểm hành vi cuối** (cách Hồng nêu) — gửi link chữ cho người A, gửi **file PNG đã tải** cho người B; A bấm link, B quét ảnh → cả hai vào (hoặc vào hàng chờ duyệt) **cùng một nhóm**; (2) kiểm trực tiếp — quét file PNG ra đúng chuỗi link đang hiện; tên file đúng `QR - {tên nhóm}.png`; file mở được, đúng định dạng PNG. Trên Web file nằm ở thư mục tải về, trên điện thoại ở thư viện ảnh | `[NGUỒN]` `G033:189`, `G033:194`, `G033:428`, `G033:444`, `G033:484` | — | Hồng + AI · 2026-10-19 | — |
| D-13 | BR09, AF03, §10C (nhóm đầy) | **Ngoài phạm vi kiểm thử đợt này** — quyết định của Hồng (QA) 2026-10-19: không dựng được nhóm đạt `maxMember` trên môi trường test. BR09 và AC `G033:475-477`, dòng "cả hai cùng đúng" `G033:285` **vẫn thuộc tài liệu**: Test Designer liệt kê trong Coverage Matrix với ghi chú "không chạy — quyết định QA", không viết kỳ vọng thay thế. Q-10 chỉ còn phần ghi chú chữ AF03 cho BA; phần hỏi Dev cách lấy `maxMember` không còn cần | Quyết định phạm vi của người dùng (rule 10 §3); BR là `[NGUỒN]` `G033:191` | Q-10 | Hồng · 2026-10-19 | — |
| D-14 | BR13, §10E (nền tảng) | Chạy trên **cả ba nền tảng** Web · Android · iOS, **ưu tiên Web** (Round 1 Web, mobile sau). Kỳ vọng **hành vi, chuỗi, giới hạn giống nhau**; chỉ được khác: Web popup giữa màn ~420px, đóng bằng ✕ / Esc / click nền mờ, file PNG vào thư mục tải về; mobile màn toàn trang, nút ←, ảnh vào thư viện ảnh. Khác ở hành vi hoặc chuỗi → lỗi | `[NGUỒN]` `G033:194`, `G033:326`, `G033:487-488`; thứ tự ưu tiên là quyết định của Hồng | — | Hồng · 2026-10-19 | — |
| D-15 | BR14, UC-02 (tin gửi dạng thẻ) | Kiểm ở **cả hai nơi**: (1) **app Zalo của người nhận** — căn cứ chính, vì tài liệu nói "người nhận chỉ thấy link" khi xoá trắng và AC nói hội thoại đích nhận đúng chữ đã sửa kèm link; tin hiện dạng thẻ (avatar + tên nhóm + link), không phải tin chữ thường; (2) **khung chat Gopany** của hội thoại đích — hình dạng thẻ trong Gopany tài liệu chưa nói (Q-13) → ĐO & GHI, không làm tiêu chí pass | `[NGUỒN]` `G033:195`, `G033:441-443` cho phía người nhận; phía Gopany `[CẦN XÁC NHẬN]` Q-13 | Q-13 | Hồng · 2026-10-19 | — |
| D-16 | BR16, §10F (ghi Zalo xong mới đổi màn) | Kỳ vọng: trong lúc chờ Zalo, màn **vẫn là §10F**, nút *Tạo ngay* ở trạng thái đang xử lý, **không bấm được lần hai**; §10B (QR + link + ba nút + `•••`) chỉ xuất hiện **cùng** toast *"Tạo link thành công"*; link hiện ra phải **trùng** link nhóm trên app Zalo. Cách kiểm (AI đề xuất, Hồng chưa có cách riêng): (1) trên Web làm **chậm mạng** bằng DevTools (throttling) để kéo dài khoảng chờ, quan sát màn và thử bấm lần hai; (2) sau toast, mở app Zalo → thông tin nhóm → link nhóm, so với link trên màn; (3) nhánh âm: tạo bằng tài khoản Zalo **không phải trưởng nhóm** → Zalo từ chối → E08, màn giữ §10F, bấm lại được | Kỳ vọng `[NGUỒN]` `G033:197`, `G033:358-359`, `G033:453`, `G033:455-456`; cách làm chậm mạng là kỹ thuật QA `[QA BỔ SUNG]` | — | AI đề xuất · 2026-10-19 — Hồng chưa phản đối | — |
| D-17 | BR17, UC-05, UC-06 (link cũ chết ngay) | Lưu link cũ (chuỗi) **và** ảnh QR cũ (PNG) trước khi đổi / huỷ. Sau toast *"Đã đổi link nhóm"* / *"Đã huỷ link nhóm"*, dùng **một tài khoản Zalo bất kỳ ngoài nhóm** bấm link cũ (và quét QR cũ) → **không tham gia được nhóm**, kiểm **ngay** sau toast, không chờ. Thông báo app Zalo hiện lúc đó do Zalo quyết → ĐO & GHI, không làm tiêu chí. Với *Đổi link*: link mới + QR mới trên màn phải dùng được (quét ra link mới, vào được nhóm) | `[NGUỒN]` `G033:198`, `G033:463-464`, `G033:466`, `G033:503`; chuỗi thông báo phía Zalo không có nguồn | — | Hồng · 2026-10-19 | — |
| D-18 | E01, BR04 (không quyền); cột "Notification — ghi log" của E03, E04, E06, E07, E08 | QA kiểm phần nhìn thấy: tài khoản **không** phải Admin và **không** có quyền "Quản lý nhóm" → panel thông tin nhóm **không có** dòng *Link nhóm* (kể cả dạng mờ), trên cả ba nền tảng; nút *Mời qua link* không tới được vì G008 BR06 ẩn nút quản lý. "Gọi API thẳng → từ chối" chờ endpoint (Q-09). **Ghi log** (truy cập trái phép, error log, mã lỗi Zalo ở E08): **Dev kiểm**, QA ghi "Dev xác nhận" trong Note, không chấm Pass / Fail | `[NGUỒN]` `G033:166`, `G033:186`, `G033:243`, `G033:423`; `G008:292`. Cách chia việc log là quyết định của Hồng | Q-09 | Hồng · 2026-10-19 | — |
| D-19 | E04 (nhóm giải tán / rời nhóm) | **Lúc mở màn** (UC-01 b2): toast *"Nhóm không còn tồn tại"*, đóng màn, panel tải lại — `[NGUỒN]`. **Trong lúc màn đang mở**: Hồng kỳ vọng xử lý giống hệt E04; tài liệu không gắn E04 cho thời điểm này và dòng 223 chỉ nói về trạng thái link → `[GIẢ ĐỊNH]`, case đánh ❓, hỏi BA ở Q-22 | `[NGUỒN]` `G033:169`, `G033:492` cho lúc mở màn; nhánh đang mở `[GIẢ ĐỊNH]` → Q-22 | Q-22 | Hồng + AI · 2026-10-19 | — |
| D-20 | AF07, AF01, §10E, §10G (Esc / ✕ / Huỷ) | `Esc` hoặc ✕ hoặc nút **Huỷ** khi **hộp xác nhận** đang mở → chỉ **đóng hộp xác nhận**, popup Link nhóm phía sau **vẫn mở**, link giữ nguyên, màn không đổi gì. `Esc` / ✕ / click nền mờ khi **không** có hộp xác nhận → đóng popup Link nhóm, **về đúng chỗ vừa đi ra** (panel, hoặc màn Thêm thành viên nếu vào từ *Mời qua link*), không thay đổi gì. Mobile: nút ← thay ✕ | `[NGUỒN]` `G033:152`, `G033:156`, `G033:157`, `G033:326`, `G033:406`, `G033:467`, `G033:487` | — | Hồng · 2026-10-19 | — |
| D-21 | Chuỗi hiển thị §10B, §10C, §10D, §10F, §10G, toast UC / E | Kỳ vọng chuỗi **đúng nguyên văn tài liệu** (tài liệu ghi "chép đúng chuỗi Zalo đang dùng"). Mức chấp nhận do Hồng chốt: khác **cách bỏ dấu cùng một chữ** ("Huỷ" / "Hủy") → **chấp nhận**, ghi Note; thiếu / thừa từ, thiếu dấu "—", thiếu dấu chấm cuối câu, đổi nghĩa, sai tên nút → **lỗi**. Chuỗi E08 phần giữa "…" chờ Q-12; chuỗi do app Zalo hiện (màn xem trước, thông báo link chết) không có nguồn → ĐO & GHI | Chuỗi `[NGUỒN]` `G033:63`, `G033:72`, `G033:88`, `G033:98`, `G033:108`, `G033:167-173`, `G033:272`, `G033:283-284`, `G033:355`, `G033:383-401`; mức chấp nhận là quyết định QA (AI diễn giải câu trả lời của Hồng, Hồng chưa phản đối) | Q-12 | Hồng + AI · 2026-10-19 | — |
| D-22 | E07, E05 (tải ảnh QR thất bại) | Cách Hồng: **tắt mạng** rồi bấm *Lưu mã QR*. Kỳ vọng: toast, màn giữ nguyên, bấm lại được — nhưng toast là **E05** (*"Mất kết nối, vui lòng thử lại"*) hay **E07** (*"Không tải được mã QR. Vui lòng thử lại."*) tài liệu không nói ưu tiên → case đánh ❓, bổ sung vào Q-11; nếu ảnh QR đã có sẵn ở trình duyệt thì có thể lưu được khi mất mạng → ĐO & GHI. Cách thêm để ra đúng E07 khi còn mạng: DevTools chặn request ảnh QR (Block request URL) `[QA BỔ SUNG]` | `[NGUỒN]` `G033:170`, `G033:172`, `G033:493`, `G033:495`; ưu tiên toast `[CẦN XÁC NHẬN]` Q-11 | Q-11 | Hồng + AI · 2026-10-19 | — |

Đã đi: BR03, BR05, BR08, BR10, BR11, BR15, BR01, BR02, BR04, BR06, BR07, BR09, BR13, BR14, BR16, BR17, E01, E04, E07, AF01, AF07, chuỗi
UI. E02, E03, E08, AF02, AF05, AF06, AF08 được chốt trong các lượt BR tương ứng (D-03, D-04, D-06, D-08, D-16). E05 / E06 chờ Q-11.

## 5. Các cách hiểu khác nhau còn tồn tại

Q-11, Q-14, Q-19, Q-21, Q-23 — mỗi câu hai cách hiểu, xem bảng. Q-05 → Q-10, Q-12, Q-13, Q-15 → Q-17, Q-20, Q-22, Q-24, Q-25 — tài liệu không nói:
**Unresolved / BA Clarification Required**, đã cô lập. Q-01 → Q-04 đã có BA, không còn hai cách hiểu.

## 6. Điểm đã thống nhất và điểm còn mở

- Đã xác nhận (BA): Q-01, Q-02, Q-03, Q-04.
- Đã thống nhất (debate): chưa có.
- Còn mở — **trọng yếu**: không có (Hồng chấp nhận mức đề xuất của Q-06, Q-21 khi mở cổng).
- Còn mở — không trọng yếu (đã cô lập): Q-05 → Q-17, Q-19 → Q-25.
- Đã chốt (người dùng): Q-18 — dùng bản Draft.

## 7. Cần BA / Dev / Product xác nhận

Nội dung gửi (copy được) ở `cau-hoi-gui-BA.md`. Tóm tắt:

| Q | Gửi ai | Việc cần |
| --- | --- | --- |
| Q-01, Q-03 (đã trả lời) | BA Trân | Ghi chú cập nhật: G008 BR15 / AF01 / §10C / AC lên v1.9; sửa dẫn chiếu G011 BR02b, G008 BR25 |
| Q-02 (đã trả lời) | BA Trân | Ghi chú cập nhật: bỏ "phó nhóm" ở G033 E08, BR16, AC 422, 457 |
| Q-04 (đã trả lời) | BA Trân | Ghi chú cập nhật: G033 BR06, AC 438 — không đổi được bộ lọc tài khoản |
| Q-19 → Q-25 | BA Trân | Lệch với G036 Q-01 về phó nhóm; bộ lọc tài khoản khoá hay ẩn; trưởng nhóm gửi vào nhóm đích đang chặn nhắn tin; nhóm giải tán khi màn đang mở; chuỗi bộ đếm; `•••` ở E03; dấu hiệu khi cập nhật realtime |
| Q-11 → Q-16 | BA Trân | Làm rõ chữ / hành vi nhánh phụ |
| Q-05 → Q-10, Q-17 | Dev / hub (nhờ BA chuyển) | OQ01 → OQ05, endpoint E01, cách lấy `maxMember`, tên file |

## 8. Ngoài phạm vi / chưa có căn cứ

- OOS01 → OOS08 (`G033:503-510`): QR có vòng đời riêng · lịch sử link · quét QR từ trong hệ thống · thống kê · in QR · tuỳ biến QR ·
  luật cache / tần suất của G016 / G018 · công tắc Bật / Tắt link mời.
- Data model / API: `N/A` (`G033:231`) — không có mã lỗi hay endpoint để kiểm.
- Luồng sau nút *Tham gia* (chờ duyệt → thành viên) thuộc G026; màn xem trước nhóm do app Zalo dựng.
- Link hết hạn (OQ03), trạng thái "tắt link mời" (OQ05): chưa có luật — không viết case.
- BR09 / AF03 / §10C "nhóm đã đủ số thành viên tối đa": ngoài phạm vi **chạy** đợt này theo quyết định Hồng 2026-10-19 (D-13); vẫn liệt kê trong coverage.
- Mã dùng chung BR-C06 / BR-C07 / BR-C12: không có file định nghĩa trong `tailieu/`; chỉ dùng được nội dung G033 tự nêu.

## 9. Change Proposal / New Requirement Candidate `[ĐỀ XUẤT THAY ĐỔI]`

Chưa có.

## 10. QA coverage bổ sung dự kiến `[QA BỔ SUNG]`

- Mở màn nhiều lần, từ cả hai lối vào, trên hai nền tảng → cùng một chuỗi link (BR03).
- Quét QR bằng app Zalo và bằng app đọc QR thường → chuỗi giải mã bằng link hiển thị (BR02).
- Chia sẻ link: chọn 1 / 98 / 99 / cố chọn 100 hội thoại; nhóm bị disable không tính vào bộ đếm (G003 §10G).
- Dòng tin kèm: mặc định · sửa · xoá trắng · có chứa link khác (Q-13) · rất dài.
- Tên nhóm có emoji, ký tự `/ : ? *`, rất dài → tên file PNG (Q-17); tên dài cắt `…` trên màn (`G033:271`).
- Hai người cùng mở màn, một người đổi link → người kia thấy cập nhật ngay (`G033:223`).
- Bấm Tạo ngay / Đổi link / Huỷ link nhiều lần nhanh → chỉ một yêu cầu (`G033:358`, `G033:408`).
- Nhóm vừa bật duyệt vừa đầy → hai dòng, thứ tự đúng (`G033:285`).
- Tài khoản Zalo chuyển sang Ngắt kết nối trong lúc màn đang mở.
- Thao tác trong lúc §15 quá 10 giây → E03 (ĐO & GHI).

## 11. Xác nhận mở cổng

- [x] Điểm trọng yếu còn mở = 0 — không điểm nào được xếp trọng yếu; Hồng chấp nhận mức đề xuất của Q-06, Q-21
- [x] Đã debate S4b (mục 4 có D-01 → D-22, 2026-10-19)
- [x] Người dùng đã chốt Q-18 (dùng bản Draft)
- [x] Người dùng đã được trình bày mục 2–8 trong phiên
- Người dùng xác nhận: Hồng (QA) · 2026-10-19 · nguyên văn: "mo cong" — trả lời đề nghị "nếu chị đồng ý ba điểm trên thì nói mở cổng"
- Lưu ý: Q-05 → Q-17, Q-19 → Q-22 vẫn là `[CẦN XÁC NHẬN]`; Q-01 → Q-04 đã có BA.

## Lịch sử cập nhật

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
| 2026-10-19 | AI (Orchestrator) | Tạo bản đầu sau Requirement Analysis: 18 câu hỏi (Q-01 → Q-17 không trọng yếu theo đề xuất, Q-18 người dùng chốt), cổng đóng, S4b chưa bắt đầu |
| 2026-10-19 | Hồng (chuyển BA Trân) + AI (Orchestrator) | Ghi trả lời Q-01 → Q-04 (`[ĐÃ XÁC NHẬN]`, tài liệu chưa cập nhật) vào mục 3, 4; cập nhật mục 2, 5, 6, 7; thêm Q-19 (lệch G036 Q-01), Q-20 (hình thức bộ lọc tài khoản); nonMaterialOpen 17 → 15 |
| 2026-10-19 | Hồng + AI (debate S4b) | Lượt 1 BR03 → D-01, D-02 (so chuỗi link; mốc đối chiếu ngoài màn) |
| 2026-10-19 | Hồng + AI (debate S4b) | Lượt 2 BR05 → D-03 (không có ≠ mờ; mờ là E03) |
| 2026-10-19 | Hồng + AI (debate S4b) | Lượt 3 BR08 → D-04 (chưa có link thì không dòng nhắc) |
| 2026-10-19 | Hồng + AI (debate S4b) | Lượt 4 BR10 → D-05 (nơi kiểm chờ duyệt / vào thẳng trên Gopany; ảnh Cài đặt nhóm là quan sát sản phẩm) |
| 2026-10-19 | Hồng + AI (debate S4b) | Lượt 5 BR11 → D-06 (E02 áp cho cả hai lối vào) |
| 2026-10-19 | Hồng + AI (debate S4b) | Lượt 6 BR15 → D-07 (kiểm không tự tạo link: mở lại nhiều lần + đối chiếu app Zalo) |
| 2026-10-19 | Hồng + AI (debate S4b) | Lượt 7 BR01 → D-08 (so chuỗi + quét QR, cộng kiểm hành vi cuối) |
| 2026-10-19 | Hồng + AI (debate S4b) | Lượt 8 BR02 → D-09 (QR cũ đã lưu phải chết cùng link cũ; kịch bản Hồng → case AF08) |
| 2026-10-19 | Hồng + AI (debate S4b) | Lượt 9 BR04 → D-10 (quyền chung module; phạm vi nhóm theo tài khoản được gán) |
| 2026-10-19 | Hồng + AI (debate S4b) | Lượt 10 BR06 → D-11; lệch có căn cứ → thêm Q-21; nonMaterialOpen 15 → 16 |
| 2026-10-19 | Hồng + AI (debate S4b) | Lượt 11 BR07 → D-12 (gửi link + PNG cho hai người, cùng vào một nhóm; quét file ra đúng chuỗi) |
| 2026-10-19 | Hồng + AI (debate S4b) | Lượt 12 BR09 → D-13 (Hồng quyết định ngoài phạm vi chạy; giữ trong coverage); mục 8 thêm dòng |
| 2026-10-19 | Hồng + AI (debate S4b) | Lượt 13 BR13 → D-14 (ba nền tảng, ưu tiên Web) |
| 2026-10-19 | Hồng + AI (debate S4b) | Lượt 14 BR14 → D-15 (kiểm trên Zalo người nhận + khung chat Gopany) |
| 2026-10-19 | Hồng + AI (debate S4b) | Lượt 15 BR16 → D-16 (kéo dài khoảng chờ bằng throttling; so link với app Zalo; nhánh E08) |
| 2026-10-19 | Hồng + AI (debate S4b) | Lượt 16 BR17 → D-17 (link cũ + QR cũ không vào được, kiểm ngay sau toast). Hết 16 BR; sang E / AF / §10 |
| 2026-10-19 | Hồng + AI (debate S4b) | Lượt 17 E01 → D-18 (QA kiểm ẩn dòng; log giao Dev) |
| 2026-10-19 | Hồng + AI (debate S4b) | Lượt 18 E04 → D-19; thêm Q-22 (nhóm giải tán khi màn đang mở); nonMaterialOpen 16 → 17 |
| 2026-10-19 | Hồng + AI (debate S4b) | Lượt 19 AF07 / AF01 → D-20 (Esc chỉ đóng hộp xác nhận) |
| 2026-10-19 | Hồng + AI (debate S4b) | Lượt 20 chuỗi UI → D-21 (Huỷ / Hủy chấp nhận; lệch khác là lỗi) |
| 2026-10-19 | Hồng + AI (debate S4b) | Lượt 21 E07 → D-22; bổ sung Q-11; khép S4b — stage S4a → S4b, chờ chốt mức Q-06, Q-21, chốt Q-18 và xác nhận mở cổng |
| 2026-10-19 | Hồng (QA) | Chấp nhận mức Q-06, Q-21; chốt Q-18 dùng bản Draft; xác nhận mở cổng — gate open, stage S6-S7 |
| 2026-10-19 | AI (Orchestrator) | Sau S6/S7: cấp Q-23 (chuỗi bộ đếm), Q-24 (`•••` ở E03), Q-25 (dấu hiệu cập nhật realtime); bổ sung Q-07, Q-09, Q-11, Q-15 theo điểm sub-agent trả về; không điểm trọng yếu, cổng giữ mở; stage S6-S7 → S9; nonMaterialOpen 17 → 20 |
