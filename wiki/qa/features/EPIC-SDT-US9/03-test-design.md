---
featureId: EPIC-SDT-US9
basedOn: 02-alignment-summary.md (gate: open, 2026-10-16)
designedAt: 2026-10-16
---

# Test Design — EPIC-SDT-US9: Đăng ký & đăng nhập bằng Google

Viết tắt nguồn như file 01 (`US9:NN`, `EPIC:NN`, `US1/US3/US4/US5/US7:NN`, `FIGMA`, `US4-AS`, `US6-AS`); thêm `TB:NN` =
`bang-noi-dung-thong-bao.md` cùng thư mục với US9 (xuất hiện 2026-10-16 17:12, chưa có trong file 01). `02 §4 d.N` = mục 4 dòng N
của `02-alignment-summary.md`. Case chi tiết: `04-testcases.md`.

## 1. Use Case

| Mã | Tên | Actor | Nguồn |
| --- | --- | --- | --- |
| UC-01 | Đăng ký bằng Google (Android, Web): chọn tài khoản → tạo tài khoản → màn thành công → "Bắt đầu sử dụng" → tạo workspace → ChatGoni | Người dùng có tài khoản Google | `US9:45-47`, `US9:52`, `US9:62`; user flow `US9:23`; màn thành công `[ĐÃ XÁC NHẬN]` Q-05 (b) |
| UC-02 | Đăng nhập bằng Google (mọi nền tảng) với email đã có tài khoản | Người dùng có tài khoản Gopany | `US9:46`, `US9:63` |
| UC-03 | iOS, email Google chưa có tài khoản → không tạo, báo hướng dẫn | Người dùng iOS | `US9:48`, `US9:64`; `[ĐÃ XÁC NHẬN]` Q-01 (a) |
| UC-04 | Sau khi vào app: hạn mức ChatGoni, Thông tin tài khoản, thêm SĐT | Người dùng tài khoản Google | `US9:49`, `US9:51`, `US9:67-68`; Q-04 (b) |
| UC-05 | Quên mật khẩu bằng email Google → đặt mật khẩu, vẫn dùng Google | Người dùng tài khoản Google | `US9:50`, `US9:69`, `US4:52` |

## 2. Business Rule

| Mã | Tóm tắt | Trạng thái hiểu | Nguồn |
| --- | --- | --- | --- |
| BR1 | Email Google = email đã xác thực, không cần OTP | `[NGUỒN]` — loại email Google còn mở Q-12 | `US9:45`; 02 §4 d.1 |
| BR2 | Email Google trùng tài khoản đã có → đăng nhập vào tài khoản đó | `[NGUỒN]` (7 loại tài khoản, 02 §4 d.2; loại (4) `[DIỄN GIẢI AI]`); "được mời" `[ĐÃ XÁC NHẬN]` Q-02 (c); workspace Q-07 mở | `US9:46`, `EPIC:97`; 02 §4 d.2, d.18 |
| BR3 | Android/Web: email mới → tạo tài khoản, họ tên từ Google, sửa được | `[NGUỒN]` + `[ĐÃ XÁC NHẬN]` Q-05 (b) màn thành công; Q-05b, Q-11 mở | `US9:47`, `US9:62`; 02 §4 d.4, d.5, d.20 |
| BR4 | iOS: email mới → không tạo tài khoản, báo hướng dẫn | `[ĐÃ XÁC NHẬN]` Q-01 (a) PdM Hường; tài liệu còn chữ "Đề xuất"; Q-19 mở | `US9:48`, `US9:64`; 02 §4 d.23 |
| BR5 | Tài khoản Google chưa có SĐT → hạn mức thấp, Pro khóa tới khi thêm SĐT | `[NGUỒN]`; popup lần đầu Q-08 mở | `US9:49`, `US7:50`, `US7:61-66`; 02 §4 d.6, d.7 |
| BR6 | Tài khoản Google không có mật khẩu; đặt qua Quên mật khẩu | `[ĐÃ XÁC NHẬN]` US4 Q-04, Q-05; quy định mật khẩu phụ thuộc US4 Q-26 (chỉ dữ liệu) | `US9:50`, `US9:69`, `US4:50`, `US4:52`; 02 §4 d.8, d.9 |
| BR7 | Email gắn Google không đổi được; thêm SĐT phải đặt mật khẩu trước | `[NGUỒN]` (không đổi email) + `[ĐÃ XÁC NHẬN]` Q-04 (b); hình thức thông báo Q-04b mở | `US9:51`, `US9:68`, `US5:56`, `US5:70`; 02 §4 d.10, d.11, d.19 |
| BR8 | Đăng ký bằng Google không giới hạn IP | `[NGUỒN]`; nút Google ngoài VN Q-15 mở | `US9:52`, `US1:45`; 02 §4 d.12 |

