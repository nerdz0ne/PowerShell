The *watch-commits.ps1* Script
===========================

This PowerShell script permanently lists the latest commit in a Git repository in real-time.

Parameters
----------
```powershell
/home/markus/Repos/PowerShell/scripts/watch-commits.ps1 [[-pathToRepo] <String>] [[-updateInterval] <Int32>] [[-speed] <Int32>] [<CommonParameters>]

-pathToRepo <String>
    Specifies the file path to the local Git repository.
    
    Required?                    false
    Position?                    1
    Default value                "$PWD"
    Accept pipeline input?       false
    Accept wildcard characters?  false

-updateInterval <Int32>
    
    Required?                    false
    Position?                    2
    Default value                30
    Accept pipeline input?       false
    Accept wildcard characters?  false

-speed <Int32>
    
    Required?                    false
    Position?                    3
    Default value                17
    Accept pipeline input?       false
    Accept wildcard characters?  false

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Example
-------
```powershell
PS> ./commit-ticker.ps1
❇️ Updated general.csv by Markus Fleschutz (HEAD -> main, origin/main, origin/HEAD)
...

```

Notes
-----
Author: Markus Fleschutz | License: CC0

Related Links
-------------
https://github.com/fleschutz/PowerShell

Script Content
--------------
```powershell
<#
.SYNOPSIS
	Show commits live in real-time.
.DESCRIPTION
	This PowerShell script permanently lists the latest commit in a Git repository in real-time.
.PARAMETER pathToRepo
	Specifies the file path to the local Git repository.
.EXAMPLE
	PS> ./commit-ticker.ps1
	❇️ Updated general.csv by Markus Fleschutz (HEAD -> main, origin/main, origin/HEAD)
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$pathToRepo = "$PWD", [int]$updateInterval = 30, [int]$speed = 17)

try {
	Write-Progress "Searching for Git executable..."
	$null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	Write-Progress "Checking file patch to Git repository..."
	if (-not(Test-Path "$pathToRepo" -pathType container)) { throw "Can't access directory: $pathToRepo" }

	Write-Progress "Fetching updates..."
	& git -C "$pathToRepo" fetch --all --recurse-submodules=no --jobs=1 --quiet
	if ($lastExitCode -ne "0") { throw "'git fetch' failed" }
	Write-Progress -completed "Done."

	$prevLine = ""
	$tzOffset = (Get-Timezone).BaseUtcOffset.TotalSeconds
	for (;;) {
		$line = (git -C "$pathToRepo" log origin --format=format:'%at %s by %an%d' --max-count=1)
		if ($line -ne $prevLine) {
			$unixTimestamp = [int64]$line.Substring(0,10)
			$time = (Get-Date -day 1 -month 1 -year 1970 -hour 0 -minute 0 -second 0).AddSeconds($unixTimestamp)
			$time = $time.AddSeconds($tzOffset)
			$timeString = $time.ToString("HH:mm")
			$message = $line.Substring(11)
			& "$PSScriptRoot/write-typewriter.ps1" "❇️ $timeString $message" $speed
			$prevLine = $line
		} else {
			Start-Sleep -seconds $updateInterval
		}
		& git -C "$pathToRepo" fetch --all --recurse-submodules=no --jobs=1 --quiet
		if ($lastExitCode -ne "0") { throw "'git fetch' failed" }
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
```

*(generated by convert-ps2md.ps1 as of 11/08/2024 12:40:23)*
