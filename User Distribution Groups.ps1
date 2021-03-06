import-module ActiveDirectory
$Groups = (Get-AdGroup -filter 'GroupCategory -eq "Distribution"' | Where {$_.name -like "**"} | select name -expandproperty name)
$User = "USER FULL NAME HERE"
$Table = @()

$Record = [ordered]@{
"Name" = ""
"Group Name" = ""
"Email Address" = ""
}



Foreach ($Group in $Groups)
{

$Arrayofmembers = Get-ADGroupMember -identity $Group -recursive | where {$_.name -like $User} | select name,samaccountname

foreach ($Member in $Arrayofmembers)
{
$Record."Group Name" = $Group
$Record."Name" = $Member.name
$Record."Email Address" = $group.mail
$objRecord = New-Object PSObject -property $Record
$Table += $objrecord

}

}

$Table | export-csv "C:\temp\User DLs.csv" -NoTypeInformation