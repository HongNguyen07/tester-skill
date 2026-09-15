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
- Skills `qa-orchestrator` + `qa-*` → `~/.agents/skills/`
- Agents `qa-*` → `~/.claude/agents/`
- `qa-project-template` + `shared-wiki-template` (vendored) → `~/.claude/skills/` & `~/.agents/skills/`

## Dùng trong project
```bat
bash ~/.claude/skills/qa-project-template/bootstrap.sh D:\path\to\project
```
Bootstrap **non-clobber**: nếu BA/BE/FE đã tạo AGENTS.md/CLAUDE.md/config → KHÔNG ghi đè;
chỉ thêm overlay `wiki/qa/` + `QA_COVERAGE_MATRIX.md`. Rồi mở Claude Code → `/qa-orchestrator`.

## Cấu trúc
```
tester-skill/
  install.sh/.ps1/.bat        # cài global + copy template + vendored shared-wiki
  qa-orchestrator/skill.md     # entry point (thin dispatcher)
  qa-*/skill.md                # rule skills (P2–P4)
  agents/qa-*.md               # sub-agents (P2–P4)
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

**Tổng:** 12 agent `qa-*` + 8 skill (`qa-orchestrator` + 7 rule). Luồng đóng vòng:
intake → plan → case (shift-left) → *(BE/FE build)* → automation → execute+evidence → defect/loop-back → review(score) → log + sign-off gate → commit/push.

## Đồng bộ shared-wiki
Sửa canonical tại `java-skill/shared-wiki-template/` → chạy `../sync-shared-wiki.sh` (đã gồm tester-skill).
