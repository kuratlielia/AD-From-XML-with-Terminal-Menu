###############################################################
#
# Scriptname:  Citrix_Language_ML.ps1
#
# Autor:       Kuratli Elia
# Date:        09.05.22
#
# Version:     2022.01 / 09.05.22 / elia kuratli
#                                 Script created
#                                 Base structure, MUI variables, selector menus
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
        $ML02 = ""
        $ML03 = ""
        $ML04 = ""
        $ML05 = ""
        $ML06 = ""
        $ML07 = ""
        $ML08 = ""
        $ML09 = ""
        $ML10 = ""
        $ML11 = ""
        $ML12 = ""
        $ML13 = ""
        $ML14 = ""
        $ML15 = ""
        $ML16 = ""
        $ML17 = ""
        $ML18 = ""
        $ML19 = ""
        $ML20 = ""
    }
    # Prepare English text blocks
    ElseIf ($MenuLanguage -eq "E"){
        $ML01 = "English"
        $ML02 = ""
        $ML03 = ""
        $ML04 = ""
        $ML05 = ""
        $ML06 = ""
        $ML07 = ""
        $ML08 = ""
        $ML09 = ""
        $ML10 = ""
        $ML11 = ""
        $ML12 = ""
        $ML13 = ""
        $ML14 = ""
        $ML15 = ""
        $ML16 = ""
        $ML17 = ""
        $ML18 = ""
        $ML19 = ""
        $ML20 = ""
    }
    Else {
        Write-Host "Something went wrong - unknown language"
    }
   

   # Configure all the variables with the correct text blocks
    Set-Variable -Name OutChosenLanguage -Value $ML01 -Scope global
    Set-Variable -Name  -Value $ML02 -Scope global   
    Set-Variable -Name  -Value $ML03 -Scope global   
    Set-Variable -Name  -Value $ML04 -Scope global   
    Set-Variable -Name  -Value $ML05 -Scope global   
    Set-Variable -Name  -Value $ML06 -Scope global   
    Set-Variable -Name  -Value $ML07 -Scope global   
    Set-Variable -Name  -Value $ML08 -Scope global   
    Set-Variable -Name  -Value $ML09 -Scope global   
    Set-Variable -Name  -Value $ML10 -Scope global   
    Set-Variable -Name  -Value $ML11 -Scope global
    Set-Variable -Name  -Value $ML12 -Scope global   
    Set-Variable -Name  -Value $ML13 -Scope global   
    Set-Variable -Name  -Value $ML14 -Scope global   
    Set-Variable -Name  -Value $ML15 -Scope global   
    Set-Variable -Name  -Value $ML16 -Scope global   
    Set-Variable -Name  -Value $ML17 -Scope global   
    Set-Variable -Name  -Value $ML18 -Scope global   
    Set-Variable -Name  -Value $ML19 -Scope global   
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
    Write-Host "            "$
    Write-Host "                                                                         "
    Write-Host "            "$":"
    Write-Host "                                                                         "
    Write-Host "                       [1]"$
    Write-Host "                       [2]"$
    Write-Host "                       [3]"$
    Write-Host "                                                                         "
    Write-Host "                       [S]"$
    Write-Host "                                                                         "
    Write-Host "                       [X]"$
    Write-Host "                                                                         "
    Write-Host "**************************************************************************"
    $MenuSelection = Read-Host $OutChooseSelection

        # Plausibility check
        # If an option is selected, the variable will be set
        # If X is selected, the guide will end the function
        # If something else was entered, the UI selection starts again
        If ($MenuSelection -in 1..3) {
            $SelectedOption = "$MenuSelection"
        }
        ElseIf ($MenuSelection -eq "S") {
            Set-LanguageSelection
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
            Choose-SystemLanguage
        }
        ElseIf ($SelectedOption -eq 2) {
           Choose-RegionalSettings
        }
        ElseIf ($SelectedOption -eq 3) {
           Choose-AppLanguage
        }
}

