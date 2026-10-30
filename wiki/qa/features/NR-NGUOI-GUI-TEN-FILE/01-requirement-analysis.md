---
featureId: NR-NGUOI-GUI-TEN-FILE   # mã tạm của QA — tài liệu ghi "ID: —" (NR:5); đổi khi BA cấp mã
title: "[Zalo Chat] Hiển thị người gửi và tên file trên danh sách hội thoại"
analyzedAt: 2026-10-27
analyst: Requirement Analyst (AI) — người dùng: Hồng (QA)
---

# Requirement Analysis — NR-NGUOI-GUI-TEN-FILE: Hiển thị người gửi và tên file trên danh sách hội thoại

Viết tắt tham chiếu: `NR` = `tailieu/[NR] [Zalo Chat] Hiển thị người gửi và tên file trên danh sách hội thoại.md`;
`G003` = `tailieu/G003 - Chat.md` (v1.11); `G036` = `tailieu/G036 - Giao diện khung hội thoại.md` (v1.0);
`G032` = `tailieu/G032 - Đổi tên gợi nhớ (1).md` (v1.0 — bản hiệu lực, Hồng chốt 2026-10-07);
`G029` = `tailieu/G029 - Đếm tin nhắn chưa đọc.md`; `G008` = `tailieu/G008 - Quản lý nhóm.md` (v1.1);
`G006` = `tailieu/G006 - Đồng bộ dữ liệu.md` (v1.1);
`CR-RES` = `tailieu/[CR] [Zalo Chat] Tối ưu responsive giao diện hội thoại (1).md` (22/10/2026). Số sau dấu `:` là số dòng.

## 1. Nguồn và phạm vi đã đọc

| # | Tệp | Version ghi trong tệp | Phạm vi đã đọc | Ghi chú |
| ---: | --- | --- | --- | --- |
| 1 | `NR` | **Không có version** — change log trống (`NR:131-134`) · ID `—` (`NR:5`) · 19/10/2026 · AVZ yêu cầu · Priority Medium · Status Approved · BA Nguyễn Thị Phương Thảo (`NR:5-9`) | Toàn bộ (134 dòng) | Nguồn chính. Tiêu đề ghi `[NR/CR]`, bảng Request có 1 NR + 1 CR (`NR:41-42`) |
| 2 | `G003` | 1.11 | UC-01 danh sách (`59-70`), UC-06 thu hồi/xóa (`180-187`), AF05 tin gửi từ điện thoại (`252-257`), BR06 / BR07 / BR09 (`302-305`), §10B Conversation Item (`412-422`), §10D hiển thị tin (`453-469`), Platform (`385`), OOS08 (`650`) | Logic hiện tại của danh sách và thu hồi/xóa |
| 3 | `G036` | 1.0 | BR06 tên người gửi phía khách (`139`), BR19 tin hệ thống (`152`), §10E thanh ghim (`234`) | Quy tắc tên hiện hành trong khung chat; thanh ghim dùng dạng `Tên người gửi: nội dung` gần giống NR |
| 4 | `G032` | 1.0 (Last updated 2026-09-22) | BR01–BR02 (`135-136`), BR03 (`137`), BR05 (`139`), BR07 (`141`), BR08–BR09 (`142-143`), BR13–BR14 (`147-148`), AC-BR04 (`293`) | Quy tắc tên gợi nhớ mà NR BR-05 / BR-06 kế thừa |
| 5 | `G029` | — | §UI badge (`123`), BR04 (`93`), BR07 (`96`), E05 (`72`) | Badge chưa đọc mà NR AC-25 / AC-26 nhắc |
| 6 | `G008` | 1.1 | UC-04 đổi tên nhóm (`135`), UC-07 rời nhóm + toggle im lặng (`184-193`), AC (`429-430`) | Thông báo hệ thống mà NR BR-14 / AC-22 nhắc |
| 7 | `G006` | 1.1 | Phạm vi đồng bộ (`27`), BR05–BR06 danh bạ (`172-173`), OOS04 webhook (`345`) | Chỉ đồng bộ thẻ và danh bạ — **không có đồng bộ tin nhắn** |
| 8 | `CR-RES` | không ghi version · 22/10/2026 | UI xem trước + badge (`98-99`), BR-15 truncate (`126`) | Quy tắc truncate hiện hành của danh sách. `tailieu/` có 2 file `(1).md` và `(1) (1).md` **giống hệt nhau** (diff = 0) |

