# CLAUDE.md — Project Root (Claude Code, QA)

**Master rules nằm ở [AGENTS.md](AGENTS.md)** — đọc đầu tiên.

File này chỉ chứa Claude Code-specific addendum. Mọi workflow / hierarchy / naming convention → xem `AGENTS.md`.

---

## Claude-specific

### Gọi orchestrator
- `/qa-orchestrator <yêu cầu>` — dispatch QA pipeline (đầu vào: `wiki/features/FEAT-<NNN>.md`).
- `/qa-flow <ID>` — bộ qa-ai-agents, đứng riêng (đầu vào: tài liệu BA trong `tailieu/`; kết quả
  `wiki/qa/features/<ID>/01…06-*.md`). Không gọi lẫn agent của hai bộ trong cùng một feature.

### Skills
Cài global ở `~/.claude/skills/`:
- `qa-orchestrator` — orchestrator (entry point, dispatch sub-agents)
- `qa-*` — rule skills per concern (test-design, test-types, e2e-playwright, api-test, defect, test-data, exit-criteria, test-case-writing, point-scoring)
- `qa-flow` — orchestrator của bộ qa-ai-agents (SKILL.md + CLAUDE.md + rules/ + templates/). Mẫu test case
  chuẩn của team = `qa-flow/templates/testcase-template.md` (bộ `qa-*` dùng bản sao nguyên văn).

### Sub-agents
Cài global ở `~/.claude/agents/`:
- `qa-intake-classifier`, `qa-test-planner`, `qa-test-case-writer`, `qa-automation-builder`,
  `qa-test-executor`, `qa-bug-reporter`, `qa-regression-manager`, `qa-reviewer`, `qa-wiki-logger`,
  `qa-git-committer`, `qa-initiative-builder`, `qa-release-notes-builder`
- Bộ qa-ai-agents (do `/qa-flow` dispatch): `qa-test-designer`, `cx-reviewer`

> **Namespace:** QA agents prefix `qa-` → KHÔNG đụng `ba-*` / `be-*` / `fe-*`. An toàn cài chung 1 máy.

### Pipeline (QA adapted)
- **Test-DESIGN shift-left:** viết test case khi `status.ba=done` (có AC/US) — song song dev build.
- **Execution gate:** chỉ chạy Phase 5 khi `deps.qa` thỏa (be.done + fe.done theo needs).
- **Gate cuối:** feature `done` toàn cục chỉ khi `status.qa=done` + `qa.signedOff=true`.
- **Evidence bắt buộc:** mỗi "pass" cần log/screenshot/trace (Playwright trace, REST log).
- **qa-reviewer là MANDATORY** — chấm SCORING anti-hallucination (`wiki/SCORING.md`), gate=block → loop.

### Model preference
Default: orchestrator + sub-agents = sonnet. Override per-agent trong front-matter.

---

## QA gate reminder

Khi feature fail QA:
1. `qa-bug-reporter` tạo `BUG-<NNN>` (severity, repro, link FEAT+AC)
2. Discipline liên quan (be/fe) tụt `status` về `review` — loop lại
3. Feature KHÔNG `done` toàn cục cho tới khi QA re-run pass + sign-off

---

> Nếu dùng tool khác (Cursor, Codex, Aider, Gemini CLI) → chỉ cần `AGENTS.md`. Tool-specific addendum tùy tool.
