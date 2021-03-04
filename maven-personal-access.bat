@echo off
echo write encrypted pws into \conf\.m2\settings.xml 
REM if this bat is called from the cmd the password will be shown in the commandlist
REM can be reset but not the best
setlocal
set /P "=_" < NUL > "Gib das ABC_PWD an"
findstr /A:1E /V "^$" "Gib das ABC_PWD an" NUL > CON
del "Gib das ABC_PWD an"
set /P "password="
REM clear console
cls
color 07
call mvn -ep %password%>pwd.txt

set /P "=_" < NUL > "Gib das XYZ_PWD an"
findstr /A:1E /V "^$" "Gib das XYZ_PWD an" NUL > CON
del "Gib das XYZ_PWD an"
set /P "password="
REM clear console
cls
color 07
REM TODO write into correct file, check when mvn is a known command
call mvn -ep %password%>pwd.txt
pause
echo %password%