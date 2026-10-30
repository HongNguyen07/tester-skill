---
id: TP-CR-001
feature: CR-001 (không có FEAT spine — nguồn = phiếu CR + spec hiện hành trong tailieu/)
createdBy: QA
createdAt: 2026-10-07
status: Draft          # Draft | Ready | Executing | Signed-off
lane: high-risk
---

# TP-CR-001: Test Plan — Quyền kết bạn của nhân sự

> **Nguồn AC/US:** project KHÔNG có `wiki/features/FEAT-*.md`. AC-source =
> - Phiếu `tailieu/CR-001 - Quyền kết bạn của nhân sự.md` (200 dòng; trích `L<số>`): BR18/BR19 (G007), BR24/BR26 (G017), ma trận §6, 2 luồng mermaid trước/sau.
> - Spec hiện hành (BẢN DUY NHẤT, user xác nhận 2026-10-07): `tailieu/G007*` (Kết bạn), `G017*` (Tìm kiếm hợp nhất), `G012*` (Nút Kết bạn trong hội thoại), `G002*` (Chia sẻ TK Zalo cho Staff), `G003*` (Chat). `G032` bản hiệu lực = `G032 - Đổi tên gợi nhớ (1).md`.
> - Phân tích chi tiết: `wiki/qa/intake/INTAKE-CR-001.md` (lane, flag, 21 câu hỏi Q-01…Q-21, baseline 4 lối, regression R1–R8, bảng dòng spec cần sửa 4.3).
>
> **Cách test (đã chốt):** spec hiện hành + delta ghi trong CR-001. BR mới của CR (G007 BR18/BR19, G017 BR24/BR26, ma trận §6) chưa có trong G007/G017 → gắn nhãn **"nguồn: CR-001 only"** cho tới khi BA trả lời Q-01.
> Mã lỗi / thông báo / nhãn nút dùng NGUYÊN VĂN trong tài liệu (vd "Đã gửi lời mời", "Bạn chưa được phân quyền tài khoản Zalo nào", "Bạn không có quyền thực hiện thao tác này"); KHÔNG tự chế. Chỗ tài liệu không nêu → case ghi ❓ (xem mục 5).
>
> **Vì chưa có FEAT:** bỏ bước verify claim `owners.qa` và KHÔNG tick checklist FEAT §4.4 (không có FEAT để tick). Khi BA/orchestrator tạo FEAT cho CR này, backfill `feature:` ở frontmatter và tick lại row "Test plan".
> Test-DESIGN là shift-left, bắt đầu ngay trên spec hiện hành, không chờ build.
> Quy ước trích dẫn: `G007:152` = file + số dòng của spec hiện hành (lấy lại từ intake); mã BR luôn kèm tiền tố tài liệu vì BR18 trùng ở G003/G017/G007 (Q-15).

## 1. Scope

- **FEAT / CR:** CR-001 — Nhân sự không có quyền "Quản lý tài khoản Zalo" hiện không thấy/không dùng được nút Kết bạn (khách báo ở lối ③, phải mở hội thoại và nhắn tin trước); CR yêu cầu gỡ điều kiện đó khỏi các lối kết bạn, điều kiện duy nhất = được assign ≥1 TK Zalo CONNECTED (L119, L192).
- **Phân loại của BA:** CR (L190) — "không đổi quy tắc", nhưng "Việc cho Dev" (L192) đổi hành vi thật. Ở mức spec hiện hành KHÔNG có điều kiện QLTK ở ①②③ (G007:43-45, :53, :152; G017:396-399) → điều kiện đó chỉ nằm ở implementation (L27-28). Vì vậy vòng test này vừa là **kiểm delta** vừa là **regression diện rộng**.

### 1.1 Delta của CR (đối tượng kiểm chính)

| # | Delta | Nguồn | Ghi chú test |
|---|---|---|---|
| D1 | Gỡ điều kiện quyền "Quản lý tài khoản Zalo" khỏi các lối kết bạn **①②③**; điều kiện duy nhất = assign ≥1 TK CONNECTED; KHÔNG đòi "Quản lý tài khoản Zalo", "Quản lý nhóm", mở hội thoại/nhắn tin trước (G007 BR18) | L119, L192 | Trọng tâm. Đối tượng: nhân sự KHÔNG có quyền QLTK, assign ≥1 TK CONNECTED |
| D2 | **Nút kết bạn trên kết quả tìm kiếm (③):** nút "Gửi lời mời kết bạn" hiện NGAY trên kết quả, không cần hội thoại/nhắn tin, gửi qua đúng TK dùng để tìm, không hỏi lại (G017 BR26); khối "Tìm & Kết bạn" hiện với mọi nhân sự assign ≥1 TK (G017 BR24) | L121-122, L76, L78 | Nghĩa của "hiện ngay" chưa chốt (Q-17) → case ③ viết theo giả định (1) = bước 7a hiện hành (G017:178-179), gắn "giả định" |
| D3 | 4 lối ①②③④ bình đẳng về quyền (G007 BR19); sau sửa không còn nhánh nào dẫn tới "nhắn tin trước" (CR-FLOW-01) | L120, L86 | Kiểm bằng ma trận lối × vai × trạng thái assign |
| D4 | Ma trận phân quyền §6 "Danh bạ & Kết bạn" (5 dòng: Gửi lời mời, Thu hồi, Chấp nhận/Từ chối, Xoá bạn, Đặt tên gợi nhớ) — điều kiện chung assign ≥1 TK CONNECTED, không dòng nào đòi QLTK | L159-169 | Ma trận KHÔNG tồn tại → kiểm bằng smoke theo vai + regression R5; dòng 5 chờ Q-18 |
| D5 | Chọn TK ở bước 2: chỉ TK được assign (BR10); danh sách hiển thị đầy đủ, cuộn được (BR20 — CR-002) | L46-47, L92 | Phần CR-002/BR20 → ngoài phạm vi vòng này (Q-14) |

