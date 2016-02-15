# --------------------------------------------------------------------------------------
# Script: Import_RAF.ps1
# Script Version: v1.0
# Author: Ingo Bechtle
# comments: Imports the *.XML List and installs all Roles and Features that are listed
# --------------------------------------------------------------------------------------

Import-Module Servermanager
Import-Clixml C:\Temp\RnF.xml | Add-WindowsFeature