## DIY USB Whitelisting
- Eine Anleitung zum Zulassen von bestimmten USB Geräten unter ausschluss, alle nicht in der Zulassungsliste stehenden USB Geräten.

Diese Anleitung ist nicht als Script umsetzbar da Windows dies kompliziert macht und daher gibt es das nur als Anleitung unter der Verwendung bestimmte Tools und teile von Scripten die es ein wenig vereinfacht. 
Damit kann man auf einen Lokalen Computer ohne AD-Infrastruktur dieses Whitelisting anwenden.

-----

### Benötigte Komponenten:
- [DeviceCleanup von Uwe Sieber](https://www.uwe-sieber.de/files/DeviceCleanup.zip)
- [CreateWhitelist.ps1](CreateWhitelist.ps1)
- Windows mindestens in der "Pro" Edition

### Durchführung:
1. Entpacke `DeviceCleanup.zip` und führe `DeviceCleanup.exe` aus den entweder `x64` Verzeichnis (für Windows in der x64 / 64 Bit Architektur) oder `Win32` (für Windows in der x86 / 32 Bit Architektur)

	1.1. Im Programm `DeviceCleanup` alle dort aufgelisteten USB Geräte mit den Tasten "STRG"-Taste + "A"-Taste markieren und mit der "ENTF"-Taste entfernen.

2. `CreateWhitelist.ps1` ausführen und die erstellte `USBWhitelist.txt` öffnen. Der Inhallt dieser Datei wird für später noch benötigt

3. Öffne unter der Suchleiste die `gpedit.msc` auf.

	3.1. Navigiere zu "Computerkonfiguration > Administrative Vorlagen > System > Geräteinstallation > Einschränkungen bei der Geräteinstallation"

	3.2. Aktiviere folgende GPO "Installation von Geräten mit diesen Geräte-IDs zulassen"

	3.2.1. Klicke auf "Anzeigen" und füge dort die aus der `USBWhitelist.txt` ausgelesene IDs Zeile für Zeile ein und klicke auf "OK" und dann nochmal auf "OK"

	3.3. Aktiviere folgende GPO "Installation von Geräten verhindern, die nicht in anderen Richtlinien beschrieben sind" und klicke auf "OK"


Damit sollte dieses USB Whitelisting funktionieren.
Erfolg nicht garantiert.