### 1.2 KHÔNG đổi (kiểm bằng regression, không kiểm hành vi mới)

- **Lối ④ — nút "Kết bạn" trong hội thoại (G012):** phiếu khẳng định "không phải sửa" (L88-90, L192; G012:240 và G003:398 "đã ghi đúng", L144). Giữ nguyên: confirm dialog bắt buộc (G012 BR05), ẩn khi TK DISCONNECTED (G012 BR06, :158), E04 mất quyền giữa chừng (G012:134), quyền "truy cập hội thoại" (G012:240), G003 BR26 Case A/B/C.
- **Phạm vi dữ liệu:** "chỉ kết bạn được qua TK mình được assign … phạm vi không đổi một milimet" (L147); BR10 dropdown theo assign (G007:152); BR-C02/BR-C06 (L143, tài liệu PROJECT_KNOWLEDGE không tồn tại).
- Không có dữ liệu nghiệp vụ mới (L146), nhưng gửi lời mời sinh/đổi dữ liệu phụ (lời mời chờ, G017 BR20/BR21, G032 BR11) → kiểm ở R6.

### 1.3 In scope / Out of scope

- **In scope (QA black-box):** acceptance, system, e2e, regression, exploratory, a11y. Gồm: kiểm delta D1–D4; baseline hiện trạng ①②③④ (mục 4); regression R1–R8; test phân quyền/cô lập qua UI và qua API ở mức black-box (security-test); cô lập workspace (multi-tenant-isolation).
- **Out of scope (dev sở hữu):** unit / integration / contract (BE/FE tự lo — vd unit test hàm kiểm quyền hiển thị nút, contract request/response của API gửi lời mời).
- **Out of scope vòng này (ghi nhận, không bịa case):**
  - CR-002 và BR20 "danh sách TK bị cắt ở 10, TK thứ 11+ không chọn được" (L92) — CR-002 không tồn tại (Q-14); loại case "TK thứ 11+" khỏi CR-001.
  - Cập nhật PROJECT_KNOWLEDGE (L193), Ma trận phân quyền — tài liệu không tồn tại, chỉ kiểm bằng đối chiếu dòng spec ở INTAKE mục 4.3 khi BA cập nhật.
  - Phân quyền riêng theo role cho từng thao tác Danh bạ: G007 OOS07 (:328). Gửi kèm lời nhắn: G012 OOS04 (:279).
  - Perf / load / stress.

## 2. Test types áp dụng

Intake khuyến nghị: acceptance, system, e2e, regression, exploratory, a11y; KHÔNG recommend perf-smoke (CR không đổi tải). `testDepth` = deep (lane high-risk).

| Type | Có? | Ghi chú |
| --- | --- | --- |
| Acceptance (theo AC) | ✅ | Mỗi BR delta (G007 BR18, BR19; G017 BR24, BR26; CR-FLOW-01/02/03; MATRIX-§6-a…f) ≥ 1 case; mỗi lối ①②③④ × vai × trạng thái assign. Phiếu ghi "☑ Acceptance Criteria" nhưng KHÔNG chép nội dung AC (L154, L157) → AC sinh từ BR + luồng của CR (Q-01), nhãn "nguồn: CR-001 only". Baseline/regression lấy AC của spec hiện hành (G007 §9 :246-314, G017 §11 :403-476, G012 §11 :245-268) |
| System / E2E | ✅ | Luồng xuyên FE-BE-Zalo: nhân sự không QLTK gõ SĐT → kết bạn → lời mời vào tab Đã gửi → Thu hồi, KHÔNG mở hội thoại/nhắn tin trước. **`cross-service-e2e` (flag, chưa hard gate):** Web → Server Gopany → Chat-Zalo Service → Zalo (G017:23, :63-64, :124-128); Gopany và Chat-Zalo lưu dữ liệu độc lập (G017:520). Tách 2 tập: (a) chạy trên stub/mock Chat-Zalo nếu Dev cấp; (b) tập nhỏ chạy Zalo thật bằng TK/SĐT thử (Q-12). Gồm test phân quyền API ①②③ và cô lập workspace (`multi-tenant-isolation`) — kỳ vọng API chờ Q-10 |
| Regression | ✅ | `regression-scope`: R1–R8 (mục 5.3), tập regression đã ship của 4 lối + ma trận phân quyền + G017/G012/G003. Quy mô lớn → ứng viên vào `wiki/qa/regression-suite/` sau khi ổn định. Chạy lại R1/R2/R3/R4/R8 sau MỌI lần Dev sửa |
| Exploratory | ✅ | `testDepth=deep` + security. Charter gợi ý: (1) nhân sự đổi quyền/assign/kết nối giữa chừng khi popup/khối đang mở (Q-11); (2) "lách" tinh thần G003 BR26 Case C — hội thoại đã gán NV A nhưng chưa là bạn, NV B kết bạn qua ③ (INTAKE R1); (3) sửa request đổi `accountId` sang TK không assign / TK workspace khác; (4) bấm đúp / gửi song song 2 nhân sự cùng SĐT + cùng TK (G007 BR02 :144); (5) SĐT ở mọi trạng thái quan hệ (đã là bạn, đang chờ, lời mời đến, bị block); (6) nhân sự có nhiều TK, TK dùng gần nhất bị DISCONNECTED |
| Accessibility (a11y) | ✅ | Chỉ các phần UI của CR: nút "Kết bạn" header (①), "Thêm bạn" (②), popup (dropdown TK/SĐT/Tìm kiếm/Kết bạn/Nhắn tin/Thu hồi), khối "Tìm & Kết bạn" + ô "Tài khoản Zalo thực hiện" + "Gửi lời mời kết bạn" (③), confirm dialog ④. Kiểm: thao tác bằng bàn phím, thứ tự focus, nhãn nút/ô chọn đọc được, toast/trạng thái "Đã gửi lời mời" có thông báo cho trình đọc màn hình, nút disabled có trạng thái rõ. Công cụ định hướng: axe (qua Playwright). Không có wireframe/FE spec chi tiết → case a11y chỉ nêu theo chuỗi UI trong spec, không bịa layout |
| Perf-smoke | ☐ | KHÔNG đưa vào: CR đổi điều kiện hiển thị, không đổi tải/đường tra cứu (intake không recommend). Trừ vòng "D1 = tra Zalo tự động khi gõ" (Q-17 cách hiểu 2) — khi đó phá G017 BR06, xử lý bằng kiểm R8 chứ không phải perf-smoke |
| Unit / Integration / Contract | ☐ | **Dev sở hữu** — KHÔNG in-scope |

