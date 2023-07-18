param(
    [Parameter(Mandatory    = $True)]
    [String]$Pattern,
    [Parameter(Mandatory    = $True)]
    [String]$ScriptBlock,
    [Parameter(Mandatory    = $False)]
    [Switch]$IsAntipattern,
    [Parameter(Mandatory    = $False)]
    [Int]$WaitInterval      = 3,
    [Parameter(Mandatory    = $False)]
    [Int]$TimeoutInterval   = -1
)

    # loop until timeout
    While ($TimeoutInterval -ne 0)
    {
        Write-Host "Searching..."

        # execute script block and search for pattern
        $rtn = Select-String -Pattern $Pattern -InputObject ([ScriptBlock]::Create($ScriptBlock).Invoke());

        # return if pattern is found (or not found)
        if ((($rtn -ne $null) -and !$IsAntipattern) -or (($rtn -eq $null) -and $IsAntipattern)){

            Write-Host "Found It!";
            
            break;
        }

        # sleep for interval
        Start-Sleep $WaitInterval;

        # depricate timeout interval
        if ($TimeoutInterval -gt 0) { $TimeoutInterval--; }
    }
