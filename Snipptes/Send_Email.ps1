# --------------------------------------------------------------------------------------
# Script: Send_Email.ps1
# Script Version: v1.0
# Author: Ingo Bechtle
# comments: small snippet for sending en email
# --------------------------------------------------------------------------------------

# Generate Outlook com object and generate mail
# has to be your mail account
$Outlook = New-Object -ComObject Outlook.Application
$Mail = $Outlook.CreateItem(0)
$Mail.To = "your.name@company"
$Mail.Subject = "This is the Subject"
$Mail.Body ="This is the body of the mail"
$Mail.Send()