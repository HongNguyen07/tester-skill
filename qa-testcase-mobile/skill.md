---
name: "qa-testcase-mobile"
description: "Viết testcase hoặc checklist cho app mobile Gopany theo template QA chuẩn (cột, ID, Steps/Expected theo bước, edge case, MOBILE_CHUNG)."
---

# QA Testcase & Checklist – Mobile Gopany

Dùng khi người dùng nhờ viết testcase / checklist cho một màn hình, chức năng, ticket hoặc tài liệu design của app Gopany (iOS/Android, có thể cả Web). Viết bằng tiếng Việt.

File Excel mẫu: https://docs.google.com/spreadsheets/d/1Ds2ZLa625wfctgooSmfzbN9Zyq5Fdj5eNDkXV63Jwyo/edit?gid=1253039788 (có dropdown, công thức đếm, sheet MAU_TRONG, MAU_CHECKLIST, MOBILE_CHUNG, CAN_LAM_RO_PO, LOG_BUG).

## 0. Chọn Testcase hay Checklist

- **Testcase đầy đủ**: luồng nhiều bước, cần dữ liệu cụ thể, nghiệp vụ phức tạp (duyệt, đồng bộ, tính toán), tính năng mới/rủi ro cao, cần người khác chạy lại y hệt.
- **Checklist**: chức năng đơn giản, test nhanh nhiều điểm (phân quyền, hiển thị trường, validate), regression/smoke, người test đã quen hệ thống.
- Người dùng không nói rõ → mặc định Testcase; nếu đầu vào ngắn/đơn giản thì hỏi 1 câu hoặc ghi rõ lựa chọn.

## 1. Cấu trúc sheet

- Mỗi sheet = 1 module/màn hình. Tên sheet VIẾT_HOA_GẠCH_DƯỚI (vd `ZALO_TIN_NHAN_MAU`).
- **Khối thông tin đầu sheet**:
  - Tên màn hình/Tên chức năng
  - Thiết bị, hệ điều hành: đủ model – OS – phiên bản app (vd `iPhone 13 – iOS 26 – App v2.3.1`; `Samsung A54 – Android 15 – App v2.3.1`). Chưa biết → để `iPhone __ – iOS __ – App v__`.
  - Mã trường hợp kiểm thử (vd `MH1`, `BV`, `MB`).
- **Bảng Manual test** (đạt P / không đạt F / đang xem xét NA / chưa thực hiện / tổng): tự đếm bằng công thức, KHÔNG gõ tay. Kết quả 1 case = Round (hoặc cột Day) mới nhất khác Todo/trống.
- **Group row**: hàng tiêu đề nhóm, vd `1. Đăng nhập bằng tài khoản` hoặc mã ticket `GC-18`. Checklist có 2 cấp: cấp 1 = chức năng lớn ("Tạo bài viết"), cấp 2 = nhóm con đánh số ("1. Quyền tạo bài viết").
- Các case chung mobile (thiết bị/OS/màn hình, cấp quyền, mạng, push, nền/foreground, cài đặt & nâng cấp) đã có ở sheet **MOBILE_CHUNG** → KHÔNG viết lại trong từng module, chỉ viết phần riêng của module (trừ khi module có hành vi đặc thù với quyền/mạng/push).

## 2. Bảng Testcase – cột và quy tắc

Cột theo đúng thứ tự:

| Test Case ID | Purpose | Category | Precondition | Steps | Data | Expected Result | Result – Round 1 | Result – Round 2 | Result – Round 3 | Error Code | Note | Date | Tester |

- **Test Case ID**: `[MÃ_nn]` – 2 chữ số, đánh số liên tục cả sheet, KHÔNG reset theo nhóm. Vd `[MH1_01]`, `[MH1_02]`.
- **Purpose**: 1 câu ngắn nêu mục tiêu. Vd "Sai mật khẩu → hiện thông báo lỗi". Tránh "Kiểm tra…" chung chung.
- **Category**: chỉ `UI` hoặc `Function`.
  - UI = hiển thị, bố cục, màu, chữ, kích thước màn hình (không cần thao tác nghiệp vụ).
  - Function = mọi kiểm tra chức năng/nghiệp vụ: luồng đúng, nhập sai, phân quyền, mạng, push, edge case…