**Không có trong `tailieu/`:**
- Spec hiện tại của **dòng tin nhắn** trên danh sách: G003 §10B chỉ ghi "Tin nhắn cuối: Preview nội dung + thời gian tương đối" (`G003:418`); nhãn `[Tệp]`, `[Hình ảnh]`, `[Sticker]` chỉ xuất hiện trong NR (`NR:13`, `NR:66`). G036 thanh ghim dùng `[Nhãn dán]` · `[Tập tin]` (`G036:234`).
- Spec **danh sách hội thoại trên mobile**: G003 ghi *Platform: Web only* (`G003:385`), *Mobile app* là OOS08 (`G003:650`). NR áp dụng desktop/mobile (`NR:27`).
- Cơ chế **đồng bộ tin nhắn gửi từ app Zalo** về Gopany và đồng bộ trạng thái thu hồi từ Zalo: G006 không có (`G006:27`), G003 AF05 chỉ mô tả kết quả hiển thị (`G003:252-257`).
- **Design / Figma** cho icon đính kèm và bố cục dòng tin nhắn.
- **Ảnh hiện trạng** dòng tin nhắn.

## 2. Mục tiêu và phạm vi feature `[NGUỒN]`

- Tại sidebar danh sách hội thoại, bổ sung **tên người gửi** vào dòng tin nhắn gần nhất và **thay nhãn `[Tệp]` bằng icon đính kèm + tên file**, để nhân sự nhận diện người gửi và tài liệu mà không cần mở hội thoại (`NR:13-15`).
- "Dòng tin nhắn" = dòng hiển thị tin gần nhất bên dưới tên hội thoại; tin đã đọc và chưa đọc đều ở đó; việc **xác định tin hiển thị kế thừa logic hiện tại** (`NR:17`).
- In scope (`NR:23-27`): người gửi trên hội thoại cá nhân và nhóm; hiển thị tin file; **thêm** thể hiện trạng thái thu hồi/xóa trên dòng tin nhắn; dữ liệu gồm tin gửi qua Gopany, tin do chính tài khoản liên kết gửi từ app Zalo, tin nhận từ khách / thành viên nhóm; desktop/mobile. Kế thừa phân quyền, phân công, thu hồi/xóa, lưu giữ, đồng bộ (`NR:29`).
- Out of scope (`NR:33-35`): ảnh thu nhỏ trên dòng tin nhắn; icon riêng theo loại file; mở/tải file từ dòng tin nhắn.
- Hai yêu cầu: **NR-01** bổ sung người gửi + nhãn thu hồi/xóa + rút gọn một dòng (`NR:41`); **CR-01** thay `[Tệp]` bằng icon + tên file, không có tên thì giữ `[Tệp]` (`NR:42`).

## 3. Actor, precondition, trigger

| Mục | Nội dung | Nguồn | Nhãn |
| --- | --- | --- | --- |
| Actor xem | Nhân sự Gopany có quyền xem hội thoại (Admin/Owner thấy mọi hội thoại — G003 BR11; Staff theo phân công — G003 BR16) | `NR:94-99`, `G003:307`, `G003:312` | `[NGUỒN]` |
| Actor gửi | (1) Nhân sự gửi qua Gopany; (2) chủ tài khoản Zalo gửi từ app Zalo bằng chính tài khoản đang liên kết; (3) khách hàng trong hội thoại cá nhân; (4) thành viên khác trong nhóm | `NR:48-53` | `[NGUỒN]` |
| Precondition | Hội thoại thuộc một tài khoản Zalo đang liên kết; nhân sự có quyền xem; tin đã có trên Gopany (gửi qua Gopany hoặc đã đồng bộ về) | `NR:59`, `NR:96` | `[NGUỒN]` |
| Trigger | Tin mới được hiển thị trên danh sách theo logic hiện tại; tin đang hiển thị đổi trạng thái thu hồi/xóa; tên gợi nhớ được đặt/đổi/gỡ | `NR:17`, `NR:71`, `NR:64` | `[NGUỒN]` |
| Nền tảng | Desktop/mobile (`NR:27`); G003 hiện hành chỉ *Web only* (`G003:385`) | | `[NGUỒN]` — xem Q-02 |

## 4. Use case và luồng

NR không viết use case; QA tách luồng từ bảng nguồn gửi (`NR:48-53`) và AC.

| Mã | Tên | Main flow | Alternate flow | Exception flow | Nguồn |
| --- | --- | --- | --- | --- | --- |
| UC-01 | Xem người gửi trên dòng tin nhắn | Tin gần nhất của hội thoại được hiển thị → dòng tin nhắn ghép `{tiền tố}: {nội dung}` theo nguồn gửi | Khách gửi trong hội thoại cá nhân → không tiền tố (`NR:62`) | — | `NR:48-53`, `NR:94-99` |
| UC-02 | Xem tin file trên dòng tin nhắn | Tin file có tên → icon đính kèm + tên file (`NR:67`) | Không có tên file → giữ `[Tệp]` (`NR:68`) | — | `NR:42`, `NR:105-106` |
| UC-03 | Tin đang hiển thị bị thu hồi/xóa | Hệ thống ghi nhận trạng thái → dòng tin nhắn thêm nhãn `[Đã thu hồi]` / `[Đã xóa]` sau tiền tố, giữ nội dung (`NR:69`, `NR:71`) | Có tin tiếp theo → dòng chuyển sang tin mới, không giữ nhãn cũ (`NR:71`) | — | `NR:107-114` |
| UC-04 | Tên gợi nhớ của người gửi thay đổi | Đặt / đổi / gỡ tên gợi nhớ → tiền tố trong nhóm cập nhật theo quy tắc tên hiển thị (`NR:64`) | Tên đổi trên app Zalo → theo cơ chế và thời điểm đồng bộ hiện tại (`NR:64`; G032 BR09 `G032:143`) | — | `NR:100` |
| UC-05 | Rút gọn dòng tin nhắn | Desktop: tên đầy đủ, cả dòng rút gọn bằng `…` (`NR:73`). Mobile: tên > 20 ký tự → 20 ký tự + `…` trước `: `, rồi giới hạn cả dòng (`NR:74-75`) | — | — | `NR:116-118` |

