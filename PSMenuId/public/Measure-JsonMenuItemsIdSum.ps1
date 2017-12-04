<#
.SYNOPSIS
	Example coding exercise for calculating sums of JSON file menu items IDs.
.DESCRIPTION
	For each top-level "menu" in a JSON file, calculate the SUM of the IDs of all "items",
	as long as a "label" exists for that item.
.EXAMPLE
	Measure-JsonFileMenuItemsIdSum -path "C:\temp\file.json"
.EXAMPLE
	"C:\temp\file.json" | Measure-JsonFileMenuItemsIdSum
.NOTES
	Takes a path to a JSON file as input.
	All IDs are integers between 0 and 100. The menu can be of any length.
#>
function Measure-JsonMenuItemsIdSum {
[CmdletBinding()]
param(
	[Parameter(Mandatory=$true,ValueFromPipeline=$true)]
	[String]$Path
)
	Process {
		$fileContent = Get-Content $Path -Force
		$jsonData = $fileContent | ConvertFrom-Json

		$jsonData | Where { $_.menu } | Select -Expand menu | ForEach {
			($_ |
				Where { $_.items } |
				Select -Expand items |
				Where { $_.psobject.properties.name -contains 'label' } |
				Measure-Object -Property 'id' -Sum
			).Sum -as [Int]
		}
	}
}
