---
feature: G032 — Đổi tên gợi nhớ (liên hệ, hội thoại cá nhân)
specVersion: v1.0 (Last updated ghi trong file = 2026-09-22), Status Draft, Owner BA Trân, Priority "Cao — khách yêu cầu"
source: tailieu/G032 - Đổi tên gợi nhớ (1).md   # BẢN HIỆU LỰC — user xác nhận 2026-10-07
referenceOnly: tailieu/G032 - Đặt tên gợi nhớ.md (v1.0, Last updated 2026-10-02)   # KHÔNG hiệu lực, chỉ tham khảo (xem Q-23)
plan: chưa có (spec thuần nghiệp vụ, §8/§9 N/A — không có data model / API contract)
createdBy: QA
createdAt: 2026-10-07
updatedBy: QA
updatedAt: 2026-10-07
phase: 1 — Intake & câu hỏi làm rõ (CHƯA viết plan / case)
status: high-risk-pending-confirmation
lane: high-risk
---

# INTAKE — G032: Đổi tên gợi nhớ

> Chỉ rà soát tài liệu + lập câu hỏi. Không có test plan / test case ở file này.
> **Hai bản G032 (gọi theo tên, KHÔNG gọi "cũ / mới" vì ngày ngược nhau):**
> - **G032(1)** = `G032 - Đổi tên gợi nhớ (1).md` — **BẢN HIỆU LỰC** (user xác nhận 2026-10-07, dù Last updated 2026-09-22 cũ hơn).
> - **G032-Đặt** = `G032 - Đặt tên gợi nhớ.md` — **KHÔNG hiệu lực**, chỉ tham khảo (Last updated 2026-10-02).
>
> **Quy ước trích dẫn:** `(1) dòng n` = số dòng trong G032(1); `Đặt dòng n` = số dòng trong G032-Đặt; `<G-spec> dòng n` = số dòng trong file tương ứng ở `tailieu/`; `§n` = mục của G032(1).
> **Các file trong `tailieu/` là BẢN DUY NHẤT** (user xác nhận): số version mà tài liệu khác dẫn (G006 v1.6, G007 v1.2 / v1.3…) chỉ là các lần sửa trực tiếp trên docs. G001, G002, G003, G006, G007, G008, G010, G011, G017… trong `tailieu/` là **spec hiện hành** — mâu thuẫn giữa G032(1) và các spec đó là mâu thuẫn THẬT.
> Câu hỏi chỉ ghi chỗ thật sự thiếu / mâu thuẫn / không có ngưỡng đo được. Không tự chế AC.
> Mã Q-01…Q-22 GIỮ NGUYÊN theo intake lần 1; câu mới đánh từ Q-23. Câu đã đóng không bị xoá, chỉ đổi trạng thái.

---

## 0. Intake tóm tắt (test-risk) — chấm lại theo G032(1)

| Mục | Giá trị |
|---|---|
| **AC-source** | OK. §11 của G032(1) có **48** checkbox AC (G032-Đặt: 34), §4 AF01–AF07, §5 E01–E07 (kèm thông báo nguyên văn), §6 BR01–BR14, §10 UI. Không có Given/When/Then nhưng đủ testable theo tiền lệ Z-02. KHÔNG `blocked-no-ac`. |
| **Lane** | `high-risk` (không đổi so với intake lần 1) |
| **Flags (5)** | `security-test`, `multi-tenant-isolation`, `cross-service-e2e`, `regression-scope`, `flaky-risk` (giữ nguyên; căn cứ đã đổi theo G032(1)) |
| **Hard gates** | `security-test`, `multi-tenant-isolation`, `cross-service-e2e` (giữ nguyên) |
| **Flag KHÔNG bật** | `no-ac-source`. **`data-integrity` CHƯA bật** — điều kiện bật ghi ở "Kiểm Q-15" ngay dưới. |
| **Lý do** | 5 flag (>= 4) + 3 hard gate. G032(1) nặng về cross-service: ghi **song song lên TẤT CẢ tài khoản Zalo** đã kết bạn với liên hệ (BR08, §15), tự ghi khi sự kiện kết bạn (BR11), kéo ngược qua G006 (BR09), cô lập workspace (BR01), quyền xem hội thoại / xem danh bạ (BR06). Đụng tính năng đã ship: G003, G006, G007 (Option card Danh bạ), G011, G017, thông báo G019/G022/G027. |
| **Contradiction cờ** | (1) Spec tự mô tả "thuần nghiệp vụ" nhưng chạm quyền + tenant + hệ thống ngoài → nâng flag theo nội dung thực. (2) G032(1) **mâu thuẫn với nhiều spec hiện hành** (G006, G007, G011, G010, G017, CR-001, G003) — xem mục 3.H. (3) G032-Đặt (không hiệu lực) ghi 3 sự kiện khác G032(1) và có vẻ là số đo thực → Q-23. |
| **Test depth** | Normal (Happy/Edge/Error đủ AC) + exploratory + a11y + automation regression + confirm scope với user |
| **Test types đề xuất** | acceptance · system · e2e · regression · exploratory · a11y · perf-smoke (3 s ghi song song + 3 s realtime) |
| **Out of scope QA** | unit / integration / contract (dev sở hữu); full load test; pentest (chỉ negative test phân quyền qua API) |
| **Skills đề xuất** | qa-test-design · qa-test-types · qa-e2e-playwright · qa-api-test · qa-test-data · qa-defect · qa-exit-criteria |
| **Execution gate** | **OQ01 của G032(1) ((1) dòng 399): "Hub/Zalo có API GHI tên gợi nhớ không?" — ⏳ Chờ dev, CHẶN BUILD.** Không có API ghi thì BR03/BR08 bất khả thi và toàn bộ nhóm AC "Ghi lên Zalo" vô hiệu. Case phụ thuộc OQ01, OQ02 và các Q chặn ở dưới đánh dấu "chưa chốt", không tính là đã phủ. |

### Lý do từng flag (theo G032(1))

| Flag | Căn cứ trong spec |
|---|---|
| `security-test` | BR06 + E02 (ẩn ✎; thiếu cả quyền xem hội thoại lẫn danh bạ → toast + ghi log; AC (1) dòng 309 "gọi API thẳng → từ chối + ghi log"); **ghi lên tài khoản Zalo mà người dùng có thể không được gán** (Q-27); CR-001 dòng 167/169 |
| `multi-tenant-isolation` | BR01, AC (1) dòng 286 "workspace khác không thấy", §1 "Ai nhìn thấy", G010 BR02/BR06 (dữ liệu theo workspace; relink chỉ khôi phục workspace hiện tại) |
| `cross-service-e2e` | BR08 ghi N tài khoản Zalo song song, BR09 + G006, BR11 sự kiện kết bạn (G007), BR12 + G017, BR04 + thông báo (G019/G022/G027), BR13 + G010 |
| `regression-scope` | §13 liệt kê **7 spec phụ thuộc** ((1) dòng 378–384: G001, G002, G003, G006, G007, G011, G017) và **9 spec được phụ thuộc** ((1) dòng 390–391: G003, G007, G008, G011, G017, G020, G022, G027, G029); G007 Option card còn mục *Đổi tên* (nay là entry point UC-02); G011 ✎; "Breaking change: Có" ((1) dòng 420) |
| `flaky-risk` | §15 (≤3 s ghi song song, ≤3 s realtime), AF04 race 2 nhân sự, BR11 ghi tự động khi sự kiện kết bạn + thử lại ở lần đồng bộ kế tiếp, E04 hết giờ, realtime đa client |

### Kiểm Q-15 (migration dữ liệu tên cũ) — điều kiện bật `data-integrity`

- **Chưa xác nhận có dữ liệu cũ phải chuyển** → KHÔNG bật `data-integrity`. G032(1) §16 ghi "Data migration: Không cần làm gì" ((1) dòng 419).
- **Điều kiện để BẬT `data-integrity` (hard gate): BA/Dev xác nhận G007 hiện hành — tính năng "Đổi tên" ở Danh bạ — ĐÃ ship / đang chạy, và vì vậy có tên nội bộ cũ trong hệ thống cần chuyển (hoặc đẩy lên Zalo).** Căn cứ G007 hiện hành mô tả tính năng này là đang có:
  - G007 dòng 90 (UC-04 bước 3): Option gồm **Gắn thẻ, Đổi tên, Xóa bạn**.
  - G007 dòng 145 (BR03): *"Danh bạ lưu nội bộ hệ thống — đổi tên, gắn thẻ trong Gopany không ảnh hưởng dữ liệu trên Zalo"*; dòng 298 (AC): *"Đổi tên → lưu nội bộ, không ảnh hưởng Zalo (BR03)"*; dòng 353 (Notes).
  - Ngược lại, G011 dòng 17 ghi ✎ Đổi tên gợi nhớ **"tạm thời chưa làm trong tuần này"** và dòng 274 ghi *"Tên gợi nhớ (alias) là dữ liệu mới; không ảnh hưởng dữ liệu chat cũ"* — hai spec hiện hành nói khác nhau về việc đã có dữ liệu tên hay chưa.
- G032(1) §16 khẳng định tên đặt trên app Zalo "đã về hệ thống qua G006" ((1) dòng 419) nhưng G006 hiện hành không có chữ nào về tên gợi nhớ / alias (Q-26).
- **Ứng viên bật thêm (để user quyết):** Q-24 — ghi N tài khoản không nguyên tử, có thể để Zalo và hệ thống lệch nhau; Gỡ tên xoá tên trên tất cả tài khoản Zalo không hoàn tác được (OOS04: không lưu lịch sử). Nếu bật thì `data-integrity` là hard gate (đã nằm trong 4 hard gate QA); lane vẫn high-risk.

---

## 0A. DIFF: G032-Đặt (KHÔNG hiệu lực) → G032(1) (HIỆU LỰC)

> Kết luận ngắn: **G032(1) KHÔNG phải G032-Đặt cộng thêm.** Hai bản khác nhau ở mô hình cốt lõi (gắn theo cặp tài khoản–liên hệ → dùng chung cấp workspace ghi lên tất cả tài khoản), giới hạn ký tự, điểm vào, xử lý khách chưa kết bạn, chiều Zalo → hệ thống, và G032(1) bỏ hẳn cơ chế đồng bộ không ghi đè. Nhiều AC của G032-Đặt đối nghịch trực tiếp với AC của G032(1). Vì G032-Đặt không hiệu lực, các AC đó **không được dùng làm kỳ vọng**; ba điểm sự kiện có vẻ là số đo thật được giữ thành câu hỏi riêng (Q-23).

### A. Metadata

| Mục | G032-Đặt (không hiệu lực) | G032(1) (hiệu lực) |
|---|---|---|
| Tên file / tiêu đề | "Đặt tên gợi nhớ" | "Đổi tên gợi nhớ" |
| Priority | — | "Cao — khách yêu cầu" |
| Version / Status | 1.0 / Draft | 1.0 / Draft |
| Last updated | 2026-10-02 | 2026-09-22 (cũ hơn 10 ngày nhưng được user xác nhận là hiệu lực) |
| Changelog | 1 dòng, 2026-10-02 | 1 dòng, 2026-09-22 |
| Dung lượng / thời điểm file | 32KB, 09:05 | 39KB, 09:31 |
| Mục số | §2 "Điều kiện & Trigger", §15 "Performance", §16 "Rollout" | §2 "Điều kiện tiên quyết & Trigger", §15 "Performance & Scalability", §16 "Rollout & Migration" |

### B. Thay đổi nền tảng thiết kế (đổi nghĩa)

| # | Chủ đề | G032-Đặt (không hiệu lực) | G032(1) (hiệu lực) | Hệ quả test |
|---|---|---|---|---|
| 1 | **Đơn vị gắn tên** | Cặp *(tài khoản Zalo, liên hệ)*; "Mỗi liên hệ chỉ thuộc một tài khoản" (Đặt dòng 43–45) | Dữ liệu **cấp workspace**, một giá trị cho liên hệ; liên hệ có thể là bạn của nhiều tài khoản ((1) dòng 142; G007 BR04) | AC Đặt dòng 213 "liên hệ ở tài khoản B giữ nguyên" bị đảo; không dùng |
| 2 | **Ghi lên Zalo** | Đúng **một** tài khoản (Đặt BR07) | **TẤT CẢ tài khoản liên quan**, song song; lỗi ở bất kỳ tài khoản nào → không lưu gì ((1) BR08, §15) | Cần ≥ 3 tài khoản Zalo thật cùng là bạn của 1 liên hệ; Q-24, Q-25 |
| 3 | **Điểm vào** | **Một** chỗ: ✎ panel; Danh bạ chỉ hiển thị (Đặt BR02, OOS10, AF03) | **Hai** chỗ: ✎ panel + Option → **Đổi tên** ở card Danh bạ ((1) dòng 43, UC-02 dòng 71–77, BR02 "một nguồn duy nhất") | AC Đặt dòng 208 "Option không có mục đặt tên" bị đảo |
| 4 | **Khách chưa kết bạn** | Ghi lên Zalo **ngay**, không hàng đợi, "đã đo trên dev ~0,2 s" (Đặt BR09, AF05) | Lưu hệ thống, **không ghi Zalo**, tự ghi khi kết bạn, lỗi im lặng + thử lại ở lần đồng bộ kế ((1) BR11, AF05); OQ02 ⏳ "Zalo có cho ghi người chưa kết bạn không?" | Đảo ngược; điểm sự kiện → Q-23a |
| 5 | **Chiều Zalo → hệ thống** | Tín hiệu realtime của Zalo, ≤ 5 s, ghi đè; G006 chỉ là lưới an toàn (Đặt BR10, AF08, §15) | **Chỉ qua đồng bộ danh bạ G006** ((1) BR09, OOS05); không còn tín hiệu realtime, AF08, ngưỡng 5 s | Điểm sự kiện → Q-23c; Q-26 |
| 6 | **Đồng bộ không ghi đè tên** | BR14 (ngoại lệ G006 BR06), AF09, OQ03, 4 AC (Đặt dòng 249–252) | **BỎ HẲN** (BR14 của G032(1) = realtime + nền tảng) | Q-14 không còn áp dụng; xem Q-26 |

