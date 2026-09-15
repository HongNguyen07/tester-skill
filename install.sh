#!/usr/bin/env bash
# install.sh — Cài tester-skill (discipline QA) global cho Claude Code (+ optionally Cursor)
#
# Usage:
#   bash install.sh                 # install for claude-code only
#   bash install.sh --with-cursor   # install for claude-code + cursor
#   bash install.sh --dry-run       # show what would be done
#   bash install.sh --uninstall     # remove

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="${HOME}/.claude"
AGENTS_DIR="${CLAUDE_DIR}/agents"
CLAUDE_SKILLS_DIR="${CLAUDE_DIR}/skills"
NPX_SKILLS_DIR="${HOME}/.agents/skills"
TEMPLATE_DIR_NPX="${NPX_SKILLS_DIR}/qa-project-template"
TEMPLATE_DIR_CLAUDE="${CLAUDE_SKILLS_DIR}/qa-project-template"

WITH_CURSOR=false
DRY_RUN=false
UNINSTALL=false
NO_PAUSE=false
PROJECT=""

for arg in "$@"; do
  case "$arg" in
    --with-cursor) WITH_CURSOR=true ;;
    --dry-run)     DRY_RUN=true ;;
    --uninstall)   UNINSTALL=true ;;
    --no-pause)    NO_PAUSE=true ;;
    -h|--help)     head -n 10 "$0" | tail -n 8; exit 0 ;;
    -*) echo "Unknown arg: $arg" >&2; exit 1 ;;
    *)  PROJECT="$arg" ;;  # optional project path -> bootstrap after install
  esac
done

pause_at_end() {
  local exit_code=$?
  if [[ "$NO_PAUSE" == "true" ]]; then exit $exit_code; fi
  echo ""
  if [[ $exit_code -ne 0 ]]; then
    echo "[X] Install FAILED with exit code $exit_code"
  fi
  echo ""
  read -rp "Press Enter to close... " _
  exit $exit_code
}
trap pause_at_end EXIT

run() {
  echo "  $ $*"
  if [[ "$DRY_RUN" == "false" ]]; then eval "$@"; fi
}

if [[ "$UNINSTALL" == "true" ]]; then
  echo "[~] Uninstalling tester-skill..."
  for d in "${SCRIPT_DIR}"/qa-*/; do
    name="$(basename "$d")"
    run "rm -rf ${NPX_SKILLS_DIR}/${name}"
  done
  run "rm -rf ${TEMPLATE_DIR_NPX}"
  run "rm -rf ${TEMPLATE_DIR_CLAUDE}"
  for f in "${SCRIPT_DIR}/agents/"*.md; do
    [[ "$(basename "$f")" == "README.md" ]] && continue
    run "rm -f ${AGENTS_DIR}/$(basename "$f")"
  done
  echo "[OK] Uninstalled."
  exit 0
fi

echo "[+] Installing tester-skill (QA) global..."
echo "   Source: ${SCRIPT_DIR}"
echo "   Target: ${CLAUDE_DIR}"
echo ""

echo "[1/3] Skills (qa-orchestrator + qa-*) -> ${NPX_SKILLS_DIR}/"
NPX_AGENTS="-a claude-code"
[[ "$WITH_CURSOR" == "true" ]] && NPX_AGENTS="${NPX_AGENTS} -a cursor"

if command -v npx &>/dev/null; then
  run "cd ${SCRIPT_DIR} && npx skills add . --all ${NPX_AGENTS} -g"
else
  echo "  [!] npx not found - fallback to manual cp"
  run "mkdir -p ${NPX_SKILLS_DIR}"
  for d in "${SCRIPT_DIR}"/qa-*/; do
    run "cp -r ${d} ${NPX_SKILLS_DIR}/"
  done
fi
echo ""

echo "[2/3] Agents -> ${AGENTS_DIR}/"
run "mkdir -p ${AGENTS_DIR}"
for f in "${SCRIPT_DIR}/agents/"*.md; do
  name="$(basename "$f")"
  [[ "$name" == "README.md" ]] && continue
  [[ -e "$f" ]] || continue
  run "cp ${f} ${AGENTS_DIR}/"
done
echo ""

echo "[3/3] Project template + shared wiki -> both locations"
run "mkdir -p ${NPX_SKILLS_DIR}"
run "mkdir -p ${CLAUDE_SKILLS_DIR}"
run "rm -rf ${TEMPLATE_DIR_NPX}"
run "rm -rf ${TEMPLATE_DIR_CLAUDE}"
run "cp -r ${SCRIPT_DIR}/project-template ${TEMPLATE_DIR_NPX}"
run "cp -r ${SCRIPT_DIR}/project-template ${TEMPLATE_DIR_CLAUDE}"
# Shared wiki (dùng chung BA/BE/FE/QA) — vendored (portable)
run "rm -rf ${NPX_SKILLS_DIR}/shared-wiki-template ${CLAUDE_SKILLS_DIR}/shared-wiki-template"
run "cp -r ${SCRIPT_DIR}/shared-wiki-template ${NPX_SKILLS_DIR}/shared-wiki-template"
run "cp -r ${SCRIPT_DIR}/shared-wiki-template ${CLAUDE_SKILLS_DIR}/shared-wiki-template"
echo ""

if [[ "$DRY_RUN" == "false" ]]; then
  echo "[OK] Installed:"
  echo "   - $(ls ${NPX_SKILLS_DIR} 2>/dev/null | grep -c '^qa-') qa-* skills in ${NPX_SKILLS_DIR}/"
  echo "   - $(ls ${AGENTS_DIR}/qa-*.md 2>/dev/null | wc -l) qa agents in ${AGENTS_DIR}/"
  echo "   - template in ${TEMPLATE_DIR_NPX}/ and ${TEMPLATE_DIR_CLAUDE}/"
  echo "Next: bootstrap a project → bash ${TEMPLATE_DIR_CLAUDE}/bootstrap.sh /path/to/your-project"
else
  echo "[i] Dry run complete."
fi

# Optional: one-shot bootstrap — `bash install.sh /path/to/project`
if [[ -n "$PROJECT" && "$DRY_RUN" == "false" ]]; then
  echo ""
  echo "[bootstrap] Scaffolding QA overlay at ${PROJECT} ..."
  bash "${TEMPLATE_DIR_CLAUDE}/bootstrap.sh" "$PROJECT"
fi