## 5. Business rule

Mã BR-01…BR-17 là **mã gốc của tài liệu** (`NR:59-75`). Bảng "Đối chiếu nguồn gửi" (`NR:48-55`) không có mã; QA gọi là **BR-00**.

| Mã | Nội dung (sát nguyên văn) | Loại | Nguồn | Nhãn |
| --- | --- | --- | --- | --- |
| BR-00 | Nhân sự gửi qua Gopany → `{Tên nhân sự thực hiện gửi}: {Nội dung}`; chính tài khoản liên kết gửi từ app Zalo → `{Tên Zalo của tài khoản gửi}: {Nội dung}`; khách gửi trong hội thoại cá nhân → `{Nội dung}`; thành viên khác trong nhóm → `{Tên hiển thị của thành viên}: {Nội dung}` (ưu tiên tên gợi nhớ, chưa có thì tên Zalo). Tin đã thu hồi/xóa: nhãn trạng thái **trước nội dung, sau tiền tố**; tiền tố theo nguồn gửi ban đầu, không đổi theo nơi/người thu hồi | nghiệp vụ | `NR:48-55` | `[NGUỒN]` |
| BR-01 | Mỗi hội thoại thuộc một tài khoản Zalo. Tin gửi đi = tin gửi bằng chính tài khoản Zalo của hội thoại; tin nhận = tin do khách hoặc thành viên khác gửi đến tài khoản này. Xác định phía gửi **không phụ thuộc nhân sự đang đăng nhập** | nghiệp vụ | `NR:59` | `[NGUỒN]` |
| BR-02 | Tin gửi qua Gopany → `{Tên nhân sự}: {Nội dung}` ở cả cá nhân và nhóm. Tên lấy từ người thực hiện gửi **ghi nhận trên tin nhắn**, kế thừa quy tắc tên trong chi tiết hội thoại. Mọi nhân sự có quyền xem thấy cùng tên, **kể cả chính người gửi**. Không lấy người được phân công | nghiệp vụ / dữ liệu | `NR:60` | `[NGUỒN]` |
| BR-03 | Tin do chính tài khoản Zalo của hội thoại gửi từ app Zalo rồi đồng bộ về → `{Tên Zalo của tài khoản gửi}: {Nội dung}`. Tên lấy từ đúng tài khoản đã gửi, **kế thừa nguồn tên đang dùng cho tin này trong chi tiết hội thoại**. Không dùng tên nhân sự liên kết / đồng bộ / được phân công | nghiệp vụ / dữ liệu | `NR:61` | `[NGUỒN]` — dẫn chiếu treo, xem Q-01 |
| BR-04 | Khách gửi trong hội thoại cá nhân → chỉ nội dung, không tiền tố | nghiệp vụ | `NR:62` | `[NGUỒN]` |
| BR-05 | Thành viên khác gửi vào nhóm → `{Tên hiển thị}: {Nội dung}`; ưu tiên tên gợi nhớ, chưa có thì tên Zalo. Tên lấy theo liên hệ thuộc **đúng tài khoản Zalo của hội thoại**, không lấy tên gợi nhớ từ liên hệ của tài khoản khác | nghiệp vụ / dữ liệu | `NR:63` | `[NGUỒN]` — xem Q-03 |
| BR-06 | Tên gợi nhớ đặt / đổi / gỡ trong hệ thống → tên người gửi trong nhóm cập nhật theo quy tắc tên hiển thị hiện hành. Tên đổi trên app Zalo kế thừa cơ chế và thời điểm đồng bộ hiện tại | nghiệp vụ | `NR:64` | `[NGUỒN]` |
| BR-07 | Tin trả lời: người gửi = người gửi tin trả lời, không phải người của tin trích dẫn. Tin chuyển tiếp: người gửi = người chuyển tiếp vào hội thoại hiện tại, không phải người gửi ban đầu. Tiền tố theo nguồn gửi như BR-02…BR-05 | nghiệp vụ | `NR:65` | `[NGUỒN]` |
| BR-08 | Nội dung text, ảnh, sticker và loại khác ngoài file kế thừa cách hiển thị hiện tại, gồm nhãn `[Hình ảnh]` và `[Sticker]`. Chỉ bổ sung tiền tố và nhãn thu hồi/xóa | nghiệp vụ | `NR:66` | `[NGUỒN]` — nhãn hiện tại không có spec, xem Q-08 |
| BR-09 | Tin file có tên: thay `[Tệp]` bằng icon đính kèm + tên file theo dữ liệu tin nhắn. Tiền tố và nhãn trạng thái áp dụng như tin khác. Tên file nằm trong phần nội dung, rút gọn theo không gian còn lại của cả dòng | nghiệp vụ / dữ liệu | `NR:67` | `[NGUỒN]` |
| BR-10 | Tin file không có tên: giữ `[Tệp]`, không tự đặt tên. Tiền tố và nhãn trạng thái vẫn áp dụng | nghiệp vụ / dữ liệu | `NR:68` | `[NGUỒN]` |
| BR-11 | Tin đã thu hồi: nội dung + nhãn `[Đã thu hồi]`. Tin đã xóa: nội dung + nhãn `[Đã xóa]`. Nhãn **trước nội dung, sau tiền tố**; tin nhận trong hội thoại cá nhân không có tiền tố nên nhãn đứng đầu dòng | nghiệp vụ | `NR:69` | `[NGUỒN]` |
| BR-12 | Tiền tố = người gửi; nhãn = trạng thái tin, không phải người thao tác. Sau thu hồi/xóa tiền tố vẫn theo người gửi ban đầu. Áp dụng khi thao tác trên Gopany và khi trạng thái từ Zalo đồng bộ về. Quyền thao tác và cách hiển thị người thực hiện trong chi tiết kế thừa | nghiệp vụ | `NR:70` | `[NGUỒN]` |
| BR-13 | Tin đang hiển thị chuyển sang thu hồi/xóa → dòng cập nhật nhãn, giữ nội dung của chính tin đó. Có tin tiếp theo (theo logic hiện tại) → dòng chuyển sang người gửi / nội dung / trạng thái của tin tiếp theo; không giữ nhãn của tin trước | nghiệp vụ | `NR:71` | `[NGUỒN]` |
| BR-14 | Thông báo hệ thống (đổi tên nhóm, thêm thành viên, rời nhóm) kế thừa logic hiện tại; **không** ghép tiền tố hay nhãn thu hồi/xóa | nghiệp vụ | `NR:72` | `[NGUỒN]` |
| BR-15 | Desktop: không giới hạn ký tự riêng cho tên; tên đầy đủ ghép vào dòng; cả dòng vượt chiều ngang → phần vượt rút gọn bằng `…`; tên rất dài có thể bị cắt bởi giới hạn cả dòng | hiển thị | `NR:73` | `[NGUỒN]` |
| BR-16 | Mobile: tên > **20 ký tự** → 20 ký tự đầu + `…` trước `: `. Mốc 20 chỉ tính trên tên. Áp dụng cho tên nhân sự, tên Zalo tài khoản gửi từ app, tên hiển thị thành viên nhóm; tên gợi nhớ mới cũng áp dụng | hiển thị | `NR:74` | `[NGUỒN]` — xem Q-02, Q-05 |
| BR-17 | Tên, dấu phân cách, nhãn, icon, nội dung cùng **một dòng**, không xuống dòng, không tăng chiều cao item; phần vượt rút gọn `…`. Mobile: giới hạn cả dòng áp dụng **sau** khi đã rút gọn tên. Mốc 20 **không** áp dụng cho tên file. Chiều rộng sidebar đổi → lượng nội dung hiển thị đổi theo | hiển thị | `NR:75` | `[NGUỒN]` |

