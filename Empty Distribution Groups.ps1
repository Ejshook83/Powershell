import-module ActiveDirectory
Get-ADGroup -Filter {GroupCategory -eq 'Distribution'} | ?{@(Get-ADGroupMember $_).Length -eq 0} | Select Name, DistinguishedName | export-csv "C:\temp\Empty.csv" -NoTypeInformation