---
name: qa-point-scoring
description: "Quy tắc bóc tách đầu việc QA và chấm point (0.05–1 theo ma trận Size × Effort) — độc lập, KHÔNG dùng commit làm căn cứ. Đơn vị bóc việc là MỘT BUSINESS RULE trong tài liệu (KHÔNG tính theo use case / luồng), mỗi BR một dòng point gộp cả phân tích + thiết kế case + chạy. Gồm: cách nhận ra BR trong một luồng, chống đếm trùng, xử lý case không có nguồn tài liệu, điều kiện chốt point, phạm vi tính/không tính, bằng chứng trong artifact QA, quy ước ghi công, cách chọn Size/Effort, mốc 1 point, bảng phụ cho defect/automation/regression, format báo cáo. Load khi cần chấm point đầu việc QA, bóc tài liệu thành danh sách yêu cầu cần test, hoặc review báo cáo point của tester."
allowed-tools: Read, Write, Edit, Glob, Grep
---

# qa-point-scoring — Quy tắc chấm point đầu việc QA

> **Bộ quy tắc độc lập của QA.** Không tham chiếu và không phụ thuộc quy tắc chấm point của bộ phận
> nào khác. Point đo **khối lượng đầu việc kiểm thử**, căn cứ trên artifact QA.
>
> **Đơn vị bóc việc = MỘT BUSINESS RULE (BR).** Trong rule này "yêu cầu" luôn nghĩa là một BR.
> Việc phân tích, thiết kế case và chạy test đều tính theo từng BR, gộp trong **một dòng point**.
> Use case / luồng **không** phải đơn vị — nó chỉ là con đường để kiểm các BR. AC, bước đánh số và
> mã lỗi cũng không phải đơn vị riêng: chúng thuộc BR chứa chúng.
>
> **Không dùng commit làm căn cứ chấm.** Nhiều đầu việc QA không sinh commit (chạy test thủ công,
> dựng dữ liệu, điều tra lỗi, đối chiếu tài liệu). Căn cứ là artifact + phần ghi công trong artifact (§2).
>
> ⚠️ **Phân biệt với `wiki/SCORING.md`:** `SCORING.md` chấm **chất lượng** một lần review (0–100,
> gate pass/loop-back). Skill này chấm **khối lượng đầu việc** (0.05–1).

## Core rules

1. **Một business rule = một dòng point.** Dòng đó gộp cả phân tích + thiết kế case + chạy test.
2. **Một hành vi chỉ thuộc đúng MỘT BR.** Luồng thành công thuần và thao tác chức năng không chứa quy tắc thì **không có dòng** (§1.1).
3. **Số test case không quyết định point.** Một yêu cầu đẻ ra 1 case hay 8 case vẫn là một dòng; số case chỉ ảnh hưởng Effort.
4. **Không có mã yêu cầu thì không có dòng.** Yêu cầu phải trỏ được về mục/dòng trong tài liệu nguồn.
5. **Point chốt một lần cho mỗi yêu cầu** — xem điều kiện chốt ở §1.3. Không chốt hai lần cho cùng một yêu cầu.
6. **Pass không evidence không được tính** — phần chạy của yêu cầu đó coi như chưa làm.
7. **Mức nghiêm trọng của lỗi không nâng point** — chỉ độ khó tái hiện mới nâng (bảng phụ §3).
8. **Ownership không nhân phần trăm vào point.**
9. **Một dòng tối đa 1 point.** Một BR đơn lẻ hầu như không bao giờ chạm mức này — chạm `1` là dấu hiệu BR đó thực chất là nhiều BR.
10. **Evidence là điều kiện, không phải đầu việc.**

---

## 1. Bóc tài liệu thành danh sách yêu cầu

### 1.1. Cái gì là một đơn vị

**Đơn vị bóc việc là business rule (BR).** Use case / luồng không phải đơn vị.

