# install.ps1 - Install tester-skill (QA discipline) global for Claude Code (+ optionally Cursor) on Windows
#
# Wraps:
#   1. npx skills add -> copy qa-* skills to $env:USERPROFILE\.agents\skills\
#   2. cp agents\qa-*.md -> $env:USERPROFILE\.claude\agents\
#   3. cp -r project-template -> BOTH locations (.agents\skills\ and .claude\skills\)
#   4. cp -r shared-wiki-template (vendored, shared BA/BE/FE/QA)
#
# Usage:
#   .\install.ps1                  # claude-code only
#   .\install.ps1 -WithCursor      # claude-code + cursor
#   .\install.ps1 -DryRun          # show what would be done
#   .\install.ps1 -Uninstall       # remove
#   .\install.ps1 -NoPause         # skip Read-Host pause (for .bat wrapper)

param(
    [Parameter(Position=0)][string]$Project = "",
    [switch]$WithCursor,
    [switch]$DryRun,
    [switch]$Uninstall,
    [switch]$NoPause
)

$ErrorActionPreference = "Stop"

function Pause-AtEnd {
    param([int]$ExitCode = 0)
    if ($NoPause) { exit $ExitCode }
    Write-Host ""
    if ($ExitCode -ne 0) {
        Write-Host "[X] Install FAILED with exit code $ExitCode" -ForegroundColor Red
    }
    Write-Host ""
    Read-Host "Press Enter to close"
    exit $ExitCode
}

trap {
    Write-Host ""
    Write-Host "[X] Error: $_" -ForegroundColor Red
    Pause-AtEnd -ExitCode 1
}

$ScriptDir         = $PSScriptRoot
$ClaudeDir         = Join-Path $env:USERPROFILE ".claude"
$AgentsDir         = Join-Path $ClaudeDir "agents"
$ClaudeSkillsDir   = Join-Path $ClaudeDir "skills"
$NpxSkillsDir      = Join-Path $env:USERPROFILE ".agents\skills"
$TemplateDirNpx    = Join-Path $NpxSkillsDir "qa-project-template"
$TemplateDirClaude = Join-Path $ClaudeSkillsDir "qa-project-template"

function Run-Cmd {
    param([string]$Description, [scriptblock]$Block)
    Write-Host "  > $Description"
    if (-not $DryRun) { & $Block }
}

# Uninstall
if ($Uninstall) {
    Write-Host "[~] Uninstalling tester-skill..."
    Get-ChildItem -Directory $ScriptDir -Filter "qa-*" | ForEach-Object {
        $name = $_.Name
        Run-Cmd "Remove $name" {
            Remove-Item -Recurse -Force (Join-Path $NpxSkillsDir $name) -ErrorAction SilentlyContinue
            Remove-Item -Recurse -Force (Join-Path $ClaudeSkillsDir $name) -ErrorAction SilentlyContinue
        }
    }
    Run-Cmd "Remove project-template (npx location)" {
        Remove-Item -Recurse -Force $TemplateDirNpx -ErrorAction SilentlyContinue
    }
    Run-Cmd "Remove project-template (claude location)" {
        Remove-Item -Recurse -Force $TemplateDirClaude -ErrorAction SilentlyContinue
    }
    Get-ChildItem (Join-Path $ScriptDir "agents") -Filter "*.md" -ErrorAction SilentlyContinue | Where-Object { $_.Name -ne "README.md" } | ForEach-Object {
        $name = $_.Name
        Run-Cmd "Remove agent $name" {
            Remove-Item -Force (Join-Path $AgentsDir $name) -ErrorAction SilentlyContinue
        }
    }
    Write-Host "[OK] Uninstalled."
    Pause-AtEnd 0
}

# Install
Write-Host "[+] Installing tester-skill (QA) global..."
Write-Host "   Source: $ScriptDir"
Write-Host "   Target: $ClaudeDir + $NpxSkillsDir"
Write-Host ""

Write-Host "[1/3] Skills (qa-orchestrator + qa-*) -> $NpxSkillsDir\"
$NpxAgents = "-a claude-code"
if ($WithCursor) { $NpxAgents = "$NpxAgents -a cursor" }

if (Get-Command npx -ErrorAction SilentlyContinue) {
    Run-Cmd "npx skills add . --all $NpxAgents -g" {
        Push-Location $ScriptDir
        try {
            $cmd = "npx skills add . --all $NpxAgents -g"
            Invoke-Expression $cmd
        } finally {
            Pop-Location
        }
    }
} else {
    Write-Host "  [!] npx not found - fallback to manual copy"
    Run-Cmd "mkdir skills" { New-Item -ItemType Directory -Force -Path $NpxSkillsDir | Out-Null }
    Get-ChildItem -Directory $ScriptDir -Filter "qa-*" | ForEach-Object {
        $src = $_.FullName
        Run-Cmd "Copy $($_.Name)" { Copy-Item -Recurse -Force $src $NpxSkillsDir }
    }
}

