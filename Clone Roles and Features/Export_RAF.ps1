# --------------------------------------------------------------------------------------
# Script: Export_RAF.ps1
# Script Version: v1.0
# Author: Ingo Bechtle
# comments: Exports a list of Roles and Features from a Windows Server as *.XML
# --------------------------------------------------------------------------------------

Import-Module Servermanager
Get-WindowsFeature | ? { $_.Installed -AND $_.SubFeatures.Count -eq 0 } | Export-Clixml C:\Temp\RnF.xml