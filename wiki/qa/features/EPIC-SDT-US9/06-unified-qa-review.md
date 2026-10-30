---
featureId: EPIC-SDT-US9
reviewedAt: 2026-10-16
inputs: [01-requirement-analysis.md, 02-alignment-summary.md, 03-test-design.md, 04-testcases.md, 05-cx-review.md]
---

# Unified QA Review — EPIC-SDT-US9: Đăng ký & đăng nhập bằng Google

Hợp nhất kết quả QA và CX. Hai phần giữ phân loại riêng, không trộn. Viết tắt tệp và số dòng như file 01 (thêm `TB` =
`bang-noi-dung-thong-bao.md`, nguồn #13).

## 1. Trạng thái chung

| Mục | Giá trị |
| --- | --- |
| Cổng Alignment | open — Hồng (QA) · 2026-10-16 · "Tôi đã đọc, đồng ý mở cổng US9". **Đóng một phần sau S6/S7 (đề xuất, chờ Hồng chốt mức):** hình thức mở Google trên iOS (Q-23 — [US9_05], [US9_45], [US9_48]) và nhánh tài khoản form cũ của BR2 (Q-24 — [US9_10], [US9_70]) |
| Điểm còn mở (trọng yếu / không trọng yếu) | **2 đề xuất trọng yếu** (Q-23, Q-24 — Hồng chưa chốt) / 19 (Q-07→Q-19, Q-04b, Q-05b, Q-25→Q-28) |
| Câu trả lời BA đã dùng | Q-01 (a), Q-02 (c), Q-03 (a), Q-04 (b), Q-05 (b) — PdM Hường 2026-10-16, Hồng chuyển (kênh chưa ghi). Tái dùng từ US4: Q-04 (Google đặt được mật khẩu), Q-05 (đăng xuất mọi phiên kể cả Google) |
| Design | Wireframe + user flow US9; Figma giao diện thật — 2 frame (màn 01, màn 11) + lớp text lưu ở `figma/`. Figma **không có** màn 21, màn chọn tài khoản Google, màn lỗi AC10, màn thành công cho Google, Thông tin tài khoản của tài khoản Google |
| Đã thực thi chưa | Chưa — chỉ thiết kế. Không có môi trường / công cụ trong phiên này. Round 1–3 đều `Todo` |
| Sub-agent | `qa-test-designer` ghi 03, 04 (2026-10-16); `cx-reviewer` ghi 05 (2026-10-16). Orchestrator đã kiểm 04: 72 dòng case, ID không trùng và liên tục, đủ 15 cột, không ô Trace BR trống; cả 3 file có dòng lịch sử của agent |
| Nguồn mới trong phiên | `TB` xuất hiện 2026-10-16 17:12 (sau S3). Đã báo `qa-test-designer` trong lúc chạy; đã thêm vào 01 §1 (#13); 3 chỗ chạm US9 → Q-09, Q-26, Q-27 |

## 2. Phần QA (theo requirement)

| Chỉ số | Giá trị |
| --- | --- |
| BR đã phủ / một phần / chưa phủ | 4 (BR1, BR4, BR6, BR8) / 4 (BR2 — Q-07, **Q-24**; BR3 — Q-05b; BR5 — Q-08; BR7 — Q-04b) / 0. BR6 phủ đủ nhưng ô Data mật khẩu chờ US4 Q-26 |
| AC đã phủ / một phần / chưa phủ | 6 (AC1, AC2, AC5, AC6, AC9, AC10) / 4 (AC3 — Q-05b; AC4 — Q-07, **Q-24**; AC7 — Q-08; AC8 — Q-04b, Q-25) / 0. AC6 trên iOS ([US9_45]) và AC10 trên iOS ([US9_48]) chờ **Q-23** phần bước thao tác |
| Case nhóm A (tổng · có `❓`) | **50** ([US9_01]→[US9_50]): 28 Positive, 13 Negative, 5 Edge, 3 UI, 1 Security · `❓` ở Note 5 ([US9_16] [US9_17] Q-07, [US9_23] Q-05b, [US9_30] Q-08, [US9_39] Q-04b) · `❓` chỉ ở Data mật khẩu 4 ([US9_34]→[US9_36], [US9_40] — US4 Q-26). **Thêm sau S6/S7:** [US9_05] (Q-23) và [US9_10] (Q-24) chưa dùng làm pass/fail tới khi Hồng chốt mức — agent chưa đánh `❓` vì hai điểm phát sinh cùng lượt |
| Case nhóm B — QA bổ sung (báo cáo riêng) | **22** ([US9_51]→[US9_72]): 11 Edge, 7 UI, 4 Security; 16 có `❓`; Expected đều ĐO & GHI |
| Lỗ hổng coverage | Cột Error Code trống toàn file (Q-13 — chưa có API, mã lỗi); case API [US9_54] [US9_55] [US9_71] chưa chạy được tới khi có endpoint; cách giả IP ngoài VN và truy vấn DB phải nhờ dev; chưa có case concurrency / performance / accessibility (lý do ở 03 §6) |
| Rủi ro cao nhất (03 §5) | iOS tự tạo tài khoản khi bấm Google với email mới → Apple reject (BR4; `US9:78` cần có trước lần submit iOS) — [US9_24]→[US9_26], [US9_55]; tạo tài khoản thứ hai trùng email (E-01) — [US9_08]→[US9_15], [US9_54]; phiên Google ở thiết bị khác không bị hủy sau khi đặt mật khẩu — [US9_36]; tài khoản Google chưa có SĐT không bị giới hạn hạn mức — [US9_27]→[US9_32]; regression người dùng Google hiện hữu — [US9_11] |
| Regression scope (03 §9) | 8 khu vực: đăng nhập Google hiện hữu 3 nền tảng (mobile đổi từ webview sang màn riêng); màn 01 US3; Quên mật khẩu US4; Thông tin tài khoản US5; ChatGoni hạn mức US7; màn đăng ký 05a/11 US1/US6; iOS không có đường vào đăng ký (BUG10 — dùng chung bộ case, không lặp); lời mời workspace |
| Automation candidate (03 §10) | 6 nhóm, đều `Candidate`: hiển thị nút Web; regression đăng nhập Google Web (Google có thể chặn đăng nhập tự động); hạn mức %; Thông tin tài khoản; Hủy / mất mạng trên web bằng route abort; kiểm hai lớp qua API (chờ Q-13). Không có script |

## 3. Phần CX (quan sát và giả thuyết)

| Loại | Số lượng | ID |
| --- | ---: | --- |
| Defect (có bằng chứng thực tế) | 0 | — (không có sản phẩm để quan sát) |
| Usability Issue | 4 | CX-02, CX-07, CX-09, CX-11 |
| CX Risk | 9 | CX-01, CX-03, CX-04, CX-05, CX-06, CX-08, CX-10, CX-12, CX-13 — đều rủi ro giả định |
| Improvement Suggestion | 1 | CX-14 |

Mode đã chạy và mức bằng chứng: Mode 1 (tài liệu, wireframe, Figma) và Mode 3 (hành trình suy ra từ tài liệu, 10 hành trình
J1–J10, 9 persona — 3 có căn cứ nguồn, 4 có căn cứ nhóm nhưng bối cảnh giả thuyết, 2 hoàn toàn giả thuyết). Không có Mode 2,
không có tương tác thật. Mức impact là đề xuất của CX agent.

## 4. Điểm giao nhau QA ↔ CX

| CX finding | Case / BR liên quan | Việc cần làm |
| --- | --- | --- |
| CX-01 Người đã có tài khoản SĐT / email khác bấm Google ở màn 01 → tạo tài khoản thứ hai không cảnh báo | BR3, AC3 · [US9_18] [US9_20]; E-01 | Không đổi expected (đúng BR3). QA xác minh trên build có cảnh báo gì không — ghi ĐO & GHI; đề xuất CP-01 cho Product |
| CX-02, CX-03 Thông báo AC5 không nêu email đã kiểm, không có lối đi tiếp | BR4, AC5 · [US9_24] [US9_66] | Expected giữ nguyên văn `US9:64`; vị trí / hiển thị theo [US9_66] (Q-19); CP-02, CP-03 cho Product |
| CX-04 Màn 01 tạo được tài khoản nhưng không có dòng Điều khoản | AC3 · [US9_18] | QA xác minh, ĐO & GHI; CP-04 cho Product / pháp chế |
| CX-05 Người được mời vào workspace mới, không thấy workspace đã mời | BR2, Q-02 (c) · [US9_15] [US9_26] [US9_53] | Thêm **Q-28** (lời mời hiện ở đâu); [US9_53] ĐO & GHI |
| CX-06, CX-07, CX-11, CX-14 Thêm SĐT cho tài khoản Google ~15 bước; câu chữ viết cho người đã có mật khẩu | BR7, AC8, Q-04 (b) · [US9_39] [US9_40] [US9_31] | Bổ sung vào **Q-04b** (lối vào Quên mật khẩu khi đang đăng nhập); expected giữ luồng (b); CP-06, CP-07, CP-11 |
| CX-08 Đặt mật khẩu lần đầu đăng xuất mọi thiết bị Google | BR6, AC9 · [US9_36] | Không đổi expected (`[ĐÃ XÁC NHẬN]` US4 Q-05); CP-08 |
| CX-09 AC10 gợi ý email/SĐT là ngõ cụt với tài khoản chỉ có Google | AC10 · [US9_47]→[US9_50] | Bổ sung vào **Q-09** (kèm `TB:43`); CP-09 |
| CX-10 Không có trạng thái đang xử lý; web chặn popup | AC10 · [US9_63] | QA xác minh trong [US9_63]; CP-10 |
| CX-12 Màn thành công cho Google chưa có nội dung | AC3 · [US9_18] [US9_19] [US9_60] | Bổ sung vào **Q-05b**; [US9_60] ĐO & GHI |
| CX-13 Tài khoản form cũ (email chưa xác thực) + Google → hai người cùng vào một tài khoản | BR2, AC4 · [US9_10] [US9_70] | **Q-24, đề xuất trọng yếu (bảo mật)** — không có CP vì cần quy tắc nghiệp vụ |
| CX §7 "gắn Google" ở AC8 | AC8 · [US9_37] | **Q-25**; phần chữ "Google" ĐO & GHI, phần "Đã xác thực / không nút Đổi" vẫn expected |

## 5. Cần con người quyết định

| # | Điểm chờ quyết định | Nguồn / bằng chứng | Vì sao AI không tự quyết | Lựa chọn tài liệu hỗ trợ | Ảnh hưởng nếu chưa giải quyết | Ai quyết |
| ---: | --- | --- | --- | --- | --- | --- |
| 1 | **Mức của Q-23** — iOS có làm được "không mở trang web" không | Q-03 (a); `US9:17`; 03 §11 #4 (nhận định kỹ thuật, chưa kiểm build) | Mức trọng yếu do người dùng chốt; câu trả lời cần BA + FE | Không có — tài liệu chỉ nói chung "mobile" | [US9_05] có thể Fail theo câu chữ; bước thao tác [US9_45] [US9_48] | Hồng chốt mức; PdM Hường + FE Hoàng trả lời |
| 2 | **Mức của Q-24** — tài khoản form cũ + Google | `US9:46`, `EPIC:28`, `EPIC:98`; CX-13 | Chạm bảo mật; tài liệu không có quy tắc | Không có | [US9_10] [US9_70] không có expected cho phần mật khẩu cũ | Hồng chốt mức; PdM Hường + BE Chiến trả lời |
| 3 | **Mức của Q-27** — US9 phụ thuộc quy định mật khẩu (US4 Q-26) | `TB:24`, `TB:41`; US4 Q-26 | Mức do người dùng chốt | AI đề xuất **không trọng yếu**: US9 không test quy tắc mật khẩu | Ô Data mật khẩu 6 case `❓` | Hồng |
| 4 | Loại tài khoản (4) "đăng ký SĐT rồi thêm email" có nâng lên `[NGUỒN]` để chuyển [US9_52] sang nhóm A không | 02 §4 dòng 2; `US5:57`, `EPIC:96`; 03 §11 #6 | Đọc danh sách trong ngoặc của BR2 là ví dụ hay đầy đủ là cách hiểu — cần debate với Hồng | `EPIC:96` (mỗi email một tài khoản) + `US5:57` (email vừa thêm đăng nhập được) | [US9_52] chỉ ĐO & GHI | Hồng (debate một lượt) |
| 5 | Change Proposal CP-01→CP-12 có đưa cho Product không | 05 §6 | Đề xuất CX không là requirement | — | Không chặn test | Product (Hường) / BA Chình |

## 6. Change Proposal và đề xuất cải thiện (chưa là requirement)

| ID | Nội dung | Nguồn | Trạng thái |
| --- | --- | --- | --- |
| CP-01 | Hiện email Google vừa dùng; cảnh báo người đã có tài khoản khác trước khi tạo mới | CX-01 | Đề xuất — chưa ai quyết |
| CP-02 | Thông báo AC5 kèm email đã chọn và gợi ý đi tiếp | CX-02 | Đề xuất |
| CP-03 | Câu hướng dẫn iOS cụ thể hơn trong giới hạn BUG10 / Apple | CX-03 | Đề xuất |
| CP-04 | Dòng Điều khoản ở màn 01 hoặc màn thành công | CX-04 | Đề xuất |
| CP-05 | Lối "Tham gia workspace" cho người có lời mời đang chờ | CX-05 | Đề xuất — nối Q-28 |
| CP-06 | Thông báo Q-04b có hai lối: ChatGoni và Đặt mật khẩu mở thẳng | CX-06 | Đề xuất — nối Q-04b |
| CP-07 | Câu chữ riêng cho tài khoản chưa có mật khẩu | CX-07 | Đề xuất |
| CP-08 | Báo trước việc đăng xuất mọi thiết bị khi đặt mật khẩu | CX-08 | Đề xuất |
| CP-09 | AC10 tách câu mất mạng / Google lỗi, gợi ý theo màn | CX-09 | Đề xuất — nối Q-09 |
| CP-10 | Trạng thái đang xử lý; web phát hiện popup bị chặn | CX-10 | Đề xuất |
| CP-11 | Thông tin tài khoản hiện phương thức đăng nhập, trạng thái mật khẩu, lối Đặt mật khẩu | CX-11, CX-14 | Đề xuất |
| CP-12 | Nội dung màn thành công riêng cho Google | CX-12 | Đề xuất — nối Q-05b |

Mã CP-xx là mã cục bộ trong `05-cx-review.md`; 02 mục 9 chưa có CP từ Debate.

## 7. Giới hạn của lượt review này

- Chưa thực thi gì; không có build, môi trường, tài khoản Google test, công cụ bắt request.
- Figma chỉ có 2 frame liên quan; Figma MCP không dùng trong lượt này (đọc ảnh và lớp text đã lưu).
- Q-23 là nhận định kỹ thuật về Google Sign-In trên iOS, chưa kiểm trên build.
- `TB` xuất hiện sau khi S3 xong; 01 chỉ bổ sung dòng nguồn và 3 chỗ chạm US9, chưa rà lại toàn bộ 01 theo `TB`.
- Không có API / mã lỗi (Q-13) nên không case nào có mã lỗi kỳ vọng.
- Không kết luận về accessibility; màn chọn tài khoản của hệ điều hành là UI của Google, không review.
- Tài liệu BA chưa cập nhật theo câu trả lời (BR2 "được mời", BR4 và BR6 "Đề xuất", AC3 chưa có màn thành công, Epic #10, #11, #19) — expected đang dựa trên `[ĐÃ XÁC NHẬN]` trong 02.

## 8. Việc tiếp theo

1. **Hồng:** chốt mức Q-23, Q-24, Q-27 (mục 5 #1–#3). Nếu Q-23/Q-24 trọng yếu → gửi Phần A mới của `cau-hoi-gui-BA.md` cho chị Hường, FE Hoàng, BE Chiến; nếu hạ → `qa-test-designer` đánh `❓` cho [US9_05] [US9_45] [US9_48] [US9_10] [US9_70].
2. **Hồng:** gửi Phần B mới (Q-25, Q-26, Q-28) cùng đợt; nhắc BA cập nhật tài liệu theo các câu đã trả lời.
3. **Hồng + AI:** debate một lượt mục 5 #4 (loại tài khoản 4).
4. **Ngoài US9 — báo phiên giữ US4:** `TB:22` "Email hoặc số điện thoại không đúng" khi email/SĐT không tồn tại trái `US4:48` (thông báo phải giống nhau dù có tồn tại hay không) — 03 §11 #7.
5. Khi có build và môi trường: chạy theo 04, ghi bằng chứng (S10 — chỉ khi Hồng yêu cầu).

## Lịch sử cập nhật

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
| 2026-10-16 | AI (Orchestrator) — người dùng Hồng | Tạo file S9: hợp nhất 03, 04 (72 case: 50 nhóm A, 22 nhóm B), 05 (14 finding); kiểm 04 bằng script; gộp 13 điểm trả về thành Q-23→Q-28 + bổ sung Q-09, Q-04b, Q-05b; Q-23, Q-24 đề xuất trọng yếu chờ Hồng chốt |
