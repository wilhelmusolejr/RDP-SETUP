@echo off
setlocal

rem Double-click this file on a fresh Windows RDP machine.
fltmc >nul 2>&1
if errorlevel 1 (
    echo Requesting administrator access...
    set "RDP_SETUP_LAUNCHER=%~f0"
    powershell.exe -NoProfile -Command "$ErrorActionPreference='Stop'; Start-Process -FilePath $env:RDP_SETUP_LAUNCHER -Verb RunAs"
    if errorlevel 1 (
        echo Administrator access was not granted. Setup did not run.
        pause
        exit /b 1
    )
    exit /b 0
)

if not exist "%~dp0setup-fresh-rdp.ps1" (
    echo setup-fresh-rdp.ps1 was not found next to this batch file.
    pause
    exit /b 1
)

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0setup-fresh-rdp.ps1"
set "setup_exit=%errorlevel%"
if not "%setup_exit%"=="0" echo Setup failed. Review the error above.
echo.
pause
exit /b %setup_exit%