## Function Choose-SystemLanguage
# Shows the options to choose a language for the user interface (UI)
Function Choose-SystemLanguage {
    cls

    Write-Host " "
    Write-Host "**************************************************************************"
    Write-Host "                                                                         "
    Write-Host "            "$OutTitelSystemLanguage
    Write-Host "            "$OutAvailableSystemLanguages ":"
    Write-Host "                                                                         "
    Write-Host "                       [1]"$OutLangDECH
    Write-Host "                       [2]"$OutLangDEDE
    Write-Host "                       [3]"$OutLangENUS
    Write-Host "                       [4]"$OutLangENUK
    Write-Host "                       [5]"$OutLangCHFR
    Write-Host "                       [6]"$OutLangFRFR
    Write-Host "                       [7]"$OutLangITIT
    Write-Host "                       [8]"$OutLangPLPL
    Write-Host "                       [9]"$OutLangRURU
    Write-Host "                       [10]"$OutLangESES
    Write-Host "                       [11]"$OutLangHUHU
    Write-Host "                                                                         "
    Write-Host "                       [X]"$OutExitSystemLanguageSelector
    Write-Host "                                                                         "
    Write-Host "**************************************************************************"
    $UISelection = Read-Host $OutChooseSystemLanguage

        # Plausibility check
        # If a language is selected, the variable will be set
        # If X is selected, the guide will end the function
        # If something else was entered, the UI selection starts again
        If ($UISelection -in 1..11) {
            If     ($UISelection -eq 1) {
                Set-Variable -Name UILanguage -Value "de-CH" -Scope global
            }
            ElseIf ($UISelection -eq 2) {
                Set-Variable -Name UILanguage -Value "de-DE" -Scope global
            }
            ElseIf ($UISelection -eq 3) {
                Set-Variable -Name UILanguage -Value "en-US" -Scope global
            }
            ElseIf ($UISelection -eq 4) {
                Set-Variable -Name UILanguage -Value "en-GB" -Scope global
            }
            ElseIf ($UISelection -eq 5) {
                Set-Variable -Name UILanguage -Value "fr-FR" -Scope global
            }
            ElseIf ($UISelection -eq 6) {
                Set-Variable -Name UILanguage -Value "fr-CH" -Scope global
            }
            ElseIf ($UISelection -eq 7) {
                Set-Variable -Name UILanguage -Value "it-IT" -Scope global
            }
            ElseIf ($UISelection -eq 8) {
                Set-Variable -Name UILanguage -Value "pl-PL" -Scope global
            }
            ElseIf ($UISelection -eq 9) {
                Set-Variable -Name UILanguage -Value "ru-RU" -Scope global
            }
            ElseIf ($UISelection -eq 10) {
                Set-Variable -Name UILanguage -Value "es-ES" -Scope global
            }
            ElseIf ($UISelection -eq 11) {
                Set-Variable -Name UILanguage -Value "hu-HU" -Scope global
            }
        }
        ElseIf ($UISelection -eq "X") {
            #Show-SelectorMenu
            Return
        }
        Else {
            Write-Host " "
            Write-Host "$OutInvalidSelection"
            Start-Sleep -Seconds 1
            Choose-SystemLanguage
        }

}


