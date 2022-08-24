@echo off
 Title .NET Framework 3.5 Offline Installer
 for %%I in (D E F G H I J K L M N O P Q R S T U V W X Y Z) do if exist "%%I:\\sources\install.*" set setupdrv=%%I

echo Installing .NET Framework 3.5...

if NOT EXIST "%setupdrv%:\sources\sxs" goto :onlineinstall
goto :offlineinstaller


:onlineinstall
Dism /online /enable-feature /featurename:NetFX3 /All
goto :done


:offlineinstaller
Dism /online /enable-feature /featurename:NetFX3 /All /Source:%setupdrv%:\sources\sxs /LimitAccess
goto :done


:done
echo.
echo done
echo.

pause
exit