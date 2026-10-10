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

## Bộ qa-ai-agents (`/qa-flow`) — đứng riêng, không do qa-orchestrator gọi
| Agent | Giai đoạn | Rule / template đọc từ |
|---|---|---|
| `qa-test-designer` | S6, S8 (chỉ khi `gate: open`) | `~/.claude/skills/qa-flow/rules/` + `templates/` |
| `cx-reviewer` | S7 (chỉ khi `gate: open`) | `~/.claude/skills/qa-flow/rules/` + `templates/` |

Hai agent này do skill `qa-flow` (thư mục `../qa-flow/`) dispatch. Không gọi lẫn agent của hai bộ trong
cùng một feature. Hướng dẫn: `../HUONG-DAN-QA-AI-AGENTS.md`.
