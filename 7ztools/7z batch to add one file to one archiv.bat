@echo off

pushd "%CD%" && CD /D "%~dp0"

SET LINE===================================================

if "%PROCESSOR_ARCHITECTURE%"=="x86"   SET "ZIPEXE=.\7z-bin\x86\7z.exe"
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" SET "ZIPEXE=.\7z-bin\x64\7z.exe"
if "%PROCESSOR_ARCHITECTURE%"=="ARM"   SET "ZIPEXE=.\7z-bin\x86\7z.exe"
if "%PROCESSOR_ARCHITECTURE%"=="ARM64" SET "ZIPEXE=.\7z-bin\arm64\7z.exe"

if not exist "%ZIPEXE%" (
    if "%PROCESSOR_ARCHITECTURE%"=="x86"   SET "ZIPEXE=C:\Program Files (x86)\7-Zip\7z.exe"
    if "%PROCESSOR_ARCHITECTURE%"=="AMD64" SET "ZIPEXE=C:\Program Files\7-Zip\7z.exe"
    if "%PROCESSOR_ARCHITECTURE%"=="ARM"   SET "ZIPEXE=C:\Program Files (x86)\7-Zip\7z.exe"
    if "%PROCESSOR_ARCHITECTURE%"=="ARM64" SET "ZIPEXE=C:\Program Files\7-Zip\7z.exe"
)

if not exist "%ZIPEXE%" (
    echo "local or installed 7z are not found"
    SET errorlevel=1
    goto error
)

REM ARCHTP: zip, 7z, xz, gz
SET ARCHTP=zip
REM MX: 0 - 9
SET MX=9

REM FINDTP: Filetype (exe, and more)
SET FINDTP=exe

for %%a IN ("*.%FINDTP%") DO (
    echo %LINE%
    echo add "%%a".%ARCHTP%
    echo %LINE%
    "%ZIPEXE%" u -t%ARCHTP% -mx=%MX% "%%a".%ARCHTP% "%%a"

    if errorlevel 1 goto error

    echo %LINE%
    echo check "%%a".%ARCHTP%
    echo %LINE%
    "%ZIPEXE%" t "%%a".%ARCHTP%

    if errorlevel 1 goto error
)

:exits
timeout 10
exit /b %errorlevel%

:error
echo An error has occurred. Errorcode: %errorlevel%
pause
goto exits