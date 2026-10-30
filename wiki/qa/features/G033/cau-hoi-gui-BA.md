# G033 — Câu hỏi QA gửi BA

| | |
| --- | --- |
| **Tài liệu** | G033 — Màn Link nhóm — mời bằng QR hoặc link (v1.0, Draft, 2026-10-02) |
| **Gửi** | Trân (BA) |
| **Từ** | Hồng (QA) |
| **Ngày gửi** | 2026-10-19 (Phần A đã có trả lời cùng ngày) |
| **Tài liệu đã đối chiếu** | G033 · G008 v1.1 · G026 v1.0 · G011 v1.1 · G003 v1.11 · G001 |

Chị Trân trả lời giúp em vào cột **BA trả lời**. Câu có sẵn phương án thì chị chỉ cần ghi (a) hoặc (b); nếu không phương án
nào đúng thì ghi cách đúng. Phần C là câu cho Dev / hub, nhờ chị chuyển giúp.

Không câu nào chặn việc viết test case; em muốn chị xác nhận sớm **Q-01** và **Q-02** vì liên quan tới hai tài liệu khác (G008, G026).

## Phần A — Mâu thuẫn với tài liệu khác, nhờ chị xác nhận và cập nhật

| # | Câu hỏi | Tài liệu đang ghi | Phương án | BA trả lời |
| --- | --- | --- | --- | --- |
| **Q-01** | Nút **Mời qua link** trong màn Thêm thành viên nay **mở màn Link nhóm** chứ không copy thẳng, đúng không? G008 trong thư mục tài liệu vẫn là **v1.1**, chưa có BR15 v1.9. | **G033 BR01, AF06, §16:** mở màn, không copy clipboard (G008 BR15 v1.9).<br>**G008 v1.1 BR15, AF01, §10C, AC:** click → copy vào clipboard → toast *"Đã copy link nhóm"*. | **(a)** Theo G033 — chị cập nhật G008 BR15 / AF01 / §10C / AC.<br>**(b)** Theo G008 v1.1 — G033 BR01 cần sửa. | **Không copy thẳng vào clipboard.** Trân, 19/10/2026 |
| **Q-02** | Hệ thống **có vai phó nhóm** không? G033 viết test với phó nhóm (thấy dòng Link nhóm, tạo được link), còn G026 nói không có phó nhóm và **chỉ trưởng nhóm** đổi được cài đặt nhóm. Chuỗi cài đặt chặn nhắn tin ghi *"Chỉ trưởng/phó nhóm được nhắn tin"* (G003 BR21) hay *"chỉ trưởng nhóm được nhắn tin"* (G033 BR06)? *(Ở G036 Q-01 chị đã trả lời "có phó nhóm, theo G036" — em hiểu G033 cũng theo hướng đó, chị xác nhận giúp.)* | **G033 AC (dòng 422, 457), E08, BR16:** trưởng nhóm **và phó nhóm**.<br>**G026 BR01, OOS01:** KHÔNG có phó nhóm. **G026 BR02:** chỉ trưởng nhóm đổi cài đặt. | **(a)** Có phó nhóm, theo G033 — G026 cần cập nhật.<br>**(b)** Không có phó nhóm, theo G026 — G033 bỏ các chỗ "phó nhóm". | **Hiện tại trên hệ thống chỉ có trưởng nhóm.** Trân, 19/10/2026<br>*QA hỏi thêm ở Q-19 vì khác câu trả lời G036 Q-01.* |
| **Q-03** | Ghi chú dẫn chiếu: **G011 BR02b** ("nhóm dòng chức năng" của panel) và **G008 BR25** (trưởng / phó nhóm đổi cài đặt nhóm) **không có** trong G011 v1.1 và G008 v1.1 (G008 chỉ tới BR22; gần nhất là BR05b). Dòng *Link nhóm* nằm trong panel của **G008 §10C** hay **G011**? | G033 BR01, BR16, §13. G011 BR02 chỉ nói panel 2 tab; G008 §10C dòng 395 có dòng Link nhóm. | | **G008 §10C.** Trân, 19/10/2026 |
| **Q-04** | Trong màn chia sẻ link, **đổi bộ lọc tài khoản Zalo** sang tài khoản B rồi gửi link vào hội thoại của B — được, đúng không? G003 BR23 ghi *"không forward cross-account"*. | **G033 BR06:** đổi được, link gửi từ tài khoản nào cũng dùng được.<br>**G003 BR23:** không forward cross-account (nhưng AC-BR23 cho đổi filter). | **(a)** Được, theo G033.<br>**(b)** Không — chỉ gửi trong tài khoản đang quản lý nhóm. | **(b) Không — chỉ gửi trong tài khoản đang quản lý nhóm.** Trân, 19/10/2026<br>*QA hỏi thêm ở Q-20: bộ lọc khoá hay ẩn.* |