| Loại | Là gì | Dấu hiệu nhận ra | Ví dụ (ZALO-OTP) |
|---|---|---|---|
| **Business rule (BR)** | Một quy tắc độc lập, đặt tên được, có điều kiện kích hoạt và kết quả riêng | "nếu … thì …", ngưỡng, thang bậc, thứ tự kiểm tra, bất biến, hậu điều kiện, quy tắc hiển thị | `BR-10 Khóa đổi số theo bậc` |
| **Mục phi chức năng** | Tiêu chí kiểm được do **tài liệu** nêu | Có ngưỡng/ràng buộc trong tài liệu | `lọc client-side`, `không phá luồng cũ` |
| **Sơ đồ trạng thái** | Tính **một** BR cho cả sơ đồ, không tách từng transition | Vòng đời có trạng thái cuối | `vòng đời mẫu: Hiển thị ↔ Tạm ẩn → Đã xóa` |

**Nhận ra BR trong một luồng:** đọc từng bước, bước nào là *quy tắc* (có điều kiện, ngưỡng, bất biến,
hậu điều kiện, thứ tự kiểm tra) thì tách thành BR; bước chỉ là *thao tác* thì không.

| Trong luồng | Là BR? |
|---|---|
| "đúng mã → lưu SĐT, đánh dấu đã xác thực, xóa 3 loại cache" | **Có** — hậu điều kiện (`BR-15`) |
| "tắt gửi Zalo thật → không gọi Zalo, trả thêm `otp`" | **Có** — điều kiện kích hoạt + kết quả riêng (`BR-14`) |
| "chỉ hiện ô nhập cho mục có trong JSON, ngoại lệ 3 nhóm khóa" | **Có** — quy tắc hiển thị (`BR-16`) |
| "bấm Gửi → nhận mã" không kèm điều kiện nào | Không — thao tác |
| "bật/tắt nút X, sửa giá trị Y rồi lưu" | Không — thao tác cấu hình |

**Hệ quả cần hiểu:** luồng thành công thuần và thao tác chức năng không chứa quy tắc **không có dòng**.
Nếu cần ghi nhận khối lượng của chúng thì tài liệu phải nêu thành quy tắc, không tự gán vào BR khác.

AC, bước đánh số, mã lỗi **không** là đơn vị riêng; chúng thuộc BR chứa chúng và đi vào **Effort**
(số nhánh).

**Không tính:** mục ngoài phạm vi test (trừ khi QA phải viết case canh giữ thì tính một BR); mô tả
kiến trúc không quan sát được; thuật ngữ, mục lục.

**Case không có nguồn tài liệu** (QA tự bổ sung: bảo mật, tiếp cận, hiệu năng sơ bộ, đồng thời):

- Nằm trong BR của hành vi nó kiểm nếu BR đó có nguồn — nhưng **không tạo dòng riêng và không tự nâng point**.
- BR mà **mọi** case đều không có nguồn thì **không có dòng**.
- Ngoại lệ: rủi ro **suy ra trực tiếp từ cơ chế tài liệu mô tả** (vd đổi số làm đếm lại bộ đếm nhập sai)
  được nâng Effort của BR chứa nó — phải ghi rõ đó là suy ra.

### 1.2. Chống đếm trùng

- Một hành vi chỉ thuộc **một BR**: nằm ở BR nào thì chỉ tính ở đó, dù nhiều luồng đi qua nó.
- Mỗi **mã TC chỉ thuộc đúng một BR**. Case chạm hai BR thì gán vào BR mà kỳ vọng chính của case kiểm.
- BR kế thừa cấu trúc của BR khác (vd hai thang khóa cùng khuôn) chỉ tính **phần khác**.
- Cách kiểm: gom mọi mã TC ở cột `Case phủ` → mỗi mã xuất hiện đúng một lần (trừ mã ở mục "không tính").

**Ví dụ (ZALO-OTP):** luồng gửi mã thành công đi qua thời gian chờ, khóa đổi số, chuẩn hóa SĐT →
mỗi hành vi là một BR (`BR-07`, `BR-10`, `BR-01`); luồng "gửi mã thành công" không có dòng riêng.

### 1.3. Khi nào chốt point một dòng

Vì một dòng gộp cả phân tích + thiết kế + chạy, phải có luật rõ để không chốt hai lần và không bị kỳ rỗng point.

