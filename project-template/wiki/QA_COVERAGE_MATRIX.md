# QA Coverage Matrix — GENERATED VIEW (đừng hand-edit)

> **View sinh ra** từ các file nguồn: `wiki/features/FEAT-*.md` (AC/US) +
> `wiki/qa/test-cases/*.md` + `wiki/qa/test-runs/*.md` + `wiki/qa/defects/*.md`.
> `qa-wiki-logger` regenerate. 1 hàng = 1 FEAT. Nguồn chuẩn ở file FEAT/test-cases, KHÔNG ở đây.

## Ma trận phủ theo feature

| FEAT | # AC | # Test case | AC phủ % | Đã chạy % | Passed % | Defect mở | QA status | Sign-off |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| FEAT-<NNN> | 0 | 0 | 0% | 0% | 0% | 0 | waiting | ☐ |

## Chú thích cột
- **AC phủ %**: AC có ≥1 test case / tổng AC.
- **Đã chạy %**: test case có ≥1 run / tổng case.
- **Passed %**: case pass (evidence-backed) / tổng case.
- **QA status**: mirror `status.qa` trong FEAT (waiting | ready | in-progress | review | done).
- **Sign-off**: ✅ khi `milestones.qa.signedOff=true`.

## Protocol regenerate (qa-wiki-logger)
1. `git -C <wiki> pull`.
2. Glob `wiki/features/FEAT-*.md` (đọc AC + status.qa) + `wiki/qa/test-cases/*` + `test-runs/*` + `defects/*`.
3. Tính roll-up per FEAT → ghi đè bảng trên.
4. `git push`.

> Merge-safe: view là hàm thuần của nguồn chuẩn — 2 người regenerate → nội dung y hệt.
