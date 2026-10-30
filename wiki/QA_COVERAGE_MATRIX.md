# QA Coverage Matrix — GENERATED VIEW (đừng hand-edit)

> **View sinh ra** từ các file nguồn: `wiki/features/FEAT-*.md` (AC/US) +
> `wiki/qa/test-cases/*.md` + `wiki/qa/test-runs/*.md` + `wiki/qa/defects/*.md`.
> `qa-wiki-logger` regenerate. 1 hàng = 1 FEAT. Nguồn chuẩn ở file FEAT/test-cases, KHÔNG ở đây.

## Ma trận phủ theo feature

> **Lưu ý regenerate 2026-09-28:** project chưa có `wiki/features/FEAT-*.md` cho 2 dòng dưới
> (nguồn = raw spec `wiki/document/srs/*.md`). Cột "FEAT" ghi id + `(no FEAT spine)`; cột
> "# AC"/"QA status" là suy ra từ chính file test-cases (không có `status.qa`/milestones để mirror).
> `git pull` bị skip (agent chạy này không có Bash) — số liệu đọc trực tiếp từ working tree.

| FEAT | # AC | # Test case | AC phủ % | Đã chạy % | Passed % | Defect mở | QA status | Sign-off |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| ZALO-OTP *(no FEAT spine)* | n/a¹ | 102 | 100%² | 0% | 0% | 0 | in-progress | ☐ |
| Z-02 *(no FEAT spine)* | 31 | 95 | 100%³ | 0% | 0% | 0 | in-progress | ☐ |

¹ Spec ZALO-OTP không đánh số AC — trace theo Section/S-step; proxy gần nhất là errorCode
(spec `tailieu/7` + `tailieu/8`): **17/17 = 100%** (thêm 30029 `account_already_verified` + 11000 cho verify; xem `qa/test-cases/ZALO-OTP.md` §2.9).
² Cập nhật 2026-10-02 theo `tailieu/8-verify-ma-otp.md` (verify-zalo-otp): 90→102 case (TC-91→102).
98/102 case đã resolve; 4 case ❓ (TC-04, TC-06 Gap #6; TC-11 Gap #5; TC-67 Gap #7) và 2 case ⚠️
(TC-60, TC-99 — Gap #8, thứ tự kiểm tra 30029/30014 vs 30028/30025) chờ BA/BE; không tính vào coverage
cho tới khi trả lời (không loại khỏi ma trận AC vì dòng đó vẫn có case khác phủ). Review: 85/100 pass (lần 2).
Gap còn mở: #1–#8 (xem `qa/test-cases/ZALO-OTP.md` §3; HB-002/HB-004/HB-005).
³ 31/31 AC (§11 spec) có ≥1 case không phụ thuộc gap; 17/95 case đánh dấu ❓ chờ 18 OQ ở
`qa/test-cases/Z-02.md` §3 (không ảnh hưởng tỉ lệ AC phủ vì mỗi AC còn case khác đã executable).
Đã chạy %/Passed % = 0% cho cả 2 dòng — `qa/test-runs/` chỉ có `_template.md`, chưa có run nào.
Defect mở = 0 — `qa/defects/` chỉ có `_template.md`, chưa có defect nào được tạo.

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
