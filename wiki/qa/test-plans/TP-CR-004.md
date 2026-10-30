---
id: TP-CR-004
feature: CR-004 (chưa có FEAT spine — nguồn = tailieu/CR-004 + spec hiện hành G003/G005/G009/G015)
createdBy: QA
createdAt: 2026-10-07
status: Draft          # Draft | Ready | Executing | Signed-off
---

# TP-CR-004: Test Plan — Nâng mốc tách tin nhắn dài (1.000 → 2.000 ký tự)

> **Nguồn AC/US:** project CHƯA có `wiki/features/FEAT-*.md` (cùng tình trạng HB-003 trong `wiki/HARNESS_BACKLOG.md`).
> AC-source = (a) delta: `tailieu/CR-004 - Nâng mốc tách tin nhắn dài.md` §1.3 (4 điểm chốt), §1.4 (không đổi), §1.5 (bảng kỳ vọng);
> (b) phần không đổi: spec hiện hành `tailieu/G003 - Chat.md` (v1.11), `G005 - Tin nhắn mẫu.md` (v1.4),
> `G009 - Tính năng bổ sung Chat.md` (v1.12), `G015 - Hiển thị Thumbnail khi gửi kèm Link.md` (v1.1).
> Intake: `wiki/qa/intake/INTAKE-CR-004.md` (lane normal · flag `regression-scope`, `flaky-risk` · 14 BR · câu hỏi Q-01…Q-14 · bảng §8 21 dòng spec cần sửa).
>
> **Vì chưa có FEAT:** bỏ bước verify claim `owners.qa` và KHÔNG tick checklist FEAT mục 4.4 (không có FEAT để tick).
> Khi BA/orchestrator tạo FEAT cho CR này, backfill `feature:` ở frontmatter và tick lại.
>
> **Quy ước nguồn (quyết định của user 2026-10-07):** các file trong `tailieu/` là **bản duy nhất**. 4 G-spec **chưa** cập nhật theo CR
> (vẫn mốc 1.000 / trần mẫu 3.000 / "Counter 1000" / "1.000 ký tự chung") dù CR ghi "Đã sửa tài liệu".
> QA test theo **spec hiện hành + delta CR-004**. Chỗ hai nguồn lệch nhau (Q-10, Q-12, Q-13 và các dòng §8 intake) → **KHÔNG đóng case, đánh ❓**
> cho tới khi BA trả lời Q-14. KHÔNG tự chế mã lỗi / thông báo lỗi (anti-hallucination rule 3).
>
> Build: CR §1.8 "Đã sửa tài liệu · chờ dev làm" → **chưa có build**. Test-DESIGN (plan + case) là shift-left; thực thi bị gate (mục 4).

## 1. Scope

- **FEAT / CR:** CR-004 — Nâng mốc tách tin nhắn dài của luồng gửi Chat từ 1.000 lên 2.000 ký tự (vượt `>` 2.000 mới tách), kéo theo trần nội dung Tin nhắn mẫu theo luật 3 × mốc (3.000 → 6.000); G009 BR12 và G015 kế thừa mốc mới.

### 1.1 Delta (cái đổi — trọng tâm kiểm thử)

| # | Delta | Trước (spec hiện hành) | Sau CR | Nguồn |
|---|---|---|---|---|
| D1 | Mốc tách tin dài (G003 BR03) | 1.000 ký tự | **2.000 ký tự**; ≤ 2.000 → 1 tin, > 2.000 → tách, mỗi phần ≤ 2.000 | CR §1.3 #1; G003 dòng 84, 297, 571 |
| D2 | Trần nội dung Tin nhắn mẫu (G005 BR08) | 3.000 (= 3 × 1.000) | **6.000 (= 3 × mốc)**, tự đổi theo mốc | CR §1.3 #3; G005 dòng 258, 473, 519 |
| D3 | G009 BR12 (đếm plaintext để tách) và G015 | mốc 1.000 | kế thừa mốc 2.000 | CR §1.4, §1.7 |
| D4 | Hệ thống vẫn tự tách dù Zalo cũng tách ở 2.000; mỗi tin gửi khớp 1:1 một tin Zalo | — | BR-4 | CR §1.3 #3b; G003/G005 OQ02 |
| D5 | Ô soạn: không counter, không cảnh báo, không chặn | G009 còn "Counter 1000" | theo CR "không counter" | CR §1.3 #4 — **mâu thuẫn thật Q-12 → ❓** |
| D6 | BE validate mỗi lần gọi ≤ mốc | G005 BR08: ≤ 1.000, > → từ chối | CR không nói | **mâu thuẫn thật Q-10 → ❓ (kiểm bằng API)** |

### 1.2 Phần KHÔNG đổi (kiểm hồi quy — kỳ vọng theo G003 hiện hành, chỉ thay con số mốc)

