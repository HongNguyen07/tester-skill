---
featureId: G028
basedOn: 02-alignment-summary.md (gate: open, 2026-10-09, mở bởi Hồng (QA))
reviewedAt: 2026-10-09
modes: [1, 3]              # 1 = UI/UX/CX Review · 3 = Customer Journey Review (chỉ ở mức phân tích tài liệu). Không chạy Mode 2
evidenceLevel: phân tích tài liệu
---

# CX Review — G028: Tắt / Bật thông báo hội thoại

Viết tắt tham chiếu: `G028` = `tailieu/G028 - Tắt Bật thông báo hội thoại (1).md`; `G027`, `G003`, `G024` = file tương ứng
trong `tailieu/`. Số sau dấu `:` là số dòng.

**Đọc file này thế nào:** mọi nhận định về trải nghiệm bên dưới là `[CX GIẢ THUYẾT]` — suy ra từ câu chữ của tài liệu,
**chưa quan sát trên sản phẩm**. Câu mang nhãn `[NGUỒN]` là trích từ tài liệu. Không có finding nào là Defect. Khuyến
nghị trong từng finding là gợi ý, không phải requirement.

## 1. Phạm vi và nguồn đã xem

| # | Nguồn (tài liệu / design / prototype / sản phẩm) | Phạm vi | Cách xem (đọc tài liệu / xem ảnh / thao tác thật) |
| ---: | --- | --- | --- |
| 1 | `G028 - Tắt Bật thông báo hội thoại (1).md` — Status **Draft**, Last updated 2026-08-21 | Toàn bộ (161 dòng) | Đọc tài liệu |
| 2 | `G027 - Thông báo đẩy (Web & Mobile) (1).md` | Kênh phát (43–46), BR03 (87), BR04 (88), AC dòng 112 | Đọc tài liệu (các dòng đã trích trong `01-…`) |
| 3 | `G003 - Chat.md` | §10B "Conversation Item": dòng 412–424 (icon chuông 420, option menu 424) | Đọc tài liệu |
| 4 | `G024 - Thao tác hội thoại…(1).md` | Mô tả option menu: dòng 40, 143, 168, 180 | Đọc tài liệu |
| 5 | `wiki/qa/features/G028/01-requirement-analysis.md`, `02-alignment-summary.md` | Toàn bộ | Đọc tài liệu |

Phạm vi review: hai điểm vào (icon chuông panel phải, option menu danh sách), menu thời hạn, trạng thái icon, bật lại,
tự bật lại khi hết hạn, toast lỗi E01, hành trình "tắt để tập trung → hết hạn → nhận lại thông báo".

**Giới hạn:**

- Không có UI design, prototype, sản phẩm truy cập được hay công cụ thao tác → **không chạy Mode 2**. Mode 3 chỉ dựng
  hành trình từ câu chữ tài liệu. Mọi nhận định về hành vi thực tế là giả thuyết.
- Nguồn chính đang ở trạng thái Draft (người dùng đã chốt dùng bản Draft — Q-07).
- Sáu điểm Q-01 → Q-06 chưa có câu trả lời của BA. Finding nào chạm tới các điểm này được ghi là **phụ thuộc**, không
  chọn cách hiểu.
- G027, G003, G024 chỉ đọc các dòng nêu trên; G002 chưa đọc.
- Chưa có `03-test-design.md` và `04-testcases.md` → cột trace không dẫn được mã Scenario / Test Case.

## 2. Persona

| Persona | Nhóm khách hàng · bối cảnh | Mục tiêu | Căn cứ |
| --- | --- | --- | --- |
| P1 | Staff có quyền xem hội thoại, dùng chung tài khoản Zalo với nhân sự khác | Tắt thông báo một hội thoại để tập trung, rồi nhận lại thông báo khi hết hạn | `G028:20` "mọi nhân sự (Admin / Staff) có quyền xem hội thoại"; `G028:16` "để nhân sự tập trung mà không bị làm phiền"; `G028:86` |
| P2 | Admin có quyền xem hội thoại, trong mô hình tài khoản Zalo dùng chung | Tắt thông báo cho mình mà vẫn chắc người khác trong team còn nhận | `G028:20`; `G028:86`; `G028:161` |
| P3 | Nhân sự B dùng chung tài khoản với người đã tắt (không thao tác gì) | Vẫn nhận thông báo bình thường | `G028:132` "nhân sự B dùng chung tài khoản vẫn nhận thông báo bình thường" |
| P4 | Nhân sự lần đầu dùng chức năng, chưa biết quy tắc thời hạn | Hiểu mỗi lựa chọn nghĩa là gì trước khi chọn | **persona giả thuyết phục vụ review** |
| P5 | Nhân sự thao tác bằng bàn phím / công cụ hỗ trợ, hoặc trên màn hình cảm ứng | Tìm và dùng được chức năng mà không cần rê chuột | **persona giả thuyết phục vụ review** |
| P6 | Nhân sự đang ở mạng chập chờn | Biết thao tác tắt / bật có thành công không và làm lại được | **persona giả thuyết phục vụ review** (bối cảnh mất kết nối có ở `G028:73`; đặc điểm người dùng là giả thuyết) |

Không có dữ liệu nhân khẩu học hay hành vi người dùng thật nào được dùng.

## 3. Hành trình đã review

