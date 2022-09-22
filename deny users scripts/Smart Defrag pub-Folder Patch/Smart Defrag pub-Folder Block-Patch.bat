@echo off

rem Abfrage.
echo Bereit?
pause

rem Teilverzeichnis falls unterscheid zu den Pfad in x86 und x64 Bassierten Systemen etc.
set SW-Dir=C:\Program Files
if %PROCESSOR_ARCHITECTURE%==AMD64 set SW-Dir=C:\Program Files (x86)
if %PROCESSOR_ARCHITECTURE%==ARM set SW-Dir=C:\Program Files (x86)
if %PROCESSOR_ARCHITECTURE%==ARM64 set SW-Dir=C:\Program Files (x86)

rem Komplettes oder Rest des Verzeichnises
set Dir1=IObit\Smart Defrag\pub
set Dir2=IObit\Smart Defrag\AUpdate.exe
set Dir3=IObit\Smart Defrag\AutoUpdate.exe
set Dir4=IObit\Smart Defrag\iupdater.exe
set Dir5=IObit\Smart Defrag\isrupdater.exe


rem Dieser Abschnitt stellt die Liste mit den zu verweigerten Benutzer da.
CD %TEMP%
FOR /F "tokens=3 delims= " %%G in ('reg query "hklm\system\controlset001\control\nls\language" /v InstallLanguage') DO (
IF [%%G] EQU [0407] (
  set "lang=de"
) ELSE (
  set "lang=en"
)
)
if %lang%==en goto :deny-users-eng
:deny-users-ger
@echo Benutzer > deny-user-lists.txt
@echo Administratoren >> deny-user-lists.txt
@echo SYSTEM >> deny-user-lists.txt
goto :run-task
:deny-users-eng
@echo Users > deny-user-lists.txt
@echo Administrators >> deny-user-lists.txt
@echo SYSTEM >> deny-user-lists.txt
goto :run-task

:run-task
rem Anwendung.
for /f %%i in ('findstr /i . deny-user-lists.txt 2^>nul') do icacls.exe "%SW-Dir%\%Dir1%" /deny "%%i":(X) /L 
for /f %%i in ('findstr /i . deny-user-lists.txt 2^>nul') do icacls.exe "%SW-Dir%\%Dir2%" /deny "%%i":(X) /L 
for /f %%i in ('findstr /i . deny-user-lists.txt 2^>nul') do icacls.exe "%SW-Dir%\%Dir3%" /deny "%%i":(X) /L 
for /f %%i in ('findstr /i . deny-user-lists.txt 2^>nul') do icacls.exe "%SW-Dir%\%Dir4%" /deny "%%i":(X) /L 
for /f %%i in ('findstr /i . deny-user-lists.txt 2^>nul') do icacls.exe "%SW-Dir%\%Dir5%" /deny "%%i":(X) /L 

rem Ende.
del deny-user-lists.txt
timeout 5
exit
