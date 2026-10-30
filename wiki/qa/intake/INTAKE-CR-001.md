---
id: INTAKE-CR-001
title: "Intake & phân loại — CR-001 Quyền kết bạn của nhân sự"
featureId: CR-001
createdBy: QA
createdAt: 2026-10-07
updatedBy: QA
updatedAt: 2026-10-07
status: high-risk-pending-confirmation
lane: high-risk
---

# INTAKE — CR-001 Quyền kết bạn của nhân sự

> Phase 1 (qa-intake-classifier). CHƯA viết plan / case.
> Quy ước trích dẫn: `L<số>` = số dòng trong `tailieu/CR-001 - Quyền kết bạn của nhân sự.md` (200 dòng). Tài liệu gốc trích dạng `G007:152` = file + số dòng (số dòng trùng cách CR-001 tự trích `G007:41–45`, `G007:152`, `G007:328`, `G017:41`, `G017:235`, `G012:240`, ngoại trừ G003 — xem Q-21). `G032` luôn là bản `G032 - Đổi tên gợi nhớ (1).md`.
> Mã Q-01…Q-16 giữ nguyên; câu mới đánh tiếp từ Q-17.
> **Hai quyết định của user (2026-10-07), đã áp dụng:** (1) G032 hiệu lực = `G032 - Đổi tên gợi nhớ (1).md`; bản "Đặt tên gợi nhớ" KHÔNG dùng. (2) Mọi file trong `tailieu/` là BẢN DUY NHẤT = spec HIỆN HÀNH; số version CR dẫn (G007 v1.2/v1.3, G017 v1.2…) chỉ là các lần sửa trực tiếp trên docs, không có file bản khác để chờ. Nội dung CR mô tả mà spec hiện hành chưa chứa = **spec chưa được cập nhật theo CR / dẫn chiếu treo** (Q-01; bảng sửa ở mục 4.3). **Cách QA test: spec hiện hành trong `tailieu/` + delta ghi trong CR-001.** Tài liệu thật sự không tồn tại (CR-002, Ma trận phân quyền, PROJECT_KNOWLEDGE) vẫn tính là thiếu.

## 1. Nguồn

- File: `tailieu/CR-001 - Quyền kết bạn của nhân sự.md` (200 dòng). Ngày nhận 2026-09-17, last updated 2026-09-24, ưu tiên Cao, BA Trân, khách nội bộ Mingi (L5-12).
- Không có `wiki/features/FEAT-*.md` → nguồn AC = chính phiếu CR (BR + luồng mermaid + ma trận §2.5) cộng AC của spec hiện hành.
- **Kết luận B1:** có hành vi kiểm chứng được (BR18, BR19, G017 BR24, G017 BR26, ma trận §6, 2 luồng trước/sau) → KHÔNG `blocked-no-ac`.
- Phiếu ghi `☑ Acceptance Criteria` cho G007/G017 (L154, L157) nhưng **không chép nội dung AC**; chỉ có BR. Case cho BR mới sinh từ BR + luồng của CR (Q-01).

**Spec hiện hành trong `tailieu/` (đã đối chiếu 2026-10-07):**

| Tài liệu | Version ghi trong file / ngày | Ghi chú |
|---|---|---|
| G007 Kết bạn | v1.1 · 2026-07-01 (G007:11-13) | BR01-BR17; chưa chứa BR18/BR19/BR20 (CR dẫn) → Q-01, mục 4.3 |
| G017 Tìm kiếm hợp nhất | v1.1 · 2026-07-29 (G017:11-13) | BR01-BR23; chưa chứa BR24/BR26 (CR dẫn) → Q-01, mục 4.3 |
| G012 Nút Kết bạn trong hội thoại | v1.1 · 2026-07-22 (G012:11-13) | Có chiều nhận (Chấp nhận/Từ chối) |
| G002 Chia sẻ TK Zalo cho Staff | v1.2 · 2026-06-26 (G002:11-13) | |
| G003 Chat | v1.11 · 2026-08-03 (G003:11-13) | Dòng CR-001 trích lệch 2-6 dòng (Q-21) |
| G001 Liên kết TK Zalo | v1.1 · 2026-06-09 (G001:11-13) | Trạng thái dùng nhãn "Đang hoạt động / Ngắt kết nối"; mã `CONNECTED/DISCONNECTED` dùng ở G012/G032/G033 |
| G032 Đổi tên gợi nhớ (1) — **bản hiệu lực** (user xác nhận 2026-10-07) | v1.0 · 2026-09-22 (G032:11-13) | Bản "Đặt tên gợi nhớ" không dùng |
| G033 Màn Link nhóm | v1.0 · 2026-10-02 | Chỉ liên quan R7 (BR11) |
| CR-002, Ma trận phân quyền, PROJECT_KNOWLEDGE | KHÔNG tồn tại (đã Glob + Grep toàn `tailieu/` và repo) | Tên "CR-002" chỉ xuất hiện trong CR-001 (L47, L92) |

## 2. Đây là CR — baseline, delta & regression

Phân loại của BA (L190): **CR**, "nghiệp vụ đã có trong G007 và G017, viết rõ điều đang nói chưa rõ. Không tạo Spec mới, không đổi quy tắc". Việc cho Dev (L192) yêu cầu đổi hành vi thật (hiện nút + gỡ điều kiện quyền).

### 2.1 Baseline "trước CR" — hành vi hiện hành theo spec hiện hành

Bốn lối vào theo CR-001 BR19 (L120). Cột "Spec hiện hành" là cái tài liệu ĐANG nói; cột "Quan sát thực tế" là cái khách báo (CR-001 L27-28, L53-64) — chỉ có cho lối ③ và ④.

| Lối | Spec hiện hành: luồng | Spec hiện hành: điều kiện quyền | Quan sát thực tế (khách) |
|---|---|---|---|
| ① Nút "Kết bạn" trên header danh sách hội thoại (G007 UC-01) | G007:55-61: click nút → popup (dropdown TK Zalo "bắt buộc, mặc định trống" + SĐT + Tìm kiếm) → hồ sơ + "Kết bạn"/"Nhắn tin" → click "Kết bạn" → nút đổi "Đã gửi lời mời" + "Thu hồi"; lời mời vào tab Đã gửi (G007:61). Không có confirm dialog. Nhãn nút header: "Kết bạn" (G003:398) | Tiên quyết: "Có ít nhất 1 tài khoản Zalo đang hoạt động trong workspace" (G007:53). Actors: cả 3 vai "Toàn bộ thao tác" (G007:43-45). Dropdown: "chỉ liệt kê tài khoản Zalo đang hoạt động mà user hiện tại được assign" (G007:152). KHÔNG có điều kiện "Quản lý tài khoản Zalo" ở đâu | KHÔNG có dữ liệu (CR chỉ nói chung "ba lối còn lại", L90). Còn mở: Q-02 |
| ② Nút "Thêm bạn" trong Danh bạ (G007 UC-01b) | G007:63-69: cùng popup như ① | Giống ① (tiên quyết G007:65) | KHÔNG có dữ liệu. Còn mở: Q-02 |
| ③ Khối "Tìm & Kết bạn" trong tìm kiếm (G017) | G017:160-180 (AF02): gõ SĐT (9-12 chữ số, BR02) không có trong danh bạ (BR07) → khối "Không tìm thấy số này trong danh bạ." + ô "Tài khoản Zalo thực hiện" (chỉ TK được assign; 1 TK thì tự chọn + ẩn ô; mặc định TK dùng gần nhất; BR08-BR10) → bấm "Tìm & Kết bạn" (lúc này mới gọi Chat-Zalo; BR06) → hồ sơ (avatar, tên) + nút "Gửi lời mời kết bạn" (G017:179). Đã là bạn → toast "Đã là bạn bè" + "Mở hội thoại" (E07) | G017 §10E (G017:394-399): Admin/Owner "Mọi tài khoản trong workspace" ✅; Staff được assign ✅; Staff chưa assign "❌ — trạng thái rỗng (E04)". KHÔNG có điều kiện "Quản lý tài khoản Zalo" | CR L27-28, L55-62: nhân sự CÓ quyền QLTK → "nút Kết bạn hiện ngay" (khách gọi là "Kết bạn ngay" — chuỗi này KHÔNG có trong spec hiện hành nào); nhân sự KHÔNG có quyền → "KHÔNG có nút Kết bạn" → phải mở hội thoại, nhắn tin trước |
| ④ Nút "Kết bạn" trong hội thoại (G012) | G012:77-82: mở hội thoại → nút "Kết bạn" dưới tên Zalo → click → confirm dialog ("Bạn có muốn gửi lời mời kết bạn đến [tên]?", bắt buộc, BR05) → "Đã gửi lời mời" disabled. Không có bước chọn TK (dùng TK của hội thoại) | G012:240 (§10C): "Thấy và click nút Kết bạn — Admin: Có · Staff: Có (nếu có quyền truy cập hội thoại — G002)". Tiên quyết TK CONNECTED (G012:38); DISCONNECTED → ẩn nút (BR06, G012:158). E04: mất quyền giữa chừng → toast "Bạn không có quyền thực hiện thao tác này" + ghi log (G012:134) | Chạy đúng cho mọi nhân sự, nhưng buộc phải nhắn tin trước (CR L88-90). Khớp G003 BR26 Case A: mở "hội thoại nháp", hội thoại thật chỉ tạo khi gửi tin đầu tiên, khi đó auto-assign cho người gửi (G003:322) |

**Các khác biệt giữa 4 lối đã có sẵn trong spec hiện hành (KHÔNG phải do CR, nhưng ảnh hưởng case):** (a) confirm dialog chỉ có ở ④; ①②③ bấm là gửi; (b) chọn TK: ①② "mặc định trống, không tự động chọn" (G007:56, BR01 G007:143) còn ③ "tự chọn sẵn / dùng gần nhất" (G017:175-176); (c) khi TK DISCONNECTED: ④ ẩn nút, ①② toast "Lỗi kết nối. Vui lòng thử lại" (G007 E03, G007:130), ③ toast "Tài khoản Zalo «[tên]» đang mất kết nối…" (G017 E06, G017:237) — xem Q-04.

