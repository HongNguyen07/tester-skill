---
featureId: NR-NGUOI-GUI-TEN-FILE   # mã tạm — tài liệu ghi "ID: —"
stage: S4a
gate: closed
materialOpen: 3          # đề xuất của AI — chờ người dùng chốt mức
nonMaterialOpen: 10
gateOpenedBy:
gateOpenedAt:
updatedAt: 2026-10-27
---

# Requirement Understanding / Alignment Summary — NR-NGUOI-GUI-TEN-FILE: Hiển thị người gửi và tên file trên danh sách hội thoại

Trạng thái: **S4a — câu hỏi đã lập, chờ Hồng chốt mức và gửi BA Nguyễn Thị Phương Thảo.** Debate S4b bắt đầu ngay với BR
không chạm câu hỏi trọng yếu (BR-02, BR-04, BR-07…BR-15, BR-17); BR-03 / BR-05 / BR-16 chờ Q-01 / Q-03 / Q-02.

## 1. Nguồn và phạm vi đã đọc

Xem mục 1 của `01-requirement-analysis.md`: NR (nguồn chính, 134 dòng, không version), G003 v1.11, G036 v1.0, G032 v1.0 bản (1),
G029, G008 v1.1, G006 v1.1, CR Tối ưu responsive 22/10/2026. Không có: spec dòng tin nhắn hiện tại, spec mobile, cơ chế đồng bộ tin
từ app Zalo, design.

## 2. Requirement / Use case / Business rule đã trích

| Mã | Tóm tắt | Nguồn | Trạng thái hiểu |
| --- | --- | --- | --- |
| NR-01 | Bổ sung người gửi + nhãn thu hồi/xóa, giữ một dòng | `NR:41` | `[NGUỒN]` — chi tiết theo BR |
| CR-01 | `[Tệp]` → icon + tên file; không tên giữ `[Tệp]` | `NR:42` | `[NGUỒN]` — còn mở Q-07 (icon, không chặn) |
| BR-00 | Bảng đối chiếu nguồn gửi ↔ cách hiển thị; nhãn sau tiền tố, trước nội dung | `NR:48-55` | `[NGUỒN]` rõ |
| BR-01 | Phía gửi theo tài khoản Zalo của hội thoại, không theo nhân sự đăng nhập | `NR:59` | `[NGUỒN]` — còn mở Q-04 (không trọng yếu) |
| BR-02 | Tin qua Gopany → tên nhân sự thực hiện gửi, kể cả với chính người gửi | `NR:60` | `[NGUỒN]` — còn mở Q-06 (không trọng yếu) |
| BR-03 | Tin từ app Zalo của chính tài khoản → tên Zalo của tài khoản gửi | `NR:61` | còn mở **Q-01** |
| BR-04 | Khách gửi trong hội thoại cá nhân → không tiền tố | `NR:62` | `[NGUỒN]` rõ |
| BR-05 | Thành viên khác trong nhóm → tên gợi nhớ, chưa có thì tên Zalo, theo liên hệ của đúng tài khoản | `NR:63` | còn mở **Q-03** |
| BR-06 | Đặt / đổi / gỡ tên gợi nhớ → tiền tố cập nhật; đổi trên app Zalo theo đồng bộ hiện tại | `NR:64` | `[NGUỒN]` rõ (G032 BR05, BR09, BR14) |
| BR-07 | Người gửi của tin trả lời / chuyển tiếp = người gửi tin đó, không phải người của tin gốc | `NR:65` | `[NGUỒN]` — còn mở Q-10 (nội dung, không trọng yếu) |
| BR-08 | Nội dung ngoài file kế thừa; `[Hình ảnh]`, `[Sticker]` | `NR:66` | `[NGUỒN]` — còn mở Q-08 (nhãn hiện tại) |
| BR-09 | File có tên → icon + tên file, rút gọn theo cả dòng | `NR:67` | `[NGUỒN]` rõ |
| BR-10 | File không tên → `[Tệp]`, không tự đặt tên | `NR:68` | `[NGUỒN]` rõ |
| BR-11 | `[Đã thu hồi]` / `[Đã xóa]` sau tiền tố, trước nội dung | `NR:69` | `[NGUỒN]` rõ |
| BR-12 | Tiền tố = người gửi ban đầu, nhãn = trạng thái, không đổi theo người thu hồi/xóa | `NR:70` | `[NGUỒN]` rõ |
| BR-13 | Dòng cập nhật nhãn cho tin đang hiển thị; tin tiếp theo thay thế, không giữ nhãn cũ | `NR:71` | `[NGUỒN]` rõ |
| BR-14 | Thông báo hệ thống kế thừa, không tiền tố / nhãn | `NR:72` | `[NGUỒN]` — còn mở Q-11 (nguyên văn) |
| BR-15 | Desktop: tên đầy đủ, cả dòng rút gọn `…` | `NR:73` | `[NGUỒN]` rõ |
| BR-16 | Mobile: tên > 20 ký tự → 20 + `…` trước `: ` | `NR:74` | còn mở **Q-02**, Q-05 |
| BR-17 | Một dòng, không tăng chiều cao; mobile rút gọn tên trước rồi cả dòng; mốc 20 không áp cho tên file | `NR:75` | `[NGUỒN]` — còn mở **Q-02** (nền tảng) |
| UI | Thứ tự người gửi → nhãn → nội dung; không có tiền tố/nhãn thì không có dấu phân cách; không làm mờ item; không chồng thời gian / badge | `NR:81-88` | `[NGUỒN]` rõ |
| AC-01…AC-26 | 26 AC, xem mục 6 của `01-…` | `NR:94-119` | theo BR tương ứng |

