# --------------------------------------------------------------------------------------
# Script: Delete_Databases.ps1
# Script Version: v1.0
# Author: Ingo Bechtle
# comments: Deletes MSSQL Databases 
# --------------------------------------------------------------------------------------

#Set Server name and database
$Server=".\SQLEXPRESS" 
$dbName= "DATABASENAME", "OTHERDATABASE"
       
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.SMO")
    $SMOserver = New-Object ('Microsoft.SqlServer.Management.Smo.Server') -Argumentlist $Server
    $SMOserver.Databases | select Name, Size,DataSpaceUsage, IndexSpaceUsage, SpaceAvailable

foreach($dbName in $SMOserver.Databases) 
{
do 
    if ($SMOserver.Databases[$dbName] -ne $null)  

        {  
        $SMOserver.Databases[$dbName].drop()  
        } 

  }