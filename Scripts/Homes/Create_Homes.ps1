###############################################################
#
# Scriptname:  Create_Homes.ps1
#
# Autor:       Kuratli Elia
# Date:        21.06.22
#
# Version:     2022.01 / 21.06.22 / Elia Kuratli
#                                 Script created
#
#  
# Description: Script to create the homes
#
###############################################################

Import-Module ActiveDirectory
Set-Location C:\temp\m122\Homes

$Users = Import-Csv .\Source\Schueler.csv -Delimiter ";"

foreach($User in $Users){
$Username = $User.Benutzername.Replace('ä','ae').Replace('ö','oe').Replace('ü','ue').Replace('é','e').Replace('è','e')
$SAM = $Username
$get = Get-ChildItem -Filter *

    if($get.name -eq $Username){

    } else {
        New-Item -Name $SAM -ItemType Directory
        Set-ADUser -Identity $SAM -HomeDirectory C:\temp\m122\Homes\$SAM -HomeDrive S 
    }
}