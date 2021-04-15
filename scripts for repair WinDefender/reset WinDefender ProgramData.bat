@echo off & setlocal

pushd "%CD%"
CD /D "%~dp0" 

net stop WinDefend


set "SrcDir=%ALLUSERSPROFILE%\Microsoft\Windows Defender"
set "Exclude="Platform""

del /q "%SrcDir%\*.*" 2>NUL

set "DoNotDelete="

for /f "delims=" %%d in ('dir /b /a:d "%SrcDir%"') do (
  for %%e in (%Exclude%) do (
    if "%%d" equ "%%~e" set "DoNotDelete=1"
  )

  if not defined DoNotDelete rd /s /q "%SrcDir%\%%d"
  set "DoNotDelete="
)


net start WinDefend
echo Done / Fertig
timeout 5
exit