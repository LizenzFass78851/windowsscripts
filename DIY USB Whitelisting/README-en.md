## DIY USB Whitelisting
- Instructions for allowing certain USB devices, excluding all USB devices not on the allow list.

These instructions cannot be implemented as a script because Windows makes this complicated and therefore it is only available as a guide using certain tools and parts of scripts that make it a little easier.

This allows you to apply this whitelisting to a local computer without AD infrastructure.

-----

Required components:
- [DeviceCleanup by Uwe Sieber](https://www.uwe-sieber.de/files/DeviceCleanup.zip)
- [CreateWhitelist.ps1](CreateWhitelist.ps1)
- Windows at least in the "Pro" edition

Procedure:
1. Unzip `DeviceCleanup.zip` and run `DeviceCleanup.exe` from either the `x64` directory (for Windows in the x64 / 64 bit architecture) or `Win32` (for Windows in the x86 / 32 bit architecture)

1.1. In the `DeviceCleanup` program, mark all USB devices listed there with the "CTRL" key + "A" key and remove them with the "DEL" key.

2. Run `CreateWhitelist.ps1` and open the created `USBWhitelist.txt`. The contents of this file will be needed later

3. Open `gpedit.msc` under the search bar.

3.1. Navigate to "Computer Configuration > Administrative Templates > System > Device Installation > Device Installation Restrictions"

3.2. Activate the following GPO "Allow installation of devices with these device IDs"

3.2.1. Click on "Show" and insert the IDs read from `USBWhitelist.txt` line by line and click on "OK" and then on "OK" again

3.3. Activate the following GPO "Prevent installation of devices not described in other policies" and click on "OK"


This should make this USB whitelisting work.
Success not guaranteed.
