---
featureId: CR-ANH-FILE-THU-HOI   # mã tạm — CR chưa được cấp mã
stage: S4a
gate: closed
materialOpen: 2          # đề xuất của AI — chờ người dùng chốt mức
nonMaterialOpen: 10
gateOpenedBy:
gateOpenedAt:
updatedAt: 2026-10-14
---

# Requirement Understanding / Alignment Summary — CR-ANH-FILE-THU-HOI: Thao tác đối với ảnh/file đã bị thu hồi

Trạng thái: **S4a — câu hỏi đã lập, chờ người dùng chốt mức và gửi BA Đỗ Văn An.** Debate S4b bắt đầu ngay với BR
không phụ thuộc BA (rule 04 §4b: thứ tự BR, câu hỏi mở, Hồng nói trước).

## 1. Nguồn và phạm vi đã đọc

Xem mục 1 của `01-requirement-analysis.md`. Nguồn chính: CR v1.0 (13/10/2026, BA Đỗ Văn An, mã chưa cấp). Dùng chung:
CR-V v1.1 (viewer), G003 v1.11 (UC-06, BR06/07/09/10/12/19, §10D), G036 (BR14/16/20/28), ESC, G001 BR03. Thiếu: ảnh hiện
trạng, chính sách quyền, spec app Gopany, spec viewer hiện hành.

## 2. Requirement / Business rule đã trích

| Mã | Tóm tắt | Nguồn | Trạng thái hiểu |
| --- | --- | --- | --- |
| BR-01 | Điều kiện mở / xem / tải; thu hồi không còn là lý do chặn; thumbnail ≠ nguồn | `CR:67-75` | `[NGUỒN]` — còn mở Q-01 (quyền), Q-03 (nguồn mất) |
| BR-02 | Ảnh thu hồi trong chat: đen trắng + nhãn, nhận click | `CR:81-85` | `[NGUỒN]` — Q-05 (chữ nhãn) |
| BR-03 | Mở viewer đúng ảnh, màu nguồn, đóng về chat | `CR:89-96` | `[NGUỒN]` rõ |
| BR-04 | Cùng bộ thao tác viewer; kế thừa CR-V; tập ảnh | `CR:100-114` | `[NGUỒN]` — còn mở Q-02 (Chuyển tiếp), Q-08 (phụ thuộc CR-V) |
| BR-05 | File thu hồi trong chat: mở lại vùng tải | `CR:120-123` | `[NGUỒN]` — Q-12 (cơ chế hiện hành) |
| BR-06 | Luồng và quy tắc tải file | `CR:127-140` | `[NGUỒN]` rõ |
| BR-07 | Thu hồi trong lúc đang xem / tải | `CR:146-153` | `[NGUỒN]` rõ |
| BR-08 | Phạm vi nền tảng web / app; không đổi Zalo | `CR:159-164` | `[NGUỒN]` — Q-07 (app) |
| BR-09 | 10 tình huống trạng thái / lỗi, 4 thông báo | `CR:170-181` | `[NGUỒN]` — Q-01, Q-04, Q-11 |
| BR-10 | Dữ liệu, chặn ở cả UI lẫn backend, kiểm cả tin gửi / nhận | `CR:185-190` | `[NGUỒN]` rõ |
| BR-11 | Không mở lại thao tác khác; giữ ý nghĩa thu hồi | `CR:47`, `CR:62`, `CR:190` | `[NGUỒN]` — Q-02, Q-06 (tin Đã xóa) |
| BR-12 | Dữ liệu cũ; kiểm truy xuất nguồn trước triển khai | `CR:235-239` | `[NGUỒN]` — Q-03 |

## 3. Bảng câu hỏi debate

