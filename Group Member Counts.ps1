import-module ActiveDirectory
$groups = Get-AdGroup -filter 'GroupCategory -eq "Distribution"'
$Table = @()

$Record = [ordered]@{
"Name" = ""
"Member Count" = ""
}



foreach($group in $groups){
$Record."Name" = $group.name
$UserCount= (Get-ADGroupMember $group.DistinguishedName).count 
if ($UserCount -gt 1) {$Record."Member Count" = $UserCount} Elseif ($UserCount -lt 1) {$Record."Member Count" = "0"} Else {$Record."Member Count" = "1"}
$objRecord = New-Object PSObject -property $Record
$Table += $objrecord

}

 $table| export-csv "C:\temp\Group Member Counts.csv" -NoTypeInformation



