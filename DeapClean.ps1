<#
.SYNOPSIS
    Removes all bin and obj folders, with everything inside them, from a folder of repositories.

.DESCRIPTION
    Recursively scans the root folder, lists every bin/obj folder that will be deleted, and asks for a
    single confirmation. After that confirmation everything is deleted without further prompts.

    Safety rules:
    - Symbolic links and junctions are never followed or deleted.
    - Folders named in -ExcludeDirectoryNames are not searched.
    - Drive roots and system/application folders are refused.

.PARAMETER Path
    Folder that contains the repositories. Defaults to the folder this script is in.

.PARAMETER ExcludeDirectoryNames
    Names of folders that are never searched.

.EXAMPLE
    .\DeapClean.ps1 -Path C:\Development
#>
[CmdletBinding()]
param(
    [string] $Path,
    [string[]] $ExcludeDirectoryNames = @('.git', 'node_modules')
)

$ErrorActionPreference = 'Stop'
$targetNames = @('bin', 'obj')

if (-not $Path) {
    $Path = $PSScriptRoot
}

if (-not $Path -or -not (Test-Path -LiteralPath $Path -PathType Container)) {
    throw "Folder not found: '$Path'."
}

$rootInfo = [System.IO.DirectoryInfo]::new((Resolve-Path -LiteralPath $Path).ProviderPath)

function Test-PathOverlap {
    param(
        [string] $First,
        [string] $Second
    )

    $a = $First.TrimEnd('\') + '\'
    $b = $Second.TrimEnd('\') + '\'
    return $a.StartsWith($b, [System.StringComparison]::OrdinalIgnoreCase) -or
        $b.StartsWith($a, [System.StringComparison]::OrdinalIgnoreCase)
}

if ($null -eq $rootInfo.Parent) {
    throw "Refusing to clean the drive root '$($rootInfo.FullName)'. Point -Path at the folder that contains your repositories."
}

$systemFolders = @($env:SystemRoot, $env:ProgramFiles, ${env:ProgramFiles(x86)}, $env:ProgramData, $env:APPDATA, $env:LOCALAPPDATA) |
    Where-Object { $_ }
foreach ($folder in $systemFolders) {
    if (Test-PathOverlap -First $rootInfo.FullName -Second $folder) {
        throw "Refusing to clean '$($rootInfo.FullName)': it overlaps the system or application folder '$folder'."
    }
}

function Reset-Attributes {
    param([System.IO.DirectoryInfo] $Directory)

    $pending = [System.Collections.Generic.Stack[System.IO.FileSystemInfo]]::new()
    $pending.Push($Directory)

    while ($pending.Count -gt 0) {
        $current = $pending.Pop()
        if ($current.Attributes -band [System.IO.FileAttributes]::ReparsePoint) {
            continue
        }

        $current.Attributes = [System.IO.FileAttributes]::Normal
        if ($current -is [System.IO.DirectoryInfo]) {
            foreach ($child in $current.GetFileSystemInfos()) {
                $pending.Push($child)
            }
        }
    }
}

function Remove-Directory {
    param([System.IO.DirectoryInfo] $Directory)

    # .NET deletion removes nested links without following them and never prompts.
    try {
        [System.IO.Directory]::Delete($Directory.FullName, $true)
    }
    catch {
        Reset-Attributes -Directory $Directory
        [System.IO.Directory]::Delete($Directory.FullName, $true)
    }
}

Write-Host "Deep Clean root: $($rootInfo.FullName)" -ForegroundColor Cyan
Write-Host 'Searching for bin/obj directories...' -ForegroundColor Cyan

$targets = [System.Collections.Generic.List[System.IO.DirectoryInfo]]::new()
$scannedCount = 0

$pending = [System.Collections.Generic.Stack[System.IO.DirectoryInfo]]::new()
$pending.Push($rootInfo)

while ($pending.Count -gt 0) {
    $directory = $pending.Pop()

    $scannedCount++
    if ($scannedCount % 500 -eq 0) {
        Write-Progress -Activity 'Scanning' -Status "$scannedCount folders scanned" -CurrentOperation $directory.FullName
    }

    try {
        $children = $directory.GetDirectories()
    }
    catch {
        Write-Warning "Could not read '$($directory.FullName)': $($_.Exception.GetBaseException().Message)"
        continue
    }

    foreach ($child in $children) {
        if (($child.Attributes -band [System.IO.FileAttributes]::ReparsePoint) -or $child.Name -in $ExcludeDirectoryNames) {
            continue
        }

        if ($child.Name -in $targetNames) {
            $targets.Add($child)
        }
        else {
            $pending.Push($child)
        }
    }
}

Write-Progress -Activity 'Scanning' -Completed

if ($targets.Count -eq 0) {
    Write-Host 'No bin/obj directories found. Nothing to clean.' -ForegroundColor Green
    exit 0
}

$targets = @($targets | Sort-Object FullName)

Write-Host "`nThe following directories (and all files and subfolders inside them) will be deleted:" -ForegroundColor Yellow
$targets | ForEach-Object { Write-Host "  $($_.FullName)" }

$answer = Read-Host "`nDelete these $($targets.Count) directories and their contents? Type YES to continue"
if ($answer -cne 'YES') {
    Write-Host 'Cancelled. Nothing was deleted.' -ForegroundColor Yellow
    exit 0
}

$removed = 0
$failed = [System.Collections.Generic.List[object]]::new()

foreach ($target in $targets) {
    try {
        Remove-Directory -Directory $target
        Write-Host "Removed: $($target.FullName)" -ForegroundColor DarkGray
        $removed++
    }
    catch {
        $message = $_.Exception.GetBaseException().Message
        $failed.Add([PSCustomObject]@{
                Path  = $target.FullName
                Error = $message
            })
        Write-Warning "Could not remove '$($target.FullName)': $message"
    }
}

Write-Host "`nDeep Clean finished. Removed $removed of $($targets.Count) directories (including files)." -ForegroundColor Green

if ($failed.Count -gt 0) {
    Write-Host "`nSome paths could not be removed. Close Visual Studio or processes using them, then rerun the script." -ForegroundColor Yellow
    $failed | Format-Table -AutoSize
    exit 1
}