| Tình trạng cuối kỳ | Chốt? | Ghi ở đâu |
|---|---|---|
| Đã thiết kế case **và** đã chạy có evidence | **Chốt đủ** | Bảng A, trạng thái `đã chạy` |
| Đã thiết kế xong, **chưa chạy vì gate ngoài QA** (chưa có build, chờ môi trường) | **Chốt đủ** trong kỳ thiết kế | Bảng A, trạng thái `thiết kế xong — chờ build`. Kỳ sau chạy thì **không tính thêm**, chỉ ghi ngày chạy vào cùng dòng |
| Đã thiết kế xong nhưng **kỳ vọng chưa chốt** (chờ tài liệu/BA trả lời) | **Chưa chốt** | Mục "chưa chốt point", nêu rõ chờ câu hỏi nào |
| Đang viết dở | **Chưa chốt** | Mục "chưa chốt point" |
| Tài liệu ra version mới làm đổi kỳ vọng của yêu cầu đã chốt | **Dòng mới**, nhãn `mở rộng`, chỉ tính delta | Bảng A kỳ mới |

Chờ build không phải lỗi của QA — nên phần việc QA đã làm xong được chốt trong kỳ đã làm. Nhưng phải
ghi trạng thái để kỳ sau không ai chấm lại lần chạy.

### 1.4. Đầu việc KHÔNG gắn vào một yêu cầu cụ thể

Ba loại sau không chia được theo yêu cầu nên đi **bảng phụ** (§3), không nằm trong bảng yêu cầu:

- **Defect** — tính theo từng defect, theo độ khó tái hiện.
- **Automation** — tính theo harness / page-object / nhóm test.
- **Regression & dựng môi trường** — tính theo lần có thay đổi thật trong suite, hoặc theo đợt dựng dữ liệu.

Test plan: không có bảng riêng. Nếu test plan chỉ là điền khung thì nằm trong phần phân tích của các
dòng yêu cầu. Nếu phải tự dựng chiến lược môi trường/dữ liệu đáng kể thì ghi ở bảng phụ.

---

## 2. Căn cứ chấm + ghi công trong artifact

### 2.1. Bằng chứng mỗi dòng yêu cầu phải có

| Thành phần | Bằng chứng |
|---|---|
| Yêu cầu có thật | Mã yêu cầu + vị trí trong tài liệu nguồn (mục/dòng) |
| Đã phân tích | Kỳ vọng được ghi trong case, hoặc câu hỏi làm rõ có trích dẫn nếu tài liệu thiếu |
| Đã thiết kế | Khoảng mã TC (mục A) phủ yêu cầu đó trong `qa/test-cases/<FEAT>.md` hoặc `qa/features/<ID>/04-testcases.md` |
| Đã chạy | Dòng tương ứng trong `qa/test-runs/<FEAT>_<ngày>.md` + đường dẫn evidence **tồn tại thật** |

Bảng phụ: defect cần `BUG-<NNN>` + repro + evidence; automation cần đường dẫn file + tên test mang mã
TC; regression cần nội dung thêm/bớt trong suite.

Artifact nằm trong git thì có thể đính link cho tiện tra, nhưng **link không phải căn cứ chấm**.

### 2.2. Ghi công bắt buộc trong artifact

Không có phần này thì đầu việc **không chấm được** — không phải vì nghi ngờ, mà vì hết cách kiểm tra lại.

```yaml
---
feature: ZALO-OTP
createdBy: <tên/initials>
createdAt: 2026-09-28
updatedBy: <tên/initials>
updatedAt: 2026-10-02
---
```

Test run thêm `runBy`, `env`, `runDate`. Defect thêm `foundBy`, `foundAt`.

**Riêng file test case** (template chuẩn = mẫu qa-flow, không có frontmatter — xem `qa-test-case-writing` §1):
người tạo + ngày tạo nằm ở dòng `Người thiết kế · ngày` của khối thông tin; người sửa + ngày sửa nằm ở
bảng **Lịch sử cập nhật**. Hai chỗ này thay cho frontmatter ở trên.

Mỗi artifact có bảng ở cuối file, **chỉ thêm dòng, không sửa dòng cũ**:

| Ngày | Ai | Phạm vi thay đổi | Mã yêu cầu / TC liên quan |
|---|---|---|---|
| 2026-09-28 | QA-H | Tạo case cho AC-01→AC-15 | TC-01→47 |
| 2026-10-02 | QA-H | Cập nhật kỳ vọng AC-16→AC-18 theo tài liệu mới | TC-48→55 |

