###############################################################
#
# Scriptname:  Rename_Directory.ps1
#
# Autor:       Kuratli Elia, Etiennson Ammann
# Date:        21.06.22
#
# Version:     2022.01 / 21.06.22 / Elia Kuratli
#                                 Script created
#
#  
# Description: Rename created Directorys
#
###############################################################

# Location wird gesetzt
Set-Location C:\temp\m122\Klassenordner

# do schlaufe mit Eingaben
do{
    Write-Host "Wollen sie einen Ordner umbennen (Ja/Nein)"
    $FiveHead = Read-Host

    if($FiveHead -eq "Ja"){
        Write-Host "Wie heisst der Ordner denn du umbennen willst?"
        $FiveHead1 = Read-Host
        Write-Host "Wie soll der neue Name des Ordners lauten?"
        $FiveHead2 = Read-Host
        Rename-Item .\$Fivehead1 .\$Fivehead2 -Confirm: $false
    }else{
        Write-Host "Hallo User, du wirst zurückgeleitet in 2 Sekunden"
        Start-Sleep 2
    }
}   until ($Eingabe -eq "Nein")