---
feature: G033 — Màn Link nhóm (mời bằng QR hoặc link)
specVersion: v1.0 Draft (last updated 2026-10-02, BA: Trân)
plan: chưa có (Phase 1 — intake, chưa viết plan/case)
createdBy: QA
createdAt: 2026-10-07
updatedBy: QA
updatedAt: 2026-10-07
lane: high-risk
flags: [security-test, cross-service-e2e, regression-scope, flaky-risk, multi-tenant-isolation]
hardGatesTriggered: [security-test, cross-service-e2e, multi-tenant-isolation]
status: high-risk-pending-confirmation
---

# INTAKE — G033: Màn Link nhóm

> Phase 1: rà soát tài liệu + lập câu hỏi làm rõ. KHÔNG phải test plan / test case.
> Số dòng `L###` = dòng trong file nguồn của tài liệu được nêu tên. Câu trích trong dấu "…" là nguyên văn.
> **Quy ước nguồn (user chốt 2026-10-07):** mỗi file trong `tailieu/` là **bản DUY NHẤT và HIỆN HÀNH** của tài liệu đó. Số version mà tài liệu khác dẫn (G008 v1.9, G003 v1.23…) chỉ là các lần sửa trực tiếp trên docs, không có file bản khác để chờ. Với G032, bản hiệu lực là `G032 - Đổi tên gợi nhớ (1).md`.
> Mã Q-01…Q-30 giữ nguyên; câu mới từ Q-31.

## 0. Nguồn

| Nguồn | Vai trò |
|---|---|
| `tailieu/G033 - Màn Link nhóm (1).md` (v1.0 Draft, 2026-10-02) | AC-source chính (§3 UC, §4 AF, §5 E01–E08, §6 BR, §7 state, §10 UI, §11 AC, §15 perf). Đã kiểm lại `tailieu/G033*`: chỉ có 1 file |
| `tailieu/G008 - Quản lý nhóm.md` (v1.1, 2026-06-26) | **Spec hiện hành.** BR01–BR22, BR15/AF01 = copy clipboard |
| `tailieu/G011 - Panel Thông tin.md` (v1.1, 2026-08-04) | **Spec hiện hành.** BR01–BR10, không có BR02b |
| `tailieu/G026 - Cài đặt nhóm (1).md` (v1.0, 2026-08-17) | Spec hiện hành: duyệt thành viên, "không có phó nhóm", quyền |
| `tailieu/G003 - Chat.md` (v1.11, 2026-08-03) | Spec hiện hành: UC-08, BR03, BR20–BR27, E09 |
| `tailieu/G002 - Chia sẻ tài khoản Zalo cho Staff.md` (v1.2) | Phân quyền theo tài khoản, cô lập workspace |
| `tailieu/G001-lien-ket-tai-khoan-zalo.md` (v1.1) | Trạng thái tài khoản Zalo |
| `tailieu/G016 …(2).md` (v1.0), `tailieu/G018_Cache_mã_QR….md` (v1.2) | Đối chiếu OQ01 / OOS07: chỉ nói **QR liên kết tài khoản**, không liên quan QR nhóm |
| `tailieu/G010 - Soft Delete….md` (v1.2), `G014 - Ghim tin nhắn (2).md`, `G015 - Hiển thị Thumbnail….md` (v1.1), `G023 - Gửi danh thiếp….md`, `G011a - Panel Ghi chú (2).md`, **`G032 - Đổi tên gợi nhớ (1).md`** (bản hiệu lực), `CR-001`, `CR-004` | Đọc để suy ra nghĩa BR-C01/C02/C05/C06/C07/C12 (Grep `BR-C` toàn `tailieu/`) và tìm quy tắc liên quan chia sẻ link/tin nhắn |
| `tailieu/thay-doi-28-29-09.html`, `tailieu/luong-dong-bo-gopany.html` | Cache nhóm, avatar fallback, chuyển tiếp, phiên Zalo PC/Web, đa công ty |
| `wiki/qa/test-cases/Z-02.md` §0 | Tiền lệ format intake |

**Đã Grep toàn `tailieu/` (kể cả 2 file html) với "link nhóm / QR nhóm / zalo.me/g / link mời / invite":** chỉ G008 và G033 có nội dung về link nhóm. Không có tài liệu API/hub, không có nơi nào mô tả lấy QR nhóm.

**Không tìm thấy trong repo:** `PROJECT_KNOWLEDGE` (§5 chứa các BR-C chung, được CR-001 L143 dẫn chiếu).

**B1 (AC-source):** spec thuần nghiệp vụ, §8/§9 = N/A (không có contract). §11 có checklist AC testable theo từng BR/UC → **đủ nguồn, không `blocked-no-ac`**. Mã lỗi dùng chính E01–E08 của spec, KHÔNG tự chế `ERR-xxx`.

Trạng thái tài liệu cần lưu ý: **Draft**, "Dev assignee: —", **OQ01 "Chờ dev — chặn build"**.

### 0.1 Dẫn chiếu treo (dangling reference) — G033 dẫn thứ không có trong spec hiện hành

Vì `tailieu/` là bản duy nhất, các dẫn chiếu dưới đây **không tồn tại** ở spec hiện hành. Hoặc G008/G011/G026/G003 **chưa được cập nhật theo G033**, hoặc **G033 dẫn sai**. QA không tự quyết (xem Q-31).

| # | Ai dẫn (file:dòng) | Dẫn tới | Spec hiện hành có/không | Kết luận |
|---|---|---|---|---|
| 1 | G033 L38, L156 (AF06), L242, L520, L530, L563, L579 | "G008 **BR15 v1.9**" — nút Mời qua link mở màn G033 thay vì copy | **KHÔNG.** G008 là v1.1 (L11). BR15 L300, AF01 L242, AC L455 đều là "copy vào clipboard → toast Đã copy link nhóm". Changelog G008 chỉ v1.0, v1.1 (L518–L520), không có "v1.9" | Treo |
| 2 | G033 L197, L422, L457, L520 | "G008 **BR25** — Zalo chỉ cho trưởng/phó đổi cài đặt nhóm; không nằm trong ba đặc quyền riêng của trưởng nhóm" | **KHÔNG.** G008 chỉ có BR01–BR22 (BR22 ở L307). Cụm "ba đặc quyền" chỉ xuất hiện trong G033 | Treo. **E08, BR16, AC L422 dựa vào nội dung này** |
| 3 | G033 L183, L522 | "G011 **BR02b**" — G033 tự khai dòng Link nhóm trong "nhóm dòng chức năng" | **KHÔNG.** G011 chỉ có BR01–BR10 (L129–L138); BR03 L131 còn cấm nút thao tác trong panel | Treo + mâu thuẫn (Q-35) |
| 4 | G033 L38, L241 | "G008 §10C có dòng Link nhóm — nay trỏ sang G033" | **MỘT PHẦN.** §10C L395 có dòng "Link nhóm | Hiển thị link mời nhóm để copy…" nhưng **không trỏ G033**; §13 L501–L504 "Được phụ thuộc bởi" không có G033 | Treo một chiều |
| 5 | G033 L186 (BR04) | G008 BR06 | **CÓ** (L292) | Không treo |
| 6 | G033 BR09/AF03 | G008 BR02 | **CÓ** (L287) | Không treo |
| 7 | G033 BR06 | G003 UC-08, BR21, BR23, BR27 | **CÓ** (L201–L212, L317, L319, L323). Riêng chữ BR21 "Chỉ trưởng/phó nhóm" (G003 L317) khác "chỉ trưởng nhóm" (G026 BR06 L135, G033 BR06) | Không treo; lệch chữ G003↔G026 |
| 8 | G033 L166, L193, L223 | BR-C06, BR-C07, BR-C12 | **Không có định nghĩa** (nguồn `PROJECT_KNOWLEDGE §5` không có trong repo); nghĩa suy ra ở Q-26 | Treo định nghĩa |
| 9 | G026 L128 (BR01) | "Hệ thống không có vai trò phó nhóm (**G008 v1.3**)" | **KHÔNG.** G008 là v1.1 và **vẫn dùng phó nhóm** (L25, L26, L43, L129–L141, L291, L385–L386, L423–L424) | Treo (không thuộc G033 nhưng ảnh hưởng, Q-33) |
| 10 | G026 L82, L134 | "G008 đã chốt sửa thông tin nhóm **chỉ trưởng nhóm**" | **KHÔNG.** G008 BR05b L291: "trưởng nhóm **hoặc phó nhóm**" | Treo / mâu thuẫn G026↔G008 |
| 11 | CR-004 L75–L78, L84 | G003 **v1.23** BR03 mốc tách tin 2.000 ("Đã sửa tài liệu") | **KHÔNG.** G003 là v1.11; BR03 L297 = 1.000 ký tự (BR03b L298 "mốc 1.000") | Treo (ảnh hưởng Q-20) |

**Hệ quả:** không còn lý do "chờ bản spec khác". Việc cần là **BA quyết định**: spec hiện hành nào phải sửa, hoặc G033 dẫn sai. Tới khi có nội dung BR25/BR15-mới/BR02b, các kỳ vọng dựa vào chúng (E08, BR16, AC L422, hành vi mới của "Mời qua link") **bị chặn**. Danh sách dòng spec khác cần sửa nếu G033 đúng: §6.1.

---

## 1. Test-risk (B2–B6) — chấm lại

| Mục | Trước (bản đầu) | Sau đối chiếu G-spec (giữ nguyên sau quyết định "tailieu là bản duy nhất") |
|---|---|---|
| **Lane** | high-risk (4 flag + 2 hard gate) | **high-risk** (5 flag + 3 hard gate) |
| **Flags bật** | `security-test` · `cross-service-e2e` · `regression-scope` · `flaky-risk` | `security-test` · `cross-service-e2e` · `regression-scope` · `flaky-risk` · **`multi-tenant-isolation` (mới bật, tạm thời — chờ BA xác nhận Q-14/BR-C01)** |
| **Hard gates** | `security-test` · `cross-service-e2e` | `security-test` · `cross-service-e2e` · **`multi-tenant-isolation`** |
| **Flag KHÔNG bật** | `data-integrity` | `data-integrity` (không tiền/tồn/số dư/migration; §16 "Data migration: Không cần". Đổi/huỷ link không hoàn tác với link đã phát ra (L410) nhưng không thuộc định nghĩa flag) · `no-ac-source` |
| **Status** | high-risk-pending-confirmation | high-risk-pending-confirmation (parent vẫn phải DỪNG xin user xác nhận scope) |
| **Test depth** | Normal + exploratory + a11y + automation regression + confirm scope | Giữ nguyên |
| **Test types** | acceptance · system · e2e · regression · exploratory · a11y · perf-smoke | Giữ nguyên |
| **Skills gợi ý** | qa-test-design · qa-test-types · qa-e2e-playwright · qa-api-test · qa-test-data · qa-defect · qa-exit-criteria | Giữ nguyên (`qa-test-data` quan trọng hơn: cần 2 workspace) |
| **Out of scope QA** | unit/integration/contract (dev) · load test · pentest · màn xem trước nhóm do app Zalo dựng (OOS03) · OOS01–OOS08 | Giữ nguyên |

Cách hiểu mới (spec hiện hành là bản duy nhất) **không làm đổi lane/flag**. Riêng `regression-scope` chắc chắn hơn: mâu thuẫn với spec hiện hành là thật, không còn là nghi vấn lệch bản.

**Vì sao bật `multi-tenant-isolation` (căn cứ từ G-spec hiện hành):**

- Mô hình đa workspace/công ty có thật và dữ liệu phải cô lập: G010 BR02 L156 "Dữ liệu phân theo **workspace** … Cô lập dữ liệu đa workspace"; BR03 L157 định danh `companyId + zaloUid`; G002 L248–L250 mục "**Cô lập dữ liệu giữa các workspace ⚠️ (bắt buộc)**: Người dùng workspace A không thể xem hoặc chỉnh phân quyền của workspace B"; AC cô lập (`BR-C01`) lặp lại ở G014 L691, G015 L238, G032 (Đổi tên gợi nhớ (1)) L286.
- Link/QR nhóm là chuỗi cho phép người ngoài vào nhóm; nhóm gắn với tài khoản Zalo thuộc 1 workspace (G003 BR02 L296, BR11 L307). Gọi API link/tạo/đổi/huỷ chéo workspace sẽ rò link hoặc làm chết link nhóm của workspace khác.
- **G033 không có một dòng nào về workspace/tenant** (không AC cô lập, không nêu trong E01). Mọi spec cùng loại trong bộ đều có AC `BR-C01`; G033 thiếu → vừa là bằng chứng bật flag vừa là lỗ hổng spec (Q-14).
- Giới hạn: nghĩa của `BR-C01` được **suy ra từ cách các spec khác dùng** (định nghĩa gốc ở `PROJECT_KNOWLEDGE §5`, không có trong repo). Flag đánh dấu **tạm thời**, BA xác nhận ở Q-14.

