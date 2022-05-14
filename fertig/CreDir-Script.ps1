# Author: Noel & Fabio
# Datum: 29.12.2021
# Version: 1.0
# Funktionsbeschreibung: Create Directory
# Bemerkungen:
#-----

#Setze Location
Set-Location C:\M122Projekt\

#Importieren des AD Modul
Import-Module ActiveDirectory

#Get Date in einer Variable
$Date = Get-Date

#Importieren des CSV
$csv = Import-Csv .\schueler.csv -Delimiter ";"

#Klasse gesplitet
$Klasse1 = $csv.Klasse -split " "

#Klasse gesplitet
$Klasse2 = $csv.Klasse2 -split " "

#Vorgang gestartet und Output davon
$start = "[{0}] [{1}] Vorgang MASSFOLDER wurde gestartet." -f "0", $Date
Write $start | Out-File Z:\M122Projekt\Documents\scripts\log.txt -Append
Write $start

#Array für Klasse
$row += $Klasse1
$row += $Klasse2
#Select -Unique für keine doppelten
$array = $row |select -Unique

#Setze Location 2
Set-Location C:\M122Projekt\Klassenordner

#Variable für Get-Childitem
$get = Get-ChildItem -Filter *

#foreach definiert
foreach ($element in  $array){
    #Setze Location 3
    Set-Location C:\M122Projekt\Klassenordner
#if statement
if ($element.Length -gt 0){
#if statement
if ($get.name -eq $element){ 
#notice variable erstellt
$notice1 = "[{0}] [{1}] {2} existiert bereits" -f "8", $Date, $element
    Write $notice1 | Out-File Z:\M122Projekt\Documents\scripts\log.txt -Append
    echo $notice1
#else statement
} else
{
#new item directory
New-Item -Name $element -Path C:\M122Projekt\Klassenordner\ -ItemType Directory | Out-Null
$notice2 = "[{0}] [{1}] {2} wurde erstellt" -f "9", $Date, $element
    Write $notice1 | Out-File Z:\M122Projekt\Documents\scripts\log.txt -Append
    echo $notice2
}
#if statement
}else{
#start-sleep für programm ende
Start-Sleep -Seconds 0
}
}