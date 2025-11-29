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
TITLE Nur das alte Kontextmenü aufrufen
ECHO Bereit?
echo 1 Nein
echo 2 Ja
set /p uni= Option in Zahl eintippen:
if %uni% ==1 goto :exits
if %uni% ==2 goto :runs

:runs
reg.exe add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
taskkill /IM explorer.exe /F && start explorer.exe

:exits
timeout 10
exit
