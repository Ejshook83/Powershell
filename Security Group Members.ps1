import-module ActiveDirectory
$Groups = (Get-AdGroup -filter 'GroupCategory -eq "Security"' | Where {$_.name -like "**"} | select name -expandproperty name)


$Table = @()

$Record = @{
"Group Name" = ""
"Name" = ""
"Username" = ""
}



Foreach ($Group in $Groups)
{

$Arrayofmembers = Get-ADGroupMember -identity $Group -recursive | select name,samaccountname

foreach ($Member in $Arrayofmembers)
{
$Record."Group Name" = $Group
$Record."Name" = $Member.name
$Record."UserName" = $Member.samaccountname
$objRecord = New-Object PSObject -property $Record
$Table += $objrecord

}

}

$Table | export-csv "C:\temp\Security Members.csv" -NoTypeInformation