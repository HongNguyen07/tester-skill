---
id: TP-CR-005
feature: CR-005 (không có FEAT spine — nguồn = phiếu CR + spec hiện hành trong tailieu/)
createdBy: QA
createdAt: 2026-10-08
status: Draft          # Draft | Ready | Executing | Signed-off
lane: high-risk
---

# TP-CR-005: Test Plan — Staff có quyền Assign được unassign (gỡ nhân viên khỏi hội thoại)

> **Nguồn AC/US:** project KHÔNG có `wiki/features/FEAT-*.md`. AC-source =
> - Phiếu `tailieu/CR-005 - Staff có quyền assign được unassign.md` (89 dòng; trích `CR:<dòng>`): bảng "Đề nghị đổi thành" §2.2 (6 dòng, CR:26-32), rà xung đột §2.4/§2.4b (CR:42-59), câu hỏi mở (CR:69-70), việc cho Dev (CR:78).
> - Spec hiện hành (BẢN DUY NHẤT, user xác nhận): `tailieu/G003 - Chat.md` (v1.11, 741 dòng: UC-07 `G003:191-197`, BR14-BR16 `G003:310-312`, BR15 `G003:311`, §10F `G003:518-519`, AC `G003:553`, `G003:602-604`) và các spec bị chạm: `G002` (BR04/BR09), `G017` (BR03), `G019` (BR12), `G027` (BR07), `G029` (BR01), `G011a` (BR09), `G014` (AF04/BR19), `G024` (BR08).
> - Phân tích chi tiết: `wiki/qa/intake/INTAKE-CR-005.md` (lane, flag, baseline trước CR §3, delta D1-D9 §4, bảng dẫn chiếu treo §5, 13 dòng spec cần sửa §6, 14 câu hỏi Q-01…Q-14 §12, regression R1-R13 §11).
>
> **Cách test (đã chốt):** spec hiện hành + delta ghi trong CR-005. G003 hiện hành CHƯA chứa nội dung CR (vẫn ghi "Admin only" ở `G003:197`, `:311`, `:603`) → BR mới/đổi (G003-BR15a…e, UC07-b5, CR5-BR-API) gắn nhãn **"nguồn: CR-005 only"** cho tới khi BA trả lời Q-01. `CR5-DRAFT` (bị gỡ giữa chừng) **chưa là BR** → không dùng làm kỳ vọng (Q-07).
>
> **Thông báo / mã lỗi / endpoint / tên field:** dùng NGUYÊN VĂN tài liệu (vd toast "Tài khoản đã ngắt kết nối. Vui lòng kết nối lại" `G003:519`; dự thảo "Bạn không còn phụ trách hội thoại này" `CR:70` chỉ là dự thảo). KHÔNG tự chế mã lỗi/endpoint/tên field; chỗ tài liệu không nêu → case ghi ❓ (mục 5.2).
>
> **Vì chưa có FEAT:** bỏ bước verify claim `owners.qa` / `status.qa` và KHÔNG tick checklist FEAT §4.4 (không có FEAT để tick). Khi BA/orchestrator tạo FEAT cho CR này, backfill `feature:` ở frontmatter và tick lại row "Test plan".
>
> **"assign" ở CR-005 = gán nhân viên vào HỘI THOẠI (G003 UC-07, cấp con), KHÔNG phải "assign tài khoản Zalo" (G002, cấp cha) của CR-001.** Mọi tài khoản/dữ liệu dưới đây ghi rõ "assign hội thoại" hay "assign TK Zalo" để khỏi lẫn khi dựng dữ liệu (mục 3.2).
>
> Test-DESIGN là shift-left, bắt đầu ngay trên spec hiện hành, không chờ build. Quy ước trích dẫn: `G003:311` = file + số dòng spec hiện hành (lấy lại từ intake); mã BR luôn kèm tiền tố tài liệu.

## 1. Scope

- **FEAT / CR:** CR-005 — Staff có quyền Assign hiện chỉ gán được nhân viên vào hội thoại, không gỡ được (chỉ Admin gỡ: `G003:197`, `:311`, AC `:603`); CR cho phép Staff có quyền Assign **gỡ** nhân viên khỏi hội thoại, nới điều kiện kiểm quyền ở cả giao diện lẫn API (CR:28-31, CR:78). BA phân loại: **CR**, đổi quy tắc đã phát hành, **không migration** (CR:51, CR:76-78).

### 1.1 Delta của CR (đối tượng kiểm chính)

| # | Delta | Nguồn | Ghi chú test |
|---|---|---|---|
| D1 | Staff có quyền Assign **unassign** được (trước: chỉ Admin); quyền gán và gỡ "đi liền nhau", UC-07 bước 5 thành "[Admin hoặc Staff có quyền assign]" | CR:28, CR:31 | Trọng tâm. Đối tượng: Staff có Assign (U-SA*). Nhãn "nguồn: CR-005 only" |
| D2 | Gỡ được **bất kỳ ai, kể cả người khác** (không chỉ chính mình) | CR:29 | Tác nhân gỡ người khác trong cùng danh sách phụ trách. "Bất kỳ ai" gồm self / Admin / Staff có Assign hay không → ❓ Q-05 |
| D3 | Gỡ được cả **người cuối cùng** → hội thoại về "chưa phân công"; không chặn (chốt interview 06/10) | CR:29, CR:89 | Phần "ai còn thấy hội thoại, push, badge, BR26" phụ thuộc quyền BR18 → ❓ Q-06. Suy ra được ngay từ BR11/BR18: Admin vẫn thấy; Staff có BR18 thấy; Staff khác không |
| D4 | **Mọi lần gỡ ghi log**: ai gỡ · gỡ ai · khỏi hội thoại nào · lúc nào; không cần màn xem | CR:30 | Mâu thuẫn CR:69 ("log bổ sung sau, không chặn build") và nơi đọc log chưa biết → ❓ Q-10 |
| D5 | Kiểm quyền ở **cả giao diện lẫn API**; quyền là kiểm tra lúc chạy | CR:51, CR:78 | Trọng tâm `security-test`; kỳ vọng API (mã lỗi/thông điệp/log) ❓ Q-09 |
| D6 | Phạm vi **không đổi**: Staff chỉ thao tác trong hội thoại mình xem được ("mở chiều thao tác, không mở tầm với") | CR:28, CR:42 | Case âm tính "ngoài tầm xem" (chỉ kiểm được qua API); tầm xem của Staff có Assign → ❓ Q-03 (G002:139 / G017:274 nói hẹp, G003 BR02 nói rộng) |
| D7 | Dữ liệu cũ: không migration; mọi phân công hiện có giữ nguyên; từ ngày phát hành Staff có Assign gỡ được những phân công đó | CR:51 | Dựng phân công do Admin tạo TRƯỚC khi áp bản sửa (mục 3.2) |
| D8 | Bị gỡ giữa chừng: hội thoại biến khỏi danh sách ngay; đang mở → thông báo rồi đóng | CR:70 | **Chưa là BR** (CR ghi "cần xác nhận hành vi hiện tại") → ❓ Q-07, Q-08 |

