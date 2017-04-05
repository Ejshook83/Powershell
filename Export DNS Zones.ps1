#Must run as admin, from DNS Server.
#Zones are exported to c:\windows\system32\dns\backup\ directory.

$Zones = @(Get-WmiObject -Namespace Root\MicrosoftDNS -Class "MicrosoftDNS_Zone" | Select Name)

ForEach ($Zone in $Zones)
{
$File = $Zone.name
cmd.exe /c dnscmd /zoneexport $Zone.name $File".bak"
Move-Item c:\windows\system32\dns\$File".bak" c:\windows\system32\dns\backup\$File".bak" -force
}




