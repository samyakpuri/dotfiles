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
. "$PSScriptDir\git.ps1"
. "$PSScriptDir\ssh.ps1"

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

# {{{ posh-git (git subcommand + branch/tag/remote tab completion for 'git …')
# Install with: Install-Module -Name posh-git
if (Get-Module -ListAvailable -Name posh-git -ErrorAction SilentlyContinue) {
    Import-Module posh-git
}
# }}}

# {{{ Git alias tab completion — branches/refs for short aliases (works without posh-git)
if (Get-Command git -ErrorAction SilentlyContinue) {
    $branchAliases = @('g', 'gco', 'gsw', 'gsc', 'gb', 'gba', 'gbd', 'gbD', 'gcp', 'gre', 'grs', 'gd', 'gst', 'gstp')
    $gitRefCompleter = {
        param($wordToComplete, $commandAst, $cursorPosition)
        $refs = @(git branch --all 2>$null | ForEach-Object {
            $_.Trim() -replace '^\* ' -replace '^remotes/[^/]+/'
        })
        $refs += @(git tag 2>$null)
        $refs | Sort-Object -Unique | Where-Object { $_ -like "$wordToComplete*" } | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
    }
    Register-ArgumentCompleter -Native -CommandName $branchAliases -ScriptBlock $gitRefCompleter
}
# }}}

# {{{ PSReadLine (inline suggestions + tab completion like zsh/fish)
# Inline autosuggestions from history (like zsh-autosuggestions / fish)
# PredictionSource/ViewStyle require PSReadLine 2.1+ (ships with PS7; PS5 skips)
if ($PSVersionTable.PSVersion.Major -ge 7) {
    Set-PSReadLineOption -PredictionSource HistoryAndPlugin
    Set-PSReadLineOption -PredictionViewStyle InlineView
}

# Right arrow or End to accept the current inline suggestion
Set-PSReadLineKeyHandler -Key RightArrow -Function ForwardWord

# Up/Down search history by typed prefix (like zsh-history-substring-search)
Set-PSReadLineKeyHandler -Key UpArrow   -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# Tab shows scrollable menu (like zsh menuselect); overridden by PSFzf below if fzf present
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
# }}}

# {{{ PSFzf (Ctrl+R history search, Ctrl+T file finder, Tab fzf completion)
# Install with: Install-Module -Name PSFzf
if ((Get-Command fzf -ErrorAction SilentlyContinue) -and
    (Get-Module -ListAvailable -Name PSFzf -ErrorAction SilentlyContinue)) {
    Import-Module PSFzf
    Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r' -TabExpansion
}
# }}}