### 1.2 KHÔNG đổi (kiểm bằng regression, không kiểm hành vi mới)

- **Admin:** vẫn assign + unassign như cũ (`G003:604`); Admin/Owner vẫn thấy mọi hội thoại không cần assign (G003 BR11, `G003:307`).
- **Staff KHÔNG có quyền Assign:** icon `Assign` vẫn **không hiển thị** (`G003:518`); gọi API gỡ vẫn bị từ chối (BR-C06, CR:48; kỳ vọng API ❓ Q-09).
- **Staff có quyền Assign vẫn gán được** (UC-07, BR14, BR16): không hồi quy phần "gán".
- **"Thay thế" hàng loạt (G034 BR10) vẫn CHỈ Admin** (CR:32, CR:50, CR:59): Staff có Assign không thấy hộp chọn (CR:21) và không gọi được API hàng loạt. Lý do đổi thành "mức sát thương" (CR:53-59), hành vi không đổi. **G034 không có trong `tailieu/`** → case Thay thế chỉ ở mức ❓ thăm dò (Q-02). Đây là rủi ro regression ngược của chính CR (CR:55; INTAKE §4).
- **Phạm vi xem hội thoại** (G002 BR09, G003 BR02/BR11/BR18, G017 BR03): không đổi; quyền "Hiển thị cuộc hội thoại chưa gắn nhân sự" là quyền riêng (BR18).
- **Unassign TK Zalo (cấp cha, G003 BR12, `G003:308`):** không đổi; chỉ làm case chéo (mục 5.3 R10).

### 1.3 In scope / Out of scope

- **In scope (QA black-box):** acceptance, system, e2e, regression, exploratory, a11y. Gồm: kiểm delta D1-D8; **baseline hiện trạng trước sửa** (mục 4.1); regression R1-R13 (mục 5.3); test phân quyền ở UI và qua API black-box (`security-test`, hard gate); realtime tới nhiều phiên (`flaky-risk`).
- **Out of scope (dev sở hữu):** unit / integration / contract (BE/FE tự lo — vd unit test hàm kiểm quyền gỡ, contract request/response API unassign).
- **Out of scope vòng này (ghi nhận, không bịa case):**
  - Màn "Thay thế" hàng loạt G034 (không có file) — chỉ thăm dò ❓, KHÔNG đóng case (Q-02).
  - Ma trận PHÂN QUYỀN (dòng 88/90/149), PROJECT_KNOWLEDGE, SỔ THEO DÕI YÊU CẦU — không có trong `tailieu/`; chỉ đối chiếu dòng spec ở INTAKE §6 khi BA cập nhật; QA không viết case cho ma trận (Q-14).
  - Màn xem log (CR:30 "không cần màn xem") — chỉ kiểm bản ghi log nếu Q-10 chốt có trong phát hành này.
  - Perf / load / stress; automation (Phase 4) — vòng này **manual design-only**.

## 2. Test types áp dụng

Intake khuyến nghị: acceptance, system, e2e, regression, exploratory, a11y; KHÔNG recommend perf-smoke. `testDepth` = deep (lane high-risk). Hard gate `security-test` → bắt buộc có test phân quyền theo vai ở UI và API.

| Type | Có? | Ghi chú |
| --- | --- | --- |
| Acceptance (theo AC) | ✅ | Mỗi BR delta (G003-BR15a…e, UC07-b5, CR5-BR-API, G034-BR10) ≥ 1 case; bảng quyết định **vai × thao tác (gỡ) × quan hệ với hội thoại × số người phụ trách** (mục 3.2). CR ghi "☑ Acceptance Criteria" (CR:63) nhưng KHÔNG chép AC Given/When/Then → AC sinh từ BR + luồng của CR, nhãn "nguồn: CR-005 only". Baseline/regression lấy AC hiện hành `G003:603-604`, `:553`. AC log, người cuối, đang mở: ❓ (Q-10, Q-06, Q-07) |
| System / E2E | ✅ | Chuỗi UI → server → realtime tới client thứ hai: Staff có Assign mở panel Assign, bỏ chọn người khác → `Lưu` → người bị gỡ (phiên khác) không còn thấy hội thoại; gỡ lần lượt đến người cuối → "chưa phân công"; hai người sửa panel cùng lúc (Q-11); đang mở hội thoại thì bị gỡ (Q-07). Gồm test phân quyền API (vai × hội thoại × workspace, `qa-api-test` định hướng). `cross-service-e2e` chỉ **theo dõi** (chưa hard gate) — nâng nếu log/realtime đi qua service riêng (Q-08, Q-10) |
| Regression | ✅ | `regression-scope`: R1-R13 (mục 5.3): phân công đã ship (UC-07, BR14-BR16, BR26) và 8 spec phụ thuộc (G002/G017/G019/G027/G029/G011a/G014/G024). Chạy lại R1/R2/R3/R4/R5 sau MỌI lần Dev sửa. Ứng viên vào `wiki/qa/regression-suite/` khi ổn định |
| Exploratory | ✅ | `testDepth=deep` + security. Charter gợi ý: (1) hai Staff cùng sửa panel, người này gỡ người vừa bị người kia gỡ / gán lại (Q-11); (2) Staff tự gỡ chính mình rồi cố gán lại / mở lại hội thoại (Q-05a); (3) sửa request đổi định danh hội thoại sang hội thoại ngoài tầm xem / workspace khác (Q-09); (4) Staff bị thu hồi quyền Assign khi panel đang mở rồi bấm `Lưu` (Q-12); (5) gỡ người cuối lúc khách nhắn tin đến (push/badge, G027 BR07 / G029); (6) thử mở "Thay thế" bằng Staff có Assign nếu màn tồn tại (Q-02); (7) nhiều tab cùng Staff |
| Accessibility (a11y) | ✅ | Chỉ phần UI của CR: icon `Assign` header, panel phải (ô tìm kiếm, danh sách checkbox nhân viên, `Lưu`, `G003:194-196`), trạng thái đã chọn/bỏ chọn của checkbox, thông báo bị gỡ (khi BA chốt). Kiểm: thao tác bàn phím, thứ tự focus, nhãn checkbox đọc được ở cả trạng thái đã chọn/bỏ chọn, thông báo cho trình đọc màn hình, trạng thái disabled/ẩn rõ. Công cụ định hướng: axe (qua Playwright). Không có wireframe/FE spec chi tiết → case a11y chỉ nêu theo chuỗi UI trong spec, không bịa layout |
| Perf-smoke | ☐ | KHÔNG đưa vào: CR đổi điều kiện kiểm quyền, không đổi tải. Ngưỡng "ngay" của realtime (Q-08) là kiểm chức năng/flaky, không phải perf-smoke |
| Unit / Integration / Contract | ☐ | **Dev sở hữu** — KHÔNG in-scope |

