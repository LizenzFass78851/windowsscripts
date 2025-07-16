## Office Disable Telemetry
- an attempt to disable telemetry in Microsoft Office

### OC2R_DisableTelemetry

Thanks to abbodi1406, there is a registry file that makes it possible to disable telemetry in Office and thus, among other things, communication with:
- `nexusrules.officeapps.live.com` (on office 2021 ltcs)
- `self.events.data.microsoft.com` (on office 2021 ltcs)

Found at: https://github.com/abbodi1406/WHD/blob/master/scripts/OC2R_DisableTelemetry.reg

#### OC2R_DisableTelemetry_Lite

A lite version with which you only have the entry `DisableTelemetry` in the registry (since this is unfortunately not available in the GPO templates) if you have already defined everything necessary via [GPO](https://www.microsoft.com/en-us/download/details.aspx?id=49030).

See: [OC2R_DisableTelemetry_Lite.reg](./OC2R_DisableTelemetry_Lite.reg)
