###############################################################
#
# Scriptname:  Create_Groups.ps1
#
# Autor:       Kuratli Elia
# Date:        21.06.22
#
# Version:     2022.01 / 21.06.22 / Elia Kuratli
#                                 Script created
#
#  
# Description: Create AD Groups from the XML file
#
###############################################################

Import-Module ActiveDirectory
Set-Location C:\temp\m122

$import = Import-Csv .\Source\Schueler.csv -Delimiter ";"

$Klasse1 = $import.Klasse -split " "
$Klasse2 = $import.Klasse2 -split " "

$get = Get-ADGroup -Filter *

$row += $Klasse1
$row += $Klasse2
$array = $row | Select-Object -Unique

foreach ($element in  $array){
if ($element.Length -gt 0){
    if ($get.name -eq "BZTF_"+$element){

    } else {
    New-ADGroup -Name BZTF_$element -SamAccountName BZTF_$element -GroupScope Global -Path "OU=Groups,OU=BZTF,DC=kuratli,DC=ch" -GroupCategory Distribution
    }
} else {
Start-Sleep -Seconds 0
}
}