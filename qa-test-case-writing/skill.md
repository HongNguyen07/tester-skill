---
name: qa-test-case-writing
description: "Rule viết test case manual theo template chuẩn của team (mẫu qa-flow, dùng chung cho /qa-flow và /qa-orchestrator) — khối thông tin 6 dòng, bảng Manual test theo Round, bảng 15 cột cố định (Test Case ID · Purpose · Category · Trace BR · Precondition · Steps · Data · Expected Result · Round 1–3 · Error Code · Note · Date · Tester) tách nhóm A (theo requirement) và nhóm B (QA bổ sung), câu hỏi cần chốt, thống kê, lịch sử cập nhật. Cột Trace BR bắt buộc cho MỖI case. Gồm quy tắc từng cột, cách ghi Trace BR khi tài liệu có / không có mã BR, giá trị hợp lệ của Category và Result, chỗ đặt ma trận BR → case, checklist tự kiểm, và cách chuyển file test case cũ sang template này. Load khi viết, bổ sung, sửa, review hoặc chuyển đổi test case trong wiki/qa/test-cases/ hoặc wiki/qa/features/<ID>/04-testcases.md."
allowed-tools: Read, Write, Edit, Glob, Grep
---

# qa-test-case-writing — Rule viết test case (template chuẩn)

Skill này quy định **hình dạng và cách điền** một file test case. Nó không dạy cách nghĩ ra case —
việc đó thuộc `qa-test-design` (BVA, EP, decision table, state transition…). Load bởi
`qa-test-case-writer` (viết), `qa-reviewer` (soát), `qa-test-designer` (bộ qa-flow), và bất kỳ ai sửa
file test case.

**Template chuẩn duy nhất của team = mẫu của `qa-flow`.** Dùng chung cho cả hai luồng:

| Luồng | File đầu ra | Template |
|---|---|---|
| `/qa-flow` | `wiki/qa/features/<ID>/04-testcases.md` | `qa-flow/templates/testcase-template.md` |
| `/qa-orchestrator` | `{wikiPath}/qa/test-cases/<FEAT>.md` | `{wikiPath}/qa/test-cases/_template.md` |

Hai file template là **bản sao nguyên văn** của nhau. Sửa một thì sửa cả hai, không để lệch. Copy
template rồi điền, không tự dựng bảng khác.

---

## 1. Cấu trúc file (thứ tự cố định)

Không có frontmatter YAML. Thông tin nhận diện và ghi công nằm trong khối thông tin và bảng lịch sử.

1. **Tiêu đề** — `# Test Cases — <ID>: <tên feature>`.
2. **Khối thông tin** — bảng `| Thông tin | Giá trị |`, 6 dòng, đúng tên:

   | Dòng | Điền gì |
   |---|---|
   | `Mã trường hợp kiểm thử` | Mã dùng làm tiền tố ID (`MH1`, `G032`, `CR004`…) |
   | `Tên trường hợp kiểm thử` | Tên feature |
   | `Tài liệu nguồn` | `tailieu/<tệp>` (version ghi trong tệp). Luồng orchestrator: `features/FEAT-<NNN>.md` + tài liệu BA mà FEAT trỏ tới |
   | `Căn cứ cách hiểu` | qa-flow: `02-alignment-summary.md`, cổng mở ngày `<YYYY-MM-DD>`. Orchestrator: `FEAT-<NNN>` §2 Trace + §3 Contract, `TP-<FEAT>` |
   | `Trục trace` | `Trace BR = BR / AC mà case đang verify (mã gốc của tài liệu)`. Tài liệu không đánh mã BR → ghi thêm `mã BR-xx do QA tự đánh` (§3.4) |
   | `Người thiết kế · ngày` | `<tên/initials> · <YYYY-MM-DD>` — căn cứ ghi công cho `qa-point-scoring` |

3. **`## Manual test`** — bảng đếm **theo Round**:

   ```
   |         | Pass | Fail | NA | Chưa thực hiện | Tổng |
   | Round 1 |      |      |    |                |      |
   | Round 2 |      |      |    |                |      |
   | Round 3 |      |      |    |                |      |
   ```

   - Dòng `Round n` đếm giá trị ở cột `Round n` của **mọi** dòng case trong file (nhóm A + nhóm B).
   - `Todo` đếm vào `Chưa thực hiện`.
   - Mỗi dòng: `Pass + Fail + NA + Chưa thực hiện = Tổng` = tổng số dòng case trong file.
   - Khi mới viết: `0 · 0 · 0 · <n> · <n>` cho cả 3 Round.

4. **`## A. Case theo requirement`** — bảng 15 cột (§2), group row theo BR.
5. **`## B. Case QA bổ sung / exploratory`** `[QA BỔ SUNG]` — bảng 15 cột, đặt riêng, đếm riêng, **không
   cộng vào độ phủ requirement**. Không có case nhóm B thì giữ heading, ghi `Không có`.
