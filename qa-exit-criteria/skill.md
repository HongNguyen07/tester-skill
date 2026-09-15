---
name: qa-exit-criteria
description: "QA Definition-of-Done + sign-off criteria the qa-reviewer/qa-wiki-logger load — AC coverage 100%, blocking pass 100%, 0 open critical/blocker, evidence present, SCORING gate pass, before setting status.qa=done + milestones.qa.signedOff=true (done-GLOBAL)."
allowed-tools: Read, Write, Edit, Glob, Grep
---

# qa-exit-criteria — QA Definition-of-Done + Sign-off Skill

> Rulebook cho **qa-reviewer** (chấm gate) và **qa-wiki-logger** (set milestone). Đây là cửa cuối
> của pipeline **BA → BE → FE → QA**. BE done + FE done **CHƯA phải** done-GLOBAL — chỉ khi QA
> sign-off (`status.qa=done` + `milestones.qa.signedOff=true`) thì FEAT mới **done-GLOBAL**.

## Core rules

1. **AC coverage = 100%** — mọi AC của FEAT có **≥1 test case** ĐÃ được executed (không phải chỉ "planned"). AC không có case → **BLOCK**.
2. **Blocking-severity pass rate = 100%** — mọi case severity blocking (`hardGatesGlobal` chạm → auto blocking) phải PASS. 1 case blocking fail → **BLOCK**.
3. **0 open critical/blocker defects** — không còn defect critical/blocker ở trạng thái mở. Còn mở → **BLOCK** (không sign-off).
4. **Evidence present for every pass** — mọi case PASS phải có evidence (trace/screenshot/log). PASS không evidence = **không được tính là pass** (SCORING ② = fail).
5. **SCORING gate = pass** — review score `total ≥ 85`, `contradiction (⑤) ≥ 5`, không finding thiếu evidence. Vi phạm → **loop-back**, không sign-off.
6. **Sign-off là một hành động ghi trạng thái** — chỉ set `status.qa=done` + `milestones.qa.signedOff=true` SAU khi cả 5 rule trên PASS. Không set trước.

---

## Definition of Done (QA) — 6 artifact bắt buộc

Một FEAT chỉ "QA-done" khi đủ **cả 6**:

| # | DoD item | Ở đâu | Thiếu → |
|---|---|---|---|
| 1 | **Test plan** | `wiki/test/plan/TP-<FEAT>.md` | không có scope/exit → BLOCK |
| 2 | **Test cases** map đủ AC | test-matrix partition, id `TC-<FEAT>-NN` | AC coverage < 100% → BLOCK |
| 3 | **Execution** (mọi case đã chạy) | run log per environment | còn case chưa run → BLOCK |
| 4 | **Evidence** cho từng pass | trace/screenshot/log path | pass thiếu evidence → BLOCK |
| 5 | **Review score gate = pass** | `score` block (SCORING.md) | total<85 / ⑤<5 / no-evidence → BLOCK |
| 6 | **Defects triaged** | `BUG-<NNN>`, severity + status | critical/blocker mở → BLOCK |

DoD = **superset** của exitCriteria: exitCriteria là ngưỡng số; DoD là "đủ artifact + đã review + defect đã triage".

---

## Exit criteria (từ `.project-config.yml` → `qa.exitCriteria`)

```yaml
qa:
  exitCriteria:
    acCoverage: 100            # % AC phải có ≥1 test case ĐÃ executed
    passRateBlocking: 100      # blocking severity phải pass 100%
    openCriticalDefects: 0     # 0 defect critical/blocker mở mới sign-off
```

**Đọc config:** qa-reviewer walk up directory tree tìm `.project-config.yml`, đọc block `qa.exitCriteria`. Nếu field vắng → dùng default trong bảng (100 / 100 / 0).

### Override per test plan

Test plan (`TP-<FEAT>`) **được phép nới lỏng có kiểm soát** — chỉ theo hướng ghi rõ + có lý do:

