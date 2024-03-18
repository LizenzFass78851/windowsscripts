@echo off

pushd "%CD%" && CD /D "%~dp0"

SET ZIPEXE=.\7z-bin\x86\7z.exe
if %PROCESSOR_ARCHITECTURE%==AMD64 SET ZIPEXE=.\7z-bin\x64\7z.exe
if %PROCESSOR_ARCHITECTURE%==ARM SET ZIPEXE=.\7z-bin\x86\7z.exe
if %PROCESSOR_ARCHITECTURE%==ARM64 SET ZIPEXE=.\7z-bin\arm64\7z.exe

REM ARCHTP: zip, 7z, xz, gz
SET ARCHTP=zip
REM MX: 0 - 9
SET MX=9

REM FINDTP: Filetype (exe, and more)
SET FINDTP=exe

(for %%a IN ("*.%FINDTP%") DO "%ZIPEXE%" u -t%ARCHTP% -mx=%MX% "%%a".%ARCHTP% "%%a" )

timeout 10
exit