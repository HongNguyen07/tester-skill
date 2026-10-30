---
featureId: G028
title: Tắt / Bật thông báo hội thoại
analyzedAt: 2026-10-09
analyst: Requirement Analyst (AI) — người dùng: Hồng (QA)
---

# Requirement Analysis — G028: Tắt / Bật thông báo hội thoại

Viết tắt tham chiếu: `G028` = `tailieu/G028 - Tắt Bật thông báo hội thoại (1).md`; `G027`, `G029`, `G009`, `G003`,
`G024` = file tương ứng trong `tailieu/`. Số sau dấu `:` là số dòng.

## 1. Nguồn và phạm vi đã đọc

| # | Tệp | Version ghi trong tệp | Phạm vi đã đọc | Ghi chú |
| ---: | --- | --- | --- | --- |
| 1 | `G028 - Tắt Bật thông báo hội thoại (1).md` | Không có ô Version; Status **Draft**; Last updated 2026-08-21 | Toàn bộ (161 dòng) | Nguồn chính |
| 2 | `G027 - Thông báo đẩy (Web & Mobile) (1).md` | — | Các dòng về tắt thông báo, loại thông báo, kênh phát (27–46, 69, 87–93, 101–115, 135) | Tìm theo từ khoá, chưa đọc toàn văn |
| 3 | `G029 - Đếm tin nhắn chưa đọc.md` | — | BR06, AC-BR06, phụ thuộc (20, 95, 149, 175) | |
| 4 | `G009 - Tính năng bổ sung Chat.md` | — | Các dòng "MOVED → G028" (19, 42, 53, 162–164, 242–245, 255–257, 330) | |
| 5 | `G003 - Chat.md` | 1.11 | §10B icon chuông, option menu (420, 424) | |
| 6 | `G024 - Thao tác hội thoại…(1).md` | — | BR04, mô tả option menu (143, 180) | |

Chưa đọc: `G002` (chỉ được dẫn làm lý do cho per-user); phần còn lại của G027, G003, G009.

## 2. Mục tiêu và phạm vi feature `[NGUỒN]`

Cho phép tắt thông báo của một hội thoại trong thời hạn chọn trước hoặc đến khi bật lại. Khi tắt, hội thoại vẫn nhận tin
bình thường, chỉ không phát thông báo; số chưa đọc vẫn cập nhật (`G028:16`). Tách từ G009 UC-05 (`G028:18`).

## 3. Actor, precondition, trigger

| Mục | Nội dung | Nguồn | Nhãn |
| --- | --- | --- | --- |
| Actor | Mọi nhân sự (Admin / Staff) có quyền xem hội thoại | `G028:20` | `[NGUỒN]` |
| Precondition | Đã đăng nhập, có quyền xem hội thoại; hội thoại đang mở hoặc đang ở màn danh sách hội thoại | `G028:33-34` | `[NGUỒN]` |
| Trigger 1 | Icon chuông trong panel phải của hội thoại | `G028:29`, `G028:113` | `[NGUỒN]` |
| Trigger 2 | Option menu của hội thoại trong danh sách (hover → ••• → Tắt/Bật thông báo) | `G028:30`, `G028:114` | `[NGUỒN]` |

## 4. Use case và luồng

| Mã | Tên | Luồng | Nguồn |
| --- | --- | --- | --- |
| UC-01 | Tắt thông báo hội thoại | Bấm icon chuông hoặc chọn **Tắt thông báo** từ option menu → menu thời hạn → chọn → tắt theo thời hạn, icon chuông chuyển trạng thái tắt → trong thời gian tắt không phát thông báo, số chưa đọc vẫn hiển thị | `G028:40-46` |
| UC-02 | Bật lại thông báo | Bấm icon chuông đang tắt → chọn **"Bật thông báo"** → bật lại ngay, hủy hẹn giờ nếu chưa hết hạn | `G028:50-53` |
| AF01 | Tự bật lại khi hết thời hạn | Hết thời hạn (1 giờ / 4 giờ / Đến 8 giờ sáng) → tự bật lại, không cần thao tác | `G028:61-62` |
| AF02 | Tắt lại khi đang trong thời hạn tắt | Đang tắt mà chọn tắt tiếp với thời hạn khác → thời hạn reset về mốc mới chọn (không cộng dồn, không giữ mốc cũ) | `G028:64-65` |
| E01 | Thao tác tắt/bật thất bại (mất kết nối) | Toast: *"Không thực hiện được, vui lòng thử lại"*; giữ nguyên trạng thái trước đó | `G028:73` |

## 5. Business rule

