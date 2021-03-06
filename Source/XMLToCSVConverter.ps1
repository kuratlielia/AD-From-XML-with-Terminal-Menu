###############################################################
#
# Scriptname:  XMLToCSVConverter.ps1
#
# Autor:       Kuratli Elia
# Date:        21.06.22
#
# Version:     2022.01 / 21.06.22 / Elia Kuratli
#                                 Script created
#
#  
# Description: Converts XML to CSV
#
###############################################################

# Input File
[xml]$inputFile = Get-Content "C:\temp\m122\Source\Schueler.xml"

# File wird in CSV Konvertiert
$inputFile.Objs.Obj.MS.S | ConvertTo-Csv -NoTypeInformation -Delimiter ";" | Set-Content "C:\temp\m122\Source\Sample.csv" -Encoding UTF8