### 2.2 Delta thật của CR-001

| # | Delta (theo L119-123, L153-169, L192) | Đối chiếu spec hiện hành | Kết luận delta |
|---|---|---|---|
| D1 | G017 BR26: nút Kết bạn hiện NGAY trên kết quả tìm kiếm, gửi qua đúng TK đã dùng để tìm, không hỏi lại | G017:178-179 đã có "bấm Tìm & Kết bạn → tra cứu qua TK đã chọn → hồ sơ + Gửi lời mời kết bạn"; CR L122 tự nói "đúng như §7a đang ghi". Nhưng "ngay trên kết quả" có thể có nghĩa khác (bỏ bước bấm "Tìm & Kết bạn"; hoặc hàng kết quả nội bộ có nút) | **Chưa xác định** — Q-17. Nếu nghĩa là bước 7a hiện hành thì delta = sửa implementation cho đúng spec |
| D2 | G007 BR18: kết bạn không đòi quyền quản trị; điều kiện duy nhất = assign ≥1 TK CONNECTED; gỡ điều kiện "Quản lý tài khoản Zalo" | Spec hiện hành KHÔNG có điều kiện QLTK ở ①②③ (G007:43-45, :53, :152; G017:396-399). Điều kiện đó chỉ có ở implementation (CR L27-28) | Delta = **sửa code** (gỡ gate không có trong spec) + BR tường minh (nguồn: CR). Thay đổi quan sát được chắc chắn duy nhất: nhân sự không có QLTK, assign ≥1 TK, dùng được ③ (và có thể ①②) mà không cần nhắn tin trước |
| D3 | G007 BR19: 4 lối bình đẳng về quyền | Spec hiện hành ④ cần "quyền truy cập hội thoại" (G012:240) — CR L120 nói đây là "bản chất vị trí" | Doc-level; kiểm bằng ma trận ①②③④ x vai |
| D4 | G017 BR24: khối Tìm & Kết bạn hiện với mọi nhân sự assign ≥1 TK | Đã có G017:397 và E04 (G017:235). Khác nhỏ: spec "Staff chưa assign → trạng thái rỗng + câu 'Bạn chưa được phân quyền tài khoản Zalo nào'" (G017:235) vs CR "Không thấy khối Tìm và Kết bạn" (L75); spec không nhắc CONNECTED ở §10E | Doc-level + 1 chênh câu chữ (Q-04) |
| D5 | Ma trận phân quyền thêm §6 (5 dòng) | Ma trận không tồn tại; dòng 5 ("Đặt tên gợi nhớ", G032 BR06) đúng mã quyền G032 nhưng điều kiện chung lệch G032 BR06/BR10 (Q-18) | Tài liệu; kiểm bằng đối chiếu |

**Không đổi (theo phiếu):** lối ④ (L88-90, L192); BR10 dropdown theo assign (L147); BR-C02, BR-C06 (L143).

### 2.3 Regression cần canh (theo BR của spec hiện hành)

- **R1 Lối ④ + auto-assign.** Spec: G012 BR01-BR12 (G012:153-164), confirm dialog BR05, E04; G003 BR26 (G003:322; AC G003:607-612): Case A = mở **hội thoại nháp**, thật chỉ tạo khi gửi tin đầu (auto-assign lúc đó, không phụ thuộc quyền G003 BR18); Case B mở hội thoại sẵn có; Case C (đã gán nhân viên khác) = chặn + banner + log. Phiếu khẳng định "không phải sửa" (L192). Kịch bản khám phá (KHÔNG phải câu hỏi spec): khách đang có hội thoại gán cho NV khác nhưng chưa là bạn — nhân sự B kết bạn qua ③ có "lách" tinh thần Case C không.
- **R2 Vai/quyền.** Admin / "Nhân viên quản lý" / nhân sự có quyền "Quản lý tài khoản Zalo" vẫn dùng được cả 4 lối. Cần chốt "Nhân viên quản lý" là gì (Q-19).
- **R3 Dropdown/ô chọn TK chỉ liệt kê TK được assign** (G007 BR10 :152; G017 BR08 :279, BR09 :280, BR10 :281) — không lộ TK không assign. Admin: G017:396 nói "mọi tài khoản trong workspace" (Q-16).
- **R4 Staff chưa assign TK nào:** G017 E04 (:235) "Bạn chưa được phân quyền tài khoản Zalo nào" (trạng thái rỗng) — kỳ vọng câu chữ có ở spec; riêng ①② không có spec (Q-03).
- **R5 4 thao tác khác trong ma trận §6:** Thu hồi (G007 UC-02, :71-76; G012 OOS03 :278 = không có từ hội thoại); Chấp nhận/Từ chối (G007 UC-03 :78-84, BR07 :149; G012 UC-02/BR07-BR12 :159-164); Xoá bạn (G007 UC-05 :93-102, BR11-BR17 :153-159); Tên gợi nhớ (G032: BR06 quyền :140, BR10 điều kiện CONNECTED :144 — Q-18).
- **R6 Sau khi gửi lời mời từ ③:** G017 BR20 xoá bản ghi nhớ tra cứu (:299), BR21 thêm người đó vào danh bạ ngay (:300), AC :442, :445-446; G032 BR11 (:145) tự ghi tên gợi nhớ lên Zalo khi quan hệ chuyển sang bạn bè; tab "Người lạ" / chuyển hội thoại về danh sách chính (`thay-doi-28-29-09.html` L107-108, chưa đọc lại vòng này).
- **R7 Màn khác phụ thuộc CONNECTED/DISCONNECTED:** G012 BR06 (:158), G007 E03 (:130), G017 E06 (:237), G003 BR10 (:306), G002 BR01 (:135), G033 BR11 (G033:193) và E02 (G033:167), **G032 BR10 (G032:144)** (đã Grep bản (1): BR10 = TẤT CẢ TK liên quan phải CONNECTED; BR08 = ghi lên tất cả TK liên quan, không phải điều kiện CONNECTED) — cùng BR-C07.
- **R8 Bất biến của tìm kiếm G017:** BR06 (:277) "không bao giờ tự gọi Chat-Zalo Service khi user gõ"; BR19 (:298) ghi nhớ 7 ngày theo cặp (SĐT + TK); BR23 (:302) ghi nhớ kết quả tách theo user; AC G017:433-435 (gõ liên tục không phát sinh lượt tra cứu; bấm nút mới tính 1 lượt; nút vô hiệu trong lúc tra). Nếu D1 được hiện thực bằng cách tra Zalo tự động thì phá BR06 — canh sát.

## 3. Risk assessment (RISK_LANES.md § Lanes — QA)

| Flag | Cũ | Mới | Căn cứ |
|---|---|---|---|
| `security-test` | CÓ (hard gate) | CÓ (hard gate) | Gỡ yêu cầu "Quản lý tài khoản Zalo" = nới điều kiện hiện nút (L119, L192); cần test không rò sang TK không assign và phía server (Q-10, Q-20). Spec đã có cơ chế từ chối + log ở ④ (G012 E04 :134) nhưng ①②③ chưa nêu |
| `regression-scope` | CÓ | CÓ | Luồng kết bạn đã ship, 4 lối vào, ma trận phân quyền, G017/G012/G003 |
| `flaky-risk` | CÓ | CÓ | Phụ thuộc Zalo ngoài + trạng thái CONNECTED đổi theo thời gian; ghi nhớ 7 ngày/30 giây (G017 BR19/BR22) làm kết quả phụ thuộc thời điểm |
| `multi-tenant-isolation` | Không xác định | **CÓ (flag, chưa là hard gate)** | Spec hiện hành xác nhận cô lập workspace là bắt buộc: "Cô lập dữ liệu giữa các workspace ⚠️ (bắt buộc)" (G002:248-250), "Mỗi user chỉ thấy danh bạ trong workspace của mình" (G007:301), "User workspace A tìm từ khoá chỉ có ở workspace B → không ra kết quả nào" (G017:467), G032:286. Không nâng hard gate vì CR không đổi phạm vi tenant (L147); xem lại nếu Q-10/Q-20 cho thấy gate cũ đang gánh việc kiểm workspace |
| `cross-service-e2e` | Không xác định | **CÓ (flag, chưa là hard gate)** | Tra cứu/gửi lời mời đi Web → Server Gopany → Chat-Zalo Service → Zalo (G017:23, :63-64, :124-128); "Gopany và Chat-Zalo lưu dữ liệu độc lập" (G017 OQ Q2, :520). CR không nói đổi contract nên chưa hard gate; xem lại sau Q-10 |
| `data-integrity` | Không | Không | Không tính tiền/tồn/số dư/migration (CR L146 "Không có dữ liệu nào"). G017 BR21 thêm danh bạ + G032 BR11 ghi tên là dữ liệu phụ, xử lý trong Q-09 |
| `no-ac-source` | Không | Không | Xem mục 1 |

Số flag (ngoài no-ac-source): cũ = 3 → **mới = 5**. Hard gate: `security-test`. → **lane high-risk (không đổi)**; 2 căn: hard gate + ≥4 flag.
Test depth: Happy/Edge/Error đủ BR + exploratory + a11y + automation regression + **confirm scope với user**.
Test types: acceptance, system, **e2e** (cross-service-e2e + UI xuyên FE-BE), regression, exploratory, a11y. Không recommend perf-smoke. Không làm lại unit/integration/contract (Dev).
Skills: qa-test-design, qa-test-types, qa-e2e-playwright, qa-api-test, qa-test-data, qa-defect, qa-exit-criteria.

## 4. Danh sách Business Rule

### 4.1 BR do CR-001 đề xuất (delta) — nguồn là CR; spec hiện hành chưa chứa (spec chưa cập nhật theo CR, Q-01)

QA test các BR này theo nội dung CR-001, gắn nhãn "nguồn: CR-001 only" cho tới khi BA trả lời Q-01. Đây KHÔNG còn là "chưa kiểm được vì chưa có bản sau CR".

