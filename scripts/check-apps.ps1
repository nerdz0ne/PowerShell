﻿<#
.SYNOPSIS
	Query the app status
.DESCRIPTION
	This PowerShell script queries the installed applications and prints it.
.EXAMPLE
	PS> ./check-apps.ps1
	✅ 119 Windows apps installed, 11 upgrades available
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux) {
		Write-Progress "Querying installed applications..."
		$numPkgs = (apt list --installed 2>/dev/null).Count
		$numSnaps = (snap list).Count - 1
		Write-Progress -Completed "."
		Write-Host "✅ $numPkgs Debian packages, $numSnaps snaps installed"
	} else {
		Write-Progress "Querying installed applications..."
		$Apps = Get-AppxPackage
		Write-Progress -Completed "."
		Write-Host "✅ $($Apps.Count) Windows apps installed, " -noNewline

		[int]$NumNonOk = 0
		foreach($App in $Apps) { if ($App.Status -ne "Ok") { $NumNonOk++ } }
		if ($NumNonOk -gt 0) { $Status += ", $NumNonOk non-ok" }
		[int]$NumErrors = (Get-AppxLastError)
		if ($NumErrors -gt 0) { $Status += ", $NumErrors errors" }

		$NumUpdates = (winget upgrade --include-unknown).Count - 5
		Write-Host "$NumUpdates upgrades available"
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
