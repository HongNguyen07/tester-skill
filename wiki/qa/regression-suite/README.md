# wiki/qa/regression-suite/ — Bộ hồi quy (regression)

> Tập hợp test case ổn định, chạy lại mỗi release để bắt hồi quy. `qa-regression-manager`
> quản lý: chọn case đưa vào suite, tag theo module/feature, theo dõi coverage per release.

## Quy tắc đưa case vào suite
- Case đã pass ổn định ≥ 1 lần, thuộc luồng nghiệp vụ chính hoặc từng có defect (regression guard).
- Ưu tiên automate (Playwright/Karate) để chạy nhanh, lặp lại.
- Case flaky (pass/fail thất thường) → KHÔNG đưa vào suite tới khi ổn định (đánh dấu quarantine).

## Cấu trúc
```
regression-suite/
  README.md              (file này)
  suite-<module>.md      (danh sách case theo module)
  release/v<x.y.z>.md    (kết quả chạy regression cho 1 release)
```

## Bảng suite mẫu (suite-<module>.md)

| TC id | Feature | Automated? | Tag | Trạng thái mới nhất |
| --- | --- | --- | --- | --- |
| TC-042-01 | FEAT-042 | ✅ Playwright | smoke, checkout | Passed |

## Coverage per release
- % luồng critical được regression phủ.
- Case quarantine (flaky) đang chờ ổn định.