**Căn cứ các flag còn lại (theo nội dung thật):**

| Flag | Bằng chứng trong spec |
|---|---|
| `security-test` (hard gate) | BR04 + E01 (L166, L186): phân quyền Admin / "Quản lý nhóm" quyết định ai thấy; "Gọi API thẳng → từ chối" + "Ghi log truy cập trái phép". Link nhóm là chuỗi cho phép người ngoài vào nhóm → cần test rò rỉ/quyền ở cả UI và API. Đổi/huỷ/tạo link là thao tác ghi lên Zalo gắn với quyền. 2 lối vào (panel + Thêm thành viên) phải cùng luật (Q-11) |
| `cross-service-e2e` (hard gate) | Gopany FE → BE → hub/zaloHub → Zalo (lấy link/QR, tạo, đổi, huỷ; OQ01/OQ04 chưa chốt contract hub) + G008/G026/G003/G011/G001 + người nhận quét/bấm trên app Zalo (BR10) |
| `regression-scope` | Đổi hành vi nút "Mời qua link" đã ship (breaking change L563) mâu thuẫn trực tiếp với G008 BR15/AF01/AC L455 hiện hành · thêm dòng vào panel trái G011 BR03 · dùng lại hộp chọn G003 UC-08 · luật G026 |
| `flaky-risk` | Mọi thao tác "chờ Zalo xác nhận" (async) · BR-C12 màn cập nhật "ngay" khi đổi trên app Zalo · ngưỡng 2s/10s (§15) |

---

## 2. Danh sách Use Case (6 UC) — §3

| UC | Tên | Vị trí | Ngoại lệ/Luồng phụ liên quan |
|---|---|---|---|
| UC-01 | Mở màn Link nhóm và sao chép link | L57–L65 | E01–E06, AF01–AF03, AF06 |
| UC-02 | Chia sẻ link vào một hội thoại (thực tế: một hoặc nhiều) | L67–L74 | E05, E06; BR06, BR14 |
| UC-03 | Lưu mã QR | L76–L81 | E07; BR07 |
| UC-04 | Tạo link cho nhóm chưa có link | L83–L90 | E08, E05, E06; AF05, AF08; BR15, BR16 |
| UC-05 | Đổi link nhóm | L92–L100 | E08, E05, E06; AF07; BR17 |
| UC-06 | Huỷ link nhóm | L102–L110 | E08, E05, E06; AF07; BR17 |

Luồng phụ có trong spec: AF01, AF02, AF03, AF05, AF06, AF07, AF08 (**không có AF04**, xem Q-26). Ngoại lệ: E01–E08 (L166–L173).

Ghi chú sau đối chiếu: UC-02 b4 (L72) "một tin nhắn" mâu thuẫn BR14 (Q-05) và chưa rõ thẻ xem trước do ai dựng (Q-36); UC-01 b3 (L61) ghi `[→ AF05]` sai (Q-26); E02 (L167) trùng chuỗi toast với G011 L116 và G015 E06 L122 ("Tài khoản Zalo đang ngắt kết nối. Vui lòng kết nối lại") — nhất quán, riêng G002 BR01 L135 dùng chuỗi "Tài khoản đã ngắt kết nối…"; AF06/AF08 (đóng màn về Thêm thành viên) và UC-01 b1 mô tả hành vi mới của nút "Mời qua link" — trái G008 AF01 L242 hiện hành (Q-31).

---

## 3. Business Rules (16 BR) — §6, gom theo nhóm, kèm đối chiếu spec hiện hành

**A. Lối vào & điều hướng**
- BR01 (L183): Hai lối vào cùng một màn: dòng "Link nhóm" trên panel (G011 BR02b) và nút "Mời qua link" ở Thêm thành viên (G008 BR15); cả hai MỞ MÀN, không copy thẳng vào clipboard; đóng màn về đúng chỗ vừa đi ra.
  - ↳ Đối chiếu: **G011 không có BR02b**, và BR03 (L131) cấm nút thao tác trong panel (Q-35). **G008 BR15 L300 / AF01 L242 hiện hành vẫn là "copy thẳng"** (Q-31). G008 §10C đã có dòng "Link nhóm | Admin + có quyền" (L395) và nút "Thêm thành viên" (L390).

**B. Quyền & trạng thái tài khoản**
- BR04 (L186): Quyền Gopany quyết định ai THẤY dòng Link nhóm: Admin hoặc quyền "Quản lý nhóm" (G008 BR06); không quyền → ẩn hoàn toàn (BR-C06). Vai trò Zalo (trưởng/phó/thành viên) KHÔNG phải điều kiện của Gopany; Zalo từ chối thì rơi E03.
  - ↳ Đối chiếu: G008 BR05 L290 + BR06 L292 đúng là "Admin + nhân viên có quyền Quản lý nhóm"; G008 L114, L361, L445 ẩn nút **Thêm thành viên** với người không quyền (→ lối vào 2 bị chặn theo, Q-11). Nhưng G008 BR05b L291, G011 BR08 L136, G026 BR02 L129 **gate theo vai trò ở Gopany** — ngược tinh thần "không gate vai trò Zalo" (Q-34). G026 BR01 L128: **không có phó nhóm** (Q-33).
- BR11 (L193): Tài khoản Zalo DISCONNECTED → không mở được màn (E02). Nhất quán BR-C07.
  - ↳ Đối chiếu: **nhất quán** — BR-C07 theo cách dùng ở G010 BR04 L158 "DISCONNECTED → dữ liệu vẫn hiển thị; chỉ khóa các thao tác outbound/live-read Zalo API", G014 BR10 L410, G015 L47. Link/QR phải đọc trực tiếp từ Zalo (live-read) nên bị khoá là đúng. Tên trạng thái: G033 dùng CONNECTED/DISCONNECTED, G001 L197 dùng "Đang hoạt động / Ngắt kết nối" (cùng nghĩa).

**C. Nguồn link & QR**
- BR02 (L184): QR chứa đúng link nhóm; link đổi thì QR đổi theo; Zalo trả ảnh QR → dùng nguyên (có logo Zalo); hệ thống tự sinh → mã trơn, KHÔNG logo Zalo (gắn OQ01).
  - ↳ Đối chiếu: không tài liệu nào giải OQ01 (Q-01).
- BR03 (L185): Dùng đúng link có sẵn (G008 BR15); hệ thống không tự tạo/đổi/huỷ; mỗi lần mở màn ra đúng link cũ; chỉ đổi khi người dùng bấm Tạo ngay (BR16) hoặc Đổi/Huỷ (BR17).
  - ↳ Đối chiếu: **G008 L242 / L300 hiện hành nói "hệ thống tự tạo link nhóm có sẵn cho mỗi nhóm"** — mâu thuẫn thật với "nhóm chưa có link / không tự tạo" của G033 (Q-32).
- BR07 (L189): Lưu mã QR → tải PNG, tên file `QR - {tên nhóm}.png`.
  - ↳ Đối chiếu: không có quy tắc đặt tên file/ký tự cấm ở spec nào (Q-17). Tên nhóm tối đa 100 ký tự (G008 BR03 L288).

**D. Thao tác theo trạng thái link**
- BR05 (L187): Đã có link → 3 nút (Sao chép · Chia sẻ · Lưu mã QR) + menu `•••`; chưa có link → không có 3 nút, không có `•••`, chỉ nút Tạo ngay; không thêm gì khác.
- BR15 (L196): Chưa có link → màn khác hẳn (§10F): 2 icon QR+link, câu mời, nút Tạo ngay; không QR/link/3 nút (kể cả mờ)/`•••`; không phải lỗi, không E03, không Thử lại; không bao giờ tự tạo link khi mở màn.
  - ↳ Đối chiếu: G008 L242/L300 ngụ ý mọi nhóm đều có link (Q-32).
- BR16 (L197): Tạo ngay → gọi Zalo luôn, KHÔNG hộp xác nhận; Zalo trả link → đổi tại chỗ sang §10B + toast "Tạo link thành công"; Zalo từ chối → không đổi gì, E08; ai bấm được = người thấy dòng Link nhóm (BR04), không thêm điều kiện vai trò Zalo; ghi lên Zalo xong mới đổi màn.
  - ↳ Đối chiếu: dẫn "G008 BR25" là dẫn chiếu treo (Q-31); "trưởng nhóm hoặc phó nhóm" trái G026 BR01 (Q-33); không gate vai trò trái G008 BR05b (Q-34).
- BR17 (L198): Đổi/Huỷ trong `•••` (chỉ khi có link); BẮT BUỘC hộp xác nhận nói rõ hậu quả (nút Huỷ để thoát, AF07); ghi lên Zalo xong mới đổi màn; Zalo từ chối → không đổi gì, E08; link cũ chết ngay, không báo người giữ link cũ, không lưu link cũ.

**E. Chia sẻ link**
- BR06 (L188): Chia sẻ link → hộp chọn hội thoại (G003 UC-08) giữ nguyên luật: tối đa 99 (G003 BR27), chỉ hội thoại có quyền xem (BR23), nhóm "chỉ trưởng nhóm được nhắn tin" hiện nhưng disable (BR21); bộ lọc tài khoản Zalo mặc định = tài khoản quản lý nhóm, đổi được sang tài khoản khác có quyền; gửi "như một tin nhắn thường".
  - ↳ Đối chiếu: G003 UC-08 L205 **có** filter tài khoản Zalo (single select, mặc định = tài khoản của hội thoại nguồn, chỉ hiện tài khoản user có quyền xem); BR23 L319 giới hạn trong 1 tài khoản; BR27 L323 trần 99 + nhắc "Tối đa 99 hội thoại"; BR21 L317 disable nhóm hạn chế nhắn tin (G003 viết "chỉ trưởng/phó nhóm", G026 BR06 L135 viết "chỉ trưởng nhóm" — G033 theo G026); BR25 L321 loại nhóm đã rời/bị xoá khỏi điểm đến. "Như một tin nhắn thường" là nguyên văn G003 BR20 L316 → nguồn gốc mâu thuẫn với BR14 (Q-05).
- BR14 (L195): Màn chia sẻ có thẻ xem trước (avatar + tên nhóm + link) và dòng tin nhắn kèm mặc định "Truy cập link để tham gia nhóm", sửa được; tin gửi đi dạng THẺ xem trước, không phải tin chữ thường; dòng chữ không chứa link thì Zalo tự nối link vào cuối; xoá trắng → người nhận chỉ thấy link.
  - ↳ Đối chiếu: G015 (link preview) định nghĩa thẻ theo cơ chế khác và cho phép rơi về text thường (Q-36).

**F. Dòng nhắc theo trạng thái nhóm**
- BR08 (L190): Nhóm bật duyệt thành viên (G026) → dòng nhắc "Nhóm đang bật duyệt thành viên — người tham gia sẽ chờ trưởng nhóm duyệt"; tắt thì không hiện.
  - ↳ Đối chiếu: khớp G026 BR04 L131, BR08 L132 (chờ duyệt, chỉ **trưởng nhóm** Duyệt/Từ chối) và chữ "trưởng nhóm" (G026 BR01).
- BR09 (L191): Nhóm đủ số thành viên tối đa → cảnh báo "Nhóm đã đủ {số} thành viên — người mới chưa vào được"; vẫn mở và lấy được link/QR; `{số}` lấy từ `maxMember` Zalo trả về. Cả hai đúng → hiện cả hai, cảnh báo đầy ở trên (§10C L285).
  - ↳ Đối chiếu: G008 BR02 L287 + E05 L268 ghi 100 (cá nhân) và Business "cần xác nhận con số cụ thể" — cùng khoảng trống (Q-10).

**G. Luồng người nhận**
- BR10 (L192): Quét QR/bấm link không vào nhóm ngay; app Zalo mở màn xem trước nhóm (do Zalo dựng, OOS03) + nút Tham gia; bấm Tham gia mới đi luồng hiện có: chờ duyệt nếu G026 bật, vào thẳng nếu tắt.
  - ↳ Đối chiếu: phần "sau Tham gia" **khớp** G026 UC-06 L88–L95, BR04 L131, BR08 L132 (G026 chỉ nhắc "qua link (G008 AF01)", chưa nhắc QR). G008 AC L456 "người được mời vào nhóm qua link → xuất hiện trong danh sách thành viên" chưa có bước duyệt/màn xem trước (xem §6.1).

