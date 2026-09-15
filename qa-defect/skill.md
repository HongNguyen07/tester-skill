---
name: qa-defect
description: "Defect rulebook the qa-bug-reporter loads — lifecycle states + transitions, severity vs priority decision, reproducible repro standard, BUG↔FEAT/AC/TC/test-run linking, loop-back routing BE/FE, anti-hallucination (no speculative bug), triage + duplicate detection."
allowed-tools: Read, Write, Edit, Glob, Grep
---

# qa-defect — Defect Rulebook (QA discipline)

> **Đây là rulebook cho `qa-bug-reporter` (Phase 6).** Agent đó THỰC THI; skill này định NGHĨA
> luật: một defect hợp lệ trông như thế nào, sống qua những trạng thái nào, đi về discipline nào.
> Pipeline: **BA → BE → FE → QA**. QA là gate cuối; defect là cơ chế QA-fail đẩy việc ngược pipeline.
> Skill này KHÔNG chạy test, KHÔNG sửa code, KHÔNG git push, KHÔNG sign-off.

## Core rules

1. **No repro → no defect.** Defect thiếu repro tái hiện được + evidence là **KHÔNG fileable**. Thà báo thiếu còn hơn bịa (xem Anti-hallucination).
2. **Every BUG traces up.** Mỗi `BUG-<NNN>` PHẢI link `FEAT-<NNN>` + `AC-<x>` + `TC-<NNN>-0y` + test-run. Không trace được → không phải defect hợp lệ.
3. **Severity ≠ Priority.** Severity = mức hỏng kỹ thuật (do QA gán khách quan). Priority = thứ tự fix (severity × business impact). Gán **cả hai**, độc lập.
4. **Cite nguồn kỳ vọng.** "Kỳ vọng" trích AC/contract có thật (`ERR-<NNN>-xx` nếu case Error). KHÔNG bịa AC/mã lỗi để dựng defect.
5. **Test-case error ≠ product bug.** "Fail" do `expected` của TC sai → route `qa-test-case-writer`, KHÔNG file BUG.
6. **Loop-back đúng discipline.** Lỗi server/contract/data → BE. Lỗi UI/render/client-validation → FE. Không rõ → note "cần triage", KHÔNG đổ bừa.
7. **Không đụng `status.qa`.** Loop-back chỉ set `status.be`/`status.fe` → `review`. Sign-off là Phase 10.

---

## Defect lifecycle (states + transitions)

```
Open ─▶ Triaged ─▶ In-progress ─▶ Fixed ─▶ Verified ─▶ Closed
  │                                  │
  │                                  └─(verify FAIL)─▶ Reopened ─▶ In-progress
  └─(triage: không phải bug / ngoài scope)─▶ Rejected
```

| State | Ý nghĩa | Ai chuyển | Điều kiện vào |
| --- | --- | --- | --- |
| **Open** | Vừa được QA ghi, chưa triage | qa-bug-reporter | Có repro + evidence + trace đầy đủ |
| **Triaged** | Đã xác nhận là bug thật, đã gán discipline + priority | triage/lead | Không phải duplicate, không phải test-case error |
| **In-progress** | BE/FE đang fix (FEAT `status.be/fe = review`) | dev | Nhận loop-back |
| **Fixed** | Dev khai đã sửa, chờ QA verify | dev | Code fix pushed |
| **Verified** | QA chạy lại → pass, có evidence mới | qa-test-executor + qa-bug-reporter | Re-run PASS + evidence |
| **Closed** | Đóng hẳn | qa | Verified + FEAT gate xanh lại |
| **Reopened** | Verify lại FAIL sau khi "Fixed" | qa-bug-reporter | Re-fail defect cũ — **KHÔNG tạo BUG mới trùng** |
| **Rejected** | Không phải bug / ngoài scope / duplicate | triage | Kết luận sau triage (nên bắt sớm ở gate B1) |

**Luật chuyển:**
- QA khởi tạo luôn ở **Open**. Không được nhảy thẳng sang Verified/Closed.
- Re-fail một defect đã **Fixed** → **Reopened** (edit defect cũ), TUYỆT ĐỐI không mở BUG mới cho cùng lỗi.
- Kết luận không-phải-bug → **Rejected**, nhưng ưu tiên chặn ở gate anti-hallucination (`notBugs[]`) TRƯỚC khi cấp id.
- Mỗi lần đổi state = 1 dòng Changelog: `<ngày> | <ai> | <state cũ → state mới>`.

