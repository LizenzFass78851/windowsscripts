@echo off
 for %%I in (D E F G H I J K L M N O P Q R S T U V W X Y Z) do if exist "%%I:\\VIDEO_TS" set setupdrv=%%I
 "C:\Program Files\VideoLAN\VLC\vlc.exe" dvd:///%setupdrv%:/