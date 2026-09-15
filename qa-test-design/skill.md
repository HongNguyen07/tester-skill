---
name: qa-test-design
description: "Black-box test-design techniques (boundary value, equivalence partitioning, decision table, state-transition, pairwise, error guessing) that qa-test-case-writer and qa-test-planner load to derive Happy/Edge/Error cases traced to each AC."
allowed-tools: Read, Write, Edit, Glob, Grep
---

# qa-test-design — Test Design Skill (black-box)

Skill này = **kỹ thuật thiết kế test-case black-box**. Load bởi `qa-test-case-writer` (sinh case)
và `qa-test-planner` (ước lượng coverage + chọn kỹ thuật). QA **không** đọc code — chỉ derive case
từ **AC / US / contract** (spec), input/output quan sát được từ ngoài.

## Core rules

1. **No test without AC-source** — mọi case PHẢI trace ≥1 AC/US. Không derive được từ spec → **loại**, KHÔNG bịa hành vi.
2. **Black-box** — thiết kế từ spec + interface, KHÔNG từ code/branch nội bộ. Không có white-box coverage (line/branch) ở đây — đó là việc dev.
3. **3 nhánh chuẩn Happy / Edge / Error** — mỗi AC có input hợp lệ điển hình (Happy), phải phủ biên (Edge), và ít nhất 1 nhánh sai + **mã lỗi kỳ vọng** (Error).
4. **Chọn kỹ thuật theo hình dạng input** — không dùng 1 kỹ thuật cho mọi thứ (xem bảng "Chọn kỹ thuật").
5. **Giảm bùng nổ tổ hợp có kỷ luật** — Pairwise / decision-table thay vì Cartesian product mù quáng.
6. **Case executable** — mỗi case có tiền điều kiện + bước + dữ liệu + kết quả kỳ vọng cụ thể; case rỗng = không tính coverage.

---

## Chọn kỹ thuật (input shape → technique)

| Input / spec shape | Kỹ thuật chính | Vì sao |
|---|---|---|
| Numeric / range / length có min–max | **Boundary Value Analysis** + Equivalence | Bug tụ ở biên (off-by-one) |
| Field nhiều "loại" giá trị (valid/invalid classes) | **Equivalence Partitioning** | 1 đại diện / lớp — gọn |
| Nhiều điều kiện độc lập → nhiều hành động | **Decision Table** | Phủ đủ tổ hợp business rule |
| Hành vi phụ thuộc **trạng thái** (workflow, status) | **State-Transition** | Bắt transition sai / trái phép |
| Nhiều tham số enum/flag → tổ hợp nổ | **Pairwise / combinatorial** | Phủ mọi cặp, giảm số case |
| Lỗi ẩn, ràng buộc ngầm, kinh nghiệm | **Error guessing / negative** | Bắt case spec không nói rõ |

---

## 1. Boundary Value Analysis (BVA) — biên min/max/off-by-one

Với range hợp lệ `[min..max]`, test tại: `min-1`, `min`, `min+1`, `max-1`, `max`, `max+1` (+ rỗng/null nếu cho phép).

**Ví dụ** — AC: "SMS content 1–160 ký tự".

| Giá trị | Nhánh | Kỳ vọng |
|---|---|---|
| 0 (rỗng) | Error | ERR-validation (required) |
| 1 | Happy | Chấp nhận |
| 160 | Edge | Chấp nhận |
| 161 | Error | ERR-validation (max length) |

> Off-by-one: 160 vs 161 là cặp quan trọng nhất — spec "≤160" hay "<160"? Khác nhau ở 160.

## 2. Equivalence Partitioning (EP) — lớp tương đương

Chia miền input thành các **lớp** cho cùng hành vi; test **1 đại diện / lớp** (không test hết mọi giá trị).

**Ví dụ** — AC: "Nạp tiền: số tiền hợp lệ 10.000–50.000.000 VND".