| Q | Mức (đề xuất) | Trích dẫn + nguồn | Vì sao chưa rõ | Các cách hiểu có căn cứ | Ảnh hưởng tới test | Cần ai xác nhận | Trạng thái | Câu trả lời | Ai trả lời · ngày · kênh |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Q-01 | **Trọng yếu** (quyền) | `CR:70`, `CR:73`, `CR:176`; AC-25 `CR:222` | "Chính sách hiện hành" về quyền truy cập ảnh / file và "thông báo quyền theo cơ chế hiện hành" — không tài liệu | (a) Chỉ cần quyền xem hội thoại (G003 BR02 / BR11 / BR18), không có quyền riêng cho ảnh / file. (b) Có quyền riêng — cần tài liệu | Có / không nhóm case "có quyền xem nhưng không được tải"; kỳ vọng text của AC-25; cách dựng "mất quyền giữa chừng" (G003 BR12 unassign) | BA An | Mở | | |
| Q-02 | **Trọng yếu** (hành vi) | `CR:100` ↔ `CR:47`; `CR-V:200`, AC-41 `CR-V:263`; `G003:315` | Viewer của ảnh thu hồi có icon Chuyển tiếp hay không | (a) **Ẩn** — `CR:47` không mở lại chuyển tiếp; CR-V AC-41; G003 BR19. (b) **Hiện như ảnh thường** — `CR:100` "không tạo bộ giới hạn riêng do trạng thái thu hồi" | Kỳ vọng AC-03 / AC-29; case "toolbar viewer ảnh thu hồi" | BA An | Mở | | |
| Q-03 | Không trọng yếu | `CR:75`, `CR:179`, `CR:237`, `CR:175` | Khi nào chỉ còn thumbnail / mất nguồn; cách dựng; ai kiểm truy xuất trước triển khai. **Bổ sung (D1-2):** cách dựng "link nguồn hết hạn" và nguyên văn lỗi khi không làm mới được | Tài liệu không nói | Cách dựng AC-22, AC-23; AC-21 dữ liệu cũ | BA An / Dev | Mở — cô lập | | |
| Q-04 | Không trọng yếu (chữ) | `CR:171` ↔ `CR-V:75` | Tải xuống trong viewer, ảnh thu hồi mất nguồn: "Ảnh không còn khả dụng." hay "Không còn tệp ảnh để tải xuống." | (a) Theo CR-V vì thao tác Tải xuống kế thừa CR-V (`CR:112`). (b) Theo CR vì ảnh thu hồi mất nguồn là tình huống của CR | Text kỳ vọng của một case | BA An | Mở — cô lập | | |
| Q-05 | Không trọng yếu (chữ) | `CR:15`, `CR:82` ↔ `G003:185`, `G003:459`; `G003:187` | Nhãn "Tin nhắn đã thu hồi" hay "Đã thu hồi"; có tên Staff thu hồi không | (a) "Tin nhắn đã thu hồi" (CR, mới hơn). (b) "Đã thu hồi" (G003 hiện hành) | Text kỳ vọng AC-01, AC-11 | BA An | Mở — cô lập | | |
| Q-06 | Không trọng yếu | `CR:41`; `G003:181-185`, BR07 `G003:303` | Ảnh / file của tin **Đã xóa** (Xóa chỉ phía tôi) có áp dụng CR không | Tài liệu không nói (CR chỉ nói thu hồi) | Có / không nhóm case tin Đã xóa; hiện tại ghi ĐO & GHI | BA An | Mở — cô lập | | |
| Q-07 | Không trọng yếu | `CR:160`; AC-03 / 15 / 32; `G003:385`, `G003:650` | Không spec viewer / tải file trên app; app có xoay / zoom / kéo không | Tài liệu không nói | Case app ghi "như hiện hành — ĐO & GHI"; AC-06 → AC-09 trên app có áp dụng không | BA An | Mở — cô lập | | |
| Q-08 | Không trọng yếu | `CR:112`; `CR-V:281` | Thứ tự phát hành CR-V và CR này | — | AC-06 → AC-13 chỉ kiểm được sau CR-V | BA An / người dùng | Mở | | |
| Q-09 | Không trọng yếu | `CR:5`, `CR:10` | Mã CR, ưu tiên | — | Tên thư mục / trace tạm `CR-ANH-FILE-THU-HOI` | BA An | Mở — ghi chú | | |
| Q-10 | Không trọng yếu | `CR:19` | Thiếu ảnh hiện trạng | — | Hiện trạng kiểm theo chữ | BA An (gửi file) | Mở — cô lập | | |
| Q-11 | Không trọng yếu | `CR:170`, `CR:114` | Viewer hiện gì trong lúc chờ nguồn (khung chờ / thumbnail màu / thumbnail đen trắng) | Tài liệu không nói | Case "đang lấy nguồn" ĐO & GHI | BA An | Mở — cô lập | | |
| Q-12 | Không trọng yếu | `CR:121`, `CR:136`; `G003:469` | Vùng click tải của thẻ file; thông báo sau khi tải hiện hành trên web / app | Tài liệu không nói | Case AC-14 / AC-15 phần "giống file chưa thu hồi" ĐO & GHI | BA An / Dev | Mở — cô lập | | |