## 3. Môi trường + dữ liệu

### 3.1 Môi trường

- **Env (theo `projectConfig.qa.environments`):** local / staging / uat. Env chạy chính = **staging** (lane high-risk, cần dữ liệu phân quyền + realtime gần thật); local cho exploratory nhanh và baseline sơ bộ; uat cho smoke trước go-live.
- **Hiện CHƯA có thông tin:** URL env, build/version trước và sau sửa, tài khoản test, trạng thái dev (CR:85 trỏ SỔ THEO DÕI, file không có) → **chặn THỰC THI, không chặn viết kỳ vọng**. Thực thi chờ build; thiết kế case làm được cho phần không bị chặn.
- Cần ghi lại **build/commit trước sửa** và **sau sửa** làm khoá so sánh baseline (mục 4.1).

### 3.2 Bộ dữ liệu — vai × quan hệ với hội thoại × số người phụ trách

> Tên tạm do QA đặt để tham chiếu trong case; tài khoản thật điền khi Dev/BA cấp. **Phân biệt hai nghĩa "assign":** cột "Quyền Assign (hội thoại)" là permission cấp con (G003 OQ01, tên quyền **Assign**, icon header); "assign TK Zalo" là cấp cha (G002) — mọi Staff test đều phải được assign TK Zalo ZA1 trước để *thấy* TK (G003 BR02), nếu không ẩn hết hội thoại (G003 BR12) và làm hỏng dữ liệu.

**Workspace + TK Zalo (assign cấp CHA):** WS-A chính, WS-B cô lập.

| ID | Trạng thái | Dùng để |
|---|---|---|
| ZA1 | CONNECTED (WS-A) | TK chính; assign TK này cho mọi Staff test |
| ZA2 | CONNECTED (WS-A) | TK thứ hai; Staff chỉ được assign ZA1 → hội thoại của ZA2 là "ngoài tầm" |
| ZA3 | DISCONNECTED (WS-A) | Panel Assign với TK Ngắt kết nối (`G003:519`, AC `:553`; Q-13) |
| ZB1 | CONNECTED (WS-B) | Cô lập workspace |

**Người dùng (vai):** (Staff đều được assign TK ZA1, trừ khi ghi khác.)

| ID | Vai / quyền | Quyền Assign (hội thoại) | Quyền BR18 "xem hội thoại chưa gắn nhân sự" | Mục đích | Dựng được? |
|---|---|---|---|---|---|
| U-AD | Admin/Owner WS-A | (mặc định có) | (thấy tất cả, BR11) | Đối chứng: assign + unassign như cũ (`G003:604`); quan sát | Có |
| U-SA1 | Staff | **CÓ** | Tắt | **Tác nhân chính của D1-D3** | Dựng được, **cách cấp quyền ❓ Q-04** |
| U-SA2 | Staff | **CÓ** | Tắt | Tác nhân thứ hai / người bị gỡ có Assign (D2); 2 phiên đồng thời gỡ lẫn nhau (Q-11) | Như U-SA1 |
| U-SA3 | Staff | **CÓ** | **BẬT** | Người bị gỡ/tác nhân có BR18: sau khi hội thoại thành chưa phân công vẫn thấy? (Q-06a) | Như U-SA1 |
| U-SQ | Staff có "Quản lý tài khoản Zalo" nhưng **KHÔNG** Assign | KHÔNG | Tắt | BR15 tách 2 quyền (câu gạch ở `G003:311`): quyền QLTK không kèm Assign → icon vẫn ẩn, API từ chối | Dựng được, cấp quyền ❓ Q-04 |
| U-SN | Staff **KHÔNG** có Assign | KHÔNG | Tắt | `G003:518`: icon ẩn; API gỡ bị từ chối (R2). Cũng dùng làm **người được gán nhưng không có Assign** (đối tượng bị gỡ, Q-05c) | Có |
| U-SB | Staff không Assign | KHÔNG | **BẬT** | Staff có BR18 nhưng không Assign: thấy hội thoại chưa gán, không có icon | Có |
| U-MG | "Nhân sự Quản lý" (ma trận `PHÂN QUYỀN:88`, CR:22) | ? | ? | Cột ma trận | **CHƯA dựng được — Q-04/Q-14** (role chưa định nghĩa; dùng chung câu trả lời với CR-001 Q-19). Tạm dùng U-SQ thay, ghi giả định |
| U-B-AD, U-B1 | Admin WS-B; Staff WS-B có Assign | Có (U-B1) | — | Cô lập workspace (3.4) | Có |

**Ma trận vai (3 nhóm bắt buộc) × quan hệ với hội thoại × số người phụ trách** — bảng quyết định để qa-test-case-writer sinh case; ô ❓ chỉ chờ BA, ô còn lại có kỳ vọng suy ra từ CR/spec:

