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
echo try to stop some windows update services
for %%S in (wuauserv cryptSvc bits msiserver) do (
    sc query %%S | find "RUNNING" >nul && (
        net stop %%S || echo failed to stop %%S && goto start-services
    ) || echo %%S is not running, skipping
)

:remove-softwaredistribution
echo try to remove some windows update folders
rd /S /Q %systemroot%\SoftwareDistribution && rd /S /Q %systemroot%\System32\catroot2 || echo failed to remove folders

:start-services
echo try to start some windows update services
for %%S in (wuauserv cryptSvc bits msiserver) do (
    sc query %%S | find "RUNNING" >nul && echo %%S is already running, skipping || (
        net start %%S || echo failed to start %%S
    )
)

:reset-authorization
echo try to reset windows update authorization
wuauclt /resetauthorization

:exits
echo done
timeout 5
exit
