---
feature: FEAT-<NNN>
plan: TP-<FEAT>
createdBy: <QA initials>
createdAt: <YYYY-MM-DD>
---

# Test Cases — FEAT-<NNN>: <Tên feature>

> **Mỗi test case PHẢI trace 1 AC/US** (No test without AC-source). Chuẩn 3 nhánh:
> **Happy / Edge / Error**. Case Error phải nêu **mã lỗi kỳ vọng** (khớp `error-codes` / contract).

## Bảng test case

| TC id | Trace (AC/US) | Loại | Tiền điều kiện | Bước | Dữ liệu | Kết quả kỳ vọng | Mã lỗi | Evidence-required |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| TC-<NNN>-01 | AC-1 / US-<NNN>-01 | Happy | | 1... 2... | | | — | screenshot |
| TC-<NNN>-02 | AC-2 | Edge | | | biên: min/max/rỗng | | — | screenshot |
| TC-<NNN>-03 | AC-3 | Error | | | input sai | báo lỗi | ERR-<NNN>-01 | log |

## Ma trận AC → case (đảm bảo phủ)

| AC | Test case phủ | Đã phủ? |
| --- | --- | --- |
| AC-1 | TC-<NNN>-01 | ✅ |
| AC-2 | TC-<NNN>-02 | ✅ |
| AC-3 | TC-<NNN>-03 | ✅ |

> qa-reviewer chấm: AC nào **không** có case → điểm faithfulness/coverage tụt; AC "phủ" nhưng
> case rỗng/không executable → không tính.