| Vai tác nhân | Hội thoại | Số người phụ trách | Thao tác | Kỳ vọng |
|---|---|---|---|---|
| Admin (U-AD) | Đang phụ trách / không phụ trách (Admin thấy tất cả, BR11) | 1 / 2 / nhiều | Gỡ 1 người / gỡ người cuối | Gỡ được, như cũ (`G003:604`). Hội thoại về chưa phân công khi gỡ người cuối (CR:29); log ❓ Q-10 |
| Staff CÓ Assign (U-SA1) | **Đang phụ trách** (tác nhân nằm trong danh sách) | 1 (chỉ mình) | Tự gỡ chính mình = gỡ người cuối | Self ❓ Q-05a; hội thoại về chưa phân công (CR:29); tác nhân còn thấy? ❓ Q-06 |
| | | 2 | Gỡ người khác | **Gỡ được** (D2, nhãn CR-005 only); người bị gỡ không còn thấy hội thoại khi KHÔNG có BR18 và còn người khác phụ trách; còn lại ❓ Q-06/Q-07/Q-08 |
| | | nhiều (≥3) | Gỡ lần lượt từng người đến người cuối | Mỗi lần gỡ 1 người, danh sách còn lại đúng; người cuối → "chưa phân công" (D3) |
| | **Không phụ trách nhưng thấy được** (hội thoại chưa gán + tác nhân có BR18 — U-SA3) | 0 | Mở panel Assign; gán rồi gỡ | Gán được (UC-07). Không có ai để gỡ; icon vẫn hiện |
| | **Ngoài tầm xem** (hội thoại gán cho người khác, tác nhân không phụ trách, G002:139; hoặc khác TK/workspace) | 1 / 2 | Gỡ (chỉ qua API vì UI không mở được hội thoại) | **Bị từ chối, danh sách phụ trách không đổi** (D6: "không mở tầm với") — mã/thông điệp/log ❓ Q-09; nếu Q-03 trả lời tầm xem rộng (BR02) thì đổi kỳ vọng |
| Staff KHÔNG Assign (U-SN, U-SQ, U-SB) | Đang phụ trách | 1 / 2 | Tìm icon `Assign`; gọi API gỡ | Icon **không hiển thị** (`G003:518`); API bị từ chối (BR-C06), không đổi phân công — mã/thông điệp/log ❓ Q-09 |
| | Chưa gán (có BR18, U-SB) | 0 | Như trên | Như trên |

**Biến thể bắt buộc của mọi ô "gỡ" (dữ liệu):**
- **Quyền BR18 của NGƯỜI BỊ GỠ** bật/tắt (U-SA3 vs U-SA2/U-SN) × còn người khác / là người cuối → bảng hiển thị Q-06 (gồm biểu hiện của rủi ro "người bị gỡ vẫn thấy hội thoại vì có BR18").
- **Loại người bị gỡ:** người thường (U-SN), Staff có Assign (U-SA2), chính mình (self), Admin/Owner nếu được tick trong hội thoại (Q-05b) — kỳ vọng hai loại sau ❓ Q-05.
- **Hội thoại:** chưa gán (C0); 1 người (C1); 2 người (C2); ≥3 người (C3); 1-1 và nhóm (Q-05e); trên TK CONNECTED (ZA1) và DISCONNECTED (ZA3: icon hiển thị, click → toast `G003:519`, panel không mở — áp cho thao tác gỡ? Q-13; Admin chờ BA).
- **Dữ liệu cũ (D7):** ≥1 phân công do Admin tạo TRƯỚC khi áp bản sửa (tạo ở build trước sửa, giữ qua nâng cấp) → sau sửa Staff có Assign gỡ được; không mất/đổi phân công ngoài thao tác gỡ.
- **Hội thoại có dữ liệu liên quan** để kiểm hệ quả (R6/R7): tin chưa đọc (badge, G029), nhắc hẹn (G019), ghi chú (G011a), tin ghim (G014), thẻ/ẩn hội thoại (G024).

**Phiên đồng thời (kiểm realtime + flaky):** tối thiểu 4 phiên trình duyệt độc lập (profile/cửa sổ ẩn danh): (1) tác nhân gỡ; (2) người bị gỡ đang xem danh sách; (3) người bị gỡ đang **mở đúng hội thoại** (Q-07); (4) Admin quan sát. Thêm: 2 tab cùng một Staff (nhiều tab, Q-08a); 2 Staff có Assign cùng mở panel của cùng hội thoại (Q-11). Ghi mốc thời gian (từ lúc bấm `Lưu` đến lúc phiên kia đổi) — không assert cứng cho tới khi Q-08 có ngưỡng.

### 3.3 Chiến lược cô lập tenant / workspace (theo dõi `multi-tenant-isolation`, chưa là hard gate)

- Dữ liệu tách theo workspace: WS-A và WS-B có TK Zalo, nhân viên, hội thoại riêng (mục 3.2). Spec cô lập: G002:248-250 (xem CR-001 TP mục 3.4).
- **Case negative cross-workspace nằm trong `security-test` (Q-09b):** (1) Staff có Assign WS-A gọi API gỡ phân công của hội thoại WS-B → bị từ chối và phân công WS-B không đổi; (2) ngược lại U-B1 → hội thoại WS-A; (3) danh sách nhân viên trong panel của WS-A không chứa nhân viên WS-B; (4) log gỡ (nếu có, Q-10) không ghi chéo workspace. Mã/thông điệp ❓ Q-09.
- Không dùng chung hội thoại giữa các case chạy song song; reset dữ liệu: gán lại đúng danh sách phụ trách ban đầu bằng Admin sau mỗi case "gỡ" (phân công không khôi phục được tự động; CR:57 cho G034) — cách dọn chờ Dev chỉ dẫn.

### 3.4 Chỗ CHƯA dựng được vì câu hỏi mở

| Phần dữ liệu | Bị chặn bởi |
|---|---|
| Cách cấp / thu hồi quyền **Assign** cho tài khoản test (cấu hình ở đâu — OQ01 `G003:682` hỏi "Cấu hình ở đâu?" chưa trả lời; G002 không nhắc quyền Assign); quan hệ với vai "Nhân sự Quản lý" (U-MG) | **Q-04** (chặn dữ liệu test, không chặn kỳ vọng) — dựng bằng cách Dev/BA cấp tay, hoặc hỏi |
| Tác nhân "không phụ trách" có mở được hội thoại gán cho người khác để gỡ không | Q-03 |
| Quan hệ tác nhân × loại người bị gỡ (self, Admin, Staff có Assign) | Q-05 |
| Hội thoại người cuối × BR18 của người bị gỡ; nhánh BR26 "chưa gán + không BR18" | Q-06 |
| Màn/API "Thay thế" hàng loạt (200 hội thoại) | Q-02 (G034 không có file) |
| Nơi đọc log gỡ (DB / log hệ thống / API), schema, log từ chối | Q-10 (và Q-09) |
| Build trước/sau sửa, env, tài khoản test | Q-12 phần thực thi (SỔ THEO DÕI không có file) |

