# Quality Trend — điểm review theo thời gian (APPEND-ONLY)

> **Metric evolution.** Mỗi lần review (BE/FE/BA) append 1 dòng. KHÔNG hand-edit lịch sử,
> KHÔNG xoá. Trả lời "chất lượng qua từng round/sprint có lên không". Rubric: `wiki/SCORING.md`.
>
> `weakDim` (dimension < 3) lặp lại ≥2 lần → mở `HARNESS_BACKLOG` (checklist-fix/skill-gap).
> Shared cả BA/BE/FE (wiki là repo chung team share).

| Ngày | Story/Artifact | FEAT | Discipline | Reviewer | Total /100 | ①Faith | ②Attr | ⑤Contra | Gate | weakDim | Loop iter |
|---|---|---|---|---|---|---|---|---|---|---|---|
| _(append khi có review đầu tiên)_ | | | | | | | | | | | |

## Đọc trend (khi cần)

- **Xu hướng total** theo thời gian per discipline → chất lượng lên/xuống.
- **Contra fail lặp lại** → seam BA↔BE↔FE hay đứt (contract drift) → ưu tiên fix.
- **weakDim lặp** → checklist/skill của dimension đó yếu → harness-improvement.
- **Loop iter cao** (builder phải sửa nhiều vòng) → builder/spec chưa tốt.