## Phần B — Không chặn việc, nhờ chị làm rõ chữ / nhánh phụ

| # | Nội dung | Tài liệu đang ghi | Phương án | BA trả lời |
| --- | --- | --- | --- | --- |
| **Q-10** | AF03 ghi *"(cá nhân: 100 · Business: cao hơn)"* trong khi BR09 và AC nói **không ghi cứng ở bất kỳ đâu** — chị bỏ con số ở AF03 chứ? | G033 AF03 (dòng 154) vs BR09, AC dòng 476. | | |
| **Q-11** | **Lỗi hệ thống (500) lúc mở màn**: AC-E06 ghi "màn giữ nguyên, bấm **Thử lại** được", nhưng bảng E06 chỉ có toast và nút Thử lại chỉ có ở E03. Lúc đó màn có mở không, Thử lại ở đâu? Thêm: **mất mạng / 500 khi nút Tạo ngay / Đổi link / Huỷ link đang xử lý** → nút về trạng thái bấm được chứ? **Thêm:** mất mạng đúng lúc bấm *Lưu mã QR* thì toast E05 hay E07? **Thêm:** (i) AC-E06 "màn giữ nguyên" lúc *mở màn* — là màn nào, hay panel? (ii) Tạo / Đổi / Huỷ chờ Zalo **tối đa bao lâu**, quá mốc thì nút ra sao, toast gì? (iii) Đang chờ Zalo mà bấm Esc / ✕ / click nền mờ → đóng hộp, đóng popup, hay bị khoá? | G033 E05, E06, E07 (dòng 170–171), AC dòng 494, §10F/§10G "trong lúc chờ Zalo". | **(a)** Mở màn như E03: vùng QR hiện lỗi + nút Thử lại, 3 nút disable.<br>**(b)** Chỉ toast, không mở màn. | |
| **Q-12** | Toast E08 chị cho em **chuỗi đầy đủ** — hiện chỉ có đầu *"Không tạo được link nhóm…"* và đuôi *"Vui lòng kiểm tra lại trên app Zalo"*. | G033 E08 (dòng 173). | | |
| **Q-13** | Dòng tin nhắn kèm **có chứa một link** (link khác, hoặc chính link nhóm) thì Zalo còn tự nối link vào cuối không? Trong **khung chat Gopany**, tin dạng thẻ xem trước hiện thế nào? | G033 BR14: "không chứa link thì Zalo tự nối link vào cuối"; tin gửi dạng thẻ. | | |
| **Q-14** | Sau khi bấm **Gửi** ở màn chia sẻ: màn chia sẻ **đóng** và về màn Link nhóm, đúng không? Gửi lỗi ở **một vài** hội thoại thì toast gì? | G033 UC-02 b4 chỉ có toast *"Đã gửi link nhóm"*; G003 UC-08 b6 "popup đóng lại". | **(a)** Đóng màn chia sẻ, về màn Link nhóm.<br>**(b)** Khác — chị ghi giúp. | |
| **Q-15** | Trên **Web**, vào từ *Mời qua link*: popup Link nhóm **mở chồng** lên giao diện Thêm thành viên hay thay thế? Đóng về lại Thêm thành viên ở trạng thái nào? **Thêm:** đóng popup rồi về lại Thêm thành viên thì từ khoá tìm và danh sách đã tích có còn không? | G033 AF06, §10E; G008 §10C "Thêm thành viên". | | |
| **Q-16** | Các mốc ở §15 (mở màn ≤ 2 giây, > 10 giây → E03, tải QR ≤ 3 giây, hộp chọn ≤ 1 giây) là **tiêu chí đạt** hay **tham khảo**? | G033 §15. | | |

