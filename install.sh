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
    run "rm -rf \"${NPX_SKILLS_DIR}/${name}\""
    run "rm -rf \"${CLAUDE_SKILLS_DIR}/${name}\""
  done
  run "rm -rf \"${TEMPLATE_DIR_NPX}\""
  run "rm -rf \"${TEMPLATE_DIR_CLAUDE}\""
  for f in "${SCRIPT_DIR}/agents/"*.md; do
    [[ "$(basename "$f")" == "README.md" ]] && continue
    run "rm -f \"${AGENTS_DIR}/$(basename "$f")\""
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
  run "cd \"${SCRIPT_DIR}\" && npx skills add . --all ${NPX_AGENTS} -g"
else
  echo "  [!] npx not found - fallback to manual cp"
  run "mkdir -p \"${NPX_SKILLS_DIR}\""
  for d in "${SCRIPT_DIR}"/qa-*/; do
    run "cp -r \"${d}\" \"${NPX_SKILLS_DIR}/\""
  done
fi

# Claude Code doc ~/.claude/skills/<name>/SKILL.md (VIET HOA), KHONG doc ~/.agents/skills/.
# Thieu buoc nay thi skill khong hien trong menu "/" cua Claude Code.
echo "  -> Claude Code native: ${CLAUDE_SKILLS_DIR}/<name>/SKILL.md"
run "mkdir -p \"${CLAUDE_SKILLS_DIR}\""
for d in "${SCRIPT_DIR}"/qa-*/; do
  name="$(basename "$d")"
  [[ "$name" == "qa-flow" ]] && continue   # qa-flow la skill nhieu file, cai rieng ben duoi
  [[ -f "${d}skill.md" ]] || continue
  run "mkdir -p \"${CLAUDE_SKILLS_DIR}/${name}\""
  run "cp \"${d}skill.md\" \"${CLAUDE_SKILLS_DIR}/${name}/SKILL.md\""
done

# qa-flow (bo qa-ai-agents): SKILL.md + CLAUDE.md + rules/ + templates/ -> copy CA THU MUC.
# Agent qa-test-designer / cx-reviewer doc rules/ va templates/ tu ~/.claude/skills/qa-flow/.
echo "  -> qa-flow (qa-ai-agents, nhieu file): ${CLAUDE_SKILLS_DIR}/qa-flow/"
run "rm -rf \"${CLAUDE_SKILLS_DIR}/qa-flow\""
run "cp -r \"${SCRIPT_DIR}/qa-flow\" \"${CLAUDE_SKILLS_DIR}/qa-flow\""
echo ""

echo "[2/3] Agents -> ${AGENTS_DIR}/"
run "mkdir -p \"${AGENTS_DIR}\""
for f in "${SCRIPT_DIR}/agents/"*.md; do
  name="$(basename "$f")"
  [[ "$name" == "README.md" ]] && continue
  [[ -e "$f" ]] || continue
  run "cp \"${f}\" \"${AGENTS_DIR}/\""
done
echo ""

echo "[3/3] Project template + shared wiki -> both locations"
run "mkdir -p \"${NPX_SKILLS_DIR}\""
run "mkdir -p \"${CLAUDE_SKILLS_DIR}\""
run "rm -rf \"${TEMPLATE_DIR_NPX}\""
run "rm -rf \"${TEMPLATE_DIR_CLAUDE}\""
run "cp -r \"${SCRIPT_DIR}/project-template\" \"${TEMPLATE_DIR_NPX}\""
run "cp -r \"${SCRIPT_DIR}/project-template\" \"${TEMPLATE_DIR_CLAUDE}\""
# Shared wiki (dùng chung BA/BE/FE/QA) — vendored (portable)
run "rm -rf \"${NPX_SKILLS_DIR}/shared-wiki-template\" \"${CLAUDE_SKILLS_DIR}/shared-wiki-template\""
run "cp -r \"${SCRIPT_DIR}/shared-wiki-template\" \"${NPX_SKILLS_DIR}/shared-wiki-template\""
run "cp -r \"${SCRIPT_DIR}/shared-wiki-template\" \"${CLAUDE_SKILLS_DIR}/shared-wiki-template\""

# Mau test case CHUAN cua team = qa-flow/templates/testcase-template.md.
# Ban cai cua project-template luon lay tu mau nay de hai luong (/qa-flow, /qa-orchestrator) cung 1 hinh dang.
TC_CANON="${SCRIPT_DIR}/qa-flow/templates/testcase-template.md"
TC_REPO_COPY="${SCRIPT_DIR}/project-template/wiki/qa/test-cases/_template.md"
echo "  -> Dong bo mau test case tu qa-flow -> project-template (ca 2 noi cai)"
run "cp \"${TC_CANON}\" \"${TEMPLATE_DIR_NPX}/wiki/qa/test-cases/_template.md\""
run "cp \"${TC_CANON}\" \"${TEMPLATE_DIR_CLAUDE}/wiki/qa/test-cases/_template.md\""
if ! cmp -s "$TC_CANON" "$TC_REPO_COPY"; then
  echo "  [!] CANH BAO: project-template/wiki/qa/test-cases/_template.md trong repo LECH voi qa-flow/templates/testcase-template.md"
  echo "      Ban cai da lay theo qa-flow. Hay dong bo lai file trong repo: cp qa-flow/templates/testcase-template.md project-template/wiki/qa/test-cases/_template.md"
fi
echo ""

if [[ "$DRY_RUN" == "false" ]]; then
  echo "[OK] Installed:"
  echo "   - $(ls ${NPX_SKILLS_DIR} 2>/dev/null | grep -c '^qa-') qa-* skills in ${NPX_SKILLS_DIR}/"
  echo "   - $(ls ${CLAUDE_SKILLS_DIR}/qa-*/SKILL.md 2>/dev/null | wc -l) qa-* skills in ${CLAUDE_SKILLS_DIR}/ (menu \"/\" cua Claude Code)"
  agent_count=0
  for f in "${SCRIPT_DIR}/agents/"*.md; do
    [[ "$(basename "$f")" == "README.md" ]] && continue
    [[ -f "${AGENTS_DIR}/$(basename "$f")" ]] && agent_count=$((agent_count + 1))
  done
  echo "   - ${agent_count} agents (qa-* + cx-reviewer) in ${AGENTS_DIR}/"
  echo "   - qa-flow (qa-ai-agents) in ${CLAUDE_SKILLS_DIR}/qa-flow/ ($(ls ${CLAUDE_SKILLS_DIR}/qa-flow/rules 2>/dev/null | wc -l) rules, $(ls ${CLAUDE_SKILLS_DIR}/qa-flow/templates 2>/dev/null | wc -l) templates)"
  echo "   - template in ${TEMPLATE_DIR_NPX}/ and ${TEMPLATE_DIR_CLAUDE}/"
  echo "Next: bootstrap a project → bash ${TEMPLATE_DIR_CLAUDE}/bootstrap.sh /path/to/your-project"
  echo "      hoac mo Claude Code -> /qa-flow <ID>  (tu tai lieu BA)  |  /qa-orchestrator  (tu FEAT)"
else
  echo "[i] Dry run complete."
fi

# Optional: one-shot bootstrap — `bash install.sh /path/to/project`
if [[ -n "$PROJECT" && "$DRY_RUN" == "false" ]]; then
  echo ""
  echo "[bootstrap] Scaffolding QA overlay at ${PROJECT} ..."
  bash "${TEMPLATE_DIR_CLAUDE}/bootstrap.sh" "$PROJECT"
fi
