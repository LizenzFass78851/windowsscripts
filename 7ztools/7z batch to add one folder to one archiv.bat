@echo off

pushd "%CD%" && CD /D "%~dp0"

SET ZIPEXE=.\7z-bin\x86\7z.exe
if %PROCESSOR_ARCHITECTURE%==AMD64 SET ZIPEXE=.\7z-bin\x64\7z.exe
if %PROCESSOR_ARCHITECTURE%==ARM SET ZIPEXE=.\7z-bin\x86\7z.exe
if %PROCESSOR_ARCHITECTURE%==ARM64 SET ZIPEXE=.\7z-bin\arm64\7z.exe
SET LINE===================================================

REM ARCHTP: zip, 7z
SET ARCHTP=zip
REM MX: 0 - 9
SET MX=9

for /F "tokens=*" %%A IN ('dir /b /ad ".\"') do (
    pushd "%%A"

    echo %LINE%
    echo add "%%A".%ARCHTP%
    echo %LINE%
    "%ZIPEXE%" u -t%ARCHTP% -mx=%MX% ..\"%%A".%ARCHTP% .\

    if errorlevel 1 goto error

    echo %LINE%
    echo check "%%A".%ARCHTP%
    echo %LINE%
    "%ZIPEXE%" t ..\"%%A".%ARCHTP%

    if errorlevel 1 goto error

    popd
)

:exits
timeout 10
exit /b %errorlevel%

:error
echo An error has occurred. Errorcode: %errorlevel%
pause
goto exits
