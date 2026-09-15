# tester-skill — Kế hoạch xây dựng (discipline QA)

> Bộ skill thứ 4, prefix **`qa-`**, song song `ba-` / `be-` / `fe-`. Self-contained + portable
> như 3 bộ hiện có (vendored `shared-wiki-template`, install.bat/bootstrap non-clobber).

## Quyết định đã chốt
| # | Quyết định |
| --- | --- |
| Ranh giới | **Bổ sung** be-test-writer: dev giữ unit/integration/contract (white-box, service repo); QA làm **acceptance / system / E2E / regression / exploratory / a11y / perf-smoke** (black-box, xuyên discipline). Lấp gap test cho FE. |
| Vị trí FEAT | **Test-design sớm** (viết case khi có US/AC — shift-left, song song dev) + **execution & GATE cuối** (feature chỉ `done` khi `status.qa=done`). |
| Automation | **Playwright** (E2E web + visual + a11y) + **REST-assured / Karate** (API BE). |
| Prefix | `qa-` |

## 1. Cấu trúc bộ skill (mirror pattern)
```
tester-skill/
  README.md  install.sh/.ps1/.bat  shared-wiki-template/ (vendored, đồng bộ qua sync-shared-wiki)
  qa-orchestrator/skill.md + checklist/
  qa-<concern>/skill.md            (rules — mục 4)
  agents/qa-*.md                   (mục 3)
  project-template/
    _project-root/{.project-config.yml (disciplines:["qa"]), AGENTS.md (QA), CLAUDE.md}
    bootstrap.sh/.ps1/.bat (non-clobber, robocopy /XC/XN/XO)
    wiki/                          (QA overlay — mục 5)
```

## 2. Agents (`qa-*`) — pipeline
| Phase | Agent | Vai trò | Tools |
| --- | --- | --- | --- |
| 1 | `qa-intake-classifier` | QA risk lanes (data-integrity, security-test, regression-scope, cross-service-e2e, flaky-risk) → lane + flags | Read, Glob, Grep, Write |
| 2 | `qa-test-planner` | Test plan từ FEAT: scope, test types, môi trường, test data, entry/exit criteria | Read, Write, Edit, Glob, Grep |
| 3 | `qa-test-case-writer` | Test case chi tiết: **Happy / Edge / Error** (chuẩn S4 + mã lỗi), mỗi case trace 1 AC/US | Read, Write, Edit, Glob, Grep |
| 4 | `qa-automation-builder` | Automation code: Playwright (E2E/FE) + REST-assured/Karate (API/BE) | Read, Write, Edit, Glob, Grep, Bash |
| 5 | `qa-test-executor` | Chạy/ghi manual QA + automation; kết quả + **evidence** (log/screenshot) | Read, Write, Edit, Glob, Grep, Bash |
| 6 | `qa-bug-reporter` | Log defect (severity, repro, link FEAT+AC), defect lifecycle | Read, Write, Edit, Glob, Grep |
| 7 | `qa-regression-manager` | Regression suite + coverage per release | Read, Write, Edit, Glob, Grep, Bash |
| 8 | `qa-reviewer` | Review chất lượng test + **SCORING anti-hallucination** (mục 6) | Read, Glob, Grep, Bash |
| 9 | `qa-wiki-logger` | Đóng vòng: QA_COVERAGE_MATRIX, defect log, quality-trend, HARNESS_BACKLOG | Read, Write, Edit, Glob, Grep |
| 10 | `qa-git-committer` | Commit test-case/automation code (scoped, conventional, branch) | Bash, Read, Glob, Grep |
| disc | `qa-initiative-builder` | Decompose spec → N QA slice | Read, Write, Edit, Glob, Grep |
| rel | `qa-release-notes-builder` | Aggregate QA-passed features → release QA report | Read, Write, Edit, Glob, Grep, Bash |

