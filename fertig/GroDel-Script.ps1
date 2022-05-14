# Author: Noel & Fabio
# Datum: 30.12.2021
# Version: 1.0
# Funktionsbeschreibung: Group Delete
# Bemerkungen:
#-----
#Setze Location
Set-Location C:\M122Projekt\

#Importeiren des AD Modul
Import-Module ActiveDirectory

#Importieren der CSV
$csv = Import-Csv .\schueler.csv -Delimiter ";"

#Klasse spliten
$Klasse1 = $csv.Klasse -split " "
$Klasse2 = $csv.Klasse2 -split " "

#Variable für get-date
$Date = Get-Date

#start vorgang & log
$start = "[{0}] [{1}] Vorgang MASSGROUP wurde gestartet." -f "0", $Date
Write $start | Out-File Z:\M122Projekt\Documents\scripts\log.txt -Append

#variable für get-adgroup
$get = Get-ADGroup -Filter *

#array für klassen
$row += $Klasse1
$row += $Klasse2
#Select -Unique für keine doppelten
$array = $row |select -Unique

#foreach statement
foreach ($element in  $array){
#if statement
if ($element.Length -gt 0){
#if statment
if ($get.name -eq "BZTF_"+$element){ 
    #Variable für Wortzusammensetzung
    $name = "BZTF_"+$element
        #Remove AD group
        Remove-ADGroup -Identity $name -Confirm:$false
        #notice & log
    $notice1 = "[{0}] [{1}] {2} wurde gelöscht." -f "6", $Date, "BZTF_$element"
    Write $notice1 | Out-File Z:\M122Projekt\Documents\scripts\log.txt -Append
    echo $notice1

#else statement
} else {
#notice & log
$notice2 = "[{0}] [{1}] {2} existiert nicht oder wurde bereits gelöscht." -f "7", $Date, "BZTF_$element"
    Write $notice2 | Out-File Z:\M122Projekt\Documents\scripts\log.txt -Append
    echo $notice2


}
}
}