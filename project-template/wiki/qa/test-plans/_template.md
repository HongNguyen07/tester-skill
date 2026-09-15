---
id: TP-<FEAT>
feature: FEAT-<NNN>
createdBy: <QA initials>
createdAt: <YYYY-MM-DD>
status: Draft          # Draft | Ready | Executing | Signed-off
---

# TP-<FEAT>: Test Plan — <Tên feature>

> Test plan cho 1 FEAT. Nguồn AC/US = `wiki/features/FEAT-<NNN>.md` (mục 2 Trace).
> Test-DESIGN có thể bắt đầu khi `status.ba=done` (shift-left).

## 1. Scope
- **In scope (QA black-box):** <acceptance / system / E2E / regression / a11y ...>
- **Out of scope (dev sở hữu):** unit / integration / contract (BE/FE tự lo)
- **FEAT:** FEAT-<NNN> — <1 câu tóm tắt>

## 2. Test types áp dụng
| Type | Có? | Ghi chú |
| --- | --- | --- |
| Acceptance (theo AC) | ✅ | |
| System / E2E | | |
| Regression | | |
| Exploratory | | |
| Accessibility (a11y) | | |
| Perf-smoke | | |

## 3. Môi trường + dữ liệu
- **Env:** local / staging / uat
- **Test data:** <fixtures, tài khoản, tenant — tránh rò rỉ tenant>
- **Automation:** Playwright (E2E web) · REST-assured/Karate (API BE)

## 4. Entry / Exit criteria
- **Entry (execution):** `deps.qa` thỏa — be.done + fe.done (theo needs); contract công bố.
- **Exit (sign-off):**
  - AC coverage = 100% (mỗi AC ≥ 1 test case)
  - Blocking severity pass 100%, không còn defect critical mở
  - Evidence đầy đủ cho mọi case pass

## 5. Rủi ro / lane
- Lane: tiny | normal | high-risk (từ `wiki/RISK_LANES.md` § QA)
- Hard gates chạm: <auth / payment / data-integrity / cross-service-e2e / multi-tenant>

## 6. Liên kết
- Test cases: `wiki/qa/test-cases/<FEAT>.md`
- Test runs: `wiki/qa/test-runs/<FEAT>_*.md`
- FEAT: `wiki/features/FEAT-<NNN>.md`
