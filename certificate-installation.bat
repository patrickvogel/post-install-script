@echo off
SETLOCAL
"%JAVA_HOME%\bin\keytool.exe" -importkeystore -srckeystore AbcCA-chain.jks -destkeystore "%JAVA_HOME%\jre\lib\security\cacerts" -srcalias abcca -destalias abcca -srcstorepass passwort123 -deststorepass passwort123
pause