# vim: ft=ps1

# {{{ Editor
$env:EDITOR = "nvim"
function e { & $env:EDITOR $args }
# }}}

# {{{ Navigation
function md  { New-Item -Type Directory -Path $args }
function mcd { New-Item -Type Directory -Path $args[0] -Force | Out-Null; Set-Location $args[0] }

if ($Host.Name -eq 'ConsoleHost') {
    # Built-in aliases (ls -> Get-ChildItem, cd -> Set-Location) take precedence
    # over same-named functions, so they must be removed first.
    Remove-Item -Path Alias:ls, Alias:cd -Force -ErrorAction SilentlyContinue

    if (Get-Command zoxide -ErrorAction SilentlyContinue) {
        function cd { if ($args) { z @args } else { z ~ } }
    }

    if (Get-Command eza -ErrorAction SilentlyContinue) {
        # Legacy per-user junctions (Application Data, Cookies, etc.) are broken/
        # self-referential reparse points on modern Windows; eza's long mode
        # readlinks every entry (even hidden ones) and hangs/errors on them.
        $ezaIgnore = 'Application Data|Cookies|Local Settings|My Documents|NetHood|PrintHood|Recent|SendTo|Start Menu|Templates'
        function ls  { eza --group-directories-first --icons --ignore-glob $ezaIgnore $args }
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
if ($Host.Name -eq 'ConsoleHost' -and (Get-Command rg -ErrorAction SilentlyContinue)) {
    function grep { rg $args }
}
# }}}

# {{{ Ping
function p { ping 9.9.9.9 }
# }}}

# {{{ Unix compat
function head {
    param([Parameter(Position=0)][string]$Arg1, [Parameter(Position=1)][string]$Arg2)
    if     ($Arg1 -match '^\d+$' -and $Arg2) { Get-Content $Arg2 | Select-Object -First ([int]$Arg1) }
    elseif ($Arg1 -match '^\d+$')             { $input | Select-Object -First ([int]$Arg1) }
    elseif ($Arg1)                             { Get-Content $Arg1 | Select-Object -First 10 }
    else                                       { $input | Select-Object -First 10 }
}
function tail {
    param([Parameter(Position=0)][string]$Arg1, [Parameter(Position=1)][string]$Arg2)
    if     ($Arg1 -match '^\d+$' -and $Arg2) { Get-Content $Arg2 | Select-Object -Last ([int]$Arg1) }
    elseif ($Arg1 -match '^\d+$')             { $input | Select-Object -Last ([int]$Arg1) }
    elseif ($Arg1)                             { Get-Content $Arg1 | Select-Object -Last 10 }
    else                                       { $input | Select-Object -Last 10 }
}
function wc   { $input | Measure-Object -Line | Select-Object -ExpandProperty Lines }
function which { Get-Command $args }
function touch {
    foreach ($f in $args) {
        if (Test-Path $f) { (Get-Item $f).LastWriteTime = Get-Date }
        else              { New-Item -ItemType File $f | Out-Null }
    }
}
# }}}
