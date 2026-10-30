# INIT-{NNN}: {Initiative Title}

| Thuộc tính | Giá trị |
|---|---|
| **Initiative ID** | `INIT-{NNN}` |
| **Status** | `Planning` / `In Progress` / `Done` / `Cancelled` / `On Hold` |
| **Priority** | `P0-Critical` / `P1-High` / `P2-Medium` / `P3-Low` |
| **Owner service(s)** | `{service-a}, {service-b}` |
| **Started** | `YYYY-MM-DD` |
| **Target completion** | `YYYY-MM-DD` |
| **Source spec/ticket** | `{link SRS hoặc Jira}` |

---

## Goal

> 1-3 câu mô tả product outcome muốn đạt được. KHÔNG technical detail.

---

## Affected product docs

- [ ] `wiki/document/product/{domain}.md` — sửa contract X
- [ ] `wiki/document/api-specs/{service}/{domain}.md` — endpoint mới
- [ ] `wiki/document/dev-document/{service}/{feature}.md` — flow mới

---

## Candidate stories

| # | Story title | Service | Type | Lane | Status | Story packet |
|---|---|---|---|---|---|---|
| 1 | _(điền title cụ thể)_ | `{service}` | Feature | normal | `Planned` | _(link sau khi tạo)_ |
| 2 | | | | | | |
| 3 | | | | | | |

---

## Validation shape (cross-story)

> Behavior cross-cutting cần test ở cấp initiative (e2e), không thuộc 1 story riêng.

| Behavior ID | Mô tả | Layer | Status |
|---|---|---|---|
| `{PREFIX}-INIT-001` | _(vd: tenant A vẫn thấy data tenant A sau khi migration)_ | e2e | `🚧 planned` |

---

## Open decisions

> Quyết định chưa chốt. Mỗi quyết định cần ADR khi giải quyết.

- [ ] **D1:** _(vd: chọn strategy migration online vs offline)_
- [ ] **D2:** _(vd: data backfill 1-pass vs incremental)_

---

## Architecture impact

- ADR cần tạo: `ADR-{NNN}_{topic}.md` (link sau khi viết)
- Service-map ảnh hưởng: _(list cross-service dependency mới)_
- Hard gates triggered: _(auth / data-migration / audit-security / external)_

---

## Exit criteria

> Khi nào initiative coi là Done?

- [ ] Tất cả candidate stories status `Done` trong test-matrix partition
- [ ] All cross-story validation behaviors `✅ covered`
- [ ] Migration runbook `wiki/document/runbook/{service}/{init-slug}-runbook.md` viết xong
- [ ] Rollback plan tested
- [ ] User acceptance / BA sign-off

---

## Risk register

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| _(vd: migration timeout trên prod data 50M rows)_ | High | High | Chia batch, run off-peak, có rollback |

---

## Lịch sử

| Ngày | Action | By | Ghi chú |
|---|---|---|---|
| `YYYY-MM-DD` | Tạo initiative | Agent | Decompose từ SRS |