**UI Spec** (`NR:81-88`) `[NGUỒN]`: thứ tự **Người gửi → nhãn trạng thái → nội dung**, tiền tố có `: ` phía sau; không áp dụng tiền tố / nhãn thì **không hiển thị dấu phân cách và khoảng trống** (`NR:82`); icon đính kèm đặt **ngay trước tên file**, dùng **một icon chung** (`NR:85`); không xuống dòng cho tên dài, nhãn, nội dung dài, tên file dài (`NR:86`); **không làm mờ** toàn bộ item vì tin đã thu hồi/xóa (`NR:87`); không chồng lấn thời gian và badge chưa đọc; bố cục, màu, cỡ chữ, phân biệt đã đọc/chưa đọc kế thừa (`NR:88`).

**Quy tắc hiện hành liên quan** `[NGUỒN]`:
- Chi tiết hội thoại: tin gửi từ web Gopany hiện **tên người gửi** (`G003:457`); tin gửi từ điện thoại **không hiển thị tên người gửi** (`G003:458`, `G003:255`); Staff thu hồi tin gửi từ điện thoại → hiển thị **tên Staff đã thu hồi** (`G003:186`, `G003:256`).
- Thu hồi chỉ trong 24h (`G003:302`); xóa/thu hồi thực thi trên Zalo, Gopany giữ nội dung gốc + label (`G003:303`); đã thu hồi là terminal, không xóa tiếp (`G003:305`).
- Tên gợi nhớ: dùng chung cấp workspace (`G032:135`), một nguồn duy nhất (`G032:136`), ghi lên **tất cả** tài khoản Zalo có kết bạn (`G032:142`), Zalo là nơi lưu chính thức, chiều Zalo → hệ thống qua đồng bộ danh bạ G006 (`G032:143`), tối đa 40 ký tự (`G032:141`), hệ thống không tự gỡ (`G032:147`), cập nhật realtime mọi client (`G032:148`), thay tên Zalo ở danh sách hội thoại (`G032:293`).
- Danh sách: truncate nội dung xem trước, `…` ở cuối, một dòng, không che thời gian / badge (`CR-RES:98-99`, `CR-RES:126`); badge chưa đọc ẩn khi = 0, vượt 99 → `99+` (`G029:72`, `G029:123`).
- Rời nhóm "trong im lặng" ON → **không** có thông báo hệ thống vào nhóm (`G008:185`, `G008:192`).