---

## Severity vs Priority

### Severity — mức hỏng kỹ thuật (QA gán khách quan)

| Severity | Nghĩa | Ví dụ (TMKT SMS/ZNS) |
| --- | --- | --- |
| **blocker** | Chặn toàn bộ luồng / không test tiếp được / mất dữ liệu / rò tenant | Gửi campaign của tenant A lộ số điện thoại tenant B; API gửi SMS crash 500 toàn bộ |
| **critical** | Chức năng chính hỏng, không workaround; sai bảo mật/phân quyền | ZNS template approved vẫn gửi fail 100%; user không có quyền vẫn gửi được broadcast |
| **major** | Chức năng quan trọng sai nhưng **có workaround** | Báo cáo delivery-rate sai số nhưng export CSV vẫn đúng |
| **minor** | Lỗi nhỏ, ít ảnh hưởng nghiệp vụ | Bộ lọc theo ngày lệch múi giờ hiển thị nhưng data đúng |
| **trivial** | Cosmetic / văn bản / khoảng cách | Sai chính tả nhãn nút, lệch padding |

### Priority — thứ tự fix (severity × business impact)

| Priority | Nghĩa | Khi nào |
| --- | --- | --- |
| **P0** | Fix ngay, chặn release | blocker/critical trên luồng doanh thu / production / bảo mật |
| **P1** | Fix trong sprint hiện tại | critical có workaround tạm, hoặc major trên luồng chính |
| **P2** | Fix theo backlog thường | major ít dùng, hoặc minor ảnh hưởng nhiều user |
| **P3** | Fix khi rảnh / gom batch | minor/trivial, cosmetic |

### Bảng quyết định Severity × Priority (mặc định, có thể nâng theo business)

| Severity \ Business impact | Luồng chính / production / security | Luồng phụ / có workaround | Ít dùng / cosmetic |
| --- | --- | --- | --- |
| **blocker** | **P0** | P0 | P1 |
| **critical** | **P0** | P1 | P1 |
| **major** | P1 | **P2** | P2 |
| **minor** | P2 | P2 | **P3** |
| **trivial** | P3 | P3 | **P3** |

> Đọc bảng: tìm dòng severity, cột business impact → priority mặc định. Nâng/hạ 1 bậc phải ghi lý do ở Mô tả.
> **Quy tắc chốt:** severity do QA quyết (khách quan, theo mức hỏng); priority do business/lead quyết (severity là input, không phải output cuối).

---

## Reproducible repro standard (bắt buộc)

Một defect **fileable** phải có ĐỦ các thành phần dưới. Thiếu bất kỳ thành phần in đậm → **KHÔNG file** (→ `notBugs[]`, yêu cầu chạy lại lấy evidence).

1. **Preconditions** — trạng thái hệ thống trước khi repro (tenant nào, role/permission, feature flag, dữ liệu seed).
2. **Test data** — input cụ thể, giá trị thật (số điện thoại mẫu, template id, payload). KHÔNG viết "nhập dữ liệu hợp lệ" chung chung.
3. **Environment** — env + build/commit (staging @ `<sha>`, browser/OS nếu FE, service version nếu BE) — lấy từ test-run.
4. **Exact steps** — các bước **đánh số, executable, deterministic**; ai làm lại cũng ra cùng kết quả. Không bước mơ hồ ("thử vài lần").
5. **Expected vs Actual** — **Expected** trích AC/contract (`ERR-<NNN>-xx` cho case Error); **Actual** = observed thật.
6. **Evidence attached** — screenshot / log / trace / HAR / response body. Path phải trỏ tới file có thật trong test-run.

### Repro-quality checklist (gate trước khi file)