### 3.5 Automation (định hướng, CHƯA làm vòng này)

- Định hướng theo `projectConfig.qa.automation`: **Playwright** (`e2eWeb`; 2+ browser context song song cho realtime, axe cho a11y) cho UI; **REST-assured** (`apiBe`) / **Karate** (`apiAlt`) cho test phân quyền API gỡ (vai × hội thoại × workspace).
- **Vòng này (Phase 2) là manual design-only** — user đã xác nhận CHƯA làm automation. Ứng viên khi làm: ma trận vai × quan hệ × số người (data-driven), R2/R3/R5, âm tính API, cô lập workspace.
- `reportEvidence: true` áp dụng ngay khi thực thi tay: screenshot trước/sau mỗi bước (danh sách phụ trách trước và sau, panel), HAR/log request `Lưu` (ghi tên/field thật quan sát được, không tự chế), ghi build version, mốc thời gian từng phiên.

## 4. Entry / Exit criteria

### 4.1 Entry (execution)

Không có FEAT nên không có `deps.qa` (be.done + fe.done) chuẩn. Entry thực tế thay thế:

1. **Env + build:** URL env; build **trước sửa** (đo baseline) và build **sau sửa** (Dev báo xong). Trạng thái dev chưa biết (CR:85).
2. **Bộ dữ liệu mục 3.2 dựng được:** tối thiểu U-AD, U-SA1, U-SA2, U-SA3, U-SN, U-SQ, ZA1-ZA3; WS-B cho cô lập; cách cấp quyền Assign (Q-04) đã được chỉ dẫn.
3. **Đo baseline hiện trạng TRƯỚC khi Dev sửa — BẮT BUỘC, là cổng entry cho cả vòng** (giống TP-CR-001 §4.1):
   - Build: **trước sửa**; không để Dev deploy bản sửa lên env test trước khi baseline xong (nếu đã deploy → dựng lại từ commit trước, hoặc ghi rõ "không đo được baseline" và chuyển các case đối chiếu sang ❓).
   - **Phạm vi đo (cặp vai × giao diện/API):**
     - **Staff có Assign (U-SA1) — hiện có gỡ được không?** UI: mở panel Assign, bỏ chọn một người khác, `Lưu` → checkbox có bị khoá/ẩn không, `Lưu` thành công hay bị từ chối, danh sách phụ trách sau đó; thử tự gỡ chính mình; thử gỡ người cuối. API: gửi cùng thao tác gỡ (quan sát request thật của Admin rồi phát lại bằng phiên U-SA1) → kết quả (mã, thông điệp, có ghi log từ chối?). Đối chứng **U-AD**: gỡ như `G003:604`.
     - **Staff không Assign (U-SN, U-SQ):** icon `Assign` ẩn (`G003:518`); API gỡ bị từ chối hay vẫn thực hiện được (nếu hiện trạng KHÔNG chặn ở server → defect bảo mật có sẵn, ghi riêng, không trộn với delta).
     - **Ngoài tầm xem / workspace khác:** U-SA1 gọi API gỡ trên hội thoại không phụ trách / khác workspace — hiện trạng.
     - **Hành vi "đang mở giữa chừng" hiện tại (Q-07):** Admin gỡ người đang mở hội thoại → người đó thấy gì (CR:70 nói "cần xác nhận hành vi hiện tại").
     - **Người cuối:** Admin gỡ người cuối hiện làm gì (spec không nói) → hội thoại về chưa phân công? ai còn thấy?
     - **"Thay thế" hàng loạt (nếu màn tồn tại ở build):** Staff có Assign có thấy hộp chọn không; API hàng loạt (Q-02).
     - **Log:** hiện có log gỡ/gán ở đâu, nếu có (Q-10).
   - Ghi cho mỗi (vai × thao tác): hiển thị (hiện/ẩn/disable), kết quả `Lưu`, chuỗi UI nguyên văn, mã/thông điệp API quan sát được, có ghi log không. Evidence: screenshot + HAR.
   - Mục đích: (a) xác nhận lối nào CÓ gate "Admin only" ở UI và/hoặc API (spec không nêu API, `G003` §5 không có E cho assign); (b) chốt baseline so sánh trước/sau; (c) tách "sửa implementation cho đúng spec" khỏi "hành vi mới theo CR"; (d) trả lời Q-07 phần "hành vi hiện tại"; (e) kết quả ghi vào `wiki/qa/test-runs/CR-005_baseline.md`.
4. **Cách xem log gỡ (Q-10):** Dev chỉ rõ nơi đọc (DB / log hệ thống / API), schema và quyền truy cập cho QA ở env test; nếu BA chốt "log bổ sung sau" (CR:69) thì AC log ra khỏi phạm vi nghiệm thu lần này và ghi vào exit criteria (mục 4.2). Chưa có cách đọc log thì case log thực thi dưới dạng ❓, không đánh pass.
5. Dev/BA đã nhận 14 câu hỏi (Q-01…Q-14); case ❓ thực thi sau khi BA trả lời — KHÔNG chờ để bắt đầu thực thi các case đã rõ (mục 5.2 "viết được ngay").
6. Có hướng dẫn dọn dữ liệu / reset phân công (Admin gán lại danh sách ban đầu) hoặc script reset từ Dev.

### 4.2 Exit (sign-off) — theo `projectConfig.qa.exitCriteria`

- **AC coverage = 100%** — mỗi BR delta (G003-BR15a…e, UC07-b5, G034-BR10, CR5-BR-API) và mỗi BR/AC hiện hành thuộc R1-R13 có ≥ 1 test case. Case ❓ tính là *đã viết nhưng CHƯA đạt* cho tới khi BA trả lời và case được thực thi; **không** coi ❓ là pass. Sign-off cần: mọi ❓ đã trả lời và thực thi, hoặc user ghi nhận loại/hoãn rõ ràng (vd Q-10 "log sau", Q-02 "G034 ngoài docs", Q-14).
- **Blocking severity pass = 100%; open critical defects = 0.** Case thuộc `security-test` (phân quyền gỡ theo vai ở UI và API, ngoài tầm xem, chéo workspace, Thay thế không mở nhầm) và R1/R2/R3/R4/R5 coi là **blocking**.
- **Evidence đầy đủ** cho mọi case pass (screenshot/HAR/log; ghi build, user, hội thoại, danh sách phụ trách trước/sau, mốc thời gian phiên).
- Baseline trước sửa đã đo và lưu; mọi khác biệt trước/sau đều được giải thích bằng delta D1-D8 (khác biệt ngoài delta = nghi regression → defect hoặc hỏi BA).

