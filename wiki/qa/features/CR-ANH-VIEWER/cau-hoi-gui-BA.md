# [CR] Thao tác với ảnh trong trình xem ảnh — Câu hỏi QA gửi BA

| | |
| --- | --- |
| **Tài liệu** | [CR] Bổ sung các thao tác đối với ảnh đang được mở ra xem trong đoạn chat — v1.1, 13/10/2026 (mã yêu cầu chưa cấp) |
| **Gửi** | Đỗ Văn An (BA) |
| **Từ** | Hồng (QA) |
| **Ngày gửi** | 2026-10-14 |
| **Tài liệu đã đối chiếu** | CR v1.1 · G003 v1.11 (UC-08, E09, BR19–BR27, §10G) · G036 v1.0 (BR14, BR20) |

Anh An trả lời giúp em vào cột **BA trả lời**. Câu có sẵn phương án thì chỉ cần ghi (a) hoặc (b); không phương án nào
đúng thì ghi cách đúng.

QA cần câu trả lời cho **4 câu ở Phần A** trước khi viết test case. Phần B không chặn việc.

## Phần A — Cần trả lời trước khi viết test case

| # | Câu hỏi | Tài liệu đang ghi | Phương án | BA trả lời |
| --- | --- | --- | --- | --- |
| **Q-01** | **Quyền tải ảnh** là quyền nào? Có quyền riêng cho tải xuống hay chỉ cần quyền xem hội thoại? User **không có quyền** thì icon Tải xuống ẩn, bị khóa, hay bấm được rồi báo lỗi (thông báo gì)? | CR §4.2: "user có quyền theo chính sách hiện có"; "kiểm tra quyền theo cơ chế hiện hành; không dùng viewer để vượt quyền truy cập ảnh". QA chưa có tài liệu nào về chính sách này. | **(a)** Chỉ cần quyền xem hội thoại (G003), không có quyền tải riêng.<br>**(b)** Có quyền tải riêng — anh cho em tài liệu. | |
| **Q-04** | Tin ảnh **có chú thích** (caption): chuyển tiếp từ viewer gửi **chỉ ảnh** hay **ảnh kèm chú thích**? | CR §4.9: "Nội dung chuyển tiếp là một ảnh đang xem". G003 UC-08 bước 5: "gửi nội dung tin nhắn gốc". G036 BR14: ảnh có chú thích dính dưới ảnh. | **(a)** Chỉ ảnh.<br>**(b)** Ảnh + chú thích. | |

| **Q-15** | Ảnh nguồn có tên **`IMG_001.jpg` nhưng nội dung thực tế là PNG**: file tải về tên gì? §4.2 có hai câu: "giữ tên file nguồn hợp lệ" và "đuôi file khớp định dạng thực tế" — trường hợp này hai câu cho kết quả khác nhau. | CR §4.2 quy tắc tên file; AC-04 chỉ nói trường hợp thiếu tên. | **(a)** Giữ `IMG_001.jpg`.<br>**(b)** Đổi thành `IMG_001.png`. | |

| **Q-16** | Chuyển tiếp tới **nhiều người / nhóm**, một phần **lỗi** (vd 3 đích: 2 được, 1 lỗi): modal hiện gì? Bấm **Gửi lại** thì gửi cho đích nào (chỉ đích lỗi, hay cả 3 — gửi trùng)? Tin lỗi có nằm trong đoạn chat đích dạng "lỗi gửi + Thử lại" không? *(Câu này thuộc chức năng dùng chung G003 UC-08 — có thể cần chị Trân.)* | CR §4.9 bước 6; G003 E09 "toast + popup giữ nguyên để thử lại"; G003 BR22 "gửi song song đến từng đích". | **(a)** Modal giữ, đánh dấu đích lỗi, Gửi lại chỉ gửi đích lỗi.<br>**(b)** Modal giữ, Gửi lại gửi cả 3.<br>**(c)** Tin lỗi nằm ở đoạn chat đích, thử lại tại đó. | |

## Phần B — Không chặn việc, nhờ anh xác nhận hoặc bổ sung tài liệu

