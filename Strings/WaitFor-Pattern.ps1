param(
    [Parameter(Mandatory=$True)]
    [String]$Pattern,
    
    [Parameter(Mandatory=$True)]
    [String]$ScriptBlock,

    [Parameter(Mandatory=$True)]
    [Switch]$IsAntipattern
)

    while ($true)
    {
        Write-Host "Searching..."

        $rtn = Select-String -Pattern $Pattern -InputObject ([ScriptBlock]::Create($ScriptBlock).Invoke());

        if ((($rtn -ne $null) -and !$IsAntipattern) -or (($rtn -eq $null) -and $IsAntipattern)){

            Write-Host "Found It!";
            
            break;
        }

        Start-Sleep 5;
    }