## 4. Cách hiểu đã thống nhất (Debate S4b)

### 4.1 Từ câu trả lời BA

Chưa có.

### 4.2 Debate Hồng ↔ AI theo thứ tự BR (câu hỏi mở, Hồng nói trước, dò lại tài liệu từng dòng)

Bắt đầu 2026-10-14. Thứ tự dự kiến: BR-01 (trừ phần quyền) → BR-02 (trừ chữ nhãn) → BR-03 → BR-04 (trừ Chuyển tiếp) → BR-05 → BR-06
→ BR-07 → BR-09 (trừ Q-01 / Q-04 / Q-11) → BR-10 → BR-11 (trừ Q-02 / Q-06) → BR-12 → BR-08 → phần chờ BA.

**BR-01 — Điều kiện mở / xem / tải (đang debate)**

| # | Nội dung đã thống nhất | Nhãn | Dòng tài liệu đã dò | Ghi chú |
| ---: | --- | --- | --- | --- |
| D1-1 | Thumbnail (đen trắng) còn hiện trong chat **không** chứng minh điều kiện (3) "nội dung nguồn còn được Gopany lưu" đã đạt. Điều kiện (3) chỉ xác định khi hệ thống lấy nguồn lúc user click; chỉ còn thumbnail → không coi là nguồn, hiện "Ảnh không còn khả dụng." / "File không còn khả dụng để tải xuống.", không tải thumbnail hay file rỗng thay nguồn | `[NGUỒN]` | `CR:71`; `CR:75` "có thumbnail… không đồng nghĩa bản nguồn còn tồn tại"; `CR:179`; AC-22 `CR:219`, AC-23 `CR:220` | Hồng nói trước: "đạt" — **lệch với tài liệu**; chốt theo tài liệu, Hồng đổi. Cách dựng "chỉ còn thumbnail" tài liệu không nói → Q-03 |
| D1-2 | Điều kiện (3) có hai nhánh: bản Gopany **đang lưu** và bản Gopany **lấy được qua link** còn hạn; link hết hạn → làm mới bằng cơ chế hiện hành nếu còn quyền, không lấy được → lỗi (tài liệu không nói nguyên văn). Trên UI hai nhánh **không phân biệt được** khi thành công; chỉ lộ khi link hết hạn | `[NGUỒN]` (hai nhánh, làm mới link) + `[DIỄN GIẢI AI]` ("truy xuất hợp lệ" = lấy qua link ngoài, vd phía Zalo) | `CR:71`; `CR:96` "bản ảnh Gopany đang lưu/cung cấp"; `CR:175` | Hồng: chưa nghĩ ra case → AI nêu cách đọc. Case "link hết hạn" không dựng được từ UI → bổ sung vào Q-03 (Dev cho cách dựng) |

BR-01 **xong** phần không chờ BA (còn Q-01 quyền, Q-03 cách dựng).

**BR-02 — Ảnh thu hồi trong đoạn chat (đang debate)**