## Function Choose-RegionalSettings
# Shows the options to choose the regional settings
Function Choose-RegionalSettings {
    cls

    Write-Host " "
    Write-Host "**************************************************************************"
    Write-Host "                                                                         "
    Write-Host "            "$OutTitelRegionalSettings
    Write-Host "            "$OutAvailableRegionalSettings ":"
    Write-Host "                                                                         "
    Write-Host "                       [1]"$OutLangDECH
    Write-Host "                       [2]"$OutLangDEDE
    Write-Host "                       [3]"$OutLangENUS
    Write-Host "                       [4]"$OutLangENUK
    Write-Host "                       [5]"$OutLangARDZ
    Write-Host "                       [6]"$OutLangDADK
    Write-Host "                       [7]"$OutLangCHFR
    Write-Host "                       [8]"$OutLangFRFR
    Write-Host "                       [9]"$OutLangITIT
    Write-Host "                       [10]"$OutLangNLNL
    Write-Host "                       [11]"$OutLangNNNO
    Write-Host "                       [12]"$OutLangPLPL
    Write-Host "                       [13]"$OutLangRURU
    Write-Host "                       [14]"$OutLangSVSE
    Write-Host "                       [15]"$OutLangESES
    Write-Host "                       [16]"$OutLangCSCZ
    Write-Host "                       [17]"$OutLangHUHU
    Write-Host "                                                                         "
    Write-Host "                       [X]"$OutExitRegionalSettings
    Write-Host "                                                                         "
    Write-Host "**************************************************************************"
    $RegionSelection = Read-Host $OutChooseRegionalSetting

        # Plausibility check
        # If a language is selected, the variable will be set
        # If X is selected, the guide will end the function
        # If something else was entered, the UI selection starts again
        If ($RegionSelection -in 1..16) {
            If ($RegionSelection -eq 1) {
                Set-Variable -Name RegionSetCulture -Value "de-CH" -Scope global
                Set-Variable -Name RegionSetGeoID -Value "223" -Scope global
            }
            ElseIf ($RegionSelection -eq 2) {
                Set-Variable -Name RegionSetCulture -Value "de-DE" -Scope global
                Set-Variable -Name RegionSetGeoID -Value "94" -Scope global
            }
            ElseIf ($RegionSelection -eq 3) {
                Set-Variable -Name RegionSetCulture -Value "en-US" -Scope global
                Set-Variable -Name RegionSetGeoID -Value "244" -Scope global
            }
            ElseIf ($RegionSelection -eq 4) {
                Set-Variable -Name RegionSetCulture -Value "en-GB" -Scope global
                Set-Variable -Name RegionSetGeoID -Value "242" -Scope global
            }
            ElseIf ($RegionSelection -eq 5) {
                Set-Variable -Name RegionSetCulture -Value "ar-DZ" -Scope global
                Set-Variable -Name RegionSetGeoID -Value "4" -Scope global
            }
            ElseIf ($RegionSelection -eq 6) {
                Set-Variable -Name RegionSetCulture -Value "da-DK" -Scope global
                Set-Variable -Name RegionSetGeoID -Value "61" -Scope global
            }
            ElseIf ($RegionSelection -eq 7) {
                Set-Variable -Name RegionSetCulture -Value "fr-CH" -Scope global
                Set-Variable -Name RegionSetGeoID -Value "223" -Scope global
            }
            ElseIf ($RegionSelection -eq 8) {
                Set-Variable -Name RegionSetCulture -Value "fr-FR" -Scope global
                Set-Variable -Name RegionSetGeoID -Value "84" -Scope global
            }
            ElseIf ($RegionSelection -eq 9) {
                Set-Variable -Name RegionSetCulture -Value "it-IT" -Scope global
                Set-Variable -Name RegionSetGeoID -Value "118" -Scope global
            }
            ElseIf ($RegionSelection -eq 10) {
                Set-Variable -Name RegionSetCulture -Value "nl-NL" -Scope global
                Set-Variable -Name RegionSetGeoID -Value "176" -Scope global
            }
            ElseIf ($RegionSelection -eq 11) {
                Set-Variable -Name RegionSetCulture -Value "nn-NO" -Scope global
                Set-Variable -Name RegionSetGeoID -Value "177" -Scope global
            }
            ElseIf ($RegionSelection -eq 12) {
                Set-Variable -Name RegionSetCulture -Value "pl-PL" -Scope global
                Set-Variable -Name RegionSetGeoID -Value "191" -Scope global
            }
            ElseIf ($RegionSelection -eq 13) {
                Set-Variable -Name RegionSetCulture -Value "ru-RU" -Scope global
                Set-Variable -Name RegionSetGeoID -Value "203" -Scope global
            }
            ElseIf ($RegionSelection -eq 14) {
                Set-Variable -Name RegionSetCulture -Value "sv-SE" -Scope global
                Set-Variable -Name RegionSetGeoID -Value "221" -Scope global
            }
            ElseIf ($RegionSelection -eq 15) {
                Set-Variable -Name RegionSetCulture -Value "es-ES" -Scope global
                Set-Variable -Name RegionSetGeoID -Value "217" -Scope global
            }
            ElseIf ($RegionSelection -eq 16) {
                Set-Variable -Name RegionSetCulture -Value "cs-CZ" -Scope global
                Set-Variable -Name RegionSetGeoID -Value "75" -Scope global
            }
            ElseIf ($RegionSelection -eq 17) {
                Set-Variable -Name RegionSetCulture -Value "hu-HU" -Scope global
                Set-Variable -Name RegionSetGeoID -Value "109" -Scope global
            }
            #$Region = "$RegionSelection"
        }
        ElseIf ($RegionSelection -eq "X") {
            #Show-SelectorMenu
            Return
        }
        Else {
            Write-Host " "
            Write-Host "$OutInvalidSelection"
            Start-Sleep -Seconds 1
            Choose-RegionalSettings
        }

        #Set-Variable -Name RegionSet -Value $Region -Scope global

}


