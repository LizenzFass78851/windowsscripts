@echo off
 
REN pushd "%CD%"
REM pushd "%tmp%"
REN CD /D "%~dp0"
 
 
REG DELETE "HKCU\Control Panel\Desktop" /v DpiScalingVer /f
 
REG DELETE "HKCU\Control Panel\Desktop" /v Win8DpiScaling /f
 
REG DELETE "HKCU\Control Panel\Desktop" /v LogPixels /f
 
exit