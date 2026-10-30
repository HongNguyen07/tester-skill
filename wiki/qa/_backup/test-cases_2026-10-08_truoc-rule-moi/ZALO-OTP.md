---
feature: ZALO-OTP — Verify số điện thoại qua Zalo OTP (chưa có FEAT spine — nguồn = raw spec)
specVersion: "wiki/document/srs/ZALO-OTP.md (2026-09-23 15:54:10 +07) + tailieu/8-verify-ma-otp.md (2026-10-02 09:36:42 +07, API verify-zalo-otp — ưu tiên hơn nguồn cũ ở phần verify)"
updatedAt: 2026-10-02
plan: TP-ZALO-OTP
createdBy: QA
createdAt: 2026-09-28
lane: high-risk (+ flags: security-test, regression-scope, cross-service-e2e, flaky-risk)
testDepth: deep
---

# Test Cases — ZALO-OTP: Verify số điện thoại qua Zalo OTP

> **Nguồn AC:** project CHƯA có `wiki/features/FEAT-*.md`. AC-source = raw spec
> `wiki/document/srs/ZALO-OTP.md`: Section 2 (S2-01…S2-18 + BR gửi OTP), Section 3 (S3-01…S3-10),
> Section 4 (bậc khóa `phone_change_lock_steps`/`resend_lock_steps`/`verify_lock_steps` + ý nghĩa
> bậc khóa), Section 5 (Admin `/admin/system-settings/{id}`), Section 6 (cơ chế cache),
> Section 7 (refresh token), Section 1 (BR chuẩn hóa số điện thoại). **Mã lỗi dùng NGUYÊN bảng
> Section 8** (`errorCode` 30014–30028 + `rule`) — KHÔNG tự chế `ERR-<NNN>-xx` (anti-hallucination
> rule 3, theo tiền lệ Z-02).
>
> **Nguồn bổ sung (2026-10-02):** `tailieu/8-verify-ma-otp.md` (API verify-zalo-otp) — thêm errorCode `30029`/`11000`, ưu tiên 30029 trước 30014, `failedAttempts` ở 30027, xóa cache resend khi verify OK, so khớp phone sau chuẩn hóa. Khi mâu thuẫn ở phần verify, tài liệu mới thắng nguồn cũ.
>
> **Black-box:** mọi case derive từ hành vi quan sát được qua 2 API + màn Admin. Không suy diễn
> từ code/DB internals ngoài những gì spec nêu (vd tên cache key dùng để mô tả tiền điều kiện/
> evidence, không phải để assert cấu trúc code).

---

## 0. Intake tóm tắt (test-risk)

| Mục | Giá trị |
|---|---|
| **Lane** | `high-risk` — endpoint public không auth, xử lý OTP + bậc khóa bảo vệ tài khoản |
| **Flags** | `security-test` (hard gate — brute-force/lock integrity là trọng tâm), `regression-scope` (đổi `zalo_setting` ảnh hưởng toàn hệ thống), `cross-service-e2e` (phụ thuộc Zalo ZNS), `flaky-risk` (timing cooldown/TTL/lock) |
| **Test types in-scope** | Acceptance (theo S2-xx/S3-xx) · System/E2E · Regression · Exploratory (deep) · a11y (chỉ Admin config screen) · Perf-smoke |
| **Out of scope QA** | Unit (hàm chuẩn hóa phone) / integration (cache Redis) / contract test (BE sở hữu) |
| **Execution gate** | Không có `be.done`/`fe.done` chuẩn (chưa có FEAT). File này là shift-left design trên raw spec — xem Entry criteria ở TP-ZALO-OTP §4. |

## 0.1 Kỹ thuật thiết kế áp dụng

| Kỹ thuật | Áp cho | Case |
|---|---|---|
| **Boundary Value Analysis (BVA)** | Bậc khóa đổi số/resend/verify tại attempts 4/5/6, 9/10/11, 19/20/21 (3 nhóm); OTP TTL quanh `ttl_minutes` (ngay trước/sau hết hạn) | TC-26→35, TC-36→45, TC-46→55, TC-61, TC-62 |
| **Equivalence Partitioning (EP)** | `phone`: `0…`/`84…`/`+84…` hợp lệ, sai định dạng, rỗng, không phải số VN; `uuid`: hợp lệ / sai format / không tồn tại | TC-01→07, TC-08 |
| **Decision Table** | Nhánh S2-06→S2-17: (đổi số vs resend vs lần đầu) × (cooldown?) × (lock?) × (Zalo OK/fail) | §0.2 bên dưới, TC-14→25 |
| **State-Transition** | Vòng đời OTP + lock: chưa có OTP → có OTP → verify sai n lần → locked → hết lock → reset; `is_verify_phone` false → true → chặn gửi OTP tiếp | TC-59, TC-69, TC-70, TC-34/35, TC-44/45, TC-54/55 |
| **Error guessing / security** | Gửi OTP số A rồi verify số B (`otp_mismatch`), verify khi chưa từng gửi, race 2 request cùng uuid, đổi số A→B→A, bypass verify-lock bằng đổi số, brute-force, enumeration | TC-56→58, TC-63→68 |

### 0.2 Decision table — nhánh S2-06 → S2-17

| # | Loại request | Còn cooldown? | Đang bị lock tương ứng? | Zalo gửi | Kết quả | Counter tăng | Cache | Case |
|---|---|---|---|---|---|---|---|---|
| R1 | Lần đầu (chưa có phone, chưa có cache) | N | N | OK | 200 + OTP | không | tạo `zalo_phone_otp` + `..._cooldown` | TC-14 |
| R2/R10 | Bất kỳ | **Y** | – | – | 30018 `otp_cooldown` | không | không đổi | TC-15, TC-25 |
| R3 | Đổi số (target mới ≠ phone lưu/cache) | N | N | OK | 200 + OTP | `phone_change_attempts`+1 | ghi đè `zalo_phone_otp`; update `phone`; reset `is_verify_phone` | TC-16 |
| R4 | Đổi số | N | **Y** | – | 30019 `phone_change_locked` | không | không tạo | TC-17 |
| R5a | Đổi số | N | N | FAIL (`-118`) | 30015 `send_otp_failed` | không | không tạo/update | TC-18 |
| R5b | Đổi số | N | N | FAIL (lỗi khác) | 30024 `send_otp_failed` | không | không tạo/update | TC-19 |
| R6 | Đổi số, chạm đúng bậc (vd lần 5) | N | N (chưa, đang set) | OK | 200 + OTP (vẫn trả) | +1 (chạm bậc) | ghi đè; **lock tạo cho request kế tiếp** | TC-20 |
| R7 | Resend (cùng `uuid+phone` với cache hiện hành) | N | N | OK | 200 + OTP | `resend_attempts`+1 | ghi đè `zalo_phone_otp` | TC-21 |
| R8 | Resend | N | **Y** | – | 30020 `otp_resend_locked` | không | không đổi | TC-22 |
| R9 | Resend | N | N | FAIL | 30015/30024 | không | không tạo | TC-23 |
| — | Gửi lại đúng số đang lưu (không đổi) | N | N | OK | 200 + OTP | không tăng đổi số | ghi đè | TC-24 |

---

## 1. Bảng test case

> Ký hiệu: **❓** = case bị chặn bởi gap spec (chưa chốt kỳ vọng) — không tính coverage cho tới khi
> BA/BE trả lời. Mọi test data dùng `uuid` riêng biệt cho từng case đếm bậc khóa (tránh cộng dồn
> nhầm counter, theo TP-ZALO-OTP mục 3).

