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
dism /online /add-package /norestart /packagepath:.\


del *.cab


shutdown /r /t 10 /f
REM shutdown /s /t 10 /f


del "cab update Installer (self destruct mode).bat" && timeout 5 && exit