```yaml
# trong TP-<FEAT>.md — front-matter override
exitCriteriaOverride:
  acCoverage: 100              # KHÔNG được hạ acCoverage — hard floor
  passRateBlocking: 100        # KHÔNG được hạ — hard floor
  openCriticalDefects: 0       # KHÔNG được nới — hard floor
  reason: "..."                # bắt buộc nếu override bất kỳ field nào
```

- **Hard floor (KHÔNG override xuống):** `acCoverage`, `passRateBlocking`, `openCriticalDefects`. Đây là an toàn nghiệp vụ — nới = tự chịu trách nhiệm defect production.
- **Chỉ được siết CHẶT hơn** default (vd non-blocking pass rate 95% → 100% cho release UAT), không được nới lỏng hard floor.
- Mọi override phải có `reason` + ghi ADR nếu chạm `hardGatesGlobal` (auth/payment/data-integrity/cross-service-e2e/multi-tenant-isolation).

---

## Quan hệ với SCORING.md gate

qa-reviewer chấm theo **SCORING.md** (chuẩn chung review). Sign-off phụ thuộc kết quả gate:

| SCORING gate | Ý nghĩa | Hành động QA |
|---|---|---|
| `pass` | total≥85, ⑤≥5, mọi finding có evidence | đủ điều kiện SCORING → tiếp tục check exitCriteria |
| `loop-back` | total<85 HOẶC ⑤<5 HOẶC finding thiếu evidence | **KHÔNG sign-off** → loop back builder (max 1) |
| `escalate` | có must-fix critical/high sau loop-back | **KHÔNG sign-off** → escalate |

**Ràng buộc cứng (không được bỏ qua):**
- `total < 85` → **cannot sign off**.
- `contradiction (⑤) < 5` → **cannot sign off** (QA output mâu thuẫn nguồn: case verify sai contract, "covered" mà không có case thật).
- `evidence-missing` (② có finding/pass không gắn file:line hoặc thiếu trace) → **cannot sign off**.

QA `score` block (theo SCORING §Output) — quality dims cho QA: `acCoverage · blockingPassRate · defectTriage · evidenceQuality · reproducibility · regressionCoverage`. Append 1 dòng vào `wiki/quality-trend.md` sau khi chấm.

---

## Khi nào BLOCK sign-off + loop back

BLOCK sign-off nếu **bất kỳ** điều kiện:

- AC nào chưa có case executed (coverage < 100%).
- Case blocking nào fail (pass rate blocking < 100%).
- Còn defect critical/blocker **mở**.
- Case pass nào thiếu evidence.
- SCORING gate ≠ pass (total<85 / ⑤<5 / evidence-missing).

### Loop-back routing (defect → discipline)

```
Defect tìm ra khi QA
   ├─ nguyên nhân ở API/logic/data/tenant/permission  → loop back BE  (be-code-reviewer / builder)
   ├─ nguyên nhân ở UI/action/contract-call/a11y       → loop back FE  (fe-code-reviewer / builder)
   └─ nguyên nhân ở AC/spec mơ hồ, thiếu, mâu thuẫn     → loop back BA  (ba-validator)
```

- Ghi `BUG-<NNN>` với severity + repro + evidence + **discipline nghi ngờ** trước khi loop.
- Loop-back **max 1 vòng** rồi `escalate` (theo SCORING GATE §1) — không loop vô hạn.
- Sau khi builder fix → re-run case liên quan + regression → chấm lại → mới xét sign-off.

---

## Sign-off gate mechanics (cái làm FEAT done-GLOBAL)

Sign-off = **2 thao tác ghi trạng thái**, chỉ chạy khi checklist dưới PASS toàn bộ:

```yaml
# FEAT spine / task status
status:
  qa: done                    # (1) QA discipline done
milestones:
  qa:
    signedOff: true           # (2) cờ done-GLOBAL — BE/FE done KHÔNG đủ để bật cờ này
    signedOffBy: "qa-reviewer"
    signedOffAt: "YYYY-MM-DD"
    scoreTotal: <n>           # ≥85
    evidenceRef: "wiki/test/evidence/<FEAT>/"
```

