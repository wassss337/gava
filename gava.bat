@echo off
chcp 1251 >nul 2>&1
color 0B
title Gava Ecosystem Installer

:: Проверка прав администратора
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ============================================
    echo   ТРЕБУЮТСЯ ПРАВА АДМИНИСТРАТОРА
    echo ============================================
    echo.
    echo Запустите этот файл от имени администратора!
    echo Правый клик по файлу -> Запуск от имени администратора
    echo.
    pause
    exit /b 1
)

echo ============================================
echo   GAVA ECOSYSTEM INSTALLER v1.1
echo ============================================
echo.
echo This will install:
echo   1. Gava Interpreter ^(gava.exe^)
echo   2. Gava Command Prompt ^(gava_cmd.exe^)
echo.
echo ============================================
echo   Press any key to install...
echo ============================================
pause >nul

:: Создаём папку Gava
echo.
echo [*] Creating Gava directory...
mkdir "%USERPROFILE%\Gava" 2>nul
mkdir "%USERPROFILE%\Gava\vendor\gava" 2>nul

:: Копируем файлы
echo [*] Copying gava.exe...
if exist "%~dp0gava.exe" (
    copy /Y "%~dp0gava.exe" "%USERPROFILE%\Gava\gava.exe" >nul
    echo [OK] gava.exe copied
) else (
    echo [WARNING] gava.exe not found in current folder
)

echo [*] Copying gava_cmd.exe...
if exist "%~dp0gava_cmd.exe" (
    copy /Y "%~dp0gava_cmd.exe" "%USERPROFILE%\Gava\gava_cmd.exe" >nul
    echo [OK] gava_cmd.exe copied
) else (
    echo [WARNING] gava_cmd.exe not found in current folder
)

:: Создаём gava.bat
echo [*] Creating gava.bat...
(
    echo @echo off
    echo "%USERPROFILE%\Gava\gava.exe" %%*
) > "%USERPROFILE%\Gava\gava.bat"

:: Копируем gava.bat в C:\Windows
copy /Y "%USERPROFILE%\Gava\gava.bat" "C:\Windows\gava.bat" >nul
echo [OK] gava.bat created in C:\Windows

:: Создаём gava-cmd.bat
echo [*] Creating gava-cmd.bat...
(
    echo @echo off
    echo "%USERPROFILE%\Gava\gava_cmd.exe" %%*
) > "%USERPROFILE%\Gava\gava-cmd.bat

:: Копируем gava-cmd.bat в C:\Windows (ВНИМАНИЕ: имя файла с дефисом!)
copy /Y "%USERPROFILE%\Gava\gava-cmd.bat" "C:\Windows\gava-cmd.bat" >nul
echo [OK] gava-cmd.bat created in C:\Windows

:: Добавляем в системный PATH
echo [*] Adding to system PATH...
setx PATH "%PATH%;%USERPROFILE%\Gava" >nul 2>&1
echo [OK] Added to PATH

:: Обновляем PATH в текущей сессии
set "PATH=%PATH%;%USERPROFILE%\Gava"

echo.
echo ============================================
echo   INSTALLATION COMPLETE!
echo ============================================
echo.
echo Available commands:
echo   gava       - Run Gava scripts
echo   gava-cmd   - Open Gava Command Prompt
echo.
echo Testing installation...
echo.

:: Проверяем gava
where gava >nul 2>&1
if %errorLevel% equ 0 (
    echo [OK] gava command works!
) else (
    echo [NOTE] gava will work after restart
)

:: Проверяем gava-cmd
where gava-cmd >nul 2>&1
if %errorLevel% equ 0 (
    echo [OK] gava-cmd command works!
) else (
    echo [NOTE] gava-cmd will work after restart
)

echo.
echo Open a NEW console and try: gava
echo Or restart your computer.
echo.
pause