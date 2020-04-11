<#

www.au2mator.com/PowerShell
PowerShell Self Service Portal

#>

Import-Module ActiveDirectory

$OU="OU=Salz Nord,OU=Users,OU=Department,OU=Edelstahl,DC=Company,DC=root,DC=local"

Get-ADUser -Filter * -SearchBase $OU | Set-ADUser -HomeDrive P: