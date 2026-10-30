---
featureId: CR-004
title: Nâng mốc tách tin nhắn dài (1.000 → 2.000 ký tự)
sourceDoc: tailieu/CR-004 - Nâng mốc tách tin nhắn dài.md (Last updated 2026-09-29)
specHienHanh: tailieu/G003 - Chat.md (v1.11) · G005 - Tin nhắn mẫu.md (v1.4) · G009 - Tính năng bổ sung Chat.md (v1.12) · G015 - Hiển thị Thumbnail khi gửi kèm Link.md (v1.1) — chưa cập nhật theo CR-004
createdBy: QA
createdAt: 2026-10-07
updatedBy: QA
updatedAt: 2026-10-07
phase: 1 — intake & classification (CHƯA có plan / case)
status: ok
lane: normal
---

# INTAKE — CR-004 Nâng mốc tách tin nhắn dài

## 1. Nguồn và AC-source

- Nguồn thay đổi: `tailieu/CR-004 - Nâng mốc tách tin nhắn dài.md`. Project chưa có `wiki/features/FEAT-*.md` (cùng tình trạng HB-003 trong `wiki/HARNESS_BACKLOG.md`).
- B1: coi §1.3 (4 điểm chốt), §1.4 (không đổi), §1.5 (bảng kỳ vọng) là AC-source cho phần **delta**, cộng spec hiện hành G003/G005/G009/G015 cho phần **không đổi**. Không trả `blocked-no-ac`.
- Trạng thái theo CR (§1.8): "Đã sửa tài liệu · chờ dev làm" → **chưa có build**; thực thi test bị chặn tới khi dev xong (shift-left design được).
- **Quyết định của user (2026-10-07):** các file trong `tailieu/` là **bản duy nhất** của tài liệu. Số version CR-004 §1.7 dẫn (G003 1.23, G005 1.7, G009 1.15, G015 1.4) chỉ là các lần sửa trực tiếp trên docs; **không có file bản khác để chờ**.

**Hệ quả — hiện trạng cần ghi rõ:** G003/G005/G009/G015 trong `tailieu/` là **spec hiện hành** và **chưa được cập nhật theo CR-004**. Header của chúng ghi version thấp hơn con số CR dẫn, và nội dung vẫn là mốc cũ:

| Spec hiện hành | Version trong header | CR §1.7 dẫn | Vẫn ghi (bằng chứng spec chưa sửa) |
|---|---|---|---|
| G003 Chat | 1.11 (dòng 11, 2026-08-03) | 1.23 | mốc 1.000 (dòng 84, 297, 298, 566-571); "1.000 là giới hạn Zalo API" (297) |
| G005 Tin nhắn mẫu | 1.4 (dòng 11, 2026-08-17) | 1.7 | trần 3.000; mốc 1.000; BE validate ≤1.000 (dòng 258, 366, 473, 519-523) |
| G009 Bổ sung Chat | 1.12 (dòng 11, 2026-08-26) | 1.15 | mốc 1.000 (dòng 241); "Counter 1000 ký tự" (326, 394) |
| G015 Thumbnail Link | 1.1 (dòng 11, 2026-07-21) | 1.4 | "1.000 ký tự chung" (dòng 48, 266) |

**Quy ước test cho tới khi BA trả lời Q-14:** QA test theo **G-spec hiện hành + delta ghi trong CR-004**. Chỗ nào CR và spec hiện hành nói khác nhau (Q-10, Q-12, Q-13 và các dòng ở §8) thì ghi là **mâu thuẫn thật**, không viết kỳ vọng cho tới khi BA chốt.

## 2. Delta so với hành vi cũ