## 3. Môi trường + dữ liệu

### 3.1 Môi trường

- **Env (theo `projectConfig.qa.environments`):** local / staging / uat. Env chạy chính = **staging** (lane high-risk, cần dữ liệu phân quyền và Chat-Zalo Service gần thật nhất); local cho exploratory nhanh và baseline sơ bộ; uat cho smoke trước go-live.
- **Hiện CHƯA có thông tin:** URL env, build/version trước và sau sửa, TK Zalo thử, SĐT thử, giới hạn lời mời của Zalo (Q-12 VẪN MỞ — **chặn THỰC THI, không chặn viết kỳ vọng**). Không dùng TK/SĐT khách thật (G017:482, :519: tra cứu nhiều có thể khiến Zalo hạn chế TK workspace).
- Cần ghi lại **build/commit trước sửa** và **sau sửa** làm khoá so sánh baseline (mục 4).

### 3.2 Bộ tài khoản (người dùng) — vai × trạng thái assign × trạng thái kết nối

Tên tạm do QA đặt để tham chiếu trong case; tên/tài khoản thật điền khi Dev/BA cấp (Q-12). Workspace chính **WS-A**; workspace thứ hai **WS-B** cho cô lập.

**TK Zalo (Zalo account) trong WS-A:**

| ID | Trạng thái | Dùng để |
|---|---|---|
| ZA1 | CONNECTED | TK chính, assign cho nhân sự thử |
| ZA2 | CONNECTED | TK thứ hai (nhân sự nhiều TK; test TK dùng gần nhất, dropdown G017 BR09-BR10) |
| ZA3 | DISCONNECTED | Ngắt kết nối (G012 BR06, G007 E03, G017 E06) |
| ZA4 | CONNECTED | **KHÔNG assign** cho nhân sự thử — làm "TK không được phép" (R3, rò rỉ, Q-20) |
| ZA5 | DISCONNECTED | Dựng case "assign nhưng toàn DISCONNECTED" (Q-04) |

TK Zalo trong WS-B: **ZB1** CONNECTED (nhân sự WS-B), dùng cho cô lập workspace.

**Nhân sự WS-A (đối tượng test):**