AC1–AC10 (`US9:59-71`) không gắn BR riêng ở AC1, AC2, AC6, AC10; các AC còn lại đi cùng BR theo user flow (`US9:23`).

## 3. Decision Table

**DT-1 — Kết quả sau khi bấm nút Google** (BR2, BR3, BR4, AC3–AC6, AC10; user flow `US9:23`)

| Điều kiện / Hành động | R1 | R2 | R3 | R4 | R5 | R6 | R7 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| C1: Thao tác ở màn chọn tài khoản | Hủy | Google lỗi / mất mạng | Chọn | Chọn | Chọn | Chọn | Chọn |
| C2: Email Google đã có tài khoản Gopany | — | — | Có | Chưa | Chưa | Chưa (chỉ được mời) | Chưa (chỉ được mời) |
| C3: Nền tảng | Mọi | Mọi | Mọi | Android / Web | iOS | Android / Web | iOS |
| → Kết quả (nguồn) | Về màn vừa bấm, không báo lỗi (AC6, d.13) | Báo lỗi tiếng Việt, thử lại, gợi ý email/SĐT (AC10) | Đăng nhập đúng tài khoản, đúng workspace, không tạo thứ hai (AC4) | Màn thành công → "Bắt đầu sử dụng" → tạo workspace → ChatGoni (AC3, Q-05 b) | Không tạo; "Tài khoản chưa tồn tại. Vui lòng đăng ký trên web hoặc ứng dụng Android." (AC5, Q-01 a) | Như R4, workspace mới, lời mời xử lý riêng (Q-02 c) | Như R5 (Q-02 c) |
| Case | [US9_43]→[US9_46] | [US9_47]→[US9_50] | [US9_08]→[US9_14] | [US9_06], [US9_07], [US9_18]→[US9_20], [US9_25] | [US9_24] | [US9_15] | [US9_26] |

R3 với tài khoản nhiều workspace / chưa có workspace: Q-07 ([US9_16], [US9_17], `❓`).

**DT-2 — Thêm SĐT cho tài khoản Google** (BR5, BR7; Q-04 (b), 02 §4 d.7, d.19)

| Điều kiện / Hành động | R1 | R2 | R3 |
| --- | --- | --- | --- |
| C1: Đường thêm | Thông tin tài khoản → "Thêm" | Thông tin tài khoản → "Thêm" | ChatGoni → popup → "Nhập số điện thoại" |
| C2: Tài khoản đã đặt mật khẩu | Chưa | Rồi (qua AC9) | Không xét (`US7:83` không hỏi mật khẩu) |
| → Kết quả (nguồn) | Yêu cầu đặt mật khẩu trước qua Quên mật khẩu (Q-04 b); hình thức Q-04b | Màn 09 nhập mật khẩu + SĐT → OTP Zalo → "Đã xác thực" (`US5:69`, `US5:73`) | OTP Zalo → "Hạn mức chat đã được nâng và bạn dùng được Pro" (`US7:75`) |
| Case | [US9_39] `❓` | [US9_40] | [US9_31] |

## 4. State Transition

Nguồn không định nghĩa máy trạng thái; bảng dưới chỉ gồm trạng thái dữ liệu có trong nguồn / câu trả lời BA (file 01 mục 7).

