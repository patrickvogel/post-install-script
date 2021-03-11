@echo off
set npmrc=%~dp0\conf\npm\.npmrc
REM remove comments for registry and python
call %~dp0find-and-replace-allFiles.bat #registry registry %npmrc% %~dp0\conf\npm\.npmrc.copy
call %~dp0find-and-replace-allFiles.bat #python python %npmrc% %~dp0\conf\npm\.npmrc.copy
REM should directly write return into npmrc file NEEDS to be SET up
REM Same login data as ABC
curl -u <username>:<password> http://example.org/artifactory/api/npm/auth>>%npmrc%
type NPMToken.txt >> %npmrc%
pause