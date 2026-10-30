# Câu hỏi gửi BA

| | |
| --- | --- |
| **Tài liệu** | [NR/CR] [Zalo Chat] Hiển thị người gửi và tên file trên danh sách hội thoại — 19/10/2026, Status Approved (ID và version chưa ghi) |
| **Gửi** | Nguyễn Thị Phương Thảo (BA) |
| **Từ** | Hồng (QA) |
| **Ngày gửi** | 2026-10-27 |
| **Tài liệu đã đối chiếu** | G003 v1.11 (UC-06, AF05, §10B, §10D) · G032 v1.0 bản "Đổi tên gợi nhớ (1)" (BR01, BR02, BR08, BR09) · G036 v1.0 (§10E) · G008 v1.1 (UC-07) · G006 v1.1 · CR Tối ưu responsive 22/10/2026 (BR-15) |

Chị Thảo trả lời giúp em vào cột **BA trả lời**. Câu có sẵn phương án thì chỉ cần ghi (a) hoặc (b); không phương án nào
đúng thì ghi cách đúng.

QA cần câu trả lời cho **3 câu ở Phần A** trước khi viết test case. Phần B không chặn việc.

## Phần A — Cần trả lời trước khi viết test case

| # | Câu hỏi | Tài liệu đang ghi | Phương án | BA trả lời |
| --- | --- | --- | --- | --- |
| **Q-01** | **"Tên Zalo của tài khoản gửi"** (tin do chủ tài khoản gửi từ app Zalo) lấy từ trường nào? BR-03 và AC-03 nói "kế thừa nguồn tên đang dùng cho tin này trong chi tiết hội thoại", nhưng G003 ghi tin gửi từ điện thoại trong chi tiết **không hiển thị tên người gửi** — nên QA chưa có nguồn tên để đối chiếu. | NR BR-03, AC-03; G003 §10D "Tin nhắn gửi từ điện thoại: không hiển thị tên người gửi", AF05. | **(a)** Tên tài khoản Zalo đang liên kết như hiển thị ở màn Liên kết tài khoản (G001) và bộ lọc tài khoản trên danh sách.<br>**(b)** Trường khác — chị ghi rõ (và chi tiết hội thoại có đổi sang hiển thị tên này không). | |
| **Q-02** | **"Mobile"** trong tài liệu là **app Gopany mobile** (Android/iOS) hay **web Gopany trên màn hình hẹp**? Nếu là app: QA chưa có spec danh sách hội thoại trên app (G003 ghi Web only, Mobile app ngoài phạm vi). Nếu là web: web thu hẹp dưới 880 px (theo CR responsive) áp dụng quy tắc desktop (không giới hạn 20 ký tự) hay quy tắc mobile? | NR §2.1 "Áp dụng trên desktop/mobile"; BR-16; BR-17 "khi chiều rộng sidebar thay đổi theo khả năng hiện tại"; G003 Platform: Web only, OOS08 Mobile app. | **(a)** Mobile = app Gopany; web mọi chiều rộng dùng quy tắc desktop.<br>**(b)** Mobile = web màn hẹp (chị cho mốc px).<br>**(c)** Cả app và web màn hẹp đều dùng quy tắc mobile. | |
| **Q-03** | AC-08 giả định cùng một người có liên hệ trên tài khoản Zalo A và B **với tên gợi nhớ khác nhau**. Nhưng G032 quy định tên gợi nhớ là dữ liệu **dùng chung cấp workspace**, một nguồn duy nhất và được **ghi lên tất cả tài khoản** có kết bạn. Vậy một liên hệ có thể có **hai tên gợi nhớ khác nhau theo tài khoản** không, và nếu có thì dựng bằng cách nào (đặt trên app Zalo rồi đồng bộ danh bạ)? | NR BR-05, AC-08 [1]; G032 BR01, BR02, BR08, BR09. | **(a)** Không thể khác nhau trong Gopany — AC-08 [1] chỉ cần kiểm tên gợi nhớ hiện đúng cho hội thoại của từng tài khoản.<br>**(b)** Có thể khác nhau — chị cho cách dựng dữ liệu. | |

