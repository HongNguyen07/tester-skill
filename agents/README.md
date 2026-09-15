# tester-skill agents (qa-*)

Sub-agent của discipline QA, cài global vào `~/.claude/agents/` bởi `install.*`.
Prefix `qa-` → không đụng `ba-*` / `be-*` / `fe-*`.

## Roster (theo PLAN.md)
| Agent | Phase | Build |
|---|---|---|
| `qa-intake-classifier` | 1 | P2 |
| `qa-test-planner` | 2 | P2 |
| `qa-test-case-writer` | 3 | P2 |
| `qa-automation-builder` | 4 | P4 |
| `qa-test-executor` | 5 | P3 |
| `qa-bug-reporter` | 6 | P3 |
| `qa-regression-manager` | 7 | P4 |
| `qa-reviewer` | 8 | P2 |
| `qa-wiki-logger` | 9 | P2 |
| `qa-git-committer` | 10 | P4 |
| `qa-initiative-builder` | disc | P3 |
| `qa-release-notes-builder` | release | P4 |

> P1 = khung (không có agent file). Agent thêm dần — file này liệt kê để track.
