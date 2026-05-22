@echo off
title Gava + GPM Installer

echo ============================================
echo     GAVA + GPM INSTALLER
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

:: Find Downloads folder
set "DOWNLOADS=%USERPROFILE%\Downloads"

echo [*] Searching for Gava in Downloads...
echo.

:: Check gava.exe
if exist "%DOWNLOADS%\gava.exe" (
    echo [OK] gava.exe found
) else (
    echo [!] gava.exe not found in Downloads
    echo     Please download gava.exe first
)

:: Check gpm.exe
if exist "%DOWNLOADS%\gpm.exe" (
    echo [OK] gpm.exe found
) else (
    echo [!] gpm.exe not found in Downloads
    echo     Please download gpm.exe first
)

:: If neither found, exit
if not exist "%DOWNLOADS%\gava.exe" (
    if not exist "%DOWNLOADS%\gpm.exe" (
        echo.
        echo [ERROR] Nothing to install!
        pause
        exit /b 1
    )
)

:: Create Gava directory
echo.
echo [*] Installing...
mkdir "%USERPROFILE%\Gava" 2>nul
mkdir "%USERPROFILE%\Gava\vendor\gava" 2>nul

:: Move files
if exist "%DOWNLOADS%\gava.exe" (
    move /Y "%DOWNLOADS%\gava.exe" "%USERPROFILE%\Gava\gava.exe" >nul
    echo [OK] gava.exe installed
)

if exist "%DOWNLOADS%\gpm.exe" (
    move /Y "%DOWNLOADS%\gpm.exe" "%USERPROFILE%\Gava\gpm.exe" >nul
    echo [OK] gpm.exe installed
)

:: Create system commands
echo @echo off > "%USERPROFILE%\Gava\gava.bat"
echo "%USERPROFILE%\Gava\gava.exe" %%* >> "%USERPROFILE%\Gava\gava.bat"

echo @echo off > "%USERPROFILE%\Gava\gpm.bat"
echo "%USERPROFILE%\Gava\gpm.exe" %%* >> "%USERPROFILE%\Gava\gpm.bat"

copy /Y "%USERPROFILE%\Gava\gava.bat" "C:\Windows\gava.bat" >nul 2>&1
copy /Y "%USERPROFILE%\Gava\gpm.bat" "C:\Windows\gpm.bat" >nul 2>&1

:: Add to PATH
setx PATH "%PATH%;%USERPROFILE%\Gava" >nul 2>&1

echo.
echo ============================================
echo     INSTALLATION COMPLETE!
echo ============================================
echo.
echo Commands available:
echo   gava start main.gava
echo   gava build main.gava
echo   gpm install log
echo   gpm add my_project
echo.
echo Open a NEW console and try: gpm help
echo.
pause