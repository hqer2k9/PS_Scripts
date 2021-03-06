# --------------------------------------------------------------------------------------
# Script: Databases_and_Sizes.ps1
# Script Version: v1.0
# Author: Ingo Bechtle
# comments: Simple script for selecting databases and their sizes
# --------------------------------------------------------------------------------------

[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.SMO') | out-null
$s = New-Object ('Microsoft.SqlServer.Management.Smo.Server') ".\SQLEXPRESS"
$dbs=$s.Databases
$dbs | SELECT Name, Size
Write-Host ""
[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.SMO') | out-null
$s = New-Object ('Microsoft.SqlServer.Management.Smo.Server') "DBServer"
$dbs=$s.Databases
$dbs | SELECT Name, Size