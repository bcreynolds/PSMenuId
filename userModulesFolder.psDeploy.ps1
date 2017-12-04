<#
.DESCRIPTION
Deploy to the PowerShell Modules folder for the current user
#>
[cmdletbinding()]
param()

$projectRoot = $ENV:BHProjectPath
$moduleRoot = Split-Path (Resolve-Path "$projectRoot\*\*.psm1")
$moduleName = Split-Path $moduleRoot -Leaf

Deploy 'Deploy $moduleName module' {
	By Filesystem Modules {
		FromSource "$moduleRoot"
		To "$env:UserProfile\Documents\WindowsPowerShell\Modules\$moduleName"
		WithOptions @{
			Mirror = $true
		}
	}
}