| # | Nội dung đã thống nhất | Nhãn | Dòng tài liệu đã dò | Ghi chú |
| ---: | --- | --- | --- | --- |
| D2-1 | Chỉ **vùng ảnh** (khung ảnh đen trắng) nhận click / chạm để mở viewer. Click vào **chú thích** dưới ảnh hoặc dòng **"Tin nhắn đã thu hồi"** → tài liệu không nói; kiểm ĐO & GHI và so với tin ảnh **chưa thu hồi** cùng loại (hành vi hiện hành, không có spec) | `[NGUỒN]` (vùng ảnh) + `[QA BỔ SUNG]` (chú thích / nhãn ĐO & GHI) | `CR:83` "Vùng ảnh nhận click để mở viewer. Trên thiết bị cảm ứng, user chạm vào ảnh để mở"; `G036:147` chú thích dính dưới ảnh | Hồng nói trước: "là vùng ảnh" — khớp. Case: tin ảnh có chú thích, click lần lượt ảnh / chú thích / nhãn, trên web và màn cảm ứng |
| D2-2 | Bằng chứng "đen trắng không ghi đè dữ liệu nguồn": (1) viewer hiện **màu nguồn** (AC-04); (2) file **tải về** từ viewer giữ màu và hướng gốc (AC-09) — so sánh với file gốc đã gửi (hash / mở bằng trình xem ảnh); (3) user khác mở cùng ảnh, Zalo app vẫn giữ trạng thái riêng (AC-28). Kiểm DB là bằng chứng bổ sung, chỉ khi QA có quyền truy cập; tài liệu không có data model để đối chiếu | `[NGUỒN]` (ba bằng chứng) + `[QA BỔ SUNG]` (DB, hash file) | `CR:84`; `CR:92`; `CR:104`; AC-04 `CR:201`; AC-09 `CR:206`; `CR:153`; AC-28 `CR:225` | Hồng nói trước: "check trong DB" — không sai nhưng tài liệu không hỗ trợ; bổ sung bằng chứng theo tài liệu |

BR-02 **xong** phần không chờ BA (còn Q-05 chữ nhãn).

**BR-03 — Mở viewer và màu nguồn (đang debate)**

| # | Nội dung đã thống nhất | Nhãn | Dòng tài liệu đã dò | Ghi chú |
| ---: | --- | --- | --- | --- |
| D3-1 | AC-05 dùng ảnh **nguồn vốn đen trắng** (gửi file grayscale thật); viewer hiện đúng như nguồn, hệ thống không tự tô màu. Vì ảnh xám nhìn không phân biệt được "màu nguồn" với "hiệu ứng thu hồi", kiểm bằng: giữ file gốc đã gửi, so viewer / file tải về với file gốc; chạy cặp với AC-04 (ảnh màu, cùng tin hoặc cùng phiên) làm đối chứng rằng viewer không áp hiệu ứng | `[NGUỒN]` (không tự tô màu, ảnh gốc đen trắng vẫn đen trắng) + `[QA BỔ SUNG]` (cách đối chứng) | `CR:96`; AC-04 `CR:201`; AC-05 `CR:202` | Hồng nói trước: "khi tải ảnh chọn ảnh đen trắng" — khớp phần dữ liệu; AI bổ sung cách đối chứng |
| D3-2 | Trạng thái chat trước khi mở viewer: **cuộn lên** tới tin ảnh thu hồi cũ (xa đáy vài màn hình, trong 24 giờ thu hồi) và **đang gõ dở** text ở ô nhập. Sau khi đóng viewer (nút Đóng hoặc Esc): vẫn đúng hội thoại, vị trí cuộn không nhảy về đáy, text gõ dở còn nguyên; ảnh trong chat vẫn đen trắng + nhãn | `[NGUỒN]` | `CR:94`; `CR-V:137`; `ESC:22` AC-02; `G036:159` BR26 "tin đang xem đứng yên… không giành quyền cuộn"; `G003:302` BR06 | Hồng nói trước: "tin cũ, đang cuộn xem lại, đang soạn text" — khớp. Case thêm `[QA BỔ SUNG]`: có tin mới tới trong lúc viewer mở (BR26: đang đọc tin cũ thì giữ chỗ) |

BR-03 **xong**.

## 5. Các cách hiểu khác nhau còn tồn tại

Q-01, Q-02, Q-04, Q-05 — hai cách hiểu, xem bảng. Q-03, Q-06, Q-07, Q-11, Q-12 — tài liệu không nói: **Unresolved / BA
Clarification Required**.

## 6. Điểm đã thống nhất và điểm còn mở

