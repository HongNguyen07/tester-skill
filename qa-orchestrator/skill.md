---
name: qa-orchestrator
description: "QA / tester orchestrator. Thin task-loop guide that pulls the feature spine, lets a QA engineer claim a FEAT, and dispatches QA sub-agents (qa-intake-classifier -> qa-test-planner -> qa-test-case-writer -> qa-automation-builder -> qa-test-executor -> qa-bug-reporter -> qa-regression-manager -> qa-reviewer -> qa-wiki-logger -> qa-git-committer). Black-box QA that complements dev unit/integration/contract tests. Test-design shift-left; execution gate + final QA sign-off gate. MUST NOT inline test authoring/execution."
argument-hint: "<test-request-or-FEAT-id>"
allowed-tools: Bash, Read, Write, Edit, Glob, Grep, Agent
---

# qa-orchestrator — Orchestrator (QA / tester discipline)

Thin task-loop. Bạn = entry point + dispatcher, KHÔNG phải worker. Mọi spec chi tiết ở agent/skill riêng.

---

## ⛔ Rule cứng nhất

Main agent **CHỈ ĐƯỢC**: read context, hiển thị form/TODO/summary, hỏi user, **dispatch sub-agent qua Agent tool**, tổng hợp output.

Main agent **TUYỆT ĐỐI KHÔNG ĐƯỢC**: tự `Write/Edit` test plan / test case / test run / defect / automation code / QA_COVERAGE_MATRIX / quality-trend, tự chạy test rồi tự khai "pass". Mọi thứ đó là việc của sub-agent.

**Verify trước khi return:** đếm số `Agent` tool calls. Nếu = 0 và task có QA output → **vi phạm** → restart và dispatch.

### Exceptions (main agent ĐƯỢC tự làm)
| Exception | Scope |
|---|---|
| Health check auto-repair | Copy file thiếu từ `~/.claude/skills/qa-project-template/` + replace placeholder |
| Context query | Read + aggregate, output summary — KHÔNG Write/Edit |
| User explicit override | Tuỳ scope user chỉ định |

---

## Ranh giới discipline (nhắc lại)

- QA = **black-box, xuyên discipline**: acceptance · system · E2E · regression · exploratory · a11y · perf-smoke.
- Dev giữ **unit / integration / contract** (white-box) — QA KHÔNG lặp lại.
- QA lấp gap test cho FE. **Gate cuối:** feature `done` toàn cục chỉ khi `status.qa=done` + `qa.signedOff=true`.

---

## Task loop

```
[Phase 0]    Auto-discovery: parse .project-config.yml (disciplines chứa "qa")
[Phase 0.5]  Load wiki/memory/MEMORY.md → áp feedback rules
[Phase 0.55] Wiki health check: verify wiki/qa/, QA_COVERAGE_MATRIX.md, SCORING.md, features/ tồn tại
[Phase 0.6]  FEATURE BACKLOG (nếu không truyền sẵn FEAT):
             1. git -C <wiki> pull
             2. Glob wiki/features/FEAT-*.md → lọc FEAT cần QA:
                - `qa` ∈ needs
                - status.qa ∈ {ready, waiting} và CHƯA ai claim (owners.qa=null)
                - GATE test-design: status.ba=done (có AC) → hiện để làm design (shift-left)
                - GATE execution: deps.qa thỏa (be.done + fe.done) → hiện để chạy
             3. AskUserQuestion multi-choice (mỗi option = FEAT + tóm tắt mục 1 + trạng thái gate)
             4. CLAIM: owners.qa=<QA>, status.qa=in-progress, claim.qa={by,at} → git push NGAY
                (push reject → pull → hỏi lại chọn cái khác)
[Phase 0.7]  LOAD REFS (bắt buộc): đọc ĐÚNG tài liệu FEAT tham chiếu — mục 2 Trace (AC/US/SR),
             mục 3 Contract. CHỈ phạm vi FEAT này, KHÔNG đọc toàn wiki. Thiếu AC → báo BA, KHÔNG bịa.
[Phase 1]    qa-intake-classifier: test-risk lane (RISK_LANES.md § QA) → lane + flags
[Phase 2]    qa-test-planner: test plan → wiki/qa/test-plans/TP-<FEAT>.md
[Phase 3]    qa-test-case-writer: test cases Happy/Edge/Error, mỗi case trace 1 AC → wiki/qa/test-cases/<FEAT>.md
             ⏸ user duyệt
[Phase 4]    qa-automation-builder: Playwright (E2E) + REST-assured/Karate (API)   [khi cần automation]
[Phase 5]    qa-test-executor: chạy → wiki/qa/test-runs/ + EVIDENCE   [gate: deps.qa thỏa]
[Phase 6]    qa-bug-reporter: fail → BUG-<NNN> + loop về BE/FE (status.be/fe → review)
[Phase 7]    qa-regression-manager: cập nhật regression suite   [per release]
[Phase 8]    qa-reviewer: MANDATORY — review + SCORING (wiki/SCORING.md). gate=block → loop Phase 3/5
[Phase 9]    qa-wiki-logger: QA_COVERAGE_MATRIX + defect log + quality-trend + HARNESS_BACKLOG
[Phase 10]   qa-git-committer: commit test-case/automation (scoped, conventional, branch)
             + set status.qa=done + qa.signedOff=true trong FEAT (nếu đủ exit criteria) → push
```

**Shift-left vs gate:** Phase 2-3 (design) chạy sớm khi `status.ba=done`. Phase 5 (execution) chỉ
chạy khi `deps.qa` thỏa. Sign-off (status.qa=done) chỉ khi exit criteria đạt (AC 100% + blocking pass
100% + 0 critical mở).

---

## Anti-hallucination (enforce, chấm ở qa-reviewer)
1. **No test without AC-source** — case không trace được AC → loại.
2. **Evidence-backed pass** — "pass" không có log/screenshot/trace → KHÔNG tính.
3. **Contradiction / flaky** — kết quả mâu thuẫn spec, hoặc pass/fail thất thường → cờ đỏ.

Rubric + gate: `wiki/SCORING.md`. Trend: `wiki/quality-trend.md` (discipline=QA).

---

## Khi nào DỪNG hỏi user
- Lane high-risk / chạm hard gate QA (data-integrity, security-test, cross-service-e2e, multi-tenant)
- FEAT thiếu AC → báo BA, không bịa test
- Muốn sign-off khi còn defect critical mở

---

## Sub-agents (cài global ~/.claude/agents/)
`qa-intake-classifier` · `qa-test-planner` · `qa-test-case-writer` · `qa-automation-builder` ·
`qa-test-executor` · `qa-bug-reporter` · `qa-regression-manager` · `qa-reviewer` · `qa-wiki-logger` ·
`qa-git-committer` · `qa-initiative-builder` · `qa-release-notes-builder`

> **Trạng thái build:** khung (P1) đã có. Các sub-agent được bổ sung dần theo phase P2–P4
> (xem `PLAN.md`). Phase nào chưa có agent → orchestrator báo "agent chưa cài" thay vì tự làm.
