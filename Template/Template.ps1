# --------------------------------------------------------------------------------------
# Script: Template.ps1
# Script Version: v1.0
# Author: Ingo Bechtle
# comments: simple template for PS scripts
# --------------------------------------------------------------------------------------

get-date

#Script will stop if an error occurs, has to be in the first line
$ErrorActionPreference = "Stop"

#Error catching, applies for the entire script, can be placed anywhere         
trap 
{
	write-host ("An error has occured: "+$_.exception.message)
	Write-Host ("Please see error message or log file")
	$_.Exception.Message+" "+(Get-Date) | Out-File -Append "c:\temp\Template_errorlog.txt"
	$_.Exception.InnerException.Message | Out-File -Append "c:\temp\Template_errorlog.txt"
	"---------------------------------" | Out-File -Append "c:\temp\Template_errorlog.txt"
}

#Hard kill of every excel process, inadvisable. Only use for single user machine
#Stop-Process -name PROGRAM NAME

#two methods for killing processes for username, the first method is recommended (no output)
gwmi -query "select * from win32_process where name='EXE_NAME.exe'" | %{if($_.GetOwner().User -eq 'USERNAME'){$_.terminate()}} | Out-Null
#taskkill /f /fi "imagename eq excel.exe" /fi "username eq USERNAME"