| # | Nội dung | Tài liệu đang ghi | Phương án | BA trả lời |
| --- | --- | --- | --- | --- |
| **Q-02** | **Trình xem ảnh hiện hành** có tài liệu không? QA cần: dải thumbnail gồm những ảnh nào (ảnh của tin đó hay mọi ảnh trong hội thoại); ở ảnh đầu / cuối thì nút trước / sau ra sao; **click vào nền tối** có đóng viewer không; **click đơn lên ảnh** (nhấn rồi thả, không kéo) thì viewer đóng, giữ nguyên, hay làm gì khác. | CR §1 "viewer đã có…"; §4.7 "giữ nguyên nguồn, thứ tự và quy tắc điều hướng đầu / cuối hiện hành"; §4.5 "nhả chuột sau kéo không được tính thành click nền để đóng viewer". | | |
| **Q-03** | Ảnh **nhỏ hơn vùng xem**: hệ số 1 = kích thước tự nhiên (không phóng cho vừa khung) — đúng không? Và khi bấm Phóng to lên 2, 3, 4 thì ảnh nhỏ **có được phóng vượt kích thước tự nhiên** không? | CR §4.4: "kích thước cơ sở là ảnh vừa vùng xem… không phóng ảnh nhỏ vượt kích thước tự nhiên"; "kích thước hiển thị = cơ sở × hệ số". | **(a)** Hệ số 1 = tự nhiên; zoom vẫn nhân hệ số, được vượt tự nhiên.<br>**(b)** Ảnh nhỏ không bao giờ lớn hơn kích thước tự nhiên. | |
| **Q-05** | Modal Chuyển tiếp mở từ viewer: có hiện phần **"Chọn nhiều" / "Đã chọn X/50"** không (chỉ có một tin nguồn)? Nút **"Gửi (X)"** và bộ đếm **"X/99"** có giữ như G003 §10G không? | CR §4.9 "dùng lại các thành phần của UC-08"; G003 §10G. | | |
| **Q-06** | Click vào ảnh của **tin đã thu hồi** (G036 giữ nội dung) có mở viewer không? Nếu mở: icon Chuyển tiếp ẩn (AC-41) — còn **Tải xuống** thì tải được hay báo "Không còn tệp ảnh"? | CR §4.9 điều kiện; G036 BR20. | | |
| **Q-07** | Khi nào một ảnh "**không còn file nguồn**" (xóa phía tôi? thu hồi? hết hạn lưu)? QA cần cách dựng để test AC-07. | CR §4.2. | | |
| **Q-08** | Icon **bị khóa** (đang tải, đã đạt giới hạn zoom): rê chuột có hiện tooltip lý do không; **click** vào icon khóa có phản hồi gì? Và lúc viewer **mới hiện thumbnail mờ, chưa có bản nét** thì có tính là "ảnh chưa tải xong" (khóa Xoay / Phóng to / Thu nhỏ) không? | CR §4.3 "khi ảnh chưa tải xong, icon Xoay bị khóa"; §4.7 "icon đang bị khóa hiển thị lý do"; AC-12/13, AC-30. | | |
| **Q-09** | "Đóng viewer **trả focus về ảnh đã mở**": QA kiểm bằng gì (viền focus trên ảnh; nhấn Tab tiếp đi đâu)? | CR §4.6. | | |
| **Q-10** | Anh gửi giúp 3 wireframe **WF-01, WF-02, WF-03** (PNG / SVG) — thư mục `CR-thao-tac-anh-chat-v1.1/` không có trong bộ tài liệu QA nhận. | CR §4.8. | | |
| **Q-13** | *(Gửi Dev)* Hệ số zoom và góc xoay không hiển thị nhưng là tiêu chí nghiệm thu. Dev có thể gắn **thuộc tính đọc được** trên phần tử ảnh (vd `data-zoom="1.25"`, `data-rotate="90"`) để QA kiểm bằng DevTools không? Không có thì QA đo kích thước render, dung sai ±1 px. | CR §4.4 "hệ số này phục vụ tính kích thước và nghiệm thu, không hiển thị cho user". | | |
| **Q-14** | Tải ảnh A đang xử lý, user chuyển sang xem ảnh B (hoặc đóng viewer) rồi A **tải lỗi**: có hiện thông báo lỗi không? Nếu có, thông báo có nêu rõ là ảnh A không (để không nhầm với B)? | CR §4.2: "Không tải nhầm B hoặc hiển thị lỗi của A như lỗi của B." | **(a)** Hiện "Không thể tải ảnh…" kèm nhận diện ảnh A.<br>**(b)** Không hiện gì khi không còn xem A. | |
| **Q-11** | **Mã yêu cầu** của CR này là gì? QA đang dùng mã tạm `CR-ANH-VIEWER`. | CR dòng "Mã yêu cầu: Chưa cấp". | | |

## Phản hồi của BA

| | |
| --- | --- |
| **Người trả lời** | |
| **Ngày trả lời** | |
| **Ghi chú thêm** | |

## Lịch sử cập nhật (nội bộ QA — BA không cần đọc)

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
| 2026-10-14 | AI (Orchestrator) | Tạo Phần A (Q-01, Q-04), Phần B (Q-02, Q-03, Q-05 → Q-11) |
| 2026-10-14 | Hồng + AI (debate) | Bổ sung ý thumbnail mờ vào Q-08 |
| 2026-10-14 | Hồng + AI (debate) | Thêm Q-13 (đề nghị Dev gắn data-zoom / data-rotate) |
| 2026-10-14 | Hồng + AI (debate) | Bổ sung ý click đơn trên ảnh vào Q-02 |
| 2026-10-14 | Hồng + AI (debate) | Thêm Q-14 (lỗi tải A khi đang xem B) |
| 2026-10-14 | Hồng + AI (debate) | Thêm Q-15 vào Phần A (tên file có đuôi sai định dạng) |
| 2026-10-14 | Hồng + AI (debate) | Thêm Q-16 vào Phần A (lỗi từng đích khi chuyển tiếp) |
