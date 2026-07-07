# vim: ft=ps1

# Create C source/header file pairs
# Usage: cfiles [-d <dir>] <name> [name2 ...]
function cfiles {
    _Create-FilePairs "c" "h" $args
}

# Create C++ source/header file pairs
# Usage: cpfiles [-d <dir>] <name> [name2 ...]
function cpfiles {
    _Create-FilePairs "cxx" "hxx" $args
}

function _Create-FilePairs {
    param($ext1, $ext2)
    $dir = "."
    $names = @()
    $i = 0
    while ($i -lt $args.Count) {
        if ($args[$i] -eq "-d") {
            $i++
            $dir = $args[$i]
        } else {
            $names += $args[$i]
        }
        $i++
    }
    if ($names.Count -eq 0) { Write-Error "At least one filename required"; return }
    New-Item -Type Directory -Path $dir -Force | Out-Null
    foreach ($name in $names) {
        New-Item -Path "$dir\$name.$ext1" -Force | Out-Null
        New-Item -Path "$dir\$name.$ext2" -Force | Out-Null
        Write-Host "Created $name.$ext1 and $name.$ext2 in $dir\"
    }
}

# Create an empty CMakeLists.txt
# Usage: cmakel [-f]
function cmakel {
    if ((Test-Path "CMakeLists.txt") -and ($args -notcontains "-f")) {
        Write-Error "CMakeLists.txt already exists. Use -f to force creation with backup."
        return
    }
    if (Test-Path "CMakeLists.txt") {
        Copy-Item "CMakeLists.txt" "CMakeLists.txt.bak"
        Write-Host "Backed up existing CMakeLists.txt"
    }
    New-Item -Path "CMakeLists.txt" -Force | Out-Null
    Write-Host "Created empty CMakeLists.txt"
}

# Clipboard helpers (Windows)
function clip  { $input | Set-Clipboard }
function tclip { $input | Tee-Object -Variable _out | Set-Clipboard; $_out }
