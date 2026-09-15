@echo off
REM bootstrap.bat - Scaffold / overlay QA discipline (tester-skill) onto a project.
REM wiki = shared-wiki-template + qa overlay; _project-root config copied NON-CLOBBER.
REM QA agents are installed globally by install.bat (not copied per-project).
REM Usage: bootstrap.bat <project-path> [project-name]
setlocal EnableDelayedExpansion
set SCRIPT_DIR=%~dp0

if "%~1"=="" (
  echo Usage: bootstrap.bat ^<project-path^> [project-name]
  exit /b 1
)
set PROJECT_PATH=%~1
set PROJECT_NAME=%~2
if "%PROJECT_NAME%"=="" for %%i in ("%PROJECT_PATH%") do set PROJECT_NAME=%%~nxi

REM Resolve shared-wiki-template: installed first, then own-repo vendored
set SHARED_SRC=%USERPROFILE%\.claude\skills\shared-wiki-template
if not exist "%SHARED_SRC%" set SHARED_SRC=%USERPROFILE%\.agents\skills\shared-wiki-template
if not exist "%SHARED_SRC%" set SHARED_SRC=%SCRIPT_DIR%..\shared-wiki-template
if not exist "%SHARED_SRC%" (
  echo ERROR: shared-wiki-template not found. Run install.bat first.
  exit /b 1
)

echo Bootstrapping QA discipline: %PROJECT_NAME%
echo    Target: %PROJECT_PATH%
if not exist "%PROJECT_PATH%" mkdir "%PROJECT_PATH%"

REM 1. _project-root config - NON-CLOBBER (khong ghi de AGENTS/CLAUDE/config discipline khac)
robocopy "%SCRIPT_DIR%_project-root" "%PROJECT_PATH%" /E /XC /XN /XO /NFL /NDL /NJH /NJS /NP >nul
if %ERRORLEVEL% GEQ 8 ( echo [WARN] robocopy _project-root error ) & (call )

REM 2. wiki = shared + qa overlay
if not exist "%PROJECT_PATH%\wiki" mkdir "%PROJECT_PATH%\wiki"
xcopy /E /I /H /Q /Y "%SHARED_SRC%\*" "%PROJECT_PATH%\wiki\" >nul
xcopy /E /I /H /Q /Y "%SCRIPT_DIR%wiki\*" "%PROJECT_PATH%\wiki\" >nul

REM 3. substitute placeholders
powershell -NoProfile -Command ^
  "Get-ChildItem -Path '%PROJECT_PATH%' -Recurse -Include '*.md','*.yml','*.yaml' | ForEach-Object { $c = Get-Content $_.FullName -Raw -Encoding UTF8; $c = $c -replace '\{PROJECT_NAME\}','%PROJECT_NAME%'; Set-Content $_.FullName -Value $c -NoNewline -Encoding UTF8 }"

echo Done. QA overlay scaffolded at %PROJECT_PATH%
echo    Next: cd %PROJECT_PATH%, open Claude Code -> /qa-orchestrator
endlocal