## 6. Acceptance criteria, mã lỗi, thông báo, giới hạn số

| Mã | Tóm tắt nguyên văn | Nguồn |
| --- | --- | --- |
| AC-01 | Cá nhân, A và B cùng được phân công: A gửi → cả hai thấy tên A; B gửi → tên B; kể cả trên giao diện của chính người gửi | `NR:94` |
| AC-02 | Nhóm: tương tự AC-01; không thay bằng tên tài khoản Zalo hay người được phân công | `NR:95` |
| AC-03 | Chủ tài khoản gửi từ app Zalo vào hội thoại cá nhân, đồng bộ về → `{Tên Zalo của tài khoản gửi}: {Nội dung}`, tên khớp nguồn tên trong chi tiết | `NR:96` |
| AC-04 | Như AC-03 trong nhóm | `NR:97` |
| AC-05 | Khách gửi trong hội thoại cá nhân → chỉ nội dung | `NR:98` |
| AC-06 | Thành viên khác gửi trong nhóm: [1] có tên gợi nhớ → tên gợi nhớ; [2] chưa có → tên Zalo | `NR:99` |
| AC-07 | Đặt / đổi / gỡ tên gợi nhớ → tiền tố đổi tương ứng; nội dung và định danh giữ nguyên; mobile áp lại mốc 20 | `NR:100` |
| AC-08 | Hai tài khoản Zalo A, B; cùng một người có liên hệ trên cả hai với **tên gợi nhớ khác nhau** → tiền tố theo liên hệ của đúng tài khoản; tin do A/B gửi từ app hiện tên Zalo của A/B | `NR:101` |
| AC-09 | Tin trả lời: [1] nhân sự A → tên A; [2] khách trong cá nhân → không tiền tố; [3] thành viên nhóm → tên thành viên; không lấy tên người của tin trích dẫn | `NR:102` |
| AC-10 | Tin chuyển tiếp: tương tự AC-09; không lấy người gửi ban đầu | `NR:103` |
| AC-11 | Text, ảnh, sticker, loại khác ngoài file giữ cách hiển thị hiện tại (`[Hình ảnh]`, `[Sticker]`); không phát sinh ảnh thu nhỏ | `NR:104` |
| AC-12 | File có tên → icon + đúng tên file; tên dài rút gọn theo cả dòng, không cắt ở mốc 20 | `NR:105` |
| AC-13 | File không tên → `[Tệp]`, không tự đặt tên, **không hiển thị `null` / `undefined`** | `NR:106` |
| AC-14 | A thu hồi trên Gopany tin A gửi qua Gopany → `Tên A: [Đã thu hồi] nội dung` | `NR:107` |
| AC-15 | Chủ tài khoản thu hồi trên app Zalo tin gửi từ app → `{Tên Zalo}: [Đã thu hồi] {Nội dung}`; không gán nhân sự | `NR:108` |
| AC-16 | Nhân sự A thu hồi trên Gopany tin gửi từ app Zalo → tiền tố vẫn tên Zalo, không thay bằng A; người thu hồi trong chi tiết kế thừa | `NR:109` |
| AC-17 | Chủ tài khoản thu hồi trên app Zalo tin A gửi qua Gopany → tiền tố vẫn tên A + `[Đã thu hồi]` | `NR:110` |
| AC-18 | Khách thu hồi trong cá nhân → `[Đã thu hồi] {Nội dung}` không tiền tố | `NR:111` |
| AC-19 | Thành viên nhóm thu hồi → tên thành viên + `[Đã thu hồi]` + nội dung | `NR:112` |
| AC-20 | Tin đang hiển thị (mọi nguồn) chuyển sang đã xóa → thêm `[Đã xóa]`, giữ nội dung, tiền tố theo người gửi ban đầu | `NR:113` |
| AC-21 | Có tin tiếp theo chưa thu hồi/xóa → dòng chuyển sang tin mới, không giữ nhãn cũ | `NR:114` |
| AC-22 | Thông báo hệ thống kế thừa; không tiền tố, không nhãn | `NR:115` |
| AC-23 | Desktop, tên > 20 ký tự: [1] đủ chỗ → hiện đầy đủ, không `…`; [2] không đủ → một dòng, rút gọn phần vượt bằng `…` | `NR:116` |
| AC-24 | Mobile: [1] tên < 20 → giữ nguyên; [2] đúng 20 → giữ đủ, không `…`; [3] > 20 → 20 ký tự + `…` + `: ` + nội dung; `…`, `: `, nhãn, nội dung không tính vào mốc 20 | `NR:117` |
| AC-25 | Cả dòng vượt không gian (desktop/mobile) → một dòng, `…`, không tăng chiều cao, không chồng thời gian / badge; không cắt riêng tên file ở mốc 20 | `NR:118` |
| AC-26 | Hội thoại đã đọc và chưa đọc đều áp dụng; không tự đổi quyền xem, kết quả lọc, badge, thứ tự | `NR:119` |

