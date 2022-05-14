# Author: Noel & Fabio
# Datum: 28.12.2021
# Version: 1.0
# Funktionsbeschreibung: Rename directory
# Bemerkungen:
#-----

#Setze Location
Set-Location C:\M122Projekt\Klassenordner

#Importieren des AD Modul
Import-Module ActiveDirectory

#Variable für Get-Date
$Date = Get-Date

#Vorgang start und Output in Log
$start = "[{0}] [{1}] Vorgang RENFOLDER wurde gestartet." -f "0", $Date
Write $start | Out-File Z:\M122Projekt\Documents\scripts\log.txt -Append
Write $start

#do statement
do{
#Abfrage ob sicher
Write-Host "Möchten Sie einen Ordner umbenennen? (Yes/No)"
$Weiter = Read-Host

#if statement
if($weiter -eq "Yes"){
    #abfrage welcher ordner
    Write-Host "Welchen Ordner möchtest du umbenennen?"
    #save des input in variable
    $Input1 = Read-Host
    #Abfrage zu was für Namen ändern
    Write-Host "Zu welchen Namen möchtest du den Ordnernamen ändern?"
    #save des input in variable
    $Input2 = Read-Host
    #Umbennenung
    Rename-Item .\$Input1 .\$Input2 -Confirm:$false
    #notice & Log
    $notice1 = "[{0}] [{1}] {2} has been renamed to {3}." -f "10", $Date, $Input1, $Input2
    Add-Content -Path Z:\M122Projekt\Documents\scripts\disable-error.csv -Value "$Date | $SAM does not exist - Check Active Directory"
    Write $notice1 | Out-File Z:\M122Projekt\Documents\scripts\log.txt -Append
    echo $notice1
#else statement
}else{
    #Information das es sich schliesst.
    Write-Host "Programm schliesst sich in den nächsten 2 Sekunden"
    Start-Sleep 2
}
#until statement
}until ($weiter -eq "No")