## 3. Skills (`qa-<concern>/skill.md`) — rules
- `qa-test-design` — boundary / equivalence / decision-table / state-transition / pairwise.
- `qa-test-types` — test pyramid, unit↔integration↔system↔E2E↔acceptance, non-functional.
- `qa-e2e-playwright` — Playwright: page-object, selectors, visual regression, a11y (axe), trace/screenshot evidence.
- `qa-api-test` — REST-assured / Karate: contract test vs BE contract (FEAT §3), auth, data setup/teardown.
- `qa-defect` — defect lifecycle, severity/priority, repro standard, link FEAT+AC.
- `qa-test-data` — test data management, fixtures, tenant isolation (khớp be-multitenancy).
- `qa-exit-criteria` — DoD QA, sign-off, coverage thresholds.

## 4. Wiki overlay (`project-template/wiki/qa/`)
```
wiki/qa/
  test-plans/_template.md          (plan per FEAT/release)
  test-cases/_template.md          (case: id, trace AC/US, Happy/Edge/Error, mã lỗi, evidence-required)
  test-runs/_template.md           (run: date, env, results, evidence links, pass/fail)
  defects/_template.md             (BUG-<id>: severity, repro, FEAT, AC, status lifecycle)
  regression-suite/README.md
wiki/QA_COVERAGE_MATRIX.md         (GENERATED VIEW: AC → test case → run status → % — do qa-wiki-logger sinh)
```
Automation code (Playwright/Karate) sống ở **test repo** (qa-git-committer commit) — không ở wiki.

## 5. Tích hợp Feature spine (sửa `features/_template.md` + README trong shared-wiki)
- FEAT frontmatter: `needs:[ba,be,fe,qa]`, `deps.qa:[be.done, fe.done]`, `status.qa`, `milestones.qa.signedOff`.
- Checklist FEAT thêm mục **QA**: test-plan · test-cases (trace AC) · execution+evidence · sign-off.
- **Gate cuối:** feature `done` chỉ khi `status.qa=done`. QA fail → `qa-bug-reporter` tạo defect → loop về BE/FE (status.be/fe về `review`).
- **Shift-left:** qa-test-case-writer viết case khi `status.ba=done` (có US/AC), không chờ build.

## 6. Scoring + anti-hallucination (qa-reviewer — theo `wiki/SCORING.md`)
- **① Faithfulness:** mọi test case trace 1 AC/US (No test without AC-source — mirror BA No-source rule); không test hành vi ngoài spec.
- **② Attribution/Evidence:** kết quả "pass" phải có evidence (log/screenshot/trace) — pass không evidence = bịa → <5. Finding gắn file:line.
- **⑤ Contradiction:** kết quả test mâu thuẫn spec/contract; test flaky (pass/fail không ổn định) = bất định.
- **Quality dims:** AC-coverage · 3-case-completeness (Happy/Edge/Error) · defect-quality (repro rõ) · automation-stability.
- Gate + append `wiki/quality-trend.md` (discipline=QA).

## 7. Giai đoạn build
| P | Nội dung | Output "chạy được" |
| --- | --- | --- |
| **P1 Khung** | qa-project-template + _project-root + qa-orchestrator + wiki/qa overlay + FEAT thêm qa + install/bootstrap + vendored shared + README | bootstrap ra project QA |
| **P2 Lõi manual** | qa-intake-classifier → qa-test-planner → qa-test-case-writer → qa-reviewer(+scoring) → qa-wiki-logger | manual QA end-to-end + gate |
| **P3 Execution+defect** | qa-test-executor + qa-bug-reporter + QA_COVERAGE_MATRIX + FEAT gate wiring | chạy + log defect + gate feature |
| **P4 Automation** | qa-automation-builder (Playwright+Karate) + qa-regression-manager + qa-git-committer + qa-e2e/api skills | automation E2E/API + regression |

## 8. Việc chạm bộ khác (cross-repo)
- `shared-wiki-template/features/_template.md` + `README.md`: thêm `qa` (needs/deps/status/gate) → sync 4 bộ.
- be/fe/ba orchestrator: khi feature done, không set `status=done` toàn cục cho tới khi QA pass (FEAT gate).
- `sync-shared-wiki.sh`: thêm `tester-skill` vào danh sách đích.