## 5. Rủi ro / lane

- **Lane:** `high-risk` (từ INTAKE-CR-005; status `high-risk-pending-confirmation` — scope user đã yêu cầu theo đề xuất intake: regression + exploratory + a11y + e2e; automation chưa làm vòng này).
- **Flags:** `security-test` (hard gate), `regression-scope`, `flaky-risk` — 3 flag. **Theo dõi** (chưa bật): `multi-tenant-isolation`, `cross-service-e2e`. Không `data-integrity`, không `no-ac-source`.
- **Hard gates chạm:** `security-test`. Nâng `multi-tenant-isolation` nếu dev cho biết kiểm workspace nằm đúng ở logic kiểm quyền bị sửa (Q-09); nâng `cross-service-e2e` nếu log/realtime đi qua service riêng (Q-08, Q-10).

### 5.1 Ảnh hưởng tới test focus

- **`security-test` →** CR đổi *ai được gỡ* và **nới điều kiện kiểm quyền ở API**. Trọng tâm: (a) Staff không có Assign vẫn không gỡ được — icon ẩn (UI) VÀ API từ chối (R2); (b) Staff có Assign không gỡ được ngoài tầm xem / ngoài TK được assign / workspace khác (D6); (c) quyền kiểm lúc chạy: thu hồi/cấp giữa phiên (Q-12); (d) "Thay thế" hàng loạt không bị mở nhầm (rủi ro riêng 5.4); (e) log đúng người/hội thoại/thời điểm, không làm lộ dữ liệu; (f) phân công không đổi khi thao tác bị từ chối.
- **`regression-scope` →** phân công đã ship ảnh hưởng 8 spec (R6-R9); Admin/gán không đổi (R1, R3).
- **`flaky-risk` →** thay đổi phân công truyền qua realtime tới nhiều phiên, kết quả phụ thuộc thời điểm / thứ tự (hai người sửa panel cùng lúc). Xử lý: mỗi case dùng hội thoại + danh sách phụ trách riêng; chạy tuần tự các case chung hội thoại; đo mốc thời gian, không assert cứng "ngay" cho tới khi Q-08 có ngưỡng; chờ có giới hạn tối đa X và ghi lại; kiểm lại kết nối ZA1/ZA3 trước mỗi đợt; reset danh sách phụ trách sau mỗi case.
- **Multi-tenant (theo dõi) →** mục 3.3.

### 5.2 Câu hỏi đang CHẶN kỳ vọng → nhóm case bị ảnh hưởng (viết ở dạng ❓)

Nhãn ❓ = case vẫn viết (bước + dữ liệu), ô "Kết quả mong đợi" ghi ❓ + tên câu hỏi + giả định tạm nếu có; KHÔNG tự điền kỳ vọng.

| Q | Nội dung | Nhóm case bị ảnh hưởng (dạng ❓) | Giả định tạm cho phép viết |
|---|---|---|---|
| **Q-02** | G034 không có trong `tailieu/`: "Thay thế chỉ Admin" kiểm bằng gì (màn, hộp chọn, API); dev "sửa cho nhất quán" mở nhầm (CR:55) | Mọi case G034: Staff có Assign không thấy hộp chọn "Thay thế" (CR:21); API hàng loạt bị từ chối; hành vi/giới hạn 200 hội thoại, không khôi phục (CR:57) | Chỉ ghi mức thăm dò: "Staff có Assign không dùng được gán hàng loạt kiểu Thay thế"; **không đóng case**. Thêm 3 chữ "từng hội thoại" vào BR15 (đề xuất BA) để đọc nhất quán CR:28 và CR:50 |
| **Q-03** | "Phạm vi vẫn khoá trong hội thoại người đó được xem": Staff có Assign xem được hội thoại nào? (G002:139 / G017:274 hẹp: chỉ gắn cho mình + chưa gán nếu BR18; G003 BR02 rộng: mọi hội thoại của TK được assign) | Tác nhân "không phụ trách" gỡ người khác (UI và API); ô "Ngoài tầm xem" của bảng quyết định 3.2; kịch bản người điều phối CR:38-39 | Tạm theo G002:139 + G017:274 (tác nhân phải thuộc danh sách phụ trách để gỡ người khác; gỡ người cuối bởi Staff chỉ xảy ra khi tự gỡ mình). Case "gỡ người khác" trong danh sách phụ trách làm ngay |
| **Q-05** | Đối tượng bị gỡ và phản hồi UI: "bất kỳ ai" gồm chính mình / Admin-Owner / Staff có Assign; panel có phân biệt ai gán, cảnh báo, toast "Đã lưu"/lỗi; nhóm vs 1-1 | Case tự gỡ; gỡ Admin; gỡ Staff có Assign; phản hồi sau `Lưu`; nhóm vs 1-1 | Chắc chắn: gỡ người thường (U-SN) bởi Staff có Assign (D2). Còn lại ❓ |
| **Q-06** | Hội thoại sau gỡ người cuối: người bị gỡ có BR18 vẫn thấy (CR:70 "biến mất" mâu thuẫn); nhánh BR26 "chưa gán + không BR18" không thuộc Case A/B/C; auto-assign lại; push tới ai | Case người cuối; ma trận {bị gỡ có/không BR18} × {còn người khác/là người cuối}; hiển thị, thông báo, badge; R8, R9 (BR26) | Viết được ngay: người cuối gỡ → Admin vẫn thấy, Staff có BR18 thấy, Staff khác không (suy từ BR11, BR18). Phần "người bị gỡ có BR18", push, badge, BR26, auto-assign ❓ |
| **Q-07** | Bị gỡ khi đang mở hội thoại / đang gõ / đang gửi; chuỗi *"Bạn không còn phụ trách hội thoại này"* chỉ là dự thảo (CR:70) | Phiên (3) mục 3.2; tin soạn dở; bấm Gửi sau khi bị gỡ; popup ghim đang mở (G014 AF04); tin khách đến sau gỡ; a11y thông báo | Chỉ khẳng định "sau khi người kia nhận cập nhật hoặc tải lại, hội thoại không còn trong danh sách" khi người bị gỡ KHÔNG có BR18 và còn người phụ trách khác. Chuỗi, hành vi đang mở, Gửi sau gỡ ❓ |
| **Q-08** | "Ngay" không có ngưỡng (BR-C12 / G034 BR13 không có file); ai nhận cập nhật: người bị gỡ (nhiều tab), người còn lại trong danh sách, Admin, người đang mở panel | Mọi case realtime; ngưỡng chờ; panel của người còn lại | `G003:692` "không cần F5": assert "không cần tải lại trong khoảng chờ tối đa X" và ghi giới hạn. Ngưỡng ❓ |
| **Q-09** | Kiểm quyền phía server: mã/thông điệp/log cho Staff không Assign, ngoài tầm xem, chéo workspace; API gỡ đơn lẻ và API hàng loạt có dùng chung hàm kiểm quyền không | Toàn bộ case API âm tính (`security-test`, trọng tâm CR); chéo workspace; "sửa request" | Chỉ khẳng định "bị từ chối, phân công không đổi". Mã/thông điệp/log ❓ (có thể bám tiền lệ G033 E01 / BR-C04 `G003:322`, cần BA xác nhận) |
| **Q-10** | Log gỡ: CR:30 "mọi lần gỡ ghi log" vs CR:69 "log bổ sung sau, không chặn build"; nơi đọc; N dòng hay 1 khi gỡ N người; log lần từ chối; tự gỡ có ghi không | AC log (D4): nội dung ai/ai/hội thoại/lúc nào; số dòng; log từ chối; log self | Nếu BA chốt "sau": AC log ra khỏi nghiệm thu vòng này, ghi vào exit criteria. Chưa chốt → mọi case log ❓ |
| **Q-11** | Hai người sửa panel cùng lúc: `Lưu` gửi toàn bộ danh sách hay delta; panel cũ báo gì | Phiên đồng thời: A mở panel (X, Y), B gỡ Y và `Lưu`, A bỏ chọn X và `Lưu` → Y có bị gán lại ngoài ý muốn không (dữ liệu phân công không khôi phục được) | Dựng case 2 phiên, ghi kết quả quan sát làm bằng chứng; kỳ vọng ❓ |
| **Q-12** | Quyền Assign bị thu hồi/cấp giữa phiên: `Lưu` thành công hay từ chối; icon biến mất realtime; chưa có E trong `G003` §5 | Exploratory (4); case "mất quyền giữa chừng" | Sau tải lại: icon theo quyền hiện tại (`G003:518`). Giữa phiên ❓ (hỏi chung CR-001 Q-11) |

