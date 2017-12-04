# PSMenuId
PSMenuId is a PowerShell module for calculating sums of JSON file menu items IDs.

# Description
The PSMenuID module contains only one command: Measure-JsonFileMenuItemsIdSum. This command takes a JSON filepath as input, and iterates through each top-level "menu" to calculate the SUM of the IDs of all "items", as long as a "label" exists for that item.

# Command examples
Measure-JsonFileMenuItemsIdSum can be passed a JSON filepath via the "path" parameter:

    Measure-JsonFileMenuItemsIdSum -path "C:\temp\file.json"

Or you can also pass the JSON filepath via the PowerShell pipeline:

    "C:\temp\file.json" | Measure-JsonFileMenuItemsIdSum

## Example Input File

    [
     {
        "menu":{
           "header":"menu",
           "items":[
              {
                 "id":27
              },
              {
                 "id":0,
                 "label":"Label 0"
              },
              null,
              {
                 "id":93
              },
              {
                 "id":85
              },
              {
                 "id":54
              },
              null,
              {
                 "id":46,
                 "label":"Label 46"
              }
           ]
        }
     },
     {
        "menu":{
           "header":"menu",
           "items":[
              {
                 "id":81
              }
           ]
        }
     },
     {
        "menu":{
           "header":"menu",
           "items":[
              {
                 "id":70,
                 "label":"Label 70"
              },
              {
                 "id":85,
                 "label":"Label 85"
              },
              {
                 "id":93,
                 "label":"Label 93"
              },
              {
                 "id":2
              }
           ]
        }
     }
    ]

## Sample Output

With the sample input file above, the output will be as follows:

46
0
248

# Building, Testing, and Deploying PSMenuID
Make sure you are running Powershell 5.0 (WMF 5.0).

Download the full PSMenuID repository, open a PowerShell window and CD to the downloaded folder, then run .\build.ps1. This will build the PSMenuID module, run automated tests against it, and deploy it to your PowerShell Modules folder at %UserProfile%\Documents\WindowsPowerShell\Modules. At that point, you can type "Import-Module PSMenuID" at any time in a PowerShell window to gain access to the Measure-JsonFileMenuItemsIdSum command.

# Manually Installing PSMenuID
Download the "PSMenuID" folder within the "PSMenuID" repository and manually copy the entire folder to one of your PowerShell Modules folders such as %UserProfile%\Documents\WindowsPowerShell\Modules. At that point, you can type "Import-Module PSMenuID" at any time in a PowerShell window to gain access to the Measure-JsonFileMenuItemsIdSum command.
