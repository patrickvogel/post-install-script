@echo off
SETLOCAL
echo Make sure you have the jdk.exe in the same folder as the post-install-script
pause
set javafolder= %~dp0software\java
set version= 8u271b09-oracle 

REM Cleanup java folder and install jdk into it
echo clearing current %javafolder% from existing files
if exist %javafolder% (
    echo removing existing java files
    rmdir /s /q %javafolder%
    mkdir %javafolder%
) else (
    mkdir %javafolder%
)
echo starting JDK install
%~dp0jdk-8u281-windows-x64.exe /s /INSTALLDIRPUBJRE=%javafolder%

REM Create file .devon.software.version and write version into it
echo creating .devon.software.verison file and writing Java version into it
if not exist %javafolder%\.devon.software.version (
	echo%version%>%javafolder%\.devon.software.version
)

REM ADD JAVA_VERSION to devon.properties, maybe interrupt here if devon.properties does not exist
echo adding java_version to devon.properties
if exist %~dp0conf\devon.properties (
    REM When Text not found write into file
    find /c "JAVA_VERSION=8u271b09-oracle" %~dp0conf\devon.properties  || ( echo.>>%~dp0conf\devon.properties
    echo JAVA_VERSION=8u271b09-oracle>>%~dp0conf\devon.properties ) 
)

REM Für Später wenn man evtl. eine existierende java installation kopieren will, wenn z.B die Installation nicht laeuft weil
REM schon ein JDK installiert ist
REM dir /b /a "%javafolder%\*" | >nul findstr "^" && (echo Files and/or Folders exist) || (echo No Files and/or Folders exist)