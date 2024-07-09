@echo off

pushd "%CD%" && CD /D "%~dp0"

TITLE Inplace (Workaround)


if exist .\sources\setupprep.exe goto :RUN1
goto :ERROR

:ERROR
 for %%I in (D E F G H I J K L M N O P Q R S T U V W X Y Z) do if exist "%%I:\\sources\install.*" set setupdrv=%%I
if exist %setupdrv%:\sources\setupprep.exe goto :RUN2

echo Script could not find Windows Setup.
goto :EXITS

:RUN1
echo Inplace upgrade is starting - please wait ...
call .\sources\setupprep.exe /product server
goto :EXITS

:RUN2
echo Inplace Upgrade is starting from drive %setupdrv%: - please wait ...
call %setupdrv%:\sources\setupprep.exe /product server
goto :EXITS

:EXITS
timeout 5
goto :EOF

:EOF
exit
