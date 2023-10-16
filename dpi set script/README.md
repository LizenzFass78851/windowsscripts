## dpi set script
- this script sets the [dpi settings](https://www.deskmodder.de/wiki/index.php/Bildschirmanzeige_DPI_Einstellung_Windows_10#DPI-Einstellung_in_der_Registry_.C3.A4ndern_Windows_10) to 200% with one click and can ideally be set in a autostart folder for all users.
````
%programdata%\Microsoft\Windows\Start Menu\Programs\StartUp
````

# Warning!!: 
### Please only run this script if you intend to set the dpi higher than 100% in a shared environment because this script overrides the windows defaults and so it cannot be easily undone unless you do the following off to undo it:
````
REG ADD "HKCU\Control Panel\Desktop" /v Win8DpiScaling /t REG_DWORD /d 0x00000000 /f
````