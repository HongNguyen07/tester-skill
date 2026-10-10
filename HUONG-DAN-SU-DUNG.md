# Hướng dẫn sử dụng bộ skill QA (tester-skill)

> Tài liệu cho **team QA**. Đọc theo thứ tự các Bước 1 → 4 là dùng được. Phần 5–7 là tra cứu.

## Mục lục

1. [Bộ skill này là gì](#1-bộ-skill-này-là-gì)
2. [Chuẩn bị trước khi cài](#2-chuẩn-bị-trước-khi-cài)
3. [Bước 1 — Cài bộ skill vào máy](#3-bước-1--cài-bộ-skill-vào-máy)
4. [Bước 2 — Dựng khung QA cho project](#4-bước-2--dựng-khung-qa-cho-project)
5. [Bước 3 — Cấu hình project](#5-bước-3--cấu-hình-project)
6. [Bước 4 — Làm việc hằng ngày](#6-bước-4--làm-việc-hằng-ngày)
7. [Ý nghĩa từng skill](#7-ý-nghĩa-từng-skill)
8. [Ý nghĩa từng agent](#8-ý-nghĩa-từng-agent)
9. [File sinh ra nằm ở đâu](#9-file-sinh-ra-nằm-ở-đâu)
10. [Quy tắc cứng cần nhớ](#10-quy-tắc-cứng-cần-nhớ)
11. [Sự cố thường gặp](#11-sự-cố-thường-gặp)
12. [Lệnh nhanh](#12-lệnh-nhanh)

---

## 1. Bộ skill này là gì

Bộ công cụ cho **Claude Code** giúp QA làm việc theo một quy trình thống nhất: đọc tài liệu → thiết kế
test case → chạy test → ghi lỗi → chấm điểm → ký duyệt (sign-off).

Gồm 3 phần:

| Phần | Là gì | Cài ở đâu |
|---|---|---|
| **Skill** (10 cái, prefix `qa-`) | Bộ quy tắc/luật. Claude đọc để biết "làm đúng là thế nào" | `~/.claude/skills/` |
| **Agent** (12 cái, prefix `qa-`) | "Nhân viên" chuyên trách từng khâu (lập plan, viết case, chạy test, log bug…) | `~/.claude/agents/` |
| **Bộ qa-ai-agents** (`qa-flow` + 2 agent) | Luồng riêng đi từ tài liệu BA. Cài cùng installer, nhưng dùng tách biệt — xem [`HUONG-DAN-QA-AI-AGENTS.md`](HUONG-DAN-QA-AI-AGENTS.md) | `~/.claude/skills/qa-flow/`, `~/.claude/agents/` |
| **Project template** | Khung thư mục `wiki/qa/` + file mẫu (test case, test plan, test run, defect, báo cáo point) | Copy vào project ở Bước 2 |

**Ranh giới công việc:** QA làm test **black-box** (acceptance, system, E2E, regression, exploratory,
a11y, perf-smoke). Unit / integration / contract là việc của dev — QA **không** lặp lại.

**Cổng cuối:** một feature chỉ được coi là xong toàn cục khi QA đã ký duyệt
(`status.qa=done` và `milestones.qa.signedOff=true`).

**Hai cách dùng** (chọn ở Bước 4):

- **Cách A — Pipeline đầy đủ:** gõ `/qa-orchestrator`, hệ thống tự điều phối cả chuỗi. Cần wiki chung của
  team có sẵn file feature `FEAT-<NNN>.md`.
- **Cách B — Dùng lẻ từng skill:** chỉ cần tài liệu nguồn. Ví dụ "viết test case theo template 15 cột",
  "chấm point tháng này". Không cần FEAT.

---

## 2. Chuẩn bị trước khi cài

Tick đủ trước khi sang Bước 1.

### 2.1. Bắt buộc

- [ ] **Claude Code** đã cài và đăng nhập (CLI, hoặc extension VS Code). Kiểm tra: mở terminal gõ `claude --version`.
- [ ] **Git** (`git --version`). Orchestrator dùng git để pull wiki, claim feature và push kết quả.
- [ ] **Bộ source này** đã có trên máy: clone repo `tester-skill`, hoặc copy nguyên thư mục.
- [ ] **Tài liệu nguồn của feature** (SRS / tài liệu BA) — Claude chỉ viết case dựa trên tài liệu, không bịa.

### 2.2. Theo hệ điều hành

| Hệ điều hành | Cần thêm |
|---|---|
| **Windows** | PowerShell (có sẵn). Dùng `install.bat`. Muốn chạy `.sh` thì cần Git Bash |
| **Linux / macOS** | `bash` |

### 2.3. Tuỳ chọn

- [ ] **Node.js + npx** — nếu có, installer dùng `npx skills add` để cài. Không có thì installer tự copy tay, vẫn chạy bình thường.
- [ ] **Cursor** — thêm cờ `--with-cursor` / `-WithCursor` nếu team dùng cả Cursor.

### 2.4. Chỉ cần khi làm automation (Cách A, Phase 4–5)

Làm test thủ công thì **bỏ qua** mục này.

- [ ] **Playwright** (Node.js) — automation E2E web + a11y (axe-core)
- [ ] **Java + REST-assured** hoặc **Karate** — automation API
- [ ] Tài khoản + môi trường test (local / staging / uat) và dữ liệu test

### 2.5. Chỉ cần khi dùng Cách A (pipeline đầy đủ)

- [ ] **Wiki chung của team** là một git repo (BA/BE/FE/QA dùng chung), có thư mục `features/` với các `FEAT-<NNN>.md`.
- [ ] Có quyền **push** vào wiki repo (claim feature và ghi kết quả đều push).
- [ ] Feature cần test đã có Acceptance Criteria (AC/US). Thiếu AC thì orchestrator dừng và báo BA, không tự bịa.

---

## 3. Bước 1 — Cài bộ skill vào máy

Làm **một lần cho mỗi máy**. Làm lại mỗi khi bộ source có bản cập nhật.

### 3.1. Cài

Mở terminal tại thư mục `tester-skill`:

| Hệ điều hành | Lệnh |
|---|---|
| **Windows** | `install.bat` (double-click được) |
| **Linux / macOS / Git Bash** | `bash install.sh` |

Tuỳ chọn thêm:

| Mục đích | Windows | Linux / macOS |
|---|---|---|
| Xem trước, chưa cài | `install.bat -DryRun` | `bash install.sh --dry-run` |
| Cài thêm cho Cursor | `install.bat -WithCursor` | `bash install.sh --with-cursor` |
| Cài + dựng khung project luôn | `.\install.ps1 D:\duong-dan\project` | `bash install.sh /duong-dan/project` |

### 3.2. Installer làm gì (3 bước)

1. Copy 10 skill `qa-*` vào `~/.claude/skills/<tên>/SKILL.md` (để hiện trong menu `/` của Claude Code) và `~/.agents/skills/`. Riêng `qa-flow` copy cả thư mục (có `rules/`, `templates/`).
2. Copy 14 agent (12 `qa-*` + `qa-test-designer` + `cx-reviewer`) vào `~/.claude/agents/`.
3. Copy `qa-project-template` và `shared-wiki-template` vào `~/.claude/skills/` và `~/.agents/skills/`. Mẫu test case trong bản cài luôn lấy từ `qa-flow/templates/testcase-template.md`.

### 3.3. Kiểm tra đã cài đúng

1. **Đóng hẳn Claude Code rồi mở lại** (phiên đang mở không tự nhận skill mới).
2. Gõ `/qa` trong khung chat. Phải thấy `qa-orchestrator`, `qa-point-scoring`, `qa-test-case-writing`…
3. Hoặc kiểm bằng terminal:
   - Linux / macOS: `ls ~/.claude/skills | grep qa-` và `ls ~/.claude/agents | grep qa-`
   - Windows: `dir %USERPROFILE%\.claude\skills\qa-*` và `dir %USERPROFILE%\.claude\agents\qa-*`

Đủ khi thấy **11 skill** (10 `qa-*` + `qa-flow`) + **14 agent** (và thêm `qa-project-template`, `shared-wiki-template`).

> **Sửa rule ở đâu?** Sửa trong repo rồi chạy lại installer. Sửa thẳng trong `~/.claude/` sẽ bị ghi đè ở lần cài kế tiếp.

### 3.4. Cập nhật / gỡ

- **Cập nhật:** `git pull` trong repo `tester-skill` → chạy lại installer → mở lại Claude Code.
- **Gỡ:** `install.bat -Uninstall` hoặc `bash install.sh --uninstall`.

> Skill mới thêm gần đây (`qa-point-scoring`, `qa-test-case-writing`) chỉ có trên máy **sau khi chạy lại
> installer**. Máy cài từ trước mà không thấy hai skill này thì chạy lại là xong.

---

## 4. Bước 2 — Dựng khung QA cho project

Làm **một lần cho mỗi project**.

> ⚠️ **Đọc trước khi chạy.** Phần config gốc (`AGENTS.md`, `CLAUDE.md`, `.project-config.yml`) được giữ
> nguyên nếu đã tồn tại. Nhưng **phần `wiki/` sẽ bị ghi đè** các file trùng tên (như `BOARD.md`,
> `quality-trend.md`, `HARNESS_BACKLOG.md`, `GLOSSARY.md`, `memory/MEMORY.md`). Nếu project đã có wiki
> đang dùng: **commit hoặc backup `wiki/` trước**, rồi chạy xong dùng `git diff` để khôi phục những
> file bị đè ngoài ý muốn.

### 4.1. Chạy bootstrap

```bash
# Linux / macOS / Git Bash
bash ~/.claude/skills/qa-project-template/bootstrap.sh /duong-dan/project [ten-project]
```

```bat
:: Windows
%USERPROFILE%\.claude\skills\qa-project-template\bootstrap.bat D:\duong-dan\project [ten-project]
```

Không truyền tên project thì lấy tên thư mục.

### 4.2. Kết quả

```
project/
  .project-config.yml        # cấu hình QA (Bước 3)
  AGENTS.md  CLAUDE.md       # luật cho agent
  wiki/
    features/                # FEAT-<NNN>.md — xương sống BA → BE → FE → QA
    qa/
      test-plans/_template.md
      test-cases/_template.md      # template 15 cột
      test-runs/_template.md
      defects/_template.md
      point-reports/_template.md   # báo cáo point
      regression-suite/README.md
    QA_COVERAGE_MATRIX.md    # bảng phủ AC → case → kết quả (tự sinh)
    SCORING.md  RISK_LANES.md  quality-trend.md  GLOSSARY.md  HARNESS_BACKLOG.md
    memory/                  # ghi nhớ rút kinh nghiệm của project
```

---

## 5. Bước 3 — Cấu hình project

Mở `.project-config.yml` ở thư mục gốc project. Các mục cần rà:

| Mục | Ý nghĩa | Cần làm gì |
|---|---|---|
| `projectName` | Tên project | Đã tự điền |
| `wiki` | Đường dẫn wiki (mặc định `./wiki`) | Đổi nếu wiki nằm chỗ khác |
| `qa.automation.e2eWeb` | Công cụ E2E web | Giữ `playwright` |
| `qa.automation.apiBe` | Công cụ API | `rest-assured` hoặc `karate` |
| `qa.environments` | Môi trường test | Giữ/sửa `local / staging / uat` |
| `qa.exitCriteria` | Điều kiện ký duyệt | Mặc định: phủ 100% AC, 100% case blocking pass, 0 defect critical mở |
| `conventions` | Tiền tố mã | `TC-` (test case), `BUG-` (lỗi), `TP-` (test plan) |
| `hardGatesGlobal` | Vùng nhạy cảm | Chạm vào là tự coi rủi ro cao: auth, payment, data-integrity, cross-service-e2e, multi-tenant-isolation |

Dự án đã có `.project-config.yml` của BA/BE/FE thì **không bị ghi đè**. Khi đó nhờ Claude gộp khối `qa:`
vào file có sẵn.

---

## 6. Bước 4 — Làm việc hằng ngày

Mở Claude Code **tại thư mục gốc project** rồi chọn cách A hoặc B.

### Cách A — Pipeline đầy đủ với `/qa-orchestrator`

Dùng khi project có wiki + feature `FEAT-<NNN>`.

**Bước A1.** Gõ:

```
/qa-orchestrator
```

hoặc kèm mã feature: `/qa-orchestrator FEAT-042`.

**Bước A2.** Hệ thống `git pull` wiki, liệt kê các feature đang cần QA. Chọn một feature. Trạng thái cổng:

| Trạng thái | Nghĩa | Làm được gì |
|---|---|---|
| `status.ba=done` | BA xong, đã có AC | **Thiết kế test case** (làm sớm, song song với dev) |
| `be.done` + `fe.done` | Dev xong | **Chạy test** |

**Bước A3.** Hệ thống **claim** feature cho bạn và push ngay. Nếu đã có người claim trước, bạn được hỏi chọn feature khác.

**Bước A4.** Orchestrator đọc đúng tài liệu FEAT tham chiếu (AC/US ở mục 2, contract ở mục 3). Thiếu AC thì dừng và báo BA.

**Bước A5.** Pipeline chạy lần lượt (mỗi bước do một agent đảm nhiệm — xem [mục 8](#8-ý-nghĩa-từng-agent)):

| Phase | Việc | Bạn cần làm |
|---|---|---|
| 1 | Phân loại rủi ro (lane) | Nếu rủi ro cao thì được hỏi xác nhận |
| 2 | Lập test plan | Đọc lướt |
| 3 | Viết test case (Happy/Edge/Error, mỗi case trỏ về 1 AC) | **Duyệt** trước khi đi tiếp |
| 4 | Viết code automation (nếu cần) | Chọn case nào đáng tự động hoá |
| 5 | Chạy test + ghi bằng chứng | Chỉ chạy khi dev xong |
| 6 | Ghi lỗi `BUG-<NNN>`, trả về BE/FE | Xem lỗi |
| 7 | Cập nhật bộ regression | Theo từng release |
| 8 | Review + chấm điểm chất lượng | Nếu "block" thì quay lại Phase 3/5 |
| 9 | Cập nhật ma trận phủ, defect log, quality-trend | — |
| 10 | Commit + push, ký duyệt nếu đủ điều kiện | — |

**Bước A6.** Hệ thống dừng hỏi bạn khi: rủi ro cao · feature thiếu AC · muốn ký duyệt khi còn defect critical mở.

**Bước A7.** Kết thúc: feature được ký duyệt (`status.qa=done`, `signedOff=true`), hoặc lỗi được trả về BE/FE để sửa rồi test lại.

### Cách B — Dùng lẻ từng skill (không cần FEAT)

Gõ yêu cầu bằng tiếng Việt, **nêu tên skill** để Claude nạp đúng luật:

| Tình huống | Câu mẫu |
|---|---|
| Viết test case từ tài liệu | `Dùng qa-test-case-writing viết test case cho tài liệu tailieu/G032.md` |
| Soát lại file case có sẵn | `Dùng qa-test-case-writing kiểm tra file wiki/qa/test-cases/G032.md theo checklist tự kiểm` |
| Chuyển file case cũ sang mẫu mới | `Dùng qa-test-case-writing chuyển file case cũ này sang template 15 cột` |
| Nghĩ case bằng kỹ thuật chuẩn | `Dùng qa-test-design phân tích biên và lớp tương đương cho trường SĐT` |
| Bóc tài liệu thành danh sách BR + chấm point | `Dùng qa-point-scoring bóc tài liệu G032 thành danh sách BR và chấm point` |
| Review báo cáo point | `Dùng qa-point-scoring review báo cáo point tháng này` |
| Viết bug đúng chuẩn | `Dùng qa-defect viết bug từ mô tả này` |
| Viết test API / E2E | `Dùng qa-api-test …` / `Dùng qa-e2e-playwright …` |

Có thể gõ thẳng `/qa-point-scoring` hay `/qa-test-case-writing` trong menu `/`, rồi viết yêu cầu tiếp.

### Quy trình mẫu: một tài liệu mới → test case → point

1. Đặt tài liệu BA vào project (ví dụ `tailieu/`).
2. Gõ: `Dùng qa-test-case-writing viết test case cho tài liệu <tên file>`. Skill này ép dùng template 15 cột.
3. Kiểm tra file sinh ra ở `wiki/qa/test-cases/`: ô **Trace BR** có trống không, Round 1–3 có đều là `Todo`, case QA tự thêm có nằm ở **mục B** (không lẫn vào mục A), mục "Câu hỏi cần chốt" có gì, dòng `Người thiết kế · ngày` đã điền chưa.
4. Gửi các câu hỏi cần chốt cho BA. Case bị chặn bởi câu hỏi chưa trả lời thì chưa tính là đã phủ.
5. Chạy test thủ công, điền kết quả vào Round 1–3, `Error Code` (mã `BUG-…` khi Fail), `Date`, `Tester`.
6. Cuối kỳ gõ: `Dùng qa-point-scoring lập báo cáo point từ file test case`. Kết quả vào `wiki/qa/point-reports/`.

---

## 7. Ý nghĩa từng skill

10 skill = 1 cổng vào + 9 bộ luật. Gõ `/` trong Claude Code sẽ thấy tất cả.

| Skill | Dùng để làm gì | Dùng khi nào |
|---|---|---|
| **`qa-orchestrator`** | **Cổng vào chính.** Điều phối cả pipeline: lấy feature, claim, gọi lần lượt các agent. Bản thân nó **không** tự viết test hay tự chạy test | Cách A — làm feature theo quy trình đầy đủ |
| **`qa-test-case-writing`** | Luật **hình dạng** file test case theo **mẫu chuẩn của team (mẫu `qa-flow`)**: khối thông tin 6 dòng, Manual test theo Round, bảng 15 cột tách **nhóm A** (theo requirement) / **nhóm B** (QA bổ sung), câu hỏi cần chốt, thống kê, lịch sử cập nhật; cột **Trace BR** bắt buộc cho mọi case; checklist tự kiểm; cách chuyển file cũ sang mẫu mới. Dùng chung cho `/qa-flow` và `/qa-orchestrator` | Viết / sửa / soát / chuyển đổi test case trong `wiki/qa/test-cases/` hoặc `wiki/qa/features/<ID>/04-testcases.md` |
| **`qa-test-design`** | Luật **cách nghĩ ra case**: giá trị biên, lớp tương đương, decision table, state-transition, pairwise, error guessing → ra bộ Happy / Edge / Error | Cần nghĩ case cho một AC/BR |
| **`qa-point-scoring`** | Luật **bóc việc + chấm point** (0.05–1, ma trận Size × Effort). Đơn vị là **một Business Rule**, không tính theo số case hay số luồng. Không dùng commit làm căn cứ. Có bảng phụ cho defect / automation / regression | Lập báo cáo point, bóc tài liệu thành danh sách BR, review point của đồng nghiệp |
| **`qa-test-types`** | Phân định **test gì ở tầng nào**: dev giữ unit/integration/contract; QA giữ system/E2E/acceptance/regression/smoke/exploratory/a11y/perf-smoke | Lập test plan, quyết định có nên test thứ này không |
| **`qa-test-data`** | Quản lý dữ liệu test: dữ liệu cố định/lặp lại được, dọn dẹp sau test, cô lập tenant, **không dùng dữ liệu production**, che thông tin cá nhân (PII), chạy song song không đụng nhau | Chuẩn bị dữ liệu cho case / automation |
| **`qa-e2e-playwright`** | Luật viết automation **E2E web**: Page Object, selector `getByRole/getByTestId`, chờ tự động, quét a11y bằng axe-core, trace/screenshot làm bằng chứng, mỗi test trỏ về `TC-<FEAT>-NN` | Viết / review code Playwright |
| **`qa-api-test`** | Luật viết automation **API** (REST-assured / Karate): kiểm status + schema, token + cô lập tenant, đối chiếu contract của FEAT (endpoint, DTO, mã lỗi `ERR-<NNN>-xx`) | Viết / review test API |
| **`qa-defect`** | Luật **ghi lỗi**: vòng đời, severity vs priority, chuẩn repro tái hiện được, liên kết BUG ↔ FEAT/AC/TC/test-run, định tuyến BE/FE, chống ghi lỗi "phỏng đoán", phát hiện trùng | Viết / triage bug |
| **`qa-exit-criteria`** | Điều kiện **ký duyệt (Definition of Done)**: phủ 100% AC, 100% case blocking pass, 0 defect critical/blocker mở, đủ bằng chứng, qua cổng SCORING | Trước khi đặt `status.qa=done` |

**Phân biệt dễ nhầm:**

- `qa-test-case-writing` = case **trông như thế nào** · `qa-test-design` = **nghĩ ra** case thế nào.
- `qa-point-scoring` = chấm **khối lượng việc** (0.05–1) · `wiki/SCORING.md` = chấm **chất lượng** một lần review (0–100). Hai thứ khác nhau.
- Mức nghiêm trọng của lỗi (severity) **không** làm tăng point; chỉ độ khó tái hiện mới tăng.

---

## 8. Ý nghĩa từng agent

Agent do `qa-orchestrator` gọi. Bạn thường không gọi trực tiếp.

| Phase | Agent | Nhiệm vụ | Đầu ra |
|---|---|---|---|
| 1 | `qa-intake-classifier` | Kiểm feature có AC dùng được không; đánh giá rủi ro → chọn lane + độ sâu test | Kết quả phân loại |
| 2 | `qa-test-planner` | Lập test plan: phạm vi, loại test, môi trường, dữ liệu, điều kiện vào/ra | `qa/test-plans/TP-<FEAT>.md` |
| 3 | `qa-test-case-writer` | Viết case cho **mỗi AC** một bộ Happy / Edge / Error; case lỗi trích mã lỗi của contract | `qa/test-cases/<FEAT>.md` |
| 4 | `qa-automation-builder` | Viết code Playwright / REST-assured / Karate cho case đáng tự động hoá (không tự động hoá tất cả) | Code trong **repo test** |
| 5 | `qa-test-executor` | Chạy test thủ công + automation; mỗi kết quả kèm **bằng chứng** | `qa/test-runs/FEAT-<NNN>_<ngày>.md` |
| 6 | `qa-bug-reporter` | Mỗi lỗi tái hiện được → 1 file bug; giao BE/FE; lỗi chặn nghiệm thu → trả feature về `review` | `qa/defects/BUG-<NNN>.md` |
| 7 | `qa-regression-manager` | Duy trì bộ regression; báo coverage theo release (số liệu thật, không ước lượng) | `qa/regression-suite/` |
| 8 | `qa-reviewer` | **Bắt buộc.** Soát chất lượng artifact QA + chấm điểm chống bịa; chỉ đọc, không sửa | Điểm + báo cáo review |
| 9 | `qa-wiki-logger` | Đóng vòng: cập nhật ma trận phủ, defect log, quality-trend; đặt cờ ký duyệt khi đủ điều kiện | `QA_COVERAGE_MATRIX.md`… |
| 10 | `qa-git-committer` | Commit + push theo từng repo (test repo / wiki repo); không `--force` | Commit |
| — | `qa-initiative-builder` | Chia spec lớn (epic, release) thành các lát QA nhỏ | Ghi chú initiative |
| — | `qa-release-notes-builder` | Tổng hợp feature đã QA đạt thành báo cáo QA của release | `release/v<x.y.z>-qa.md` |

---

## 9. File sinh ra nằm ở đâu

| Loại | Đường dẫn | Ai ghi |
|---|---|---|
| Test plan | `wiki/qa/test-plans/TP-<FEAT>.md` | `qa-test-planner` |
| Test case | `wiki/qa/test-cases/<FEAT>.md` | `qa-test-case-writer`; tester điền Round / Error Code / Date / Tester |
| Kết quả chạy | `wiki/qa/test-runs/FEAT-<NNN>_<ngày>.md` | `qa-test-executor` |
| Lỗi | `wiki/qa/defects/BUG-<NNN>.md` | `qa-bug-reporter` |
| Bộ regression | `wiki/qa/regression-suite/` | `qa-regression-manager` |
| Báo cáo point | `wiki/qa/point-reports/` | Tester, theo `qa-point-scoring` |
| Ma trận phủ AC | `wiki/QA_COVERAGE_MATRIX.md` | `qa-wiki-logger` (file tự sinh — **đừng sửa tay**) |
| Điểm chất lượng review | `wiki/quality-trend.md` | `qa-reviewer` |
| Code automation | **Repo test** (không phải wiki) | `qa-automation-builder` |

---

## 10. Quy tắc cứng cần nhớ

1. **Không có nguồn thì không có test.** Mỗi case phải trỏ về một BR/AC thật trong tài liệu. Không bịa mã.
2. **Pass phải có bằng chứng** (screenshot / log / trace). Pass không bằng chứng coi như chưa chạy.
3. **Không đoán thay BA.** Tài liệu chưa rõ → ghi vào "Câu hỏi cần chốt", đánh `❓ Cần chốt: Q<n>`, không kết luận Pass/Fail bằng kỳ vọng tạm.
4. **Test case dùng đúng mẫu chuẩn (mẫu `qa-flow`) và đúng 15 cột**, không đổi tên, không đổi thứ tự, không thêm bớt. Case QA tự thêm ngoài tài liệu đặt ở **mục B**, không tính vào độ phủ. Người **viết** case không điền Pass/Fail. Lịch sử cập nhật phải nêu khoảng mã TC — thiếu thì không chấm point được.
5. **Cột `Error Code` là nơi ghi mã bug** khi Fail. Mã lỗi **kỳ vọng** thì ghi trong Expected Result (dòng `Mã lỗi kỳ vọng:`).
6. **Point tính theo Business Rule**, không theo số case, số luồng hay số lần chạy. Mỗi mã TC chỉ thuộc **một** BR. Một BR chốt point **một lần**.
7. **Không ký duyệt khi còn defect critical mở.**
8. **Luật cho orchestrator:** nó chỉ điều phối. Nếu thấy nó tự viết test hoặc tự khai "pass" mà không gọi agent nào là sai, yêu cầu làm lại.

---

## 11. Sự cố thường gặp

| Hiện tượng | Nguyên nhân thường gặp | Cách xử lý |
|---|---|---|
| Gõ `/qa` không thấy skill | Chưa mở lại Claude Code sau khi cài; hoặc installer lỗi | Đóng hẳn Claude Code, mở lại. Kiểm tra mục 3.3. Chạy lại installer |
| Không thấy `qa-point-scoring` / `qa-test-case-writing` | Máy cài từ bản cũ | `git pull` + chạy lại installer |
| Installer báo "npx not found" | Máy không có Node.js | Bình thường. Installer tự copy tay. Không cần xử lý |
| Orchestrator báo "agent chưa cài" | Thiếu file trong `~/.claude/agents/` | Chạy lại installer; kiểm tra 12 file `qa-*.md` |
| Orchestrator báo thiếu wiki / `QA_COVERAGE_MATRIX.md` | Chưa chạy bootstrap, hoặc mở Claude Code sai thư mục | Chạy Bước 2; mở Claude Code ở thư mục gốc project |
| Không có feature nào để chọn | Feature chưa đủ điều kiện (BA chưa `done`, hoặc đã có người claim) | Hỏi BA; kiểm `wiki/features/BOARD.md` |
| Claim bị push reject | Có người claim trước | Chọn feature khác khi được hỏi lại |
| Orchestrator dừng, báo thiếu AC | Feature chưa có Acceptance Criteria | Báo BA bổ sung. **Không** yêu cầu Claude tự viết AC |
| Bootstrap làm mất nội dung `BOARD.md`, `quality-trend.md`… | Bootstrap ghi đè file wiki trùng tên | Khôi phục bằng `git checkout -- <file>` rồi làm lại; lần sau commit trước khi bootstrap |
| `qa-reviewer` trả "block" | Case thiếu Trace, pass thiếu bằng chứng, kết quả mâu thuẫn tài liệu | Làm theo báo cáo review, sửa rồi chạy lại Phase 3/5 |
| Test case bị chê thiếu "Trace BR" | Ô Trace BR trống | Điền theo mục 3 của skill `qa-test-case-writing` (BR trước, mã phụ sau, ngăn bằng ` · `) |

---

## 12. Lệnh nhanh

```bash
# Cài / cập nhật (Linux, macOS, Git Bash)
cd tester-skill && git pull && bash install.sh

# Cài / cập nhật (Windows)
install.bat

# Dựng khung QA cho project
bash ~/.claude/skills/qa-project-template/bootstrap.sh /duong-dan/project
%USERPROFILE%\.claude\skills\qa-project-template\bootstrap.bat D:\duong-dan\project

# Gỡ
bash install.sh --uninstall
install.bat -Uninstall
```

Trong Claude Code:

| Gõ | Để làm gì |
|---|---|
| `/qa-orchestrator` | Chạy pipeline đầy đủ, chọn feature để làm |
| `/qa-orchestrator FEAT-042` | Chạy pipeline cho đúng feature đó |
| `/qa-test-case-writing` | Viết / soát test case theo template 15 cột |
| `/qa-point-scoring` | Bóc việc + chấm point |
| `/qa-test-design` · `/qa-defect` · `/qa-test-types` · `/qa-test-data` · `/qa-e2e-playwright` · `/qa-api-test` · `/qa-exit-criteria` | Nạp luật tương ứng |
