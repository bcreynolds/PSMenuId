Properties {
	$projectRoot = $env:BHProjectPath
	if (-not $projectRoot) {
		$projectRoot = $PSScriptRoot
	}

	$moduleRoot = Split-Path (Resolve-Path "$projectRoot\*\*.psm1")
	$moduleName = Split-Path $moduleRoot -Leaf

	$timestamp = Get-date -uformat "%Y%m%d-%H%M%S"
	$PSVersion = $PSVersionTable.PSVersion.Major
	$testFile = "TestResults_PS$PSVersion`_$timeStamp.xml"
	$separator = '----------------------------------------------------------------------'

	$verbose = @{}
	if ($env:BHCommitMessage -match "!verbose") {
		$verbose = @{Verbose = $True}
	}
}

Task Default -Depends Deploy

Task Init {
	$separator
	Set-Location $projectRoot
	"Build System Details:"
	Get-Item env:BH* | Format-List
	"`n"
}

Task ProjectTests -Depends Init {
	$separator
	"STATUS: Testing with PowerShell $PSVersion`n"

	$testResults = Invoke-Pester -Path "$projectRoot\Tests\Project*" -PassThru -Tag Build

	if ($testResults.FailedCount -gt 0) {
		$testResults | Format-List
		Write-Error "Failed '$($testResults.FailedCount)' tests, build failed"
	}
	"`n"
}

Task UnitTests -Depends ProjectTests {
	$separator

	$testResults = Invoke-Pester -Path "$projectRoot\Tests\*unit*" -PassThru -Tag Build

	if ($testResults.FailedCount -gt 0) {
		$testResults | Format-List
		Write-Error "Failed '$($testResults.FailedCount)' tests, build failed"
	}
	"`n"
}

Task HelpTests -Depends UnitTests {
	$separator

	$testResults = Invoke-Pester -Path "$projectRoot\Tests\Help*" -PassThru -Tag Build

	if ($testResults.FailedCount -gt 0) {
		$testResults | Format-List
		Write-Error "Failed '$($testResults.FailedCount)' tests, build failed"
	}
	"`n"
}

Task Deploy -Depends HelpTests {
	$separator

	Invoke-PSDeploy -Path $projectRoot -Force

	Import-Module $moduleName
	if (-not (Get-Module -ListAvailable -Name $moduleName)) {
		Write-Error 'Failed: $moduleName module deployment.'
	}
}