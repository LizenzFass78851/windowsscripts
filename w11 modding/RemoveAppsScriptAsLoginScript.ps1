$appsToRemove = @(
    "Clipchamp.Clipchamp",
    "Microsoft.BingNews",
    "Microsoft.BingWeather",
    "Microsoft.Copilot",
    "Microsoft.GamingApp",
    "Microsoft.MicrosoftOfficeHub",
    "Microsoft.MicrosoftSolitaireCollection",
    "Microsoft.MicrosoftStickyNotes",
    "Microsoft.OutlookForWindows",
    "Microsoft.Paint",
    "Microsoft.ScreenSketch",
    "Microsoft.Todos",
    "Microsoft.Windows.Photos",
    "Microsoft.WindowsCalculator",
    "Microsoft.WindowsCamera",
    "Microsoft.WindowsFeedbackHub",
    "Microsoft.WindowsNotepad",
    "Microsoft.WindowsSoundRecorder",
    "Microsoft.WindowsTerminal",
    "Microsoft.Xbox.TCUI",
    "Microsoft.XboxIdentityProvider",
    "Microsoft.XboxSpeechToTextOverlay",
    "Microsoft.ZuneMusic",
    "MicrosoftCorporationII.QuickAssist",
    "MSTeams"
)

Write-Host "Starting removimg of selected apps..." -ForegroundColor Cyan

foreach ($app in $appsToRemove) {
    Write-Host "`nTry to remove: $app ..." -ForegroundColor Yellow

    Get-AppxPackage -Name $app |
        Remove-AppxPackage -ErrorAction SilentlyContinue

    if ($?) {
        Write-Host "-> Removed: $app" -ForegroundColor Green
    } else {
        Write-Host "-> Not found or not removable: $app" -ForegroundColor Red
    } 
}

Write-Host "`nDone!" -ForegroundColor Cyan

