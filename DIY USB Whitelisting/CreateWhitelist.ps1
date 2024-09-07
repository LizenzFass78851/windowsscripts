# PowerShell-Skript zur Erstellung einer Zulassungsliste der derzeit angeschlossenen USB-Geräte
# PowerShell script to create an allowlist of currently connected USB devices 

# Funktion zur Erstellung der Zulassungsliste
# Function for creating the approval list 
function CreateWhitelist {
    # Erstellen einer Liste der derzeit angeschlossenen USB-Geräte
    # Create a list of currently connected USB devices 
    $usbDevices = Get-PnpDevice -Class USB | Where-Object { $_.Status -eq "OK" }

    # Speichern der Geräte-IDs in einer Datei
    # Saving the device IDs to a file
    $usbDevices | ForEach-Object { $_.InstanceId } | Out-File ".\USBWhitelist.txt"
    Write-Host "Zulassungsliste erstellt und gespeichert."
    Write-Host "Approval list created and saved."
}

# Erstellung der Zulassungsliste
# Creation of the approval list
CreateWhitelist
