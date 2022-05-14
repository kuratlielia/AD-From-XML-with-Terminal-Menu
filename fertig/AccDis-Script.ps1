# Author: Noel & Fabio
# Datum: 03.01.2022
# Version: 1.0
# Funktionsbeschreibung: Disavle alle AD Accs
# Bemerkungen:
#-----

#Setze Location
Set-Location C:\M122Projekt

#import ad modul
Import-Module ActiveDirectory

#varialbe für get-aduser
$getaduser = Get-ADUser -Filter *

#variable für get-date
$date = Get-Date

#import csv
$csv = Import-Csv .\schueler.csv -Delimiter ";" -Encoding UTF8
#variable für username
$Username = $csv.vorname

#foreach statement
foreach ($User in $getaduser) {
#variable für givenname
$givenname = $user.givenname
#if statement
if ($username -eq $givenname){ Start-Sleep -Seconds 0}
#else statement
else{
#if statement
if($user.name -eq "administrator"){



}
#else statement
else
{
#set-ad user
Set-ADUser -Identity $user -Enabled $false
#notice & log
$notice1 = "[{0}] [{1}] {2}  disabled" -f "3", $Date, $user.Name
    Write $notice1 | Out-File Z:\M122Projekt\Documents\scripts\log.txt -Append
    echo $notice1
}

}
}