- **Precondition**: trạng thái hệ thống, quyền, dữ liệu có sẵn. Không có → `-`. Câu chuẩn hay dùng: "Đã cài đặt và đăng nhập thành công Gopany, thiết bị có kết nối mạng".
- **Steps**: đánh số `1. 2. 3.`, MỖI BƯỚC 1 DÒNG (xuống dòng trong ô), bắt đầu bằng động từ (Bấm, Nhập, Chọn, Vào, Quan sát…). Gọi đúng tên nút/menu trên UI, tên nút để trong ngoặc kép. Điều hướng nhiều màn dùng `>>` (vd `Vào menu "Bài viết" >> bấm "Tạo bài viết"`).
- **Data**: dữ liệu cụ thể (email, SĐT, chuỗi, thiết bị, URL…). Không có → `-`.
- **Expected Result**: ghi THEO TỪNG BƯỚC, mỗi dòng bắt đầu bằng số của bước tương ứng trong Steps – tới bước đó phải thấy gì. Bước trung gian không có gì kiểm tra thì bỏ qua số đó.
  - Vd Steps `1. Vào tính năng cần quyền / 2. Bấm "Không cho phép" / 3. Dùng lại tính năng` → Expected `2. Popup đóng, app không crash / 3. Hiện thông báo cần cấp quyền kèm nút "Mở Cài đặt"`.
  - Thông báo, nhãn chép NGUYÊN VĂN trong ngoặc kép.
  - CẤM viết "hoạt động bình thường", "hiển thị đúng" mà không nói đúng là gì.
- **Result – Round 1/2/3**: `Todo | Pass | Fail | NA`, mặc định `Todo`. Retest ghi vào Round tiếp theo, không sửa Round cũ.
- **Error Code**: khi Fail, điền mã bug trên Gopany (vd `#257_1234`).
- **Note**: mức ưu tiên `Ưu tiên P1/P2/P3`; `Cần PO chốt: Qn` nếu kỳ vọng chưa rõ (câu hỏi ghi ở sheet CAN_LAM_RO_PO). Có thể nhiều dòng.
- **Date / Tester**: để trống khi viết, điền khi chạy.

Ưu tiên: P1 = luồng chính, phân quyền, mất dữ liệu, crash; P2 = validate, edge case quan trọng, mạng/gián đoạn; P3 = hiển thị phụ, dark mode, xoay màn, badge.

## 3. Bảng Checklist – cột và quy tắc

| Test Case ID | Purpose | Expected Result | Status – Day dd/mm | Status – Day dd/mm | Status – Day dd/mm | Error Code | Note | Tester |

- Không có Precondition / Steps / Data → Purpose và Expected phải đủ rõ để người khác tự biết làm gì và thế nào là đúng.
- **ID**: `[MÃ_nn]`, liên tục cả sheet.
- **Purpose**: ĐỐI TƯỢNG + HÀNH ĐỘNG + ĐIỀU KIỆN. Vd "Role Nhân viên: được tạo bài viết".
- **Expected**: kiểm chứng được – UI + dữ liệu + thông báo nguyên văn. Liệt kê trường thì kèm giá trị/quy tắc đúng của từng trường (lấy từ đâu, định dạng, khi nào để trống). Có thể dùng gạch đầu dòng `- ` trong ô.
- **Status – Day dd/mm** (3 cột = 3 lần test): ghi ngày vào tiêu đề, chọn Pass/Fail/NA; trống = chưa test. Retest sang cột mới, chỉ test lại case Fail/NA và phần liên quan dev vừa sửa.
- **Note**: P1/P2/P3, "Edge case", "Cần PO chốt: …". NA phải ghi lý do.
- Mỗi dòng chỉ kiểm tra 1 ý. KHÔNG gộp nhiều trường vào 1 dòng (Fail 1 trường là Fail cả case) → tách theo nhóm trường.

## 4. Quy trình viết

