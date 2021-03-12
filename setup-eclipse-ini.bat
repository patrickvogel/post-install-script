@echo off
setlocal enabledelayedexpansion
REM if string already in file skip 
find /c "-Duser.home=conf" %~dp0software\eclipse\eclipse.ini >nul || ( goto run )
echo eclipse.ini is already set up
exit 

:run
echo adding -Duser.home=conf to eclipse.ini
ren %~dp0software\eclipse\eclipse.ini eclipse.ini.tmp
pause
set p=
for /f %%a in (%~dp0software\eclipse\eclipse.ini.tmp) do (
  if "!p!"=="-vmargs" echo -Duser.home=conf >> %~dp0software\eclipse\eclipse.ini
  echo %%a >>%~dp0software\eclipse\eclipse.ini
  set p=%%a
)
pause
del %~dp0software\eclipse\eclipse.ini.tmp