| Hành trình | Persona | Mục tiêu → các bước → phản hồi hệ thống → kết quả cuối → cách phục hồi | Nguồn |
| --- | --- | --- | --- |
| J1 — Tắt qua icon chuông | P1, P4 | Tắt thông báo hội thoại đang mở → bấm icon chuông ở panel phải → hệ thống hiện menu 4 thời hạn → chọn → icon chuyển chuông gạch chéo → không phát thông báo, số chưa đọc vẫn hiển thị. Phục hồi: bật lại (J3). Tài liệu không tả: phản hồi nào khác ngoài icon; đóng menu mà không chọn | `G028:42-46`, `G028:113-116` |
| J2 — Tắt qua option menu | P1, P5 | Tắt thông báo ngay từ danh sách → hover hàng hội thoại → ••• → "Tắt thông báo" → menu thời hạn → chọn → tắt. Tài liệu không tả: sau khi tắt, hàng hội thoại trong danh sách thể hiện trạng thái thế nào | `G028:30`, `G028:42-45`, `G028:114`; `G024:168` |
| J3 — Bật lại thủ công | P1 | Nhận lại thông báo trước hạn → bấm icon chuông gạch chéo → chọn "Bật thông báo" → bật ngay, hủy hẹn giờ → icon về chuông bình thường. Tài liệu không tả: bật lại từ option menu | `G028:52-53`, `G028:83`, `G028:118` |
| J4 — Tắt để tập trung → hết hạn → nhận lại thông báo (Mode 3) | P1, P2 | Yên tĩnh một khoảng rồi tự quay lại nhận thông báo → tắt có hẹn giờ (J1 / J2) → trong lúc tắt: tin vẫn về, số chưa đọc tăng, không thông báo → hết hạn: hệ thống tự bật lại, icon về trạng thái bật, không cần thao tác → kết quả cuối: tin mới sau mốc hết hạn được thông báo lại. Phục hồi nếu chọn nhầm thời hạn: bật lại thủ công (J3) hoặc tắt lại với thời hạn khác (AF02 — đường thao tác phụ thuộc Q-02). Tài liệu không tả: người dùng biết mốc hết hạn ở đâu; có tín hiệu nào lúc hết hạn; tin đã về trong lúc tắt được nhắc ra sao ngoài số chưa đọc | `G028:16`, `G028:62`, `G028:65`, `G028:81-85` |
| J5 — Thao tác thất bại | P6 | Tắt hoặc bật khi mất kết nối → toast "Không thực hiện được, vui lòng thử lại" → trạng thái giữ như trước. Phục hồi: làm lại thao tác từ đầu. Tài liệu không tả: trạng thái đang xử lý; menu thời hạn còn mở hay đóng sau lỗi | `G028:73` |

## 4. Tổng hợp finding

| ID | Loại | Tóm tắt | Persona | Impact | Mức bằng chứng | Trace (BR / UC / case) |
| --- | --- | --- | --- | --- | --- | --- |
| CX-01 | Usability Issue | Khi đang tắt, không có chỗ nào cho biết thời hạn đã chọn hay mốc hết hạn; icon không phân biệt tắt hẹn giờ với tắt vô thời hạn | P1, P2 | Cao | Phân tích tài liệu | BR01, BR02, AC-10, §7 State Machine |
| CX-02 | Usability Issue | Xác nhận thao tác thành công chỉ dựa vào icon chuông ở panel phải; đi từ option menu trong danh sách thì không rõ người dùng thấy xác nhận ở đâu | P1, P5 | Trung bình | Phân tích tài liệu | UC-01, AC-10 |
| CX-03 | CX Risk (rủi ro giả định) | Hết hạn tự bật lại không có tín hiệu nào được mô tả; tin đã về trong lúc tắt chỉ còn số chưa đọc → nguy cơ chậm phản hồi khách | P1, P2 | Cao | Phân tích tài liệu | AF01, BR02, BR05 |
| CX-04 | Usability Issue | Nhãn "Đến 8 giờ sáng" không cho biết là hôm nay hay hôm sau; chọn ngay trước 8:00 thì thời gian tắt rất ngắn | P1, P4 | Trung bình | Phân tích tài liệu | BR01, AC `G028:129-130` |
| CX-05 | Usability Issue | Nhãn mục ở option menu ghi bốn kiểu khác nhau trong ba tài liệu; không rõ nhãn đổi theo trạng thái hay cố định; bật lại từ option menu không được mô tả | P1, P4 | Trung bình | Phân tích tài liệu | UC-01, UC-02 |
| CX-06 | Usability Issue | Khi đang tắt: bật lại cần hai bước; đường đổi sang thời hạn khác không được mô tả (phụ thuộc Q-02) | P1 | Trung bình | Phân tích tài liệu | UC-02, AF02, BR03, BR04 |
| CX-07 | CX Risk (rủi ro giả định) | Giao diện mô tả không có gì cho người dùng biết việc tắt chỉ áp dụng cho riêng mình | P1, P2, P3 | Trung bình | Phân tích tài liệu | BR06, AC-BR06, OOS04 |
| CX-08 | CX Risk (rủi ro giả định) | Nhãn "Tắt thông báo" không nói điều gì vẫn tiếp tục xuất hiện (số chưa đọc; và các điểm phụ thuộc Q-01, Q-03) | P1, P4 | Trung bình | Phân tích tài liệu | BR05; G027 BR03, BR04 |
| CX-09 | Usability Issue | Toast E01 không nói thao tác nào thất bại và vì sao; trạng thái đang xử lý và cách làm lại không được mô tả | P6 | Trung bình | Phân tích tài liệu | E01 |
| CX-10 | Usability Issue | Điểm vào 2 chỉ được tả qua hover; trạng thái chỉ thể hiện bằng hình icon, không tả nhãn chữ / tooltip | P5 | Trung bình | Phân tích tài liệu | UC-01; phụ thuộc Q-06 |

Số lượng theo loại: Defect 0 · Usability Issue 7 · CX Risk 3 · Improvement Suggestion 0

Cột Impact là đánh giá của CX Agent `[CX GIẢ THUYẾT]`, chưa có quan sát thực tế làm căn cứ.

