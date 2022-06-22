###############################################################
#
# Scriptname:  Rename_Directory.ps1
#
# Autor:       Kuratli Elia
# Date:        21.06.22
#
# Version:     2022.01 / 21.06.22 / Elia Kuratli
#                                 Script created
#
#  
# Description: Rename created Directorys
#
###############################################################

Import-Module ActiveDirectory
Set-Location C:\M122Projekt\Klassenordner

do{
    Write-Host "Möchten Sie einen Ordner umbenennen? (Yes/No)"
    $Eingabe = Read-Host

    if($Eingabe -eq "Yes"){
    Write-Host "Welchen Ordner möchtest du umbenennen?"
    $Eingabe1 = Read-Host
    Write-Host "Zu welchen Namen möchtest du den Ordnernamen ändern?"
    $Eingabe2 = Read-Host
    Rename-Item .\$Eingabe1 .\$Eingabe2 -Confirm: $false

}else{
    Write-Host "Programm schliesst sich in den nächsten 2 Sekunden"
    Start-Sleep 2
}
}   until ($Eingabe -eq "No")