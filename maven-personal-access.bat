@echo off
set "abc_pwd=%1"
set "xyz_pwd=%2"
setlocal EnableDelayedExpansion
echo %abc_pwd%
echo %xyz_pwd%
REM encrypted pw is always in this format {asbdlabsd=} 
for /f "tokens=*" %%a in ('mvn -ep %abc_pwd%') do (
    set "_CmdResult=%%a"
    REM escpae first bracket 
    set "_firstBracket=!_CmdResult:{=^{!"
    REM escape second bracket
    set "_secondBracket=!_firstBracket:}=^}!"
)
call %~dp0find-and-replace.bat TODO_COPY_ABC_ARTIFACTORY_PASSWORD "!_secondBracket!" %~dp0\conf\.m2\settings.xml %~dp0\conf\.m2\settings.xml.copy


for /f "tokens=*" %%b in ('mvn -ep %xyz_pwd%') do (
    set "_xyzResult=%%b"
    REM escpae first bracket 
    set "_xyzFirstBracket=!_xyzResult:{=^{!"
    REM escape second bracket
    set "_xyzSecondBracket=!_xyzFirstBracket:}=^}!"
)
call %~dp0find-and-replace.bat TODO_COPY_XYZ_ARTIFACTORY_PASSWORD "!_xyzSecondBracket!" %~dp0\conf\.m2\settings.xml %~dp0\conf\.m2\settings.xml.copy
echo end of maven-personal-access.bat