1. Đọc tài liệu/design: liệt kê màn hình, các role, nút, trường (nhập / tự generate), điều kiện khoá nút, trạng thái, thông báo, quy tắc nghiệp vụ.
2. Chia nhóm theo chức năng / bước luồng → mỗi nhóm 1 group row (thứ tự gợi ý: Phân quyền → Màn hình/UI → Validate → Lưu/Gửi → Trạng thái → Edge case).
3. Viết theo thứ tự: luồng đúng (positive) → nhập sai/bị chặn (negative) → edge case (rà mục 5 và 6).
4. Điểm chưa rõ → liệt kê câu hỏi `Q1, Q2…` ở cuối (bảng CAN_LAM_RO_PO), gắn mã vào Note. Không tự bịa quy tắc nghiệp vụ; nếu cần giá trị chưa biết dùng placeholder (vd `N ký tự`, `<URL màn tạo bài viết>`).
5. Nhắc người dùng nhờ lead review trước khi chạy Round 1.

## 5. Checklist edge case chung

- **Thời gian**: hết hạn, sát hạn, timeout, bấm nhiều lần, double-click (chỉ 1 request, không tạo trùng).
- **Đồng thời**: 2 tab / 2 thiết bị / 2 người cùng thao tác 1 bản ghi; sửa khi bản ghi đang được duyệt.
- **Gián đoạn**: F5/đóng app, mất mạng/đổi mạng, app xuống nền, cuộc gọi đến, khoá màn hình, đăng xuất, phiên hết hạn, bị thu quyền giữa chừng.
- **Chặn UI nhưng gọi API**: nút ẩn/disable nhưng truy cập thẳng URL/deeplink/API (Postman) vẫn phải bị chặn; trường tự generate gửi giá trị khác lên API phải bị bỏ qua/báo lỗi.
- **Dữ liệu biên**: rỗng/0, khoảng trắng, rất lớn, chuỗi dài (N, N+1), ký tự đặc biệt, emoji, XSS (`<script>alert(1)</script>`), không dấu, SĐT nhiều định dạng.
- **Lặp lại**: gửi lại có nhân đôi? dữ liệu bị sửa/xoá giữa 2 lần?
- **Phân quyền**: mỗi role × mỗi hành động (xem/tạo/sửa/xoá/duyệt); cô lập dữ liệu giữa phòng ban/công ty/tenant; bản ghi chuyển chủ sở hữu.
- **Trạng thái**: hành động nào được phép ở từng trạng thái (Nháp / Chờ duyệt / Đã duyệt / Từ chối).
- **Filter / danh sách / URL**: tham số sai, trang vượt quá, lọc chồng nhau, phân trang, số đếm khớp danh sách.
- **Hiệu năng**: dữ liệu lớn, nhiều tác vụ song song.

## 6. Bộ MOBILE_CHUNG (mã MB – đã có sẵn, chỉ tham chiếu)

Chạy trên ít nhất 1 máy iOS + 1 máy Android mỗi bản build. Khi người dùng yêu cầu bộ chung mobile thì viết đủ các nhóm sau (MB_01 → MB_32):

1. **Thiết bị, OS, màn hình**: iOS mới nhất / thấp nhất hỗ trợ; Android mới nhất / thấp nhất hỗ trợ (cài, đăng nhập, vào các màn chính, không crash/màn trắng); màn nhỏ (iPhone SE 4.7", Android ≤5.5": không vỡ layout, cuộn hết, bàn phím không che ô nhập/nút Lưu); tablet (co giãn, ảnh không méo); tai thỏ/Dynamic Island/điều hướng cử chỉ không che nội dung; xoay ngang (giữ dữ liệu đang nhập); cỡ chữ lớn nhất + Dark mode.
2. **Cấp quyền** (Camera, Ảnh, Vị trí, Thông báo, Micro, Danh bạ): không xin quyền khi vừa mở app, chỉ xin khi dùng tính năng; nội dung popup đúng mục đích; từ chối → app không crash, hiện nút "Mở Cài đặt"; Android từ chối vĩnh viễn → mở đúng trang Cài đặt của app; thu hồi quyền khi app chạy nền; iOS quyền Ảnh Limited.
3. **Mạng yếu / Offline**: mở app không mạng (thông báo + nút thử lại); mất mạng khi gửi/lưu (giữ dữ liệu, bật lại gửi không trùng); mạng chậm 3G (loading, timeout, không treo, bấm 2 lần chỉ 1 request); đổi Wifi ↔ 4G (không crash, không bị đăng xuất); có mạng lại → tự làm mới, kéo để làm mới.
4. **Push notification**: nhận ở foreground/background/killed với nội dung đúng; bấm push mở đúng màn chi tiết; bấm push khi đã đăng xuất → Đăng nhập rồi chuyển đúng màn; tắt quyền thông báo → không nhận; badge icon đúng số chưa đọc.
5. **Background / foreground**: xuống nền ngắn → giữ màn và dữ liệu; nền lâu (>30 phút) → giữ/làm mới hoặc về Đăng nhập nếu hết phiên, không crash; cuộc gọi đến/khoá màn hình; hệ thống kill app khi chạy nền.
6. **Cài đặt & nâng cấp**: cài mới (màn đầu đúng thiết kế); nâng cấp từ bản cũ (giữ đăng nhập, dữ liệu, cài đặt); force update (popup không đóng được, mở đúng store); gỡ và cài lại.

