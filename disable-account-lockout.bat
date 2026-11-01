@echo off
setlocal

rem Run this file on the Windows computer whose local policy you want to change.
fltmc >nul 2>&1
if errorlevel 1 (
    echo Administrator rights are required.
    echo Right-click this file and select "Run as administrator".
    pause
    exit /b 1
)

echo Setting the local account lockout threshold to 0...
net accounts /lockoutthreshold:0
if errorlevel 1 (
    echo Failed to change the local account lockout policy.
    pause
    exit /b 1
)

echo.
echo Current local account policy:
net accounts
echo.
echo Done. Local accounts will not lock out after failed password attempts.
pause
exit /b 0