### C. Thay đổi quy tắc / thông số

| Chủ đề | G032-Đặt (không hiệu lực) | G032(1) (hiệu lực) |
|---|---|---|
| Độ dài tối đa | **50** ký tự, UTF-16, emoji = 2; không bộ đếm (Đặt BR06, E01) | **40** ký tự, **bộ đếm `n/40`** đổi màu khi chạm 40; không nhắc UTF-16 / emoji ((1) BR07, E01). Lý do: "40 là đúng giới hạn Zalo" ≠ Đặt "50 là giới hạn ô nhập Zalo PC" → Q-23b |
| Chuẩn hoá chuỗi | Cắt hai đầu **và bỏ ký tự điều khiển**; **giữ** khoảng trắng trong: `"  Chị  Hồng  "` → `"Chị  Hồng"` | Trim đầu/cuối **và thu gọn khoảng trắng liên tiếp**; không nhắc ký tự điều khiển: → `"Chị Hồng"` ((1) dòng 298) |
| Quyền | Được **gán** vào tài khoản của liên hệ; Admin luôn có (Đặt BR05) | Quyền **xem hội thoại hoặc xem danh bạ** ((1) BR06); vẫn không cần "Quản lý tài khoản Zalo"; người dùng mục tiêu: Admin/Owner · Nhân sự quản lý · Nhân sự ((1) dòng 31) |
| Điều kiện kết nối | Tài khoản **của liên hệ** CONNECTED (Đặt BR08) | **TẤT CẢ tài khoản liên quan** CONNECTED; bỏ qua chưa kết bạn và DELETED; nhiều tài khoản rớt → "và {n} tài khoản khác" ((1) BR10, E03). Áp cả gỡ tên |
| Tìm kiếm | Tên đang hiển thị **và SĐT**; OQ01 chưa đo (Đặt BR11) | Chỉ **tên đang hiển thị**; **chốt: tên Zalo gốc không ra**; thêm OOS06 ((1) BR12). §16 truyền thông: "có thể không ra" → "sẽ không ra" |
| Gỡ tên | Xoá trắng + **Xác nhận**; xoá hệ thống + Zalo | Xoá trắng + **Lưu**; xoá hệ thống + **tất cả tài khoản Zalo** ((1) BR05, AF02) |
| Không tự gỡ tên | Xoá bạn / mất kết nối / xoá tài khoản không xoá tên trên Zalo (Đặt BR13) | Không bao giờ tự gỡ; khách không bao giờ kết bạn → giữ mãi; liên kết lại → tên trên Zalo còn nguyên nên đồng bộ mang về ((1) BR13, §7) |
| Máy trạng thái §7 | "N/A", 2 tình huống | "N/A" nhưng liệt kê **3 tình huống** (thêm: có tên gợi nhớ, chưa ghi lên Zalo — vĩnh viễn nếu không bao giờ kết bạn) ((1) dòng 152–162) |

### D. UI / UX

| Chủ đề | G032-Đặt (không hiệu lực) | G032(1) (hiệu lực) |
|---|---|---|
| Hộp / màn | "Hộp Đặt tên gợi nhớ" giống Zalo PC: avatar, câu *"Hãy đặt cho {tên Zalo} một cái tên dễ nhớ."*, dòng lưu ý có tên tài khoản, nút **Huỷ + Xác nhận** | Màn "Đổi tên gợi nhớ": ô một dòng gạch chân, nút **⊗**, bộ đếm `n/40`, nút **Lưu** full-width, **✕**, **không có Huỷ**; Web = popup giữa màn ~420 px nền mờ; mobile = **bottom sheet** ((1) §10B, §10E) |
| Enter / IME | Enter = Xác nhận, bỏ qua Enter khi đang gõ dấu tiếng Việt | **Không nhắc Enter hay IME** |
| Focus / bôi đen | Focus + bôi đen tên điền sẵn | Chỉ "prefill"; không nói focus / bôi đen |
| Cách đóng không lưu | Huỷ, ✕, Esc | ✕, Esc, **click ra nền mờ** (Web) |
| Dòng lưu ý | **Bắt buộc** trong hộp, nêu tên tài khoản (Đặt dòng 189) | **Chỉ khi mở từ Danh bạ** (§10C): *"Tên này áp dụng cho cả nhóm nhân sự, và hiện cả trên app Zalo. Khách không nhìn thấy."* — đủ **3 ý**. Màn mở từ panel **không** có dòng này ((1) dòng 227–231) |
| Câu "Hãy đặt cho {tên Zalo}…" | Có | Bỏ |
| Vòng quay / chặn bấm lặp | Trong §10B | Chuyển sang §15 |
| ✎ trên panel | Có, chỉ người có quyền, cắt `…` | Giữ; thêm hình panel đầy đủ; cảnh báo nhầm với ✎ Sửa (G011a) giữ nguyên |

### E. Luồng (UC / AF / E)

| Loại | G032-Đặt (không hiệu lực) | G032(1) (hiệu lực) | Ghi chú |
|---|---|---|---|
| UC | UC-01 | **UC-01 + UC-02 (đặt/sửa/gỡ từ Danh bạ)** | UC thêm |
| AF01 | Huỷ / ✕ / Esc | ✕ / Esc (+ click nền ở §10E) | Đổi |
| AF02 | Gỡ tên (Xác nhận) | Gỡ tên (Lưu), xoá trên **tất cả** tài khoản | Đổi |
| AF03 | Danh bạ chỉ hiển thị | "Đổi từ hai nơi: cùng một giá trị" | Đổi nghĩa |
| AF04 | Hai nhân sự cùng đặt, sau thắng | Giữ + "client người kia cập nhật ngay, không báo lỗi" | Làm rõ |
| AF05 | Khách chưa kết bạn: ghi ngay | Khách chưa kết bạn: **hẹn ghi khi kết bạn** | Đảo |
| AF06 | Tài khoản của liên hệ mất kết nối | **Có tài khoản liên quan** mất kết nối; toast nêu tài khoản | Đổi |
| AF07 | Chưa có hội thoại: Nhắn tin rồi đặt ở panel, **không có đường tắt** | Chưa có hội thoại: **đổi tên thẳng từ Danh bạ** | Đảo |
| AF08 | Đặt/gỡ tên trên app Zalo → về hệ thống gần như ngay | **BỎ** | Q-23c |
| AF09 | Bấm Đồng bộ danh bạ không làm mất tên | **BỎ** | Q-26 |
| E01 | > 50 ký tự, không bộ đếm | > **40** ký tự, bộ đếm `40/40` đổi màu | Đổi |
| E02 | Không được gán (ẩn ✎, API → toast + log) | Thiếu cả quyền xem hội thoại lẫn danh bạ (ẩn ✎, toast + log) | Đổi điều kiện |
| E03 | Tài khoản của liên hệ DISCONNECTED | Có tài khoản liên quan DISCONNECTED; "và {n} tài khoản khác" | Đổi |
| E04 | Zalo từ chối (mã khác 221/237) **hoặc hết giờ**; ghi chú "Zalo có thể đã ghi xong, tín hiệu BR10 sẽ đưa tên đúng về" | Zalo từ chối **hoặc không phản hồi**; toast "Không đổi được tên. Vui lòng thử lại."; **mất ghi chú** | Đổi, mất ghi chú |
| E05, E06, E07 | Giữ | Giữ | — |
| E08 (mã 221), E09 (mã 237) | Có, thông báo riêng | **BỎ** (mã Zalo rơi vào E04 chung) | — |

Tổng: AF 9 → 7; E 9 → 7; UC 1 → 2; BR 14 → 14 (đánh số lại); OOS 10 → 9; OQ 3 → 2; AC 34 → 48 (chiều G032-Đặt → G032(1)).

### F. Business Rule — bảng đối chiếu số hiệu

| G032(1) | Nội dung G032(1) | Tương ứng ở G032-Đặt | Trạng thái |
|---|---|---|---|
| BR01 | Dùng chung cấp workspace | BR01 | Giữ |
| BR02 | MỘT nguồn duy nhất, panel + Danh bạ cùng một giá trị | BR02 (một điểm vào duy nhất) | **Đổi nghĩa** |
| BR03 | Ghi vào tên gợi nhớ của Zalo (chỉ chủ tài khoản thấy), không đổi tên thật | (một phần BR03 Đặt) | **Tách ra** |
| BR04 | Khác "Họ tên" G011a; thay tên Zalo ở 7 nơi | BR03 | Đổi số |
| BR05 | Gỡ tên = xoá trắng + Lưu, xoá trên tất cả tài khoản | BR04 | Đổi |
| BR06 | Quyền: xem hội thoại **hoặc** xem danh bạ | BR05 (được gán) | **Đổi** |
| BR07 | 40 ký tự, trim + thu gọn khoảng trắng | BR06 (50, UTF-16, giữ khoảng trắng trong) | **Đổi** |
| BR08 | Ghi lên TẤT CẢ tài khoản liên quan; ghi xong mới lưu | BR07 (đúng một tài khoản) | **Đổi** |
| BR09 | Zalo là nơi lưu chính thức; Zalo → hệ thống chỉ qua G006 | BR10 (tín hiệu realtime) | **Đổi** |
| BR10 | TẤT CẢ tài khoản liên quan CONNECTED | BR08 | **Đổi** |
| BR11 | Chưa kết bạn: lưu hệ thống, hẹn ghi khi kết bạn | BR09 (ghi ngay) | **Đảo** |
| BR12 | Tìm kiếm chỉ theo tên đang hiển thị | BR11 (có SĐT, OQ01) | **Đổi** |
| BR13 | Không tự gỡ tên; không bao giờ kết bạn → giữ mãi | BR13 | Đổi nhẹ |
| BR14 | Realtime; hai người cùng đổi, sau thắng; bottom sheet / popup | BR12 | Đổi số, thêm nền tảng |
| — | (không còn) | BR14 (đồng bộ không ghi đè tên) | **G032(1) BỎ** |

### G. Out of Scope / Open Questions / Hiệu năng / Rollout

| Mục | G032-Đặt (không hiệu lực) | G032(1) (hiệu lực) |
|---|---|---|
| OOS | 10 mục; OOS09 nối liên hệ giữa các tài khoản; OOS10 đặt tên từ Danh bạ | 9 mục; **bỏ OOS09, OOS10**; thêm OOS06 tìm theo tên Zalo gốc; OOS05 = cơ chế kéo tên từ Zalo (G006) |
| Open Questions | OQ01 search theo tên gốc · OQ02 ảnh mobile · OQ03 hub trả alias (đều "không chặn build") | **OQ01: Hub/Zalo có API GHI tên gợi nhớ không? — CHẶN BUILD** · **OQ02: ghi được cho người chưa kết bạn không?** |
| Hiệu năng | Ghi Zalo ≤3 s ("đo ~0,2 s"); realtime ≤3 s; Zalo → hệ thống ≤5 s | Ghi Zalo **song song nhiều tài khoản** ≤3 s, quá thì E04; Lưu chặn bấm lặp; realtime ≤3 s. **Bỏ 5 s và số đo 0,2 s** |
| Rollout | Gỡ mục *Đổi tên* khỏi Option card G007 cùng lúc | **Phát hành đồng thời hai entry point** (panel + Danh bạ) |
| Báo nhân sự | 4 ý (gồm "chỉ áp trên tài khoản Zalo đó"; tìm tên gốc "có thể" không ra) | 3 ý (dùng chung; hiện trên app Zalo, khách không thấy; tìm tên gốc **sẽ** không ra) |
| Phụ thuộc | G006 "lưới an toàn; BR14 ngoại lệ G006 BR06"; G011 điểm vào duy nhất; G003·G007 chỉ hiển thị | G006 "mang tên gợi nhớ từ Zalo về (BR05/BR06)"; G007 = entry point UC-02 + danh sách tài khoản chung bạn + **sự kiện kết bạn** kích hoạt BR11; G011 vị trí ✎ |

### H. Tác động lên intake lần 1

- 22 câu hỏi của intake lần 1 được rà lại ở mục 3 (11 trả lời một phần, 8 vẫn mở, 2 không còn áp dụng, 1 đã trả lời).
- Trích dẫn dòng ở intake lần 1 (viết theo G032-Đặt) không còn khớp; phần dưới ghi lại theo G032(1).
- `wiki/qa/intake/INTAKE-CR-001.md` (dòng 47, 80, 175) đang trích "G032 BR08" cho điều kiện CONNECTED (G032(1) là **BR10**) và "G032 BR06" cho quyền (G032(1) **đúng là BR06**). Nên cập nhật.

---

## 1. Danh sách Use Case (G032(1))

| ID | Tên | Vị trí | So với G032-Đặt |
|---|---|---|---|
| UC-01 | Đặt / sửa / gỡ tên gợi nhớ từ panel phải | §3, (1) dòng 61–69 | Giữ (nội dung đổi) |
| UC-02 | Đặt / sửa / gỡ tên gợi nhớ từ Danh bạ (hover card → Option → Đổi tên) | §3, (1) dòng 71–77 | **Chỉ có ở G032(1)** |

### Luồng phụ (AF) — không phải UC riêng

