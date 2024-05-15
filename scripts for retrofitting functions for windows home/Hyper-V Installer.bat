@echo off

>nul 2>&1 fsutil dirty query %systemdrive% && (goto gotAdmin) || (goto UACPrompt)
:UACPrompt
if exist "%SYSTEMROOT%\System32\Cscript.exe" (
    echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "%~s0", "", "", "runas", 1 > "%temp%\getadmin.vbs"
    cscript //nologo "%temp%\getadmin.vbs"
    exit /b
) else (
    powershell -Command "Start-Process -Verb RunAs -FilePath '%~s0'"
    exit /b
)
:gotAdmin
if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs"
pushd "%CD%" && CD /D "%~dp0"
cls
GOTO:menu
:menu
Title Hyper-V Installer
echo Backup wird dringend empfohlen!
echo um u.a. Hyper-V spurenlos und sicher zu entfernen.
echo --------------------------------------------------
echo Was soll das Setup tun?
echo 1 Installieren
echo 2 Deinstallieren
echo 3 Beenden
set /p uni= Option in Zahl eintippen:
if %uni% ==1 goto :in
if %uni% ==2 goto :un
if %uni% ==3 goto :ex

:in
cls
Title Install Hyper-V

pushd "%~dp0"

dir /b %SystemRoot%\servicing\Packages\*Hyper-V*.mum >hyper-v.txt

for /f %%i in ('findstr /i . hyper-v.txt 2^>nul') do dism /online /norestart /add-package:"%SystemRoot%\servicing\Packages\%%i"

del hyper-v.txt

Dism /online /enable-feature /featurename:Microsoft-Hyper-V-All /LimitAccess /ALL /NoRestart

goto :remenu

:un
cls
Title Uninstall Hyper-V

pushd "%~dp0"

Dism /online /disable-feature /featurename:Microsoft-Hyper-V-All /NoRestart

dir /b %SystemRoot%\servicing\Packages\*Hyper-V*.mum >hyper-v.txt

for /f %%i in ('findstr /i . hyper-v.txt 2^>nul') do dism /online /norestart /remove-package:"%SystemRoot%\servicing\Packages\%%i"

del hyper-v.txt

goto :remenu

:remenu
cls
echo Möchten Sie den Computer jetzt neu starten?
echo 1 Ja
echo 2 Nein
set /p uni= Option in Zahl eintippen:
if %uni% ==1 goto :re
if %uni% ==2 goto :ex

:re
shutdown /r /t 0 /f
goto :ex

:ex
exit