@echo off
setlocal
title Scheduled Power Action

set "ACTION=reboot"
set "RESTART_HOUR=5"
set "RESTART_MINUTE=30"

for /f %%S in ('powershell.exe -NoProfile -Command "$now = Get-Date; $target = [datetime]::Today.AddHours(%RESTART_HOUR%).AddMinutes(%RESTART_MINUTE%); if ($now -ge $target) { $target = $target.AddDays(1) }; [int][math]::Ceiling(($target - $now).TotalSeconds)"') do set "SECONDS=%%S"

if not defined SECONDS (
    echo Error: Failed to calculate the scheduled time.
    pause
    exit /b 1
)

if /i "%ACTION%"=="reboot" (
    set "SHUTDOWN_OPTION=/r"
) else if /i "%ACTION%"=="shutdown" (
    set "SHUTDOWN_OPTION=/s"
) else (
    echo Error: ACTION must be "shutdown" or "reboot".
    pause
    exit /b 1
)

echo Action: %ACTION%
echo Scheduled in %SECONDS% seconds.

shutdown.exe %SHUTDOWN_OPTION% /t %SECONDS% /f
endlocal
timeout 10