| ID | Nội dung rút gọn | Vị trí | Đối chiếu spec hiện hành |
|---|---|---|---|
| G007-BR18 | Kết bạn không đòi quyền quản trị; điều kiện duy nhất: assign ≥1 TK CONNECTED (G002); KHÔNG đòi "Quản lý tài khoản Zalo", "Quản lý nhóm", hội thoại trước; áp cả 4 lối | L119 | G007 chỉ có BR01-BR17. "Quản lý nhóm" là quyền có thật ở G008 (BR05-BR06, G008:290-292) |
| G007-BR19 | 4 lối bình đẳng về quyền | L120 | Chưa chứa; mới hoàn toàn |
| G017-BR24 | Khối Tìm & Kết bạn hiện với mọi nhân sự assign ≥1 TK; không đòi quyền quản trị | L121 | Chưa chứa BR24, nhưng đã nói ở G017:397 + E04 (:235) |
| G017-BR26 | Nút "Gửi lời mời kết bạn" hiện ngay trên kết quả; không cần hội thoại/nhắn tin; gửi qua đúng TK dùng để tìm | L122, L78 | Chưa chứa BR26; G017:179 (7a) đã có nút sau khi tra; Q-17. G017 không có BR25 (Q-21) |
| MATRIX-§6-a | Gửi lời mời kết bạn: Admin ✓, NS Quản lý ✓, Nhân sự ✓ | L163 | Ma trận không tồn tại |
| MATRIX-§6-b | Thu hồi lời mời đã gửi: 3 vai ✓ (G007 UC-02) | L164 | G007:71-76 không nêu quyền |
| MATRIX-§6-c | Chấp nhận / Từ chối: 3 vai ✓ (G007 UC-03, G012 §10C) | L165 | G012:241 chỉ "Staff có nếu có quyền truy cập hội thoại" |
| MATRIX-§6-d | Xoá bạn: 3 vai ✓ (G007 UC-05, BR11) "⚠️ xem R-01" | L166 | R-01 không được định nghĩa ở đâu (Q-13) |
| MATRIX-§6-e | Đặt tên gợi nhớ: 3 vai ✓ (G032 BR06) | L167 | Mã BR06 ĐÚNG với G032 hiệu lực (quyền xem hội thoại/danh bạ, G032:140); điều kiện chung của hàng lệch G032 BR06/BR10 (Q-18) |
| MATRIX-§6-f | Điều kiện chung 5 dòng: assign ≥1 TK CONNECTED; không dòng nào đòi "Quản lý tài khoản Zalo" | L169 | Xung đột G032 BR06/BR10/BR11 và Admin bypass (Q-16, Q-18) |
| CR-FLOW-01 | Sau khi sửa không còn nhánh nào dẫn tới "nhắn tin trước" | L86 | Hành vi mới |
| CR-FLOW-02 | Không có TK assign CONNECTED → không thấy khối Tìm & Kết bạn (G017 E04) | L75 | Spec E04 = "chưa assign" + trạng thái rỗng, KHÔNG nói CONNECTED (Q-04) |
| CR-FLOW-03 | Bước 2 chọn TK: chỉ TK được assign (BR10), hiển thị đầy đủ & cuộn được (BR20, CR-002) | L46-47, L92 | G007 không có BR20 → dẫn chiếu treo (Q-14, Q-01) |

### 4.2 BR/quy tắc hiện hành đã kiểm với spec hiện hành (baseline/regression)

| ID | Nội dung rút gọn | Vị trí |
|---|---|---|
| G007 §2 | 3 vai "Toàn bộ thao tác" | G007:43-45 |
| G007 UC-01 / UC-01b | Tiên quyết: ≥1 TK Zalo đang hoạt động trong workspace; popup; luồng gửi | G007:53, :65, :55-61 |
| G007 BR01 | Gửi luôn qua TK chọn trong dropdown — không tự động chọn | G007:143 |
| G007 BR02 | 1 TK chỉ có 1 lời mời đang chờ với cùng 1 SĐT | G007:144 |
| G007 BR06 / E05 | SĐT bị block hiển thị như "Không tìm thấy" | G007:148, :132 |
| G007 BR08 / BR09 | Kết bạn và nhắn tin độc lập — kết bạn thành công không tự tạo hội thoại; nhắn tin từ popup tạo hội thoại | G007:150-151 |
| G007 BR10 | Dropdown chỉ TK đang hoạt động mà user được assign | G007:152 |
| G007 BR11-BR17 | Xoá bạn (BR11 chọn TK "đang active"/"đầu tiên mà liên hệ có chung với user"), giữ lịch sử, banner "Gửi kết bạn", webhook (BR15 pending OQ01) | G007:153-159 |
| G007 OOS07 | Phân quyền riêng theo role cho từng thao tác Danh bạ: Out of Scope | G007:328 |
| G007 AC | Popup, AF01 (đã là bạn → chỉ Nhắn tin), AF02 (đang chờ → "Đã gửi lời mời" disabled + Thu hồi) | G007:267-279, :108-112 |
| G017 pre-conditions | Staff đã assign ≥1 TK; workspace có ≥1 TK Đang hoạt động; từ khoá ≥2 ký tự | G017:85-87 |
| G017 BR02 | 9-12 chữ số = SĐT, so khớp 9 số cuối | G017:273 |
| G017 BR03 | Phạm vi tìm của Staff = TK assign + hội thoại gán cho mình (+ chưa gán nếu có quyền); Admin toàn workspace | G017:274 |
| G017 BR06 | Không bao giờ tự gọi Chat-Zalo khi user gõ | G017:277 |
| G017 BR07 | Khối Tìm & Kết bạn chỉ hiện khi là SĐT và không có trong danh bạ | G017:278 |
| G017 BR08-BR10 | Ô chọn TK chỉ TK được assign; 1 TK → tự chọn + ẩn; mặc định TK dùng gần nhất | G017:279-281 |
| G017 BR19-BR21, BR23 | Ghi nhớ 7 ngày theo (SĐT+TK); xoá khi gửi lời mời thành công; thêm danh bạ ngay; ghi nhớ kết quả tìm tách theo user | G017:298-300, :302 |
| G017 E04-E08 | Trạng thái rỗng chưa assign; không thấy trên Zalo; TK mất kết nối; đã là bạn; lỗi/timeout | G017:235-239 |
| G017 §10E | Bảng quyền hiển thị Admin / Staff assigned / Staff chưa assign | G017:394-399 |
| G012 BR01-BR12, E01-E04, §10C | Nút "Kết bạn" ④: hiện/ẩn theo CONNECTED + quan hệ; confirm dialog; Chấp nhận/Từ chối; quyền; mất quyền giữa chừng | G012:153-164, :131-134, :240-241 |
| G003 BR10 / BR11 / BR12 | TK ngắt kết nối vẫn xem lịch sử, không gửi mới; Admin thấy tất cả không cần assign; unassign → hội thoại ẩn ngay | G003:306-308 |
| G003 BR18 | Staff có quyền "Hiển thị cuộc hội thoại chưa gắn nhân sự" mới thấy hội thoại chưa gán | G003:314 |
| G003 BR26 (A/B/C) | Mở hội thoại từ tham chiếu liên hệ: nháp + auto-assign khi gửi tin đầu / mở sẵn / chặn | G003:322 |
| G002 BR07, ma trận | Nhân sự được phân quyền không có quyền Ngắt kết nối/Xoá; "Staff có quyền Quản lý tài khoản Zalo" toàn quyền tương đương Admin trong G002 | G002:142, :149-154, :26 |
| G032 BR06 / BR10 / BR11 | Quyền đổi tên = quyền xem hội thoại hoặc danh bạ, không đòi QLTK; TẤT CẢ TK liên quan phải CONNECTED (không xét TK chưa kết bạn); khách chưa kết bạn vẫn đặt được tên, ghi lên Zalo khi thành bạn bè | G032:140, :144, :145 |
| BR-C02 / BR-C06 | Phân quyền theo TK Zalo / ẩn-disable-toast (PROJECT_KNOWLEDGE §5 — tài liệu không tồn tại) | L143 |

Tổng: **13 BR/quy tắc delta của CR (4.1)** — nguồn CR, spec hiện hành chưa chứa; **26 dòng BR/quy tắc hiện hành (4.2)** đã đối chiếu spec hiện hành.

### 4.3 Dòng spec cần sửa nếu áp CR-001 (MỚI — để BA/Dev đối chiếu; QA không sửa spec)

Nội dung "phải thành" lấy từ CR-001; ô có "?" còn phụ thuộc câu hỏi chưa trả lời. Ma trận phân quyền không tồn tại nên không liệt kê dòng (CR L159-169 yêu cầu tạo §6).

