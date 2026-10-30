---
featureId: G036
basedOn: 02-alignment-summary.md (gate: open, 2026-10-13, mở bởi Hồng (QA))
reviewedAt: 2026-10-13
modes: [1, 3]              # 1 = UI/UX/CX Review · 3 = Customer Journey Review (chỉ ở mức phân tích tài liệu)
evidenceLevel: phân tích tài liệu
reviewer: Customer Experience Agent (AI) — người dùng: Hồng (QA)
---

# CX Review — G036: Giao diện khung hội thoại — giống Zalo PC

> **Mode đã chạy:** Mode 1 (UI/UX/CX Review từ tài liệu) và Mode 3 (Customer Journey Review) — **cả hai chỉ ở mức
> phân tích tài liệu**. **Không chạy Mode 2** (Customer Simulation): không có UI design, prototype, sản phẩm truy cập
> được hay công cụ thao tác. **Mức bằng chứng của mọi finding: phân tích tài liệu.** Không finding nào được xếp
> **Defect**; mọi nhận định về hành vi thực tế đều là `[CX GIẢ THUYẾT]` / "rủi ro giả định".

Viết tắt: `G036:nn` = `tailieu/G036 - Giao diện khung hội thoại.md` dòng nn; `G003`, `G009`, `G014`, `G015`, `G026`
tương tự. `Q-nn` = câu hỏi trong `02-alignment-summary.md` §3. Cách hiểu đã xác nhận #1–#4 = `02-…` §4.

## 1. Phạm vi và nguồn đã xem

| # | Nguồn (tài liệu / design / prototype / sản phẩm) | Phạm vi | Cách xem |
| ---: | --- | --- | --- |
| 1 | `tailieu/G036 - Giao diện khung hội thoại.md` (v1.0, Draft, 2026-10-09) | Toàn bộ 384 dòng: §1–§16, sơ đồ ASCII §10A, bảng §10B–§10E, AC, OOS | Đọc tài liệu |
| 2 | `wiki/qa/features/G036/01-requirement-analysis.md` | §2–§6, §9, §11, §12 | Đọc tài liệu |
| 3 | `wiki/qa/features/G036/02-alignment-summary.md` | §3 (bảng Q), §4 (cách hiểu đã xác nhận) | Đọc tài liệu |
| 4 | `G003 - Chat.md` | §7 trạng thái tin (`G003:333-341`), bảng hiển thị §10D (`G003:456-483`) | Đọc các dòng đã trích trong `01-…` |
| 5 | `G009 - Tính năng bổ sung Chat.md` | React / reply (`G009:65-69`, `G009:98`, `G009:289`, `G009:301-304`) | Đọc các dòng đã trích |
| 6 | `G014 - Ghim tin nhắn (2).md` | §10A–§10B (`G014:494-523`) | Đọc các dòng đã trích |
| 7 | `G015 - Hiển thị Thumbnail khi gửi kèm Link.md` | BR03 (`G015:144`) | Đọc dòng đã trích |
| 8 | `G026 - Cài đặt nhóm (1).md` | BR01–BR03 (`G026:128-130`) | Đọc các dòng đã trích |

**Giới hạn:**

- Không có UI design, prototype, sản phẩm hay công cụ thao tác → **không chạy Mode 2**; không có screenshot / log;
  thư mục `evidence/` không được tạo.
- Mọi nhận định về màu sắc, độ tương phản, kích thước chạm, cảm giác khi dùng là suy luận từ câu chữ và sơ đồ ASCII,
  **chưa quan sát thực tế**.
- Không có dữ liệu người dùng thật (số nhân sự, tần suất, thiết bị) → persona chỉ dựa vào câu chữ của nguồn hoặc
  ghi rõ là giả thuyết.
- Các điểm không trọng yếu còn mở (Q-03 → Q-11, Q-14, Q-16) **không tự chọn cách hiểu**; finding liên quan ghi
  "phụ thuộc Q-nn".
- Chưa đọc G008, G023, G025 và phần còn lại của G003 / G009 / G014 / G015 / G026.

## 2. Persona

| Persona | Nhóm khách hàng · bối cảnh | Mục tiêu | Căn cứ |
| --- | --- | --- | --- |
| P1 | **Nhân sự CSKH dùng chung một tài khoản Zalo với đồng nghiệp**; cả ngày ở trong các hội thoại nhóm / 1-1 với khách, nhiều người cùng trả lời một khách | Biết nhanh **ai** (khách nào, đồng nghiệp nào, hay chủ tài khoản gửi từ điện thoại) nói **gì** lúc **nào**, trả lời đúng tin, biết tin mình đã đi chưa | `G036:39` "Một tài khoản có **nhiều nhân viên**"; BR01 `G036:134` "hai nhân viên dùng chung một tài khoản Zalo vẫn là hai cụm"; BR07 `G036:140`; Q-02 / Q-13 |
| P2 | **Nhân sự quen Zalo PC** — đã dùng Zalo PC hằng ngày, mang kỳ vọng về cụm, mốc, thu hồi, video sang hệ thống | Đọc khung chat theo thói quen Zalo, không phải "đọc lại theo một cách khác" | `G036:21` "Nhân sự quen Zalo phải đọc lại theo một cách khác"; `G036:35-40` hai chỗ cố ý khác Zalo |
| P3 | **Admin / trưởng nhóm** — tài khoản Zalo đang dùng là trưởng hoặc phó nhóm, hoặc nhân sự cần nhận ra tin của trưởng / phó nhóm khách | Nhận ra tin của trưởng / phó nhóm; biết tin mình gửi được làm nổi | BR10 `G036:143`; §10C `G036:217-219`; cách hiểu đã xác nhận #1 |
| P4 | **Nhân sự dùng khung chat hẹp (≈390px) hoặc màn cảm ứng** (vd cửa sổ chia đôi, máy tính bảng) — **persona giả thuyết phục vụ review**: phạm vi 390px và màn cảm ứng có trong nguồn (`G036:32`, AF06 `G036:113`, BR28 `G036:161`) nhưng nguồn không nói ai dùng, dùng khi nào | Thao tác được trên tin, đọc được không tràn | Phạm vi: `G036:32`, `G036:113`, `G036:161`; người dùng: giả thuyết |
| P5 | **Nhân sự dùng giao diện tiếng Anh** — **persona giả thuyết phục vụ review**: nguồn chỉ nói hệ thống có tiếng Anh (`G036:33`, BR05, BR28) | Mọi nhãn, mốc, nút đọc được bằng tiếng Anh, không trộn tiếng Việt / mã | Phạm vi: `G036:33`, `G036:138`, `G036:161`; người dùng: giả thuyết |
| P6 | **Nhân sự mới, chưa quen Zalo PC** — **persona giả thuyết phục vụ review**: nguồn không nhắc nhóm này | Hiểu các dấu hiệu (chìa khoá, viền, `+N ghim`, `T3`, `CN`) mà không cần được giải thích | Giả thuyết |

## 3. Hành trình đã review

Mode 3 ở mức phân tích tài liệu: cột "phản hồi hệ thống" lấy từ nguồn; chỗ nguồn im lặng ghi `[CX GIẢ THUYẾT]`.

| Hành trình | Persona | Mục tiêu → các bước → phản hồi hệ thống → kết quả cuối → cách phục hồi | Nguồn |
| --- | --- | --- | --- |
| J1 — Mở hội thoại nhóm đông tin | P1, P2 | **Mục tiêu:** vào nhóm khách đang hoạt động, thấy tin mới nhất. **Bước:** bấm hội thoại trong danh sách. **Phản hồi:** đã mở trong ~5 phút → hiện ngay, tải ngầm; lần đầu → tải từ lúc nhấn chuột xuống; mở ở tin mới nhất; dựng cụm / mốc / tên / avatar / giờ; gửi *đã đọc* sau khi tải xong. **Kết quả:** thấy tin mới nhất, không bị đẩy lệch. **Phục hồi:** mất kết nối / không quyền → theo G003 (ngoài G036). `[CX GIẢ THUYẾT]` lần mở đầu có vòng quay chờ hay không, nguồn không nói. | UC-01 `G036:71-77`; BR26–27 `G036:159-160`; `G036:126` |
| J2 — Đọc hiểu ai nói gì lúc nào | P1, P3, P6 | **Mục tiêu:** trong vài giây biết tin nào của khách nào, đồng nghiệp nào, chủ tài khoản gửi từ điện thoại, trưởng / phó nhóm, lúc nào. **Bước:** nhìn cụm, avatar, tên đầu cụm (khách) / tên + giờ cuối cụm (mình), mốc thời gian, chìa khoá. **Phản hồi:** theo BR01–BR10, §10A–§10C, Q-02 / Q-13. **Kết quả:** `[CX GIẢ THUYẾT]` đọc được với cụm ngắn; cụm dài, nhiều nhân viên chung tài khoản, nhiều tin hệ thống xen kẽ thì phải dò (CX-01 → CX-05). **Phục hồi:** cuộn tới cuối cụm để thấy tên; không có cách khác được ghi trong nguồn. | BR01–BR10 `G036:134-143`; §10A `G036:181-199`; §10B `G036:203-211` |
| J3 — Trả lời một tin cũ | P1 | **Mục tiêu:** trả lời đúng tin khách hỏi cách đây hơn một màn hình. **Bước:** cuộn lên (tải thêm khi còn ~3 màn hình, tin đang xem đứng yên) → rê chuột lên tin → bấm **Trả lời** → soạn, gửi. **Phản hồi:** tin trả lời có trích dẫn trong khung, vạch xanh trái, tên người được trích; bấm trích dẫn nhảy tới tin gốc, tô sáng vài giây. **Kết quả:** tin trả lời ở đáy, một ô trạng thái `Đang gửi → Đã gửi`. **Phục hồi:** bấm trích dẫn để quay lại tin gốc. `[CX GIẢ THUYẾT]` trong lúc cuộn lên, tin khách mới tới chỉ "giữ chỗ", nguồn không nói có tín hiệu báo (CX-14). | UC-02 `G036:79-83`; UC-03 `G036:85-89`; BR13 `G036:146`; BR21 `G036:154`; BR24 `G036:157`; AF02, AF04 `G036:109-111` |
| J4 — Gửi lỗi và thử lại | P1 | **Mục tiêu:** chắc chắn tin đã tới khách. **Bước:** gửi tin → (G003: sau 3 phút không xác nhận → Lỗi gửi) → tin có viền đỏ + "Thử lại" → bấm "Thử lại". **Phản hồi:** G003: quay lại Đang gửi. **Kết quả:** `[CX GIẢ THUYẾT]` nếu tin lỗi không còn là tin cuối hội thoại thì không có ô trạng thái cho nó (BR24 chỉ một ô dưới tin cuối) → không biết lần thử lại có đi không cho tới khi lại viền đỏ hoặc hết viền đỏ (CX-10, CX-11). **Phục hồi:** bấm "Thử lại" lần nữa; nguồn không nói giới hạn. | E01 `G036:121`; BR24 `G036:157`; `G003:333-339` |
| J5 — Chuyển hội thoại khác rồi quay lại | P1 | **Mục tiêu:** xử lý khách khác rồi quay lại không mất chỗ, không chờ. **Bước:** bấm hội thoại B → xử lý → bấm lại hội thoại A trong ~5 phút. **Phản hồi:** A hiện ngay, không vòng quay; tin mới / thu hồi / cảm xúc tới trong lúc rời đi được bổ sung sau; *đã đọc* gửi sau khi tải xong. **Kết quả:** A ở tin mới nhất (BR26). **Phục hồi:** N/A. `[CX GIẢ THUYẾT]` nội dung đang đọc có thể đổi (tin bị thu hồi, tin mới chèn) sau khi màn đã hiện mà không có tín hiệu (CX-15). | BR27 `G036:160`; UC-01 b2 `G036:74`; §15 `G036:350-352` |

