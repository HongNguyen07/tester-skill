# G036 — Câu hỏi QA gửi BA

| | |
| --- | --- |
| **Tài liệu** | G036 — Giao diện khung hội thoại, giống Zalo PC (v1.0, Draft, 2026-10-09) |
| **Gửi** | Trân (BA) |
| **Từ** | Hồng (QA) |
| **Ngày gửi** | 2026-10-13 |
| **Tài liệu đã đối chiếu** | G036 · G003 v1.11 · G026 · G009 · G032 v1.0 · G014 |

Chị Trân trả lời giúp em vào cột **BA trả lời**. Câu có sẵn phương án thì chị chỉ cần ghi (a) hoặc (b); nếu không phương án
nào đúng thì ghi cách đúng.

QA cần câu trả lời cho **2 câu ở Phần A** trước khi viết test case. Phần B không chặn việc.

## Phần A — Cần trả lời trước khi viết test case

| # | Câu hỏi | Tài liệu đang ghi | Phương án | BA trả lời |
| --- | --- | --- | --- | --- |
| **Q-01** | Hệ thống **có vai trò phó nhóm** không? Tin của trưởng nhóm được làm nổi **bằng cách nào**, và toggle tên là gì? | **G036 BR10 và §10C:** chìa khoá **vàng = trưởng nhóm, xám = phó nhóm** ở góc ảnh đại diện, rê chuột hiện "Trưởng nhóm" / "Phó nhóm"; tin có viền xanh nhạt; chỉ hiện khi nhóm bật *"Làm nổi tin nhắn trưởng **và phó** nhóm"* (dẫn G026 BR03).<br>**G026 BR01 và OOS01:** Gopany **không có phó nhóm**; mọi chỗ Zalo ghi "trưởng và phó nhóm" thì dùng "trưởng nhóm".<br>**G026 BR03 và UC-02:** toggle *"Làm nổi tin nhắn trưởng nhóm"*; BẬT → **nhãn "Trưởng nhóm" cạnh tên** + màu viền khác. | **(a)** Theo G036: có phó nhóm; chìa khoá vàng / xám ở avatar + viền xanh nhạt.<br>**(b)** Theo G026: không có phó nhóm; nhãn "Trưởng nhóm" cạnh tên + viền khác. | **(a) — lấy thông tin theo G036.** Trân, 13/10/2026 |
| **Q-02** | Tin **chủ tài khoản gửi từ điện thoại** (không qua web) hiển thị thế nào trong khung chat mới:<br>• gộp cụm với tin nào?<br>• tin cuối cụm hiện gì ở chỗ "tên nhân viên + giờ"?<br>• ảnh đại diện phía mình là ảnh gì? | **G036 BR01:** phía mình gộp cụm theo **nhân viên**.<br>**G036 BR07:** tin cuối cụm có **tên nhân viên + giờ**.<br>**G036 BR08:** ảnh đại diện phía mình là **ảnh nhân viên**.<br>**G003 AF05 và bảng hiển thị tin:** tin gửi từ điện thoại hiện nội dung + thời gian, **không hiện tên người gửi**. | Tài liệu chưa nói. | Tin gửi từ điện thoại **gộp theo cụm gửi từ điện thoại**. Trân, 13/10/2026<br>*QA hỏi thêm ở Q-13: tên và ảnh đại diện của cụm này.* |

## Phần B — Không chặn việc, nhờ chị xác nhận hoặc cập nhật tài liệu

