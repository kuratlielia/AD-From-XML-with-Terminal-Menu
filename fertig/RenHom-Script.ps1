# Author: Noel & Fabio
# Datum: 05.01.2022
# Version: 1.0
# Funktionsbeschreibung: Rename von Home Directories
# Bemerkungen:
#-----

#Setze Location
Set-Location C:\M122Projekt\Homes

#importieren des AD modul
Import-Module ActiveDirectory

#varaible für get-date
$Date = Get-Date

#start vorgang & log
$start = "[{0}] [{1}] Vorgang RENHOME wurde gestartet." -f "0", $Date
Write $start | Out-File Z:\M122Projekt\Documents\scripts\log.txt -Append
Write $start

#do-statement
do{
#write ob sicher
Write-Host "Möchten Sie einen Ordner umbenennen? (Yes/No)"
$Weiter = Read-Host
#if statement
if($weiter -eq "Yes"){
    #welcher ordner umbennen
    Write-Host "Welchen Ordner möchtest du umbenennen?"
    #input 1
    $Input1 = Read-Host
    #zu was ändern (name)
    Write-Host "Zu welchen Namen möchtest du den Ordnernamen ändern?"
    #input2
    $Input2 = Read-Host
    #rename item
    Rename-Item .\$Input1 .\$Input2 -Confirm:$false
    #notice1 & log
    $notice1 = "[{0}] [{1}] {2} has been renamed to {3}." -f "13", $Date, $Input1, $Input2
    Add-Content -Path Z:\M122Projekt\Documents\scripts\disable-error.csv -Value "$Date | $SAM does not exist - Check Active Directory"
    Write $notice1 | Out-File Z:\M122Projekt\Documents\scripts\log.txt -Append
    echo $notice1
#else statement
}else{

}
#until statement
}until ($weiter -eq "No")