## 4. Tổng hợp finding

| ID | Loại | Tóm tắt | Persona | Impact | Mức bằng chứng | Trace (BR / UC / case) |
| --- | --- | --- | --- | --- | --- | --- |
| CX-01 | Usability Issue | Giờ gửi chỉ ở tin cuối cụm → tin giữa cụm không có giờ, nguồn không nêu cách xem giờ từng tin | P1 | Trung bình | Phân tích tài liệu | BR09, BR01 · case: chưa có `04-testcases.md` |
| CX-02 | CX Risk (rủi ro giả định) | Tên nhân viên chỉ ở tin cuối cụm, avatar chỉ ở tin đầu cụm → giữa cụm dài không biết đồng nghiệp nào đang nói | P1 | Trung bình | Phân tích tài liệu | BR07, BR08, AC-BR07 |
| CX-03 | CX Risk (rủi ro giả định) | Ranh giới hai cụm phía mình chỉ khác 4px; cụm gửi từ điện thoại hiện "tên Zalo + giờ" cùng kiểu với "tên nhân viên + giờ" → dễ nhầm là một nhân viên | P1 | Cao | Phân tích tài liệu | BR01, BR02, BR07, BR11; Q-02, Q-13 (đã xác nhận) |
| CX-04 | CX Risk (rủi ro giả định) | Nhóm nhiều tin hệ thống xen kẽ → mốc "giờ + ngày" lặp liên tiếp gây nhiễu; "nhóm tin hệ thống đang thu gọn" được nhắc nhưng không mô tả | P1, P3 | Trung bình | Phân tích tài liệu | BR03 ❹, BR01 ❹, BR19, AF04 |
| CX-05 | CX Risk (rủi ro giả định) | Dấu hiệu trưởng / phó: chìa khoá chỉ ở avatar tin đầu cụm; viền xanh nhạt trên khung xanh nhạt phía mình; vàng / xám chỉ khác màu | P3, P6 | Trung bình | Phân tích tài liệu | BR10, BR08, BR11, §10C |
| CX-06 | Usability Issue | Tooltip "Trưởng nhóm" / "Phó nhóm" chỉ khi rê chuột; màn cảm ứng không rê chuột được, AF06 chỉ nói về nút | P4, P6 | Thấp | Phân tích tài liệu | BR10, AF06, BR28 |
| CX-07 | CX Risk (rủi ro giả định) | Video hiện như ảnh (đúng tỉ lệ, khung chờ) nhưng bấm vào vẫn là tải về theo G003 (diễn giải AI, Q-15); nguồn không nêu dấu hiệu phân biệt video / ảnh | P2 | Trung bình | Phân tích tài liệu | BR14, E03; Q-15; `G003:468` |
| CX-08 | CX Risk (rủi ro giả định) | Tin thu hồi / đã xoá giữ nội dung, khác tin thường chỉ ở "không 👍, không trạng thái gửi"; nếu không có nhãn (Q-03 mở) nhân sự có thể xử lý theo nội dung khách đã rút | P1, P2 | Cao | Phân tích tài liệu | BR20, OOS05; Q-03 (mở); `G003:459`; `G014:517` |
| CX-09 | CX Risk (rủi ro giả định) | 👍 luôn hiện ở tin cuối của khách, bấm một lần = thả "Thích" lên Zalo; lỡ tay khi khách đang khiếu nại; cách gỡ nằm trong bảng cần rê 0,4s | P1 | Cao | Phân tích tài liệu | BR22, AC-BR22; `G009:66` (gỡ react) |
| CX-10 | CX Risk (rủi ro giả định) | Một ô trạng thái dưới tin cuối hội thoại: đồng nghiệp hoặc khách nhắn sau → trạng thái tin mình biến mất; trong 3 phút trước khi báo lỗi không có dấu hiệu; "Đã xem" chưa có BE nên chỉ còn "Người đã xem…" trong menu "…" | P1 | Cao | Phân tích tài liệu | BR24, BR21; Q-04, Q-09 (mở); `G003:333-336`; `G036:365` |
| CX-11 | Usability Issue | Sau khi bấm "Thử lại" trên tin ở giữa hội thoại, không có ô trạng thái cho tin đó; nguồn không nói tin giữ vị trí hay xuống cuối | P1 | Trung bình | Phân tích tài liệu | E01, BR24; Q-16 (mở); `G003:339` |
| CX-12 | Usability Issue | Trích dẫn và thanh ghim hiện **tên tài khoản** cho tin phía mình → nhân sự chung tài khoản không biết đang trích / ghim tin của đồng nghiệp nào; trích video dùng nhãn `[Hình ảnh]` | P1 | Trung bình | Phân tích tài liệu | BR13, BR25 §10E; G009 BR05 |
| CX-13 | Usability Issue | Bảng danh sách ghim đóng bằng "Thu gọn" (từ gợi thu nhỏ, không phải đóng); không nêu phím Esc; bấm ghim trỏ tới tin thu hồi → nhảy tới tin "giữ nội dung" | P1, P6 | Thấp | Phân tích tài liệu | BR25 §10E; `G014:517`, `G014:521` |
| CX-14 | CX Risk (rủi ro giả định) | Đang đọc tin cũ, tin khách mới tới chỉ "giữ chỗ"; nguồn không nói có tín hiệu báo tin mới → CSKH có thể bỏ lỡ | P1 | Cao | Phân tích tài liệu | AF02, BR26 |
| CX-15 | CX Risk (rủi ro giả định) | Quay lại hội thoại trong ~5 phút: hiện ngay rồi bổ sung ngầm tin mới / thu hồi / cảm xúc → nội dung đang đọc đổi không có tín hiệu | P1 | Thấp | Phân tích tài liệu | BR27, AC-BR27 |
| CX-16 | CX Risk (rủi ro giả định) | Màn hẹp 390px + màn cảm ứng: 3 nút + 👍 luôn hiện trên mọi tin, kể cả hàng 3 sticker; bảng cảm xúc / menu "…" "tại vị trí nút" trong khung hẹp | P4 | Trung bình | Phân tích tài liệu | BR28, AF06, BR21, BR22, BR15 §10D |
| CX-17 | Usability Issue | Tiếng Anh: chỉ `Today` · `Yesterday` · `Sun/Mon/…` có nguồn; các nhãn khác và định dạng ngày / thứ tự "giờ + Today" không được liệt kê → nguy cơ trộn ngôn ngữ như hiện trạng cũ | P5 | Trung bình | Phân tích tài liệu | BR05, BR28, AC-BR28; Q-07 (mở) |

Số lượng theo loại: **Defect 0 · Usability Issue 6 · CX Risk 11 · Improvement Suggestion 0** (đề xuất cải thiện
tách sang §6 với mã `IS-nn`). Tổng 17 finding.

## 5. Chi tiết finding

