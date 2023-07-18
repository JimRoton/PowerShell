# ---------------------------------------------------
# -  Author: Jim Roton
# -    Date: 2023.07.17
# -    Desc: Waits for a pattern in a string and returns "Found It" when the pattern is discovered
#       in the string. Good for running a command that outputs a string as its return and waiting for
#       some given pattern in the string output before exuting some downstream command.
#
# - Example: WaitFor-Pattern -Pattern "12:00" -ScriptBlock { Get-Date }
# - Example: WaitFor-Pattern -Pattern "12:00" -ScriptBlock { Get-Date } -WaitInterval 1
# - Example: WaitFor-Pattern -Pattern "12:00" -ScriptBlock { Get-Date } -WaitInterval 1 -TimeoutInterval 60
# - Example: WaitFor-Pattern -Pattern "12:00" -ScriptBlock { Get-Date } -WaitInterval 1 -TimeoutInterval 60 -IsAntipattern
# ---------------------------------------------------
param(
    [Parameter(
        Position            = 0,
        Mandatory           = $True,
        HelpMessage         = "Pattern to search for in script output.")]
    [String]$Pattern,
    [Parameter(
        Position            = 1,
        Mandatory           = $True,
        HelpMessage         = "Script to generate string output.")]
    [scriptblock]$ScriptBlock,
    [Parameter(
        Mandatory           = $False,
        HelpMessage         = "Designates the seconds to wait between attempts.")]
    [Int]$WaitInterval      = 0,
    [Parameter(
        Mandatory           = $False,
        HelpMessage         = "Designates number of attempts before giving up.")]
    [Int]$TimeoutInterval   = -1,
    [Parameter(
        Mandatory           = $False,
        HelpMessage         = "Flips pattern to antipattern 'NOT IN'.")]
    [Switch]$IsAntipattern
)

try {
    # loop until timeout
    While ($TimeoutInterval -ne 0)
    {
        Write-Host "Waiting..."

        # execute script block and search for pattern
        $val = Invoke-Command -ScriptBlock $ScriptBlock -ErrorAction Stop;
        $rtn = Select-String -Pattern $Pattern -InputObject $val -ErrorAction Stop;

        # return if pattern is found (or not found)
        if ((($rtn -ne $null) -and !$IsAntipattern) -or (($rtn -eq $null) -and $IsAntipattern)){

            Write-Host "Found It!";
            
            break;
        }

        # sleep for interval
        Start-Sleep $WaitInterval -ErrorAction Stop;

        # depricate timeout interval
        if ($TimeoutInterval -gt 0) { $TimeoutInterval--; }
    }
} catch {
    Write-Host -ForegroundColor Red $_;
}
