# Hướng dẫn sử dụng bộ skill QA (tester-skill)

> Tài liệu cho **team QA**. Đọc theo thứ tự các Bước 1 → 4 là dùng được. Phần 7 trở đi là tra cứu.
> Muốn cùng sửa rule với team: xem [mục 13](#13-cùng-góp-sửa-rule-với-team).

**Repo:** <https://github.com/HongNguyen07/tester-skill>

## Bắt đầu nhanh (5 phút)

```bash
# 1. Lấy bộ skill về máy (một lần)
git clone https://github.com/HongNguyen07/tester-skill.git
cd tester-skill

# 2. Cài vào Claude Code
bash install.sh          # Linux / macOS / Git Bash
install.bat              # Windows: double-click cũng được

# 3. Đóng hẳn Claude Code, mở lại, gõ "/qa" để kiểm tra thấy skill
```

Rồi chọn một trong hai cách làm việc:

| Bạn đang có | Dùng | Hướng dẫn |
|---|---|---|
| **Tài liệu BA** (file `.md` trong `tailieu/`), chưa có FEAT | `/qa-flow <ID>` | [HUONG-DAN-QA-AI-AGENTS.md](HUONG-DAN-QA-AI-AGENTS.md) |
| **Feature `FEAT-<NNN>.md`** trong wiki chung của team, dev đã/đang làm | `/qa-orchestrator` | File này, [Bước 4](#6-bước-4--làm-việc-hằng-ngày) |

Hai bộ dùng **chung một mẫu test case** nhưng **không gọi lẫn nhau** trong cùng một feature.

## Mục lục

1. [Bộ skill này là gì](#1-bộ-skill-này-là-gì)
2. [Chuẩn bị trước khi cài](#2-chuẩn-bị-trước-khi-cài)
3. [Bước 1 — Cài bộ skill vào máy](#3-bước-1--cài-bộ-skill-vào-máy)
4. [Bước 2 — Dựng khung QA cho project](#4-bước-2--dựng-khung-qa-cho-project)
5. [Bước 3 — Cấu hình project](#5-bước-3--cấu-hình-project)
6. [Bước 4 — Làm việc hằng ngày](#6-bước-4--làm-việc-hằng-ngày)
7. [Tham chiếu skill ↔ agent ↔ rule](#7-tham-chiếu-skill--agent--rule)
8. [Từng agent: nhận gì, nạp gì, ghi gì, không làm gì](#8-từng-agent-nhận-gì-nạp-gì-ghi-gì-không-làm-gì)
9. [File sinh ra nằm ở đâu](#9-file-sinh-ra-nằm-ở-đâu)
10. [Quy tắc cứng cần nhớ](#10-quy-tắc-cứng-cần-nhớ)
11. [Sự cố thường gặp](#11-sự-cố-thường-gặp)
12. [Lệnh nhanh](#12-lệnh-nhanh)
13. [Cùng góp sửa rule với team](#13-cùng-góp-sửa-rule-với-team)

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
- [ ] **Bộ source này** đã có trên máy: `git clone https://github.com/HongNguyen07/tester-skill.git` (cần quyền xem repo — chưa có thì xin người quản lý repo thêm bạn vào).
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

- **Cập nhật:** `git pull` trong repo `tester-skill` → chạy lại installer → mở lại Claude Code. Khi có người báo "đã sửa rule" trong nhóm, mọi người làm bước này để máy ai cũng chạy cùng một bộ luật.
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

**Bước A5.** Pipeline chạy lần lượt (mỗi bước do một agent đảm nhiệm — xem [mục 8](#8-từng-agent-nhận-gì-nạp-gì-ghi-gì-không-làm-gì)):

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

## 7. Tham chiếu skill ↔ agent ↔ rule

Cách đọc mục này:

- **Skill** = một bộ luật (file `.md`). Claude nạp nó vào trước khi làm việc. Skill **không tự chạy**.
- **Agent** = "người" thực thi một khâu. Agent nạp skill để biết luật, rồi đọc input và ghi file.
- Hai skill đặc biệt là **điều phối** (`qa-orchestrator`, `qa-flow`): chúng gọi agent. 9 skill còn lại là **luật thuần**, không gọi ai.

### 7.1. Ai gọi ai

```
BẠN gõ  /qa-orchestrator [FEAT-NNN]            BẠN gõ  /qa-flow <ID>
            │                                              │
            ▼                                              ▼
   qa-orchestrator  (skill điều phối)              qa-flow  (skill điều phối;
   KHÔNG tự viết/chạy test                         tự làm S1–S5 và S9 trong hội thoại chính)
            │  dispatch theo phase                         │  dispatch CHỈ KHI gate: open
            ├─ P1   qa-intake-classifier                   ├─ S6, S8  qa-test-designer
            ├─ P2   qa-test-planner                        └─ S7      cx-reviewer
            ├─ P3   qa-test-case-writer        ⏸ bạn duyệt
            ├─ P4   qa-automation-builder                  Hai agent này đọc luật ở
            ├─ P5   qa-test-executor           [gate dev]  ~/.claude/skills/qa-flow/rules/ + templates/
            ├─ P6   qa-bug-reporter                        qa-test-designer đọc thêm qa-test-case-writing
            ├─ P7   qa-regression-manager
            ├─ P8   qa-reviewer                MANDATORY
            ├─ P9   qa-wiki-logger
            └─ P10  qa-git-committer
            (ngoài chuỗi: qa-initiative-builder, qa-release-notes-builder)

9 skill luật: qa-test-case-writing · qa-test-design · qa-point-scoring · qa-test-types · qa-test-data ·
qa-e2e-playwright · qa-api-test · qa-defect · qa-exit-criteria
→ được agent nạp (bảng 7.2), hoặc bạn gõ /<tên-skill> khi làm lẻ (Cách B).
```

### 7.2. Agent nào nạp skill nào

| Agent | Skill nạp | Để làm gì |
|---|---|---|
| `qa-intake-classifier` | `qa-test-types`, `qa-test-design`, `qa-defect`, `qa-exit-criteria` (luôn); `qa-e2e-playwright` (có e2e/a11y); `qa-api-test` (có contract/API); `qa-test-data` (multi-tenant / data-integrity) | Chấm lane rủi ro, rồi **đề xuất** cho các phase sau nên nạp skill nào — không nạp hết |
| `qa-test-planner` | `qa-test-types`, `qa-test-design`; ngưỡng từ `.project-config.yml` (theo `qa-exit-criteria`) | Chọn tầng test, ước lượng coverage, điền entry/exit |
| `qa-test-case-writer` | `qa-test-case-writing`, `qa-test-design`, `qa-test-data`, `qa-point-scoring` | Hình dạng file · kỹ thuật nghĩ case · dữ liệu biên · đánh mã `BR-xx` khi tài liệu không có |
| `qa-automation-builder` | `qa-e2e-playwright`, `qa-api-test`, `qa-test-data`, `qa-test-case-writing` | Sinh code Playwright / REST-assured / Karate; đọc case 15 cột để trace `TC` |
| `qa-test-executor` | `qa-e2e-playwright`, `qa-api-test`, `qa-test-data`, `qa-test-case-writing` | Biết evidence nào là hợp lệ; chạy; ghi test-run |
| `qa-bug-reporter` | `qa-defect` | Ghi `BUG-<NNN>`, định tuyến BE/FE |
| `qa-regression-manager` | — (theo `regression-suite/README.md`) | Duy trì suite, báo coverage |
| `qa-reviewer` | `qa-test-case-writing`, `qa-exit-criteria`, `wiki/SCORING.md` | Soát hình dạng case; chấm điểm chống bịa; trả gate |
| `qa-wiki-logger` | `qa-exit-criteria` | Quyết định có đặt cờ ký duyệt không |
| `qa-git-committer` | — | Commit/push |
| `qa-initiative-builder`, `qa-release-notes-builder` | — | Chia lát / tổng hợp release |
| `qa-test-designer` (bộ qa-flow) | `qa-flow/rules/01, 05, 07, 09` + `templates/`; `qa-test-case-writing` | Thiết kế test theo mẫu chuẩn |
| `cx-reviewer` (bộ qa-flow) | `qa-flow/rules/01, 06, 09` + `templates/` | Review CX |

### 7.3. Rule trong từng skill

Mỗi skill có nhiều mục; dưới đây là **rule cốt lõi** — thứ Claude sẽ bám và `qa-reviewer` sẽ chấm. Muốn
đọc đủ: mở `~/.claude/skills/<tên>/SKILL.md`.

#### `qa-orchestrator` — điều phối pipeline từ FEAT

- **Gọi agent:** 10 agent P1→P10 (+2 ngoài chuỗi), theo sơ đồ 7.1.
- **Rule cứng nhất:** main agent **chỉ được** đọc context, hiện form/TODO, hỏi bạn, dispatch agent, tổng hợp. **Tuyệt đối không** tự Write/Edit test plan / case / run / defect / automation / `QA_COVERAGE_MATRIX` / `quality-trend`, không tự chạy test rồi khai "pass". Trước khi trả kết quả phải đếm số lần gọi Agent; = 0 mà có output QA → vi phạm, làm lại.
- **Ngoại lệ được tự làm:** health check wiki (copy file thiếu từ template), trả lời câu hỏi ngữ cảnh (chỉ đọc), hoặc bạn chỉ định rõ.
- **Gate:** test-design (P2–P3) chạy khi `status.ba=done`; execution (P5) chỉ khi `be.done + fe.done`; sign-off chỉ khi AC 100% + blocking pass 100% + 0 critical mở.
- **Phải dừng hỏi bạn khi:** lane high-risk / chạm hard gate (auth, payment, data-integrity, cross-service-e2e, multi-tenant); FEAT thiếu AC (báo BA, không bịa); muốn sign-off khi còn defect critical.
- **Anti-hallucination (chấm ở `qa-reviewer`):** no test without AC-source · pass phải có evidence · kết quả mâu thuẫn spec hoặc flaky = cờ đỏ.

#### `qa-test-case-writing` — hình dạng file test case (mẫu chuẩn = mẫu `qa-flow`)

- **Agent dùng:** `qa-test-case-writer` (viết), `qa-reviewer` (soát), `qa-test-designer` (bộ qa-flow), `qa-automation-builder` / `qa-test-executor` (đọc).
- **Cấu trúc cố định:** tiêu đề → khối thông tin 6 dòng (Mã · Tên · Tài liệu nguồn · Căn cứ cách hiểu · Trục trace · Người thiết kế · ngày) → Manual test **theo Round** → **A. Case theo requirement** → **B. Case QA bổ sung** → Câu hỏi cần chốt → Thống kê → Lịch sử cập nhật. Không có frontmatter YAML.
- **15 cột, không đổi tên / thứ tự / số lượng:** Test Case ID · Purpose · Category · Trace BR · Precondition · Steps · Data · Expected Result · Round 1 · Round 2 · Round 3 · Error Code · Note · Date · Tester.
- **Từng cột:** ID `[<Mã>_<NN>]` liên tục cả file, không ký hiệu trong ô ID · Purpose 1 câu riêng · Category ∈ Positive/Negative/Edge case/UI/Security/Performance · Steps đánh số, bắt đầu bằng động từ, đúng tên nút · Data là giá trị cụ thể · Expected Result kiểm chứng được, thông báo chép nguyên văn, mã lỗi kỳ vọng ở dòng cuối · Round mặc định `Todo`, người viết không điền Pass/Fail · Error Code = mã BUG khi Fail (không phải mã lỗi kỳ vọng) · Note theo thứ tự Ưu tiên · Loại · ❓ Cần chốt · Nguồn · Evidence.
- **Trace BR (7 rule):** BR chính trước, mã phụ sau, ngăn bằng ` · ` · mỗi case đúng 1 BR chính · nhiều tài liệu thì thêm tiền tố (`G007 BR18`) · tài liệu không có mã → QA đánh `BR-xx`, khai ở `Trục trace` · case nhóm A không thuộc BR → `— · <mã gần nhất>` · case QA tự thêm → mục B, `N/A — QA bổ sung` · **không bịa mã**.
- **Nhóm B** không tính vào độ phủ; Expected Result ghi `ĐO & GHI`. BR chỉ có case `❓ Cần chốt` = chưa phủ.
- **Khi tài liệu chưa rõ:** viết phần chắc chắn, phần chưa rõ ghi `Chờ Q-<nn>`, không đoán hộ BA.
- **Lịch sử cập nhật** phải nêu khoảng mã TC — đó là căn cứ chấm point.

#### `qa-test-design` — kỹ thuật nghĩ ra case

- **Agent dùng:** `qa-test-case-writer`, `qa-test-planner`.
- **6 rule:** (1) no test without AC-source — không derive được từ spec thì loại · (2) black-box: từ spec + giao diện, không từ code · (3) mỗi AC đủ 3 nhánh **Happy / Edge / Error**, Error phải có mã lỗi kỳ vọng · (4) chọn kỹ thuật theo hình dạng input (biên → BVA; lớp → EP; nhiều điều kiện → decision table; vòng đời → state-transition; nhiều tham số → pairwise; kinh nghiệm → error guessing) · (5) giảm tổ hợp có kỷ luật, không Cartesian mù · (6) case phải chạy được — case rỗng không tính coverage.
- Nhánh ghi ở cột Category (`Positive` / `Edge case` / `Negative`); ma trận BR → case theo chỗ đặt của `qa-test-case-writing`.

#### `qa-point-scoring` — bóc việc và chấm point

- **Agent dùng:** không có agent riêng; bạn gọi trực tiếp. `qa-test-case-writer` chỉ dùng để đánh mã `BR-xx`.
- **Đơn vị = một Business Rule.** Use case / luồng / AC / bước / mã lỗi không phải đơn vị. Mỗi BR một dòng, gộp phân tích + thiết kế + chạy.
- **10 rule:** 1 BR = 1 dòng · 1 hành vi chỉ thuộc 1 BR (luồng thuần, thao tác không có rule → không có dòng) · số case không quyết định point · không mã yêu cầu → không dòng · chốt point một lần (đã thiết kế mà chờ build vẫn chốt; chờ BA thì chưa) · pass không evidence không tính · severity không nâng point, chỉ độ khó tái hiện · không nhân % ownership · một dòng tối đa 1 point · evidence là điều kiện, không phải đầu việc.
- **Thang:** ma trận Size (S/M; **L không dùng cho 1 BR**) × Effort (E/M/H) = 0.05 → 1. Mặc định `S×E = 0.05`; nâng phải có lý do (số nhánh, tài liệu thiếu/mâu thuẫn, ảnh hưởng tiền/dữ liệu/quyền). Mốc: BR cỡ trung bình ≈ 0.5; tính năng 15–20 BR ≈ 4–7 point.
- **Bảng phụ** (không nằm trong bảng BR): defect theo độ khó tái hiện (0.05 → 0.7) · automation theo harness/page-object · regression theo lần thay đổi thật · dựng môi trường chỉ khi nặng.
- **Căn cứ:** mã yêu cầu trỏ về tài liệu · khoảng mã TC · test-run + evidence tồn tại thật · ghi công trong artifact (`Người thiết kế · ngày` + Lịch sử cập nhật). **Không dùng commit** làm căn cứ.
- **Báo cáo:** Bảng tổng hợp · Bảng A (BR) · Bảng B (phụ) · "Chưa chốt point" · "Đã loại". Template `wiki/qa/point-reports/_template.md`.

#### `qa-test-types` — test gì ở tầng nào

- **Agent dùng:** `qa-intake-classifier`, `qa-test-planner`.
- **6 rule:** QA = black-box qua UI/API · dev giữ unit/integration/contract, QA **không lặp** · no test without AC-source · chọn loại test theo lane rủi ro (`RISK_LANES.md § QA`): tiny = smoke; normal = Happy/Edge/Error; high-risk = + exploratory + a11y + regression automation · execution cần `be.done + fe.done`, design thì shift-left · non-functional trong scope = a11y + perf-smoke + security-test cơ bản; full perf/pentest ngoài scope.

#### `qa-test-data` — dữ liệu test

- **Agent dùng:** `qa-test-case-writer`, `qa-automation-builder`, `qa-test-executor`.
- **7 rule:** không bao giờ dùng dữ liệu production, PII phải mask · deterministic — random phải có fixed seed · mỗi test bắt đầu từ known state, setup/teardown riêng, không phụ thuộc thứ tự · cô lập tenant, có assertion tenant A không thấy tenant B · không secret trong repo · parallel-safe (unique key theo worker/run) · tách data/config theo môi trường.

#### `qa-e2e-playwright` — automation E2E web + a11y

- **Agent dùng:** `qa-automation-builder` (sinh code), `qa-test-executor` (chạy, thu evidence).
- **9 rule:** selector `getByRole` / `getByTestId`, cấm CSS class / xpath / nth-child · web-first assertion, cấm `waitForTimeout` · Page Object Model · evidence bắt buộc: trace on-first-retry, screenshot + video on failure · axe-core quét mọi màn chính, không critical/serious · fresh state + isolation, `fullyParallel` · auth một lần qua `storageState` · tag `@TC-<FEAT>-NN` trên mỗi test · fix flaky tận gốc, không tăng retry để giấu.

#### `qa-api-test` — automation API (REST-assured / Karate)

- **Agent dùng:** `qa-automation-builder`, `qa-test-executor`.
- **7 rule:** contract FEAT §3 là nguồn chân lý — response lệch = contradiction, **không sửa test cho khớp code** · mỗi test map đúng 1 `TC-<FEAT>-NN` · assert status + body + schema + đúng `ERR-<NNN>-xx`, không chỉ `200 OK` · test cô lập tenant là bắt buộc · authz negative (thiếu/sai/hết hạn token → 401/403 đúng mã) · isolated & repeatable, tự setup/teardown · log full request + response (mask secret) làm evidence.

#### `qa-defect` — ghi lỗi

- **Agent dùng:** `qa-bug-reporter`.
- **7 rule:** no repro → no defect · mỗi BUG link FEAT + AC + TC + test-run · severity (mức hỏng) ≠ priority (thứ tự fix), gán cả hai · kỳ vọng phải trích AC/contract có thật · expected của case sai → trả về `qa-test-case-writer`, không file bug · loop-back đúng nơi: server/contract/data → BE, UI/render/client-validation → FE, không rõ → "cần triage" · không đụng `status.qa`, chỉ đẩy `status.be/fe` → `review`.

#### `qa-exit-criteria` — điều kiện ký duyệt

- **Agent dùng:** `qa-reviewer` (chấm gate), `qa-wiki-logger` (đặt cờ).
- **6 rule — đủ cả 6 mới sign-off:** AC coverage 100% (case **đã chạy**, không phải chỉ "planned") · blocking pass rate 100% · 0 defect critical/blocker mở · mọi Pass có evidence · SCORING gate pass (total ≥ 85, contradiction ⑤ = 5) · sign-off là hành động ghi `status.qa=done` + `milestones.qa.signedOff=true`, chỉ sau khi 5 điều trên đạt. Ba ngưỡng đầu là **hard floor** — plan chỉ được siết, không được nới.

#### `qa-flow` — điều phối bộ qa-ai-agents (từ tài liệu BA)

- **Gọi agent:** `qa-test-designer` (S6, S8), `cx-reviewer` (S7) — chỉ khi `gate: open`, `materialOpen: 0`, có câu xác nhận của bạn.
- **Luật nằm ở 10 file `qa-flow/rules/`** (nguyên tắc nền, workflow, phân tích requirement, debate & alignment, test design, CX, risk/coverage/regression, execution, traceability, human-in-the-loop). Tóm tắt từng file: [HUONG-DAN-QA-AI-AGENTS.md §7.3](HUONG-DAN-QA-AI-AGENTS.md#73-mười-file-rule-rules).

---

## 8. Từng agent: nhận gì, nạp gì, ghi gì, không làm gì

Agent do `qa-orchestrator` (hoặc `qa-flow`) gọi; bạn thường không gọi trực tiếp.

| Phase | Agent | Nhận vào | Nạp skill | Ghi ra | Không làm |
|---|---|---|---|---|---|
| 1 | `qa-intake-classifier` | FEAT đã claim, `.project-config.yml` | types · design · defect · exit-criteria (+ e2e / api / data tùy) | Lane + flag + độ sâu test + danh sách skill gợi ý (trả về orchestrator) | Viết plan/case; chạy test; gọi agent khác |
| 2 | `qa-test-planner` | FEAT + kết quả intake | types · design | `qa/test-plans/TP-<FEAT>.md`; tick ô "Test plan" trong FEAT §4.4 | Viết case; chạy test; đụng defect/matrix |
| 3 | `qa-test-case-writer` | FEAT §2 (AC/US) + §3 (mã lỗi) + test plan | test-case-writing · design · data · point-scoring | `qa/test-cases/<FEAT>.md` (mẫu chuẩn, nhóm A/B, ma trận BR → case) | Chạy test; viết automation; log bug; **bịa AC/mã lỗi** |
| 4 | `qa-automation-builder` | FEAT + case + stack trong config | e2e-playwright · api-test · data · test-case-writing | Code trong **repo test** (không phải wiki); mỗi test trace 1 TC | Tự động hoá tất cả; chạy làm nguồn chân lý; viết case; push |
| 5 | `qa-test-executor` | FEAT + case + plan; **chỉ khi be.done + fe.done** | e2e-playwright · api-test · data · test-case-writing | `qa/test-runs/FEAT-<NNN>_<ngày>.md`, mỗi case Pass/Fail/Blocked + evidence | Viết case; file bug (chỉ liệt kê case fail); sign-off; push |
| 6 | `qa-bug-reporter` | `failedCases[]` từ executor + FEAT | defect | `qa/defects/BUG-<NNN>.md`; đẩy `status.be/fe` → `review` nếu chặn nghiệm thu | Chạy test; sửa code; push; sign-off |
| 7 | `qa-regression-manager` | test-run mới / version release | — | `qa/regression-suite/suite-<module>.md`, `release/v<x>.md` (coverage đếm thật, flaky → quarantine) | Viết case mới; build automation; ước lượng coverage; push |
| 8 | `qa-reviewer` | plan + case (+ run + defect nếu đã chạy) | test-case-writing · exit-criteria · SCORING.md | Score block + review report + 1 dòng `quality-trend.md`; gate pass / loop-back | **Sửa** bất kỳ artifact nào; review code sản phẩm |
| 9 | `qa-wiki-logger` | Tóm tắt các phase + score của reviewer | exit-criteria | Regenerate `QA_COVERAGE_MATRIX.md`; FEAT §4.4 + §5; defect index; `status.qa=done` + `signedOff=true` khi đủ | Chạy test; viết case; push |
| 10 | `qa-git-committer` | FEAT vừa xong | — | Commit + push repo test (scoped) và wiki repo; không `--force`, không `--no-verify` | Sửa artifact; chạy test; quyết định sign-off |
| — | `qa-initiative-builder` | Spec lớn (epic / release scope) | — | Initiative note: N lát QA + FEAT đích + thứ tự phụ thuộc | Viết plan/case; chạy; gọi agent |
| — | `qa-release-notes-builder` | Version + khoảng thời gian | — | `release/v<x.y.z>-qa.md`: feature đã QA pass, coverage, defect còn mở, rủi ro | Sign-off; chạy test; ước số |
| S6/S8 | `qa-test-designer` (qa-flow) | `02-alignment-summary.md` (gate open) + `01-…` + tài liệu nguồn | qa-flow rules 01/05/07/09 · test-case-writing | `03-test-design.md`, `04-testcases.md` | Tạo requirement; tự chọn cách hiểu điểm mở; chạy test; điền Pass/Fail; ghi `Automated` khi không có script |
| S7 | `cx-reviewer` (qa-flow) | `02-…` (gate open) + tài liệu / design / prototype | qa-flow rules 01/06/09 | `05-cx-review.md` (Defect / Usability / CX Risk / Suggestion) | Sửa requirement; nói "đã thao tác" khi chỉ đọc; coi persona giả định là thật |

**Nhận ra agent làm sai:** agent ghi file ngoài cột "Ghi ra", hoặc làm việc trong cột "Không làm" → yêu cầu chạy lại đúng agent. Ví dụ: `qa-test-executor` tự tạo `BUG-…` là sai; `qa-reviewer` tự sửa test case là sai; `qa-test-designer` ghi file khi `gate: closed` là sai.

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
| `/qa-flow <ID>` | Bộ qa-ai-agents — từ tài liệu BA (xem [HUONG-DAN-QA-AI-AGENTS.md](HUONG-DAN-QA-AI-AGENTS.md)) |

---

## 13. Cùng góp sửa rule với team

Bộ skill là **code chung**: mọi người dùng cùng một bộ luật, nên sửa luật phải đi qua repo để ai cũng nhận được.

### 13.1. Nguyên tắc

1. **Sửa trong repo, không sửa trong `~/.claude/`.** Thư mục `~/.claude/skills/` và `~/.claude/agents/` là **bản cài**; lần chạy installer kế tiếp sẽ ghi đè. Sửa ở đó là mất.
2. **Một mẫu test case duy nhất** = `qa-flow/templates/testcase-template.md`. File `project-template/wiki/qa/test-cases/_template.md` phải là bản sao nguyên văn. Sửa mẫu thì copy sang file thứ hai; installer sẽ cảnh báo nếu hai file lệch.
3. **Rule nào sửa thì đọc checklist / anti-pattern của rule đó** trước, để không mâu thuẫn với phần còn lại (ví dụ: `qa-point-scoring` chấm theo BR, nếu đổi cách đánh mã BR trong `qa-test-case-writing` thì phải xem lại cả hai).
4. **Không bịa thêm luật cho AI** ngoài những gì team đã thống nhất. Rule là thoả thuận của team, không phải ý kiến cá nhân.

### 13.2. Sửa ở đâu

| Muốn đổi | Sửa file |
|---|---|
| Cách viết test case (cột, nhóm A/B, Trace BR) | `qa-test-case-writing/skill.md` + mẫu `qa-flow/templates/testcase-template.md` (và bản sao trong `project-template/`) |
| Cách chấm point | `qa-point-scoring/skill.md` + `project-template/wiki/qa/point-reports/_template.md` |
| Luật debate / cổng Alignment / CX của `/qa-flow` | `qa-flow/rules/<số>-*.md`, mẫu đầu ra trong `qa-flow/templates/` |
| Hành vi một agent (ví dụ `qa-test-designer` ghi thêm gì) | `agents/<tên-agent>.md` |
| Cách cài | `install.sh` + `install.ps1` (sửa cả hai) |
| Cấu hình mặc định cho project mới | `project-template/_project-root/.project-config.yml` |

### 13.3. Quy trình gửi thay đổi

```bash
cd tester-skill
git checkout main && git pull
git checkout -b <ten-nhanh>          # vd: fix/trace-br-nhieu-tai-lieu

# ... sửa file trong repo ...

bash install.sh                      # cài bản đang sửa vào máy mình để thử
# mở lại Claude Code, chạy thử với một tài liệu thật, xem kết quả có đúng ý không

git add <file đã sửa>
git commit -m "fix(qa): <mô tả ngắn, nói rõ đổi luật gì>"
git push -u origin <ten-nhanh>
```

Rồi vào GitHub tạo **Pull Request** vào `main` (hoặc `gh pr create --fill`). Trong mô tả PR ghi:
**đổi luật gì · vì sao · đã thử với tài liệu nào**. Người khác xem, góp ý, rồi merge.

Sau khi merge: báo trong nhóm để mọi người `git pull` + chạy lại installer.

### 13.4. Trước khi gửi PR, tự kiểm

- [ ] Đã chạy installer và thử thật trên ít nhất một tài liệu; file sinh ra đúng mẫu.
- [ ] Không sửa file nào trong `wiki/` hay `tailieu/` của project (đó là dữ liệu làm việc, không thuộc bộ skill; `.gitignore` đã chặn).
- [ ] Sửa mẫu test case thì hai file template vẫn giống nhau (`diff` không ra gì).
- [ ] Sửa installer thì sửa cả `install.sh` lẫn `install.ps1`; đã thử trên hệ điều hành mình có; ghi rõ trong PR hệ nào **chưa** thử.
- [ ] Đổi luật ảnh hưởng tới cách chấm point hoặc độ phủ → ghi rõ trong PR để người chấm biết.
