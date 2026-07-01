#!/usr/bin/env pwsh
# chezmoi: runs on Windows when script content changes.
# Creates junctions/symlinks from Windows tool paths to chezmoi-managed ~/.config/ locations.

$cfg = "$env:USERPROFILE\.config"

function New-Link {
    param($Target, $Link)
    if (-not (Test-Path $Target)) { return }
    if (Test-Path $Link) {
        $e = Get-Item $Link -Force
        if ($e.LinkType -in 'SymbolicLink', 'HardLink', 'Junction') { return }
        if ($e.PSIsContainer) { Write-Warning "real dir at $Link — remove manually"; return }
        Remove-Item $Link -Force
    }
    $parent = Split-Path -Parent $Link
    if (-not (Test-Path $parent)) { New-Item -Type Directory -Path $parent -Force | Out-Null }
    $isDir = (Get-Item $Target).PSIsContainer
    try {
        New-Item -ItemType SymbolicLink -Path $Link -Target $Target -ErrorAction Stop | Out-Null
    } catch {
        if ($isDir) { New-Item -ItemType Junction  -Path $Link -Target $Target | Out-Null }
        else         { New-Item -ItemType HardLink  -Path $Link -Target $Target | Out-Null }
    }
}

# Neovim: %LOCALAPPDATA%\nvim → ~/.config/nvim
New-Link "$cfg\nvim" "$env:LOCALAPPDATA\nvim"

# Alacritty: %APPDATA%\alacritty → ~/.config/alacritty
New-Link "$cfg\alacritty" "$env:APPDATA\alacritty"

# bat: %APPDATA%\bat → ~/.config/bat
New-Link "$cfg\bat" "$env:APPDATA\bat"

# kitty: %APPDATA%\kitty → ~/.config/kitty
New-Link "$cfg\kitty" "$env:APPDATA\kitty"

# Windows Terminal: Package LocalState\settings.json → ~/.config/windows-terminal/settings.json
$wtState = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
if (Test-Path $wtState) {
    New-Link "$cfg\windows-terminal\settings.json" "$wtState\settings.json"
}

# PS5 profile (WindowsPowerShell) → same file as PS7 (PowerShell)
New-Link "$env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" `
         "$env:USERPROFILE\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"

# Python: ~/.pythonrc → ~/.config/python/pythonrc  (set PYTHONSTARTUP=~/.pythonrc)
New-Link "$cfg\python\pythonrc" "$env:USERPROFILE\.pythonrc"

# npm: ~/.npmrc → ~/.config/npm/npmrc
New-Link "$cfg\npm\npmrc" "$env:USERPROFILE\.npmrc"

# tmux: ~/.tmux.conf → ~/.config/tmux/tmux.conf
New-Link "$cfg\tmux\tmux.conf"       "$env:USERPROFILE\.tmux.conf"
New-Link "$cfg\tmux\tmux.reset.conf" "$env:USERPROFILE\.tmux.reset.conf"

# vim: ~/.vimrc → ~/.config/vim/vimrc
New-Link "$cfg\vim\vimrc" "$env:USERPROFILE\.vimrc"

# wget: ~/.wgetrc → ~/.config/wget/wgetrc
New-Link "$cfg\wget\wgetrc" "$env:USERPROFILE\.wgetrc"
