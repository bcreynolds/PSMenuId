$projectRoot = Resolve-Path "$PSScriptRoot\.."
$moduleRoot = Split-Path (Resolve-Path "$projectRoot\*\*.psd1")
$moduleName = Split-Path $moduleRoot -Leaf

Describe "Basic unit tests" -Tags Build {

	Import-Module (Join-Path $moduleRoot "$moduleName.psm1") -Force

	Context "Function: Measure-JsonMenuItemsIdSum" {

		It 'should return a specific array of integers.' {
			$params = @{
				Path = "$PSScriptRoot\..\Tests\TestFiles\GoodTestInput.json"
			}
			$results = Measure-JsonMenuItemsIdSum @params
			$results | Should be @(46,0,248)
		}
	}
}