| ID | Nội dung | Vị trí | So với G032-Đặt |
|---|---|---|---|
| AF01 | Huỷ giữa chừng (✕ / Esc) | (1) dòng 105 | Đổi (bỏ nút Huỷ) |
| AF02 | Gỡ tên (xoá trắng + Lưu), xoá trên hệ thống và tất cả tài khoản | (1) dòng 106 | Đổi |
| AF03 | Đổi từ hai nơi, cùng một giá trị | (1) dòng 107 | Đổi nghĩa |
| AF04 | Hai nhân sự cùng đổi, lưu sau thắng | (1) dòng 108 | Giữ |
| AF05 | Khách chưa kết bạn: lưu hệ thống, tự ghi khi kết bạn, lỗi im lặng | (1) dòng 109 | Đảo |
| AF06 | Có tài khoản liên quan mất kết nối: ✎ vẫn hiện, toast E03 nêu tài khoản | (1) dòng 110 | Đổi |
| AF07 | Liên hệ chưa có hội thoại: đổi tên từ Danh bạ | (1) dòng 111 | Đảo |
| ~~AF08~~ | ~~Đặt/gỡ tên trên app Zalo → về hệ thống~~ | (Đặt dòng 88) | **G032(1) BỎ** |
| ~~AF09~~ | ~~Bấm Đồng bộ danh bạ không làm mất tên~~ | (Đặt dòng 89) | **G032(1) BỎ** |

### Ngoại lệ (E)

E01 quá **40** ký tự · E02 không có quyền · E03 có tài khoản liên quan DISCONNECTED · E04 Zalo từ chối / không phản hồi · E05 mất mạng · E06 lỗi 500 · E07 liên hệ không còn tồn tại ((1) §5, dòng 119–125). ~~E08 (mã 221)~~ ~~E09 (mã 237)~~ G032(1) đã bỏ.

---

## 2. Danh sách Business Rule (G032(1))

| ID | Nội dung rút gọn | Vị trí | So với G032-Đặt |
|---|---|---|---|
| BR01 | Dùng chung cấp workspace; không có tên riêng theo nhân sự | (1) dòng 135 | Giữ |
| BR02 | MỘT nguồn duy nhất: panel và Danh bạ cùng một giá trị, không có hai trường | (1) dòng 136 | **Đổi** |
| BR03 | Ghi vào tên gợi nhớ của Zalo (chỉ chủ tài khoản Zalo thấy); không đổi tên thật trên profile; khách không thấy | (1) dòng 137 | **Tách** |
| BR04 | Khác "Họ tên" của Hồ sơ KH (G011a); thay tên Zalo ở 7 nơi: danh sách hội thoại · header · panel · Danh bạ · tìm kiếm · thành viên nhóm · nội dung thông báo | (1) dòng 138 | Đổi số |
| BR05 | Gỡ tên = xoá trắng + Lưu; xoá trên hệ thống và tất cả tài khoản; không có nút "Gỡ"; Lưu không disabled khi trống | (1) dòng 139 | Đổi |
| BR06 | Quyền xem hội thoại **hoặc** xem danh bạ; không cần "Quản lý tài khoản Zalo" | (1) dòng 140 | **Đổi** |
| BR07 | Tối đa 40 ký tự, chặn tại input, bộ đếm n/40; trim + thu gọn khoảng trắng liên tiếp; không giới hạn loại ký tự | (1) dòng 141 | **Đổi** |
| BR08 | Ghi lên **tất cả tài khoản liên quan** (đã kết bạn + còn tồn tại; bỏ chưa kết bạn và DELETED); Zalo xác nhận xong mới lưu; lỗi ở bất kỳ tài khoản → không lưu gì | (1) dòng 142 | **Đổi** |
| BR09 | Zalo là nơi lưu chính thức; chiều Zalo → hệ thống do G006 BR05/BR06, "cập nhật đè" | (1) dòng 143 | **Đổi** |
| BR10 | TẤT CẢ tài khoản liên quan CONNECTED mới mở màn (đặt lẫn gỡ); không xét chưa kết bạn / DELETED | (1) dòng 144 | **Đổi** |
| BR11 | Chưa kết bạn: lưu hệ thống, chưa ghi Zalo; kết bạn bằng mọi đường → tự ghi tên đang có lên tài khoản đó; lỗi ghi không báo, thử lại ở lần đồng bộ danh bạ kế; là bạn của một số tài khoản, chưa của số khác → ghi số đã là bạn, số còn lại chờ | (1) dòng 145 | **Đảo** |
| BR12 | Tìm kiếm chỉ khớp tên đang hiển thị (có tên gợi nhớ → chỉ tên gợi nhớ), không tìm song song cả hai | (1) dòng 146 | **Đổi** |
| BR13 | Không bao giờ tự gỡ (xoá bạn · DISCONNECTED · DELETED → tên vẫn hiển thị); không bao giờ kết bạn → giữ mãi; liên kết lại cùng `companyId + zaloUid` → tên trên Zalo còn nguyên nên đồng bộ mang về | (1) dòng 147 | Đổi nhẹ |
| BR14 | Realtime mọi client; hai người cùng đổi → sau thắng, không báo lỗi; hành vi đồng nhất Web/Android/iOS; mobile bottom sheet, Web popup (§10E) | (1) dòng 148 | Đổi |
| ~~BR14 (Đặt)~~ | ~~Đồng bộ danh bạ không ghi đè tên gợi nhớ (ngoại lệ G006 BR06)~~ | (Đặt dòng 128) | **G032(1) BỎ** |

Tổng: **14 BR**. Số liệu G032(1): 7 AF, 7 E, 2 UC, 48 AC checkbox, 9 OOS, 2 OQ.

**Khoảng trống AC (ghi nhận để trace):** G032(1) không có AC cho E03 dạng "và {n} tài khoản khác", cho E06 (500), cho AF07, cho dòng chú thích 3 ý ở §10C, cho việc Option card có mục *Đổi tên* (UC-02), và cho ✎ ẩn/hiện theo quyền ngoài dòng 309.

---

## 3. Câu hỏi làm rõ — trạng thái sau khi chốt 2 quyết định của user

Quy ước: **Chặn** = không viết được kỳ vọng pass/fail cho case liên quan nếu chưa trả lời. **Không chặn** = viết được case theo giả định ghi kèm.
Trạng thái: `đã trả lời` · `trả lời một phần` · `vẫn mở` · `không còn áp dụng` · `câu hỏi sai`.

### 3.0 Bảng tổng hợp

| Q | Chủ đề | Trạng thái | Chặn? | Ghi chú ngắn |
|---|---|---|---|---|
| Q-01 | Quyền: tham chiếu chéo + điều kiện lệch CR-001 | **trả lời một phần** (nhánh "CR-001 trỏ nhầm BR06" là câu hỏi sai) | Chặn | CR-001 → "G032 BR06" ĐÚNG với G032(1); còn: "quyền xem danh bạ" không định nghĩa, CR-001 vs BR10 |
| Q-02 | Nhân sự không được gán có thấy tên không | **đã trả lời** | — | §1 "cả workspace" + G007 Danh bạ toàn workspace |
| Q-03 | Quyền/kết nối đổi giữa chừng khi hộp mở | vẫn mở | Không chặn | |
| Q-04 | Gọi API thẳng: mã trả về, log, chéo workspace | vẫn mở | Chặn (security) | §9 vẫn N/A |
| Q-05 | Cách đếm ký tự ở các biên | **trả lời một phần** | Chặn (biên 40) | 50/UTF-16 → 40; đơn vị đếm, paste, server chưa nói |
| Q-06 | Chuẩn hoá chuỗi | **trả lời một phần** | Chặn một phần | còn: toàn khoảng trắng, định nghĩa ký tự |
| Q-07 | Ký tự đặc biệt / escape ở 7 nơi | vẫn mở | Không chặn | |
| Q-08 | Trùng tên; xác nhận khi không đổi | vẫn mở | Không chặn | mỗi lần Lưu = N lần gọi Zalo |
| Q-09 | Số liệu E08 (221) / E09 (237) | **không còn áp dụng** | — | G032(1) bỏ E08, E09 |
| Q-10 | Hết giờ / mất mạng / 500 sau khi Zalo đã ghi | vẫn mở (đổi dạng) | Chặn | mất ghi chú "Zalo có thể đã ghi"; xem Q-24, Q-23c |
| Q-11 | Ngưỡng thời gian | **trả lời một phần** | Không chặn | còn 3 s/3 s; bỏ 5 s |
| Q-12 | Hai nhân sự cùng đặt | **trả lời một phần** | Không chặn | AF04 nói rõ client người kia cập nhật ngay |
| Q-13 | Tìm kiếm: OQ01 + quy tắc khớp | **trả lời một phần** | Không chặn | BR12 chốt "không ra"; quy tắc khớp từ G017; còn Q-31 |
| Q-14 | BR14 / OQ03 đồng bộ không ghi đè | **không còn áp dụng** | — | rủi ro chuyển sang Q-26 |
| Q-15 | Migration "Không cần" nhưng Breaking change "Có" | vẫn mở | Chặn | điều kiện bật `data-integrity`: G007 "Đổi tên" đã ship chưa |
| Q-16 | Phạm vi 7 nơi hiển thị | **trả lời một phần** | Không chặn | G019 dòng 214 nêu rõ; G022/G027 "tên hội thoại" |
| Q-17 | Trạng thái xoá / ẩn / không còn tồn tại | **trả lời một phần** | Chặn (E07) | xem Q-30 |
| Q-18 | BR13 liên kết lại | **trả lời một phần** | Không chặn | G010 BR03/BR06; xem Q-30 |
| Q-19 | Mobile chưa có thiết kế | **trả lời một phần** | Không chặn | bottom sheet + cùng thành phần |
| Q-20 | a11y và hành vi UI | **trả lời một phần** | Không chặn | click nền = đóng; Enter/IME không còn |
| Q-21 | Tên Zalo rỗng và SĐT ẩn | vẫn mở | Không chặn | trích "G003 §10B" không tồn tại |
| Q-22 | Môi trường test | vẫn mở | Chặn thực thi | ≥3 tài khoản Zalo thật; OQ01 chặn build |
| **Q-23** | Ba điểm SỰ KIỆN G032-Đặt ghi khác G032(1) (chưa chắc G032(1) đúng) | **phần "bản nào hiệu lực" ĐÃ ĐÓNG; phần sự kiện MỞ** | Chặn | user chốt G032(1) hiệu lực; BA phải xác nhận từng điểm 23a / 23b / 23c |
| Q-24 | Ghi N tài khoản không nguyên tử | mới — mở | Chặn | |
| Q-25 | Khoá nhận diện "cùng một liên hệ" giữa các tài khoản | mới — mở | Chặn | |
| Q-26 | G006 không có chữ "gợi nhớ / alias" | mới — **mâu thuẫn thật** với G006 hiện hành | Chặn | bảng 3.H |
| Q-27 | Ghi lên tài khoản không được gán; E03 lộ tên | mới — mở | Chặn (security) | |
| Q-28 | G007 / G011 hiện hành còn "đổi tên nội bộ, không ghi Zalo" | mới — **mâu thuẫn thật** | Chặn (hồi quy G007/G011 + popup profile) | nâng từ "Không chặn" → "Chặn một phần"; bảng 3.H |
| Q-29 | BR11: tự ghi khi kết bạn + thử lại vs G006 / G007 | mới — **mâu thuẫn thật** | Chặn | bảng 3.H |
| Q-30 | BR13 vs G010 / G007 / định nghĩa "tài khoản liên quan" | mới — **mâu thuẫn thật** | Chặn | bảng 3.H |
| Q-31 | BR12 "không đụng G017" vs G017 hiện hành | mới — **mâu thuẫn thật** | Không chặn | bảng 3.H |

Đếm (22 câu cũ): đã trả lời **1** · trả lời một phần **11** · vẫn mở **8** · không còn áp dụng **2** · câu hỏi sai **0** (riêng nhánh "CR-001 trỏ nhầm BR06" của Q-01 sai). Câu mới: **9** (Q-23 … Q-31).

---

### A. Phân quyền / security

**Q-01 — Quyền: tham chiếu chéo và điều kiện lệch giữa G032 và CR-001** — **TRẢ LỜI MỘT PHẦN** (Chặn)
- *Hỏi lần 1:* CR-001 trỏ "G032 BR06" nhưng quyền ở BR05 (theo G032-Đặt); CR-001 yêu cầu "assign ≥1 tài khoản CONNECTED" chung; vai trò "Nhân viên quản lý" chưa rõ; Admin có bị BR08 không.
- *Đối chiếu G032(1):*
  - **Nhánh (1) "tham chiếu sai BR06" → CÂU HỎI SAI** theo G032(1): (1) dòng 140 BR06 *"Quyền: có quyền xem hội thoại hoặc xem danh bạ là đổi được. KHÔNG yêu cầu quyền 'Quản lý tài khoản Zalo'"*; CR-001 dòng 167 *"Đặt tên gợi nhớ cho liên hệ … ✓ ✓ ✓ … G032 BR06"* **khớp**.
  - **Nhánh (3) "Nhân viên quản lý" → ĐÃ TRẢ LỜI:** (1) dòng 31 *"Người dùng mục tiêu: Admin/Owner · Nhân sự quản lý · Nhân sự"*.
  - **Nhánh (4) "Admin có bị E03 không" → ĐÃ TRẢ LỜI ngầm:** BR10 ((1) dòng 144) áp cho mọi người dùng, không nêu ngoại lệ Admin.
