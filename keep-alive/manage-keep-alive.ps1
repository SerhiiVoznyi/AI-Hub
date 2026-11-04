param(
    [ValidateSet("Start", "Status", "Stop")]
    [string]$Action
)

$scriptPath = Join-Path $PSScriptRoot "keep-alive.vbs"

function Get-KeepAliveProcess {
    Get-CimInstance Win32_Process -Filter "Name='wscript.exe' OR Name='cscript.exe'" |
        Where-Object {
            $_.CommandLine -and
            $_.CommandLine.IndexOf($scriptPath, [StringComparison]::OrdinalIgnoreCase) -ge 0
        }
}

if (-not $Action) {
    $Action = Read-Host "Choose an action: Start, Status, or Stop"
}

switch ($Action.ToLowerInvariant()) {
    "start" {
        $running = Get-KeepAliveProcess
        if ($running) {
            Write-Host "Keep-alive is already running (PID: $($running.ProcessId -join ', '))."
            break
        }

        $process = Start-Process -FilePath "$env:SystemRoot\System32\wscript.exe" `
            -ArgumentList "`"$scriptPath`"" -PassThru
        Write-Host "Keep-alive started (PID: $($process.Id))."
    }

    "status" {
        $running = Get-KeepAliveProcess
        if ($running) {
            Write-Host "Keep-alive is running (PID: $($running.ProcessId -join ', '))."
        }
        else {
            Write-Host "Keep-alive is not running."
        }
    }

    "stop" {
        $running = Get-KeepAliveProcess
        if (-not $running) {
            Write-Host "Keep-alive is not running."
            break
        }

        $running | ForEach-Object { Stop-Process -Id $_.ProcessId }
        Write-Host "Keep-alive stopped."
    }
}