**Không chặn (QA xử lý tạm):** Q-01 (G003 chưa cập nhật theo CR, dẫn chiếu CR lệch: BR15 ở `G003:311` không phải `:313`, AC ở `G003:603-604` không phải `:611` → test "spec hiện hành + delta CR", nhãn "nguồn: CR-005 only"); Q-04 (chặn *dữ liệu test*, không chặn kỳ vọng); Q-13 (TK DISCONNECTED: theo `G003:519` toast chặn panel với Staff có Assign; Admin chờ BA); Q-14 (ma trận PHÂN QUYỀN: chỉ đối chiếu, không viết case).

**Viết được ngay (không chờ BA):** D1 Staff có Assign gỡ người khác trong danh sách phụ trách (người bị gỡ không BR18, còn người khác) và người bị gỡ không còn thấy hội thoại; D1 nhiều lần gỡ đến người cuối với Admin vẫn thấy; Admin assign + unassign như cũ; Staff không Assign không thấy icon; Staff có Assign vẫn gán được; ghi baseline; regression R1-R3, R5, R7, R10, R13; âm tính "ngoài tầm xem": phân công không đổi.

### 5.3 Regression cần canh (theo INTAKE §11)

| Mã | Nội dung | Nguồn spec | Ưu tiên |
|---|---|---|---|
| R1 | Assign không đổi: Admin và Staff có Assign vẫn gán được; hội thoại hiện đúng trong danh sách người được gán (BR14, BR16); gán nhiều người | `G003:310`, `:312`, UC-07 `:191-197` | Blocking |
| R2 | Staff không có Assign: icon ẩn; API gỡ vẫn bị từ chối (kỳ vọng API ❓ Q-09) | `G003:518`, `:553` | Blocking (security) |
| R3 | Admin: unassign vẫn như cũ; vẫn thấy hết (BR11), không phụ thuộc phân công | `G003:604`, `:307` | Blocking |
| R4 | "Thay thế" hàng loạt (G034) vẫn Admin only: Staff có Assign không thấy hộp chọn; API hàng loạt từ chối | CR:21, CR:50, CR:59 | Blocking (❓ Q-02) |
| R5 | Phạm vi xem: Staff có Assign không gỡ được ngoài tầm xem; cô lập workspace | G002 BR09 `:139`, G017 BR03 `:274` | Blocking (security) |
| R6 | Hệ quả hiển thị sau gỡ: danh sách người bị gỡ, badge chưa đọc trừ khỏi tổng, push theo phân công mới, nhắc hẹn ẩn + không thông báo, ghi chú ẩn, tìm kiếm không còn trả hội thoại đó | G029 BR01/AF02/E04 `:39`, `:59-60`, `:71`; G027 BR07 `:91`; G019 BR12 `:140`, `:267`; G011a BR09 `:120`; G017 BR03 | Cao |
| R7 | Gán lại sau gỡ: hội thoại hiện lại, nhắc hẹn nhắc lại, ghi chú hiện lại | G019 BR12; G011a BR09 | Cao |
| R8 | Hội thoại chưa phân công sau khi gỡ người cuối: Admin và Staff có BR18 thấy; Staff khác không; badge/push "mọi người có quyền xem" (phần chưa chắc ❓ Q-06) | `G003:314`; G027 BR07; G029 BR01 | Cao |
| R9 | BR26: Case A auto-assign vẫn đúng; Case C vẫn chặn; sau gỡ phân công, click danh thiếp rơi vào nhánh nào (❓ Q-06) | `G003:322`, AC `:609-612` | Cao |
| R10 | Chéo CR-001 / cấp cha: gỡ phân công hội thoại không ảnh hưởng điều kiện assign TK Zalo (kết bạn); Staff bị unassign TK Zalo → hội thoại ẩn bất kể phân công hội thoại | INTAKE §7; G003 BR12 `:308` | Cao |
| R11 | Gỡ giữa chừng: popup ghim đang mở đóng ngay; đang gõ/gửi (❓ Q-07) | G014 AF04 `:352-354` | Cao (❓) |
| R12 | TK DISCONNECTED: Staff có Assign click icon → toast, panel không mở, kể cả thao tác gỡ (Admin ❓ Q-13) | `G003:519`, AC `:553` | Trung bình |
| R13 | a11y panel Assign: bàn phím, nhãn checkbox cho trạng thái đã chọn/bỏ chọn, thông báo bị gỡ đọc được | — | Cao |

