@echo off
color 0c

for %%I in (D E F G H I J K L M N O P Q R S T U V W X Y Z) do if exist "%%I:\\VIDEO_TS" set setupdrv="%%I:/" && goto :done
goto :fail

:fail
echo No DVD detected
echo Please try again
timeout 5
exit

:error
echo Error occurred while executing the script
echo Please check the script
timeout 10
exit

:done
cd "C:\Program Files\VideoLAN\VLC\" || goto :error
start vlc.exe dvd:///%setupdrv%
exit
