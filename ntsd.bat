@echo off&color 17&mode con cols=20 lines=8
cd /d C:\&dir|findstr Pro.*x86&&cd /d %~dp0&&cd x64&&title NTSD x64&&goto :cdc
title NTSD x86&cd /d %~dp0&cd x86
:cdc
:l1
cls
echo processes match in
echo name or pid
echo will all be killed
set /p p=input keywords :
if %p%==exit exit 0
tskill ntsd
tasklist /fo table /nh|findstr %p%|findstr /v /b /c:"taskkill"|findstr /v /b /c:"tskill"|findstr /v /b /c:"cmd"|findstr /v /b /c:"ntsd"|findstr /v /b /c:"tasklist"|findstr /v /b /c:"findstr">temp
for /f "tokens=2 delims= " %%i in (temp) do start /b /i ntsd -c q -p %%i
echo ^@echo off>temp2.cmd
echo echo Finished>>temp2.cmd
echo echo.>>temp2.cmd
for /f "tokens=1 delims= " %%i in (temp) do echo echo %%i killed>>temp2.cmd
echo choice /t 3 /d y /n^>nul>>temp2.cmd
echo taskkill /f /im ntsd.exe>>temp2.cmd
echo exit>>temp2.cmd
start temp2.cmd
goto :l1
