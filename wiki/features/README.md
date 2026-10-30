# wiki/features/ — Feature spine (xương sống BA → BE → FE)

> **1 feature = 1 file `FEAT-<NNN>.md` = 1 ticket = 1 đơn vị việc.** Đây là nơi
> BA "log xong vào 1 chỗ", và là hàng đợi để BE/FE biết bắt đầu từ đâu.
> Nguyên lý: **partition file theo feature = nguồn chuẩn; matrix/BOARD = view sinh ra.**
> 2 người làm 2 FEAT khác nhau → 2 file khác nhau → không merge-conflict.

## Vì sao không đua ID / không đá nhau

- **ID cục bộ theo feature**: `REQ-<NNN>-01`, `US-<NNN>-03`, `BE-<NNN>-T01`,
  `FE-<NNN>-T01`. Mỗi FEAT chỉ 1 người mint ID bên trong → không đua với FEAT khác.
- **Cấp số FEAT-<NNN>**: dùng chính **git push-rejection** làm bộ cấp số. 2 người
  tạo cùng FEAT-042 → ai push trước thắng; người sau push bị reject (non-fast-forward)
  → `git pull` → đổi số → push lại. KHÔNG cần registry/lock server.
- **Claim = khóa qua git**: chọn FEAT xong ghi `owners.<d>` + `status.<d>=in-progress`
  + `claim.<d>={by,at}` rồi **push NGAY**. 2 người cùng chọn 1 FEAT → người sau push
  reject → pull → thấy đã có owner → hỏi lại chọn cái khác.

## Vòng đời mỗi discipline (BA / BE / FE độc lập)

```
n/a ──▶ waiting ──▶ ready ──▶ in-progress ──▶ review ──▶ done
                       ▲            │
                  (dep thỏa)   (BE: contractPublished=true tại đây)
        blocked ◀── (dep tụt hạng / CR)      abandoned ◀── (claim bỏ dở)
```

- `n/a`: feature không cần discipline này (theo `needs`).
- `waiting`: cần discipline này nhưng **chưa đủ input** (BA chưa done, hoặc dep chưa thỏa).
- `ready`: đủ input + chưa ai claim → **HIỆN trong multi-choice**.
- `in-progress`: đã claim.
- `blocked`: đang chờ dep (vd FE chờ `be.contract`) hoặc bị CR.
- `done`: xong.

## Gate — "discipline D được START FEAT F không?"

```
1. D ∉ F.needs                         → n/a   (không hiện)
2. F.status[D] ≠ ready                  → skip  (đã claim/done/waiting)
3. Thiếu input BA cho D (bảng dưới)     → waiting (không hiện) + lý do
4. Có dep chưa thỏa (F.deps[D])         → blocked (không hiện) + lý do cụ thể
5. Qua hết                              → HIỆN trong multi-choice, cho claim
```

**Input tối thiểu để START (định nghĩa cứng, gate đọc đúng field này):**

| D muốn start | BẮT BUỘC có trong FEAT |
| --- | --- |
| BE | `status.ba=done` + ≥1 `SR/REQ` + acceptance criteria BE |
| FE (C1/C4 độc lập) | `status.ba=done` + ≥1 `US/SCR` |
| FE (C3 phụ thuộc) | như trên **+** `milestones.be.contractPublished=true` |
| QA test-DESIGN (shift-left) | `status.ba=done` + ≥1 `AC/US` (viết case sớm, song song dev) |
| QA EXECUTION | test-design xong **+** `deps.qa` thỏa (`be.done` + `fe.done` theo needs) |

**Gate cuối (QA):** feature chỉ `done` **toàn cục** khi `status.qa=done` + `milestones.qa.signedOff=true`.
QA fail → tạo `BUG-*` (defect) → discipline liên quan (be/fe) tụt về `review` → loop lại. Orchestrator
BE/FE **không** tự tuyên bố feature "done toàn cục" khi còn `needs` chứa `qa` chưa sign-off.

## Luồng chuẩn

