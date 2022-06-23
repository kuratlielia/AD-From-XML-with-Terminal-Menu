###############################################################
#
# Scriptname:  Add_Members.ps1
#
# Autor:       Kuratli Elia, Etienne Ammann
# Date:        21.06.22
#
# Version:     2022.01 / 21.06.22 / Elia Kuratli
#                                 Script created
#
#  
# Description: Add created members to the groups
#
###############################################################

$Import = Import-Csv C:\temp\m122\Source\Schueler.csv -Delimiter ";" -Encoding UTF8

foreach($Benutzer in $Import){
    
    $Username = $Benutzer.Benutzername
    if($Username.Length -gt 30) {
        $Username = $Username.subString(0, 30)
    }
    $KlassenName = "BZTF_" + $Benutzer.Klasse
    Add-ADGroupMember -Identity $KlassenName -Members $Username
}