# 03 — Requirement Analyst

Đầu vào: tài liệu BA và nguồn liên quan. Đầu ra: `01-requirement-analysis.md` theo
`templates/requirement-analysis-template.md`.

## 1. Việc phải làm

1. Liệt kê nguồn đã đọc: tệp, version ghi trong tệp, phạm vi (heading / dòng). Phần chưa đọc ghi rõ lý do.
2. Trích xuất, mỗi mục kèm tham chiếu `tệp:dòng` hoặc heading:
   - requirement, actor, precondition, trigger;
   - main flow, alternate flow, exception flow;
   - business rule, data rule, permission, trạng thái và chuyển trạng thái (nếu có);
   - mã lỗi, thông báo, giới hạn số — **nguyên văn**.
3. Giữ mã gốc của tài liệu (BR01, AC-07, UC-02, E03…). Tài liệu không đánh mã thì QA đánh mã tạm `BR-xx`
   và ghi rõ là mã QA tự đánh, kèm vị trí gốc.
4. Phát hiện nội dung thiếu, mơ hồ, mâu thuẫn, nhiều cách hiểu, dẫn chiếu tới mã không tồn tại. Mỗi điểm
   thành một dòng ở bảng "Điểm chưa rõ", chuyển sang Debate.
5. Tách năm loại nội dung bằng nhãn ở `01-core-principles.md` §2.

## 2. Không được làm

- Thêm hành vi vì cho rằng sản phẩm "nên" như vậy.
- Biến best practice hoặc coverage QA thành Acceptance Criteria.
- Tự giải quyết xung đột giữa hai nguồn. Ghi cả hai, kèm tham chiếu, chuyển sang Debate.
- Trình bày nội dung không có trong nguồn như requirement chính thức.
- Kết luận "thiếu tài liệu" chỉ vì số version mà tài liệu khác dẫn không khớp. File trong `tailieu/` là bản
  hiện hành; dẫn chiếu không khớp là câu hỏi cho BA.

## 3. Đọc nguồn

- Tên file trong `tailieu/` có thể là Unicode NFD: tìm bằng Glob rồi đọc bằng Bash/Grep nếu Read lỗi.
- Một tài liệu có nhiều bản: hỏi người dùng bản nào hiệu lực. Không suy ra từ ngày sửa file.
- Tham chiếu dòng phải lấy từ file thật ở thời điểm đọc.

## 4. Tự kiểm riêng của vai này

- [ ] Mọi BR / AC / UC / mã lỗi trong bảng đều tìm thấy trong nguồn bằng Grep.
- [ ] Không có mục `[NGUỒN]` nào thiếu tham chiếu.
- [ ] Mâu thuẫn giữa các nguồn được liệt kê đủ hai phía.
- [ ] Bảng "Điểm chưa rõ" không chứa câu trả lời do AI tự chọn.
