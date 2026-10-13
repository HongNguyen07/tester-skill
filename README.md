# tester-skill — Bộ skill QA (tester) cho Claude Code

Bộ skill thứ 4 (song song `ba-skills` / `java-skill` / `fe-nextjs-skill`), prefix **`qa-`**.
Đưa **QA (kiểm thử)** vào pipeline BA → BE → FE → **QA gate**.

## Vai trò
- **Bổ sung, không thay** test của dev. Dev giữ unit/integration/contract (white-box);
  QA làm **black-box xuyên discipline**: acceptance · system · E2E · regression · exploratory · a11y · perf-smoke.
- Lấp gap test cho FE (FE harness không sinh test).
- **Gate cuối:** feature `done` toàn cục chỉ khi `status.qa=done` + `milestones.qa.signedOff=true`.

## Cài đặt (portable — self-contained)
Copy folder này sang máy bất kỳ → chạy 1 lệnh → xong:

```bat
:: Windows
install.bat

:: hoặc bash
bash install.sh
```

Cài gì:
- Skills `qa-orchestrator` + `qa-*` → **`~/.claude/skills/<name>/SKILL.md`** (để hiện trong menu `/`
  của Claude Code) **và** `~/.agents/skills/` (cho `npx skills` / Cursor)
- Skill `qa-flow` (bộ qa-ai-agents, nhiều file) → **copy cả thư mục** `~/.claude/skills/qa-flow/`
  (SKILL.md + CLAUDE.md + `rules/` + `templates/`)
- Agents `qa-*` + `cx-reviewer` → `~/.claude/agents/`
- `qa-project-template` + `shared-wiki-template` (vendored) → `~/.claude/skills/` & `~/.agents/skills/`
- Mẫu test case trong bản cài của `qa-project-template` **luôn lấy từ** `qa-flow/templates/testcase-template.md`
  (installer cảnh báo nếu bản copy trong repo bị lệch)

> Sửa rule/template: sửa **trong repo** rồi chạy lại installer. Sửa thẳng trong `~/.claude/` sẽ bị ghi đè ở
> lần cài kế tiếp.

Hướng dẫn cho team: [`HUONG-DAN-SU-DUNG.md`](HUONG-DAN-SU-DUNG.md) (bộ `qa-*` / `/qa-orchestrator`) ·
[`HUONG-DAN-QA-AI-AGENTS.md`](HUONG-DAN-QA-AI-AGENTS.md) (bộ qa-ai-agents / `/qa-flow`).

## Dùng trong project
```bat
bash ~/.claude/skills/qa-project-template/bootstrap.sh D:\path\to\project
```
Bootstrap **non-clobber**: nếu BA/BE/FE đã tạo AGENTS.md/CLAUDE.md/config → KHÔNG ghi đè;
chỉ thêm overlay `wiki/qa/` + `QA_COVERAGE_MATRIX.md`. Rồi mở Claude Code → `/qa-flow <ID>` (luồng mặc định
của team, từ tài liệu BA) hoặc `/qa-orchestrator` (khi đã có FEAT + wiki git chung).

## Cấu trúc
```
tester-skill/
  install.sh/.ps1/.bat        # cài global + copy template + vendored shared-wiki
  qa-orchestrator/skill.md     # entry point (thin dispatcher) — luồng từ FEAT
  qa-*/skill.md                # rule skills (P2–P6)
  qa-flow/                     # bộ qa-ai-agents — luồng từ tài liệu BA (SKILL.md + CLAUDE.md + rules/ + templates/)
  agents/qa-*.md               # sub-agents của qa-orchestrator (P2–P4)
  agents/qa-test-designer.md   # sub-agent của qa-flow
  agents/cx-reviewer.md        # sub-agent của qa-flow
  shared-wiki-template/        # vendored (đồng bộ qua ../sync-shared-wiki.*)
  project-template/
    _project-root/             # .project-config.yml + AGENTS.md + CLAUDE.md (QA)
    bootstrap.sh/.ps1/.bat     # non-clobber, wiki = shared + qa overlay
    wiki/qa/ + QA_COVERAGE_MATRIX.md
  PLAN.md                      # kế hoạch build P1–P4
```

## Trạng thái — HOÀN CHỈNH (P1–P4)
- **P1 khung** — template, bootstrap, orchestrator, wiki/qa overlay, FEAT thêm `qa`, install.
- **P2 lõi manual** — qa-intake-classifier · qa-test-planner · qa-test-case-writer · qa-reviewer(scoring) · qa-wiki-logger.
- **P3 execution+defect** — qa-test-executor · qa-bug-reporter · qa-initiative-builder + FEAT QA-gate wiring vào be/fe orchestrator.
- **P4 automation** — qa-automation-builder (Playwright + REST-assured/Karate) · qa-regression-manager · qa-git-committer · qa-release-notes-builder + 7 rule skill (test-design/types/e2e-playwright/api-test/defect/test-data/exit-criteria).
- **P5 quản trị đầu việc** — `qa-point-scoring`: bóc tách đầu việc QA + chấm point (Size × Effort,
  0.125–2). Độc lập, không dùng commit làm căn cứ; đơn vị chấm là **cơ chế nghiệp vụ**, không phải
  số test case. Báo cáo ghi ở `wiki/qa/point-reports/`.

- **P6 rule viết test case** — `qa-test-case-writing`: template 15 cột cố định (Test Case ID · Purpose ·
  Category · **Trace BR** · Precondition · Steps · Data · Expected Result · Round 1–3 · Error Code · Note ·
  Date · Tester) + khối thông tin + Manual test theo Round + tách nhóm A (theo requirement) / nhóm B (QA bổ
  sung). Mỗi case bắt buộc có Trace BR. Template chuẩn của team = mẫu `qa-flow`, dùng chung cho
  `/qa-flow` và `/qa-orchestrator`: `project-template/wiki/qa/test-cases/_template.md` (bản sao nguyên văn
  của `qa-flow/templates/testcase-template.md` — sửa một thì sửa cả hai).

- **P7 bộ qa-ai-agents** — `qa-flow` + 2 agent `qa-test-designer`, `cx-reviewer`. Luồng **từ tài liệu BA**
  (không cần FEAT / wiki git): Requirement Analysis → Câu hỏi BA → Debate QA ↔ AI → **người dùng mở cổng** → Test
  Design + CX Review song song → Unified QA Review. Kết quả `wiki/qa/features/<ID>/01…06-*.md`. Đứng riêng
  với `/qa-orchestrator`, không gọi lẫn agent trong cùng feature. Chi tiết: `qa-flow/CLAUDE.md`.

**Tổng:** 14 agent (12 `qa-*` + `qa-test-designer` + `cx-reviewer`) + 11 skill (`qa-orchestrator` + 9 rule + `qa-flow`).

Luồng `/qa-orchestrator` (từ FEAT, đóng vòng):
intake → plan → case (shift-left) → *(BE/FE build)* → automation → execute+evidence → defect/loop-back → review(score) → log + sign-off gate → commit/push.

Luồng `/qa-flow` (từ tài liệu BA):
phân tích → câu hỏi gửi BA → debate QA ↔ AI (bắt đầu ngay với phần không cần BA) → mở cổng → thiết kế case ‖ CX review → unified review.

## Đồng bộ shared-wiki
Sửa canonical tại `java-skill/shared-wiki-template/` → chạy `../sync-shared-wiki.sh` (đã gồm tester-skill).
