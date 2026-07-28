## Adobe Reader 32 & 64 Bit Version GPO Template

This contains the Group Policy templates for Adobe Reader in the 32-bit and 64-bit versions for following versios:

### Supported Versions

- Classic
- 2020
- 2017
- 2015
- DC

Original source: https://github.com/p0w3rsh3ll/AdobeGPOTemplates/tree/master
Used Command: `New-AdobeGPOTemplate -Product Reader,Acrobat -Version Classic,2020,2017,2015,DC`

- The `*.adml` files is intended for the `en-us` language.
- The `*.admx` files is from the linked source was a result of the used powershell modul so that all relevant GPOs can be set separately for 32-bit and/or 64-bit systems.

> [!IMPORTANT]
> **All `*.admx` files must be copied to `%SYSTEMROOT%\PolicyDefinitions`, and all `*.adml` files to `%SYSTEMROOT%\PolicyDefinitions\en-US` so that the templates are recognized by e.g. gpedit.**

> [!NOTE]
> Tested with Adobe Reader DC in both 32-bit and 64-bit versions, version 26.001.21745
