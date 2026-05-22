@echo off
title Gava + GPM Uninstaller

echo ============================================
echo     GAVA + GPM UNINSTALLER
echo ============================================
echo.

:: Check admin
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] Administrator rights required!
    echo Right-click on this file - Run as Administrator
    pause
    exit /b 1
)

echo [*] Removing Gava and GPM...

:: Remove from Windows
if exist "C:\Windows\gava.bat"  del /f /q "C:\Windows\gava.bat"
if exist "C:\Windows\gpm.bat"   del /f /q "C:\Windows\gpm.bat"
if exist "C:\Windows\gava-cmd.bat" del /f /q "C:\Windows\gava-cmd.bat"

:: Remove install folder
if exist "%USERPROFILE%\Gava" rmdir /s /q "%USERPROFILE%\Gava"

echo [OK] Gava and GPM removed!
echo.
echo NOTE: Check PATH manually to remove old entries.
echo   Win+R - sysdm.cpl - Advanced - Environment Variables
echo.
pause