| File | Dòng | Hiện tại | Phải thành (theo CR) |
|---|---|---|---|
| G007 | :11 (Version) | `1.1` | `1.3` (CR L153; CR gọi bản trước là v1.2) + cập nhật Last updated :13 |
| G007 | :53 (UC-01 tiên quyết) | "Có ít nhất 1 tài khoản Zalo đang hoạt động trong workspace." | Được assign ≥1 TK Zalo đang CONNECTED (G002) — theo BR18 (L119); Q-03 |
| G007 | :65 (UC-01b tiên quyết) | "Có ít nhất 1 tài khoản Zalo đang hoạt động trong workspace." | Như :53 |
| G007 | sau :159 (sau BR17) | không có BR18, BR19 | Thêm BR18 (kết bạn không đòi quyền quản trị; điều kiện duy nhất assign ≥1 TK CONNECTED; không đòi QLTK/Quản lý nhóm/hội thoại trước; áp 4 lối — L119) và BR19 (4 lối ①②③④ bình đẳng về quyền — L120) |
| G007 | BR20? (L47 dẫn "BR20 — xem CR-002") | không có | ? Thêm BR20 "danh sách TK hiển thị đầy đủ, cuộn được" nếu CR-002 thuộc G007 — chưa rõ (Q-14) |
| G007 | §9 AC :246-314 (nhóm "Popup Kết bạn" :266-279) | không có AC cho BR18/BR19 | Thêm AC: nhân sự không QLTK + assign ≥1 TK CONNECTED thấy/dùng được ①②; không đòi hội thoại trước (CR L154 "☑ Acceptance Criteria") |
| G007 | §11 Dependencies :335-339 | G001, G002, G003 | Thêm G017 (CR L154 "☑ Dependencies (thêm G017)") |
| G007 | Changelog :362-363 | dừng ở v1.1 | Thêm dòng v1.2/v1.3 tham chiếu CR-001 |
| G007 | :152 (BR10) / :354 | "đang hoạt động mà user hiện tại được assign" / "không phải toàn bộ workspace" | ? Ghi ngoại lệ Admin/Owner nếu BA xác nhận bypass assign (Q-16) |
| G017 | :11 (Version) | `1.1` | `1.2` (CR L156) + Last updated :13 |
| G017 | :266 (tiêu đề §6) + sau :302 (sau BR23) | "6A BR01–BR18 · 6B BR19–BR23"; không có BR24/BR25/BR26 | Thêm BR24 (khối Tìm & Kết bạn hiện với mọi nhân sự assign ≥1 TK, trỏ G007 BR18 — L121), BR26 (nút Gửi lời mời hiện ngay trên kết quả, qua đúng TK dùng để tìm, không hỏi lại — L122); BR25 không có trong CR (Q-21); cập nhật câu mở đầu §6 |
| G017 | :179 (7a) và :378 (§10C "Sau khi bấm") | "Tìm thấy → hiện hồ sơ + nút 'Gửi lời mời kết bạn'" (sau 6a bấm "Tìm & Kết bạn") | ? Giữ nếu BR26 = bước 7a hiện hành; sửa bước 6a/BR06 nếu BR26 nghĩa khác (Q-17) |
| G017 | :235 (E04) và :399 (§10E hàng "chưa assign") | "Staff chưa được assign … trạng thái rỗng"; §10E không nhắc CONNECTED | ? Bổ sung điều kiện "assign ≥1 TK CONNECTED" và hành vi "assign nhưng 0 CONNECTED" (CR L74-75; Q-04) |
| G017 | AC §11 :454-467 (nhóm "Chọn tài khoản Zalo", "Phân quyền và cách ly") | không có AC BR24/BR26 | Thêm AC: Staff không QLTK, assign ≥1 TK → khối Tìm & Kết bạn hiện; gửi qua đúng TK đã dùng để tìm; không cần mở hội thoại/nhắn tin (CR L157) |
| G017 | Dependencies :495-503 (hàng G002 :498) | không nhắc G007 BR18 | Thêm tham chiếu G007 BR18 (BR24 chỉ trỏ về, không định nghĩa lại — CR L145) |
| G017 | Changelog :555-556 | dừng ở v1.1 | Thêm dòng v1.2 tham chiếu CR-001 |
| G012 | :240 (§10C) / G003 :398 (§10B) | — | KHÔNG sửa (CR L144 "cả hai đã ghi đúng") |
| Ma trận phân quyền | — | tài liệu không tồn tại | Tạo §6 "Danh bạ & Kết bạn" (5 dòng, CR L159-169); sửa điều kiện chung dòng 5 theo Q-18 |
| PROJECT_KNOWLEDGE | — | tài liệu không tồn tại | CR L193 yêu cầu cập nhật; không kiểm được |

## 5. Điều kiện dữ liệu / môi trường

- Nhân sự test: không có quyền "Quản lý tài khoản Zalo", được assign ≥1 TK Zalo CONNECTED (L30, L181).
- Đối chứng: nhân sự CÓ quyền Quản lý TK (L27); nhân sự CHƯA assign TK nào (L75; G017 E04); Admin/Owner (chưa assign — Q-16); "NS Quản lý" (Q-19).
- Cần thêm từ spec: TK Zalo ở cả hai trạng thái CONNECTED và DISCONNECTED; nhân sự assign 1 TK và nhiều TK (G017 BR09 ẩn ô chọn khi 1 TK); SĐT: chưa là bạn / đã là bạn / đang chờ / bị block / không tồn tại trên Zalo (G007 AF01-AF02, E04-E05; G017 E05, E07).
- **Ràng buộc dữ liệu từ G017:** tra cứu cùng (SĐT + TK) trong 7 ngày trả kết quả ghi nhớ, không gọi Zalo (G017 BR19, :298), và bị xoá sau khi gửi lời mời thành công (BR20) → mỗi lần chạy lại case cần SĐT mới hoặc chờ hết hạn; tra cứu quá nhiều có thể khiến Zalo hạn chế TK workspace (G017:482, :519) → không dùng TK/SĐT khách thật (Q-12).
- Không nêu: môi trường, build/version, TK Zalo thử, SĐT thử, giới hạn Zalo → Q-12.

## 6. Câu hỏi làm rõ

### 6.0 Bảng tóm tắt trạng thái (rà soát 2026-10-07, đã áp 2 quyết định của user)

Nhãn: `ĐÃ TRẢ LỜI` · `MỘT PHẦN` · `VẪN MỞ` · `SAI` (không câu nào bị đánh SAI). Cột cuối ghi thay đổi do 2 quyết định.

| Q | Chủ đề | Trạng thái | Trả lời bởi | Còn chặn viết kỳ vọng? | Đổi do 2 quyết định |
|---|---|---|---|---|---|
| Q-01 | Spec hiện hành chưa chứa nội dung CR dẫn: spec có được sửa không, hay CR là nguồn duy nhất cho BR mới | MỘT PHẦN | Spec hiện hành đủ (4.2); user: `tailieu/` là bản duy nhất | **Không** (QA test = spec hiện hành + delta CR) | Chặn "Có" → "Không"; câu chuyển từ "thiếu bản sau CR" sang "spec chưa cập nhật theo CR"; thêm bảng 4.3 |
| Q-02 | Hiện trạng thật từng lối | MỘT PHẦN | Spec baseline (2.1); implementation ①② chưa | Không; QA tự đo baseline ①② trên build trước sửa | — |
| Q-03 | "đang hoạt động trong workspace" vs "được assign" | MỘT PHẦN | G007:53, :152; G017:85-86, :235 | Một phần (case ①② Staff chưa assign) | — |
| Q-04 | Assign nhưng DISCONNECTED / lẫn lộn | MỘT PHẦN + MÂU THUẪN | G007 E03, G017 E06, G012 BR06 | **Có** (assign nhưng toàn DISCONNECTED) | — |
| Q-05 | TK dùng để tìm ở lối ③ | ĐÃ TRẢ LỜI | G017:174-178 | Không | — |
| Q-06 | Nút theo trạng thái quan hệ | MỘT PHẦN | G007 AF01-AF02, G017 E07, G012 BR01-BR12 | Có (đang chờ/đến ở ③; kết quả theo từ khoá) | — |
| Q-07 | Nhãn nút | MỘT PHẦN | G007, G017, G012 | Không | — |
| Q-08 | Phản hồi sau khi bấm | MỘT PHẦN | G007 UC-01 b6, E03, E06; G017 E08; G012 E01-E03 | Một phần (lỗi gửi ①②③, hạn mức Zalo) | — |
| Q-09 | Hậu điều kiện khi gửi không có hội thoại | MỘT PHẦN | G007 BR08, UC-01 b7; G017 BR20-BR21; G032 BR11 | Có (ai thấy lời mời; "danh bạ" sau gửi) | Bỏ so sánh bản G032 "Đặt" |
| Q-10 | Phân quyền phía server | MỘT PHẦN | Chỉ ④ (G012 E04); G017 :117 | **Có** (API/security ①②③) | — |
| Q-11 | Đổi assign/kết nối khi phiên mở | MỘT PHẦN | G003 BR12 :308; G012 E04, :299 | Có (①②③, ngưỡng thời gian) | — |
| Q-12 | Môi trường & dữ liệu test | VẪN MỞ | — | Chặn THỰC THI, không chặn viết kỳ vọng | — |
| Q-13 | Phạm vi 4 dòng ma trận & "Quản lý nhóm" | MỘT PHẦN | "Quản lý nhóm" = G008 BR05-BR06 | Một phần (R-01, phạm vi) | — |
| Q-14 | CR-002 + BR20 | VẪN MỞ | — | Chặn case TK thứ 11+ | CR-002 vẫn thiếu thật; BR20 = dẫn chiếu treo (spec chưa cập nhật) |
| Q-15 | Trùng mã BR18 | ĐÃ TRẢ LỜI | G003:314 | Không | — |
| Q-16 | Admin có cần assign | MỘT PHẦN | G003 BR11, G017:396 vs G007:152, L169 | Có (case Admin) | Bỏ dẫn G032 bản "Đặt" |
| Q-17 | **MỚI** BR26 "hiện ngay" vs 2 bước G017 | MỚI | — | **Có** (lối ③) | — |
| Q-18 | **MỚI** Điều kiện chung ma trận §6 vs G032 BR06/BR10 | MỚI (thu hẹp) | User xác nhận bản (1) hiệu lực | Có (chỉ dòng ma trận 5, R5) | Đóng "bản nào hiệu lực"; bỏ "CR trỏ nhầm BR06"; BR08 → BR10 |
| Q-19 | **MỚI** Vai "Nhân viên quản lý" | MỚI | — | Có (bộ TK test, R2) | — |
| Q-20 | **MỚI** Phạm vi Danh bạ / "có trong danh bạ" | MỚI | — | **Có** (khối ③ hiện/ẩn, rò rỉ) | — |
| Q-21 | **MỚI** Tham chiếu mã BR/mục CR lệch spec hiện hành | MỚI (thu hẹp) | — | Không chặn (truy vết) | Bỏ phần "version v1.2 không có file"; BR20/24/26 sang Q-01/Q-14 |

