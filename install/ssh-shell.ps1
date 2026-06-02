#!/usr/bin/env pwsh
################################################################################
#
#   Configure Windows OpenSSH default shell
#   Sets HKLM:\SOFTWARE\OpenSSH\DefaultShell so SSH sessions use PowerShell
#   Requires Administrator privileges
#
#   Usage:
#     .\ssh-shell.ps1           # interactive
#     .\ssh-shell.ps1 -Shell PS7
#     .\ssh-shell.ps1 -Shell PS5
#
#   PS7 note: Microsoft deprecated the MSI installer after 7.6.x. From 7.7+
#   only the MSIX (Store) package is available, which installs to WindowsApps
#   — a directory the SSH service (SYSTEM) cannot access. Options:
#     a) Stay on PS7.6.x MSI (pin it, upgrade manually from GitHub)
#     b) Use PS5 for SSH (always available, stable path)
#     c) Symlink the MSIX exe to the stable MSI path + grant SYSTEM access
#        (workaround — symlink breaks when PS7 updates, re-run to fix)
#
################################################################################

param(
    [ValidateSet('PS5', 'PS7')]
    [string]$Shell
)

# ---------------------------------------------------------------------------
# Require admin
# ---------------------------------------------------------------------------
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
           ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Error "This script requires Administrator privileges. Re-run PowerShell as Administrator."
    exit 1
}

# ---------------------------------------------------------------------------
# Paths
# ---------------------------------------------------------------------------
$ps5Path = "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"
$ps7Path = "C:\Program Files\PowerShell\7\pwsh.exe"   # stable MSI/symlink target

$ps7MsiPresent = Test-Path $ps7Path

