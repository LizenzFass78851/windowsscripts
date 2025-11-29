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
GOTO:menu
:menu
Title Sandbox Installer
echo Backup wird dringend empfohlen!
echo um u.a. die Sandbox spurenlos und sicher zu entfernen.
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
Title Install Sandbox

pushd "%~dp0"

dir /b %SystemRoot%\servicing\Packages\*Containers*.mum >sandbox.txt

for /f %%i in ('findstr /i . sandbox.txt 2^>nul') do dism /online /norestart /add-package:"%SystemRoot%\servicing\Packages\%%i"

del sandbox.txt

Dism /online /enable-feature /featurename:Containers-DisposableClientVM /LimitAccess /ALL /NoRestart

goto :remenu

:un
cls
Title Uninstall Sandbox

pushd "%~dp0"

Dism /online /disable-feature /featurename:Containers-DisposableClientVM /NoRestart

dir /b %SystemRoot%\servicing\Packages\*Containers*.mum >sandbox.txt

for /f %%i in ('findstr /i . sandbox.txt 2^>nul') do dism /online /norestart /remove-package:"%SystemRoot%\servicing\Packages\%%i"

del sandbox.txt

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