@echo off

pushd "%CD%" && CD /D "%~dp0"

TITLE Reset Custom Printsettings of CurrentUser

for /F "tokens=*" %%A IN ('REG QUERY HKCU\Printers\Connections') do ( REG DELETE %%A /v DevMode /f ) >NUL 2>NUL

exit
