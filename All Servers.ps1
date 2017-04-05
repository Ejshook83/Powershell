$objSearcher = New-Object System.DirectoryServices.DirectorySearcher
$objSearcher.Filter = '(OperatingSystem=Window*Server*)'
"Name","canonicalname","distinguishedname" | Foreach-Object {$null = $objSearcher.PropertiesToLoad.Add($_) }
$objSearcher.FindAll() | Select-Object @{n='Name';e={$_.properties['name']}},@{n='CanonicalName';e={$_.properties['canonicalname']}},@{n='ipv4Address';e={$_.properties['ipv4Address']}} |Export-csv c:\temp\Servers.csv