---
featureId: G028
stage: S6-S7
gate: open
materialOpen: 0
nonMaterialOpen: 6
gateOpenedBy: Hồng (QA)
gateOpenedAt: 2026-10-09
updatedAt: 2026-10-09
---

# Requirement Understanding / Alignment Summary — G028: Tắt / Bật thông báo hội thoại

Trạng thái: **cổng mở ngày 2026-10-09** do người dùng xác nhận. Không có điểm trọng yếu; 6 điểm không trọng yếu đã cô lập, chưa có câu trả lời của BA.

## 1. Nguồn và phạm vi đã đọc

Xem mục 1 của `01-requirement-analysis.md`. Nguồn chính: `tailieu/G028 - Tắt Bật thông báo hội thoại (1).md` (toàn bộ,
Status Draft, Last updated 2026-08-21). Đối chiếu thêm các dòng liên quan ở G027, G029, G009, G003, G024.

## 2. Requirement / Use case / Business rule đã trích

| Mã | Tóm tắt | Nguồn | Trạng thái hiểu |
| --- | --- | --- | --- |
| UC-01 | Tắt thông báo: chuông hoặc option menu → chọn thời hạn → tắt | `G028:40-46` | `[NGUỒN]` rõ |
| UC-02 | Bật lại: chuông đang tắt → "Bật thông báo" → bật ngay, hủy hẹn giờ | `G028:50-53` | `[NGUỒN]` rõ |
| BR01 | 4 thời hạn; quy tắc "Đến 8 giờ sáng" | `G028:81` | `[NGUỒN]` rõ — còn mở Q-04 (múi giờ) |
| BR02 | Hết hạn → tự bật lại, chuông về trạng thái bật | `G028:82` | `[NGUỒN]` rõ |
| BR03 | Bật thủ công → hủy hẹn giờ ngay | `G028:83` | `[NGUỒN]` rõ |
| BR04 | Tắt lại khi đang tắt → reset về mốc mới, không cộng dồn | `G028:84` | `[NGUỒN]` rõ ở nhánh chính — còn mở Q-02 |
| BR05 | Đang tắt: không phát thông báo; số chưa đọc vẫn hiển thị; vẫn nhận và lưu tin | `G028:85` | `[NGUỒN]` rõ ở nhánh tin nhắn mới — còn mở Q-01, Q-03 |
| BR06 | Per-user; xử lý phía Gopany | `G028:86` | `[NGUỒN]` rõ — ghi chú Q-05 |
| E01 | Thao tác thất bại → toast, giữ trạng thái cũ | `G028:73` | `[NGUỒN]` rõ |
| G027 BR04 | Ngoại lệ luôn báo dù đã tắt: @Mention, Mất kết nối, Nhắc hẹn Cá nhân | `G027:88` | `[NGUỒN]` rõ (ở G027) |
| G029 BR06 | Hội thoại đã tắt vẫn cộng chưa đọc | `G029:95` | `[NGUỒN]` rõ |

## 3. Bảng câu hỏi debate

| Q | Mức (đề xuất) | Trích dẫn + nguồn | Vì sao chưa rõ | Các cách hiểu có căn cứ | Ảnh hưởng tới test | Cần ai xác nhận | Trạng thái | Câu trả lời | Ai trả lời · ngày · kênh |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Q-01 | Không trọng yếu | `G028:85`; `G027:88` | G028 không nhắc ngoại lệ; G027 có ba ngoại lệ "luôn báo dù đã tắt" | (a) Ngoại lệ G027 áp dụng — căn cứ `G027:88`, `G027:112`, `G028:143` (nội dung thông báo thuộc G027). (b) Tắt là tắt hết — căn cứ chữ của `G028:85` không có ngoại lệ | Case @Mention / Mất kết nối / Nhắc hẹn Cá nhân khi hội thoại đang tắt: viết theo G027 BR04, trace `G027 BR04` | BA | Mở — cô lập | | |
| Q-02 | Không trọng yếu | `G028:84`, `G028:52`, `G028:92-99` | Khi đang tắt, chọn tắt lại ở đâu; đang tắt vô thời hạn đổi sang hẹn giờ có được không | Tài liệu không nói đường thao tác. Về vô thời hạn: (a) cũng reset theo BR04; (b) không có chuyển trạng thái này (bảng §7) | Case AF02 theo AC `G028:128` viết được; case "vô thời hạn → hẹn giờ" và bước thao tác cụ thể đánh `❓` | BA | Mở — cô lập | | |
| Q-03 | Không trọng yếu | `G028:85`; `G027:46` | Âm thanh có tắt theo không | (a) Tắt cả âm thanh (âm thanh là phần kèm của thông báo, `G027:46`). (b) Tài liệu không nói riêng | Một ý kiểm trong case BR05, đánh `❓` | BA | Mở — cô lập | | |
| Q-04 | Không trọng yếu | `G028:81` | Múi giờ tính "8 giờ sáng" | Tài liệu không nói | Case BR01 chạy trên một múi giờ; case đổi múi giờ là QA bổ sung | BA | Mở — cô lập | | |
| Q-05 | Không trọng yếu | `G003:420`; `G009:164`; `G028:86`; `G009:245` | G003 và một câu G009 còn ghi "per tài khoản Zalo, Zalo-native" | G028 là tài liệu chủ quản, ghi "đã chốt 2026-08-21"; G009 dòng 245 ghi thay cho hướng cũ | Không đổi case; test theo G028 BR06 | BA (ghi chú cập nhật G003, G009:164) | Mở — cô lập | | |
| Q-06 | Không trọng yếu | `G028:113-114`; `G027:45` | Mobile có thao tác tắt / bật không | Tài liệu chỉ tả điểm vào trên web | Thiết kế thao tác cho web; mobile chỉ kiểm việc không nhận push sau khi tắt từ web | BA / người dùng chốt phạm vi | Mở — cô lập | | |
| Q-07 | Người dùng chốt | `G028:9` | Spec đang Draft | — | Có viết test case trên bản Draft không | Người dùng | Đã chốt | Dùng bản Draft làm căn cứ viết test case | Hồng (QA) · 2026-10-09 · phiên /qa-flow |

