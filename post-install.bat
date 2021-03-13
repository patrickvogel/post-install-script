@echo off
goto check_Permissions

:check_Permissions
    echo Administrative permissions required. Detecting permissions...
    REM net session requires admin permission using it to check if we have Admin permissions
    REM send stdout(1) to null and send errout(2) to 1
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
    REM Download JKS File from Server
    call %~dp0download-jks.bat
    REM If there is an error while downloading job has to be cancelled manually 

    REM nutzer eingabe: username pwd 
    call %~dp0get-username-pwd.bat abc_username,abc_pwd,xyz_username,xyz_pwd
    echo installing java
    call %~dp0java-install.bat


    REM call find-and-replace.bat with string to search for and string to replace with
    echo Writing Artifactory Usernames into conf\devon.properties
    call %~dp0find-and-replace.bat "#TODO_1" %abc_username% %~dp0conf\devon.properties %~dp0conf\devon.properties.copy
    call %~dp0find-and-replace.bat "#TODO_2" %xyz_username% %~dp0conf\devon.properties %~dp0conf\devon.properties.copy
    echo Done with writing Artifactory Usernamens into conf\devon.properties

    REM call maven-personal-acces.bat to setup maven settings and passwords
    echo setting up maven-settings and passwords
    call %~dp0maven-personal-access.bat %abc_pwd% %xyz_pwd%

    REM call npmrc-settings.bat to setup the npm token
    echo setting up npm token
    call %~dp0npmrc-settings.bat %abc_username% %abc_pwd%

    echo Setting up eclipse.ini with userhome conf
    call %~dp0setup-eclipse-ini.bat
    echo setting up windows build tools
    call %~dp0windows-build-tools-installation.bat
    
    devon
    npm install -g windows-build-tools
    echo post-install ended

:end_of_script
    pause