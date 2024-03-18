@echo off

>nul 2>&1 fsutil dirty query %systemdrive% && (goto gotAdmin) || (goto UACPrompt)
:UACPrompt
if exist "%SYSTEMROOT%\System32\Cscript.exe" (
    echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B
) else (
    powershell -Command "Start-Process -Verb RunAs -FilePath '%0' -ArgumentList 'am_admin'"
    exit /b
)
:gotAdmin
if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs"
pushd "%CD%" && CD /D "%~dp0"
cls
dism /online /add-package /packagepath:.\
pause
exit