## 5. Chi tiết finding

### CX-01 — Khi đang tắt, không có chỗ nào cho biết thời hạn đã chọn hay mốc hết hạn

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-01 |
| Review scope | Trạng thái icon chuông sau khi tắt; hành trình J4 |
| Source evidence | `G028:116` "Chuông có gạch chéo (đang tắt) / chuông bình thường (đang bật)" · `G028:95-96` hai trạng thái "Đang tắt (hẹn giờ)" và "Đang tắt (vô thời hạn)" · `G028:81` bốn thời hạn · `G028:118` menu khi đang tắt chỉ nêu "Bật thông báo". Đã đọc toàn bộ G028: không có dòng nào tả việc hiển thị thời hạn còn lại hay mốc hết hạn |
| Persona và context | P1 — tắt một hội thoại để tập trung, sau đó quay lại và muốn biết khi nào thông báo tự bật; P2 — tắt nhiều hội thoại với các thời hạn khác nhau |
| Customer journey / scenario | J4, bước "trong lúc tắt" |
| Observation | `[NGUỒN]` Tài liệu định nghĩa hai trạng thái tắt nhưng chỉ một hình icon cho "đang tắt". `[CX GIẢ THUYẾT]` Người dùng nhìn icon không biết mình đã chọn thời hạn nào, còn bao lâu, và hội thoại này có tự bật lại hay không. Với "Cho đến khi bật lại", người dùng có thể quên là mình đã tắt vô thời hạn |
| Finding type | Usability Issue |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — không có requirement về việc hiển thị thời hạn; không có quan sát thực tế |
| Impact | Cao `[CX GIẢ THUYẾT]` — người dùng không dự đoán được lúc nào nhận lại thông báo; hội thoại tắt vô thời hạn có thể bị bỏ quên, đi ngược lý do "Chỉ tắt tiếng làm phiền, không bỏ lỡ tin" (`G028:85`) |
| Evidence và confidence / limitations | Bằng chứng: câu chữ tài liệu. Tin cậy trung bình: tài liệu là "thuần nghiệp vụ" (`G028:160`) nên design có thể bổ sung phần hiển thị này mà spec không ghi. Chưa kiểm được trên design hay sản phẩm |
| Recommendation | Gợi ý: cho người dùng thấy mốc hết hạn ở nơi họ thao tác (ví dụ tooltip của icon hoặc dòng mô tả trong menu khi đang tắt), và phân biệt được tắt vô thời hạn. Xem CP-01 |
| Traceability | BR01, BR02, AC-10 (`G028:133`), §7 State Machine. Test Case: Unlinked — chưa có `04-testcases.md` |
| Open questions / quyết định cần Product · BA · UX | Khi đang tắt, giao diện có hiển thị thời hạn / mốc hết hạn không? Hai trạng thái tắt có khác nhau về hiển thị không? |

### CX-02 — Xác nhận thành công chỉ dựa vào icon chuông ở panel phải; đi từ danh sách thì không rõ thấy xác nhận ở đâu

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-02 |
| Review scope | Phản hồi sau khi chọn thời hạn; điểm vào 2 (option menu danh sách) |
| Source evidence | `G028:45` "icon chuông chuyển trạng thái tắt" · `G028:113` "Icon chuông trong panel phải của hội thoại" · `G028:34` "Hội thoại đang mở hoặc đang ở màn hình danh sách hội thoại" · `G028:133` "Icon chuông đổi trạng thái đúng sau mỗi thao tác" · `G003:412-420` bảng "Conversation Item (mỗi card trong danh sách)" có dòng "Icon chuông". G028 không tả toast hay thông báo thành công |
| Persona và context | P1 — đang ở danh sách, tắt thông báo một hội thoại **không** mở (precondition cho phép, `G028:34`); P5 |
| Customer journey / scenario | J2, bước ngay sau khi chọn thời hạn |
| Observation | `[NGUỒN]` Phản hồi thành công duy nhất được mô tả là icon chuông đổi trạng thái; G028 đặt icon chuông ở panel phải của hội thoại, còn G003 liệt kê icon chuông là phần tử của card trong danh sách. `[CX GIẢ THUYẾT]` Nếu icon chỉ có ở panel phải thì người tắt từ danh sách một hội thoại không mở sẽ không nhìn thấy xác nhận nào, và về sau cũng không nhận ra hội thoại nào đang tắt khi lướt danh sách |
| Finding type | Usability Issue |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — không có quan sát thực tế; vị trí icon chuông giữa G028 và G003 chưa thống nhất nên vế "expected" cũng chưa đủ căn cứ |
| Impact | Trung bình `[CX GIẢ THUYẾT]` — người dùng không chắc thao tác đã có hiệu lực, có thể lặp lại thao tác hoặc mở hội thoại chỉ để kiểm tra |
| Evidence và confidence / limitations | Bằng chứng: câu chữ hai tài liệu. Tin cậy thấp–trung bình vì vị trí icon chuông chưa rõ (xem mục 7, dòng D-1). G003 dòng 420 còn ghi hướng cũ (Q-05) nên không dùng để kết luận |
| Recommendation | Gợi ý: làm rõ nơi hiển thị trạng thái tắt cho cả hai điểm vào trước khi viết case AC-10 |
| Traceability | UC-01, AC-10. Test Case: Unlinked — chưa có `04-testcases.md` |
| Open questions / quyết định cần Product · BA · UX | Icon chuông nằm ở panel phải, ở card danh sách, hay cả hai? Tắt từ option menu thì người dùng thấy xác nhận ở đâu? (liên quan Q-05 nhưng là câu hỏi khác — xem D-1) |