- [ ] Preconditions ghi rõ tenant + role + flag + data-state
- [ ] Test data là giá trị cụ thể, tái dùng được (không "dữ liệu bất kỳ")
- [ ] Environment + build/commit sha ghi rõ
- [ ] Steps đánh số, mỗi bước 1 hành động, deterministic (không flaky)
- [ ] Expected trích **đúng** AC/contract id (không bịa)
- [ ] Actual là quan sát thật, không suy diễn
- [ ] Evidence path tồn tại + trỏ đúng TC trong test-run
- [ ] Người khác theo repro này tái hiện được 100%

> **Flaky = chưa đủ.** Kết quả pass/fail thất thường → chưa fileable; yêu cầu `qa-test-executor` chạy lại lấy evidence ổn định.

---

## Linking (traceability — bắt buộc)

Mỗi BUG là một nút trong ma trận truy vết. Thiếu 1 link = defect không hợp lệ.

```
FEAT-<NNN>  ──serves──  AC-<x>  ──verified by──  TC-<NNN>-0y  ──executed in──  test-run
     ▲                    ▲                            ▲                            ▲
     └──────────────── BUG-<NNN> link cả 4 ─────────────────────────────────────┘
```

| Link | Ghi ở đâu | Vì sao |
| --- | --- | --- |
| **FEAT** | frontmatter `feature:` + thân §Liên kết | biết defect thuộc feature nào để loop-back |
| **AC** | frontmatter `trace:` + §Kỳ vọng cite AC | chứng minh có nguồn kỳ vọng thật |
| **TC** | frontmatter `trace:` + §Liên kết `#TC-id` | defect sinh từ test case nào |
| **test-run** | §Liên kết path test-run | evidence + env đến từ lần chạy nào |

---

## Loop-back rule (routing + FEAT status)

Khi defect **chặn acceptance** (blocker/critical hoặc chặn AC bắt buộc), đẩy việc ngược pipeline:

### Route về discipline nào?

| Triệu chứng | Discipline | FEAT status set |
| --- | --- | --- |
| API/logic server/contract/error-code/DB/query/tenant-filter sai | **BE** | `status.be → review` |
| UI/render/client-validation/state/a11y/UX sai | **FE** | `status.fe → review` |
| Contract mơ hồ / thiếu AC / hiểu sai spec | **BA** (spec-gap) | KHÔNG loop dev → `notBugs[]` route BA |
| `expected` của TC sai | **QA** (test-case) | KHÔNG file BUG → route `qa-test-case-writer` |
| Không rõ tầng lỗi | note "cần triage" | chưa set — chờ triage, KHÔNG đoán |

### Khi loop-back (chỉ defect chặn acceptance), edit FEAT:

- Frontmatter: set `status.be: review` **hoặc** `status.fe: review`. **KHÔNG** đụng `status.qa`, **KHÔNG** set `status=done` bất kỳ đâu.
- **§4.4 QA** — dòng Defect: trạng thái 🚧/⛔ + id BUG + discipline chịu trách nhiệm.
- **§5 Roll-up** — cột "Ghi chú/blocked" của BE/FE: `loop-back từ BUG-<NNN>`.
- **§6 Changelog** (append-only): `<ngày> | <QA> | QA fail: BUG-<NNN> (<severity>) → status.<disc>=review`.
- Defect **minor/trivial KHÔNG chặn acceptance** → **KHÔNG** loop-back status; chỉ log BUG + note §4.4.

> Chỉ **Write/Edit**. `git push` là việc của `qa-git-committer` (Phase 10). Feature `done` toàn cục chỉ khi
> `status.qa=done` + `qa.signedOff=true` — và điều đó không xảy ra khi còn defect critical mở.

---

## Triage + duplicate detection

**Trước khi cấp id BUG-<NNN>:**
1. **Glob** `{wikiPath}/qa/defects/BUG-*.md` (bỏ `_template.md`) → lấy số lớn nhất → +1.
2. **Duplicate check** — Grep defect hiện có theo: cùng FEAT + cùng AC/TC + cùng triệu chứng.
   - Trùng defect **đang mở** → KHÔNG tạo mới; thêm ghi chú/evidence vào defect cũ.
   - Trùng defect đã **Fixed** mà fail lại → set defect cũ **Reopened**, KHÔNG mở BUG mới.
   - Chỉ tạo BUG mới khi thật sự là lỗi khác.
3. **Allocator thật là git push-rejection** — 2 QA cấp trùng số thì push người sau bị reject; `qa-git-committer` sẽ pull + re-number. Bạn chỉ cấp best-effort theo glob.