> **QUAN TRỌNG:** `milestones.qa.signedOff=true` là **điểm duy nhất** đánh dấu FEAT done-GLOBAL.
> Nếu `status.be=done` + `status.fe=done` nhưng `milestones.qa.signedOff≠true` → FEAT **CHƯA done**.
> Chỉ qa-wiki-logger set cờ này, và chỉ sau khi qa-reviewer trả gate=pass + exitCriteria đạt.

---

## Sign-off checklist (chạy TRƯỚC khi khai QA done)

Agent PHẢI tick đủ **tất cả** trước khi set `signedOff=true`:

- [ ] Test plan `TP-<FEAT>` tồn tại, có scope + exitCriteria (hoặc override có `reason`).
- [ ] Mọi AC có **≥1** `TC-<FEAT>-NN` map — **AC coverage = 100%**.
- [ ] Mọi test case ở trạng thái **executed** (không còn `planned`/`skipped` không lý do).
- [ ] **Blocking-severity pass rate = 100%** (mọi case chạm `hardGatesGlobal` PASS).
- [ ] **0 defect critical/blocker mở** — tất cả đã fix + re-verify hoặc waived có ADR.
- [ ] Mọi case PASS có **evidence** (trace/screenshot/log) đúng path `wiki/test/evidence/<FEAT>/`.
- [ ] Regression set cho release đã chạy (nếu FEAT nằm trong release đang đóng).
- [ ] SCORING `score` block: **total ≥ 85**, **⑤ contradiction ≥ 5**, **không finding thiếu evidence**, `gate: pass`.
- [ ] Defects đã triage (severity + status + discipline gắn đúng).
- [ ] Override exitCriteria (nếu có) **không hạ hard floor** + có `reason` + ADR nếu chạm hard gate.
- [ ] Append 1 dòng `wiki/quality-trend.md` với QA score.
- [ ] Set `status.qa=done` + `milestones.qa.signedOff=true` + `signedOffBy/At` + `scoreTotal` + `evidenceRef`.

**Bất kỳ ô nào chưa tick → KHÔNG set `signedOff=true`. → BLOCK + loop-back.**

---

## Anti-patterns (NGHIÊM CẤM)

| Anti-pattern | Đúng |
|---|---|
| Sign-off khi BE+FE done mà chưa chạy QA | done-GLOBAL cần `milestones.qa.signedOff=true` |
| AC "coi như covered" không có case executed | mỗi AC ≥1 `TC` đã run + evidence |
| Case PASS không kèm evidence | mọi pass gắn trace/screenshot/log (SCORING ②) |
| Sign-off khi còn critical/blocker mở | fix + re-verify hoặc waive có ADR trước |
| Hạ `acCoverage`/`passRateBlocking`/`openCriticalDefects` trong plan | hard floor — chỉ được siết chặt hơn |
| total<85 nhưng vẫn sign-off "vì gấp" | gate cứng — cannot sign off |
| ⑤<5 (case verify sai contract BE) bỏ qua | contradiction → loop-back, không pass |
| Loop-back vô hạn với builder | max 1 vòng rồi escalate |
| Set `signedOff=true` trước khi checklist đủ | checklist PASS 100% mới set cờ |
| QA lặp lại unit/integration/contract của dev | QA làm black-box (acceptance/system/e2e/regression) — `devOwns` |

---

## Integration with other skills / agents

- **qa-reviewer** — chấm SCORING + exitCriteria, trả `gate` (pass/loop-back/escalate). Là agent chạy checklist này.
- **qa-wiki-logger** — set `status.qa=done` + `milestones.qa.signedOff=true`, append `quality-trend.md`, ghi evidence index.
- **SCORING.md** — chuẩn chấm điểm + GATE (chặn cứng trước, điểm sau).
- **`.project-config.yml` §qa.exitCriteria** — nguồn ngưỡng coverage/pass/defect.
- **RISK_LANES.md §hardGatesGlobal** — quyết định case nào là blocking-severity.
- **be-code-reviewer / fe-code-reviewer / ba-validator** — đích loop-back khi có defect theo discipline.

---

## Related memory

- `feedback_ac_coverage_not_100.md`
- `feedback_pass_without_evidence.md`
- `feedback_signed_off_with_open_critical.md`
- `feedback_be_fe_done_not_global_done.md`
