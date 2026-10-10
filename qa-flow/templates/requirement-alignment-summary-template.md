---
featureId: <ID>
stage: S4
gate: closed            # closed | open — chỉ người dùng mở
materialOpen: <n>       # điểm trọng yếu còn mở; phải = 0 mới được mở cổng
nonMaterialOpen: <n>
gateOpenedBy:
gateOpenedAt:
updatedAt: <YYYY-MM-DD>
---

# Requirement Understanding / Alignment Summary — <ID>: <tên feature>

## 1. Nguồn và phạm vi đã đọc

<tóm tắt, trỏ tới mục 1 của `01-requirement-analysis.md`>

## 2. Requirement / Use case / Business rule đã trích

| Mã | Tóm tắt | Nguồn | Trạng thái hiểu |
| --- | --- | --- | --- |
| BR01 | | `tệp:dòng` | `[NGUỒN]` rõ / `[ĐÃ XÁC NHẬN]` Q-01 / còn mở Q-02 |

## 3. Bảng câu hỏi debate

| Q | Mức | Trích dẫn + nguồn | Vì sao chưa rõ | Các cách hiểu có căn cứ (kèm căn cứ) | Ảnh hưởng tới test | Cần ai xác nhận | Trạng thái | Câu trả lời | Ai trả lời · ngày · kênh |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Q-01 | Trọng yếu | | | (a) … (b) … | | BA | Mở / Đã xác nhận / Unresolved — BA Clarification Required | | |

## 4. Cách hiểu đã xác nhận `[ĐÃ XÁC NHẬN]`

| # | Nội dung | Từ câu hỏi | Ai xác nhận · ngày | Tài liệu đã cập nhật chưa |
| ---: | --- | --- | --- | --- |
| 1 | | Q-01 | | Chưa — ghi chú cho BA |

## 5. Các cách hiểu khác nhau còn tồn tại

<mỗi điểm: các cách hiểu, căn cứ từng cách, case bị ảnh hưởng — hoặc "Không còn">

## 6. Điểm đã thống nhất và điểm còn mở

- Đã thống nhất: <danh sách Q>
- Còn mở — **trọng yếu**: <danh sách Q; phải rỗng để mở cổng>
- Còn mở — không trọng yếu (đã cô lập): <Q, kèm phần phạm vi / case bị ảnh hưởng>

## 7. Cần BA / Dev / Product xác nhận

| Q | Gửi ai | Nội dung gửi (copy được) | Hạn / ghi chú |
| --- | --- | --- | --- |

## 8. Ngoài phạm vi / chưa có căn cứ

<nội dung không thuộc phạm vi; hành vi tài liệu không nói>

## 9. Change Proposal / New Requirement Candidate `[ĐỀ XUẤT THAY ĐỔI]`

| CP | Ý tưởng | Ai nêu · ngày | Trạng thái |
| --- | --- | --- | --- |

Không thuộc requirement đã trích. Chỉ thành requirement khi người có thẩm quyền duyệt và nguồn được cập nhật.

## 10. QA coverage bổ sung dự kiến `[QA BỔ SUNG]`

<edge case / coverage ngoài tài liệu QA định thêm — không phải yêu cầu của BA>

## 11. Xác nhận mở cổng

- [ ] Điểm trọng yếu còn mở = 0 (BA đã trả lời hết)
- [ ] Người dùng đã đọc mục 2–8
- Người dùng xác nhận: <tên · ngày · câu xác nhận nguyên văn>

## Lịch sử cập nhật

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
