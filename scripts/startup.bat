@echo off

::
:: Adam Skotarczak 2025
:: Skript legt Verzeichnisse beim Bootvorgang in der Ramdisk an
::

:: Tempverzeichnis in Ramdoisk erstellen
if not exist R:\Temp mkdir R:\Temp

:: Verzeichnisse für Chrome anlegen in Ramdisk
if not exist R:\ChromeProfile mkdir R:\ChromeProfile
if not exist R:\ChromeCache mkdir R:\ChromeCache

:: Arbeitsverzeichnis anlegen
if not exist R:\Arbeitsverzeichnis mkdir R:\Arbeitsverzeichnis

echo 1
:: END