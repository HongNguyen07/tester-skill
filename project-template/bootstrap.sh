#!/usr/bin/env bash
# bootstrap.sh - Scaffold / overlay QA discipline (tester-skill) onto a project.
# Assembles wiki = shared-wiki-template (canonical) + qa overlay, and copies
# _project-root config (.project-config.yml, AGENTS.md, CLAUDE.md) NON-CLOBBER
# (won't overwrite files another discipline BA/BE/FE already put there).
# NOTE: QA agents are installed GLOBALLY by install.sh (~/.claude/agents), NOT per-project.
#
# Usage: bash bootstrap.sh <project-path> [project-name]
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_PATH="${1:-}"
if [[ -z "$PROJECT_PATH" ]]; then
  echo "Usage: bash bootstrap.sh <project-path> [project-name]" >&2
  exit 1
fi
PROJECT_NAME="${2:-$(basename "$PROJECT_PATH")}"

# Resolve shared-wiki-template: installed location first, then own-repo vendored.
SHARED_SRC=""
for c in \
  "${HOME}/.claude/skills/shared-wiki-template" \
  "${HOME}/.agents/skills/shared-wiki-template" \
  "$(dirname "$SCRIPT_DIR")/shared-wiki-template"; do
  if [[ -d "$c" ]]; then SHARED_SRC="$c"; break; fi
done
if [[ -z "$SHARED_SRC" ]]; then
  echo "ERROR: shared-wiki-template not found. Run install.sh first." >&2
  exit 1
fi

echo "Bootstrapping QA discipline: ${PROJECT_NAME}"
echo "   Target: ${PROJECT_PATH}"

# 1. _project-root config — NON-CLOBBER (cp -n: chỉ copy file chưa tồn tại)
mkdir -p "$PROJECT_PATH"
cp -rn "${SCRIPT_DIR}/_project-root/." "${PROJECT_PATH}/"

# 2. wiki = shared (canonical) + qa overlay (additive)
mkdir -p "${PROJECT_PATH}/wiki"
cp -r "${SHARED_SRC}/." "${PROJECT_PATH}/wiki/"       # canonical shared
cp -r "${SCRIPT_DIR}/wiki/." "${PROJECT_PATH}/wiki/"  # qa discipline overlay

# 3. substitute placeholders
find "$PROJECT_PATH" -type f \( -name "*.md" -o -name "*.yml" -o -name "*.yaml" \) -print0 | \
while IFS= read -r -d '' f; do
  sed -i.bak "s|{PROJECT_NAME}|${PROJECT_NAME}|g" "$f" 2>/dev/null && rm -f "${f}.bak"
done

echo "Done. QA overlay scaffolded at ${PROJECT_PATH}"
echo "   - wiki/qa/ + QA_COVERAGE_MATRIX.md"
echo "   Next: cd ${PROJECT_PATH}; open Claude Code → /qa-orchestrator"
