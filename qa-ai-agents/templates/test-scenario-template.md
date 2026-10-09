---
featureId: <ID>
basedOn: 02-alignment-summary.md (gate: open, <ngày mở>)
designedAt: <YYYY-MM-DD>
---

# Test Design — <ID>: <tên feature>

## 1. Use Case

| Mã | Tên | Actor | Nguồn |
| --- | --- | --- | --- |

## 2. Business Rule

| Mã | Tóm tắt | Trạng thái hiểu | Nguồn |
| --- | --- | --- | --- |

## 3. Decision Table

<một bảng cho mỗi BR có logic điều kiện — hoặc "Không áp dụng — <lý do>">

| Điều kiện / Hành động | R1 | R2 | R3 |
| --- | --- | --- | --- |
| C1: | | | |
| → Kết quả (nguồn) | | | |

## 4. State Transition

<bảng trạng thái × sự kiện — hoặc "Không áp dụng — nguồn không mô tả trạng thái">

## 5. Risk Analysis `[QA BỔ SUNG]`

| # | Rủi ro | Impact | Likelihood | Căn cứ | Liên quan BR / Q |
| ---: | --- | --- | --- | --- | --- |

## 6. Coverage Matrix

| BR / AC | Use Case | Decision / State | Scenario | Case nhóm A | Trạng thái (Đã phủ / Một phần / Chưa phủ) | Ghi chú |
| --- | --- | --- | --- | --- | --- | --- |

Lỗ hổng: requirement không có case · case không có nguồn · coverage chưa rõ.

Loại coverage đã cân nhắc và không áp dụng: <loại — lý do>

## 7. Test Scenario

| SC | Mô tả | BR / AC | Use Case | Loại coverage | Nhóm (A requirement / B QA bổ sung) |
| --- | --- | --- | --- | --- | --- |

## 8. Testcase Summary

| Nhóm | Số case | Positive | Negative | Edge case | Khác | Có `❓ Cần chốt` |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| A. Theo requirement | | | | | | |
| B. QA bổ sung | | | | | | |

Chi tiết case: `04-testcases.md`.

## 9. Regression Scope

| Khu vực | Vì sao bị ảnh hưởng | Căn cứ | Giới hạn phân tích |
| --- | --- | --- | --- |

## 10. Automation Candidate

| Case | Lý do phù hợp | Dependency · data · môi trường | Trạng thái (Candidate / Automated + đường dẫn script) |
| --- | --- | --- | --- |

## 11. Điểm cần quay lại Debate

| # | Nội dung + nguồn | Đề xuất mức | Case bị ảnh hưởng |
| ---: | --- | --- | --- |

## Lịch sử cập nhật

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
