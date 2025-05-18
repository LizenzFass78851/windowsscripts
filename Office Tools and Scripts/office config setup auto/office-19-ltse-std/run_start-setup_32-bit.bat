@echo off
pushd "%CD%" && CD /D "%~dp0"
..\setup-custom.exe /configure configuration32.xml