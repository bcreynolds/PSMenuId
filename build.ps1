<#
.DESCRIPTION
Installs and loads all the required modules for the build.
#>
[CmdletBinding()]
param($Task = 'Default')

"Starting build"

# Grab nuget bits, install modules, set build variables, start build.
"  Install Dependent Modules"
Get-PackageProvider -Name NuGet -ForceBootstrap | Out-Null

Install-Module Psake, PSDeploy, BuildHelpers, PSScriptAnalyzer -Force -Scope CurrentUser
Install-Module Pester -Force -SkipPublisherCheck -Scope CurrentUser

"  Import Dependent Modules"
Import-Module Psake, PSDeploy, BuildHelpers, PSScriptAnalyzer, Pester

Set-BuildEnvironment -Force

"  Invoke Build"
Invoke-psake -buildFile .\psake.ps1 -taskList $Task -nologo
if ($result.Error) {
	exit 1
} else {
	exit 0
}
