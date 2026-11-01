$ErrorActionPreference = "Stop"
$root = $PSScriptRoot

if (-not $root -or -not (Test-Path -LiteralPath $root)) {
    throw "Could not determine the script directory."
}

Write-Host "Deep Clean root: $root" -ForegroundColor Cyan
Write-Host "Searching for bin/obj directories..." -ForegroundColor Cyan

$targets = @(
    Get-ChildItem -LiteralPath $root -Directory -Recurse -Force -ErrorAction SilentlyContinue |
        Where-Object { $_.Name -in @("bin", "obj") } |
        Sort-Object { $_.FullName.Length } -Descending
)

if ($targets.Count -eq 0) {
    Write-Host "No bin/obj directories found. Nothing to clean." -ForegroundColor Green
    exit 0
}

Write-Host "`nThe following directories (and all files inside them) will be deleted:" -ForegroundColor Yellow
$targets | ForEach-Object { Write-Host "  $($_.FullName)" }

$answer = Read-Host "`nDelete these $($targets.Count) directories and their contents? Type YES to continue"
if ($answer -cne "YES") {
    Write-Host "Cancelled. Nothing was deleted." -ForegroundColor Yellow
    exit 0
}

function Remove-Tree {
    param(
        [Parameter(Mandatory = $true)]
        [string] $Path
    )

    if (-not (Test-Path -LiteralPath $Path)) {
        return
    }

    # Clear attributes that block deletion, then remove files first.
    Get-ChildItem -LiteralPath $Path -Recurse -Force -File -ErrorAction SilentlyContinue |
        ForEach-Object {
            $_.Attributes = "Normal"
            Remove-Item -LiteralPath $_.FullName -Force -ErrorAction Stop
        }

    # Remove directories deepest-first so parents are empty when deleted.
    Get-ChildItem -LiteralPath $Path -Recurse -Force -Directory -ErrorAction SilentlyContinue |
        Sort-Object { $_.FullName.Length } -Descending |
        ForEach-Object {
            Remove-Item -LiteralPath $_.FullName -Force -ErrorAction Stop
        }

    Remove-Item -LiteralPath $Path -Force -ErrorAction Stop
}

$deleted = 0
$failed = @()

foreach ($target in $targets) {
    try {
        if (Test-Path -LiteralPath $target.FullName) {
            Remove-Tree -Path $target.FullName
            Write-Host "Removed: $($target.FullName)" -ForegroundColor DarkGray
            $deleted++
        }
    }
    catch {
        $failed += [PSCustomObject]@{
            Path  = $target.FullName
            Error = $_.Exception.Message
        }
        Write-Warning "Could not remove '$($target.FullName)': $($_.Exception.Message)"
    }
}

Write-Host "`nDeep Clean finished. Removed $deleted of $($targets.Count) directories (including files)." -ForegroundColor Green

if ($failed.Count -gt 0) {
    Write-Host "`nSome paths could not be removed. Close Visual Studio or processes using them, then rerun the script." -ForegroundColor Yellow
    $failed | Format-Table -AutoSize
    exit 1
}