Thống kê 16 câu cũ: ĐÃ TRẢ LỜI 2 · MỘT PHẦN 12 · VẪN MỞ 2 · SAI 0 (không đổi số lượng sau 2 quyết định; chỉ Q-01 hết chặn). Câu mới: 5 (Q-18, Q-21 thu hẹp).

### 6.1 Câu hỏi cũ (giữ mã)

### Q-01 — Spec hiện hành chưa chứa nội dung CR dẫn: spec có được sửa không, hay CR là nguồn duy nhất cho BR mới?   [MỘT PHẦN]
- Trích (cũ): "**Spec bị sửa** | G007 v1.2 · G017 v1.1 · PHÂN QUYỀN — Ma trận tổng hợp" (L9); "☑ Business Rule … ☑ Acceptance Criteria" (L154, L157). Câu hỏi cũ: "Tài liệu gốc & AC không có trong repo".
- Quyết định user 2026-10-07: file trong `tailieu/` là bản duy nhất = spec hiện hành; số version CR dẫn chỉ là các lần sửa trực tiếp, không có file bản khác để chờ.
- Đã trả lời: spec hiện hành có đủ G007, G017, G012, G002, G003, G001, G032 và AC để dựng baseline/regression (G007 §9 :246-314, G017 §11 :403-476, G012 §11 :245-268).
- Spec hiện hành CHƯA chứa (= chưa cập nhật theo CR / dẫn chiếu treo): G007 BR18, BR19 và "BR20" (spec chỉ BR01-BR17); G017 BR24, BR26 (spec BR01-BR23, không BR25); Ma trận §6 (Ma trận không tồn tại); AC của các BR trên (phiếu không chép); chuỗi "Kết bạn ngay"; "R-01". Dòng cần sửa: mục 4.3.
- Câu hỏi cho BA: spec G007/G017/Ma trận có được sửa theo CR-001 không, hay CR-001 là nguồn duy nhất cho các BR mới (và nếu sửa thì theo bảng 4.3 có đúng không)?
- QA xử lý (không chặn): test theo spec hiện hành (baseline + regression) + delta trong CR (BR18, BR19, G017 BR24, BR26, ma trận §6); BR mới gắn nhãn "nguồn: CR-001 only" cho tới khi BA trả lời.

### Q-02 — CR "chỉ viết rõ" hay thay đổi hành vi? Hiện trạng thật của từng lối   [MỘT PHẦN]
- Trích (cũ): "Phân loại … nghiệp vụ đã có … Không tạo Spec mới, không đổi quy tắc" (L190) vs "② Gỡ điều kiện quyền 'Quản lý tài khoản Zalo' khỏi các lối vào kết bạn" (L192) vs "vấn đề nằm ở ba lối còn lại" (L90).
- Đã trả lời (phần spec): spec hiện hành KHÔNG có điều kiện "Quản lý tài khoản Zalo" ở ①②③ — G007:43-45 "Toàn bộ thao tác" cho cả 3 vai; G007:53 tiên quyết chỉ "≥1 tài khoản Zalo đang hoạt động trong workspace"; G017:397 "Staff được assign tài khoản Zalo … ✅". Lời BA "không đổi quy tắc" đúng ở mức spec; điều kiện QLTK chỉ có ở implementation (CR L27-28). Baseline từng lối: mục 2.1.
- Còn mở: implementation hiện tại của ① và ② với nhân sự không có quyền (ẩn / disable / toast / bình thường?) — khách chỉ mô tả lối ③ và đường vòng ④.
- Đề xuất: QA tự chạy baseline ①② trên build TRƯỚC khi Dev sửa (cần build + 2 TK nhân sự có/không QLTK); BA/Dev xác nhận lối nào có code gate cần gỡ. Không còn chặn kỳ vọng "sau sửa".

### Q-03 — "Tài khoản đang hoạt động trong workspace" vs "được assign"   [MỘT PHẦN]
- Trích (cũ): UC-01 tiên quyết "Có ít nhất 1 tài khoản Zalo đang hoạt động **trong workspace**" (L101) vs BR18 "**được assign** ít nhất 1 tài khoản Zalo đang CONNECTED" (L119).
- Đối chiếu spec: G007:53 "**Điều kiện tiên quyết:** Có ít nhất 1 tài khoản Zalo đang hoạt động trong workspace." (CR trích đúng); G007:152 BR10 "Dropdown chỉ liệt kê tài khoản Zalo đang hoạt động mà user hiện tại được assign"; G017:85-86 "Với Staff: đã được assign vào ít nhất một tài khoản Zalo qua G002" + "Workspace có ít nhất một tài khoản Zalo **Đang hoạt động**"; G017:235 E04. Spec không có E-code cho ①② khi Staff chưa assign (nút hiện, dropdown rỗng? popup không mở?). BR18 của CR giải quyết ý định (theo assign) nhưng chưa nói UI.
- Còn mở: biểu hiện UI ①② khi Staff chưa assign (ẩn nút hay hiện + trạng thái rỗng, câu chữ).
- Đề xuất: theo BR18; BA chốt UI ①② và cập nhật G007:53/:65 (4.3). Tạm dùng câu G017 E04 cho trạng thái rỗng, ghi "giả định".

### Q-04 — Hành vi khi TK được assign nhưng DISCONNECTED (hoặc lẫn lộn)   [MỘT PHẦN + MÂU THUẪN]
- Trích (cũ): "Không → Không thấy khối Tìm và Kết bạn / G017 E04" cho nhánh "Được assign ít nhất 1 tài khoản Zalo đang CONNECTED?" (L74-75) vs E04 "chưa assign" (L105).
- Đối chiếu spec (TK DISCONNECTED, theo từng lối): ④ ẩn nút — "Khi tài khoản Zalo DISCONNECTED → ẩn nút (cả nút gửi lẫn 2 nút nhận)" (G012:158); ①② toast — "E03 | Tài khoản Zalo được chọn bị ngắt kết nối | Toast: 'Lỗi kết nối. Vui lòng thử lại'" (G007:130); ③ toast — "E06 … Toast: 'Tài khoản Zalo «[tên]» đang mất kết nối. Vui lòng chọn tài khoản khác hoặc kết nối lại.'" (G017:237) và AC "Chọn tài khoản đang Ngắt kết nối rồi bấm → toast báo lỗi, gợi ý chọn tài khoản khác" (G017:458).
- Mâu thuẫn: (1) G007 BR10 (:152) chỉ liệt kê TK "đang hoạt động" nhưng G007 E03 và G017 E06 giả định user CÓ THỂ chọn TK ngắt kết nối (G017 BR08 chỉ lọc theo assign, :279) → dropdown có/không liệt kê TK DISCONNECTED? (2) CR sơ đồ (L74-75) nói không có TK assign CONNECTED → "không thấy khối", còn G017 E04 chỉ cho "chưa assign" (trạng thái rỗng) và §10E (:399) không nhắc CONNECTED → assign nhưng toàn DISCONNECTED: ẩn khối hay hiện khối + toast E06? (3) ①②③④ cho 4 kiểu phản hồi khác nhau với cùng sự kiện, trong khi BR19 nói bình đẳng.
- Còn mở: kỳ vọng cho "assign ≥1 nhưng 0 CONNECTED" và "lẫn lộn".
- Đề xuất: BA chốt ma trận {chưa assign | assign toàn DISCONNECTED | lẫn lộn} x {①②③④} → ẩn/disable/toast + câu chữ; phân biệt "bình đẳng về quyền" (BR19) với "bình đẳng về hành vi lỗi".

### Q-05 — Lối ③: "tài khoản dùng để tìm" được xác định thế nào   [ĐÃ TRẢ LỜI]
- Trích (cũ): "Bước 2 Chọn tài khoản Zalo … (BR10)" (L47) vs sơ đồ sau sửa không có bước chọn (L73-78) vs "gửi qua đúng tài khoản Zalo đã dùng để tìm — không hỏi lại" (L122).
- Trả lời (G017, AF02): "5a.i. Ô chọn tài khoản chỉ liệt kê tài khoản Zalo mà user **được assign qua G002**" (G017:174); "5a.ii. Nếu chỉ có **1** tài khoản khả dụng → tự chọn sẵn, **ẩn** ô chọn" (G017:175); "5a.iii. Mặc định chọn tài khoản user **dùng gần nhất**" (G017:176); "6a. User bấm **'Tìm & Kết bạn'** → System mới tra cứu qua tài khoản đã chọn" (G017:178); sequence "Chọn tài khoản Zalo + bấm nút … Tra cứu qua tài khoản Zalo đã chọn" (G017:124-126). Kết luận: tra cứu chạy trên MỘT TK đã chọn ở ô "Tài khoản Zalo thực hiện" (không tìm đa tài khoản); "đúng TK vừa dùng để tìm" = TK trong ô đó, không hỏi lại sau khi có hồ sơ. Ghi nhớ kết quả theo cặp (SĐT + TK) — G017:298, AC :441.
- Lưu ý baseline: sơ đồ "Sau khi sửa" của CR (L72-79) lược bỏ bước chọn TK và bước bấm "Tìm & Kết bạn" — rút gọn hay đổi hành vi xem Q-17. Khác biệt ①② ("mặc định trống, không tự động chọn", G007:56, :143) vs ③ (tự chọn sẵn) là có sẵn trong spec.