## Phần C — Nhờ chị chuyển Dev / hub (các Open Question của tài liệu)

| # | Nội dung | Tài liệu đang ghi | Phương án | Trả lời |
| --- | --- | --- | --- | --- |
| **Q-05** | **OQ01:** Zalo / hub có trả **ảnh QR** của nhóm không, hay hệ thống **tự sinh** từ link? Em cần biết để chốt kỳ vọng **logo Zalo** trên mã. | G033 BR02, §10B, OQ01. | **(a)** Zalo trả ảnh — giữ logo.<br>**(b)** Tự sinh — mã trơn, không logo. | |
| **Q-06** | **OQ04:** hub có đủ **ba API tạo · đổi · huỷ link** không? Thiếu cái nào để em bỏ nhóm case tương ứng. | G033 OQ04, §16. | | |
| **Q-07** | **OQ02:** Zalo có **chặn tài khoản chỉ là thành viên thường** xem link nhóm không (→ E03)? **Thêm:** nếu Zalo có chặn, thông báo E03 có nói lý do (tài khoản không phải trưởng nhóm) không? | G033 BR04, OQ02. | | |
| **Q-08** | **OQ03 / OQ05:** link nhóm có **hạn dùng** không (`expirationDate`)? Zalo có trạng thái **"tắt link mời"** tách khỏi "chưa có link" không? | G033 OQ03, OQ05, §7. | | |
| **Q-09** | E01 ghi *"gọi API thẳng → từ chối + ghi log"* — cho em **endpoint** để kiểm; §8/§9 đang `N/A`. **Thêm:** Dev có cách giả lập E03 (Zalo không trả link) và E06 (500) trên môi trường test không? | G033 E01, AC dòng 423. | | |
| **Q-17** | Tên nhóm có **ký tự cấm trong tên file** (`/ \ : * ? " < > \|`) hoặc rất dài → tên file `QR - {tên nhóm}.png` xử lý sao? Trên **mobile** ảnh lưu vào thư viện có mang tên này không? Và cách lấy **`maxMember`** của một nhóm để em đối chiếu cảnh báo BR09. | G033 BR07, BR09, BR13. | | |

## Phần D — Hỏi thêm sau câu trả lời ngày 19/10 (không chặn việc)

