# --------------------------------------------------------------------------------------
# Script: Auto_Domain.ps1
# Script Version: v1.0
# Author: Ingo Bechtle
# comments: joins a domain or leaves it, depending on status, please make sure to fill in the placeholders!
# --------------------------------------------------------------------------------------

get-date

#Script will stop if an error occurs, has to be in the first line
$ErrorActionPreference = "Stop"

#Error catching, applies for the entire script, can be placed anywhere         
trap 
{   #adding some error handling
	write-host ("An error has occured: "+$_.exception.message)
	Write-Host ("Please see error message or log file")
	$_.Exception.Message+" "+(Get-Date) | Out-File -Append "c:\temp\autodomain.txt"
	$_.Exception.InnerException.Message | Out-File -Append "c:\temp\autodomain.txt"
	"---------------------------------" | Out-File -Append "c:\temp\autodomain.txt"
}

#see if a connection to server can be made, if so, proceed, if not, exit
if ((Test-Connection -Count "1" -ComputerName SETCOMPUTERNAMEHERE -Quiet) -eq $true)
	{
	Write-Host -fore green "Connection to SETCOMPUTERNAMEHERE was successful, proceeding with script"

		#check if the pc is domain joined
		if ((gwmi win32_computersystem).partofdomain -eq $true) {
		write-host -fore green "This Computer is in a Domain, lets leave it"
		Write-host "Please wait for the operation to complete"
		
		#leaving domain
		Remove-Computer -credential "domain\elevatedaccount"
			} 
			else 
			{
				write-host -fore red "Not domain joined, joining, please enter password"
				
				#joining domain
				Write-Host "Please enter Admin password to join the domain DOMAIN"
				Add-Computer -domainname my.domain.goes.here -credential "domain\elevatedaccount"
				Write-host "Please wait for the operation to complete"

				#Restard computer if neccesarry
				#restart-computer
			}
	
	}
	else
	{
		Write-Host -Fore Red "Could not check if SETCOMPUTERNAMEHERE is online!, stopping script"
	}