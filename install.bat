@echo off
REM install.bat  Wrapper for install.ps1 on Windows (tester-skill / QA)
REM
REM Usage:
REM   install.bat                  - install claude-code only
REM   install.bat -WithCursor      - install + cursor
REM   install.bat -DryRun          - preview
REM   install.bat -Uninstall       - remove

setlocal
cd /d "%~dp0"

echo.
echo === tester-skill (QA) installer ===
echo.

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0install.ps1" -NoPause %*

set EXITCODE=%ERRORLEVEL%

echo.
if %EXITCODE% NEQ 0 (
    echo [!] install.ps1 exited with error code %EXITCODE%
    echo     See log above for details.
) else (
    echo [OK] Installer finished successfully.
)

echo.
pause

endlocal
exit /b %EXITCODE%
