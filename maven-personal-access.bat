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
setlocal EnableDelayedExpansion
for /f "tokens=*" %%a in ('mvn -ep %password%') do (
    set "_CmdResult=%%a"
    REM escpae first bracket 
    set "_firstBracket=!_CmdResult:{=^{!"
    REM escape second bracket
    set "_secondBracket=!_firstBracket:}=^}!"
)
call find-and-replace-allFiles.bat TODO_COPY_ABC_ARTIFACTORY_PASSWORD "!_secondBracket!" .\conf\.m2\settings.xml .\conf\.m2\settings.xml.copy

set /P "=_" < NUL > "Gib das XYZ_PWD an"
findstr /A:1E /V "^$" "Gib das XYZ_PWD an" NUL > CON
del "Gib das XYZ_PWD an"
set /P "password="
REM clear console
cls
color 07
REM TODO write into correct file, check when mvn is a known command
for /f "tokens=*" %%b in ('mvn -ep %password%') do (
    set "_xyzResult=%%b"
    REM escpae first bracket 
    set "_xyzFirstBracket=!_xyzResult:{=^{!"
    REM escape second bracket
    set "_xyzSecondBracket=!_xyzFirstBracket:}=^}!"
)
call find-and-replace-allFiles.bat TODO_COPY_XYZ_ARTIFACTORY_PASSWORD "!_xyzSecondBracket!" .\conf\.m2\settings.xml .\conf\.m2\settings.xml.copy
pause
echo endo of maven-personal-access.bat