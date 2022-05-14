###############################################################
#
# Scriptname:  Citrix_Language_ML.ps1
#
# Autor:       Kuratli Elia
# Date:        09.05.22
#
# Version:     2022.01 / 09.05.22 / Elia Kuratli
#                                 Script created
#                                 Base structure, Menu, Variables
#
#              2022.02 / 10.05.22 / Elia Kuratli
#                                 Script created
#                                 Base structure, Menu, Variables
#
#  
#
# Description: Gives the user a guided menu to set the
#              UI/App language and the regional settings
#              Based on the several dedicated language scripts
#              The wizard is build with a MUI in DE/EN
#
###############################################################


# =============================================================================================================
# ==================================           FUNCTIONS              =========================================
# =============================================================================================================

#1# Function Set-MenuLanguage
# Defines the output variables either to English or German for the guided menu
Function Set-MenuLanguage {
    param (
        [string]$MenuLanguage
    )

    #$ML = @()

    # Prepare German text blocks
    If ($MenuLanguage -eq "D"){
        $ML01 = "Deutsch"
        $ML02 = "Funktionsauswahl"
        $ML03 = "Wähle deine Funktion"
        $ML04 = "Klassen Verzeichnisse"
        $ML05 = "Applikation schliessen"
        $ML06 = "Home Verzeichnisse Schüler"
        $ML07 = "Wähle deine Auswahl"
        $ML08 = "Ungültige Eingabe"
        $ML09 = "Wähle deine Auswahl"
        $ML10 = "Erstelle User Accounts"
        $ML11 = "Deaktiviere User Accounts"
        $ML12 = "AD Gruppen erstellen"
        $ML13 = "AD Gruppen löschen"
        $ML14 = "Klassen Verzeichnisse"
        $ML15 = "Klassen Verzeichnisse erstellen"
        $ML16 = "Klassen Verzeichnisse umbenennen"
        $ML17 = "Home Ordner"
        $ML18 = "Home Ordner erstellen"
        $ML19 = "Home Ordner umbenennen"
        $ML20 = ""
    }
    # Prepare English text blocks
    ElseIf ($MenuLanguage -eq "E"){
        $ML01 = "English"
        $ML02 = "Chose function"
        $ML03 = "What function you want to use?"
        $ML04 = "Class folders"
        $ML05 = "Close Menu"
        $ML06 = "Student Home folders"
        $ML07 = "Chose your selection"
        $ML08 = "Invalid Selection"
        $ML09 = "Chose one of the selections"
        $ML10 = "Create User Accounts"
        $ML11 = "Deactivate User accounts"
        $ML12 = "Create AD groups"
        $ML13 = "Delete AD groups"
        $ML14 = "Class Folders"
        $ML15 = "Create Class folders"
        $ML16 = "Rename Class folders"
        $ML17 = "Home Folders"
        $ML18 = "Create Home Folders"
        $ML19 = "Rename Home Folders"
        $ML20 = ""
    }
    Else {
        Write-Host "Something went wrong - unknown language"
    }
   

   # Configure all the variables with the correct text blocks
    Set-Variable -Name OutChosenLanguage -Value $ML01 -Scope global
    Set-Variable -Name StarterMenuTitle -Value $ML02 -Scope global   
    Set-Variable -Name StarterMenuText -Value $ML03 -Scope global   
    Set-Variable -Name ClassFolders -Value $ML04 -Scope global   
    Set-Variable -Name ExitMenu -Value $ML05 -Scope global   
    Set-Variable -Name HomeFolder -Value $ML06 -Scope global   
    Set-Variable -Name OutChooseSelection -Value $ML07 -Scope global   
    Set-Variable -Name OutInvalidSelection -Value $ML08 -Scope global   
    Set-Variable -Name ChoseOption -Value $ML09 -Scope global   
    Set-Variable -Name CreateAccounts -Value $ML10 -Scope global   
    Set-Variable -Name DeactivateAccounts -Value $ML11 -Scope global
    Set-Variable -Name CreateGroup -Value $ML12 -Scope global   
    Set-Variable -Name DeleteGroup -Value $ML13 -Scope global  
    Set-Variable -Name ClassFolderTitle -Value $ML14 -Scope global   
    Set-Variable -Name CreateClassFolder -Value $ML15 -Scope global   
    Set-Variable -Name RenameClassFolder -Value $ML16 -Scope global   
    Set-Variable -Name HomeFolderTitle -Value $ML17 -Scope global   
    Set-Variable -Name CreateHomeFolder -Value $ML18 -Scope global   
    Set-Variable -Name RenameHomeFolder -Value $ML19 -Scope global   
    Set-Variable -Name  -Value $ML20 -Scope global      

}

