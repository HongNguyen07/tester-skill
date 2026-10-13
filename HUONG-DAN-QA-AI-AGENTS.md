# Hướng dẫn sử dụng bộ qa-ai-agents (`/qa-flow`)

> Tài liệu cho **team QA**. **Đây là luồng mặc định của team** — mọi feature mới đi theo luồng này.
> Làm theo Bước 1 → 5 là chạy được một feature. Phần 6 trở đi là tra cứu.
>
> Bộ này **khác** bộ `qa-*` / `/qa-orchestrator` (tuỳ chọn, chưa dùng — xem
> [`HUONG-DAN-SU-DUNG.md`](HUONG-DAN-SU-DUNG.md)). Hai bộ đứng riêng, **không gọi lẫn agent của hai bộ
> trong cùng một feature**.

## Mục lục

1. [Bộ này là gì, khi nào dùng](#1-bộ-này-là-gì-khi-nào-dùng)
2. [Chuẩn bị](#2-chuẩn-bị)
3. [Bước 1 — Cài vào máy](#3-bước-1--cài-vào-máy)
4. [Bước 2 — Chuẩn bị project và tài liệu](#4-bước-2--chuẩn-bị-project-và-tài-liệu)
5. [Bước 3 → 5 — Chạy một feature](#5-bước-3--5--chạy-một-feature)
6. [Sáu file đầu ra](#6-sáu-file-đầu-ra)
7. [Ý nghĩa từng thành phần](#7-ý-nghĩa-từng-thành-phần)
8. [Nhãn nội dung — đọc đầu ra cho đúng](#8-nhãn-nội-dung--đọc-đầu-ra-cho-đúng)
9. [Điểm trọng yếu và cổng Alignment](#9-điểm-trọng-yếu-và-cổng-alignment)
10. [CX Review: 3 mode, 4 loại finding](#10-cx-review-3-mode-4-loại-finding)
11. [Những điều AI sẽ không làm](#11-những-điều-ai-sẽ-không-làm)
12. [Tình huống thường gặp](#12-tình-huống-thường-gặp)
13. [Sự cố thường gặp](#13-sự-cố-thường-gặp)
14. [Câu mẫu nhanh](#14-câu-mẫu-nhanh)

---

## 1. Bộ này là gì, khi nào dùng

**qa-ai-agents** là quy trình QA đi từ **tài liệu BA** đến **bộ test case**, với nguyên tắc cốt lõi:

> **Hiểu đúng tài liệu trước, thiết kế test sau.** AI không được tự đoán nghiệp vụ.

Luồng tóm tắt:

```
Đọc tài liệu BA → Phân tích requirement → Câu hỏi gửi BA → Debate bạn ↔ Claude → BẠN mở "cổng"
      → Thiết kế test case  ┐
                            ├─ chạy song song → Unified QA Review
      → Review UI/UX/CX    ┘
```

### 1.1. So sánh hai bộ — chọn bộ nào

| | **`/qa-flow`** (bộ này) | **`/qa-orchestrator`** (bộ `qa-*`) |
|---|---|---|
| Đầu vào | **Tài liệu BA** (file trong `tailieu/`) | **FEAT-<NNN>.md** trong wiki chung của team |
| Cần wiki git của team? | **Không** | Có (pull / claim / push) |
| Làm rõ requirement với BA | **Có — bước Debate bắt buộc, có cổng chặn** | Không (thiếu AC thì báo BA) |
| Review UI/UX/CX | **Có** (`cx-reviewer`) | Không |
| Chạy test, ghi bug, ký duyệt | Chỉ rule, **chưa có agent** | Có đủ agent |
| Phù hợp khi | Nhận tài liệu mới, cần hiểu rõ trước khi viết case | Feature đã có FEAT, dev đã xong, cần chạy và ký duyệt |

**Team chọn `/qa-flow` làm luồng mặc định** cho mọi feature mới. Lý do: đầu vào của team là tài liệu BA trong
`tailieu/`, chưa có FEAT, chưa có wiki git chung với BA/BE/FE, và đang test thủ công. `/qa-orchestrator` là
tuỳ chọn, chỉ bật khi đủ ba thứ đó (chi tiết: [HUONG-DAN-SU-DUNG.md › Bắt đầu nhanh](HUONG-DAN-SU-DUNG.md#bắt-đầu-nhanh-5-phút)).

---

## 2. Chuẩn bị

Tick đủ trước khi sang Bước 1.

### 2.1. Bắt buộc

- [ ] **Claude Code** đã cài và đăng nhập (CLI hoặc extension VS Code). Kiểm tra: `claude --version`.
- [ ] **Tài liệu BA** của feature, dạng file văn bản (`.md`) để Claude đọc và trích dẫn được `tệp:dòng`.
- [ ] **Một thư mục project** để chứa tài liệu và kết quả (xem Bước 2).
- [ ] **Đường liên lạc với BA.** Bước Debate sinh ra câu hỏi; bạn là người gửi cho BA và mang câu trả lời về. AI không tự đóng được các điểm quan trọng.

### 2.2. Tuỳ chọn (cho CX Review)

- [ ] **UI design / prototype / user flow** — càng có càng cho review CX sâu. Không có thì CX chỉ review từ tài liệu (Mode 1).
- [ ] **Sản phẩm hoặc prototype truy cập được + công cụ thao tác** (browser tool…) — chỉ khi cần Mode 2 (mô phỏng khách hàng). Xem [mục 10](#10-cx-review-3-mode-4-loại-finding).

### 2.3. Không cần

- Không cần wiki git chung, không cần `FEAT-*.md`, không cần Playwright / Java.
- Không cần chạy `bootstrap` của bộ `qa-*`. Thư mục kết quả `wiki/qa/features/<ID>/` do Claude tự tạo.

---

## 3. Bước 1 — Cài vào máy

Làm **một lần cho mỗi máy**.

### 3.1. Bộ gồm 3 phần

| Phần | Gồm | Cài vào |
|---|---|---|
| **Skill `qa-flow`** | `SKILL.md` + `CLAUDE.md` + thư mục `rules/` (10 file) + thư mục `templates/` (7 file) | `~/.claude/skills/qa-flow/` |
| **Agent `qa-test-designer`** | `qa-test-designer.md` | `~/.claude/agents/` |
| **Agent `cx-reviewer`** | `cx-reviewer.md` | `~/.claude/agents/` |

Trên Windows, `~` là `%USERPROFILE%`.

### 3.2. Cài

Bộ này nằm **chung repo `tester-skill`** với bộ `qa-*` và được cài bằng **cùng một installer**. Chưa có repo
trên máy thì lấy về trước: `git clone https://github.com/HongNguyen07/tester-skill.git`. Rồi mở terminal
tại thư mục `tester-skill`:

| Hệ điều hành | Lệnh |
|---|---|
| **Windows** | `install.bat` (double-click được) |
| **Linux / macOS / Git Bash** | `bash install.sh` |

Installer copy **cả thư mục** `qa-flow/` (gồm `rules/` và `templates/`) vào `~/.claude/skills/qa-flow/`, và
2 file agent vào `~/.claude/agents/`. Đã cài bộ `qa-*` trước đó thì chạy lại installer là có thêm bộ này.

> **Sửa rule / template ở đâu?** Sửa trong repo (`tester-skill/qa-flow/…`) rồi chạy lại installer. Sửa thẳng
> trong `~/.claude/skills/qa-flow/` sẽ **bị ghi đè** ở lần cài kế tiếp. Quy trình gửi thay đổi cho team:
> [HUONG-DAN-SU-DUNG.md §13](HUONG-DAN-SU-DUNG.md#13-cùng-góp-sửa-rule-với-team).

### 3.3. Kiểm tra

1. **Đóng hẳn Claude Code, mở lại.**
2. Gõ `/qa-flow` trong khung chat — phải thấy skill này trong menu.
3. Kiểm file:
   - Linux / macOS: `ls ~/.claude/skills/qa-flow ~/.claude/agents | grep -E "qa-flow|qa-test-designer|cx-reviewer|rules|templates"`
   - Windows: `dir %USERPROFILE%\.claude\skills\qa-flow` và `dir %USERPROFILE%\.claude\agents\cx-reviewer.md`

Đủ khi có: `SKILL.md`, `CLAUDE.md`, `rules/` (01→10), `templates/` (7 file), và hai file agent.

### 3.4. Bộ `qa-*` được cài cùng lúc

Installer cài cả bộ `qa-*` (xem [`HUONG-DAN-SU-DUNG.md`](HUONG-DAN-SU-DUNG.md) §3). `qa-test-designer` đọc skill
`qa-test-case-writing` của bộ đó để theo đúng ý nghĩa 15 cột của team.

> **Một mẫu test case cho cả team.** Mẫu `qa-flow/templates/testcase-template.md` là mẫu chuẩn. Bộ `qa-*`
> dùng bản sao nguyên văn của nó (`project-template/wiki/qa/test-cases/_template.md`), nên file case ra từ
> `/qa-flow` và `/qa-orchestrator` có cùng hình dạng. Sửa mẫu thì sửa cả hai file.

---

## 4. Bước 2 — Chuẩn bị project và tài liệu

Làm **mỗi project một lần**; mỗi feature chỉ cần đặt tài liệu.

### 4.1. Cấu trúc thư mục

```
project/
  tailieu/                       # TÀI LIỆU BA — chỉ đọc, bạn tự đặt vào
    G032 - Đổi tên gợi nhớ.md
    …
  wiki/qa/
    features/<ID>/               # Claude tự tạo, mỗi feature một thư mục
      01-requirement-analysis.md
      02-alignment-summary.md
      03-test-design.md
      04-testcases.md
      05-cx-review.md
      06-unified-qa-review.md
      evidence/                  # chỉ khi CX chạy Mode 2
    knowledge/                   # kho tri thức đã xác nhận, tạo khi có mục đầu tiên
```

### 4.2. Cần làm

1. Tạo thư mục `tailieu/` ở gốc project, bỏ tài liệu BA vào. **Claude không sửa file trong `tailieu/`.**
2. **Một tài liệu có nhiều bản?** Giữ lại bản hiệu lực, hoặc chuẩn bị sẵn câu trả lời "bản nào hiệu lực" — Claude sẽ hỏi, không tự suy ra từ ngày sửa file.
3. Có UI design / prototype thì để sẵn đường dẫn để đưa cho CX.
4. Mở Claude Code **tại thư mục gốc project**.

> **Lưu ý tên file:** tên tiếng Việt có dấu từ máy khác có thể ở dạng Unicode NFD (Claude đọc trực tiếp bị lỗi).
> Agent đã được dặn tự tìm bằng Glob rồi đọc bằng Bash/Grep. Nếu vẫn báo "không đọc được file", đổi tên file
> sang dạng không dấu rồi chạy lại.

---

## 5. Bước 3 → 5 — Chạy một feature

Quy trình có 10 giai đoạn (S1–S10) chia thành 3 chặng. Gõ **một lệnh duy nhất** để bắt đầu:

```
/qa-flow G032
```

(`G032` là ID feature của bạn.) Không kèm ID thì Claude hỏi. Gọi lại lệnh này ở bất kỳ lúc nào để **tiếp tục**
từ chỗ dở: Claude đọc trạng thái trong `02-alignment-summary.md` và nói đang ở giai đoạn nào.

### Bước 3 — Hiểu requirement (S1 → S5)

Chạy trong hội thoại chính. **Chưa có test case nào ở chặng này.**

| GĐ | Claude làm | Bạn làm | Đầu ra |
|---|---|---|---|
| **S1** Khởi tạo | Hỏi tên/ID, mục tiêu, phạm vi (từng câu một). Tạo thư mục feature | Trả lời. Chỉ định tài liệu nguồn | Thư mục `wiki/qa/features/<ID>/` |
| **S2** Nạp nguồn | Đọc hết tài liệu trong phạm vi | Cung cấp tài liệu còn thiếu | — |
| **S3** Requirement Analysis | Trích requirement, actor, use case, business rule (BR), AC, mã lỗi, thông báo — **kèm `tệp:dòng`**. Liệt kê điểm chưa rõ | Đọc bảng "Điểm chưa rõ" | `01-requirement-analysis.md` |
| **S4a** Câu hỏi gửi BA | Với mỗi điểm chưa rõ, lập câu hỏi có trích dẫn + các cách hiểu **có căn cứ** + ảnh hưởng tới test. Đề xuất mức trọng yếu / không. Ghi thành file `cau-hoi-gui-BA.md` (bảng, có cột BA trả lời) | **Chốt mức trọng yếu / không trọng yếu. Gửi file cho BA. Mang câu trả lời về, nói rõ ai trả lời, ngày nào, kênh nào** | `cau-hoi-gui-BA.md`; bảng câu hỏi trong `02-alignment-summary.md` |
| **S4b** Debate bạn ↔ Claude | Tóm tắt nghiệp vụ theo từng nhóm BR, ghép câu trả lời BA vào, nêu cách Claude đọc từng chỗ còn có thể hiểu khác. **Bắt đầu ngay với nhóm không phụ thuộc BA** trong lúc chờ; nhóm còn chạm câu hỏi mở thì debate khi BA trả lời | Nói bạn đọc thế nào ở từng nhóm; lệch nhau thì chỉ chỗ trong tài liệu. Cả hai đều có căn cứ → nâng thành trọng yếu, hỏi BA | Mục 4 "Cách hiểu đã thống nhất" của `02-alignment-summary.md` (`[ĐÃ XÁC NHẬN]` có BA / `[GIẢ ĐỊNH]` chờ BA) |
| **S5** Xác nhận | Khi điểm trọng yếu còn mở = 0 **và đã debate xong các nhóm có điểm trọng yếu**, đề nghị bạn mở cổng | Đọc mục 2–8 của Summary, **nói rõ "đồng ý mở cổng"** | `02-alignment-summary.md` với `gate: open` |

**Mẹo S4:** file `cau-hoi-gui-BA.md` soạn sẵn để gửi BA điền thẳng vào cột "BA trả lời". Trong lúc chờ, bảo Claude
"debate nhóm không cần BA trước" — không ngồi chờ. Câu trả lời về thì dán vào phiên kèm tên người trả lời và ngày.

### Bước 4 — Thiết kế + CX song song (S6 → S8)

Chỉ bắt đầu khi **cổng đã mở** (xem [mục 9](#9-điểm-trọng-yếu-và-cổng-alignment)). Claude giao việc cho hai
agent trong **cùng một lượt**:

| GĐ | Agent | Làm gì | Đầu ra |
|---|---|---|---|
| **S6** | `qa-test-designer` | Use Case → BR → Decision Table → State Transition → Risk → Coverage Matrix → Scenario → Testcase (bảng 15 cột) → Regression Scope → Automation Candidate | `03-test-design.md`, `04-testcases.md` |
| **S7** | `cx-reviewer` | Review UI/UX/CX theo persona; phân loại finding | `05-cx-review.md` |
| **S8** | `qa-test-designer` | Coverage & Risk Review (mục 6–8 của `03-…`) | cập nhật `03-test-design.md` |

Bạn chờ. Nếu agent gặp điểm tài liệu **chưa rõ mới phát hiện**, nó không tự chọn cách hiểu — ghi vào mục
"Điểm cần quay lại Debate" và Claude đưa lại S4.

### Bước 5 — Hợp nhất và duyệt (S9 → S10)

| GĐ | Claude làm | Bạn làm | Đầu ra |
|---|---|---|---|
| **S9** Unified QA Review | Kiểm file có trên đĩa; kiểm nhanh ID trùng, số cột, Trace BR trống. Hợp nhất kết quả QA và CX (hai phần giữ riêng). Báo: đã làm gì, còn mở gì, cần quyết định gì | **Review. Quyết định các điểm ở mục 5 của `06-…`** | `06-unified-qa-review.md` |
| **S10** Thực thi | **Chỉ khi có môi trường + công cụ và bạn yêu cầu.** Chưa có agent riêng, chỉ có rule (`08-…`) | — | xem [mục 12](#12-tình-huống-thường-gặp) |

Sau S9, bộ `04-testcases.md` đã sẵn sàng để tester chạy thủ công (cột Round 1–3 đang là `Todo`).

---

## 6. Sáu file đầu ra

Tất cả nằm trong `wiki/qa/features/<ID>/`.

| File | Ai ghi | Nội dung | Đọc khi nào |
|---|---|---|---|
| `01-requirement-analysis.md` | Claude (chính) | Nguồn đã đọc, mục tiêu, actor, use case, BR, AC, mã lỗi, trạng thái, diễn giải/giả định, **điểm chưa rõ** | Muốn biết Claude hiểu tài liệu thế nào |
| `02-alignment-summary.md` | Claude (chính) + bạn | **Bảng câu hỏi debate**, cách hiểu đã xác nhận, điểm còn mở, nội dung gửi BA, đề xuất thay đổi, **trạng thái cổng** | Theo dõi tiến độ; mở cổng |
| `03-test-design.md` | `qa-test-designer` | Use case, BR, decision table, state transition, **rủi ro**, **coverage matrix**, scenario, regression scope, automation candidate | Review độ phủ và rủi ro |
| `04-testcases.md` | `qa-test-designer` | **Bảng 15 cột**: nhóm A (theo requirement) + nhóm B (QA bổ sung) + thống kê | Tester chạy case |
| `05-cx-review.md` | `cx-reviewer` | Persona, hành trình, finding (Defect / Usability Issue / CX Risk / Improvement Suggestion) | Gửi Product/UX |
| `06-unified-qa-review.md` | Claude (chính) | Hợp nhất QA + CX, điểm giao nhau, **việc cần người quyết định**, giới hạn lượt review | Họp tổng kết |

Khung đầu ra của từng file nằm ở `~/.claude/skills/qa-flow/templates/`.

---

## 7. Ý nghĩa từng thành phần

### 7.1. Các vai

| Vai | Chạy ở đâu | Việc |
|---|---|---|
| **Orchestrator** | Hội thoại chính (`qa-flow`) | Điều phối giai đoạn, giữ cổng, giao việc cho agent, hợp nhất kết quả |
| **Requirement Analyst** | Hội thoại chính | Trích requirement từ tài liệu (S3) |
| **Requirement Debate & Alignment** | Hội thoại chính (cần đối thoại với bạn) | Hỏi, làm rõ, ghi nhận câu trả lời của BA (S4–S5) |
| **QA Test Designer** | Agent `qa-test-designer` | Thiết kế test (S6, S8) |
| **Customer Experience Agent** | Agent `cx-reviewer` | Review trải nghiệm khách hàng (S7) |
| Risk & Coverage / Regression / Automation Candidate | Nằm trong `qa-test-designer` | Chưa tách agent riêng |
| Test Executor / Result Analyzer / Defect Analyst / AI Quality Evaluator | **Chưa có agent**, chỉ có rule | Chạy test, phân tích kết quả, ghi bug |

### 7.2. Hai agent

| Agent | Chỉ chạy khi | Ghi | KHÔNG làm |
|---|---|---|---|
| **`qa-test-designer`** | `gate: open` **và** `materialOpen: 0` | `03-…`, `04-…` | Tạo requirement; tự chọn cách hiểu điểm còn mở; chạy test; điền Pass/Fail; bịa mã lỗi/thông báo/endpoint |
| **`cx-reviewer`** | `gate: open` | `05-…` | Sửa requirement; nói "đã thao tác" khi chỉ đọc tài liệu; coi persona giả định là dữ liệu thật |

Gate đóng thì cả hai **dừng, không ghi file nào** và báo lại lý do.

### 7.3. Mười file rule (`rules/`)

Mỗi file là một bộ luật. Vai nào đọc file nào: xem bảng 7.1. Dưới đây là rule cốt lõi của từng file.

**`01-core-principles` — áp dụng cho mọi vai, mọi giai đoạn**
- 10 nguyên tắc: hiểu trước khi làm · debate để hiểu, không để sáng tạo · không kết luận thiếu căn cứ · truy vết từ thiết kế · bằng chứng hơn tự tin · con người quyết định khi mơ hồ/xung đột/rủi ro cao · tách requirement khỏi quan sát · tự rà soát trước khi bàn giao · **không giả vờ thực thi** · nhỏ, tách module.
- 8 nhãn nội dung bắt buộc, mỗi câu đúng một nhãn ([mục 8](#8-nhãn-nội-dung--đọc-đầu-ra-cho-đúng)). Chỉ `[NGUỒN]` và `[ĐÃ XÁC NHẬN]` được làm căn cứ expected result.
- Cấm: tự tạo BR/AC/hành vi · bịa mã lỗi, thông báo, field, endpoint, số liệu, persona · coi best practice là yêu cầu · tự giải quyết mâu thuẫn giữa hai nguồn · viết lại tài liệu BA như đã duyệt · tạo liên kết truy vết giả.
- Checklist tự rà soát: mọi `[NGUỒN]` mở ra được · không câu thiếu nhãn · không expected result dựa trên diễn giải/giả định · số liệu đếm lại, không ước · không câu "đã chạy" thiếu bằng chứng · ghi rõ phần chưa làm được.

**`02-qa-workflow` — thứ tự và điều kiện chuyển giai đoạn**
- Chuỗi: Requirement → Analysis → **Debate & Alignment** → Use Case → BR → Decision Table → State Transition → Risk → Coverage Matrix → Scenario → Testcase Summary → Testcase Detail → Regression Scope → Automation Candidate. CX chạy song song với Test Design sau khi cổng mở.
- Bắt đầu feature: hỏi từng câu (ID, mục tiêu, phạm vi), nhận tài liệu, tạo `wiki/qa/features/<ID>/`; đã có thì đọc trạng thái và tiếp tục.
- Điều kiện chuyển: S3→S4a khi `01-…` đủ nguồn + điểm chưa rõ · S4a→S4b ngay với nhóm không phụ thuộc BA, hoàn tất khi điểm trọng yếu mở = 0 · S4b→S5 khi mục 4 Summary có nội dung · S5→S6/S7 khi `gate: open` do bạn xác nhận · S6/S7→S9 khi cả hai agent đã ghi file · S9→S10 khi có môi trường + công cụ + bạn yêu cầu. Chưa đạt thì dừng, nói thiếu gì, **không làm tắt**.
- Trạng thái ghi ở frontmatter `02-alignment-summary.md`: `stage`, `gate`, `materialOpen`, `nonMaterialOpen`, `gateOpenedBy/At`.
- Quay lại: agent gặp điểm chưa rõ → không tự chọn, đưa về S4 · điểm trọng yếu mới → `gate: closed` cho phần bị ảnh hưởng · tài liệu đổi → cập nhật `01`, rà `02`, đánh dấu case · đề xuất UX không quay lại S4, ghi ở `05`.

**`03-requirement-analysis` — vai Requirement Analyst (S3)**
- Liệt kê nguồn đã đọc (tệp, version, phạm vi); phần chưa đọc ghi lý do.
- Trích kèm `tệp:dòng`: requirement, actor, precondition, trigger; main/alternate/exception flow; BR, data rule, permission, trạng thái; mã lỗi, thông báo, giới hạn số **nguyên văn**.
- Giữ mã gốc (BR01, AC-07…). Tài liệu không đánh mã → QA đánh `BR-xx`, ghi rõ là mã QA + vị trí gốc.
- Mỗi điểm thiếu / mơ hồ / mâu thuẫn / nhiều cách hiểu / dẫn chiếu treo → một dòng "Điểm chưa rõ", chuyển Debate.
- Cấm: thêm hành vi vì "nên như vậy" · biến best practice thành AC · tự giải quyết xung đột hai nguồn · kết luận "thiếu tài liệu" chỉ vì version dẫn chiếu không khớp (file trong `tailieu/` là bản hiện hành; lệch dẫn chiếu là câu hỏi cho BA).
- Một tài liệu nhiều bản → hỏi bạn bản nào hiệu lực, không suy từ ngày sửa file.

**`04-requirement-debate-alignment` — vai Debate (S4a → S4b → S5), bắt buộc trước Test Design**
- **Hai nửa:** S4a lập câu hỏi gửi BA (`cau-hoi-gui-BA.md`); S4b debate bạn ↔ Claude theo từng nhóm BR — bắt đầu ngay với nhóm không cần BA, phần còn lại khi BA trả lời. Kết quả ghi mục 4 "Cách hiểu đã thống nhất" của Summary; cổng chỉ mở khi mục này có nội dung.
- Mỗi điểm chưa rõ thành một câu hỏi đủ: nguồn trích dẫn · vì sao chưa rõ · các cách hiểu **có căn cứ** · ảnh hưởng tới case · cần ai xác nhận · mức trọng yếu (AI đề xuất, bạn chốt).
- Hỏi theo nhóm nhỏ, ưu tiên trọng yếu. Ghi câu trả lời kèm **ai trả lời · ngày · kênh**.
- **Ai đóng được điểm trọng yếu:** chỉ BA (hoặc Dev/Product đúng thẩm quyền), do bạn chuyển vào. Bạn nói "tôi nghĩ là…" → `[GIẢ ĐỊNH]`, điểm vẫn mở.
- **Trọng yếu** = cách hiểu khác nhau làm đổi hành vi nghiệp vụ, quyền, bảo mật, dữ liệu, hoặc điều kiện chấp nhận. Chỉ ảnh hưởng câu chữ/thứ tự → không trọng yếu, cô lập và đi tiếp.
- Ranh giới: câu hỏi phải neo vào tài liệu · tài liệu không đủ căn cứ → `Unresolved / BA Clarification Required` · không ép chọn phương án tài liệu không hỗ trợ · ý tưởng ngoài tài liệu → Change Proposal `[ĐỀ XUẤT THAY ĐỔI]` · bạn và tài liệu mâu thuẫn → chỉ ra, hỏi lại · BA trả lời đổi tài liệu → ghi `[ĐÃ XÁC NHẬN]` + "tài liệu chưa cập nhật", **không sửa `tailieu/`**.
- Đầu ra `02-alignment-summary.md` đủ 7 mục.

**`05-test-design` — vai QA Test Designer (S6)**
- Chỉ chạy khi `gate: open`; khác → dừng, không viết gì.
- Thứ tự: Use Case → BR (mỗi BR ghi trạng thái hiểu) → Decision Table (chỉ khi có logic điều kiện) → State Transition (chỉ khi có trạng thái) → Risk / Coverage / Regression / Automation Candidate → Scenario → Summary → Detail. Bước không áp dụng ghi "Không áp dụng — lý do", không bỏ trống.
- Coverage cân nhắc: Positive · Negative · Boundary/EP · Exception & recovery · Permission/security · Data integrity · Integration/API · Concurrency · UI/usability/a11y/compatibility · Performance (chỉ khi có SLA) · AI-specific (chỉ khi sản phẩm có AI). Là danh sách để cân nhắc, không phải requirement.
- Nguyên tắc case: một case một mục tiêu · đủ precondition/data/steps/expected để người khác chạy · group row theo BR · expected nghiệp vụ chỉ từ `[NGUỒN]` / `[ĐÃ XÁC NHẬN]`, chưa rõ ghi `❓ Cần chốt` · không bịa mã lỗi/thông báo/field/endpoint · case `❓` không tính là đã phủ.
- Bảng 15 cột theo `qa-test-case-writing`; Trace BR chỉ ghi BR/AC case thực sự kiểm; link UC/Scenario/Decision nằm ở Coverage Matrix.
- Hai nhóm tách riêng: **A theo requirement** (Trace BR bắt buộc là mã thật) · **B QA bổ sung** (đếm riêng, không cộng vào độ phủ, expected ghi "ĐO & GHI").
- Tự kiểm: mỗi BR có ≥1 case A hoặc lý do · không case A thiếu Trace BR · không ID trùng, Purpose không trùng hàng loạt, đủ 15 cột · số liệu đếm bằng script · điểm chưa rõ mới → liệt kê để quay lại Debate, không tự chọn.

**`06-customer-experience-agent` — vai CX (S7)**
- 3 mode: **1** UI/UX/CX review từ tài liệu/design (luôn làm trước; chưa quan sát → `[CX GIẢ THUYẾT]`) · **2** Customer Simulation chỉ khi có sản phẩm/prototype truy cập được **và** công cụ · **3** Journey Review end-to-end. Đầu file ghi mode + mức bằng chứng.
- Câu hỏi review: khách hiểu mục tiêu màn hình? nhãn/thuật ngữ/thông báo rõ? biết thành công/thất bại/đang xử lý? có bước thừa, điểm nhầm, nguy cơ bỏ dở? nhất quán giữa màn hình? tiếp cận, đọc, thao tác, khôi phục sau lỗi?
- Persona: nhiều persona theo nhóm khách; có căn cứ thì ghi tham chiếu, không thì ghi "persona giả thuyết phục vụ review"; không bịa nhân khẩu học.
- 4 loại finding: **Defect** chỉ khi có bằng chứng thực tế vi phạm requirement đã xác nhận · Usability Issue · CX Risk (chưa quan sát → "rủi ro giả định") · Improvement Suggestion (không phải requirement).
- Ranh giới: không sửa requirement/BR/AC · trải nghiệm kém nhưng đúng requirement ≠ Defect · câu hỏi về cách hiểu tài liệu → về Debate · "Expected vs observed" chỉ khi có căn cứ cả hai vế.

**`07-risk-coverage-regression` — trong `qa-test-designer`, mục 5–9 của `03-…`**
- Risk: đánh giá theo impact, likelihood, độ phức tạp, quyền, dữ liệu **khi có căn cứ**; không có thì ghi "chưa có dữ liệu", không tự cho điểm. Rủi ro là `[QA BỔ SUNG]`, không phải AC.
- Coverage Matrix: mỗi BR/AC một dòng; trạng thái **Đã phủ** (≥1 case A không `❓`) / **Phủ một phần** / **Chưa phủ** (chỉ case `❓` hoặc không có). Phải nêu 3 loại lỗ hổng: requirement không có case · case không có nguồn · coverage chưa rõ. Coverage bắt buộc và coverage QA bổ sung báo **riêng**.
- Regression Scope: từ thay đổi, dependency, lịch sử defect; mỗi khu vực ghi căn cứ + giới hạn; **không** khẳng định "không bị ảnh hưởng" khi thiếu dữ liệu — ghi "chưa đủ dữ liệu để loại trừ".
- Automation Candidate: theo độ ổn định, tần suất, giá trị regression, khả năng kiểm, chi phí bảo trì; mặc định `Candidate`; chỉ `Automated` khi có script + đường dẫn.

**`08-execution-defect-analysis` — chưa có agent, áp dụng cho vai nào được bạn yêu cầu (S10)**
- Executor: chỉ chạy khi có môi trường + công cụ + bạn yêu cầu; mỗi case ghi status, actual, evidence, môi trường, build, ngày, người; không đủ bằng chứng → không Pass/Fail; không chạy được → `Blocked`/`Not Executed` + lý do; không có công cụ → chỉ kế hoạch hoặc mô phỏng gắn nhãn; thao tác phá dữ liệu → dừng hỏi.
- Result Analyzer: số liệu đếm từ bản ghi thật; tách **quan sát** với **root cause đã xác minh**.
- Defect Analyst: repro, expected (kèm nguồn), actual, evidence, môi trường, impact; severity/priority chỉ **đề xuất**; hành vi không có requirement làm căn cứ → không phải defect.
- AI Quality Evaluator: chỉ khi sản phẩm có AI; tiêu chí phải khớp requirement và threat model, không tự đặt ngưỡng.

**`09-traceability-knowledge` — chuỗi truy vết và kho tri thức**
- Chuỗi tối thiểu: Requirement → UC → BR → Decision/State → Scenario → Testcase → Result → Defect; Requirement → Testcase → Automation Candidate → Status; CX: Source → Persona → Journey → Finding → Testcase/Defect → Decision. Không có liên kết → `N/A` / `Unlinked` + lý do, không tạo liên kết giả.
- Liên kết nằm ở đâu: `01` (REQ/UC/BR ↔ nguồn) · `02` (câu hỏi ↔ trả lời ↔ người xác nhận) · `03` Coverage Matrix · `04` cột Trace BR · `05` CX finding.
- Mã: giữ mã gốc; mã QA tự đánh ghi rõ và ổn định; `Q-<nn>`, `SC-<nn>`, `CX-<nn>`, `CP-<nn>`; mã đã được tham chiếu thì không đổi, mục bỏ thì đánh dấu, không tái dùng số.
- `wiki/qa/knowledge/` (product · requirements · test · defects · cx · decisions): chỉ nhập `[NGUỒN]` / `[ĐÃ XÁC NHẬN]` kèm nguồn + ngày; giả thuyết để mục "Chưa xác minh" riêng.

**`10-human-in-the-loop` — khi nào AI phải dừng hỏi bạn**
- Bắt buộc dừng khi: requirement mơ hồ/mâu thuẫn/thiếu trọng yếu · nhiều cách hiểu ảnh hưởng nghiệp vụ/quyền/bảo mật/dữ liệu · đề xuất đổi scope · rủi ro bảo mật/dữ liệu nhạy cảm · severity/root cause chưa đủ bằng chứng · chấp nhận rủi ro / release · hành động phá hủy · chuyển UX suggestion thành requirement · **mở cổng Alignment**.
- Khi dừng phải nêu 6 thứ: điểm chờ quyết định · nguồn/bằng chứng · vì sao không tự quyết · lựa chọn tài liệu hỗ trợ (không có thì nói không có) · ảnh hưởng nếu chưa giải quyết · ai cần xác nhận.
- Ai quyết: cách hiểu trọng yếu → BA · mở cổng → bạn · mức trọng yếu → AI đề xuất, bạn chốt · CX/CP thành requirement → Product/BA + nguồn phải cập nhật · severity/priority/root cause/release → người có thẩm quyền.
- Cách hỏi: theo hội thoại, nhóm nhỏ; không hỏi lại điều đã chốt; trong lúc chờ làm tiếp phần không phụ thuộc; đề xuất AI tự thêm gắn nhãn ĐỀ XUẤT.

### 7.4. Bảy mẫu (`templates/`)

`requirement-analysis-template` · `requirement-alignment-summary-template` · `test-scenario-template` (cho
`03-…`) · `testcase-template` (cho `04-…`) · `cx-review-template` · `cx-finding-template` ·
`unified-qa-review-template`.

### 7.5. Kho tri thức `wiki/qa/knowledge/`

Tạo khi có mục đầu tiên. Chỉ nhận nội dung **`[NGUỒN]` hoặc `[ĐÃ XÁC NHẬN]`**, kèm nguồn và ngày.

| File | Chứa |
|---|---|
| `product.md` | Chức năng, module, glossary đã xác nhận |
| `requirements.md` | Nguồn requirement, version, lịch sử thay đổi |
| `test.md` | Scenario, case, coverage, test data tái dùng |
| `defects.md` | Defect đã xác minh, pattern |
| `cx.md` | CX finding đã quan sát, quyết định của Product |
| `decisions.md` | Quyết định đã được người có thẩm quyền xác nhận (nội dung, ai, ngày, phạm vi) |

Giả thuyết, nhận định chưa xác minh, persona giả định **không** vào kho như dữ kiện.

---

## 8. Nhãn nội dung — đọc đầu ra cho đúng

Mọi nội dung quan trọng trong file đầu ra mang **đúng một nhãn**. Nhãn cho biết có được dùng làm căn cứ
expected result hay không.

| Nhãn | Nghĩa | Làm căn cứ expected result? |
|---|---|---|
| `[NGUỒN]` | Có trong tài liệu, kèm `tệp:dòng` | **Có** |
| `[ĐÃ XÁC NHẬN]` | BA/Dev/Product đã xác nhận, có ghi ai-ngày-kênh | **Có** |
| `[DIỄN GIẢI AI]` | AI diễn giải câu chữ, chưa ai xác nhận | Không |
| `[GIẢ ĐỊNH]` | Tạm coi là đúng để đi tiếp | Không |
| `[QA BỔ SUNG]` | Edge case / coverage QA tự đề xuất ngoài tài liệu | Không — kết quả ghi "ĐO & GHI" |
| `[CX GIẢ THUYẾT]` | Nhận định trải nghiệm chưa quan sát thực tế | Không |
| `[CẦN XÁC NHẬN]` | Câu hỏi đang chờ BA/Dev/Product | Không |
| `[ĐỀ XUẤT THAY ĐỔI]` | Ý tưởng mới ngoài tài liệu (Change Proposal) | Không |

Ngoài ra, trong `04-testcases.md`:

- `❓ Cần chốt: Q-<n>` ở cột Note = case còn chờ câu trả lời; **không tính là đã phủ**.
- **Nhóm A** = case theo requirement (Trace BR bắt buộc là mã BR/AC thật). **Nhóm B** = QA bổ sung/exploratory, **đếm riêng**, không cộng vào độ phủ requirement.

---

## 9. Điểm trọng yếu và cổng Alignment

### 9.1. Điểm trọng yếu

Một điểm chưa rõ là **trọng yếu** khi cách hiểu khác nhau làm đổi:

- hành vi nghiệp vụ (kết quả, luồng, điều kiện rẽ nhánh);
- quyền hạn / phân quyền;
- bảo mật;
- dữ liệu (lưu gì, đồng bộ gì, mất gì);
- điều kiện chấp nhận.

Chỉ ảnh hưởng câu chữ hiển thị hay thứ tự trình bày → **không trọng yếu**: được cô lập, đánh dấu và đi tiếp.

AI **đề xuất** mức, **bạn chốt**.

### 9.2. Ai đóng được điểm trọng yếu

- **Chỉ câu trả lời của BA** (hoặc Dev/Product đúng thẩm quyền), do bạn chuyển vào phiên.
- Ý kiến riêng của bạn hay của AI **không** đóng được. Bạn nói "tôi nghĩ là…" mà không nêu BA đã trả lời → ghi `[GIẢ ĐỊNH]`, điểm vẫn mở.
- Tài liệu không đủ căn cứ → ghi **Unresolved / BA Clarification Required**. Không suy diễn.

### 9.3. Điều kiện mở cổng (đủ cả ba)

Frontmatter của `02-alignment-summary.md`:

```yaml
gate: open          # chỉ BẠN mở
materialOpen: 0     # điểm trọng yếu còn mở phải bằng 0
```

và mục "Xác nhận mở cổng" có **câu xác nhận nguyên văn của bạn** (tên · ngày).

Thiếu một trong ba → không giao việc cho `qa-test-designer` / `cx-reviewer`. Claude nói rõ còn thiếu gì.

### 9.4. Bạn bảo "viết test case luôn" khi cổng đóng

Claude **từ chối bước đó**, nêu các điểm trọng yếu còn chờ BA, và đề nghị việc làm được ngay: soạn nội dung
gửi BA, tiếp tục xử lý điểm không trọng yếu.

### 9.5. Điểm trọng yếu mới phát sinh sau khi đã mở cổng

Cổng **đóng lại cho phần phạm vi bị ảnh hưởng**; phần còn lại giữ nguyên. Case liên quan đánh `❓ Cần chốt`.

---

## 10. CX Review: 3 mode, 4 loại finding

### 10.1. Ba mode

| Mode | Khi nào | Được ghi gì |
|---|---|---|
| **1. UI/UX/CX Review** | Luôn làm trước. Từ tài liệu / design / prototype tĩnh | Nhận định từ nguồn; phần chưa quan sát gắn `[CX GIẢ THUYẾT]` |
| **2. Customer Simulation** | **Chỉ khi** có sản phẩm/prototype truy cập được **và** công cụ được cấp quyền | Bước đã làm, phản hồi quan sát được, screenshot/log (lưu ở `evidence/`) |
| **3. Customer Journey Review** | Phạm vi là hành trình end-to-end | Mục tiêu → bước → phản hồi → kết quả cuối → cách phục hồi |

Đầu `05-cx-review.md` luôn ghi **mode đã chạy** và **mức bằng chứng**: `phân tích tài liệu` /
`mô phỏng bằng suy luận` / `tương tác thật có bằng chứng`. Không có công cụ thì CX **nói rõ không chạy Mode 2**.

### 10.2. Persona

- Có căn cứ trong nguồn → ghi tham chiếu.
- Không có căn cứ → ghi **"persona giả thuyết phục vụ review"**. Không bịa nhân khẩu học hay hành vi người dùng thật.

### 10.3. Bốn loại finding

| Loại | Điều kiện |
|---|---|
| **Defect** | Có **bằng chứng** hành vi thực tế vi phạm requirement **đã xác nhận** |
| **Usability Issue** | Vấn đề về hiểu, học, thao tác, hoàn thành nhiệm vụ |
| **CX Risk** | Nguy cơ mất niềm tin / bỏ dở / thất bại hành trình; chưa quan sát thì ghi "rủi ro giả định" |
| **Improvement Suggestion** | Đề xuất cải thiện; **không** phải requirement, **không** phải defect |

Chỉ đọc tài liệu/design thì **không được** phân loại Defect. Nghi vi phạm requirement → ghi nguồn,
chuyển QA xác minh (mục "Chuyển cho QA").

---

## 11. Những điều AI sẽ không làm

Biết trước để không bất ngờ, và để phát hiện khi AI vi phạm.

| AI **không** | Thay vào đó |
|---|---|
| Tự tạo requirement, BR, AC, hành vi sản phẩm | Ghi `[ĐỀ XUẤT THAY ĐỔI]` nếu bạn muốn theo dõi ý tưởng |
| Bịa mã lỗi, thông báo, tên field, endpoint, số liệu, persona | Ghi nguyên văn từ nguồn; không có thì "tài liệu không nói" |
| Tự chọn cách hiểu cho điểm chưa rõ | Hỏi bạn → BA |
| Tự giải quyết mâu thuẫn giữa hai nguồn, hoặc giữa bạn và tài liệu | Nêu cả hai phía, hỏi xác nhận |
| Tự mở cổng Alignment | Chờ câu xác nhận của bạn |
| Sửa file trong `tailieu/` | BA trả lời đổi nội dung → ghi `[ĐÃ XÁC NHẬN]` + "tài liệu chưa cập nhật" |
| Ghi "đã chạy / pass / đã quan sát" khi không có hành động và bằng chứng | Ghi "mô phỏng, chưa thực thi" |
| Điền Pass/Fail khi *thiết kế* case | Round 1–3 luôn `Todo` |
| Ghi `Automated` khi không có script | Mặc định `Candidate` |
| Coi best practice / ý tưởng UX là yêu cầu chính thức | Đưa vào Improvement Suggestion |

**AI phải dừng hỏi bạn** (rule `10-…`) khi: requirement mơ hồ/mâu thuẫn · nhiều cách hiểu ảnh hưởng
nghiệp vụ/quyền/bảo mật/dữ liệu · đề xuất đổi phạm vi · rủi ro bảo mật · severity/root cause chưa đủ bằng
chứng · quyết định release · thao tác phá dữ liệu · biến UX suggestion thành requirement · mở cổng.

Khi dừng, Claude nêu: điểm chờ quyết định · nguồn · vì sao không tự quyết · lựa chọn tài liệu hỗ trợ · ảnh
hưởng nếu chưa giải quyết · ai cần xác nhận.

---

## 12. Tình huống thường gặp

### 12.1. Tiếp tục feature đang làm dở

Gõ lại `/qa-flow <ID>`. Claude đọc trạng thái trong `02-alignment-summary.md` (`stage`, `gate`, `materialOpen`)
và nói đang ở giai đoạn nào rồi làm tiếp.

### 12.2. Tài liệu BA đổi sau khi đã thiết kế case

Báo Claude. Claude cập nhật `01-…`, rà lại `02-…`, đánh dấu case bị ảnh hưởng. Nếu sự thay đổi tạo điểm
trọng yếu mới → cổng đóng lại cho phần bị ảnh hưởng.

### 12.3. BA trả lời, bạn muốn ghi vào

Nói: *"BA Lan trả lời Q-03 là … (chat nhóm, hôm nay)."* Claude ghi `[ĐÃ XÁC NHẬN]` kèm ai/ngày/kênh vào
`02-…`. Nếu BA bảo đổi tài liệu, Claude ghi "tài liệu chưa cập nhật" — **bạn** nhắc BA cập nhật `tailieu/`.

### 12.4. Muốn thêm ý tưởng ngoài tài liệu

Nói ý tưởng. Claude hỏi có muốn theo dõi không; nếu có, ghi vào mục **Change Proposal** (`CP-<nn>`) với nhãn
`[ĐỀ XUẤT THAY ĐỔI]`. Nó **không** thành requirement và **không** sinh case nhóm A.

### 12.5. Muốn chạy test

Chưa có agent thực thi trong bộ này. Có hai hướng:

- **Chạy thủ công** từ `04-testcases.md`, điền Round 1–3, `Error Code` (mã bug khi Fail), `Date`, `Tester`.
- Yêu cầu Claude chạy theo rule `08-…`: chỉ khi **có môi trường + công cụ + bạn yêu cầu**; mỗi case ghi status, actual result, evidence, môi trường, build, ngày, người. Không đủ bằng chứng → không ghi Pass/Fail.

### 12.6. Cần chấm point cho công việc này

Dùng bộ `qa-*`: skill `qa-point-scoring`. Mã BR trong cột **Trace BR** của `04-testcases.md` chính là đơn vị
tính point (xem [`HUONG-DAN-SU-DUNG.md`](HUONG-DAN-SU-DUNG.md) §7).

---

## 13. Sự cố thường gặp

| Hiện tượng | Nguyên nhân thường gặp | Cách xử lý |
|---|---|---|
| Gõ `/qa-flow` không thấy | Chưa mở lại Claude Code, hoặc máy cài từ bản repo cũ (chưa có `qa-flow`) | `git pull` + chạy lại installer; đóng hẳn Claude Code, mở lại |
| Claude báo thiếu `rules/` hoặc `templates/` | Bản cài cũ / copy tay thiếu | Chạy lại installer (nó copy cả thư mục) |
| Báo "chưa cài `qa-test-designer` / `cx-reviewer`" | Thiếu file trong `~/.claude/agents/` | Chạy lại installer |
| Claude từ chối viết test case | Cổng đóng (`gate: closed` hoặc `materialOpen` > 0) | Đúng thiết kế. Lấy câu trả lời BA cho các điểm trọng yếu, rồi mở cổng |
| Agent trả về, không ghi file | Cổng chưa mở hoặc agent bị chặn | Đọc báo cáo của agent — nó nêu lý do. Kiểm `02-…` |
| "Không đọc được file trong `tailieu/`" | Tên file Unicode NFD | Để Claude dùng Glob + Bash/Grep; hoặc đổi tên file không dấu |
| Claude hỏi "bản nào hiệu lực" | Tài liệu có nhiều bản | Chỉ rõ bản hiệu lực. Claude không tự suy từ ngày sửa file |
| Tài liệu dẫn chiếu mã/version không khớp | Tài liệu BA tham chiếu mục không tồn tại | Không phải "thiếu tài liệu". File trong `tailieu/` là bản hiện hành; Claude ghi thành câu hỏi cho BA |
| Case có `❓ Cần chốt`, thống kê "BR đã phủ" thấp | Case chờ trả lời không tính là đã phủ | Chốt câu hỏi liên quan → Claude cập nhật |
| CX review không có Defect nào | Chỉ có tài liệu, không có sản phẩm để quan sát | Đúng thiết kế. Có sản phẩm + công cụ thì yêu cầu Mode 2 |
| Muốn dùng `/qa-orchestrator` cho feature đang làm bằng `/qa-flow` | Hai bộ đứng riêng | Không gọi lẫn trong cùng một feature. Chọn một bộ |

---

## 14. Câu mẫu nhanh

| Mục đích | Gõ |
|---|---|
| Bắt đầu / tiếp tục feature | `/qa-flow G032` |
| Xem đang ở đâu | `/qa-flow G032` (Claude tự nói giai đoạn hiện tại) |
| Ghi câu trả lời của BA | `BA Lan trả lời Q-03: <nội dung>, qua chat nhóm hôm nay` |
| Chốt mức trọng yếu | `Q-05 là không trọng yếu, cô lập và đi tiếp` |
| Mở cổng | `Tôi đã đọc mục 2–8 của alignment summary, đồng ý mở cổng` |
| Soạn nội dung gửi BA | `Soạn các câu hỏi trọng yếu để gửi BA` |
| Ghi ý tưởng ngoài tài liệu | `Ghi vào Change Proposal: <ý tưởng>` |
| Hỏi riêng CX có UI design | `Review CX thêm cho design này: <đường dẫn>` |
| Yêu cầu chạy test | `Chạy case [G032_01]→[G032_10] trên <môi trường>` *(chỉ khi có công cụ)* |
