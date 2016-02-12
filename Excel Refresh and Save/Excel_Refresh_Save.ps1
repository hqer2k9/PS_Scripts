# --------------------------------------------------------------------------------------
# Script: Excel_Refresh_Save.ps1
# Script Version: v1.0
# Author: Ingo Bechtle
# comments: Opens a Excel File, Refreshes the data, saves it and closes process
# --------------------------------------------------------------------------------------

get-date

#Script will stop if an error occurs, has to be in the first line
$ErrorActionPreference = "Stop"

#Set com object for Excel, silent
$ExcelApp = new-object -ComObject Excel.Application
$ExcelApp.Visible = $false
$ExcelApp.DisplayAlerts = $false

#preparations
$filter = "*.xlsx"
$path = "C:\temp\" #<<<<<<<<<<<<<<<<<<<<<<<<<< SET FOLDER PATH FIRST!!!!!

#"-Recurse" includes sub-directorys, delete to exclude (place after $path if needed)
#Errors may occur due to lack of access rights while filtering for files you are not eligible
#Having all files in 1 main directory is the cleanest way
$files = gci $path -filter $filter

#Set (reset) $status to prevent false write protect alarm
$status = $true

#Check if a file is write protected, if so goto else and stop, no files will be updated
foreach($file in $files)
{
	if($status -eq $true)
	{
		if($file.IsReadOnly -eq $true)
		{
			$status = $false		
		}
	}	
}

#Files are not write protected? files will be updated
if($status -eq $true)
{
	Write-Host ""
	Write-Host "Following files are being updated"
	Write-Host "##########################################"
 	foreach ($file in $files)
	{
		Write-Host $file
	    $Workbook = $ExcelApp.Workbooks.Open($file.DirectoryName + "\" + $file.Name)
	    $Workbook.RefreshAll()
	    $Workbook.Save()
	}
	Write-Host "##########################################"
}

#If a file is write protected, script will stop and save message to error log
else
{
	write-host ("An error has occured: One or more files are write protected!")
	"One or more files are write protected! No files where updated! " +(Get-Date) | Out-File -Append "c:\temp\Excel_Refresh_Save.txt"
	Write-Host ("Message saved to error log, no files where updated!")
	"---------------------------------" | Out-File -Append "c:\temp\Excel_Refresh_Save.txt"
}

#Error catching, applies for the entire script, can be placed anywhere         
trap 
{
	write-host ("An error has occured: "+$_.exception.message)
	Write-Host ("Please see error message or log file")
	$_.Exception.Message+" "+(Get-Date) | Out-File -Append "c:\temp\Excel_Refresh_Save.txt"
	$_.Exception.InnerException.Message | Out-File -Append "c:\temp\Excel_Refresh_Save.txt"
	"---------------------------------" | Out-File -Append "c:\temp\Excel_Refresh_Save.txt"
}

#Hard kill of every excel process, inadvisable. Only use for single user machine
#Stop-Process -name EXCEL

#two methods for killing processes for username, the first method is recommended (no output)
#gwmi -query "select * from win32_process where name='EXCEL.exe'" | %{if($_.GetOwner().User -eq 'USERNAME'){$_.terminate()}} | Out-Null #<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<Set Username first
#or use current users name
gwmi -query "select * from win32_process where name='EXCEL.exe'" | %{if($_.GetOwner().User -eq [Environment]::UserName){$_.terminate()}} | Out-Null
#taskkill /f /fi "imagename eq excel.exe" /fi "username eq USERNAME"