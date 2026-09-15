# Project Memory

> **Memory cấp project — KHÔNG dùng global Claude Code memory** (`~/.claude/projects/...`).
>
> Lý do:
> - Project có nhiều microservice. Global Claude memory keyed theo cwd → mỗi service thành memory tách biệt → không share được.
> - Memory cần versioned cùng wiki để cả team thấy + git history.
> - Memory phải sống chung với HARNESS_BACKLOG để feedback loop hoàn chỉnh.

---

## Structure

```
wiki/memory/
├── README.md                       (file này)
├── MEMORY.md                       ← INDEX (always loaded)
├── feedback_{slug}.md              ← rules từ user feedback (correction or confirmation)
├── project_{slug}.md               ← facts về initiative, stakeholder, deadline
├── reference_{slug}.md             ← pointer tới external systems (Jira, Slack, Grafana...)
└── user_{slug}.md                  ← profile của team member dùng skill (rare)
```

**Format MEMORY.md:** index file, mỗi entry 1 dòng `- [Title](file.md) — one-line hook`. Không chứa nội dung memory trực tiếp.

**Format entry file:** YAML frontmatter `name / description / type` + body có cấu trúc theo loại.

> Format giống Claude Code memory system — chỉ khác location.

---

## 4 loại memory

### 1. `feedback` (quan trọng nhất)
Rules từ correction hoặc confirmation của user.

**Triggers save:**
- User nói "không, đừng X" / "stop X" → correction
- User chấp nhận lựa chọn không-rõ-ràng mà không pushback → confirmation (validated judgment)
- User nói "lần sau làm thế này" / "next time do X"

**Body structure:**
```
[Rule statement — lead with the rule]

**Why:** [reason user gave — past incident, strong preference]
**How to apply:** [when/where this kicks in]
```

### 2. `project`
Facts về initiative, stakeholder, deadline, in-flight work.

**Triggers save:**
- User mention deadline, freeze, release window
- Stakeholder/team responsibility mention
- Reason behind a refactor/migration ("legal flagged X", "infra team needs Y")

**Body:** lead with fact, then **Why:** + **How to apply:**

**Lưu ý:** project memory decay nhanh. Convert relative dates → absolute (`Thursday` → `2026-05-09`).

### 3. `reference`
Pointer tới external system.

**Triggers save:**
- "Bugs tracked in Linear project XYZ"
- "Oncall watches grafana.../d/abc"
- "Releases logged in Notion ..."

### 4. `user`
Hiếm khi dùng. Chỉ khi nhiều người trong team dùng skill và mỗi người có role/preference khác.

---

## Khi nào agent ĐỌC memory

- **Phase 0.5** (mỗi task) — orchestrator đọc `MEMORY.md` index, load những entry liên quan dựa trên task type
- Khi user reference prior conversation
- Khi user explicit bảo "check memory" / "remember when"

## Khi nào agent GHI memory

- `be-wiki-logger` (Phase 6) khi gặp 1 trong 6 trigger HARNESS_BACKLOG, **đồng thời** check:
  - Friction này có phải pattern lặp ≥ 2 lần không? → `feedback_*.md`
  - User đã correct trong session này? → `feedback_*.md`
- `be-intake-classifier` khi user cung cấp project context mới (deadline, stakeholder) → `project_*.md`
- Bất kỳ phase nào khi user nói "lần sau làm thế này" → `feedback_*.md`

---

## KHÔNG ghi vào memory

- Code patterns, conventions, file paths → đã có trong wiki/technical, CLAUDE.md
- Git history, commit info → có git log
- Debugging recipes — fix nằm trong code + commit message
- Thông tin đã có trong CLAUDE.md / .project-config.yml
- Ephemeral task state → dùng story packet hoặc TODO

---

## Khác biệt với HARNESS_BACKLOG

| | HARNESS_BACKLOG | Memory |
|---|---|---|
| Mục đích | Cải tiến chính skill/template | Áp dụng rules đã học vào task tương lai |
| Nội dung | "Skill thiếu gì, fix gì" | "Đã học gì về user/project" |
| Lifecycle | Open → fix → done | Persist mãi đến khi user nói forget |
| Read khi | Sprint review | Mỗi task |

Ví dụ:
- HARNESS_BACKLOG: "HB-005: Intake Form thiếu field 'cần audit log không'" → fix template
- Memory: "feedback_audit_required.md: project này luôn cần audit log cho table chứa PII" → áp dụng mà không cần hỏi

---

## Stale memory

Memory record có thể outdated. Trước khi áp dụng:
- Memory mention file/function/flag → grep verify còn tồn tại
- Memory summary repo state → ưu tiên git log + đọc code thật
- Conflict giữa memory và current state → trust current state, update/remove memory

---

## Migration từ global Claude memory

Nếu project đã có entry trong `~/.claude/projects/{slug}/memory/`:
1. Filter entry liên quan project (KHÔNG entry user-level chung như "tôi thích typescript")
2. Copy vào `wiki/memory/`
3. Verify còn đúng
4. Có thể giữ lại global cho user-level memory; chỉ migrate project-specific
