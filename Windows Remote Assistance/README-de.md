## Windows-Remoteunterstützung
- Eine Möglichkeit für Windows, das als Terminalserver **oder** auf einem anderen Computer im internen Netzwerk mit mehreren Benutzern verwendet wird, anderen Benutzern als Administrator zu helfen.

Führe den folgenden Befehl als Administrator aus, sodass sich das entsprechende Fenster öffnet. Legen Sie die IP-Adresse oder den Hostnamen für den Zielcomputer fest und wählen den Benutzer aus, dem Sie helfen möchten.

````
%SYSTEMROOT%\SYSTEM32\msra.exe /offerra
````

-----

### GPO Konfigurieren

Stelle folgendes ein unter:

- `Computerkonfiguration -> Administrative Vorlagen -> System -> Remoteunterstützung`

  - "Angeforderte Remoteunterstützung" konfigurieren
    1. **Auf `Aktiviert` stellen**
    2. **Remoteüberwachung dieses Computers zulassen:** Helfer dürfen den Computer remote steuern
    3. **Maximale Gültigkeitsdauer der Einladung (Wert):** 1
    4. **Maximale Gültigkeitsdauer der Einladung (Einheit):** Stunden
    5. **Methode zum Senden von E-Mail-Einladungen:** Senden an 

  - "Remoteunterstützung anbieten" konfigurieren
    1. **Auf `Aktiviert` stellen**
    2. **Remoteüberwachung dieses Computers zulassen:** Helfer dürfen den Computer remote steuern
    3. **Helfer:** <Da die Benutzerkonten oder Gruppen eintragen. z.B. COMPUTERNAME\USER>


- `Computerkonfiguration -> Windows-Einstellungen -> Sicherheitseinstellungen -> Windows Defender Firewall mit erweiterter Sicherheit -> Eingehende Regeln`
  
  - Neue Regel...
    1. Eine neue Firewall Regel erstellen um damit für folgendes Programm `%SystemRoot%\system32\raserver.exe` die Verbindungen zuzulassen.
    2. Eine neue Firewall Regel erstellen um damit für folgendes Programm `%SystemRoot%\system32\msra.exe` die Verbindungen zuzulassen.
