# bootstrap.ps1 - Scaffold / overlay QA discipline (tester-skill) onto a project.
# wiki = shared-wiki-template + qa overlay; _project-root config copied NON-CLOBBER.
# QA agents are installed globally by install.ps1 (not copied per-project).
# Usage: pwsh bootstrap.ps1 <project-path> [project-name]
param(
    [Parameter(Mandatory=$true, Position=0)][string]$ProjectPath,
    [Parameter(Position=1)][string]$ProjectName = ""
)
$ErrorActionPreference = "Stop"
$ScriptDir = $PSScriptRoot
if (-not $ProjectName) { $ProjectName = Split-Path $ProjectPath -Leaf }

$SharedSrc = $null
foreach ($c in @(
    (Join-Path $env:USERPROFILE ".claude\skills\shared-wiki-template"),
    (Join-Path $env:USERPROFILE ".agents\skills\shared-wiki-template"),
    (Join-Path (Split-Path $ScriptDir -Parent) "shared-wiki-template"))) {
    if (Test-Path $c) { $SharedSrc = $c; break }
}
if (-not $SharedSrc) { Write-Error "shared-wiki-template not found. Run install.ps1 first."; exit 1 }

Write-Output "Bootstrapping QA discipline: $ProjectName -> $ProjectPath"
New-Item -ItemType Directory -Path $ProjectPath -Force | Out-Null
# non-clobber: khong ghi de AGENTS/CLAUDE/config cua discipline khac (chi copy file chua co)
$null = robocopy (Join-Path $ScriptDir "_project-root") $ProjectPath /E /XC /XN /XO /NFL /NDL /NJH /NJS /NP
if ($LASTEXITCODE -ge 8) { throw "robocopy _project-root failed ($LASTEXITCODE)" }; $global:LASTEXITCODE = 0

$wiki = Join-Path $ProjectPath "wiki"
New-Item -ItemType Directory -Path $wiki -Force | Out-Null
Copy-Item -Path (Join-Path $SharedSrc "*")           -Destination $wiki -Recurse -Force   # canonical shared
Copy-Item -Path (Join-Path $ScriptDir "wiki\*")      -Destination $wiki -Recurse -Force   # qa overlay

Get-ChildItem -Path $ProjectPath -Recurse -Include '*.md','*.yml','*.yaml' | ForEach-Object {
    $c = Get-Content $_.FullName -Raw -Encoding UTF8
    $c = $c -replace '\{PROJECT_NAME\}', $ProjectName
    Set-Content $_.FullName -Value $c -NoNewline -Encoding UTF8
}
Write-Output "Done. QA overlay scaffolded at $ProjectPath"
Write-Output "   Next: cd $ProjectPath ; open Claude Code -> /qa-orchestrator"
