@echo off
echo Make sure you have the jdk.exe in the same folder as the post-install-script
pause
set javafolder= %CD%\software\java
set version= 8u271b09-oracle 

REM Cleanup java folder and install jdk into it
echo javafolder: %javafolder%
if exist %javafolder% (
    echo removing existing java files
    rmdir /s /q %javafolder%
    mkdir %javafolder%
) else (
    mkdir %javafolder%
)
jdk-8u281-windows-x64.exe /s /INSTALLDIRPUBJRE=%javafolder%

REM Create file .devon.software.version and write version into it
if not exist %javafolder%\.devon.software.version (
	echo%version%>%javafolder%\.devon.software.version
)

REM ADD JAVA_VERSION to devon.properties, maybe interrupt here if devon.properties does not exist
if exist %CD%\conf\devon.properties (
    REM When Text not found write into file
    find /c "JAVA_VERSION=8u271b09-oracle" %CD%\conf\devon.properties  || ( echo.>>%CD%\conf\devon.properties
    echo JAVA_VERSION=8u271b09-oracle>>%CD%\conf\devon.properties ) 
)

REM Für Später wenn man evtl. eine existierende java installation kopieren will, wenn z.B die Installation nicht laeuft weil
REM schon ein JDK installiert ist
REM dir /b /a "%javafolder%\*" | >nul findstr "^" && (echo Files and/or Folders exist) || (echo No Files and/or Folders exist)

REM Download JKS File from Server
REM With Powershell: powershell -Command "Invoke-WebRequest http://localhost:8080/webservertest/downloads/test_user-chain.jks -OutFile test_user-chain.jks"
bitsadmin.exe /transfer "DownloadJKS" http://localhost:8080/webservertest/downloads/test_user-chain.jks %CD%\test_user_chain_bitsadmindownload.jks
REM If there is an error while downloading job has to be cancelled manually 
echo test test test
pause

REM call find-and-replace.bat with string to search for and string to replace with
call find-and-replace.bat "#TODO_1" "ABC_USERNAME"
call find-and-replace.bat "#TODO_2" "XYZ_USERNAME"
pause
echo end