| Mã | Nội dung (sát nguyên văn) | Loại | Nguồn | Nhãn |
| --- | --- | --- | --- | --- |
| BR01 | Thời hạn tắt: 1 giờ / 4 giờ / Đến 8 giờ sáng / Cho đến khi bật lại. "Đến 8 giờ sáng" = 8:00 sáng lần kế tiếp: tắt trước 8:00 → hết hạn 8:00 cùng ngày; tắt từ 8:00 trở đi → hết hạn 8:00 sáng hôm sau | Nghiệp vụ | `G028:81` | `[NGUỒN]` |
| BR02 | Hết thời hạn (1 giờ / 4 giờ / Đến 8 giờ sáng) → tự bật lại; icon chuông trở về trạng thái bật | Nghiệp vụ | `G028:82` | `[NGUỒN]` |
| BR03 | Bật lại thủ công bất cứ lúc nào → hủy hẹn giờ ngay, không chờ hết hạn | Nghiệp vụ | `G028:83` | `[NGUỒN]` |
| BR04 | Đang trong thời hạn tắt mà chọn tắt lại → thời hạn reset về mốc mới (không cộng dồn) | Nghiệp vụ | `G028:84` | `[NGUỒN]` |
| BR05 | Khi đang tắt: không phát thông báo cho hội thoại (toast / trình duyệt / push — G027); số chưa đọc vẫn hiển thị, hội thoại vẫn nhận và lưu tin bình thường | Nghiệp vụ | `G028:85` | `[NGUỒN]` |
| BR06 | Phạm vi per-user: tắt chỉ áp dụng cho chính người thao tác; nhân sự khác dùng chung tài khoản Zalo không bị ảnh hưởng. Xử lý phía Gopany, không dùng chức năng tắt của Zalo | Dữ liệu / phạm vi | `G028:86`, `G028:161` | `[NGUỒN]` |

Rule liên quan ở spec khác:

| Mã | Nội dung | Nguồn | Nhãn |
| --- | --- | --- | --- |
| G027 BR03 | Tôn trọng cài đặt tắt thông báo của hội thoại (G028): đã tắt thì không báo, số chưa đọc vẫn cập nhật | `G027:87` | `[NGUỒN]` |
| G027 BR04 | Ngoại lệ luôn báo dù đã tắt: @Mention (trong nhóm), Mất kết nối tài khoản Zalo, Nhắc hẹn Cá nhân. Nhắc hẹn Mọi người → tôn trọng tắt thông báo | `G027:88`, `G027:93` | `[NGUỒN]` |
| G027 kênh phát | Đang mở tab → toast; tab ở nền → thông báo trình duyệt / hệ điều hành; mobile nền hoặc đóng → push; mọi trường hợp kèm âm thanh + số chưa đọc trên tab / icon | `G027:43-46` | `[NGUỒN]` |
| G029 BR06 | Hội thoại đã tắt thông báo vẫn cộng chưa đọc bình thường | `G029:95` | `[NGUỒN]` |

## 6. Acceptance criteria (nguyên văn rút gọn)

| Mã | Nội dung | Nguồn |
| --- | --- | --- |
| AC-BR01, AC-BR05 | Tắt 1 giờ → không phát thông báo trong 1 giờ; số chưa đọc vẫn hiển thị | `G028:124` |
| AC-BR02 | Hết 1 giờ → tự bật lại | `G028:125` |
| AC-BR01 | Chọn "Cho đến khi bật lại" → tắt đến khi bật tay | `G028:126` |
| AC-BR03 | Bật lại thủ công giữa chừng → hủy hẹn giờ ngay | `G028:127` |
| AC-BR04 | Đang tắt "Đến 8 giờ sáng", chọn tắt lại 1 giờ → thời hạn reset về 1 giờ (không cộng dồn) | `G028:128` |
| AC-BR01 | Tắt lúc 06:00 chọn "Đến 8 giờ sáng" → hết hạn 08:00 cùng ngày | `G028:129` |
| AC-BR01 | Tắt lúc 09:00 chọn "Đến 8 giờ sáng" → hết hạn 08:00 hôm sau | `G028:130` |
| AC-BR05 | Đang tắt → hội thoại vẫn nhận tin, số chưa đọc vẫn cập nhật | `G028:131` |
| AC-BR06 | Nhân sự A tắt thông báo hội thoại X → nhân sự B dùng chung tài khoản vẫn nhận thông báo bình thường | `G028:132` |
| AC-10 | Icon chuông đổi trạng thái đúng sau mỗi thao tác | `G028:133` |

Thông báo lỗi duy nhất: E01 *"Không thực hiện được, vui lòng thử lại"* (`G028:73`). Không có mã lỗi API (spec thuần nghiệp vụ,
`G028:105`).

## 7. Trạng thái và chuyển trạng thái `[NGUỒN]` (`G028:92-99`)

Theo người dùng × hội thoại.

| Từ | Sự kiện | Sang |
| --- | --- | --- |
| (chưa cài đặt) | Mặc định | Đang bật |
| Đang bật | Tắt có hẹn giờ (1 giờ / 4 giờ / Đến 8 giờ sáng) | Đang tắt (hẹn giờ) |
| Đang bật | Tắt "Cho đến khi bật lại" | Đang tắt (vô thời hạn) |
| Đang tắt (hẹn giờ) | Hết thời hạn | Đang bật |
| Đang tắt (hẹn giờ) | Bật lại thủ công | Đang bật |
| Đang tắt (vô thời hạn) | Bật lại thủ công | Đang bật |