### CX-03 — Hết hạn tự bật lại không có tín hiệu; tin về trong lúc tắt chỉ còn số chưa đọc

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-03 |
| Review scope | AF01 tự bật lại; hành trình J4 đoạn "hết hạn → nhận lại thông báo" |
| Source evidence | `G028:62` "hệ thống tự bật lại thông báo, không cần thao tác" · `G028:82` "tự bật lại; icon chuông trở về trạng thái bật" · `G028:85` "số chưa đọc vẫn hiển thị, hội thoại vẫn nhận & lưu tin bình thường" — lý do "Chỉ tắt tiếng làm phiền, không bỏ lỡ tin" · `G028:20`, `G028:7` module "Chat / Chăm sóc khách hàng" |
| Persona và context | P1 — tắt để tập trung việc khác, không nhìn danh sách hội thoại trong lúc tắt; P2 |
| Customer journey / scenario | J4, từ mốc hết hạn trở đi |
| Observation | `[NGUỒN]` Tại mốc hết hạn, điều duy nhất được mô tả là icon về trạng thái bật. Tài liệu không nói có tín hiệu nào cho người dùng lúc hết hạn, cũng không nói tin đã về trong lúc tắt có được thông báo bù hay không. `[CX GIẢ THUYẾT]` Người dùng chỉ biết thông báo đã bật lại khi có tin mới kế tiếp; nếu khách đã nhắn trong lúc tắt và không nhắn thêm, người dùng chỉ phát hiện khi tự nhìn số chưa đọc |
| Finding type | CX Risk — rủi ro giả định |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — tài liệu không quy định hành vi với tin đã tích lũy; không có quan sát thực tế |
| Impact | Cao `[CX GIẢ THUYẾT]` — nguy cơ chậm phản hồi khách hàng, tức kết quả cuối của hành trình "nhận lại thông báo" không đạt với các tin đã về trong lúc tắt |
| Evidence và confidence / limitations | Bằng chứng: tài liệu im lặng về điểm này. Tin cậy trung bình. Chưa kiểm được: icon có tự đổi khi người dùng đang mở màn hình không; mốc hết hạn rơi vào lúc người dùng đóng tab / đăng xuất thì sao |
| Recommendation | Gợi ý: BA xác nhận hành vi với tin đã về trong lúc tắt (không phát bù là một lựa chọn hợp lệ, nhưng cần ghi rõ). Xem D-2 và CP-02 |
| Traceability | AF01, BR02, BR05, AC-BR02 (`G028:125`). Test Case: Unlinked — chưa có `04-testcases.md` |
| Open questions / quyết định cần Product · BA · UX | Khi hết hạn, tin đã về trong lúc tắt có được thông báo bù / gộp không, hay chỉ tin mới sau mốc hết hạn mới phát? |

### CX-04 — Nhãn "Đến 8 giờ sáng" không cho biết là hôm nay hay hôm sau

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-04 |
| Review scope | Menu thời hạn |
| Source evidence | `G028:115` "Dropdown: 1 giờ / 4 giờ / Đến 8 giờ sáng / Cho đến khi bật lại" · `G028:81` "tắt trước 8:00 → hết hạn 8:00 cùng ngày; tắt từ 8:00 trở đi → hết hạn 8:00 sáng hôm sau" · `G028:129-130` ví dụ 06:00 và 09:00 |
| Persona và context | P4 — lần đầu dùng, chọn "Đến 8 giờ sáng" vào sáng sớm; P1 — chọn vào cuối ngày để yên tĩnh qua đêm |
| Customer journey / scenario | J1 / J2, bước chọn thời hạn |
| Observation | `[NGUỒN]` Quy tắc cùng ngày / hôm sau chỉ nằm trong BR01; nhãn dropdown không mang thông tin ngày. `[CX GIẢ THUYẾT]` Người chọn lúc ngay trước 8:00 sẽ thấy thông báo quay lại sau một khoảng rất ngắn và có thể cho rằng chức năng không hoạt động; người chọn lúc 8:05 sáng sẽ tắt gần trọn một ngày mà có thể không lường trước |
| Finding type | Usability Issue |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — hành vi mô tả đúng theo BR01; đây là vấn đề về khả năng hiểu nhãn, không có quan sát thực tế |
| Impact | Trung bình `[CX GIẢ THUYẾT]` — thời gian tắt thực tế lệch với ý định của người dùng theo cả hai chiều |
| Evidence và confidence / limitations | Bằng chứng: câu chữ BR01 và nhãn ở §10. Tin cậy trung bình. **Phụ thuộc Q-04** (múi giờ tính "8 giờ sáng") — chưa có câu trả lời, finding này không giả định múi giờ nào. Kết hợp với CX-01: người dùng cũng không có nơi xem lại mốc hết hạn |
| Recommendation | Gợi ý: nhãn hoặc dòng phụ nêu mốc cụ thể tại thời điểm mở menu. Xem CP-03 |
| Traceability | BR01, AC-BR01 (`G028:129`, `G028:130`). Liên quan `[QA BỔ SUNG]` biên 07:59 / 08:00 / 08:01 ở `02-…` mục 10. Test Case: Unlinked |
| Open questions / quyết định cần Product · BA · UX | Q-04 (đã có). Nhãn có cần thể hiện ngày không — quyết định của UX / BA |

