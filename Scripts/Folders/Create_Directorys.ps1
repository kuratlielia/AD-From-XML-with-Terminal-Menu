###############################################################
#
# Scriptname:  Create_Directorys.ps1
#
# Autor:       Kuratli Elia
# Date:        21.06.22
#
# Version:     2022.01 / 21.06.22 / Elia Kuratli
#                                 Script created
#
#  
# Description: Create Directorys
#
###############################################################

Import-Module ActiveDirectory
Set-Location C:\M122Projekt\

$import = Import-Csv .\Source\Schueler.csv -Delimiter ";"

$Klasse1 = $import.Klasse -split " "

$Klasse2 = $import.Klasse2 -split " "

$row += $Klasse1
$row += $Klasse2
$array = $row |Select-Object -Unique

Set-Location C:\temp\m122\Klassenordner

$get = Get-ChildItem -Filter *

foreach ($element in  $array){
    if ($element.Length -gt 0){
        if ($get.name -eq $element){ 
        } else {
            New-Item -Name $element -Path C:\M122Projekt\Klassenordner\ -ItemType Directory | Out-Null
        }
}else{
    Start-Sleep -Seconds 0
}
}