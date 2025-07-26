## Windows Remote Assistance
- A possibility for Windows which is used as a terminal server **or** another computer on internal network with several users to help other users as an admin

Run the following as admin so that the corresponding window opens to set this ip or hostname for the target computer and select the user that you want to help

````
%SYSTEMROOT%\SYSTEM32\msra.exe /offerra
````

-----

### Configure GPO

Set the following under:

- `Computer Configuration -> Administrative Templates -> System -> Remote Assistance`

  - Configure "Requested Remote Assistance"
    1. **Set to `Enabled`**
    2. **Allow remote monitoring of this computer:** Helpers can remotely control the computer
    3. **Maximum invitation validity period (value):** 1
    4. **Maximum invitation validity period (unit):** Hours
    5. **Method for sending email invitations:** Send to

  - Configure "Offer Remote Assistance"
    1. **Set to `Enabled`**
    2. **Allow remote monitoring of this computer:** Helpers can remotely control the computer
    3. **Helpers:** <Enter the user accounts or groups. e.g. COMPUTERNAME\USER>

- `Computer Configuration -> Windows Settings -> Security Settings -> Windows Defender Firewall with Advanced Security -> Inbound Rules`

  - New Rule...
    1. Create a new firewall rule to allow connections for the following program `%SystemRoot%\system32\raserver.exe`.
    2. Create a new firewall rule to allow connections for the following program `%SystemRoot%\system32\msra.exe`.
