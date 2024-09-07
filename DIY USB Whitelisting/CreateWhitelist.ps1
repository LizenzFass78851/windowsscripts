# PowerShell-Skript zur Erstellung einer Zulassungsliste der derzeit angeschlossenen USB-Geräte

# Funktion zur Erstellung der Zulassungsliste
function CreateWhitelist {
    # Erstellen einer Liste der derzeit angeschlossenen USB-Geräte
    $usbDevices = Get-PnpDevice -Class USB | Where-Object { $_.Status -eq "OK" }

    # Speichern der Geräte-IDs in einer Datei
    $usbDevices | ForEach-Object { $_.InstanceId } | Out-File ".\USBWhitelist.txt"
    Write-Host "Zulassungsliste erstellt und gespeichert."
}

# Erstellung der Zulassungsliste
CreateWhitelist
