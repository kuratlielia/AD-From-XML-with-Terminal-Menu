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

$Import = Import-Csv C:\temp\m122\Source\Schueler.csv -Delimiter ";" -Encoding UTF8

$password = "bztf.001"

function Test-ADUser {
    param(
        [Parameter(Mandatory = $true)]
        [string] $SAM
    )
    $null -ne ([ADSISearcher] "(sAMAccountName=$SAM)").FindOne()
}

foreach ($User in $Import) {
  $Username = $User.Benutzername.Replace('ä','ae').Replace('ö','oe').Replace('ü','ue').Replace('é','e').Replace('è','e')
  if($Username.Length -gt 20) {
    $Username = $Username.subString(0, 20)
  }
  $SAM = $Username
  $Displayname = $Username
  $Firstname = $User.Vorname
  $Lastname = $User.Name
  $OU = "OU=Lernende,OU=BZTF,DC=kuratli,DC=ch"
  $UPN = $Username + "@bztf.ch"
  $Password = (ConvertTo-SecureString $password -AsPlainText -Force)

  if (!(Get-ADUser -Filter "sAMAccountName -eq '$($SAM)'")) {
    New-ADUser -Name "$Displayname" -DisplayName "$Displayname" -SamAccountName "$SAM" -UserPrincipalName "$UPN" -GivenName "$Firstname" -Surname "$Lastname" -AccountPassword $Password -Enabled $true -Path "$OU" -ChangePasswordAtLogon $false -PasswordNeverExpires $true
    Write-Host "$Displayname wurde erstellt"

  }else{
    Write-Host "User $Displayname already exists"
  }

} 