| Đối tượng | Trạng thái → sự kiện → trạng thái | Nguồn / nhãn | Case |
| --- | --- | --- | --- |
| Tài khoản (Android/Web, email mới) | Chưa tồn tại → chọn tài khoản Google → đã tạo, màn thành công → bấm "Bắt đầu sử dụng" → có workspace, ChatGoni | `[ĐÃ XÁC NHẬN]` Q-05 (b); thời điểm tạo tài khoản `[DIỄN GIẢI AI]` d.20; thoát giữa chừng Q-05b | [US9_18], [US9_23] `❓`, [US9_61] |
| Tài khoản (iOS, email mới) | Chưa tồn tại → chọn tài khoản Google → vẫn chưa tồn tại | `[ĐÃ XÁC NHẬN]` Q-01 (a) | [US9_24], [US9_25] |
| Mật khẩu tài khoản Google | Không có → Quên mật khẩu (OTP email) → có | `[ĐÃ XÁC NHẬN]` US4 Q-04 | [US9_33], [US9_34] |
| Phiên đăng nhập Google ở thiết bị khác | Đang đăng nhập → đặt mật khẩu → bị đăng xuất ở lần gọi API kế tiếp | `[ĐÃ XÁC NHẬN]` US4 Q-05 | [US9_36] |
| SĐT tài khoản Google | "Chưa có" → thêm (ChatGoni, hoặc TTTK sau khi có mật khẩu) → "Đã xác thực" | `[NGUỒN]` `US9:68`, `US7:75`; Q-04 (b) | [US9_31], [US9_39], [US9_40] |
| Hạn mức ChatGoni | Thấp + Pro khóa → thêm SĐT → cao + Pro | `[NGUỒN]` `US9:49`, `US7:75` | [US9_27]→[US9_32], [US9_40] |

## 5. Risk Analysis `[QA BỔ SUNG]`