## 3. Bảng câu hỏi debate

| Q | Mức (AI đề xuất) | Trích dẫn + nguồn | Vì sao chưa rõ | Các cách hiểu có căn cứ | Ảnh hưởng tới test | Cần ai | Trạng thái | Câu trả lời | Ai trả lời · ngày · kênh |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Q-01 | **Trọng yếu** | BR-03 "kế thừa nguồn tên đang dùng cho tin này trong chi tiết hội thoại" (`NR:61`); AC-03 (`NR:96`); G003 tin gửi từ điện thoại "không hiển thị tên người gửi" (`G003:458`, `G003:255`) | Chi tiết hội thoại hiện không có tên cho tin gửi từ app → không có nguồn kế thừa; trường tên nào | (a) tên tài khoản Zalo liên kết (G001; tiền lệ G036 thanh ghim `G036:234` hiện "tên tài khoản"); (b) trường khác | Expected của AC-03, AC-04, AC-08 [2], AC-15, AC-16, AC-17 | BA | Mở | | |
| Q-02 | **Trọng yếu** | "desktop/mobile" (`NR:27`); BR-16 (`NR:74`); BR-17 (`NR:75`); G003 Web only (`G003:385`), OOS08 (`G003:650`); CR-RES `< 880 px` (`CR-RES:89`) | "Mobile" là app hay web hẹp; web hẹp áp quy tắc nào | (a) app Gopany, web luôn desktop; (b) web màn hẹp theo mốc px; (c) cả hai | Phạm vi nền tảng; expected AC-23 / AC-24 / AC-25 | BA | Mở | | |
| Q-03 | **Trọng yếu** | BR-05 (`NR:63`); AC-08 "tên gợi nhớ khác nhau" (`NR:101`); G032 BR01 dùng chung workspace (`G032:135`), BR02 (`G032:136`), BR08 ghi lên mọi tài khoản (`G032:142`) | Hai tài liệu mô tả hai mô hình dữ liệu tên gợi nhớ | (a) không thể khác nhau — AC-08 [1] thu hẹp; (b) có thể — cần cách dựng | Dựng dữ liệu và expected AC-06 [1], AC-07, AC-08 [1], AC-19 | BA | Mở | | |
| Q-04 | Không trọng yếu | BR-01 (`NR:59`), BR-05 (`NR:63`) | Nhóm có hai tài khoản liên kết; tin nhân sự gửi bằng B nhìn từ hội thoại của A | (a) tên hiển thị của B — theo BR-01; (b) tên nhân sự — không có dòng tài liệu ủng hộ | Một case bổ sung cho BR-01 | BA xác nhận | Mở | | |
| Q-05 | Không trọng yếu | BR-16 (`NR:74`) | Cách đếm ký tự, dạng `…` | — tài liệu không nói | Case biên AC-24 [2]/[3] — ĐO & GHI | BA | Mở | | |
| Q-06 | Không trọng yếu | BR-02 (`NR:60`) | Nhân sự đổi tên / bị xóa sau khi gửi | — tài liệu không nói | Case bổ sung BR-02 — ĐO & GHI | BA | Mở | | |
| Q-07 | Không trọng yếu | CR-01 (`NR:42`); UI (`NR:85`) | Icon nào; icon có đi kèm `[Tệp]`; phần mở rộng | — không có design | Expected hình thức AC-12 / AC-13 | BA / design | Mở | | |
| Q-08 | Không trọng yếu | BR-08 (`NR:66`); G036 `[Nhãn dán]` · `[Tập tin]` (`G036:234`); G003 §10B (`G003:418`) | Nhãn hiện tại từng loại tin không có spec | — | Expected AC-11 — ĐO & GHI | BA | Mở | | |
| Q-09 | Không trọng yếu | G003 §10D đang gửi / thất bại (`G003:460-461`) | NR không nói | — | Case bổ sung — ĐO & GHI | BA | Mở | | |
| Q-10 | Không trọng yếu | BR-07 (`NR:65`) | Nội dung tin trả lời trên danh sách | — | Expected AC-09 phần nội dung — ĐO & GHI | BA | Mở | | |
| Q-11 | Không trọng yếu | BR-14 (`NR:72`); G008 (`G008:192`) | Nguyên văn thông báo hệ thống | — | Expected AC-22 — ĐO & GHI | BA | Mở | | |
| Q-12 | Không trọng yếu | BR-03 (`NR:61`), BR-12 (`NR:70`); G006 (`G006:27`) | Cơ chế và thời điểm đồng bộ tin / trạng thái từ Zalo | — | Cách dựng AC-03/04/15/17/18/19/20 | BA / Dev | Mở | | |
| Q-13 | Không trọng yếu | `NR:5`, `NR:131-134` | Mã, version, design | — | Frontmatter, dẫn chiếu | BA | Mở | | |