### Q-06 — Điều kiện hiển thị nút trên kết quả theo trạng thái quan hệ   [MỘT PHẦN]
- Trích (cũ): "nút Kết bạn hiện ngay trên kết quả" (L32, L122), "đúng như §7a đang ghi" (L122).
- Đã trả lời một phần: ①② popup — chưa kết bạn: "Kết bạn" + "Nhắn tin"; đã là bạn: "chỉ hiển thị button Nhắn tin, ẩn button Kết bạn" (AF01, G007:109); đang chờ: "Đã gửi lời mời (disabled) + button Thu hồi" (AF02, G007:112); block: "Không tìm thấy" không lộ (G007:132, BR06 :148). ③ — đã là bạn: toast "Đã là bạn bè" + "Mở hội thoại" (E07, G017:238); SĐT đã có trong danh bạ: không hiện khối (BR07, :278; AF01 :157). ④ — đủ 4 trạng thái: chưa kết bạn/đã gửi/có lời mời đến/đã là bạn (G012:50-56, :172-183). "§7a" trong CR là bước 7a của AF02 (G017:179), không có mục §7a (G017 §7 = State Machine "N/A", :306-308).
- Còn mở: (a) ③ — SĐT đang có lời mời chờ (mình đã gửi) hoặc đối phương đã gửi cho mình: G017 không có luồng (sau tra cứu chỉ hiện "Gửi lời mời kết bạn", :179); (b) ①②③ — có lời mời ĐẾN: G007 popup không xử lý (G012 BR07 chỉ ở ④); (c) kết quả là chính TK Zalo trong workspace; (d) kết quả từ tìm từ khoá (không phải SĐT) — G017 chỉ hiện khối cho SĐT; nếu BR26 muốn "nút trên kết quả" cho hàng nhóm Người liên hệ thì xem Q-17.
- Đề xuất: BA liệt kê trạng thái quan hệ x nút x lối; QA dùng G007/G017/G012 làm baseline cho các ô đã có.

### Q-07 — Nhãn nút không thống nhất   [MỘT PHẦN]
- Trích (cũ): "nút 'Kết bạn ngay'" (L27), "Kết bạn" (L49, L76, L88), "Gửi lời mời kết bạn" (L122, L163).
- Đối chiếu spec — chuỗi UI hiện hành theo lối: ① header "Kết bạn" (G003:398, G007:55); ② "Thêm bạn" (G007:67); popup ①②: "Tìm kiếm", "Kết bạn", "Nhắn tin", sau gửi "Đã gửi lời mời" + "Thu hồi" (G007:56-60); ③ khối "Tìm & Kết bạn" → "Gửi lời mời kết bạn" (G017:171, :179); ④ "Kết bạn" → dialog "Bạn có muốn gửi lời mời kết bạn đến [tên]?" "Xác nhận"/"Hủy" → "Đã gửi lời mời" (G012:77-82); banner sau xoá bạn "Gửi kết bạn" (G007:98). **"Kết bạn ngay" (L27, L76) KHÔNG xuất hiện trong spec hiện hành nào** (Grep toàn `tailieu/`) → cách gọi của khách / dẫn chiếu treo của CR.
- Còn mở: không chặn; chuỗi chuẩn sau CR cho ③ ("Gửi lời mời kết bạn" hay "Kết bạn") thuộc Q-17.
- Đề xuất: so UI theo bảng chuỗi ở trên; BA xác nhận nếu CR muốn đổi nhãn.

### Q-08 — Phản hồi sau khi bấm: thành công / lỗi / lời nhắn kèm   [MỘT PHẦN]
- Trích (cũ): "Bấm Kết bạn → gửi lời mời qua tài khoản đã chọn" (L49), "Đã gửi lời mời kết bạn" (L58).
- Đã trả lời một phần: thành công ①②: nút → "Đã gửi lời mời" + "Thu hồi", lời mời vào tab Đã gửi (G007:60-61); ④: nút → "Đã gửi lời mời" disabled (G012 BR02 :154); lỗi: G007 E06 toast "Lỗi kết nối. Vui lòng thử lại" + ghi log (:133); G017 E08 "Vui lòng thử lại" (:239); G012 E01 "Không thể thực hiện, vui lòng thử lại", nút giữ nguyên (:131), E02 "Lỗi hệ thống. Vui lòng thử lại sau" (:132), E03 "Mất kết nối, vui lòng thử lại" (:133); bấm đúp: G017 nút vô hiệu trong lúc tra cứu (:389, AC :435), G012 disabled sau khi gửi. Lời nhắn kèm: popup/khối không có ô lời nhắn gửi đi (lời nhắn chỉ ở tab Đã nhận, G007:82); G012 OOS04 (:279).
- Còn mở: lỗi riêng của hành động "Gửi lời mời" ở ③ (G017 chỉ định nghĩa E05-E08 cho bước TRA CỨU), hạn mức lời mời của Zalo, SĐT chưa cho phép nhận lời mời.
- Đề xuất: BA xác nhận ③ dùng lại E-code G007/G012 cho bước gửi.

### Q-09 — Hậu điều kiện dữ liệu khi gửi lời mời mà chưa có hội thoại   [MỘT PHẦN]
- Trích (cũ): "Không có dữ liệu nào. Đây là quy tắc hiển thị nút, không sinh dữ liệu" (L146) vs "Thu hồi lời mời đã gửi" (L164) vs "Không yêu cầu mở hội thoại" (L122).
- Đã trả lời một phần: **không tạo hội thoại** — "BR08 | Kết bạn và nhắn tin là 2 hành động độc lập — kết bạn thành công không tự tạo hội thoại" (G007:150); lời mời hiện ở tab Đã gửi để Thu hồi (G007:61, :73-76); ③ sau khi gửi thành công: xoá bản ghi nhớ tra cứu (G017 BR20, :299) và "thêm người đó vào danh bạ ngay lập tức" (G017 BR21, :300). Tên gợi nhớ: G032 BR11 (:145) hẹn ghi lên Zalo khi quan hệ thành bạn bè (không ghi lúc mới gửi lời mời) — đã rõ. Phiếu nói "không sinh dữ liệu" (L146) nhưng spec cho thấy gửi lời mời sinh/đổi dữ liệu (lời mời chờ, bản ghi danh bạ, xoá cache) → L146 chỉ đúng với "quy tắc hiển thị nút".
- Còn mở: (a) "danh bạ" của G017 BR21 là danh bạ liên hệ, còn G007 UC-04 Danh bạ = "liên hệ là bạn bè" (G007:89) — người mới chỉ ở PENDING có xuất hiện ở màn Danh bạ không (Q-20); (b) nhân sự khác cùng assign TK có thấy lời mời chờ không (G007 không nói lời mời theo user hay theo TK).
- Đề xuất: BA chốt (a)(b); QA kiểm theo BR08 + BR20/BR21 + G032 BR11 cho phần đã nêu.

### Q-10 — Phân quyền phía server (API) chưa được nêu   [MỘT PHẦN]
- Trích (cũ): "Đây là quy tắc hiển thị nút" (L146); "chỉ kết bạn được qua tài khoản Zalo mình được assign … phạm vi không đổi một milimet" (L147).
- Đã trả lời một phần: spec có tiền lệ server-side: ④ "E04 | Người dùng không còn quyền truy cập hội thoại khi gọi API (thu hồi phân quyền giữa chừng) | Toast: 'Bạn không có quyền thực hiện thao tác này' + ghi log truy cập trái phép" (G012:134); G017 sequence "Server->>Server: Tìm … (giới hạn theo quyền của user)" (G017:117) và BR03 (:274); G032 AC "gọi API thẳng → từ chối + ghi log" (G032:309). Cho hành động gửi lời mời ở ①②③ bằng TK không assign / bởi user chưa assign: không có dòng nào. Cũng không nêu server từng chặn theo quyền QLTK chưa.
- Còn mở: kỳ vọng API ①②③ (mã lỗi/thông điệp/log) — điểm security chính của CR.
- Đề xuất: BA/Dev xác nhận có kiểm assign ở API gửi lời mời; QA thêm case API (qa-api-test): TK không assign → từ chối; user chưa assign → từ chối; chéo workspace → từ chối. Mẫu thông điệp có thể bám G012 E04 nhưng cần BA xác nhận.

### Q-11 — Thay đổi assign / kết nối khi phiên đang mở   [MỘT PHẦN]
- Trích (cũ): "chỉ còn một điều kiện duy nhất" (L85, L119); không nêu cập nhật tức thì.
- Đã trả lời một phần: unassign → hội thoại "ẩn khỏi danh sách ngay lập tức" (G003 BR12, :308); ④ mất quyền giữa chừng → E04 (G012:134, AC :268); ④ nút cập nhật "không cần reload trang" khi đối phương chấp nhận/từ chối (G012:299); DISCONNECTED → ẩn nút ④ (G012 BR06). ①②③: không nêu.
- Còn mở: ①②③ và ngưỡng thời gian đo được.
- Đề xuất: BA nêu hành vi ①②③ + ngưỡng; nếu không, QA chỉ test sau tải lại và ghi giới hạn.

### Q-12 — Môi trường & dữ liệu test, tác dụng phụ lên khách thật   [VẪN MỞ]
- Trích (cũ): không có phần nào về môi trường/data (kể cả trong spec hiện hành).
- Cập nhật: spec không bổ sung; chỉ thêm ràng buộc: ghi nhớ 7 ngày theo (SĐT + TK) (G017:298) và rủi ro Zalo hạn chế/khoá TK vì tra cứu nhiều (G017:482, :519).
- Vì sao: cần môi trường, tài khoản vai trò, TK Zalo CONNECTED/DISCONNECTED thử, SĐT thử, giới hạn lời mời Zalo.
- Đề xuất: BA/Dev cấp tài khoản + SĐT thử; không dùng SĐT khách thật. Chặn THỰC THI, không chặn viết kỳ vọng.

### Q-13 — Phạm vi 4 dòng còn lại của Ma trận §6 và quyền "Quản lý nhóm"   [MỘT PHẦN]
- Trích (cũ): "Điều kiện chung cho cả 5 dòng …" (L169); "KHÔNG yêu cầu quyền 'Quản lý nhóm'" (L119); Việc cho Dev chỉ nêu ① và ② (L192); "BR11 ⚠️ xem R-01" (L166).
- Đã trả lời một phần: "Quản lý nhóm" là quyền có thật của G008 — "Chỉ Admin workspace + nhân viên có quyền 'Quản lý nhóm' được: tạo nhóm, thêm thành viên" (G008:290), nhân viên không có quyền thấy danh sách nhóm nhưng ẩn các nút tạo/sửa/thêm (G008:292) → vế "không đòi Quản lý nhóm" ở BR18 chỉ có nghĩa khi kết bạn có điểm vào trong luồng nhóm (CR không nêu điểm vào nào; G007 không có điểm vào từ nhóm).
- Còn mở: R-01 không được định nghĩa ở đâu (Grep `R-01` toàn `tailieu/` chỉ ra đúng L166 của CR) — dẫn chiếu treo. Gợi ý BA kiểm tra: G007 BR11 (:153) chọn TK xoá bạn là "tài khoản Zalo đầu tiên mà liên hệ đó có chung với user" khi xem "Tất cả" — chưa nêu có giới hạn theo TK được assign. Phạm vi QA cho Thu hồi / Chấp nhận-Từ chối / Xoá bạn / Tên gợi nhớ (in-scope hay chỉ tài liệu hoá) chưa chốt.
- Đề xuất: BA nêu R-01 và xác nhận phạm vi; mặc định QA kiểm 4 dòng ở mức "không đòi QLTK" (smoke theo vai) + regression R5.

