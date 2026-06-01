# vim: ft=ps1

# Common helper to resolve hostname via SSH config and wait for a port
function _Wait-ForPort {
    param(
        [string]$Name,
        [int]$Port,
        [int]$Timeout,
        [string]$Service
    )

    $startTime = [DateTime]::UtcNow

    $ipaddr = ssh -G $Name 2>$null |
              Where-Object { $_ -match '^hostname ' } |
              ForEach-Object { ($_ -split '\s+')[1] } |
              Select-Object -First 1

    if (-not $ipaddr) {
        Write-Error "Could not resolve hostname '$Name'"
        return $false
    }

    Write-Host "Waiting for $Service on $Name ($($ipaddr):$Port)..."

    while ($true) {
        $connected = $false
        try {
            $tcp = [System.Net.Sockets.TcpClient]::new()
            $ar  = $tcp.BeginConnect($ipaddr, $Port, $null, $null)
            if ($ar.AsyncWaitHandle.WaitOne(2000)) {
                $tcp.EndConnect($ar)
                $connected = $tcp.Connected
            }
        } catch {}
        finally { $tcp.Dispose() }

        if ($connected) {
            Write-Host "`n$Service available on ${Name}:${Port}"
            return $true
        }

        $elapsed = ([DateTime]::UtcNow - $startTime).TotalSeconds
        if ($elapsed -ge $Timeout) {
            Write-Host "Timeout after $Timeout seconds waiting for $Name"
            return $false
        }

        Write-Host -NoNewline '.'
        Start-Sleep -Seconds 2
    }
}

# Wait for SSH then connect
# Usage: ussh <hostname> [timeout_seconds]
function ussh {
    param(
        [Parameter(Mandatory, Position = 0)] [string]$Name,
        [Parameter(Position = 1)]            [int]$Timeout = 300
    )
    if (_Wait-ForPort -Name $Name -Port 22 -Timeout $Timeout -Service 'SSH') {
        ssh $Name
    }
}

# Wait for SSH to become available (no connect)
# Usage: wssh <hostname> [timeout_seconds]
function wssh {
    param(
        [Parameter(Mandatory, Position = 0)] [string]$Name,
        [Parameter(Position = 1)]            [int]$Timeout = 300
    )
    _Wait-ForPort -Name $Name -Port 22 -Timeout $Timeout -Service 'SSH'
}

# Wait for VNC to become available
# Usage: wvnc <hostname> [port] [timeout_seconds]
function wvnc {
    param(
        [Parameter(Mandatory, Position = 0)] [string]$Name,
        [Parameter(Position = 1)]            [int]$Port    = 5900,
        [Parameter(Position = 2)]            [int]$Timeout = 300
    )
    _Wait-ForPort -Name $Name -Port $Port -Timeout $Timeout -Service 'VNC'
}
