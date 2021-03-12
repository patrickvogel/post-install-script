@echo off
SETLOCAL
set "username=%1"
set "pwd=%2"
set npmrc=%~dp0\conf\npm\.npmrc
REM remove comments for registry and python
call %~dp0find-and-replace.bat #registry registry %npmrc% %~dp0\conf\npm\.npmrc.copy
call %~dp0find-and-replace.bat #python python %npmrc% %~dp0\conf\npm\.npmrc.copy
REM should directly write return into npmrc file NEEDS to be SET up
REM Same login data as ABC
:: curl -u %username%:%pwd% http://example.org/artifactory/api/npm/auth>>%npmrc%
type %~dp0NPMToken.txt >> %npmrc%