@echo off
set /P abc_username=Bitte den Usernamen fuer ABC_Artifactory eingeben:
set "%~1=%abc_username%"

set /P "=_" < NUL > "Gib das ABC_PWD an"
findstr /A:1E /V "^$" "Gib das ABC_PWD an" NUL > CON
del "Gib das ABC_PWD an"
set /P "password="
REM clear console
cls
color 07
set "%~2=%password%"

set /P xyz_username=Bitte den Usernamen fuer XYZ_Artifactory eingeben:
set "%~3=%xyz_username%"

set /P "=_" < NUL > "Gib das XYZ_PWD an"
findstr /A:1E /V "^$" "Gib das XYZ_PWD an" NUL > CON
del "Gib das XYZ_PWD an"
set /P "password="
REM clear console
cls
color 07

set "%~4=%password%"
EXIT /B 0