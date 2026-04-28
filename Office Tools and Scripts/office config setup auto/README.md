## Office Config Setup Auto
- This allows you to deploy Office versions.

To download the ODT tool, see: https://www.microsoft.com/en-us/download/details.aspx?id=49117

Run `officedeploymenttool_*.exe` and move `setup.exe` to this directory, then rename it to `setup-custom.exe`.

> [!TIP]
> Alternatively, you can use the `officedeploymenttool_downloader.ps1` script: `powershell -ep Bypass ./officedeploymenttool_downloader.ps1` 
> 
> (this script functionality cannot be guaranteed if the owners of the ODT tool change the link or its webpage).