File test case dùng bảng 3 cột `| Ngày | Ai | Thay đổi |` của template; khi đó cột `Thay đổi` phải gộp
đủ phạm vi + mã yêu cầu + khoảng mã TC, vd `Tạo case BR01→BR15, [G032_01]→[G032_47]`. Thiếu khoảng mã
TC thì dòng đó không dùng làm căn cứ ghi công được.

### 2.3. Quy tắc mã (để khoảng mã dùng được làm bằng chứng)

- Mã TC đánh liên tục, không nhảy số, không đánh lại số cũ cho case mới; bổ sung thì cấp mã mới ở cuối.
- **Mã yêu cầu phải ổn định.** Nếu tài liệu không đánh số sẵn thì QA tự đánh và giữ nguyên qua các version; đánh lại số làm mọi dòng point cũ mất chỗ trỏ.
- Yêu cầu bị bỏ theo version mới: giữ mã, đánh dấu bỏ kèm lý do, **không tính point lần nữa**.

### 2.4. Ownership

Xác định bằng `createdBy`/`updatedBy` (file test case: dòng `Người thiết kế · ngày`) + bảng lịch sử cập nhật.

- Sửa case sai của người khác: tính. Của chính mình: không tính.
- Hai người cùng làm một tính năng: chia theo **mã yêu cầu** mỗi người phụ trách, không chia phần trăm.

---

## 3. Bảng phụ — defect, automation, regression

| Nhóm | Đơn vị | Lưu ý |
|---|---|---|
| **Defect** | Một defect, theo **độ khó tái hiện** | Verify sau fix `S × E`, tối đa 2 vòng/defect. Gom nhiều biểu hiện cùng nguyên nhân thành một defect. Defect do kỳ vọng case sai, hoặc trùng defect đang mở: không tính |
| **Automation** | Một harness / một page-object / một nhóm test | Dựng harness mới `M × M` trở lên. Thêm test chỉ gọi helper có sẵn `S × E`. Retry hàng loạt che flaky: **không tính** + ghi nợ kỹ thuật. Cấu hình reporter/CI không phải đầu việc |
| **Regression** | Một lần có thay đổi thật trong suite | Chỉ đánh dấu lại trạng thái: không tính. Coverage release `S × M` nếu số liệu đếm được; **ước lượng thì không tính** |
| **Dựng môi trường/dữ liệu** | Một đợt dựng | Chỉ tách dòng khi nặng hơn việc chạy (viết script seed, xin quyền, phối hợp bên thứ ba). Dựng thông thường đã nằm trong Effort của dòng yêu cầu |

### Bảng point defect

| Loại defect | Size × Effort | Point |
|---|---|---|
| Hiện ngay khi chạy case, repro 3 bước | `S × E` | 0.05 |
| Cần dựng dữ liệu hoặc nhiều bước để tái hiện | `S × M` | 0.1 |
| Do đối chiếu tài liệu phát hiện lệch kết quả | `S × M` | 0.1 |
| Chỉ xảy ra khi race/timing, phải điều tra mới ra repro ổn định | `M × H` | 0.7 |

---

## 4. Ma trận point Size × Effort

| Size \ Effort | Easy (E) | Medium (M) | Hard (H) |
| --- | ---: | ---: | ---: |
| Small (S) | 0.05 | 0.1 | 0.25 |
| Medium (M) | 0.25 | 0.5 | 0.7 |
| Large (L) | 0.5 | 0.75 | 1 |

```text
Point task lớn = Tổng point các dòng yêu cầu + tổng point bảng phụ
```

> **Hiệu chỉnh thang:** ma trận này neo vào mốc **một tính năng cỡ trung bình ≈ 5 point** (người chấm
> xác nhận cho tính năng xác thực OTP). Đổi mốc thì phải đổi đồng thời ma trận, bảng defect (§3.6) và
> bảng hệ quy chiếu (§4.4) — không sửa riêng một chỗ.

### 4.1. Size của một BR

| Size | Khi nào |
|---|---|
| **S** | BR có **một loại kết quả quan sát được** (một phản hồi hoặc một trạng thái), dù có nhiều nhánh đầu vào |
| **M** | BR có **thang bậc / bộ đếm / vòng đời nhiều bước** · hoặc BR phải **giữ nhiều bất biến trên nhiều hệ thống** (API + dịch vụ ngoài + cache/DB) |
| **L** | **Không dùng cho một BR đơn lẻ.** Cần `L` nghĩa là mục đó thực chất là nhiều BR → bóc nhỏ |

