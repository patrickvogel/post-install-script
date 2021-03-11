@echo off
echo %~dp0
pause
goto check_Permissions

:check_Permissions
    echo Administrative permissions required. Detecting permissions...
    REM net session requires admin permission using it to check if we have Admin permissions
    net session >nul 2>&1
    if %errorLevel% == 0 (
        echo Success: Administrative permissions confirmed.
        goto run_script
    ) else (
        echo Failure: Current permissions inadequate.
        echo Please restart the script with administrator rights
        echo Bitte starten Sie das Skript mit Administrator rechten!
        goto end_of_script
    )
    pause >nul

:run_script
    REM nutzer eingabe: username pwd 
    call java-install.bat

    REM Download JKS File from Server
    REM With Powershell: powershell -Command "Invoke-WebRequest http://localhost:8080/webservertest/downloads/test_user-chain.jks -OutFile test_user-chain.jks"
    bitsadmin.exe /transfer "DownloadJKS" http://localhost:8080/webservertest/downloads/test_user-chain.jks %CD%\test_user_chain_bitsadmindownload.jks
    REM If there is an error while downloading job has to be cancelled manually 

    REM call find-and-replace.bat with string to search for and string to replace with
    call %~dp0find-and-replace.bat "#TODO_1" "ABC_USERNAME"
    call %~dp0find-and-replace.bat "#TODO_2" "XYZ_USERNAME"
    REM call maven-personal-acces.bat to setup maven settings and passwords
    call %~dp0maven-personal-access.bat
    pause
    echo end

:end_of_script
    pause