- **Cách cắt (BR03b):** cắt tại dấu xuống dòng gần nhất **trước** mốc; không có thì khoảng trắng gần nhất; không vỡ từ giữa chừng; không có ranh giới nào trong mốc → **cắt cứng tại mốc**. QA áp mệnh đề cắt cứng theo G003 (CR §1.4 diễn đạt lại bỏ sót) và **chờ BA xác nhận ở Q-14**.
- **Cách gửi (BR03c, BR-7):** các phần gửi nối tiếp đúng thứ tự; mỗi phần là tin độc lập (Đang gửi / Đã gửi / Lỗi gửi); phần lỗi có Retry riêng, không ảnh hưởng phần đã gửi.
- **Đếm plaintext (BR-8):** không tính markup (Bold/Italic/Underline/Bullet list/Block quote), không tính phần quote khi trả lời (G009 BR11, BR05, BR12).
- **Tách tại thời điểm nhấn Gửi** (G003 BR03; G005 BR08 "trong lúc soạn/lưu không tách, không chia ô"); ô soạn không giới hạn, không chặn gõ/gửi, không toast lỗi độ dài (toast E06 "nhỏ hơn 1000 ký tự" phải **vắng mặt**).
- Mẫu: chỉ tách khi bấm Gửi, KHÔNG tách ở bước lưu mẫu (miễn nội dung ≤ trần).

### 1.3 In scope (QA black-box)

1. **Test mới cho delta D1–D4:** biên số tin quanh mốc (1.999 / 2.000 / 2.001, 1.000/1.001 là "biên cũ không còn là biên", 1.500, 2.500, 3.000, 4.000/4.001), độ dài mỗi phần ≤ 2.000, thứ tự phần, Retry từng phần, 1:1 với tin Zalo thực nhận; trần mẫu 2.999/3.000/3.001 và 5.999/6.000/6.001; chèn mẫu dài vào ô soạn → gửi.
2. **Hồi quy phần không đổi:** BR03b (điểm cắt), BR03c (nối tiếp/Retry), BR-8 (plaintext, quote, markup), ô soạn không chặn, tin ≤ mốc vẫn 1 tin, G015 (thumbnail khi tin có link — phạm vi hẹp, phần tin bị tách ❓ Q-13).
3. **Sửa lại bộ case Z-02** (`wiki/qa/test-cases/Z-02.md`, cùng tính năng G005, viết theo spec v1.1 → lệch G005 v1.4 từ trước CR):
   - **TC-Z02-85 → 89** (nhóm J): 85/86 không còn là biên → thay bằng 1.999/2.000/2.001; 87 (1001 → "2 tin, Zalo tự tách, ghép = đủ 1001") sai kỳ vọng + sai actor + "ghép = đủ" không có căn cứ; 88 (2500 → 3 tin) → 2 tin; 89 ❓ dựng lại fixture tại mốc 2.000 (OQ-16 = Q-03 còn mở).
   - **TC-Z02-42 / 43** (lưu mẫu 1000 / 1001): vẫn PASS nhưng lý do TC-43 "BR08: không chặn ở bước lưu" không còn đúng toàn phần (G005 v1.4 có trần 3.000) → sửa lý do; thêm biên trần.
   - **AC-30 / AC-31** (ma trận Z-02 dòng 212-213): "≤ 1000" → "≤ 2000"; "Zalo tự tách" → "**hệ thống tách**".
   - **BR08** (Z-02 §0.1 dòng 39, bảng phủ dòng 229, tiêu đề nhóm J dòng 157 "Giới hạn 1000 ký tự **của Zalo**"): sửa nhãn/trace; câu chữ lý do mốc chờ Q-08.
   - **Lỗi "Zalo tự tách" có từ trước CR:** G003 BR03 + UC-02a, G005 OQ02 (2026-07-22), G005 BR08, CR §1.3 #3b đều nói **hệ thống tách** (FE tách khi gửi). Sửa ở mọi chỗ Z-02 ghi "Zalo tự tách" (TC-87, AC-31, tiêu đề nhóm J).
   - Đồng bộ Z-02 với G005 v1.4 ở phần chạm CR: trần mẫu, "FE tách / BE validate". Các khoảng trống khác (case import Excel vượt trần — Q-11; rich text v1.3) chỉ **ghi nhận**, không mở rộng vòng này.
   - Sau khi sửa: rà `wiki/qa/point-reports/2026-09_z-02.md` và dòng Z-02 trong `wiki/QA_COVERAGE_MATRIX.md` (95 case) — việc của agent phase sau, ghi nhận ở đây để không sót.
4. **Kiểm BE bằng API (black-box):** gửi trực tiếp > mốc cũ và > mốc mới qua API/hub để xác nhận ngưỡng BE (Q-10) và đường hub (Q-05). Chỉ thiết kế; case ❓ cho tới khi dev/BA trả lời.

