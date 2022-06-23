###############################################################
#
# Scriptname:  Disable_Accounts.ps1
#
# Autor:       Kuratli Elia, Etiennsone Ammann
# Date:        21.06.22
#
# Version:     2022.01 / 21.06.22 / Elia Kuratli
#                                 Script created
#
#  
# Description: Disable AD Accounts that are not in the XML file
#
###############################################################

# Alle User werden in Variabel gespeichert
$AlleUser = Get-ADUser -Filter *

# CSV wird importiert
$Import = Import-Csv C:\temp\m122\Source\Schueler.csv -Delimiter ";" -Encoding UTF8

$Username = $Import.vorname

foreach ($User in $AlleUser) {

# Wenn User nicht im Excel File = deaktiveren
$givenname = $user.givenname
if ($username -eq $givenname){
        Start-Sleep -Seconds 0
    } else {
        # Wenn User =  Administrator = ignorieren
        if($user.name -eq "administrator"){

        } else {
            Set-ADUser -Identity $user -Enabled $false
            Write-Host "$user wurde deaktiviert"
        }
}
}