﻿<#
.SYNOPSIS
	enter-chat.ps1 
.DESCRIPTION
	Enters a chat using a common network shared file
.EXAMPLE
	PS> ./enter-chat
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

# make sure you adjust this path
# it must point to a network share where you have read and write permissions
$ServerShare = "\\myserver\chathome"

function Enter-Chat 
{
  param
  (
    [Parameter(Mandatory)]
    [string]
    $ChatChannelName,
    
    [string]
    $Name = $env:USERNAME,
    
    [Switch]
    $ShowOldPosts,
    
    $HomeShare = $ServerShare
    
  )
  
  if ($ShowOldPosts)
  {
    $Option = ''
  }
  else
  {
    $Option = '-Tail 0'
  }

  $Path = Join-Path -Path $HomeShare -ChildPath "$ChatChannelName.txt"
  $exists = Test-Path -Path $Path
  if ($exists -eq $false)
  {
    $null = New-Item -Path $Path -Force -ItemType File
  }

  $process = Start-Process -FilePath powershell -ArgumentList "-noprofile -windowstyle hidden -command Get-COntent -Path '$Path' $Option -Wait | Out-GridView -Title 'Chat: [$ChatChannelName]'" -PassThru

  Write-Host "To exit, enter: quit"
  "[$Name entered the chat]" | Add-Content -Path $Path
  do
  {
    Write-Host "[$ChatChannelName]: " -ForegroundColor Green -NoNewline
    $inputText = Read-Host 
    
    $isStopCommand = 'quit','exit','stop','leave' -contains $inputText
    if ($isStopCommand -eq $false)
    {
      "[$Name] $inputText" | Add-Content -Path $Path
    }
    
    
  } until ($isStopCommand -eq $true)
  "[$Name left the chat]" | Add-Content -Path $Path
  
  $process | Stop-Process
}



function Get-ChatChannel
{
  param
  (
    $HomeShare = $ServerShare
    
  )

  Get-ChildItem -Path $HomeShare -Filter *.txt -File |
    ForEach-Object {
      [PSCustomObject]@{
        ChannelName = [System.IO.Path]::GetFileNameWithoutExtension($_.Name)
        LastActive = $_.LastWriteTime
        Started = $_.CreationTime
      }
    }
}