| TC id | Trace | Loại | Tiền điều kiện | Bước | Dữ liệu | Kết quả kỳ vọng | Mã lỗi | Evidence-required |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| **A — Validate input send-OTP (S2-01, S2-02) — EP** ||||||||
| TC-ZALO-OTP-01 | S2-01, S2-02, S2-11→14, S2-18 | Happy | Account U1 tồn tại `user_providers`, chưa có `phone`, chưa verify; `zalo_setting.send_message_enabled=false` | 1. POST `/send-zalo-otp` với `uuid=U1`, `phone="0347566507"` | `{"uuid":"U1","phone":"0347566507"}` | HTTP 200; `data` có `accountId,uuid,phone,expiresIn,otp`; message *"Gửi mã OTP qua Zalo thành công"* | — | response log JSON |
| TC-ZALO-OTP-02 | S2-02 (EP) | Happy | Account U2 tồn tại, chưa verify | POST với `phone="84347566507"` | phone dạng `84…` | HTTP 200, request được chấp nhận như định dạng hợp lệ | — | response log JSON |
| TC-ZALO-OTP-03 | S2-02 (EP) | Happy | Account U3 tồn tại, chưa verify | POST với `phone="+84347566507"` | phone dạng `+84…` | HTTP 200, request được chấp nhận | — | response log JSON |
| TC-ZALO-OTP-04 ❓ | S2-02 (EP) | Error | Account U4 bất kỳ | POST với `phone=""` | phone rỗng | **[Cập nhật theo review 2026-10-02]** Bị từ chối: HTTP 400 + có lỗi ở field `errors.phone`; không tạo OTP. Mã lỗi/rule/message cụ thể **chưa chốt — phụ thuộc Gap #6** (không assert) | — (Gap #6) | response log JSON |
| TC-ZALO-OTP-05 | S2-02 (EP) | Error | Account U5 bất kỳ | POST với `phone="12345"` (không phải số VN, có ký tự chữ hoặc thiếu số) | phone sai định dạng | Request bị từ chối; **mã lỗi cụ thể chưa xác định — xem Gap #6** | — (Gap #6) | response log JSON |
| TC-ZALO-OTP-06 ❓ | S2-01 (EP) | Error | — | POST với `uuid=""` | uuid rỗng | **[Cập nhật theo review 2026-10-02]** Bị từ chối: HTTP 400 + có lỗi ở field `errors.uuid`. Mã lỗi/rule/message cụ thể **chưa chốt — phụ thuộc Gap #6** (không assert) | — (Gap #6) | response log JSON |
| TC-ZALO-OTP-07 | S2-01 (EP) | Error | — | POST với `uuid="not-a-uuid"` | uuid sai format | Request bị từ chối; **mã lỗi cụ thể chưa xác định — xem Gap #6** | — (Gap #6) | response log JSON |
| **B — Account existence & duplicate phone (S2-03, S2-04, S2-05)** ||||||||
| TC-ZALO-OTP-08 | S2-03 | Error | `uuid=U-random` đúng format nhưng KHÔNG map `provider_id` nào | POST với `uuid=U-random`, phone hợp lệ | uuid không tồn tại | HTTP 400 | `30016 / not_found` | response log JSON |
| TC-ZALO-OTP-09 | S2-04 | Error | Account U6 đã `is_verify_phone=true` | POST send-otp cho U6 | uuid đã verify | HTTP 400 | `30014 / phone_already_verified` | response log JSON |
| TC-ZALO-OTP-10 | S2-05 | Error | Account U7 chưa verify; phone `P1` đã được account U8 verify (`is_verify_phone=true`) | POST send-otp `uuid=U7`, `phone=P1` | P1 trùng account khác đã verify | HTTP 400 | `30014 / phone_already_verified` | response log JSON |
| TC-ZALO-OTP-11 ❓ | S2-05, Section 1 (3 biến thể) | Edge (Gap #5) | Account U9 chưa verify; account U10 đã verify với `phone` lưu dạng `"0347566507"` | POST send-otp `uuid=U9`, `phone="84347566507"` (cùng số, khác định dạng) | biến thể `84…` vs `0…` đã lưu | **Chờ BE xác nhận (Gap #5):** kỳ vọng đề xuất của QA — vẫn phát hiện trùng theo 3 biến thể → `30014`; nhưng có rủi ro bypass nếu rule S2-05 không áp đủ | 30014 (giả định) | response log JSON |
| TC-ZALO-OTP-12 | S2-05 | Edge | Account U11 chưa verify; account U12 cũng có `phone=P2` nhưng `is_verify_phone=false` (chưa verify) | POST send-otp `uuid=U11`, `phone=P2` | P2 trùng account khác NHƯNG chưa verify | HTTP 200 — KHÔNG bị chặn (30014 chỉ áp khi số đã **verify** bởi account khác) | — | response log JSON |
| TC-ZALO-OTP-13 | S2-03, S2-04, S2-05 (security) | Error (security-test) | 3 kịch bản: (a) uuid không tồn tại, (b) uuid tồn tại đã verify, (c) phone trùng account khác đã verify | Gọi lần lượt 3 request, so sánh response | 3 payload khác nhau | Response của cả 3 chỉ khác `errorCode`/`message` chuẩn theo Section 8; KHÔNG có field nào lộ thêm thông tin định danh account khác (tên, email, accountId của account kia) | 30016 / 30014 | response log JSON x3 |
| **C — Decision table S2-06→S2-17 (đổi số / resend / lần đầu × cooldown × lock × Zalo OK/fail)** ||||||||
| TC-ZALO-OTP-14 | S2-06→08, S2-11→14, §0.2 R1 | Happy | Account U13 chưa có `phone`, chưa có OTP cache | POST send-otp lần đầu | phone P1 | HTTP 200 + otp; cache `zalo_phone_otp:{hash(U13)}` được tạo; cache cooldown được tạo; KHÔNG tăng `phone_change_attempts`/`resend_attempts` | — | response log + cache dump |
| TC-ZALO-OTP-15 | S2-07, §0.2 R2/R10 | Error | Account U14 vừa gửi OTP thành công, còn trong thời gian `cooldown` | POST send-otp lại ngay (bất kỳ phone) | trong cooldown | HTTP 400; KHÔNG tăng `resend_attempts`/`phone_change_attempts` | `30018 / otp_cooldown` (response chỉ có `lockedUntil, remainingSeconds, remainingMinutes` — KHÔNG có `failedAttempts`) | response log JSON |
| TC-ZALO-OTP-16 | S2-09, S2-13→15, §0.2 R3 | Happy | Account U15 đã có `phone=P1` (chưa verify), hết cooldown, không bị khóa đổi số | POST send-otp `phone=P2` (≠P1) | đổi số hợp lệ | HTTP 200; `user_providers.phone` cập nhật = P2 (raw); `is_verify_phone` reset về `false`; cache OTP ghi đè theo `uuid`; `phone_change_attempts`+1 | — | response log + DB row `user_providers` |
| TC-ZALO-OTP-17 | S2-09, §0.2 R4 | Error | Account U16 đang bị khóa đổi số (`zalo_phone_change_lock` còn hiệu lực) | POST send-otp đổi số mới | đang bị lock | HTTP 400; KHÔNG gọi Zalo, KHÔNG tăng counter, KHÔNG tạo cache mới | `30019 / phone_change_locked` | response log JSON |
| TC-ZALO-OTP-18 | S2-12, BR gửi OTP (Zalo fail -118), §0.2 R5a | Error (cross-service-e2e) | Account U17 hợp lệ, đổi số sang số KHÔNG tồn tại trên Zalo; `send_message_enabled=true` | POST send-otp với số test không đăng ký Zalo | Zalo trả `error=-118` | HTTP 400; `user_providers.phone` KHÔNG đổi; KHÔNG tạo cache OTP; KHÔNG tăng `phone_change_attempts`; cooldown vẫn đã set | `30015 / send_otp_failed` | response log + Zalo API log |
| TC-ZALO-OTP-19 | S2-12, BR gửi OTP (Zalo fail khác), §0.2 R5b | Error (cross-service-e2e) | Account U18 hợp lệ, đổi số hợp lệ; mock/stub Zalo trả lỗi khác `-118` (vd lỗi hệ thống) | POST send-otp | Zalo fail (không phải -118) | HTTP 400; KHÔNG update phone/cache/counter; cooldown vẫn set | `30024 / send_otp_failed` | response log + Zalo API log |
| TC-ZALO-OTP-20 | S2-17, §0.2 R6 | Edge | Account U19 đã đổi số thành công 4 lần trước đó (counter=4) | POST send-otp đổi số lần thứ 5 (target mới) | lần thứ 5 (chạm bậc) | HTTP 200 + OTP — **request hiện tại vẫn thành công**; lock đổi số được tạo áp dụng cho **request kế tiếp** (`lock_minutes=1`) | — | response log + cache dump `zalo_phone_change_lock` |
| TC-ZALO-OTP-21 | S2-10, S2-16, §0.2 R7 | Happy | Account U20 đã gửi OTP cho `phone=P1`, chưa verify, hết cooldown | POST send-otp lại cùng `uuid=U20`, `phone=P1` | resend (cùng cặp) | HTTP 200 + OTP mới; cache `zalo_phone_otp` ghi đè (OTP/`trackingId` mới); `resend_attempts`+1; KHÔNG tăng `phone_change_attempts` | — | response log + cache dump |
| TC-ZALO-OTP-22 | S2-10, §0.2 R8 | Error | Cặp `uuid+phone` U21/P1 đang bị khóa resend | POST send-otp resend | đang bị lock resend | HTTP 400 | `30020 / otp_resend_locked` | response log JSON |
| TC-ZALO-OTP-23 | S2-10, BR gửi OTP, §0.2 R9 | Error (cross-service-e2e) | Account U22 resend hợp lệ; mock Zalo fail | POST send-otp resend | Zalo fail | HTTP 400; KHÔNG tăng `resend_attempts`; cooldown vẫn set | `30015` (nếu -118) / `30024` (khác) | response log + Zalo API log |
| TC-ZALO-OTP-24 | S2-06, BR gửi OTP (cùng số đang lưu không cộng đổi số) | Edge | Account U23 đã có `phone=P1` (chưa verify), hết cooldown | POST send-otp `phone=P1` (đúng số đang lưu, không phải resend vì cache khác nội dung/đã hết hạn) | cùng số hiện tại | HTTP 200 + OTP; KHÔNG tăng `phone_change_attempts` (không phải đổi số vì cùng số) | — | response log + cache dump |
| TC-ZALO-OTP-25 | S2-08, BR gửi OTP (cooldown set trước khi gọi Zalo) | Edge | Account U24 hợp lệ, chưa có cooldown | 1. POST send-otp hợp lệ, Zalo mock **fail** (`30024`)<br>2. POST send-otp lại ngay lập tức | Zalo fail rồi retry ngay | Bước 1: HTTP 400 `30024`. Bước 2: HTTP 400 `30018 otp_cooldown` — chứng minh cooldown đã được set ở bước 1 dù Zalo fail | 30024 (b1) / 30018 (b2) | response log x2 |
| **D — BVA bậc khóa ĐỔI SỐ (theo `uuid`) — 5/1′, 10/10′, 20/60′** ||||||||
| TC-ZALO-OTP-26 | Section 4 `phone_change_lock_steps`, BVA N-1=4 | Edge (BVA) | U25: đã đổi số thành công 3 lần trước đó (counter=3) | POST send-otp đổi số lần thứ 4 | lần 4 | HTTP 200 + OTP; chưa chạm bậc, chưa tạo lock | — | response log + cache dump |
| TC-ZALO-OTP-27 | Section 4, BVA N=5 | Edge (BVA, security-test) | U25 tiếp tục: counter=4 (từ TC-26) | POST send-otp đổi số lần thứ 5 (chạm bậc 1) | lần 5 | HTTP 200 + OTP (vẫn trả); lock đổi số được tạo cho **request kế tiếp**, `lock_minutes=1` | — | response log + cache dump `zalo_phone_change_lock` |
| TC-ZALO-OTP-28 | Section 4, BVA N+1=6 | Error (BVA, security-test) | U25 vừa chạm bậc 1 ở TC-27, lock đang hiệu lực | POST send-otp đổi số ngay lập tức | lần 6 (bị khóa) | HTTP 400; `errors.failedAttempts=5`, `lockMinutes=1`, có `lockedUntil/remainingSeconds/remainingMinutes` | `30019 / phone_change_locked` | response log JSON |
| TC-ZALO-OTP-29 | Section 4, BVA N-1=9 | Edge (BVA) | U25: lock bậc 1 đã hết hạn (chờ >1′), counter vẫn =5, tiếp tục đổi số tới lần thứ 9 (counter=8) | POST send-otp đổi số lần thứ 9 | lần 9 | HTTP 200 + OTP; chưa chạm bậc 2 | — | response log + cache dump |
| TC-ZALO-OTP-30 | Section 4, BVA N=10 | Edge (BVA, security-test) | U25: counter=9 (từ TC-29) | POST send-otp đổi số lần thứ 10 (chạm bậc 2) | lần 10 | HTTP 200 + OTP (vẫn trả); lock tạo cho request kế tiếp, `lock_minutes=10` | — | response log + cache dump |
| TC-ZALO-OTP-31 | Section 4, BVA N+1=11 | Error (BVA, security-test) | U25 vừa chạm bậc 2, lock đang hiệu lực | POST send-otp ngay | lần 11 (bị khóa) | HTTP 400; `failedAttempts=10`, `lockMinutes=10` | `30019 / phone_change_locked` | response log JSON |
| TC-ZALO-OTP-32 | Section 4, BVA N-1=19 | Edge (BVA) | U25: lock bậc 2 hết hạn (chờ >10′), tiếp tục tới lần thứ 19 (counter=18) | POST send-otp đổi số lần thứ 19 | lần 19 | HTTP 200 + OTP; chưa chạm bậc cuối | — | response log + cache dump |
| TC-ZALO-OTP-33 | Section 4, BVA N=20 (bậc cuối) | Edge (BVA, security-test) | U25: counter=19 (từ TC-32) | POST send-otp đổi số lần thứ 20 (chạm bậc cuối) | lần 20 | HTTP 200 + OTP (vẫn trả); lock tạo cho request kế tiếp `lock_minutes=60`; **bộ đếm reset về 0** ngay sau khi chạm bậc cuối | — | response log + cache dump (xác nhận counter=0 sau reset) |
| TC-ZALO-OTP-34 | Section 4, BVA N+1=21 | Error (BVA, security-test) | U25 vừa chạm bậc cuối, lock đang hiệu lực | POST send-otp ngay | lần 21 (bị khóa) | HTTP 400; `failedAttempts=20` (mốc bậc, **không phải** 21), `lockMinutes=60` | `30019 / phone_change_locked` | response log JSON |
| TC-ZALO-OTP-35 | Section 4 (reset sau bậc cuối) | Edge (state-transition) | U25: lock bậc cuối (60′) đã hết hạn, counter đã reset về 0 | POST send-otp đổi số 5 lần liên tiếp (đủ điều kiện qua cooldown mỗi lần) | 5 lần kế tiếp | 4 lần đầu thành công bình thường không lock; lần thứ 5 mới chạm lại bậc 1 (`lock_minutes=1`) — chứng minh vòng đếm bắt đầu lại từ 1, không cộng tiếp từ 21 | — | cache dump theo từng lần |
| **E — BVA bậc khóa RESEND (theo cặp `uuid+phone`) — 5/1′, 10/10′, 20/60′** ||||||||
| TC-ZALO-OTP-36 | Section 4 `resend_lock_steps`, BVA N-1=4 | Edge (BVA) | Cặp U26/P1: đã resend thành công 3 lần (counter=3) | POST send-otp resend lần thứ 4 (cùng P1) | lần 4 | HTTP 200 + OTP; chưa chạm bậc | — | response log + cache dump |
| TC-ZALO-OTP-37 | Section 4, BVA N=5 | Edge (BVA, security-test) | Cặp U26/P1: counter=4 | POST resend lần thứ 5 (chạm bậc 1) | lần 5 | HTTP 200 + OTP (vẫn trả); lock resend tạo cho request kế tiếp, `lock_minutes=1` | — | response log + cache dump `zalo_phone_otp_resend_lock` |
| TC-ZALO-OTP-38 | Section 4, BVA N+1=6 | Error (BVA, security-test) | Cặp U26/P1 vừa chạm bậc 1, lock hiệu lực | POST resend ngay | lần 6 (bị khóa) | HTTP 400; `failedAttempts=5`, `lockMinutes=1` | `30020 / otp_resend_locked` | response log JSON |
| TC-ZALO-OTP-39 | Section 4, BVA N-1=9 | Edge (BVA) | Cặp U26/P1: lock hết hạn, tới lần thứ 9 (counter=8) | POST resend lần thứ 9 | lần 9 | HTTP 200 + OTP; chưa chạm bậc 2 | — | response log + cache dump |
| TC-ZALO-OTP-40 | Section 4, BVA N=10 | Edge (BVA, security-test) | Cặp U26/P1: counter=9 | POST resend lần thứ 10 (chạm bậc 2) | lần 10 | HTTP 200 + OTP (vẫn trả); lock tạo cho request kế tiếp, `lock_minutes=10` | — | response log + cache dump |
| TC-ZALO-OTP-41 | Section 4, BVA N+1=11 | Error (BVA, security-test) | Cặp U26/P1 vừa chạm bậc 2, lock hiệu lực | POST resend ngay | lần 11 (bị khóa) | HTTP 400; `failedAttempts=10`, `lockMinutes=10` | `30020 / otp_resend_locked` | response log JSON |
| TC-ZALO-OTP-42 | Section 4, BVA N-1=19 | Edge (BVA) | Cặp U26/P1: lock hết hạn, tới lần thứ 19 (counter=18) | POST resend lần thứ 19 | lần 19 | HTTP 200 + OTP; chưa chạm bậc cuối | — | response log + cache dump |
| TC-ZALO-OTP-43 | Section 4, BVA N=20 (bậc cuối) | Edge (BVA, security-test) | Cặp U26/P1: counter=19 | POST resend lần thứ 20 (chạm bậc cuối) | lần 20 | HTTP 200 + OTP (vẫn trả); lock tạo cho request kế tiếp `lock_minutes=60`; bộ đếm reset về 0 | — | response log + cache dump |
| TC-ZALO-OTP-44 | Section 4, BVA N+1=21 | Error (BVA, security-test) | Cặp U26/P1 vừa chạm bậc cuối, lock hiệu lực | POST resend ngay | lần 21 (bị khóa) | HTTP 400; `failedAttempts=20`, `lockMinutes=60` | `30020 / otp_resend_locked` | response log JSON |
| TC-ZALO-OTP-45 | Section 4 (reset sau bậc cuối) | Edge (state-transition) | Cặp U26/P1: lock bậc cuối hết hạn, counter reset về 0 | POST resend 5 lần liên tiếp | 5 lần kế tiếp | 4 lần đầu OK không lock; lần thứ 5 mới chạm lại bậc 1 — xác nhận reset đúng | — | cache dump theo từng lần |
| **F — BVA bậc khóa VERIFY (theo cặp `uuid+phone`) — hành vi KHÁC nhóm đổi số/resend: chạm bậc = khóa NGAY** ||||||||
| TC-ZALO-OTP-46 | S3-06, S3-07, Section 4 `verify_lock_steps`, BVA N-1=4 | Edge (BVA) | Cặp U27/P1 đã có OTP hợp lệ đang pending; đã verify sai 3 lần (counter=3) | POST verify-otp với `otp` sai lần thứ 4 | OTP sai #4 | HTTP 400; counter verify tăng lên 4; chưa chạm bậc; **[Cập nhật 2026-10-02]** response có `errors.failedAttempts=4` (= số lần sai hiện tại; *suy diễn từ mẫu `failedAttempts:1` trong tài liệu, chưa có mẫu cho giá trị 4*) | `30027 / otp_invalid` | response log + cache dump |
| TC-ZALO-OTP-47 | S3-07, Section 4, BVA N=5 | Error (BVA, security-test) | Cặp U27/P1: counter=4 | POST verify với `otp` sai lần thứ 5 (chạm bậc) | OTP sai #5 | HTTP 400 — **NGAY LẬP TỨC** trả lỗi khóa (khác nhóm đổi số/resend: verify khóa cùng lúc chạm bậc, không đợi request kế tiếp); `failedAttempts=5`, `lockMinutes=1` | `30028 / otp_verify_locked` | response log + cache dump `zalo_phone_otp_verify_lock` |
| TC-ZALO-OTP-48 | S3-02, Section 4 (security) | Error (security-test) | Cặp U27/P1 đang bị khóa verify (từ TC-47) | POST verify với **OTP ĐÚNG** (cache vẫn còn hiệu lực TTL) | OTP đúng, nhưng đang lock | HTTP 400 — vẫn bị chặn dù OTP đúng, vì bước kiểm tra lock (S3-02) chạy TRƯỚC bước so khớp OTP | `30028 / otp_verify_locked` | response log JSON |
| TC-ZALO-OTP-49 | S3-06, BVA N-1=9 | Edge (BVA) | Cặp U28/P1: sau khi lock bậc 1 hết hạn, đã sai tiếp tới lần thứ 9 (counter=8) | POST verify sai lần thứ 9 | OTP sai #9 | HTTP 400; chưa chạm bậc 2; **[Cập nhật 2026-10-02]** `errors.failedAttempts=9` (*suy diễn từ mẫu `failedAttempts:1` trong tài liệu*) | `30027 / otp_invalid` | response log + cache dump |
| TC-ZALO-OTP-50 | S3-07, BVA N=10 | Error (BVA, security-test) | Cặp U28/P1: counter=9 | POST verify sai lần thứ 10 (chạm bậc 2) | OTP sai #10 | HTTP 400 ngay; `failedAttempts=10`, `lockMinutes=10` | `30028 / otp_verify_locked` | response log + cache dump |
| TC-ZALO-OTP-51 | S3-02 (security) | Error (security-test) | Cặp U28/P1 đang bị khóa bậc 2 | POST verify với OTP đúng | OTP đúng, đang lock | HTTP 400 — vẫn chặn dù OTP đúng | `30028 / otp_verify_locked` | response log JSON |
| TC-ZALO-OTP-52 | S3-06, BVA N-1=19 | Edge (BVA) | Cặp U29/P1: sau lock bậc 2 hết hạn, sai tiếp tới lần 19 (counter=18) | POST verify sai lần thứ 19 | OTP sai #19 | HTTP 400; chưa chạm bậc cuối; **[Cập nhật 2026-10-02]** `errors.failedAttempts=19` (*suy diễn từ mẫu `failedAttempts:1` trong tài liệu*) | `30027 / otp_invalid` | response log + cache dump |
| TC-ZALO-OTP-53 | S3-07, BVA N=20 (bậc cuối) | Error (BVA, security-test) | Cặp U29/P1: counter=19 | POST verify sai lần thứ 20 (chạm bậc cuối) | OTP sai #20 | HTTP 400 ngay; `failedAttempts=20`, `lockMinutes=60`; bộ đếm reset về 0 sau đó | `30028 / otp_verify_locked` | response log + cache dump |
| TC-ZALO-OTP-54 | S3-02 (security) | Error (security-test) | Cặp U29/P1 đang bị khóa bậc cuối | POST verify với OTP đúng | OTP đúng, đang lock | HTTP 400 — vẫn chặn dù OTP đúng | `30028 / otp_verify_locked` | response log JSON |
| TC-ZALO-OTP-55 | Section 4 (reset sau bậc cuối) | Edge (state-transition) | Cặp U29/P1: lock bậc cuối hết hạn, counter reset về 0; gửi OTP mới cho cùng cặp | POST verify sai 5 lần liên tiếp (OTP mới mỗi lần gửi lại) | 5 lần sai kế tiếp | 4 lần đầu → `otp_invalid`; lần thứ 5 mới chạm lại bậc 1 (`otp_verify_locked`, `failedAttempts=5`) — xác nhận reset đúng, không cộng tiếp từ 21 | 30027 (x4) / 30028 (lần 5) | cache dump theo từng lần |
| **G — Verify core, cache, error guessing, security (S3-01→S3-10, Section 6)** ||||||||
| TC-ZALO-OTP-56 | S3-04 | Error | Cặp U30/P1: OTP đã hết hạn (quá `ttl_minutes`), chưa từng sai lần nào | POST verify với `otp` bất kỳ | OTP hết hạn | HTTP 400; tăng vào bộ đếm khóa verify | `30025 / otp_expired` | response log + cache dump |
| TC-ZALO-OTP-57 | S3-05 (error guessing) | Error | U31 gửi OTP thành công cho `phone=A`; chưa verify | POST verify với `uuid=U31`, `phone=B` (≠A), `otp` bất kỳ | verify sai phone (khác cache) | HTTP 400; tăng vào bộ đếm khóa verify | `30026 / otp_mismatch` | response log + cache dump |
| TC-ZALO-OTP-58 | S3-04 (error guessing) | Error | U32 CHƯA từng gọi send-otp lần nào | POST verify trực tiếp `uuid=U32`, phone/otp bất kỳ | không có cache nào | HTTP 400 (không có OTP cache = coi như hết hạn) | `30025 / otp_expired` | response log JSON |
| TC-ZALO-OTP-59 | S3-08, S3-09, S3-10 | Happy | U33 vừa gửi OTP thành công cho `phone=P1`, còn trong TTL | POST verify đúng `otp` | OTP đúng | HTTP 200; `data.verified=true`; `user_providers.phone=P1`, `is_verify_phone=true`; xóa cache OTP theo `uuid`, **cache resend** và cache verify (attempts + lock) theo cặp `uuid+phone` **[Cập nhật 2026-10-02: bổ sung xóa cache resend theo tài liệu verify]** | — | response log + DB row + cache dump (xác nhận cả 3 loại cache đã xóa, gồm resend) |
| TC-ZALO-OTP-60 | S3-09, V-08 (tailieu/8) | Edge | Ngay sau TC-59 (verify vừa thành công, cache đã xóa) | POST verify lại với `otp` vừa dùng | otp cũ, account đã `is_verify_phone=true` | **[Cập nhật theo tài liệu 2026-10-02]** HTTP 400, message *"Tài khoản đã được xác thực"*, `module=user`, `rule=account_already_verified`. ⚠️ **Phụ thuộc Gap #8** (thứ tự kiểm tra chưa xác nhận: 30029 có được trả trước bước tìm OTP cache/khóa verify không). *(Cũ: kỳ vọng `30025 / otp_expired` với lý do "verify không check is_verify_phone" — SAI theo tài liệu mới: rule account đã xác thực được kiểm tra, ưu tiên trước 30014)* | `30029 / account_already_verified` | response log JSON |
| TC-ZALO-OTP-61 | Section 4 `ttl_minutes`, BVA TTL trước hết hạn | Edge (BVA) | U34 gửi OTP với `ttl_minutes` nhỏ (cấu hình test); verify ngay trước mốc hết hạn (còn 1-2 giây) | POST verify đúng `otp` ngay trước khi hết hạn | trong TTL | HTTP 200, verify thành công | — | response log + timing |
| TC-ZALO-OTP-62 | Section 4 `ttl_minutes`, BVA TTL sau hết hạn | Edge (BVA) | U35 gửi OTP, chờ vượt quá `ttl_minutes` | POST verify đúng `otp` ngay sau khi hết hạn | ngoài TTL | HTTP 400 | `30025 / otp_expired` | response log + timing |
| TC-ZALO-OTP-63 | Section 6 (cache ghi đè theo `uuid`), S3-05 | Edge | U36 gửi OTP cho `phone=A`; TRƯỚC khi verify, gửi OTP đổi số hợp lệ sang `phone=B` (cùng `uuid`) | POST verify với `phone=A` + `otp` cũ (đã bị ghi đè) | cache hiện tại thuộc B | HTTP 400 — cache theo `uuid` hiện chứa payload của B, không khớp `phone=A` | `30026 / otp_mismatch` | response log + cache dump |
| TC-ZALO-OTP-64 | S2-06→08 (exploratory, flaky-risk) | Error/Edge (exploratory) | U37 hợp lệ, chưa có cache/cooldown | 2 request POST send-otp gửi ĐỒNG THỜI cùng `uuid=U37` (khác phone) | race condition | Chỉ 1 request set cache/cooldown/counter thành công nhất quán; request còn lại nhận `otp_cooldown` hoặc dữ liệu cache không bị ghi đè hỗn loạn (không có 2 OTP song song không nhất quán) | 30018 (request thua) | response log x2 + cache dump |
| TC-ZALO-OTP-65 | BR gửi OTP (target khác target gần nhất), error guessing | Edge | U38 hợp lệ, chưa có phone | Đổi số tuần tự: A → B → A (mỗi lần đợi hết cooldown) | 3 lần đổi số A,B,A | Cả 3 lần đều tăng `phone_change_attempts` (mỗi lần target khác target liền trước, kể cả quay lại A vì target gần nhất lúc đó là B) → counter=3 | — | cache dump sau mỗi lần |
| TC-ZALO-OTP-66 | Section 4, S3-07 (security-test hard gate) | Security (Error) | U39 gửi OTP hợp lệ, `verify_lock_steps` bậc đầu = 5 | Thử verify sai OTP liên tục (brute-force 6 chữ số) | nhiều lần sai liên tiếp | Bị chặn hoàn toàn bởi `otp_verify_locked` ngay tại lần thứ 5 — không thể vét cạn 10^6 tổ hợp trong 1 chu kỳ trước khi khóa | `30028 / otp_verify_locked` | response log + cache dump |
| TC-ZALO-OTP-67 ❓ | Section 4 (security-test, bypass risk — phát hiện mới, xem Gap #7) | Security (Error) | Cặp U40/A đã verify sai 4 lần (gần chạm bậc 1, counter=4) | 1. Gửi OTP đổi số hợp lệ sang `phone=B` (cùng `uuid=U40`, còn lượt đổi số)<br>2. Verify sai cho cặp U40/B | đổi số giữa chừng để né lock | **Ghi nhận hành vi hiện tại của spec:** verify counter cho cặp `(U40,B)` = 0, KHÔNG kế thừa từ cặp `(U40,A)` → cho phép "làm mới" số lần thử verify bằng cách đổi số, giới hạn duy nhất bởi `phone_change_lock` (5 lần). **Đây là rủi ro bảo mật cần BA/Security xác nhận (Gap #7)**, KHÔNG tự kết luận là bug | `30027` (verify sai cho B, chưa lock) | response log + cache dump 2 cặp |
| TC-ZALO-OTP-68 | S3-04 (security — enumeration) | Security (Error) | `uuid=U-ghost` KHÔNG tồn tại trong `user_providers` | POST verify với `uuid=U-ghost`, phone/otp bất kỳ | uuid không tồn tại | HTTP 400 — trả **CÙNG** lỗi như trường hợp uuid tồn tại nhưng chưa từng gửi OTP (TC-58); không lộ thông tin account có tồn tại hay không qua verify endpoint | `30025 / otp_expired` | response log JSON |
| TC-ZALO-OTP-69 | S2-04, S3-08 (state-transition) | Edge | Ngay sau khi U41 verify thành công (`is_verify_phone=true`) | POST send-otp lại cho `uuid=U41` | account đã verify | HTTP 400 — không cho gửi OTP nữa | `30014 / phone_already_verified` | response log JSON |
| TC-ZALO-OTP-70 | S2-04, S3-07, S3-08 (state-transition E2E) | Happy (System/E2E) | U42 chưa có OTP, chưa verify | 1. Gửi OTP<br>2. Verify sai 4 lần liên tiếp<br>3. Verify sai lần 5 → bị khóa<br>4. Chờ hết khóa (1′)<br>5. Gửi OTP mới, verify đúng<br>6. Gửi OTP lại | full lifecycle | (1) 200; (2) 4×`otp_invalid`; (3) `otp_verify_locked`; (4)-(5) verify đúng → `is_verify_phone=true`; (6) `phone_already_verified` — đóng vòng đời đúng theo thiết kế | 30027→30028→(success)→30014 | response log toàn chuỗi + DB row |
| **H — Admin `/admin/system-settings/{id}` (Section 5, Happy cơ bản)** ||||||||
| TC-ZALO-OTP-71 | Section 5 | Happy | Đăng nhập Admin; record `system_settings.key=zalo_setting` tồn tại | Mở `/admin/system-settings/{id}` | record zalo_setting | Hiển thị đúng JSON tổng ở `Giá trị (JSON)`; các input/toggle tách riêng hiển thị **chỉ** cho key đang tồn tại trong JSON | — | screenshot |
| TC-ZALO-OTP-72 | Section 5 (toggle `send_message_enabled`) | Happy | Đang ở màn config, `send_message_enabled=true` trong JSON | Bật/tắt toggle "Gửi OTP qua Zalo" → Lưu | toggle → false | JSON cập nhật `send_message_enabled=false`; lưu thành công, load lại xác nhận persisted | — | screenshot trước/sau |
| TC-ZALO-OTP-73 | Section 5 (toggle `auto_refresh_token_enabled`) | Happy | Đang ở màn config | Bật/tắt toggle "Tự động refresh token Zalo" → Lưu | toggle | JSON cập nhật đúng field; lưu thành công | — | screenshot |
| TC-ZALO-OTP-74 | Section 5 (bậc khóa) | Happy | Đang ở màn config, có sẵn `phone_change_lock_steps`/`resend_lock_steps`/`verify_lock_steps` | Sửa `attempts`/`lock_minutes` ở 1 bậc của mỗi nhóm → Lưu | vd đổi bậc 1 verify từ 5→3 | Lưu thành công; mở lại trang xác nhận giá trị mới đã persisted trong JSON | — | screenshot trước/sau |
| TC-ZALO-OTP-75 | Section 5 (nguyên tắc hiển thị) | Happy | JSON của `zalo_setting` KHÔNG có key `phone_verify_bypass_ips` | Mở màn config, quan sát khu vực "Danh sách IP không cần xác thực OTP" | key không tồn tại | Input tương ứng KHÔNG hiển thị (theo nguyên tắc "key không tồn tại → không hiện input"); JSON tổng vẫn hiển thị đầy đủ | — | screenshot |
| TC-ZALO-OTP-76 | Section 5 (ngoại lệ 3 lock-steps mặc định) | Happy | JSON của `zalo_setting` KHÔNG có `phone_change_lock_steps`/`resend_lock_steps`/`verify_lock_steps` | Mở màn config | 3 key lock-steps đều thiếu trong JSON gốc | 3 input cấu hình bậc khóa vẫn được hiển thị với giá trị mặc định (ngoại lệ so với nguyên tắc ẩn ở TC-75) | — | screenshot |
| **I — Accessibility (chỉ Admin `/admin/system-settings/{id}`)** ||||||||
| TC-ZALO-OTP-77 | Section 5 (a11y) | a11y | Màn config đang mở với đầy đủ toggle/input/JSON editor | Chạy axe-core scan | — | 0 violation mức critical/serious (WCAG A/AA); toggle có `aria-label`/label liên kết; input có `<label>` | — | axe-report |
| TC-ZALO-OTP-78 | Section 5 (a11y) | a11y | Màn config đang mở | Điều hướng chỉ bằng bàn phím: Tab qua toggle, bảng bậc khóa, danh sách IP, nút Lưu | keyboard-only | Mọi control thao tác được bằng bàn phím; focus visible; không có bẫy focus (focus trap) | — | video |
| **J — Refresh token Zalo (Section 7)** ||||||||
| TC-ZALO-OTP-79 | S2-12, Section 7 (tự refresh) | Happy (cross-service-e2e) | `zalo_setting.expires_in` gần hết hạn (giả lập); `refresh_token/app_id/secret_key` hợp lệ | POST send-otp | access_token gần hết hạn | Hệ thống tự refresh TRƯỚC khi gọi Zalo; `access_token/refresh_token` mới; `expires_in` = thời điểm refresh +25h; `refresh_expires_in` = +3 tháng; OTP vẫn gửi thành công (HTTP 200) | — | response log + DB row `system_settings` (zalo_setting) |
| TC-ZALO-OTP-80 | Section 7 | Error | `zalo_setting` thiếu `refresh_token` (hoặc `app_id`/`secret_key`); `access_token` gần hết hạn | POST send-otp (kích hoạt tự refresh) | thiếu config refresh | HTTP 400; không refresh được, không gửi OTP | `30021 / refresh_config_error` | response log JSON |
| TC-ZALO-OTP-81 | Section 7 | Error | `refresh_token` đã hết hạn (`refresh_expires_in` đã qua) | POST send-otp (kích hoạt tự refresh) | refresh_token hết hạn | HTTP 400 | `30022 / refresh_token_expired` | response log JSON |
| TC-ZALO-OTP-82 | Section 7 | Error (cross-service-e2e) | Mock API Zalo refresh trả lỗi | POST send-otp (kích hoạt tự refresh) | Zalo refresh API fail | HTTP 400 | `30023 / refresh_token_failed` | response log + Zalo API log |
| TC-ZALO-OTP-83 | S2-12 (config_error, không do refresh) | Error | `zalo_setting` thiếu cấu hình cơ bản (`endpoint`/`template_id`/`access_token` rỗng), KHÔNG liên quan hết hạn token | POST send-otp | thiếu cấu hình Zalo cơ bản | HTTP 400 | `30017 / config_error` | response log JSON |
| TC-ZALO-OTP-84 | Section 7 (scheduler) | System/Exploratory | `auto_refresh_token_enabled=true`, `access_token` còn dưới 2 ngày | Trigger lệnh `zalo:refresh-otp-token` (thủ công hoặc chờ 03:00) | scheduler chạy | Refresh thành công; `access_token/expires_in/refresh_expires_in` cập nhật đúng công thức; cache `zalo_setting` đồng bộ ngay để request gửi OTP kế tiếp dùng token mới | — | log scheduler + DB row + response log request kế tiếp |
| TC-ZALO-OTP-85 | Section 7 (scheduler, edge) | Edge | `auto_refresh_token_enabled=false`, token sắp hết hạn | Trigger `zalo:refresh-otp-token` | flag tắt | Scheduler KHÔNG refresh token dù token sắp hết hạn | — | log scheduler + DB row (không đổi) |
| TC-ZALO-OTP-86 | Section 7 (scheduler, edge) | Edge | `auto_refresh_token_enabled=true`, token còn > 2 ngày | Trigger `zalo:refresh-otp-token` | chưa tới ngưỡng | Scheduler KHÔNG refresh (chưa đủ điều kiện < 2 ngày) | — | log scheduler + DB row (không đổi) |
| **K — Perf-smoke** ||||||||
| TC-ZALO-OTP-87 | Section 4 (perf-smoke) | Perf-smoke | `send_message_enabled=false` (tránh phụ thuộc Zalo thật), tải nhẹ | POST send-otp, đo thời gian phản hồi | — | Response time dưới ngưỡng thô đã thống nhất (vd < 2s) ở điều kiện tải nhẹ | — | timing log |
| TC-ZALO-OTP-88 | Section 3 (perf-smoke) | Perf-smoke | OTP hợp lệ đang pending | POST verify-otp, đo thời gian phản hồi | — | Response time dưới ngưỡng thô (vd < 1s, không phụ thuộc service ngoài) | — | timing log |
| TC-ZALO-OTP-89 | `zalo_setting.timeout`, S2-12 (perf + error) | Perf-smoke (Error) | Mock Zalo API delay vượt quá `timeout` giây cấu hình | POST send-otp | Zalo timeout | Request KHÔNG treo vô hạn; trả lỗi ngay sau khoảng ~`timeout` giây | `30024 / send_otp_failed` | timing log + response log |
| **L — BR chuẩn hóa số điện thoại (Section 1)** ||||||||
| TC-ZALO-OTP-90 | Section 1 (raw + normalize) | Edge | Account U43 chưa có phone | POST send-otp với `phone="  0347566507  "` (có khoảng trắng đầu/cuối) | phone có whitespace | `user_providers.phone` lưu **raw sau trim** = `"0347566507"`; khi gọi Zalo, số được chuẩn hóa thành `"84347566507"` | — | DB row `user_providers` + Zalo API request log |
| **M — Cập nhật theo tailieu/8-verify-ma-otp.md (2026-10-02): validation verify, 30029/30014, chuẩn hóa phone, failedAttempts** ||||||||
| TC-ZALO-OTP-91 | V-01 (11000, otp regex) — EP/BVA | Error | U44 bất kỳ (OTP pending hay không đều được vì validation chạy trước) | POST verify với `otp=""` | otp rỗng | HTTP 400, message *"Lỗi dữ liệu"*; `errors.otp` có lỗi (rule `required`/`regex` — rule cụ thể chưa nêu trong tài liệu, chỉ assert có lỗi trên field `otp`); việc có tăng bộ đếm khóa verify hay không: **chưa xác nhận** (tài liệu không nêu) | `11000` | response log JSON |
| TC-ZALO-OTP-92 | V-01 — BVA N-1 | Error | U45 có OTP pending | POST verify với `otp="12345"` (5 số) | otp 5 chữ số | HTTP 400, `errorCode=11000`, `errors.otp[0]` = `{rule: regex, message: "Mã OTP phải gồm 6 chữ số"}` | `11000` | response log JSON |
| TC-ZALO-OTP-93 | V-01 — BVA N+1 | Error | U45 có OTP pending | POST verify với `otp="1234567"` (7 số) | otp 7 chữ số | HTTP 400, `errorCode=11000`, `errors.otp` rule `regex`, message "Mã OTP phải gồm 6 chữ số" | `11000` | response log JSON |
| TC-ZALO-OTP-94 | V-01 — EP (ký tự không phải số) | Error | U45 có OTP pending | POST verify với `otp="12a456"` (đủ 6 ký tự, có chữ) | otp có chữ | HTTP 400, `errorCode=11000`, rule `regex`, message "Mã OTP phải gồm 6 chữ số" | `11000` | response log JSON |
| TC-ZALO-OTP-95 | V-01 — EP (thiếu uuid) | Error | — | POST verify bỏ hẳn field `uuid` (có `phone`, `otp` hợp lệ) | thiếu uuid | HTTP 400, `errorCode=11000`, có lỗi trên `errors.uuid`. Tài liệu không nêu rule/message riêng cho uuid — chỉ assert field `uuid` có lỗi | `11000` | response log JSON |
| TC-ZALO-OTP-96 | V-01 — EP (uuid sai định dạng) | Error | — | POST verify với `uuid="not-a-uuid"` | uuid sai format | HTTP 400, `errorCode=11000`, có lỗi trên `errors.uuid` | `11000` | response log JSON |
| TC-ZALO-OTP-97 | V-01 — EP (phone sai định dạng) | Error | U46 có OTP pending | POST verify với `phone="12345"`, `otp` 6 số | phone sai format | HTTP 400, `errorCode=11000`, có lỗi trên `errors.phone`; việc có tăng bộ đếm khóa verify hay không: **chưa xác nhận** (tài liệu không nêu) | `11000` | response log JSON |
| TC-ZALO-OTP-98 | V-09 (30014 — phone đã được account KHÁC xác thực) | Error | Account A (U47) chưa verify, đã gửi OTP cho `phone=P1` thành công (còn TTL). Sau đó account B xác thực xong `P1` (A gửi OTP trước khi B verify xong — setup cần điều phối thứ tự) | POST verify `uuid=U47`, `phone=P1`, `otp` đúng | phone đã bị account khác verify | HTTP 400, message *"Số điện thoại đã được xác thực"*, `module=user`, `rule=phone_already_verified`; `is_verify_phone` của U47 KHÔNG đổi | `30014 / phone_already_verified` | response log JSON + DB row 2 account |
| TC-ZALO-OTP-99 | V-10 (30029 ưu tiên trước 30014) | Error (priority) | Account A (U48) đã `is_verify_phone=true` với `P1`; account B đã verify `P2` | POST verify `uuid=U48`, `phone=P2`, `otp` bất kỳ 6 số | vừa account đã verify, vừa phone đã bị account khác verify | HTTP 400 trả **30029** `account_already_verified` — KHÔNG phải 30014. ⚠️ **Phụ thuộc Gap #8** (thứ tự kiểm tra so với khóa 30028 chưa xác nhận; case giả định cặp uuid+phone không đang bị khóa) | `30029 / account_already_verified` | response log JSON + DB row |
| TC-ZALO-OTP-100 | V-06 (chuẩn hóa phone trước khi so khớp) | Happy | U49 chưa verify, send-otp với `phone="0347566507"` thành công, OTP còn TTL | POST verify `phone="84347566507"` + OTP đúng | cùng số, dạng `84…` | HTTP 200, `data.verified=true` — KHÔNG phải `30026 otp_mismatch` | — | response log + cache dump |
| TC-ZALO-OTP-101 | V-06 | Happy | U50 chưa verify, send-otp với `phone="0347566507"`, OTP còn TTL | POST verify `phone="+84347566507"` + OTP đúng | cùng số, dạng `+84…` | HTTP 200, `data.verified=true` — KHÔNG phải `30026` | — | response log + cache dump |
| TC-ZALO-OTP-102 | V-07 (failedAttempts của otp_invalid) — BVA N=1 | Error | U51 có OTP pending, chưa sai lần nào (counter=0) | POST verify với `otp` sai (6 số) lần đầu | OTP sai #1 | HTTP 400, `module=zalo`, `rule=otp_invalid`, `errors.failedAttempts=1` | `30027 / otp_invalid` | response log JSON |

**Tổng: 102 test case** (90 cũ + 12 mới TC-91→TC-102). Phân bổ nhánh (đếm theo nhãn ghi ở cột Loại, **xấp xỉ**): Happy 22 · Edge 43 · Error 34 · a11y 2 · Perf-smoke 3. Một số case mang nhãn kép (vd Error/Edge, Happy (System/E2E), Security), nên tổng nhãn có thể không bằng 102. **Số TC chuẩn = 102 = số dòng của bảng.**
Trong đó **4 case đánh dấu ❓** (TC-04, TC-06 phụ thuộc Gap #6; TC-11 Gap #5; TC-67 Gap #7) — bị chặn bởi gap spec. **2 case đánh dấu ⚠️** (TC-60, TC-99) phụ thuộc Gap #8 (thứ tự kiểm tra chưa xác nhận).

---

## 2. Ma trận AC (Section/S-step) → case

### 2.1 Section 2 — Luồng gửi OTP (S2-01 … S2-18)

| Bước | Nội dung (rút gọn) | Test case phủ | Đã phủ? |
| --- | --- | --- | --- |
| S2-01 | Validate `uuid` bắt buộc UUID hợp lệ | TC-06, TC-07 | ✅ |
| S2-02 | Validate `phone` số VN hợp lệ (`0/84/+84`) | TC-01, TC-02, TC-03, TC-04, TC-05 | ✅ |
| S2-03 | Account tồn tại trong `user_providers` | TC-08 | ✅ |
| S2-04 | Đã `is_verify_phone=true` → chặn gửi OTP | TC-09, TC-69, TC-70 | ✅ |
| S2-05 | Kiểm tra phone đã được account khác dùng (verified) chưa | TC-10, TC-11❓, TC-12, TC-13 | ✅ |
| S2-06 | Xác định đổi số hay resend | TC-14, TC-16, TC-21, TC-24 | ✅ |
| S2-07 | Cooldown check trước lock, ưu tiên cao nhất | TC-15, TC-25 | ✅ |
| S2-08 | Set cooldown ngay khi hợp lệ, trước khi gọi Zalo | TC-25, TC-18, TC-19, TC-23 | ✅ |
| S2-09 | Kiểm tra khóa đổi số theo `uuid` | TC-17, TC-26→35 | ✅ |
| S2-10 | Kiểm tra khóa resend theo cặp `uuid+phone` | TC-22, TC-36→45 | ✅ |
| S2-11 | Sinh OTP 6 chữ số | TC-01 (ngầm định trong mọi case Happy) | ✅ |
| S2-12 | Gọi API Zalo nếu `send_message_enabled=true` | TC-18, TC-19, TC-79, TC-89 | ✅ |
| S2-13 | Zalo OK → update `phone`, reset `is_verify_phone` nếu đổi | TC-16 | ✅ |
| S2-14 | Cache OTP theo `uuid`, ghi đè cũ nếu có | TC-14, TC-16, TC-63 | ✅ |
| S2-15 | Tăng lượt đổi số nếu hợp lệ | TC-16, TC-20, TC-24, TC-26→35 | ✅ |
| S2-16 | Tăng lượt resend nếu resend | TC-21, TC-36→45 | ✅ |
| S2-17 | Chạm bậc → khóa request kế tiếp, hiện tại vẫn trả OTP | TC-20, TC-27, TC-30, TC-33, TC-37, TC-40, TC-43 | ✅ |
| S2-18 | Trả response cho FE | TC-01 (response shape) | ✅ |

### 2.2 BR gửi OTP (Section 2 — "Lưu ý quan trọng")

| BR | Nội dung | Test case phủ | Đã phủ? |
| --- | --- | --- | --- |
| BR-send-1 | Zalo fail → KHÔNG update `phone` | TC-18, TC-19 | ✅ |
| BR-send-2 | Zalo trả `-118` → `errorCode=30015` | TC-18 | ✅ |
| BR-send-3 | Zalo fail → KHÔNG tạo cache, KHÔNG cộng đổi số/resend; cooldown đã set trước đó | TC-18, TC-19, TC-23, TC-25 | ✅ |
| BR-send-4 | Đổi số chỉ cộng khi target khác target đổi số gần nhất | TC-16, TC-24, TC-65 | ✅ |
| BR-send-5 | Gửi lại cùng cặp/cùng số đang lưu không cộng đổi số; chỉ cộng sau khi gửi OK | TC-21, TC-24 | ✅ |
| BR-send-6 | Resend tính theo cặp, chỉ sau khi resend OK, Zalo lỗi không cộng | TC-21, TC-23 | ✅ |

### 2.3 Section 3 — Luồng xác thực OTP (S3-01 … S3-10)

| Bước | Nội dung (rút gọn) | Test case phủ | Đã phủ? |
| --- | --- | --- | --- |
| S3-01 | Validate `uuid`, `phone`, `otp` | TC-56→58 (ngầm định) + **TC-91→97 (tường minh, cập nhật 2026-10-02)** | ✅ |
| S3-02 | Check cặp `uuid+phone` đang bị khóa verify không (chạy TRƯỚC check OTP) | TC-48, TC-51, TC-54 | ✅ |
| S3-03 | Lấy OTP cache hiện hành theo `uuid` | TC-59, TC-58 | ✅ |
| S3-04 | OTP không tồn tại/hết hạn → tăng đếm + `otp_expired` | TC-56, TC-58, TC-61, TC-62, TC-68 | ✅ |
| S3-05 | Payload cache không khớp `uuid`/`phone` → tăng đếm + `otp_mismatch` | TC-57, TC-63 | ✅ |
| S3-06 | OTP sai → tăng đếm + `otp_invalid` (response có `errors.failedAttempts` = số lần sai hiện tại — cập nhật 2026-10-02) | TC-46, TC-49, TC-52, TC-102 | ✅ |
| S3-07 | Chạm bậc khóa verify → khóa NGAY + `otp_verify_locked` | TC-47, TC-50, TC-53 | ✅ |
| S3-08 | OTP đúng → update `phone` + `is_verify_phone=true` | TC-59 | ✅ |
| S3-09 | Xóa cache OTP (theo `uuid`), cache **resend** và cache verify (attempts + lock) theo cặp `uuid+phone` (cập nhật 2026-10-02: có xóa resend) | TC-59 | ✅ |
| S3-10 | Trả response thành công | TC-59, TC-100, TC-101 | ✅ |

#### 2.3b Bước verify bổ sung từ tailieu/8-verify-ma-otp.md (2026-10-02)

> Mã V-xx là nhãn QA đặt để trace nguồn tailieu/8 (không phải ID chính thức của spec).

| Mã | Nội dung (rút gọn) | Test case phủ | Đã phủ? |
| --- | --- | --- | --- |
| V-01 | Validation `uuid`/`phone`/`otp` thiếu hoặc sai định dạng → 11000; otp đúng 6 chữ số (regex) | TC-91, 92, 93, 94, 95, 96, 97 | ✅ |
| V-02 | Cặp `uuid+phone` đang khóa → 30028 | TC-47, 48, 50, 51, 53, 54 | ✅ |
| V-03 | Không có OTP cache → 30025 (tính vào bộ đếm) | TC-56, 58, 62, 68 | ✅ |
| V-04 | Payload cache không khớp `uuid`/`phone` **sau chuẩn hóa** → 30026 | TC-57, 63 | ✅ |
| V-05 | OTP sai → 30027 + `failedAttempts` | TC-46, 49, 52, 102 | ✅ |
| V-06 | So sánh phone sau chuẩn hóa: `0xxx`/`84xxx`/`+84xxx` cùng số → khớp, không 30026 | TC-100, TC-101 | ✅ |
| V-07 | Response 30027 có `errors.failedAttempts`; ở 30028 là mốc bậc | TC-46, 49, 52, 102 / TC-47, 50, 53 | ✅ |
| V-08 | Account đã `is_verify_phone=true` → 30029 | TC-60 (sửa) ⚠️, TC-99 ⚠️ (cả hai phụ thuộc Gap #8) | ⚠️ Phủ có điều kiện — chờ Gap #8 |
| V-09 | Phone đã được account khác xác thực → 30014 (module `user`) | TC-98 | ✅ |
| V-10 | Ưu tiên 30029 trước 30014 | TC-99 ⚠️ (Gap #8) | ✅ |
| V-11 | Thứ tự 30029/30014 so với kiểm tra khóa 30028 | — (tài liệu không nêu) | ⚠️ Gap #8 |

### 2.4 Section 4 — Bậc khóa (`phone_change_lock_steps` / `resend_lock_steps` / `verify_lock_steps`)

| Nội dung | Test case phủ | Đã phủ? |
| --- | --- | --- |
| `phone_change_lock_steps` (5/1′, 10/10′, 20/60′) đủ 3 bậc | TC-26→35 | ✅ |
| `resend_lock_steps` đủ 3 bậc | TC-36→45 | ✅ |
| `verify_lock_steps` đủ 3 bậc | TC-46→55 | ✅ |
| Đổi số/resend: chạm bậc vẫn trả OTP, khóa áp cho request KẾ TIẾP | TC-27, TC-30, TC-33, TC-37, TC-40, TC-43 | ✅ |
| Verify: chạm bậc khóa NGAY lập tức (khác đổi số/resend) | TC-47, TC-50, TC-53 | ✅ |
| Chạm bậc cuối → reset bộ đếm về 0 | TC-33, TC-35, TC-43, TC-45, TC-53, TC-55 | ✅ |
| `failedAttempts` = mốc `attempts` của bậc, không phải counter nội bộ | TC-28, TC-31, TC-34, TC-38, TC-41, TC-44, TC-47, TC-50, TC-53 | ✅ |
| Response lỗi khóa có đủ `failedAttempts/lockMinutes/lockedUntil/remainingSeconds/remainingMinutes` | TC-28, TC-31, TC-34, TC-38, TC-41, TC-44, TC-47, TC-50, TC-53 | ✅ |

### 2.5 Section 6 — Cơ chế cache

| Nội dung | Test case phủ | Đã phủ? |
| --- | --- | --- |
| Cache OTP theo `uuid`; gửi số mới ghi đè cache cũ cùng `uuid` | TC-14, TC-16, TC-63 | ✅ |
| Cache verify/resend theo cặp `uuid+phone` | TC-21, TC-36→45, TC-46→55 | ✅ |
| Cache cooldown/đổi số theo `uuid` | TC-15, TC-25, TC-26→35 | ✅ |
| Verify OK → xóa cache OTP theo `uuid`, **cache resend** và cache verify (attempts + lock) theo cặp `uuid+phone`. *(Sửa 2026-10-02: bản trước ghi "KHÔNG xóa resend cache" — mâu thuẫn với Section 6 spec cũ và tailieu/8)* | TC-59 | ✅ |

### 2.6 Section 1 — BR chuẩn hóa số điện thoại

| Nội dung | Test case phủ | Đã phủ? |
| --- | --- | --- |
| Gọi Zalo dùng `84xxxxxxxxx` | TC-01, TC-90 | ✅ |
| Lưu DB raw sau trim | TC-90 | ✅ |
| Check trùng theo 3 biến thể `0/84/+84` | TC-11❓ (gắn Gap #5) | ⚠️ Phủ có điều kiện — chờ Gap #5 |

### 2.7 Section 7 — Refresh token

| Nội dung | Test case phủ | Đã phủ? |
| --- | --- | --- |
| Tự refresh khi gần hết hạn lúc gửi OTP | TC-79 | ✅ |
| Scheduler 03:00, `auto_refresh_token_enabled=true`, token <2 ngày | TC-84 | ✅ |
| Scheduler không refresh khi flag tắt / chưa tới ngưỡng | TC-85, TC-86 | ✅ |
| Cập nhật `expires_in`+25h, `refresh_expires_in`+3 tháng | TC-79, TC-84 | ✅ |

### 2.8 Section 5 — Admin config screen

| Nội dung | Test case phủ | Đã phủ? |
| --- | --- | --- |
| Hiển thị JSON tổng + input/toggle theo key tồn tại | TC-71 | ✅ |
| Toggle `send_message_enabled` | TC-72 | ✅ |
| Toggle `auto_refresh_token_enabled` | TC-73 | ✅ |
| Cấu hình bậc khóa 3 nhóm | TC-74 | ✅ |
| Nguyên tắc ẩn input khi key không tồn tại | TC-75 | ✅ |
| Ngoại lệ: 3 lock-steps luôn hiển thị mặc định | TC-76 | ✅ |
| a11y (axe + keyboard) | TC-77, TC-78 | ✅ |

### 2.9 Section 8 — Bảng mã lỗi (CONTRACT)

| errorCode | rule | Test case phủ | Đã phủ? |
| --- | --- | --- | --- |
| 30016 | `not_found` | TC-08 | ✅ |
| 30014 | `phone_already_verified` (send-otp + verify) | TC-09, TC-10, TC-11❓, TC-69, **TC-98** | ✅ |
| 30029 (mới 2026-10-02) | `account_already_verified` (module `user`) | **TC-60 (sửa), TC-99** | ✅ |
| 11000 (mới 2026-10-02) | `validation_error` (rule con: `regex` "Mã OTP phải gồm 6 chữ số") — **chỉ cho verify** theo tailieu/8 | **TC-91→97** (verify). Send-otp (TC-04, TC-06) KHÔNG tính vào coverage 11000 — chưa có evidence/xác nhận (Gap #6) | ✅ |
| 30025 | `otp_expired` | TC-56, TC-58, TC-62, TC-68 (TC-60 chuyển sang 30029) | ✅ |
| 30026 | `otp_mismatch` | TC-57, TC-63 | ✅ |
| 30027 | `otp_invalid` (+ `errors.failedAttempts`) | TC-46, TC-49, TC-52, TC-102 | ✅ |
| 30018 | `otp_cooldown` | TC-15, TC-25 | ✅ |
| 30019 | `phone_change_locked` | TC-17, TC-28, TC-31, TC-34 | ✅ |
| 30020 | `otp_resend_locked` | TC-22, TC-38, TC-41, TC-44 | ✅ |
| 30028 | `otp_verify_locked` | TC-47, TC-48, TC-50, TC-51, TC-53, TC-54 | ✅ |
| 30017 | `config_error` | TC-83 | ✅ |
| 30021 | `refresh_config_error` | TC-80 | ✅ |
| 30022 | `refresh_token_expired` | TC-81 | ✅ |
| 30023 | `refresh_token_failed` | TC-82 | ✅ |
| 30024 | `send_otp_failed` (khác `-118`) | TC-19, TC-23, TC-25, TC-89 | ✅ |
| 30015 | `send_otp_failed` (`-118`) | TC-18, TC-23 | ✅ |

**errorCode coverage: 17/17 = 100%** (15 mã cũ + 30029 + 11000; 11000 chỉ tính cho verify TC-91→97; 30029 phủ có điều kiện Gap #8).

**acWithoutCase[] = []** (mọi Section/S-step/errorCode đều có ≥1 case; chỉ TC-11 và TC-67 bị gắn ❓ chờ gap, không loại bỏ khỏi ma trận vì vẫn có case khác phủ cùng dòng).

---

## 3. Clarification gaps — cần BA/BE trả lời trước khi execute

> Theo anti-hallucination rule #4: AC mơ hồ → báo gap, KHÔNG tự đoán rồi viết case xanh.
> 5 gap đầu kế thừa từ TP-ZALO-OTP §5; gap #6, #7 phát hiện thêm trong lúc thiết kế case (rule #5).

| # | Gap | Case bị chặn/ảnh hưởng | Owner | Đề xuất của QA |
| --- | --- | --- | --- | --- |
| 1 | `phone_verify_bypass_ips` áp ở bước nào (S2/S3 hay middleware riêng)? | Không viết được case cho cơ chế bypass IP — out-of-scope-pending-spec | BA | — |
| 2 | Section 5 (Admin) thiếu validation rule/error message cho JSON editor (JSON sai cú pháp, thiếu field, sai kiểu) | Không viết case Error cho form JSON editor (chỉ viết Happy ở TC-71→76) | BA | Định nghĩa rõ thông điệp lỗi trước khi viết case Error + a11y cho lỗi đó |
| 3 | Scheduler `zalo:refresh-otp-token` refresh fail giữa chừng (Zalo timeout khi refresh) — access token cũ còn dùng được không, có retry/alert không? | Không viết được case Error cho "refresh-token-failed-mid-scheduler" chi tiết hơn TC-82 | BA/BE | — |
| 4 | Thiếu FE UI spec cho form nhập phone/OTP end-user | a11y cho form end-user KHÔNG in-scope (chỉ Admin — TC-77/78) | BA/FE | — |
| 5 | S2-05 (check trùng số): rule so khớp 3 biến thể `0/84/+84` (Section 1) có áp **đủ** ở bước check trùng không? | TC-11 ❓ | BE | Áp đủ 3 biến thể ở S2-05 để tránh bypass check trùng số bằng đổi định dạng |
| 6 (**còn mở; cập nhật theo review 2026-10-02**) | S2-01/S2-02 (send-otp): validate format `uuid`/`phone` không có errorCode trong Section 8; tailieu/8 chỉ nói về verify (11000) nên không tự suy sang send-otp. *Ghi chú:* QA từng quan sát 11000 khi gửi cả uuid và phone rỗng (2026-09-30, dev) nhưng **chưa lưu evidence** — cần chạy lại có evidence hoặc BA xác nhận | TC-04 ❓, TC-06 ❓ (chỉ assert HTTP 400 + lỗi ở field); TC-05, TC-07 (chưa chốt mã lỗi) | BE/BA | Xác nhận send-otp dùng 11000 hay mã khác; message/regex phone, uuid |
| 7 (mới) | **Rủi ro bảo mật:** `verify_lock_steps` khóa theo cặp `uuid+phone`; vì `phone_change` cho phép đổi số (tới khi chạm `phone_change_lock`), attacker có thể đổi số liên tục để "làm mới" bộ đếm verify cho từng cặp mới, né được `verify_lock` sớm hơn dự kiến (chỉ bị chặn cuối cùng bởi `phone_change_lock`, không phải `verify_lock`) | TC-67 ❓ | BA + Security | Cân nhắc khóa verify theo `uuid` (không chỉ theo cặp) hoặc giới hạn số cặp `phone` được thử verify trong 1 chu kỳ trước khi khóa toàn `uuid` |
| 8 (mới 2026-10-02) | tailieu/8 không nêu **thứ tự kiểm tra** giữa 30029/30014 và kiểm tra khóa verify 30028 (account đã verify hoặc phone trùng nhưng cặp `uuid+phone` đang bị khóa thì trả mã nào?). Cũng chưa rõ 30029/30014 có được tính vào bộ đếm khóa verify không (tài liệu chỉ liệt kê 30025/30026/30027) và thứ tự so với 30025/30026/30027 (TC-60 giả định 30029 trả trước khi tìm OTP cache) | V-11; chưa viết case (không đoán) | BE | Hỏi BE thứ tự ưu tiên đầy đủ của các bước kiểm tra trong verify |

---

## 4. Return block (cho qa-orchestrator / qa-reviewer)

```yaml
status: gaps
casesPath: "wiki/qa/test-cases/ZALO-OTP.md"
featureId: "ZALO-OTP"
specPath: "wiki/document/srs/ZALO-OTP.md"
planPath: "wiki/qa/test-plans/TP-ZALO-OTP.md"
specPaths: ["wiki/document/srs/ZALO-OTP.md", "tailieu/8-verify-ma-otp.md (2026-10-02 09:36:42 +07)"]
totalCases: 102
casesByBranch: { happy: 22, edge: 43, error: 34, a11y: 2, perf_smoke: 3 }   # đếm xấp xỉ theo nhãn (có nhãn kép); số TC chuẩn = totalCases = 102
casesAddedThisUpdate: [TC-ZALO-OTP-91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102]
casesModifiedThisUpdate: [TC-ZALO-OTP-04, 06, 46, 49, 52, 59, 60]
securityTestCases: [TC-ZALO-OTP-13, TC-ZALO-OTP-27, TC-ZALO-OTP-28, TC-ZALO-OTP-30, TC-ZALO-OTP-31, TC-ZALO-OTP-33, TC-ZALO-OTP-34, TC-ZALO-OTP-37, TC-ZALO-OTP-38, TC-ZALO-OTP-40, TC-ZALO-OTP-41, TC-ZALO-OTP-43, TC-ZALO-OTP-44, TC-ZALO-OTP-47, TC-ZALO-OTP-48, TC-ZALO-OTP-50, TC-ZALO-OTP-51, TC-ZALO-OTP-53, TC-ZALO-OTP-54, TC-ZALO-OTP-66, TC-ZALO-OTP-67, TC-ZALO-OTP-68]
blockedByGap: 4            # TC-04, TC-06 (Gap #6), TC-11 (Gap #5), TC-67 (Gap #7) (❓); phụ thuộc Gap #8 (⚠️): TC-60, TC-99
acCovered: "Section 2 (S2-01..18 + 6 BR), Section 3 (S3-01..10), Section 4 (3 nhóm lock-steps đủ 3 bậc), Section 5 (Admin happy + a11y), Section 6 (cache), Section 7 (refresh token), Section 1 (BR phone), Section 8 + tailieu/8 (17/17 errorCode, gồm 30029 và 11000) — xem chi tiết §2"
acWithoutCase: []
errorCodesCovered: [11000, 30014, 30015, 30016, 30017, 30018, 30019, 30020, 30021, 30022, 30023, 30024, 30025, 30026, 30027, 30028, 30029]   # 11000 chỉ verify; 30029 phủ có điều kiện Gap #8
errorCodesNotApplicable: []
clarificationGaps:
  - { issue: "phone_verify_bypass_ips áp ở bước nào (S2/S3 hay middleware riêng)", owner: "BA" }
  - { issue: "Section 5 Admin thiếu validation rule/error message cho JSON editor", owner: "BA" }
  - { issue: "Hành vi khi scheduler refresh token fail giữa chừng", owner: "BA + BE" }
  - { issue: "Thiếu FE UI spec form nhập phone/OTP end-user", owner: "BA + FE" }
  - { issue: "S2-05 rule so khớp 3 biến thể 0/84/+84 có áp đủ ở bước check trùng số không", owner: "BE" }
  - { issue: "Gap #6 (còn mở): send-otp validate uuid/phone chưa có mã lỗi chính thức (TC-04→07 ❓/chưa chốt). Ghi chú: QA từng quan sát 11000 khi gửi cả uuid và phone rỗng (2026-09-30, dev), chưa lưu evidence — cần chạy lại có evidence hoặc BA xác nhận", owner: "BA + BE" }
  - { issue: "Gap #8 (mới): thứ tự kiểm tra 30029/30014 so với khóa verify 30028 (và có tính vào bộ đếm khóa không) — tailieu/8 không nêu", owner: "BE" }
  - { issue: "Rủi ro bảo mật: đổi số có thể làm mới bộ đếm verify_lock theo cặp uuid+phone, né lock sớm hơn dự kiến", owner: "BA + Security" }
notes:
  - "Spec dùng nguyên errorCode 30014-30028 (Section 8) — không tự chế ERR-<NNN>-xx, theo tiền lệ Z-02."
  - "Verify lock (S3-07) khóa NGAY khi chạm bậc, khác đổi số/resend (S2-17) chỉ khóa request kế tiếp — 2 case nhóm BVA (D/E vs F) viết theo 2 hành vi khác nhau, không dùng chung template."
  - "TC-18, TC-19, TC-23, TC-79, TC-82, TC-84 thuộc cross-service-e2e (phụ thuộc Zalo thật/mock) — cần môi trường staging với số điện thoại test thật đã đăng ký Zalo theo TP-ZALO-OTP mục 3."
  - "File này là test DESIGN (shift-left) — chạy song song BE/FE build, không chờ be.done/fe.done (chưa có FEAT spine)."
nextAction: "⏸ user duyệt test-cases; BA/BE trả lời 8 gap ở §3 (đặc biệt Gap #7 security, Gap #8 thứ tự kiểm tra verify, Gap #6 xác nhận 11000 cho send-otp) → cập nhật TC-11/TC-67 → parent dispatch qa-automation-builder (P4, case ổn định: TC-01, TC-08→10, TC-14→25, TC-46→70 phần core) / qa-test-executor (P5, khi deps.qa thỏa)"
```

---

## 5. Lịch sử cập nhật

| Ngày | Người | Nội dung |
| --- | --- | --- |
| 2026-10-02 | QA | Cập nhật theo tailieu/8-verify-ma-otp.md: thêm errorCode 30029 (`account_already_verified`, ưu tiên trước 30014) và 11000 (validation, otp regex 6 số); **sửa** TC-60 (30025 → 30029), TC-59 (bổ sung xóa cache resend; sửa §2.5), TC-46/49/52 (thêm `failedAttempts`), TC-04/06 (kỳ vọng 11000 theo quan sát thực tế 2026-09-30, chờ BA xác nhận); **thêm** TC-91→TC-102 (12 case: 7 validation 11000, 30014 verify, ưu tiên 30029, 2 chuẩn hóa phone, failedAttempts lần 1); gap #6 trả lời một phần, thêm gap #8 (thứ tự 30029/30014 vs khóa 30028); tổng 90 → 102 case, errorCode 15 → 17. *(Dòng TC-04/06 và gap #6 ở trên đã bị thay bởi dòng review bên dưới.)* |
| 2026-10-02 | QA | Sửa theo review lần 1: TC-04/06 đưa về ❓ phụ thuộc Gap #6 (chỉ assert HTTP 400 + lỗi ở field, bỏ 11000/rule/message; QA từng quan sát 11000 nhưng chưa có evidence); bỏ 11000 send-otp khỏi bảng mã lỗi/coverage; bỏ TC-60 khỏi dòng S3-04; TC-60 và TC-99 gắn ⚠️ phụ thuộc Gap #8; TC-46/49/52 ghi chú failedAttempts suy diễn từ mẫu; TC-91/97 "không tăng bộ đếm" đổi thành "chưa xác nhận"; số đếm nhánh ghi rõ là xấp xỉ, số TC chuẩn 102; số case ❓ = 4 (TC-04, 06, 11, 67). |
