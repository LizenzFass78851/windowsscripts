@echo off
 
REN pushd "%CD%"
REM pushd "%tmp%"
REN CD /D "%~dp0"
 
SET MESSAGE="If this is the first time you have logged in to this PC, please log out and log back in briefly to adjust the screen settings."
 
REM Reset the DpiScaling
REG DELETE "HKCU\Control Panel\Desktop" /v DpiScalingVer /f
 
REM Enable allowing custom DPIs
REG ADD "HKCU\Control Panel\Desktop" /v Win8DpiScaling /t REG_DWORD /d 0x00000001 /f
 
REM Set the DPI
REM	DPI	-	scaling factor
REM	96	-	100
REM	120	-	125
REM	144	-	150
REM	192	-	200
REG ADD "HKCU\Control Panel\Desktop" /v LogPixels /t REG_DWORD /d 0x00000192 /f
 
MSG %username% %MESSAGE%
exit