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

Title remove softwaredistribution
SET LINE===================================================

:stop-services
echo %LINE%
echo [SCRIPT] Trying to stop some Windows Update services
echo %LINE%
for %%S in (wuauserv cryptSvc bits msiserver) do (
    sc query %%S | find "RUNNING" >nul && (
        net stop %%S || echo [SCRIPT] Failed to stop %%S && goto start-services
    ) || echo [SCRIPT] %%S is not running, skipping
)

:remove-softwaredistribution
echo %LINE%
echo [SCRIPT] Trying to remove some Windows Update folders
echo %LINE%
rd /S /Q %systemroot%\SoftwareDistribution && rd /S /Q %systemroot%\System32\catroot2 || echo [SCRIPT] Failed to remove folders

:start-services
echo %LINE%
echo [SCRIPT] Trying to start some Windows Update services
echo %LINE%
for %%S in (wuauserv cryptSvc bits msiserver) do (
    sc query %%S | find "RUNNING" >nul && echo [SCRIPT] %%S is already running, skipping || (
        net start %%S || echo [SCRIPT] Failed to start %%S
    )
)

:reset-authorization
echo %LINE%
echo [SCRIPT] Trying to reset Windows Update authorization
echo %LINE%
wuauclt /resetauthorization

:exits
echo [SCRIPT] Done
timeout 10
exit
