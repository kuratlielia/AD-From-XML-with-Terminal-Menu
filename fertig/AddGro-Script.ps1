# Author: Noel & Fabio
# Datum: 09.01.2022
# Version: 1.0
# Funktionsbeschreibung: Add Members to Group
# Bemerkungen:
#-----

#Setze Location
Set-Location C:\M122Projekt

#import des csv
$csv = Import-Csv .\schueler.csv -Delimiter ";" -Encoding UTF8




#foreach statement
foreach($element in $csv){
    
    #variable username
    $Username = $element.Benutzername
    #if statement
    if($Username.Length -gt 20) {
    #username varaible
    $Username = $Username.subString(0, 20)
  }
    #klasse klasse variable
    $KlasseI = "BZTF_" + $element.Klasse
    #add adgroupmember
    Add-ADGroupMember -Identity $KlasseI -Members $Username


}