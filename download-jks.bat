@echo off
REM With Powershell: powershell -Command "Invoke-WebRequest http://localhost:8080/webservertest/downloads/test_user-chain.jks -OutFile test_user-chain.jks"
bitsadmin.exe /transfer "DownloadJKS" http://localhost:8080/webservertest/downloads/test_user-chain.jks %~dp0test_user_chain_bitsadmindownload.jks
dir /a-d *.jks >nul 2>&1 &&(
    :: file does not exist - do something
    echo No .jks File in folder
) || (
    :: file does exist - do something
    echo jks File successfully downloaded
)
pause