### CX-01 — Giờ gửi chỉ ở tin cuối cụm; tin giữa cụm không có giờ

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-01 |
| Review scope | Đọc tin theo cụm — giờ gửi (J2) |
| Source evidence | `G036:142` BR09 "Giờ gửi: chỉ ở **tin cuối cụm**"; `G036:134` BR01 ❸ "tin sau cách tin trước **không quá 30 phút**" (điều kiện giữa hai tin liền nhau, không phải tổng chiều dài cụm); §10A `G036:186-189` tin 1 không giờ, tin 2 có `09:05`. Không dòng nào trong G036 nói cách xem giờ của tin giữa cụm (tooltip, rê chuột…) |
| Persona và context | P1 — CSKH cần biết chính xác khách hỏi lúc mấy giờ (tính thời gian phản hồi, đối chiếu khi khách khiếu nại) |
| Customer journey / scenario | J2: nhìn một tin ở giữa cụm, muốn biết giờ gửi của chính tin đó |
| Observation | `[NGUỒN]` Theo BR01 ❸, một cụm có thể gồm nhiều tin mỗi tin cách nhau < 30 phút → cụm có thể kéo dài hàng giờ mà chỉ có **một** giờ ở tin cuối. `[CX GIẢ THUYẾT]` Người đọc tin giữa cụm chỉ suy ra được giờ "trước giờ ở tin cuối" và "sau mốc gần nhất", không có giờ chính xác; nguồn không cho cách xem. Đây là hành vi cố ý (giống Zalo PC) nên không phải lệch requirement |
| Finding type | Usability Issue |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — đúng requirement (BR09); không có requirement về cách xem giờ từng tin làm căn cứ cho vế "expected" khác |
| Impact | Nhân sự phải ước lượng giờ khi đối chiếu, hoặc chịu không biết; ảnh hưởng khi cần dẫn chứng thời điểm với khách |
| Evidence và confidence / limitations | Chỉ từ câu chữ BR01 / BR09; chưa biết build có tooltip giờ không — nếu có thì finding giảm còn "nguồn chưa ghi" |
| Recommendation | Gợi ý IS-01 (tooltip giờ khi rê chuột lên tin bất kỳ). Hỏi Debate: build có cách xem giờ từng tin không (nếu có cần ghi vào G036 vì G036 là "nơi duy nhất quy định hiển thị") |
| Traceability | BR01, BR09, AC-BR09 (`G036:260`) · case: `Unlinked` — chưa có `04-testcases.md` |
| Open questions / quyết định cần Product · BA · UX | Debate D-01 (§7) |

### CX-02 — Tên nhân viên chỉ ở tin cuối cụm, avatar chỉ ở tin đầu cụm

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-02 |
| Review scope | Đọc tin theo cụm — tên, avatar phía mình (J2) |
| Source evidence | `G036:140` BR07 "không hiện tên phía trên tin. Tên **nhân viên** đi kèm **giờ gửi** ở **tin cuối cụm**"; `G036:141` BR08 "Ảnh đại diện: 40px, chỉ ở tin đầu cụm"; `G036:39` "Một tài khoản có **nhiều nhân viên** → tên nhân viên đi kèm giờ gửi ở tin cuối cụm" (cố ý khác Zalo); §10A `G036:192-194` |
| Persona và context | P1 — ba, bốn nhân viên cùng trả lời một khách trong ngày; cần biết câu nào đồng nghiệp đã hứa với khách |
| Customer journey / scenario | J2: đọc một cụm dài phía mình (vd 10 tin, mỗi tin cách < 30 phút) |
| Observation | `[NGUỒN]` Dấu hiệu nhận diện nhân viên nằm ở hai đầu cụm: avatar nhân viên ở tin đầu, tên ở tin cuối. `[CX GIẢ THUYẾT]` Khi cụm dài hơn một màn hình, tin đang đọc ở giữa không có cả avatar lẫn tên → phải cuộn tới một trong hai đầu. Nếu nhân viên không đặt avatar hoặc avatar giống nhau (nguồn không quy định avatar nhân viên bắt buộc khác nhau) thì chỉ còn tên ở cuối cụm. Tài liệu đã chủ động chọn "tên kèm giờ ở tin cuối" để khác Zalo — vấn đề là **vị trí** chứ không phải sự tồn tại của tên |
| Finding type | CX Risk — rủi ro giả định |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — đúng requirement (BR07, BR08); không có requirement khác làm căn cứ |
| Impact | Nhầm lời hứa của đồng nghiệp là của mình (hoặc ngược lại); mất thời gian cuộn tìm tên |
| Evidence và confidence / limitations | Suy luận từ câu chữ; chưa biết avatar nhân viên thực tế có phân biệt được không; chưa đo chiều dài cụm điển hình |
| Recommendation | Gợi ý IS-01 (tooltip tên + giờ trên tin bất kỳ) — để Product / UX quyết; không thay đổi BR07 |
| Traceability | BR07, BR08, AC-BR07 (`G036:258`), AC-BR08 (`G036:259`) · case: `Unlinked` — chưa có `04-testcases.md` |
| Open questions / quyết định cần Product · BA · UX | Gộp vào D-01 (§7) |

### CX-03 — Ranh giới cụm phía mình mỏng; cụm gửi từ điện thoại dễ bị đọc nhầm là một nhân viên

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-03 |
| Review scope | Đọc tin theo cụm — chuyển người gửi phía mình; tin gửi từ điện thoại (J2) |
| Source evidence | `G036:134` BR01 "hai nhân viên dùng chung một tài khoản Zalo vẫn là hai cụm"; `G036:135` BR02 "trong cụm **4px** · giữa hai cụm **8px**"; `G036:144` BR11 khung phía mình "xanh nhạt" (một màu cho mọi nhân viên); cách hiểu đã xác nhận #2, #3 (Q-02, Q-13): tin gửi từ điện thoại là cụm riêng, tin cuối cụm hiện **tên Zalo + giờ**, avatar = avatar tài khoản Zalo; `G036:140` BR07 ví dụ `Nguyễn Thu Hồng 21:22` |
| Persona và context | P1 — nhiều nhân viên + chủ tài khoản thỉnh thoảng trả lời khách từ điện thoại |
| Customer journey / scenario | J2: hai cụm phía mình liền nhau (nhân viên A rồi nhân viên B, hoặc nhân viên rồi điện thoại) |
| Observation | `[NGUỒN]` Hai cụm phía mình cùng phía phải, cùng màu khung, khác nhau ở: khoảng cách 8px thay vì 4px, avatar mới ở tin đầu cụm sau, tên + giờ ở tin cuối cụm trước. `[CX GIẢ THUYẾT]` (i) Chênh lệch 4px là tín hiệu rất nhỏ để nhận ra "đổi người"; avatar 40px là tín hiệu chính nhưng chỉ có tại tin đầu cụm. (ii) Cụm gửi từ điện thoại hiện "tên Zalo + giờ" **cùng vị trí và cùng kiểu** với "tên nhân viên + giờ"; không có dấu hiệu nào trong nguồn nói đó là tin từ điện thoại → nhân sự mới (P6) có thể hiểu "tên Zalo" là một đồng nghiệp tên như vậy; nhân sự cũ phải nhớ tên tài khoản Zalo để suy ra |
| Finding type | CX Risk — rủi ro giả định |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — đúng cách hiểu đã xác nhận (Q-02, Q-13); không có requirement về dấu hiệu "từ điện thoại" |
| Impact | Nhầm người chịu trách nhiệm câu trả lời; không biết chủ tài khoản đã can thiệp trực tiếp |
| Evidence và confidence / limitations | Chưa thấy thiết kế; nếu avatar tài khoản Zalo khác rõ avatar nhân viên thì rủi ro (ii) giảm. 8px vs 4px chưa đo trên màn thật |
| Recommendation | IS-02 (dấu hiệu nhỏ cho cụm gửi từ điện thoại, vd biểu tượng điện thoại cạnh tên). Chuyển QA: viết case đọc được ranh giới cụm khi hai nhân viên chung tài khoản gửi liền nhau — "ĐO & GHI" |
| Traceability | BR01, BR02, BR07, BR08, BR11; AC-BR01 (`G036:247`); Q-02, Q-13 · case: `Unlinked` — chưa có `04-testcases.md` |
| Open questions / quyết định cần Product · BA · UX | Product / UX: có muốn dấu hiệu "gửi từ điện thoại" không (IS-02) |

### CX-04 — Nhiều tin hệ thống xen kẽ → mốc "giờ + ngày" lặp; "thu gọn tin hệ thống" chưa được mô tả

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-04 |
| Review scope | Mốc thời gian 7 dạng; tin hệ thống (J1, J2) |
| Source evidence | `G036:136` BR03 ❹ "tin thường ngay sau một tin đứng riêng — mốc ghi giờ + ngày"; `G036:134` BR01 ❹ "tin hệ thống và bình chọn luôn tách cụm riêng"; `G036:135` BR02 "trước và sau tin đứng riêng **16px**"; `G036:152` BR19 "kể cả khi nó nằm trong **nhóm tin hệ thống đang thu gọn**"; `G036:111` AF04 cùng ý. Không BR nào trong G036 định nghĩa khi nào tin hệ thống được thu gọn, trông thế nào, mở ra bằng gì |
| Persona và context | P1, P3 — nhóm khách đông người, thành viên vào / ra, đổi tên nhóm, ghim thường xuyên |
| Customer journey / scenario | J1 / J2: mở nhóm có nhiều tin hệ thống xen giữa tin thường trong cùng một giờ |
| Observation | `[NGUỒN]` Mỗi tin thường ngay sau tin hệ thống bắt buộc có mốc "giờ + ngày" (vd `09:05 Hôm nay`), cộng 16px trước và sau tin hệ thống. `[CX GIẢ THUYẾT]` Khi tin hệ thống xen kẽ dày (5 thành viên vào nhóm trong 10 phút, mỗi người một tin hệ thống, giữa chúng là tin chào của nhân sự) → chuỗi mốc `09:05 Hôm nay`, `09:07 Hôm nay`, `09:08 Hôm nay`… liên tiếp, mỗi mốc kèm khoảng trống → khung chat loãng, mốc mất ý nghĩa "đánh dấu khoảng nghỉ". Cơ chế "thu gọn" có thể là lời giải nhưng G036 không mô tả → không đánh giá được |
| Finding type | CX Risk — rủi ro giả định |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — đúng requirement (BR03 ❹); không có requirement về mật độ mốc |
| Impact | Khó quét nhanh; mốc thời gian không còn là tín hiệu hữu ích |
| Evidence và confidence / limitations | Suy luận từ quy tắc; tần suất tin hệ thống thực tế chưa có số liệu |
| Recommendation | Debate D-02: "nhóm tin hệ thống đang thu gọn" quy định ở đâu (G003? G008?) và có ảnh hưởng tới BR03 ❹ không. QA: case nhiều tin hệ thống liên tiếp trong < 30 phút, đếm số mốc — "ĐO & GHI" |
| Traceability | BR01 ❹, BR02, BR03 ❹, BR19, AF04; AC-BR01 (`G036:248`), AC-BR03 (`G036:250`), AC-BR19 (`G036:277`) · case: `Unlinked` |
| Open questions / quyết định cần Product · BA · UX | Debate D-02 (§7) |

