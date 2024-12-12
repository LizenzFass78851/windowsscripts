@echo off
setlocal enabledelayedexpansion

REM destination address for the ping
set target=192.168.178.1

REM log file
set logfile=%target%-ping_log.txt

REM Waiting time in seconds
set waittime=1

REM End time (in format HH:MM), leave blank for infinite running
set endtime=

REM Current time
for /f "tokens=1-2 delims=:" %%a in ("%time%") do set currenttime=%%a:%%b

REM Set the beginning of the log file
echo --------------------------------------------------        
echo !date! !time! - Starte Ping_Logger für Target: %target%   
echo --------------------------------------------------        
echo --------------------------------------------------        >> %logfile%
echo !date! !time! - Starte Ping_Logger für Target: %target%   >> %logfile%
echo --------------------------------------------------        >> %logfile%

REM ping loop
:pingloop
for /f "tokens=1-2 delims=:" %%a in ("%time%") do set currenttime=%%a:%%b
if defined endtime if "!currenttime!" geq "%endtime%" goto end

REM Ping command and logging the result
for /f "tokens=4-5 delims= " %%a in ('ping -n 1 %target% ^| find "Zeit="') do (
    set pingtime=%%b
    echo !date! !time! - %target% ist erreichbar - !pingtime! 
    echo !date! !time! - %target% ist erreichbar - !pingtime! >> %logfile%
)

REM waiting time
timeout /t %waittime% >nul

goto pingloop

:end
echo Ping script terminated.
