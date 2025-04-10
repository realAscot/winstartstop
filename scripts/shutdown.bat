@echo off
setlocal EnableDelayedExpansion

:: === OPTIONALES LOGGING ===
set LOGFILE=
if /I "%1"=="debug" (
    set LOGFILE=./shutdownbat.log
    echo --- [Start Cleanup %DATE% %TIME%] --- > "%LOGFILE%"
)

:: === LOG-FUNKTION ===
:log
if defined LOGFILE (
    echo %* >> "%LOGFILE%"
)
exit /b

call :log *** Starte Cleanup ***

:: === SYSTEM TEMP ===
call :log Lösche C:\Windows\Temp
2>nul del /s /f /q "C:\Windows\Temp\*.*"
for /d %%p in ("C:\Windows\Temp\*") do 2>nul rmdir "%%p" /s /q

:: === USER TEMP ===
for /d %%u in ("C:\Users\*") do (
    if exist "%%u\AppData\Local\Temp" (
        call :log Lösche Temp für %%u
        2>nul del /s /f /q "%%u\AppData\Local\Temp\*.*"
        for /d %%p in ("%%u\AppData\Local\Temp\*") do 2>nul rmdir "%%p" /s /q
    )
)

:: === PREFETCH ===
call :log Lösche Prefetch
2>nul del /s /f /q "C:\Windows\Prefetch\*.*"

:: === MEMORY DUMPS ===
call :log Lösche Speicherabbilder
2>nul del /f /q "C:\Windows\MEMORY.DMP"
2>nul del /s /f /q "C:\Windows\Minidump\*.*"
2>nul del /s /f /q "C:\ProgramData\Microsoft\Windows\WER\*.*"
for /d %%p in ("C:\ProgramData\Microsoft\Windows\WER\*") do 2>nul rmdir "%%p" /s /q

:: === RECYCLE BIN ===
call :log Leere Papierkorb
2>nul rd /s /q C:\$Recycle.Bin

:: === CMD-HISTORY (Konsole) ===
call :log Lösche CMD-Historie
2>nul reg delete "HKCU\Console" /f

:: === POWERSHELL-HISTORY ===
call :log Lösche PowerShell-Historie
for /d %%u in ("C:\Users\*") do (
    set PSHIST=%%u\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt
    if exist !PSHIST! (
        2>nul del /f /q "!PSHIST!"
    )
)

call :log *** Cleanup abgeschlossen ***
exit /b 0
