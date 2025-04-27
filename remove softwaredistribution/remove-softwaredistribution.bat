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

Title remove softwaredistribution

:stop-services
echo [SCRIPT] Trying to stop some Windows Update services
for %%S in (wuauserv cryptSvc bits msiserver) do (
    sc query %%S | find "RUNNING" >nul && (
        net stop %%S || echo [SCRIPT] Failed to stop %%S && goto start-services
    ) || echo [SCRIPT] %%S is not running, skipping
)

:remove-softwaredistribution
echo [SCRIPT] Trying to remove some Windows Update folders
rd /S /Q %systemroot%\SoftwareDistribution && rd /S /Q %systemroot%\System32\catroot2 || echo [SCRIPT] Failed to remove folders

:start-services
echo [SCRIPT] Trying to start some Windows Update services
for %%S in (wuauserv cryptSvc bits msiserver) do (
    sc query %%S | find "RUNNING" >nul && echo [SCRIPT] %%S is already running, skipping || (
        net start %%S || echo [SCRIPT] Failed to start %%S
    )
)

:reset-authorization
echo [SCRIPT] Trying to reset Windows Update authorization
wuauclt /resetauthorization

:exits
echo [SCRIPT] Done
timeout 5
exit
