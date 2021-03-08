REM call this bat with two parameters 1 word you want to search for 2 replacement
@echo off
set "search=%1"
set "replace=%2"
set search=%search:"=%
set replace=%replace:"=%
set "originalFile=%3"
set "newFile=%4"

REM GET Filename + Extension from Path
for %%A in ("%originalFile%") do (
	set name=%%~nxA
)
REM 
(for /f "delims=" %%i in (%originalFile%) do (
    set "line=%%i"
    setlocal enabledelayedexpansion
    set "line=!line:%search%=%replace%!"
    echo(!line!
    endlocal
))>%newFile%
del %originalFile%
rename %newFile% %name%
REM TODO: add test if replace is contained in file 
REM echo %search% has been successfully replaced with %replace% in %originalFile%
echo end of find and replace all Files.bat 