Ghi chú AC (`NR:121`): AC áp dụng desktop/mobile trừ AC-23 (desktop) và AC-24 (mobile). Thu hồi/xóa áp dụng cho text, ảnh, sticker, file; file đã thu hồi/xóa có tên → vẫn icon + tên file, không tên → `[Tệp]`.

**Giới hạn số** `[NGUỒN]`: **20 ký tự** tên người gửi trên mobile (`NR:74`). **Nhãn nguyên văn**: `[Tệp]`, `[Hình ảnh]`, `[Sticker]`, `[Đã thu hồi]`, `[Đã xóa]`, dấu `: `, dấu `…` (`NR:66-69`, `NR:74`). **Mã lỗi / thông báo**: không có. **Data migration** (`NR:125-129`): áp dụng cho tin lịch sử; không chuyển đổi nội dung, không gán nhân sự cho tin lịch sử từ app Zalo.

## 7. Trạng thái và chuyển trạng thái

Trạng thái của **tin đang hiển thị** trên dòng tin nhắn (kế thừa G003 §11 `G003:337-341`):

| Từ | Sự kiện | Sang | Dòng tin nhắn | Nguồn |
| --- | --- | --- | --- | --- |
| Chưa thu hồi/xóa | Thu hồi (Gopany hoặc Zalo, đồng bộ về) | Đã thu hồi (terminal) | thêm `[Đã thu hồi]` sau tiền tố, giữ nội dung | `NR:69`, `NR:71`, `G003:337` |
| Chưa thu hồi/xóa | Xóa | Đã xóa (terminal) | thêm `[Đã xóa]` sau tiền tố, giữ nội dung | `NR:69`, `NR:113`, `G003:338` |
| Bất kỳ | Có tin tiếp theo được hiển thị | — | dòng chuyển sang tin mới, bỏ nhãn cũ | `NR:71`, `NR:114` |

## 8. Diễn giải, giả định, QA observation

| # | Nội dung | Nhãn | Liên quan tới |
| ---: | --- | --- | --- |
| 1 | Nhóm có **hai tài khoản Zalo liên kết** cùng là thành viên: tin nhân sự gửi qua Gopany bằng tài khoản B, xem trong hội thoại nhóm thuộc tài khoản A → là "tin nhận", tiền tố = tên hiển thị của B theo liên hệ của A (không phải tên nhân sự). Suy từ BR-01 "phía gửi theo tài khoản của hội thoại" | `[DIỄN GIẢI AI]` | BR-01, BR-05 — Q-04 |
| 2 | Với tin file đã thu hồi, thứ tự là `{Tên}: [Đã thu hồi] {icon}{tên file}` — icon "ngay trước tên file" nên đứng sau nhãn | `[DIỄN GIẢI AI]` | BR-09, BR-11, `NR:82`, `NR:85` |
| 3 | "Tên Zalo của tài khoản gửi" là tên tài khoản Zalo đang liên kết như G001 hiển thị; G036 thanh ghim có tiền lệ "ghim tin của chính tài khoản mình mà không có tên → hiện tên tài khoản" (`G036:234`) | `[DIỄN GIẢI AI]` | BR-03 — Q-01 |
| 4 | Tin do app Zalo gửi về Gopany và trạng thái thu hồi từ Zalo đến Gopany theo cơ chế realtime hiện có (không qua "Đồng bộ dữ liệu" G006, vốn chỉ thẻ/danh bạ) | `[GIẢ ĐỊNH]` | BR-03, BR-12 — Q-12 |
| 5 | Tin **đang gửi** / **gửi thất bại** (`G003:460-461`) nếu là tin gần nhất: NR không nói dòng tin nhắn hiển thị gì | `[QA BỔ SUNG]` | BR-02 — Q-09 |
| 6 | Tin dài bị tách thành nhiều phần (G003 BR03c `G003:87`; CR-004): dòng tin nhắn hiện phần cuối với tiền tố nhân sự | `[QA BỔ SUNG]` | BR-02 |
| 7 | Nhân sự gửi tin rồi **đổi tên** hoặc **bị xóa khỏi workspace**: NR không nói tiền tố lấy tên lúc gửi hay tên hiện tại | `[QA BỔ SUNG]` | BR-02 — Q-06 |
| 8 | Tên gợi nhớ 40 ký tự (G032 BR07) > mốc 20 của mobile → tên gợi nhớ dài là dữ liệu test cho AC-24 [3] | `[QA BỔ SUNG]` | BR-16 |
| 9 | Hội thoại lọc theo tab "Chưa đọc" / lọc tài khoản Zalo / tìm kiếm: dòng tin nhắn cũng áp dụng quy tắc mới (AC-26 "bộ lọc hiện tại") | `[DIỄN GIẢI AI]` | AC-26 |
| 10 | "Tên file theo dữ liệu tin nhắn" gồm cả phần mở rộng nếu dữ liệu có; không có quy tắc bỏ đuôi | `[DIỄN GIẢI AI]` | BR-09 — Q-07 |