**Triage priority:** sau khi xác nhận bug thật, gán severity (khách quan) → tra bảng quyết định → priority; nếu nâng/hạ bậc phải ghi lý do business.

---

## Anti-hallucination (rule LÕI)

1. **No defect without repro + evidence** — chỉ file khi có bước tái hiện cụ thể **và** evidence. Thiếu → `notBugs[]`, KHÔNG log speculative.
2. **Test-case error ≠ product bug** — "fail" do `expected` của TC sai → route `qa-test-case-writer`, KHÔNG file BUG. (Đây là lỗi test, không phải lỗi sản phẩm.)
3. **Cite nguồn** — Expected phải trích AC/contract có thật; error code phải khớp contract §3. KHÔNG bịa AC/mã lỗi.
4. **Flaky = chưa kết luận** — pass/fail thất thường → yêu cầu chạy lại lấy evidence ổn định, KHÔNG khẳng định là bug.
5. **KHÔNG gán discipline bừa** — không rõ tầng lỗi → note "cần triage", không đổ đại cho BE/FE.
6. **Mọi failure phải có nơi đến** — mỗi failed case kết thúc ở `defectsCreated[]` **hoặc** `notBugs[]`, không rơi rớt.

---

## Anti-patterns (NGHIÊM CẤM)

| Anti-pattern | Đúng |
| --- | --- |
| File BUG chỉ vì "cảm giác sai", không repro | No repro → `notBugs[]`, yêu cầu evidence |
| Repro kiểu "nhập dữ liệu, thấy lỗi" | Steps đánh số + test data cụ thể + preconditions |
| Expected tự chế, không cite AC | Trích đúng AC-id / `ERR-<NNN>-xx` từ contract |
| Gán severity=blocker cho lỗi cosmetic | Severity theo mức hỏng thật; trivial cho cosmetic |
| Trộn severity với priority làm một | Gán **cả hai**, độc lập, theo bảng quyết định |
| Tạo BUG mới cho lỗi đã "Fixed" fail lại | Set defect cũ **Reopened** |
| Loop-back set `status.qa` / `status=done` | Chỉ set `status.be`/`status.fe = review` |
| "Fail" do test sai nhưng vẫn đổ cho BE/FE | Route `qa-test-case-writer`, KHÔNG file BUG |
| Đoán discipline khi contract mơ hồ | Note "cần triage" / route BA spec-gap |
| Defect thiếu link TC/test-run | Bắt buộc link đủ FEAT+AC+TC+test-run |

---

## Integration with other skills / agents

- `qa-bug-reporter` (agent) — thực thi rulebook này ở Phase 6.
- `qa-test-executor` — nguồn `failedCases[]` + evidence + test-run.
- `qa-test-case-writer` — nơi route khi "fail" là test-case error.
- `qa-orchestrator` — dispatcher; giữ gate execution + sign-off.
- Template defect: `{wikiPath}/qa/defects/_template.md`.

---

## Checklist (gate trước khi return defect)

- [ ] Mỗi failure phân loại real-defect | test-case-error | thiếu-evidence TRƯỚC khi cấp id
- [ ] Mỗi `BUG-<NNN>` có repro reproducible + evidence path tồn tại
- [ ] Expected cite đúng AC/contract; error code khớp §3
- [ ] Severity gán khách quan; priority tra bảng quyết định (nâng/hạ có lý do)
- [ ] Link đủ FEAT + AC + TC + test-run
- [ ] Duplicate check qua glob/grep; re-fail → Reopened (không tạo trùng)
- [ ] Mỗi defect có `assignedDiscipline` (be|fe) hoặc note "cần triage"
- [ ] Defect chặn acceptance → loop-back FEAT (status + §4.4 + §5 + §6 changelog)
- [ ] KHÔNG chạm `status.qa` / `qa.signedOff`
- [ ] Mọi failure nằm ở `defectsCreated[]` hoặc `notBugs[]` — không rơi rớt

---

## Related memory

- `feedback_no_defect_without_repro.md`
- `feedback_severity_vs_priority.md`
- `feedback_no_duplicate_bug_reopen_instead.md`
