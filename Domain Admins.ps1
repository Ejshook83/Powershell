$Arrayofmembers = Get-ADGroupMember -identity "Domain Admins" -recursive

$Table = @()

$Record = [ordered]@{
"Name" = ""
"Description" = ""
}


foreach ($Member in $Arrayofmembers)
{
$Admin=(Get-ADUser $Member -properties * |Select DisplayName, Description)
$Record."Name" = $Admin.displayname
$Record."Description" = $Admin.description
$objRecord = New-Object PSObject -property $Record
$Table += $objrecord
}


$Table | sort-object Name | export-csv "C:\temp\Domain Admins.csv" -NoTypeInformation