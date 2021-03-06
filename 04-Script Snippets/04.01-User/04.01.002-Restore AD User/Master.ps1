<#

www.au2mator.com/PowerShell
PowerShell Self Service Portal

#>

Import-Module activedirectory
Get-ADObject -filter * -IncludeDeletedObjects

#Auslesen aller User
Get-ADObject -filter {ObjectClass -like "user"} -SearchBase "CN=Deleted Objects,DC=Company,DC=local" -IncludeDeletedObjects #| Restore-ADObject

#Auslesen aller Gruppen
Get-ADObject -filter {ObjectClass -like "group"} -SearchBase "CN=Deleted Objects,DC=Company,DC=local" -IncludeDeletedObjects #| Restore-ADObject

#Auslesen aller Computer
Get-ADObject -filter {ObjectClass -like "computer"} -SearchBase "CN=Deleted Objects,DC=Company,DC=local" -IncludeDeletedObjects #| Restore-ADObject

#Auslesen eines Objektes mit einem Namen
Get-ADObject -Filter {name -like "*test*"}  -SearchBase "CN=Deleted Objects,DC=Company,DC=local" -IncludeDeletedObjects #| Restore-ADObject