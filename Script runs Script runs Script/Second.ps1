# --------------------------------------------------------------------------------------
# Script: First.ps1, Second.ps1, Third.ps1
# Script Version: v1.0
# Author: Ingo Bechtle
# comments: "First" starts "Second" which starts "Third"
# --------------------------------------------------------------------------------------

start  C:\Temp\Third.ps1

#can also be starten hidden:
#start /min powershell -WindowStyle Hidden -Command C:\Temp\Third.ps1