@echo off
setlocal enabledelayedexpansion

::
:: (C) Adam Skotarczak 2025
:: Erstellt Ramdisk-Verzeichnisse – Pfad als Parameter übergeben
::

:: --- Konfiguration: Verzeichnisliste ---
:: (Kommentare mit :: möglich, Leerzeilen erlaubt)
set "DIRS_FILE=%~dp0dirlist.txt"

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
    echo Datei dirlist.txt wurde erzeugt. Inhalt ggf. anpassen und erneut ausfuehren.
    goto :eof
)

:: --- Hilfe anzeigen, wenn kein Parameter übergeben wird ---
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

:: --- Zielpfad aus Parameter setzen ---
set "RAMDISK=%~1"
if not "%RAMDISK:~-1%"=="\" set "RAMDISK=%RAMDISK%\"

:: --- Verzeichnisse erstellen ---
for /f "usebackq tokens=*" %%D in ("%DIRS_FILE%") do (
    set "LINE=%%D"
    if not "!LINE!"=="" if "!LINE:~0,2!" NEQ "::" (
        if not exist "%RAMDISK%!LINE!" mkdir "%RAMDISK%!LINE!"
    )
)

echo Verzeichnisse in %RAMDISK% wurden erstellt.
endlocal