Một module chỉ cần thêm case mobile riêng khi có hành vi đặc thù (vd module Chụp ảnh với quyền Camera, form dài với bàn phím).

## 7. Ví dụ chuẩn

Testcase:

| Test Case ID | Purpose | Category | Precondition | Steps | Data | Expected Result | Result – Round 1 | Result – Round 2 | Result – Round 3 | Error Code | Note | Date | Tester |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| [MH1_02] | Sai mật khẩu → hiện thông báo lỗi | Function | Tài khoản đã được kích hoạt | 1. Nhập Email đúng<br>2. Nhập Mật khẩu sai<br>3. Bấm "Đăng nhập" | Email: tester01@gopany.vn<br>Mật khẩu: Sai@123 | 3. Vẫn ở màn Đăng nhập; hiện "Email hoặc mật khẩu không đúng"; ô Mật khẩu được xoá trắng | Todo | Todo | Todo | | Ưu tiên P1 | | |
| [MB_16] | Mất mạng khi đang gửi / lưu dữ liệu | Function | Đã cài đặt và đăng nhập thành công Gopany, thiết bị có kết nối mạng | 1. Vào màn tạo mới, nhập đủ dữ liệu<br>2. Tắt mạng<br>3. Bấm "Lưu"<br>4. Bật lại mạng, bấm lại | Dữ liệu hợp lệ của màn đang test | 3. Báo lỗi không có kết nối; dữ liệu đã nhập vẫn còn<br>4. Gửi thành công; danh sách chỉ có 1 bản ghi (không trùng) | Todo | Todo | Todo | | Ưu tiên P1 | | |

Checklist:

| Test Case ID | Purpose | Expected Result | Status – Day dd/mm | Status – Day dd/mm | Status – Day dd/mm | Error Code | Note | Tester |
|---|---|---|---|---|---|---|---|---|
| [BV_01] | Role Quản lý: không có quyền tạo bài viết | - Không hiển thị nút "Tạo bài viết"<br>- Truy cập thẳng URL tạo bài viết → báo "Bạn không có quyền truy cập" | | | | | Ưu tiên P1 | |

## 8. Định dạng đầu ra

- Mặc định trả về bảng markdown theo đúng cột ở trên, chia theo group row (`#### 1. Tên nhóm`), kèm khối thông tin đầu sheet; trong ô dùng `<br>` để xuống dòng.
- Nếu người dùng muốn file Excel/Google Sheets: giữ đúng cấu trúc template (khối thông tin B3:C5, bảng Manual test B8:C12 dùng công thức COUNTIF, dropdown Category/Round, xuống dòng trong ô), mỗi module 1 sheet.
- Cuối kết quả: liệt kê câu hỏi cần PO chốt (Q1, Q2…) nếu có, và nhắc nhờ lead review.

## 9. Lỗi hay gặp – tự rà trước khi trả

- Expected không đánh số theo bước, hoặc có "hoạt động bình thường".
- Thông báo không để nguyên văn trong ngoặc kép.
- 1 dòng gộp nhiều kiểm tra.
- Expected chỉ liệt kê tên trường, không nêu giá trị/quy tắc.
- Chỉ test UI, quên chặn URL/API.
- ID reset theo nhóm hoặc không đủ 2 chữ số.
- Viết lại case đã có trong MOBILE_CHUNG.
- Thiếu model – OS – phiên bản app.