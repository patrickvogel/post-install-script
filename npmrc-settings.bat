@echo off
set npmrc=.\conf\npm\.npmrc
REM remove comments for registry and python
call find-and-replace-allFiles.bat #registry registry %npmrc% .\conf\npm\.npmrc.copy
call find-and-replace-allFiles.bat #python python %npmrc% .\conf\npm\.npmrc.copy
REM should directly write return into npmrc file NEEDS to be SET up
curl -u <username>:<password> http://example.org/artifactory/api/npm/auth>>%npmrc%
type NPMToken.txt >> %npmrc%
pause