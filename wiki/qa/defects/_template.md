---
id: BUG-<NNN>
feature: FEAT-<NNN>
trace: AC-<x> / TC-<NNN>-0y
severity: major        # blocker | critical | major | minor | trivial
priority: P2           # P0 | P1 | P2 | P3
status: Open           # Open | Triaged | In-progress | Fixed | Verified | Closed | Rejected | Reopened
foundBy: <QA initials>
foundAt: <YYYY-MM-DD>
env: staging
assignee: null         # dev BE/FE nhận fix
---

# BUG-<NNN>: <Tiêu đề ngắn>

## Mô tả
<Cái gì sai, ở đâu>

## Repro (bắt buộc rõ ràng — reproducible)
1. ...
2. ...
3. ...

## Kỳ vọng vs Thực tế
- **Kỳ vọng:** <theo AC / contract>
- **Thực tế:** <observed>

## Evidence
- Screenshot / log / trace: `...`

## Liên kết
- FEAT: `wiki/features/FEAT-<NNN>.md`
- Test case: `wiki/qa/test-cases/<FEAT>.md#TC-<NNN>-0y`
- Test run: `wiki/qa/test-runs/<FEAT>_<date>.md`

## Vòng đời (defect lifecycle)
```
Open → Triaged → In-progress → Fixed → Verified → Closed
                                   └── (fail lại) → Reopened
Rejected (nếu không phải bug / ngoài scope)
```

## Changelog
| Ngày | Ai | Thay đổi trạng thái |
| --- | --- | --- |
| <date> | <QA> | Open |
