#!/usr/bin/env pwsh
################################################################################
#
#   Create symlinks for PowerShell / Windows dotfiles
#   Run from the dotfiles directory (or anywhere — uses git root)
#   Requires Developer Mode OR run as Administrator for symlink creation
#
################################################################################

# Resolve dotfiles root via git
$dotfilesDir = (git rev-parse --show-toplevel).Trim()
if ($LASTEXITCODE -ne 0) {
    Write-Error "Not inside a git repository. Run this from the dotfiles directory."
    exit 1
}

function New-Symlink {
    param($Target, $Link)
    if (-not (Test-Path $Target)) {
        Write-Warning "  skipped: target not found: $Target"
        return
    }
    if (Test-Path $Link) {
        $existing = Get-Item $Link -Force
        if ($existing.LinkType -eq 'SymbolicLink' -and $existing.Target -eq $Target) {
            Write-Host "  already linked: $Link" -ForegroundColor DarkGray
            return
        }
        Remove-Item $Link -Recurse -Force
    }
    $linkParent = Split-Path -Parent $Link
    if (-not (Test-Path $linkParent)) {
        New-Item -Type Directory -Path $linkParent -Force | Out-Null
    }
    New-Item -ItemType SymbolicLink -Path $Link -Target $Target | Out-Null
    Write-Host "  linked: $Link -> $Target" -ForegroundColor Green
}

# Check for optional recommended tools and warn if missing
Write-Host "`nChecking recommended tools..." -ForegroundColor Cyan
$recommended = @{
    'starship' = 'winget install Starship.Starship'
    'eza'      = 'winget install eza-community.eza'
    'bat'      = 'winget install sharkdp.bat'
    'rg'       = 'winget install BurntSushi.ripgrep.MSVC'
    'fzf'      = 'winget install junegunn.fzf'
    'zoxide'   = 'winget install ajeetdsouza.zoxide'
    'nvim'     = 'winget install Neovim.Neovim'
}
foreach ($tool in $recommended.Keys) {
    if (Get-Command $tool -ErrorAction SilentlyContinue) {
        Write-Host "  ✅ $tool" -ForegroundColor Green
    } else {
        Write-Host "  ❌ $tool  (install: $($recommended[$tool]))" -ForegroundColor Yellow
    }
}

# Check PSFzf module
if (Get-Module -ListAvailable -Name PSFzf -ErrorAction SilentlyContinue) {
    Write-Host "  ✅ PSFzf" -ForegroundColor Green
} else {
    Write-Host "  ❌ PSFzf  (install: Install-Module -Name PSFzf)" -ForegroundColor Yellow
}

Write-Host "`nCreating PowerShell symlinks..." -ForegroundColor Cyan

# PowerShell 7 profile
New-Symlink `
    -Target "$dotfilesDir\config\powershell\profile.ps1" `
    -Link   $PROFILE

# Windows PowerShell 5.1 profile
New-Symlink `
    -Target "$dotfilesDir\config\powershell\profile.ps1" `
    -Link   "$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"

# Starship config (shared with Linux — already in repo)
New-Symlink `
    -Target "$dotfilesDir\config\starship.toml" `
    -Link   "$HOME\.config\starship.toml"

Write-Host "`nDone! Restart your shell or run: . `$PROFILE" -ForegroundColor Green
