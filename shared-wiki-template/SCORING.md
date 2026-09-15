# SCORING — Chấm điểm review (anti-hallucination + chất lượng)

> Chuẩn CHUNG cho mọi review agent (BE `be-code-reviewer`, FE `fe-code-reviewer`+`fe-ux-reviewer`,
> BA `ba-validator`). Mỗi review **trả về `score` block** + **append 1 dòng vào `wiki/quality-trend.md`**.
> Nguồn tham số: bộ hallucination-eval chuẩn ngành (faithfulness / attribution / entailment).

## Dimension anti-hallucination (BẮT BUỘC — chấm 0–5 mỗi metric)

| Metric | Ý nghĩa | 5 (tốt) | 0 (tệ) |
| --- | --- | --- | --- |
| **① Faithfulness** | Output (code/artifact) khớp **nguồn** FEAT tham chiếu (spec/contract/trace); không thêm thắt | Mọi claim/hành vi đều bám spec/contract | Bịa endpoint/field/logic/requirement ngoài nguồn |
| **② Attribution / Evidence** | Mọi **finding** của reviewer + mọi claim "covered/agreed" gắn **file:line/ID nguồn** | Finding nào cũng có file:line + verify-on-disk | Finding nói chung chung, không evidence (reviewer tự bịa) |
| **⑤ Entailment / Non-contradiction** | Output **không mâu thuẫn / bóp méo** nguồn | Không mâu thuẫn spec/contract/upstream | Mâu thuẫn (FE gọi sai contract BE; downstream-agreed vs upstream-draft; permission không tồn tại) |

`antiHallucination.subtotal = ① + ② + ⑤` (max 15).

**Áp dụng theo discipline (đọc feat-scoped, verify-on-disk):**
- **BE** (`be-code-reviewer`): ① code khớp AC/SR + contract skeleton; ② HB-311 verify facts on disk trước khi flag + HB-540 test rỗng≠cover; ⑤ permission/PermissionCode tồn tại, skeleton vs final không drift.
- **FE** (`fe-code-reviewer`): ① UI/action khớp US/SCR; ② finding gắn file:line + verify-on-disk; ⑤ **Server Action/fetch khớp contract BE (FEAT §3): endpoint path + DTO field + error code** — lệch = contradiction.
- **BA** (`ba-validator`): ① REQ/BR có RAW source (No-source→fail) + `[BA-inferred]`→ASM gated; ② mọi finding + "agreed" có evidence file; ⑤ downstream-agreed vs upstream-draft, glossary contradiction.

## Dimension chất lượng (0–5 mỗi cái, theo checklist sẵn có)

- **BE:** Security · Multi-tenancy · Performance · Data-model/Liquibase · Test-quality · AC-coverage.
- **FE:** (UX từ `fe-ux-reviewer`) tokens/common-components/a11y/module + (code) TS-strict/RSC/security/perf/AC-coverage. `fe-code-reviewer` **gộp** sub-score UX + code thành 1 total FE.
- **BA:** Traceability · Completeness(DoD) · Consistency(glossary).

## Tổng điểm

```
total /100 = 40 * (antiHallucination.subtotal / 15)      # anti-hallucination = 40%
           + 60 * (avg(quality dims 0-5) / 5)             # chất lượng = 60%
```

## GATE (điểm là ACTIONABLE, không trang trí)

Ưu tiên theo thứ tự — **chặn cứng trước, điểm sau:**
1. **Có must-fix/block** (severity critical/high; BA `block`) → `gate: loop-back` (→ builder, max 1) rồi `escalate`.
2. **⑤ Contradiction < 5** (mâu thuẫn nguồn) HOẶC **② có finding không evidence** → `gate: loop-back` (không cho pass dù total cao).
3. **total < 85** → `gate: loop-back`.
4. Còn lại → `gate: pass`.

## Output `score` block (thêm vào return của reviewer)

```yaml
score:
  antiHallucination: { faithfulness: 5, attribution: 4, contradiction: 5, subtotal: 14 }
  quality: { security: 5, multiTenancy: 4, performance: 5, dataModel: 5, testQuality: 4, acCoverage: 5 }
  total: 92
  gate: pass            # pass | loop-back | escalate
  weakDim: []           # dimension < 3 (feed evolution)
```

## Ghi trend — `wiki/quality-trend.md` (append-only)

Sau khi tính score, reviewer/orchestrator append 1 dòng vào `wiki/quality-trend.md`. Dimension
`weakDim` lặp lại ≥2 lần → tạo `HARNESS_BACKLOG` (loại `checklist-fix`/`skill-gap`) — đây là
tín hiệu **evolution định lượng** (thay ngưỡng ≥2/≥3 rời rạc bằng trend điểm).
