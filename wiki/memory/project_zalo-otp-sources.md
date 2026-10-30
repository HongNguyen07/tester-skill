---
name: ZALO-OTP nguồn spec theo endpoint
type: project
discipline: QA
---

Spec chi tiết ZALO-OTP theo từng endpoint nằm ở `tailieu/`:
- `tailieu/7-send-ma-otp.md` — send-zalo-otp
- `tailieu/8-verify-ma-otp.md` — verify-zalo-otp (đổi 2026-10-02 09:36:42 +07)

Test case: `wiki/qa/test-cases/ZALO-OTP.md` (102 case) + `ZALO-OTP-nghiep-vu.md`. Môi trường test: base URL api-dev.
Khi tài liệu tailieu/ đổi, đối chiếu lại errorCode + gap (#5–#8) trước khi chạy.
Khi probe API thực tế, lưu evidence ngay (xem HB-006).
