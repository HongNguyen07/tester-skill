---
featureId: <ID>
title: <tên feature>
analyzedAt: <YYYY-MM-DD>
analyst: Requirement Analyst (AI) — người dùng: <tên>
---

# Requirement Analysis — <ID>: <tên feature>

## 1. Nguồn và phạm vi đã đọc

| # | Tệp | Version ghi trong tệp | Phạm vi đã đọc (heading / dòng) | Ghi chú |
| ---: | --- | --- | --- | --- |
| 1 | `tailieu/<tệp>` | | | |

Chưa đọc / ngoài phạm vi: <nêu rõ, kèm lý do>

## 2. Mục tiêu và phạm vi feature `[NGUỒN]`

<1–3 câu, kèm tham chiếu>

## 3. Actor, precondition, trigger

| Mục | Nội dung | Nguồn | Nhãn |
| --- | --- | --- | --- |
| Actor | | `tệp:dòng` | `[NGUỒN]` |

## 4. Use case và luồng

| Mã | Tên | Main flow | Alternate flow | Exception flow | Nguồn |
| --- | --- | --- | --- | --- | --- |
| UC-01 | | | | | |

## 5. Business rule

| Mã | Nội dung (sát nguyên văn) | Loại (nghiệp vụ / dữ liệu / quyền) | Nguồn | Nhãn |
| --- | --- | --- | --- | --- |
| BR01 | | | `tệp:dòng` | `[NGUỒN]` |

Mã do QA tự đánh (nếu tài liệu không đánh mã): <liệt kê, kèm vị trí gốc>

## 6. Acceptance criteria, mã lỗi, thông báo, giới hạn số

| Mã | Nguyên văn | Nguồn |
| --- | --- | --- |
| AC-01 | | |

## 7. Trạng thái và chuyển trạng thái

<bảng trạng thái — hoặc "Không áp dụng — nguồn không mô tả trạng thái">

## 8. Diễn giải, giả định, QA observation

| # | Nội dung | Nhãn | Liên quan tới |
| ---: | --- | --- | --- |
| 1 | | `[DIỄN GIẢI AI]` / `[GIẢ ĐỊNH]` / `[QA BỔ SUNG]` | BR.. |

## 9. Điểm chưa rõ (chuyển sang Debate)

| # | Loại (thiếu / mơ hồ / mâu thuẫn / nhiều cách hiểu / dẫn chiếu treo) | Trích dẫn + nguồn | Vì sao chưa rõ | Đề xuất mức (trọng yếu / không) |
| ---: | --- | --- | --- | --- |
| 1 | | | | |

## 10. Tự rà soát

- [ ] Mọi mã ở mục 4–6 tìm thấy trong nguồn
- [ ] Không mục `[NGUỒN]` nào thiếu tham chiếu
- [ ] Mâu thuẫn giữa nguồn đã liệt kê đủ hai phía
- [ ] Mục 9 không chứa câu trả lời do AI tự chọn
