#!/usr/bin/env pwsh
################################################################################
#
#   Create symlinks for PowerShell / Windows dotfiles
#   Run from the dotfiles directory (or anywhere — uses git root)
#   Symlinks preferred; falls back to junctions (dirs) or hardlinks (files) without elevation
#
################################################################################

# Resolve dotfiles root via git
$dotfilesDir = (git rev-parse --show-toplevel).Trim()
if ($LASTEXITCODE -ne 0) {
    Write-Error "Not inside a git repository. Run this from the dotfiles directory."
    exit 1
}
$cfg = "$dotfilesDir\config"

function Test-SymlinkSupport {
    $tmp = Join-Path $env:TEMP "symlink-probe-$(New-Guid)"
    try {
        New-Item -ItemType SymbolicLink -Path $tmp -Target $env:TEMP -ErrorAction Stop | Out-Null
        Remove-Item $tmp -Force
        return $true
    } catch {
        return $false
    }
}

$useSymlinks = Test-SymlinkSupport
if (-not $useSymlinks) {
    Write-Host ""
    Write-Host "  WARNING: Symlinks unavailable — falling back to junctions (dirs) and hardlinks (files)." -ForegroundColor Yellow
    Write-Host "  For proper symlinks: Settings -> System -> For developers -> Developer Mode, then re-run." -ForegroundColor DarkGray
    Write-Host ""
}

function New-Symlink {
    param($Target, $Link)
    if (-not (Test-Path $Target)) {
        Write-Warning "  skipped: target not found: $Target"
        return
    }
    if (Test-Path $Link) {
        $existing = Get-Item $Link -Force
        if ($existing.LinkType -in 'SymbolicLink', 'HardLink', 'Junction') {
            Write-Host "  already linked: $Link" -ForegroundColor DarkGray
            return
        }
        # Safety: refuse to delete a real (non-symlink) directory
        if ($existing.PSIsContainer) {
            Write-Warning "  skipped: real directory exists at $Link — remove manually first"
            return
        }
        Remove-Item $Link -Recurse -Force
    }
    $linkParent = Split-Path -Parent $Link
    if (-not (Test-Path $linkParent)) {
        New-Item -Type Directory -Path $linkParent -Force | Out-Null
    }
    $isDir = (Get-Item $Target).PSIsContainer
    if ($useSymlinks) {
        New-Item -ItemType SymbolicLink -Path $Link -Target $Target -ErrorAction Stop | Out-Null
        Write-Host "  linked: $Link -> $Target" -ForegroundColor Green
    } elseif ($isDir) {
        New-Item -ItemType Junction -Path $Link -Target $Target | Out-Null
        Write-Host "  junctioned: $Link -> $Target" -ForegroundColor Yellow
    } else {
        New-Item -ItemType HardLink -Path $Link -Target $Target | Out-Null
        Write-Host "  hardlinked: $Link -> $Target" -ForegroundColor Yellow
    }
}

function Test-Cmd { param($name) [bool](Get-Command $name -ErrorAction SilentlyContinue) }

# ---------------------------------------------------------------------------
# Check for optional recommended tools and warn if missing
# ---------------------------------------------------------------------------
Write-Host "`nChecking recommended tools..." -ForegroundColor Cyan
$recommended = [ordered]@{
    'starship'  = 'winget install Starship.Starship'
    'nvim'      = 'winget install Neovim.Neovim'
    'eza'       = 'winget install eza-community.eza'
    'bat'       = 'winget install sharkdp.bat'
    'rg'        = 'winget install BurntSushi.ripgrep.MSVC'
    'delta'     = 'winget install dandavison.delta'
    'fzf'       = 'winget install junegunn.fzf'
    'zoxide'    = 'winget install ajeetdsouza.zoxide'
    'alacritty' = 'winget install Alacritty.Alacritty'
    'kitty'     = 'winget install kovidgoyal.kitty'
    'tmux'      = 'winget install tmux'
    'vim'       = 'winget install vim.vim'
    'npm'       = 'winget install OpenJS.NodeJS'
    'wget'      = 'winget install GNU.Wget2'
    'git'       = 'winget install Git.Git'
}
foreach ($tool in $recommended.Keys) {
    if (Test-Cmd $tool) {
        Write-Host "  ✅ $tool" -ForegroundColor Green
    } else {
        Write-Host "  ❌ $tool  (install: $($recommended[$tool]))" -ForegroundColor Yellow
    }
}

if (Get-Module -ListAvailable -Name PSFzf -ErrorAction SilentlyContinue) {
    Write-Host "  ✅ PSFzf" -ForegroundColor Green
} else {
    Write-Host "  ❌ PSFzf  (install: Install-Module -Name PSFzf)" -ForegroundColor Yellow
}

# ---------------------------------------------------------------------------
# PowerShell
# ---------------------------------------------------------------------------
Write-Host "`nPowerShell..." -ForegroundColor Cyan
New-Symlink -Target "$cfg\powershell\profile.ps1" -Link $PROFILE
New-Symlink -Target "$cfg\powershell\profile.ps1" `
            -Link   "$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"

# ---------------------------------------------------------------------------
# Git
# ---------------------------------------------------------------------------
Write-Host "`nGit..." -ForegroundColor Cyan

