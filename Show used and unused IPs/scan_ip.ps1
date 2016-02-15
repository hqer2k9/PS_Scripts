
# --------------------------------------------------------------------------------------
# Script: scan_ip.ps1
# Script Version: v1.0
# Author: Ingo Bechtle
# comments: Scans network range for used or unused ip adresses and shows time taken
# --------------------------------------------------------------------------------------

#Get-Date for timekeeping at the end of the script
$count = 0
$count1 = 0
$Start = Get-Date
$Ping = New-Object System.Net.Networkinformation.ping
for ($i=1; $i -le 255; $i++) 
{

#Display a progress Bar according to the IP count to evade max count 100% warning
Write-Progress -PercentComplete ((100*$i)/255) -Activity "Gathering IP's"

                $Status = $Null
                $IPAddress = "192.168.2." + $i
                $Status = ($Ping.Send("$IPAddress", 1)).Status 
                if ($Status -eq "Success") 
                { $count++
                Write-Host "$IPAddress" -ForegroundColor Green  
                }  
                else
                { $count1++
                Write-Host "$IPAddress" -ForegroundColor Red
                } 
} 
$End = Get-Date

Write-Host ""
Write-Host $count "used IP's" -ForegroundColor Green
Write-Host $count1 "unused IP's" -ForegroundColor Red

#how long did it take?
$End-$Start