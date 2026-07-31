@echo off

>nul 2>&1 reg.exe query HKU\S-1-5-19 && (goto gotAdmin) || (goto UACPrompt)
:UACPrompt
if exist "%SYSTEMROOT%\System32\Cscript.exe" (
    if exist "%SYSTEMROOT%\System32\vbscript.dll" (
        echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "%~s0", "", "", "runas", 1 > "%temp%\getadmin.vbs"
        cscript //nologo "%temp%\getadmin.vbs"
        exit /b
    )
)
>nul 2>&1 where /Q powershell.exe && (
    powershell -Command "Start-Process -Verb RunAs -FilePath '%~s0'"
    exit /b
)
:gotAdmin
if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs"
pushd "%CD%" && CD /D "%~dp0"
cls
TITLE Fixes the issue where the taskbar and XAML-dependent buttons do not respond
ECHO This action crashes all active graphical applications when dwm.exe is required.
ECHO The screen may flicker briefly during this process.
ECHO ==================================================
ECHO Ready?
echo 1 No
echo 2 Yes
set /p uni= Type the option number:
if %uni% ==1 goto :exits
if %uni% ==2 goto :runs

:runs
taskkill /F /IM dwm.exe

:exits
timeout 10
exit