6. **`## Câu hỏi cần chốt`** — `| Q | Nội dung | Case liên quan | Trạng thái |`.
7. **`## Thống kê`** — bảng 2 cột nhóm A / nhóm B: tổng case · Positive / Negative / Edge case / khác ·
   số case `❓ Cần chốt` · BR đã phủ / tổng BR (chỉ nhóm A). Đếm bằng script nếu có Bash, không ước lượng.
8. **`## Lịch sử cập nhật`** — `| Ngày | Ai | Thay đổi |`. **Chỉ thêm dòng, không sửa dòng cũ.** Cột
   `Thay đổi` phải nêu **khoảng mã TC** bị tạo/sửa (vd `Tạo [G032_01]→[G032_24]`) — đây là căn cứ chấm point.

**Ma trận BR → case:**

- Luồng `qa-flow`: nằm ở **Coverage Matrix** trong `03-test-design.md`. Không lặp lại trong file case.
- Luồng `qa-orchestrator` (không có `03-…`): thêm phần phụ `## Ma trận BR → case` **sau Thống kê, trước
  Lịch sử cập nhật**: `| BR | Nội dung rút gọn | Case phủ (nhóm A) | Trạng thái |`, Trạng thái ∈
  `Đã phủ` / `Phủ một phần` / `Chưa phủ`. FEAT có AC thì thêm ma trận AC → case ngay dưới.

Phần phụ khác (quy ước dữ liệu, decision table, return block) cũng đặt **trước** Lịch sử cập nhật.

## 2. Bảng test case — 15 cột, không đổi tên, không đổi thứ tự, không thêm bớt

```
| Test Case ID | Purpose | Category | Trace BR | Precondition | Steps | Data | Expected Result | Round 1 | Round 2 | Round 3 | Error Code | Note | Date | Tester |
```

Dùng cho cả bảng nhóm A và nhóm B. `Round 1–3` là ba cột con của **Result**. Thông tin không có cột riêng
(nguồn tài liệu, evidence, ưu tiên, câu hỏi chặn) đi vào **Note** — không tự thêm cột.

| Cột | Quy tắc |
|---|---|
| **Test Case ID** | `[<Mã>_<NN>]`, vd `[MH1_01]`. Đánh số **liên tục trong cả file** (nhóm B tiếp số sau nhóm A), tối thiểu 2 chữ số (01…99, 100…), **không reset theo nhóm**. Không gắn ký hiệu (❓, ⚠, 🆕) vào ô ID — ghi ở Note. Case bổ sung sau lấy số kế tiếp, không chèn giữa, không dùng lại số đã xoá. |
| **Purpose** | **Một câu ngắn**, viết riêng cho từng case, nói case kiểm cái gì, đọc riêng vẫn hiểu. Vd `Mã QR hết hạn → Làm mới mã`. Không chép lại Expected Result, không viết "Kiểm tra chức năng X hoạt động đúng". |
| **Category** | Đúng một trong: `Positive` · `Negative` · `Edge case` · `UI` · `Security` · `Performance`. Loại chi tiết hơn (regression, E2E, a11y, baseline…) ghi ở Note dạng `Loại: …`. |
| **Trace BR** | **Bắt buộc, không để trống.** Xem §3. |
| **Precondition** | Trạng thái hệ thống, quyền, dữ liệu có sẵn trước bước 1. Không có thì ghi `-`. |
| **Steps** | Đánh số `1.` `2.`, mỗi bước một dòng (`<br>`), bắt đầu bằng động từ (Bấm, Nhập, Quét, Chờ, Gọi API…). Gọi tên nút / menu **đúng như trên UI**. Người chưa đọc spec phải chạy được; cấm bước kiểu "Thực hiện thao tác theo test case". |
| **Data** | Giá trị cụ thể dùng để test (SĐT, chuỗi, độ dài, tài khoản, file). Không có thì ghi `-`. Cấm "dữ liệu hợp lệ", "dữ liệu phù hợp". |
| **Expected Result** | Kết quả **kiểm chứng được**: UI + dữ liệu + log nếu có. **Nhóm A** chỉ lấy từ nội dung có trong nguồn hoặc đã được BA xác nhận (`[NGUỒN]` / `[ĐÃ XÁC NHẬN]`). Thông báo, nhãn, trạng thái **chép nguyên văn**, đặt trong ngoặc kép. Cấm "hoạt động bình thường", "xử lý đúng". Case kỳ vọng một lỗi có mã thì ghi thêm dòng cuối `**Mã lỗi kỳ vọng:** <mã đúng theo tài liệu/contract>` — không tự chế mã. **Nhóm B** ghi `ĐO & GHI: …` hoặc `❓ Cần chốt` — không phải tiêu chí pass theo requirement. |
| **Round 1 / 2 / 3** | Đúng một trong: `Todo` · `Pass` · `Fail` · `NA`. Mặc định `Todo`. Người viết case **không** điền Pass/Fail. |
| **Error Code** | Để trống khi viết. Tester điền **mã bug** (`BUG-<NNN>`) khi một Round là `Fail`. Đây KHÔNG phải chỗ ghi mã lỗi kỳ vọng. |
| **Note** | Mỗi ý một dòng (`<br>`), theo thứ tự: `Ưu tiên: P1/P2/P3` · `Loại: …` · `❓ Cần chốt: Q-<nn>` · `Nguồn: <tệp:dòng "trích ngắn">` · `Evidence: <screenshot / HAR / log / axe-report>`. Nhóm B thêm `Lý do thêm: …`. |
| **Date** / **Tester** | Để trống khi viết; tester điền ngày chạy gần nhất và tên mình. |

