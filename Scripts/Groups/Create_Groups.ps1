###############################################################
#
# Scriptname:  Create_Groups.ps1
#
# Autor:       Kuratli Elia, Etienne Ammann
# Date:        21.06.22
#
# Version:     2022.01 / 21.06.22 / Elia Kuratli
#                                 Script created
#
#  
# Description: Create AD Groups from the XML file
#
###############################################################

# Import CSV
$Import = Import-Csv C:\temp\m122\Source\Schueler.csv -Delimiter ";" -Encoding UTF8

# Variablen werden deklariert
$Klasse_420 = $Import.Klasse -split " "
$Klasse_6969696969696 = $Import.Klasse2 -split " "

$BillGates = Get-ADGroup -Filter *

$Pig += $Klasse_420
$Pig += $Klasse_6969696969696
$Arrayson = $Pig | Select-Object -Unique

foreach ($Klasse in  $Arrayson){
if ($Klasse.Length -gt 0){
    # Wenn Gruppe bereits existiert passiert nicht
    if ($BillGates.name -eq "BZTF_"+$Klasse){

    } else {
        # Neue AD Gruppe wird erstellt
        New-ADGroup -Name BZTF_$Klasse -SamAccountName BZTF_$Klasse -GroupScope Global -Path "OU=Klassengruppen,OU=BZTF,DC=kuratli,DC=ch" -GroupCategory Distribution
        Write-Host "AD Gruppe: BZTF_$Klasse wurde erstellt"

    }
} else {
    Start-Sleep -Seconds 2
    Write-Host "Klasse ist leer"
}
}