| # | Nội dung | Tài liệu đang ghi | Phương án | BA trả lời |
| --- | --- | --- | --- | --- |
| **Q-03** | Tin thu hồi / đã xoá có còn **nhãn "Đã thu hồi" / "Đã xóa" và kiểu chữ mờ (disable)** không? | G036 BR20: giữ nội dung, không 👍, không trạng thái gửi. G003 UC-06, BR07 và bảng hiển thị: style disable + nhãn "Đã thu hồi" / "Đã xóa". | **(a)** Vẫn có nhãn và kiểu mờ như G003.<br>**(b)** Không còn, G036 thay hẳn. | |
| **Q-04** | `Đã nhận` / `Đã xem`: QA sẽ viết case nhưng **tạm chặn** tới khi BE trả được. Khi có, **"Đã xem"** hiện bằng **chữ** hay **ảnh đại diện người xem** như G003? | G036 BR24 và §16: BE hiện chỉ trả `Đã gửi`. G003 §7 không có "Đã nhận"; "Đã xem" là icon avatar người xem. | | |
| **Q-05** | Mốc thời gian **trước tin đầu tiên của danh sách** ghi **chỉ ngày** hay **giờ + ngày**? | G036 BR03 ❶ không nói định dạng. | | |
| **Q-06** | Các ngưỡng:<br>• "không quá 30 phút" tính tới giây (30:00 cùng cụm, 30:01 cụm mới)?<br>• "trong 30 ngày" có gồm ngày thứ 30 không?<br>• "~5 phút" (BR27), "vài giây" (BR26), "khoảng 3 màn hình" và các số ở §15 là **tiêu chí đạt** hay **tham khảo**? | G036 BR01, BR04, BR26, BR27, §15 ("đo trên môi trường dev"). | | |
| **Q-07** | Tiếng Anh: **ngày đầy đủ** và **"thứ + ngày"** ghi theo định dạng nào? | G036 BR05 chỉ có `Today` · `Yesterday` · `Sun/Mon/…`. | | |
| **Q-08** | 390–1600px là bề ngang **khung chat** hay **cửa sổ trình duyệt**? | G036 §1 "Bề ngang khung chat"; AC-BR28 "390 · 640 · 1000 · 1600px". | | |
| **Q-09** | Tin cuối của mình mà ngay sau là **tin hệ thống** hoặc **bình chọn** thì ô trạng thái gửi còn hiện không? | G036 BR24: ô dưới tin cuối nếu là của phía mình; khách nhắn sau thì biến mất. | | |
| **Q-10** | "Tin ghim không kèm ảnh" (BR19) là **tin hệ thống báo đã ghim** hay **tin được ghim**? | G036 BR19. | **(a)** Tin hệ thống báo đã ghim.<br>**(b)** Tin được ghim. | |
| **Q-11** | Ghi chú cập nhật tài liệu:<br>• BR06 dẫn "G032 BR03" cho tên gợi nhớ, nhưng G032 BR03 là quy tắc ghi tên lên Zalo.<br>• BR10 dẫn "G026 BR03" với tên toggle khác G026 (xem Q-01).<br>• §1 ghi "Spec gốc trỏ sang G036", nhưng G003, G009, G014, G023 chưa nhắc G036. | G036 §1, BR06, BR10. | | |

## Phần C — Hỏi thêm sau câu trả lời ngày 13/10 (không chặn việc)

