$Arrayofmembers = Get-ADGroupMember -identity "Domain Users" -recursive 
$Table = @()

$Record = [ordered]@{
"Name" = ""
"Office" = ""
"Last Logon" = ""
"Description" = ""
}

$NT='No Logon Timestamp'

foreach ($Member in $Arrayofmembers)
{
$User=(Get-ADUser $Member -properties * |Select Name, Description, lastlogon, office)
$Record."Name" = $User.name
$Record."Description" = $User.description
if($user.LastLogon -gt 0) 
    {
      $time = $user.LastLogon
      $dt = [DateTime]::FromFileTime($time)
    }
    else
{
$dt=$nt
}  
$record."Office" = $user.office
$Record."Last Logon" = $dt
$objRecord = New-Object PSObject -property $Record
$Table += $objrecord
}


$Table | sort-object Name | export-csv "C:\temp\Domain Users.csv" -NoTypeInformation
