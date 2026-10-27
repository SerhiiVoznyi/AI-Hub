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

Write-Host "`nThe following directories will be deleted:" -ForegroundColor Yellow
$targets | ForEach-Object { Write-Host "  $($_.FullName)" }

$answer = Read-Host "`nDelete these $($targets.Count) directories? Type YES to continue"
if ($answer -cne "YES") {
    Write-Host "Cancelled. No directories were deleted." -ForegroundColor Yellow
    exit 0
}

$deleted = 0
$failed = @()

foreach ($target in $targets) {
    try {
        if (Test-Path -LiteralPath $target.FullName) {
            Remove-Item -LiteralPath $target.FullName -Recurse -Force
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

Write-Host "`nDeep Clean finished. Removed $deleted of $($targets.Count) directories." -ForegroundColor Green

if ($failed.Count -gt 0) {
    Write-Host "`nSome directories could not be removed. Close Visual Studio or processes using them, then rerun the script." -ForegroundColor Yellow
    $failed | Format-Table -AutoSize
    exit 1
}