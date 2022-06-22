###############################################################
#
# Scriptname:  Add_Members.ps1
#
# Autor:       Kuratli Elia
# Date:        21.06.22
#
# Version:     2022.01 / 21.06.22 / Elia Kuratli
#                                 Script created
#
#  
# Description: Add created members to the groups
#
###############################################################

Import-Module ActiveDirectory
Set-Location C:\temp\m122

$import = Import-Csv .\Source\Schueler.csv -Delimiter ";" -Encoding UTF8

foreach($element in $import){
    
    $Username = $element.Benutzername
    if($Username.Length -gt 20) {
        $Username = $Username.subString(0, 20)
    }
    $Klasse = "BZTF_" + $element.Klasse
    Add-ADGroupMember -Identity $Klasse -Members $Username
}