## 4. Cách hiểu đã xác nhận `[ĐÃ XÁC NHẬN]`

Chưa có. Không điểm nào ở mục 3 có câu trả lời của BA.

## 5. Các cách hiểu khác nhau còn tồn tại

Q-01, Q-02 (phần vô thời hạn), Q-03 — mỗi câu hai cách hiểu, xem bảng. Q-02 (đường thao tác), Q-04, Q-06 — tài liệu
không nói: **Unresolved / BA Clarification Required**, đã cô lập.

## 6. Điểm đã thống nhất và điểm còn mở

- Đã thống nhất: chưa có.
- Đã chốt: Q-07 (người dùng).
- Còn mở — **trọng yếu**: không có (mức do AI đề xuất, người dùng chấp nhận khi mở cổng).
- Còn mở — không trọng yếu (đã cô lập): Q-01 → Q-06.

## 7. Cần BA / Dev / Product xác nhận

| Q | Gửi ai | Nội dung gửi (copy được) |
| --- | --- | --- |
| Q-01 | BA Trân | G028 BR05 ghi khi đang tắt thì không phát thông báo, không nhắc ngoại lệ. G027 BR04 ghi @Mention, Mất kết nối tài khoản Zalo và Nhắc hẹn Cá nhân luôn báo dù đã tắt. Ba ngoại lệ này có áp dụng cho G028 không? |
| Q-02 | BA Trân | Khi hội thoại đang tắt, người dùng chọn "tắt lại với thời hạn khác" (AF02) ở đâu — menu chuông lúc đó gồm những mục nào? Đang tắt "Cho đến khi bật lại" mà chọn 1 giờ thì có đổi sang hẹn giờ không? |
| Q-03 | BA Trân | Khi tắt thông báo hội thoại, âm thanh báo (G027) có tắt theo không? |
| Q-04 | BA Trân | "Đến 8 giờ sáng" tính theo múi giờ nào? |
| Q-05 | BA Trân | Ghi chú: G003 §10B dòng "Icon chuông" và G009 dòng 164 còn ghi "Zalo-native, per tài khoản Zalo" — chưa cập nhật theo G028 BR06 (per-user). |
| Q-06 | BA Trân | Trên app mobile có thao tác tắt / bật thông báo hội thoại không? Điểm vào ở đâu? |

## 8. Ngoài phạm vi / chưa có căn cứ

- OOS01 tắt toàn bộ hội thoại · OOS02 cấu hình loại thông báo · OOS03 nội dung và cách hiển thị thông báo (thuộc G027) ·
  OOS04 tắt cho cả team (`G028:141-144`).
- Data model / API: N/A (`G028:105`) — không có mã lỗi hay endpoint để kiểm.
- "Khi tắt, hội thoại không được highlight" chỉ có ở `G003:420` (bản cũ), không có trong G028.

## 9. Change Proposal / New Requirement Candidate `[ĐỀ XUẤT THAY ĐỔI]`

Chưa có.

## 10. QA coverage bổ sung dự kiến `[QA BỔ SUNG]`

- Biên thời gian quanh mốc 08:00 (07:59, 08:00, 08:01) — suy từ BR01, tài liệu chỉ có ví dụ 06:00 và 09:00.
- Trạng thái tắt sau khi tải lại trang / đăng nhập lại / mở trên thiết bị khác của cùng người dùng.
- Hai điểm vào (chuông, option menu) hiển thị cùng một trạng thái.
- Tắt hội thoại X không ảnh hưởng hội thoại Y của cùng người dùng.

## 11. Xác nhận mở cổng

- [x] Điểm trọng yếu còn mở = 0 — không có điểm nào được xếp trọng yếu; người dùng chấp nhận mức đề xuất của Q-01 → Q-06
- [x] Người dùng đã chốt Q-07 (dùng bản Draft)
- [x] Người dùng đã được trình bày mục 2–8 trong phiên
- Người dùng xác nhận: Hồng (QA) · 2026-10-09 · nguyên văn: "dong y mo cong" — trả lời đề nghị "nếu đồng ý mức của Q-01 → Q-06 và dùng bản Draft thì nói đồng ý mở cổng"
- Lưu ý: chưa có câu trả lời nào của BA; Q-01 → Q-06 vẫn là `[CẦN XÁC NHẬN]`.

## Lịch sử cập nhật

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
| 2026-10-09 | AI (Orchestrator) | Tạo bản đầu sau Requirement Analysis: 7 điểm, AI đề xuất không có điểm trọng yếu, cổng đóng chờ người dùng |
| 2026-10-09 | Hồng (QA) | Chấp nhận mức đề xuất, chốt Q-07, xác nhận mở cổng |