# Claude Code doc ~/.claude/skills/<name>/SKILL.md (VIET HOA), KHONG doc ~/.agents/skills/.
# Thieu buoc nay thi skill khong hien trong menu "/" cua Claude Code.
Write-Host "  -> Claude Code native: $ClaudeSkillsDir\<name>\SKILL.md"
Run-Cmd "mkdir claude skills dir" { New-Item -ItemType Directory -Force -Path $ClaudeSkillsDir | Out-Null }
Get-ChildItem -Directory $ScriptDir -Filter "qa-*" | ForEach-Object {
    $name    = $_.Name
    $srcSkill = Join-Path $_.FullName "skill.md"
    if (Test-Path $srcSkill) {
        $destDir = Join-Path $ClaudeSkillsDir $name
        Run-Cmd "Install skill $name -> SKILL.md" {
            New-Item -ItemType Directory -Force -Path $destDir | Out-Null
            Copy-Item -Force $srcSkill (Join-Path $destDir "SKILL.md")
        }
    }
}
Write-Host ""

Write-Host "[2/3] Agents -> $AgentsDir\"
Run-Cmd "mkdir agents" { New-Item -ItemType Directory -Force -Path $AgentsDir | Out-Null }
Get-ChildItem (Join-Path $ScriptDir "agents") -Filter "*.md" -ErrorAction SilentlyContinue | Where-Object { $_.Name -ne "README.md" } | ForEach-Object {
    $src = $_.FullName
    Run-Cmd "Copy agent $($_.Name)" { Copy-Item -Force $src $AgentsDir }
}
Write-Host ""

Write-Host "[3/3] Project template + shared wiki -> BOTH locations"
Run-Cmd "mkdir npx skills dir" { New-Item -ItemType Directory -Force -Path $NpxSkillsDir | Out-Null }
Run-Cmd "mkdir claude skills dir" { New-Item -ItemType Directory -Force -Path $ClaudeSkillsDir | Out-Null }
Run-Cmd "Remove old template (npx)" {
    Remove-Item -Recurse -Force $TemplateDirNpx -ErrorAction SilentlyContinue
}
Run-Cmd "Remove old template (claude)" {
    Remove-Item -Recurse -Force $TemplateDirClaude -ErrorAction SilentlyContinue
}
Run-Cmd "Copy project-template -> npx" {
    Copy-Item -Recurse -Force (Join-Path $ScriptDir "project-template") $TemplateDirNpx
}
Run-Cmd "Copy project-template -> claude" {
    Copy-Item -Recurse -Force (Join-Path $ScriptDir "project-template") $TemplateDirClaude
}
Run-Cmd "Copy shared-wiki-template (vendored, shared BA/BE/FE/QA)" {
    $sharedSrc = Join-Path $ScriptDir "shared-wiki-template"
    if (Test-Path $sharedSrc) {
        foreach ($d in @($NpxSkillsDir, $ClaudeSkillsDir)) {
            $dst = Join-Path $d "shared-wiki-template"
            Remove-Item -Recurse -Force $dst -ErrorAction SilentlyContinue
            Copy-Item -Recurse -Force $sharedSrc $dst
        }
    }
}
Write-Host ""

if (-not $DryRun) {
    $skillCount  = (Get-ChildItem $NpxSkillsDir -Directory -ErrorAction SilentlyContinue | Where-Object { $_.Name -match '^qa-' }).Count
    $agentCount  = (Get-ChildItem $AgentsDir -Filter "qa-*.md" -ErrorAction SilentlyContinue).Count

    Write-Host "[OK] Installed:"
    $claudeSkillCount = (Get-ChildItem $ClaudeSkillsDir -Directory -ErrorAction SilentlyContinue | Where-Object { $_.Name -match '^qa-' }).Count
    Write-Host "   - $skillCount qa-* skills in $NpxSkillsDir\"
    Write-Host "   - $claudeSkillCount qa-* skills in $ClaudeSkillsDir\ (menu '/' cua Claude Code)"
    Write-Host "   - $agentCount qa agents in $AgentsDir\"
    Write-Host "   - template in $TemplateDirNpx\"
    Write-Host "   - template in $TemplateDirClaude\"
} else {
    Write-Host "[i] Dry run complete. Re-run without -DryRun to apply."
}

# Optional: bootstrap a project in one shot -> install.ps1 C:\path\to\project
if ($Project -and -not $DryRun) {
    Write-Host ""
    Write-Host "[bootstrap] Scaffolding QA overlay at $Project ..."
    & (Join-Path $TemplateDirClaude "bootstrap.ps1") -ProjectPath $Project
}

Pause-AtEnd 0