**H. Nền tảng**
- BR13 (L194): Hành vi/chuỗi/giới hạn đồng nhất Web·Android·iOS; mobile màn toàn trang nút ←, Web popup giữa màn nút ✕; chỉ 2 điểm khác được phép: Chia sẻ link và Lưu mã QR.
  - ↳ Đối chiếu: cùng khuôn với G032 (Đổi tên gợi nhớ (1)) BR14 L148 (đồng nhất Web·Android·iOS; Web popup). G001/G002 là desktop only (G002 L194) — chỉ là màn thiết lập tài khoản.

**Không đánh số nhưng có tính ràng buộc kiểm thử** (không tính vào 16 BR): §7 state machine 2 trạng thái CHƯA_CÓ_LINK ↔ CÓ_LINK (L202–L225) · BR-C12 màn cập nhật ngay khi link đổi trên app Zalo (L223, AC L470) · §15 ngưỡng 2s/10s/3s/1s (L550–L553) · §10E Web popup ~420px, đóng bằng ✕/Esc/click nền (L326) · OOS01–OOS08 (L503–L510, danh sách cấm).

---

## 4. Câu hỏi làm rõ

> Đánh dấu loại: [M] mâu thuẫn · [T] thiếu · [N] không có ngưỡng đo được · [B] đã nằm trong §14 Open Questions của spec.
> Trạng thái sau đối chiếu G-spec: **ĐÃ TRẢ LỜI** (tài liệu gốc định nghĩa rõ, có trích) · **MỘT PHẦN** · **VẪN MỞ** · **SAI** (tiền đề câu hỏi sai). Cột "Chặn" = có chặn việc viết kỳ vọng cho AC cốt lõi hay không.

### 4.0 Bảng tổng hợp trạng thái 30 câu cũ

Sau quyết định "tailieu là bản duy nhất" **không câu cũ nào đổi trạng thái** (0 / 14 / 16 / 0). Chỉ đổi cách diễn giải: các đối chiếu với G008/G011/G003 nay là đối chiếu với **spec hiện hành** (Q-11, Q-20, Q-26 cập nhật lời). Cột "Đổi" ghi rõ.

| Q | Loại | Trạng thái | Đổi | Chặn | Nguồn đối chiếu chính |
|---|---|---|---|---|---|
| Q-01 | [B] OQ01 nguồn QR | VẪN MỞ | không | **Chặn** (case QR/logo) | G016/G018 không liên quan; không tài liệu nào |
| Q-02 | [B] OQ04 3 API | VẪN MỞ | không | **Chặn** môi trường | G008 L342/L348 N/A |
| Q-03 | [B] OQ02+OQ05 thành viên xem link | VẪN MỞ | không | Từng case | G026 BR02, G008 L537 liên quan, không đo |
| Q-04 | [B] OQ03 hạn dùng link | VẪN MỞ | không | Từng case | — |
| Q-05 | [M] tin thường vs thẻ | VẪN MỞ | không | **Chặn** UC-02 | G003 BR20 L316 là nguồn chữ "tin nhắn thường"; xem Q-36 |
| Q-06 | [M] một vs nhiều hội thoại | MỘT PHẦN | không | Không | G003 UC-08 b3 L210, BR22 L318 |
| Q-07 | [M] phó nhóm thấy dòng Link | VẪN MỞ | không | **Chặn** (cụm quyền) | G008 BR25 treo (Q-31); G026 BR01 → Q-33 |
| Q-08 | [M] E06 Thử lại | VẪN MỞ | không | Từng case | G015 E04 L120 chỉ toast |
| Q-09 | [M] E03 vs chưa có link | VẪN MỞ | không | **Chặn** fault-injection | — |
| Q-10 | [M] 100 ghi cứng | VẪN MỞ | không | Từng case (Business) | G008 BR02 L287 cùng khoảng trống |
| Q-11 | [T] lối vào 2 và quyền | MỘT PHẦN | lời (G008 là spec hiện hành, cùng điều kiện hơn chắc chắn) | Giảm | G008 L114, L361, L390, L445 |
| Q-12 | [T] thu hồi quyền khi đang mở | MỘT PHẦN | không | Từng case | G014 BR19 L419 (convention) |
| Q-13 | [T] "gọi API thẳng" | VẪN MỞ | không | **Chặn** (hard gate security) | không có tài liệu API |
| Q-14 | [T] tenant | MỘT PHẦN | không | Giảm (đã bật flag) | G002 L248–L250, G010 BR02 L156 |
| Q-15 | [T] log | VẪN MỞ | không | Từng case | chỉ có chuỗi "Ghi log truy cập trái phép" |
| Q-16 | [T] định dạng link/QR/clipboard | MỘT PHẦN | không | Từng case | G015 BR01 L142 |
| Q-17 | [T] Lưu QR chi tiết | VẪN MỞ | không | Từng case | — |
| Q-18 | [N] rút gọn tên / avatar | MỘT PHẦN | không | Không | G008 BR03 L288 |
| Q-19 | [T] gửi nhiều, lỗi một phần | MỘT PHẦN | không | Từng case | G003 E09 L273, BR22 L318 |
| Q-20 | [T] dòng tin kèm | MỘT PHẦN | lời (G003 BR03 hiện hành = 1.000; CR-004 treo) | Từng case | G015 BR01/BR04, G003 BR03 L297 |
| Q-21 | [T] bộ lọc tài khoản | MỘT PHẦN | không | Giảm | G003 UC-08 L205 |
| Q-22 | [T] tài khoản + loại phiên | MỘT PHẦN | không | Từng case (PC/Web) | G023 BR03 L111, G003 BR23 L319 |
| Q-23 | [T] đóng màn/mất mạng khi chờ | VẪN MỞ | không | Từng case | — |
| Q-24 | [N] "cập nhật ngay" BR-C12 | MỘT PHẦN | lời (chỉ dẫn G032 bản (1)) | Từng case | G015 L99, G032 (1) BR14 L148 |
| Q-25 | [N] ngưỡng hiệu năng | VẪN MỞ | không | Không (perf-smoke) | — |
| Q-26 | [M]/[T] mã tham chiếu | MỘT PHẦN | lời (tách phần dẫn chiếu treo sang Q-31) | Không | CR-001 L143, G014, G010 |
| Q-27 | [T] cache vs realtime BR08/09 | VẪN MỞ | không | Từng case | — |
| Q-28 | [T] ranh giới BR10 | MỘT PHẦN | không | Không | G026 UC-06, BR04, BR08 |
| Q-29 | [T] phạm vi nền tảng | MỘT PHẦN | không | Không | G032 (1) BR14 L148 |
| Q-30 | [T] a11y | VẪN MỞ | không | Từng case (a11y) | không spec nào có yêu cầu a11y |

Tổng 30 câu cũ: **0 ĐÃ TRẢ LỜI · 14 MỘT PHẦN · 16 VẪN MỞ · 0 SAI**. Câu mới: **6** (Q-31…Q-36), cả 6 chưa có lời giải. Q-31 viết lại (dẫn chiếu treo); Q-32…Q-36 **nâng mức chắc chắn**: từ "có thể do lệch bản" thành "mâu thuẫn thật với spec hiện hành".

Lý do không có câu nào "đã trả lời" đầy đủ: 7 câu mâu thuẫn nội bộ G033 (Q-05→Q-10, Q-26) nằm ở chính G033, tài liệu khác không có thẩm quyền sửa; các câu còn lại tài liệu gốc chỉ cho nguyên tắc chung/quy ước, không nói riêng cho G033.

### Nhóm 1 — Open Questions của spec chặn kỳ vọng

**Q-01 [B] OQ01 — nguồn QR (chặn build).** L538: "Hub/Zalo có cho lấy mã QR của nhóm không? … Zalo trả ảnh → dùng nguyên (có logo); tự sinh → mã trơn, không logo Zalo" — "Chờ dev — chặn build".
- Vì sao chưa viết được: AC L429 và BR02 có hai kỳ vọng loại trừ nhau (có/không logo). QA không thể assert logo khi chưa biết build theo nhánh nào; cũng không biết tester xác định nguồn QR bằng cách nào.
- Đề xuất QA: dev chốt nhánh trước khi QA viết case; ghi vào spec. Case QR tách 2 biến thể, chỉ chạy biến thể đúng nhánh.
- **Trạng thái: VẪN MỞ — CHẶN.** Đối chiếu: G016 (L19 "mỗi lần bấm Thêm liên kết … sinh một mã QR mới … chiếm một proxy") và G018 (Tên L6 "Cache mã QR và giới hạn tần suất lấy mã") đều nói về **QR liên kết tài khoản Zalo (G001)**, không phải QR nhóm — chính G033 OOS07 L509 và L592 đã tự nói vậy. Grep toàn `tailieu/` (cả html): không có mô tả lấy QR nhóm. **OQ01 chưa có lời giải trong bộ G-spec.**

**Q-02 [B] OQ04 — đủ 3 API tạo·đổi·huỷ hay không.** L541 + §16 L561: "thiếu API nào thì ẩn đúng thao tác đó… hết cả hai thì bỏ luôn `•••`".
- Vì sao: tập UC-04/05/06 và AC L452–L470 có thể không áp dụng trên môi trường test; QA phải biết build/env nào có API nào để không ghi nhầm "ẩn mục" thành lỗi.
- Đề xuất QA: cung cấp ma trận API khả dụng theo môi trường trước Phase 2; case có điều kiện tiên quyết rõ ràng.
- **Trạng thái: VẪN MỞ — CHẶN môi trường.** Đối chiếu: G008 §8/§9 (L342, L348) "N/A — … API contract sẽ được định nghĩa trong tài liệu kỹ thuật riêng"; tài liệu kỹ thuật đó không có trong `tailieu/`.

**Q-03 [B] OQ02 + OQ05 — thành viên thường xem link, trạng thái "link bị tắt".** L539: "Zalo có chặn tài khoản chỉ là thành viên thường xem link nhóm không? Chưa đo."; L542 (OQ05) "chưa đo thì không đặt luật".
- Vì sao: BR04 chỉ nói "rơi vào E03", nhưng với nhóm đã có link, E03 (ba nút disable + Thử lại) và "chưa có link" (BR15) phải phân biệt được. Không có kỳ vọng cho trường hợp "Admin Gopany có quyền nhưng tài khoản Zalo liên kết chỉ là thành viên thường".
- Đề xuất QA: cho phép exploratory trên các vai trò Zalo và ghi kết quả thực vào spec (đây chính là việc "đo" của OQ02/OQ05).
- **Trạng thái: VẪN MỞ.** Đối chiếu: G008 L537 "Trưởng nhóm = người được Zalo giao quyền trưởng nhóm, KHÔNG phải người sở hữu Zalo account kết nối với hệ thống" cho biết tài khoản liên kết có thể không phải trưởng nhóm, nhưng không nói gì về quyền xem link. G026 BR02 L129 chỉ về quyền chỉnh cài đặt. Không tài liệu nào đo. (Chọn bộ vai trò Zalo để đo sau khi Q-33 chốt có "phó nhóm" hay không.)

**Q-04 [B] OQ03 — hạn dùng link.** L540: "Hub trả `expirationDate` nhưng chưa đo giá trị thật. Có hạn thì phải bổ sung cách xử lý khi link hết hạn".
- Vì sao: không có kỳ vọng khi link hết hạn (hiển thị gì, nút nào); BR03 "mỗi lần mở màn vẫn ra đúng link cũ" có thể mâu thuẫn nếu link hết hạn.
- Đề xuất QA: BA/dev đo trước; trong lúc chờ, case hết hạn đánh dấu chặn.
- **Trạng thái: VẪN MỞ.** Không tài liệu nào nhắc hạn dùng link nhóm.

### Nhóm 2 — Mâu thuẫn trong tài liệu

**Q-05 [M] "tin nhắn thường" vs "thẻ xem trước".** BR06 L188: "gửi link vào các hội thoại đó **như một tin nhắn thường**"; UC-02 b4 L72: "**một tin nhắn** gồm dòng chữ kèm và link"; BR14 L195/AC L441: "Tin gửi đi ở dạng THẺ XEM TRƯỚC, **không phải tin chữ thường**".
- Vì sao: hai BR mô tả loại tin gửi đi khác nhau; AC L434 ("như một tin nhắn") và AC L441 (dạng thẻ) cũng lệch. Expected result của UC-02 không xác định.
- Đề xuất QA: lấy BR14 làm chuẩn (cụ thể hơn, có AC riêng) và sửa chữ ở BR06/AC L434; BA xác nhận.
- **Trạng thái: VẪN MỞ — CHẶN UC-02.** Đối chiếu: cụm "như một tin nhắn thường" là nguyên văn G003 BR20 L316 ("Tin nhắn được chuyển tiếp … dưới dạng **tin nhắn thường** — không có label hay định dạng đặc biệt") bị BR06 chép sang khi tái dùng UC-08 → giải thích nguồn mâu thuẫn nhưng **không giải quyết**: BR14 vẫn ghi ngược lại. Thẻ do ai dựng: Q-36.

