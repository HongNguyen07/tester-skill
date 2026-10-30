# Project Wiki

> **Wiki = data/state.** Rules cho agent nằm ở `{projectRoot}/AGENTS.md` (single entry point), KHÔNG ở wiki.
> Dev không sửa wiki trực tiếp — agent log tự động qua be-wiki-logger sau mỗi task.

---

## Cấu trúc

```
wiki/
├── README.md            ← file này — human navigation
├── RISK_LANES.md        ← Intake gate: phân loại tiny/normal/high-risk
├── TEST_MATRIX.md       ← Aggregator (auto-regenerated from test-matrix/)
├── HARNESS_BACKLOG.md   ← Friction log: cải tiến chính bộ skill/template
├── GLOSSARY.md          ← Domain + technical terms
├── memory/              ← Project memory (feedback / project / reference / user)
├── test-matrix/         ← Per-service test matrix partition
├── task/                ← Story packets per service (AC + validation điền TRƯỚC khi code)
├── technical/           ← Tier+service layout:
│   ├── backend/{service}/   ← BE docs per service (entities/ subfolder cho entity; service/cache/http-client/business docs)
│   ├── frontend/{module}/   ← FE docs per module (nếu có FE)
│   ├── kafka/               ← Cross-service Kafka topic map + contracts (FLAT — không sub-folder service)
│   └── service-map.md       ← Cross-service dependency edges
├── document/
│   ├── api-specs/       ← Per-service API spec (sau khi code xong)
│   ├── dev-document/    ← Per-service dev document
│   ├── srs/             ← SRS do BA push vào (raw input material)
│   ├── product/         ← Product contract snapshot per domain (living)
│   ├── initiatives/     ← Initiative notes — group ≥ 5 task vào product area lớn
│   ├── adr/             ← Architecture Decision Records (bắt buộc cho high-risk)
│   ├── runbook/         ← Per-service operational procedures
│   ├── error-codes/     ← Per-service error code registry
│   └── onboarding/      ← Tài liệu cho developer mới
├── release/             ← Release notes theo version
├── prompt/dev/template/ ← Prompt templates dev paste vào chat
└── _templates/          ← Snapshot AGENTS.md + CLAUDE.md + .project-config.yml để bootstrap project mới
```

> **Rules-for-agent KHÔNG nằm trong wiki.** Đặt ở:
> - `{projectRoot}/AGENTS.md` (master, tool-agnostic) + `{projectRoot}/CLAUDE.md` (Claude addendum)
> - `{projectRoot}/{service}/AGENTS.md` (service-level) + `{projectRoot}/{service}/CLAUDE.md`
>
> Bootstrap project mới: copy từ `wiki/_templates/` (xem [README](_templates/README.md)).

---

## Workflow agent BẮT BUỘC

```
1. Intake Form (java-architecture)
2. Risk Assessment → RISK_LANES.md → chọn lane
3. Tạo Story Packet (task/_template.md) — điền Pre-Code (AC + Validation Plan)
4. Add row vào TEST_MATRIX.md (status: 🚧 planned)
5. Nếu high-risk → tạo ADR draft + xác nhận user lần 2
6. TODO list → user duyệt → code
7. Sau code: điền Post-Code section, update TEST_MATRIX, log friction vào HARNESS_BACKLOG nếu có
```

---

## Navigation

| Tôi muốn xem... | Vào... |
|---|---|
| **Risk lanes (intake gate)** | [RISK_LANES.md](RISK_LANES.md) |
| **Test matrix (proof gap)** | [TEST_MATRIX.md](TEST_MATRIX.md) |
| **Harness backlog (friction log)** | [HARNESS_BACKLOG.md](HARNESS_BACKLOG.md) |
| **Technical docs — backend** | [technical/backend/{service}/](technical/backend/) — entity (entities/), cache, http-client, business pattern per service |
| **Technical docs — frontend** | [technical/frontend/{module}/](technical/frontend/) — routes, components, server actions per module |
| Kafka topics (cross-service) | [technical/kafka/](technical/kafka/) |
| Service map (cross-service edges) | [technical/service-map.md](technical/service-map.md) |
| Danh sách tasks | [task/README.md](task/README.md) |
| API specs | [document/api-specs/README.md](document/api-specs/README.md) |
| SRS documents | [document/srs/README.md](document/srs/README.md) |
| **Product contract snapshots** (current behaviors per domain) | [document/product/README.md](document/product/README.md) |
| **Initiatives** (group ≥ 5 task) | [document/initiatives/README.md](document/initiatives/README.md) |
| Architecture decisions | [document/adr/README.md](document/adr/README.md) |
| Runbook (operational) | [document/runbook/README.md](document/runbook/README.md) |
| Error codes registry | [document/error-codes/README.md](document/error-codes/README.md) |
| Onboarding | [document/onboarding/README.md](document/onboarding/README.md) |
| Service dependency map | [technical/service-map.md](technical/service-map.md) |
| Release notes | [release/README.md](release/README.md) |
| **Project memory** | [memory/MEMORY.md](memory/MEMORY.md) |
| **Bootstrap templates (AGENTS.md, CLAUDE.md, .project-config.yml)** | [_templates/README.md](_templates/README.md) |
| **Glossary** | [GLOSSARY.md](GLOSSARY.md) |
| Per-service test matrix | [test-matrix/](test-matrix/) |
| Prompt templates (dev paste) | [prompt/dev/template/](prompt/dev/template/) |

---

## Quy ước

- **Ngôn ngữ:** Tiếng Việt cho mô tả, tiếng Anh cho code/technical terms
- **File naming:** `{module}-{name}.md` hoặc `{TASK-ID}_{feature}.md`
- **Date format:** `YYYY-MM-DD`
- **Status values:** `Planning` | `In Progress` | `Done` | `Blocked` | `Cancelled`
