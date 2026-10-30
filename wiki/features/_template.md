---
id: FEAT-<NNN>
title: "<Tên feature nghiệp vụ>"
createdBy: <BA initials>          # ai tạo (BA)
createdAt: <YYYY-MM-DD>
needs: [be, fe]                   # ba-only | be-only | fe-only | tổ hợp; THÊM qa khi feature cần QA sign-off (gate cuối)
deps:
  fe: [be.contract]              # fe cần BE công bố contract trước; [] nếu độc lập; [be.done] nếu chờ BE xong hẳn
  qa: [be.done, fe.done]         # QA EXECUTION chạy sau khi BE+FE xong; test-DESIGN shift-left (bắt đầu khi status.ba=done)
status:
  ba: done                       # not-started | in-progress | done
  be: ready                      # n/a | waiting | ready | in-progress | review | done | blocked
  fe: waiting                    # n/a | waiting | ready | in-progress | review | done | blocked
  qa: waiting                    # n/a | waiting | ready | in-progress | review | done | blocked
milestones:
  be.contractPublished: false    # BE đã log endpoint + DTO + error codes → mốc unblock FE (C3)
  qa.signedOff: false            # QA pass hết (evidence-backed) → mốc cho feature DONE toàn cục
owners:
  be: null                       # <dev initials> khi claim; null = chưa ai giữ
  fe: null
  qa: null
claim:
  be: { by: null, at: null }     # ghi khi claim để phát hiện stale
  fe: { by: null, at: null }
  qa: { by: null, at: null }
services: []                     # nếu feature liên nhiều BE service: [iam-service, lead-service]
lane: normal                     # tiny | normal | high-risk (từ RISK_LANES)
---

# FEAT-<NNN>: <Tên feature>

> **File này = nguồn chuẩn (source of truth) của feature.** Trace, checklist,
> owner, status đều ở đây. Matrix/BOARD là view SINH RA từ các file FEAT —
> KHÔNG hand-edit. 2 người làm 2 FEAT khác nhau = 2 file khác nhau → không
> merge-conflict. ID trong feature này đánh số **cục bộ** (`REQ-<NNN>-01`,
> `US-<NNN>-03`, `BE-<NNN>-T01`, `FE-<NNN>-T01`) → không đua với FEAT khác.

## 1. Tóm tắt nghiệp vụ (BA điền — để dev chọn có căn cứ)

<2-4 câu: feature làm gì, cho ai, giá trị. Đây là nội dung hiện trong
multi-choice khi dev pick FEAT.>

## 2. Truy vết (trace)

| Lớp | ID | Link |
| --- | --- | --- |
| BRD | BR-<x.y> | `wiki/document/brd/brd.md#...` |
| Requirement | REQ-<NNN>-01 | `wiki/analysis/requirements/analyzed/...` |
| Spec (SR/CAP) | SR-<NNN>-01 | `wiki/document/srs/srs.md#...` |
| User story | US-<NNN>-01 | `wiki/analysis/stories/epics/...` |
| Screen | SCR-<NNN>-01 | `wiki/analysis/wireframes/screens/...` |
| BE task | BE-<NNN>-T01 | `wiki/task/<service>/...` |
| FE task | FE-<NNN>-T01 | `wiki/task/<module>/...` |

## 3. Contract BE (cột mốc unblock FE — chỉ với C3)

> BE điền phần này KHI công bố contract, rồi set `milestones.be.contractPublished: true`
> + push. FE dependent chỉ được START sau mốc này.

| Endpoint | Method | Request DTO | Response DTO | Error codes |
| --- | --- | --- | --- | --- |
| `/api/...` | POST | ... | ... | ERR-<NNN>-01 |

## 4. Checklist theo bước (log tiến độ từng discipline)

Trạng thái ô: ☐ chưa · 🚧 đang · ✅ xong · ⛔ blocked.

### 4.1 BA
| Bước | Trạng thái | Owner | Artifact |
| --- | --- | --- | --- |
| Elicit → RAW | ☐ | | |
| RAW → REQ | ☐ | | |
| BRD section | ☐ | | |
| SRS/US | ☐ | | |
| Wireframe (nếu UI) | ☐ | | |
| **BA done → set status.ba=done, đẩy git** | ☐ | | |

### 4.2 BE (nếu needs chứa be)
| Bước | Trạng thái | Owner | Artifact |
| --- | --- | --- | --- |
| Claim (owner+in-progress+push) | ☐ | | |
| Entity + Liquibase | ☐ | | |
| **Contract published → milestones.be.contractPublished=true + push (unblock FE)** | ☐ | | |
| API (create/search/update/delete) | ☐ | | |
| Test | ☐ | | |
| Review | ☐ | | |
| Commit code + set status.be=done + push FEAT | ☐ | | |

### 4.3 FE (nếu needs chứa fe)
| Bước | Trạng thái | Owner | Artifact |
| --- | --- | --- | --- |
| Gate: dep thỏa? (be.contract nếu C3) | ☐ | | |
| Claim (owner+in-progress+push) | ☐ | | |
| Story packet (screens + manual QA) | ☐ | | |
| Feature build | ☐ | | |
| UX review + code review | ☐ | | |
| Commit code + set status.fe=done + push FEAT | ☐ | | |

### 4.4 QA (nếu needs chứa qa)
> **Gate cuối:** feature chỉ `done` toàn cục khi `status.qa=done` + `milestones.qa.signedOff=true`.
> Test-DESIGN shift-left (làm khi status.ba=done); EXECUTION sau khi be.done + fe.done.
| Bước | Trạng thái | Owner | Artifact |
| --- | --- | --- | --- |
| Test plan (scope + test types + entry/exit) | ☐ | | `wiki/qa/test-plans/...` |
| Test cases (Happy/Edge/Error, mỗi case trace 1 AC) | ☐ | | `wiki/qa/test-cases/...` |
| Gate: dep thỏa? (be.done + fe.done) | ☐ | | |
| Execution + evidence (log/screenshot/trace) | ☐ | | `wiki/qa/test-runs/...` |
| Defect (nếu fail → BUG + loop về BE/FE) | ☐ | | `wiki/qa/defects/...` |
| QA review + score (gate pass) | ☐ | | |
| **Sign-off → status.qa=done + qa.signedOff=true + push** | ☐ | | |

## 5. Roll-up (BOARD đọc từ đây)

| Discipline | % xong | Owner | Ghi chú/blocked |
| --- | --- | --- | --- |
| BA | 100% | | |
| BE | 0% | | |
| FE | 0% | | waiting: be.contract |
| QA | 0% | | waiting: be.done + fe.done |

## 6. Changelog (append-only — CR, đổi scope, đổi contract)

| Ngày | Ai | Thay đổi |
| --- | --- | --- |
| <date> | <BA> | Tạo FEAT |