| ID | Vai / quyền | Assign | Mục đích | Dựng được? |
|---|---|---|---|---|
| U-NS1 | Nhân sự thường, **KHÔNG** quyền "Quản lý tài khoản Zalo" | ZA1 (1 TK CONNECTED) | **Đối tượng chính của D1** (L30, L181); 1 TK → ô chọn TK tự chọn + ẩn (G017 BR09) | Có |
| U-NS2 | Như U-NS1 | ZA1 + ZA2 (nhiều TK CONNECTED) | Ô chọn TK hiện; mặc định "dùng gần nhất" (G017 BR10); ①② "mặc định trống" (G007:56) | Có |
| U-NS3 | Như U-NS1 | ZA1 + ZA3 (lẫn lộn) | TK CONNECTED lẫn DISCONNECTED (Q-04) | Dựng được, **kỳ vọng ❓ (Q-04)** |
| U-NS4 | Như U-NS1 | ZA3 (1 TK DISCONNECTED) | Q-04, G012 BR06 | Dựng được, **kỳ vọng ❓ (Q-04)** |
| U-NS5 | Như U-NS1 | ZA3 + ZA5 (toàn DISCONNECTED) | Q-04 | Dựng được, **kỳ vọng ❓ (Q-04)** |
| U-NS6 | Như U-NS1 | **Không assign TK nào** | G017 E04 "Bạn chưa được phân quyền tài khoản Zalo nào" (:235); ①② chưa có spec (Q-03) | Dựng được; ③ có câu chữ, ①② ❓ (Q-03) |
| U-NS7 | Nhân sự có quyền "Hiển thị cuộc hội thoại chưa gắn nhân sự" (G003 BR18) | ZA1 | Phạm vi tìm của Staff (G017 BR03, :274; §10E hàng 3); tránh nhầm với quyền QLTK (Q-15) | Có |
| U-QL1 | Nhân sự **CÓ** quyền "Quản lý tài khoản Zalo" | ZA1 | **Đối chứng** (L27): hành vi trước/sau sửa phải như nhau (R2) | Có |
| U-QL2 | Như U-QL1 | Không assign | Quyền QLTK nhưng chưa assign — "toàn quyền tương đương Admin" (G002:26) nên có ⇒ ❓ | Dựng được, **kỳ vọng ❓ (Q-16, Q-03)** |
| U-AD1 | Admin/Owner | Không assign TK nào | G003 BR11 / G017 §10E "mọi TK trong workspace" vs G007:152 / L169 (Q-16) | Dựng được, **kỳ vọng ❓ (Q-16)** |
| U-AD2 | Admin/Owner | Assign ZA1 | Admin có assign — đường chắc chắn | Có |
| U-MG | "Nhân viên quản lý"/"NS Quản lý" (G007:44, L161) | ? | R2, cột ma trận §6 | **CHƯA dựng được — Q-19** (không biết là role độc lập hay chính là Staff có quyền QLTK). Cho tới khi BA trả lời: dùng U-QL1 thay, ghi giả định |

**Nhân sự WS-B (cô lập workspace):** **U-B1** nhân sự thường không QLTK, assign ZB1; **U-B-AD** Admin WS-B. Dùng cho test: U-NS1 không thấy TK/danh bạ/lời mời WS-B; U-B1 không thấy ZA1; tìm SĐT chỉ có ở WS-B từ WS-A → không ra kết quả (G017:467); sửa request để gửi lời mời bằng ZB1 từ phiên U-NS1 và ngược lại → bị từ chối (kỳ vọng mã lỗi/log ❓ Q-10).

### 3.3 Số điện thoại thử (SĐT)

Mỗi SĐT gắn trạng thái quan hệ với **TK cụ thể** (quan hệ là theo cặp SĐT + TK). Pool SĐT cần nhiều và **dùng 1 lần**: kết quả tra cứu ghi nhớ 7 ngày theo (SĐT + TK) (G017 BR19, :298) và chỉ bị xoá khi gửi lời mời thành công (BR20) → mỗi lần chạy lại case cần SĐT mới hoặc chờ hết hạn; không dùng chung SĐT giữa 2 case chạy song song.

| Mã | Trạng thái | Quan hệ với | Dùng cho | Dựng được? |
|---|---|---|---|---|
| P1 | Chưa là bạn, có Zalo, chưa có trong danh bạ | ZA1/ZA2 | Happy path ①②③ | Có (nhiều số, 1 lần/số) |
| P2 | Đã là bạn | ZA1 | G007 AF01 (chỉ "Nhắn tin"), G017 E07 toast "Đã là bạn bè" + "Mở hội thoại" (:238); BR07 (không hiện khối nếu đã trong danh bạ) | Có |
| P3 | Đang chờ (NS đã gửi lời mời) | ZA1 | G007 AF02 "Đã gửi lời mời" disabled + Thu hồi (:112); BR02 (:144) | Có |
| P4 | Có lời mời ĐẾN (đối phương đã gửi cho TK) | ZA1 | ④ đủ 4 trạng thái (G012:50-56); ①②③ chưa có luồng (Q-06b) | Dựng được, **kỳ vọng ①②③ ❓ (Q-06)** |
| P5 | Block | ZA1 | G007 BR06/E05 hiển thị như "Không tìm thấy" (:148, :132) | Có (nếu Zalo thử cho phép) |
| P6 | Không tồn tại trên Zalo | — | G017 E05 (không thấy trên Zalo) | Có |
| P7 | Đã là bạn của **ZA4** (không assign cho NS), chưa là bạn của ZA1 | ZA4 | Q-20: khối ③ có hiện cho U-NS1 không; rò rỉ danh bạ ngoài phạm vi assign | Dựng được, **kỳ vọng ❓ (Q-20)** |
| P8 | Chỉ có ở WS-B (bạn của ZB1) | ZB1 | Cô lập workspace (G017:467) | Có |
| P9 | Độ dài biên 9 / 12 chữ số; 8 / 13 chữ số | — | G017 BR02 (:273: 9-12 chữ số, khớp 9 số cuối) | Có |
| P10 | SĐT đã có hội thoại gán cho NV khác nhưng chưa là bạn | ZA1 + NV khác | Exploratory R1 (G003 BR26 Case C) | Dựng được; kỳ vọng ❓ (exploratory, không phải câu hỏi spec) |

### 3.4 Chiến lược cô lập tenant (`multi-tenant-isolation`, BẮT BUỘC)

