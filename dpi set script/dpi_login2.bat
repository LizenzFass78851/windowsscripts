@echo off

REN pushd "%CD%"
pushd "%tmp%"
REN CD /D "%~dp0"

echo     DpiScalingVer    REG_DWORD    0x1018>DpiScalingVer.comparison.txt
echo     LogPixels    REG_DWORD    0x192>LogPixels.comparison.txt
echo     Win8DpiScaling    REG_DWORD    0x1>Win8DpiScaling.comparison.txt

reg query "HKCU\Control Panel\Desktop" /v DpiScalingVer | find "REG">DpiScalingVer.query.txt
reg query "HKCU\Control Panel\Desktop" /v Win8DpiScaling | find "REG">Win8DpiScaling.query.txt
reg query "HKCU\Control Panel\Desktop" /v LogPixels | find "REG">LogPixels.query.txt

copy *.comparison.txt _setdpi.comparison.txt
copy *.query.txt _setdpi.query.txt

fc _setdpi.comparison.txt _setdpi.query.txt | find "FC">txtfc.txt
for /F "tokens=1*" %%A IN ( 'type txtfc.txt' ) do ( echo %%A>%%A.txt )

goto :clean


:clean
del .txt
del txtfc.txt
del *.comparison.txt
del *.query.txt

if not exist FC goto :run
goto :exits


:run
REG ADD "HKCU\Control Panel\Desktop" /v DpiScalingVer /t REG_DWORD /d 0x00001018 /f
REG ADD "HKCU\Control Panel\Desktop" /v Win8DpiScaling /t REG_DWORD /d 0x00000001 /f
REG ADD "HKCU\Control Panel\Desktop" /v LogPixels /t REG_DWORD /d 0x00000192 /f

shutdown /l

goto :exits


:exits
del FC
exit