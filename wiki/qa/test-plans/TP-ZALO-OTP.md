---
id: TP-ZALO-OTP
feature: ZALO-OTP (chưa có FEAT spine — nguồn = raw spec)
createdBy: QA
createdAt: 2026-09-28
status: Draft
---

# TP-ZALO-OTP: Test Plan — Verify số điện thoại qua Zalo OTP

> **Nguồn AC/US:** project CHƯA có `wiki/features/FEAT-*.md` cho tính năng này. AC-source =
> RAW SPEC `wiki/document/srs/ZALO-OTP.md` (API Documentation), cụ thể:
> Section 2 (luồng gửi OTP, S2-01…S2-18) · Section 3 (luồng verify OTP, S3-01…S3-10) ·
> Section 4 (cấu hình `zalo_setting` + bậc khóa) · Section 5 (Admin UI `/admin/system-settings/{id}`) ·
> Section 6 (cơ chế cache) · Section 7 (refresh token) · Section 8 (bảng mã lỗi — CONTRACT chuẩn).
> Mã lỗi dùng nguyên `errorCode` 30014–30028 + `rule` của spec. **KHÔNG** tự chế `ERR-<NNN>-xx`
> (anti-hallucination rule 3 — giống nguyên tắc đã áp cho Z-02).
>
> **Vì chưa có FEAT:** bỏ qua bước verify claim `owners.qa` và không tick checklist FEAT mục 4.4
> (không có FEAT để tick). Khi BA/orchestrator tạo FEAT-XXX cho tính năng này sau, cần backfill
> `feature:` trong frontmatter file này và tick lại checklist tương ứng.
>
> Test-DESIGN (plan + case) là shift-left, có thể bắt đầu ngay trên raw spec, không chờ FEAT.

## 1. Scope

- **In scope (QA black-box):** acceptance, system, e2e, regression, exploratory, perf-smoke,
  a11y (chỉ phạm vi Admin config screen — xem ghi chú ở mục 2).
- **Out of scope (dev sở hữu):** unit / integration / contract (BE/FE tự lo — vd unit test cho
  hàm chuẩn hóa số điện thoại, integration test cache Redis, contract test request/response
  schema của 2 endpoint).
- **Feature:** ZALO-OTP — Xác thực số điện thoại của account (`user_providers`) qua OTP 6 số gửi
  bằng Zalo ZNS: luồng gửi OTP (đổi số / resend), luồng verify OTP, cấu hình `zalo_setting`
  (cooldown, TTL, bậc khóa đổi số/resend/verify), cache OTP/đếm số lần/khóa, refresh token Zalo
  tự động, và màn Admin quản trị cấu hình.

## 2. Test types áp dụng

