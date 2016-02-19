# --------------------------------------------------------------------------------------
# Script: Test_Connection.ps1
# Script Version: v1.0
# Author: Ingo Bechtle
# comments: Snippet for fast 1 ping requests, not realy reliable but it does it's job
# --------------------------------------------------------------------------------------

# Declaring computers
$Computers = "Computer1", "Computer2", "Computer3", "Computer4"

# 1 Ping packet
Test-Connection -Count "1" -ComputerName $Computers | Out-host