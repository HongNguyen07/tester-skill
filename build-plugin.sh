#!/usr/bin/env bash
# Dung folder plugin "tester-skill" (de publish len thu vien to chuc claude.ai) tu noi dung repo.
# Output: ~/.cache/tester-skill-plugin/tester-skill/  (skills/<name>/SKILL.md + agents/ + .claude-plugin/plugin.json)
# LUU Y: KHONG build vao trong repo (vd dist/) — PublishPlugin bo qua moi file bi .gitignore, se chi gui plugin.json.
set -euo pipefail
SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUT="${1:-${XDG_CACHE_HOME:-$HOME/.cache}/tester-skill-plugin/tester-skill}"
case "$OUT" in "$SRC"/*) echo "LOI: OUT=$OUT nam trong repo, se bi .gitignore chan khi publish. Chon duong dan ngoai repo." >&2; exit 1;; esac
rm -rf "$OUT"; mkdir -p "$OUT/.claude-plugin" "$OUT/skills" "$OUT/agents"

for d in "$SRC"/qa-*/; do
  name="$(basename "$d")"
  if [[ "$name" == "qa-flow" ]]; then cp -r "$d" "$OUT/skills/qa-flow"; continue; fi   # skill nhieu file
  [[ -f "${d}skill.md" ]] || continue
  mkdir -p "$OUT/skills/$name"; cp "${d}skill.md" "$OUT/skills/$name/SKILL.md"
done
for f in "$SRC"/agents/*.md; do [[ "$(basename "$f")" == README.md ]] && continue; cp "$f" "$OUT/agents/"; done

VERSION="${PLUGIN_VERSION:-1.0.0}"
cat > "$OUT/.claude-plugin/plugin.json" <<JSON
{
  "name": "tester-skill",
  "version": "$VERSION",
  "description": "Bộ skill + agent QA (tester) của Gopany: /qa-flow (luồng từ tài liệu BA), /qa-orchestrator (luồng từ FEAT), rule viết test case 15 cột, chấm point, test design/types/data, Playwright E2E, API test, defect, exit criteria, log bug / testcase mobile & web.",
  "author": { "name": "Gopany QA" },
  "keywords": ["qa", "tester", "test-case", "gopany"]
}
JSON
cat > "$OUT/README.md" <<'MD'
# tester-skill — bộ skill QA (tester) Gopany

Nguồn: repo `tester-skill` (`build-plugin.sh`). Sửa rule/template trong repo rồi publish lại plugin; không sửa bản cài.

- `skills/qa-flow/` — luồng từ tài liệu BA (SKILL.md + CLAUDE.md + rules/ + templates/)
- `skills/qa-orchestrator/` — luồng từ FEAT, điều phối các agent `qa-*`
- `skills/qa-test-case-writing/` — template test case 15 cột, Expected Result theo bước
- `skills/qa-point-scoring/` — chấm point theo Business Rule
- `skills/qa-test-design|types|data`, `qa-e2e-playwright`, `qa-api-test`, `qa-defect`, `qa-exit-criteria` — rule skill
- `skills/qa-log-bug-mobile|web`, `qa-testcase-mobile` — log bug / testcase Gopany theo template
- `agents/` — sub-agent (`qa-*`, `cx-reviewer`)
MD

# claude.ai tu choi plugin neu dong description: co the <...>
if grep -lE '^description:.*<[^>]+>' "$OUT"/skills/*/SKILL.md "$OUT"/agents/*.md 2>/dev/null; then
  echo "LOI: dong description o file tren co <tag>. Sua trong repo roi chay lai." >&2; exit 1
fi
echo "OK: $OUT — $(ls "$OUT/skills" | wc -l) skill, $(ls "$OUT/agents" | wc -l) agent"
