---
feature: FEAT-<NNN>
plan: TP-<FEAT>
createdBy: <QA initials>
createdAt: <YYYY-MM-DD>
---

# Test Cases — FEAT-<NNN>: <Tên feature>

> Viết theo rule ở skill `qa-test-case-writing`. **Không đổi tên, không đổi thứ tự, không thêm bớt cột.**
> Mỗi test case PHẢI có **Trace BR** (No test without source).

| Mục | Giá trị |
|---|---|
| Tên màn hình/Tên chức năng | <TÊN_CHỨC_NĂNG> |
| Thiết bị, hệ điều hành | <vd Chrome 129 / Windows 11> |
| Mã trường hợp kiểm thử | <MHx> |

**Manual test**

| Chỉ số | Số lượng |
|---|---|
| Số trường hợp kiểm thử đạt (P) | 0 |
| Số trường hợp kiểm thử không đạt (F) | 0 |
| Số trường hợp kiểm thử đang xem xét (NA) | 0 |
| Số trường hợp kiểm thử chưa thực hiện | 3 |
| Tổng số trường hợp kiểm thử | 3 |

## Bảng test case

| Test Case ID | Purpose | Category | Trace BR | Precondition | Steps | Data | Expected Result | Round 1 | Round 2 | Round 3 | Error Code | Note | Date | Tester |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| **<Nhóm 1 — vd BR01 — tên quy tắc>** | | | | | | | | | | | | | | |
| [MHx_01] | <1 câu: case kiểm gì> | Positive | BR01 · UC-01 · AC-01 | <trạng thái, quyền, dữ liệu có sẵn> | 1. Bấm …<br>2. Nhập …<br>3. Bấm … | <giá trị cụ thể> | <kết quả kiểm chứng được; thông báo chép nguyên văn trong "…"> | Todo | Todo | Todo | | Ưu tiên P1<br>Nguồn: <tệp:dòng "trích"><br>Evidence: screenshot | | |
| [MHx_02] | <biên / tình huống hiếm> | Edge case | BR01 · AC-02 | - | 1. …<br>2. … | biên: min / max / rỗng | <…> | Todo | Todo | Todo | | Ưu tiên P2<br>Nguồn: <…><br>Evidence: screenshot | | |
| **<Nhóm 2 — vd BR02 — tên quy tắc>** | | | | | | | | | | | | | | |
| [MHx_03] | <input sai / vi phạm rule> | Negative | BR02 · E01 | - | 1. …<br>2. … | <input sai> | Báo lỗi "<thông báo nguyên văn>"; không lưu<br>**Mã lỗi kỳ vọng:** ERR-<NNN>-01 | Todo | Todo | Todo | | Ưu tiên P1<br>Nguồn: <…><br>Evidence: log | | |

## Ma trận BR → case (đảm bảo phủ)

| BR | Nội dung rút gọn | Test case phủ | Đã phủ? |
|---|---|---|---|
| BR01 | <…> | [MHx_01], [MHx_02] | ✅ |
| BR02 | <…> | [MHx_03] | ✅ |

> qa-reviewer chấm: BR nào **không** có case → điểm faithfulness/coverage tụt; BR "phủ" nhưng
> case rỗng/không executable, hoặc chỉ có case đang `❓ Cần chốt` → không tính là đã phủ.

## Câu hỏi cần chốt (nếu có)

| # | Câu hỏi | Test case liên quan | Người trả lời | Trả lời |
|---|---|---|---|---|
| Q1 | <điểm tài liệu chưa rõ> | [MHx_02] | BA / PO / Dev | |
