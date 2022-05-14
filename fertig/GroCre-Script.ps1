# Author: Noel & Fabio
# Datum: 02.01.2022
# Version: 1.0
# Funktionsbeschreibung: Gruppene erstellen
# Bemerkungen:
#-----
#Setze Location
Set-Location C:\M122Projekt\

#Import AD Modul
Import-Module ActiveDirectory

#Import CSV
$csv = Import-Csv .\schueler.csv -Delimiter ";"

#Klasse splitet
$Klasse1 = $csv.Klasse -split " "
$Klasse2 = $csv.Klasse2 -split " "

#Variable für get-date
$Date = Get-Date

#Start des Vorgang & log
$start = "[{0}] [{1}] Vorgang MASSGROUP wurde gestartet." -f "0", $Date
Write $start | Out-File Z:\M122Projekt\Documents\scripts\log.txt -Append
Write $start

#variable für get-adgroup
$get = Get-ADGroup -Filter *

#array für klasse
$row += $Klasse1
$row += $Klasse2
#Select -Unique für keine doppelten
$array = $row |select -Unique

#foreach statement
foreach ($element in  $array){
#if statement
if ($element.Length -gt 0){
#if statement
if ($get.name -eq "BZTF_"+$element){
#notice & log 
$notice1 = "[{0}] [{1}] {2} existiert bereits" -f "4", $Date, "BZTF_$element"
    Write $notice1 | Out-File Z:\M122Projekt\Documents\scripts\log.txt -Append
    echo $notice1
#else statement
} else
{
#new ad-group
New-ADGroup -Name BZTF_$element -SamAccountName BZTF_$element -GroupScope Global -Path "OU=Groups,OU=BZTF,DC=bztf,DC=ch" -GroupCategory Distribution
#notice & log
$notice2 = "[{0}] [{1}] {2} wurde erstellt." -f "5", $Date, "BZTF_$element"
    Write $notice2 | Out-File Z:\M122Projekt\Documents\scripts\log.txt -Append
    echo $notice2
}
#else statement
}else{

#start sleep für beenden des programmes
Start-Sleep -Seconds 0
}



}




#New-ADGroup 