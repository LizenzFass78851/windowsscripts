# Target directory
$TargetDir = Join-Path $PSScriptRoot "ODT"
New-Item -ItemType Directory -Path $TargetDir -Force | Out-Null

# Function: Get latest ODT download URL dynamically
function Get-ODTDownloadUrl {
    Write-Host "Fetching download page..."

    $page = Invoke-WebRequest -Uri "https://www.microsoft.com/en-us/download/details.aspx?id=49117"

    # Extract direct download link for officedeploymenttool*.exe
    if ($page.Content -match 'https://download\.microsoft\.com[^"]+officedeploymenttool[^"]+\.exe') {
        return $matches[0]
    } else {
        throw "Failed to find download URL for Office Deployment Tool."
    }
}

try {
    # Step 1: Get download URL
    $downloadUrl = Get-ODTDownloadUrl
    Write-Host "Download URL found:`n$downloadUrl"

    # Step 2: Download EXE
    $exePath = Join-Path $TargetDir "officedeploymenttool.exe"
    Write-Host "Downloading Office Deployment Tool..."
    Invoke-WebRequest -Uri $downloadUrl -OutFile $exePath

    # Step 3: Extract files silently
    Write-Host "Extracting files..."
    Start-Process -FilePath $exePath `
        -ArgumentList "/quiet /extract:`"$TargetDir`"" `
        -Wait

    # Step 4: Keep only setup.exe file
    Write-Host "Cleaning up extracted files..."

    Get-ChildItem -Path $TargetDir -File | ForEach-Object {
        if ($_.Name -notmatch "setup\.exe") {
            Remove-Item $_.FullName -Force
        }
    }

    # Step 5: Move setup.exe to CurrentDir
    Move-Item $TargetDir/setup.exe ./setup-custom.exe -Force
    Remove-Item $TargetDir -Force

    Write-Host "`nDone! Files available in: $TargetDir"
}
catch {
    Write-Error $_
}