properties {
	$pwd = Split-Path $psake.build_script_file	
	$build_directory  = "$pwd\output\NetStorage"
	$configuration = "Release"
	$nuget = "$pwd\..\tools\nuget.exe"
}
 
include .\..\tools\psake_ext.ps1

task default -depends Build-All

task Build-All -depends Clean, ResotreNugetPackages, Build

task ResotreNugetPackages {
	Exec { & $nuget restore "$pwd\..\NetStorage.sln" }
}

task Build {
	Exec { msbuild "$pwd\..\NetStorage.sln" /t:Build /p:Configuration=$configuration /p:OutDir=$build_directory /p:GenerateProjectSpecificOutputFolder=true}
}

task Clean {
	Write-Host "Cleaning Build output"  -ForegroundColor Green
	Remove-Item $build_directory -Force -Recurse -ErrorAction SilentlyContinue
}