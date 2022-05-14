# Author: Noel & Fabio
# Datum: 10.01.2022
# Version: 1.0
# Funktionsbeschreibung: Alle Scripts in Switch
# Bemerkungen:
#-----

#do statement
Do{
#clear statement
Clear-Host

#do until variable für checks
$DOUNTIL = Read-Host "Möchtest du eine Aufgabe ausführen? (Yes/No)"
#clear host
Clear-Host
#if statement
if($DOUNTIL -eq "Yes"){
#clear host
Clear-Host
#switch statement
switch (Read-Host "1: Create Users`n2: Disable Users`n3: Create Groups`n4: Delete Groups`n5: Create Directories`n6: Rename Directories`n7: Create Home`n8: Rename Home`n9: Clear Log`nWählen Sie eine Aufgabe"){

1{
Clear-Host
Set-Location C:\M122Projekt

Import-Module ActiveDirectory

$Users = Import-Csv -Delimiter ";" -Path ".\schueler.csv"

$bztfpassword = "bztf.001"

$Date = Get-Date

$start = "[{0}] [{1}] Vorgang MASSCREUSER wurde gestartet." -f "0", $Date
Write $start | Out-File Z:\M122Projekt\Documents\scripts\log.txt -Append
Write $start

function Test-ADUser {
    param(
        [Parameter(Mandatory = $true)]
        [string] $SAM
    )
    $null -ne ([ADSISearcher] "(sAMAccountName=$SAM)").FindOne()
}

foreach ($User in $Users) {
  $Username = $User.Benutzername.Replace('ä','ae').Replace('ö','oe').Replace('ü','ue').Replace('é','e').Replace('è','e')
  if($Username.Length -gt 20) {
    $Username = $Username.subString(0, 20)
  }
  $SAM = $Username
  $Displayname = $Username
  $Firstname = $User.Vorname
  $Lastname = $User.Name
  $OU = "OU=Users,OU=BZTF,DC=bztf,DC=ch"
  $UPN = $Username + "@bztf.ch"
  $Password = (ConvertTo-SecureString $bztfpassword -AsPlainText -Force)
  $Date = Get-Date

  if (!(Get-ADUser -Filter "sAMAccountName -eq '$($SAM)'")) {
    New-ADUser -Name "$Displayname" -DisplayName "$Displayname" -SamAccountName "$SAM" -UserPrincipalName "$UPN" -GivenName "$Firstname" -Surname "$Lastname" -AccountPassword $Password -Enabled $true -Path "$OU" -ChangePasswordAtLogon $false -PasswordNeverExpires $true
    $notice1 = "[{0}] [{1}] {2} wurde erstellt." -f "1", $Date, $SAM
    Write $notice1 | Out-File Z:\M122Projekt\Documents\scripts\log.txt -Append
    echo $notice1
  }else{
  $notice2 = "[{0}] [{1}] {2} existiert bereits!" -f "2", $Date, $SAM
  Write $notice2 | Out-File Z:\M122Projekt\Documents\scripts\log.txt -Append
  echo $notice2
  Add-Content -Path Z:\M122Projekt\Documents\scripts\duplicate.csv -Value "$SAM already exists, Please check User-Information"

  }

}
}
2{
Clear-Host
Set-Location C:\M122Projekt

Import-Module ActiveDirectory

$start = "[{0}] [{1}] Vorgang MASSDELUSER wurde gestartet." -f "0", $Date
Write $start | Out-File Z:\M122Projekt\Documents\scripts\log.txt -Append
Write $start

$getaduser = Get-ADUser -Filter *

$date = Get-Date

$csv = Import-Csv .\schueler.csv -Delimiter ";" -Encoding UTF8
$Username = $csv.vorname
foreach ($User in $getaduser) {
$givenname = $user.givenname
if ($username -eq $givenname){ Start-Sleep -Seconds 0}
else{
if($user.name -eq "administrator"){



}
else
{
Set-ADUser -Identity $user -Enabled $false
$notice1 = "[{0}] [{1}] {2}  disabled" -f "3", $Date, $user.Name
    Write $notice1 | Out-File Z:\M122Projekt\Documents\scripts\log.txt -Append
    echo $notice1
}

}
}
}
3{
Clear-Host
Set-Location C:\M122Projekt\

Import-Module ActiveDirectory

$csv = Import-Csv .\schueler.csv -Delimiter ";"

$Klasse1 = $csv.Klasse -split " "

$Klasse2 = $csv.Klasse2 -split " "

$Date = Get-Date

$start = "[{0}] [{1}] Vorgang MASSCREGROUP wurde gestartet." -f "0", $Date
Write $start | Out-File Z:\M122Projekt\Documents\scripts\log.txt -Append
Write $start

$get = Get-ADGroup -Filter *

$row += $Klasse1
$row += $Klasse2
$array = $row |select -Unique


foreach ($element in  $array){
if ($element.Length -gt 0){
if ($get.name -eq "BZTF_"+$element){ 
$notice1 = "[{0}] [{1}] {2} existiert bereits" -f "4", $Date, "BZTF_$element"
    Write $notice1 | Out-File Z:\M122Projekt\Documents\scripts\log.txt -Append
    echo $notice1
} else
{
New-ADGroup -Name BZTF_$element -SamAccountName BZTF_$element -GroupScope Global -Path "OU=Groups,OU=BZTF,DC=bztf,DC=ch" -GroupCategory Distribution
$notice2 = "[{0}] [{1}] {2} wurde erstellt." -f "5", $Date, "BZTF_$element"
    Write $notice2 | Out-File Z:\M122Projekt\Documents\scripts\log.txt -Append
    echo $notice2
}
}else{

Start-Sleep -Seconds 0
}
}
}
4{
Clear-Host
Set-Location C:\M122Projekt\

Import-Module ActiveDirectory

$csv = Import-Csv .\schueler.csv -Delimiter ";"

$Klasse1 = $csv.Klasse -split " "

$Klasse2 = $csv.Klasse2 -split " "

$Date = Get-Date

$start = "[{0}] [{1}] Vorgang MASSDISGROUP wurde gestartet." -f "0", $Date
Write $start | Out-File Z:\M122Projekt\Documents\scripts\log.txt -Append
Write $start

$get = Get-ADGroup -Filter *

$row += $Klasse1
$row += $Klasse2
$array = $row |select -Unique


foreach ($element in  $array){
if ($element.Length -gt 0){
if ($get.name -eq "BZTF_"+$element){ 
    $name = "BZTF_"+$element
        Remove-ADGroup -Identity $name -Confirm:$false
        $notice1 = "[{0}] [{1}] {2} wurde gelöscht." -f "6", $Date, "BZTF_$element"
    Write $notice1 | Out-File Z:\M122Projekt\Documents\scripts\log.txt -Append
    echo $notice1


} else {
$notice2 = "[{0}] [{1}] {2} existiert nicht oder wurde bereits gelöscht." -f "7", $Date, "BZTF_$element"
    Write $notice2 | Out-File Z:\M122Projekt\Documents\scripts\log.txt -Append
    echo $notice2


}
}
}
}
5{
Clear-Host
Set-Location C:\M122Projekt\

Import-Module ActiveDirectory

$Date = Get-Date

$csv = Import-Csv .\schueler.csv -Delimiter ";"

$Klasse1 = $csv.Klasse -split " "

$Klasse2 = $csv.Klasse2 -split " "

$start = "[{0}] [{1}] Vorgang MASSCREFOLDER wurde gestartet." -f "0", $Date
Write $start | Out-File Z:\M122Projekt\Documents\scripts\log.txt -Append
Write $start

$row += $Klasse1
$row += $Klasse2
$array = $row |select -Unique

Set-Location C:\M122Projekt\Klassenordner

$get = Get-ChildItem -Filter *

foreach ($element in  $array){
    Set-Location C:\M122Projekt\Klassenordner
if ($element.Length -gt 0){
if ($get.name -eq $element){ 
$notice1 = "[{0}] [{1}] {2} existiert bereits" -f "8", $Date, $element
    Write $notice1 | Out-File Z:\M122Projekt\Documents\scripts\log.txt -Append
    echo $notice1
} else
{
New-Item -Name $element -Path C:\M122Projekt\Klassenordner\ -ItemType Directory | Out-Null
$notice2 = "[{0}] [{1}] {2} wurde erstellt" -f "9", $Date, $element
    Write $notice1 | Out-File Z:\M122Projekt\Documents\scripts\log.txt -Append
    echo $notice2
}
}else{
Start-Sleep -Seconds 0
}
}
}
6{
Clear-Host
Set-Location C:\M122Projekt\Klassenordner

Import-Module ActiveDirectory

$Date = Get-Date

$start = "[{0}] [{1}] Vorgang MASSRENFOLDER wurde gestartet." -f "0", $Date
Write $start | Out-File Z:\M122Projekt\Documents\scripts\log.txt -Append
Write $start

do{
Write-Host "Möchten Sie einen Ordner umbenennen? (Yes/No)"
$Weiter = Read-Host

if($weiter -eq "Yes"){
    Write-Host "Welchen Ordner möchtest du umbenennen?"
    $Input1 = Read-Host
    Write-Host "Zu welchen Namen möchtest du den Ordnernamen ändern?"
    $Input2 = Read-Host
    Rename-Item .\$Input1 .\$Input2 -Confirm:$false
    $notice1 = "[{0}] [{1}] {2} has been renamed to {3}." -f "10", $Date, $Input1, $Input2
    Add-Content -Path Z:\M122Projekt\Documents\scripts\disable-error.csv -Value "$Date | $SAM does not exist - Check Active Directory"
    Write $notice1 | Out-File Z:\M122Projekt\Documents\scripts\log.txt -Append
    echo $notice1
}else{
    Start-Sleep 1
}
}until ($weiter -eq "No")
}
7{
Clear-Host
Set-Location C:\M122Projekt\Homes

$Users = Import-Csv -Path C:\M122Projekt\schueler.csv -Delimiter ";"

$Date = Get-Date

$start = "[{0}] [{1}] Vorgang MASSCREHOME wurde gestartet." -f "0", $Date
Write $start | Out-File Z:\M122Projekt\Documents\scripts\log.txt -Append
Write $start


foreach($User in $Users){
$Username = $User.Benutzername.Replace('ä','ae').Replace('ö','oe').Replace('ü','ue').Replace('é','e').Replace('è','e')
$SAM = $Username
$Displayname = $Username
$Firstname = $User.Vorname
$Lastname = $User.Name
$OU = "OU=Users,OU=BZTF,DC=bztf,DC=ch"
$UPN = $Username + "@bztf.ch"
$get = Get-ChildItem -Filter *
$WHome = $Home + $SAM


if($get.name -eq $Username){
    $notice1 = "[{0}] [{1}] Der Home-Directory von {2} existiert bereits." -f "11", $Date, $Username
    Write $notice1 | Out-File Z:\M122Projekt\Documents\scripts\log.txt -Append
    echo $notice1
    
}else{
    New-Item -Name $SAM -ItemType Directory
    Set-ADUser -Identity $SAM -HomeDirectory C:\M122Projekt\Homes\$SAM -HomeDrive S 
    $notice2 = "[{0}] [{1}] Home-Directory von {2} wurde erstellt und im AD hinzugefügt." -f "12", $Date, $Username
    Write $notice2 | Out-File Z:\M122Projekt\Documents\scripts\log.txt -Append
    echo $notice2

}
}
}
8{
Clear-Host
Set-Location C:\M122Projekt\Homes

Import-Module ActiveDirectory

$Date = Get-Date

$start = "[{0}] [{1}] Vorgang MASSRENHOME wurde gestartet." -f "0", $Date
Write $start | Out-File Z:\M122Projekt\Documents\scripts\log.txt -Append
Write $start

do{
Write-Host "Möchten Sie einen Ordner umbenennen? (Yes/No)"
$Weiter = Read-Host

if($weiter -eq "Yes"){
    Write-Host "Welchen Ordner möchtest du umbenennen?"
    $Input1 = Read-Host
    Write-Host "Zu welchen Namen möchtest du den Ordnernamen ändern?"
    $Input2 = Read-Host
    Rename-Item .\$Input1 .\$Input2 -Confirm:$false
    $notice1 = "[{0}] [{1}] {2} has been renamed to {3}." -f "13", $Date, $Input1, $Input2
    Add-Content -Path Z:\M122Projekt\Documents\scripts\disable-error.csv -Value "$Date | $SAM does not exist - Check Active Directory"
    Write $notice1 | Out-File Z:\M122Projekt\Documents\scripts\log.txt -Append
    echo $notice1
}else{

}
}until ($weiter -eq "No")
}
9{
#clear log
Clear-Content -Path Z:\M122Projekt\Documents\scripts\log.txt

}

}
#else statement
}else{
#clear host
Clear-Host
#start sleep
Start-Sleep 0
}
#until statement
}until ($DOUNTIL -eq "No")