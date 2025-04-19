# Sammlung von Start- und Shutdown-Skripten

![Projektlogo](./assets/logo-alpha_250x250.png)

> (C) 2025 Adam Skotarczak <adam@skotarczak.net>  
> [Lizenz anzeigen](./LIZENSE)  

Diese Sammlung ist auf GitHUB unter der Adresse [https://github.com/realAscot/winstartstop.git](https://github.com/realAscot/winstartstop.git) zu finden.  

## Inhalt:

- [Sammlung von Start- und Shutdown-Skripten](#sammlung-von-start--und-shutdown-skripten)
  - [Inhalt:](#inhalt)
  - [Übersicht](#übersicht)
  - [Skripte](#skripte)
    - [`startup.bat`](#startupbat)
      - [Beispiel:](#beispiel)
      - [Funktionsweise:](#funktionsweise)
      - [Installation:](#installation)
  - [Hinweise](#hinweise)
    - [`shutdown.bat`](#shutdownbat)
      - [Installation:](#installation-1)
      - [Parameter:](#parameter)

## Übersicht

Dieses Repository enthält Windows-Batchskripte zur Initialisierung und Aufräumroutine bei Systemstart und -shutdown.  
Ziel ist es, temporäre Ressourcen effizient zu verwalten (z. B. Ramdisk, Temp-Ordner etc.).  

## Skripte

### [`startup.bat`](./scripts/startup.bat)

Erstellt beim Systemstart vordefinierte Verzeichnisse auf einem beliebigen Zielpfad (z. B. Ramdisk).  

#### Beispiel:

```cmd

startup.bat R:\  
```

#### Funktionsweise:

- Beim ersten Start wird automatisch die Datei `dirlist.txt` im selben Verzeichnis erzeugt.  
- In `dirlist.txt` werden die Verzeichnisse aufgelistet, die erstellt werden sollen.  
- Die angegebene Ramdisk muss zum Zeitpunkt des Skriptaufrufs vorhanden sein.  
- Es wird eine Logdatei `ramdisk_log.txt` angelegt, die alle Aktionen protokolliert.  

#### Installation:

> ⚠️ **Hinweis vorweg:**  
  Microsoft liefert den Gruppenrichtlinien-Editor nur in den Pro, Enterprise und Education-Versionen von Windows aus – nicht in der Home-Edition.  Man kann das ganze alternativ aber auch über die Aufgabenplanung `taskschd.msc` steuern oder notfalls sogar über die gute alte `autostart.bat`

```text

gpedit.msc → Computerkonfiguration → Windows-Einstellungen → Skripts (Starten)  
```

Die Skripte aus dem Paket hier an beliebige Stelle kopieren und dort einpflegen.

---

## Hinweise

- Die integrierte Warteschleife in `startup.bat` prüft bis zu 30 Sekunden lang, ob das angegebene Laufwerk (z. B. Ramdisk) verfügbar ist.  
- Für erweiterte Steuerung kann zusätzlich der Windows-Taskplaner verwendet werden (z. B. zum verzögerten Start).  
- Die Logdateien wachsen mit – regelmäßige Wartung empfohlen.  

---

### [`shutdown.bat`](./scripts/shutdown.bat)

Bereinigt temporäre Pfade unter Windows. Ideal für den Einsatz beim Herunterfahren des Systems.  

#### Installation:

```text
gpedit.msc → Computerkonfiguration → Windows-Einstellungen → Skripts (Herunterfahren)  
```

![Screenshot gpedit.msc](./assets/gpedit.png)  

#### Parameter:

| Aufruf                    | Wirkung                                          |  
|---------------------------|--------------------------------------------------|  
| `shutdown.bat`            | Führt Cleanup aus, ohne Logging                  |  
| `shutdown.bat debug`      | Cleanup + Logausgabe in `shutdownbat.log`        |  
| `shutdown.bat test`       | Simulation (kein Löschen)                        |  
| `shutdown.bat test debug` | Simulation + Logging                             |  

---
