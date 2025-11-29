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
TITLE Enable SMB access to passwordless shares
ECHO Ready?
echo 1 Enable
echo 2 Disable
echo 3 Exit
set /p uni= Type option in number:
if %uni% ==1 goto :enable
if %uni% ==2 goto :disable
if %uni% ==3 goto :exits

:enable
powershell -command "Set-SmbClientConfiguration -RequireSecuritySignature $false"
powershell -command "Set-SmbClientConfiguration -EnableInsecureGuestLogons $true"
goto :exits

:disable
powershell -command "Set-SmbClientConfiguration -RequireSecuritySignature $true"
powershell -command "Set-SmbClientConfiguration -EnableInsecureGuestLogons $false"
goto :exits

:exits
timeout 10
exit
