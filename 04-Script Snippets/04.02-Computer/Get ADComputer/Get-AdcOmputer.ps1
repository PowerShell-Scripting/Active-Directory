<#

www.au2mator.com/PowerShell
PowerShell Self Service Portal

#>


Import-Module ActiveDirectory
Get-ADComputer -Filter 'ObjectClass -eq "Computer"'  -Properties OperatingSystem,Name,OperatingSystemVersion,LastLogonDate,Enabled | Select OperatingSystem,Name,OperatingSystemVersion,LastLogonDate,Enabled | export-csv -Path ("C:\export.csv")
