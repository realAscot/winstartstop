# Sammulung von Start- Shutdown Scripten

(C) 2025 Adam Skotarczak

## Skritpe

[PLATZHALTER]

### **[shutdown.bat](./scripts/shutdown.bat)**

Löscht diverse tempoäre Pfade unter windows. Sollte z.B beim Shutdown eingesetzt werden:

`gpedit.msc → Computerkonfiguration → Windows-Einstellungen → Skripts (Herunterfahren)`  

| Aufruf                      | Wirkung                                              |  
|-----------------------------|------------------------------------------------------|  
| `shutdown.bat`              | Führe Cleanup aus, keine Logs                        |  
| `shutdown.bat debug`        | Führe Cleanup aus + logge nach shutdownbat.log       |  
| `shutdown.bat test`         | Simuliere nur, keine Daten werden gelöscht           |  
| `shutdown.bat test debu1g`  | Simuliere + logge alles                              |  
