---
period: <YYYY-MM>            # kỳ báo cáo (tháng / sprint)
reportedBy: <QA initials>
reportedAt: <YYYY-MM-DD>
rule: qa-point-scoring       # quy tắc áp dụng (skill ~/.claude/skills/qa-point-scoring)
---

# Báo cáo point QA — <kỳ>

> Quy tắc chấm: skill `qa-point-scoring`. Điểm ở đây là **khối lượng đầu việc**, không phải điểm
> chất lượng (xem `wiki/quality-trend.md` cho chất lượng review).
>
> Mọi dòng phải có bằng chứng trong artifact. Không chấm theo số case.

## 1. Tổng hợp task lớn

| # | Task lớn | Phân loại | Số subtask | Tổng point |
| ---: | --- | --- | ---: | ---: |
| 1 | <tên tính năng / đợt kiểm thử> | Tính năng | 0 | 0 |
| | **Tổng kỳ** | | **0** | **0** |

`Phân loại`: Tính năng · Cải tiến · Fix · Regression · Release.

## 2. Chi tiết subtask

| # | Nhóm | Task | Artifact | Cơ chế được phủ & cách verify | Bằng chứng | Size | Effort | Point | Lý do point |
| ---: | --- | --- | --- | --- | --- | :---: | :---: | ---: | --- |
| 1 | Thiết kế case | <tên cơ chế> | `qa/test-cases/<FEAT>.md` | <nhánh/trạng thái nào được kiểm; kỳ vọng lấy từ mục tài liệu nào; phạm vi kiểm lại> | `TC-<FEAT>-01→10` | M | E | 0.5 | <1 bằng chứng Size + 1 bằng chứng Effort> |

`Nhóm`: Rà soát tài liệu · Test plan · Thiết kế case · Automation · Execution · Defect · Regression.

## 3. Phần đã loại khỏi báo cáo

> Ghi lại để người review không phải hỏi lại, và để chứng minh đã lọc đúng.

| Đầu việc | Lý do loại |
| --- | --- |
| <vd: sửa 12 case viết sai kỳ vọng ở đợt trước> | Case do chính mình viết |
| <vd: chạy lại bộ smoke trên cùng build> | Không có build mới |
| <vd: đánh lại số TC cho đồng bộ> | Đổi format, không đổi hành vi được kiểm |

## 4. Đầu việc chưa chấm được

| Đầu việc | Thiếu gì để chấm |
| --- | --- |
| <vd: execution FEAT-xxx> | Chưa có file test-run / chưa có evidence |
| <vd: bộ case do 2 người cùng viết> | Artifact thiếu bảng lịch sử cập nhật, không tách được khoảng mã TC |

## 5. Tự kiểm trước khi gửi

- [ ] Mỗi subtask có bằng chứng (khoảng TC / mã BUG / file test-run / đường dẫn automation)
- [ ] Không dòng nào chấm theo số case, số dòng bảng, số screenshot, số lần chạy
- [ ] Execution chỉ tính khi evidence tồn tại thật
- [ ] Bản diễn đạt lại không chấm lại cơ chế của bản gốc
- [ ] Defect chấm theo độ khó tái hiện, không theo mức nghiêm trọng
- [ ] Không subtask nào vượt 2 point
- [ ] Cột `Lý do point` có đủ bằng chứng Size + Effort
- [ ] Tổng task lớn = tổng subtask; tổng kỳ = tổng các task lớn

## 6. Lịch sử cập nhật

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
| <YYYY-MM-DD> | <QA> | Tạo báo cáo |
