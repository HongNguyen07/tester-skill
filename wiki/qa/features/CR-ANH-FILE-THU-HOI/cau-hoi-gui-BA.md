# [CR] [Zalo chat] Thao tác đối với ảnh/file đã bị thu hồi — Câu hỏi QA gửi BA

| | |
| --- | --- |
| **Tài liệu** | [CR] [Zalo chat] Thao tác đối với ảnh/file đã bị thu hồi — v1.0, 13/10/2026 (mã yêu cầu chưa cấp) |
| **Gửi** | Đỗ Văn An (BA) |
| **Từ** | Hồng (QA) |
| **Ngày gửi** | 2026-10-14 |
| **Tài liệu đã đối chiếu** | CR v1.0 · CR thao tác ảnh trong viewer v1.1 · G003 v1.11 (UC-06, BR06/07/09/19, §10D) · G036 v1.0 (BR20) |

Anh An trả lời giúp em vào cột **BA trả lời**. Câu có sẵn phương án thì chỉ cần ghi (a) hoặc (b); không phương án nào
đúng thì ghi cách đúng.

QA cần câu trả lời cho **2 câu ở Phần A** trước khi viết test case. Phần B không chặn việc.

## Phần A — Cần trả lời trước khi viết test case

| # | Câu hỏi | Tài liệu đang ghi | Phương án | BA trả lời |
| --- | --- | --- | --- | --- |
| **Q-01** | **Quyền truy cập ảnh / file** là quyền nào? Chỉ cần quyền xem hội thoại hay có quyền riêng cho ảnh / file / tải xuống? Khi user **mất quyền** rồi bấm mở ảnh hoặc tải file (AC-25), **thông báo** hiện nguyên văn là gì? | CR §4.2: "có quyền xem hội thoại và truy cập ảnh/file theo chính sách hiện hành"; §4.7: "hiển thị thông báo quyền theo cơ chế hiện hành". QA chưa có tài liệu nào về chính sách này. *(Trùng câu Q-01 của CR thao tác ảnh trong viewer.)* | **(a)** Chỉ cần quyền xem hội thoại (G003), không có quyền riêng.<br>**(b)** Có quyền riêng — anh cho em tài liệu. | |
| **Q-02** | Khi mở viewer của **ảnh đã thu hồi**, icon **Chuyển tiếp** trên toolbar **ẩn**, **bị khóa**, hay **hiện và dùng được**? | CR §4.3.3: "cùng bộ thao tác với ảnh chưa thu hồi, không tạo… bộ giới hạn riêng do trạng thái thu hồi" — nhưng bảng thao tác không có dòng Chuyển tiếp; §3.2: "không mở lại… chuyển tiếp". CR viewer v1.1 §4.9 + AC-41: tin đã thu hồi → ẩn icon Chuyển tiếp (G003 BR19). | **(a)** Ẩn icon Chuyển tiếp.<br>**(b)** Hiện và dùng được như ảnh thường. | |

## Phần B — Không chặn việc, nhờ anh xác nhận hoặc bổ sung tài liệu