### CX-05 — Dấu hiệu trưởng / phó nhóm nhỏ, phụ thuộc màu, chỉ có ở tin đầu cụm

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-05 |
| Review scope | Dấu hiệu trưởng / phó nhóm (J2) |
| Source evidence | `G036:143` BR10 "chìa khoá nhỏ ở góc ảnh đại diện — **vàng = trưởng nhóm**, **xám = phó nhóm**… Tin của trưởng/phó có **viền xanh nhạt**… tin mình gửi cũng có viền xanh"; `G036:141` BR08 avatar "chỉ ở tin đầu cụm"; `G036:144` BR11 "phía mình **xanh nhạt**… không viền"; §10C `G036:217-218`; cách hiểu đã xác nhận #1 |
| Persona và context | P3 — tài khoản đang dùng là trưởng / phó nhóm; P6 — nhân sự mới không biết "chìa khoá" nghĩa gì |
| Customer journey / scenario | J2: nhận ra tin của trưởng nhóm khách trong một cụm dài; nhận ra tin mình được làm nổi |
| Observation | `[NGUỒN]` Chìa khoá gắn vào avatar → chỉ có ở tin đầu cụm; các tin còn lại của cụm chỉ còn viền xanh nhạt. Khung tin phía mình nền xanh nhạt, bình thường "không viền". `[CX GIẢ THUYẾT]` (i) Viền xanh nhạt trên nền xanh nhạt có nguy cơ tương phản thấp, nhất là với tin mình gửi khi tài khoản là trưởng / phó (AC `G036:266`). (ii) Vàng / xám là phân biệt **chỉ bằng màu** trên biểu tượng "nhỏ" ở góc avatar 40px — người mù màu hoặc màn hình kém khó phân biệt trưởng với phó. (iii) Không có chữ "Trưởng nhóm" bên cạnh tên (G026 BR03 cũ có nhãn chữ, `G026:130`) → P6 phải rê chuột mới biết nghĩa |
| Finding type | CX Risk — rủi ro giả định |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — đúng requirement đã xác nhận (Q-01); màu cụ thể chưa có design |
| Impact | Không nhận ra người có thẩm quyền trong nhóm khách; tính năng "làm nổi" không đạt mục đích |
| Evidence và confidence / limitations | Chưa có mã màu, chưa đo tương phản; chỉ từ chữ "xanh nhạt" dùng cho cả nền (BR11) và viền (BR10) |
| Recommendation | QA: "ĐO & GHI" độ tương phản viền / nền trên build; IS-03 (cân nhắc kèm dấu hiệu không phụ thuộc màu, vd hình chìa khoá khác nhau hoặc chữ) |
| Traceability | BR08, BR10, BR11; AC-BR10 (`G036:263-266`) · case: `Unlinked` |
| Open questions / quyết định cần Product · BA · UX | UX: mã màu viền; có dấu hiệu phụ ngoài màu không |

### CX-06 — Tooltip vai trò không có trên màn cảm ứng

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-06 |
| Review scope | Dấu hiệu trưởng / phó nhóm trên màn cảm ứng (J2) |
| Source evidence | `G036:143` BR10 "rê chuột hiện *"Trưởng nhóm"* / *"Phó nhóm"*"; `G036:113` AF06 "các **nút** vốn chỉ hiện khi rê chuột thì **luôn hiện**"; `G036:161` BR28 cùng ý — chỉ nói về **nút**, không nói tooltip |
| Persona và context | P4 (giả thuyết) dùng màn cảm ứng; P6 (giả thuyết) chưa biết nghĩa chìa khoá |
| Customer journey / scenario | J2 trên máy tính bảng: thấy chìa khoá xám, muốn biết nghĩa |
| Observation | `[NGUỒN]` Nghĩa của chìa khoá chỉ được cung cấp qua tooltip khi rê chuột. AF06 chỉ phủ nút thao tác. `[CX GIẢ THUYẾT]` Trên màn cảm ứng không có thao tác rê → không có cách đọc chữ "Trưởng nhóm" / "Phó nhóm" trong khung chat; người dùng phải biết trước quy ước vàng / xám |
| Finding type | Usability Issue |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — không có requirement về tooltip trên màn cảm ứng làm căn cứ |
| Impact | Thấp — P6 trên màn cảm ứng không hiểu dấu hiệu; P3 có thể đoán được |
| Evidence và confidence / limitations | Chưa biết build có xử lý chạm-giữ hiện tooltip không |
| Recommendation | Debate D-03: AF06 có áp dụng cho tooltip không. IS-03 |
| Traceability | BR10, BR28, AF06; AC-BR28/AF06 (`G036:305`) · case: `Unlinked` |
| Open questions / quyết định cần Product · BA · UX | Debate D-03 (§7) |

### CX-07 — Video trông như ảnh nhưng bấm vào là tải về; chưa có dấu hiệu phân biệt

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-07 |
| Review scope | Ảnh / video trong khung (J2) |
| Source evidence | `G036:147` BR14 "Ảnh, video: giữ đúng tỉ lệ thật, rộng tối đa 360px… Đang tải → khung chờ"; `G036:142` BR09 "Ảnh, video, sticker: giờ là ô nhỏ dưới ảnh"; `G003:468` "Video: Hiển thị nút download; không view trực tiếp"; Q-15 (đã xác nhận): hiển thị video theo G036; **hành vi bấm vào video G036 không nói → theo G003 (tải về)** là `[DIỄN GIẢI AI]`, chưa BA xác nhận. G036 không nhắc biểu tượng play, thời lượng hay bất kỳ dấu hiệu nào phân biệt video với ảnh |
| Persona và context | P2 — quen Zalo PC, kỳ vọng bấm video là phát |
| Customer journey / scenario | J2: khách gửi video hướng dẫn lỗi; nhân sự bấm để xem |
| Observation | `[CX GIẢ THUYẾT]` Video và ảnh hiện cùng cách (đúng tỉ lệ, cùng khung chờ, cùng ô giờ). Nếu bấm video kích hoạt tải về (theo diễn giải Q-15) trong khi bấm ảnh mở xem trước (`G003:467`), hai thứ trông giống nhau nhưng phản hồi khác → bất ngờ, file tải về ngoài ý muốn. Không rõ người dùng phân biệt được trước khi bấm |
| Finding type | CX Risk — rủi ro giả định |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — hành vi bấm video chưa được xác nhận (diễn giải AI) |
| Impact | Tải file không mong muốn; nhân sự tưởng lỗi; mất thời gian khi xử lý khiếu nại có video |
| Evidence và confidence / limitations | Phụ thuộc Q-15 phần "bấm video" (chưa xác nhận); chưa thấy thiết kế thẻ video |
| Recommendation | Debate D-04: xác nhận hành vi bấm video và dấu hiệu phân biệt video / ảnh (biểu tượng play / thời lượng) — nếu có phải ghi vào G036. IS-04 |
| Traceability | BR09, BR14, E03; AC-BR14 (`G036:272`); Q-15 · case: `Unlinked` |
| Open questions / quyết định cần Product · BA · UX | Debate D-04 (§7) |

