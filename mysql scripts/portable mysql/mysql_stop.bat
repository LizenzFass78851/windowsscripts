@echo off
%~d0
cd %~dp0mariadb
echo Mysql shutdowm ...
%~dp0mariadb\bin\mysqladmin.exe -u root shutdown