###############################################################
#
# Scriptname:  Delete_Groups.ps1
#
# Autor:       Kuratli Elia, Etienne Ammann
# Date:        21.06.22
#
# Version:     2022.01 / 21.06.22 / Elia Kuratli
#                                 Script created
#
#  
# Description: Delete AD Groups that are not in the XML file
#
###############################################################

# Import CSV
$Import = Import-Csv C:\temp\m122\Source\Schueler.csv -Delimiter ";" -Encoding UTF8

# Variablen werden definiert
$Klasse_911 = $Import.Klasse -split " "
$Klasse_88 = $Import.Klasse2 -split " "

# Alle AD Gruppen werden ausgelesen
$ElonMusk = Get-ADGroup -Filter *

$Pig += $Klasse_911
$Pig += $Klasse_88
$Arrayson = $Pig | Select-Object -Unique

foreach ($Bob in  $Arrayson){
    if ($Bob.Length -gt 0){
        # Wenn Gruppe existiert wird sie gelöscht
        if ($ElonMusk.name -eq "BZTF_"+$Bob){ 
            $name = "BZTF_"+$Bob
            # Gruppe wird gelöscht
            Remove-ADGroup -Identity $name -Confirm:$false
            Write-Host "AD Gruppe : BZTF_$Bob wurde gelöscht"
        } else {
        
        }
    }
}