### CX-08 — Tin thu hồi giữ nguyên nội dung; nếu không có nhãn, nhân sự không biết tin đã bị rút

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-08 |
| Review scope | Tin thu hồi / đã xoá; thanh ghim và trích dẫn trỏ tới tin thu hồi (J2, J3) |
| Source evidence | `G036:153` BR20 "Tin đã thu hồi / đã xoá: **giữ nội dung** *(khác Zalo)*. **Không** có nút 👍, **không** có trạng thái gửi"; `G036:40`, `G036:318` OOS05 "Giữ nội dung theo quyết định sản phẩm"; `G003:459` "Style disable + label "Đã thu hồi" / "Đã xóa"" — Q-03 **mở**: nhãn và style disable còn áp dụng không; `G014:517` tin ghim bị thu hồi vẫn trong danh sách; `G009:302` reply đã gửi tự đổi quote thành *"Tin nhắn đã thu hồi"* |
| Persona và context | P1 — xử lý yêu cầu của khách theo nội dung tin; P2 — quen Zalo, kỳ vọng tin thu hồi bị ẩn |
| Customer journey / scenario | J2: khách gửi địa chỉ giao hàng rồi thu hồi và gửi địa chỉ mới; nhân sự đọc hội thoại |
| Observation | `[NGUỒN]` G036 chỉ nêu hai khác biệt của tin thu hồi so với tin thường: không 👍, không trạng thái gửi. Tin của khách bình thường cũng không có trạng thái gửi (BR24 chỉ cho phía mình) → với tin khách thu hồi, khác biệt còn lại chỉ là **thiếu nút 👍 khi rê chuột**. `[CX GIẢ THUYẾT]` Nếu Q-03 chọn cách hiểu (b) — không còn nhãn — nhân sự đọc lướt không có cách nào nhận ra tin đã bị thu hồi, có thể xử lý theo nội dung khách đã rút (giao sai địa chỉ, nhắc lại thông tin khách muốn xoá) → khách mất niềm tin. Với P2, việc tin thu hồi vẫn hiện nguyên trái ngược hoàn toàn thói quen Zalo. Thanh ghim / trích dẫn trỏ tới tin thu hồi vẫn nhảy tới được, làm rủi ro lan sang ghim |
| Finding type | CX Risk — rủi ro giả định |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — "giữ nội dung" là quyết định sản phẩm (OOS05); nhãn phụ thuộc Q-03 chưa chốt |
| Impact | **Cao** — sai sót nghiệp vụ với khách; nguy cơ dùng thông tin khách đã rút lại |
| Evidence và confidence / limitations | Phụ thuộc Q-03; nếu nhãn "Đã thu hồi" + style disable của G003 vẫn áp dụng thì rủi ro giảm nhiều. Chưa thấy build |
| Recommendation | **Quay lại Debate** — bổ sung lý do CX cho Q-03 và đề nghị ưu tiên trả lời. QA: case tin khách thu hồi có nhận diện được không rê chuột; case nút Trả lời / Chuyển tiếp ẩn theo `G009:232` BR04, `G003:315` BR19 (diễn giải AI #1 trong `01-…` §8) |
| Traceability | BR20, OOS05; AC-BR20 (`G036:278`); Q-03; G003 BR07, G009 BR04, G014 BR07 · case: `Unlinked` |
| Open questions / quyết định cần Product · BA · UX | Q-03 (BA); Product: dấu hiệu tối thiểu để nhận ra tin thu hồi |

### CX-09 — Nút 👍 luôn hiện ở tin cuối của khách; một lần bấm là thả "Thích" lên Zalo

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-09 |
| Review scope | Thao tác khi rê chuột và nút 👍 (J3) |
| Source evidence | `G036:155` BR22 "**luôn hiện ở tin cuối cùng của khách**. **Bấm một lần = thả "Thích"**. Rê chuột lên nút khoảng **0,4 giây** = mở bảng chọn cảm xúc; rời chuột khỏi nút mà không đi vào bảng thì bảng **tự đóng**"; `G036:88` UC-03; `G009:66` bảng chọn có "**icon gạch chéo** ở cuối để **gỡ react của mình**"; `G009:68` "Gửi react lên Zalo" |
| Persona và context | P1 — CSKH đang xử lý khiếu nại; con trỏ di chuyển quanh tin cuối của khách để bấm Trả lời / "…" |
| Customer journey / scenario | J3: rê chuột lên tin cuối của khách để bấm "Trả lời"; bảng cảm xúc bật lên sau 0,4s khi con trỏ đi ngang 👍; hoặc bấm nhầm 👍 |
| Observation | `[NGUỒN]` 👍 nằm ở góc phải dưới khung tin, gần nhóm 3 nút khi rê chuột; thả "Thích" bằng một lần bấm, không xác nhận; react được gửi lên Zalo nên khách thấy. Cách gỡ nằm trong bảng chọn (phải rê 0,4s để mở). `[CX GIẢ THUYẾT]` (i) Lỡ "Thích" một tin khách đang bức xúc có thể bị khách hiểu là thái độ; (ii) bảng cảm xúc bật khi con trỏ dừng 0,4s trên đường tới nút khác gây giật; (iii) người dùng không biết gỡ bằng cách nào vì G036 không nhắc gỡ react |
| Finding type | CX Risk — rủi ro giả định |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — đúng requirement (BR22); việc gỡ react thuộc G009 |
| Impact | **Cao** về hình ảnh với khách dù xác suất mỗi lần thấp; xảy ra hàng ngày với số lượng hội thoại lớn |
| Evidence và confidence / limitations | Chưa đo vị trí / kích thước nút; "0,4 giây" chưa chốt là tiêu chí (Q-06); hành vi bấm 👍 lần hai (gỡ hay thêm) không có trong G036 |
| Recommendation | IS-05 (cách gỡ nhanh ngay trên tin, vd bấm lại 👍 đã thả = gỡ — cần Product). QA: case gỡ Thích qua gạch chéo G009 BR02 từ khung chat; case bảng cảm xúc tự đóng khi rời chuột; đánh dấu 0,4s "ĐO & GHI" |
| Traceability | BR22, BR23; AC-BR22 (`G036:283`); G009 BR02 · case: `Unlinked` |
| Open questions / quyết định cần Product · BA · UX | Debate D-05: bấm 👍 lần hai trên tin đã Thích thì gỡ hay không (G009 quy định?) |

### CX-10 — Một ô trạng thái gửi: thông tin "tin của tôi đã đi chưa / khách xem chưa" dễ mất

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-10 |
| Review scope | Ô trạng thái gửi (J3, J4) |
| Source evidence | `G036:157` BR24 "chỉ **một ô**, dưới **tin cuối cùng của hội thoại nếu tin đó là của phía mình**; khách nhắn sau đó thì ô biến mất. Các mức: `Đang gửi` → `Đã gửi` → `Đã nhận` → `Đã xem`"; `G036:365` "BE chỉ trả `Đã gửi` → tạm thời chỉ thấy `Đang gửi` và `Đã gửi`"; `G003:335` "Gửi thất bại sau 3 phút → Lỗi gửi"; `G003:474` (cũ) "Trạng thái đã xem: icon avatar của người đã đọc"; `G036:154` BR21 menu "…" có "Người đã xem…"; Q-04, Q-09 mở |
| Persona và context | P1 — nhiều nhân viên gửi liên tiếp; cần biết tin của **mình** đã tới khách chưa, khách đã xem chưa |
| Customer journey / scenario | J3 → J4: nhân viên A gửi tin; 20 giây sau nhân viên B gửi tin (cụm khác); tin của A chưa được xác nhận |
| Observation | `[NGUỒN]` Ô trạng thái chỉ mô tả tin cuối cùng của hội thoại; tin A không còn ô nào; theo G003 tin A chỉ chuyển "Lỗi gửi" (viền đỏ) sau 3 phút. `[CX GIẢ THUYẾT]` (i) Trong tối đa 3 phút, tin A không có dấu hiệu gì — A không biết tin mình đang gửi, đã gửi hay sắp lỗi; (ii) khi khách nhắn, ô biến mất → "Đã xem" không bao giờ hiện cho các tin trước đó; (iii) build hiện tại không có `Đã nhận` / `Đã xem` → thông tin "khách đã xem" rút từ vị trí luôn thấy (avatar người xem, build cũ `G003:474`) vào menu "…" → "Người đã xem…" — người dùng không biết menu này có mục đó nếu không mở |
| Finding type | CX Risk — rủi ro giả định |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — đúng requirement (BR24); vòng đời thuộc G003 |
| Impact | **Cao** với CSKH: gửi lại thừa, hoặc tưởng đã gửi mà chưa; không biết khách đã đọc để quyết định gọi điện |
| Evidence và confidence / limitations | Suy luận từ BR24 + G003 §7; chưa biết build có hiện "Đang gửi" tạm cho tin không phải tin cuối không (Q-09, Q-16 liên quan) |
| Recommendation | Debate: bổ sung lý do CX cho Q-04 / Q-09; QA: case "tin của A khi B gửi sau trong < 3 phút" — "ĐO & GHI"; IS-06 |
| Traceability | BR21, BR24; AC-BR24 (`G036:287`); Q-04, Q-09, Q-16; G003 §7 · case: `Unlinked` |
| Open questions / quyết định cần Product · BA · UX | Q-04, Q-09 (BA); Product: có cần dấu hiệu "đang gửi" cho tin không phải tin cuối không |

### CX-11 — Sau "Thử lại" trên tin ở giữa hội thoại, không có phản hồi "đang gửi lại"

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-11 |
| Review scope | Tin lỗi "Thử lại" (J4) |
| Source evidence | `G036:121` E01 "Viền đỏ + nút "Thử lại", ở bất kỳ vị trí nào"; `G036:157` BR24 một ô trạng thái dưới tin cuối; `G003:339` "Lỗi gửi → User click Retry → Đang gửi"; G036 không nói sau Thử lại tin giữ vị trí hay chuyển xuống cuối, viền đỏ tắt khi nào |
| Persona và context | P1 — tin lỗi nằm giữa hội thoại vì sau đó khách / đồng nghiệp đã nhắn tiếp |
| Customer journey / scenario | J4: bấm "Thử lại" trên tin lỗi ở giữa |
| Observation | `[NGUỒN]` Theo G003 tin quay về "Đang gửi"; theo BR24 ô trạng thái chỉ ở tin cuối → tin này không có ô. `[CX GIẢ THUYẾT]` Phản hồi duy nhất có thể có là viền đỏ + nút "Thử lại" biến mất; nếu chúng chỉ biến mất khi gửi thành công thì trong lúc gửi lại người dùng thấy y như chưa bấm → bấm lại nhiều lần; nếu chúng biến mất ngay khi bấm thì không có dấu hiệu nào cho tới khi lỗi tiếp (3 phút). Hai khả năng đều không có căn cứ trong nguồn |
| Finding type | Usability Issue |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — nguồn không quy định phản hồi sau "Thử lại" |
| Impact | Trung bình — gửi trùng tin hoặc bỏ cuộc |
| Evidence và confidence / limitations | Hoàn toàn từ khoảng trống của tài liệu; phụ thuộc Q-16 (tin tách phần) và Q-09 |
| Recommendation | **Quay lại Debate** D-06: sau "Thử lại", tin giữ vị trí hay xuống cuối; viền đỏ / nút tắt lúc nào; có ô "Đang gửi" tạm cho tin đó không. IS-06 |
| Traceability | E01, BR24; AC-BR24/E01 (`G036:288`); G003 §7 (`G003:339`); Q-09, Q-16 · case: `Unlinked` |
| Open questions / quyết định cần Product · BA · UX | Debate D-06 (§7) |

### CX-12 — Trích dẫn và thanh ghim hiện "tên tài khoản" thay vì tên nhân viên; trích video gắn nhãn `[Hình ảnh]`

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-12 |
| Review scope | Trích dẫn trong khung; thanh ghim (J3) |
| Source evidence | `G036:146` BR13 "Trích tin của chính tài khoản mình: hiện **tên tài khoản**"; "Trích ảnh/video: ảnh nhỏ 40px + `[Hình ảnh]`"; `G036:234` §10E "Ghim tin của chính tài khoản mình mà không có tên → hiện **tên tài khoản**"; `G036:39` nhiều nhân viên một tài khoản; `G009:301` quote preview "`[Hình ảnh]` / `[File]`" |
| Persona và context | P1 — trả lời tin đồng nghiệp đã gửi cho khách, hoặc đọc ghim do đồng nghiệp tạo |
| Customer journey / scenario | J3: bấm "Trả lời" vào tin của đồng nghiệp; nhìn thanh ghim |
| Observation | `[NGUỒN]` Trong trích dẫn và thanh ghim, tin phía mình gắn tên **tài khoản Zalo**, không phải tên nhân viên gửi (khác BR07 trong khung tin). `[CX GIẢ THUYẾT]` Nhân sự không biết đang trả lời / ghim câu của đồng nghiệp nào; bấm trích dẫn nhảy tới tin gốc rồi phải cuộn tới cuối cụm để thấy tên (CX-02). Riêng nhãn: trích **video** hiện `[Hình ảnh]`, trích **tệp** không được G036 nêu (G009 có `[File]`, §10E có `[Tập tin]`) → ba nhãn có thể không thống nhất giữa trích dẫn và thanh ghim |
| Finding type | Usability Issue |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — đúng requirement (BR13, §10E); nhãn tệp trong trích dẫn không có requirement ở G036 |
| Impact | Trung bình — chậm, nhầm người; nhãn lệch nhau gây khó hiểu nhẹ |
| Evidence và confidence / limitations | Hành vi "tên tài khoản" có thể do giới hạn dữ liệu Zalo (trích dẫn gửi lên Zalo — G009) — chưa xác minh; chỉ nêu tác động |
| Recommendation | Debate D-07: trích video nhãn gì, trích tệp nhãn gì (`[File]` hay `[Tập tin]`); chuyển QA kiểm thống nhất nhãn giữa BR13 và §10E. IS-07 |
| Traceability | BR13, BR25 §10E; AC-BR13 (`G036:271`), AC-BR25 (`G036:291`); G009 BR05 · case: `Unlinked` |
| Open questions / quyết định cần Product · BA · UX | Debate D-07 (§7) |

### CX-13 — Bảng danh sách ghim: nhãn "Thu gọn", không nêu Esc, ghim trỏ tới tin thu hồi

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-13 |
| Review scope | Thanh ghim và bảng danh sách ghim (J2) |
| Source evidence | `G036:236` §10E "Đóng bằng **"Thu gọn"** hoặc bấm ra ngoài"; `G036:239` bàn phím chỉ nêu Enter / Space; `G014:521` popup cũ "Đóng popup: Nút X · nhấn `Esc` · click ra ngoài"; `G014:517` tin ghim bị thu hồi vẫn trong danh sách, nhãn *"Đã thu hồi"*; `G036:237` bấm ghim → nhảy tới tin |
| Persona và context | P1, P6 |
| Customer journey / scenario | J2: mở `+N ghim`, xem, đóng; bấm một ghim của tin đã thu hồi |
| Observation | `[NGUỒN]` Nút đóng bảng tên "Thu gọn"; G036 không nêu Esc (G014 cũ có). `[CX GIẢ THUYẾT]` (i) "Thu gọn" gợi ý rút gọn danh sách chứ không phải đóng bảng — P6 có thể tìm nút "Đóng" / "X"; (ii) người quen phím Esc (G014 cũ) không có căn cứ Esc còn hoạt động; (iii) bấm ghim trỏ tới tin thu hồi → nhảy tới tin "giữ nội dung" — nhãn trong bảng danh sách ghim của G036 không nói có "Đã thu hồi" như G014 `[G014:517]` (phụ thuộc Q-03) |
| Finding type | Usability Issue |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — đúng requirement §10E; Esc không có requirement ở G036 |
| Impact | Thấp |
| Evidence và confidence / limitations | Chỉ từ câu chữ; G014 có thể đã bị G036 thay phần hiển thị (cách hiểu #4) nên Esc có thể không còn là kỳ vọng |
| Recommendation | Debate D-08: Esc có đóng bảng không; bảng ghim có nhãn "Đã thu hồi" cho ghim thu hồi không (gắn Q-03). IS-08 |
| Traceability | BR25 §10E; AC-BR25 (`G036:292-293`); G014 BR07, `G014:521` · case: `Unlinked` |
| Open questions / quyết định cần Product · BA · UX | Debate D-08 (§7) |

### CX-14 — Đang đọc tin cũ, tin khách mới tới chỉ "giữ chỗ" — không có tín hiệu báo

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-14 |
| Review scope | Cuộn / tin mới tới (J3) |
| Source evidence | `G036:109` AF02 "Tin mới tới khi đang đọc tin cũ: giữ nguyên chỗ đang đọc"; `G036:159` BR26 "đang đọc tin cũ thì giữ chỗ"; `G036:298` AC-BR26/AF02. G036 không nêu nút "xuống tin mới", bộ đếm tin chưa đọc hay bất kỳ tín hiệu nào trong khung chat |
| Persona và context | P1 — cuộn lên đọc lịch sử để trả lời khiếu nại dài; khách gửi tin mới trong lúc đó |
| Customer journey / scenario | J3: đang ở tin cách đáy nhiều màn hình; khách nhắn "alo còn đó không?" |
| Observation | `[NGUỒN]` Hệ thống giữ chỗ, đúng ý "không giành quyền cuộn". `[CX GIẢ THUYẾT]` Không có tín hiệu trong khung → nhân sự chỉ biết có tin mới qua danh sách hội thoại bên ngoài (ngoài phạm vi G036, chưa xác minh) hoặc khi tự cuộn xuống. Với CSKH, bỏ lỡ tin mới của chính khách đang mở là mất SLA phản hồi |
| Finding type | CX Risk — rủi ro giả định |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — đúng requirement (AF02); không có requirement về tín hiệu tin mới |
| Impact | **Cao** — chậm phản hồi khách đang chờ |
| Evidence và confidence / limitations | Chưa biết build có nút "↓ tin mới" không (G036 là nơi duy nhất quy định hiển thị, nếu có thì nguồn thiếu) |
| Recommendation | **IS-09** (nút "Tin mới ↓" kèm số, hiện khi có tin mới lúc không ở đáy — cần Product). Debate D-09: build có tín hiệu này không |
| Traceability | AF02, BR26; AC-BR26/AF01/AF02 (`G036:298`) · case: `Unlinked` |
| Open questions / quyết định cần Product · BA · UX | Debate D-09 (§7); Product: IS-09 |

### CX-15 — Quay lại hội thoại trong ~5 phút: nội dung đang đọc có thể đổi không báo

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-15 |
| Review scope | Chuyển hội thoại rồi quay lại (J5) |
| Source evidence | `G036:160` BR27 "đã mở trong ~5 phút gần nhất → hiện ngay, không vòng quay, tải lại ngầm; tin mới, tin thu hồi, cảm xúc tới trong lúc rời đi được bổ sung sau"; `G036:352` §15 bổ sung "~0,1–0,3 giây sau khi mở lại"; `G036:77` *đã đọc* gửi sau khi tải xong |
| Persona và context | P1 — nhảy qua lại giữa nhiều khách |
| Customer journey / scenario | J5: quay lại A, bắt đầu đọc tin cuối, 0,3s sau tin mới chèn vào / tin đang đọc bị thu hồi |
| Observation | `[NGUỒN]` Màn hiện ngay bản cũ rồi cập nhật ngầm; không có tín hiệu "đang cập nhật". `[CX GIẢ THUYẾT]` Trong 0,1–0,3s (số đo dev, Q-06) thay đổi là nhỏ; nhưng khi mạng chậm (`G036:355` "phụ thuộc tốc độ mạng") khoảng này dài hơn, người dùng có thể đã bắt đầu trả lời một tin vừa bị thu hồi hoặc bỏ sót tin mới chèn phía trên tầm nhìn nếu màn đang ở đáy (AF01 tự cuộn xuống — nên rủi ro bỏ sót thấp). Đây là đánh đổi chủ ý "không vòng quay"; rủi ro thấp |
| Finding type | CX Risk — rủi ro giả định |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — đúng requirement (BR27) |
| Impact | Thấp |
| Evidence và confidence / limitations | Số giây ở §15 là tham khảo (Q-06); chưa quan sát mạng chậm |
| Recommendation | QA: case quay lại hội thoại khi tin đang xem đã bị thu hồi trong lúc rời đi — "ĐO & GHI" cách tin đổi hiển thị. Không cần đề xuất riêng |
| Traceability | BR27, UC-01 b2; AC-BR27 (`G036:300-301`) · case: `Unlinked` |
| Open questions / quyết định cần Product · BA · UX | Không |

### CX-16 — Màn hẹp 390px + màn cảm ứng: nút luôn hiện trên mọi tin, kể cả hàng sticker

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-16 |
| Review scope | Màn hẹp 390px; màn cảm ứng (J2, J3) |
| Source evidence | `G036:161` BR28 "390–1600px không tràn… Màn cảm ứng: nút vốn chỉ hiện khi rê chuột thì **luôn hiện**"; `G036:154` BR21 3 nút tròn + sticker thêm "Tải sticker"; `G036:155` BR22 👍 góc phải dưới; `G036:223` §10D tối đa 3 sticker một hàng, mỗi sticker tin riêng (BR15 "thả cảm xúc, trả lời… **từng cái**"); `G036:154` menu "…" mở "tại vị trí nút"; `G036:144` BR11 khung tin ≤ 90% khung; `G036:238` nút "…" của ghim "màn cảm ứng luôn hiện" |
| Persona và context | P4 (giả thuyết) — khung chat 390px trên máy tính bảng / cửa sổ chia đôi |
| Customer journey / scenario | J2 / J3 trên 390px cảm ứng: hàng 3 sticker của khách; muốn bấm "Trả lời" một tin |
| Observation | `[NGUỒN]` Trên màn cảm ứng mọi tin đều hiện 3 nút (sticker 4 nút) + 👍 ở tin cuối khách; hàng 3 sticker → mỗi sticker có bộ nút riêng. `[CX GIẢ THUYẾT]` (i) Ở 390px, 3 sticker + 3×4 nút trên một hàng khó vừa, nút chồng nhau hoặc che sticker; (ii) nút luôn hiện trên mọi tin làm khung chat dày đặc nút, dễ chạm nhầm (nhất là 👍 — xem CX-09); (iii) menu "…" "tại vị trí nút" với tin phía mình sát mép phải khung 390px có thể tràn ra ngoài — nguồn không nói cách xử lý; (iv) bảng cảm xúc 6 emoji + gạch chéo (G009) mở bằng rê 0,4s — trên cảm ứng không có rê → chỉ có "bấm = Thích", không có cách mở bảng (nguồn không nói) |
| Finding type | CX Risk — rủi ro giả định |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — đúng requirement (BR28, AF06); bố cục cụ thể chưa có design |
| Impact | Trung bình — thao tác chậm, chạm nhầm; (iv) có thể không chọn được cảm xúc khác Thích trên cảm ứng |
| Evidence và confidence / limitations | Chưa có design cho 390px; chưa biết kích thước nút |
| Recommendation | Chuyển QA: case 390px cảm ứng với hàng 3 sticker (AC-BR28 + BR15) — "ĐO & GHI" chồng lấn, tràn; case menu "…" sát mép. Debate D-03 mở rộng: trên cảm ứng mở bảng cảm xúc bằng gì |
| Traceability | BR15, BR21, BR22, BR28, AF06; AC-BR28 (`G036:304-305`), AC-BR15 (`G036:273`), AC-BR21 (`G036:282`) · case: `Unlinked` |
| Open questions / quyết định cần Product · BA · UX | Debate D-03 (§7) |

### CX-17 — Tiếng Anh: chỉ 3 nhãn mốc có nguồn; các nhãn còn lại và định dạng ngày chưa được liệt kê

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-17 |
| Review scope | Tiếng Anh (J1–J5) |
| Source evidence | `G036:138` BR05 "Tiếng Anh: `Today` · `Yesterday` · `Sun/Mon/…`"; `G036:161` BR28 "Mọi nhãn có bản tiếng Anh" — "Trước: tiếng Anh thiếu 14 nhãn, hiện tên mã thay vì chữ"; `G036:306` AC "Mọi nhãn mới có bản tiếng Anh, không hiện tên mã"; `01-…` §6 liệt kê ~22 nhãn tiếng Việt nguyên văn (`Thử lại`, `Đang gửi`, `+N ghim`, `Thu gọn`, `Trưởng nhóm`, `[Hình ảnh]`…); Q-07 mở (định dạng ngày tiếng Anh) |
| Persona và context | P5 (giả thuyết) — dùng giao diện tiếng Anh |
| Customer journey / scenario | Toàn bộ J1–J5 bằng tiếng Anh |
| Observation | `[NGUỒN]` G036 chỉ cho bản tiếng Anh của 3 nhãn; không cho bản tiếng Anh của các nhãn còn lại, định dạng `T3 23/09/2026` / `23/08/2026` bằng tiếng Anh, thứ tự "20:47 Today", định dạng giờ 12h / 24h. Hiện trạng cũ "thiếu 14 nhãn, hiện tên mã". `[CX GIẢ THUYẾT]` Không có danh sách → dev tự dịch, QA không có kỳ vọng → nguy cơ lặp lại trộn tiếng Việt / tên mã trên giao diện tiếng Anh, nhất là nhãn mới (`+N ghim`, `Thu gọn`, `Thử lại`, `Phó nhóm`) |
| Finding type | Usability Issue |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — ngoài 3 nhãn, không có requirement nêu chữ tiếng Anh cụ thể |
| Impact | Trung bình với P5; không ảnh hưởng người dùng tiếng Việt |
| Evidence và confidence / limitations | Chỉ từ khoảng trống tài liệu |
| Recommendation | **Chuyển QA**: case AC-BR28 quét đủ danh sách nhãn ở `01-…` §6 bằng tiếng Anh, chỉ kiểm "có chữ, không mã" (không kiểm nội dung dịch vì không có nguồn). **Quay lại Debate**: mở rộng Q-07 thêm thứ tự "giờ + Today", 12h / 24h, bản tiếng Anh của nhãn mới. IS-10 |
| Traceability | BR05, BR28; AC-BR05 (`G036:254`), AC-BR28 (`G036:306`); Q-07 · case: `Unlinked` |
| Open questions / quyết định cần Product · BA · UX | Q-07 mở rộng (BA) |

## 6. Đề xuất cải thiện (luồng riêng — không phải requirement) `[ĐỀ XUẤT THAY ĐỔI]`

Mã `IS-nn` (Improvement Suggestion). Chỉ thành requirement khi người có thẩm quyền quyết định và G036 được cập nhật.

| ID | Đề xuất | Lý do | Cần ai quyết định | Trạng thái |
| --- | --- | --- | --- | --- |
| IS-01 | Rê chuột lên tin bất kỳ (không chỉ tin cuối cụm) hiện tooltip "tên nhân viên · giờ gửi" | CX-01, CX-02 — tin giữa cụm không có giờ, không có tên | Product / UX (BA Trân cập nhật G036 nếu đồng ý) | Đề xuất |
| IS-02 | Dấu hiệu nhỏ cho cụm gửi từ điện thoại (vd biểu tượng điện thoại cạnh "tên Zalo + giờ") | CX-03 — dễ nhầm với một nhân viên | Product / UX | Đề xuất |
| IS-03 | Dấu hiệu trưởng / phó không phụ thuộc màu (hình chìa khoá khác nhau, hoặc chữ nhỏ) và cách xem nghĩa trên màn cảm ứng | CX-05, CX-06 | Product / UX | Đề xuất |
| IS-04 | Biểu tượng play / thời lượng trên video để phân biệt với ảnh; ghi rõ hành vi bấm video vào G036 | CX-07 | BA (Trân) / Product | Đề xuất |
| IS-05 | Cách gỡ "Thích" ngay trên tin (vd bấm lại 👍 đã thả = gỡ) thay vì chỉ trong bảng chọn | CX-09 | Product (liên quan G009 BR02) | Đề xuất |
| IS-06 | Dấu hiệu "Đang gửi" tạm thời cho tin phía mình không phải tin cuối (kể cả sau "Thử lại"), biến mất khi "Đã gửi" | CX-10, CX-11 | Product / BA — có thể mâu thuẫn chủ ý "một ô" của BR24 | Đề xuất |
| IS-07 | Trích dẫn / thanh ghim ưu tiên tên nhân viên gửi nếu hệ thống biết, thay vì tên tài khoản | CX-12 — cần kiểm tính khả thi dữ liệu (G009 / G014) | Product / Dev | Đề xuất |
| IS-08 | Đổi nhãn "Thu gọn" thành "Đóng" (hoặc thêm "X"), bổ sung Esc | CX-13 | UX / BA | Đề xuất |
| IS-09 | Nút "Tin mới ↓" kèm số tin mới khi tin tới lúc không ở đáy | CX-14 | Product / UX | Đề xuất |
| IS-10 | Bảng nhãn song ngữ Việt – Anh đầy đủ trong G036 (hoặc phụ lục) để dev và QA cùng căn cứ | CX-17 | BA (Trân) | Đề xuất |
| IS-11 | Cân nhắc đưa OOS04 (hiện nút khi di chuyển bằng Tab) vào lộ trình để người dùng bàn phím thao tác được trên tin | Tiếp cận (accessibility); nguồn đã chủ động đưa ra ngoài phạm vi (`G036:317`) | Product | Ghi nhận — ngoài phạm vi hiện tại |

## 7. Chuyển cho QA / quay lại Debate

### 7.1 Chuyển cho QA xác minh (QA Test Designer đưa vào `03-…` / `04-…`, kết quả "ĐO & GHI" trừ khi có BR)

| # | Nội dung | Chuyển đi đâu | Nguồn |
| ---: | --- | --- | --- |
| 1 | Hai nhân viên chung tài khoản gửi liền nhau: ranh giới cụm có nhận ra được (8px, avatar mới) — ĐO & GHI | QA xác minh | CX-03; BR01, BR02 `G036:134-135` |
| 2 | Cụm gửi từ điện thoại xen cụm nhân viên: "tên Zalo + giờ" có phân biệt được với tên nhân viên không — ĐO & GHI | QA xác minh | CX-03; Q-02, Q-13 |
| 3 | Nhiều tin hệ thống liên tiếp trong < 30 phút: đếm số mốc "giờ + ngày" sinh ra (AC-BR03 ❹) | QA xác minh | CX-04; BR03 `G036:136` |
| 4 | Độ tương phản viền xanh nhạt trên khung phía mình (xanh nhạt) khi tài khoản là trưởng / phó (AC-BR10 `G036:266`) — ĐO & GHI | QA xác minh | CX-05; BR10, BR11 |
| 5 | Tin khách đã thu hồi: nhận diện được không cần rê chuột? Nút Trả lời / Chuyển tiếp có ẩn theo G009 BR04 / G003 BR19 (diễn giải AI #1 `01-…` §8) | QA xác minh (phần nhãn chờ Q-03) | CX-08; BR20 `G036:153`; `G009:232`; `G003:315` |
| 6 | Gỡ "Thích" từ khung chat qua gạch chéo trong bảng chọn (G009 BR02); bảng tự đóng khi rời chuột; 0,4s — ĐO & GHI | QA xác minh | CX-09; BR22 `G036:155`; `G009:66` |
| 7 | Tin của nhân viên A khi B (hoặc khách) gửi tiếp trong < 3 phút: tin A có dấu hiệu trạng thái nào không | QA xác minh — ĐO & GHI (chờ Q-09) | CX-10; BR24 `G036:157`; `G003:333-335` |
| 8 | Bấm "Thử lại" trên tin ở giữa hội thoại: viền đỏ / nút biến mất lúc nào, tin đổi vị trí không | QA xác minh — ĐO & GHI (chờ D-06) | CX-11; E01 `G036:121` |
| 9 | Nhãn `[Hình ảnh]` / `[Nhãn dán]` / `[Tập tin]` thống nhất giữa trích dẫn (BR13) và thanh ghim (§10E); trích video, trích tệp hiện nhãn gì | QA xác minh (chờ D-07) | CX-12; `G036:146`, `G036:234` |
| 10 | Quay lại hội thoại trong ~5 phút khi tin đang xem đã bị thu hồi lúc rời đi — cách tin đổi hiển thị | QA xác minh — ĐO & GHI | CX-15; BR27 `G036:160` |
| 11 | 390px màn cảm ứng: hàng 3 sticker với mọi nút luôn hiện — chồng lấn, tràn; menu "…" của tin phía mình sát mép phải | QA xác minh (AC-BR28/AF06, AC-BR15) — ĐO & GHI | CX-16; `G036:161`, `G036:223` |
| 12 | Giao diện tiếng Anh: quét toàn bộ nhãn ở `01-…` §6 — có chữ tiếng Anh, không hiện tên mã (AC-BR28); không kiểm nội dung dịch ngoài 3 nhãn có nguồn | QA xác minh | CX-17; `G036:306` |

### 7.2 Quay lại Debate (câu hỏi về cách hiểu tài liệu — Orchestrator đưa vào `02-…` nếu chấp nhận)

| # | Nội dung | Chuyển đi đâu | Nguồn |
| ---: | --- | --- | --- |
| D-01 | Tin giữa cụm có cách nào xem giờ gửi / tên nhân viên (tooltip…) không? Nếu build có thì G036 ("nơi duy nhất quy định hiển thị") đang thiếu | Debate — câu hỏi mới | CX-01, CX-02; BR07, BR09 `G036:140-142` |
| D-02 | "Nhóm tin hệ thống đang thu gọn" (BR19, AF04) được quy định ở spec nào; khi thu gọn, BR03 ❹ (mốc sau tin đứng riêng) và BR02 (16px) áp dụng thế nào | Debate — câu hỏi mới | CX-04; `G036:111`, `G036:152` |
| D-03 | AF06 "luôn hiện" có áp dụng cho tooltip "Trưởng nhóm" / "Phó nhóm" không; trên màn cảm ứng mở bảng cảm xúc bằng gì khi không rê chuột được | Debate — câu hỏi mới | CX-06, CX-16; `G036:113`, `G036:143`, `G036:155` |
| D-04 | Hành vi **bấm vào video** (tải về theo G003 là `[DIỄN GIẢI AI]` ở Q-15) cần BA xác nhận; video có dấu hiệu phân biệt với ảnh không | Debate — bổ sung Q-15 | CX-07; `G036:147`; `G003:468` |
| D-05 | Bấm 👍 lần hai trên tin đã Thích: gỡ hay giữ nguyên (G009 BR02 quy định?) | Debate — câu hỏi mới | CX-09; `G036:155`; `G009:66` |
| D-06 | Sau "Thử lại": tin giữ vị trí hay xuống cuối; viền đỏ / nút tắt lúc nào; có ô "Đang gửi" tạm cho tin đó không | Debate — câu hỏi mới, liên quan Q-09, Q-16 | CX-11; `G036:121`, `G036:157`; `G003:339` |
| D-07 | Trích dẫn video / tệp hiện nhãn gì (`[Hình ảnh]` cho video? `[File]` hay `[Tập tin]` cho tệp) | Debate — câu hỏi mới | CX-12; `G036:146`, `G036:234`; `G009:301` |
| D-08 | Esc có đóng bảng danh sách ghim không (G014 cũ có, G036 không nêu); ghim của tin thu hồi trong bảng có nhãn "Đã thu hồi" không (gắn Q-03) | Debate — câu hỏi mới | CX-13; `G036:236-239`; `G014:517`, `G014:521` |
| D-09 | Khi tin mới tới lúc đang đọc tin cũ (AF02), trong khung chat có tín hiệu gì không | Debate — câu hỏi mới | CX-14; `G036:109` |
| Q-03 | Bổ sung lý do CX (CX-08: rủi ro xử lý theo nội dung khách đã rút) — đề nghị ưu tiên trả lời | Debate — bổ sung lý do, không đổi mức | CX-08 |
| Q-04 / Q-09 | Bổ sung lý do CX (CX-10: thông tin "khách đã xem" lùi vào menu "…"; tin không phải tin cuối không có trạng thái trong 3 phút) | Debate — bổ sung lý do | CX-10 |
| Q-05 | Bổ sung: khi cuộn lên tải thêm tin cũ, mốc "trước tin đầu danh sách" (BR03 ❶) có dịch chuyển lên tin đầu mới không | Debate — bổ sung câu hỏi | CX-04 (liên quan); `G036:136` |
| Q-07 | Mở rộng: thứ tự "giờ + Today", định dạng giờ 12h / 24h, bản tiếng Anh của nhãn mới (`+N ghim`, `Thu gọn`, `Thử lại`, `Phó nhóm`…) | Debate — bổ sung câu hỏi | CX-17; `G036:138`, `G036:161` |

## 8. Tự rà soát

- [x] Mỗi finding có loại, persona, bằng chứng nguồn (`tệp:dòng`), mức bằng chứng (phân tích tài liệu), giới hạn
- [x] Không Defect nào — không có bằng chứng thực tế (không Mode 2)
- [x] Không câu nào nói đã thao tác / đã thấy; mọi nhận định hành vi gắn `[CX GIẢ THUYẾT]` hoặc "rủi ro giả định"
- [x] Persona giả thuyết (P4, P5, P6) đã đánh dấu; P1–P3 có tham chiếu nguồn
- [x] "Expected vs observed" chỉ ghi N/A kèm lý do (không có căn cứ cho vế observed)
- [x] Đề xuất cải thiện tách ở §6 với mã `IS-nn`; không dùng `CP-`; không lẫn vào requirement
- [x] Điểm mở Q-03 → Q-11, Q-14, Q-16 không tự chọn cách hiểu; finding liên quan ghi "phụ thuộc Q-nn"
- [x] Số đếm: 17 finding (Usability Issue 6 · CX Risk 11 · Defect 0) — đếm lại từ §4; 11 IS; 12 mục chuyển QA; 9 câu hỏi Debate mới (D-01 → D-09) + 5 bổ sung cho Q cũ
- [x] Không sửa file `01-…` → `04-…`, `cau-hoi-gui-BA.md`, `tailieu/`
- Giới hạn: không có design / prototype / sản phẩm; chưa đọc G008, G023, G025; dòng spec gốc chỉ đọc phần đã trích trong `01-…`

## Lịch sử cập nhật

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
| 2026-10-13 | AI (CX) — người dùng: Hồng (QA) | Tạo bản đầu: Mode 1 + 3 (phân tích tài liệu), 17 finding (0 Defect · 6 Usability · 11 CX Risk), 11 đề xuất IS-01 → IS-11, 9 câu D-01 → D-09 quay lại Debate (Orchestrator đánh mã Q-20 → Q-28) |