- Đã thống nhất: chưa có.
- Còn mở — **trọng yếu** (đề xuất): Q-01, Q-02.
- Còn mở — không trọng yếu (cô lập): Q-03 → Q-12.

## 7. Cần BA xác nhận

Nội dung gửi BA Đỗ Văn An: `cau-hoi-gui-BA.md` cùng thư mục.

## 8. Ngoài phạm vi / chưa có căn cứ

- Theo `CR:45-51`: khôi phục / gửi lại lên Zalo; đổi quyền; mở lại trả lời / phản ứng / chuyển tiếp / thu hồi lại; video, sticker, văn bản; nội dung chưa từng lưu; chính sách xóa / lưu trữ; xem trước file.
- Hành vi trên Zalo app / Zalo web: không thuộc CR (`CR:161-162`); chỉ kiểm AC-28 (Zalo vẫn giữ trạng thái thu hồi).
- Mức zoom, giới hạn kéo, reset, toolbar, Esc: theo CR-V (`CR:112`), CR không định nghĩa lại.

## 9. Change Proposal / New Requirement Candidate `[ĐỀ XUẤT THAY ĐỔI]`

Chưa có.

## 10. QA coverage bổ sung dự kiến `[QA BỔ SUNG]`

- Tin một ảnh / nhiều ảnh (album) thu hồi; ảnh màu, grayscale thật, dọc / ngang, có EXIF xoay; file tên tiếng Việt / ký tự đặc biệt / trùng tên.
- Thu hồi do tài khoản liên kết (từ Gopany, từ điện thoại) và do khách; tin ≤ 24h (G003 BR06).
- Dữ liệu: có nguồn / chỉ thumbnail / nguồn mất / link hết hạn × quyền còn / mất — decision table.
- Thời điểm: thu hồi trước khi tải nguồn xong, trong lúc đang tải file, đổi ảnh A → B kết quả A về muộn (mạng chậm).
- Kiểm chặn ở backend: quan sát response tải nguồn (DevTools Network), không chỉ UI.
- Hồi quy: tin Đã xóa, tin ảnh chưa thu hồi, hover option của tin thu hồi (G036 BR20 / BR21), ghim tin thu hồi (G014).

## 11. Xác nhận mở cổng

- [ ] Điểm trọng yếu còn mở = 0 (hiện 2: Q-01, Q-02 — chờ BA An)
- [ ] Debate S4b đã đi hết các BR (mục 4.2 có nội dung)
- [ ] Người dùng đã chốt mức các Q và Q-08 (lịch)
- Người dùng xác nhận: —

## Lịch sử cập nhật

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
| 2026-10-14 | AI (Orchestrator) | Tạo bản đầu sau Requirement Analysis: 12 câu, 2 đề xuất trọng yếu (Q-01 quyền, Q-02 icon Chuyển tiếp trong viewer ảnh thu hồi), cổng đóng |
| 2026-10-14 | Hồng (QA) + AI | Debate S4b BR-01 lượt 1: D1-1 (thumbnail ≠ nguồn) — Hồng đọc "đạt", chốt theo tài liệu |
| 2026-10-14 | Hồng (QA) + AI | Debate S4b BR-01 lượt 2: D1-2 (hai nhánh của điều kiện 3, link hết hạn); bổ sung Q-03. BR-01 xong phần không chờ BA |
| 2026-10-14 | Hồng (QA) + AI | Debate S4b BR-02 lượt 1: D2-1 (vùng click = vùng ảnh; chú thích / nhãn ĐO & GHI) |
| 2026-10-14 | Hồng (QA) + AI | Debate S4b BR-02 lượt 2: D2-2 (bằng chứng không ghi đè nguồn). BR-02 xong phần không chờ BA |
| 2026-10-14 | Hồng (QA) + AI | Debate S4b BR-03 lượt 1: D3-1 (dữ liệu và đối chứng cho ảnh vốn đen trắng) |
| 2026-10-14 | Hồng (QA) + AI | Debate S4b BR-03 lượt 2: D3-2 (trạng thái chat để kiểm cuộn / soạn). BR-03 xong |
