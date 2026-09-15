# CLAUDE.md — Project Root (Claude Code, QA)

**Master rules nằm ở [AGENTS.md](AGENTS.md)** — đọc đầu tiên.

File này chỉ chứa Claude Code-specific addendum. Mọi workflow / hierarchy / naming convention → xem `AGENTS.md`.

---

## Claude-specific

### Gọi orchestrator
`/qa-orchestrator <yêu cầu>` — dispatch QA pipeline.

### Skills
Cài global ở `~/.claude/skills/`:
- `qa-orchestrator` — orchestrator (entry point, dispatch sub-agents)
- `qa-*` — rule skills per concern (test-design, test-types, e2e-playwright, api-test, defect, test-data, exit-criteria)

### Sub-agents
Cài global ở `~/.claude/agents/`:
- `qa-intake-classifier`, `qa-test-planner`, `qa-test-case-writer`, `qa-automation-builder`,
  `qa-test-executor`, `qa-bug-reporter`, `qa-regression-manager`, `qa-reviewer`, `qa-wiki-logger`,
  `qa-git-committer`, `qa-initiative-builder`, `qa-release-notes-builder`

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