- *Còn mở:*
  - (a) **"Quyền xem danh bạ" không được định nghĩa ở spec nào.** G007 §2 (dòng 43–45) cho cả 3 vai "Toàn bộ thao tác", OOS07 (dòng 328) "không phân quyền riêng cho từng thao tác trong Danh bạ"; G011 BR08 (dòng 136) lại viết "xem hội thoại / **quản lý** danh bạ". Không có mã quyền "xem danh bạ" ở G001/G002/G007. Nhân sự có "chỉ quyền xem danh bạ" (AC (1) dòng 307) cấu hình bằng cách nào?
  - (b) CR-001 dòng 169 *"Điều kiện chung cho cả 5 dòng: được assign ≥1 tài khoản Zalo đang CONNECTED (G002)"* vs G032(1) BR06/BR10: G032(1) không đòi "được gán", nhưng đòi **tất cả** tài khoản liên quan CONNECTED. Nhân sự gán A (CONNECTED), liên hệ còn là bạn của B (DISCONNECTED) → CR-001 ✓, G032(1) E03.
- *Đề xuất:* lấy G032(1) BR06 + BR10 làm chuẩn, BA sửa dòng 169 CR-001; BA nêu cách cấp "quyền xem danh bạ" hoặc bỏ vế đó.

**Q-02 — Nhân sự không được gán tài khoản có thấy tên gợi nhớ không?** — **ĐÃ TRẢ LỜI**
- *Trả lời:* (1) dòng 26 *"Ai nhìn thấy: Cả workspace, và hiện trên app Zalo của chính nhân sự. Khách không thấy"* + BR01 (dòng 135) *"mọi nhân sự trong workspace thấy tên mới"*; Danh bạ workspace-wide: G007 dòng 295 *"Hiển thị bạn bè của tất cả tài khoản Zalo đang hoạt động trong workspace"*. Tìm kiếm của Staff vẫn giới hạn theo gán: G017 BR03 (dòng 274).
- *Giả định cho case:* tên hiển thị ở mọi nơi nhân sự đó vốn đã thấy liên hệ. Phần "gán" liên quan tới ghi lên Zalo chuyển sang **Q-27**.

**Q-03 — Quyền / kết nối đổi giữa chừng khi hộp đang mở** — **VẪN MỞ** (Không chặn)
- G032(1): E02/E03 vẫn chỉ gắn với bước 1 ((1) dòng 63, 127 *"E02/E03 ← UC-01 b1 · UC-02 b1"*). Không có ca "bỏ gán / đổi vai trò / tài khoản rớt giữa chừng rồi bấm Lưu"; gần nhất là E04 ((1) dòng 122).
- Thêm do G032(1): nay có N tài khoản; một tài khoản rớt giữa chừng → E03, E04 hay lưu một phần (Q-24).
- *Đề xuất:* backend kiểm lại quyền khi lưu → E02; mất kết nối khi lưu → E04/E03, không lưu.

**Q-04 — Gọi API thẳng: mã trả về, log, truy cập chéo workspace** — **VẪN MỞ** (Chặn cho case security)
- G032(1): (1) dòng 120 E02 *"Toast … Icon ✎ ẩn … | Ghi log truy cập trái phép"*; AC dòng 309 *"gọi API thẳng → từ chối + ghi log (AC-E02)"*; §8/§9 N/A ((1) dòng 168). Không có mã HTTP, nơi xem log, hành vi với `contactId` workspace khác, với tên 41+ ký tự, hay với tài khoản DISCONNECTED qua API.
- *Đề xuất:* BA/Dev chốt mã từ chối + nơi xem log; cross-workspace trả không-tìm-thấy hoặc không-có-quyền, không lộ dữ liệu.

### B. Giới hạn, độ dài, ký tự, chuẩn hoá

**Q-05 — Cách đếm ký tự ở các biên** — **TRẢ LỜI MỘT PHẦN** (Chặn cho case boundary)
- *Đã trả lời / thay đổi:* BR07 ((1) dòng 141) *"Tên gợi nhớ tối đa 40 ký tự — chặn tại input, màn hiện bộ đếm n/40"*; E01 (dòng 119); AC dòng 297. **Con số 50 và quy ước UTF-16 / emoji = 2 của G032-Đặt không hiệu lực** → các biên 49/50/51 không áp dụng (nhưng xem Q-23b: 40 hay 50 là sự kiện cần BA xác nhận).
- *Còn mở (đánh lại theo 40):* (1) **đơn vị đếm** — UTF-16, code point hay grapheme; emoji / ZWJ / cờ / NFD; bộ đếm `n/40` đếm theo đơn vị nào. (2) Đang ở 39, gõ 1 emoji → chặn cả emoji hay nhận nửa. (3) **Paste** > 40: cắt hay từ chối (E01 chỉ nói "gõ"). (4) Đếm **trước hay sau** trim / thu gọn. (5) Server kiểm lại khi nhận > 40 (API) và trả lỗi gì — không có mã lỗi trong E01–E07.
- *Đề xuất:* biên 39 / 40 / 41, 20 emoji, 21 emoji, ZWJ sequence, paste 60, ba dấu cách đầu + 40 ký tự.

**Q-06 — Chuẩn hoá chuỗi** — **TRẢ LỜI MỘT PHẦN** (Chặn một phần)
- *Đã trả lời:* BR07 *"trim khoảng trắng đầu/cuối và thu gọn khoảng trắng liên tiếp"*; AC (1) dòng 298 `"  Chị  Hồng  "` → `"Chị Hồng"`. (G032-Đặt giữ khoảng trắng trong → `"Chị  Hồng"`: không hiệu lực, không dùng.)
- *Còn mở:* (1) chuỗi **chỉ toàn khoảng trắng** sau trim: là **gỡ tên** (BR05) hay lỗi? BR05 chỉ nói "xoá trắng ô" ((1) dòng 139). Tiền lệ cùng dự án: G011a BR10 (dòng 121) coi chuỗi chỉ khoảng trắng sau cắt là rỗng. (2) "Khoảng trắng" gồm NBSP, U+3000, tab, xuống dòng? (3) G032(1) **không nhắc "bỏ ký tự điều khiển"** — ZWSP / U+200B–200D / BOM / RTL override có giữ không? (4) Tên có newline khi paste nhiều dòng.
- *Đề xuất:* toàn dấu cách → coi là gỡ (theo G011a BR10) nếu BA xác nhận; case: tab đầu, NBSP hai đầu, paste có newline, ZWSP giữa tên.

**Q-07 — Ký tự đặc biệt / HTML / script / emoji: hiển thị và escape ở 7 nơi** — **VẪN MỞ** (Không chặn)
- BR07 *"Không giới hạn loại ký tự"* ((1) dòng 141) và BR04 7 nơi (dòng 138). Chưa có kỳ vọng hiển thị `<script>`, `{{tên}}`, `'; DROP`, RTL, tên rất dài không ngắt dòng ở danh sách / header / panel / Danh bạ / tìm kiếm / thông báo (§10A chỉ nói cắt `…`).
- *Đề xuất:* hiển thị nguyên văn dạng text, không render / không thực thi, cắt `…` ở chỗ hẹp.

**Q-08 — Trùng tên và "xác nhận khi không đổi"** — **VẪN MỞ** (Không chặn)
- §10B ((1) dòng 219) *"prefill tên gợi nhớ hiện tại (chưa có thì tên Zalo)"*; không nói về trùng tên, trùng tên Zalo gốc, hay bấm Lưu khi không sửa.
- Thay đổi do G032(1): phần "tính vào hạn mức 221" không còn (E08 bỏ). Nhưng mỗi lần Lưu = ghi song song **N** tài khoản; bấm Lưu ngay với prefill là tên Zalo gốc → ghi alias = tên gốc lên N tài khoản, và theo BR12 làm "tìm tên gốc" đổi hành vi.
- *Đề xuất:* BA chốt: không đổi → không gọi Zalo, đóng màn; trùng tên liên hệ khác → cho phép.

**Q-09 — Số liệu của E08 (mã 221) và E09 (mã 237)** — **KHÔNG CÒN ÁP DỤNG**
- G032(1) **xoá E08 và E09** (E-list dừng ở E07, (1) dòng 119–125). Mã lỗi Zalo giờ rơi vào E04 chung (dòng 122) *"Không đổi được tên. Vui lòng thử lại."*. QA chỉ cần mock "Zalo từ chối" → E04 (Q-22). Không còn case riêng "quá số lần/ngày" và "danh sách đầy".

### C. Lỗi, timeout, realtime, đồng thời

**Q-10 — Hết giờ / mất mạng / 500 sau khi Zalo đã ghi** — **VẪN MỞ, ĐỔI DẠNG** (Chặn cho case lỗi)
- G032(1): E04 ((1) dòng 122) *"Zalo từ chối hoặc không phản hồi … KHÔNG lưu gì cả — tên cũ giữ nguyên ở cả hệ thống lẫn Zalo"*. Ghi chú của G032-Đặt "Zalo có thể đã ghi xong dù hệ thống báo lỗi; tín hiệu sẽ đưa tên đúng về" **không có trong G032(1)**, và chiều Zalo → hệ thống chỉ còn G006 thủ công (BR09). E05 / E06 vẫn không nói gì khi lỗi xảy ra **sau** khi Zalo đã ghi.
- *Còn mở:* (1) hết giờ nhưng Zalo thật sự đã ghi → hệ thống giữ tên cũ, Zalo là tên mới: ai đưa về khớp, khi nào. (2) E05 / E06 sau khi Zalo đã ghi. (3) "Hết giờ" tính từ client hay server; §15 nói tổng ≤3 s. (4) Bấm Lưu lại ngay sau E04 có ghi lại lên các tài khoản đã thành công không.
- *Liên quan:* **Q-24**, **Q-23c**.

**Q-11 — Ngưỡng thời gian không thống nhất và chưa nói cách đo** — **TRẢ LỜI MỘT PHẦN** (Không chặn)
- *Đã trả lời:* §15 ((1) dòng 408, 410): ghi Zalo song song ≤ **3 s** (quá → E04); realtime mọi client ≤ **3 s** (BR14). G032(1) không còn ngưỡng 5 s và số "~0,2 s".
- *Còn mở:* AC dòng 347 "ngay, không cần reload" không nêu số; đo p100 hay p95, N lần, điều kiện mạng; "≤3 s" từ lúc bấm Lưu hay từ lúc Zalo xác nhận; số tài khoản tối đa trong 3 s.
- *Đề xuất:* dùng §15, đo 10 lần với 1 và 3 tài khoản, tất cả ≤ ngưỡng (perf-smoke).

**Q-12 — Hai nhân sự cùng đặt: định nghĩa "sau" và hiển thị cho người thua** — **TRẢ LỜI MỘT PHẦN** (Không chặn)
- *Đã trả lời:* AF04 ((1) dòng 108) *"lần lưu sau thắng — người lưu sau ghi đè lên Zalo, client của người kia cập nhật ngay, không báo lỗi"*; BR14 (dòng 148).
- *Còn mở:* "sau" theo thời điểm bấm hay Zalo xác nhận; người thua đang mở màn nhập với nội dung cũ thì màn có đổi không; hai người ghi song song N tài khoản có thể xen kẽ (A thắng ở tài khoản X, B thắng ở Y) → trạng thái cuối có nhất quán không (Q-24).
- *Đề xuất:* thắng = thứ tự Zalo xác nhận; trạng thái cuối nhất quán ở mọi client và mọi tài khoản.

### D. Tìm kiếm

**Q-13 — Tìm kiếm: OQ01 chưa đo; thiếu quy tắc khớp** — **TRẢ LỜI MỘT PHẦN** (không còn chặn)
- *Đã trả lời:* G032(1) không còn OQ01 tìm kiếm. BR12 ((1) dòng 146) *"Tìm kiếm chỉ khớp theo tên đang hiển thị … Không tìm song song cả hai"*; AC dòng 334 *"gõ tên Zalo gốc không ra"*; OOS06 (dòng 365); §16 (dòng 421).
- *Quy tắc khớp từ G017 hiện hành:* tối thiểu 2 ký tự (BR01, dòng 272); gõ không dấu vẫn ra có dấu (BR15, dòng 286); SĐT 9–12 chữ số, so 9 chữ số cuối (BR02, dòng 273); phạm vi Staff theo gán (BR03, dòng 274). G032(1) BR12 không nhắc SĐT (G032-Đặt có) — không mâu thuẫn vì G017 BR02 vẫn xử lý SĐT.
- *Còn mở:* phần G017 phải sửa thế nào — xem **Q-31**.

### E. Đồng bộ, dữ liệu đã có, migration

**Q-14 — BR14 / OQ03: kỳ vọng đồng bộ danh bạ phụ thuộc nhánh chưa chốt** — **KHÔNG CÒN ÁP DỤNG**
- G032(1) **bỏ BR14 của G032-Đặt (ngoại lệ G006 BR06), OQ03, AF09 và 4 AC đồng bộ** (Đặt dòng 249–252). BR14 của G032(1) nói về realtime / nền tảng.
- Rủi ro chuyển hướng, không biến mất: G032(1) giả định G006 đã mang tên gợi nhớ về nhưng G006 hiện hành không nói vậy, và đã mất hàng rào "đồng bộ không ghi đè tên gợi nhớ". Xem **Q-26**.

