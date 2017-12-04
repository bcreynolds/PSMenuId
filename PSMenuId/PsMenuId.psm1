#Requires -Version 4.0
[cmdletbinding()]
param()
Write-Verbose $PSScriptRoot

Write-Verbose 'Import everything in sub folders'
foreach ($folder in @('classes', 'private', 'public', 'includes', 'internal')) {
	$root = Join-Path -Path $PSScriptRoot -ChildPath $folder
	if (Test-Path -Path $root) {
		Write-Verbose "processing folder $root"
		$files = Get-ChildItem -Path $root -Filter *.ps1 -Recurse

		# Dot source each file
		$files | Where { $_.name -NotLike '*.Tests.ps1'} |
			ForEach {Write-Verbose $_.basename; . $_.FullName}
	}
}

Export-ModuleMember -Function (Get-ChildItem -Path "$PSScriptRoot\public\*.ps1").basename