| Lớp | Đại diện | Nhánh |
|---|---|---|
| < min (không hợp lệ) | 5.000 | Error |
| trong khoảng (hợp lệ) | 1.000.000 | Happy |
| > max (không hợp lệ) | 60.000.000 | Error |
| phi số / âm | "abc", -100 | Error |

> Kết hợp BVA: mỗi ranh giới giữa 2 lớp lại áp BVA để bắt off-by-one.

## 3. Decision Table — tổ hợp điều kiện → hành động

Liệt kê điều kiện (rows) × rule (columns) → action. Dùng khi business rule = "nếu A và B thì X".

**Ví dụ** — AC: gửi ZNS chỉ khi `template approved` AND `đủ số dư` AND `trong giờ cho phép`.

| Điều kiện | R1 | R2 | R3 | R4 |
|---|---|---|---|---|
| Template approved | Y | Y | Y | N |
| Đủ số dư | Y | Y | N | – |
| Trong giờ cho phép | Y | N | – | – |
| **→ Kết quả** | Gửi (Happy) | Chờ (Edge) | Từ chối: ERR-balance (Error) | Từ chối: ERR-template (Error) |

> Mỗi rule = ≥1 test case. "–" = don't-care → giảm số cột.

## 4. State-Transition — kiểm thử chuyển trạng thái

Vẽ state machine từ spec; test **transition hợp lệ** (Happy/Edge) + **transition trái phép** (Error).

**Ví dụ** — Campaign: `DRAFT → SCHEDULED → SENDING → SENT`; huỷ chỉ từ `DRAFT/SCHEDULED`.

| Từ | Action | Đến | Nhánh |
|---|---|---|---|
| DRAFT | schedule | SCHEDULED | Happy |
| SCHEDULED | cancel | CANCELLED | Edge |
| SENDING | cancel | (chặn) ERR-invalid-state | Error |
| SENT | schedule | (chặn) ERR-invalid-state | Error |

> Phủ mọi transition trong spec + ít nhất vài "invalid transition" cho nhánh Error.

## 5. Pairwise / combinatorial — giảm bùng nổ tổ hợp

Khi có N tham số nhiều giá trị, full Cartesian = tích số → nổ. Pairwise phủ **mọi cặp giá trị** giữa 2 tham số bất kỳ (đa số bug là interaction 2 chiều).

**Ví dụ** — 3 tham số: Channel{SMS,ZNS} × Tenant-plan{Free,Pro} × Locale{vi,en} = 8 tổ hợp full → pairwise ~4 case phủ mọi cặp.

| Case | Channel | Plan | Locale |
|---|---|---|---|
| 1 | SMS | Free | vi |
| 2 | SMS | Pro | en |
| 3 | ZNS | Free | en |
| 4 | ZNS | Pro | vi |

> Ưu tiên pin (force) tổ hợp business-critical/high-risk vào cả khi pairwise không đòi.

## 6. Error guessing / negative testing

Dựa kinh nghiệm + ràng buộc ngầm để bịa input phá: null/empty, whitespace, ký tự đặc biệt/emoji, SQL/HTML injection string, số cực lớn, sai định dạng ngày/SĐT, gửi trùng (idempotency), request đồng thời (race), token hết hạn, tenant khác (data isolation), field thừa/thiếu.

> Mỗi guess vẫn phải **map ngược về AC/NFR/contract** để trace. Guess không gắn được spec → ghi vào exploratory notes, KHÔNG thành test case chính thức.

---

## Map kỹ thuật → 3 nhánh Happy / Edge / Error

Mọi kỹ thuật quy về chuẩn 3 nhánh mà test-case template dùng:

| Nhánh | Nguồn từ kỹ thuật | Mã lỗi? |
|---|---|---|
| **Happy** | EP: lớp hợp lệ điển hình · Decision-table: rule "thành công" · State: transition hợp lệ chính | — |
| **Edge** | BVA: biên min/max · EP: ranh giới lớp · State: transition ít gặp nhưng hợp lệ · Pairwise combo hiếm | — (trừ khi biên = lỗi) |
| **Error** | BVA: min-1/max+1 · EP: lớp không hợp lệ · Decision-table: rule bị từ chối · State: transition trái phép · Error guessing | **BẮT BUỘC** nêu `ERR-<...>` khớp `error-codes`/contract |