# Detect MSIX (Store) install — in PATH but not accessible to SYSTEM
$msixCmd = Get-Command pwsh -ErrorAction SilentlyContinue
$msixPath = if ($msixCmd -and ($msixCmd.Source -like "*WindowsApps*")) {
    $msixCmd.Source
} else { $null }

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------
function Set-SshShell {
    param([string]$Path, [string]$Label)
    if (-not (Test-Path "HKLM:\SOFTWARE\OpenSSH")) {
        New-Item -Path "HKLM:\SOFTWARE\OpenSSH" -Force | Out-Null
    }
    New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell `
        -Value $Path -PropertyType String -Force | Out-Null
    Write-Host "  SSH default shell -> $Label" -ForegroundColor Green
    Write-Host "  Path: $Path" -ForegroundColor DarkGray
}

function Show-Ps7MsiWarning {
    Write-Host ""
    Write-Host "  WARNING: Microsoft deprecated the PS7 MSI after 7.6.x." -ForegroundColor Yellow
    Write-Host "           PS7.7+ ships MSIX only, which the SSH service (SYSTEM) cannot access." -ForegroundColor DarkGray
    Write-Host "           Long-term options: stay on PS7.6.x MSI, use PS5 for SSH, or use the" -ForegroundColor DarkGray
    Write-Host "           symlink workaround below (breaks on PS7 updates — re-run to refresh)." -ForegroundColor DarkGray
}

function New-Ps7Symlink {
    # Symlinks $ps7Path -> MSIX exe and grants SYSTEM read+execute on the WindowsApps dir.
    # The symlink breaks when PS7 updates (version string in folder name changes).
    # Re-run this script after each PS7 update to refresh it.
    if (-not $msixPath) {
        Write-Host "  No MSIX pwsh found in PATH — cannot create symlink." -ForegroundColor Red
        return $false
    }

    $msixDir = Split-Path $msixPath
    Write-Host "  Granting SYSTEM read+execute on: $msixDir" -ForegroundColor DarkGray
    icacls $msixDir /grant "SYSTEM:(OI)(CI)RX" /T | Out-Null

    $symlinkDir = Split-Path $ps7Path
    if (-not (Test-Path $symlinkDir)) {
        New-Item -ItemType Directory -Path $symlinkDir -Force | Out-Null
    }
    if (Test-Path $ps7Path) { Remove-Item $ps7Path -Force }

    New-Item -ItemType SymbolicLink -Path $ps7Path -Target $msixPath | Out-Null
    Write-Host "  Symlink created:" -ForegroundColor Green
    Write-Host "    $ps7Path" -ForegroundColor Green
    Write-Host "    -> $msixPath" -ForegroundColor DarkGray
    Write-Host ""
    Write-Host "  Remember: re-run this script after each PS7 update to refresh the symlink." -ForegroundColor Yellow
    return $true
}

function Offer-Ps7Symlink {
    # Shows the MSIX warning and offers to create the symlink interactively.
    # Returns $true if the symlink was created successfully.
    Show-Ps7MsiWarning
    if (-not $msixPath) {
        Write-Host ""
        Write-Host "  No MSIX pwsh detected. Install PS7 6.x MSI from GitHub for a stable setup:" -ForegroundColor Yellow
        Write-Host "    https://github.com/PowerShell/PowerShell/releases/tag/v7.6.2" -ForegroundColor Cyan
        return $false
    }

    Write-Host ""
    Write-Host "  MSIX version found: $msixPath" -ForegroundColor Cyan
    Write-Host "  A symlink + SYSTEM ACL grant can make it work as the SSH shell." -ForegroundColor DarkGray
    $ans = (Read-Host "  Create symlink? [y/N]").Trim()
    if ($ans -ieq 'y') {
        return (New-Ps7Symlink)
    }
    return $false
}

# ---------------------------------------------------------------------------
# Non-interactive: -Shell flag
# ---------------------------------------------------------------------------
if ($Shell -eq 'PS7') {
    if ($ps7MsiPresent) {
        Set-SshShell -Path $ps7Path -Label "PowerShell 7"
        exit 0
    }
    # MSI path missing — offer symlink if MSIX is present
    if (Offer-Ps7Symlink) {
        Set-SshShell -Path $ps7Path -Label "PowerShell 7 (via symlink)"
    } else {
        Write-Host ""
        Write-Host "  No changes made. Set PS5 instead with: .\ssh-shell.ps1 -Shell PS5" -ForegroundColor DarkGray
    }
    exit 0
}

if ($Shell -eq 'PS5') {
    Set-SshShell -Path $ps5Path -Label "PowerShell 5"
    exit 0
}

# ---------------------------------------------------------------------------
# Interactive
# ---------------------------------------------------------------------------
Write-Host "`nSSH Shell Configuration" -ForegroundColor Cyan
Write-Host "-----------------------" -ForegroundColor DarkGray
Write-Host ""

if ($ps7MsiPresent) {
    Write-Host "  [1] PowerShell 7 (MSI)   $ps7Path" -ForegroundColor White
} elseif ($msixPath) {
    Write-Host "  [1] PowerShell 7 (MSIX)  symlink workaround available — see note above" -ForegroundColor Yellow
} else {
    Write-Host "  [1] PowerShell 7         not installed" -ForegroundColor DarkGray
}
Write-Host "  [2] PowerShell 5         $ps5Path" -ForegroundColor White
Write-Host ""

$raw = Read-Host "Select shell [2]"
$choice = $raw.Trim()

if ($choice -eq '' -or $choice -eq '2') {
    Set-SshShell -Path $ps5Path -Label "PowerShell 5"
} elseif ($choice -eq '1') {
    if ($ps7MsiPresent) {
        Set-SshShell -Path $ps7Path -Label "PowerShell 7"
    } else {
        if (Offer-Ps7Symlink) {
            Set-SshShell -Path $ps7Path -Label "PowerShell 7 (via symlink)"
        } else {
            Write-Host ""
            Write-Host "  Falling back to PowerShell 5." -ForegroundColor Yellow
            Set-SshShell -Path $ps5Path -Label "PowerShell 5"
        }
    }
} else {
    Write-Warning "Invalid selection '$choice'. No changes made."
    exit 1
}