## Function Choose-AppLanguage
# Shows the options to choose a language for the applications (UI)
Function Choose-AppLanguage {
    cls

    Write-Host " "
    Write-Host "*************************************************************************"
    Write-Host "                                                                         "
    Write-Host "                 Menu Language / Menü Sprache                            "
    Write-Host "                                                                         "
    Write-Host "            Available Languages / verfügbare Sprache                     "
    Write-Host "                                                                         "
    Write-Host "                       [1] Deutsch                                       "
    Write-Host "                       [2] English                                       "
    Write-Host "                                                                         "
    Write-Host "                       [X] Verlassen / Exit                              "
    Write-Host "                                                                         "
    Write-Host "                                                                         "  
    Write-Host "                                                                         "
    Write-Host "*************************************************************************"
    $AppUISelection = Read-Host $OutChooseAppLanguage

        # Plausibility check
        # If a language is selected, the variable will be set
        # If X is selected, the guide will end the function
        # If something else was entered, the UI selection starts again
        If ($AppUISelection -in 1..2) {
            If ($AppUISelection -eq 1) {
                Set-Variable -Name AppLanguage -Value "DE" -Scope global
                Set-Variable -Name AppLanguageNumber -Value 49 -Scope global
            }
            ElseIf ($AppUISelection -eq 2) {
                Set-Variable -Name AppLanguage -Value "EN" -Scope global
                Set-Variable -Name AppLanguageNumber -Value 44 -Scope global
            }
        }
        ElseIf ($AppUISelection -eq "X") {
            #Show-SelectorMenu
            Return
        }
        Else {
            Write-Host " "
            Write-Host "$OutInvalidSelection"
            Start-Sleep -Seconds 1
            Choose-AppLanguage
        }

}

## Function Set-LanguageSelection
# Set all the choosen settings and log off the user from the session to save the settings
Function Set-LanguageSelection {

    cls

    Write-Host " "
    Write-Host "**************************************************************************"
    Write-Host "                                                                         "
    Write-Host "            "$OutTitleSetSelection
    Write-Host "            "$OutSelectionOutput ":"
    Write-Host "                " $OutSelectSystemLanguage "= " $UILanguage
    Write-Host "                " $OutSelectRegionalSettings " = " $RegionSetCulture
    Write-Host "                " $OutSelectAppLanguage " = " $AppLanguage
    Write-Host "                                                                         "
    Write-Host "                       [S]"$OutSelectionSetLogoff
    Write-Host "                                                                         "
    Write-Host "                       [X]"$OutSelectionCancel
    Write-Host "                                                                         "
    Write-Host "**************************************************************************"
    $SetSelection = Read-Host $OutChooseSetSelection

        # Plausibility check
        # If a language is selected, the variable will be set
        # If X is selected, the guide will end the function
        # If something else was entered, the UI selection starts again
        If ($SetSelection -eq "S") {
            if ($RegionSetCulture) {
                Set-Culture $RegionSetCulture #Set Culture  
            }
            if ($regionSetGeoID) {
                Set-WinHomeLocation -GeoId $regionSetGeoID # Set Home Location
            }
            if ($UILanguage) {
                Set-WinUserLanguageList $UILanguage -force # Set Language
            }
            
            Add-Type -AssemblyName System.Windows.Forms
            Set-Variable -Name exitApplication -Value "exit" -Scope global


            if (Test-Path env:LM_LICENSE_FILE) # Change E3 Language
                {
                    if (Test-Path "HKCU:\Software\Zuken")
                    {
                        $regPath = “HKCU:\Software\Zuken\E3.Series\21.0”
                        $Name = “Language”
                        $value = "$AppLanguageNumber"

                        New-ItemProperty -Path $regPath -Name $name -Value $value -PropertyType String -Force | Out-Null
                    }

                    if (Test-Path "HKCU:\Software\Zuken")
                    {
                        $regPath1 = “HKCU:\Software\Zuken\E3.CopyDatabaseEntries\21.0”
                        $Name1 = “Language”
                        $value1 = "$AppLanguageNumber"

                        if (-Not (Test-Path $regPath1))
                        {
                            New-Item -Path $regPath1 -Force | Out-Null
                        }
                        New-ItemProperty -Path $regPath1 -Name $name1 -Value $value1 -PropertyType String -Force | Out-Null
                    }

                    if (Test-Path "HKCU:\Software\Zuken")
                    {
                        $regPath2 = “HKCU:\Software\Zuken\E3.UpdateSubCircuits\13.0”
                        $Name2 = “Language”
                        $value2 = "$AppLanguageNumber"

 
                        if (-Not (Test-Path $regPath2))
                        {
                            New-Item -Path $regPath2 -Force | Out-Null
                        }
                        New-ItemProperty -Path $regPath2 -Name $name2 -Value $value2 -PropertyType String -Force | Out-Null
                    }            
                }                

            #   logoff user session
            Write-Host " "
            Read-Host "$OutLastConformation"
            Shutdown -l
            

        }
        ElseIf ($SetSelection -eq "X") {
            #Show-SelectorMenu
            Return
        }
        Else {
            Write-Host " "
            Write-Host "$OutInvalidSelection"
            Start-Sleep -Seconds 5
            Set-LanguageSelection
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


