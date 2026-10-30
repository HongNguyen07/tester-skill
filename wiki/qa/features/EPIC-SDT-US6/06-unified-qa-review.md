---
featureId: EPIC-SDT-US6
reviewedAt: 2026-10-16
inputs: [01-requirement-analysis.md, 02-alignment-summary.md, 03-test-design.md, 04-testcases.md, 05-cx-review.md]
---

# Unified QA Review — EPIC-SDT-US6: Đăng ký bằng email với xác thực OTP

Hợp nhất kết quả QA và CX. Hai phần giữ phân loại riêng, không trộn. Viết tắt tệp và số dòng như file 01.

## 1. Trạng thái chung

| Mục | Giá trị |
| --- | --- |
| Cổng Alignment | open — Hồng (QA) · 2026-10-16 · "mo cong us6". **Đóng một phần 2026-10-16** (sau khi đọc Figma, Hồng chốt trọng yếu): **AC9** (Q-17 — quy định mật khẩu Figma ≠ BA) và **nhánh chặn mới ở màn 11** (Q-18 — hai frame không có trong US6); xem 02 `closedScope`. Phần còn lại vẫn mở |
| Điểm còn mở (trọng yếu / không trọng yếu) | **2 trọng yếu cô lập theo phạm vi** (Q-17, Q-18 — cổng đóng cho phần đó) / 16 (Q-01→Q-14, Q-16, Q-19; Q-15 đóng theo `EPIC:97`). BA đã trả lời **định dạng email** (02 §4 dòng 21, 2026-10-16) → Q-07 phần AC3 và Q-08 phần khoảng trắng / hoa-thường đã có |
| Cách mở cổng | Hồng hạ Q-01→Q-05 xuống không trọng yếu (2026-10-15) và tự chọn phương án; phương án giữ nhãn `[GIẢ ĐỊNH]`, case liên quan `❓ Cần chốt`. File `cau-hoi-gui-BA.md` **chưa gửi BA** (theo thông tin trong phiên) |
| Design | **Figma giao diện thật** (Hồng gửi 2026-10-16, `FIGMA`) — đối chiếu ở 01 §6d; ảnh xem được 5/9 frame US6 + email OTP đăng ký (lưu `figma/`); frame 13, frame 12 bản hai và hai frame Q-18 chỉ có lớp text. Figma MCP gói Starter chạm giới hạn nên chưa lấy thêm được |
| Đã thực thi chưa | Chưa — chỉ thiết kế. Không có môi trường / công cụ trong phiên này |
| Sub-agent | `qa-test-designer` ghi 03, 04 (2026-10-16); `cx-reviewer` ghi 05 (2026-10-16). Orchestrator đã kiểm 04 sau cập nhật AC3 (2026-10-16): 77 dòng case, ID không trùng, đủ 15 cột, không ô Trace BR trống. **Lượt 2 (2026-10-16, theo Figma + closedScope):** `qa-test-designer` sửa 29 case, thêm 3 ([US6_79] [US6_80] placeholder Q-18, [US6_81] Quay lại màn 13); `cx-reviewer` cập nhật 14 finding, thêm CX-15→CX-21. Orchestrator kiểm lại 04: **80 dòng case**, ID không trùng, đủ 15 cột, không ô Trace BR trống, 27 dòng có `❓` |

## 2. Phần QA (theo requirement)