### 5.4 Rủi ro riêng

- **Hai người sửa panel cùng lúc gán lại người vừa bị gỡ (Q-11):** nếu `Lưu` gửi toàn bộ danh sách thay vì delta, A (panel cũ) có thể gán lại Y vừa bị B gỡ, hoặc gỡ nhầm người vừa được thêm; mất phân công không khôi phục được. Case 2 phiên bắt buộc, ghi kết quả làm evidence; flaky nên lặp ≥3 lần và đảo thứ tự.
- **Dev mở nhầm cả "Thay thế" (Q-02):** lý do "gỡ chỉ Admin" không còn đúng khiến dev "sửa cho nhất quán" (CR:55). Thay thế gỡ toàn bộ người không tick, tối đa 200 hội thoại một lượt, không khôi phục được (CR:57) → sát thương lớn. Cần case âm tính **cả UI lẫn API**, đo trong baseline (4.1); G034 không có file nên chỉ ở mức ❓ thăm dò, không đóng case.
- **Người bị gỡ vẫn thấy hội thoại vì có quyền BR18 (Q-06):** khi người cuối bị gỡ, hội thoại thành "chưa gán" và BR18 cho người bị gỡ (nếu có quyền) vẫn thấy → "biến mất khỏi danh sách ngay" và thông báo đóng (CR:70) có thể sai. Phải có ô dữ liệu {bị gỡ có BR18} × {còn người khác / là người cuối} (U-SA3 vs U-SA2).
- **Kiểm quyền API không đồng bộ UI (Q-09):** UI ẩn nhưng server không chặn hoặc ngược lại; đây là điểm security chính, case âm tính qua API bắt buộc cho cả Staff không Assign, ngoài tầm xem, chéo workspace.
- **Tầm xem rộng hơn spec (Q-03):** nếu Staff có Assign xem được mọi hội thoại của TK (G003 BR02), "người điều phối gỡ người khác" mở rộng bề mặt → regression R5 và kỳ vọng ma trận đổi.
- **Log (Q-10):** CR:30 vs CR:69 mâu thuẫn; rủi ro nghiệm thu thiếu log dù CR yêu cầu. Cách đọc log chưa có → không verify được.
- **Dữ liệu phân công không khôi phục được:** mỗi case gỡ làm mất phân công; cần Admin gán lại sau mỗi case (3.3) và pool hội thoại đủ lớn.
- **Spec chưa cập nhật + dẫn chiếu treo:** G003 chưa theo CR (13 dòng cần sửa, INTAKE §6); G034, PHÂN QUYỀN, PROJECT_KNOWLEDGE, SỔ THEO DÕI không có file; 10/11 chỗ CR dẫn "cần sửa" nằm ở file không tồn tại → không đối chiếu được. Nếu BA chỉnh lại CR thì viết lại case delta.
- **Dễ lẫn "assign" hai nghĩa:** dữ liệu assign TK Zalo (G002) và assign hội thoại (G003) dễ dựng sai khi tái dùng bộ dữ liệu CR-001 → mục 3.2 tách rõ.
- **Chưa biết build/trạng thái dev:** thực thi chờ build; baseline có thể mất nếu Dev deploy sớm (4.1).

## 6. Liên kết

- Test cases: `wiki/qa/test-cases/CR-005.md` (Phase 3 — chưa tạo)
- Test runs: `wiki/qa/test-runs/CR-005_*.md` (kể cả `CR-005_baseline.md` — đo baseline trước sửa)
- Intake (nguồn phân tích): `wiki/qa/intake/INTAKE-CR-005.md`
- Phiếu CR: `tailieu/CR-005 - Staff có quyền assign được unassign.md`
- Spec hiện hành: `tailieu/G003 - Chat.md` (chính) · `G002 - Chia sẻ tài khoản Zalo cho Staff.md` · `G017*` · `G019*` · `G027*` · `G029*` · `G011a*` · `G014*` · `G024*`. Không có trong `tailieu/`: G034, PHÂN QUYỀN - Ma trận tổng hợp, PROJECT_KNOWLEDGE, SỔ THEO DÕI YÊU CẦU.
- Liên quan: `wiki/qa/test-plans/TP-CR-001.md` (cùng dạng CR đổi quyền; "assign" ở đó là cấp TK Zalo — R10 và Q-04 dùng chung câu trả lời về vai "Nhân sự Quản lý")
- FEAT: **chưa tồn tại** — khi BA/orchestrator tạo `wiki/features/FEAT-<NNN>.md`, backfill link tại đây và tick row 4.4 "Test plan".

## Lịch sử cập nhật

| Ngày | Người | Thay đổi |
|---|---|---|
| 2026-10-08 | QA | Tạo test plan lần đầu (Phase 2) từ INTAKE-CR-005: scope delta D1-D8 (Staff có Assign gỡ được bất kỳ ai kể cả người cuối, log, kiểm quyền UI + API) và phần KHÔNG đổi (Admin, Staff không Assign, "Thay thế" chỉ Admin); 6 test type (không perf-smoke); ma trận dữ liệu vai × quan hệ × số người phụ trách, BR18 bật/tắt, phiên đồng thời, 2 workspace, TK CONNECTED/DISCONNECTED; entry gồm đo baseline hiện trạng trước sửa (UI + API) và cách xem log (Q-10); exit theo `qa.exitCriteria`; rủi ro + bảng câu hỏi chặn (Q-02, Q-03, Q-05…Q-12) → nhóm case ❓, regression R1-R13. Không có FEAT nên bỏ verify claim và tick FEAT §4.4. Automation chỉ là định hướng (manual design-only). |