Bảng trạng thái **không có** dòng "đang tắt → tắt lại" dù BR04 / AF02 mô tả hành vi này (xem điểm chưa rõ 2).

## 8. Diễn giải, giả định, QA observation

| # | Nội dung | Nhãn | Liên quan tới |
| ---: | --- | --- | --- |
| 1 | G028 BR05 không nhắc ngoại lệ, nhưng G028 giao nội dung thông báo cho G027 (`G028:143`) và G027 BR04 ghi rõ ngoại lệ "luôn báo dù đã tắt". Đọc hai tài liệu cùng nhau thì ngoại lệ của G027 vẫn áp dụng | `[DIỄN GIẢI AI]` | BR05, Q-01 |
| 2 | "Không phát thông báo" bao gồm cả âm thanh đi kèm, vì G027 coi âm thanh là phần "kèm theo" của thông báo (`G027:46`) | `[DIỄN GIẢI AI]` | BR05, Q-03 |
| 3 | G003 §10B dòng icon chuông là nội dung cũ, chưa cập nhật theo G028 (G009 đã ghi "nay chốt per-user… thay cho hướng theo cả tài khoản cũ", `G009:245`) | `[DIỄN GIẢI AI]` | BR06, Q-05 |
| 4 | Kiểm thời hạn 1 giờ / 4 giờ / 8 giờ sáng cần cách chỉnh thời gian trên môi trường test | `[QA BỔ SUNG]` | BR01, BR02 |

## 9. Điểm chưa rõ (chuyển sang Debate)

| # | Loại | Trích dẫn + nguồn | Vì sao chưa rõ | Đề xuất mức |
| ---: | --- | --- | --- | --- |
| 1 | Thiếu | `G028:85` "không phát thông báo cho hội thoại (toast / trình duyệt / push — G027)"; `G027:88` "Ngoại lệ luôn báo dù đã tắt: @Mention (trong nhóm), Mất kết nối tài khoản Zalo, và Nhắc hẹn Cá nhân" | G028 không nhắc ngoại lệ nào; G027 có ba ngoại lệ | Không trọng yếu — kỳ vọng cho ngoại lệ có nguồn rõ ở G027 BR04; nhóm case chính (tin nhắn mới) không đổi |
| 2 | Thiếu | `G028:84` "Đang trong thời hạn tắt mà chọn tắt lại → reset"; `G028:52` bấm icon chuông đang tắt → chọn "Bật thông báo"; `G028:92-99` không có chuyển trạng thái tắt → tắt | (i) Khi đang tắt, người dùng chọn tắt lại ở đâu (menu lúc đó có gì). (ii) Đang tắt **vô thời hạn** mà chọn thời hạn có hẹn giờ thì có đổi không — "trong thời hạn tắt" có bao gồm vô thời hạn không | Không trọng yếu — AC chính (`G028:128`) rõ; chỉ ảnh hưởng nhánh biên |
| 3 | Mơ hồ | `G028:85` liệt kê "toast / trình duyệt / push"; `G027:46` "Mọi trường hợp (kèm theo): Âm thanh báo + số chưa đọc" | Âm thanh có tắt theo không; G028 không nhắc âm thanh | Không trọng yếu |
| 4 | Thiếu | `G028:81` "8:00 sáng lần kế tiếp" | Giờ tính theo múi giờ nào (thiết bị người dùng / máy chủ / workspace) | Không trọng yếu nếu sản phẩm chỉ dùng một múi giờ |
| 5 | Mâu thuẫn giữa spec | `G003:420` icon chuông "Zalo-native, per tài khoản Zalo… Gopany không có browser/Chrome push notification — khi tắt, hội thoại không được highlight… Chi tiết: G009 UC-05"; `G009:164` "phạm vi theo tài khoản Zalo dùng chung"; `G028:86` per-user, xử lý phía Gopany; `G009:245` "nay chốt per-user" | G003 và một câu trong G009 còn ghi theo hướng cũ; "không được highlight" không có trong G028 | Không trọng yếu — G028 là tài liệu chủ quản, có ghi "đã chốt 2026-08-21"; ghi chú để BA cập nhật G003 |
| 6 | Thiếu | `G028:113-114` điểm vào chỉ tả web (panel phải, hover); `G027:45` có kênh push trên mobile | Trên app mobile có thao tác tắt / bật không, điểm vào ở đâu | Không trọng yếu — ảnh hưởng phạm vi nền tảng, không đổi quy tắc |
| 7 | Trạng thái tài liệu | `G028:9` Status **Draft** | Spec đang Draft có được dùng làm căn cứ viết test case không | Người dùng chốt |

## 10. Tự rà soát

- [x] Mọi mã ở mục 4–6 tìm thấy trong nguồn
- [x] Không mục `[NGUỒN]` nào thiếu tham chiếu
- [x] Mâu thuẫn giữa nguồn đã liệt kê đủ các phía
- [x] Mục 9 không chứa câu trả lời do AI tự chọn (các nhận định của AI nằm ở mục 8, có nhãn)
- Giới hạn: G027, G003, G009 mới đọc các dòng liên quan theo từ khoá; G002 chưa đọc
