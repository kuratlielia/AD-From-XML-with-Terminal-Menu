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

# Location wird gesetzt
Set-Location C:\temp\m122\Homes

# Do Schleife mit Eingaben
do{
    Write-Host "Wollen sie ein User Home umbennen? (Ja/Nein)"
    $69 = Read-Host
    # Wenn Eingabe Ja
    if($69 -eq "Ja"){
        Write-Host "Welches Home möchten Sie umbennen?"
        $187 = Read-Host
        Write-Host "Zu welchen Namen möchtest du den Ordnernamen ändern?"
        $420 = Read-Host
        Rename-Item .\$187 .\$420 -Confirm:$false
    }else{

}
# Wenn Eingabe Nein Do Schleife wird gestoppt
}until ($69 -eq "Nein")