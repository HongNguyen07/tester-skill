---
name: qa-test-case-writing
description: "Rule viết test case manual theo template chuẩn của team — 15 cột cố định (Test Case ID · Purpose · Category · Trace BR · Precondition · Steps · Data · Expected Result · Round 1–3 · Error Code · Note · Date · Tester), khối thông tin + bảng đếm Manual test, group row, và cột Trace BR bắt buộc cho MỖI case. Gồm quy tắc từng cột, cách ghi Trace BR khi tài liệu có / không có mã BR, giá trị hợp lệ của Category và Result, ma trận BR → case, checklist tự kiểm, và cách chuyển file test case cũ sang template này. Load khi viết, bổ sung, sửa, review hoặc chuyển đổi test case trong wiki/qa/test-cases/."
allowed-tools: Read, Write, Edit, Glob, Grep
---

# qa-test-case-writing — Rule viết test case (template chuẩn)

Skill này quy định **hình dạng và cách điền** một file test case. Nó không dạy cách nghĩ ra case —
việc đó thuộc `qa-test-design` (BVA, EP, decision table, state transition…). Load bởi
`qa-test-case-writer` (viết), `qa-reviewer` (soát), và bất kỳ ai sửa file trong
`{wikiPath}/qa/test-cases/`.

Template: `{wikiPath}/qa/test-cases/_template.md`. Copy template rồi điền, không tự dựng bảng khác.

---

## 1. Cấu trúc file (thứ tự cố định)

1. **Frontmatter** — `feature`, `plan`, `createdBy`, `createdAt` (+ `updatedAt` khi sửa).
2. **Khối thông tin** — bảng 3 dòng:
   - `Tên màn hình/Tên chức năng`
   - `Thiết bị, hệ điều hành` — môi trường test; chưa biết thì để trống, tester điền khi chạy.
   - `Mã trường hợp kiểm thử` — mã dùng làm tiền tố ID (`MH1`, `MH2`… hoặc mã feature như `G032`, `CR004`).
3. **Manual test** — bảng đếm 5 dòng, đúng tên:
   `Số trường hợp kiểm thử đạt (P)` · `không đạt (F)` · `đang xem xét (NA)` · `chưa thực hiện` · `Tổng số trường hợp kiểm thử`.
   Kết quả của một case = **Round mới nhất khác `Todo`** (Round 3 → Round 2 → Round 1). Tổng 4 dòng trên phải bằng dòng Tổng.
4. **Bảng test case** — 15 cột ở §2, có group row.
5. **Ma trận BR → case** — mỗi BR của tài liệu một dòng.
6. **Câu hỏi cần chốt** — nếu có case bị chặn bởi điểm tài liệu chưa rõ.

Phần phụ (quy ước dữ liệu, decision table, return block, lịch sử cập nhật) đặt **sau** các mục trên.

## 2. Bảng test case — 15 cột, không đổi tên, không đổi thứ tự, không thêm bớt

```
| Test Case ID | Purpose | Category | Trace BR | Precondition | Steps | Data | Expected Result | Round 1 | Round 2 | Round 3 | Error Code | Note | Date | Tester |
```

`Round 1–3` là ba cột con của **Result**. Thông tin không có cột riêng (nguồn tài liệu, evidence,
ưu tiên, câu hỏi chặn) đi vào **Note** — không tự thêm cột.

