# --------------------------------------------------------------------------------------
# Script: First.ps1, Second.ps1, Third.ps1
# Script Version: v1.0
# Author: Ingo Bechtle
# comments: "First" starts "Second" which starts "Third"
# --------------------------------------------------------------------------------------

for(;;) {
 try {
  # invoke the worker script
  C:\Temp\Second.ps1
 }
 catch {
  # do something with $_, log it, more likely
 }

 # wait a bit
 Start-Sleep 5
 
#This will end EVERY notepad after time intervall, see "Third" for starting notepad
 Get-Process notepad | Foreach-Object { $_.CloseMainWindow() | Out-Null } | stop-process –force

}