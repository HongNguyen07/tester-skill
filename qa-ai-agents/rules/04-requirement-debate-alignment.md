# 04 — Requirement Debate & Alignment

Giai đoạn **bắt buộc** trước Test Design. Chạy trong hội thoại chính.

> Thảo luận để hiểu requirement đã được viết ra — không để sáng tạo, mở rộng hay định nghĩa lại.

## 1. Cách làm

1. Lấy bảng "Điểm chưa rõ" từ `01-requirement-analysis.md`.
2. Với mỗi điểm, lập một câu hỏi gồm đủ:
   - **Nguồn:** trích dẫn + `tệp:dòng`.
   - **Vì sao chưa rõ:** thiếu điều kiện, mâu thuẫn, nhiều nghĩa, dẫn chiếu treo…
   - **Các cách hiểu:** chỉ liệt kê cách hiểu **có căn cứ từ tài liệu**, mỗi cách kèm căn cứ.
   - **Ảnh hưởng:** mỗi cách hiểu đổi hành vi / phạm vi test case nào.
   - **Cần xác nhận gì, từ ai** (BA / Dev / Product).
   - **Mức:** trọng yếu / không trọng yếu (§3), do AI đề xuất, người dùng chốt.
3. Hỏi người dùng theo từng nhóm nhỏ, ưu tiên điểm trọng yếu. Không dồn tất cả vào một lượt nếu quá dài.
4. Ghi câu trả lời vào bảng câu hỏi của `02-alignment-summary.md`: nội dung, **ai trả lời**, ngày, kênh
   (vd "BA Lan, 2026-10-09, chat nhóm — QA chuyển lại").
5. Khi điểm trọng yếu còn mở = 0, xuất Alignment Summary và đề nghị người dùng xác nhận mở cổng.

## 2. Ai xác nhận

- Điểm **trọng yếu** chỉ đóng khi có câu trả lời của **BA** (hoặc Dev/Product đúng thẩm quyền), do người
  dùng chuyển vào phiên. Ý kiến riêng của QA hoặc của AI không đóng được điểm trọng yếu.
- Người dùng nói "tôi nghĩ là…" mà không nêu BA đã trả lời → ghi `[GIẢ ĐỊNH]`, điểm vẫn mở, hỏi lại một lần
  xem đây có phải câu trả lời của BA không.
- Mở cổng là quyết định của người dùng, sau khi điều kiện đủ.

## 3. Điểm trọng yếu

Một điểm là trọng yếu khi cách hiểu khác nhau làm đổi một trong các thứ sau:

- hành vi nghiệp vụ (kết quả, luồng, điều kiện rẽ nhánh);
- quyền hạn / phân quyền;
- bảo mật;
- dữ liệu (lưu gì, đồng bộ gì, mất gì);
- điều kiện chấp nhận.

Điểm chỉ ảnh hưởng câu chữ hiển thị, thứ tự trình bày, hay chi tiết không đổi kết quả pass/fail của nhóm case
chính thì là không trọng yếu — được cô lập và đi tiếp.

## 4. Ranh giới

- Mọi câu hỏi phải neo vào nội dung cụ thể của tài liệu. Không có chỗ neo thì không phải câu hỏi debate.
- Tài liệu không đủ căn cứ để xác định hành vi → ghi **Unresolved / BA Clarification Required**. Không suy diễn.
- Không ép người dùng chọn giữa các phương án khi tài liệu không hỗ trợ phương án nào; khi đó chỉ nêu
  "tài liệu không nói" và hỏi BA.
- Người dùng đưa ý tưởng ngoài tài liệu → không đưa vào requirement đã trích. Hỏi có muốn theo dõi không; nếu
  có, ghi ở mục **Change Proposal / New Requirement Candidate** với nhãn `[ĐỀ XUẤT THAY ĐỔI]`.
- Người dùng và tài liệu mâu thuẫn → chỉ ra chỗ mâu thuẫn, hỏi xác nhận. Không âm thầm ưu tiên bên nào.
- Coverage QA bổ sung lưu riêng, không dùng làm bằng chứng rằng BA đã yêu cầu.
- Câu trả lời của BA làm thay đổi tài liệu: ghi là `[ĐÃ XÁC NHẬN]` trong Alignment Summary và ghi chú "tài
  liệu chưa cập nhật"; không sửa file trong `tailieu/`.

## 5. Đầu ra

`02-alignment-summary.md` theo `templates/requirement-alignment-summary-template.md`, có đủ bảy mục:
nguồn và phạm vi đã đọc · requirement / use case / BR đã trích · cách hiểu đã xác nhận · các cách hiểu khác
nhau · điểm đã thống nhất và điểm còn mở · nội dung cần BA/Dev/Product xác nhận · ngoài phạm vi / chưa có căn cứ.