| # | Nội dung | Tài liệu đang ghi | Phương án | BA trả lời |
| --- | --- | --- | --- | --- |
| **Q-13** | Cụm tin gửi từ điện thoại:<br>• tin cuối cụm hiện **chỉ giờ**, hay hiện gì thay cho "tên nhân viên + giờ"?<br>• **ảnh đại diện** phía mình của cụm này là ảnh gì (ảnh tài khoản Zalo, không có ảnh…)?<br>• cụm này vẫn tách theo **cùng ngày, cách ≤ 30 phút, tin hệ thống / bình chọn đứng riêng** như BR01 đúng không? | G036 BR07, BR08 (dựa vào nhân viên). G003 AF05: tin gửi từ điện thoại "không hiển thị tên người gửi". | Tên: **(a)** chỉ giờ, không tên. **(b)** khác — chị ghi giúp. | (1) Bác bỏ G003 — hiện **tên Zalo + giờ**. (2) Avatar cụm gửi từ điện thoại = **avatar tài khoản Zalo đó**; các cụm khác = avatar nhân viên gửi. (3) **Có.** Trân, 13/10/2026 |
| **Q-14** | Menu **"…"** (BR21) có hiện **đúng tập thao tác G003 cho phép theo từng loại tin** không? Vd tin khách không có Thu hồi; tin gửi từ điện thoại chỉ có Chuyển tiếp, Thu hồi. | G036 BR21: menu "…" = menu chuột phải (Copy, Ghim, Chọn nhiều, Xoá phía tôi, Người đã xem…). G003 §10D: mỗi loại tin một tập option. | **(a)** Theo tập thao tác G003 của từng loại tin.<br>**(b)** Menu giống nhau cho mọi tin. | |
| **Q-15** | **Video** trong khung chat: hiện ảnh xem trước đúng tỉ lệ (BR14) rồi bấm thì tải về như G003, hay **xem trực tiếp**? | G036 BR09, BR14: video đúng tỉ lệ ≤ 360 × 368, khung chờ. G003 §10D: video "hiển thị nút download; không view trực tiếp". | **(a)** Xem trước theo G036, bấm thì tải về theo G003.<br>**(b)** Xem trực tiếp. | G036 chính là bản cập nhật của G003 → hiển thị theo G036. Trân, 13/10/2026 *(QA hiểu: bấm vào video vẫn tải về theo G003 — chị sửa nếu sai)* |
| **Q-16** | Tin dài **tách nhiều phần**: chỉ một ô trạng thái dưới phần cuối (BR24), còn phần lỗi có viền đỏ + "Thử lại" ở đúng vị trí — đúng không? | G036 BR24: một ô dưới tin cuối. G003 BR03c: mỗi phần có trạng thái riêng Đang gửi / Đã gửi / Lỗi gửi. | **(a)** Đúng như trên.<br>**(b)** Mỗi phần vẫn hiện trạng thái. | |

## Phần D — Phát sinh khi thiết kế test case và review CX (13/10, không chặn việc)

