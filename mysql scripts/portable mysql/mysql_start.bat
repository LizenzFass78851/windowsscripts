@echo off
%~d0
cd %~dp0mariadb
echo MySQL is starting

set DIR=%~dp0mariadb
set DATA=%DIR%\data
set PATH=%DIR%\bin;%PATH%

if not exist %DATA% (
	echo Creating the database
	mysql_install_db
	echo ---------------------------
) 

start %~dp0mysql_cli.bat
bin\mysqld --standalone --console
rem pause