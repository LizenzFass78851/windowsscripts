### EFI Boot Keys for UEFI to import

- This includes the following binaries extracted from a working motherboard with Secure Boot enabled:

  - PK
  - KEK
  - DB
  - DBX

- These files can be imported into a UEFI to obtain the following Secure Boot CAs:

  - Microsoft 2011
  - Microsoft 2023

This is useful if you want to clone Windows to a new system and run it on a motherboard that doesn't recognize any of the old or new CAs.

> [!IMPORTANT]
> If the currently valid CAs are not imported into the UEFI, Secure Boot will be displayed as disabled even though it is enabled, thus preventing future Windows 11 updates/upgrades (in-place upgrades) and subsequent UEFI CA update commands from Windows. Therefore, the only way to install Secure Boot on a new motherboard with valid CAs is to manually import these four files.

> [!NOTE]
> Other CAs may also be included in the files, such as the CAs of ASUS and Ubuntu.