| # | Hạng mục | Trước (spec hiện hành) | Sau CR | Vị trí |
|---|---|---|---|---|
| D1 | Mốc tách tin dài (G003 BR03) | **1.000 ký tự** (G003 dòng 297, 84) | **2.000 ký tự**, vượt mới tách | CR §1.3 #1 (dòng 36) |
| D2 | Lý do con số (G003 BR03) | ghi "1.000 là giới hạn của Zalo API" (G003 dòng 297) | CR §1.2 nói "trần của Zalo", §1.3 #2 nói "mức hệ thống tự đặt", §1.7 nói "trần Zalo, có bằng chứng" — **3 câu không thống nhất** → Q-08 | CR dòng 26, 37, 75 |
| D3 | Trần nội dung Tin nhắn mẫu (G005 BR08) | **3.000 ký tự**, vượt → không gõ thêm được (G005 dòng 258, 473, 519) = đúng 3 × 1.000 | luật **3 × mốc = 6.000** | CR §1.3 #3 (dòng 38) |
| D4 | G009 BR12 và G015 | G009: mốc 1.000 plaintext (dòng 241); G015: "1.000 ký tự chung" (dòng 48) | kế thừa mốc mới | CR §1.4 (47), §1.7 |
| D5 | BE validate mỗi lần gọi (G005 BR08) | **BE từ chối > 1.000 ký tự/lần gọi** (G005 dòng 258, 522); FE tách | CR không nói → mâu thuẫn thật, Q-10 | — |
| D6 | Counter ở ô soạn có định dạng (G009) | **"Counter 1000 ký tự"** (G009 dòng 326, 394) | "không counter" (CR §1.3 #4) → mâu thuẫn thật, Q-12 | CR dòng 40 |
| — | Giữ nguyên | cách cắt BR03b, cách gửi BR03c, ô soạn không giới hạn/không cảnh báo, đếm plaintext | không đổi | CR §1.4 |

Bảng kỳ vọng CR §1.5: ≤1.000 → 1 tin; 1.500 → 1 (cũ 2); 2.000 → 1 (cũ 2); 3.000 → 2 (cũ 3). Lưu ý bảng này là **cận dưới lý thuyết** → Q-09.

## 3. Baseline "TRƯỚC CR" — G003 v1.11 (spec hiện hành, mốc 1.000)

Nguồn: `tailieu/G003 - Chat.md`. Đây là hành vi spec đang mô tả và dev đang chạy; CR đổi con số.

| Khía cạnh | Quy tắc G003 (nguyên văn) | Dòng |
|---|---|---|
| Khi nào tách | "**Tại thời điểm nhấn Gửi**, nếu nội dung vượt **1.000 ký tự** → hệ thống **tự động tách thành nhiều tin nhắn nối tiếp**, mỗi tin ≤ 1.000 ký tự. Trong lúc soạn **không tách, không chia ô**" | 297 (BR03) |
| Biên | "Nếu nội dung > 1.000 ký tự → tự động tách … Nếu ≤ 1.000 → giữ nguyên 1 tin"; AC: "Nội dung ≤ 1.000 ký tự → gửi thành **1 tin duy nhất**, không tách" | 84, 571 |
| Điểm cắt | "cắt tại **dấu xuống dòng** gần nhất trước mốc 1.000 ký tự; nếu không có, cắt tại **khoảng trắng** gần nhất — **không vỡ từ giữa chừng**" | 298 (BR03b) |
| Không có ranh giới | "Nếu một đoạn liền không có ranh giới nào trong 1.000 ký tự → **cắt cứng tại 1.000**"; AC: "Đoạn liền >1.000 ký tự không có khoảng trắng → cắt cứng tại 1.000, không treo" | 298, 570 |
| Thứ tự / lỗi | nối tiếp đúng thứ tự; mỗi phần là tin độc lập (Đang gửi / Đã gửi / Lỗi gửi); phần lỗi có Retry riêng, không ảnh hưởng phần đã gửi | 299 (BR03c), 572-573 |
| Ai tách | "hệ thống" (BR03); đường gửi "qua hub-chat-zalo → Zalo" (UC-02a bước 5). G005 OQ02 chốt 2026-07-22: "**Hệ thống tách, tại thời điểm nhấn Gửi**" (G005 dòng 564); G005 BR08: "**FE tách**, backend validate ≤1.000/lần gọi" (dòng 258) | 84-86; G005 564, 258 |
| Ví dụ AC | "Gửi nội dung 2.500 ký tự → tự tách thành **3 tin** nối tiếp" | 568 |
| Gỡ chặn cũ | E06 đã bãi bỏ; phải gỡ toast "Nội dung tin nhắn phải nhỏ hơn 1000 ký tự" | 270, 567 |

**KHÔNG có trong G003 (không được đoán):** xử lý ký tự phân cách (giữ/bỏ/trim); đơn vị đếm (code point, UTF-16, byte); emoji/NFC/NFD/CRLF; độ dài tối thiểu của phần; cắt khi newline nằm đúng ở vị trí mốc; trường hợp 1 link/số điện thoại bị cắt cứng.

### 3.1 Đối chiếu số học ví dụ CR §1.1 (2.069 → 932 / 999 / 135)

1. Tính: 932 + 999 + 135 = **2.066** ≠ 2.069 → thiếu **3 ký tự**. (Kiểm lại: 932 + 999 = 1.931; 1.931 + 135 = 2.066.)
2. Mỗi phần ≤ 1.000 ✓ (BR03 baseline); số phần = 3 ✓ (2.069 > 1.000; ceil(2069/1000) = 3). Hai điểm cắt (giữa P1|P2 và P2|P3), không phải ba.
3. Gọi g1, g2 = số ký tự bị bỏ tại điểm cắt 1 và 2; g0, g3 = ký tự bị trim ở đầu/cuối toàn văn. Ràng buộc từ số liệu: **g0 + g1 + g2 + g3 = 3**.
4. G003 BR03b chỉ nói "cắt tại dấu xuống dòng gần nhất trước mốc". Nó **không** nói ký tự xuống dòng được giữ hay bỏ, cũng không nói trim. Do đó:
   - Nếu phân cách **được giữ** trong một phần: tổng các phần phải = 2.069 → mâu thuẫn với 2.066 (loại).
   - Nếu mỗi điểm cắt **bỏ đúng 1 ký tự xuống dòng**: g1 + g2 = 2 → tổng 2.068, **vẫn lệch 1**. Quy tắc G003 + cách đọc đơn giản nhất **không giải thích được** 3 ký tự.
   - Để ra 3 cần thêm một giả định ngoài G003: (a) một điểm cắt rơi vào dòng trống / CRLF / "xuống dòng + khoảng trắng" (bỏ 2 ký tự) + điểm kia bỏ 1; hoặc (b) trim khoảng trắng đầu phần tiếp theo; hoặc (c) trim cuối văn bản gốc (g3); hoặc (d) con số 2.069 do công cụ khác đếm (Zalo Web / Word / CRLF = 2) khác cách đếm của code.
5. Gợi ý nhẹ từ P2 = 999 (không phải 1.000): nếu cửa sổ 1.000 ký tự có xuống dòng ở ký tự thứ 1.000 và xuống dòng đó bị bỏ thì ra 999 — khớp "bỏ phân cách". Nếu thế, P3 bắt đầu tại vị trí 2.069 − 135 = 1.934 và P2 bắt đầu 1.934 − 1 − 999 = 934 = 932 + 2 → g1 = 2, g2 = 1. Đây là **một nghiệm khả dĩ, không phải kết luận**, vì không có văn bản gốc.
6. **KẾT LUẬN:** G003 **không** giải thích được 3 ký tự lệch. Quy tắc "bỏ 1 ký tự xuống dòng mỗi điểm cắt" (2 điểm cắt → 2 ký tự) chỉ giải thích 2/3. Phần còn lại (ít nhất 1 ký tự) cần (i) văn bản gốc 2.069 ký tự và (ii) BA/dev nêu quy tắc xử lý ký tự phân cách/trim. Chưa đủ căn cứ để chọn giữa (a)-(d).
7. Hệ quả cho test: **không viết được** kỳ vọng "ghép các phần = nội dung gốc" ở dạng bằng-nhau tuyệt đối. Z-02 TC-87 ("ghép 2 tin lại = đủ 1001 ký tự gốc") và TC-88 ("không mất nội dung") **không có căn cứ trong G003/G005**; nếu phân cách bị bỏ thì ghép lại luôn ít hơn gốc khi cắt tại xuống dòng/khoảng trắng (chỉ bằng nhau khi cắt cứng) → TC-87 có nguy cơ sai kể cả trước CR. Xem Q-02.

## 4. Case Z-02 bị ảnh hưởng — đối chiếu với G005 thật

**Z-02 và G005 là CÙNG tính năng:** G005 dòng 5 ghi "Feature ID ~~Z-02~~ **G005**" (đã đổi mã). `wiki/qa/test-cases/Z-02.md` viết theo **spec v1.1 (2026-06-08)** (Z-02 dòng 3); G005 hiện hành **v1.4** (2026-08-17). Nghĩa là Z-02 đã lệch spec **trước cả CR**: thiếu trần mẫu 3.000 (v1.4), thiếu "FE tách / BE validate ≤1.000" (v1.4), thiếu rich text/import chỉ text thuần (v1.3), và ghi sai actor tách (xem dưới).

**Z-02 ghi "Zalo tự tách" — sai so với tài liệu gốc:**
- G003 UC-02a bước 3b + BR03: "**hệ thống** tự động tách" (dòng 84, 297).
- G005 OQ02 (✅ giải quyết 2026-07-22): "**Hệ thống tách**, tại thời điểm nhấn Gửi" (dòng 564); BR08 v1.4: "**FE tách**, backend validate" (dòng 258).
- CR §1.3 #3b: "**Hệ thống vẫn tự tách**, dù Zalo cũng tự tách ở 2.000" (dòng 39) — **khớp** G003/G005.
- → Z-02 AC-31 (dòng 213), TC-87 (dòng 160), tiêu đề nhóm J (dòng 157: "Giới hạn 1000 ký tự của Zalo") **sai actor/nhãn** từ trước CR; CR-004 không phải nguyên nhân nhưng buộc phải sửa.

**Sẽ SAI nếu mốc = 2000 (phải sửa kỳ vọng):**

| Case / mục | Giả định cũ | Sau CR | Mức |
|---|---|---|---|
| **TC-Z02-87** (AC-31, max+1) | 1001 ký tự → "Zalo tự tách" 2 tin, ghép = đủ 1001 | **1 tin** (1001 ≤ 2000); đồng thời actor sai và yêu cầu "ghép = đủ" không có căn cứ (§3.1 #7) | Sai kỳ vọng + sai actor |
| **TC-Z02-88** (AC-31) | 2500 ký tự → 3 tin (khớp G003 AC dòng 568 ở mốc 1.000) | **2 tin** (2.500 > 2.000, ≤ 4.000; cần điểm cắt ở vị trí 500-2.000) | Sai kỳ vọng |
| **TC-Z02-89 ❓** (AC-31, emoji tại mốc) | emoji/xuống dòng ở vị trí 1000 | điểm cắt dời sang 2000; fixture phải dựng lại; OQ-16 vẫn mở (Q-03) | Sai fixture |
| **AC-30** (ma trận §2, dòng 212) | "≤ 1000 → 1 tin" | "≤ 2000 → 1 tin" | Sai AC |
| **AC-31** (dòng 213) | "> 1000 → Zalo tự tách" | "> 2000 → hệ thống tự tách" | Sai AC + actor |
| **BR08** (nhóm J, §0.1 dòng 39, bảng phủ dòng 229) | giới hạn 1000 "của Zalo" | mốc 2000 "hệ thống tự đặt" (nếu BA chốt, Q-08) | Sai nhãn/trace |

**Còn PASS nhưng mất giá trị biên (nên thay):**

| Case | Ghi chú |
|---|---|
| TC-Z02-85 (999 → 1 tin), TC-Z02-86 (đúng 1000 → 1 tin) | Vẫn đúng, không còn là biên; thay bằng 1999 / 2000 / 2001. |
| TC-Z02-42 (lưu mẫu 1000), TC-Z02-43 (lưu mẫu 1001, "KHÔNG báo lỗi") | **Vẫn PASS** ở cả 3.000 (v1.4) lẫn 6.000 (CR) vì 1001 < trần. Nhưng lý do ghi trong TC-43 "BR08: không chặn ở bước lưu" **không còn đúng toàn phần**: G005 v1.4 BR08 có trần 3.000, vượt → **không gõ thêm được** (G005 dòng 473, 519). Cần sửa lý do và thêm biên 5.999/6.000/6.001 (chờ Q-06) cùng biên cũ 2.999/3.000/3.001 (3.001 từng bị chặn, sau CR hợp lệ). |

**Khoảng trống Z-02 so với G005 v1.4 (có từ trước CR, ghi nhận):** không có case cho trần 3.000; không có case "BE từ chối > mốc/lần gọi" (G005 dòng 522; kiểm bằng API, `qa-api-test`); không có case import Excel với nội dung vượt trần (G005 UC-07 không nêu → Q-11).

Không bị ảnh hưởng bởi CR: nhóm A-I, K, L khác của Z-02. Cũng nên rà `wiki/qa/point-reports/2026-09_z-02.md` và dòng Z-02 trong `wiki/QA_COVERAGE_MATRIX.md` (95 case) sau khi sửa.

## 5. B2–B3: Flag và lane (RISK_LANES § Lanes — QA)

| Flag | Bật? | Lý do |
|---|---|---|
| `regression-scope` | **Có** | Đụng luồng gửi tin Chat đã ship (G003 BR03), kéo theo G005/G009/G015 và artifact Z-02 (đã lệch spec v1.1 → v1.4). |
| `flaky-risk` | **Có** | Gửi nhiều phần nối tiếp (G003 BR03c), phụ thuộc thứ tự/async; đếm số tin Zalo thực nhận. |
| `data-integrity` | Không | Không phải tiền/tồn kho/số dư/migration. Mất/lặp/đảo nội dung khi tách là rủi ro chức năng, phủ bằng case nội dung phần. |
| `security-test` | Không | Không đổi auth/permission. |
| `cross-service-e2e` | Không — **theo dõi, có điều kiện nâng** | Đường gửi thật là FE (tách) → BE (validate ≤ mốc/lần gọi, G005 dòng 258) → hub-chat-zalo (G003 dòng 86) → Zalo; hằng số độ dài có thể nằm ở ≥ 3 thành phần cần đồng bộ. Spec hiện hành xác nhận BE có ngưỡng 1.000 riêng (mâu thuẫn thật với CR, Q-10) nhưng chưa có bằng chứng hub có ngưỡng riêng và chưa có contract nhiều bên mới. **Nâng lên bật (→ hard gate → high-risk) nếu** dev xác nhận (Q-05/Q-10) hub hoặc BE là service độc lập giữ hằng số độ dài phải đổi theo. |
| `multi-tenant-isolation` | Không | Không liên quan. |
| `no-ac-source` | Không | Có AC-source (§1) và baseline G003 AC. |

**Lane: `normal` → `normal` (không đổi).** Số flag = 2, hard gate = 0. Test depth: Happy / Edge / Error phủ đủ mọi AC. Contradiction (ghi lại, không nâng lane): CR §1.8 "Không còn chặn Prod" nhưng Q-05 (đường hub) chưa trả lời, và Q-10 (BE từ chối > 1.000/lần gọi, G005 hiện hành) là mâu thuẫn thật — nếu dev không đổi thì gửi phần 1.001-2.000 bị từ chối; đúng loại rủi ro `regression-scope`.

## 6. B5–B6: Test types và skills

- **Test types:** `acceptance`, `system` (chuỗi nhiều phần gửi nối tiếp, retry từng phần), `e2e` (UI Chat → BE → hub → Zalo, đếm tin thực nhận), `regression` (Z-02 nhóm J, luồng gửi thường, G009 BR12, G015, form mẫu).
- Không đề xuất: `exploratory` (không high-risk; chỉ gợi ý session ngắn cho Unicode ở Q-03), `a11y` (ô soạn không đổi UI, CR §1.3 #4), `perf-smoke`. Unit/integration/contract của việc cắt chuỗi thuộc dev.
- **Skills:** `qa-test-design` (BVA 1999/2000/2001, EP theo vị trí xuống dòng), `qa-test-types`, `qa-e2e-playwright`, `qa-api-test` (kiểm BE từ chối vượt mốc/lần gọi — Q-10; gửi thẳng qua hub — Q-05), `qa-test-data` (fixture text dài), `qa-defect`, `qa-exit-criteria`.

## 7. Business rule (12 → 14)

Cột "Căn cứ" cho biết rule đã được spec hiện hành xác nhận hay chỉ từ CR.

| BR | Nội dung | Vị trí | Căn cứ / thay đổi sau rà soát |
|---|---|---|---|
| BR-1 | Mốc tách = 2.000 ký tự; vượt (**>**) mới tách; mỗi phần ≤ mốc | CR §1.3 #1 | Dạng ">"/"≤" xác nhận ở G003 dòng 84, 297, 571. Con số 2.000 chỉ từ CR; **spec hiện hành còn 1.000** |
| BR-2 | Lý do con số là mức hệ thống tự đặt theo test, không phải giới hạn Zalo công bố | CR §1.3 #2 | **CR tự mâu thuẫn** (§1.2/§1.3/§1.7) và G003/G005 hiện hành ghi "giới hạn Zalo" ở dòng 297/258/366/611 → Q-08 |
| BR-3 | Trần nội dung Tin nhắn mẫu = 3 × mốc tách (6.000), tự đổi theo mốc | CR §1.3 #3; G005 BR08 | Spec hiện hành: **3.000 = 3 × 1.000, vượt → không gõ thêm được** (G005 dòng 258, 473, 519). Hành vi tại 6.001 chỉ suy ra → Q-06 |
| BR-4 | Hệ thống vẫn tự tách dù Zalo cũng tách ở 2.000; mỗi tin gửi khớp 1:1 một tin Zalo | CR §1.3 #3b | **Xác nhận** "hệ thống tách" (G003 dòng 84; G005 OQ02 dòng 564). Z-02 sai |
| BR-5 | Ô soạn tin không counter, không cảnh báo, không chặn gõ/gửi | CR §1.3 #4 | G003 BR03 dòng 297 xác nhận "không chặn/không báo lỗi độ dài". **G009 dòng 326/394 còn "Counter 1000" → mâu thuẫn thật** → Q-12 |
| BR-6 | Cắt tại xuống dòng gần nhất trước mốc; không có thì khoảng trắng gần nhất; không vỡ từ; **không có ranh giới nào → cắt cứng tại mốc** | CR §1.4; G003 BR03b | **Bổ sung:** fallback cắt cứng (G003 dòng 298, 570) — CR §1.4 diễn đạt lại bỏ sót mệnh đề này. Xử lý ký tự phân cách chưa quy định → Q-02. QA áp cắt cứng tại mốc mới cho tới khi BA nói khác (Q-14) |
| BR-7 | Các phần gửi nối tiếp đúng thứ tự; mỗi phần là tin độc lập; phần lỗi Retry riêng, không ảnh hưởng phần đã gửi | CR §1.4; G003 BR03c | **Xác nhận** (G003 dòng 299, 572-573) |
| BR-8 | Đếm plaintext; không tính markup; không tính phần quote khi trả lời | CR §1.4; G009 BR12 | **Xác nhận** (G009 dòng 241, 396). Markup = Bold/Italic/Underline/Bullet list/Block quote (G009 BR11 dòng 240); quote reply cắt 100 ký tự (BR05 dòng 233). Ký hiệu danh sách có tính không → Q-03 |
| BR-9 | Bảng số tin theo độ dài (≤1.000→1, 1.500→1, 2.000→1, 3.000→2) | CR §1.5 | Là cận dưới lý thuyết → Q-09 |
| BR-10 | Mốc 2.000 không gộp mọi tin dài về một tin; ràng buộc mốc ≤ trần Zalo | CR §1.2, §1.5 | Không đổi |
| BR-11 | G009 BR12 và G015 kế thừa mốc mới | CR §1.7 | G009 kế thừa G003 (dòng 436) nhưng **còn mốc 1.000**. **G015 không có quy tắc tách** nào, chỉ câu "1.000 ký tự chung" (dòng 48, 266) **mâu thuẫn thật với CR** → Q-13 |
| BR-12 | Đơn vị đếm là "ký tự"; emoji 1 hay 2 đơn vị chưa chốt | CR §1.6 Q2 | **Vẫn mở** — G003/G005/G009 không nêu đơn vị |
| BR-13 | Backend validate **mỗi lần gọi ≤ mốc**; > mốc/lần gọi BE từ chối; việc tách do FE | G005 BR08 (dòng 258), AC dòng 522 | Spec hiện hành mốc 1.000. CR không nói BE phải đổi → **mâu thuẫn thật** Q-10 |
| BR-14 | Mẫu: trong lúc soạn/lưu **không tách, không chia ô**; chỉ tách khi bấm Gửi; vượt trần mẫu → không gõ thêm được | G005 BR08 (dòng 258, 473) | Spec hiện hành trần 3.000; sau CR 6.000 (chỉ từ CR) |

**Số BR: 14** (BR-12 là rule còn mở; BR-13/BR-14 là rule hiện hành mới tìm thấy).

## 8. Dòng G-spec cần sửa NẾU áp CR-004

Căn cứ: CR §1.3, §1.4, §1.7 + quyết định user (spec trong `tailieu/` là bản duy nhất). "Nội dung phải thành" là suy ra từ CR; những chỗ CR không nói rõ ghi **[chờ BA]**. Đây là danh sách để BA trả lời Q-14, không phải QA tự sửa tài liệu.

| # | File | Dòng | Nội dung hiện tại | Nội dung phải thành (nếu áp CR) | Câu liên quan |
|---|---|---|---|---|---|
| 1 | G003 | 84 (UC-02a 3b) | "> 1.000 ký tự → tự động tách … phần ≤ 1.000 … Nếu ≤ 1.000 → giữ nguyên 1 tin" | 2.000 (cả 3 chỗ) | D1 |
| 2 | G003 | 297 (BR03) | "vượt **1.000** → tự tách, mỗi tin ≤ **1.000**"; lý do "1.000 là giới hạn của **Zalo API**, không phải giới hạn nghiệp vụ" | 2.000; lý do = "mức hệ thống tự đặt theo kết quả test, không phải giới hạn do Zalo công bố" (CR §1.3 #2) — **[chờ BA chốt câu chữ, CR tự mâu thuẫn]** | Q-08 |
| 3 | G003 | 298 (BR03b) | "mốc 1.000 ký tự … không có ranh giới nào trong 1.000 ký tự → cắt cứng tại 1.000" | 2.000 (3 chỗ); mệnh đề cắt cứng **[chờ BA xác nhận còn giữ]** | Q-04 |
| 4 | G003 | 566 | "Gõ/dán quá 1.000 ký tự → vẫn gõ được, nút Gửi vẫn bấm được, tin được gửi đi" | "quá 2.000 …" | D1 |
| 5 | G003 | 567 | "gửi nội dung >1.000 ký tự → KHÔNG còn toast lỗi" | ">2.000 …" (văn bản toast cũ "nhỏ hơn 1000" giữ nguyên làm nội dung cần vắng mặt) | D1 |
| 6 | G003 | 568 | "Gửi nội dung 2.500 ký tự → tự tách thành **3 tin**" | "… **2 tin**" (CR §1.5 cho 3.000 → 2; 2.500 suy ra) | D1, Q-09 |
| 7 | G003 | 570 | "Đoạn liền >1.000 ký tự không có khoảng trắng → cắt cứng tại 1.000" | 2.000 (2 chỗ) | Q-04 |
| 8 | G003 | 571 | "Nội dung ≤ 1.000 ký tự → 1 tin duy nhất" | "≤ 2.000" | D1 |
| 9 | G005 | 31, 68, 550 | "auto tách khi vượt 1.000" (mô tả phụ thuộc G003, nhánh sơ đồ "Nội dung > 1.000 ký tự?") | 2.000 | D1 |
| 10 | G005 | 258 (BR08) | "Nội dung mẫu **tối đa 3.000**. Zalo giới hạn **1.000**/lần gửi; mẫu >1.000 → tự tách (mỗi tin ≤1.000); FE tách; **backend validate ≤1.000/lần gọi**"; lý do "Trần 3.000… Zalo giới hạn 1.000/lần" | "tối đa **6.000** (= 3 × mốc tách, tự đổi theo mốc)"; mốc 2.000; "Zalo giới hạn" → "mức hệ thống tự đặt"; BE validate ≤ **2.000** **[chờ BA/dev xác nhận ngưỡng BE]** | D3, D5, Q-10 |
| 11 | G005 | 366 (field Nội dung) | "Tối đa 3.000 ký tự (Zalo giới hạn 1.000/lần gửi; mẫu >1.000 → tự tách, FE tách/BE validate ≤1.000)" | 6.000 / 2.000 / BE ≤ 2.000 | D3, Q-10 |
| 12 | G005 | 473, 519 | "Nội dung mẫu tối đa 3.000: đủ 3.000 vẫn gõ/lưu được; vượt 3.000 → không gõ thêm được" | 6.000 | D3, Q-06 |
| 13 | G005 | 520-523 | "≤ 1.000 → 1 tin"; "> 1.000 → tự tách"; "backend nhận ≤1.000/lần gọi, >1.000 từ chối" | 2.000 (cả 3 dòng) | D1, Q-10 |
| 14 | G005 | 611 (ghi chú cuối) | "tối đa 3.000. Zalo giới hạn 1.000 … mỗi tin ≤1.000 … BE validate ≤1.000" | 6.000 / 2.000 / BE ≤ 2.000; bỏ "Zalo giới hạn" | D3, Q-08 |
| 15 | G009 | 158, 436 | "nội dung >1.000 ký tự được auto tách … Mốc 1.000 đếm theo ký tự plaintext"; dependency "auto tách khi vượt 1.000" | 2.000 | D4 |
| 16 | G009 | 241 (BR12) | "Không chặn khi vượt 1.000 … Mốc **1.000 ký tự** để tách đếm theo plaintext, không tính markup, không tính quote" | mốc 2.000 (cách đếm giữ nguyên, CR §1.4) | D4 |
| 17 | G009 | 326 (UI) | "Giới hạn ký tự \| **Counter 1000 ký tự**, đếm plaintext" | bỏ counter / ghi "không có counter, không cảnh báo" (CR §1.3 #4) **[chờ BA]** | D6, Q-12 |
| 18 | G009 | 378, 395, 396 | "Gõ 1000 ký tự nội dung reply …"; "Nhập quá 1000 ký tự → … tự tách"; "quote không tính vào mốc 1.000" | 2.000 | D4 |
| 19 | G009 | 394 (AC) | "**Counter** đếm đúng ký tự plaintext, không đếm markup; vượt 1000 ký tự không chặn gõ" | bỏ ý "Counter" (CR §1.3 #4) **[chờ BA]** | D6, Q-12 |
| 20 | G015 | 48 (tiền điều kiện) | "Nội dung vẫn trong giới hạn **1.000 ký tự** chung (G003 BR03)" | bỏ ràng buộc "giới hạn chung" (G003 không còn chặn từ v1.7); thay bằng quy tắc thumbnail khi tin bị tách theo mốc 2.000 **[chờ BA, Q-13]** | D4, Q-13 |
| 21 | G015 | 266 (dependency) | "giới hạn 1.000 ký tự (BR03)" | "mốc tách 2.000 ký tự (BR03)" | D4, Q-13 |

Không cần sửa theo CR (giữ nguyên): G003 BR03c (dòng 299), G005 OQ02 (dòng 564), G009 BR05/BR11 (dòng 233, 240), G015 BR04/BR17 (dòng 146, 160) — nhưng BR04 cần bổ sung cho tin bị tách (Q-13).

## 9. Trạng thái 8 câu hỏi cũ (đối chiếu spec hiện hành)

Giữ nguyên mã Q-01…Q-08. Cập nhật 2026-10-07 theo quyết định user: chỉ Q-08 và các câu dựa vào "bản mới chưa có" (Q-04, Q-06) đổi mô tả.

| Câu | Tiêu đề | Trạng thái | Căn cứ ngắn |
|---|---|---|---|
| Q-01 | 2.069 ký tự vs trần Zalo 2.000 | **Vẫn mở** | Spec không có dữ liệu Zalo Web/phone; G003 chỉ nói 1.000 là "Zalo API" (dòng 297) |
| Q-02 | 932+999+135 = 2.066 ≠ 2.069 | **Trả lời một phần** | G003 cho quy tắc chọn điểm cắt và ≤ mốc; **không** quy định ký tự phân cách/trim → lệch 3 chưa giải thích (§3.1) |
| Q-03 | Đơn vị đếm (emoji, dấu, CRLF) | **Vẫn mở** | Chỉ có "ký tự", "plaintext"; không có Unicode/CRLF |
| Q-04 | Biên 1.999/2.000/2.001, không có chỗ cắt | **Trả lời một phần** | Có: ">"/"≤", cắt cứng tại mốc (G003 dòng 298, 570, 571). Chưa có: newline đúng ở mốc, phần quá ngắn, cắt giữa link; và BA chưa nói BR03b mới có giữ mệnh đề cắt cứng không (Q-14) |
| Q-05 | Trần 2.000 qua hub/API | **Vẫn mở** | Không có dữ liệu hub |
| Q-06 | Trần mẫu 6.000, xung đột Z-02 BR08 | **Trả lời một phần** | Có: spec hiện hành trần 3.000 = 3×1.000, vượt → không gõ thêm được (G005 dòng 258, 473, 519). Chưa có: hành vi tại 6.001 sau CR (G005 chưa sửa theo CR), dán, đơn vị đếm khi có rich text |
| Q-07 | Tin cũ / đang gửi dở lúc triển khai | **Vẫn mở** | Spec không nêu migration/tương thích; chỉ có thứ tự deploy (G005 dòng 587) |
| Q-08 | Thiếu tài liệu; câu chữ lý do mốc | **Trả lời một phần** — phần "thiếu tài liệu" **ĐÓNG**; còn 2 phần: (b) CR tự mâu thuẫn về lý do mốc; (c) spec chưa cập nhật theo CR → chuyển thành **Q-14** | 4 file trong `tailieu/` là bản duy nhất (quyết định user); markup/quote của G009 BR12 đã rõ (BR11, BR05) |

Không câu nào "đã trả lời trọn vẹn"; không câu nào "câu hỏi sai". Thống kê: đã trả lời 0 · một phần 4 (Q-02, Q-04, Q-06, Q-08) · vẫn mở 4 (Q-01, Q-03, Q-05, Q-07) · sai 0.

### Q-01 — Ví dụ 2.069 ký tự mâu thuẫn với trần Zalo 2.000 [Cao, BA] — VẪN MỞ
- **Trích:** "bài giới thiệu khóa học dài **2.069 ký tự**. Trên **Zalo Web** bài này gửi **một tin liền mạch**" (CR §1.1, dòng 18) vs "**Mốc tách = 2.000 ký tự** — đây là **trần của Zalo** … Gửi quá 2.000 thì Zalo tự cắt" (CR §1.2, dòng 26-28).
- **Vấn đề:** 2.069 > 2.000 nhưng Zalo Web vẫn nhận một tin. Có thể trần Zalo Web ≠ trần app điện thoại (log đo từ điện thoại, §1.6 Q1) hoặc Zalo đếm theo đơn vị khác.
- **Kiểm baseline:** Phần "Gopany đang chạy đúng tài liệu" ĐÚNG: 2.069 > 1.000, tách 3 phần, mỗi phần ≤ 1.000 (G003 BR03). Spec không trả lời phần trần Zalo.
- **Vì sao chưa viết được kỳ vọng:** không biết trần thật từng kênh; sau CR bài 2.069 ra 2 tin nhưng CR không có dòng này.
- **Đề xuất:** BA xác nhận kênh được đo; thêm bài 2.069 vào bảng §1.5 với số tin và độ dài từng phần.

### Q-02 — Số học ví dụ: 932 + 999 + 135 = 2.066, không phải 2.069 [Cao, BA] — TRẢ LỜI MỘT PHẦN
- **Trích:** "ra **932 / 999 / 135 ký tự** — khớp 3 tin nhân sự thấy" (CR dòng 20) cạnh "dài **2.069 ký tự**" (dòng 18).
- **Đã rõ từ G003:** cắt ở xuống dòng gần nhất trước mốc, mỗi phần ≤ mốc (dòng 297-298). **Chưa rõ:** ký tự phân cách giữ/bỏ/trim. Kết luận chi tiết ở §3.1: quy tắc G003 không giải thích được 3 ký tự; "bỏ 1 xuống dòng/điểm cắt" chỉ giải thích 2; phần còn lại chưa có căn cứ.
- **Vì sao chưa viết được kỳ vọng:** không viết được "ghép các tin = nội dung gốc" (cũng là kỳ vọng của Z-02 TC-87/88).
- **Đề xuất:** BA/dev cung cấp văn bản gốc 2.069 ký tự và nêu quy tắc ký tự phân cách (bỏ 1 / bỏ cả dòng trống / trim đầu phần); sau đó AC viết "ghép lại = gốc trừ các ký tự phân cách tại điểm cắt".

### Q-03 — Đơn vị đếm ký tự (emoji, tiếng Việt có dấu, xuống dòng) [Cao, Dev + BA] — VẪN MỞ
- **Trích:** "Log hub đếm theo **ký tự** … **emoji** tính là 1 hay 2 đơn vị tuỳ cách đếm của mã nguồn — tin nhiều emoji có thể bị tách sớm hơn dự tính. Không chặn gì" (CR §1.6 Q2, dòng 67).
- **Kiểm spec:** G003/G005/G009 chỉ nói "ký tự" và "plaintext" (G009 dòng 241); không có từ khoá code point/UTF/surrogate/CRLF. Thêm: ký hiệu danh sách (Bullet list / danh sách có thứ tự, G009 BR11, G005 dòng 366) có tính vào "plaintext" không?
- **Vấn đề:** (a) CR vừa nói "ký tự" đúng vừa nói emoji có thể 2 đơn vị; (b) NFC dựng sẵn 1 ký tự vs NFD tổ hợp 2; (c) CRLF 1 hay 2; (d) đơn vị Zalo đếm có trùng Gopany không, nếu lệch Zalo tách thêm, phá 1:1 (BR-4).
- **Vì sao chưa viết được kỳ vọng:** không dựng được fixture biên 2.000 với emoji/dấu/CRLF/danh sách. Z-02 OQ-16 hỏi cùng điều này, chưa có trả lời.
- **Đề xuất:** chốt code point hay UTF-16 code unit theo đơn vị Zalo; không cắt giữa cặp surrogate/emoji; nêu cách tính ký hiệu danh sách.

### Q-04 — Hành vi đúng tại 1.999 / 2.000 / 2.001 và khi không có chỗ cắt [Cao, BA] — TRẢ LỜI MỘT PHẦN
- **Đã rõ (từ spec hiện hành, CR nói "không đổi"):** "vượt" là **>**: ≤ mốc → 1 tin duy nhất (dòng 84, 571); 1.999 và 2.000 → 1 tin (CR §1.5 dòng 55 cũng ghi 2.000 → 1); 2.001 → tách (≥ 2 tin). Không có ranh giới nào trong mốc → **cắt cứng tại mốc**, "không treo" (G003 dòng 298, 570). CR §1.4 diễn đạt lại bỏ sót mệnh đề cắt cứng; QA áp mệnh đề này theo G003 hiện hành, BA xác nhận ở Q-14.
- **Còn mở:** (i) 2.001 ký tự: phần 1 dài bao nhiêu khi xuống dòng nằm đúng vị trí 2.000 hoặc 2.001 (có "trước mốc" không); (ii) xuống dòng gần nhất rất sớm (vd vị trí 10) → phần 1 chỉ 10 ký tự, có chấp nhận; (iii) cắt cứng có thể cắt giữa link/SĐT dù lý do BR03b là "tránh cắt giữa từ, số điện thoại hoặc link" (dòng 298).
- **Vì sao chưa viết được kỳ vọng:** biên số tin viết được cho fixture ASCII; phân bố độ dài từng phần và biên có xuống dòng thì chưa.
- **Đề xuất:** BA bổ sung bảng biên 1.999/2.000/2.001 với fixture cụ thể; quy định độ dài tối thiểu của phần (nếu có).

### Q-05 — Trần 2.000 qua hub/API chưa xác nhận [Cao, Dev] — VẪN MỞ
- **Trích:** "Trần 2.000 có áp giống nhau cho tin gửi QUA HUB không? Log hiện có đo tin gửi **từ điện thoại**; đường **qua hub/API** có thể khác … Nếu vẫn tách, báo lại BA con số thật" (CR §1.6 Q1, dòng 66) và "Chặn Prod: **Không còn chặn** … Câu 1 chỉ là xác nhận thêm" (§1.8, dòng 85).
- **Kiểm spec:** đường gửi là "qua hub-chat-zalo → Zalo" (G003 dòng 86), tức hub chính là đường thật của sản phẩm; không có dữ liệu giới hạn của hub. Thêm tầng BE validate (G005 dòng 258) → Q-10.
- **Vì sao chưa viết được kỳ vọng:** nếu hub tách sớm hơn, mọi kỳ vọng "2.000 → 1 tin" sai; "không còn chặn Prod" mâu thuẫn với điều kiện nền chưa xác nhận.
- **Đề xuất:** smoke đầu tiên khi có build: gửi 2.000 ký tự qua hub, đếm tin Zalo thực nhận; hỏi dev kết quả đã có chưa.

### Q-06 — Trần mẫu 6.000: xử lý khi vượt và xung đột với Z-02 BR08 [Trung bình, BA] — TRẢ LỜI MỘT PHẦN
- **Đã rõ (G005 hiện hành, v1.4):** "Nội dung mẫu **tối đa 3.000 ký tự**" (dòng 258); "đủ 3.000 vẫn gõ/lưu được; **vượt 3.000 → không gõ thêm được**" (dòng 473); "vượt → chặn" (dòng 519); trong lúc soạn/lưu mẫu KHÔNG tách (dòng 258). 3.000 = 3 × 1.000 nên "luật 3 × mốc" của CR khớp baseline. → xung đột với Z-02 TC-43 ("không chặn ở bước lưu") xác nhận: Z-02 chỉ đúng khi nội dung ≤ trần.
- **Còn mở:** hành vi tại 6.001 sau CR (G005 chưa sửa theo CR; chỉ suy "không gõ thêm được" từ spec hiện hành); dán một lần > trần (cắt hay chặn); trần đếm theo đơn vị nào và có tính markup rich text (G005 v1.3) không; import Excel > trần (→ Q-11).
- **Đề xuất:** BA cập nhật G005 BR08 (§8 dòng 10-14) và nêu hành vi tại 6.001; QA thêm biên 5.999/6.000/6.001 sau đó.

### Q-07 — Tác động tới tin đã lưu / đã gửi / đang gửi dở lúc triển khai [Trung bình, BA + Dev] — VẪN MỞ
- **Kiểm spec:** không có quy tắc migration/tương thích. Chỉ có "Deploy order: cần G003 v1.7 deploy trước hoặc cùng lúc" (G005 dòng 587) — cho thấy G005/G003/BE phải triển khai đồng bộ, củng cố Q-10.
- **Vấn đề:** (a) tin đã gửi trước deploy đã tách theo mốc 1.000 — gộp lại hiển thị không (kỳ vọng thường là không); (b) chuỗi nhiều phần đang gửi dở: Retry dùng phần đã cắt cũ hay cắt lại theo mốc mới; (c) mẫu đã lưu: trần cũ 3.000 nên không có mẫu cũ 3.001–6.000, chỉ mẫu ≤ 3.000.
- **Đề xuất:** xác nhận "không migrate tin cũ; Retry giữ nguyên phần đã cắt" nếu đúng.

### Q-08 — Tài liệu gốc và câu chữ lý do mốc [Trung bình, BA] — TRẢ LỜI MỘT PHẦN (phần "thiếu tài liệu" đã ĐÓNG)
- **Đã đóng (quyết định user 2026-10-07):** G003/G005/G009/G015 trong `tailieu/` là bản duy nhất và là spec hiện hành; không có file bản khác để chờ. G009 BR12: markup = 5 định dạng (BR11), quote = quote reply cắt 100 ký tự (BR05).
- **Còn mở (b) — CR tự mâu thuẫn về lý do mốc:** "đây là **trần của Zalo**, không phải con số hệ thống tự đặt" (§1.2, dòng 26) vs "ghi rõ là **mức hệ thống tự đặt theo kết quả test**, **không phải** giới hạn do Zalo công bố" (§1.3 #2, dòng 37) vs "BR03 … lý do con số *(trần Zalo, có bằng chứng)*" (§1.7, dòng 75). Spec hiện hành ghi "giới hạn Zalo" ở G003 dòng 297, G005 dòng 258/366/611 (§8 dòng 2, 10, 11, 14) → các chỗ này phải sửa theo **một** câu chữ chốt.
- **Còn mở (c) — spec chưa cập nhật theo CR:** đã tách thành **Q-14**.
- **Đề xuất:** BA chốt 1 câu chữ lý do duy nhất.

## 10. Câu hỏi MỚI (phát hiện khi đối chiếu G003/G005/G009/G015)

### Q-09 — Bảng §1.5 là cận dưới lý thuyết, không khớp quy tắc cắt BR03b [Cao, BA]
- **Trích:** CR §1.5 "2.000 ký tự | 2 tin (cũ) | 1 tin"; "3.000 ký tự | 3 tin (cũ) | 2 tin" (dòng 55-56). G003 BR03b: cắt tại xuống dòng gần nhất **trước** mốc (dòng 298); G003 AC: "2.500 ký tự → 3 tin" (dòng 568).
- **Vấn đề:** mỗi phần ≤ mốc và điểm cắt thường **trước** mốc → phần đầu ngắn hơn mốc. Ví dụ ở mốc cũ 1.000, văn bản 2.000 ký tự có xuống dòng ở vị trí 932 sẽ cho phần 1 = 932, còn lại > 1.000 → **3 tin**, không phải 2. Bảng chỉ đúng khi mỗi phần dài đúng mốc (cắt cứng/điểm cắt trùng mốc). Sau CR: 3.000 → 2 tin chỉ khi phần 1 ≥ 1.000 ký tự.
- **Vì sao chưa viết được kỳ vọng:** không biết bảng là số tin chắc chắn hay tối thiểu; tester sẽ kỳ vọng sai với fixture có xuống dòng.
- **Đề xuất:** BA ghi bảng với fixture cụ thể (vd chuỗi ASCII có khoảng trắng đều, không xuống dòng sớm) hoặc đổi thành "tối thiểu"; QA dựng fixture để số tin xác định.

### Q-10 — Backend từ chối > 1.000 ký tự/lần gọi (G005 hiện hành) mâu thuẫn THẬT với CR [Cao, Dev + BA] — MÂU THUẪN THẬT
- **Trích spec hiện hành:** G005 BR08: "**FE tách khi vượt 1.000**, … **backend validate mỗi lần gọi ≤1.000 ký tự**" (dòng 258); AC: "backend nhận ≤1.000 ký tự/lần gọi (FE đã tách) — >1.000/lần backend từ chối" (dòng 522).
- **Trích CR:** §1.3 #3b: "**Hệ thống** vẫn tự tách" (dòng 39), không phân FE/BE; §1.8 "chờ dev làm", không liệt kê hạng mục BE; không CR nào nêu ngưỡng BE.
- **Mâu thuẫn:** nếu áp CR đúng chữ (mốc 2.000) mà spec G005 BE vẫn "≤1.000 từ chối", thì mọi phần 1.001-2.000 bị BE **từ chối** → mục tiêu CR không đạt. Đây là mâu thuẫn giữa **hai văn bản đang hiệu lực**, không phải suy đoán về bản mới. Không rõ BE validate chỉ áp cho gửi mẫu (G005) hay cho mọi gửi text (G003 không nhắc BE validate), và không rõ thông báo lỗi khi BE từ chối (toast E06 của G003 đã bãi bỏ).
- **Vì sao chưa viết được kỳ vọng:** không có kết quả cho "gửi trực tiếp API 1.500 ký tự" và "từ FE gửi phần 2.000 ký tự".
- **Đề xuất:** BA/dev xác nhận ngưỡng BE = mốc mới (một hằng số dùng chung FE/BE?), phạm vi áp dụng, mã/thông báo lỗi khi vượt; sửa G005 dòng 258, 366, 522, 611 (§8 dòng 10, 11, 13, 14). Nếu hằng số nằm ở nhiều service → xem lại flag `cross-service-e2e`.

### Q-11 — Import Excel: nội dung mẫu vượt trần [Trung bình, BA]
- **Trích:** G005 UC-07 và E05-E08 (dòng 162-168, 216-219), BR06, BR13: chỉ nêu lỗi định dạng file, file rỗng, mã trùng, thiếu trường bắt buộc; **không** nêu độ dài nội dung. Trần 3.000/6.000 nêu ở BR08/AC nhưng chỉ ở "gõ" (dòng 473).
- **Vấn đề:** dòng import có Nội dung > trần: bị từ chối (đếm vào "dòng lỗi" AF02), cắt, hay vẫn tạo? Z-02 có case import 1000 dòng (TC-79) nhưng không có độ dài nội dung.
- **Vì sao chưa viết được kỳ vọng:** không biết dòng 6.001 ký tự khi import ra toast/kết quả gì.
- **Đề xuất:** BA bổ sung vào G005 (E-code hoặc AF) hoặc xác nhận "không kiểm tra độ dài khi import".

### Q-12 — "Counter 1000" trong G009 hiện hành mâu thuẫn THẬT với CR "không counter" [Trung bình, BA] — MÂU THUẪN THẬT
- **Trích spec hiện hành:** G009 UI: "**Giới hạn ký tự** | Counter 1000 ký tự, đếm plaintext" (dòng 326); AC: "**Counter** đếm đúng ký tự plaintext, không đếm markup; vượt 1000 ký tự không chặn gõ" (dòng 394).
- **Trích CR:** §1.3 #4: "**Không báo gì** — không counter, không cảnh báo 'sắp bị tách'" (dòng 40); §1.4: ô soạn "không giới hạn độ dài, không chặn gõ, không chặn gửi" (dòng 46). G003 BR03 chỉ nói "không báo lỗi độ dài" (dòng 297), không nói về counter.
- **Mâu thuẫn:** cùng thao tác gõ ở ô soạn có định dạng, G009 AC yêu cầu counter hiển thị đúng; CR yêu cầu không có counter. Nếu counter giữ thì hiển thị "x/1000" hay "x/2000" cũng chưa rõ. CR §1.3 #4 ghi "giữ nguyên hành vi hiện tại" trong khi G009 hiện hành mô tả có counter → CR có thể dựa trên G003 (không counter) mà bỏ sót G009.
- **Vì sao chưa viết được kỳ vọng:** AC-BR12 (G009) và CR §1.3 #4 cho hai kết quả đối nghịch.
- **Đề xuất:** BA chốt có/không counter (QA tạm theo CR nhưng không đóng bug nếu build có counter đến khi BA trả lời); sửa G009 dòng 326, 394 (§8 dòng 17, 19).

### Q-13 — G015 hiện hành "1.000 ký tự chung" mâu thuẫn THẬT với CR, và không có quy tắc thumbnail cho tin bị tách [Trung bình, BA] — MÂU THUẪN THẬT
- **Trích spec hiện hành:** G015 tiền điều kiện "Nội dung vẫn trong giới hạn **1.000 ký tự** chung (G003 BR03)" (dòng 48); dependency "giới hạn 1.000 ký tự (BR03)" (dòng 266); BR04: "Nhiều link trong 1 tin → chỉ preview link **đầu tiên**" (dòng 146); BR17: card chỉ render trong bong bóng chat (dòng 160).
- **Trích CR:** §1.7: G015 "**Kế thừa mốc mới**" (dòng 78). G003 BR03c: mỗi phần là "**một tin nhắn độc lập**" (dòng 299).
- **Mâu thuẫn / thiếu:** (a) dòng 48 nói nội dung bị giới hạn 1.000 chung — đã mâu thuẫn với G003 v1.11 (bỏ chặn, auto tách) và nay thêm mâu thuẫn với mốc 2.000 của CR; (b) G015 không có quy tắc nào về tin bị tách: link nằm ở phần nào thì phần đó có card? mỗi phần có link đều có card (mỗi phần là tin độc lập → "link đầu tiên của từng tin")? link sát điểm cắt hoặc bị cắt cứng thì sao? CR "kế thừa mốc mới" không bù được phần này.
- **Vì sao chưa viết được kỳ vọng:** không viết được AC cho "link ở phần 2".
- **Đề xuất:** BA bổ sung vào G015 và sửa dòng 48, 266 (§8 dòng 20, 21).

### Q-14 — Các G-spec có được sửa theo CR-004 không, sửa những dòng nào? [Cao, BA]
- **Trích:** CR §1.7: "G003 — Chat **1.23** … BR03 mốc tách = **2.000** …"; "G005 **1.7** … BR08 → luật 3 × mốc = 6.000"; "G009 **1.15** … BR12 kế thừa mốc mới"; "G015 **1.4** … Kế thừa mốc mới" (dòng 75-78); CR §1.8: "**Đã sửa tài liệu** · chờ dev làm" (dòng 84). Spec trong `tailieu/` (bản duy nhất): G003 v1.11, G005 v1.4, G009 v1.12, G015 v1.1 — **vẫn mốc 1.000 / trần 3.000 / "Counter 1000" / "1.000 ký tự chung"** (§1, §8).
- **Vấn đề:** CR báo "đã sửa tài liệu" nhưng 4 file không phản ánh. Chưa rõ: BA đã/sẽ sửa các dòng ở §8 chưa; nếu chưa thì CR đang ở trạng thái "tài liệu chưa sửa" và dev đang nhận hai nguồn lệch nhau.
- **Vì sao chưa viết được kỳ vọng:** với mọi hạng mục ở §8 mà CR im lặng (BE validate, counter, thumbnail khi tách, hành vi 6.001, cắt cứng), QA không biết lấy bản nào làm đúng.
- **Quy ước tạm:** QA test theo **spec hiện hành + delta CR-004**; chỗ hai nguồn nói khác nhau ghi là mâu thuẫn thật và không đóng case cho tới khi BA trả lời.
- **Đề xuất:** BA xác nhận (1) các spec sẽ được sửa theo CR, (2) danh sách dòng ở §8 có đúng/đủ không, (3) lịch cập nhật so với lịch dev.

## 11. Điều kiện dữ liệu và môi trường

- Build/dev: chưa xong ("chờ dev làm", CR §1.8) → thực thi bị gate; thiết kế case được sau khi trả lời Q-02/Q-03/Q-04/Q-09/Q-14.
- Tài khoản Zalo test + hub trên api-dev; xem số tin thực nhận trên Zalo (app/Web) để đối chiếu 1:1 (BR-4). Cần khả năng gọi API/hub trực tiếp (Q-05, Q-10) → `qa-api-test`.
- Fixture văn bản (QA dựng, cần xác nhận Q-02/Q-03/Q-09): đúng 1.999/2.000/2.001 ký tự (ASCII, có khoảng trắng đều, không xuống dòng — để số tin xác định); 3.000 ký tự có xuống dòng; 2.500/4.000/4.001; bài mẫu 2.069 (xin văn bản gốc từ BA — cần để giải thích lệch 3 ký tự); chuỗi 2.500 ký tự không khoảng trắng (cắt cứng); xuống dòng sớm (vị trí 10); xuống dòng đúng vị trí 2.000/2.001; text có emoji, NFC/NFD, CRLF; dòng trống tại điểm cắt; link/SĐT sát điểm cắt. Mỗi fixture đánh dấu vị trí xuống dòng.
- Mẫu tin nhắn (G005): mẫu 2.999/3.000/3.001 (kiểm 3.001 không còn bị chặn sau CR) và 5.999/6.000/6.001 (chờ Q-06); mẫu có rich text và danh sách; file import có dòng vượt trần (Q-11).
- Quote reply + định dạng markup (G009 BR12): reply có quote + 2.001 ký tự; text có Bold/Bullet quanh điểm cắt; ô soạn có định dạng kiểm có/không counter (Q-12).
- Đối chiếu hồi quy: sửa Z-02 nhóm J (§4) và đồng bộ Z-02 với G005 v1.4.

## 12. Kết quả intake (output block)

```yaml
status: ok
featureId: "CR-004"
lane: normal            # không đổi so với lần 1
flags: [regression-scope, flaky-risk]
hardGatesTriggered: []
watch: [cross-service-e2e]   # nâng nếu dev xác nhận hub/BE có hằng số độ dài riêng (Q-05, Q-10)
testDepth: "Happy/Edge/Error đủ AC"
recommendedTestTypes: [acceptance, system, e2e, regression]
suggestedSkills: [qa-test-design, qa-test-types, qa-e2e-playwright, qa-api-test, qa-test-data, qa-defect, qa-exit-criteria]
reason: "CR đổi mốc tách tin dài của luồng Chat đã ship (regression-scope) và có gửi nhiều phần nối tiếp/async (flaky-risk): 2 flag, không hard gate -> normal. Spec hiện hành (tailieu/, bản duy nhất) CHƯA cập nhật theo CR -> có mâu thuẫn thật Q-10/Q-12/Q-13; lệch 3 ký tự CHƯA giải thích được."
nextAction:
  - "ok -> parent gọi qa-test-planner (Phase 2) theo quy ước 'spec hiện hành + delta CR-004'; KHÔNG viết kỳ vọng 'ghép lại = nội dung gốc', biên có emoji/CRLF, biên 6000/6001, BE-validate, counter, thumbnail khi tách trước khi BA/dev trả lời Q-02/Q-03/Q-06/Q-10/Q-12/Q-13/Q-14"
  - "Viết được ngay: biên số tin 1999/2000/2001 với fixture ASCII không xuống dòng (kỳ vọng 1/1/>=2), 2.500 -> 2 tin, Retry riêng từng phần (BR-7), ô soạn không chặn (BR-5)"
  - "Cập nhật Z-02: TC-87, TC-88, TC-89, AC-30, AC-31, BR08, sửa actor 'Zalo tự tách' -> 'hệ thống tách'; đồng bộ spec v1.1 -> G005 v1.4 (xem §4)"
  - "Chạy smoke hub 2.000 ký tự + gọi API 1.500 ký tự (Q-05, Q-10) ngay khi có build"
```

## Lịch sử cập nhật

| Ngày | Người | Thay đổi |
|---|---|---|
| 2026-10-07 | QA (qa-intake-classifier) | Tạo intake lần đầu: delta, case Z-02 bị ảnh hưởng, flag/lane, 12 BR, 8 câu hỏi. |
| 2026-10-07 | QA (qa-intake-classifier) | Rà soát lại sau khi có G003 v1.11, G005 v1.4, G009 v1.12, G015 v1.1 trong `tailieu/`. 8 câu cũ: 0 đã trả lời · 4 một phần (Q-02, Q-04, Q-06, Q-08) · 4 vẫn mở (Q-01, Q-03, Q-05, Q-07) · 0 sai. Câu mới: 5 (Q-09…Q-13). Thêm baseline G003 (§3), kết luận lệch 3 ký tự chưa giải thích được, BR 12 → 14, Z-02 = G005 cũ (spec v1.1) lệch v1.4. Lane normal không đổi. |
| 2026-10-07 | QA (qa-intake-classifier) | **Theo quyết định của user:** file trong `tailieu/` là bản duy nhất; version CR dẫn (G003 1.23, G005 1.7, G009 1.15, G015 1.4) chỉ là các lần sửa trực tiếp trên docs, không có file bản khác để chờ. Bỏ nhận định "4 G-spec là bản trước CR / bản 1.23-1.7-1.15-1.4 chưa xác nhận". Ghi hiện trạng: spec hiện hành chưa cập nhật theo CR. Q-08: đóng phần "thiếu tài liệu"; giữ phần CR tự mâu thuẫn về lý do mốc; phần "spec chưa cập nhật" chuyển thành Q-14 mới. Q-10/Q-12/Q-13 nâng thành mâu thuẫn THẬT (CR vs spec hiện hành). Thêm §8 bảng 21 dòng G-spec cần sửa nếu áp CR. Câu: 8 cũ giữ mã; mới Q-09…Q-14 (6); không câu nào đã trả lời trọn vẹn. Z-02 giữ nguyên kết luận. |
