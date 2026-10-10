# 10 — Human-in-the-loop

## 1. Bắt buộc dừng khi

- Requirement mơ hồ, mâu thuẫn hoặc thiếu thông tin trọng yếu.
- Có nhiều cách hiểu ảnh hưởng tới hành vi nghiệp vụ, permission, security hoặc dữ liệu.
- Có đề xuất thay đổi scope hoặc Business Requirement.
- Có rủi ro bảo mật, quyền hạn, dữ liệu nhạy cảm.
- Severity / priority hoặc root cause chưa đủ bằng chứng.
- Cần chấp nhận rủi ro hoặc quyết định release.
- Hành động có tính phá hủy hoặc ảnh hưởng dữ liệu / môi trường.
- Chuyển UX/CX suggestion thành yêu cầu chính thức.
- Mở cổng Alignment (`CLAUDE.md` §2).

## 2. Khi dừng phải nêu

1. Điểm đang chờ quyết định.
2. Nguồn và bằng chứng hiện có.
3. Vì sao không thể tự quyết.
4. Các lựa chọn **được tài liệu hỗ trợ**, nếu có. Không có thì nói không có.
5. Ảnh hưởng nếu chưa giải quyết (case nào bị chặn, phần nào vẫn làm tiếp được).
6. Ai cần xác nhận, loại quyết định cần có.

## 3. Ai quyết định gì

| Quyết định | Người quyết |
| --- | --- |
| Cách hiểu điểm trọng yếu của tài liệu | BA (Dev / Product theo thẩm quyền); QA chuyển câu trả lời vào phiên |
| Mở cổng Alignment | Người dùng (QA), sau khi điểm trọng yếu còn mở = 0 |
| Mức trọng yếu của một điểm | AI đề xuất, người dùng chốt |
| Đưa đề xuất CX / Change Proposal thành requirement | Product / BA, và nguồn chính thức phải được cập nhật |
| Severity / priority, root cause, chấp nhận rủi ro, release | Người có thẩm quyền; AI chỉ đề xuất kèm lý do |

## 4. Cách hỏi

- Hỏi theo hội thoại, từng câu hoặc nhóm nhỏ câu liên quan; không đưa form dài trừ khi cần thu nhiều thông tin
  độc lập.
- Không hỏi lại điều đã được chốt trong Alignment Summary hoặc `knowledge/decisions.md`.
- Trong lúc chờ, tiếp tục phần không phụ thuộc câu trả lời và nói rõ phần nào đang làm tiếp.
- Đề xuất do AI tự thêm gắn nhãn **ĐỀ XUẤT**, kèm lý do; chưa được đồng ý thì không coi là đã chốt.
