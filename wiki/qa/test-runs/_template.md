---
feature: FEAT-<NNN>
runDate: <YYYY-MM-DD>
env: staging          # local | staging | uat
runBy: <QA initials>
mode: manual          # manual | automation | mixed
---

# Test Run — FEAT-<NNN> @ <YYYY-MM-DD>

> **Evidence-backed:** mỗi case `Passed` PHẢI có link evidence (screenshot/log/Playwright trace).
> Pass không evidence = KHÔNG tính pass (anti-hallucination rule).

## Kết quả

| TC id | Kết quả | Evidence | Ghi chú / defect |
| --- | --- | --- | --- |
| TC-<NNN>-01 | Passed | `runs/xxx/trace.zip` | |
| TC-<NNN>-02 | Passed | `screenshots/tc02.png` | |
| TC-<NNN>-03 | Failed | `logs/tc03.log` | → BUG-<NNN> |

## Tổng kết

- Tổng: N · Passed: X · Failed: Y · Blocked: Z
- AC coverage đạt: __%
- Blocking pass: __%
- Defect mở (critical): __

## Quyết định gate

- [ ] Đủ điều kiện sign-off? (AC 100% + blocking pass 100% + 0 critical mở)
- Nếu **có** → set `status.qa=done` + `milestones.qa.signedOff=true` trong FEAT + push.
- Nếu **không** → qa-bug-reporter tạo BUG + loop về BE/FE (status.be/fe → review).
