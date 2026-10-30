# Quality Trend — điểm review theo thời gian (APPEND-ONLY)

> **Metric evolution.** Mỗi lần review (BE/FE/BA) append 1 dòng. KHÔNG hand-edit lịch sử,
> KHÔNG xoá. Trả lời "chất lượng qua từng round/sprint có lên không". Rubric: `wiki/SCORING.md`.
>
> `weakDim` (dimension < 3) lặp lại ≥2 lần → mở `HARNESS_BACKLOG` (checklist-fix/skill-gap).
> Shared cả BA/BE/FE (wiki là repo chung team share).

| Ngày | Story/Artifact | FEAT | Discipline | Reviewer | Total /100 | ①Faith | ②Attr | ⑤Contra | Gate | weakDim | Loop iter |
|---|---|---|---|---|---|---|---|---|---|---|---|
| _(append khi có review đầu tiên)_ | | | | | | | | | | | |
| 2026-09-28 | TP-ZALO-OTP + test-cases/ZALO-OTP.md | ZALO-OTP | QA | qa-reviewer | 94 | 5 | 5 | 5 | pass | [] | 0 |
| 2026-10-02 | test-cases/ZALO-OTP.md + ZALO-OTP-nghiep-vu.md (update theo tailieu/8, design) | ZALO-OTP | QA | qa-reviewer | 77 | 4 | 3 | 4 | loop-back | [] | 0 |
| 2026-10-02 | test-cases/ZALO-OTP.md + ZALO-OTP-nghiep-vu.md (re-review sau fix, design) | ZALO-OTP | QA | qa-reviewer | 85 | 5 | 4 | 5 | pass | [] | 1 |
| 2026-10-07 | TP-CR-001 + test-cases/CR-001.md (111 case, 35 ❓, design; trục BR) | CR-001 | QA | qa-reviewer | 79 | 4 | 5 | 5 | loop-back | [] | 0 |
| 2026-10-08 | TP-CR-004 + test-cases/CR-004.md (76 case, 31 ❓, 11 ⚠, design; trục BR) | CR-004 | QA | qa-reviewer | 79 | 5 | 4 | 5 | loop-back | [] | 0 |
| 2026-10-08 | TP-G032 + test-cases/G032.md (164 case, 91 blocked/❓ trong đó 48 blocked-OQ01, design; trục BR; nguồn G032 (1)) | G032 | QA | qa-reviewer | 73 | 4 | 5 | 5 | loop-back | [acCoverage] | 0 |
| 2026-10-08 | TP-CR-004 + test-cases/CR-004.md (re-review sau fix, 79 case, 31 ❓, design; trục BR) | CR-004 | QA | qa-reviewer | 77 | 4 | 4 | 3 | escalate | [] | 1 |

## Đọc trend (khi cần)

- **Xu hướng total** theo thời gian per discipline → chất lượng lên/xuống.
- **Contra fail lặp lại** → seam BA↔BE↔FE hay đứt (contract drift) → ưu tiên fix.
- **weakDim lặp** → checklist/skill của dimension đó yếu → harness-improvement.
- **Loop iter cao** (builder phải sửa nhiều vòng) → builder/spec chưa tốt.
