###############################################################
#
# Scriptname:  Create_Directorys.ps1
#
# Autor:       Kuratli Elia, Etiennson Ammann
# Date:        21.06.22
#
# Version:     2022.01 / 21.06.22 / Elia Kuratli
#                                 Script created
#
#  
# Description: Create Directorys
#
###############################################################

$Import = Import-Csv C:\temp\m122\Source\Schueler.csv -Delimiter ";" -Encoding UTF8

$Klasse_69 = $Import.Klasse -split " "

$Klasse_187 = $Import.Klasse2 -split " "

$Pig += $Klasse_69
$Pig += $Klasse_187
$Arrayson = $Pig | Select-Object -Unique

Set-Location C:\temp\m122\Klassenordner

$Folders = Get-ChildItem -Filter *

foreach ($Klasse in  $Arrayson){
    if ($Klasse.Length -gt 0){
        if ($Folders.name -eq $Klasse){

            Write-Host "Klassenordner $Klasse existiert bereits"

        } else {
            New-Item -Name $Klasse -Path C:\temp\m122\Klassenordner\ -ItemType Directory | Out-Null
            Write-Host "Klassenordner: $Klasse wurde erstellt"
        }
    }else{
        Start-Sleep -Seconds 1
        Write-Host "Klassen Name ist leer"
    }
}