## Function Show-SelectorMenu
# Shows the main menu of the language selector
Function Show-StarterMenu {
    cls
    cls
    Write-Host " "
    Write-Host "**************************************************************************"
    Write-Host "                                                                         "
    Write-Host "            "$StarterMenuTitle"											 "
    Write-Host "                                                                         "
    Write-Host "            "$StarterMenuText"":"										 "
    Write-Host "                                                                         "
    Write-Host "                       [1] AD-Accounts									 "
    Write-Host "                       [2] AD-Groups									 "
    Write-Host "                       [3]"$ClassFolders"								 "
	Write-Host "                       [4]"$HomeFolder"									 "
    Write-Host "                                                                         "
    Write-Host "                       [X]"$ExitMenu"									 "
    Write-Host "                                                                         "
    Write-Host "**************************************************************************"
    
	$MenuSelection = Read-Host $OutChooseSelection

        # Plausibility check
        # If an option is selected, the variable will be set
        # If X is selected, the guide will end the function
        # If something else was entered, the UI selection starts again
        If ($MenuSelection -in 1..4) {
            $SelectedOption = "$MenuSelection"
        }
        ElseIf ($MenuSelection -eq "X") {
            End-LanguageSelection
        }
        Else {
            Write-Host " "
            Write-Host "$OutInvalidSelection"
            Start-Sleep -Seconds 1
            Show-SelectorMenu
        }
        # Open the selected option
        If ($SelectedOption -eq 1) {
            Choose-AD-Accounts
        }
        ElseIf ($SelectedOption -eq 2) {
           Choose-AD-Groups
        }
        ElseIf ($SelectedOption -eq 3) {
           Choose-ClassFolders
        }
		ElseIf ($SelectedOption -eq 4) {
           Choose-HomeFolder
        }
}

## Function Choose-SystemLanguage
# Shows the options to choose a language for the user interface (UI)
Function Choose-AD-Accounts {
    cls

    Write-Host " "
    Write-Host "**************************************************************************"
    Write-Host "                                                                         "
    Write-Host "             AD-Accounts"
    Write-Host "            "$ChoseOption ":"
    Write-Host "                                                                         "
    Write-Host "                       [1]"$CreateAccounts
    Write-Host "                       [2]"$DeactivateAccounts
    Write-Host "                                                                         "
    Write-Host "                       [X]"$ExitMenu
    Write-Host "                                                                         "
    Write-Host "**************************************************************************"
    $UISelection = Read-Host $OutChooseSelection

        # Plausibility check
        # If a language is selected, the variable will be set
        # If X is selected, the guide will end the function
        # If something else was entered, the UI selection starts again
        If ($UISelection -in 1..2) {
            If     ($UISelection -eq 1) {
                foreach ($User in $Users) {
					#variable für statement
					Test-ADUser -Username $User
  }
            }
            ElseIf ($UISelection -eq 2) {
                Deactivate-AD-Accounts           }
        }
        ElseIf ($UISelection -eq "X") {
            Return
        }
        Else {
            Write-Host " "
            Write-Host "$OutInvalidSelection"
            Start-Sleep -Seconds 1
            Choose-AD-Accounts
        }

}




## Function Choose-RegionalSettings
# Shows the options to choose the regional settings
Function Choose-AD-Groups {
    cls

    Write-Host " "
    Write-Host "**************************************************************************"
    Write-Host "                                                                         "
    Write-Host "            "AD-Groups
    Write-Host "            "$ChoseOption ":"
    Write-Host "                                                                         "
    Write-Host "                       [1]"$CreateGroup
    Write-Host "                       [2]"$DeleteGroup
    Write-Host "                                                                         "
    Write-Host "                       [X]"$ExitMenu
    Write-Host "                                                                         "
    Write-Host "**************************************************************************"
    $RegionSelection = Read-Host $OutChooseSelection

        # Plausibility check
        # If a language is selected, the variable will be set
        # If X is selected, the guide will end the function
        # If something else was entered, the UI selection starts again
        If ($RegionSelection -in 1..2) {
            If ($RegionSelection -eq 1) {

            }
            ElseIf ($RegionSelection -eq 2) {

            }
        }
        ElseIf ($RegionSelection -eq "X") {
            Return
        }
        Else {
            Write-Host " "
            Write-Host "$OutInvalidSelection"
            Start-Sleep -Seconds 1
            Choose-AD-Groups
        }

}

