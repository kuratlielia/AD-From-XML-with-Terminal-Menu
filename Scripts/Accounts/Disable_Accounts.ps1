###############################################################
#
# Scriptname:  Disable_Accounts.ps1
#
# Autor:       Kuratli Elia
# Date:        21.06.22
#
# Version:     2022.01 / 21.06.22 / Elia Kuratli
#                                 Script created
#
#  
# Description: Disable AD Accounts that are not in the XML file
#
###############################################################

Import-Module ActiveDirectory
Set-Location C:\temp\m122

$getaduser = Get-ADUser -Filter *

$import = Import-Csv .\Source\Schueler.csv -Delimiter ";" -Encoding UTF8
$Username = $import.vorname

foreach ($User in $getaduser) {
$givenname = $user.givenname
if ($username -eq $givenname){ Start-Sleep -Seconds 0}
else{
if($user.name -eq "administrator"){

}
else{
Set-ADUser -Identity $user -Enabled $false
}

}
}