Mỗi AC → tối thiểu **1 Happy + (nếu có biên/lớp) 1 Edge + ≥1 Error**. Case Error thiếu mã lỗi kỳ vọng = chưa đạt.

---

## Traceability — No test without AC-source

- Mỗi TC ghi cột **Trace (AC/US)** → 1 AC cụ thể. Không trace được → loại (mirror BA No-source rule).
- Duy trì **ma trận AC → case** ở cuối file test-case: mỗi AC phải có ≥1 case, đánh dấu ✅/❌.
- AC không phủ → coverage/faithfulness tụt (chấm ở `qa-reviewer`, `wiki/SCORING.md`).
- Nếu FEAT **thiếu AC** để derive → báo BA, KHÔNG tự bịa AC hay hành vi.

---

## Anti-patterns (NGHIÊM CẤM)

| Anti-pattern | Đúng |
|---|---|
| Test case không trace AC nào | Mỗi case → 1 AC/US; không có nguồn → loại |
| Chỉ viết Happy path | Đủ Happy + Edge (biên) + Error (mã lỗi) |
| Test mọi giá trị của 1 field | Equivalence: 1 đại diện / lớp |
| Bỏ biên (chỉ test giữa khoảng) | BVA: min-1/min/min+1, max-1/max/max+1 |
| Full Cartesian N tham số | Pairwise phủ mọi cặp |
| Case Error không nêu mã lỗi | Ghi `ERR-<NNN>-xx` khớp contract/error-codes |
| Suy diễn hành vi từ code (white-box) | Chỉ từ spec/AC/contract (black-box) |
| Error guessing rời rạc không map spec | Map về AC/NFR, hoặc để exploratory notes |
| State machine chỉ test transition hợp lệ | Thêm transition trái phép → nhánh Error |

---

## Integration with other skills

- `qa-test-types` — kỹ thuật này áp cho acceptance/system/E2E level (không phải unit).
- `qa-defect` — nhánh Error → mã lỗi kỳ vọng đối chiếu error-codes.
- `qa-test-data` — dữ liệu biên/lớp lấy từ fixtures, tenant-isolated.
- `qa-exit-criteria` — AC-coverage 100% là điều kiện sign-off.
- Consumers: agent `qa-test-case-writer` (sinh case), `qa-test-planner` (ước lượng + chọn kỹ thuật).

---

## Checklist (case-writer áp cho mỗi FEAT)

- [ ] Mỗi AC có ≥1 test case; ma trận AC → case đầy đủ, không AC nào ❌
- [ ] Mỗi case trace đúng 1 AC/US (No test without AC-source)
- [ ] Field numeric/range: đã áp BVA (min-1/min/min+1, max-1/max/max+1)
- [ ] Field nhiều lớp: đã EP, 1 đại diện / lớp (không liệt kê thừa)
- [ ] Business rule đa điều kiện: có decision table, mỗi rule ≥1 case
- [ ] Có trạng thái/workflow: state-transition, gồm transition trái phép (Error)
- [ ] Nhiều tham số enum: pairwise (không full Cartesian), pin combo high-risk
- [ ] Đủ 3 nhánh Happy / Edge / Error cho mỗi AC có input
- [ ] Mọi case Error nêu mã lỗi kỳ vọng khớp contract/error-codes
- [ ] Error guessing bổ sung, mỗi guess map về AC/NFR (hoặc để exploratory)
- [ ] Case executable: tiền điều kiện + bước + dữ liệu + kết quả kỳ vọng
- [ ] Không suy diễn từ code — black-box thuần từ spec

---

## Related memory

- `feedback_no_test_without_ac_source.md`
- `feedback_three_branch_happy_edge_error.md`
- `feedback_boundary_off_by_one.md`