| # | Rủi ro | Impact | Likelihood | Căn cứ | Liên quan BR / Q |
| ---: | --- | --- | --- | --- | --- |
| 1 | iOS tự tạo tài khoản khi bấm Google với email mới → thành đăng ký trong app, Apple có thể reject | Cao (`US9:9` guideline 4.8; `US9:78` "AC5 cần có trước lần submit iOS tiếp theo") | Chưa có dữ liệu; tài liệu BR4 còn chữ "Đề xuất", Epic #10 trống → dev có thể làm theo bản cũ | `US9:48`, `EPIC:153` | BR4, Q-01 |
| 2 | Tạo tài khoản thứ hai trùng email (phá E-01) với một trong 7 loại tài khoản đã có, kể cả khác hoa/thường | Cao (dữ liệu, gộp tài khoản) | Chưa có dữ liệu | `US9:46`, `EPIC:96-97`; 02 §4 d.2 | BR2, Q-07 |
| 3 | Hình thức mở Google trên iOS không đạt "không mở trang web" (xem §11 #4) | Trung bình–cao (đổi pass/fail [US9_05], rủi ro Apple) | Chưa có dữ liệu — nhận định kỹ thuật chưa kiểm | `US9:17`; Q-03 (a); `EPIC:162` | US9 §3, Q-03 |
| 4 | Tài khoản Google không tự thêm được SĐT ở Thông tin tài khoản (hướng dẫn chưa chốt) → kẹt hạn mức thấp | Trung bình | Chưa có dữ liệu; Q-04b chưa có nội dung | Q-04 (b), `US5:52` | BR7, BR5, Q-04b |
| 5 | Phiên Google ở thiết bị khác không bị hủy sau khi đặt mật khẩu | Cao (bảo mật) | Chưa có dữ liệu | US4 Q-05 `[ĐÃ XÁC NHẬN]` | BR6, AC9 |
| 6 | Tài khoản Google chưa có SĐT không bị giới hạn hạn mức → spam chi phí ChatGoni | Cao (`US7:8`) | Chưa có dữ liệu | `US9:49`, `US7:50` | BR5 |
| 7 | Mất mạng / thoát giữa luồng tạo → tài khoản không có workspace, lần sau vào đâu không rõ | Trung bình | Chưa có dữ liệu | Q-05 (b), Q-05b, d.14, d.20 | BR3, AC10 |
| 8 | Regression người dùng Google hiện hữu (tạo trước Epic) không vào được tài khoản cũ | Cao (`EPIC:194` DoD) | Chưa có dữ liệu; mobile chuyển từ webview sang màn riêng (`EPIC:144`) | `US3:59`, `BUG10:17` | BR2, AC1 |
| 9 | Tài liệu chưa cập nhật theo câu trả lời BA (BR4, BR6, AC3 màn thành công, BR2 "được mời", Epic #19) → Dev/QA đọc lệch | Trung bình | Đã xảy ra ở tài liệu (02 mục 4 cột "Tài liệu đã cập nhật chưa") | 02 §4 d.18–d.23 | — |
| 10 | Thông báo lỗi lệch giữa các nguồn (`TB` vs US3; quy định mật khẩu `TB` vs 02 §3) | Thấp–trung bình | Đã thấy trong nguồn | `TB:19`, `TB:24`, `US3:56` | BR6, US4 Q-26 |

## 6. Coverage Matrix

Trạng thái theo rule 07 §2: "Đã phủ" = có ≥ 1 case nhóm A không `❓` và không case nào của nhánh đang `❓`; "Một phần" = có case nhưng
một phần case `❓` hoặc thiếu nhánh. Case chỉ có `❓` ở ô Data (giá trị mật khẩu, US4 Q-26) được tính là phủ vì Expected hành vi vẫn
là tiêu chí pass (chỉ đạo Orchestrator 2026-10-16) — ghi chú riêng.

| BR / AC | Use Case | Decision / State | Scenario | Case nhóm A | Trạng thái | Ghi chú |
| --- | --- | --- | --- | --- | --- | --- |
| BR1 | UC-01 | DT-1 R4 | SC-03 | [US9_06], [US9_07]; phụ: [US9_34], [US9_37] | Đã phủ | Loại email Google (Q-12) ở nhóm B [US9_59] |
| BR2 | UC-02 | DT-1 R3, R6 | SC-04, SC-05, SC-06 | [US9_08]→[US9_15], [US9_16] `❓`, [US9_17] `❓` | Một phần | Q-07 (nhiều / chưa có workspace); loại (4) TK-S ở nhóm B [US9_52] |
| BR3 | UC-01 | DT-1 R4; state tài khoản | SC-07, SC-08, SC-09 | [US9_18]→[US9_22], [US9_23] `❓` | Một phần | Q-05b; biên họ tên Q-11 ở nhóm B |
| BR4 | UC-03 | DT-1 R5, R7 | SC-10 | [US9_24], [US9_25], [US9_26] | Đã phủ | Hiển thị thông báo Q-19 ở nhóm B [US9_66] |
| BR5 | UC-04 | DT-2 R3; state hạn mức | SC-11 | [US9_27]→[US9_29], [US9_30] `❓`, [US9_31], [US9_32]; phụ: [US9_40] | Một phần | Q-08 (popup lần đầu) |
| BR6 | UC-05 | state mật khẩu, phiên | SC-12 | [US9_33]→[US9_36] | Đã phủ | [US9_34]→[US9_36] có `❓` ở Data (US4 Q-26); nguyên văn [US9_33] ĐO & GHI (§11 #1) |
| BR7 | UC-04 | DT-2 R1, R2 | SC-13 | [US9_37], [US9_38], [US9_39] `❓`, [US9_40] | Một phần | Q-04b; chữ "gắn Google" ĐO & GHI (CX) |
| BR8 | UC-01 | DT-1 R4 | SC-14 | [US9_41], [US9_42] | Đã phủ | Nút Google ngoài VN Q-15 ở nhóm B [US9_68] |
| AC1 | UC-01, UC-02 | — | SC-01 | [US9_01], [US9_02] | Đã phủ | Hình thức mở Google: [US9_04], [US9_05] (`— · US9 §3`) |
| AC2 | UC-01 | — | SC-01 | [US9_03]; phụ: [US9_09], [US9_20] | Đã phủ | Tab còn lại ĐO & GHI [US9_72] (§11 #5) |
| AC3 | UC-01 | DT-1 R4, R6 | SC-03, SC-05, SC-07, SC-14 | [US9_06], [US9_07], [US9_15], [US9_18]→[US9_21], [US9_23] `❓`, [US9_25], [US9_41], [US9_42] | Một phần | Q-05b |
| AC4 | UC-02 | DT-1 R3 | SC-04, SC-06 | [US9_08]→[US9_14], [US9_16] `❓`, [US9_17] `❓` | Một phần | Q-07 |
| AC5 | UC-03 | DT-1 R5, R7 | SC-10 | [US9_24]→[US9_26] | Đã phủ | — |
| AC6 | UC-01, UC-02 | DT-1 R1 | SC-15 | [US9_43]→[US9_46] | Đã phủ | Dữ liệu đã gõ Q-10 ở nhóm B [US9_65] |
| AC7 | UC-04 | state hạn mức | SC-11 | [US9_27]→[US9_32] ([US9_30] `❓`) | Một phần | Q-08 |
| AC8 | UC-04 | DT-2 | SC-13 | [US9_37]→[US9_40] ([US9_39] `❓`) | Một phần | Q-04b; tài khoản form cũ Q-17 nhóm B [US9_70] |
| AC9 | UC-05 | state mật khẩu, phiên | SC-12 | [US9_34], [US9_35], [US9_36] | Đã phủ | Cả 3 có `❓` ở Data (US4 Q-26) |
| AC10 | UC-01, UC-02 | DT-1 R2 | SC-16 | [US9_47]→[US9_50] | Đã phủ | Nguyên văn, màn hiện lỗi, `TB:43`: ĐO & GHI dưới Q-09 ở Note; cách dựng khác ở nhóm B |

Tổng (nhóm A): BR đã phủ 4/8, một phần 4/8, chưa phủ 0. AC đã phủ 6/10 (AC1, AC2, AC5, AC6, AC9, AC10), một phần 4/10 (AC3, AC4,
AC7, AC8), chưa phủ 0. Số liệu đếm bằng script từ cột Trace BR của `04-testcases.md`.

Lỗ hổng:

- **Requirement không có case:** không có. `US9:19` (hủy liên kết Google, Apple, Facebook/Zalo) và 02 mục 8 ngoài phạm vi — không viết case.
- **Case không có nguồn:** không có ở nhóm A. 22 case nhóm B ([US9_51]→[US9_72]) là `[QA BỔ SUNG]`, Trace `(liên quan)`, kỳ vọng ĐO & GHI.
- **Coverage chưa rõ:** 5 case `❓` nhóm A (Q-04b, Q-05b, Q-07 ×2, Q-08); nguyên văn thông báo AC10 (Q-09) và [US9_33] (§11 #1) chỉ ĐO & GHI; giá trị mật khẩu chờ US4 Q-26; hình thức mở Google trên iOS (§11 #4); mã lỗi BE chưa có (Q-13) nên không case nào có dòng mã lỗi kỳ vọng.

Coverage QA bổ sung (báo cáo riêng, không cộng): 22 case nhóm B — dữ liệu tài khoản đã có (3), hai lớp API (3), biên họ tên / loại email
(4), màn thành công (1), lỗi Google mở rộng (4), hiển thị phụ (5), bảo mật / tài khoản cũ (2).

Loại coverage đã cân nhắc và không áp dụng:

- Boundary / equivalence của mật khẩu — thuộc US4 (US4 Q-26), không viết ở US9 (chỉ đạo Orchestrator).
- Performance — nguồn không có SLA.
- Concurrency — nguồn không mô tả; hai người cùng bấm Google một email ít khả thi về dữ liệu test (một tài khoản Google). Chưa viết; có thể thêm nhóm B nếu Hồng muốn.
- AI-specific — ChatGoni chỉ dùng làm nơi quan sát hạn mức; chất lượng trả lời ngoài phạm vi US9.
- Accessibility — nguồn không có yêu cầu; để CX review.
- Compatibility — thiết bị test theo DoD (`EPIC:193`: 2 iOS, 2 Android, Chrome/Safari) là điều kiện chạy, không tách case.

## 7. Test Scenario

| SC | Mô tả | BR / AC | Use Case | Loại coverage | Nhóm |
| --- | --- | --- | --- | --- | --- |
| SC-01 | Nút Google hiển thị ở màn 01 (3 nền tảng) và màn đăng ký (Android/Web); iOS không có link Đăng ký | AC1, AC2 | UC-01, UC-02 | UI, regression | A |
| SC-02 | Mobile mở màn chọn tài khoản của hệ điều hành, không mở trang web | US9 §3 (Q-03) | UC-01, UC-02 | Positive, compatibility | A |
| SC-03 | Đăng ký bằng Google không qua OTP / tạo mật khẩu | BR1, AC3 | UC-01 | Positive | A |
| SC-04 | Đăng nhập Google với từng loại tài khoản đã có, mọi nền tảng | BR2, AC4 | UC-02 | Positive, data integrity, regression | A |
| SC-05 | Email được mời nhưng chưa đăng ký (Android tạo mới, iOS chặn) | BR2, BR4, AC3, AC5 | UC-01, UC-03 | Positive / Negative | A |
| SC-06 | Đích workspace khi nhiều / chưa có workspace | BR2, AC4 | UC-02 | Edge case | A (`❓` Q-07) |
| SC-07 | Tạo tài khoản → màn thành công → ChatGoni (01, 05a, 11) | BR3, AC3 | UC-01 | Positive, E2E | A |
| SC-08 | Họ tên lấy từ Google và sửa được | BR3 | UC-01 | Positive | A |
| SC-09 | Thoát ở màn thành công | BR3, AC3 | UC-01 | Edge case, recovery | A (`❓` Q-05b) |
| SC-10 | iOS email mới bị chặn, chứng minh không tạo | BR4, AC5 | UC-03 | Negative | A |
| SC-11 | Hạn mức thấp, Pro khóa, popup, nâng qua ChatGoni | BR5, AC7 | UC-04 | Positive | A |
| SC-12 | Không mật khẩu → đặt qua Quên mật khẩu → mật khẩu + Google cùng dùng; đăng xuất thiết bị khác | BR6, AC9 | UC-05 | Positive, security | A |
| SC-13 | Thông tin tài khoản và thêm SĐT | BR7, AC8 | UC-04 | Positive / Negative | A |
| SC-14 | Đăng ký Google từ IP ngoài VN / không xác định IP | BR8, AC3 | UC-01 | Positive, edge | A |
| SC-15 | Hủy ở màn chọn tài khoản theo nơi bấm và nền tảng | AC6 | UC-01, UC-02 | Negative, recovery | A |
| SC-16 | Mất mạng ba thời điểm, chặn Google | AC10 | UC-01, UC-02 | Exception, recovery | A |
| SC-17 | Dữ liệu tài khoản đã có sau Google; loại tài khoản SĐT + email; lời mời cũ | BR2 | UC-02 | Data integrity | B |
| SC-18 | Hai lớp API (đăng nhập lặp, iOS email mới, đổi email) | BR2, BR4, BR7 | UC-02, UC-03, UC-04 | Security, integration | B |
| SC-19 | Biên họ tên, loại email Google, nội dung màn thành công | BR1, BR3 | UC-01 | Edge case | B |
| SC-20 | Lỗi Google mở rộng (không tài khoản Google, chặn popup, sai client ID, mất mạng với email mới) | AC10 | UC-01 | Exception | B |
| SC-21 | Hiển thị phụ: dữ liệu sau Hủy, thông báo iOS, Lưu đăng nhập, nút ngoài VN, tab còn lại | AC2, AC5, AC6, BR8 | UC-01, UC-03 | UI | B |
| SC-22 | Tạm khóa vs Google; Thông tin tài khoản form cũ | AC8, AC9 | UC-02, UC-05 | Security, UI | B |

Ánh xạ SC → case: SC-01 [US9_01]→[US9_03] · SC-02 [US9_04], [US9_05] · SC-03 [US9_06], [US9_07] · SC-04 [US9_08]→[US9_14] ·
SC-05 [US9_15], [US9_26] · SC-06 [US9_16], [US9_17] · SC-07 [US9_18]→[US9_20] · SC-08 [US9_21], [US9_22] · SC-09 [US9_23] ·
SC-10 [US9_24], [US9_25] · SC-11 [US9_27]→[US9_32] · SC-12 [US9_33]→[US9_36] · SC-13 [US9_37]→[US9_40] · SC-14 [US9_41], [US9_42] ·
SC-15 [US9_43]→[US9_46] · SC-16 [US9_47]→[US9_50] · SC-17 [US9_51]→[US9_53] · SC-18 [US9_54], [US9_55], [US9_71] ·
SC-19 [US9_56]→[US9_60] · SC-20 [US9_61]→[US9_64] · SC-21 [US9_65], [US9_66], [US9_67], [US9_68], [US9_72] · SC-22 [US9_69], [US9_70].

## 8. Testcase Summary

| Nhóm | Số case | Positive | Negative | Edge case | Khác | Có `❓ Cần chốt` |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| A. Theo requirement | 50 | 28 | 13 | 5 | 4 (UI 3, Security 1) | 5 (+4 chỉ ở ô Data — US4 Q-26) |
| B. QA bổ sung | 22 | 0 | 0 | 11 | 11 (UI 7, Security 4) | 16 |

Chi tiết case: `04-testcases.md`.

## 9. Regression Scope

| Khu vực | Vì sao bị ảnh hưởng | Căn cứ | Giới hạn phân tích |
| --- | --- | --- | --- |
| Đăng nhập Google hiện hữu (cả 3 nền tảng) | Mobile chuyển từ webview sso.gopany.com sang màn riêng trong app; luồng Google thêm quy tắc gộp email | `US3:59`, `EPIC:144`, `EPIC:194`, `BUG10:17` | Không có dữ liệu số người dùng Google cũ / dữ liệu cũ |
| Màn 01 đăng nhập email/SĐT + mật khẩu (US3) | Dùng chung màn 01 với nút Google; thông báo sai thông tin đăng nhập | `US3:51-56`, `TB:19` | Chỉ chạm thông báo ([US9_33]); chi tiết thuộc US3 |
| Quên mật khẩu (US4) | AC9 đi qua luồng US4 với email Google; đăng xuất mọi thiết bị | `US4:50-52`, US4-AS Q-05, Q-26 | Quy định mật khẩu đang chờ US4 Q-26 |
| Thông tin tài khoản (US5) | Dòng Email gắn Google, thêm SĐT phải có mật khẩu (Q-04 b) | `US5:52`, `US5:56`, `US5:66-70` | Hình thức Q-04b chưa có |
| ChatGoni hạn mức (US7) | Tài khoản Google = chưa xác thực SĐT | `US7:50`, `US7:54`, `US7:61-75` | Con số chỉnh được trong Admin (US8) — chưa đủ dữ liệu để loại trừ ảnh hưởng khi Admin đổi số |
| Màn đăng ký 05a / 11 (US1, US6) | Có nút "Tiếp tục với Google"; ngoài IP VN chỉ còn Email | `US1:32`, `US1:57`, `US6:33` | Nút ngoài VN Q-15 |
| iOS không có đường vào đăng ký (BUG10, US6 AC2) | Luồng Google trên iOS không được tạo tài khoản | `BUG10:28`, `US9:48` | Dùng chung bộ case BUG10 / US6 02 §4 d.8, không lặp |
| Lời mời workspace | Email được mời chưa đăng ký đi luồng tạo mới, lời mời "xử lý riêng" | Q-02 (c) | Chưa đủ dữ liệu để loại trừ ảnh hưởng tới luồng mời ([US9_53] ĐO & GHI) |

Các khu vực khác (Admin US8, OTP US2): chưa đủ dữ liệu để loại trừ; luồng Google không dùng OTP (`US9:45`) nên US2 chỉ chạm qua AC9 / US4.

## 10. Automation Candidate

| Case | Lý do phù hợp | Dependency · data · môi trường | Trạng thái |
| --- | --- | --- | --- |
| [US9_01], [US9_03] (phần Web) | Kiểm hiển thị nút, chạy mỗi bản, kết quả rõ | Playwright; web môi trường test | Candidate |
| [US9_08], [US9_09], [US9_11] (Web) | Regression đăng nhập Google, giá trị cao | Tài khoản Google test được phép tự động hóa (Google có thể chặn đăng nhập tự động); dev hỗ trợ truy vấn DB | Candidate |
| [US9_28], [US9_29] | Hạn mức % và popup kiểm được qua UI / API | Admin để mặc định 3 câu/5 giờ; tài khoản Google mới mỗi lần chạy | Candidate |
| [US9_37], [US9_38] | Thông tin tài khoản ổn định, kiểm nhãn | Tài khoản TK-G cố định | Candidate |
| [US9_46], [US9_49] | Hủy / mất mạng trên web dựng được bằng route abort | Playwright `route.abort` cho API đăng nhập | Candidate |
| [US9_54], [US9_55], [US9_71] | Kiểm hai lớp ở mức API, lặp được | Cần endpoint + token (Q-13) | Candidate — chờ Q-13 |

Không có script; không case nào ở trạng thái `Automated`.

## 11. Điểm cần quay lại Debate

| # | Nội dung + nguồn | Đề xuất mức | Case bị ảnh hưởng |
| ---: | --- | --- | --- |
| 1 | Nguyên văn thông báo sai thông tin đăng nhập lệch giữa hai nguồn: `TB:19` (màn 01, "Sai email/SĐT hoặc mật khẩu") "Tài khoản hoặc mật khẩu không chính xác. Vui lòng thử lại." ≠ `US3:56` "Email/số điện thoại hoặc mật khẩu không đúng" (02 §4 d.8 đang dùng câu US3). `TB` xuất hiện 2026-10-16 17:12, chưa có trong file 01 §1. Designer không chọn: [US9_33] giữ expected "đăng nhập thất bại", nguyên văn ĐO & GHI kèm cả hai câu (chỉ đạo Orchestrator) | Không trọng yếu với US9 (chỉ câu chữ; chủ thể là US3) | [US9_33] |
| 2 | `TB:43` "Dùng chung · Các màn liên quan · Đã xảy ra lỗi. Vui lòng kiểm tra và thử lại." — có phải thông báo AC10 (`US9:71`) không; `TB` không có dòng nào cho US9 (không có AC5, AC10, Google) | Không trọng yếu — nối Q-09 | [US9_47]→[US9_50] (ĐO & GHI ở Note), [US9_63] |
| 3 | Đoạn "Tái dùng từ US4" ở 02 mục 3 ghi quy định mật khẩu "8–16 ký tự, ≥1 chữ và ≥1 số (US4 Q-01)" — đã bị thay: US4 Q-26 (b) và `TB:24`, `TB:41` "8–16 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt". Ô Data mật khẩu ở US9 đánh `❓ Cần chốt: US4 Q-26` | Không trọng yếu với US9 (chỉ dữ liệu; trọng yếu ở US4) — cần sửa đoạn tái dùng của 02 | [US9_34], [US9_35], [US9_36], [US9_39], [US9_40], [US9_69] |
| 4 | Q-03 (a) "mobile dùng màn chọn tài khoản Google của hệ điều hành, không mở trang web" (`US9:17`, 02 §4 d.22) áp cho **iOS**: iOS không có màn chọn tài khoản Google cấp hệ điều hành như Android; thư viện Google Sign-In trên iOS thường hiện phiên xác thực web của hệ thống (hộp hỏi cho phép dùng "google.com" để đăng nhập, rồi trang Google bên trong). Đây là nhận định kỹ thuật `[QA BỔ SUNG]`, chưa kiểm trên bản build. Nếu đúng, [US9_05] sẽ Fail theo chữ "không mở trang web" — cần BA/FE Hoàng xác nhận "không mở trang web" trên iOS nghĩa là gì | **Trọng yếu cho phần hình thức iOS** (đổi pass/fail [US9_05]); không chặn case khác | [US9_05], bước thao tác [US9_45], [US9_48] |
| 5 | 02 §4 d.16 tự mâu thuẫn: cùng ô ghi "Figma 2026-10-16 … nút có ở cả tab SĐT lẫn tab Email" và "AC2 … có ở cả hai tab hay không, tài liệu không nói → ĐO & GHI". Designer theo ĐO & GHI | Không trọng yếu | [US9_72] |
| 6 | 02 §4 d.2 loại (4) — tài khoản đăng ký SĐT rồi thêm email (`US5:57`) — nhãn `[DIỄN GIẢI AI]` dù Hồng đồng ý; E-01 (`EPIC:96` "Mỗi SĐT và mỗi email chỉ gắn với một tài khoản") có thể là căn cứ `[NGUỒN]`. Designer để ở nhóm B | Không trọng yếu — hỏi Hồng có nâng nhãn để chuyển sang nhóm A không | [US9_52] |
| 7 | `TB:22` (US4 màn 02, "Email hoặc số điện thoại không tồn tại" → "Email hoặc số điện thoại không đúng") trái `US4:48` BR2 "Thông báo … luôn giống nhau dù SĐT/email có tồn tại hay không" | Không trọng yếu với US9 (email Google luôn tồn tại trong AC9) — chuyển US4 | Không có case US9 |

Ghi nhận từ CX (đã có ở `05-cx-review.md`, không phải điểm mới của Designer): chữ "gắn Google" ở AC8 (`US9:68`) là chữ hiển thị hay chú
thích của BA — [US9_37] ghi ĐO & GHI phần chữ "Google", giữ "Đã xác thực" và không nút Đổi làm expected.

## Lịch sử cập nhật

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
| 2026-10-16 | AI (qa-test-designer) — người dùng Hồng | Tạo file S6 + mục S8: 5 UC, 8 BR, DT-1 (7 luật), DT-2 (3 luật), state 6 dòng, 10 rủi ro, Coverage Matrix BR1–BR8 / AC1–AC10, SC-01→SC-22, regression 8 khu vực, 6 nhóm automation candidate, 7 điểm quay lại Debate; case [US9_01]→[US9_72] ở `04-testcases.md`. Áp bổ sung Orchestrator cùng ngày (`TB:19`, `TB:43`, US4 Q-26, CX "gắn Google") |
