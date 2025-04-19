# CHANGELOG - WINSTARTSTOP

- **2025/04/19 - v.0.2.1**  
  - Erste produktive Version auf Github veröffentlicht.  

- **2025/04/19 - v.0.1.1**  
  - **Überarbeitet:**  
    - `startup.bat`  
      - Warteschleife integriert (prüft bis zu 60 Sekunden auf Verfügbarkeit der Ramdisk)  
      - Logging hinzugefügt (`ramdisk_log.txt`) mit Zeitstempeln und Statusmeldungen pro Verzeichnis  
      - Kommentare und Struktur des Batchskripts verbessert  
      - Fehlerbehandlung ergänzt (Abbruch bei nicht erreichbarer Ramdisk)  

  - **Dokumentiert:**  
    - `README.md`  
      - sprachlich und strukturell überarbeitet  
      - Installation und Verhalten der Skripte klarer beschrieben  
      - Hinweis auf integrierte Ramdisk-Wartezeit ergänzt  

  - **Erstellt:**  
    - MS-DOS-inspiriertes Projektlogo als PNG (schwarz-blau, Cmd-Style, RAM-Icon, Power/Shutdown-Elemente)  
