# Keep Alive

This Windows script prevents inactivity by sending the `F15` key every 20 seconds.
It runs until you stop it manually.

## Start

Open PowerShell in this directory and run:

```powershell
.\manage-keep-alive.ps1 Start
```

A message displays the start time. After you close the message, there is a
15-second delay before the script begins sending `F15`.

## Check status

```powershell
.\manage-keep-alive.ps1 Status
```

The command reports whether the script is running and shows its process ID.

## Stop

```powershell
.\manage-keep-alive.ps1 Stop
```

## Interactive mode

Run the manager without an action and enter `Start`, `Status`, or `Stop`:

```powershell
.\manage-keep-alive.ps1
```

## PowerShell execution policy

If Windows blocks the manager script, run it with a one-time policy bypass:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\manage-keep-alive.ps1 Start
```

Replace `Start` with `Status` or `Stop` as needed.