### CX-05 — Nhãn mục ở option menu không thống nhất; bật lại từ option menu không được mô tả

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-05 |
| Review scope | Điểm vào 2 — option menu của hội thoại trong danh sách |
| Source evidence | `G028:30` "hover → ••• → Tắt/Bật thông báo" · `G028:42` "chọn **Tắt thông báo** từ option menu" · `G028:114` "hover → ••• → Tắt thông báo" · `G003:424` "Bật/Tắt thông báo" · `G024:180` "Tắt / Bật thông báo" · `G028:52` UC-02 chỉ tả "Bấm icon chuông đang tắt → chọn Bật thông báo" |
| Persona và context | P1 — hội thoại đang tắt, muốn bật lại ngay từ danh sách; P4 — đọc nhãn để đoán hành động |
| Customer journey / scenario | J2 và J3 |
| Observation | `[NGUỒN]` Cùng một mục menu được viết theo các kiểu: "Tắt/Bật thông báo", "Tắt thông báo", "Bật/Tắt thông báo", "Tắt / Bật thông báo". UC-02 và dòng "Bật lại" ở §10 chỉ tả đường qua icon chuông. `[CX GIẢ THUYẾT]` Nếu nhãn là cố định kiểu "Tắt/Bật thông báo", người dùng không biết bấm vào sẽ tắt hay bật và không đọc được trạng thái hiện tại từ menu; nếu nhãn đổi theo trạng thái thì tài liệu chưa nói bấm "Bật thông báo" ở option menu có bật ngay hay không |
| Finding type | Usability Issue |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — nhãn chính thức chưa xác định được từ tài liệu; không có quan sát thực tế |
| Impact | Trung bình `[CX GIẢ THUYẾT]` — nhầm hành động, hoặc không tìm ra cách bật lại từ danh sách |
| Evidence và confidence / limitations | Bằng chứng: năm vị trí trích ở trên. Tin cậy cao về việc câu chữ không thống nhất; thấp về hành vi thực tế. Có thể các cách viết chỉ là viết tắt của cùng một ý "nhãn đổi theo trạng thái" — CX Agent không chọn cách hiểu |
| Recommendation | Gợi ý: BA xác nhận nhãn theo từng trạng thái và việc bật lại từ option menu (D-3) trước khi QA viết case cho điểm vào 2 |
| Traceability | UC-01, UC-02. Test Case: Unlinked — chưa có `04-testcases.md` |
| Open questions / quyết định cần Product · BA · UX | Nhãn mục ở option menu khi đang bật / khi đang tắt là gì? Bật lại từ option menu có được không, một bước hay qua menu con? |

### CX-06 — Khi đang tắt: bật lại cần hai bước; đường đổi thời hạn không được mô tả

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-06 |
| Review scope | Bật lại (UC-02) và tắt lại khi đang tắt (AF02) |
| Source evidence | `G028:52` "Bấm icon chuông đang tắt → chọn Bật thông báo" · `G028:118` "Bấm icon chuông gạch chéo → chọn Bật thông báo" · `G028:65` "Đang tắt mà chọn tắt tiếp với thời hạn khác → thời hạn reset về mốc mới chọn" · `G028:128` · `G028:92-99` không có dòng chuyển từ đang tắt sang đang tắt |
| Persona và context | P1 — đã chọn nhầm thời hạn (vd "Cho đến khi bật lại" thay vì "1 giờ") và muốn sửa |
| Customer journey / scenario | J3; J4 nhánh phục hồi "chọn nhầm thời hạn" |
| Observation | `[NGUỒN]` Bật lại được tả là hai bước: bấm icon rồi chọn "Bật thông báo". Tài liệu có quy tắc reset khi tắt lại nhưng không tả người dùng chọn tắt lại ở đâu. `[CX GIẢ THUYẾT]` Nếu menu lúc đang tắt chỉ có một mục "Bật thông báo" thì bước chọn là thừa và người muốn đổi thời hạn phải bật lại rồi tắt lại (bốn thao tác); nếu menu có cả các thời hạn thì hai bước là hợp lý. Tài liệu không cho biết trường hợp nào đúng |
| Finding type | Usability Issue |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — nội dung menu khi đang tắt chưa xác định; không có quan sát thực tế |
| Impact | Trung bình `[CX GIẢ THUYẾT]` — sửa lựa chọn nhầm tốn thao tác; trong khoảng "bật lại rồi tắt lại" thông báo có thể lọt ra |
| Evidence và confidence / limitations | Bằng chứng: câu chữ tài liệu. **Phụ thuộc Q-02** (đường thao tác tắt lại khi đang tắt và nhánh vô thời hạn) — chưa có câu trả lời, finding không chọn cách hiểu. Mức đánh giá sẽ đổi tùy câu trả lời |
| Recommendation | Gợi ý: xem lại finding này sau khi Q-02 có câu trả lời; không viết case UX cho nhánh này trước đó |
| Traceability | UC-02, AF02, BR03, BR04, AC-BR04 (`G028:128`). Test Case: Unlinked |
| Open questions / quyết định cần Product · BA · UX | Q-02 (đã có) |