**Q-15 — §16: Migration "Không cần" nhưng Breaking change "Có"** — **VẪN MỞ** (Chặn cho regression / dữ liệu cũ)
- *G032(1):* (1) dòng 419 *"Data migration: Không cần làm gì. Tên gợi nhớ nhân sự đã đặt sẵn trên app Zalo vốn đã về hệ thống qua đồng bộ danh bạ (G006); G032 chỉ bổ sung đường đặt tên từ hệ thống lên Zalo"*; dòng 420 *"Breaking change: Có — tên gợi nhớ vốn do từng người đặt trên máy mình, nay thành dữ liệu dùng chung cả team và nhân sự khác sửa được"*.
- *Đối chiếu spec hiện hành:*
  - G007 dòng 90, 145, 298, 353: Danh bạ **đã có** Đổi tên "lưu nội bộ, không ghi Zalo" → nếu tính năng này đã chạy thì **đã có tên nội bộ cũ**; §16 không nói số phận chúng (giữ? đẩy lên Zalo? bỏ?).
  - G011 dòng 17 / 274: ✎ "chưa làm trong tuần này"; alias "là dữ liệu mới" — spec hiện hành tự nói hai kiểu.
  - G006 không nhắc alias (Q-26) nên "đã về qua G006" không kiểm chứng được.
  - Lúc phát hành, cùng một liên hệ có thể có alias khác nhau trên các app Zalo khác nhau; hệ thống chỉ có **một** giá trị cấp workspace (BR01) — giá trị nào thắng (cũng Q-26).
- *Còn mở, chờ BA/Dev:* (a) **G007 "Đổi tên" ở Danh bạ đã ship / đang chạy chưa**; (b) quy tắc chọn giá trị khi nhiều tài khoản có alias khác nhau lúc đồng bộ đầu; (c) có đẩy tên nội bộ cũ lên Zalo không.
- *Điều kiện bật flag:* nếu (a) = có và có dữ liệu cần chuyển → **bật `data-integrity` (hard gate)**. Hiện CHƯA bật.

**Q-16 — Phạm vi "mọi nơi hiển thị" (BR04) và dữ liệu lịch sử** — **TRẢ LỜI MỘT PHẦN** (Không chặn)
- G032(1): BR04 ((1) dòng 138) 7 nơi gồm "nội dung thông báo"; §13 (dòng 390–391) *"G003 · G007 · G008 · G011 · G017 · G020 → hiển thị tên; G022 · G027 · G029 → nội dung thông báo dùng tên hiển thị theo BR04"*.
- *Đối chiếu:* G019 dòng 214 **nói rõ** *"Tên hội thoại = tên người/nhóm hoặc tên gợi nhớ"* (G019 **không** nằm trong §13 của G032). G022 dòng 88, G027 dòng 51, 86 chỉ dùng "tên hội thoại"; G020 và G029 không có chỗ hiển thị tên liên hệ. G007 §8 (dòng 240–242) thông báo kết bạn dùng "[Tên]". G030 BR11 (dòng 160): nhãn "Đã chặn" cạnh tên ở danh sách / chi tiết / danh bạ / tìm kiếm.
- *Còn mở:* (1) "Thông báo" là push (G027), in-app (G022), thông báo kết bạn (G007 §8) hay mọi loại; G020/G029 hiển thị tên ở đâu mà nằm trong §13. (2) @mention (G008 dòng 226), tin nhắn hệ thống, export, báo cáo. (3) Thông báo đã sinh trước khi đặt tên giữ tên cũ hay đổi theo. (4) Thành viên nhóm: dùng tên nào khi liên hệ thuộc nhiều tài khoản (phụ thuộc Q-25). (5) Họ tên G011a độc lập: đã rõ (BR04, AC dòng 295–296).
- *Đề xuất:* BA liệt kê đóng danh sách nơi hiển thị; mặc định tên tại thời điểm xem (động).

**Q-17 — Trạng thái xoá / ẩn / không còn tồn tại** — **TRẢ LỜI MỘT PHẦN** (Chặn cho E07)
- *Đã rõ:* DISCONNECTED: G010 BR04 (dòng 158) *"dữ liệu vẫn hiển thị bình thường … chỉ khóa các thao tác outbound"*; xoá bạn: G007 BR12 (dòng 154) giữ lịch sử, BR14 (dòng 156) quan hệ về STRANGER; DELETED: (1) §2 dòng 45 loại khỏi "tài khoản liên quan", AC dòng 320 (nhưng xem **Q-30**).
- *Còn mở:* (1) E07 "không còn tồn tại" cụ thể là gì (xoá khỏi danh bạ / hội thoại / tài khoản DELETED / dữ liệu bị dọn). (2) Sau **xoá bạn**, **bị chặn** (G030), **hội thoại ẩn**: ✎ / Option Đổi tên còn không, còn đặt / gỡ được không. (3) Chỉ còn liên hệ ở tài khoản DELETED thì tên hiển thị ở đâu.
- *Đề xuất:* BA lập bảng trạng thái liên hệ × (còn hiện tên? ✎ / Option còn đặt / gỡ?).

**Q-18 — BR13 liên kết lại cùng `companyId + zaloUid`** — **TRẢ LỜI MỘT PHẦN** (Không chặn)
- *Đã trả lời:* nguồn kéo về = **Zalo, qua đồng bộ danh bạ** — (1) BR13 (dòng 147), AC dòng 339. Cô lập workspace: G010 BR02 (dòng 156), BR06 (dòng 160), BR09 (dòng 163).
- *Còn mở:* (1) tên đổi trên app Zalo trong lúc DELETED thì "như cũ" là cũ hay mới (theo BR09 "Zalo chính thức" → mới). (2) Kéo về sau bao lâu — G010 BR14 (dòng 168) *"hiển thị lại ngay"* vs G032(1) *"đồng bộ danh bạ mang về"* (Q-30). (3) Alias do workspace A đặt nằm trên tài khoản Zalo; liên kết chéo cùng zaloUid sang workspace B (G010 BR09) thì đồng bộ ở B có kéo alias về không (cô lập tenant)?
- *Đề xuất:* kỳ vọng theo BR09; BA xác nhận (3).

### F. UI, nền tảng, a11y, môi trường

**Q-19 — Mobile (Android / iOS) chưa có thiết kế** — **TRẢ LỜI MỘT PHẦN** (không còn chặn)
- *Đã trả lời:* G032(1) không còn OQ02 ảnh mobile. BR14 ((1) dòng 148) *"mobile dùng bottom sheet, Web dùng popup giữa màn"*; §10B (dòng 223); §10E: nội dung / chuỗi / giới hạn / hành vi giữ hệt, khác biệt duy nhất là khung (dòng 278).
- *Còn mở:* không có hình riêng bottom sheet; phím Done; Back / vuốt xuống có đóng không lưu (AF01 chỉ ✕ / Esc); phạm vi thiết bị / OS.
- *Đề xuất:* case Web đầy đủ; mobile lập case hành vi (BR05/BR07/BR14) + kiểm bottom sheet theo §10B.

**Q-20 — a11y và hành vi UI chưa đo được** — **TRẢ LỜI MỘT PHẦN** (Không chặn)
- *Đã trả lời / không còn:* **click ra nền mờ = đóng không lưu** ((1) §10E dòng 274, AC dòng 344). **Enter / IME / bôi đen** — G032(1) không nhắc: case Enter + IME không còn nguồn (D-13 bỏ). Chặn bấm lặp: §15 (dòng 409).
- *Còn mở:* chuẩn a11y (WCAG 2.1 AA tạm): Tab, focus trap, trả focus về ✎ / Option, nhãn đọc cho ✎ / ⊗ / ✕, toast cho trình đọc màn hình, tương phản màu cảnh báo bộ đếm; focus khi mở; tooltip tên dài; click nền khi có nội dung chưa lưu.
- *Đề xuất:* WCAG 2.1 AA tạm; BA xác nhận focus khi mở.

**Q-21 — Hiển thị mặc định khi tên Zalo rỗng và SĐT ẩn** — **VẪN MỞ** (Không chặn)
- §10D ((1) dòng 238) *"Tên Zalo rỗng → hiển thị số điện thoại nếu có — nhất quán G003 §10B"*; không nói khi cả hai rỗng.
- *Mâu thuẫn trích dẫn với G003 hiện hành:* G003 **§10B là "Panel trái: Danh sách chat"** (dòng 391–425), **không có quy tắc "tên rỗng → SĐT"**; "Tên hội thoại" chỉ ghi "Tên cá nhân hoặc tên nhóm" (dòng 417).
- *Đề xuất:* BA chốt fallback cuối và chỉ đúng chỗ trong G003 (hoặc bổ sung G003).

**Q-22 — Môi trường test: Zalo thật hay giả lập, tái hiện lỗi** — **VẪN MỞ** (Chặn thực thi)
- G032(1) bỏ số "đo trên dev ~0,2 s" (xem Q-23a); **OQ01 và OQ02 đều ⏳** ((1) dòng 399–400). E04 phụ thuộc "Zalo từ chối hoặc không phản hồi" (không còn mã 221/237 riêng).
- *Còn mở & nặng hơn:* cần liên hệ là bạn của **≥ 3 tài khoản Zalo thật** (AC dòng 312), tài khoản chủ động ngắt kết nối (AC dòng 318), người chưa kết bạn + cả hai chiều lời mời (AC dòng 327–328); app Zalo cho từng tài khoản để xác nhận tên (AC dòng 291, 312); cách giả lập Zalo từ chối / không phản hồi trên **một** trong N tài khoản (Q-24); số đo ≤3 s có áp dụng trên QA / production không.
- *Đề xuất:* Dev cung cấp stub Zalo hoặc cờ giả lập lỗi theo từng tài khoản trên QA.

---

### G. CÂU HỎI MỚI (Q-23 trở đi)

**Q-23 — Ba điểm SỰ KIỆN mà G032-Đặt (2026-10-02) ghi khác G032(1), có vẻ là kết quả đo thật** — **PHẦN "BẢN NÀO HIỆU LỰC" ĐÃ ĐÓNG; PHẦN SỰ KIỆN CÒN MỞ** (Chặn)
- **Đã đóng:** user xác nhận 2026-10-07: bản hiệu lực = `G032 - Đổi tên gợi nhớ (1).md` (dù Last updated (1) dòng 13 = 2026-09-22 cũ hơn G032-Đặt dòng 13 = 2026-10-02). QA dùng G032(1) làm nguồn chuẩn; G032-Đặt chỉ tham khảo, mọi AC riêng của G032-Đặt **không** được dùng làm kỳ vọng.
- **Vẫn mở — lý do giữ:** G032(1) có thể đang mang giả định đã bị thực nghiệm bác. QA cần BA xác nhận **từng điểm**, không tự chọn bản nào đúng:
  - **Q-23a — Ghi tên gợi nhớ cho người CHƯA kết bạn:** G032-Đặt BR09 (Đặt dòng 123) *"Đã đo trên dev: Zalo cho đặt và gỡ tên gợi nhớ với người chưa kết bạn, ~0,2 giây mỗi lần"* và §15 *"đo thực tế ~0,2 giây"* vs G032(1) OQ02 ((1) dòng 400) *"Ghi được tên gợi nhớ cho người CHƯA kết bạn không? Nếu Zalo cho thì BR11 bỏ được vế 'hẹn ghi khi kết bạn'"* — ⏳ chờ dev. Nếu số đo của G032-Đặt đúng thì BR11 / AF05 / §7 tình huống thứ ba / AC dòng 325–331 (hẹn ghi, thử lại, im lặng) **thừa hoặc sai** và Q-29 tự đóng. *Chặn* case BR11 / AF05.
  - **Q-23b — Giới hạn ký tự của Zalo:** G032-Đặt BR06 (Đặt dòng 120) *"50 là giới hạn ô nhập của Zalo PC"* (đếm UTF-16, emoji = 2) vs G032(1) BR07 ((1) dòng 141) *"40 là đúng giới hạn Zalo — lưu quá thì ghi lên Zalo thất bại"*. Hai con số cho hai kết quả đối nghịch ở biên 41–50: G032(1) chặn, G032-Đặt cho phép; nếu Zalo thật nhận 50 thì giới hạn 40 là chặt hơn Zalo (không lỗi ghi), nếu Zalo chỉ nhận 40 thì 50 gây lỗi E04 ở biên. *Chặn* case boundary (Q-05).
  - **Q-23c — Có hay không tín hiệu realtime từ Zalo về hệ thống:** G032-Đặt BR10 (Đặt dòng 124) *"Zalo có gửi tín hiệu mỗi khi tên đổi … về hệ thống gần như ngay và ghi đè"*, §15 ≤ 5 s, AF08, AC Đặt dòng 221 *"không cần đồng bộ danh bạ"* vs G032(1) BR09 ((1) dòng 143) chỉ còn G006 (thủ công). G006 hiện hành lại cũng nói không có webhook realtime: G006 OOS04 (dòng 345) *"Webhook realtime từ Zalo (nhận push event) — Phụ thuộc Zalo API hỗ trợ; đưa vào backlog"*. Hai tài liệu hiện hành cùng nói "không có", G032-Đặt nói "có" (kèm BR "Zalo có gửi tín hiệu") → cần Dev xác nhận. Nếu có tín hiệu: AF08 và ngưỡng 5 s phải khôi phục, tên đổi trên app tự về (không cần Q-26 cho trường hợp này) và đường tự sửa của Q-10 / Q-24 tồn tại. *Chặn* case BR09.
- Chéo với tài liệu thứ ba: CR-001 (Last updated 2026-09-24) trích *"G032 BR06"* cho quyền — khớp đánh số G032(1).
- *Đề xuất:* BA Trân + Dev xác nhận từng điểm 23a / 23b / 23c bằng kết quả đo thực trên Zalo; cập nhật G032(1) (hoặc ghi chú nguồn đo) cho khớp.