Số case là hệ quả, không quyết định Size. Bảng phụ dùng Size theo phạm vi đầu việc.

### 4.2. Audit bắt buộc trước khi chọn ô

Không chấm từ tên yêu cầu. Với mỗi dòng ghi nhận:

1. **Nhánh phải phủ** — yêu cầu này đẻ ra mấy nhánh thật (thành công / biên / lỗi / trạng thái).
2. **Nguồn kỳ vọng** — tài liệu ghi thẳng, phải suy luận có căn cứ, hay tài liệu thiếu/mâu thuẫn.
3. **Mức kế thừa** — yêu cầu mới, hay mở rộng kỳ vọng đã chốt (chỉ tính delta).
4. **Dữ liệu/môi trường** — có phải dựng trạng thái đặc biệt để chạm được yêu cầu này không.
5. **Hậu quả nếu sót** — một màn hình, một luồng chính, hay tiền/dữ liệu/phân quyền/bảo mật.

### 4.3. Effort — ba trục

| Trục | Thấp | Trung bình | Cao |
|---|---|---|---|
| **Số nhánh của yêu cầu** | 1–2 nhánh | 3–5 nhánh (có biên, có lỗi) | trên 5 nhánh, hoặc sơ đồ trạng thái / bảng quyết định |
| **Độ khó suy luận** | kỳ vọng ghi thẳng trong tài liệu | phải suy luận có căn cứ từ mục khác | tài liệu thiếu hoặc **mâu thuẫn**, phải phát hiện rủi ro ẩn |
| **Sức ảnh hưởng** | một màn hình, sót lỗi ít hậu quả | một luồng chính | tiền, dữ liệu, phân quyền, bảo mật, hoặc luồng đã ship |

**Chọn mức:**

- **`E`** — kỳ vọng có sẵn, 1–2 nhánh. Phần lớn AC hiển thị/thông báo rơi vào đây → `S × E = 0.05`.
- **`M`** — ít nhất một trục ở mức trung bình: có giá trị biên, có mã lỗi phải đối chiếu, hoặc phải suy luận → `S × M = 0.1`.
- **`H`** — **độ khó suy luận cao** VÀ (**sức ảnh hưởng cao** HOẶC **số nhánh cao**): yêu cầu mà QA phải phát hiện mâu thuẫn tài liệu, rủi ro ẩn, hoặc phủ cả sơ đồ trạng thái / bảng quyết định → `S × H = 0.25`.

### 4.4. Mốc 1 point + hệ quy chiếu

**Mốc:** **một BR cỡ trung bình ≈ 0.5 point** — có vòng đời nhiều bước hoặc phải giữ nhiều bất biến trên
nhiều hệ thống, kỳ vọng ghi trong tài liệu, đã phân tích + thiết kế + chạy. BR đơn giản ≈ 0.1;
BR có thang bậc và phân kỳ hành vi ≈ 0.7.

| BR | Point thường gặp |
|---|---|
| Đơn giản, kỳ vọng ghi thẳng, ít nhánh | 0.05 |
| Vài nhánh/biên, hoặc phải đối chiếu mã lỗi | 0.1 |
| Bảo mật/toàn vẹn dữ liệu phải suy luận từ cơ chế, hoặc tài liệu thiếu | 0.25 |
| Nhiều bất biến trên nhiều hệ thống hoặc vòng đời nhiều bước, kỳ vọng ghi thẳng | 0.25 – 0.5 |
| Thang bậc / bộ đếm / phân kỳ hành vi / bảng quyết định | 0.5 – 0.7 |
| Một tính năng cỡ trung bình (15–20 BR) | khoảng 4 – 7 |
| Một tính năng lớn (30+ BR) | khoảng 8 – 12 |

Dòng nào vượt `0.5` thì cột `Lý do point` phải nói rõ BR đó khó hơn hoặc rộng hơn mốc ở chỗ nào.

---

## 5. Format bảng báo cáo

### 5.1. Bảng tổng hợp

| # | Task lớn | Phân loại | Số yêu cầu | Point yêu cầu | Point bảng phụ | Tổng point |
| ---: | --- | --- | ---: | ---: | ---: | ---: |
| 1 | QA tính năng &lt;tên&gt; | Tính năng | N | <a> | <b> | <a+b> |
| | **Tổng kỳ** | | **N** | **&lt;a&gt;** | **&lt;b&gt;** | **&lt;a+b&gt;** |