**Group row:** mỗi nhóm case mở đầu bằng một dòng chỉ có ô đầu in đậm, các ô còn lại trống:
`| **BR01 — Tên quy tắc** | | | … |`. Nhóm theo BR (ưu tiên) hoặc theo bước của luồng. Thứ tự trong
nhóm: Positive → Negative → Edge case. Được phép tách mỗi nhóm thành một bảng riêng dưới heading
`###` nếu file quá dài — khi đó mỗi bảng vẫn đủ 15 cột và vẫn nằm trong mục A hoặc B tương ứng.

## 3. Trace BR — mỗi case trỏ về quy tắc nó kiểm

**No test without source.** Case nhóm A không trỏ được về tài liệu thì không viết.

1. **Ghi mã BR trước, mã phụ sau**, ngăn bằng ` · `: `BR07 · AC-11 · E01`. Mã phụ (AC / E / §) giúp tìm đúng chỗ trong tài liệu, không thay được mã BR. Liên kết tới Use Case, Scenario, Decision / State **không** nhét vào Trace BR — nằm ở Coverage Matrix.
2. **Một case thuộc đúng một BR chính** — BR mà kỳ vọng chính của case kiểm (khớp `qa-point-scoring`: mỗi mã TC chỉ thuộc một BR). Case chạm thêm BR khác thì ghi BR chính đứng đầu: `BR08 · BR05 · AF02`. Chỉ ghi BR/AC mà case thực sự kiểm, không ghi dồn cho đủ.
3. **Nhiều tài liệu cùng có số BR trùng nhau** → thêm tiền tố tài liệu: `G007 BR18`, `G017 BR24`.
4. **Tài liệu không đánh mã BR** → QA tự đánh `BR-xx` theo `qa-point-scoring` (giữ ổn định qua các version, dùng chung với báo cáo point), kèm mã bước/mục gốc: `BR-10 · S2-09`. Khai ở dòng `Trục trace` của khối thông tin.
5. **Case nhóm A không thuộc BR nào** (thao tác thuần, hồi quy, baseline) → ghi `— · <mã gần nhất của tài liệu>`, vd `— · AC-01`, `— · G012 UC-01`. Dấu `—` là lời khai "chưa có BR", không phải ô trống.
6. **Case QA tự bổ sung ngoài tài liệu** (a11y, đo kiểm, error guessing, edge case tài liệu không nói) → đặt ở **mục B**. Trace BR = BR liên quan nếu có (`BR07 (liên quan)`), không có thì `N/A — QA bổ sung`. Note ghi `Loại: QA bổ sung` + `Lý do thêm: …`.
7. **Không bịa mã.** BR / AC / E không có trong tài liệu thì không được ghi. Tài liệu dẫn tới mã không tồn tại → ghi nguyên văn kèm `❓ Cần chốt` ở Note.

BR chỉ có case đang `❓ Cần chốt` thì **chưa tính là đã phủ**. BR không có case nào → ghi rõ lý do ở
ma trận / Coverage Matrix (thiếu thông tin, ngoài phạm vi, chờ BA).

## 4. Khi tài liệu chưa rõ

- Vẫn viết đủ Steps và Data; ở Expected Result ghi điều chắc chắn kiểm được, phần chưa rõ ghi `Chờ Q-<nn>: …` — **không đoán hộ BA**.
- Note ghi `❓ Cần chốt: Q-<nn>`; thêm một dòng vào bảng "Câu hỏi cần chốt" với ID case liên quan.
- Có kỳ vọng tạm thì gắn nhãn `[giả định Q-<nn>]` ngay trong Expected Result; không được dùng kỳ vọng tạm để kết luận Pass/Fail.

## 5. Tự kiểm trước khi nộp

