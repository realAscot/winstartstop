@echo off
setlocal enabledelayedexpansion

::
:: (C) Adam Skotarczak 2025
:: Erstellt Ramdisk-Verzeichnisse – Pfad als Parameter übergeben
:: Mit Warte-Logik und Logging
::

:: --- Konfiguration ---
set "DIRS_FILE=%~dp0dirlist.txt"
set "LOGFILE=%~dp0ramdisk_log.txt"

:: --- Hilfsfunktion: Zeitstempel ---
for /f %%T in ('powershell -nologo -command "Get-Date -Format yyyy-MM-dd_HH:mm:ss"') do set "TIMESTAMP=%%T"

:: --- Logging-Funktion ---
set "LOGENTRY=[%TIMESTAMP%]"

:: Wenn dirlist.txt nicht existiert, erzeugen
if not exist "%DIRS_FILE%" (
    >"%DIRS_FILE%" (
        echo :: Verzeichnisse, die in der Ramdisk erstellt werden sollen
        echo Temp
        echo ChromeProfile
        echo ChromeCache
        echo Downloads
        echo Arbeitsverzeichnis
    )
    echo %LOGENTRY% Datei dirlist.txt wurde erzeugt. Inhalt ggf. anpassen und erneut ausfuehren.>>"%LOGFILE%"
    echo Datei dirlist.txt wurde erzeugt. Inhalt ggf. anpassen und erneut ausfuehren.
    goto :eof
)

:: --- Hilfe anzeigen ---
if "%~1"=="" (
    echo.
    echo Syntax: %~nx0 [Laufwerkspfad]
    echo Beispiel: %~nx0 R:\
    echo Erstellt folgende Verzeichnisse in der Ramdisk:
    for /f "usebackq tokens=*" %%D in ("%DIRS_FILE%") do (
        set "LINE=%%D"
        if not "!LINE!"=="" if "!LINE:~0,2!" NEQ "::" echo   - !LINE!
    )
    goto :eof
)

:: --- Zielpfad setzen ---
set "RAMDISK=%~1"
if not "%RAMDISK:~-1%"=="\" set "RAMDISK=%RAMDISK%\"

:: --- Auf Ramdisk warten (max. 30 Sekunden) ---
set "WAIT=0"
:waitloop
if exist "%RAMDISK%." goto :continue
timeout /t 1 >nul
set /a WAIT+=1
if %WAIT% GEQ 60 (
    echo %LOGENTRY% [FEHLER] Ramdisk %RAMDISK% nicht gefunden – Abbruch.>>"%LOGFILE%"
    echo [FEHLER] Ramdisk %RAMDISK% nicht gefunden – Abbruch.
    goto :eof
)
goto waitloop
:continue

echo %LOGENTRY% Ramdisk %RAMDISK% wurde gefunden.>>"%LOGFILE%"

:: --- Verzeichnisse erstellen ---
for /f "usebackq tokens=*" %%D in ("%DIRS_FILE%") do (
    set "LINE=%%D"
    if not "!LINE!"=="" if "!LINE:~0,2!" NEQ "::" (
        set "TARGET=%RAMDISK%!LINE!"
        if not exist "!TARGET!" (
            mkdir "!TARGET!"
            echo %LOGENTRY% Erstellt: !TARGET!>>"%LOGFILE%"
        ) else (
            echo %LOGENTRY% Bereits vorhanden: !TARGET!>>"%LOGFILE%"
        )
    )
)

echo Verzeichnisse in %RAMDISK% wurden erstellt.
echo %LOGENTRY% Verzeichniserstellung abgeschlossen.>>"%LOGFILE%"
endlocal