$gitconfigPath = "$HOME\.gitconfig"
if (-not (Test-Path $gitconfigPath)) {
    New-Item -Path $gitconfigPath -ItemType File -Force | Out-Null
}
$gitconfigContent = Get-Content $gitconfigPath -Raw -ErrorAction SilentlyContinue

# Ensure [user] section exists
if ($gitconfigContent -notmatch '(?m)^\[user\]') {
    Write-Host "  No [user] found — enter your git identity:" -ForegroundColor Yellow
    $gitName  = Read-Host "  Name"
    $gitEmail = Read-Host "  Email"
    git config --global user.name  $gitName
    git config --global user.email $gitEmail
    Write-Host "  Set user: $gitName <$gitEmail>" -ForegroundColor Green
} else {
    $existing = "$(git config --global user.name) <$(git config --global user.email)>"
    Write-Host "  [user] already set: $existing" -ForegroundColor DarkGray
}

# Ensure [include] points to dotfiles git config
$includeTarget = "~/Documents/dotfiles/config/git/config"
if ($gitconfigContent -notmatch [regex]::Escape($includeTarget)) {
    git config --global include.path $includeTarget
    Write-Host "  Added [include] -> dotfiles git config" -ForegroundColor Green
} else {
    Write-Host "  [include] already present" -ForegroundColor DarkGray
}

# Symlink git ignore into XDG path
New-Symlink -Target "$cfg\git\ignore" -Link "$HOME\.config\git\ignore"

# ---------------------------------------------------------------------------
# Starship
# ---------------------------------------------------------------------------
if (Test-Cmd starship) {
    Write-Host "`nStarship..." -ForegroundColor Cyan
    New-Symlink -Target "$cfg\starship.toml" -Link "$HOME\.config\starship.toml"
}

# ---------------------------------------------------------------------------
# Neovim  (%LOCALAPPDATA%\nvim)
# ---------------------------------------------------------------------------
if (Test-Cmd nvim) {
    Write-Host "`nNeovim..." -ForegroundColor Cyan
    New-Symlink -Target "$cfg\nvim" -Link "$env:LOCALAPPDATA\nvim"
}

# ---------------------------------------------------------------------------
# Alacritty  (%APPDATA%\alacritty)
# ---------------------------------------------------------------------------
if (Test-Cmd alacritty) {
    Write-Host "`nAlacritty..." -ForegroundColor Cyan
    New-Symlink -Target "$cfg\alacritty\alacritty.yml" `
                -Link   "$env:APPDATA\alacritty\alacritty.yml"
}

# ---------------------------------------------------------------------------
# bat  (%APPDATA%\bat)
# ---------------------------------------------------------------------------
if (Test-Cmd bat) {
    Write-Host "`nbat..." -ForegroundColor Cyan
    New-Symlink -Target "$cfg\bat" -Link "$env:APPDATA\bat"
}

# ---------------------------------------------------------------------------
# kitty  (%APPDATA%\kitty)
# ---------------------------------------------------------------------------
if (Test-Cmd kitty) {
    Write-Host "`nkitty..." -ForegroundColor Cyan
    New-Symlink -Target "$cfg\kitty" -Link "$env:APPDATA\kitty"
}

# ---------------------------------------------------------------------------
# npm  (~/.npmrc)
# ---------------------------------------------------------------------------
if (Test-Cmd npm) {
    Write-Host "`nnpm..." -ForegroundColor Cyan
    New-Symlink -Target "$cfg\npm\npmrc" -Link "$HOME\.npmrc"
}

# ---------------------------------------------------------------------------
# tmux  (~/.tmux.conf)
# ---------------------------------------------------------------------------
if (Test-Cmd tmux) {
    Write-Host "`ntmux..." -ForegroundColor Cyan
    New-Symlink -Target "$cfg\tmux\tmux.conf"       -Link "$HOME\.tmux.conf"
    New-Symlink -Target "$cfg\tmux\tmux.reset.conf" -Link "$HOME\.tmux.reset.conf"
}

# ---------------------------------------------------------------------------
# Vim  (~/.vimrc)
# ---------------------------------------------------------------------------
if (Test-Cmd vim) {
    Write-Host "`nVim..." -ForegroundColor Cyan
    New-Symlink -Target "$cfg\vim\vimrc" -Link "$HOME\.vimrc"
}

# ---------------------------------------------------------------------------
# wget  (~/.wgetrc)
# ---------------------------------------------------------------------------
if (Test-Cmd wget) {
    Write-Host "`nwget..." -ForegroundColor Cyan
    New-Symlink -Target "$cfg\wget\wgetrc" -Link "$HOME\.wgetrc"
}

# ---------------------------------------------------------------------------
# Python  ($PYTHONSTARTUP → ~/.pythonrc)
# ---------------------------------------------------------------------------
if (Test-Cmd python) {
    Write-Host "`nPython..." -ForegroundColor Cyan
    New-Symlink -Target "$cfg\python\pythonrc" -Link "$HOME\.pythonrc"
    Write-Host "  note: set PYTHONSTARTUP=$HOME\.pythonrc in your environment" -ForegroundColor DarkGray
}

Write-Host "`nDone! Restart your shell or run: . `$PROFILE" -ForegroundColor Green