**Q-24 — "Không lưu gì cả nếu một tài khoản lỗi" không thể đảm bảo khi ghi song song nhiều tài khoản Zalo** (Chặn)
- Trích: BR08 ((1) dòng 142) *"Zalo xác nhận xong mới lưu vào hệ thống. Thất bại ở bất kỳ tài khoản nào → không lưu gì cả … Bắt ghi xong mới lưu để hệ thống và Zalo không bao giờ có hai giá trị khác nhau — nhờ vậy không cần bất cứ cơ chế đối chiếu hay bù trừ nào"*; §15 (dòng 408) *"ghi song song … hoàn tất trong ≤ 3 giây, quá thì coi là lỗi và bắn E04"*; E04 (dòng 122) *"KHÔNG lưu gì cả — tên cũ giữ nguyên ở cả hệ thống lẫn Zalo"*; AC dòng 315 *"Không tồn tại trạng thái hệ thống một tên, Zalo một tên khác"*.
- Mâu thuẫn: ghi song song lên N tài khoản độc lập thì không nguyên tử. Tài khoản A ghi thành công, B lỗi hoặc quá 3 s → hệ thống không lưu nhưng **Zalo của A đã mang tên mới** — chính là trạng thái spec nói không bao giờ xảy ra. Không có hoàn tác, không có đối chiếu (BR08 tự loại bỏ), và đường tự sửa duy nhất (G006) là thủ công, một chiều, cần quyền riêng (Q-26) — trừ khi Q-23c xác nhận có tín hiệu realtime. Tương tự với Gỡ tên (AF02) và E04 do "không phản hồi".
- Vì sao chưa viết được: không biết kỳ vọng sau lỗi một phần, nên không xác định pass / fail cho E04 với N > 1 và cho AC dòng 313–315.
- Đề xuất: BA/Dev nêu hành vi khi lỗi một phần (hoàn tác các tài khoản đã thành công, hoặc ghi nhận lệch + cơ chế sửa); QA lập case giả lập lỗi trên đúng một trong N tài khoản (stub theo Q-22). Ứng viên bật `data-integrity`.

**Q-25 — Khoá nào xác định "cùng một liên hệ" giữa nhiều tài khoản Zalo** (Chặn cho mọi case đa tài khoản)
- Trích G032(1): BR08 ((1) dòng 142) *"Một liên hệ có thể là bạn của nhiều tài khoản Zalo trong workspace (G007 BR04)"*; AC dòng 312 *"Liên hệ là bạn của 3 tài khoản Zalo → đặt tên một lần, mở app bằng cả 3 đều thấy tên mới"*.
- Trích G007 dòng 146 BR04 *"cùng 1 liên hệ là bạn bè với nhiều tài khoản Zalo → hiển thị 1 dòng trong Danh bạ, kèm avatar tất cả tài khoản Zalo chung"* — không nêu khoá nhận diện.
- Tham chiếu G032-Đặt (không hiệu lực, nhưng là dữ kiện về Zalo): Đặt dòng 45 *"Zalo cấp mã liên hệ (uid) riêng cho từng tài khoản … không có khoá nào nối chúng lại (số điện thoại thường bị Zalo ẩn)"*; G032(1) không phản bác mà vẫn dựa trên việc nối được.
- Vì sao chưa viết được: không biết hệ thống nhận ra liên hệ trùng bằng gì (SĐT? uid? thủ công?) nên không dựng được dữ liệu "bạn của 3 tài khoản" và không có kỳ vọng khi nối nhầm / không nối được (ghi tên lên sai người, hoặc chỉ một phần tài khoản).
- Đề xuất: BA/Dev nêu khoá nhận diện và hành vi khi SĐT bị ẩn; thêm case "hai người khác nhau trùng SĐT / không SĐT".

**Q-26 — G032(1) dựa vào G006 để "mang tên gợi nhớ về", nhưng G006 hiện hành không có chữ "gợi nhớ / alias"** — **MÂU THUẪN THẬT với spec hiện hành** (Chặn cho case G006 / BR13 / BR11 retry)
- Trích G032(1): BR09 ((1) dòng 143) *"Chiều Zalo → hệ thống do đồng bộ danh bạ (G006 BR05/BR06) đảm nhiệm — mang tên gợi nhớ đặt trên app Zalo về và cập nhật đè lên hệ thống"*; OOS05 (dòng 364); §13 (dòng 381); OQ01 (dòng 399) *"(Chiều đọc đã có sẵn — G006 đang mang tên gợi nhớ về)"*; AC dòng 340.
- Trích G006 hiện hành (header v1.1, changelog đến v1.2): BR05 (dòng 172) *"cập nhật thông tin từ Zalo (tên, avatar, ...)"*; BR06 (dòng 173) *"cập nhật từ Zalo (tên, avatar, số điện thoại nếu Zalo trả về) — không giữ nguyên dữ liệu cũ"*; OQ03 (dòng 372, **chưa trả lời**) *"Thông tin nào của danh bạ được cập nhật từ Zalo (BR06)? Tên hiển thị, avatar, số điện thoại — cần xác nhận Zalo API trả về gì"*. **Không có chữ "gợi nhớ" / "alias" ở bất kỳ dòng nào của G006.**
- Hệ quả:
  - (1) Khẳng định "G006 đã mang tên gợi nhớ về" không có nguồn trong G006; nếu hub không trả alias thì đồng bộ ghi đè "tên" bằng tên Zalo gốc theo G006 BR06 và **xoá mất tên gợi nhớ** — rủi ro mà BR14 của G032-Đặt từng chặn.
  - (2) G006 chạy **theo từng tài khoản** (BR20, dòng 188) và alias trên Zalo cũng theo từng tài khoản, nhưng hệ thống chỉ có **một** giá trị cấp workspace (BR01): alias khác nhau giữa các tài khoản thì giá trị nào thắng, "cập nhật đè" theo tài khoản nào đồng bộ sau.
  - (3) Alias rỗng từ Zalo = "gỡ tên" hay "không có dữ liệu".
  - (4) G006 một chiều (OOS02, dòng 343), không có lịch tự động (OOS03, dòng 344), chỉ Admin hoặc người được cấp quyền "Đồng bộ dữ liệu" (BR26, dòng 194; E01 dòng 135); G031 dòng 214 còn ghi màn "Đồng bộ dữ liệu" của G006 **chưa có trên sản phẩm**. Đường "Zalo → hệ thống" duy nhất của G032(1) phụ thuộc một màn thủ công chưa có và một quyền mà nhân sự thường không có.
- Vì sao chưa viết được: không nguồn nào xác nhận alias đi qua đồng bộ; AC dòng 340 và BR13 liên kết lại không có kỳ vọng kiểm chứng được.
- Đề xuất: Dev xác nhận hub có trả alias cho đồng bộ danh bạ không; sửa G006 theo bảng 3.H.

**Q-27 — Ghi lên tài khoản Zalo mà người dùng KHÔNG được gán, và E03 tiết lộ tên tài khoản đó** (Chặn cho case security)
- Trích G032(1): BR06 ((1) dòng 140) quyền = xem hội thoại **hoặc** xem danh bạ (không đòi được gán); BR08 (dòng 142) ghi lên **tất cả** tài khoản liên quan; BR10 (dòng 144) / E03 (dòng 121) *"Tài khoản Zalo «{tên tài khoản}» đang ngắt kết nối … Nhiều tài khoản rớt thì nêu tài khoản đầu tiên kèm 'và {n} tài khoản khác'"*.
- Trích spec hiện hành: G007 dòng 43–45, 295: Danh bạ hiện bạn của **tất cả** tài khoản cho cả 3 vai; G017 BR08 (dòng 279) và G007 BR10 (dòng 152): các thao tác khác chỉ liệt kê tài khoản người dùng được gán; CR-001 dòng 147 *"Nhân sự vẫn chỉ … qua tài khoản Zalo mình được assign — phạm vi không đổi một milimet"*.
- Mâu thuẫn: nhân sự gán tài khoản A, liên hệ còn là bạn của B (không được gán B). Khi sửa tên G032(1) (i) **ghi lên Zalo của B**, (ii) **chặn bằng E03 nêu tên B** nếu B rớt (lộ tên tài khoản không thuộc quyền xem), (iii) cho nhân sự "chỉ có quyền xem danh bạ" sửa tên liên hệ ở tài khoản mình không được gán. Không rõ ý đồ hay lỗ hổng; ngược nguyên tắc "phạm vi theo tài khoản được gán" của CR-001 / G007 BR10 / G017 BR08.
- Đề xuất: BA xác nhận (a) có cho ghi lên tài khoản không được gán không, (b) toast E03 có nêu tên tài khoản không được gán không, (c) nếu chỉ xét tài khoản được gán thì sửa §2 "tài khoản liên quan" và BR08/BR10.

**Q-28 — G007 và G011 hiện hành vẫn mô tả đổi tên "nội bộ, không đẩy lên Zalo"; popup profile còn icon đổi tên mà G032(1) không nhắc** — **MÂU THUẪN THẬT với spec hiện hành** (Chặn cho hồi quy G007 / G011 và case popup profile)
- Trích G032(1) §1 ((1) dòng 37) *"nghiệp vụ đổi tên liên hệ trước nằm rải ở G011 và G007 nay gom về đây; hai Spec đó chỉ còn giữ entry point"* — nhưng G007 / G011 hiện hành **chưa được sửa** theo câu này.
- Trích G007: BR03 dòng 145 *"Danh bạ lưu nội bộ hệ thống — đổi tên, gắn thẻ trong Gopany không ảnh hưởng dữ liệu trên Zalo"*; AC dòng 298 *"Đổi tên → lưu nội bộ, không ảnh hưởng Zalo (BR03)"*; Notes dòng 353; dòng 58 và 204 popup profile / kết quả tìm *"tên (kèm icon đổi tên)"*.
- Trích G011: BR06 dòng 134 *"… không đẩy lên Zalo"*; AC dòng 212; dòng 17 *"✎ Đổi tên gợi nhớ (UC-02/BR06) tạm thời chưa làm trong tuần này"*; BR08 dòng 136 quyền "theo G007".
- Mâu thuẫn: G007 / G011 "không ghi Zalo" vs G032(1) BR03/BR08 "ghi Zalo xong mới lưu" — đối nghịch trực tiếp. G032(1) bỏ OOS10 của G032-Đặt nên **popup profile khi tìm người dùng** (G007 dòng 58, 204) không còn được nhắc: icon đổi tên ở đó có mở màn G032 không? Người đó chưa có hội thoại thì chưa có đối tượng để đặt tên.
- Vì sao chưa viết được: không xác định kỳ vọng hồi quy G007 / G011 và hành vi popup profile.
- Đề xuất: BA sửa G007 / G011 theo bảng 3.H (nếu G032(1) đúng); nêu popup profile thuộc scope hay OOS.

**Q-29 — BR11: "tự ghi khi kết bạn" và "thử lại ở lần đồng bộ danh bạ kế tiếp" mâu thuẫn với G006 / G007 hiện hành** — **MÂU THUẪN THẬT** (Chặn cho case BR11 / AF05; tự đóng nếu Q-23a xác nhận Zalo cho ghi người chưa kết bạn)
- Trích G032(1): BR11 ((1) dòng 145) *"Kích hoạt ghi: quan hệ với một tài khoản bất kỳ chuyển sang bạn bè — bằng mọi đường: mình gửi lời mời và khách đồng ý, hay khách gửi lời mời và mình đồng ý (G007) — hệ thống tự ghi tên đang có lên tài khoản đó. Ghi lỗi lúc này: không báo người dùng … thử lại ở lần đồng bộ danh bạ kế tiếp"*; AF05 (dòng 109); AC dòng 327–329; §13 (dòng 382) G007 cung cấp "sự kiện kết bạn thành công".
- Trích G006: OOS02 dòng 343 *"Đồng bộ hai chiều (Gopany → Zalo) — Chỉ một chiều Zalo → Gopany"*; OOS03 dòng 344 (không lịch tự động; chỉ thủ công + auto khi liên kết lần đầu); BR26 dòng 194. Trích G007: BR07 dòng 149 và UC-03 (có thông báo khi chấp nhận / từ chối); OQ01 dòng 347 (webhook sự kiện xoá bạn **chưa xác nhận**); G017 BR21 dòng 300 (kết bạn qua "Tìm & Kết bạn" thêm vào danh bạ ngay).
- Mâu thuẫn / thiếu: (1) "thử lại ở lần đồng bộ kế tiếp" cần G006 **ghi lên Zalo** — G006 cấm đồng bộ ngược (OOS02) và thủ công; (2) nguồn sự kiện "kết bạn thành công" khi kết bạn làm **thẳng trên app Zalo** (không qua Gopany) — G007 chưa xác nhận webhook; (3) không có cách quan sát trên UI ((1) §7 dòng 162), QA kiểm bằng app Zalo; không có hạn mức thời gian từ lúc kết bạn tới lúc tên hiện trên Zalo.
- Đề xuất: BA/Dev nêu sự kiện kích hoạt (kể cả kết bạn từ app Zalo), thời hạn mục tiêu, cơ chế thử lại cụ thể (job nền? đồng bộ thủ công?).

