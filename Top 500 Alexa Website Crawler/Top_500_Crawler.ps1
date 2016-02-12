﻿# --------------------------------------------------------------------------------------
# Script: Top_500_Crawler.ps1
# Script Version: v1.0
# Author: Ingo Bechtle
# comments: starts an URL Lookup on Alexa.com and generates output
# --------------------------------------------------------------------------------------

########################################################################
####################### STILL UNDER CONSTRUCTION #######################
########################################################################

[Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}

$URIS = 
(
"http://www.alexa.com/topsites/global;0", 
"http://www.alexa.com/topsites/global;1",
"http://www.alexa.com/topsites/global;3",
"http://www.alexa.com/topsites/global;4", 
"http://www.alexa.com/topsites/global;5",
"http://www.alexa.com/topsites/global;6",
"http://www.alexa.com/topsites/global;7", 
"http://www.alexa.com/topsites/global;8",
"http://www.alexa.com/topsites/global;9",
"http://www.alexa.com/topsites/global;10", 
"http://www.alexa.com/topsites/global;11",
"http://www.alexa.com/topsites/global;12",
"http://www.alexa.com/topsites/global;13", 
"http://www.alexa.com/topsites/global;14",
"http://www.alexa.com/topsites/global;15",
"http://www.alexa.com/topsites/global;16", 
"http://www.alexa.com/topsites/global;17",
"http://www.alexa.com/topsites/global;18",
"http://www.alexa.com/topsites/global;19", 
"http://www.alexa.com/topsites/global;20",
"http://www.alexa.com/topsites/global;21"
)

foreach ($URI in $URIS) 
{
  
    $URI 
    $HTML = Invoke-WebRequest -Uri $URI 
    ($HTML.ParsedHtml.getElementsByTagName(‘div’) | Where{ $_.className -eq ‘count’ } ).innerText  
 } Out-GridView