| Cột | Quy tắc |
|---|---|
| **Test Case ID** | `[<Mã>_<NN>]`, vd `[MH1_01]`. Đánh số **liên tục trong cả file**, tối thiểu 2 chữ số (01…99, 100…), **không reset theo nhóm**. Không gắn ký hiệu (❓, ⚠, 🆕) vào ô ID — ghi ở Note. Case bổ sung sau lấy số kế tiếp, không chèn giữa, không dùng lại số đã xoá. |
| **Purpose** | **Một câu ngắn** nói case kiểm cái gì, đọc riêng vẫn hiểu. Vd `Mã QR hết hạn → Làm mới mã`. Không chép lại Expected Result, không viết "Kiểm tra chức năng X hoạt động đúng". |
| **Category** | Đúng một trong: `Positive` · `Negative` · `Edge case` · `UI` · `Security` · `Performance`. Loại chi tiết hơn (regression, E2E, a11y, baseline…) ghi ở Note dạng `Loại: …`. |
| **Trace BR** | **Bắt buộc, không để trống.** Xem §3. |
| **Precondition** | Trạng thái hệ thống, quyền, dữ liệu có sẵn trước bước 1. Không có thì ghi `-`. |
| **Steps** | Đánh số `1.` `2.`, mỗi bước một dòng (`<br>`), bắt đầu bằng động từ (Bấm, Nhập, Quét, Chờ, Gọi API…). Gọi tên nút / menu **đúng như trên UI**. Người chưa đọc spec phải chạy được; cấm bước kiểu "Thực hiện thao tác theo test case". |
| **Data** | Giá trị cụ thể dùng để test (SĐT, chuỗi, độ dài, tài khoản, file). Không có thì ghi `-`. Cấm "dữ liệu hợp lệ", "dữ liệu phù hợp". |
| **Expected Result** | Kết quả **kiểm chứng được**: UI + dữ liệu + log nếu có. Thông báo, nhãn, trạng thái **chép nguyên văn** tài liệu, đặt trong ngoặc kép. Cấm "hoạt động bình thường", "xử lý đúng". Case kỳ vọng một lỗi có mã thì ghi thêm dòng cuối `**Mã lỗi kỳ vọng:** <mã đúng theo tài liệu/contract>` — không tự chế mã. |
| **Round 1 / 2 / 3** | Đúng một trong: `Todo` · `Pass` · `Fail` · `NA`. Mặc định `Todo`. Người viết case **không** điền Pass/Fail. |
| **Error Code** | Để trống khi viết. Tester điền **mã bug** (`BUG-<NNN>`) khi một Round là `Fail`. Đây KHÔNG phải chỗ ghi mã lỗi kỳ vọng. |
| **Note** | Mỗi ý một dòng (`<br>`), theo thứ tự: `Ưu tiên P1/P2/P3` · `Loại: …` · `❓ Cần chốt: Q<n>` · `Nguồn: <tệp:dòng "trích ngắn">` · `Evidence: <screenshot / HAR / log / axe-report>`. |
| **Date** / **Tester** | Để trống khi viết; tester điền ngày chạy gần nhất và tên mình. |

**Group row:** mỗi nhóm case mở đầu bằng một dòng chỉ có ô đầu in đậm, các ô còn lại trống:
`| **BR01 — Tên quy tắc** | | | … |`. Nhóm theo BR (ưu tiên) hoặc theo bước của luồng. Thứ tự trong
nhóm: Positive → Negative → Edge case. Được phép tách mỗi nhóm thành một bảng riêng dưới heading
`###` nếu file quá dài — khi đó mỗi bảng vẫn đủ 15 cột.

## 3. Trace BR — mỗi case trỏ về quy tắc nó kiểm

**No test without source.** Case không trỏ được về tài liệu thì không viết.

1. **Ghi mã BR trước, mã phụ sau**, ngăn bằng ` · `: `BR07 · AC-11 · E01`. Mã phụ (UC / AF / E / AC / §) giúp tìm đúng chỗ trong tài liệu, không thay được mã BR.
2. **Một case thuộc đúng một BR chính** — BR mà kỳ vọng chính của case kiểm (khớp `qa-point-scoring`: mỗi mã TC chỉ thuộc một BR). Case chạm thêm BR khác thì ghi BR chính đứng đầu: `BR08 · BR05 · AF02`.
3. **Nhiều tài liệu cùng có số BR trùng nhau** → thêm tiền tố tài liệu: `G007 BR18`, `G017 BR24`.
4. **Tài liệu không đánh mã BR** → QA tự đánh `BR-xx` theo `qa-point-scoring` (giữ ổn định qua các version, dùng chung với báo cáo point), kèm mã bước/mục gốc: `BR-10 · S2-09`. Ghi rõ điều này ở một dòng `Trục trace:` ngay dưới khối thông tin.
5. **Case không thuộc BR nào** (thao tác thuần, hồi quy, baseline) → ghi `— · <mã gần nhất của tài liệu>`, vd `— · AC-01`, `— · G012 UC-01`. Dấu `—` là lời khai "chưa có BR", không phải ô trống.
6. **Case QA tự bổ sung ngoài tài liệu** (a11y, đo kiểm, error guessing) → `Ngoài tài liệu (QA bổ sung) · <BR/UC liên quan nếu có>`. Kỳ vọng của case này chỉ là tiêu chí kiểm chung, không phải yêu cầu nghiệp vụ; ghi rõ ở Note.
7. **Không bịa mã.** BR / AC / E không có trong tài liệu thì không được ghi. Tài liệu dẫn tới mã không tồn tại → ghi nguyên văn kèm `❓ Cần chốt` ở Note.

