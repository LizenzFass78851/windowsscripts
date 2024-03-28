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
cls
Title Group Policy Installer
echo Was soll das Setup tun?
echo 1 Installieren
echo 2 Deinstallieren
echo 3 Beenden
echo 4 Hilfe
set /p uni= Option in Zahl eintippen:
if %uni% ==1 goto :in
if %uni% ==2 goto :un
if %uni% ==3 goto :ex
if %uni% ==4 goto :hi

:in
cls
Title Install Group Policy

pushd "%~dp0" 

dir /b %SystemRoot%\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientExtensions-Package~3*.mum >List.txt 
dir /b %SystemRoot%\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientTools-Package~3*.mum >>List.txt 

for /f %%i in ('findstr /i . List.txt 2^>nul') do dism /online /norestart /add-package:"%SystemRoot%\servicing\Packages\%%i" 

del List.txt

cls

echo gebe in der "Zur Suche Text hier eingeben" (Suchleiste in der Taskleiste) gpedit.msc ein um die Gruppenrichtlinie zu finden

pause
goto :ex

:un
cls
Title Uninstall Group Policy

pushd "%~dp0" 

dir /b %SystemRoot%\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientExtensions-Package~3*.mum >List.txt 
dir /b %SystemRoot%\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientTools-Package~3*.mum >>List.txt 

for /f %%i in ('findstr /i . List.txt 2^>nul') do dism /online /norestart /remove-package:"%SystemRoot%\servicing\Packages\%%i" 

del List.txt

pause
goto :ex

:ex
exit

:hi
cls
echo Wenn die Gruppenrichtlinie installiert ist
echo gebe in der "Zur Suche Text hier eingeben" (Suchleiste in der Taskleiste) gpedit.msc ein um die Gruppenrichtlinie zu finden
echo Soll gpedit.msc gestartet werden?
echo 1 Ja
echo 2 Nein
set /p uni= Option in Zahl eintippen:
if %uni% ==1 goto :ja
if %uni% ==2 goto :ex

:ja
start gpedit.msc
goto :ex