Function Choose-ClassFolders {
    cls

    Write-Host " "
    Write-Host "**************************************************************************"
    Write-Host "                                                                         "
    Write-Host "            "$ClassFolderTitle
    Write-Host "            "$ChoseOption ":"
    Write-Host "                                                                         "
    Write-Host "                       [1]"$CreateClassFolder
    Write-Host "                       [2]"$RenameClassFolder
    Write-Host "                                                                         "
    Write-Host "                       [X]"$ExitMenu
    Write-Host "                                                                         "
    Write-Host "**************************************************************************"
    $UISelection = Read-Host $OutChooseSelection

        # Plausibility check
        # If a language is selected, the variable will be set
        # If X is selected, the guide will end the function
        # If something else was entered, the UI selection starts again
        If ($UISelection -in 1..2) {
            If ($UISelection -eq 1) {
				
            }
            ElseIf ($UISelection -eq 2) {
				
            }
        }
        ElseIf ($UISelection -eq "X") {
            Return
        }
        Else {
            Write-Host " "
            Write-Host "$OutInvalidSelection"
            Start-Sleep -Seconds 1
            Choose-ClassFolders
        }

}

Function Choose-HomeFolder {

    cls

    Write-Host " "
    Write-Host "**************************************************************************"
    Write-Host "                                                                         "
    Write-Host "            "$HomeFolderTitle
    Write-Host "            "$ChoseOption ":"
    Write-Host "                                                                         "
    Write-Host "                       [1]"$CreateHomeFolder
    Write-Host "                       [2]"$RenameHomeFolder
    Write-Host "                                                                         "
    Write-Host "                       [X]"$ExitMenu
    Write-Host "                                                                         "
    Write-Host "**************************************************************************"
    $SetSelection = Read-Host $OutChooseSelection

        # Plausibility check
        # If a language is selected, the variable will be set
        # If X is selected, the guide will end the function
        # If something else was entered, the UI selection starts again
        If ($SetSelection -in 1..2) {
            If ($SetSelection -eq 1) {
				
            }
            ElseIf ($SetSelection -eq 2) {
				
            }
        }
        ElseIf ($SetSelection -eq "X") {
            Return
        }
        Else {
            Write-Host " "
            Write-Host "$OutInvalidSelection"
            Start-Sleep -Seconds 1
            Choose-ClassFolders
        }

}

## Function End-LanguageSelection
# Exit the language selection guide after a message and a specific waiting time
Function End-LanguageSelection {
    Write-Host " "
    Write-Host " "
    Write-Host "**************************************************************************"
    Write-Host "*                                                                        *"
    Write-Host "*          Beende die Sprachauswahl / Exit the language selection        *"
    Write-Host "*                                                                        *"
    Write-Host "**************************************************************************"
    Start-Sleep -Seconds 2
    Exit
}


# =============================================================================================================
# ==================================          MAIN SCRIPT             =========================================
# =============================================================================================================


Set-Location C:\temp\m122

Import-Module ActiveDirectory

$Users = Import-Csv -Delimiter ";" -Path ".\schueler.csv"

cls

    Write-Host " "
    Write-Host "*************************************************************************"
    Write-Host "                                                                         "
    Write-Host "                 Menu Language / Menü Sprache                            "
    Write-Host "                                                                         "
    Write-Host "            Available Languages / verfügbare Sprache                     "
    Write-Host "                                                                         "
    Write-Host "                       [D] Deutsch                                       "
    Write-Host "                       [E] English (default)                             "
    Write-Host "                                                                         "
    Write-Host "                       [X] Exit / Verlassen                              "
    Write-Host "                                                                         "
    Write-Host "                                                                         "  
    Write-Host "                                                                         "
    Write-Host "*************************************************************************"
    $Selection = Read-Host "Wähle die Sprache / Choose the language"

    If (($Selection -eq "D") -or ($Selection -eq "E")) {
        Set-MenuLanguage $Selection
    }
    ElseIf ($Selection -eq "X") {
        End-LanguageSelection
    }
    Else {
        Write-Host "unknown selection - English will be set as language"
        $Selection = "E"
        Set-MenuLanguage $Selection
    }

    Write-Host " "
    Write-Host $OutChosenLanguage     # Show the selection of the guidance languange
    Start-Sleep -Seconds 1

Do {

    if ($exitApplication) {
        exit
    }

    Show-StarterMenu

    }
While($true)


