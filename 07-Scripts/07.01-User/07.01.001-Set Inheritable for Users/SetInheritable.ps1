########################################################
#Name: SetInheritable.ps1                              #
#Creator: Michael Seidl aka Techguy                    #
#CreationDate: 27.11.2013                              #
#LastModified:27.11.2013                               #
#Version: 1.0                                          #
#Doc: http://www.techguy.at/tag/setinheritable/        #
########################################################
#www.techguy.at                                        #
#www.facebook.com/TechguyAT                            #
#www.twitter.com/TechguyAT                             #
#michael@techguy.at                                    #
########################################################
<#

www.au2mator.com/PowerShell
PowerShell Self Service Portal

#>

#Import Module
Import-Module activedirectory

#Set Organization Unit
$OU="OU=seimi,DC=company,DC=at"

#Some Varibales
[bool]$isProtected = $false
[bool]$PreserveInheritance = $true

#Get Users
$Users=get-aduser -Filter * -SearchBase $OU

#Do the Magic
if ($Users -ne $null) {
    foreach ($Entry in $Users) {
        [string]$dn = (Get-ADUser $Entry).DistinguishedName 
        $user = [ADSI]"LDAP://$dn" 
        $acl = $user.objectSecurity  
        Write-Host "Set Permissions for User:"(Get-ADUser $Entry).SamAccountName
            if ($acl.AreAccessRulesProtected){ 
                $acl.SetAccessRuleProtection($isProtected,$PreserveInheritance) 
                $inherited = $acl.AreAccessRulesProtected 
                $user.commitchanges() 
            }
        }
    }
else {Write-Host "No User found"}