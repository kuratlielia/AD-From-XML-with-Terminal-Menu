###############################################################
#
# Scriptname:  Delete_Groups.ps1
#
# Autor:       Kuratli Elia
# Date:        21.06.22
#
# Version:     2022.01 / 21.06.22 / Elia Kuratli
#                                 Script created
#
#  
# Description: Delete AD Groups that are not in the XML file
#
###############################################################

$Import = Import-Csv C:\temp\m122\Source\Schueler.csv -Delimiter ";" -Encoding UTF8

$Klasse1 = $import.Klasse -split " "
$Klasse2 = $import.Klasse2 -split " "

$get = Get-ADGroup -Filter *

$row += $Klasse1
$row += $Klasse2
$array = $row |Select-Object -Unique

foreach ($element in  $array){
    if ($element.Length -gt 0){
        if ($get.name -eq "BZTF_"+$element){ 
            $name = "BZTF_"+$element
            Remove-ADGroup -Identity $name -Confirm:$false
        } else {
        
        }
    }
}