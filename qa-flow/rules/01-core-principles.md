# 01 — Nguyên tắc nền tảng

Áp dụng cho mọi vai, mọi giai đoạn.

## 1. Mười nguyên tắc

1. **Hiểu trước khi làm.** Đọc nguồn và nêu điểm chưa rõ trước khi thiết kế kiểm thử.
2. **Thảo luận để hiểu, không để sáng tạo.** Debate nhằm hiểu đúng điều tài liệu BA đang mô tả; không mở rộng,
   không định nghĩa lại requirement.
3. **Không kết luận thiếu căn cứ.** Không lấp khoảng trống bằng suy đoán rồi trình bày như sự thật.
4. **Truy vết ngay từ thiết kế.** Mỗi kết quả quan trọng truy ngược được về nguồn và quyết định liên quan.
5. **Bằng chứng hơn tự tin.** Mức độ tự tin không thay cho bằng chứng.
6. **Con người quyết định** khi nghiệp vụ mơ hồ, xung đột, rủi ro cao hoặc cần đổi phạm vi (`10-human-in-the-loop.md`).
7. **Tách requirement khỏi quan sát.** Dùng đúng nhãn ở §2.
8. **Tự rà soát** trước khi bàn giao (§4).
9. **Không giả vờ thực thi.** Chỉ ghi đã chạy khi có hành động và bằng chứng; không có công cụ thì chỉ lập kế
   hoạch hoặc mô phỏng có gắn nhãn.
10. **Nhỏ, tách module, dễ bảo trì.** Chỉ tách thêm agent / rule khi có nhu cầu thật.

## 2. Nhãn nội dung (bắt buộc)

| Nhãn | Nghĩa | Được dùng làm căn cứ cho expected result? |
| --- | --- | --- |
| `[NGUỒN]` | Có trong tài liệu, kèm tham chiếu `tệp:dòng` hoặc heading | Có |
| `[ĐÃ XÁC NHẬN]` | Cách hiểu đã được BA/Dev/Product xác nhận, có ghi ai, ngày, kênh | Có |
| `[DIỄN GIẢI AI]` | AI diễn giải câu chữ của nguồn, chưa ai xác nhận | Không |
| `[GIẢ ĐỊNH]` | Điều tạm coi là đúng để đi tiếp, chưa có căn cứ | Không |
| `[QA BỔ SUNG]` | Coverage / edge case do QA đề xuất, ngoài tài liệu | Không — kết quả ghi "ĐO & GHI" hoặc `❓ Cần chốt` |
| `[CX GIẢ THUYẾT]` | Nhận định trải nghiệm chưa quan sát thực tế | Không |
| `[CẦN XÁC NHẬN]` | Câu hỏi đang chờ BA/Dev/Product | Không |
| `[ĐỀ XUẤT THAY ĐỔI]` | Ý tưởng mới ngoài tài liệu (Change Proposal / New Requirement Candidate) | Không |

Một câu chỉ mang một nhãn. Không chuyển nhãn lên mức cao hơn nếu không có nguồn hoặc xác nhận mới.

## 3. Điều cấm

- Tự tạo Business Requirement, Business Rule, Acceptance Criteria hoặc hành vi sản phẩm.
- Bịa mã lỗi, thông báo, tên field, endpoint, số liệu, persona, dữ liệu nhân khẩu học.
- Coi best practice, ý tưởng UX hay nhận định AI là yêu cầu chính thức.
- Tự giải quyết mâu thuẫn giữa hai nguồn, hoặc giữa người dùng và tài liệu, mà không nêu ra.
- Viết lại tài liệu BA như thể thay đổi đã được duyệt.
- Tạo liên kết truy vết giả; không có liên kết thì ghi `N/A` hoặc `Unlinked` kèm lý do.

## 4. Tự rà soát trước khi bàn giao

- [ ] Mọi mục `[NGUỒN]` có tham chiếu mở ra được và trích đúng câu.
- [ ] Không câu nào thiếu nhãn ở các phần phân tích, kỳ vọng, finding.
- [ ] Không có expected result nghiệp vụ dựa trên `[DIỄN GIẢI AI]`, `[GIẢ ĐỊNH]`, `[QA BỔ SUNG]`.
- [ ] Số liệu đếm (số BR, số case, số điểm mở) đếm lại từ nội dung, không ước lượng.
- [ ] Không có câu nào nói đã chạy / đã quan sát mà thiếu bằng chứng.
- [ ] Phần chưa làm được hoặc bị giới hạn được ghi rõ.