| Type | Có? | Ghi chú |
| --- | --- | --- |
| Acceptance (theo AC) | ✅ | Mỗi bước S2-01…S2-18, S3-01…S3-10, mỗi hàng bảng mã lỗi §8 ≥ 1 test case (qa-test-case-writer). |
| System / E2E | ✅ | E2E gửi OTP → verify OTP end-to-end (với `send_message_enabled=false` để lấy `otp` từ response, tránh gọi Zalo thật); `cross-service-e2e` khi test path gọi Zalo thật (`send_message_enabled=true`) — cần mock/stub hoặc số điện thoại test thật đã đăng ký Zalo. |
| Regression | ✅ | `regression-scope`: đảm bảo thay đổi cooldown/lock-steps/refresh-token không phá vỡ luồng gửi/verify đã ổn định; regression trên bảng mã lỗi §8 mỗi khi cấu hình `zalo_setting` đổi. |
| Exploratory | ✅ | `testDepth=deep`: dò brute-force nhiều bậc khóa liên tiếp, race-condition giữa 2 request gửi OTP đồng thời cùng `uuid`, hành vi khi cache Redis bị xoá tay giữa chừng, hành vi khi `system_settings.zalo_setting` bị sửa giữa lúc đang có OTP pending. |
| Accessibility (a11y) | ✅ (giới hạn) | **CHỈ** áp cho màn Admin `/admin/system-settings/{id}` (Section 5: JSON editor, toggle, danh sách IP, cấu hình bậc khóa). Form nhập phone/OTP phía end-user **chưa có FE spec** → out-of-scope-pending-spec, KHÔNG bịa case a11y cho form này (xem Gap #4 ở mục 5). |
| Perf-smoke | ✅ | Thời gian phản hồi API gửi/verify OTP dưới tải nhẹ; thời gian set/đọc cache; KHÔNG thay thế cho perf test chuyên sâu (load/stress). |

## 3. Môi trường + dữ liệu

- **Env:** local / staging / uat (theo `projectConfig.qa.environments`). Env chạy chính = **staging**
  (lane `high-risk`, cần môi trường gần production nhất có Redis + `system_settings` thật, nhưng
  vẫn kiểm soát được `send_message_enabled` để không spam Zalo thật). Local dùng cho exploratory
  nhanh; uat dùng cho smoke trước go-live.
- **Test data:**
  - **`zalo_setting` (`system_settings.key = zalo_setting`):** BẮT BUỘC set `send_message_enabled = false`
    trên env test chính để response trả kèm `otp`, tránh gọi Zalo thật cho phần lớn case. Chỉ bật
    `true` có chủ đích cho case cross-service-e2e (gửi Zalo thật) và case lỗi `-118`/`30015`.
  - **Số điện thoại test:** cần **ít nhất 1 số điện thoại thật đã đăng ký Zalo** để test path
    `send_message_enabled = true` thành công, và **1 số chưa từng đăng ký Zalo** (hoặc số không
    tồn tại) để tái hiện lỗi Zalo `error = -118` → `errorCode 30015`. Không thể giả lập lỗi -118
    bằng số bịa khi `send_message_enabled = false` (không gọi Zalo thật) — case này bắt buộc
    `send_message_enabled = true`.
  - **Account test:** ≥3 record trong `user_providers` (1 account chưa verify, 1 account đã
    `is_verify_phone = true`, 1 account dùng để test đổi số điện thoại) với `provider_id` map
    sẵn `uuid` test.
  - **Cấu hình bậc khóa nhỏ để test nhanh:** chỉnh `cooldown`, `ttl_minutes`,
    `phone_change_lock_steps`, `resend_lock_steps`, `verify_lock_steps` xuống giá trị nhỏ (vd
    `attempts: 2/3/4`, `lock_minutes: 1`) trên env test để không phải chờ thật; test riêng 1 lần
    với giá trị cấu hình mặc định (bảng ví dụ §4 spec: 5/10/20, 1/10/60 phút) để xác nhận đúng
    bậc thang production.
  - **Reset cache giữa các case:** cache key theo **hash của `uuid`** (`zalo_phone_otp`,
    `zalo_phone_otp_cooldown`, `zalo_phone_change_attempts`, `zalo_phone_change_lock`) và theo
    **hash của cặp `uuid + phone`** (`zalo_phone_otp_resend_attempts`, `zalo_phone_otp_resend_lock`,
    `zalo_phone_otp_verify_attempts`, `zalo_phone_otp_verify_lock`). Trước mỗi case liên quan
    cooldown/lock, xóa đúng key tương ứng (theo `uuid` hoặc `uuid+phone`) — **không** flush toàn
    bộ cache Redis (tránh ảnh hưởng case khác đang chạy song song).
  - **Chiến lược tránh đụng counter giữa các case:** **mỗi test case dùng 1 `uuid` riêng** (không
    tái sử dụng `uuid` giữa case đếm bậc khóa và case khác) để tránh cộng dồn nhầm bộ đếm
    đổi số/resend/verify của case trước. Với case cố tình test bậc khóa (chạm 5/10/20 lần), dùng
    `uuid` dành riêng, không chia sẻ với case happy-path khác.
  - **Không có multi-tenant** trong spec này (khác Z-02) — không cần chiến lược cô lập tenant.
- **Automation:** định hướng tương lai theo `projectConfig.qa.automation` — REST-assured/Karate
  cho 2 API BE (`send-zalo-otp`, `verify-zalo-otp`), Playwright cho E2E web (form phone/OTP khi
  có FE spec) + a11y Admin config screen (axe). **Vòng này (Phase 2) là manual design-only** —
  user đã xác nhận CHƯA chạy Phase 4 (qa-automation-builder). `reportEvidence: true` vẫn áp dụng
  khi execute thủ công (screenshot/log/HAR làm evidence).

## 4. Entry / Exit criteria

- **Entry (execution):** không có `deps.qa` chuẩn (không có FEAT/`be.done`/`fe.done` để tham
  chiếu vì chưa có FEAT spine). Entry thực tế thay thế:
  1. Môi trường test có record `zalo_setting` với `send_message_enabled = false` để lấy `otp`
     trong response mà không gọi/spam Zalo thật.
  2. Có sẵn account test trong `user_providers` (map `uuid` ↔ `provider_id`) ở đủ trạng thái
     cần (chưa verify / đã verify / đang có số cũ để test đổi số).
  3. Có quyền sửa `system_settings.zalo_setting` để set `cooldown`, `ttl_minutes`,
     `phone_change_lock_steps`, `resend_lock_steps`, `verify_lock_steps` xuống giá trị nhỏ phục
     vụ test bậc khóa trong thời gian hợp lý.
  4. 2 endpoint (`POST /api/v1/auth/phone/send-zalo-otp`, `POST /api/v1/auth/phone/verify-zalo-otp`)
     đã deploy và truy cập được trên env test.
- **Exit (sign-off)** — theo `projectConfig.qa.exitCriteria`:
  - AC coverage = **100%** — mỗi bước nghiệp vụ (S2-01…S2-18, S3-01…S3-10) và mỗi hàng bảng mã
    lỗi §8 (14 mã lỗi, lưu ý `send_otp_failed` dùng chung 2 errorCode 30024/30015) có ≥1 test case.
  - Blocking severity pass = **100%**; open critical defects = **0**. Case liên quan
    brute-force/lock integrity và lỗi `-118`/`30015` coi là **blocking** (chạm hard gate
    `security-test`).
  - Evidence đầy đủ (screenshot/log/HAR) cho mọi case pass — bắt buộc do `reportEvidence: true`.

## 5. Rủi ro / lane

- **Lane:** `high-risk` (từ `intakeResult.lane`).
- **Flags:** `security-test`, `regression-scope`, `cross-service-e2e`, `flaky-risk`.
- **Hard gates chạm:** `security-test`, `cross-service-e2e`.
- **Ảnh hưởng tới test focus:**
  - **`security-test` → brute-force / lock integrity là trọng tâm chính.** Phải test đầy đủ 3
    nhóm bậc khóa (đổi số theo `uuid`, resend theo `uuid+phone`, verify theo `uuid+phone`) ở cả
    3 mốc (5/10/20 theo ví dụ spec), xác nhận: request chạm bậc **vẫn trả OTP** thành công (§4),
    khóa chỉ áp cho **request kế tiếp**, bộ đếm reset sau khi chạm bậc cuối, và `failedAttempts`
    trong response lỗi khóa đúng bằng mốc `attempts` của bậc đang khóa (không phải counter nội
    bộ) — sai một trong các điểm này là lỗ hổng cho phép brute-force OTP.
  - **`cross-service-e2e` → phụ thuộc dịch vụ ngoài (Zalo ZNS).** Cần chiến lược mock/stub Zalo
    API cho phần lớn case (dùng `send_message_enabled=false` lấy `otp` trực tiếp), và tách riêng
    một tập case nhỏ chạy với Zalo thật (`send_message_enabled=true`, số điện thoại thật) để xác
    nhận tích hợp thật hoạt động, bao gồm path lỗi `-118` (số không tồn tại trên Zalo → `30015`)
    và path `send_otp_failed` chung (`30024`) khi Zalo trả lỗi khác.
  - **`regression-scope` → mọi thay đổi cấu hình `zalo_setting` (cooldown, TTL, bậc khóa,
    refresh token) cần regression lại toàn bộ bảng mã lỗi §8 và luồng gửi/verify chính, vì đây
    là cấu hình dùng chung cho toàn hệ thống (đổi 1 config ảnh hưởng mọi account).
  - **`flaky-risk` → timing-sensitive.** Case liên quan cooldown/TTL/lock đếm theo phút/giây dễ
    flaky khi chạy song song hoặc khi CI chậm. Case cần: dùng cấu hình lock-steps/TTL nhỏ (giây
    thay vì phút nếu hệ thống cho phép) trên env test, đo `remainingSeconds`/`remainingMinutes`
    trong response với dung sai hợp lý (không assert cứng giá trị tuyệt đối), và tránh chạy song
    song 2 case dùng chung `uuid`/`phone`.

### Gap spec cần BA/BE trả lời (phát hiện ở intake, không được tự đoán)

| # | Gap | Ảnh hưởng |
| --- | --- | --- |
| 1 | `phone_verify_bypass_ips` áp ở bước nào trong luồng S2 (gửi OTP) hay S3 (verify OTP), hay ở middleware riêng ngoài 2 luồng này? Spec §4 chỉ mô tả field, không nói rõ điểm chèn. | Không viết được case chính xác cho cơ chế bypass theo IP cho tới khi chốt; tạm để out-of-scope-pending-spec. |
| 2 | Section 5 (Admin UI) thiếu validation rule/error message cho JSON editor (Giá trị JSON) — nhập JSON sai cú pháp, thiếu field bắt buộc, sai kiểu dữ liệu thì UI báo gì? | a11y + functional case cho Admin form JSON editor bị chặn (không biết expected error message để viết case Error). |
| 3 | Section 7: hành vi khi scheduler `zalo:refresh-otp-token` refresh token **fail giữa chừng** (vd Zalo API timeout khi đang refresh) — access token cũ có còn dùng được không, có retry không, có alert không? | Không viết được case Error cho refresh-token-failed-mid-scheduler; ảnh hưởng tới continuity của luồng gửi OTP nếu token hết hạn mà refresh thất bại. |
| 4 | Thiếu FE UI spec cho form nhập phone/OTP phía end-user (chỉ có API contract, không có màn hình/wireframe). | a11y cho form end-user KHÔNG đưa vào in-scope (xem mục 2) — chờ FE spec trước khi viết case a11y/UI cho phần này. |
| 5 | S2-05 (kiểm tra số điện thoại đã được account khác dùng chưa): rule so khớp 3 biến thể `0xxxxxxxxx` / `84xxxxxxxxx` / `+84xxxxxxxxx` (nêu ở Section 1) có áp **đủ** ở bước check trùng số (S2-05) không, hay chỉ áp ở bước chuẩn hóa gọi Zalo? Nếu không áp đủ ở S2-05, có thể tạo lỗ hổng bypass check trùng số bằng cách đổi định dạng nhập. | Case kiểm tra trùng số điện thoại (3 biến thể) có nguy cơ viết sai kỳ vọng nếu rule thực tế khác; liên quan tới `security-test`/`data-integrity` — cần BE xác nhận trước khi coi case này là stable (không đánh dấu ❓ tùy tiện, nhưng phải note rõ giả định khi qa-test-case-writer viết case). |

## 6. Liên kết

- Test cases: `wiki/qa/test-cases/ZALO-OTP.md`
- Test runs: `wiki/qa/test-runs/ZALO-OTP_*.md`
- Nguồn nghiệp vụ (raw spec, thay cho FEAT): `wiki/document/srs/ZALO-OTP.md`
- FEAT: **chưa tồn tại** — khi BA/orchestrator tạo `wiki/features/FEAT-<NNN>.md` cho tính năng
  này, cần backfill link tại đây và tick checklist mục 4.4 tương ứng.