**Ma trận BR → case** ở cuối file: mỗi BR một dòng, liệt kê case phủ. BR chỉ có case đang
`❓ Cần chốt` thì **chưa tính là đã phủ**. BR không có case nào → ghi rõ lý do (thiếu thông tin,
ngoài phạm vi, chờ BA).

## 4. Khi tài liệu chưa rõ

- Vẫn viết đủ Steps và Data; ở Expected Result ghi điều chắc chắn kiểm được, phần chưa rõ ghi `Chờ Q<n>: …` — **không đoán hộ BA**.
- Note ghi `❓ Cần chốt: Q<n>`; thêm một dòng vào bảng "Câu hỏi cần chốt" với ID case liên quan.
- Có kỳ vọng tạm thì gắn nhãn `[giả định Q<n>]` ngay trong Expected Result; không được dùng kỳ vọng tạm để kết luận Pass/Fail.

## 5. Tự kiểm trước khi nộp

- [ ] Mọi dòng case đủ 15 ô; không cột thừa, không cột đổi tên.
- [ ] Không ID trùng; số chạy liên tục; ô ID không có ký hiệu.
- [ ] **Không ô Trace BR nào trống**; mọi mã trong đó tồn tại thật trong tài liệu (hoặc là `BR-xx` QA đánh, có khai `Trục trace`).
- [ ] Mỗi BR của tài liệu có ≥1 case trong ma trận, hoặc có lý do chưa phủ.
- [ ] Category và Round chỉ dùng giá trị ở §2; Round đều là `Todo`; Error Code, Date, Tester trống.
- [ ] Purpose đọc riêng vẫn hiểu; Steps chạy được mà không cần mở spec; Data là giá trị cụ thể.
- [ ] Expected Result không có "hoạt động bình thường / xử lý đúng"; thông báo chép nguyên văn; case lỗi có `Mã lỗi kỳ vọng` nếu tài liệu có mã.
- [ ] Bảng Manual test: Tổng = số dòng case; `chưa thực hiện` = Tổng khi chưa chạy.

## 6. Chuyển file test case cũ sang template này

Giữ nguyên nội dung case (bước, dữ liệu, kỳ vọng) — chỉ đổi chỗ đặt:

| Cột / thông tin cũ | Chuyển sang |
|---|---|
| `TC id` | **Test Case ID**. File đã được intake / test plan / point report / ma trận tham chiếu thì **giữ mã cũ** để không gãy trace; chỉ file viết mới mới bắt buộc dạng `[<Mã>_<NN>]`. |
| `Trace (AC/US/BR)` | **Trace BR** — bổ sung mã BR theo §3 nếu cột cũ chỉ có AC / bước. |
| `Loại` (Happy / Edge / Error · loại test) | **Category**: Happy → `Positive`, Edge → `Edge case`, Error → `Negative`; case security → `Security`, a11y → `UI`, perf → `Performance`. Giá trị gốc giữ ở Note `Loại: …`. |
| `Mã lỗi` (mã lỗi kỳ vọng) | Dòng cuối của **Expected Result**: `**Mã lỗi kỳ vọng:** …`. |
| `Nguồn tài liệu`, `Evidence-required`, `Trạng thái`, `Priority` | **Note** (`Nguồn:`, `Evidence:`, `Trạng thái thiết kế:`, `Ưu tiên:`). |
| Ký hiệu ❓ / ⚠ cạnh mã | **Note** (`❓ Cần chốt: …`). |
| `Status` / `Actual Result` | **Round 1** (`Not Run` → `Todo`). |
| (không có) | **Purpose** — viết mới, một câu cho mỗi case. |

Trước khi ghi đè phải sao lưu bản cũ; sau khi chuyển, đếm lại số case và đối chiếu với bản cũ.
