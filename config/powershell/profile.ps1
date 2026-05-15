# vim: ft=ps1
##############################################################
#   ____                        ____  _   _
#  |  _ \ _____      _____ _ __/ ___|| | | |
#  | |_) / _ \ \ /\ / / _ \ '__\___ \| |_| |
#  |  __/ (_) \ V  V /  __/ |   ___) |  _  |
#  |_|   \___/ \_/\_/ \___|_|  |____/|_| |_|
##############################################################

# Resolve real path through symlink so sub-files are found in dotfiles dir
$_self = Get-Item $MyInvocation.MyCommand.Path
if ($_self.LinkType) {
    $PSScriptDir = Split-Path -Parent $_self.Target
} else {
    $PSScriptDir = Split-Path -Parent $_self.FullName
}

# Source aliases and functions
. "$PSScriptDir\aliases.ps1"
. "$PSScriptDir\functions.ps1"

# {{{ Starship prompt
if (Get-Command starship -ErrorAction SilentlyContinue) {
    Invoke-Expression (&starship init powershell)
}
# }}}

# {{{ Zoxide (smarter cd — use 'z' to jump)
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    Invoke-Expression (& { (zoxide init powershell | Out-String) })
}
# }}}

# {{{ PSFzf (Ctrl+R history search, Ctrl+T file finder)
# Install with: Install-Module -Name PSFzf
if ((Get-Command fzf -ErrorAction SilentlyContinue) -and
    (Get-Module -ListAvailable -Name PSFzf -ErrorAction SilentlyContinue)) {
    Import-Module PSFzf
    Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
}
# }}}
