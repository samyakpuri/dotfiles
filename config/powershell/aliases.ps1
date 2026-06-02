# vim: ft=ps1

# {{{ Editor
$env:EDITOR = "nvim"
function e { & $env:EDITOR $args }
# }}}

# {{{ Navigation
function md  { New-Item -Type Directory -Path $args }
function mcd { New-Item -Type Directory -Path $args[0] -Force | Out-Null; Set-Location $args[0] }

if ($Host.Name -eq 'ConsoleHost') {
    if (Get-Command zoxide -ErrorAction SilentlyContinue) {
        function cd { if ($args) { z @args } else { z ~ } }
    }

    if (Get-Command eza -ErrorAction SilentlyContinue) {
        function ls  { eza --group-directories-first --icons $args }
    } else {
        function ls  { Get-ChildItem $args }
    }
    function l   { ls -lh $args }
    function ll  { ls -lah $args }
    function la  { ls -la $args }
    function sl  { ls $args }
}
# }}}

# {{{ cat / bat / less
if ($Host.Name -eq 'ConsoleHost' -and (Get-Command bat -ErrorAction SilentlyContinue)) {
    function cat  { bat --paging=never $args }
    function catt { bat $args }
    function less { bat $args }
}
# }}}

# {{{ grep -> rg
if (Get-Command rg -ErrorAction SilentlyContinue) {
    function grep { rg $args }
}
# }}}

# {{{ Ping
function p { ping 9.9.9.9 }
# }}}

# {{{ Unix compat
function head { $input | Select-Object -First $(if ($args[0]) { [int]$args[0] } else { 10 }) }
function tail { $input | Select-Object -Last  $(if ($args[0]) { [int]$args[0] } else { 10 }) }
function wc   { $input | Measure-Object -Line | Select-Object -ExpandProperty Lines }
function which { Get-Command $args }
function touch {
    foreach ($f in $args) {
        if (Test-Path $f) { (Get-Item $f).LastWriteTime = Get-Date }
        else              { New-Item -ItemType File $f | Out-Null }
    }
}
# }}}
