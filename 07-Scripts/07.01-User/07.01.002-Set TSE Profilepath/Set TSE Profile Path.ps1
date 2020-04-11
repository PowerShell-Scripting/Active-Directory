<#

www.au2mator.com/PowerShell
PowerShell Self Service Portal

#>


$Users=Get-ADUser -Identity testler  -Properties $properties


$Users=Get-ADUser -Filter * -Properties * | where {$_.HomeDirectory -like "*\\fs01*"}
$Users.Count

#$AllUsers=Get-ADUser -Filter *
#$AllUsers.count


foreach ($User in $Users) {

$NewHomedirectory="\\fs03\Homedrive$\"+$User.SamAccountName

Set-ADUser -Identity $User -HomeDirectory $NewHomedirectory
[string]$DN=$User.distinguishedName

$LDAP="LDAP://"+$DN.substring($DN.indexof(",")+1,$DN.length-$DN.indexof(",")-1)
$UserDN=$DN.Substring(0,$DN.indexof(","))
$TSProfilePath="\\fs03\tsprofile$\"+$User.SamAccountName

 $ou = [adsi]"$LDAP"
 $LDAPuser = $ou.psbase.get_children().find($UserDN)
 
 $LDAPuser.psbase.invokeSet("TerminalServicesProfilePath","")
 $LDAPuser.setinfo()

 Write-Host $User
 #sleep -Seconds 5

}