- Dữ liệu tách theo workspace: WS-A và WS-B có TK Zalo, nhân sự, danh bạ, SĐT riêng (mục 3.2, 3.3). Spec xác nhận cô lập là bắt buộc: G002:248-250, G007:301, G017:467, G032:286.
- **Case negative cross-tenant bắt buộc:** (1) U-NS1 (WS-A) không thấy/chọn được ZB1 trong dropdown/ô chọn TK; (2) tìm SĐT P8 từ WS-A → không ra kết quả và khối ③ không lộ danh bạ WS-B; (3) gọi API gửi lời mời bằng `accountId` của ZB1 từ phiên WS-A → từ chối (kỳ vọng ❓ Q-10); (4) ngược lại (U-B1 → ZA1); (5) lời mời đã gửi ở WS-A không xuất hiện ở tab Đã gửi của WS-B.
- Ghi nhớ tra cứu tách theo user (G017 BR23, :302): U-NS1 tra P1 rồi U-NS2 tra P1 qua cùng TK → không dùng chung kết quả ghi nhớ giữa 2 user.
- Không dùng chung SĐT/TK giữa case chạy song song ở 2 workspace; reset: dọn lời mời chờ (Thu hồi) và dọn danh bạ thử sau mỗi case nếu hệ thống cho phép (cách dọn chờ Dev chỉ dẫn).

### 3.5 Chỗ CHƯA dựng được vì câu hỏi mở

| Phần dữ liệu | Bị chặn bởi |
|---|---|
| Vai "NS Quản lý" (U-MG) | Q-19 |
| Admin chưa assign (U-AD1) — kỳ vọng dropdown/hiện nút | Q-16 |
| Nhân sự assign nhưng DISCONNECTED / lẫn lộn (U-NS3/4/5) — kỳ vọng ẩn/toast/khối | Q-04 |
| SĐT P7 (bạn của TK không assign) — kỳ vọng hiện/ẩn khối | Q-20 |
| SĐT P4 (lời mời đến) và trạng thái "đang chờ" ở ③ | Q-06 |
| Nhân sự assign ≥11 TK | Q-14 (CR-002 không tồn tại) — loại khỏi vòng này |
| TK Zalo thử, SĐT thử thật, giới hạn lời mời Zalo, env + build | Q-12 (chặn thực thi) |
| Kỳ vọng API (mã lỗi/thông điệp/log) cho TK không assign / user chưa assign / chéo workspace | Q-10 |

### 3.6 Automation (định hướng, CHƯA làm vòng này)

- Định hướng theo `projectConfig.qa.automation`: **Playwright** (E2E web + a11y qua axe) cho 4 lối; **REST-assured** (`apiBe`) / **Karate** (`apiAlt`) cho API gửi lời mời và test phân quyền API (qa-api-test).
- **Vòng này (Phase 2) là manual design-only** — user đã xác nhận CHƯA chạy Phase 4 (qa-automation-builder). Ứng viên automation khi làm: ma trận lối × vai × assign (data-driven), R3, R4, R8, cô lập workspace.
- `reportEvidence: true` áp dụng ngay khi thực thi tay: screenshot trước/sau mỗi bước, HAR/log request gửi lời mời (nhất là `accountId` đã dùng), ghi build version.
- Rủi ro flaky: xem mục 5.

## 4. Entry / Exit criteria

### 4.1 Entry (execution)

Không có FEAT nên không có `deps.qa` (be.done + fe.done) chuẩn. Entry thực tế thay thế:

1. **Env + build:** URL env, build **trước sửa** (để đo baseline) và build **sau sửa** (Dev báo xong) — Q-12.
2. **Bộ dữ liệu mục 3 dựng được:** tối thiểu U-NS1, U-NS2, U-NS6, U-QL1, U-AD2, ZA1-ZA4, pool SĐT P1/P2/P3/P6; WS-B cho cô lập.
3. **Đo baseline hiện trạng TRƯỚC khi Dev sửa (INTAKE Q-02) — BẮT BUỘC, là cổng entry cho cả vòng:**
   - Build: **trước sửa**; không để Dev deploy bản sửa lên env test trước khi baseline xong (nếu đã deploy → dựng lại từ commit trước hoặc ghi rõ "không đo được baseline" và chuyển các case đối chiếu sang ❓).
   - Phạm vi đo: lối **①** (nút "Kết bạn" header, G007 UC-01), **②** ("Thêm bạn" Danh bạ, G007 UC-01b), **③** (khối "Tìm & Kết bạn", G017 AF02), **④** (G012) với **U-NS1** (không QLTK, assign ZA1) và đối chứng **U-QL1** (có QLTK, assign ZA1); thêm U-NS6 (chưa assign) và U-NS2 (nhiều TK) nếu thời gian cho phép.
   - Ghi cho mỗi (lối × nhân sự): nút có hiện / ẩn / disable / toast; popup mở được không; dropdown liệt kê TK nào; bấm gửi có thành công không; lời mời có vào tab Đã gửi không; có buộc nhắn tin trước không; chuỗi UI nguyên văn. Evidence: screenshot + HAR.
   - Mục đích: (a) xác nhận lối nào CÓ gate QLTK trong code (spec không nói; chỉ ③ và đường vòng ④ có mô tả của khách, L27-28, L53-64); (b) chốt baseline so sánh trước/sau; (c) tách "sửa implementation cho đúng spec" khỏi "hành vi mới theo CR"; (d) kết quả ghi vào `wiki/qa/test-runs/CR-001_baseline.md` và trả lời Q-02.
