###############################################################
#
# Scriptname:  Create_Homes.ps1
#
# Autor:       Kuratli Elia, Etienne Ammann
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

# Immport CSV
$Import = Import-Csv C:\temp\m122\Source\Schueler.csv -Delimiter ";" -Encoding UTF8

foreach($User in $Import){
$Username = $User.Benutzername.Replace('é','e').Replace('è','e').Replace('ü','ue').Replace('ä','ae').Replace('ö','oe')
$SAM = $Username
# Alle Ordner werden ausgelesen
$get = Get-ChildItem -Filter *

    # Wenn der Ordner bereits existiert passiert nichts
    if($get.name -eq $Username){

    } else {
        # User Home Ordner wird erstellt
        New-Item -Name $SAM -ItemType Directory
        # User Home wird gesetzt
        Set-ADUser -Identity $SAM -HomeDirectory C:\temp\m122\Homes\$SAM -HomeDrive S 
    }
}