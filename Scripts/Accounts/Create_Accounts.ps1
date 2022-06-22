###############################################################
#
# Scriptname:  Create_Accounts.ps1
#
# Autor:       Kuratli Elia
# Date:        21.06.22
#
# Version:     2022.01 / 21.06.22 / Elia Kuratli
#                                 Script created
#
#  
# Description: Create AD Accounts from XML file
#
###############################################################

Import-Module ActiveDirectory
Set-Location C:\temp\m122

$Users = Import-Csv -Delimiter ";" -Path ".\Source\Schueler.csv"

$password = "bztf.001"

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
  $OU = "OU=Users,OU=BZTF,DC=kuratli,DC=ch"
  $UPN = $Username + "@bztf.ch"
  $Password = (ConvertTo-SecureString $password -AsPlainText -Force)

  if (!(Get-ADUser -Filter "sAMAccountName -eq '$($SAM)'")) {
    New-ADUser -Name "$Displayname" -DisplayName "$Displayname" -SamAccountName "$SAM" -UserPrincipalName "$UPN" -GivenName "$Firstname" -Surname "$Lastname" -AccountPassword $Password -Enabled $true -Path "$OU" -ChangePasswordAtLogon $false -PasswordNeverExpires $true
    Write-Host "$Displayname wurde erstellt"

  }else{
    Write-Host "User $Displayname already exists"
  }

} 