### 1.4 Out of scope

- **Dev sở hữu:** unit / integration / contract (BE/FE tự lo) — vd unit test hàm cắt chuỗi, integration FE→BE→hub, contract request/response gửi tin. Kể cả hằng số mốc dùng chung giữa các thành phần.
- **Chưa làm vòng này:** automation (Phase 4) — manual design-only (user xác nhận). Không có a11y, perf-smoke (ô soạn không đổi UI, CR §1.3 #4).
- **Không phải scope QA / chờ BA:** sửa nội dung G-spec (QA chỉ nêu danh sách §8 intake cho BA); migration tin cũ / đang gửi dở (Q-07); import Excel nội dung vượt trần (Q-11 — chưa có spec, chưa viết case).
- **Out-of-scope-pending-spec:** quy tắc ký tự phân cách/trim (Q-02), đơn vị đếm Unicode (Q-03), thumbnail cho tin bị tách (Q-13), hành vi tại 6.001 (Q-06) — chỉ đặt chỗ case ❓, không viết kỳ vọng.

## 2. Test types áp dụng

| Type | Có? | Ghi chú |
| --- | --- | --- |
| Acceptance (theo AC) | ✅ | Mỗi BR-1…BR-14 ≥ 1 case (qa-test-case-writer); BR bị chặn bởi câu hỏi → case ❓. Viết được ngay: biên số tin ASCII (1.999/2.000/2.001 → 1/1/2), 1.001 → 1 tin, 2.500 → 2 tin, Retry riêng từng phần (BR-7), ô soạn không chặn (BR-5). |
| System / E2E | ✅ | Chuỗi nhiều phần gửi nối tiếp + Retry từng phần (system); UI Chat → BE → hub-chat-zalo → Zalo, **đếm số tin Zalo thực nhận** đối chiếu 1:1 (BR-4). Không `cross-service-e2e` hard gate (watch: nâng nếu Q-05/Q-10 xác nhận hub/BE giữ hằng số riêng). Manual vòng này (Playwright để Phase 4). |
| Regression | ✅ | `regression-scope`: Z-02 nhóm J + TC-42/43 (sửa lại), luồng gửi thường ≤ mốc, G003 BR03b/BR03c, G009 BR12 (quote/markup), G015 thumbnail, form mẫu. Mỗi case sửa giữ trace tới Z-02 gốc. |
| Exploratory | ☐ | testDepth = standard, không high-risk → không tick. Tuỳ chọn: 1 session timebox ngắn cho Unicode (emoji/NFC-NFD/CRLF) **sau khi** Q-03 có trả lời — không tính vào Exit. |
| Accessibility (a11y) | ☐ | Ô soạn không đổi UI (CR §1.3 #4). |
| Perf-smoke | ☐ | Không có yêu cầu hiệu năng trong CR. |

Test depth: Happy / Edge / Error đủ AC. Edge dùng BVA (1.999/2.000/2.001) + EP theo vị trí xuống dòng / loại ranh giới (xuống dòng / khoảng trắng / không có).

## 3. Môi trường + dữ liệu

- **Env:** local / staging / uat (theo `projectConfig.qa.environments`). Env chạy chính = **staging** (hoặc env có hub-chat-zalo + tài khoản Zalo test thật — intake §11 ghi "hub trên api-dev"; **parent/dev xác nhận api-dev ứng với env nào**). Local chỉ để dựng/kiểm fixture; uat smoke trước go-live. Chưa có build 2.000 trên env nào.
- **Tài khoản / kênh:** tài khoản Zalo test + hub; xem **số tin thực nhận trên Zalo (app và Web)** để đối chiếu 1:1; khả năng gọi API/hub trực tiếp (Q-05, Q-10). Chưa có multi-tenant flag; tài khoản + mẫu Z-02 dùng đúng workspace test, không dùng chéo workspace (Z-02 OQ-08 đang mở).
- **Test data — fixture văn bản (QA tự dựng, đánh dấu vị trí xuống dòng / khoảng trắng; ghi rõ độ dài thật bằng công cụ đếm ký tự ASCII để tránh lệch kiểu 2.069):**

  Ký hiệu: ✅ dùng ngay (chỉ assert điều spec hiện hành đã xác nhận) · ⏳ chờ câu hỏi (chưa viết kỳ vọng) · ⚠ dùng được có điều kiện.

  **Nhóm A — ASCII, từ ngắn (≤ 10 ký tự) cách đều bằng 1 khoảng trắng, KHÔNG xuống dòng** (để số tin xác định)

  | ID | Độ dài | Dùng cho | Trạng thái | Được assert |
  | --- | --- | --- | --- | --- |
  | F-A-999, F-A-1000, F-A-1001 | 999 / 1.000 / 1.001 | "biên cũ không còn là biên"; thay TC-85/86/87 | ✅ | cả 3 → **1 tin** (CR §1.5: ≤ 2.000 → 1 tin; 1.001 trước CR là 2 tin) |
  | F-A-1500 | 1.500 | CR §1.5 | ✅ | 1 tin |
  | F-A-1999, F-A-2000 | 1.999 / 2.000 | BVA max | ✅ | **1 tin** (≤ mốc; G003 dòng 84, 571; CR §1.5) |
  | F-A-2001 | 2.001 | BVA max+1 | ✅ | tách → **2 phần** (từ ngắn ⇒ phần 2 chỉ vài ký tự), mỗi phần ≤ 2.000, đúng thứ tự, không vỡ từ. **KHÔNG** assert độ dài chính xác phần 1/2, **KHÔNG** assert "ghép = gốc" (Q-02) |
  | F-A-2500 | 2.500 | thay TC-88 | ✅ | **2 tin** (≤ 4.000; phần 1 ≈ 2.000, phần 2 ≈ 500), thay cho "3 tin" của mốc cũ |
  | F-A-3000 | 3.000 | CR §1.5 | ✅ | **2 tin** (phần 1 ≈ 2.000 ≥ 1.000 nên bảng CR đúng với fixture này) |
  | F-A-4000, F-A-4001 | 4.000 / 4.001 | bội của mốc | ⏳ Q-09 | số tin phụ thuộc điểm cắt tại khoảng trắng (phần 1 < 2.000 → phần còn lại có thể > 2.000 → 3 tin); không assert số tin cho tới khi BA chốt bảng §1.5 là số chắc chắn hay "tối thiểu" |

  **Nhóm B — chuỗi liền KHÔNG khoảng trắng, KHÔNG xuống dòng** (kiểm cắt cứng)

  | ID | Độ dài | Dùng cho | Trạng thái | Được assert |
  | --- | --- | --- | --- | --- |
  | F-B-2000, F-B-2001 | 2.000 / 2.001 | cắt cứng tại mốc | ⚠ | 2.000 → 1 tin; 2.001 → 2 phần, phần 1 = 2.000 theo G003 dòng 298, 570. Điều kiện: BA xác nhận BR03b mới còn mệnh đề cắt cứng (Q-14); QA áp tạm theo G003 |
  | F-B-4000, F-B-4001 | 4.000 / 4.001 | cắt cứng nhiều phần | ⚠ | 4.000 → 2 phần (2.000 + 2.000); 4.001 → 3 phần. Cùng điều kiện Q-14; không treo, không mất phần |
  | F-B-2500 | 2.500 | cắt cứng, thay "chuỗi 2.500 không khoảng trắng" | ⚠ | 2 phần (2.000 + 500). Cùng điều kiện Q-14 |

  **Nhóm C — có xuống dòng ở vị trí xác định**

  | ID | Mô tả | Dùng cho | Trạng thái | Được assert |
  | --- | --- | --- | --- | --- |
  | F-C-1500 | 2.500 ký tự, đúng 1 xuống dòng LF tại vị trí 1.500, không khoảng trắng khác | cắt tại xuống dòng trước mốc | ⚠ | **2 tin**, mỗi phần ≤ 2.000, phần 1 kết thúc tại điểm xuống dòng (≈ 1.500 chứ không phải 2.000), không vỡ từ. **KHÔNG** assert ký tự xuống dòng giữ hay bỏ (Q-02) |
  | F-C-10 | xuống dòng sớm tại vị trí 10, tổng 2.500, không khoảng trắng khác | phần quá ngắn | ⏳ Q-04(ii) | chưa biết có chấp nhận phần 1 = 10 ký tự không |
  | F-C-900-3000 | 3.000 ký tự, xuống dòng duy nhất tại vị trí 900 | minh chứng Q-09 | ⏳ Q-09 | theo G003: phần 1 ≈ 900, phần còn ≈ 2.100 > 2.000 → **3 tin**, **trái** bảng CR "3.000 → 2 tin". Giữ làm fixture khoá câu trả lời Q-09 |
  | F-C-NL2000, F-C-NL2001 | xuống dòng đúng ở vị trí 2.000 / 2.001 | xuống dòng tại mốc | ⏳ Q-04(i), Q-02 | chưa biết "trước mốc" có gồm vị trí 2.000/2.001 không, và phân cách giữ/bỏ |
  | F-C-BLANK | dòng trống (2 LF liên tiếp) tại điểm cắt | phân cách nhiều ký tự | ⏳ Q-02 | — |

  **Nhóm D — Unicode / định dạng**

  | ID | Mô tả | Trạng thái | Chờ |
  | --- | --- | --- | --- |
  | F-D-EMOJI | emoji (cả emoji ghép ZWJ, cặp surrogate) tại / quanh vị trí 2.000 | ⏳ | Q-03 (code point hay UTF-16; không cắt giữa emoji) |
  | F-D-NFC / F-D-NFD | cùng nội dung tiếng Việt có dấu, bản dựng sẵn (NFC) vs tổ hợp (NFD), đủ dài để biên 2.000 phụ thuộc cách đếm | ⏳ | Q-03 |
  | F-D-CRLF | xuống dòng CRLF tại điểm cắt và rải trong văn bản | ⏳ | Q-03 (CRLF = 1 hay 2), Q-02 |
  | F-D-LIST | ký hiệu danh sách (Bullet / có thứ tự) quanh điểm cắt | ⏳ | Q-03 (ký hiệu có tính "plaintext" không) |
  | F-D-LINK | link / SĐT nằm sát hoặc bị cắt cứng tại điểm cắt | ⏳ | Q-04(iii), Q-13 |
  | F-D-QUOTE | reply có quote + 2.001 ký tự plaintext | ⚠ | quote không tính vào mốc là rule rõ (G009 BR12/BR05); chỉ assert "quote không tính", mốc theo D3 |
  | F-D-BOLD | định dạng Bold/Italic/Underline phủ vài từ **không** nằm ở điểm cắt, plaintext 2.001 | ⚠ | markup không tính là rule rõ (BR-8); markup bị cắt giữa chừng ⏳ Q-03 |

  **Nhóm E — bài mẫu 2.069 ký tự (ví dụ CR §1.1)**

  | ID | Mô tả | Trạng thái | Chờ |
  | --- | --- | --- | --- |
  | F-E-2069 | bài giới thiệu khóa học đúng **2.069** ký tự theo công cụ đếm thống nhất | ⏳ **chưa có văn bản gốc** | Xin văn bản gốc từ BA. Khi có: đếm lại bằng ≥ 2 công cụ (code point, UTF-16, có/không CRLF) và ghi vị trí xuống dòng; mới viết kỳ vọng 932 / 999 / 135 hay 2 tin sau CR |

  **Nhóm F — Tin nhắn mẫu (G005 BR08)**

  | ID | Mô tả | Trạng thái | Được assert / chờ |
  | --- | --- | --- | --- |
  | F-M-999 / 1000 / 1001 | mẫu 999 / 1.000 / 1.001 ký tự (thay TC-85…87 nhánh gửi mẫu) | ✅ | gửi → 1 tin; lưu mẫu không lỗi độ dài |
  | F-M-1999 / 2000 / 2001 | mẫu 1.999 / 2.000 / 2.001, từ ngắn cách đều | ✅ | gửi → 1 / 1 / 2 tin; lưu mẫu thành công (< trần) |
  | F-M-2999, F-M-3000 | sát trần cũ | ✅ | lưu được ở cả spec hiện hành (≤ 3.000) lẫn CR (≤ 6.000) |
  | F-M-3001 | trần cũ + 1 | ⏳ **mâu thuẫn Q-14** | spec hiện hành: không gõ thêm được; CR: hợp lệ. KHÔNG đóng case |
  | F-M-5999, F-M-6000 | sát trần mới | ⏳ Q-14 | trần 6.000 chỉ có trong CR (G005 chưa sửa); gửi 6.000 → số tin phụ thuộc Q-09 (cắt cứng = 3 phần, có khoảng trắng = 3-4) |
  | F-M-6001, dán 6.001+ | trần mới + 1; dán một lần > trần | ⏳ Q-06 | chỉ suy "không gõ thêm được" từ spec hiện hành; dán thì chưa rõ |
  | F-M-RICH | mẫu có rich text / danh sách | ⏳ Q-06, Q-03 | trần đếm theo đơn vị nào, có tính markup không |
  | F-M-XLSX | file import có dòng Nội dung vượt trần | ⏳ Q-11 | G005 UC-07 không nêu độ dài; chưa viết case |

- **Tổng hợp nhanh — dùng được ngay** (không phụ thuộc câu hỏi, chỉ cần build): nhóm A (trừ 4.000/4.001), F-M-999…3000, F-D-QUOTE, F-D-BOLD (markup không ở điểm cắt). **Dùng có điều kiện** (kỳ vọng tạm theo G003, chờ Q-14): nhóm B, F-C-1500. **Chờ câu hỏi:** F-A-4000/4001 (Q-09), F-C-10/NL/BLANK (Q-02/Q-04), F-C-900-3000 (Q-09), toàn nhóm D (Q-03/Q-04/Q-13), F-E-2069 (BA gửi văn bản + Q-02), F-M-3001/5999/6000/6001/RICH/XLSX (Q-14/Q-06/Q-11).
- **Nguyên tắc dựng fixture:** mọi fixture ghi sẵn độ dài thật, vị trí xuống dòng/khoảng trắng, công cụ đếm đã dùng. Với fixture "ghép lại" tuyệt đối không assert bằng gốc (xem §5 — lệch 3 ký tự). Mỗi lượt chạy dùng hội thoại / người nhận Zalo test riêng để đếm tin thực nhận không bị lẫn (giảm flaky).
- **Automation (định hướng, KHÔNG làm vòng này):** Playwright (E2E web, `e2eWeb`) cho luồng Chat/ô soạn; REST-assured (`apiBe`) hoặc Karate (`apiAlt`) cho kiểm BE từ chối vượt mốc/lần gọi và gọi hub (Q-05, Q-10). **Vòng này manual design-only** (Phase 4 chưa chạy). `reportEvidence: true` vẫn áp dụng khi thực thi tay: screenshot hội thoại **+ ảnh số tin thực nhận phía Zalo** + độ dài từng phần (đếm bằng công cụ ghi trong fixture).

## 4. Entry / Exit criteria

- **Entry (design):** shift-left — đã có CR-004 + 4 G-spec hiện hành + intake. Không chờ build. Case có câu hỏi CHẶN viết ở dạng ❓ (xem §5), không bịa kỳ vọng.
- **Entry (execution)** — không có `deps.qa` chuẩn (chưa có FEAT / `be.done` / `fe.done`). Entry thực tế thay thế, **tất cả** phải thoả:
  1. **Build có mốc 2.000** đã deploy lên env test (CR §1.8 hiện "chờ dev làm"; hằng số mốc ở FE và BE/hub nếu có đã đổi — dev xác nhận phiên bản/commit).
  2. **Xác nhận BE validate (Q-10)** trước khi chạy **biên 1.001–2.000**: ngưỡng BE sau CR là bao nhiêu (G005 hiện hành "≤ 1.000/lần gọi, > từ chối"). Nếu BE vẫn 1.000 thì mọi phần 1.001–2.000 bị từ chối — chạy biên sẽ ra lỗi do config, không phải do mốc. Chưa xác nhận → KHÔNG chạy các case F-A-1001…F-A-2000 / F-B / F-C trên đường có BE; chỉ chạy case ≤ 1.000.
  3. **Xác nhận hub (Q-05)** trước khi chạy biên 1.001–2.000: **smoke đầu tiên** — gửi đúng 2.000 ký tự qua hub, đếm tin Zalo thực nhận (kỳ vọng 1). Nếu hub/Zalo tách sớm hơn → dừng, báo BA con số thật, mọi kỳ vọng "2.000 → 1 tin" phải xem lại; không chạy tiếp.
  4. Tài khoản Zalo test + người nhận test sẵn sàng; quyền gọi API/hub trực tiếp (Q-05, Q-10).
  5. Fixture nhóm "dùng ngay" đã dựng và kiểm độ dài.
- **Exit (sign-off)** — theo `projectConfig.qa.exitCriteria`:
  - AC coverage = **100%** — mỗi BR-1…BR-14 (và AC-30/AC-31/BR08 của Z-02 sau khi sửa) ≥ 1 test case. BR bị chặn bởi câu hỏi mở được phủ bằng case ❓; **không sign-off khi còn case ❓ ở BR blocking** (xem §5) — phải được BA trả lời, hoặc BA ghi chấp nhận bằng văn bản.
  - Blocking severity pass = **100%**; open critical defects = **0**.
  - **Evidence đầy đủ cho mọi case pass** (`reportEvidence: true`): screenshot hội thoại + số tin thực nhận phía Zalo + độ dài từng phần.
  - Bộ case Z-02 đã sửa (TC-85→89, 42/43, AC-30/31, BR08, nhãn "Zalo tự tách") và đồng bộ trace trong `QA_COVERAGE_MATRIX.md`.

## 5. Rủi ro / lane

- **Lane:** `normal` (từ `INTAKE-CR-004.md`; RISK_LANES § QA: 2 flag, không hard gate).
- **Flags:** `regression-scope`, `flaky-risk`. **Hard gates chạm: không có.** Theo dõi: `cross-service-e2e` — nâng lên bật (→ hard gate → `high-risk`) nếu dev xác nhận (Q-05/Q-10) hub hoặc BE là service độc lập giữ hằng số độ dài phải đổi theo; khi đó cập nhật lại plan (thêm exploratory, E2E bắt buộc, chiến lược mock Zalo).
- **Ảnh hưởng tới test focus:**
  - **`regression-scope`** → luồng gửi tin Chat đã ship: hồi quy rộng G003 BR03/03b/03c, G005 (mẫu), G009 BR12, G015; Z-02 nhóm J phải sửa trước khi chạy hồi quy, nếu không sẽ báo FAIL giả (TC-87/88) hoặc PASS giả (TC-85/86 mất giá trị biên).
  - **`flaky-risk`** → gửi nhiều phần nối tiếp, async, thứ tự có thể đảo theo mạng: assert theo số tin + thứ tự cuối cùng sau khi mọi phần "Đã gửi" (có chờ có timeout), không assert thời điểm tuyệt đối; mỗi lượt một hội thoại riêng; không chạy song song 2 case cùng người nhận; Retry phần lỗi dùng cách tạo lỗi gửi có kiểm soát (không dựa vào "mạng chập chờn tự nhiên").

### 5.1 Phát hiện: 932 + 999 + 135 = 2.066 ≠ 2.069

CR §1.1 nêu bài 2.069 ký tự ra 3 phần "932 / 999 / 135" (khớp 3 tin nhân sự thấy). Cộng lại = **2.066**, **thiếu 3 ký tự**. Đối chiếu với G003 (intake §3.1):

- Mỗi phần ≤ 1.000 ✓ và số phần = 3 ✓ (2 điểm cắt) — khớp quy tắc mốc cũ.
- G003 BR03b chỉ nói cắt tại xuống dòng/khoảng trắng gần nhất trước mốc; **không** nói ký tự phân cách giữ/bỏ, **không** nói trim. "Bỏ đúng 1 ký tự xuống dòng mỗi điểm cắt" chỉ giải thích 2/3 ký tự; ít nhất 1 ký tự còn lại chưa có căn cứ (dòng trống/CRLF tại điểm cắt, trim đầu phần, trim cuối văn bản, hay 2.069 do công cụ khác đếm — chưa chọn được).
- **Hệ quả cho kế hoạch:** kỳ vọng **"ghép các phần lại = nội dung gốc"** (Z-02 TC-87 "ghép 2 tin = đủ 1001 ký tự", TC-88 "không mất nội dung") **chưa có căn cứ**, thậm chí có nguy cơ sai kể cả trước CR (khi cắt tại xuống dòng/khoảng trắng mà phân cách bị bỏ thì ghép luôn ít hơn gốc; chỉ bằng nhau khi cắt cứng). Plan này **cấm** assert "ghép = gốc" ở dạng bằng-nhau tuyệt đối cho tới khi có (i) văn bản gốc 2.069 ký tự và (ii) quy tắc phân cách/trim từ BA/dev. Thay bằng assert yếu có căn cứ: số phần, mỗi phần ≤ mốc, thứ tự phần, không vỡ từ, không lặp/đảo phần, phần đầu/cuối văn bản có mặt.

### 5.2 Câu hỏi CHẶN (không viết/không đóng kỳ vọng cho tới khi trả lời)

| Câu | Nội dung (ngắn) | Chặn nhóm case | Mức |
| --- | --- | --- | --- |
| **Q-02** | Ký tự phân cách giữ/bỏ/trim; lệch 3 ký tự (§5.1) | "ghép lại = gốc" (Z-02 TC-87/88 sửa lại); độ dài chính xác từng phần; F-C-NL2000/2001, F-C-BLANK, F-E-2069 | BLOCKING |
| **Q-03** | Đơn vị đếm: emoji (1 hay 2), NFC/NFD, CRLF, ký hiệu danh sách; không cắt giữa emoji | TC-Z02-89 ❓ (OQ-16), toàn nhóm D, mọi biên 2.000 có Unicode; nếu Zalo đếm khác Gopany thì 1:1 (BR-4) vỡ | BLOCKING |
| **Q-04** | Biên khi xuống dòng đúng mốc; phần quá ngắn (xuống dòng ở vị trí 10); cắt cứng giữa link/SĐT | F-C-10, F-C-NL2000/2001, F-D-LINK; số tin chính xác ngoài fixture nhóm A | BLOCKING (phần còn mở) |
| **Q-09** | Bảng CR §1.5 là cận dưới lý thuyết, không khớp BR03b khi có xuống dòng | mọi case "số tin" có xuống dòng; F-A-4000/4001, F-C-900-3000; AC-31 sau sửa | BLOCKING |
| **Q-10** | BE validate ≤ 1.000/lần gọi (G005 hiện hành) mâu thuẫn CR; phạm vi, mã/thông báo lỗi khi vượt | case API "BE từ chối > mốc/lần gọi"; toàn bộ biên 1.001–2.000 (nếu BE chưa đổi → bị từ chối); Entry #2 | BLOCKING (mâu thuẫn thật) |
| **Q-05** | Trần 2.000 qua hub/API chưa xác nhận (log chỉ đo từ điện thoại) | mọi kỳ vọng "2.000 → 1 tin" trên đường hub; Entry #3; có thể nâng flag `cross-service-e2e` | BLOCKING |
| **Q-14** | 4 G-spec chưa sửa theo CR; có sửa không, những dòng nào (bảng §8 intake); BR03b mới còn mệnh đề cắt cứng không | nhóm B (cắt cứng) và mọi case có hai nguồn lệch (trần 3.001/6.000, counter, BE, thumbnail) | BLOCKING |
| **Q-06** | Hành vi tại 6.001; dán > trần; đơn vị đếm khi có rich text | F-M-5999/6000/6001, dán, F-M-RICH; TC-Z02-42/43 sau sửa (biên trần mới) | BLOCKING (phần còn mở) |
| **Q-11** | Import Excel với Nội dung vượt trần | F-M-XLSX; case import có độ dài | không chặn CR chính; chặn case import |
| **Q-12** | G009 "Counter 1000" vs CR "không counter" | case ô soạn có định dạng: có/không counter; AC-BR12 (G009) | mâu thuẫn thật — QA tạm theo CR, **không đóng bug** nếu build có counter |
| **Q-13** | G015 "1.000 ký tự chung" vs CR; không có quy tắc thumbnail cho tin bị tách (link ở phần 2, link sát điểm cắt) | case G015 trong tin tách; F-D-LINK | mâu thuẫn thật + thiếu spec |

Không chặn thực thi nhưng cần ghi vào báo cáo: **Q-01** (2.069 vs trần Zalo 2.000: kênh nào được đo), **Q-07** (tin cũ / đang gửi dở lúc deploy; Retry giữ phần đã cắt cũ hay cắt lại), **Q-08** (CR tự mâu thuẫn về lý do con số — câu chữ BR08/Z-02 chờ BA chốt một câu duy nhất).

### 5.3 Nhóm case bị ảnh hưởng

| Nhóm | Case / mục | Tác động | Chờ |
| --- | --- | --- | --- |
| Z-02 nhóm J | TC-85, TC-86 | còn PASS nhưng mất giá trị biên → thay bằng 1.999/2.000/2.001 | — |
| Z-02 nhóm J | TC-87 | sai kỳ vọng (1 tin sau CR) + sai actor + "ghép = đủ" vô căn cứ | Q-02 |
| Z-02 nhóm J | TC-88 | 3 tin → 2 tin | Q-09 |
| Z-02 nhóm J | TC-89 ❓ | dựng lại fixture tại 2.000 | Q-03 |
| Z-02 lưu mẫu | TC-42, TC-43 | còn PASS; sửa lý do (có trần); thêm biên trần cũ/mới | Q-06, Q-14 |
| Z-02 ma trận | AC-30, AC-31, BR08, tiêu đề nhóm J | sửa con số, actor "hệ thống tách", nhãn "của Zalo" | Q-08 |
| Case mới | biên 1.999/2.000/2.001, 2.500, 3.000, Retry từng phần, ô soạn không chặn | viết được ngay (fixture nhóm A) | — |
| Case mới | cắt cứng, xuống dòng, Unicode, link | ❓ | Q-14, Q-04, Q-02, Q-03, Q-13 |
| Case mới | API: BE từ chối vượt mốc/lần gọi; hub 2.000 | ❓ | Q-10, Q-05 |
| Hồi quy | G003 BR03c, G009 BR12 (quote/markup), G015, luồng gửi ≤ mốc | kỳ vọng giữ, đổi số | — |

## 6. Liên kết

- Test cases: `wiki/qa/test-cases/CR-004.md` (sẽ tạo ở Phase 3) · bộ case Z-02 cần sửa: `wiki/qa/test-cases/Z-02.md`
- Test runs: `wiki/qa/test-runs/CR-004_*.md`
- Intake: `wiki/qa/intake/INTAKE-CR-004.md`
- Nguồn (thay cho FEAT): `tailieu/CR-004 - Nâng mốc tách tin nhắn dài.md` · `tailieu/G003 - Chat.md` · `tailieu/G005 - Tin nhắn mẫu.md` · `tailieu/G009 - Tính năng bổ sung Chat.md` · `tailieu/G015 - Hiển thị Thumbnail khi gửi kèm Link.md` (tên file tiếng Việt dạng Unicode NFD — dùng Glob + Grep để mở)
- Báo cáo điểm liên quan: `wiki/qa/point-reports/2026-09_z-02.md` · ma trận phủ: `wiki/QA_COVERAGE_MATRIX.md`
- FEAT: **chưa tồn tại** — khi có `wiki/features/FEAT-<NNN>.md` cho CR này, backfill link tại đây và tick checklist mục 4.4.

## Lịch sử cập nhật

| Ngày | Người | Thay đổi |
| --- | --- | --- |
| 2026-10-07 | QA (qa-test-planner) | Tạo test plan lần đầu, Draft: scope delta/không đổi + sửa Z-02, test types (acceptance/system-e2e/regression), fixture theo trạng thái dùng ngay / chờ câu hỏi, entry (build 2.000, Q-10, Q-05), exit theo `projectConfig.qa.exitCriteria`, rủi ro + 11 câu CHẶN/mâu thuẫn, phát hiện 932+999+135 = 2.066 ≠ 2.069. Manual design-only; không có FEAT nên không tick checklist. |
