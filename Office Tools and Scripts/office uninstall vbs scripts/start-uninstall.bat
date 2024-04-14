@echo off

pushd "%CD%" && CD /D "%~dp0"

TITLE Office Uninstaller AIO (MSI-Versions)

:uninstall-office-2003-2010
(for %%a IN (UninstallOffice20*0*.vbs) DO echo %%a && cscript "%%a" All /DELETEUSERSETTINGS /FORCE /NOCANCEL /OSE )

:uninstall-office-2013-2016
(for %%a IN (UninstallOffice201*MSI.vbs) DO echo %%a && cscript "%%a" All /DELETEUSERSETTINGS /FORCE /NOCANCEL /NOREBOOT /OSE /REMOVELYNC /REMOVEOSPP )

