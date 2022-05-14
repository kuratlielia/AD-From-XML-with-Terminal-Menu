# Author: Noel & Fabio
# Datum: 04.01.2022
# Version: 1.0
# Funktionsbeschreibung: Erstellen von Home Directory
# Bemerkungen:
#-----
#Setze Location
Set-Location C:\M122Projekt\Homes

#variable user
$Users = Import-Csv -Path C:\M122Projekt\schueler.csv -Delimiter ";"

#variable für get-date
$Date = Get-Date

#start vorgang und log
$start = "[{0}] [{1}] Vorgang CREHOME wurde gestartet." -f "0", $Date
Write $start | Out-File Z:\M122Projekt\Documents\scripts\log.txt -Append
Write $start

#foreach statement
foreach($User in $Users){
#username varible
$Username = $User.Benutzername.Replace('ä','ae').Replace('ö','oe').Replace('ü','ue').Replace('é','e').Replace('è','e')
#SAM variable
$SAM = $Username
#displayname variable
$Displayname = $Username
#firstname variable
$Firstname = $User.Vorname
#lastname variable
$Lastname = $User.Name
#ou variable
$OU = "OU=Users,OU=BZTF,DC=bztf,DC=ch"
#upn variable
$UPN = $Username + "@bztf.ch"
#variable für get-childitem
$get = Get-ChildItem -Filter *
#varaible für zusammensetzung
$WHome = $Home + $SAM

#if statement
if($get.name -eq $Username){
    #ntoice & log
    $notice1 = "[{0}] [{1}] Der Home-Directory von {2} existiert bereits." -f "11", $Date, $Username
    Write $notice1 | Out-File Z:\M122Projekt\Documents\scripts\log.txt -Append
    echo $notice1
    #else statement
}else{
    #new item
    New-Item -Name $SAM -ItemType Directory
    #set-aduser
    Set-ADUser -Identity $SAM -HomeDirectory C:\M122Projekt\Homes\$SAM -HomeDrive S 
    #notice & log
    $notice2 = "[{0}] [{1}] Home-Directory von {2} wurde erstellt und im AD hinzugefügt." -f "12", $Date, $Username
    Write $notice2 | Out-File Z:\M122Projekt\Documents\scripts\log.txt -Append
    echo $notice2

}
}