4. Dev/BA đã nhận 21 câu hỏi; case ❓ có thể thực thi sau khi BA trả lời — KHÔNG chờ để bắt đầu thực thi các case đã rõ.
5. Có hướng dẫn dọn dữ liệu (Thu hồi lời mời, xoá bạn thử) hoặc script reset từ Dev.

### 4.2 Exit (sign-off) — theo `projectConfig.qa.exitCriteria`

- **AC coverage = 100%** — mỗi BR delta (G007 BR18, BR19; G017 BR24, BR26; CR-FLOW-01/02/03; MATRIX-§6-a…f) và mỗi BR/AC hiện hành thuộc R1–R8 có ≥ 1 test case. Case ❓ tính là *đã viết nhưng CHƯA đạt* cho tới khi BA trả lời và case được thực thi; **không** được coi ❓ là pass. Sign-off cần: mọi ❓ đã được trả lời và thực thi, hoặc user ghi nhận loại/hoãn rõ ràng (vd Q-14).
- **Blocking severity pass = 100%; open critical defects = 0.** Case thuộc `security-test` (phân quyền ①②③, không rò TK không assign, cô lập workspace, phía server) và R1/R2/R3/R4/R8 coi là **blocking**.
- **Evidence đầy đủ** cho mọi case pass (screenshot/HAR/log, ghi build, user, SĐT, TK Zalo đã dùng) — bắt buộc do `reportEvidence: true`.
- Baseline trước sửa đã đo và lưu; mọi khác biệt trước/sau đều được giải thích bằng delta D1–D5 (khác biệt ngoài delta = nghi regression → defect hoặc hỏi BA).

## 5. Rủi ro / lane

- **Lane:** `high-risk` (từ INTAKE-CR-001; status `high-risk-pending-confirmation` — scope user đã xác nhận theo đề xuất intake).
- **Flags:** `security-test` (hard gate), `regression-scope`, `flaky-risk`, `multi-tenant-isolation`, `cross-service-e2e` — 5 flag (3 → 5). Không có `data-integrity`, không `no-ac-source`.
- **Hard gates chạm:** `security-test`. `multi-tenant-isolation` và `cross-service-e2e` là flag, chưa nâng hard gate (CR không đổi phạm vi tenant, L147; không nói đổi contract); xem lại nếu Q-10/Q-20 cho thấy gate cũ đang gánh việc kiểm workspace.

### 5.1 Ảnh hưởng tới test focus

- **`security-test` →** gỡ yêu cầu "Quản lý tài khoản Zalo" = **nới điều kiện hiện nút**. Trọng tâm: (a) nhân sự KHÔNG assign vẫn không kết bạn được (U-NS6, ③ E04; ①② chờ Q-03); (b) không gửi được qua TK không assign (ZA4) kể cả sửa request; (c) kiểm phía server — bỏ gate UI không được làm lộ API; spec có cơ chế từ chối + log ở ④ (G012 E04, :134) nhưng ①②③ chưa nêu (Q-10); (d) không lộ liên hệ/danh bạ của TK không assign (Q-20); (e) Admin bypass đúng phạm vi (Q-16).
- **`regression-scope` →** 4 lối đã ship, ma trận phân quyền, G017/G012/G003. R1–R8 (mục 5.3). Lối ④ không đổi nhưng là đường bị người dùng dùng "vòng" từ trước → bất kỳ thay đổi nào ở ④ là defect.
- **`flaky-risk` →** phụ thuộc Zalo ngoài; trạng thái CONNECTED đổi theo thời gian; ghi nhớ 7 ngày/30 giây (G017 BR19/BR22) khiến kết quả phụ thuộc thời điểm; SĐT dùng lại gây sai lệch. Xử lý: SĐT dùng 1 lần; chạy tuần tự các case chung TK/SĐT; không assert cứng thời gian; kiểm lại trạng thái CONNECTED của ZA1-ZA4 ngay trước mỗi đợt chạy; tránh chạy khi Zalo hạn chế TK.
- **`multi-tenant-isolation` →** mục 3.4.
- **`cross-service-e2e` →** Web → Server Gopany → Chat-Zalo → Zalo; tách tập stub/thật; kiểm "không gọi Zalo khi chưa bấm" (R8).

### 5.2 Câu hỏi đang CHẶN kỳ vọng → nhóm case bị ảnh hưởng (sẽ viết ở dạng ❓)

Nhãn ❓ = case vẫn viết (bước + dữ liệu), ô "Kết quả mong đợi" ghi ❓ + tên câu hỏi + giả định tạm nếu có; KHÔNG tự điền kỳ vọng.

