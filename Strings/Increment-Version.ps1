param(
    [Parameter(
        Position            = 0,
        Mandatory           = $True,
        HelpMessage         = "Version string to increment.")]
    [ValidatePattern("^(0)|(\d{1,3}).(0)|(\d{1,3}).(0)|(\d{1,3}).(0)|(\d{1,3})$")]
    [String]$Version,
    [Parameter(
        Position            = 1,
        Mandatory           = $True,
        HelpMessage         = "Values to be updated as (AND).")]
    [Int16]$Increment
)
try {
    
    Write-Host "Version: $($Version)";
    Write-Host "Increment: $($Increment)";
    Write-Host

    $Rtn = "";
    $Versions = $Version.Trim().Split('.');

    # Major
    if ($Versions.Length -gt 0) {
        if (($Increment -band 1) -eq 1) {
            [Int] $Versions[0] += 1;
        }

        $Rtn = $Versions[0].Trim();
    }

    # Minor
    if ($Versions.Length -gt 1) {
        if (($Increment -band 2) -eq 2) {
            [Int] $Versions[1] += 1;
        }

        $Rtn += "." + $Versions[1].Trim();
    }

    # Revision
    if ($Versions.Length -gt 2) {
        if (($Increment -band 4) -eq 4) {
            [Int] $Versions[2] += 1;
        }

        $Rtn += "." + $Versions[2].Trim();
    }

    # Build
    if ($Versions.Length -gt 3) {
        if (($Increment -band 8) -eq 8) {
            [Int] $Versions[3] += 1;
        }

        $Rtn += "." + $Versions[3].Trim();
    }

    Write-Host "Major: $($Versions[0])";
    Write-Host "Minor: $($Versions[1])";
    Write-Host "Revision: $($Versions[2])";
    Write-Host "Build: $($Versions[3])";

    Return $Rtn;
} catch {
    Write-Host -ForegroundColor Red "Error: $_";
}