```
BA phân tích xong FEAT-042 → status.ba=done, set be/fe=ready (hoặc waiting nếu C3)
        │  git push  (wiki repo)
        ▼
BE dev chạy java-orchestrator
        │  step 0: git pull wiki  → đọc state mới nhất
        ▼
Liệt kê FEAT open cho BE (gate) → AskUserQuestion multi-choice
        │  dev chọn FEAT-042
        ▼
CLAIM: owners.be=<dev>, status.be=in-progress, claim.be={by,at} → git push NGAY
        │  (push reject → pull → hỏi lại)
        ▼
LOAD REFS (bắt buộc): ĐỌC ĐÚNG các tài liệu FEAT NÀY tham chiếu — mục 2 Trace (đúng BR
        │  section / SR clause / REQ / US / SCR của feature) + mục 3 Contract. CHỈ phạm vi
        │  feature này, KHÔNG đọc toàn bộ wiki, KHÔNG chỉ đọc tóm tắt. Thiếu link → báo user.
        ▼
Chạy pipeline BE → khi có contract: milestones.be.contractPublished=true → push (unblock FE)
        │
        ▼
Xong: status.be=done, checklist ✅, commit code (service repo) + push FEAT (wiki repo)
        ▼
FE lần pull sau thấy fe chuyển ready (dep thỏa) → tương tự
```

## Case theo thành phần feature

| Case | needs / deps | BE | FE |
| --- | --- | --- | --- |
| **C1 FE-only** | `needs:[fe]` | n/a | ready khi BA done |
| **C2 BE-only** | `needs:[be]` | ready khi BA done | n/a |
| **C3 BE+FE, FE phụ thuộc** | `needs:[be,fe]`, `deps.fe:[be.contract]` | ready khi BA done | waiting → ready khi `be.contractPublished=true` |
| **C4 BE+FE độc lập** | `needs:[be,fe]`, `deps.fe:[]` | ready khi BA done | ready khi BA done (song song) |
| **C5 BA-only** | `needs:[ba]` hoặc `[]` | n/a | n/a (done ở BA) |

## Case đồng thời (2 người)

| # | Tình huống | Kết quả |
| --- | --- | --- |
| X1 | 2 BE cùng chọn 1 FEAT | claim push trước thắng; sau reject → pull → hỏi lại |
| X3 | FE chọn C3 khi BE **chưa** contract | **REJECT** "thiếu contract BE" (gate 4) — không hiện hoặc nhãn `blocked-by be` |
| X4 | FE chọn C3 khi BE **đã** contract (chưa done) | cho chạy song song |
| X5 | 2 BA tạo feature cùng lúc | push-rejection cấp số |

## Case biên (health-check bắt / xử)

| # | Biên | Xử |
| --- | --- | --- |
| E1 | BA khai `needs:[be,fe]` nhưng quên input BE | BE=waiting → FE(C3) blocked vô hạn → health-check cảnh báo, BA bổ sung hoặc đổi `needs` |
| E2 | Claim bỏ dở (stale) | `claim.<d>.at` quá **3 ngày** không cập nhật → health-check flag → cho release/steal (owner=null, status=ready) sau xác nhận |
| E3 | Contract sai sau khi FE build | đổi contract = CR trên FEAT; FE về review/blocked, ghi changelog, không âm thầm |
| E6 | Feature liên nhiều BE service | `services:[...]`; mỗi service 1 owner; FE chờ contract của **tất cả** service |

## BOARD + matrix = GENERATED VIEW (board-build)

`BOARD.md`, `TEST_MATRIX.md`, `TRACEABILITY_MATRIX.md` đều là **view sinh ra**, KHÔNG hand-edit.
Nguồn chuẩn = các `FEAT-*.md` + partition (`test-matrix/{service}.md`, `analysis/`).

**Protocol `board-build`** (regenerate mọi view):
1. `git -C <wiki> pull`.
2. Glob `wiki/features/FEAT-*.md` + các partition → tính roll-up.
3. Ghi đè `BOARD.md` (hàng=feature, cột=BA%/BE%/FE% + owner + blocked), refresh `TEST_MATRIX.md`,
   cột downstream của `TRACEABILITY_MATRIX.md`.
4. `git push`.

**Vì sao ghi-đè-toàn-bộ vẫn merge-safe:** view là *hàm thuần* của nguồn chuẩn. 2 người chạy
board-build đồng thời → cùng đọc FEAT/partition đã git-merge → sinh **nội dung y hệt** →
last-writer-wins vô hại. Ràng buộc CỨNG: view chỉ chứa data DERIVED, mọi data gốc nằm ở
FEAT/partition. Chạy board-build bởi 1 owner (hoặc on-read khi cần xem).

## Quy tắc file

- Tạo: copy `_template.md` → `FEAT-<NNN>.md`, điền frontmatter + mục 1-2.
- Chỉ **owner của discipline** sửa phần discipline đó (tránh tranh chấp trong 1 file — nhưng đằng nào 2 người 2 FEAT khác nhau).
- Mọi thay đổi status/claim → **push ngay** để người khác thấy.