| Q | Nội dung | Nhóm case bị ảnh hưởng (dạng ❓) | Giả định tạm cho phép viết |
|---|---|---|---|
| **Q-17** | BR26 "hiện NGAY trên kết quả" ba cách hiểu loại trừ: (1) bước 7a hiện hành sau khi bấm "Tìm & Kết bạn"; (2) bỏ bước bấm, tra Zalo khi gõ (phá G017 BR06); (3) nút trên hàng kết quả nội bộ (phá BR07) | Mọi case ③ về thời điểm/vị trí nút, "không hỏi lại TK", sơ đồ "sau sửa" (L72-79); R8 khi cách hiểu (2) | Theo (1), gắn "giả định"; thêm case "không gọi Chat-Zalo khi chưa bấm" (R8) |
| **Q-10** | Phân quyền phía server (API) cho ①②③ không nêu; không rõ server từng chặn theo QLTK chưa | Case API: TK không assign → từ chối; user chưa assign → từ chối; chéo workspace → từ chối; mã lỗi, thông điệp, log; case "sửa request" (security-test) | Chỉ khẳng định "bị từ chối, không tạo lời mời"; mã/thông điệp ❓ (có thể bám G012 E04 nhưng cần BA xác nhận) |
| **Q-20** | "Có trong danh bạ" (BR07) tính toàn workspace hay theo TK được assign | Khối ③ hiện/ẩn với P7 (bạn của ZA4, không assign cho NS); rò rỉ danh bạ TK không assign (G007 UC-04 :89, :295 vs G017 BR03 :274); G007 BR18 "hiện với mọi nhân sự assign ≥1" | Không có — cả 2 nhánh ❓ |
| **Q-04** | Assign nhưng DISCONNECTED / lẫn lộn: ẩn khối hay hiện + toast E06; ①②③④ cho 4 kiểu phản hồi khác nhau với cùng sự kiện; dropdown ①② có liệt kê TK DISCONNECTED không (BR10 vs E03) | U-NS3/4/5 × ①②③④; CR-FLOW-02 (L74-75 "không có TK CONNECTED → không thấy khối" vs G017 E04 chỉ "chưa assign"); dropdown chứa ZA3 | Riêng ④: ẩn nút (G012 BR06) là spec chắc chắn — case ④ **không** ❓ |
| **Q-16** | Admin/Owner có cần assign ≥1 TK (G007:152/L169 vs G003 BR11, G017 §10E) | U-AD1: ①②③ có dùng được không; dropdown liệt kê TK nào | Đường chắc chắn: Admin có assign (U-AD2); Admin chưa assign ❓ |
| **Q-19** | "Nhân viên quản lý"/"NS Quản lý" là gì so với quyền QLTK | R2, cột "NS Quản lý" ma trận §6 (MATRIX-§6-a…f), bộ TK thử (3 hay 4 vai) | Dùng U-QL1 thay U-MG, ghi giả định |
| Q-03 | UI ①② khi Staff chưa assign (ẩn nút hay hiện + trạng thái rỗng, câu chữ); G007:53 "trong workspace" vs "được assign" | U-NS6 × ①②; U-QL2 | ③ có câu chữ G017 E04; ①② tạm bám câu E04, ghi "giả định" |
| Q-06 | Nút theo trạng thái quan hệ ở ③ (đang chờ, lời mời đến, TK trong workspace, từ khoá không phải SĐT) | P3/P4 × ③; ①② với P4 | ①② có AF01/AF02; ④ có G012 BR01-BR12; ③ phần chưa có ❓ |
| Q-09 | Hậu điều kiện: nhân sự khác cùng assign có thấy lời mời chờ không; người mới chỉ PENDING có ở màn Danh bạ không (G007:89 "là bạn bè" vs G017 BR21 "thêm danh bạ ngay") | R6, kiểm sau khi gửi từ ③ | Chắc chắn: không tạo hội thoại (G007 BR08, :150); xoá ghi nhớ (G017 BR20); vào tab Đã gửi (G007:61) |
| Q-11 | Đổi assign / kết nối khi phiên đang mở ở ①②③, ngưỡng thời gian | Exploratory + case "mất quyền giữa chừng" ①②③ | ④ có G012 E04; ①②③ chỉ test sau tải lại và ghi giới hạn |
| Q-08 | Lỗi riêng của hành động gửi ở ③ (G017 chỉ định nghĩa E05-E08 cho bước TRA CỨU), hạn mức lời mời Zalo, SĐT không cho nhận lời mời | Case lỗi gửi ③ | ①② E03/E06 (G007:130, :133), ④ E01-E03 có sẵn |
| Q-18 | Điều kiện chung ma trận dòng 5 (Đặt tên gợi nhớ) lệch G032 BR06 (quyền xem hội thoại/danh bạ) / BR10 (TẤT CẢ TK liên quan CONNECTED) | MATRIX-§6-e, R5 phần G032 | Tạm test theo G032 hiệu lực; chỉ giữ chung "không đòi QLTK" |
| Q-13 | R-01 không được định nghĩa; phạm vi QA cho 4 dòng ma trận còn lại; "Quản lý nhóm" (G008) | MATRIX-§6-d (Xoá bạn "⚠️ xem R-01"), R5 | Mặc định: smoke theo vai (không đòi QLTK) + regression R5 |
| Q-01 | Spec chưa cập nhật theo CR; BR/AC mới chỉ có trong CR | Nhãn "nguồn: CR-001 only" trên mọi case BR18/BR19/BR24/BR26/ma trận | **Không chặn** — QA test spec hiện hành + delta CR |
| Q-14 | CR-002 + BR20 (TK thứ 11+) | Case danh sách TK dài/cuộn | Loại khỏi vòng này |
| Q-12 | Env, TK/SĐT thử, giới hạn Zalo | **Chặn THỰC THI**, không chặn viết kỳ vọng | — |
| Q-02 | Hiện trạng thật ①② | Giải quyết bằng baseline ở mục 4.1 | — |
| Q-21 | Mã BR/mục CR lệch spec (BR25, "§7a", G003 trích lệch 2-6 dòng) | Chỉ ảnh hưởng truy vết; không chặn | Luôn ghi tiền tố tài liệu + số dòng spec hiện hành |