| Chỉ số | Giá trị |
| --- | --- |
| BR đã phủ / một phần / chưa phủ | 2 (BR4, BR5) / 3 (BR1 — Q-01, Q-06, Q-12; BR2 — Q-03, Q-05, Q-12, **Q-17 phần mật khẩu**; BR3 — Q-08) / 0. **Ngoài BR:** nhánh chặn màn 11 (Q-18) chưa có BR/AC — chỉ 2 placeholder |
| AC đã phủ / một phần / chưa phủ | 3 (AC1, AC2, AC8) / 8 (AC3 chỉ còn lớp BE chờ Q-12 — lớp FE đã phủ đủ theo quy định BA, hình thức lỗi theo Figma; AC4 hình thức popup theo Figma, câu chữ chờ Q-07; AC5–AC7, AC10–AC11 — thiếu nguyên văn thông báo Q-07 và các `[GIẢ ĐỊNH]` Q-02/Q-04/Q-05; **AC9 cổng đóng Q-17** — [US6_30]→[US6_36] `❓`, chỉ [US6_37] không khớp còn tính) / 0 |
| Case nhóm A (tổng · có `❓`) | **66** ([US6_74]→[US6_77] theo quy định email; [US6_79] [US6_80] placeholder Q-18) · **24** = 15 không trọng yếu ([US6_07] [US6_15] [US6_16] [US6_17] [US6_19] [US6_20] Q-09 [US6_25] [US6_28] [US6_29] [US6_40] Q-19 [US6_43] [US6_49] [US6_57] [US6_58] [US6_59]) + **7 Q-17** ([US6_30]→[US6_36], cổng đóng) + **2 Q-18** ([US6_79] [US6_80], không expected) |
| Case nhóm B — QA bổ sung | **14** ([US6_62]→[US6_73], [US6_78], [US6_81]; [US6_61] đã chuyển lên nhóm A, số không tái dùng), đều Edge case, ĐO & GHI · 2 `❓` ([US6_72] popup Q-16, [US6_81] Quay lại màn 13 Q-10) |
| Lỗ hổng coverage | Cột Error Code trống toàn file (Q-12); 4 case API chưa chạy được tới khi có tên API; AC7 chỉ kiểm màn 12 "theo US2" với kênh email, tạm khóa / số lần sai dẫn chiếu case dùng chung US2 (Q-11); email được mời (Q-01) chỉ có case `❓`; **AC9 không dùng làm pass/fail** tới khi Q-17 chốt (quy định mật khẩu Figma ≠ BA); **nhánh chặn màn 11** (Q-18) chưa viết được case; màn 13, trạng thái sau 0 s của màn 12, AC5/AC11 chưa có ảnh Figma |
| Rủi ro cao nhất (03 §5) | Tạo tài khoản khi chưa verify OTP / mật khẩu không đạt nếu FE bị bỏ qua (BR2, `EPIC:206`) — case API [US6_07] [US6_16] [US6_28] chờ Q-12; email đã có tài khoản Google / form cũ bị tạo trùng (BR1, E-01) — [US6_10]→[US6_14]; email OTP chậm / Spam (Epic #8) |
| Regression scope (03 §9) | 9 khu vực: form đăng ký email cũ và tài khoản form cũ; màn đăng nhập US3; màn OTP dùng chung US2; màn tạo mật khẩu dùng chung (US1 05c, US4 04); Google US9; Thông tin tài khoản US5; ChatGoni hạn mức US7/US8; iOS (link trong email); mời thành viên (chờ Q-01) |
| Automation candidate (03 §10) | 4 nhóm: validate FE màn 11/13 ([US6_06] [US6_33]→[US6_37]); AC4 theo loại tài khoản ([US6_10]→[US6_14]); lớp BE qua API ([US6_07] [US6_16] [US6_28], chờ Q-12); E2E tạo tài khoản + đăng nhập ([US6_46] [US6_48]) — đều cần OTP test cố định hoặc đọc hộp thư test qua API |

## 3. Phần CX (quan sát và giả thuyết)

| Loại | Số lượng | ID |
| --- | ---: | --- |
| Defect (có bằng chứng thực tế) | 0 | — (không có sản phẩm để quan sát) |
| Usability Issue | 8 | CX-01, CX-07, CX-08, CX-09, CX-12, **CX-16** (màn 12 "Đổi số"), **CX-18** (đang đếm không có nút), **CX-21** (không có "Bước x/3") |
| CX Risk | 12 | CX-02, CX-03, CX-04, CX-05, CX-06, CX-10, CX-11, CX-13, **CX-15** (màn 14 ghi "số điện thoại"), **CX-17** (không gợi ý Spam), **CX-19** (hai frame chặn Q-18, không đường thoát), **CX-20** (email mẫu còn placeholder, không có tiêu đề) |
| Improvement Suggestion | 1 | CX-14 |

Mode đã chạy và mức bằng chứng: Mode 1 (phân tích US6 bản `06`, user flow, wireframe 11–14, Epic, US1/2/3/5/7/9, BUG10, file 01/02) và Mode 3 (9 hành trình J1–J9 mô phỏng bằng suy luận, từ màn 01 → 11 → 12 → 13 → 14 → ChatGoni → Thông tin tài khoản). **Lượt 2 (2026-10-16):** Mode 1 có thêm **Figma giao diện thật** (ảnh 5/9 frame + email OTP đăng ký) — 14 finding cũ cập nhật evidence, không finding nào đóng được; 7 finding mới CX-15→CX-21; hành trình thêm J10; persona thêm P8 (thiết bị dùng chung, giả thuyết). **Không chạy Mode 2** — không có sản phẩm, prototype, công cụ. 8 persona đều là giả định phục vụ review (`[CX GIẢ THUYẾT]`). Severity trong 05 là đề xuất CX, người có thẩm quyền chốt.

## 4. Điểm giao nhau QA ↔ CX

| CX finding | Case / BR liên quan | Việc cần làm |
| --- | --- | --- |
| CX-07 AC4 "gợi ý Đăng nhập" không đủ cho tài khoản Google (không mật khẩu) | BR1, AC4 · [US6_10]→[US6_14] (AC4 theo loại tài khoản) | Thêm **Q-16** (không trọng yếu) vào 02 §3 và file gửi BA; QA xác minh đích đến sau gợi ý theo loại tài khoản, ĐO & GHI tới khi BA trả lời |
| CX-02 email OTP chậm / Spam, gửi lại làm mã cũ vô hiệu | AC6, AC7, E-10 · case AC7 dẫn US2 | Thêm case nhóm B: gửi lại rồi nhập mã của email đầu → theo `US2:64` "mã không đúng"; có tính lượt sai không chờ Q-11 / `US2:77`. ĐO & GHI thời gian email tới trên vài nhà cung cấp (Epic #8) |
| CX-03 / 03 §11 #2 AC5 thử lại, ba trạng thái lỗi gửi | AC5, AC11 · [US6_18] [US6_19] [US6_56] `❓` | Đã ghi bổ sung vào Q-02; cách dựng lỗi gửi và BE 5xx cần Dev xác nhận — nếu không dựng được, case ghi "không chạy được" kèm lý do, không ghi pass |
| CX-04 đứng lâu ở màn 13, không có Quay lại | BR2, AC8 · [US6_29] `❓` | Đã ghi bổ sung vào Q-03; QA chạy case theo phương án Hồng (a) và ghi kết quả |
| CX-05 Android rời app lấy mã, app bị tắt | AC11 · [US6_57] [US6_58] `❓` | Đã ghi bổ sung vào Q-04; thêm case nhóm B: OS tắt app ở màn 12 khi mã còn hạn; dán mã vào 6 ô (CX-14) |
| CX-06 / 03 §11 #4 thoát ở màn 14, dấu hiệu "đã có workspace" | AC10 · [US6_46] [US6_47] [US6_49] `❓` | Đã ghi bổ sung vào Q-05; dấu hiệu QA tạm dùng (tên workspace trên menu, đăng nhập lại vào thẳng ChatGoni) là `[QA BỔ SUNG]` |
| CX-10 email được mời vào workspace | BR1, AC4, AC10 · [US6_15] `❓` | Đã ghi bổ sung vào Q-01; không thêm case tới khi BA trả lời |
| CX-13 response rớt sau khi BE đã tạo tài khoản | AC11, AC4 · case Q-13 | QA xác minh: bấm lại Đăng ký ở màn 13 BE trả gì; làm lại từ màn 11 → AC4; mật khẩu vừa đặt có hiệu lực — `❓` theo Q-13 |
| CX-08 helper màn 13, câu lỗi, trạng thái nút | AC9 · [US6_33]→[US6_37] | ĐO & GHI theo Q-07 / Q-10; thêm case nhóm B: mật khẩu 17–20 ký tự từ trình quản lý mật khẩu |
| CX-09 hai lối về màn 11 ở màn 12 | AC6 · case Q-09 | Đã ghi bổ sung vào Q-09 ("Quay lại" có hủy mã không) |
| CX-01 tên = email, không có lối đổi tên trực tiếp | BR3, AC10 · [US6_40] [US6_41] [US6_52] | ĐO & GHI tên hiện ở đâu ngay sau đăng ký (Q-08); đề xuất CP-01 chờ Product |
| CX-11 hạn mức thấp không báo trước; ngoài VN không nâng được | BR5 · dấu hiệu hạn mức thấp | Phần dấu hiệu: US6 kiểm theo 02 §4 dòng 6; phần nâng hạn mức ngoài VN **chuyển US7** |
| CX-12 ngoài VN bỏ tab SĐT không giải thích | BR4 · [US6_44] [US6_45] | ĐO & GHI theo Q-14 (thuộc US1 AC2); 03 §11 #3: cách dựng "không xác định được IP" cần Dev, không dựng được thì [US6_45] "không chạy được" |
| **CX-15** màn 14 Figma ghi "tạo với số điện thoại +84…" trong luồng email | BR3, AC10 · [US6_40] `❓ Q-19`, [US6_46] [US6_47] | Q-19 gửi Design Hiếu / BA; trên build nếu hiện SĐT → QA xác minh (nghi lệch BR3/BR5) |
| **CX-16 / CX-17 / CX-18** màn 12: link "Đổi số", không gợi ý Spam, đang đếm không có nút | AC6 · [US6_20] `❓ Q-09`, [US6_24] [US6_68] | Q-09 đã bổ sung ý Figma (cùng US4 Q-28); Expected theo AC6, hình thức ĐO & GHI; sau 0 s chưa có ảnh (US2 frame `1754:5797`) |
| **CX-19** hai frame chặn ở màn 11 (closedScope Q-18) | — · [US6_79] [US6_80] placeholder | Chỉ rủi ro, không expected, không CP; chờ BA trả lời Q-18 (hành vi thật hay không, ngưỡng, thông báo, đường thoát) |
| **CX-20** email OTP mẫu còn "[email hỗ trợ] · [hotline]", không có tiêu đề | AC6 · [US6_21] | ĐO & GHI chân thư và tiêu đề trên email thật; CP-17 |
| **CX-21** thanh tiến trình không có "Bước x/3" | AC1 · [US6_01] [US6_78] | Hình thức theo Figma, ghi nhận; CP-18 |

## 5. Cần con người quyết định

| # | Điểm chờ quyết định | Nguồn / bằng chứng | Vì sao AI không tự quyết | Lựa chọn tài liệu hỗ trợ | Ảnh hưởng nếu chưa giải quyết | Ai quyết |
| ---: | --- | --- | --- | --- | --- | --- |
| 1 | Q-01→Q-05: BA xác nhận hay bác phương án Hồng đã chọn (email được mời; AC5 thử lại; thời hạn sau OTP; ra nền / F5 / đóng tab; thời điểm tạo workspace) | `cau-hoi-gui-BA.md` Phần A, cột "QA tạm theo"; 02 §4 dòng 15–20 | Đổi kết quả AC4/AC5/AC10/AC11; tài liệu không nói; ý kiến QA không đóng được | Không có — tài liệu im lặng | 13 case `❓` không có expected chốt; Test Designer sửa case sau khi BA trả lời | BA Chình, PdM Hường (Q-01), BE Chiến (Q-02, Q-03, Q-05) |
| 2 | Q-01 và Q-05: hai ý của Hồng chưa khớp nhau (chọn (c) "tạo workspace mới" nhưng kỳ vọng "màn chọn tạo / nhận lời mời"; chọn (a) "tự tạo workspace" nhưng kỳ vọng "thấy màn tạo workspace") | 02 §4 dòng 15, 19; 02 §5 | Cả hai ý đều `[GIẢ ĐỊNH]`, không chọn được bằng tài liệu | Không có | Expected của [US6_15] [US6_49] phụ thuộc BA | BA Chình / PdM Hường |
| 3 | Q-12: API và mã lỗi cho US6 (API Zalo OTP hiện có nhận `uuid` tài khoản, không khớp đăng ký) | `EPIC:206`; `tailieu/7-send-ma-otp.md`, `8-verify-ma-otp.md` | Không bịa tên API / mã lỗi | Không có | Cột Error Code trống; 4 case API [US6_07] [US6_16] [US6_28] [US6_59] chưa chạy được | BE Chiến |
| 4 | Q-11: con số US2 (số lần gửi, số lần sai, thời gian khóa) | `US2:47-48`, `EPIC:146` — cũng chờ ở US4 Q-11 | Thuộc US2 | Không có | Precondition [US6_25] và nhóm AC7 | BE Chiến đề xuất, Hường chốt |
| 5 | Cách dựng môi trường: lỗi gửi email (AC5), BE 5xx (AC11), "không xác định được IP" (BR4), hộp thư test / OTP test cố định cho automation | 03 §11 #1–#3; 03 §10 | Việc chuẩn bị môi trường, không phải cách hiểu tài liệu | — | Không dựng được → case ghi "không chạy được" kèm lý do | BE Chiến / FE Hoàng, Hồng |
| 6 | CX-07 / Q-16: AC4 gợi ý Đăng nhập có phân nhánh theo loại tài khoản không | `US6:61`, `US9:50`, `US3:56` | Tài liệu không nói; đổi đích đến sau AC4 | Không có | [US6_10]→[US6_14] ĐO & GHI phần đích đến | BA Chình / PdM Hường |
| 7 | 18 CP ở 05 §6 (CP-01→CP-18): có đưa thành requirement không | 05 §6 | Đề xuất CX, không phải yêu cầu | — | Không ảnh hưởng case hiện tại | PdM Hường / BA Chình; CP-11, 12, 14, 15, 16 thuộc US7, US1, US2 |
| 8 | **Q-17** (trọng yếu, Hồng chốt 2026-10-16): quy định mật khẩu — Figma màn 04 US4 đòi hoa + thường + số + đặc biệt, BA Q-01 chỉ đòi chữ + số; màn 13 US6 chưa đọc được helper | 01 §6d; US4 Q-26; `EPIC:147` | Hai nguồn mâu thuẫn, đổi pass/fail nhóm AC9 | (a) theo BA, Design sửa · (b) theo Figma, Epic cập nhật | 7 case [US6_30]→[US6_36] không dùng pass/fail; AC9 chỉ còn [US6_37] | BA Chình · BE Chiến · Design Hiếu — trả lời chung với US4 Q-26 |
| 9 | **Q-18** (trọng yếu, Hồng chốt 2026-10-16): hai frame chặn ở màn 11 ("thiết bị vượt giới hạn số email", "email thuộc danh sách chặn") không có trong US6 | Figma `1819:5296`, `1819:5430`; Epic #14, `US2:78` còn mở | Hành vi mới chặn đăng ký; không có BR/AC để viết case | (a) hành vi thật → BA bổ sung BR/AC · (b) màn dự phòng, chưa làm | Chỉ 2 placeholder; CX-19 chỉ rủi ro | BA Chình · PdM Hường · BE Chiến · Design Hiếu |
| 10 | Phạm vi đánh `❓ Q-17`: Test Designer để **[US6_37]** (không khớp, `Gopany@123` đạt cả hai quy định) và [US6_28] (API) ngoài `❓`. AI đề xuất **giữ như vậy** vì hai case không phụ thuộc quy định đang tranh cãi | 03 §11 #11 | Ranh giới closedScope là việc của Hồng | — | Nếu đánh nốt → AC9 chưa phủ hoàn toàn | Hồng |
| 11 | Vị trí 2 placeholder Q-18: đang ở **nhóm A** với Trace `N/A — Q-18` (không tính phủ) để BA thấy cạnh AC3–AC5. AI đề xuất **giữ nhóm A** tới khi BA trả lời; BA nói "chưa làm" thì xóa, nói "làm" thì thành case có nguồn | 03 §11 #12; rule qa-test-case-writing (nhóm A theo requirement) | Quy ước nhóm A/B của team do Hồng giữ | — | Không đổi số case có expected | Hồng |
| 12 | Q-19 (không trọng yếu): màn 14 Figma ghi "số điện thoại" trong luồng email — lỗi copy design hay hành vi thật | Figma `1641:50321`; wireframe `US6:29`; BR3 | Không tự kết luận design sai | (a) Design sửa thành email · (b) khác | [US6_40] `❓`; CX-15 | Design Hiếu · BA Chình |

## 6. Change Proposal và đề xuất cải thiện (chưa là requirement)

| ID | Nội dung | Nguồn | Trạng thái |
| --- | --- | --- | --- |
| CP-01 | Màn 14: lối "Đổi tên hiển thị" mở thẳng Thông tin tài khoản | CX-01 | Đề xuất — chưa ai quyết |
| CP-02 | Màn 12 sau Gửi lại: dòng "chỉ mã trong email mới nhất có hiệu lực"; email mẫu ghi giờ gửi | CX-02 | Đề xuất — US2, màn dùng chung |
| CP-03 | Thông báo AC5 nêu lỗi phía hệ thống gửi + hành động; nếu thử lại chịu 60 s thì hiện đếm ngược | CX-03 | Chờ Q-02 |
| CP-04 | Nếu có thời hạn sau OTP: màn 13 hiện đếm ngược; hết hạn về màn 11 điền sẵn | CX-04 | Chờ Q-03 |
| CP-05 | Mở lại app khi mã còn hạn: về màn 12 với email cũ, cho nhập mã cũ | CX-05 | Chờ Q-04 |
| CP-06 | Màn 14 ghi rõ "có thể đăng nhập bằng email này từ bây giờ" và bước còn lại | CX-06 | Chờ Q-05 |
| CP-07 | Thông báo AC4 kèm lối "Đăng nhập" và "Quên mật khẩu?", nhắc Google nếu từng dùng | CX-07 | Đề xuất — liên quan Q-16 |
| CP-08 | Helper màn 13 nêu đủ "8–16 ký tự, có chữ và số"; lỗi không đạt nêu tiêu chí thiếu | CX-08 | Đề xuất — liên quan Q-07 |
| CP-09 | Màn 12 một lối về màn 11, hoặc "Quay lại" điền sẵn email | CX-09 | Chờ Q-09 |
| CP-10 | Màn 14 hoặc lần đầu vào ChatGoni: một dòng về hạn mức thấp và cách nâng | CX-11 | Đề xuất — có thể trái chủ trương `US7:9` |
| CP-11 | (US7) Link nâng hạn mức nói rõ điều kiện SĐT VN có Zalo | CX-11 | Ngoài phạm vi US6 |
| CP-12 | (US1) Ngoài VN: dòng giải thích vì sao chỉ còn Email | CX-12 | Ngoài phạm vi US6 |
| CP-13 | Bấm lại Đăng ký khi tài khoản đã tạo: BE idempotent hoặc thông báo "đã tạo, vui lòng đăng nhập" | CX-13 | Chờ Q-13 |
| CP-14 | (US2) Ô OTP nhận dán chuỗi 6 số, tự chuyển ô | CX-14 | Ngoài phạm vi US6 — trùng US4 CP-08 |
| CP-15 | (US2, màn dùng chung) Nhãn link ở màn 12 theo kênh gửi: "Đổi email" khi mã gửi qua email | CX-16 | Đề xuất — chồng lên Q-09 |
| CP-16 | (US2, màn dùng chung) Trong lúc đếm: câu đủ nghĩa "Gửi lại mã sau Ns" hoặc nút "Gửi lại mã" mờ kèm đếm ngược; sau 0 s nút bật | CX-18 | Đề xuất — chồng lên Q-09 |
| CP-17 | Email OTP mẫu: thay "[email hỗ trợ] · [hotline]" bằng kênh thật; design ghi tiêu đề mẫu (mẫu 23 "tiêu đề chứa mã") | CX-20 | Đề xuất — chưa ai quyết |
| CP-18 | Thanh tiến trình kèm nhãn "Bước x/3" (hoặc accessibility label) | CX-21 | Đề xuất — chưa ai quyết |

Từ Debate: không có Change Proposal (02 §9 trống).

## 7. Giới hạn của lượt review này

- Chưa chạy test; không có môi trường, sản phẩm, prototype, email mẫu 23 thật. **Figma giao diện thật đã có từ 2026-10-16** nhưng chỉ xem được ảnh 5/9 frame US6 (thiếu màn 13, frame 12 bản hai, hai frame Q-18; không có AC5/AC11, trạng thái sau 0 s, Web, iOS); CX chưa đánh giá màu, vùng chạm, accessibility (không có token).
- Cổng mở trên 5 giả định của Hồng (Q-01→Q-05), chưa có BA; **đóng một phần** cho AC9 (Q-17) và nhánh chặn màn 11 (Q-18). 24 case nhóm A đang `❓ Cần chốt` (15 không trọng yếu + 7 Q-17 + 2 Q-18); expected của chúng chưa phải căn cứ pass/fail.
- Tên nút / nhãn nay lấy theo Figma (`US6:33`): nút màn 12 "Xác thực"; chỗ Figma khác AC ("Đổi số", thiếu gợi ý Spam, màn 14 "số điện thoại") Expected vẫn theo AC và đánh `❓` Q-09 / Q-19 — không tự chọn bên nào.
- Bản nháp `Chình - … US6` trong thư mục export không dùng; Hồng chưa xác nhận rõ bản nào hiệu lực (Q-14), AI theo bản `06` Hồng đính kèm.
- Lỗi OTP chi tiết (sai mã, hết hạn, khóa) và nội dung email mẫu kiểm theo US2, không viết lại trong US6; hạn mức ChatGoni dừng ở dấu hiệu hạn mức thấp.
- `wiki/` nằm trong `.gitignore` (dòng 21) nên các file feature không được git theo dõi.

## 8. Việc tiếp theo

1. Hồng gửi `cau-hoi-gui-BA.md` (Phần A Q-01→Q-05 có cột "QA tạm theo" **+ Q-17, Q-18 trọng yếu**; Phần B Q-06→Q-14, Q-16, **Q-19**) cho BA Chình, PdM Hường, BE Chiến, **Design Hiếu** (Q-17→Q-19). Q-17 trả lời chung với US4 Q-26. Khi có trả lời, dán vào phiên kèm tên người trả lời và kênh → Orchestrator áp vào 02 §3, debate lại phần bị đổi, Test Designer sửa 13 case `❓`.
2. Hồng hỏi Dev cách dựng: lỗi gửi email, BE 5xx, "không xác định được IP", hộp thư test / OTP test cố định (mục 5 #5).
3. Hồng review 04 (80 case) và 05 (21 finding); quyết định mục 5 #10 (ranh giới `❓ Q-17`) và #11 (vị trí placeholder Q-18); có thêm case nhóm B theo mục 4 (gửi lại rồi nhập mã cũ; OS tắt app; dán mã; mật khẩu 17–20 ký tự) không.
3b. `04-testcases.xlsx` và trang Outline (4.6) đang là bản 77 case — cần xuất lại khi Hồng yêu cầu (nay 80 case, 27 dòng `❓`).
3c. Khi Figma MCP cho gọi tiếp: lấy ảnh frame 13 (`1641:50302`), 12 bản hai (`1641:50334`), hai frame Q-18 và US2 `1754:5797` (sau 0 s) → giao Test Designer / CX rà nốt.
4. Khi có môi trường và Hồng yêu cầu → S10 theo rule 08.

## 9. Cập nhật 2026-10-20 — tài liệu nguồn đổi sang bản final 19/10/2026

- **Nguồn:** US6 bản final 19/10/2026 (Hường) — 10 BR, 19 AC + AC11a; thông báo gộp vào AC; danh sách chặn email ngoài phạm vi. `tailieu/` đồng bộ 2026-10-20. Bản cũ của 7 file wiki ở `_backup-2026-10-20-truoc-ban-final/`.
- **Đã cập nhật:** `01` (mục 1–7, 10; thêm §12 đối chiếu mã, §13 điểm mới) · `02` (frontmatter, §1–§3, §3b rà Q-01→Q-21, §4 dòng 28–46 `[NGUỒN]` chưa debate, §5–§8, §11) · `cau-hoi-gui-BA.md` (bảng trạng thái + Phần C Q-22→Q-25) · `03` và `04` do Test Designer viết lại tại chỗ, giữ ID.
- **Câu hỏi:** 12 đóng theo tài liệu (Q-03, Q-06, Q-07, Q-09, Q-11, Q-15, Q-16, Q-18, Q-19, Q-20, Q-21; Q-17 thu hẹp) · 5 đóng một phần (Q-02, Q-04, Q-05, Q-10, Q-14) · 4 mở (Q-01, Q-08, Q-12, Q-13) · 4 mới không trọng yếu (Q-22 AC11a cách đếm; Q-23 AC8 "hệ thống bận" / ngưỡng chặn ngầm; Q-24 AC10 email khác, AC10 ↔ AC18; Q-25 lệch Figma ↔ tài liệu). Cổng giữ mở; `closedScope` còn Q-17 phần chữ hoa + chữ thường / nới 64 ký tự.
- **Test case (`04`):** 92 dòng = nhóm A **83** (Positive 26 / Negative 27 / Edge case 19 / UI 5 / Security 6) + nhóm B **9**; `❓` nhóm A **16** (Q-01 ×1, Q-02 ×1, Q-04 ×1, Q-05 ×1, Q-08 ×1, Q-12 ×3, Q-13 ×1, Q-17 ×3, Q-22 ×1, Q-23 ×1, Q-24 ×2). Mới [US6_82]→[US6_94] (13); chuyển B → A giữ ID: [US6_62] [US6_64] [US6_72] [US6_78] [US6_81]; [US6_79] viết lại thành AC8 chặn ngầm; bỏ [US6_80] (ngoài phạm vi). Độ phủ (`03` §6): BR đã phủ 5 / một phần 5 / chưa phủ 0; AC đã phủ 10 / một phần 9 / chưa phủ 1 (AC11a — chỉ có case `❓` Q-22).
- **Điểm quay lại Debate mới (`03` §11 #13–#17):** "hệ thống bận" không có câu riêng; thứ tự AC10 ↔ AC8 khi cùng lúc; hộp thoại AC19(b) ở màn 13 hai nút về đâu; AC19(d) ô Email điền sẵn không, áp cho web đóng tab không; tiêu đề màn 12 kênh email chỉ suy từ US2 — đều không trọng yếu, không chọn cách hiểu.
- **Cần Hồng quyết định:** (1) mức của Q-17 sau khi tài liệu đã ghi quy định (đề xuất giữ trọng yếu, cô lập 3 case); (2) xác nhận 19 dòng cách hiểu `02` §4 dòng 28–46; (3) gửi Phần C (Q-22→Q-25) và nhắc phần còn lại của Q-01, Q-02, Q-05, Q-08, Q-12, Q-13, Q-14, Q-17 cho BA/BE/Design.
- **Chưa làm:** `05-cx-review.md` chưa rà theo bản final (21 finding còn dẫn mã AC cũ; CX-15→CX-19 đã được tài liệu trả lời) · `04-testcases.xlsx` và trang Outline `docs.gopany.tech/doc/46-epic-sdt-us6-rQ9COfYmY7` còn bản 2026-10-16 (80 case) — cần xuất lại và đẩy lại khi Hồng yêu cầu · ảnh user flow mới chưa xem · Figma chưa đọc lại sau 16/10.

## Lịch sử cập nhật

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
| 2026-10-16 | AI (Orchestrator) — người dùng Hồng | Tạo file S9: hợp nhất 03/04 (73 case, 13 `❓`) và 05 (14 finding); thêm Q-16; 7 điểm cần con người quyết định; 14 CP từ CX |
| 2026-10-16 | AI (Orchestrator) — sau BA trả lời định dạng email (Hồng chuyển) | Cập nhật số: nhóm A 64, nhóm B 13 (77 dòng), AC3 lớp FE đã phủ; Q-07 còn AC4/AC5/AC9/AC11; thêm 03 §11 #5 (tên miền có dấu, ô Email trống) vào Q-07 |
| 2026-10-16 | AI (Orchestrator) — theo yêu cầu Hồng | Thêm bản Excel `04-testcases.xlsx` (dropdown kết quả) để đính kèm trang Outline docs.gopany.tech/doc/46-epic-sdt-us6-rQ9COfYmY7; AI không có quyền ghi Outline, Hồng tự đưa lên |
| 2026-10-16 | AI (Orchestrator) — theo yêu cầu Hồng | Đã đẩy 04 + Excel lên Outline bằng API (Hồng cấp key trong phiên); trang 4.6 revision 6 |
| 2026-10-16 | AI (Orchestrator) — sau S6/S7 lượt 2 (Figma giao diện thật) | Cập nhật số: 80 case (A 66 / B 14), 27 dòng `❓` (7 Q-17, 2 Q-18); CX 21 finding (0/8/12/1), CP-15→CP-18; mục 1 thêm Design + đóng cổng một phần (Q-17, Q-18); mục 4 thêm 5 dòng; mục 5 thêm #8–#12; mục 7, 8 cập nhật |
| 2026-10-20 | AI (Orchestrator) — Hồng đưa bản final 19/10/2026 vào `tailieu/`, yêu cầu cập nhật test case US6 | Thêm mục 9: tổng hợp cập nhật theo bản final — 01/02/cau-hoi do Orchestrator, 03/04 do Test Designer (92 case: A 83 / B 9, `❓` 16; mới [US6_82]→[US6_94]; bỏ [US6_80]); câu hỏi 12 đóng / 5 một phần / 4 mở / 4 mới; việc chưa làm (05, xlsx, Outline) |
