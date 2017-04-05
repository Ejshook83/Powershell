$Arrayofmembers = Get-ADUser -LDAPFilter "(&(objectCategory=person)(objectClass=user)(msNPAllowDialin=TRUE))" 




$Table = @()

$Record = [Ordered]@{
"Name" = ""
"Description" = ""
}


foreach ($Member in $Arrayofmembers)
{
$User=(Get-ADUser $Member -properties * |Select Name, Description)
$Record."Name" = $User.name
$Record."Description" = $User.description
$objRecord = New-Object PSObject -property $Record
$Table += $objrecord
}


$Table | sort-object Name | export-csv "C:\temp\VPN Users.csv" -NoTypeInformation