## 9. Điểm chưa rõ (chuyển sang Debate)

| # | Loại | Trích dẫn + nguồn | Vì sao chưa rõ | Đề xuất mức |
| ---: | --- | --- | --- | --- |
| Q-01 | dẫn chiếu treo / mâu thuẫn | BR-03: "kế thừa **nguồn tên đang dùng cho tin này trong chi tiết hội thoại**" (`NR:61`); AC-03: "Tên khớp nguồn tên đang dùng cho tin đó trong chi tiết hội thoại" (`NR:96`). G003: tin gửi từ điện thoại "**không hiển thị tên người gửi**" (`G003:458`, `G003:255`) | Chi tiết hội thoại hiện hành **không có** tên cho tin gửi từ app Zalo → không có nguồn tên để kế thừa. "Tên Zalo của tài khoản gửi" là trường nào (tên tài khoản Zalo liên kết theo G001, hay tên khác)? Quyết định expected của AC-03/04/08/15/16 | **Trọng yếu** (dữ liệu, điều kiện chấp nhận) |
| Q-02 | thiếu / nhiều cách hiểu | "Áp dụng trên desktop/mobile" (`NR:27`); BR-16 mobile 20 ký tự (`NR:74`); BR-17 "Khi chiều rộng sidebar thay đổi theo khả năng hiện tại" (`NR:75`). G003: *Platform: Web only* (`G003:385`), Mobile app OOS08 (`G003:650`). CR-RES có breakpoint `< 880 px` trên web (`CR-RES:89`) | "Mobile" là **app Gopany mobile** (chưa có spec danh sách hội thoại trong `tailieu/`) hay **web trên màn hẹp**? Web `< 880 px` áp quy tắc desktop (không mốc 20) hay quy tắc mobile? Đổi expected của AC-23/AC-24/AC-25 và phạm vi nền tảng test | **Trọng yếu** (điều kiện chấp nhận, phạm vi) |
| Q-03 | mâu thuẫn | BR-05: tên gợi nhớ "theo liên hệ thuộc đúng tài khoản Zalo của hội thoại, không lấy tên gợi nhớ từ liên hệ thuộc tài khoản Zalo khác" (`NR:63`); AC-08: "Cùng một người ngoài đời có liên hệ trên cả hai tài khoản, với **tên gợi nhớ khác nhau**" (`NR:101`). G032 BR01: tên gợi nhớ là dữ liệu **dùng chung cấp workspace** (`G032:135`); BR02 một nguồn duy nhất (`G032:136`); BR08 ghi lên **tất cả** tài khoản liên quan (`G032:142`) | Theo G032, một liên hệ chỉ có **một** tên gợi nhớ trong hệ thống và được ghi lên mọi tài khoản → không dựng được tình huống "tên gợi nhớ khác nhau trên hai tài khoản" từ Gopany. Hai tài liệu mô tả hai mô hình dữ liệu | **Trọng yếu** (dữ liệu, điều kiện chấp nhận AC-08 [1]) |
| Q-04 | nhiều cách hiểu | BR-01 (`NR:59`), BR-05 (`NR:63`) | Nhóm có **hai tài khoản Zalo liên kết** của workspace cùng là thành viên: tin nhân sự gửi qua Gopany bằng tài khoản B, nhìn trong hội thoại nhóm thuộc tài khoản A → tiền tố là tên hiển thị của B (tin nhận) hay tên nhân sự? Tài liệu không có ví dụ; QA suy theo BR-01 (mục 8 #1) | Không trọng yếu — debate trước, nhờ BA xác nhận |
| Q-05 | mơ hồ | BR-16 "vượt quá 20 ký tự, hiển thị 20 ký tự đầu và thêm `…`" (`NR:74`) | "Ký tự" đếm thế nào với tiếng Việt có dấu tổ hợp, emoji, khoảng trắng đầu/cuối, khoảng trắng liên tiếp; `…` là một ký tự U+2026 hay ba dấu chấm? Ảnh hưởng case biên AC-24 [2]/[3] | Không trọng yếu (câu chữ hiển thị) |
| Q-06 | thiếu | BR-02 "Tên nhân sự lấy từ thông tin người thực hiện gửi được ghi nhận trên tin nhắn" (`NR:60`) | Nhân sự **đổi tên** hoặc **bị xóa / vô hiệu** sau khi gửi: tiền tố hiện tên lúc gửi hay tên hiện tại / giá trị gì? Tài liệu không nói | Không trọng yếu — ĐO & GHI |
| Q-07 | thiếu | CR-01 "icon đính kèm và tên file" (`NR:42`); UI "Icon đính kèm đặt ngay trước tên file. Dùng một icon đính kèm chung. Nếu không có tên file, hiển thị `[Tệp]`" (`NR:85`) | Không có design: icon nào; khi không có tên file thì có icon kèm `[Tệp]` hay chỉ `[Tệp]`; tên file có hiển thị phần mở rộng theo dữ liệu | Không trọng yếu |
| Q-08 | thiếu / dẫn chiếu khác nhau | BR-08 "kế thừa cách hiển thị nội dung hiện tại… `[Hình ảnh]` và `[Sticker]`" (`NR:66`); G036 thanh ghim dùng `[Hình ảnh]` · `[Nhãn dán]` · `[Tập tin]` (`G036:234`); G003 §10B chỉ ghi "Preview nội dung" (`G003:418`) | Không có spec nhãn hiện tại của danh sách cho từng loại tin (sticker, video, danh thiếp, link, bình chọn, số tài khoản…). Nhãn nguyên văn để viết expected của AC-11 | Không trọng yếu — ĐO & GHI |
| Q-09 | thiếu | G003 §10D: tin "Đang gửi", "Gửi thất bại" (`G003:460-461`) | Tin gần nhất đang gửi / gửi thất bại: dòng tin nhắn có tiền tố không, có nhãn gì? NR không đề cập | Không trọng yếu — ĐO & GHI |
| Q-10 | thiếu | BR-07 chỉ nói **người gửi** của tin trả lời / chuyển tiếp (`NR:65`) | **Nội dung** hiển thị của tin trả lời trên danh sách: chỉ phần trả lời hay kèm trích dẫn? Tài liệu không nói; "kế thừa hiện tại" nhưng không có spec | Không trọng yếu — ĐO & GHI |
| Q-11 | thiếu | BR-14 / AC-22 "kế thừa logic hiện tại" (`NR:72`, `NR:115`) | Nguyên văn thông báo hệ thống hiện tại trên danh sách (đổi tên nhóm, thêm thành viên, rời nhóm) không có trong tài liệu; rời nhóm "im lặng" không sinh thông báo (`G008:192`) | Không trọng yếu — ĐO & GHI |
| Q-12 | thiếu | BR-03 "sau đó đồng bộ về Gopany" (`NR:61`); BR-12 "khi trạng thái từ Zalo được đồng bộ về" (`NR:70`) | Không có tài liệu cơ chế tin từ app Zalo và trạng thái thu hồi/xóa trên Zalo về Gopany (G006 chỉ thẻ/danh bạ `G006:27`). QA cần biết cách dựng và thời điểm kỳ vọng cập nhật để test AC-03/04/15/17/18/19/20 | Không trọng yếu — điều kiện dựng test |
| Q-13 | thiếu | `ID: —` (`NR:5`); change log trống (`NR:131-134`); tiêu đề `[NR/CR]` | Mã yêu cầu và version chính thức; có design/Figma cho dòng tin nhắn không | Không trọng yếu |

## 10. Tự rà soát

- [x] Mọi mã BR-xx, AC-xx, NR-01, CR-01 và dòng G003 / G036 / G032 / G029 / G008 / G006 / CR-RES ở mục 3–9 đã mở kiểm bằng grep / sed
- [x] BR-01…BR-17 là mã gốc; chỉ BR-00 là mã QA đặt cho bảng nguồn gửi (`NR:48-55`), ghi rõ ở đầu mục 5
- [x] Không mục `[NGUỒN]` nào thiếu tham chiếu
- [x] Mâu thuẫn (Q-01, Q-03, Q-08) ghi đủ hai phía
- [x] Mục 9 không chứa câu trả lời do AI tự chọn
- Giới hạn: không có spec dòng tin nhắn hiện tại, spec mobile, cơ chế đồng bộ tin, design; chưa quan sát sản phẩm

## Lịch sử cập nhật

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
| 2026-10-27 | AI (Orchestrator) | Tạo bản đầu: 8 nguồn, 17 BR gốc + BR-00, 26 AC, 13 điểm chưa rõ (3 đề xuất trọng yếu: Q-01 nguồn tên Zalo, Q-02 "mobile", Q-03 tên gợi nhớ theo tài khoản so với G032) |
