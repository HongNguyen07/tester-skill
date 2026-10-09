#!/usr/bin/env bash
# Cài bộ qa-ai-agents vào ~/.claude: skill /qa-flow (kèm CLAUDE.md, rules/, templates/) + 2 sub-agent.
# Không đụng tới bộ qa-* cũ.
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$HOME/.claude/skills/qa-flow"
AGENT_DIR="$HOME/.claude/agents"

mkdir -p "$SKILL_DIR" "$AGENT_DIR"

rm -rf "$SKILL_DIR/rules" "$SKILL_DIR/templates"
cp "$SRC/skills/qa-flow/SKILL.md" "$SKILL_DIR/SKILL.md"
cp "$SRC/CLAUDE.md" "$SKILL_DIR/CLAUDE.md"
cp -r "$SRC/rules" "$SKILL_DIR/rules"
cp -r "$SRC/templates" "$SKILL_DIR/templates"

cp "$SRC/agents/qa-test-designer.md" "$AGENT_DIR/qa-test-designer.md"
cp "$SRC/agents/cx-reviewer.md" "$AGENT_DIR/cx-reviewer.md"

echo "Đã cài:"
echo "  skill  : $SKILL_DIR (SKILL.md, CLAUDE.md, rules/ $(ls "$SKILL_DIR/rules" | wc -l) file, templates/ $(ls "$SKILL_DIR/templates" | wc -l) file)"
echo "  agents : $AGENT_DIR/qa-test-designer.md, $AGENT_DIR/cx-reviewer.md"
echo "Mở phiên Claude Code mới rồi gõ: /qa-flow <ID feature>"
