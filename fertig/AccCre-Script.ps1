# Author: Noel & Fabio
# Datum: 26.12.2021
# Version: 1.0
# Funktionsbeschreibung: Create Ad Accs
# Bemerkungen:
#-----
#Setze Location
Set-Location C:\M122Projekt

#import ad modul
Import-Module ActiveDirectory

#import csv variable
$Users = Import-Csv -Delimiter ";" -Path ".\schueler.csv"

#password variable
$bztfpassword = "bztf.001"

#variable für get-date
$Date = Get-Date

#start vorgang & log
$start = "[{0}] [{1}] Vorgang MASSUSER wurde gestartet." -f "0", $Date
Write $start | Out-File Z:\M122Projekt\Documents\scripts\log.txt -Append

#function Test-ADUser
function Test-ADUser {
    param(
        [Parameter(Mandatory = $true)]
        [string] $SAM
    )
    $null -ne ([ADSISearcher] "(sAMAccountName=$SAM)").FindOne()
}

#foreach statement
foreach ($User in $Users) {
  #variable für statement
  $Username = $User.Benutzername.Replace('ä','ae').Replace('ö','oe').Replace('ü','ue').Replace('é','e').Replace('è','e')
  #if statement
  if($Username.Length -gt 20) {
  #varialbe für username
    $Username = $Username.subString(0, 20)
  }
  #sam variable
  $SAM = $Username
  #display variable
  $Displayname = $Username
  #firstname variable
  $Firstname = $User.Vorname
  #lastname variable
  $Lastname = $User.Name
  #OU Variable
  $OU = "OU=Users,OU=BZTF,DC=bztf,DC=ch"
  #upn variable
  $UPN = $Username + "@bztf.ch"
  #password variable
  $Password = (ConvertTo-SecureString $bztfpassword -AsPlainText -Force)
  #variable für get-date
  $Date = Get-Date

  #if statement
  if (!(Get-ADUser -Filter "sAMAccountName -eq '$($SAM)'")) {
  #new-aduser
    New-ADUser -Name "$Displayname" -DisplayName "$Displayname" -SamAccountName "$SAM" -UserPrincipalName "$UPN" -GivenName "$Firstname" -Surname "$Lastname" -AccountPassword $Password -Enabled $true -Path "$OU" -ChangePasswordAtLogon $false -PasswordNeverExpires $true
    #notice & log
    $notice1 = "[{0}] [{1}] {2} wurde erstellt." -f "1", $Date, $SAM
    Write $notice1 | Out-File Z:\M122Projekt\Documents\scripts\log.txt -Append
    echo $notice1
  #if statement
  }else{
  #notice & log
  $notice2 = "[{0}] [{1}] {2} existiert bereits!" -f "2", $Date, $SAM
  Write $notice2 | Out-File Z:\M122Projekt\Documents\scripts\log.txt -Append
  echo $notice2
  #add content
  Add-Content -Path Z:\M122Projekt\Documents\scripts\duplicate.csv -Value "$SAM already exists, Please check User-Information"

  }

} 