<#

www.au2mator.com/PowerShell
PowerShell Self Service Portal

#>


Import-Module ActiveDirectory
Get-ADGroup -Filter * -Properties Members  | where { -not $_.Members} | select Name 