## 4. Cách hiểu đã thống nhất (kết quả Debate S4b)

| # | Nhóm BR / luồng | Nội dung đã thống nhất | Nhãn | Từ câu hỏi | Ai xác nhận · ngày | Tài liệu đã cập nhật chưa |
| ---: | --- | --- | --- | --- | --- | --- |
| | *(chưa debate)* | | | | | |

## 5. Các cách hiểu khác nhau còn tồn tại

- Q-01: tên cho tin gửi từ app Zalo — NR giả định có nguồn tên trong chi tiết; G003 nói không hiển thị tên. Case AC-03/04/15/16/17 bị ảnh hưởng.
- Q-02: nền tảng "mobile" — app hay web hẹp. Case AC-23/24/25 bị ảnh hưởng.
- Q-03: mô hình tên gợi nhớ — NR per tài khoản, G032 dùng chung workspace. Case AC-08 [1] bị ảnh hưởng.

## 6. Điểm đã thống nhất và điểm còn mở

- Đã thống nhất: chưa có.
- Còn mở — **trọng yếu**: Q-01, Q-02, Q-03 (mức AI đề xuất, chờ Hồng chốt).
- Còn mở — không trọng yếu (đã cô lập): Q-04 (BR-01, một case), Q-05 (AC-24 biên), Q-06 (BR-02 bổ sung), Q-07 (hình thức AC-12/13), Q-08 (AC-11), Q-09 (bổ sung), Q-10 (AC-09 nội dung), Q-11 (AC-22), Q-12 (cách dựng), Q-13 (mã/version).

## 7. Cần BA / Dev / Product xác nhận

Xem `cau-hoi-gui-BA.md` (Phần A: Q-01…Q-03; Phần B: Q-04…Q-13). Q-12 có thể cần Dev.

## 8. Ngoài phạm vi / chưa có căn cứ

- Ngoài phạm vi theo NR (`NR:33-35`): ảnh thu nhỏ trên dòng tin nhắn; icon riêng theo loại file; mở/tải file từ dòng tin nhắn.
- Tài liệu không nói: tin đang gửi / gửi thất bại (Q-09); nhân sự đổi tên / bị xóa (Q-06); nhãn hiện tại của các loại tin khác (Q-08).

## 9. Change Proposal / New Requirement Candidate `[ĐỀ XUẤT THAY ĐỔI]`

| CP | Ý tưởng | Ai nêu · ngày | Trạng thái |
| --- | --- | --- | --- |
| | *(chưa có)* | | |

## 10. QA coverage bổ sung dự kiến `[QA BỔ SUNG]`

- Tin dài bị tách nhiều phần (G003 BR03c) → dòng hiện phần cuối với tiền tố nhân sự.
- Tên gợi nhớ 40 ký tự (G032 BR07) làm dữ liệu cho mốc 20 trên mobile; tên có emoji / dấu tổ hợp.
- Tên file rất dài, tên file có ký tự đặc biệt / unicode; tên file rỗng vs `null`.
- Danh sách ở tab "Chưa đọc", lọc theo tài khoản Zalo, kết quả tìm kiếm: dòng tin nhắn áp dụng cùng quy tắc.
- Thu hồi tin gần nhất rồi thu hồi tiếp tin kế trước (dòng không đổi vì tin hiển thị vẫn là tin gần nhất).
- Hai tab / hai nhân sự cùng xem: cập nhật realtime khi thu hồi, khi đổi tên gợi nhớ (G032 BR14).
- Hội thoại ẩn (G024), tài khoản Zalo ngắt kết nối (G003 BR10): dòng tin nhắn vẫn hiển thị đúng khi hiện lại.

## 11. Xác nhận mở cổng

- [ ] Điểm trọng yếu còn mở = 0 (BA đã trả lời hết)
- [ ] Đã debate S4b, mục 4 có nội dung
- [ ] Người dùng đã đọc mục 2–8
- Người dùng xác nhận: *(chưa)*

## Lịch sử cập nhật

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
| 2026-10-27 | AI (Orchestrator) | Tạo bản đầu S4a: 13 câu hỏi (Q-01…Q-03 đề xuất trọng yếu), bảng BR, coverage bổ sung dự kiến; gate closed |