**Q-06 [M] "một hội thoại" vs "nhiều hội thoại".** Ghi chú cuối L583: "*Chia sẻ link* trên Web = **gửi link vào một hội thoại**"; tiêu đề UC-02 L67 "vào một hội thoại" nhưng b3 L71 "một hoặc nhiều… tối đa 99", AC L435 "Chọn được nhiều hội thoại".
- Vì sao: chưa rõ Web có cho chọn nhiều hay không (BR13 cũng nói đồng nhất).
- Đề xuất QA: coi "nhiều (≤99)" là chuẩn trên mọi nền tảng, sửa chữ ở L583 và tiêu đề UC-02.
- **Trạng thái: MỘT PHẦN.** Đối chiếu: hộp chọn tái dùng định nghĩa **nhiều đích**: G003 UC-08 b3 L210 "Chọn một hoặc nhiều … tối đa 99 hội thoại", BR22 L318, BR27 L323. Kỳ vọng "nhiều ≤ 99" có chỗ dựa; nhưng chữ ở G033 L583 và tiêu đề UC-02 vẫn mâu thuẫn → vẫn cần BA sửa (không đóng).

**Q-07 [M] Phó nhóm có tự động thấy dòng Link nhóm không?** AC L422: "**Phó nhóm** thấy dòng Link nhóm và mở được màn, lấy được link/QR (AC-BR04, G008 BR25)" vs BR04 L186/L591: "Vai trò trên Zalo (trưởng/phó/thành viên) **không phải điều kiện của Gopany**… Đừng trộn".
- Vì sao: AC viết như thể vai trò phó nhóm quyết định hiển thị, trái BR04 (chỉ Admin/"Quản lý nhóm"). Nếu phó nhóm có tài khoản Gopany không có quyền "Quản lý nhóm" thì pass hay fail?
- Đề xuất QA: sửa AC L422 thành "người có quyền Quản lý nhóm đồng thời là phó nhóm trên Zalo…"; E01 case dùng nhân sự không quyền nhưng là phó nhóm trên Zalo để chứng minh vai trò Zalo không ảnh hưởng.
- **Trạng thái: VẪN MỞ — CHẶN (cụm quyền).** Đối chiếu: G008 BR25 mà AC dẫn là **dẫn chiếu treo** (Q-31, §0.1 #2); G026 BR01 L128 / OOS01 L193 nói hệ thống **không có** vai trò phó nhóm (Q-33). Đề xuất "dùng nhân sự là phó nhóm trên Zalo" cần xem lại sau khi Q-33 chốt.

**Q-08 [M]/[T] E06: "Thử lại" ở đâu?** E06 L171: UI chỉ có toast "Lỗi hệ thống. Vui lòng thử lại sau", cột Recovery "Thử lại"; AC L494: "Lỗi hệ thống khi mở màn → toast, **màn giữ nguyên, bấm Thử lại được**". Nút "Thử lại" chỉ được định nghĩa ở E03 (L168).
- Vì sao: "màn giữ nguyên" không rõ khi lỗi xảy ra lúc mở màn (màn chưa mở). Không rõ "Thử lại" là nút hay chỉ là hành động bấm lại lối vào.
- Đề xuất QA: BA nói rõ E06 lúc mở màn = ở lại panel + toast (không có nút), hay mở màn với vùng lỗi giống E03.
- **Trạng thái: VẪN MỞ.** Đối chiếu: G015 E04 L120 cùng chuỗi "Lỗi hệ thống. Vui lòng thử lại sau" chỉ là toast + error log, không có nút → gợi ý quy ước "toast, không nút", nhưng không xác nhận cho G033.

**Q-09 [M]/[T] Màn ở trạng thái E03: `•••` và phân biệt với "chưa có link".** E03 L168: "ba nút thao tác disable"; BR05 L187 và BR15 L196: chưa có link thì không có `•••`/3 nút; không dùng E03.
- Vì sao: không nói `•••` có hiện/enable trong E03 hay không (cho phép Đổi/Huỷ "mù" khi không biết link hiện tại?). Không nói hệ thống phân biệt "Zalo trả về không có link" và "Zalo không trả được link" bằng tiêu chí nào (code/payload từ hub); BA chỉ nói hành vi, không nói điều kiện chuyển.
- Đề xuất QA: cần quy tắc phân loại phản hồi hub → {có link / chưa có link / lỗi} để tạo fault-injection.
- **Trạng thái: VẪN MỞ — CHẶN fault-injection.** Không có tài liệu hub/API nào để đối chiếu.

**Q-10 [M] "100" ghi cứng trong khi BR09 cấm ghi cứng.** AF03 L154: "mức tối đa của loại tài khoản Zalo đang dùng (cá nhân: 100 · Business: cao hơn)" vs BR09 L191/§10C L284 "không ghi cứng… không ghi cứng 100".
- Vì sao: nếu test dùng 100 làm số kỳ vọng thì trái BR09; "Business: cao hơn" không có con số → không dựng được expected.
- Đề xuất QA: expected luôn = `maxMember` từ hub; cần dữ liệu thật của tài khoản Business (xem §5).
- **Trạng thái: VẪN MỞ.** Đối chiếu: G008 BR02 L287 "Tối đa 100 thành viên … Zalo Business có thể vượt 100 (… cần xác nhận con số cụ thể)", lặp ở L540 và E05 L268 (ghi cứng 100) → cùng khoảng trống, chưa có con số Business ở đâu. Không giải quyết được mâu thuẫn nội bộ G033.

### Nhóm 3 — Quyền, bảo mật, tenant, log

**Q-11 [T] Lối vào thứ hai và quyền.** §10A L243/E01 L166 chỉ quy định "Ẩn hoàn toàn dòng Link nhóm trên panel". Nút "Mời qua link" (L242, AF06) không có quy định tương ứng khi người dùng KHÔNG có quyền "Quản lý nhóm" nhưng vẫn vào được màn Thêm thành viên.
- Vì sao: không biết nút ẩn, hay hiện rồi bị chặn, hay mở được màn (rò rỉ link qua đường vòng). Đây là điểm dễ rò rỉ nhất.
- Đề xuất QA: nút "Mời qua link" áp cùng điều kiện BR04; BA xác nhận kèm G008 BR06/BR15.
- **Trạng thái: MỘT PHẦN (rủi ro giảm, chưa đóng).** Đối chiếu spec hiện hành G008: nút "Mời qua link" nằm **bên trong** giao diện Thêm thành viên (L241, L390); nút/giao diện này "Admin + có quyền" (L390), BR05 L290, BR06 L292 "các nút tạo/sửa/thêm thành viên bị ẩn", L361, L114 "(chỉ hiện với người có quyền)", AC L445 "không thấy nút Thêm thành viên". → Người không có quyền **không với tới** lối vào 2 bằng UI, tức cùng điều kiện với BR04. **Còn mở:** (1) G033 không tự nêu điều này (AF06/E01 không phủ lối vào 2) — AC cần ghi; (2) truy cập trực tiếp (API / màn Thêm thành viên mở sẵn rồi quyền bị gỡ) chưa có kỳ vọng (Q-12/Q-13). Case security vẫn phải kiểm "người không quyền gọi thẳng lối vào 2".

**Q-12 [T] Quyền thu hồi khi màn đang mở.** BR04 chỉ nói về lúc hiển thị dòng. Không có kỳ vọng khi quyền "Quản lý nhóm" bị gỡ (hoặc user bị đổi vai trò) trong lúc màn/hộp xác nhận đang mở rồi bấm Sao chép/Đổi/Huỷ.
- Vì sao: E01 L166 chỉ nói "Gọi API thẳng → từ chối" mà không nêu mã trạng thái, thông báo UI, hay hành vi màn đang mở.
- Đề xuất QA: thao tác ghi (tạo/đổi/huỷ) phải bị từ chối ở API kèm thông báo; BA chốt chuỗi/hành vi.
- **Trạng thái: MỘT PHẦN (có quy ước, chưa có kỳ vọng riêng cho G033).** Đối chiếu: G014 BR19 L419: mất quyền giữa chừng → "đóng ngay mọi popup … hủy mọi thao tác … đang chờ kết quả — không thực thi dù yêu cầu đã gửi đi" (dẫn BR-C02, BR-C05 "thu hồi quyền có hiệu lực ngay"); chuỗi từ chối đã dùng: "Bạn không có quyền thực hiện thao tác này" + "Ghi log truy cập trái phép" (G011 E03 L115; G032 (Đổi tên gợi nhớ (1)) E02 L120). G002 AC L228 "bỏ tích 1 nhân sự … + Lưu → nhân sự đó không còn thấy tài khoản Zalo". Có quy ước làm **kỳ vọng đề xuất**, nhưng G033 chưa viết; cần BA xác nhận quy ước áp cho G033. Quyền "Quản lý nhóm" còn phải đi cùng quyền xem hội thoại thuộc tài khoản Zalo được gán (G003 BR02 L296, G011 BR07 L135) — gỡ phân quyền G002 giữa chừng cũng thuộc câu này.

**Q-13 [T] "Gọi API thẳng" — API nào, trả gì.** E01 L166: "Gọi API thẳng → từ chối", Notification: "Ghi log truy cập trái phép"; §8/§9 N/A (L231).
- Vì sao: có đến 4 API (lấy link/QR, tạo, đổi, huỷ) cần test phân quyền nhưng không có endpoint, HTTP status, body lỗi. Bắt buộc cho hard gate `security-test`.
- Đề xuất QA: dev cung cấp danh sách endpoint + status mong đợi (401/403/…); QA test bằng `qa-api-test`.
- **Trạng thái: VẪN MỞ — CHẶN (hard gate security).** Đối chiếu: không G-spec nào có endpoint/mã lỗi cho G033; quy ước: "thuần nghiệp vụ — mã lỗi API … do tài liệu kỹ thuật của dev định nghĩa" (G011a L16; G008 L342/L348). Chỉ `7-send-ma-otp.md`, `8-verify-ma-otp.md` có API doc và là API OTP, không liên quan. Cần tài liệu kỹ thuật của dev.

**Q-14 [T] Cô lập tenant (multi-tenant-isolation).** Spec không nhắc tenant/công ty. Tài liệu `thay-doi-28-29-09.html` §9 và §8 cho thấy một tài khoản Zalo có thể chuyển giữa các "công ty" khác nhau → Gopany đa công ty.
- Vì sao: E01 chỉ phân quyền trong nội bộ; không nói user công ty A gọi API lấy link/đổi/huỷ nhóm của công ty B (hoặc nhóm cùng tài khoản Zalo đã chuyển công ty) có bị chặn không. Tương tự câu OQ-08 của Z-02.
- Đề xuất QA: BA xác nhận có cô lập theo công ty không; nếu có thì bật flag `multi-tenant-isolation` + case rò rỉ chéo công ty.
- **Trạng thái: MỘT PHẦN — premise ĐÚNG, flag đã bật tạm thời.** Đối chiếu: **mô hình đa workspace/công ty được xác nhận và cô lập là yêu cầu bắt buộc ở cấp dự án** — G002 L248–L250; G010 BR02 L156, BR03 L157 (`companyId + zaloUid`), BR09 L163; AC `BR-C01` ở G014 L691, G015 L238, G032 (1) L286; G001/G002 dùng "workspace", html dùng "công ty" (cùng một thứ). **Còn mở:** G033 không có AC cô lập; chưa có định nghĩa gốc `BR-C01`; chưa rõ nhóm của tài khoản Zalo đã chuyển công ty (G010 BR09) thì link/QR do workspace nào xem được. Khuyến nghị BA bổ sung AC `BR-C01` cho G033 như các spec cùng loại.

**Q-15 [T] Log: ở đâu, định dạng, ai kiểm được.** E01 "Ghi log truy cập trái phép"; E03/E04/E06/E07 "Ghi error log"; E08 "Ghi error log **kèm nguyên văn mã lỗi Zalo**" (L173); AC L456 "log ghi nguyên văn mã lỗi Zalo". Không thấy yêu cầu audit khi tạo/đổi/huỷ **thành công**.
- Vì sao: không nêu nơi xem log, trường bắt buộc (user, nhóm, thời điểm, mã lỗi), mức log. QA black-box cần đường kiểm. Link bị đổi/huỷ làm chết link đã phát ra (L410) nhưng không có yêu cầu ghi ai đổi.
- Đề xuất QA: dev cho quyền đọc log ở môi trường test; BA nói rõ có/không audit thao tác thành công.
- **Trạng thái: VẪN MỞ.** Đối chiếu: các spec khác dùng cùng cụm "Ghi log truy cập trái phép" (G011 L115, G032 (1) L120) và "Ghi nhận lỗi hệ thống" (G002 L109–L110) mà **không** nêu nơi xem/trường log. G002 L266 liệt "Lịch sử hành động phân quyền" vào Out of Scope; G002 BR08 L143 "Thu hồi quyền không lưu trữ lịch sử". Hướng chung dự án là **không** làm audit thành công → gợi ý cho G033 nhưng chưa xác nhận.

### Nhóm 4 — Dữ liệu link / QR / clipboard

**Q-16 [T] Định dạng chuỗi link, payload QR, nội dung clipboard.** §10B L274: hiện "dạng `zalo.me/g/…`" (không có scheme); AC L428 "Quét QR → ra đúng link hiển thị bên dưới"; UC-01 b5 "Copy link vào clipboard".
- Vì sao: không biết link/QR/clipboard có tiền tố `https://` hay không, có tham số theo dõi hay không → "đúng" so sánh bằng chuỗi nào. Cũng không nói "cắt giữa bằng `…`" (L274) bắt đầu từ bao nhiêu ký tự.
- Đề xuất QA: chuẩn = chuỗi đầy đủ hub trả về; hiển thị rút gọn có `…`, clipboard/QR luôn đầy đủ.
- **Trạng thái: MỘT PHẦN.** Đối chiếu: G015 BR01 L142 "chỉ chấp nhận `http://` và `https://`. Text gõ trần không có scheme (VD `cand.vn`) **không** tính là link" → chuỗi tin nhắn gửi đi **cần** có scheme thì Gopany mới nhận diện là link (và mới có thể tạo thẻ, Q-36); chuỗi hiển thị `zalo.me/g/…` không scheme chỉ là cách trình bày. **Còn mở:** hub trả chuỗi có scheme hay không; ngưỡng cắt `…`.

**Q-17 [T] Lưu mã QR — kết quả thành công, tên file, kích thước, quyền thư viện.** UC-03 L79, BR07 L189: tên `QR - {tên nhóm}.png`; chỉ có toast lỗi E07 (L172), không có thông báo thành công; BR13 (L194) nói điện thoại lưu vào thư viện ảnh.
- Vì sao: không có kỳ vọng với (a) tên nhóm chứa ký tự không hợp lệ cho tên file (`/ \ : * ? " < > |`), emoji, tên rất dài; (b) trùng tên file nhiều lần; (c) kích thước/độ phân giải PNG, QR còn quét được không; (d) từ chối quyền thư viện ảnh trên điện thoại; (e) có toast thành công không.
- Đề xuất QA: BA chốt quy tắc làm sạch tên file + độ phân giải tối thiểu + (d) → E07.
- **Trạng thái: VẪN MỞ.** Grep `tailieu/` (tên file, ký tự không hợp lệ, thư viện ảnh): không spec nào quy định.

**Q-18 [N] Rút gọn tên nhóm / avatar mặc định.** §10B L271: "tên dài thì cắt bằng `…`"; "Avatar … lấy từ thông tin nhóm". `thay-doi-28-29-09.html` §3 (L157): "Nhóm chưa có ảnh hiện chữ cái đầu của tên nhóm (tên có emoji hoặc dấu cũng hiện đúng)".
- Vì sao: không có ngưỡng ký tự/độ rộng; không nói avatar fallback áp cho màn G033 và thẻ xem trước (§10D) hay không.
- Đề xuất QA: dùng cùng hành vi fallback đã ship; BA xác nhận và cho ngưỡng cắt.
- **Trạng thái: MỘT PHẦN.** Đối chiếu: G008 BR03 L288 tên nhóm tối đa **100 ký tự** → cận trên dữ liệu test. Ngưỡng cắt hiển thị và việc fallback có áp cho thẻ chia sẻ vẫn chưa có.

### Nhóm 5 — Chia sẻ link

**Q-19 [T] Gửi nhiều hội thoại — thất bại một phần, toast, thời điểm.** UC-02 b4 L72: toast "Đã gửi link nhóm", ngoại lệ chỉ [→ E05, E06]; AC L434–L443. Doc `thay-doi-28-29-09.html` §6 nói chuyển tiếp "xác nhận đã gửi ngay cho từng nơi nhận".
- Vì sao: chưa có kỳ vọng khi trong N hội thoại có hội thoại gửi lỗi (bị chặn nhắn tin, rời nhóm, Zalo lỗi): toast gì, gửi lại thế nào, có gửi trùng không. Toast "Đã gửi" xuất hiện sau khi xác nhận hay ngay khi bấm?
- Đề xuất QA: dùng kết quả từng nơi nhận như chuyển tiếp G003; BA chốt chuỗi cho lỗi một phần.
- **Trạng thái: MỘT PHẦN.** Đối chiếu: G003 E09 L273 "Chuyển tiếp tin nhắn thất bại (lỗi Zalo API hoặc mất kết nối) → Toast: 'Không thể chuyển tiếp, vui lòng thử lại'; popup giữ nguyên để user thử lại"; BR22 L318 "gửi song song đến từng đích". G033 UC-02 **không dẫn E09** (chỉ E05/E06). **Còn mở:** E09 là lỗi toàn bộ, không nói lỗi từng đích; "Lỗi gửi + Retry riêng" (G003 L572, BR03c L299) là của tin dài tách nhiều phần, không phải nhiều đích.

**Q-20 [T] Dòng tin nhắn kèm — giới hạn và trường hợp đặc biệt.** BR14 L195, §10D L319: "mặc định 'Truy cập link để tham gia nhóm', sửa được; xoá trắng → gửi chỉ link"; "dòng chữ không chứa link thì Zalo tự nối link vào cuối".
- Vì sao: không có độ dài tối đa; không nói khi dòng chữ đã chứa link nhóm này / link khác / xuống dòng / emoji thì gửi thế nào (nối thêm link hay không); không nói "chỉ khoảng trắng" tính là xoá trắng không. Cũng không nói có loại chính nhóm đang mở khỏi danh sách chọn không (mockup §10D L298–L305 không thấy).
- Đề xuất QA: BA cho giới hạn độ dài + quy tắc nối link; "chỉ khoảng trắng" = xoá trắng.
- **Trạng thái: MỘT PHẦN.** Đối chiếu: **độ dài** — G003 BR03 L297 hiện hành: ô soạn tin không giới hạn độ dài, không chặn gửi, tự tách tin ở mốc **1.000** ký tự (BR03b L298, BR03c L299); CR-004 (L6, L40) đòi nâng lên 2.000 nhưng G003 hiện hành chưa sửa (dẫn chiếu treo §0.1 #11). Chưa rõ dòng kèm của G033 có đi theo luật tách này không. **Link khác trong dòng chữ** — G015 BR04 L146 "Nhiều link trong 1 tin → chỉ preview link **đầu tiên**" (ảnh hưởng thẻ, Q-36). Không loại nhóm nguồn khỏi danh sách: G003 BR25 L321 chỉ loại nhóm đã rời/bị xoá. **Còn mở:** "chỉ khoảng trắng", quy tắc nối link, emoji, trùng link, mốc tách 1.000 hay 2.000.

**Q-21 [T] Bộ lọc tài khoản Zalo trong màn chia sẻ.** BR06 L188 + AC L437–L438: "Bộ lọc tài khoản Zalo mặc định = tài khoản đang quản lý nhóm… đổi được". Mockup §10D (L291–L310) **không có** bộ lọc này.
- Vì sao: không có vị trí/hình thức UI để assert; không có kỳ vọng khi tài khoản được chọn DISCONNECTED hoặc không phải thành viên nhóm, hay khi chỉ có một tài khoản.
- Đề xuất QA: BA bổ sung mockup; "link gửi từ tài khoản nào cũng dùng được" cần người nhận thực để xác minh (xem §5).
- **Trạng thái: MỘT PHẦN.** Đối chiếu: G003 UC-08 b2 L205 định nghĩa filter tài khoản Zalo (single select, mặc định = tài khoản Zalo của hội thoại nguồn, chỉ hiện tài khoản user có quyền xem); BR23 L319 "chỉ forward vào hội thoại thuộc tài khoản Zalo đang chọn (không forward cross-account)". Hành vi lọc **đã có spec gốc**; thiếu là mockup §10D của G033 chưa vẽ và tài khoản được chọn DISCONNECTED/không phải thành viên nhóm. "Mặc định = tài khoản đang quản lý nhóm" khớp "tài khoản của hội thoại nguồn" (G023 BR03 L111 "mỗi hội thoại thuộc 1 tài khoản Zalo").

### Nhóm 6 — Thao tác ghi, thời gian, đồng thời

**Q-22 [T] Tài khoản Zalo nào thực hiện lấy/tạo/đổi/huỷ, và loại phiên.** Pre-condition L49: "Tài khoản Zalo của nhóm đang CONNECTED"; BR06 nhắc "tài khoản đang quản lý nhóm đó". `luong-dong-bo-gopany.html` L145, L215 phân biệt phiên **Zalo PC** và **Zalo Web** (chỉ Zalo PC đồng bộ được).
- Vì sao: một nhóm có thể có nhiều tài khoản Zalo liên kết; không rõ chọn tài khoản nào để gọi hub, và nếu một tài khoản CONNECTED nhưng khác tài khoản đang là trưởng/phó nhóm thì kết quả là E08 hay chọn tài khoản khác. Cũng chưa rõ tài khoản phiên Zalo Web có dùng được các API link không.
- Đề xuất QA: BA/dev nêu quy tắc chọn tài khoản + phiên được hỗ trợ.
- **Trạng thái: MỘT PHẦN.** Đối chiếu — **phần "tài khoản nào" được trả lời bởi mô hình dữ liệu:** mỗi hội thoại thuộc đúng 1 tài khoản Zalo (G023 BR03 L111; G003 BR23 L319 "Mỗi Zalo account là 1 kênh độc lập"; G011a BR08 L119). Cùng một nhóm Zalo mà 2 tài khoản liên kết cùng tham gia = 2 hội thoại; thao tác link đi qua **tài khoản của hội thoại đang mở**. Người dùng chỉ thấy hội thoại của tài khoản được gán (G002 matrix L147–L154, G003 BR02/BR11). G008 L537: tài khoản liên kết không nhất thiết là trưởng nhóm → E08 là kết quả hợp lệ khi tài khoản đó không đủ quyền trên Zalo. **Còn mở:** phiên **Zalo PC vs Zalo Web** — G001/G002/G008 **không nhắc**; chỉ `luong-dong-bo-gopany.html` (về đồng bộ lịch sử, không phải API link) → chưa biết API link có chạy được trên phiên Web không. Cần dev/hub trả lời.

**Q-23 [T] Đóng màn / mất mạng / timeout trong lúc "chờ Zalo".** UC-04 b3, UC-05 b4, UC-06 b4: "chờ Zalo xác nhận"; §10F L358 "Nút … không bấm được lần hai"; E05 L170: "Mất mạng (mọi bước) … giữ nguyên màn". §15 chỉ có ngưỡng khi mở màn.
- Vì sao: không có timeout cho tạo/đổi/huỷ; nếu người dùng bấm ✕/Esc/click nền (Web), hoặc mất mạng sau khi request đã gửi, kết quả thật trên Zalo có thể đã đổi nhưng UI "giữ nguyên" → trạng thái hiển thị sai (link cũ vẫn hiện trong khi đã chết). Không có kỳ vọng.
- Đề xuất QA: BA chốt: có cho đóng khi đang chờ không; sau lỗi mạng màn phải tải lại trạng thái từ Zalo.
- **Trạng thái: VẪN MỞ.** Không spec nào quy định timeout/đóng khi đang ghi lên Zalo (G014 BR19 chỉ cho trường hợp mất quyền).

**Q-24 [N] "Cập nhật ngay" (BR-C12) và đồng thời nhiều người.** L223 + AC L470: "Trạng thái đổi trên app Zalo trong lúc màn đang mở → màn cập nhật **ngay**, không cần tải lại (BR-C12)". BR-C12 không có trong tài liệu này.
- Vì sao: không có ngưỡng thời gian, cơ chế (push/poll) hay phạm vi (chỉ link, hay cả BR08/BR09?). Không có kỳ vọng khi hai nhân sự Gopany cùng mở màn: A đổi link, màn của B vẫn giữ link cũ; B bấm Sao chép/Đổi/Huỷ trên dữ liệu cũ thì sao.
- Đề xuất QA: ngưỡng ví dụ ≤ N giây do BA/dev chọn; test đồng thời 2 phiên.
- **Trạng thái: MỘT PHẦN.** Đối chiếu — **nghĩa BR-C12 suy ra:** realtime broadcast tới mọi client/phiên đang mở (G015 UC-03 b4 L99 "Broadcast realtime tới mọi phiên đang mở hội thoại (BR-C12)"; G032 (Đổi tên gợi nhớ (1)) BR14 L148 "cập nhật realtime mọi client (BR-C12); hai người cùng đổi thì lần lưu sau thắng"). Ghi đồng thời "lần lưu cuối thắng": G002 AC L255. Trái chiều: G011a BR12 L123 chọn **không realtime** cho ghi chú → BR-C12 không phải luật tuyệt đối. **Còn mở:** ngưỡng thời gian; cơ chế thay đổi **từ app Zalo** (cần hub phát sự kiện, không tài liệu nào nói hub có phát sự kiện đổi link); kỳ vọng khi dữ liệu cũ.

**Q-25 [N] Ngưỡng hiệu năng §15: điều kiện đo và trạng thái giữa chừng.** L550–L553: "Hiện trong ≤ 2 giây; quá 10 giây không lấy được link → coi là lỗi, bắn E03"; "Tải ảnh QR ≤ 3 giây"; "Hộp chọn hội thoại ≤ 1 giây"; "Mã QR: Sinh/lấy một lần khi mở màn, không sinh lại mỗi lần bấm nút".
- Vì sao: không nêu điều kiện đo (mạng, tải, p50/p95), đo từ lúc nào; trong khoảng 2–10 giây màn hiện gì (loading? trống?); "sinh một lần" không quan sát được black-box ngoài việc xem log/network.
- Đề xuất QA: BA cho điều kiện đo + giao diện loading; perf-smoke chỉ kiểm ngưỡng thô.
- **Trạng thái: VẪN MỞ.** (G015 có "skeleton loading tối đa 3s" L194 nhưng là tính năng khác.)

### Nhóm 7 — Dữ liệu nhóm, luồng người nhận, phạm vi

**Q-26 [M]/[T] Mã tham chiếu không có/đánh số thiếu.** BR12 không tồn tại (BR11 → BR13, L193–L194); AF04 không tồn tại (AF03 → AF05, L154–L155); các mã BR-C06, BR-C07, BR-C12 được dẫn chiếu (L166, L193, L223) nhưng **không được định nghĩa** trong tài liệu; UC-01 bước 3 L61 ghi "[→ AF05]" nhưng AF05 là "chưa có link" — nội dung bước đó là AF02/AF03 (đánh sai tham chiếu).
- Vì sao: không rõ BR12/AF04 bị xoá có chủ ý hay thiếu nội dung; BR-C* nằm ở tài liệu chung nào.
- Đề xuất QA: BA xác nhận BR12/AF04 và cung cấp định nghĩa gốc BR-C*. (Phần dẫn chiếu tới G008 BR25/BR15 v1.9 và G011 BR02b nay tách sang Q-31.)
- **Trạng thái: MỘT PHẦN.** BR-C* là "BR dùng chung (`PROJECT_KNOWLEDGE §5`)" (CR-001 L143) — tài liệu này **không có** trong `tailieu/`/repo. Nghĩa **suy ra từ chỗ dùng** (không phải định nghĩa gốc):

| Mã | Nghĩa suy ra | Chỗ dùng |
|---|---|---|
| BR-C01 | Cô lập dữ liệu theo workspace | G014 L691, G015 L238, G032 (1) L286 "(AC-BR-C01)"; G002 L248–L250 (không dùng mã) |
| BR-C02 | Phân quyền theo tài khoản Zalo; mất quyền → hội thoại ẩn ngay | CR-001 L143; G014 L353, L419 |
| BR-C05 | Thu hồi quyền có hiệu lực ngay | G014 BR19 L419 |
| **BR-C06** | **Quyền → ẩn control; điều kiện runtime (ngắt kết nối, đầy 3 tin…) → báo khi thao tác, không ẩn** | CR-001 L143 "(ẩn / disable / toast)"; G014 BR05 L405; G032 (1) E02 L120; G003 L668; G011 BR10 L138 |
| **BR-C07** | **DISCONNECTED chỉ khoá thao tác outbound/live-read Zalo, dữ liệu vẫn hiển thị** | G014 BR10 L410; G010 BR04 L158; G015 L47 |
| **BR-C12** | **Realtime broadcast mọi client; ghi đồng thời lần lưu sau thắng** | G015 L99; G032 (1) BR14 L148 |

→ Cách G033 dùng BR-C06 (E01 ẩn do quyền; E02 toast do DISCONNECTED) và BR-C07 (BR11) **nhất quán** với các spec khác. **Còn mở:** BR12/AF04 thiếu và AF05 dẫn sai là lỗi nội bộ G033; cần định nghĩa gốc BR-C*.

**Q-27 [T] Nguồn dữ liệu cho BR08/BR09 (cache hay realtime).** BR09 L191: "lấy theo giá trị Zalo trả về cho từng nhóm (`maxMember`)". `thay-doi-28-29-09.html` §3 L155: "Nhóm đã từng mở hiện thành viên và cài đặt ngay, dữ liệu tự làm mới phía sau".
- Vì sao: dữ liệu nhóm (số thành viên, cài đặt duyệt) có thể đang lấy từ cache; dòng nhắc BR08/BR09 có thể sai tạm thời hoặc nhấp nháy khi mở màn. Không nêu: nếu Zalo không trả `maxMember` thì ẩn cảnh báo hay hiển thị gì; "đủ" được tính từ số thành viên nào.
- Đề xuất QA: BA chốt nguồn + hành vi khi thiếu `maxMember`; case: thêm/xoá thành viên và đổi cài đặt duyệt trên app Zalo rồi mở màn.
- **Trạng thái: VẪN MỞ.** G026 chỉ nói Gopany "đẩy toggle" (BR03 L130, "KHÔNG tự gate"), không nêu nguồn đọc/cache.

**Q-28 [T] Ranh giới kiểm thử luồng người nhận (BR10).** AC L480–L484 liệt kê hành vi do app Zalo dựng (màn xem trước với avatar · tên · số thành viên · "Nhóm của {chủ nhóm}" · "Đã tạo … trước" · bạn chung) nhưng BR10 L192/OOS03/AC L483 nói Gopany "không định nghĩa lại và không can thiệp". Thêm: AC L464 "bấm link cũ không vào được nhóm" không nêu người dùng thấy gì.
- Vì sao: các AC này là điều kiện pass/fail của G033 hay chỉ quan sát? Nếu fail do Zalo thay đổi UI thì tính lỗi cho ai? Không có thông báo/màn kỳ vọng khi link cũ/đã huỷ được bấm (do Zalo).
- Đề xuất QA: coi chỉ 2 điều cần kiểm: (1) không vào thẳng nhóm; (2) sau Tham gia đúng luồng G026. Các chi tiết màn Zalo = quan sát, không gate; link cũ chết = nhóm không có thêm người.
- **Trạng thái: MỘT PHẦN.** Đối chiếu: điều (2) **đã có spec gốc** — G026 UC-06 L88–L95, BR04 L131, BR08 L132, AC L179–L181: duyệt BẬT → CHỜ DUYỆT, chỉ trưởng nhóm Duyệt/Từ chối; TẮT → vào thẳng (G026 chỉ nhắc "qua link", chưa nêu QR). Phần ranh giới gate/quan sát và kỳ vọng khi bấm link chết vẫn do BA quyết.

**Q-29 [T] Phạm vi nền tảng.** BR13 L194 yêu cầu Web·Android·iOS; §10E L326 Web popup "~420px" (không dung sai; không nêu hành vi ở viewport hẹp).
- Vì sao: không rõ build Android/iOS có trong phạm vi QA đợt này không; "~420px" không đo được; không có mockup riêng cho cảnh báo dòng nhắc trên mobile.
- Đề xuất QA: xác nhận nền tảng trong scope + trình duyệt hỗ trợ; dung sai 420px ±N.
- **Trạng thái: MỘT PHẦN.** Đối chiếu: có mobile ở các tính năng chat gần đây — G032 (Đổi tên gợi nhớ (1)) BR14 L148, G027 (Thông báo đẩy Web & Mobile); G001/G002 là desktop only (G002 L194). Nền tảng nhiều thiết bị là quy ước thật; **QA đợt này có test Android/iOS không và dung sai 420px** vẫn do BA/PM quyết.

**Q-30 [T] Accessibility.** Spec không có yêu cầu a11y nào (không nêu nhãn cho nút icon, thứ tự focus, focus trap trong popup Web, mô tả cho mã QR, đọc toast bởi screen reader, độ tương phản màu "nhấn" của link L274). Lane high-risk bắt buộc có a11y.
- Vì sao: không có tiêu chí chuẩn (WCAG A/AA?) để làm kỳ vọng.
- Đề xuất QA: BA chọn baseline (đề xuất WCAG 2.1 AA cho popup + hộp xác nhận); a11y chạy bằng axe.
- **Trạng thái: VẪN MỞ.** Grep `a11y|WCAG|accessib|screen reader|trợ năng` toàn `tailieu/`: không G-spec nào có yêu cầu a11y.

---

### Nhóm 8 — Câu hỏi MỚI từ đối chiếu spec hiện hành (Q-31 → Q-36)

> Vì `tailieu/` là spec hiện hành duy nhất, Q-32…Q-36 là **mâu thuẫn thật** (mức chắc chắn CAO). Mỗi câu có cột "dòng spec phải sửa nếu G033 đúng" → §6.1.

**Q-31 [M]/[T] Dẫn chiếu treo: G033 dựa vào G008 BR25, G008 BR15 v1.9, G011 BR02b nhưng các BR đó không tồn tại trong spec hiện hành.**
- Trích G033: "**G008 BR15 v1.9**" (L38, L156, L530, L563, L579) — nút *Mời qua link* nay mở màn G033; "**G008 BR25** — Zalo chỉ cho trưởng/phó đổi cài đặt nhóm, không nằm trong ba đặc quyền riêng của trưởng nhóm" (L197, L422, L457, L520); "**G011 BR02b**" (L183, L522); "G008 §10C … nay trỏ sang G033" (L38, L241).
- Trích spec hiện hành (chi tiết từng dòng: §0.1 #1–#4): `G008 - Quản lý nhóm.md` v1.1 (L11) chỉ có BR01–BR22 (L307), BR15 L300 / AF01 L242 / AC L455 = "copy vào clipboard"; §10C L395 không trỏ G033; changelog chỉ v1.0–v1.1 (L518–L520). `G011 - Panel Thông tin.md` BR01–BR10 (L129–L138), không BR02b.
- Vì sao chưa viết được kỳ vọng: không rõ **G008/G011 sẽ được sửa** (G033 là bản mới) hay **G033 dẫn sai**. Cụ thể: (a) E08, BR16 và AC L422 dựa vào nội dung BR25 mà không ai viết ra; (b) hành vi "Mời qua link" mới (mở màn) mâu thuẫn trực tiếp AC G008 L455 hiện hành — nếu G033 được áp dụng, AC G008 L455 sai (§6.1); (c) dòng "Link nhóm" nằm ở đâu trên panel (Q-35).
- Đề xuất cho BA: (1) xác nhận G008 và G011 **có được sửa** theo G033 không; (2) nếu có: cung cấp **nội dung** BR25, BR15 mới (nội dung "v1.9") và BR02b, hoặc cho phép QA dùng danh sách §6.1 làm đề xuất sửa; (3) nếu G033 dẫn sai: sửa các dòng dẫn chiếu ở §0.1. QA tạm coi **G033 là ý định mới** và G008 hiện hành là hành vi cũ cần cập nhật; case regression "Mời qua link" gắn ❓ cho tới khi BA xác nhận.

**Q-32 [M] G008 nói mọi nhóm "có link sẵn, hệ thống tự tạo" — G033 nói có nhóm chưa có link và hệ thống không tự tạo.**
- Trích G008 hiện hành: AF01 L242 "Lấy link nhóm (hệ thống tự tạo link có sẵn cho mỗi nhóm) → copy vào clipboard"; BR15 L300 "hệ thống **tự tạo link nhóm** có sẵn (không tạo mới mỗi lần)". Trích G033: BR03 L185 "Hệ thống **không tự tạo, không tự đổi, không tự huỷ** link"; BR15 L196 "Nhóm **chưa có link mời** … trạng thái bình thường của nhóm"; §16 L562 "nhóm **chưa có link** thì hệ thống **không tạo hộ**"; G033 còn gọi G008 BR15 là "nguồn link" (L23, L520).
- Vì sao chưa viết được kỳ vọng: nếu G008 BR15 đúng, nhóm không bao giờ "chưa có link" → UC-04, §10F, BR15–BR16 không thể xảy ra; hoặc nút "Mời qua link" cũ **tự tạo link** khi bấm (trái BR03). Test "nhóm chưa có link" cần biết trạng thái này tồn tại thật, và nhóm mới tạo qua G008 UC-02 ở trạng thái link nào.
- Đề xuất: BA chốt G033 đúng và sửa G008 L242/L300 (§6.1 #1–#2), nêu cách có nhóm chưa có link trong dữ liệu thật (tạo nhóm mới? sau Huỷ link?).

**Q-33 [M] Vai trò "phó nhóm": G026 nói hệ thống không có; G033 và G008 vẫn dựa vào.**
- Trích G026 hiện hành: BR01 L128 "Làm giống Zalo, chỉ khác: **KHÔNG có 'phó nhóm'** … Hệ thống không có vai trò phó nhóm (G008 v1.3)"; OOS01 L193; AC L175 "không có 'phó nhóm' ở đâu". Trích G008 hiện hành: **vẫn dùng phó nhóm** — L25, L26, L43, L129–L141 (UC-04), BR05b L291 "trưởng nhóm **hoặc phó nhóm**", §10C L385–L386, AC L423–L424. Trích G033: E08 L173 "không phải trưởng nhóm hoặc phó nhóm trên Zalo"; BR16 L197; AC L422 "**Phó nhóm** thấy dòng Link nhóm…"; §13 L520.
- Vì sao chưa viết được kỳ vọng: không biết tài khoản Zalo liên kết là **phó nhóm thật** thì Tạo/Đổi/Huỷ thành công hay không hợp lệ; bộ vai trò Zalo ở test data (§5) và case E08 "không phải trưởng/phó" phụ thuộc. Ngoài ra **G026 và G008 đang mâu thuẫn nhau** (G026 dẫn "G008 v1.3" không tồn tại): G026 L82/L134 nói G008 đã chốt "chỉ trưởng nhóm", G008 BR05b L291 nói "trưởng hoặc phó". Q-07 và E08 chia sẻ gốc này.
- Đề xuất: BA thống nhất thuật ngữ cho cả ba spec; G033 chỉ dùng "trưởng nhóm" như G026, hoặc nêu "phó nhóm" chỉ là mô tả hành vi Zalo (Zalo quyết, Gopany không gate). Dòng phải sửa: §6.1 #9–#10.

**Q-34 [M] Cùng loại thao tác ghi cấp nhóm lên Zalo: G008/G011/G026 gate theo vai trò ngay ở Gopany, G033 cố ý không gate.**
- Trích G008: BR05b L291 "yêu cầu thêm điều kiện: … trưởng nhóm hoặc phó nhóm … **hệ thống fix cứng điều kiện này để tránh lỗi**". G011: BR08 L136 "Đổi tên nhóm — chỉ trưởng nhóm (G008)"; L200 "nhân sự không phải trưởng nhóm → Ẩn/không cho dùng". G026: BR02 L129 "Chỉ trưởng nhóm được thay đổi cài đặt nhóm", E01 L112 toast "Chỉ trưởng nhóm mới thay đổi được cài đặt này". Trích G033: BR04 L186, BR16 L197 "Gopany **không thêm điều kiện vai trò Zalo** … thành viên thường bấm sẽ bị Zalo từ chối → E08"; L589.
- Vì sao chưa viết được kỳ vọng: nhân sự có quyền "Quản lý nhóm" nhưng tài khoản Zalo không đủ vai trò bấm Tạo ngay/Đổi/Huỷ: (quy ước G008/G011/G026) control ẩn/disable/toast ngay ở Gopany, hay (G033) cho bấm rồi chờ Zalo từ chối E08 + error log + mã lỗi Zalo? Hai quy ước cho kết quả quan sát khác nhau trên cùng lớp thao tác.
- Đề xuất: BA xác nhận G033 là ngoại lệ có chủ ý (lý do: OQ02 "chưa đo" L539) và ghi rõ trong G033/G026; nếu muốn đồng bộ thì sửa G033 BR04/BR16. Case E08 theo G033 nhưng gắn ❓.

**Q-35 [M] Dòng "Link nhóm" nằm ở đâu trên panel: G011 cấm nút thao tác và không có BR02b; G008 §10C đã liệt kê dòng đó.**
- Trích G033: §10A L241 "Dòng **Link nhóm** | Trên panel thông tin nhóm (**G008 §10C**)"; BR01 L183 / §13 L522 "G011 BR02b — G033 tự khai dòng Link nhóm trong **nhóm dòng chức năng**". Trích G011 hiện hành: BR02 L130 "Panel gồm 2 tab: `Thông tin` | `Ghi chú`"; **BR03 L131 "Tab Thông tin thuần thông tin: header + Nhắc hẹn · Ảnh/Video · Tài liệu · Liên kết. Không đặt nút thao tác (Ghim / Tắt thông báo / Tạo nhóm / Rời nhóm / Chặn / Ẩn trò chuyện) — … ở menu hội thoại panel trái (G003 §10B)"**; L29 cùng ý; không có BR02b. Trích G008 hiện hành: §10C L381–L399 liệt kê trong panel nhóm: Thêm thành viên (L390), **Link nhóm (L395)**, Rời nhóm (L398), Giải tán nhóm (L399)… → **G008 §10C và G011 BR03 đã mâu thuẫn nhau** (G008 cũ hơn: 2026-06-26 so với 2026-08-04).
- Vì sao chưa viết được kỳ vọng: không xác định lối vào 1 ở tab/khu nào; nếu BR03 G011 còn hiệu lực thì không có chỗ cho dòng "Link nhóm"; regression bố cục panel (G011) và case "ẩn hoàn toàn dòng khi không quyền" cần vị trí để assert.
- Đề xuất: BA chốt nguồn bố cục panel nhóm (G011 hay G008 §10C), sửa G011 BR03 + thêm BR02b hoặc sửa G033; cung cấp mockup panel nhóm có dòng Link nhóm. Dòng phải sửa: §6.1 #5–#7, #11.

**Q-36 [M] Thẻ xem trước khi chia sẻ link: "tin gửi đi dạng THẺ" (G033) vs cơ chế thẻ link của G015 (crawl Open Graph, được phép rơi về text thường).**
- Trích G033: BR14 L195 "Tin gửi đi ở dạng THẺ XEM TRƯỚC, **không phải tin chữ thường**" với thẻ gồm "avatar + tên nhóm + link"; AC L441. Trích G015 hiện hành: BR01 L142 "chỉ chấp nhận `http://` và `https://`"; BR02 L143 thẻ lấy từ Open Graph, "không có gì thì không preview"; BR04 L146 "chỉ preview link **đầu tiên**"; BR06 L148 timeout crawl **3 giây**, "không chặn gửi tin"; E01 L117 "Crawl timeout … → Không hiện card; **tin vẫn gửi như text thường**". G003 BR20 L316 tin chuyển tiếp là "tin nhắn thường".
- Vì sao chưa viết được kỳ vọng: không biết thẻ do **ai** tạo — (i) Gopany crawl OG của `zalo.me/g/…` theo G015 (thẻ mang thumbnail/tiêu đề/mô tả/tên miền theo G015 BR03/BR03b, không phải "avatar + tên nhóm"; có thể thất bại → text thường, trái "không phải tin chữ thường"; chuỗi không scheme thì không tạo thẻ) hay (ii) hub gửi tin loại thẻ riêng (cần API). Mỗi nhánh cho kỳ vọng quan sát khác nhau. Liên quan Q-05, Q-16, Q-20.
- Đề xuất: BA/dev chốt nhánh; nếu (i) thì thêm ngoại lệ/BR vào G015 (hoặc G033 ghi tuân G015 và cho phép fallback); nếu (ii) thì G003 phải thêm loại tin thẻ (BR20 hiện nói tin thường). Case thẻ gắn ❓. Dòng phải sửa: §6.1 #12–#13.

---

## 5. Điều kiện dữ liệu & môi trường

| Hạng mục | Cần có | Lý do / liên quan |
|---|---|---|
| Nhóm có link / chưa có link | ≥ 1 nhóm mỗi loại; nhóm chưa có link phải reset được sau khi Huỷ; biết nhóm mới tạo qua G008 ở trạng thái nào | UC-04/06, BR15, Q-32 |
| Vai trò Gopany | Admin · nhân sự "Quản lý nhóm" · nhân sự KHÔNG quyền | BR04, E01, Q-07, Q-11 |
| Phân quyền tài khoản Zalo (G002) | nhân sự "Quản lý nhóm" **được gán** tài khoản của nhóm / **không được gán** (không thấy hội thoại) | G003 BR02, G011 BR07, Q-12 |
| Vai trò Zalo của tài khoản liên kết | trưởng nhóm · thành viên thường; phó nhóm **chỉ khi Q-33 xác nhận còn dùng** | BR16/17, E08, Q-03, Q-33 |
| 2 workspace/công ty độc lập | mỗi bên ≥ 1 nhóm có link; user của A thử gọi nhóm của B (UI + API) | Q-14, flag `multi-tenant-isolation` |
| Nhóm bật/tắt duyệt thành viên (G026) | cả hai | BR08, BR10 |
| Nhóm đã đủ thành viên tối đa | 1 nhóm cá nhân + 1 nhóm Business (cần số `maxMember` thực) | BR09, Q-10 |
| Nhóm "chỉ trưởng nhóm được nhắn tin" | ≥ 1 | BR06/G003 BR21 |
| ≥ 100 hội thoại hợp lệ để chọn | để chạm trần 99; kèm nhóm đã rời (không được là điểm đến, G003 BR25) | G003 BR27 |
| Tên nhóm đặc biệt | dài (≤ 100 ký tự, G008 BR03); emoji; ký tự cấm tên file; trùng tên; nhóm không ảnh | BR07, Q-17, Q-18 |
| Tài khoản Zalo DISCONNECTED | 1 tài khoản | E02 |
| Phiên Zalo PC và Zalo Web | cả hai loại | Q-22 |
| Tài khoản Zalo thứ hai + điện thoại có app Zalo | quét QR/bấm link, bấm Tham gia | BR10, AC L428, L480–L484 |
| 2 phiên Gopany cùng lúc | kiểm đồng bộ/đồng thời (BR-C12) | Q-24 |
| Công cụ gây lỗi | ngắt mạng; giả lập hub trả lỗi/timeout/500, hub không trả link/QR; Zalo từ chối | E03, E05, E06, E07, E08 |
| Quyền đọc log | nơi xem log truy cập trái phép + error log kèm mã lỗi Zalo | Q-15 |
| Trình duyệt Web + Android + iOS (nếu trong scope) | clipboard, tải file, thư viện ảnh | BR13, Q-29 |
| Nhánh QR của build | biết build đang dùng QR của Zalo hay tự sinh | Q-01 |
| Ma trận API hub khả dụng theo môi trường | tạo/đổi/huỷ/QR | Q-02 |
| **Spec hiện hành cần BA cập nhật trước khi test regression** | G008 (BR15, AF01, AC L455–L456, §10C, §13, phó nhóm), G011 (BR02b/BR03), G026↔G008 (phó nhóm, BR05b), G003 (BR21 chữ), có thể G015/G003 (thẻ link) — danh sách dòng ở §6.1 | Q-31…Q-36 |

**Cảnh báo dữ liệu:** các thao tác Đổi/Huỷ làm chết link thật đã phát đi (L410) → dùng nhóm test riêng, không dùng nhóm thật của khách. Nhóm test phải tách biệt với dữ liệu tab Nhóm đang chạy cache (xem Q-27).

---

## 6. Chỗ đụng tới tính năng đã ship (regression) — theo BR gốc hiện hành

> Số phiên bản = bản duy nhất trong `tailieu/`. Spec bị G033 làm đổi hành vi phải được BA cập nhật; regression test dùng **hành vi mới theo G033** làm kỳ vọng sau khi BA xác nhận (Q-31).

| Tính năng đã ship | BR/AC gốc bị chạm | Điểm chạm | Rủi ro / Oracle |
|---|---|---|---|
| **G008 Quản lý nhóm** (v1.1) | **BR15 L300 / AF01 L238–L244 / AC L455**: "Mời qua link → copy clipboard → toast Đã copy link nhóm" | **Breaking change (G033 L563):** nút mở màn G033, thêm 1 lần bấm "Sao chép link"; đóng màn về Thêm thành viên (AF06/AF08) | **AC G008 L455 sẽ SAI nếu G033 áp dụng.** Chuỗi toast "Đã copy link nhóm" giữ nguyên (G033 UC-01 b5). Case regression cũ phải thay. Chờ BA xác nhận (Q-31) |
| **G008** BR05 L290, BR06 L292, §10C L390/L395, AC L444–L445 | Quyền Admin + "Quản lý nhóm"; ẩn Thêm thành viên với người không quyền; dòng "Link nhóm" đã có ở §10C | Điều kiện BR04 = G008 BR05/06; lối vào 2 hưởng cùng điều kiện (Q-11) | Regression ẩn/hiện nút Thêm thành viên; dòng Link nhóm trùng vị trí G008 §10C (Q-35) |
| **G008** BR02 L287, E05 L268 | Mức thành viên tối đa 100 / Business cao hơn | BR09 cảnh báo đầy (Q-10) | Regression toast "Nhóm đã đạt giới hạn thành viên" ở Thêm thành viên không đổi |
| **G008** BR05b L291 / L88 / L377 | Quyền sửa tên/avatar; popup Tạo nhóm không có "Mời qua link" | Đối chiếu mô hình gate (Q-34); không thêm link vào Tạo nhóm | Regression Tạo nhóm: không xuất hiện nút link |
| **G011 Panel Thông tin** (v1.1) | BR02 L130, **BR03 L131** (cấm nút thao tác), BR07 L135 (kế thừa quyền xem hội thoại) | Thêm dòng "Link nhóm" vào panel (Q-35) | Regression bố cục panel/tab; BR02b chưa tồn tại |
| **G003 Chat** (v1.11) UC-08 L201–L212 | **BR20 L316** (tin thường), **BR21 L317**, **BR22 L318**, **BR23 L319**, **BR25 L321**, **BR27 L323**, **E09 L273**, BR03 L297 (mốc tách 1.000) | Hộp chọn hội thoại dùng lại; bộ đếm "Đã chọn n", nút "Gửi (n)" (§10G) | Regression chuyển tiếp tin sau khi tái dùng; tin chuyển tiếp nhanh hơn từ 28–29/09 (html §6) |
| **G015 Link Preview** (v1.1) | BR01 L142, BR04 L146, BR06 L148, E01 L117, BR13 L156 | Thẻ xem trước khi chia sẻ link (Q-36) | Có thể phát sinh/không phát sinh thẻ; regression thẻ link trong chat |
| **G026 Cài đặt nhóm** (v1.0) | BR01 L128 (không phó), BR04 L131, BR08 L132, UC-06 L88–L95, BR07 L136 | Duyệt thành viên → dòng nhắc BR08; luồng sau "Tham gia" BR10 | Regression danh sách chờ duyệt; G026 chỉ nhắc link, chưa nhắc QR |
| **G001 Liên kết tài khoản Zalo** (v1.1) | BR03 L140 (Ngắt kết nối → không thực thi hành động), status L197 | E02/BR11 | Tránh nhầm hai loại QR (OOS07); không áp cache/giới hạn G016/G018 |
| **G002 Chia sẻ tài khoản** (v1.2) | Matrix L147–L154; AC L227–L228, L244–L250 | Chỉ người được gán tài khoản mới thấy hội thoại/nhóm → panel | Gỡ phân quyền giữa chừng (Q-12); cô lập workspace (Q-14) |
| **G010** BR02 L156, BR04 L158, BR09 L163 | Cô lập workspace; DISCONNECTED vẫn hiển thị dữ liệu | BR11 (live-read bị khoá), tenant | Liên kết chéo workspace |
| **Cache nhóm 28–29/09** (html §3) | Thành viên/cài đặt nhóm hiện ngay từ cache rồi làm mới | Q-27 | Dòng nhắc BR08/BR09 có thể lệch tạm thời |
| Tab Nhóm / panel thông tin nhóm trong Chat | Điểm vào của màn | Smoke chung | — |

Z-02 (Tin nhắn mẫu) không chung màn với G033; chỉ chia sẻ khu vực Chat → không đưa vào regression bắt buộc, chỉ smoke tab Chat.

### 6.1 Dòng spec khác phải sửa NẾU G033 đúng (đề xuất cho BA; QA không tự sửa)

| # | File:dòng | Hiện tại | Phải thành (nếu G033 đúng) | Q |
|---|---|---|---|---|
| 1 | G008 L242 (AF01 b2) | "Lấy link nhóm (hệ thống tự tạo link có sẵn cho mỗi nhóm) → copy vào clipboard → Toast *Đã copy link nhóm*" | "Mở màn Link nhóm (G033)"; bỏ "tự tạo link có sẵn cho mỗi nhóm" (nhóm có thể chưa có link → Tạo ngay); copy chỉ qua nút Sao chép link | Q-31, Q-32 |
| 2 | G008 L300 (BR15) | "hệ thống **tự tạo link nhóm** có sẵn … click 'Mời qua link' → link copy vào clipboard → toast; người nhận click link → vào nhóm" | Mở màn G033; bỏ "tự tạo"; người nhận → màn xem trước Zalo + nút Tham gia → chờ duyệt (G026) hoặc vào thẳng | Q-31, Q-32 |
| 3 | G008 L455 (AC) | "Click 'Mời qua link' … → link được copy vào clipboard → toast *Đã copy link nhóm*" | "→ mở màn Link nhóm; bấm Sao chép link → copy + toast" (**AC hiện hành sẽ SAI**) | Q-31 |
| 4 | G008 L456 (AC) | "Người được mời vào nhóm qua link → xuất hiện trong danh sách thành viên" | Thêm điều kiện duyệt thành viên (G026 BR04/BR08): bật duyệt → chờ trưởng nhóm duyệt | Q-28 |
| 5 | G008 L390 (§10C "Thêm thành viên") | "(tương tự UC-02, có thêm nút 'Mời qua link' → AF01)" | "→ mở màn Link nhóm (G033)" | Q-31 |
| 6 | G008 L395 (§10C "Link nhóm") | "Hiển thị link mời nhóm để copy và gửi cho người muốn mời" | "Bấm → mở màn Link nhóm (G033)" (đúng như G033 L38 nói "nay trỏ sang G033") | Q-31, Q-35 |
| 7 | G008 §13 L501–L504 ("Được phụ thuộc bởi"), L412 (§10D) | Không có G033; §10D chỉ toast "Đã copy link nhóm" | Thêm G033 vào phụ thuộc; thêm/dẫn các toast mới (Tạo/Đổi/Huỷ link, Đã gửi link nhóm) | Q-31 |
| 8 | G008 (BR table L284–L307) | Chỉ BR01–BR22 | Thêm BR25 (Zalo chỉ cho … đổi cài đặt nhóm; "ba đặc quyền riêng của trưởng nhóm") — **nội dung do BA cung cấp** | Q-31 |
| 9 | G008 L25, L26, L43, L129–L141, L291 (BR05b), L385–L386, L423–L424 | "trưởng nhóm **hoặc phó nhóm**" | Bỏ "phó nhóm" nếu G026 BR01 đúng (hoặc G026/G033 phải sửa ngược lại) | Q-33 |
| 10 | G026 L82, L134 (và L128 dẫn "G008 v1.3") | "G008 đã chốt sửa thông tin nhóm chỉ trưởng nhóm"; "(G008 v1.3)" | Sửa dẫn chiếu cho khớp G008 hiện hành, hoặc G008 sửa theo (#9) | Q-33 |
| 11 | G011 L130–L131 (BR02, BR03), L29 | "Tab Thông tin thuần thông tin … Không đặt nút thao tác … ở menu hội thoại panel trái"; không có BR02b | Thêm BR02b (dòng "Link nhóm" thuộc nhóm dòng chức năng nhóm, hành vi khai ở G033) và ngoại lệ cho BR03; hoặc G033 bỏ dẫn BR02b | Q-35 |
| 12 | G003 L316 (BR20) | "Tin được chuyển tiếp … dưới dạng tin nhắn thường — không có label hay định dạng đặc biệt" | Nếu chia sẻ link nhóm gửi **thẻ**: ghi ngoại lệ/loại tin thẻ cho UC-08 khi gọi từ G033; hoặc G033 sửa BR06 L188/UC-02 L72 cho khớp | Q-05, Q-36 |
| 13 | G015 L142–L148 (BR01, BR04, BR06), E01 L117 | Thẻ chỉ khi crawl OG thành công; lỗi → text thường | Nếu thẻ link nhóm do G015 tạo: nêu rõ tiêu chí và fallback cho `zalo.me/g/…`; nếu do hub: G015 không đổi | Q-36 |
| 14 | G003 L209, L317 (UC-08 b2, BR21) | "Chỉ trưởng/phó nhóm được nhắn tin" | "Chỉ trưởng nhóm" cho khớp G026 BR05/BR06 L133, L135 (G033 BR06 đã dùng "chỉ trưởng nhóm") | Q-33 |
| 15 | CR-004 L75–L78 vs G003 L297–L299 (BR03/BR03b/BR03c) | CR-004 "Đã sửa tài liệu" mốc 2.000; G003 vẫn 1.000 | Đồng bộ G003 (không do G033 gây ra; ảnh hưởng độ dài dòng tin kèm) | Q-20 |

---

## 7. Nhận xét sơ bộ về độ phủ (chưa phải plan)

- AC §11 chia 9 nhóm (Lối vào & quyền · Nội dung màn · Ba thao tác · Tạo link · Đổi/Huỷ · Dòng nhắc · Luồng tham gia · Nền tảng · Ngoại lệ), tổng khoảng 63 mục. E01–E08, AF01–AF03/AF05–AF08, state machine 4 chuyển trạng thái đều có AC tương ứng.
- Chưa có AC cho: §15 hiệu năng (chỉ nằm ở §15), a11y, **tenant/workspace (Q-14, các spec cùng loại đều có AC BR-C01)**, log/audit (Q-15), E02 tại lối vào thứ hai, E04 tại lối vào thứ hai, thu hồi quyền giữa chừng (Q-12).
- Cụm case phải gắn ❓ (không tính phủ) cho đến khi BA/dev trả lời: QR/logo (Q-01) · UC-02 loại tin + thẻ (Q-05, Q-36) · E08 và quyền theo vai trò Zalo (Q-07, Q-33, Q-34) · lối vào/vị trí dòng + regression "Mời qua link" (Q-31, Q-32, Q-35) · security API (Q-13) · E03 vs chưa có link (Q-09).

### 7.1 Câu còn CHẶN (nhóm theo việc cần để mở khoá)

| Cụm | Câu | Cần ai |
|---|---|---|
| Hub/API (build + môi trường + security) | Q-01, Q-02, Q-09, Q-13 | dev / hub |
| Dẫn chiếu treo + mâu thuẫn với G008/G011 (lối vào, hành vi "Mời qua link", vị trí dòng) | Q-31, Q-32, Q-35 | BA (quyết sửa spec nào / G033 dẫn sai) |
| Quyền & vai trò (E08, BR04, BR16) | Q-07, Q-33, Q-34 | BA |
| Chia sẻ link (UC-02) | Q-05, Q-36 | BA / dev |

---

## 8. Lịch sử cập nhật

| Ngày | Người | Nội dung |
|---|---|---|
| 2026-10-07 | QA | Tạo INTAKE-G033: nguồn, flag + lane (high-risk), 6 UC, 16 BR, 30 câu hỏi, điều kiện dữ liệu/môi trường, điểm chạm regression. Chưa có plan/case |
| 2026-10-07 | QA | Rà soát lại sau khi có bộ G-spec gốc G001→G033 trong `tailieu/` (đã đối chiếu G001, G002, G003, G008, G010, G011, G014, G015, G016, G018, G026 + CR-001/CR-004): 30 câu cũ → **0 đã trả lời · 14 một phần · 16 vẫn mở · 0 sai**; **6 câu mới** (Q-31…Q-36); bật `multi-tenant-isolation` (5 flag · 3 hard gate, lane vẫn high-risk); cập nhật BR/regression theo BR gốc |
| 2026-10-07 | QA | Cập nhật theo **quyết định của user: mọi file trong `tailieu/` là bản DUY NHẤT/hiện hành** (số version G033 dẫn như G008 v1.9, G003 v1.23 chỉ là các lần sửa trực tiếp trên docs; G032 bản hiệu lực = `Đổi tên gợi nhớ (1).md`). Bỏ nhận định "lệch phiên bản / cần bản spec làm oracle". Q-31 viết lại thành **dẫn chiếu treo** (G008 BR25, BR15 v1.9, G011 BR02b không tồn tại); Q-32…Q-36 nâng thành mâu thuẫn thật với spec hiện hành, thêm bảng §6.1 (dòng spec cần sửa nếu G033 đúng, trong đó AC G008 L455 sẽ sai). 30 câu cũ không đổi trạng thái (0/14/16/0); lane/flag giữ nguyên (high-risk, 5 flag, 3 hard gate) |
