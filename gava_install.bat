@echo off
chcp 1251 >nul 2>&1
color 0B
title Установщик Gava

:: ========== НАСТРОЙКИ ==========
set DOWNLOAD_URL=https://github.com/wassss337/gava/raw/refs/heads/main/gava.exe
set INSTALL_DIR=%USERPROFILE%\Gava
:: ===============================

echo ============================================
echo     ДОБРО ПОЖАЛОВАТЬ В УСТАНОВЩИК GAVA
echo ============================================
echo.
echo Gava - язык программирования с синтаксисом
echo похожим на Java, но написанный на C++.
echo.
echo Особенности:
echo   - Быстрый как C++
echo   - Простой как Java
echo   - Свой пакетный менеджер GPM
echo   - Компиляция в EXE
echo   - GUI на WinAPI
echo.
echo ============================================
echo   Хотите установить Gava? (y/n)
echo ============================================

choice /c yn /n /m "Ваш выбор: "

if errorlevel 2 goto :no
if errorlevel 1 goto :yes

:yes
echo.
echo [*] Создаю папку для установки...
mkdir "%INSTALL_DIR%" 2>nul

echo [*] Скачиваю Gava...
powershell -Command "Invoke-WebRequest -Uri '%DOWNLOAD_URL%' -OutFile '%INSTALL_DIR%\gava.exe'" 2>nul

if not exist "%INSTALL_DIR%\gava.exe" (
    echo [ERROR] Не удалось скачать Gava.
    echo Проверьте подключение к интернету.
    echo Ссылка: %DOWNLOAD_URL%
    pause
    exit /b 1
)

echo [OK] Gava скачана.

echo [*] Добавляю в PATH...
setx PATH "%PATH%;%INSTALL_DIR%" >nul 2>&1

echo [*] Создаю системную команду...
(
    echo @echo off
    echo "%INSTALL_DIR%\gava.exe" %%*
) > "%INSTALL_DIR%\gava.bat"

copy /Y "%INSTALL_DIR%\gava.bat" "C:\Windows\gava.bat" >nul 2>&1

echo.
echo ============================================
echo   УСТАНОВКА ЗАВЕРШЕНА!
echo ============================================
echo.
echo Gava установлена в: %INSTALL_DIR%
echo.
echo Команды:
echo   gava start файл.gava    - запустить программу
echo   gava build файл.gava    - скомпилировать в EXE
echo   gava install url        - установить библиотеку
echo.
echo После перезагрузки изменения вступят в силу.
echo.
pause
del /f /q "%~f0" >nul 2>&1
exit

:no
echo.
echo Установка отменена.
echo Если передумаете - запустите этот файл снова.
echo.
pause
exit
