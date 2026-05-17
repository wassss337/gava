@echo off
chcp 1251 >nul 2>&1
color 0B
title Gava Ecosystem Installer

echo ============================================
echo   GAVA ECOSYSTEM INSTALLER v1.0
echo ============================================
echo.
echo This will install:
echo   1. Gava Interpreter (gava.exe)
echo   2. Gava Command Prompt (gava_cmd.exe)
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

:: Копируем файлы (предполагаем, что они лежат рядом с установщиком)
echo [*] Copying files...
copy /Y "%~dp0gava.exe" "%USERPROFILE%\Gava\gava.exe" 2>nul
copy /Y "%~dp0gava_cmd.exe" "%USERPROFILE%\Gava\gava_cmd.exe" 2>nul

:: Создаём системную команду gava
echo [*] Creating system commands...
(
    echo @echo off
    echo "%USERPROFILE%\Gava\gava.exe" %%*
) > "%USERPROFILE%\Gava\gava.bat"

copy /Y "%USERPROFILE%\Gava\gava.bat" "C:\Windows\gava.bat" >nul 2>&1

:: Создаём системную команду gava-cmd
(
    echo @echo off
    echo "%USERPROFILE%\Gava\gava_cmd.exe" %%*
) > "%USERPROFILE%\Gava\gava_cmd.bat"

copy /Y "%USERPROFILE%\Gava\gava_cmd.bat" "C:\Windows\gava-cmd.bat" >nul 2>&1

:: Добавляем в PATH
echo [*] Adding to PATH...
setx PATH "%PATH%;%USERPROFILE%\Gava" >nul 2>&1

:: Запускаем gava_cmd для финальной настройки
echo [*] Running Gava Command Prompt...
start /min "" "%USERPROFILE%\Gava\gava_cmd.exe" --silent

echo.
echo ============================================
echo   INSTALLATION COMPLETE!
echo ============================================
echo.
echo Available commands:
echo   gava       - Run Gava scripts
echo   gava-cmd   - Open Gava Command Prompt
echo.
echo Open a new console and try: gava
echo.
pause