## Phần B — Không chặn việc, nhờ chị xác nhận hoặc bổ sung tài liệu

| # | Nội dung | Tài liệu đang ghi | Phương án | BA trả lời |
| --- | --- | --- | --- | --- |
| **Q-04** | Nhóm có **hai tài khoản Zalo liên kết** của workspace cùng là thành viên. Nhân sự gửi tin qua Gopany bằng tài khoản **B**; nhìn trong hội thoại nhóm **thuộc tài khoản A**, tiền tố là gì? QA đọc theo BR-01 (phía gửi theo tài khoản của hội thoại): đây là tin nhận → tiền tố là tên hiển thị của B theo liên hệ của A. | NR BR-01, BR-05. | **(a)** Tên hiển thị của tài khoản B (tin nhận).<br>**(b)** Tên nhân sự đã gửi. | |
| **Q-05** | Mốc **20 ký tự** trên mobile đếm thế nào với tiếng Việt có dấu, emoji, khoảng trắng đầu/cuối và khoảng trắng liên tiếp? Dấu `…` là một ký tự (…) hay ba dấu chấm? | NR BR-16, AC-24. | | |
| **Q-06** | Nhân sự gửi tin xong rồi **đổi tên** hoặc **bị xóa / vô hiệu hóa** khỏi workspace: tiền tố hiện tên lúc gửi, tên hiện tại, hay giá trị gì? | NR BR-02 "người thực hiện gửi được ghi nhận trên tin nhắn". | | |
| **Q-07** | Có **design** cho dòng tin nhắn không (icon đính kèm nào)? Khi file **không có tên**, hiển thị icon kèm `[Tệp]` hay chỉ `[Tệp]`? Tên file hiển thị cả phần mở rộng theo dữ liệu đúng không? | NR CR-01, UI Spec "Tin nhắn file". | | |
| **Q-08** | Nhãn **hiện tại** trên danh sách cho từng loại tin (sticker, video, danh thiếp, link, bình chọn, số tài khoản ngân hàng…) nguyên văn là gì? NR ghi `[Sticker]`, G036 thanh ghim ghi `[Nhãn dán]` và `[Tập tin]`. | NR BR-08, AC-11; G036 §10E. | | |
| **Q-09** | Tin gần nhất đang ở trạng thái **"Đang gửi"** hoặc **"Gửi thất bại"**: dòng tin nhắn có tiền tố và nhãn gì? | G003 §10D; NR không đề cập. | | |
| **Q-10** | **Nội dung** hiển thị trên danh sách của **tin trả lời**: chỉ phần trả lời hay kèm trích dẫn? | NR BR-07 chỉ nói người gửi. | | |
| **Q-11** | Nguyên văn **thông báo hệ thống** hiện tại trên danh sách (đổi tên nhóm, thêm thành viên, rời nhóm) — để QA ghi expected cho AC-22. | NR BR-14, AC-22; G008 UC-07. | | |
| **Q-12** | Tin gửi từ app Zalo và trạng thái thu hồi/xóa trên Zalo về Gopany theo cơ chế nào, mất bao lâu? QA cần cách dựng và thời điểm kỳ vọng để test AC-03/04/15/17/18/19/20. | NR BR-03, BR-12 "đồng bộ về"; G006 chỉ đồng bộ thẻ và danh bạ. | | |
| **Q-13** | **Mã yêu cầu** và **version** của tài liệu? QA đang dùng mã tạm `NR-NGUOI-GUI-TEN-FILE`. | NR dòng "ID: —", change log trống. | | |

## Phản hồi của BA

| | |
| --- | --- |
| **Người trả lời** | |
| **Ngày** | |
| **Kênh** | |

## Lịch sử cập nhật

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
| 2026-10-27 | AI (Orchestrator) | Lập bản đầu: 3 câu Phần A (Q-01…Q-03), 10 câu Phần B (Q-04…Q-13) — mức do AI đề xuất, chờ Hồng chốt trước khi gửi |
