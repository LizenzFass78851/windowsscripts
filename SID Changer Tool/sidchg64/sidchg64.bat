@echo off

pushd "%CD%" && CD /D "%~dp0"

REM Key valid from 15th to 30th November 2025
SET KEY="77JAY-X@Vvv-2OiL#-LJ"

(for %%a IN (sidchg64*.exe) DO echo %%a && %%a /KEY=%KEY% /RMK )

pause
exit