### CX-07 — Giao diện mô tả không cho người dùng biết việc tắt chỉ áp dụng cho riêng mình

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-07 |
| Review scope | Phạm vi per-user trong mô hình tài khoản Zalo dùng chung |
| Source evidence | `G028:86` "tắt thông báo chỉ áp dụng cho chính người thao tác; nhân sự khác dùng chung tài khoản Zalo không bị ảnh hưởng" · `G028:132` · `G028:144` OOS04 "Tắt cho cả team… Backlog" · `G028:161` · §10 (`G028:111-118`) không có phần tử nào nói về phạm vi áp dụng · `G003:420` còn ghi "Zalo-native, per tài khoản Zalo" |
| Persona và context | P1 — Staff dùng chung tài khoản, phân vân có nên tắt; P2 — Admin muốn tắt một nhóm ồn cho cả team; P3 — đồng nghiệp không thao tác |
| Customer journey / scenario | J1 / J2, trước khi quyết định tắt |
| Observation | `[NGUỒN]` Phạm vi per-user là quy tắc đã chốt, nhưng phần UI/UX Notes không tả nội dung nào cho người dùng biết điều đó. `[CX GIẢ THUYẾT]` P1 có thể ngại tắt vì sợ cả team mất thông báo; P2 có thể tắt và tin rằng cả team đã được yên; hai nhân sự nhìn cùng một hội thoại thấy icon khác nhau và có thể cho là lỗi hiển thị |
| Finding type | CX Risk — rủi ro giả định |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — không có requirement về việc thông báo phạm vi cho người dùng; không có quan sát thực tế |
| Impact | Trung bình `[CX GIẢ THUYẾT]` — hiểu sai phạm vi dẫn tới phối hợp sai trong team (tưởng người khác vẫn / không còn nhận thông báo) |
| Evidence và confidence / limitations | Bằng chứng: BR06 và §10. Tin cậy trung bình. Mâu thuẫn với G003 dòng 420 đã được ghi ở **Q-05**, finding này không giải quyết. G002 chưa đọc |
| Recommendation | Gợi ý: một dòng chú thích ngắn ở menu thời hạn về phạm vi áp dụng. Xem CP-04 |
| Traceability | BR06, AC-BR06 (`G028:132`), OOS04. Test Case: Unlinked |
| Open questions / quyết định cần Product · BA · UX | Có cần nói rõ phạm vi "chỉ mình bạn" trên giao diện không — quyết định của Product / UX |

### CX-08 — Nhãn "Tắt thông báo" không nói điều gì vẫn tiếp tục xuất hiện

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-08 |
| Review scope | Kỳ vọng của người dùng trong thời gian tắt |
| Source evidence | `G028:85` "không phát thông báo cho hội thoại (toast / trình duyệt / push — G027); nhưng số chưa đọc vẫn hiển thị" · `G027:46` "Mọi trường hợp (kèm theo): Âm thanh báo + số chưa đọc trên tab/icon ứng dụng" · `G027:87` · `G027:88` "Ngoại lệ luôn báo dù đã tắt: @Mention (trong nhóm), Mất kết nối tài khoản Zalo, và Nhắc hẹn Cá nhân" · `G028:142` OOS02 |
| Persona và context | P1 — tắt một nhóm nhiều tin để tập trung; P4 — hiểu "tắt thông báo" theo nghĩa đen |
| Customer journey / scenario | J4, đoạn "trong lúc tắt" |
| Observation | `[NGUỒN]` Trong lúc tắt, số chưa đọc vẫn cập nhật. Hành vi với @Mention / Mất kết nối / Nhắc hẹn Cá nhân và với âm thanh **chưa xác định cho G028** (Q-01, Q-03). `[CX GIẢ THUYẾT]` Dù BA trả lời Q-01 và Q-03 theo hướng nào, menu và nhãn được mô tả không cho người dùng biết phần nào còn, phần nào mất; nếu vẫn có thứ gì đó xuất hiện sau khi tắt, người dùng có thể cho rằng chức năng không hoạt động |
| Finding type | CX Risk — rủi ro giả định |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — vế "expected" cho ngoại lệ và âm thanh còn phụ thuộc Q-01, Q-03; không có quan sát thực tế |
| Impact | Trung bình `[CX GIẢ THUYẾT]` — mất niềm tin vào chức năng, hoặc báo lỗi nhầm |
| Evidence và confidence / limitations | Bằng chứng: câu chữ G028 và G027. **Phụ thuộc Q-01 và Q-03** — finding không chọn cách hiểu nào; mức độ và nội dung cụ thể chỉ xác định được sau khi BA trả lời. Phần "số chưa đọc vẫn hiển thị" là đúng requirement, không phải vấn đề |
| Recommendation | Gợi ý: sau khi có câu trả lời Q-01 / Q-03, cân nhắc mô tả ngắn về những gì vẫn được báo. Xem CP-05 |
| Traceability | BR05, AC-BR05 (`G028:124`, `G028:131`); G027 BR03, G027 BR04. Test Case: Unlinked |
| Open questions / quyết định cần Product · BA · UX | Q-01, Q-03 (đã có) |

### CX-09 — Toast E01 không nói thao tác nào thất bại và vì sao; trạng thái đang xử lý không được mô tả

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-09 |
| Review scope | Luồng ngoại lệ E01 |
| Source evidence | `G028:73` Trigger "Thao tác tắt/bật thất bại (mất kết nối)" — Ứng xử: Toast "Không thực hiện được, vui lòng thử lại"; giữ nguyên trạng thái trước đó. G028 không có dòng nào về trạng thái đang xử lý hay thời gian chờ |
| Persona và context | P6 — mạng chập chờn, vừa chọn thời hạn hoặc vừa bấm "Bật thông báo" |
| Customer journey / scenario | J5 |
| Observation | `[NGUỒN]` Một câu toast dùng chung cho cả tắt lẫn bật; nguyên nhân duy nhất được nêu trong spec là mất kết nối, nhưng câu toast không nhắc tới kết nối. `[CX GIẢ THUYẾT]` (1) Người dùng không biết "không thực hiện được" là việc gì nếu toast hiện chậm sau thao tác. (2) Lời khuyên "thử lại" không giúp ích khi nguyên nhân là mất mạng mà người dùng không được báo. (3) Từ lúc chọn đến lúc có kết quả, tài liệu không tả tín hiệu đang xử lý; nếu icon đổi ngay rồi quay lại khi lỗi, người dùng đã rời mắt sẽ tin là đã tắt và sau đó bị thông báo làm phiền, hoặc tin là đã bật lại mà vẫn không nhận thông báo. (4) Làm lại nghĩa là đi lại toàn bộ các bước |
| Finding type | Usability Issue |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — nội dung toast là requirement (`G028:73`); không có quan sát thực tế để so |
| Impact | Trung bình `[CX GIẢ THUYẾT]` — nhánh nặng nhất là bật lại thất bại mà người dùng không nhận ra: tiếp tục không có thông báo cho hội thoại khách hàng |
| Evidence và confidence / limitations | Bằng chứng: một dòng E01. Tin cậy trung bình. Điểm (3) hoàn toàn là giả thuyết về cách hiện thực. Chưa kiểm được: toast hiện bao lâu, hiện ở đâu, có trùng vị trí với toast thông báo tin mới của G027 không |
| Recommendation | Gợi ý: QA kiểm trạng thái icon và menu sau lỗi ở cả hai điểm vào (mục 7, dòng V-3). Câu chữ toast: xem CP-06 |
| Traceability | E01. Test Case: Unlinked — chưa có `04-testcases.md` |
| Open questions / quyết định cần Product · BA · UX | Thất bại vì lý do khác mất kết nối (vd lỗi máy chủ, mất quyền xem hội thoại giữa chừng) có dùng cùng toast này không? (D-4) |

