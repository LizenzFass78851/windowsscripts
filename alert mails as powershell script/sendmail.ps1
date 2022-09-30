#$EventId = 16,20,23,150,219,220
$EventId = 259

$A = Get-WinEvent -MaxEvents 1  -FilterHashTable @{Logname = "Application" ; ID = $EventId}
$Message = $A.Message
$EventID = $A.Id
$MachineName = $A.MachineName
$Source = $A.ProviderName

$EmailFrom = "events@example.com"
$EmailTo = "admin@example.com,second.admin@example.com"
$Subject ="Alert From $MachineName"
$Body = "EventID: $EventID`nSource: $Source`nMachineName: $MachineName `nMessage: $Message"

$SMTPServer = "smtp.1und1.de"
$SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 587)
#$SMTPClient.EnableSsl = $true
#$SMTPClient.Credentials = New-Object System.Net.NetworkCredential("events@example.com", "yoursmtppassword");
$SMTPClient.Send($EmailFrom, $EmailTo, $Subject, $Body)
