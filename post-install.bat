@echo off
call java-install.bat

REM Download JKS File from Server
REM With Powershell: powershell -Command "Invoke-WebRequest http://localhost:8080/webservertest/downloads/test_user-chain.jks -OutFile test_user-chain.jks"
bitsadmin.exe /transfer "DownloadJKS" http://localhost:8080/webservertest/downloads/test_user-chain.jks %CD%\test_user_chain_bitsadmindownload.jks
REM If there is an error while downloading job has to be cancelled manually 

REM call find-and-replace.bat with string to search for and string to replace with
call find-and-replace.bat "#TODO_1" "ABC_USERNAME"
call find-and-replace.bat "#TODO_2" "XYZ_USERNAME"
REM call maven-personal-acces.bat to setup maven settings and passwords
call maven-personal-access.bat
pause
echo end