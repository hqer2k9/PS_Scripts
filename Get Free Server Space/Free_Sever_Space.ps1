# --------------------------------------------------------------------------------------
# Script: Free_Sever_Space.ps1
# Script Version: v1.0
# Author: Ingo Bechtle
# comments: Get's a list of servers and checks their free space in % and generates a warning if beneath the threshold
# --------------------------------------------------------------------------------------

$freespacethreshold = 17

# Setting path to servers.txt file for input
# This is just an example where the file with the servers could be
$inputfilepath = $env:USERPROFILE + "\Desktop"
$inputfilename = "servers.txt"
$workingfile = $inputfilepath + "\" + $inputfilename

#does the file exist?
$fileexist = test-path $workingfile

# Simple check for the servers.txt
if ($? -eq $false)
{
  Write-Host "$inputfilename does not exist on $infputfilepath" -ForegroundColor Red -BackgroundColor Black
  Write-Host "Please Create the file with one server per line that you want checked" -ForegroundColor Red -BackgroundColor Black
  exit 1
}

#read the file into a variable for later processing
$servers = Get-Content $workingfile

# Step 1: this is to check the disk space and alert if their is 10% or less free
foreach ($s in $servers)
{
 $logicaldisks = Get-WmiObject -ComputerName $s Win32_Logicaldisk
 
 Foreach ($l in $logicaldisks)
 {
  $totalsize = $l.size
  $freespace = $l.freespace
  if ($freespace -gt 0)
  {
   $percentagefree = ($freespace / $totalsize ) * 100
   Write-Host $l.deviceid " has " $percentagefree "% free" 
     
   if ($percentagefree -lt $freespacethreshold)
   {
    Write-Host "Health Alert!" -ForegroundColor Red -BackgroundColor Black
    Write-Host "Drive " $l.deviceid " has less the $freespacethreshold % free"
   }
 }
 }
}

#
# if you comment this part in - the script will not close!
# If running in the console, wait for input before closing.
#
#if ($Host.Name -eq "ConsoleHost")
#{ 
#    Write-Host "Press any key to continue..."
#    $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyUp") > $null