### CX-10 — Điểm vào 2 chỉ được tả qua hover; trạng thái chỉ thể hiện bằng hình icon

| Trường | Nội dung |
| --- | --- |
| Finding ID | CX-10 |
| Review scope | Khả năng tiếp cận và thao tác của hai điểm vào, icon trạng thái |
| Source evidence | `G028:30`, `G028:114` "hover → ••• → Tắt thông báo" · `G024:168` "hover vào hàng hội thoại ở panel trái → hiện icon ••• (Thêm); bấm (hoặc chuột phải vào hàng) → mở Option menu" · `G003:424` "Option menu (hiện khi hover)" · `G028:116` "Chuông có gạch chéo (đang tắt) / chuông bình thường (đang bật)" · §10 không tả nhãn chữ, tooltip hay cách thao tác bằng bàn phím |
| Persona và context | P5 — persona giả thuyết phục vụ review: thao tác bằng bàn phím / công cụ hỗ trợ, hoặc màn hình cảm ứng không có hover |
| Customer journey / scenario | J1 và J2, bước tìm điểm vào và đọc trạng thái |
| Observation | `[NGUỒN]` Nút ••• chỉ hiện khi rê chuột (hoặc chuột phải theo G024); trạng thái tắt / bật chỉ được tả bằng hình dạng icon. `[CX GIẢ THUYẾT]` Người không dùng chuột không có cách mở option menu được mô tả; người mới không biết icon chuông là nút bấm mở menu; khác biệt "có gạch chéo / không gạch chéo" ở kích thước icon nhỏ dễ bị bỏ sót |
| Finding type | Usability Issue |
| Steps to reproduce | N/A — chưa có sản phẩm để tái hiện |
| Expected vs observed | N/A — tài liệu không có requirement về tiếp cận; không có quan sát thực tế |
| Impact | Trung bình `[CX GIẢ THUYẾT]` — với nhóm P5 có thể không hoàn thành được qua điểm vào 2; điểm vào 1 vẫn là đường thay thế nếu thao tác được bằng bàn phím (chưa kiểm được) |
| Evidence và confidence / limitations | Bằng chứng: câu chữ ba tài liệu. Tin cậy thấp: spec "thuần nghiệp vụ" không tả chi tiết tương tác; không có design để xem kích thước, tooltip, thứ tự focus. **Phụ thuộc Q-06** (mobile có thao tác tắt / bật không) — finding không giả định có hay không |
| Recommendation | Gợi ý: khi có design / bản build, review lại riêng phần bàn phím, tooltip, nhãn cho công cụ hỗ trợ |
| Traceability | UC-01 (Trigger 1, Trigger 2). Không có BR / AC về tiếp cận → phần đó `Unlinked`. Test Case: Unlinked |
| Open questions / quyết định cần Product · BA · UX | Q-06 (đã có). Có yêu cầu về tiếp cận cho sản phẩm không — cần Product trả lời, tài liệu trong phạm vi không nêu |

## 6. Đề xuất cải thiện (luồng riêng — không phải requirement)

Tất cả mang nhãn `[ĐỀ XUẤT THAY ĐỔI]`. Không mục nào được dùng làm expected result.

| ID | Đề xuất | Lý do | Cần ai quyết định | Trạng thái |
| --- | --- | --- | --- | --- |
| CP-01 | Hiển thị mốc hết hạn khi đang tắt (tooltip icon hoặc dòng trong menu), phân biệt tắt vô thời hạn | CX-01 | Product / UX, BA cập nhật spec nếu duyệt | Đề xuất — chưa ai xem |
| CP-02 | Khi hết hạn, có tín hiệu nhẹ cho người dùng nếu hội thoại có tin chưa đọc tích lũy trong lúc tắt | CX-03 | Product / BA | Đề xuất — chưa ai xem; chỉ xét sau khi D-2 có câu trả lời |
| CP-03 | Nhãn "Đến 8 giờ sáng" kèm mốc cụ thể tính tại lúc mở menu | CX-04 | UX / BA | Đề xuất — chưa ai xem; phụ thuộc Q-04 |
| CP-04 | Dòng chú thích ở menu thời hạn nói rõ chỉ áp dụng cho người thao tác | CX-07 | Product / UX | Đề xuất — chưa ai xem |
| CP-05 | Mô tả ngắn những gì vẫn được báo khi đang tắt | CX-08 | Product / UX | Đề xuất — chưa ai xem; phụ thuộc Q-01, Q-03 |
| CP-06 | Toast lỗi nêu tên thao tác và nguyên nhân kết nối; có tín hiệu đang xử lý | CX-09 | UX / BA (nội dung toast hiện là requirement `G028:73`) | Đề xuất — chưa ai xem |