- [ ] Có đủ và đúng thứ tự: tiêu đề · khối thông tin (6 dòng) · Manual test · A · B · Câu hỏi cần chốt · Thống kê · Lịch sử cập nhật.
- [ ] Mọi dòng case (A và B) đủ 15 ô; không cột thừa, không cột đổi tên.
- [ ] Không ID trùng; số chạy liên tục qua cả A và B; ô ID không có ký hiệu.
- [ ] **Không ô Trace BR nào trống**; mọi mã trong đó tồn tại thật trong tài liệu (hoặc là `BR-xx` QA đánh, có khai `Trục trace`).
- [ ] Không case QA bổ sung nào nằm lẫn trong mục A.
- [ ] Mỗi BR của tài liệu có ≥1 case nhóm A trong ma trận / Coverage Matrix, hoặc có lý do chưa phủ.
- [ ] Category và Round chỉ dùng giá trị ở §2; Round đều là `Todo`; Error Code, Date, Tester trống.
- [ ] Purpose đọc riêng vẫn hiểu, không trùng hàng loạt; Steps chạy được mà không cần mở spec; Data là giá trị cụ thể.
- [ ] Expected Result không có "hoạt động bình thường / xử lý đúng"; thông báo chép nguyên văn; case lỗi có `Mã lỗi kỳ vọng` nếu tài liệu có mã.
- [ ] Manual test: mỗi Round `Pass + Fail + NA + Chưa thực hiện = Tổng` = tổng số dòng case; chưa chạy thì `Chưa thực hiện = Tổng`.
- [ ] Thống kê khớp bảng case (đếm lại, không ước lượng).
- [ ] Dòng `Người thiết kế · ngày` đã điền; Lịch sử cập nhật có dòng mới nêu khoảng mã TC.

## 6. Chuyển file test case cũ sang template này

Giữ nguyên nội dung case (bước, dữ liệu, kỳ vọng) — chỉ đổi chỗ đặt. Trước khi ghi đè phải sao lưu bản
cũ; sau khi chuyển, đếm lại số case và đối chiếu với bản cũ.

| Thông tin cũ | Chuyển sang |
|---|---|
| Frontmatter `feature` | Tiêu đề `# Test Cases — <ID>: …` (tên file giữ nguyên) |
| Frontmatter `createdBy` / `createdAt` | Dòng `Người thiết kế · ngày` |
| Frontmatter `plan` | Dòng `Căn cứ cách hiểu` (`TP-<FEAT>`) |
| Frontmatter `updatedBy` / `updatedAt` | Một dòng trong **Lịch sử cập nhật** |
| Dòng `Tên màn hình/Tên chức năng` | Dòng `Tên trường hợp kiểm thử` |
| Dòng `Thiết bị, hệ điều hành` | Bỏ khỏi file case — ghi ở file test-run (`env`) khi chạy |
| Bảng Manual test 5 dòng (đạt P / không đạt F / …) | Bảng **theo Round** (§1.3), đếm lại từ cột Round 1–3 |
| Case có Trace `Ngoài tài liệu (QA bổ sung)` | Chuyển sang **mục B**, Trace BR theo §3.6, giữ nguyên ID |
| `## Ma trận BR → case` ở cuối file | qa-flow: chuyển vào Coverage Matrix của `03-test-design.md`. Orchestrator: giữ làm phần phụ, đặt sau Thống kê |
| `TC id` | **Test Case ID**. File đã được intake / test plan / point report / ma trận tham chiếu thì **giữ mã cũ** để không gãy trace; chỉ file viết mới mới bắt buộc dạng `[<Mã>_<NN>]`. |
| `Trace (AC/US/BR)` | **Trace BR** — bổ sung mã BR theo §3 nếu cột cũ chỉ có AC / bước. |
| `Loại` (Happy / Edge / Error · loại test) | **Category**: Happy → `Positive`, Edge → `Edge case`, Error → `Negative`; case security → `Security`, a11y → `UI`, perf → `Performance`. Giá trị gốc giữ ở Note `Loại: …`. |
| `Mã lỗi` (mã lỗi kỳ vọng) | Dòng cuối của **Expected Result**: `**Mã lỗi kỳ vọng:** …`. |
| `Nguồn tài liệu`, `Evidence-required`, `Trạng thái`, `Priority` | **Note** (`Nguồn:`, `Evidence:`, `Trạng thái thiết kế:`, `Ưu tiên:`). |
| Ký hiệu ❓ / ⚠ cạnh mã | **Note** (`❓ Cần chốt: …`). |
| `Q<n>` | `Q-<nn>` |
| `Status` / `Actual Result` | **Round 1** (`Not Run` → `Todo`). |
| (không có) | **Purpose** — viết mới, một câu cho mỗi case. |