Đã rõ (viết kỳ vọng được ngay): Q-05 (③ tra qua đúng 1 TK đã chọn ở ô "Tài khoản Zalo thực hiện"; G017:174-178), Q-15 (BR18 trùng mã chỉ là trùng tên), phần "bản G032 nào" của Q-18, Q-07 (chuỗi UI theo từng lối) .

### 5.3 Regression cần canh (theo INTAKE mục 2.3)

| Mã | Nội dung | Nguồn spec | Ưu tiên |
|---|---|---|---|
| R1 | Lối ④ + auto-assign: confirm dialog (G012 BR05), E04, G003 BR26 Case A (hội thoại nháp, auto-assign khi gửi tin đầu)/B/C; phiếu khẳng định "không phải sửa" | G012:153-164, :134; G003:322, AC :607-612 | Blocking |
| R2 | Admin / "Nhân viên quản lý" / nhân sự có QLTK vẫn dùng được cả 4 lối (chờ Q-19) | G007:43-45 | Blocking |
| R3 | Dropdown/ô chọn TK chỉ liệt kê TK được assign — không lộ ZA4 | G007 BR10 :152; G017 BR08 :279, BR09 :280, BR10 :281 | Blocking (security) |
| R4 | Staff chưa assign: "Bạn chưa được phân quyền tài khoản Zalo nào" (③); ①② chờ Q-03 | G017 E04 :235, §10E :399 | Blocking |
| R5 | 4 thao tác khác của ma trận §6: Thu hồi, Chấp nhận/Từ chối, Xoá bạn, Tên gợi nhớ | G007 UC-02/03/05, G012 UC-02, G032 BR06/BR10 | Cao |
| R6 | Sau gửi lời mời từ ③: xoá ghi nhớ tra cứu, thêm danh bạ, tên gợi nhớ khi thành bạn, tab "Người lạ"/chuyển hội thoại (`thay-doi-28-29-09.html` L107-108, chưa đọc lại vòng này) | G017 BR20/BR21 :299-300; G032 BR11 :145 | Cao |
| R7 | Màn khác phụ thuộc CONNECTED/DISCONNECTED | G012 BR06, G007 E03, G017 E06, G003 BR10, G002 BR01, G033 BR11/E02, G032 BR10 | Trung bình |
| R8 | Bất biến tìm kiếm: không tự gọi Chat-Zalo khi gõ (BR06); ghi nhớ 7 ngày theo (SĐT + TK) (BR19); ghi nhớ tách theo user (BR23); gõ liên tục không phát sinh lượt tra; nút vô hiệu khi đang tra | G017:277, :298, :302; AC :433-435 | Blocking (canh sát nếu Q-17 = cách hiểu 2) |

### 5.4 Rủi ro khác

- **Baseline không đo được** nếu Dev sửa trước → mất khả năng phân biệt "sửa cho đúng spec" với "hành vi mới" (xử lý ở mục 4.1).
- **Spec chưa cập nhật** (G007 BR18/BR19, G017 BR24/BR26, Ma trận §6, PROJECT_KNOWLEDGE): kỳ vọng case delta chỉ dựa CR; nếu BA chỉnh lại CR thì viết lại. Bảng dòng cần sửa: INTAKE mục 4.3.
- **Ma trận phân quyền, CR-002, PROJECT_KNOWLEDGE không tồn tại** → không đối chiếu được.
- **Chuỗi "Kết bạn ngay"** (L27, L76) KHÔNG có trong spec hiện hành nào → không dùng làm kỳ vọng nhãn nút (Q-07).
- **Tác dụng phụ lên TK Zalo thật:** gửi lời mời thật và tra cứu nhiều có thể bị Zalo hạn chế (Q-12).

## 6. Liên kết

- Test cases: `wiki/qa/test-cases/CR-001.md` (Phase 3 — chưa tạo)
- Test runs: `wiki/qa/test-runs/CR-001_*.md` (kể cả `CR-001_baseline.md` — đo baseline trước sửa)
- Intake (nguồn phân tích): `wiki/qa/intake/INTAKE-CR-001.md`
- Phiếu CR: `tailieu/CR-001 - Quyền kết bạn của nhân sự.md`
- Spec hiện hành: `tailieu/G007*` · `G017*` · `G012*` · `G002*` · `G003*` · `G001*` · `G032 - Đổi tên gợi nhớ (1).md` · `G033*` (R7)
- FEAT: **chưa tồn tại** — khi BA/orchestrator tạo `wiki/features/FEAT-<NNN>.md`, backfill link tại đây và tick row 4.4 "Test plan".

## Lịch sử cập nhật

| Ngày | Người | Thay đổi |
|---|---|---|
| 2026-10-07 | QA | Tạo test plan lần đầu (Phase 2) từ INTAKE-CR-001: scope delta D1–D5 / không đổi (lối ④), 6 test type (không perf-smoke), bộ dữ liệu vai × assign × kết nối + 2 workspace + pool SĐT, entry gồm đo baseline ①②③④ trước sửa (Q-02), exit theo `qa.exitCriteria`, rủi ro + bảng câu hỏi chặn (Q-17, Q-10, Q-20, Q-04, Q-16, Q-19…) → nhóm case ❓, regression R1–R8. Không có FEAT nên bỏ verify claim và tick FEAT §4.4. Automation chỉ là định hướng (manual design-only). |