## 7. Chuyển cho QA / quay lại Debate

Không có mục nào thuộc loại "nghi vi phạm requirement": chưa có hành vi thực tế nào để đối chiếu.

| # | Nội dung | Chuyển đi đâu (QA xác minh / Debate — câu hỏi về cách hiểu tài liệu) | Nguồn |
| ---: | --- | --- | --- |
| D-1 | Icon chuông nằm ở đâu: G028 ghi "trong panel phải của hội thoại"; G003 liệt kê "Icon chuông" là phần tử của "Conversation Item (mỗi card trong danh sách)". Trạng thái tắt có hiển thị trên hàng hội thoại trong danh sách không? | Debate — câu hỏi mới về cách hiểu tài liệu (khác Q-05: Q-05 nói về phạm vi per-user, không nói về vị trí icon) | `G028:29`, `G028:113`; `G003:412-420` · CX-02 |
| D-2 | Khi hết hạn tự bật lại, tin đã về trong lúc tắt có được thông báo bù không, hay chỉ tin mới sau mốc hết hạn? | Debate — câu hỏi mới; tài liệu im lặng | `G028:62`, `G028:82`, `G028:85` · CX-03 |
| D-3 | Nhãn mục option menu theo từng trạng thái ("Tắt thông báo" / "Bật thông báo" hay nhãn cố định "Tắt/Bật thông báo")? Bật lại từ option menu có được không và mấy bước? | Debate — câu hỏi mới; liền kề Q-02 nhưng Q-02 chỉ hỏi về menu chuông và nhánh vô thời hạn | `G028:30`, `G028:42`, `G028:52`, `G028:114`; `G003:424`; `G024:180` · CX-05 |
| D-4 | E01 ghi trigger "(mất kết nối)". Thất bại vì lý do khác có dùng cùng toast không? | Debate — câu hỏi mới, mức thấp | `G028:73` · CX-09 |
| D-5 | CX-06, CX-08, CX-04, CX-10 lần lượt phụ thuộc Q-02; Q-01 và Q-03; Q-04; Q-06. Cần xem lại các finding này khi BA trả lời | Debate — các câu đã có, không mở câu mới | `02-alignment-summary.md` mục 3 |
| V-1 | Sau khi tắt / bật từ **option menu**, kiểm trạng thái hiển thị ở cả hai nơi (panel phải và danh sách) có khớp nhau không, kể cả khi hội thoại không mở | QA xác minh — đã có ý tương tự ở `[QA BỔ SUNG]` "hai điểm vào hiển thị cùng một trạng thái"; kỳ vọng cho phần danh sách chờ D-1 | `G028:133` AC-10 · CX-02 |
| V-2 | Tại mốc hết hạn, khi người dùng **đang mở** màn hình: icon có về trạng thái bật mà không cần tải lại trang không. Và khi mốc hết hạn rơi vào lúc đóng tab: mở lại thấy trạng thái bật | QA xác minh — vế "icon trở về trạng thái bật" có nguồn `G028:82`; vế "không cần tải lại" là `[QA BỔ SUNG]`, ghi "ĐO & GHI" | `G028:62`, `G028:82` · CX-03 |
| V-3 | Sau E01 ở từng thao tác (tắt, bật lại) và từng điểm vào: icon giữ đúng trạng thái trước đó; không có khoảng icon hiển thị sai trạng thái; ghi lại menu thời hạn còn mở hay đóng | QA xác minh — "giữ nguyên trạng thái trước đó" có nguồn `G028:73`; các ý còn lại là `[QA BỔ SUNG]`, ghi "ĐO & GHI" | `G028:73` · CX-09 |
| V-4 | Mở menu thời hạn rồi đóng mà không chọn (bấm ra ngoài / Esc): trạng thái không đổi | QA xác minh — `[QA BỔ SUNG]`, tài liệu không tả; ghi "ĐO & GHI" | `G028:43-44` |
| V-5 | Chọn "Đến 8 giờ sáng" sát mốc 8:00: ghi lại thời gian tắt thực tế và điều người dùng nhìn thấy | QA xác minh — trùng `[QA BỔ SUNG]` biên 07:59 / 08:00 / 08:01; phụ thuộc Q-04 | `G028:81` · CX-04 |
| V-6 | Khi có bản build hoặc design: review lại thao tác bàn phím, tooltip, khả năng nhận biết icon gạch chéo | CX Agent chạy lại (Mode 2) khi được cấp sản phẩm và công cụ | `G028:116` · CX-10 |

## 8. Tự rà soát

- [x] Mỗi finding có loại, persona, bằng chứng nguồn, mức bằng chứng, giới hạn
- [x] Không Defect nào thiếu bằng chứng thực tế — không có finding Defect
- [x] Không câu nào nói đã thao tác / đã thấy khi chỉ phân tích tài liệu
- [x] Persona giả thuyết đã đánh dấu — P4, P5, P6
- [x] Đề xuất cải thiện nằm riêng ở mục 6, không lẫn vào requirement
- [x] Số liệu đã đếm lại: 10 finding (7 Usability Issue, 3 CX Risk), 6 persona (3 có căn cứ, 3 giả thuyết), 5 hành trình, 6 đề xuất CP, 5 mục Debate (4 câu mới + 1 mục phụ thuộc), 6 mục chuyển xác minh
- [x] Không sửa `01-…`, `02-…`, `tailieu/`; không tự chọn cách hiểu cho Q-01 → Q-06
- Giới hạn còn lại: không có design / sản phẩm; mức Impact là nhận định của CX Agent; trace tới Test Case đều `Unlinked` vì chưa có `04-testcases.md`; mã `D-n`, `V-n` là mã cục bộ của file này, mã `CP-n` do CX Agent đánh