| # | Nội dung | Tài liệu đang ghi | Phương án | BA trả lời |
| --- | --- | --- | --- | --- |
| **Q-03** | Khi nào một ảnh / file đã thu hồi trên Gopany **chỉ còn thumbnail** hoặc **mất bản nguồn**? QA cần cách dựng để test AC-22 / AC-23. Việc "kiểm tra khả năng truy xuất bản nguồn trước triển khai" (§6) do ai làm, kết quả có gửi QA không? Thêm: trường hợp **link nguồn hết hạn** (§4.7) dựng thế nào, và khi không làm mới được thì hiện **thông báo** nào? | CR §4.2, §4.7 dòng "Chỉ có thumbnail, chưa có bản nguồn", §6. | | |
| **Q-04** | Trong viewer của ảnh thu hồi, bấm **Tải xuống** mà bản nguồn không còn: hiện **"Ảnh không còn khả dụng."** hay **"Không còn tệp ảnh để tải xuống."**? | CR §4.7: "Ảnh không còn nguồn → Ảnh không còn khả dụng."; CR viewer §4.2: "Không có file nguồn: Không còn tệp ảnh để tải xuống." | **(a)** "Ảnh không còn khả dụng."<br>**(b)** "Không còn tệp ảnh để tải xuống." | |
| **Q-05** | Nhãn dưới ảnh / file thu hồi là **"Tin nhắn đã thu hồi"** hay **"Đã thu hồi"**? Khi Staff thu hồi tin gửi từ điện thoại, nhãn có kèm **tên Staff** không? | CR §1, §4.3.1: "Tin nhắn đã thu hồi"; G003 §10D: label "Đã thu hồi"; G003 UC-06 ghi chú: hiển thị tên Staff đã thu hồi. | **(a)** "Tin nhắn đã thu hồi".<br>**(b)** "Đã thu hồi". | |
| **Q-06** | Ảnh / file của tin **"Đã xóa"** (Xóa chỉ phía tôi — G003 UC-06) có được mở viewer / tải như CR này không, hay giữ hành vi hiện tại? | CR §3.1: "bị gỡ" = tin đã thu hồi; không nhắc tin Đã xóa. G003 BR07: tin Đã xóa cũng giữ nội dung gốc trên Gopany. | **(a)** Chỉ tin thu hồi.<br>**(b)** Cả tin Đã xóa. | |
| **Q-07** | **App Gopany** có tài liệu viewer ảnh và tải file không? Viewer trên app có Xoay / Phóng to / Kéo như CR viewer (desktop web) không — tức AC-06 → AC-09 có áp dụng trên app? | CR §4.6: app "thao tác như ảnh chưa thu hồi của cùng app"; G003 ghi Platform Web only, Mobile app ngoài phạm vi. | | |
| **Q-08** | CR này và **CR thao tác ảnh trong viewer** phát hành **cùng đợt** hay CR nào trước? Nếu CR này ra trước, AC-06 → AC-13 (xoay, zoom, kéo, Esc, tooltip) kiểm theo viewer hiện tại hay chờ? | CR §4.3.3 kế thừa tài liệu viewer; CR viewer change log: "Chưa thực thi kiểm thử sản phẩm". | | |
| **Q-11** | Trong lúc viewer **đang lấy nguồn** ảnh thu hồi, màn hình hiện gì: khung chờ, thumbnail **màu**, hay thumbnail **đen trắng** như trong chat? | CR §4.7: "Viewer hiển thị trạng thái đang tải"; §4.3.3: "không mang hiệu ứng đen trắng trong chat sang viewer". | | |
| **Q-12** | Với file **chưa thu hồi** hiện nay: bấm **cả thẻ file** hay chỉ **icon tải** mới tải? Sau khi bấm, web / app có **thông báo** gì không (nguyên văn)? QA cần để so "giống file chưa thu hồi" ở AC-14 / AC-15. | CR §4.4.1: "theo cách tương tác với file chưa thu hồi"; G003 §10D: "icon download; click → download ngay". | | |
| **Q-10** | Anh gửi giúp ảnh hiện trạng **hien-trang-anh-thu-hoi.png** (CR §1) — không có trong bộ tài liệu QA nhận. | CR §1. | | |
| **Q-09** | **Mã yêu cầu** và **ưu tiên** của CR này? QA đang dùng mã tạm `CR-ANH-FILE-THU-HOI`. | CR dòng "Mã yêu cầu: Chưa cấp", "Ưu tiên: Chưa xác định". | | |

## Phản hồi của BA

| | |
| --- | --- |
| **Người trả lời** | |
| **Ngày trả lời** | |
| **Ghi chú thêm** | |

## Lịch sử cập nhật (nội bộ QA — BA không cần đọc)

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
| 2026-10-14 | AI (Orchestrator) | Tạo Phần A (Q-01, Q-02), Phần B (Q-03 → Q-12) |
| 2026-10-14 | Hồng + AI (debate) | Bổ sung ý link nguồn hết hạn vào Q-03 |
