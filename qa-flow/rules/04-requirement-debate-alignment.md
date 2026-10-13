# 04 — Requirement Debate & Alignment

Giai đoạn **bắt buộc** trước Test Design. Chạy trong hội thoại chính.

> Thảo luận để hiểu requirement đã được viết ra — không để sáng tạo, mở rộng hay định nghĩa lại.

## 1. Thứ tự (người dùng chốt 2026-10-13)

S4 gồm **hai nửa**: **4a — lập câu hỏi gửi BA** và **4b — Debate giữa người dùng (QA) và AI** để cả hai cùng
hiểu nghiệp vụ. 4a đi trước; 4b bắt đầu ngay với phần **không phụ thuộc BA** trong lúc chờ, và hoàn tất phần còn
lại khi BA trả lời. Không mở cổng khi chưa debate xong các nhóm có điểm trọng yếu.

### 4a — Lập và gửi câu hỏi cho BA

1. Lấy bảng "Điểm chưa rõ" từ `01-requirement-analysis.md`.
2. Với mỗi điểm, lập một câu hỏi gồm đủ:
   - **Nguồn:** trích dẫn + `tệp:dòng`.
   - **Vì sao chưa rõ:** thiếu điều kiện, mâu thuẫn, nhiều nghĩa, dẫn chiếu treo…
   - **Các cách hiểu:** chỉ liệt kê cách hiểu **có căn cứ từ tài liệu**, mỗi cách kèm căn cứ.
   - **Ảnh hưởng:** mỗi cách hiểu đổi hành vi / phạm vi test case nào.
   - **Cần xác nhận gì, từ ai** (BA / Dev / Product).
   - **Mức:** trọng yếu / không trọng yếu (§3), do AI đề xuất, người dùng chốt.
3. Trình bày cho người dùng theo nhóm, người dùng chốt mức; ghi thành `cau-hoi-gui-BA.md` trong thư mục feature
   (bảng, có cột "BA trả lời", chia Phần A trọng yếu / Phần B không trọng yếu; cuối file có bảng `## Lịch sử cập nhật`
   nội bộ). Người dùng gửi cho BA.
4. Khi người dùng chuyển câu trả lời vào phiên: ghi vào bảng câu hỏi của `02-alignment-summary.md` — nội dung,
   **ai trả lời**, ngày, kênh (vd "BA Lan, 2026-10-09, chat nhóm — QA chuyển lại"). Câu trả lời chưa đủ ý →
   tách phần thiếu thành câu hỏi mới, không tự lấp.

### 4b — Debate giữa người dùng và AI (sau khi BA trả lời)

Mục tiêu: cả hai cùng hiểu nghiệp vụ như nhau trước khi thiết kế. **Không phải chờ BA xong mới bắt đầu:** trong
lúc chờ BA, debate ngay những nhóm BR / luồng **đã rõ, không phụ thuộc câu hỏi nào** (hoặc chỉ phụ thuộc câu đã có
trả lời). Nhóm còn chạm câu hỏi mở thì để lại, debate khi BA trả lời. Thứ tự gợi ý: nhóm rõ → nhóm đã có BA → nhóm
còn chờ.

5. AI tóm tắt nghiệp vụ theo từng nhóm BR / luồng, **kèm câu trả lời BA đã ghép vào**, và nêu cách AI đọc từng chỗ
   còn có thể hiểu khác. Hỏi người dùng đọc thế nào; đi từng nhóm nhỏ, không dồn một lượt.
6. Hai bên lệch nhau → chỉ ra chỗ lệch và căn cứ của mỗi bên. Cả hai đều có căn cứ trong tài liệu → nâng thành
   điểm trọng yếu, quay lại 4a. Một bên không có căn cứ → theo bên có căn cứ, ghi lại.
7. Ghi kết quả vào `02-alignment-summary.md` mục 4 "Cách hiểu đã thống nhất": mỗi dòng có nhãn — `[ĐÃ XÁC NHẬN]`
   nếu dựa trên câu trả lời BA, `[GIẢ ĐỊNH]` nếu chỉ là cách hiểu chung của QA và AI cho điểm còn chờ. Mục này
   là căn cứ để Test Designer viết kỳ vọng và quyết định case `❓` theo hướng nào.
8. Debate xong, điểm trọng yếu còn mở = 0 → đề nghị người dùng xác nhận mở cổng (S5).

## 2. Ai xác nhận

- Điểm **trọng yếu** chỉ đóng khi có câu trả lời của **BA** (hoặc Dev/Product đúng thẩm quyền), do người
  dùng chuyển vào phiên. Ý kiến riêng của QA hoặc của AI không đóng được điểm trọng yếu.
- Người dùng nói "tôi nghĩ là…" mà không nêu BA đã trả lời → ghi `[GIẢ ĐỊNH]`, điểm vẫn mở, hỏi lại một lần
  xem đây có phải câu trả lời của BA không.
- Mở cổng là quyết định của người dùng, sau khi điều kiện đủ **và đã debate (4b)**. Cổng mở mà chưa debate là sai
  thứ tự — Orchestrator phải nói rõ và đề nghị debate trước.

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
