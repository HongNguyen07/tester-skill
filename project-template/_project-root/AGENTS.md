# AGENTS.md — Project Root (QA / tester)

> **Master rules cho mọi coding/testing agent** (Claude Code, Cursor, Codex, Aider, Gemini CLI...).
> Tool-agnostic — pure markdown. Entry point cấp project cho **discipline QA (tester)**.
>
> **Đa-discipline (non-clobber):** nếu project cùng thư mục còn discipline khác (BA/BE/FE) đã
> bootstrap trước, bootstrap QA **KHÔNG ghi đè** AGENTS.md/CLAUDE.md/.project-config.yml của họ —
> nên file này có thể thuộc discipline khác. Cần rules QA ở đây → **yêu cầu agent merge** section QA.
> Rules chi tiết QA luôn ở `~/.claude/skills/qa-orchestrator` + `qa-*` + wiki overlay (`wiki/qa/`).

---

## Vai trò discipline QA — ranh giới

- **QA bổ sung, KHÔNG thay** test của dev. Dev (BE/FE) giữ **unit / integration / contract**
  (white-box, trong repo service). QA làm **black-box, xuyên discipline**:
  acceptance · system · E2E · regression · exploratory · a11y · perf-smoke.
- QA **lấp gap** test cho FE (FE harness không sinh test → QA phủ E2E/acceptance).
- **Gate cuối:** feature chỉ `done` toàn cục khi `status.qa=done` + `milestones.qa.signedOff=true`
  (xem `wiki/features/README.md`).

---

## Project metadata

Đọc `.project-config.yml` cùng folder để biết:
- Wiki path (SHARED với BA/BE/FE — cùng 1 wiki repo team)
- Memory path (project-level — KHÔNG dùng global agent memory)
- Test stack (Playwright / REST-assured / Karate), môi trường, exit criteria
- Conventions (bug/test-case id prefix) + hard gates QA

---

## Workflow BẮT BUỘC mỗi task (QA pipeline)

```
[Phase 0]    Auto-discovery: parse .project-config.yml
[Phase 0.5]  Load wiki/memory/MEMORY.md → áp dụng feedback rules
[Phase 0.55] Wiki health check (verify structure)
[Phase 0.6]  Feature backlog: git pull wiki → liệt kê FEAT cần QA (gate) → multi-choice → claim (owners.qa)
[Phase 1]    qa-intake-classifier: test risk lanes (RISK_LANES.md § QA) → lane + flags
[Phase 2]    qa-test-planner: test plan (scope + test types + môi trường + entry/exit)
[Phase 3]    qa-test-case-writer: test cases Happy/Edge/Error — mỗi case trace 1 AC/US (shift-left)
             ⏸ user duyệt test cases
[Phase 4]    qa-automation-builder: Playwright (E2E/FE) + REST-assured/Karate (API/BE)   [khi cần automation]
[Phase 5]    qa-test-executor: chạy manual + automation → kết quả + EVIDENCE (log/screenshot/trace)
[Phase 6]    qa-bug-reporter: fail → BUG-<NNN> (severity, repro, link FEAT+AC) → loop về BE/FE
[Phase 7]    qa-regression-manager: cập nhật regression suite [per release]
[Phase 8]    qa-reviewer: review chất lượng test + SCORING anti-hallucination (wiki/SCORING.md)
             - gate=block → loop back qa-test-case-writer/executor
[Phase 9]    qa-wiki-logger: QA_COVERAGE_MATRIX + defect log + quality-trend + HARNESS_BACKLOG
[Phase 10]   qa-git-committer: commit test-case/automation code (scoped, conventional, branch)
```

**Gate execution:** Phase 5 (execution) chỉ chạy khi `deps.qa` thỏa (be.done + fe.done theo needs).
Phase 2-3 (design) shift-left — làm khi `status.ba=done`.

---

## Anti-hallucination QA (bắt buộc — chấm ở qa-reviewer)

- **No test without AC-source:** mọi test case PHẢI trace 1 AC/US cụ thể. Không test hành vi ngoài spec.
- **Evidence-backed pass:** kết quả "pass" PHẢI có evidence (log/screenshot/trace). Pass không evidence = bịa.
- **Contradiction:** kết quả test mâu thuẫn spec/contract, hoặc test flaky (pass/fail không ổn định) → cờ đỏ.
- Chi tiết rubric + gate: `wiki/SCORING.md`; trend: `wiki/quality-trend.md`.

---

## Memory model — QUAN TRỌNG

**KHÔNG dùng global agent memory.** Dùng `wiki/memory/` (SHARED với BA/BE/FE):
- Đọc memory đầu task (Phase 0.5); ghi khi friction lặp ≥ 2 lần (Phase 9 — qua qa-wiki-logger);
  ghi khi user nói "lần sau làm thế này".

---

## Per-feature folder convention

Mọi artifact QA gắn với FEAT id.

| Loại | Path |
|---|---|
| Test plan | `wiki/qa/test-plans/TP-<FEAT>.md` |
| Test cases | `wiki/qa/test-cases/<FEAT>.md` |
| Test run | `wiki/qa/test-runs/<FEAT>_<date>.md` |
| Defect | `wiki/qa/defects/BUG-<NNN>.md` |
| Coverage aggregator | `wiki/QA_COVERAGE_MATRIX.md` (auto-regenerated — KHÔNG hand-edit) |

Automation code (Playwright/Karate) sống ở **test repo** (qa-git-committer commit) — KHÔNG trong wiki.

---

## Naming conventions

| Type | Format | Ví dụ |
|---|---|---|
| Test case ID | `TC-<FEAT>-{NN}` | `TC-042-01` |
| Bug ID | `BUG-{NNN}` | `BUG-017` |
| Test plan ID | `TP-<FEAT>` | `TP-042` |
| Status values | `Draft` / `Ready` / `Running` / `Passed` / `Failed` / `Blocked` | |
| Date format | `YYYY-MM-DD` | |

---

## Khi nào DỪNG xin user xác nhận

- Lane = `high-risk` sau test-risk assessment → xác nhận trước khi mở rộng scope automation
- Feature chạm hard gate (auth, payment, data-integrity, cross-service-e2e, multi-tenant)
- FEAT thiếu AC → KHÔNG tự bịa test; báo BA bổ sung
- Muốn sign-off (status.qa=done) khi còn defect critical mở → DỪNG

---

## Source of truth hierarchy

```
1. AGENTS.md (file này)                ← project-wide
2. .project-config.yml                 ← metadata
3. wiki/memory/MEMORY.md               ← learned rules
4. ~/.claude/skills/qa-*               ← global skill rules
5. wiki/features/FEAT-*.md             ← nguồn chuẩn AC/US để viết test
6. wiki/SCORING.md                     ← rubric chấm điểm QA
```

Khi xung đột → ưu tiên file ở trên.

---

## Tool-specific addendum

- Claude Code → `CLAUDE.md` cùng folder
- Cursor → `.cursor/rules/` (nếu cần)
- Codex / Aider / Gemini CLI → đọc trực tiếp `AGENTS.md` này