### Q-14 — CR-002 (danh sách tài khoản bị cắt ở 10) và "BR20"   [VẪN MỞ]
- Trích (cũ): "danh sách tài khoản đang bị cắt ở 10 … nhân sự được phân quyền tài khoản thứ 11 trở đi **không chọn được**" (L92); BR20 "xem CR-002" (L47).
- Phân loại lại: (a) CR-002 KHÔNG tồn tại (Glob + Grep) → thiếu thật. (b) "BR20" CR đặt trong bảng bước của G007 (L47) nhưng G007 hiện hành chỉ có BR01-BR17 (G007:142-159) → dẫn chiếu treo / spec chưa cập nhật (Q-01, dòng 4.3), không phải "thiếu bản". BR20 duy nhất trong spec là G017 BR20 "Bản ghi nhớ tra cứu bị xoá ngay khi gửi lời mời kết bạn thành công" (G017:299), không liên quan hiển thị/cuộn danh sách. Spec không nêu giới hạn 10 ở đâu.
- Còn mở: BR20 sẽ nằm trong spec nào; thứ tự phát hành CR-002.
- Đề xuất: BA xác nhận; nếu CR-002 chưa có thì loại case 11+ khỏi CR-001, ghi ràng buộc đã biết.

### Q-15 — Trùng mã BR18 giữa G003 và G007   [ĐÃ TRẢ LỜI]
- Trích (cũ): G003 BR26 Case A "người đó thấy và nhắn được ngay dù không có quyền **BR18**" (L108) vs G007 "BR18 *(mới)*" (L119).
- Trả lời: "BR18 | Staff có quyền 'Hiển thị cuộc hội thoại chưa gắn nhân sự' (cấu hình trong G002) mới thấy hội thoại chưa được assign" (G003:314). Cụm "không có quyền BR18" trong G003 BR26 (G003:322; AC :609) là quyền "Hiển thị cuộc hội thoại chưa gắn nhân sự", KHÔNG liên quan "Quản lý tài khoản Zalo" → không mâu thuẫn nội dung với G007 BR18 mới.
- Còn lại (quy ước QA): mã BR18 trùng ở ba tài liệu — G003 BR18, G017 BR18 "Tin nhắn vừa nhận cần một khoảng rất ngắn trước khi tìm được" (G017:289), G007 BR18 mới (CR L119). QA luôn ghi kèm tiền tố tài liệu.

### Q-16 — Phạm vi vai trò Admin trong điều kiện "assign ≥1 tài khoản"   [MỘT PHẦN]
- Trích (cũ): "Điều kiện chung cho cả 5 dòng: được assign ≥1 tài khoản Zalo đang CONNECTED" áp cho cột Admin (L169, L161); G017 §1 "Admin hoặc Staff được phân quyền" (L104).
- Đã trả lời một phần (Admin KHÔNG cần assign ở nơi khác): "BR11 | Admin/Owner thấy tất cả hội thoại của tất cả tài khoản Zalo trong workspace — không cần assign" (G003:307); G017 §10E "Admin/Owner | Toàn workspace | Mọi tài khoản trong workspace | ✅" (G017:396); G017 BR03 "Admin/Owner tìm trong toàn workspace" (:274).
- Mâu thuẫn: G007:152 BR10 nói chung "tài khoản … mà user hiện tại được assign" và G007:354 "không phải toàn bộ workspace", không ngoại lệ Admin; CR L169 áp điều kiện assign ≥1 CONNECTED cho cả Admin.
- Còn mở: Admin/Owner chưa assign TK nào: ①②③ dùng được không, dropdown liệt kê TK nào.
- Đề xuất: BA xác nhận Admin bypass assign ở cả 4 lối (theo G003 BR11, G017 §10E) và sửa câu chữ L169/G007 BR10.

### 6.2 Câu hỏi mới (từ rà soát 2026-10-07)

### Q-17 — BR26 "nút hiện NGAY trên kết quả" so với luồng hai bước hiện hành của G017   [MỚI — CHẶN lối ③]
- Trích CR-001: "**Nút 'Gửi lời mời kết bạn' hiện NGAY trên kết quả tìm kiếm** *(đúng như §7a đang ghi)*. **Không** yêu cầu mở hội thoại, **không** yêu cầu nhắn tin trước. Lời mời gửi qua **đúng tài khoản Zalo đã dùng để tìm** — không hỏi lại" (L122); sơ đồ sau sửa: "Thấy khách trong kết quả tìm kiếm kèm nút Kết bạn ngay tại đó 【MỚI — G017 BR26】" (L76); "gõ số điện thoại vào ô tìm kiếm → tìm ra người → nút Kết bạn hiện ngay trên kết quả" (L32).
- Trích G017 (spec hiện hành): "**6a.** User bấm **'Tìm & Kết bạn'** → System mới tra cứu qua tài khoản đã chọn" rồi "**7a.** Tìm thấy → hiện hồ sơ người đó *(avatar, tên)* + nút **'Gửi lời mời kết bạn'**" (G017:178-179); "BR06 | Hệ thống **không bao giờ tự gọi sang Chat-Zalo Service** khi user gõ. Chỉ gọi khi user **chủ động bấm 'Tìm & Kết bạn'**" (G017:277); "BR07 | Khối 'Tìm & Kết bạn' chỉ hiện khi thoả **cả hai**: đầu vào là số điện thoại **và** số đó không có trong danh bạ" (G017:278); hàng nhóm Người liên hệ hiển thị "Avatar · tên · số điện thoại" — không có nút kết bạn (G017:142).
- Vì sao chưa viết được kỳ vọng: "hiện ngay trên kết quả" có ba cách hiểu loại trừ nhau. (1) Bước 7a hiện hành (sau khi bấm Tìm & Kết bạn) — D1 không là hành vi mới, chỉ là sửa implementation cho đúng spec (khớp "đúng như §7a đang ghi"). (2) Bỏ bước bấm "Tìm & Kết bạn": phải tra Zalo ngay khi gõ → phá BR06 (rủi ro Zalo khoá TK, G017:562) và phá AC "gõ liên tục … không phát sinh lượt tra cứu" (G017:433). (3) Nút Kết bạn trên hàng kết quả nội bộ (Người liên hệ/Hội thoại) cho người chưa là bạn: spec không có và mâu thuẫn BR07. Sơ đồ CR cũng bỏ qua bước chọn TK + bước bấm nút nên không đủ để suy ra.
- Đề xuất QA: BA chốt 1 trong 3 và vẽ lại sơ đồ "Sau khi sửa" (L72-79) đủ bước; QA tạm viết theo cách hiểu (1) gắn nhãn "giả định", thêm kiểm "không gọi Zalo khi chưa bấm" (R8).

### Q-18 — Điều kiện chung của ma trận §6 có khớp G032 BR06 (quyền) và BR10 (CONNECTED) không?   [MỚI, thu hẹp — CHẶN dòng ma trận 5 / R5]
- **Đã đóng (user xác nhận 2026-10-07):** bản G032 hiệu lực là `G032 - Đổi tên gợi nhớ (1).md` (v1.0, 2026-09-22); bản "Đặt tên gợi nhớ" không dùng. CR-001 dẫn "G032 BR06" cho quyền là ĐÚNG — "BR06 | **Quyền:** có quyền **xem hội thoại** *hoặc* **xem danh bạ** là đổi được. **KHÔNG** yêu cầu quyền 'Quản lý tài khoản Zalo'" (G032:140). Nhận định "CR trỏ nhầm BR" đã BỎ. Đã Grep kiểm mã trong bản (1): BR05 = gỡ tên (:139), BR06 = quyền (:140), BR08 = ghi lên tất cả TK liên quan (:142), BR10 = điều kiện CONNECTED (:144), BR11 = khách chưa kết bạn (:145) → mọi chỗ trích điều kiện CONNECTED dùng BR10.
- Trích CR-001 còn lại: "Đặt tên gợi nhớ cho liên hệ | … | ✓ | ✓ | **✓** | **G032 BR06**" (L167) và "Điều kiện chung cho cả 5 dòng: được assign **≥1 tài khoản Zalo đang CONNECTED** (G002)" (L169).
- Trích G032 hiệu lực: quyền = xem hội thoại hoặc danh bạ, không nhắc "assign ≥1 TK CONNECTED" (G032:140); "BR10 | **TẤT CẢ tài khoản liên quan** phải đang **CONNECTED** mới mở được màn đổi tên … Áp cả đặt tên lẫn gỡ tên. Không xét: tài khoản chưa kết bạn với liên hệ …" (G032:144; AC :318-322); khách chưa kết bạn vẫn đặt được tên, không bị chặn bởi CONNECTED (G032:145, AC :325-326); điểm vào gồm Danh bạ (UC-02, :66-75) khớp G007 UC-04 "Option … Đổi tên" (G007:90).
- Vì sao chưa viết được kỳ vọng dòng ma trận 5: hai điều kiện lệch — CR: điều kiện chung "assign ≥1 TK CONNECTED"; G032: quyền "xem hội thoại/danh bạ" và kết nối "TẤT CẢ TK liên quan CONNECTED" (có 1 TK CONNECTED nhưng 1 TK liên quan DISCONNECTED → G032 chặn, CR "chung" cho phép; nhân sự có quyền xem hội thoại/danh bạ mà không assign đúng TK nào → G032 cho, CR chặn).
- Đề xuất QA: BA xác nhận hàng "Đặt tên gợi nhớ" chỉ trỏ về G032 BR06/BR10 (điều kiện riêng) hay tuân điều kiện chung L169; tới đó QA test hàng này theo G032 (spec hiện hành), chỉ giữ chung "không đòi QLTK". R5 giữ nguyên.