`Phân loại`: Tính năng · Cải tiến · Fix · Regression · Release.

> Rule KHÔNG chứa số point của kỳ cụ thể — số thật nằm ở `{wikiPath}/qa/point-reports/`.

### 5.2. Bảng A — yêu cầu (một dòng mỗi yêu cầu)

| # | Mã yêu cầu | Nguồn tài liệu | Nội dung yêu cầu | Case phủ | Trạng thái | Size | Effort | Point | Lý do point |
| ---: | --- | --- | --- | --- | --- | :---: | :---: | ---: | --- |
| 1 | `BR-10` | SRS §4, S2-09, S2-17 | Khóa đổi số theo bậc: chạm bậc vẫn gửi mã, khóa từ lần sau; chạm bậc cuối thì reset | `TC-17, 20, 26→35` | thiết kế xong — chờ build | M | H | 0.7 | Thang 3 bậc có reset (trạng thái nhiều bước); phân kỳ hành vi so với khóa nhập mã nên phải tách case riêng |

| Cột | Nội dung |
|---|---|
| `Mã yêu cầu` | `BR-xx` — QA tự đánh và giữ ổn định qua các version |
| `Nguồn tài liệu` | Mục/dòng trong tài liệu nguồn |
| `Nội dung yêu cầu` | Quy tắc BR phải kiểm, gồm các nhánh chính — không chép cả đoạn tài liệu |
| `Case phủ` | Khoảng mã TC phủ yêu cầu này |
| `Trạng thái` | `đã chạy` · `thiết kế xong — chờ build` · `mở rộng` |
| `Size` / `Effort` | `S`/`M` và `E`/`M`/`H` |
| `Point` | đúng một ô ma trận |
| `Lý do point` | ≥1 bằng chứng Size (bề mặt/phạm vi) + ≥1 bằng chứng Effort (số nhánh, độ khó suy luận) |

### 5.3. Bảng B — đầu việc không gắn một yêu cầu

| # | Nhóm | Task | Artifact | Mô tả & cách verify | Bằng chứng | Size | Effort | Point | Lý do point |
| ---: | --- | --- | --- | --- | --- | :---: | :---: | ---: | --- |

`Nhóm`: Defect · Automation · Regression · Dựng môi trường.

### 5.4. Hai mục bắt buộc kèm theo

- **Yêu cầu chưa chốt point** — mã yêu cầu + đang chờ gì (câu hỏi nào chưa trả lời, thiếu artifact gì).
- **Phần đã loại** — đầu việc bị loại + lý do, để người review không phải hỏi lại.

---

## 6. Chống cộng trùng

- **Một hành vi một dòng** — hành vi nằm ở BR nào thì chỉ tính ở đó; mỗi mã TC chỉ ở một dòng (§1.2).
- Không tách từng transition của một sơ đồ trạng thái thành nhiều dòng.
- Không tách một yêu cầu thành nhiều dòng theo loại case (thành công / biên / lỗi).
- Không chốt point hai lần cho một yêu cầu: lần thiết kế rồi lần chạy (§1.3).
- Không mở dòng mới cho yêu cầu cũ chỉ vì viết lại sang ngôn ngữ khác — bản diễn đạt lại không chấm lại yêu cầu.
- Mở rộng theo version tài liệu mới: dòng mới nhãn `mở rộng`, chỉ tính delta.
- Không tính cùng một yêu cầu ở cả bảng A và bảng phụ.
- Không tính automation như một lần chấm lại việc thiết kế case của cùng yêu cầu.
- Không tính lần chạy lặp khi không có build mới.
- Không tính các lần sửa theo review trong cùng lần bàn giao.

---

## Anti-patterns (NGHIÊM CẤM)

