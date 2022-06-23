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

Set-Location C:\temp\m122\Homes

$Import = Import-Csv C:\temp\m122\Source\Schueler.csv -Delimiter ";" -Encoding UTF8

foreach($User in $Import){
$Username = $User.Benutzername.Replace('ä','ae').Replace('ö','oe').Replace('ü','ue').Replace('é','e').Replace('è','e')
$SAM = $Username
$get = Get-ChildItem -Filter *

    if($get.name -eq $Username){

    } else {
        New-Item -Name $SAM -ItemType Directory
        Set-ADUser -Identity $SAM -HomeDirectory C:\temp\m122\Homes\$SAM -HomeDrive S 
    }
}