### Q-19 — Vai "Nhân viên quản lý" / "NS Quản lý" là gì so với quyền "Quản lý tài khoản Zalo"?   [MỚI — CHẶN bộ TK test]
- Trích CR-001: ma trận cột "Admin | NS Quản lý | Nhân sự" (L161); "Admin/Owner · Nhân viên quản lý · **Nhân viên thường** — cả ba đều 'Toàn bộ thao tác'" (L100).
- Trích spec: "| Nhân viên quản lý | Nhân viên có role quản lý | Toàn bộ thao tác |" (G007:44). Mọi nơi khác chỉ có quyền (permission) "Quản lý tài khoản Zalo": "Staff có quyền 'Quản lý tài khoản Zalo' — toàn quyền tương đương" (G002:26; G001:26), ma trận G002 cột "Staff có quyền 'Quản lý Zalo'" (G002:147). G017 §10E chỉ có 4 hàng: Admin/Owner, Staff được assign, Staff + quyền "Hiển thị cuộc hội thoại chưa gắn nhân sự", Staff chưa assign (G017:396-399). Grep toàn `tailieu/`: "Nhân viên quản lý" chỉ ở G007:26, :44 và CR-001; "role quản lý" không được định nghĩa ở đâu.
- Vì sao chưa viết được: không biết "NS Quản lý" là (a) chính là Staff có quyền QLTK Zalo (khi đó cột "NS Quản lý" = nhân sự đối chiếu "CÓ quyền", CR L27), hay (b) một role độc lập với quyền riêng. Không biết thì không thiết kế được bộ TK test (3 hay 4 vai) và R2.
- Đề xuất QA: BA nêu định nghĩa vai "Nhân viên quản lý" và quan hệ với quyền QLTK Zalo ngay trong ma trận §6 (Ma trận cần được tạo).

### Q-20 — "Có trong danh bạ" của BR07 tính theo danh bạ toàn workspace hay theo TK nhân sự được assign?   [MỚI — CHẶN khối ③ + test rò rỉ]
- Trích spec: "BR07 | Khối 'Tìm & Kết bạn' chỉ hiện khi … số đó không có trong danh bạ" (G017:278); "Danh bạ Zalo đã đồng bộ | Nguồn dữ liệu nhóm Người liên hệ và cơ sở quyết định có hiện khối kết bạn hay không (BR07)" (G017:502); G007 UC-04 "Hiển thị danh sách tất cả liên hệ là bạn bè của ít nhất 1 tài khoản Zalo trong workspace" (G007:89) và AC "Hiển thị bạn bè của tất cả tài khoản Zalo đang hoạt động trong workspace (BR04)" (G007:295); ngược lại "Phạm vi tìm của Staff = hội thoại thuộc tài khoản Zalo được assign qua G002" (G017 BR03, :274); CR: "chỉ kết bạn được qua tài khoản Zalo mình được assign … phạm vi không đổi một milimet" (L147); khối ③ "hiện với mọi nhân sự được assign ≥1 TK" (BR24, L121).
- Vì sao chưa viết được kỳ vọng: nếu SĐT X đã là bạn của TK C (workspace có, nhân sự A không được assign C) mà A chỉ được assign TK B: nếu "danh bạ" = toàn workspace → khối ③ không hiện dù A có thể kết bạn X qua B (BR24 "hiện với mọi nhân sự assign ≥1" không còn đúng) và A thấy liên hệ của TK C (rò rỉ trái R3/L147); nếu theo assign → khối hiện. Không biết thì không đặt được kỳ vọng hiện/ẩn và không thiết kế được case rò rỉ cho `security-test`.
- Đề xuất QA: BA xác nhận phạm vi danh bạ dùng cho BR07 và cho màn Danh bạ của nhân sự (toàn workspace hay theo assign); gắn vào G007 BR18/G017 BR24.

### Q-21 — Tham chiếu mã BR/mục của CR-001 lệch spec hiện hành (truy vết)   [MỚI, thu hẹp — không chặn]
- Đã bỏ khỏi câu này (theo quyết định 2): nhận định "G007 v1.2 không có file" và "BR20/BR24/BR26 chưa có bản sau CR" — nay thuộc Q-01 (spec chưa cập nhật theo CR; bảng 4.3) và Q-14 (BR20/CR-002). Header G007 ghi v1.1 còn CR gọi "v1.2/v1.3" được hiểu là các lần sửa trực tiếp; QA lấy file trong `tailieu/` làm hiện hành.
- Còn lại:
  - G017: CR thêm "BR24, BR26 mới" (L157) nhưng không có BR25; spec kết thúc ở BR23 (G017:266 "BR19–BR23") → BR25 có bị bỏ sót không.
  - "§7a" (L122): G017 không có mục 7a; chỉ có bước 7a trong AF02 (G017:179); §7 là State Machine N/A (G017:306-308).
  - Mã BR18 trùng ba tài liệu: G003-BR18 (:314) · G017-BR18 (:289) · G007-BR18 mới — xem Q-15.
  - G003: CR trích `G003:400`, `G003:324`, `G003:615` (L106, L108); spec G003 hiện hành (v1.11): §10B ở :398, BR26 ở :322, AC BR26 ở :609 → lệch 2-6 dòng, có thể G003 đã sửa sau khi CR trích. Nội dung BR26 hiện hành là "mở hội thoại nháp; hội thoại thật tạo khi gửi tin đầu tiên, khi đó auto-assign" (G003:322), còn intake lần đầu hiểu theo L108 "tạo mới, auto-assign cho người click".
- Vì sao quan trọng: truy vết case về BR/AC sai làm kỳ vọng sai; R1 phụ thuộc mốc "auto-assign" của G003 BR26 hiện hành.
- Đề xuất: BA thống nhất tiền tố BR và sửa các mã trên khi cập nhật spec.

Tổng: **21 câu hỏi** (16 cũ + 5 mới). **13 BR delta của CR (nguồn CR) + 26 dòng BR/quy tắc hiện hành đã đối chiếu spec hiện hành** (mục 4).

## 7. Trạng thái & bước tiếp

- Lane: **high-risk** (hard gate `security-test`; flags 3 → 5), status `high-risk-pending-confirmation`.
- Parent DỪNG, xin user xác nhận scope (regression + automation + a11y + exploratory + e2e) và chuyển Q-01…Q-21 cho BA/Dev.
- Cách test đã chốt: spec hiện hành trong `tailieu/` + delta ghi trong CR-001.
- **Còn CHẶN viết kỳ vọng sau khi áp 2 quyết định:** Q-17 (lối ③); Q-04 (assign nhưng toàn DISCONNECTED); Q-10 (API/server ①②③); Q-20 (khối ③ hiện/ẩn + rò rỉ); Q-16 (case Admin); Q-19 (bộ TK test/R2); Q-09 + Q-06 + Q-11 (case biên tương ứng); Q-18 (chỉ dòng ma trận 5); Q-14 (TK thứ 11+). Q-12 chặn thực thi.
- Đã gỡ chặn: Q-01 (quyết định 2), phần "bản G032 nào" của Q-18 (quyết định 1), Q-05, Q-15, Q-02 (kỳ vọng "sau sửa"); Q-03/Q-07/Q-08 chỉ còn chi tiết.
- Có thể bắt đầu ngay: baseline + regression R1, R3, R4 (câu chữ G017 E04), R7, R8 dựa AC spec hiện hành; case ① ② ④ happy path theo luồng spec cho nhân sự không QLTK (khi có Q-02 baseline).

## Lịch sử cập nhật

| Ngày | Người | Thay đổi |
|---|---|---|
| 2026-10-07 | QA | Tạo intake lần đầu: nguồn, delta/regression, flag + lane, 24 BR, 16 câu hỏi |
| 2026-10-07 | QA | Rà soát lại sau khi có tài liệu gốc: đã đối chiếu G001, G002, G003, G007, G012, G017, G032 (cả 2 bản), G033 (CR-002/Ma trận/PROJECT_KNOWLEDGE vẫn chưa có). Thêm mục Baseline trước CR, delta thật, R8. Flag 3 → 5 (thêm `multi-tenant-isolation`, `cross-service-e2e`), lane giữ high-risk. 16 câu cũ: 2 đã trả lời / 12 một phần / 2 vẫn mở / 0 sai; 5 câu mới (Q-17…Q-21) |
| 2026-10-07 | QA | Áp 2 quyết định của user: (1) G032 hiệu lực = `Đổi tên gợi nhớ (1).md`, bản "Đặt tên gợi nhớ" không dùng → đóng phần "bản nào" của Q-18, điều kiện CONNECTED dùng G032 BR10 (đã Grep kiểm; BR08 = ghi lên tất cả TK liên quan), bỏ nhận định "CR trỏ nhầm BR06", bỏ dẫn bản "Đặt" ở Q-09/Q-16/R5/R7; (2) `tailieu/` là bản duy nhất = spec hiện hành → bỏ nhận định "thiếu bản sau CR/chưa kiểm được", Q-01 thành câu hỏi BA "spec chưa cập nhật theo CR" (hết chặn), Q-14 và Q-21 phân loại lại, thêm bảng 4.3 "dòng spec cần sửa nếu áp CR" cho G007/G017; CR-002/Ma trận/PROJECT_KNOWLEDGE vẫn thiếu. Tổng không đổi: 16 câu cũ = 2 đã trả lời / 12 một phần / 2 vẫn mở / 0 sai; 5 câu mới (Q-18, Q-21 thu hẹp) |