**Q-30 — BR13 "xoá bạn / DELETED → tên vẫn hiển thị" mâu thuẫn với G010 / G007 hiện hành và với định nghĩa "tài khoản liên quan"** — **MÂU THUẪN THẬT** (Chặn cho case BR13 / DELETED)
- Trích G032(1): BR13 ((1) dòng 147) *"Xóa bạn (G007) · tài khoản Zalo DISCONNECTED hoặc DELETED → tên vẫn hiển thị"*; AC dòng 338–339; §2 (dòng 45) *"Tài khoản liên quan = … đã kết bạn với liên hệ đó và đang tồn tại trong workspace. Không tính … tài khoản đã bị xóa (DELETED)"*; AC dòng 320.
- Trích G010 hiện hành: BR14 dòng 168 *"Danh bạ ẩn theo tài khoản khi soft delete"*, relink *"hiển thị lại ngay cùng tài khoản, không chạy nền"*; dòng 34 *"DELETED → Staff không xem được"*; BR06 dòng 160. Trích G007: UC-05 dòng 98 *"card biến khỏi danh sách Danh bạ"* sau xoá bạn; BR14 dòng 156 về STRANGER.
- Mâu thuẫn: (1) "DELETED → tên vẫn hiển thị" nhưng G010 nói dữ liệu / danh bạ tài khoản DELETED **ẩn** — hiển thị ở đâu, cho ai? (2) Sau **xoá bạn** trên tài khoản A, A **không còn là "tài khoản liên quan"**: lần đổi tên sau chỉ ghi các tài khoản còn là bạn — tên trên Zalo của A giữ giá trị cũ, vi phạm BR08 "không có hai giá trị"; spec không nói. (3) Cơ chế khôi phục khác nhau: G010 (hiển thị lại ngay từ dữ liệu soft delete) vs G032(1) (đồng bộ danh bạ mang tên về, cần thủ công — Q-26). (4) G001 (dòng 137–139) và G002 BR05 / BR06 (dòng 140–141: hard delete; "không recover được theo UID") **mâu thuẫn với G010 trong chính các spec hiện hành**; G032(1) dùng ngôn ngữ G010 nhưng **không liệt kê G010 trong §13**.
- Đề xuất: BA đối chiếu BR13 với G010 BR04 / BR06 / BR14, thêm G010 vào phụ thuộc, nêu kỳ vọng sau xoá bạn.

**Q-31 — BR12 "không phải đụng vào cơ chế tìm kiếm G017", nhưng G017 hiện hành chưa có khái niệm tên gợi nhớ và có cache 30 giây** — **MÂU THUẪN THẬT** (Không chặn)
- Trích G032(1): BR12 lý do ((1) dòng 146) *"giữ nguyên cách G017 đang chạy, không phải đụng vào cơ chế tìm kiếm"*; §13 (dòng 384); AC dòng 334.
- Trích G017 hiện hành: nhóm "Người liên hệ" tìm theo *"Tên · số điện thoại"* (dòng 142), nhóm "Hội thoại" theo "Tên cá nhân · tên nhóm" (dòng 143); không có chữ "gợi nhớ"; BR22 dòng 301 *"Kết quả tìm kiếm nội bộ được ghi nhớ 30 giây"*; BR23 dòng 302 cache theo từng user; BR18 dòng 289.
- Thiếu: (1) "có tên gợi nhớ → chỉ khớp tên gợi nhớ, tên Zalo gốc không ra" buộc chỉ mục tìm kiếm đổi — không phải "giữ nguyên"; (2) cache 30 giây (G017 BR22) giữ kết quả theo tên cũ tới 30 giây sau khi đổi tên, **trái mục tiêu realtime ≤ 3 s** (§15) nếu kết quả tìm cũng tính; (3) nhóm "Hội thoại" của G017 cũng áp BR12 không.
- Đề xuất: BA sửa G017 theo bảng 3.H; xác nhận cache 30 giây có áp cho kết quả sau đổi tên không.

---

### H. Dòng spec khác phải sửa NẾU G032(1) đúng (spec hiện hành trong `tailieu/`)

Cột "hiện tại" trích từ file thật; "phải thành" là đề xuất QA để BA quyết — không phải quyết định.

| # | File : dòng | Hiện tại | Phải thành (nếu G032(1) đúng) | Câu liên quan |
|---|---|---|---|---|
| 1 | G007 : 145 (BR03) | "Danh bạ lưu nội bộ hệ thống — đổi tên, gắn thẻ trong Gopany không ảnh hưởng dữ liệu trên Zalo" | Chỉ **gắn thẻ** là nội bộ; **đổi tên** = tên gợi nhớ theo G032 (ghi lên Zalo, dùng chung workspace) | Q-28 |
| 2 | G007 : 298 (AC) | "Đổi tên → lưu nội bộ, không ảnh hưởng Zalo (BR03)" | "Đổi tên → mở màn G032, ghi Zalo xong mới lưu" | Q-28 |
| 3 | G007 : 353 (Notes) | "… (đổi tên, gắn thẻ) không ghi ngược lên Zalo" | Bỏ "đổi tên" khỏi câu; trỏ G032 | Q-28 |
| 4 | G007 : 90, 195 (Option card) | Option: Gắn thẻ, Đổi tên, Xóa bạn | Giữ, thêm tham chiếu G032 UC-02 và dòng chú thích 3 ý (G032 §10C) | Q-28 |
| 5 | G007 : 58, 204 (popup profile) | "tên (kèm icon đổi tên)" | Nêu rõ icon mở màn G032 hay bỏ (G032(1) không nhắc) | Q-28 |
| 6 | G007 : 335–339 (Dependencies) | G001 / G002 / G003 | Thêm G032 (và G010) | Q-28, Q-30 |
| 7 | G011 : 134 (BR06) | "…CÙNG một tên với 'Đổi tên trong Danh bạ' (G007) … **không đẩy lên Zalo**" | "Ghi lên Zalo (tất cả tài khoản liên quan), dùng chung workspace — theo G032" | Q-28 |
| 8 | G011 : 67, 87, 212 (UC-02, sơ đồ, AC) | "không đẩy lên Zalo" / "không đổi trên Zalo" | "ghi lên Zalo theo G032" | Q-28 |
| 9 | G011 : 136, 199 (BR08, phân quyền) | "theo G007 (xem hội thoại / quản lý danh bạ)" | "Quyền xem hội thoại hoặc xem danh bạ (G032 BR06)" | Q-01 |
| 10 | G011 : 157, 274 (API, dữ liệu hiện tại) | "Tên gợi nhớ (alias) dùng API nội bộ"; "alias là dữ liệu mới" | API ghi tên gợi nhớ lên Zalo (chờ OQ01); sửa dòng 274 nếu G007 "Đổi tên" đã tạo dữ liệu | Q-15, Q-22 |
| 11 | G011 : 17, 24 (scope sprint) | "✎ Đổi tên gợi nhớ … tạm thời chưa làm trong tuần này" | Cập nhật trạng thái scope khi G032 vào build | Q-28 |
| 12 | G006 : 172–173 (BR05/BR06) | "cập nhật … (tên, avatar, …)" / "(tên, avatar, số điện thoại nếu Zalo trả về)" | Thêm **tên gợi nhớ (alias)** vào danh sách trường cập nhật từ Zalo, quy tắc khi nhiều tài khoản có alias khác nhau và khi alias rỗng | Q-26 |
| 13 | G006 : 372 (OQ03) | Chưa trả lời "thông tin nào được cập nhật từ Zalo" | Chốt: hub trả alias (hoặc không) | Q-26 |
| 14 | G006 : 343 (OOS02) | "Đồng bộ hai chiều (Gopany → Zalo) — Chỉ một chiều Zalo → Gopany" | Ngoại lệ: G032 ghi Gopany → Zalo (BR08 / BR11) và nếu retry qua G006 thì G006 phải ghi ngược | Q-29 |
| 15 | G006 : 344 (OOS03), 194 (BR26) | Không có đồng bộ tự động; nhân viên thường không có quyền | Nếu G032 dựa vào G006 để retry / kéo tên: nêu tự động hoặc quyền | Q-26, Q-29 |
| 16 | G006 : 345 (OOS04) | "Webhook realtime từ Zalo — … backlog" | Khớp kết quả Q-23c (có / không có tín hiệu realtime) | Q-23c |
| 17 | G010 : 168 (BR14), 34 | "Danh bạ ẩn theo tài khoản khi soft delete"; "DELETED → Staff không xem được" | Nêu ngoại lệ / làm rõ so với G032 BR13 "DELETED → tên vẫn hiển thị"; thêm G032 vào phụ thuộc | Q-30 |
| 18 | G017 : 142–143 (kết quả "Người liên hệ" / "Hội thoại") | "Tên · số điện thoại" / "Tên cá nhân · tên nhóm" | "Tên đang hiển thị (tên gợi nhớ nếu có, không thì tên Zalo) · SĐT"; tên Zalo gốc không khớp khi có tên gợi nhớ; BR15 không dấu áp cho tên gợi nhớ | Q-31 |
| 19 | G017 : 301 (BR22 cache 30 s) | "Kết quả tìm kiếm nội bộ được ghi nhớ 30 giây" | Nêu ngoại lệ / vô hiệu cache khi đổi tên, hoặc chấp nhận độ trễ cho kết quả tìm | Q-31 |
| 20 | CR-001 : 169 | "Điều kiện chung cho cả 5 dòng: được assign ≥1 tài khoản Zalo đang CONNECTED" | Đồng bộ với G032 BR06/BR10 (xem hội thoại hoặc danh bạ; TẤT CẢ tài khoản liên quan CONNECTED) hoặc ngược lại | Q-01, Q-27 |
| 21 | G003 : 391–425 (§10B / tên hội thoại) | Không có quy tắc "tên Zalo rỗng → SĐT"; "Tên hội thoại: tên cá nhân hoặc tên nhóm" (dòng 417) | Thêm quy tắc hiển thị tên gợi nhớ và fallback; hoặc G032(1) §10D sửa lại trích dẫn "G003 §10B" | Q-21 |
| 22 | G002 : 140–141 (BR05 / BR06) | "hard delete"; "REMOVED v1.2: không recover được theo UID" | Khớp G010 (soft delete, relink khôi phục) | Q-30 |
| 23 | G032(1) : 378–391 (§13) | Không có G010, G019, G030 | Thêm G010 (DELETED / relink), G019 (hiển thị tên gợi nhớ, dòng 214), G030 (nhãn "Đã chặn" cạnh tên); xem lại vì sao G020 / G029 nằm trong danh sách "hiển thị tên" | Q-16, Q-30 |

---

### Câu hỏi (OQ) có sẵn trong G032(1) §14 — QA ghi nhận, không tính vào Q-xx

| ID spec | Nội dung | Ảnh hưởng QA | Gộp vào |
|---|---|---|---|
| OQ01 | Hub/Zalo có API GHI tên gợi nhớ của liên hệ không (**chặn build**) | Không có API ghi thì BR03/BR08 bất khả thi; AC nhóm "Ghi lên Zalo" vô hiệu | Q-22, Q-24, Q-26 |
| OQ02 | Ghi được cho người CHƯA kết bạn không (nếu có thì BR11 bỏ vế "hẹn ghi khi kết bạn") | Quyết định case BR11 / AF05 | Q-22, Q-23a, Q-29 |

(OQ01 / OQ02 / OQ03 của G032-Đặt không hiệu lực — xem mục 0A-G.)

### Tổng kết số câu hỏi

- **Q-01…Q-22 (giữ nguyên mã):** đã trả lời **1** (Q-02) · trả lời một phần **11** (Q-01, 05, 06, 11, 12, 13, 16, 17, 18, 19, 20) · vẫn mở **8** (Q-03, 04, 07, 08, 10, 15, 21, 22) · không còn áp dụng **2** (Q-09, Q-14) · câu hỏi sai **0** (riêng nhánh con của Q-01).
- **Câu mới:** **9** (Q-23 … Q-31). Q-23: phần "bản hiệu lực" đã đóng, giữ mở 3 điểm sự kiện 23a / 23b / 23c.
- **Còn CHẶN:** Q-01 (nhánh a/b) · Q-04 · Q-05 · Q-06 (toàn khoảng trắng) · Q-10 · Q-15 · Q-17 (E07) · Q-22 (thực thi) · Q-23 (a, b, c) · Q-24 · Q-25 · Q-26 · Q-27 · Q-28 (hồi quy G007 / G011, popup profile) · Q-29 · Q-30 · **cộng OQ01 của G032(1) (chặn build)**. Hết chặn: Q-13, Q-19. Không chặn: Q-02, 03, 07, 08, 11, 12, 16, 18, 20, 21, 31.

---

## 4. Điều kiện dữ liệu / môi trường (theo G032(1))

