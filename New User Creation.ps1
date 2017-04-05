
##Built based on a script provided by and with the assistance of Scine.## 
 
##This section is where you're prompted for various aspects of a user's account.  Feel free to add/remove as you see fit##

$first = read-Host 'First Name'
$last = read-Host 'Last Name'
$Description = read-host 'Title'
$Office = read-Host 'Department'

##Converts first letter of First/Lastname/Description/Office to uppercase##

$first = $first.substring(0,1).toupper()+$first.substring(1).tolower()
$last = $last.substring(0,1).toupper()+$last.substring(1)
$Description = $Description.substring(0,1).toupper()+$Description.substring(1)
$Office = $Office.substring(0,1).toupper()+$Office.substring(1).tolower()

$Manager = read-Host 'Manager (Username Format)'
$Phone = read-Host 'Phone Number'
$first1 = $first.substring(0,1)
$un = $first1 + $last

##Converts username to lowercase##

$un = $un.tolower()

$pw = Read-Host -AsSecureString 'Secure Password'
$Name = $first + ' ' + $last
$homedr = 'H:'
$Homedir = '\\Server\dfs\home\' + $un
new-ADUser $name -Enabled $true -AccountPassword $pw -Path 'CN=Users,DC=Domain,DC=Local' -Department $Office -Description $Description -DisplayName $name -HomeDirectory $Homedir -Manager $Manager -ScriptPath $logon -Title $Description -OfficePhone $Phone -SamAccountName $un -GivenName $first -Surname $last -OtherAttributes @{userprincipalname="$un@mdsiinc.com";mail="$first.$last@mdsiinc.com";proxyaddresses="SMTP:$first.$last@mdsiinc.com; smtp:$un@mdsiinc.com"} -passwordneverexpires 0
set-aduser -Identity $un -homedrive $homedr
add-ADGroupMember $Office -Members $un
add-ADGroupMember "Dept $Office" -Members $un
add-ADGroupMember 'GLOBAL' -Members $un

##We have multiple sites, and the user's information will depend on their particular site.  This is a menu asking for the site, and will populate accordingly.##

$message = "Please select an option.  Use UPPER CASE LETTER!"

$S1 = New-Object System.Management.Automation.Host.ChoiceDescription "&Site1","Site 1"
$S2= New-Object System.Management.Automation.Host.ChoiceDescription "&Site2","Site 2"
$S3 = New-Object System.Management.Automation.Host.ChoiceDescription "&Site3","Site 3"
$Remote = New-Object System.Management.Automation.Host.ChoiceDescription "&Remote","Remote"

$options = [System.Management.Automation.Host.ChoiceDescription[]]($S1,$S2,$S3,$Remote)

$result = $host.ui.PromptForChoice($title, $message, $options, 0) 


switch ($result)
    {
        0 {set-ADUser $un -City "CITY" -Company "COMPANY" -PostalCode "ZIP" -State "STATE" -StreetAddress "ADDRESS" -OfficePhone $Phone -Office "OFFICE"
            add-ADGroupMember 'GROUP' -Members $un}
        1 {set-ADUser $un -City "CITY" -Company "COMPANY" -PostalCode "ZIP" -State "STATE" -StreetAddress "ADDRESS" -OfficePhone $Phone -Office "OFFICE"
            add-ADGroupMember 'GROUP' -Members $un}
		2 {set-ADUser $un -City "CITY" -Company "COMPANY" -PostalCode "ZIP" -State "STATE" -StreetAddress "ADDRESS" -OfficePhone $Phone -Office "OFFICE"
            add-ADGroupMember 'GROUP' -Members $un}
        3 {set-ADUser $un -OfficePhone $Phone
            add-ADGroupMember 'GROUP' -Members $un}
    }
	
set-aduser $un -Enabled $true

##Sync All DCs##

$DomainControllers = Get-ADDomainController -Filter *
ForEach ($DC in $DomainControllers.Name) {
    Write-Host "Processing for "$DC -ForegroundColor Green
    If ($Mode -eq "ExtraSuper") { 
        REPADMIN /kcc $DC
        REPADMIN /syncall /A /e /q $DC
    }
    Else {
        REPADMIN /syncall $DC "dc=domain,dc=local" /d /e /q
    }
}



