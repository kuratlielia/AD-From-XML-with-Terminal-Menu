###############################################################
#
# Scriptname:  Create_Accounts.ps1
#
# Autor:       Kuratli Elia , Etienne Ammann
# Date:        21.06.22
#
# Version:     2022.01 / 21.06.22 / Elia Kuratli
#                                 Script created
#
#  
# Description: Create AD Accounts from XML file
#
###############################################################

$Import = Import-Csv C:\temp\m122\Source\Schueler.csv -Delimiter ";" -Encoding UTF8

$UserPassword = "bztf.001"

foreach ($User in $Import) {

  $Username = $User.Benutzername.Replace('ä','ae').Replace('è','e').Replace('ü','ue').Replace('é','e').Replace('ö','oe')
  if($Username.Length -gt 30) {
    $Username = $Username.subString(0, 30)
  }
  $Firstname = $User.Vorname
  $Lastname = $User.Name
  $SAM = $Username
  $Displayname = $Username
  $OU = "OU=Lernende,OU=BZTF,DC=kuratli,DC=ch"
  $UPN = $Username + "@bztf.ch"
  $Password = (ConvertTo-SecureString $UserPassword -AsPlainText -Force)

  if (!(Get-ADUser -Filter "sAMAccountName -eq '$($SAM)'")) {

    New-ADUser -Surname "$Lastname" -AccountPassword $Password -Enabled $true -Path "$OU" -ChangePasswordAtLogon $false -PasswordNeverExpires $true -Name "$Displayname" -DisplayName "$Displayname" -SamAccountName "$SAM" -UserPrincipalName "$UPN" -GivenName "$Firstname" 
    Write-Host "Der User: $Displayname wurde erfolgreich erstellt"

  }else{

    Write-Host "Der User $Displayname existiert bereits"

  }
} 