| # | Nội dung | Tài liệu đang ghi | Phương án | BA trả lời |
| --- | --- | --- | --- | --- |
| **Q-17** | §10E "Ghim tin của chính tài khoản mình mà **không có tên** → hiện tên tài khoản": sau Q-13, "không có tên" còn chỉ loại tin nào? "Tên tài khoản" có phải "tên Zalo" không? | G036 §10E. | | |
| **Q-19 / Q-26** | **Ghim video** hiện nhãn gì (§10E không có nhãn video; G014 BR14 có `[Video]`)? **Trích dẫn tệp** hiện `[Tập tin]` (G036) hay `[File]` (G009)? | G036 BR13, §10E; G014 BR14; G009 §10B. | **(a)** `[Hình ảnh]` cho video, `[Tập tin]` cho tệp.<br>**(b)** `[Video]`, `[File]`. | |
| **Q-20** | Tin **giữa cụm** (không có giờ, không có tên) có cách xem giờ gửi / tên nhân viên không (vd rê chuột)? Nếu build có thì G036 cần ghi. | G036 BR07, BR09. | | |
| **Q-21** | "**Nhóm tin hệ thống đang thu gọn**" (BR19, AF04) quy định ở spec nào? Khi thu gọn, mốc "giờ + ngày" sau tin đứng riêng và khoảng cách 16px áp dụng thế nào? | G036 AF04, BR19, BR02, BR03. | | |
| **Q-22** | Màn cảm ứng: tooltip "Trưởng nhóm" / "Phó nhóm" có luôn hiện theo AF06 không? Mở **bảng chọn cảm xúc** bằng cách nào khi không rê chuột được? | G036 AF06, BR10, BR22. | | |
| **Q-23** | **Bấm vào video**: tải về (như G003) hay phát? Video có dấu hiệu phân biệt với ảnh không? *(bổ sung cho Q-15)* | G036 BR14; G003 §10D. | **(a)** Tải về.<br>**(b)** Phát trực tiếp. | |
| **Q-24** | Bấm 👍 **lần hai** trên tin đã Thích: gỡ Thích hay giữ nguyên? | G036 BR22; G009 BR02 (gỡ qua icon gạch chéo trong bảng chọn). | **(a)** Gỡ.<br>**(b)** Giữ, chỉ gỡ qua bảng chọn. | |
| **Q-25** | Sau khi bấm **"Thử lại"**: tin giữ vị trí hay xuống cuối? Viền đỏ tắt lúc nào? Có ô "Đang gửi" tạm cho tin đó không? | G036 E01, BR24. | | |
| **Q-27** | Bảng danh sách ghim: **Esc** có đóng không (G014 cũ có)? Ghim của tin đã thu hồi trong bảng có nhãn "Đã thu hồi" không? | G036 §10E; G014 §10B. | | |
| **Q-28** | Tin mới tới lúc đang đọc tin cũ (AF02): khung chat có **tín hiệu báo** gì không? Và "**đang ở đáy**" (AF01) tính thế nào — phải đang thấy tin cuối, hay còn cách đáy vài tin vẫn tự cuộn? | G036 AF01, AF02, BR26. | | |
| **Q-29** | Tin **trả lời bằng sticker hoặc ảnh** (không có khung tin chữ): phần trích dẫn hiện ở đâu, hình dạng thế nào? BR13 chỉ tả trích dẫn trong khung tin chữ; §10D.4 chỉ nói sticker trả lời "đứng riêng". | G036 BR13, §10D.4. | | |
| **Q-30** | Ảnh **nhỏ hơn** 360 × 368 (vd 200 × 150) giữ nguyên kích thước hay phóng to tới trần? | G036 BR14 "đúng tỉ lệ thật, rộng tối đa 360px, cao tối đa 368px". | **(a)** Giữ nguyên.<br>**(b)** Phóng to. | |
| **Bổ sung Q-09** | Tin cuối hội thoại là tin **chủ tài khoản gửi từ điện thoại**: ô trạng thái hiện mức gì? QA hiểu là chỉ từ `Đã gửi` trở lên, không có `Đang gửi` hay viền đỏ "Thử lại" (vì G003 §7 chỉ áp cho tin gửi từ web). | G036 BR24; G003 §7 "Tin nhắn gửi đi (từ web Gopany)". | **(a)** Đúng như QA hiểu.<br>**(b)** Khác — chị ghi giúp. | |
| **Bổ sung Q-06** | Mốc "~5 phút gần nhất" (BR27) tính từ lúc **rời** hội thoại hay lúc **mở**? Nếu tải lại ngầm **thất bại** (mất mạng) thì có gửi đánh dấu *đã đọc* không? QA hiểu: tính từ lúc rời; tải lỗi thì không gửi. | G036 UC-01 b2, b5; BR27. | **(a)** Đúng như QA hiểu.<br>**(b)** Khác — chị ghi giúp. | |
| **Bổ sung Q-05** | Khi cuộn lên tải thêm tin cũ, mốc "trước tin đầu danh sách" có dịch lên tin đầu mới không? | G036 BR03 ❶. | | |
| **Bổ sung Q-07** | Thứ tự "giờ + Today" hay "Today + giờ"; giờ 12h hay 24h; bản tiếng Anh của `+N ghim`, `Thu gọn`, `Thử lại`, `Phó nhóm`, `Tải sticker`… | G036 BR05, BR28. | | |

## Phản hồi của BA

| | |
| --- | --- |
| **Người trả lời** | Trân (BA) — Q-01, Q-02, Q-13, Q-15 |
| **Ngày trả lời** | 13/10/2026 (Q-01, Q-02, Q-13, Q-15) |
| **Ghi chú thêm** | |

## Lịch sử cập nhật (nội bộ QA — chị Trân không cần đọc)

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
| 2026-10-13 | AI (Orchestrator) | Tạo Phần A (Q-01, Q-02), Phần B (Q-03 → Q-11) |
| 2026-10-13 | Hồng (chuyển BA Trân) | Điền trả lời Q-01, Q-02; thêm Phần C với Q-13 |
| 2026-10-13 | Hồng (chuyển BA Trân) + AI | Điền Q-13; thêm Q-14 → Q-16 |
| 2026-10-13 | Hồng (chuyển BA Trân) + AI | Điền Q-15; thêm Phần D: Q-17, Q-19 → Q-28, bổ sung Q-05, Q-07 |
| 2026-10-13 | Hồng + AI (debate S4b) | Thêm Q-29, Q-30; bổ sung Q-06, Q-09, Q-28 |
