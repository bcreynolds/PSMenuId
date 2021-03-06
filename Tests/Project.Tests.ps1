$projectRoot = Resolve-Path "$PSScriptRoot\.."
$moduleRoot = Split-Path (Resolve-Path "$projectRoot\*\*.psd1")
$moduleName = Split-Path $moduleRoot -Leaf

Describe "General project validation: $moduleName" -Tags Build {

	Context "Valid Powershell" {
		$scripts = Get-ChildItem $projectRoot -Include *.ps1,*.psm1,*.psd1 -Recurse
		$testCase = $scripts | Foreach-Object{@{file=$_}}

		It "Script <file> should be valid powershell" -TestCases $testCase {
			param($file)

			$file.fullname | Should Exist

			$contents = Get-Content -Path $file.fullname -ErrorAction Stop
			$errors = $null
			$null = [System.Management.Automation.PSParser]::Tokenize($contents, [ref]$errors)
			$errors.Count | Should Be 0
		}
	}

	It "Module '$moduleName' can import cleanly" {
		{Import-Module (Join-Path $moduleRoot "$moduleName.psm1") -force } | Should Not Throw
	}
}