| Anti-pattern | Đúng |
|---|---|
| Mở dòng cho "luồng gửi mã thành công" hoặc "thao tác bật/tắt" | Không có dòng; chỉ tách BR nếu trong đó có quy tắc (§1.1) |
| Tách 8 transition của sơ đồ trạng thái thành 8 dòng | Một dòng cho cả sơ đồ, Effort `H` |
| Tách một BR thành 3 dòng: thành công / biên / lỗi | Một dòng; số nhánh đi vào Effort |
| Chấm 0.25 cho mọi BR vì "đều phải đọc tài liệu" | Mặc định là `S × E = 0.05`; nâng phải có lý do ở cột Lý do point |
| Chốt point kỳ thiết kế, kỳ sau chạy lại chốt lần nữa | Chốt một lần; kỳ sau chỉ ghi ngày chạy vào cùng dòng |
| Dòng yêu cầu chấm `L` | `L` không dùng cho một yêu cầu; nếu cần `L` thì mục đó là nhiều yêu cầu, phải bóc nhỏ |
| Mở dòng cho mục ngoài phạm vi test | OOS không tính, trừ khi QA phải viết case canh giữ |
| Đánh lại mã yêu cầu cho gọn | Mã phải ổn định qua các version, nếu không dòng point cũ mất chỗ trỏ |
| Nâng point vì lỗi severity blocker | Mức nghiêm trọng không nâng point; độ khó tái hiện mới nâng |
| Nhân point với % ownership (`1 × 85.7%`) | Đủ điều kiện tính thì giữ nguyên point |
| Lý do point ghi "nhiều case", "logic phức tạp" | Phải chỉ rõ số nhánh hoặc chỗ tài liệu thiếu/mâu thuẫn |
| Chấm point cho yêu cầu không trỏ được về tài liệu | Không mã nguồn → không dòng |

---

## Integration with other skills / agents

- `qa-test-design` — số nhánh của một yêu cầu suy ra từ kỹ thuật thiết kế (biên, lớp tương đương, bảng quyết định, chuyển trạng thái).
- `qa-test-types` — loại test và lane quyết định trục **sức ảnh hưởng**.
- `qa-defect` — severity/priority dùng để xếp ưu tiên xử lý, KHÔNG dùng nâng point.
- `qa-exit-criteria` — điều kiện sign-off, không liên quan tới point.
- `wiki/SCORING.md` — chấm chất lượng review; độc lập với point.
- `qa-test-case-writer` / `qa-test-executor` / `qa-bug-reporter` — sinh ra ma trận yêu cầu → case, test-run và defect dùng làm bằng chứng chấm point.

---

## Checklist

- [ ] Mọi dòng bảng A có mã yêu cầu trỏ được về mục/dòng tài liệu
- [ ] Mỗi mã TC chỉ xuất hiện ở một dòng (§1.2); luồng thuần và thao tác không chứa quy tắc không có dòng, quy tắc trong luồng đã được tách thành BR
- [ ] Case không có nguồn tài liệu không tạo dòng và không tự nâng point (trừ rủi ro suy ra từ cơ chế, có ghi rõ)
- [ ] Sơ đồ trạng thái tính một dòng, không tách transition
- [ ] Không yêu cầu nào bị tách theo loại case
- [ ] Mỗi dòng có `Case phủ` và `Trạng thái`
- [ ] Dòng `đã chạy` có evidence tồn tại thật
- [ ] Dòng `thiết kế xong — chờ build` nêu rõ chờ gì; kỳ sau không chấm lại
- [ ] Yêu cầu chờ trả lời câu hỏi nằm ở mục "chưa chốt point", không chốt bừa
- [ ] Không dòng nào dùng Size `L`
- [ ] Dòng vượt `0.5` có giải thích phạm vi rộng hơn một hành vi
- [ ] Defect / automation / regression ở bảng B, không lẫn vào bảng A
- [ ] Defect chấm theo độ khó tái hiện, không theo mức nghiêm trọng
- [ ] Bản diễn đạt lại không mở dòng mới cho yêu cầu đã chốt
- [ ] Mở rộng theo version mới dùng nhãn `mở rộng`, chỉ tính delta
- [ ] Artifact có đủ frontmatter ghi công + bảng lịch sử cập nhật
- [ ] Ownership không nhân phần trăm
- [ ] Tổng kỳ = tổng point bảng A + tổng point bảng B

---

## Related memory

- `feedback_don_vi_la_yeu_cau_trong_tai_lieu.md`
- `feedback_ac_bao_thi_br_khong_mo_dong_rieng.md`
- `feedback_chot_point_mot_lan_cho_moi_yeu_cau.md`
- `feedback_severity_khong_nang_point.md`
- `feedback_khong_dung_commit_lam_can_cu_point.md`
