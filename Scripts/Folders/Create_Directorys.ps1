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

# Import CSV
$Import = Import-Csv C:\temp\m122\Source\Schueler.csv -Delimiter ";" -Encoding UTF8

# Variablen werden definiert
$Klasse_69 = $Import.Klasse -split " "

$Klasse_187 = $Import.Klasse2 -split " "

$Pig += $Klasse_69
$Pig += $Klasse_187
$Arrayson = $Pig | Select-Object -Unique

# Location wird gesetzt
Set-Location C:\temp\m122\Klassenordner

# Alle Ordner in der Location werden ausgelesen
$Folders = Get-ChildItem -Filter *

foreach ($Klasse in  $Arrayson){
    if ($Klasse.Length -gt 0){
        # Wenn Ordner bereits existiert
        if ($Folders.name -eq $Klasse){

            Write-Host "Klassenordner $Klasse existiert bereits"

        } else {
            # Ordner wird erstellt
            New-Item -Name $Klasse -Path C:\temp\m122\Klassenordner\ -ItemType Directory | Out-Null
            Write-Host "Klassenordner: $Klasse wurde erstellt"
        }
    }else{
        Start-Sleep -Seconds 1
        Write-Host "Klassen Name ist leer"
    }
}