| # | Điều kiện | Ghi chú |
|---|---|---|
| D-01 | ≥ 2 workspace (W1, W2) mỗi bên có liên hệ + tài khoản Zalo riêng; thêm 1 ca cùng zaloUid liên kết chéo (G010 BR09) | AC dòng 286, BR01, Q-18 |
| D-02 | Vai trò: Admin; Nhân sự quản lý; Nhân sự thường **được gán** A; **không được gán** A (gán B); **chỉ quyền xem hội thoại**; **chỉ quyền xem danh bạ** (cần biết cách cấp, Q-01a); nhân sự **gán A nhưng liên hệ còn là bạn của B không gán** | BR06, AC dòng 306–309, Q-27 |
| D-03 | Liên hệ là bạn của **≥ 3 tài khoản Zalo** cùng workspace (mỗi tài khoản có app Zalo mở được); biết khoá nhận diện cùng một người (Q-25) | BR08, AC dòng 312, 318 |
| D-04 | Trạng thái tài khoản: CONNECTED / DISCONNECTED (chủ động ngắt) / DELETED (kể cả relink cùng zaloUid) | BR10, BR13, E03, AF06, G010 |
| D-05 | Liên hệ: bạn bè; chưa kết bạn; **bạn của A chưa là bạn của B**; đã xoá bạn; chưa có hội thoại; bị chặn (G030); đã bị xoá khỏi hệ thống | BR11, AF05, AF07, E07, BR13, Q-17 |
| D-06 | Tên Zalo: có dấu tiếng Việt (NFC và NFD), rất dài, rỗng (có / không SĐT), có emoji / ZWJ | §10D, §10A, Q-05, Q-21 |
| D-07 | Giả lập: Zalo từ chối / không phản hồi (**trên đúng một trong N tài khoản**), mất mạng client, lỗi 500 (mã 221 / 237 không còn case riêng) | E04–E06, Q-22, Q-24 |
| D-08 | App Zalo (điện thoại / Zalo PC) đăng nhập từng tài khoản test để xác nhận tên **đã ghi** và để đặt tên từ phía Zalo | AC dòng 291, 312, 340, Q-23c, Q-26 |
| D-09 | ≥ 2 phiên đăng nhập (2 nhân sự) song song để kiểm realtime + race | BR14, AF04 |
| D-10 | Dữ liệu và quyền để chạy **đồng bộ danh bạ G006** (Admin hoặc quyền "Đồng bộ dữ liệu"); biết hub có trả alias không | BR09, AC dòng 340, Q-26 |
| D-11 | Hội thoại nhóm có thành viên là liên hệ đã có tên gợi nhớ | BR04 |
| D-12 | Thiết bị Android / iOS (bottom sheet) nếu thử mobile | BR14, §10B, Q-19 |
| D-13 | ~~Bộ gõ tiếng Việt (Telex / VNI) cho case Enter + IME~~ **Không còn áp dụng** (G032(1) bỏ Enter / IME) trừ khi BA xác nhận lại | Q-20 |
| D-14 | Công cụ đo thời gian (video / timestamp) cho 3 s ghi song song + 3 s realtime | §15 |
| D-15 | Khách chưa kết bạn + cả hai chiều lời mời kết bạn, và kết bạn trực tiếp trên app Zalo | BR11, AC dòng 327–328, Q-23a, Q-29 |
| D-16 | Dữ liệu tên nội bộ từ G007 "Đổi tên" (nếu G007 đã ship) để kiểm trước / sau phát hành | Q-15 |

---

## 5. Phụ thuộc / đụng tới tính năng đã ship (đối chiếu spec hiện hành thật)

"Version" là số ghi trong header / changelog của file (thông tin tham khảo, không coi là lệch với bản nào khác vì mỗi file là bản duy nhất).

| Spec (version ghi trong file) | Đã đọc | Đụng chỗ nào / đối chiếu với G032(1) | Việc cần kiểm hồi quy / câu hỏi |
|---|---|---|---|
| **G001** (v1.1, 2026-06-09) | Trạng thái, BR01–BR07, AF02 | Dùng thuật ngữ "Đang hoạt động / Ngắt kết nối", không có CONNECTED / DELETED; "Kết nối lại" cùng UID cập nhật bản ghi cũ (dòng 96) | Thuật ngữ trạng thái thật nằm ở **G010**; Q-30 |
| **G002** (v1.2, 2026-06-26) | BR01–BR09, quyền | Phân quyền "Quản lý tài khoản Zalo" và gán nhân sự; BR05 hard delete / BR06 REMOVED (dòng 140–141) mâu thuẫn G010 | Q-01, Q-27, Q-30 |
| **G003** (v1.11, 2026-08-03) | §10B, danh sách chat, BR; tên theo grep | Danh sách hội thoại / header hiển thị tên; hội thoại thuộc từng tài khoản (dòng 400); **không có** quy tắc "tên rỗng → SĐT" ở §10B như G032(1) trích | Tên hiển thị đúng ở danh sách + header + realtime; Q-21 |
| **G006** (header v1.1, changelog tới v1.2, 2026-06-09 → 06-23) | BR04–BR07, BR20–BR27, OOS, OQ, changelog | Đồng bộ danh bạ cập nhật "tên, avatar, SĐT", **không nhắc alias**; một chiều, thủ công, cần quyền riêng; OQ03 chưa trả lời; OOS04 không có webhook realtime | Đồng bộ vẫn cập nhật avatar / SĐT / tên gốc, không xoá tên gợi nhớ; Q-23c, Q-26, Q-29 |
| **G007** (v1.1, 2026-07-01) | §2, UC-01…05, BR01–BR17, §7 UI, AC, OOS, §13 | Option card **Đổi tên** là entry point UC-02; BR03 "đổi tên nội bộ, không ghi Zalo" **mâu thuẫn G032(1)**; popup profile có icon đổi tên; BR04 Danh bạ 1 dòng / nhiều tài khoản; BR12 / BR14 xoá bạn | Hover card; Nhắn tin; xoá bạn; popup profile; Q-15, Q-25, Q-28, Q-30 |
| **G008** (v1.1, 2026-06-26) | UC-04, BR05b, BR17, @mention | Đổi tên nhóm (UC-04 / BR05b) ngoài phạm vi G032; thành viên nhóm / @mention hiển thị tên | ✎ không có ở hội thoại nhóm; đổi tên nhóm không bị ảnh hưởng; Q-16 |
| **G010** (v1.2, 2026-07-15) — **không nằm trong §13 của G032(1)** | BR01–BR14, state machine | Định nghĩa CONNECTED / DISCONNECTED / DELETED, `companyId + zaloUid`, soft delete và relink | BR10, BR13; Q-18, Q-30 |
| **G011** (changelog v1.1, 2026-08-04) | UC-02, BR06, BR08, AC, dòng 17, 274 | ✎ ở header panel; BR06 "không đẩy Zalo" **mâu thuẫn G032(1)**; ✎ tạm ngoài scope sprint; dòng 274 alias "là dữ liệu mới" | Hai ✎ không nhầm (G011a); Q-15, Q-28 |
| **G011a** | Họ tên, BR02, BR10 | "Họ tên" độc lập với tên gợi nhớ (BR04 G032(1)); tiền lệ "chỉ khoảng trắng → rỗng" | Điền Họ tên không đổi tên hiển thị và ngược lại; Q-06 |
| **G017** (v1.1, 2026-07-29) | BR01–BR23, UI, AC | Tìm theo "Tên · SĐT"; không có khái niệm tên gợi nhớ; cache 30 s (BR22) | Kết quả hiển thị tên gợi nhớ; tên gốc không ra; Q-13, Q-31 |
| **G019** — không nằm trong §13 | Dòng 214 | Nhắc hẹn: "tên hội thoại = tên người/nhóm hoặc **tên gợi nhớ**" | Thêm vào regression |
| **G020** (v1.0, 2026-08-07) | Grep tên | Không có chỗ nêu hiển thị tên liên hệ | Q-16 |
| **G022** (v1.0, 2026-08-13) | Dòng 88 | Nội dung thông báo "{tên hội thoại}" | Q-16 |
| **G027** (2026-08-20) | Dòng 51–58, 86 | Push: "tên hội thoại" | Q-16 |
| **G029** (2026-08-25) | BR02 | Đếm chưa đọc; không hiển thị tên | Q-16 |
| **G030** — không nằm trong §13 | BR11 dòng 160 | Nhãn "Đã chặn" cạnh tên ở danh sách / danh bạ / tìm kiếm | Chặn + đặt tên; Q-17 |
| **G031** | Dòng 22, 214 | Đồng bộ hội thoại (khác G006); ghi màn "Đồng bộ dữ liệu" của G006 **chưa có trên sản phẩm** | Q-26 |
| **CR-001** (Last updated 2026-09-24) | §2.4–2.7, dòng 147, 161–182 | Ma trận quyền; trỏ "G032 BR06" — **khớp G032(1)**; điều kiện chung "assign ≥1 tài khoản CONNECTED" | Q-01, Q-27 |

Tài liệu khác trong `tailieu/` đã tìm theo từ khoá ("gợi nhớ", "alias", "Đổi tên", "G032"), không có nội dung liên quan tên gợi nhớ: G021 (nhãn cho STK, OOS05), G014 (đặt tên biến), G033, G023 (một dòng không liên quan). `wiki/qa/test-cases/Z-02.md` là chủ đề khác. Chưa đọc toàn văn: G004, G005, G009, G012–G016, G018, G021, G023–G026, G028, G033.

---

## 6. Ghi chú format / cách bóc việc (để so sánh)

- Cách bóc theo **UC**: nay **2 UC** (UC-01 panel, UC-02 Danh bạ). UC-02 chỉ khác bước 1–2, các bước sau dùng chung UC-01.
- Cách bóc theo **BR**: 14 BR. BR01, BR02 (panel ↔ Danh bạ cùng giá trị), BR03, BR04, BR05, BR06, BR07, BR08, BR10, BR11, BR12, BR13, BR14 đều có AC trực tiếp; **BR09 chỉ có 1 AC (dòng 340)**. Nên dùng **BR + AF + E** làm trục trace, UC-01 / UC-02 làm luồng E2E chính.
- Spec đang **Draft v1.0**; Priority "Cao"; Dev assignee chưa điền; **OQ01 chặn build**.

---

## 7. Đầu ra intake (YAML)

```yaml
status: high-risk-pending-confirmation
featureId: "G032"
source: "tailieu/G032 - Đổi tên gợi nhớ (1).md"   # hiệu lực — user xác nhận 2026-10-07
referenceOnly: "tailieu/G032 - Đặt tên gợi nhớ.md"  # không hiệu lực
lane: high-risk
flags: [security-test, multi-tenant-isolation, cross-service-e2e, regression-scope, flaky-risk]
hardGatesTriggered: [security-test, multi-tenant-isolation, cross-service-e2e]
dataIntegrity: "chưa bật — bật khi BA/Dev xác nhận G007 'Đổi tên' ở Danh bạ đã ship và có tên nội bộ cần chuyển (Q-15); ứng viên theo Q-24"
testDepth: "Happy/Edge/Error đủ AC + exploratory + a11y + automation regression, confirm scope với user"
recommendedTestTypes: [acceptance, system, e2e, regression, exploratory, a11y, perf-smoke]
suggestedSkills: [qa-test-design, qa-test-types, qa-e2e-playwright, qa-api-test, qa-test-data, qa-defect, qa-exit-criteria]
reason: "G032(1): ghi song song lên TẤT CẢ tài khoản Zalo, tự ghi khi kết bạn, phân quyền xem hội thoại/danh bạ, cô lập workspace, realtime đa client; 5 flag, 3 hard gate. AC-source đủ (48 AC §11). G032(1) mâu thuẫn thật với G006/G007/G011/G010/G017/CR-001/G003 hiện hành (mục 3.H) và có 3 điểm sự kiện cần BA xác nhận (Q-23)."
counts:
  questionsLegacy: 22
  questionsNew: 9
  legacyStatus: { answered: 1, partial: 11, open: 8, notApplicable: 2, wrongQuestion: 0 }
  businessRules: 14
  useCases: 2
  altFlows: 7
  exceptions: 7
  acCheckboxes: 48
  specOpenQuestions: 2
  otherSpecLinesToFix: 23
nextAction:
  - "high-risk-pending-confirmation → parent DỪNG, hỏi user xác nhận scope"
  - "Gửi BA/Dev: ưu tiên Q-23 (23a/b/c), Q-24, Q-25, Q-26, Q-27, Q-28, Q-29, Q-30 và Q-01, 04, 05, 06, 10, 15, 17; OQ01 của G032(1) (chặn build); Q-22 môi trường; bảng 3.H (23 dòng spec khác); trước khi qa-test-planner chạy"
```

---

## Lịch sử cập nhật

| Ngày | Người | Nội dung |
|---|---|---|
| 2026-10-07 | QA | Tạo intake Phase 1: nguồn, flag + lane, UC, BR, 22 câu hỏi, điều kiện dữ liệu / môi trường, phụ thuộc. Chưa có plan / case. |
| 2026-10-07 | QA | Rà soát lại, chuyển nguồn sang `G032 - Đổi tên gợi nhớ (1).md`; thêm mục diff; đối chiếu G001, G002, G003, G006, G007, G008, G010, G011, G011a, G017, G019, G020, G022, G027, G029, G030, G031, CR-001. Kết quả 22 câu: 1 đã trả lời, 11 trả lời một phần, 8 vẫn mở, 2 không còn áp dụng; 9 câu mới (Q-23…Q-31). Lane high-risk, 5 flag; `data-integrity` chưa bật. |
| 2026-10-07 | QA | Cập nhật theo **2 quyết định của user (xác nhận 2026-10-07)**: (1) bản hiệu lực = `G032 - Đổi tên gợi nhớ (1).md` (dù Last updated 2026-09-22 cũ hơn bản "Đặt tên"); bản "Đặt tên" = không hiệu lực, chỉ tham khảo; đổi nhãn diff thành G032(1) / G032-Đặt, bỏ gọi "cũ / mới". Q-23: đóng phần "bản nào hiệu lực", giữ mở 3 điểm sự kiện (23a ghi cho người chưa kết bạn ~0,2 s / OQ02; 23b giới hạn Zalo 50 vs 40; 23c tín hiệu realtime Zalo → hệ thống) chờ BA/Dev xác nhận. (2) Các file trong `tailieu/` là bản duy nhất, version khác dẫn chỉ là các lần sửa trực tiếp: bỏ mọi nhận định "lệch version / bản không có trong repo"; Q-26, Q-28, Q-29, Q-30, Q-31 nâng thành mâu thuẫn thật với spec hiện hành (Q-28 từ Không chặn → Chặn một phần), thêm bảng 3.H (23 dòng spec khác cần sửa nếu G032(1) đúng); Q-15 ghi điều kiện bật `data-integrity` = G007 "Đổi tên" đã ship. Sửa 2 lỗi: "14 spec" → 7 phụ thuộc + 9 được phụ thuộc (kiểm Grep (1) dòng 378–391); "số điện/giới hạn" → "giới hạn ký tự". |
