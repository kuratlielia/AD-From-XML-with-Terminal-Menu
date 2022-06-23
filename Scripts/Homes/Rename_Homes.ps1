###############################################################
#
# Scriptname:  Rename_Homes.ps1
#
# Autor:       Kuratli Elia
# Date:        21.06.22
#
# Version:     2022.01 / 21.06.22 / Elia Kuratli
#                                 Script created
#
#  
# Description: Script to rename the homes
#
###############################################################

Set-Location C:\temp\m122\Homes

do{
Write-Host "Möchten Sie einen Ordner umbenennen? (Ja/Nein)"
$Eingabe = Read-Host
if($Eingabe -eq "Yes"){
    Write-Host "Welchen Ordner möchtest du umbenennen?"
    $Eingabe1 = Read-Host
    Write-Host "Zu welchen Namen möchtest du den Ordnernamen ändern?"
    $Eingabe2 = Read-Host
    Rename-Item .\$Eingabe1 .\$Eingabe2 -Confirm:$false
}else{

}
}until ($weiter -eq "No")