| # | Nội dung | Tài liệu đang ghi | Phương án | BA trả lời |
| --- | --- | --- | --- | --- |
| **Q-19** | Chị trả lời G033 Q-02 là *"hiện tại trên hệ thống chỉ có trưởng nhóm"*, còn ở **G036 Q-01** (13/10) chị chọn *"(a) có phó nhóm, lấy theo G036"* (chìa khoá vàng / xám ở avatar). Hai câu này hiểu thế nào cho đúng? | G033 E08, BR16, AC dòng 422, 457; G036 BR10; G026 BR01. | **(a)** G033 theo "chỉ trưởng nhóm"; G036 vẫn giữ (a) vì chỉ hiển thị dữ liệu Zalo trả về.<br>**(b)** G036 Q-01 cần xem lại — chị ghi giúp. | |
| **Q-20** | Màn chia sẻ link *"chỉ gửi trong tài khoản đang quản lý nhóm"*: **bộ lọc tài khoản Zalo** (có trong hộp chọn G003 UC-08) sẽ **khoá** ở tài khoản đó, **ẩn** hẳn, hay vẫn đổi được nhưng không gửi? | G033 BR06, AC dòng 437–438 (đang ghi "đổi được"); G003 UC-08 b2. | **(a)** Hiện nhưng khoá ở tài khoản quản lý nhóm.<br>**(b)** Ẩn bộ lọc.<br>**(c)** Khác — chị ghi giúp. | |
| **Q-21** | Trong hộp chọn hội thoại của *Chia sẻ link*, nhóm đích đang bật **"chỉ trưởng nhóm được nhắn tin"** thì mờ (G003 BR21). Nếu tài khoản Zalo đang gửi **chính là trưởng nhóm** của nhóm đích đó thì nhóm đích **tích được** không? | G033 BR06, G003 BR21: hiện nhưng disable, không nêu ngoại lệ. G026 BR06: chế độ này chỉ khoá ô nhập của **thành viên**. | **(a)** Tích được, gửi được (trưởng nhóm không bị khoá).<br>**(b)** Vẫn mờ như mọi nhóm bật cài đặt này. | |
| **Q-22** | Nhóm bị **giải tán** hoặc nhân sự **bị xoá / rời nhóm** trong lúc màn Link nhóm (hoặc màn chia sẻ link) **đang mở** → màn làm gì? Bấm một trong ba nút lúc đó ra gì? QA tạm hiểu xử lý như E04. | G033 E04 chỉ gắn ở lúc mở màn (UC-01 b2); §7 chỉ nói link đổi trên app Zalo thì màn cập nhật ngay. | **(a)** Như E04: toast *"Nhóm không còn tồn tại"*, đóng màn, panel tải lại.<br>**(b)** Khác — chị ghi giúp. | |
| **Q-23** | Bộ đếm trên màn chia sẻ link ghi **"Đã chọn: n"** (G033 §10D) hay **"Đã chọn X/99"** (G003 §10G mà G033 dẫn)? | G033 dòng 292, 316; G003 dòng 538. | **(a)** "Đã chọn: n".<br>**(b)** "Đã chọn X/99". | |
| **Q-24** | Khi **E03** (Zalo không trả được link, ba nút disable), menu **`•••`** góc phải **hiện, ẩn hay mờ**? | G033 E03 dòng 168 chỉ nói ba nút; §10B dòng 270 nói `•••` "chỉ có ở màn này". | **(a)** Ẩn.<br>**(b)** Hiện nhưng mờ.<br>**(c)** Hiện, bấm được. | |
| **Q-25** | Link bị đổi / huỷ **trên app Zalo** trong lúc màn đang mở → màn "cập nhật ngay": có **toast hay dấu hiệu** gì báo cho người đang xem không? | G033 §7 dòng 223, AC dòng 470. | | |

## Phản hồi của BA

| | |
| --- | --- |
| **Người trả lời** | Trân (BA) — Q-01, Q-02, Q-03, Q-04 |
| **Ngày trả lời** | 19/10/2026 |
| **Ghi chú thêm** | |

## Lịch sử cập nhật (nội bộ QA — chị Trân không cần đọc)

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
| 2026-10-19 | AI (Orchestrator) | Tạo Phần A (Q-01 → Q-04), Phần B (Q-10 → Q-16), Phần C (Q-05 → Q-09, Q-17); Q-18 (bản Draft) do Hồng chốt, không gửi BA |
| 2026-10-19 | Hồng (chuyển BA Trân) + AI | Điền trả lời Q-01 → Q-04; thêm Phần D với Q-19, Q-20 |
| 2026-10-19 | Hồng + AI (debate S4b) | Thêm Q-21 (trưởng nhóm gửi vào nhóm đích đang chặn nhắn tin) |
| 2026-10-19 | Hồng + AI (debate S4b) | Thêm Q-22 (nhóm giải tán khi màn đang mở) |
| 2026-10-19 | Hồng + AI (debate S4b) | Bổ sung Q-11 (mất mạng khi lưu QR: E05 hay E07) |
| 2026-10-19 | AI (Orchestrator) | Sau S6/S7: thêm Q-23 → Q-25; bổ sung Q-07, Q-09, Q-11, Q-15 |
