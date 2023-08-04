# ---------------------------------------------------
# -  Author: Jim Roton
# -    Date: 2023.07.30
# -    Desc: Replaces a string value in a file
#       using a pattern and a value. This script
#       is good when you want to replace a placeholder
#       value in a file with the actual value.
#
# - Example: Replace-String -Path "C:\Myfile.txt" -Pattern "foo" -Replacement "bar"
# ---------------------------------------------------
[CmdletBinding(DefaultParameterSetName = 'ReplaceFile')]
param(
    [Parameter(
        Position            = 0,
        Mandatory           = $True,
        HelpMessage         = "String to be processed.",
        ParameterSetName    = "ReplaceValue"
    )]
    [String] $Value,
    [Parameter(
        Position            = 0,
        Mandatory           = $True,
        HelpMessage         = "Path to the file to be processed.",
        ParameterSetName    = "ReplaceFile"
    )]
    [String] $Path,
    [Parameter(
        Position            = 1,
        Mandatory           = $True,
        HelpMessage         = "Regex pattern for value to be replaced."
    )]
    [String] $Pattern,
    [Parameter(
        Position            = 2,
        Mandatory           = $True,
        HelpMessage         = "Value to be used in replace--new value."
    )]
    [String] $Replacement
)

if ($PSCmdlet.ParameterSetName -eq "ReplaceFile") {
    Write-Host "Path: '$Path'";
} else {
    Write-host "Value: '$Value'";
}
Write-Host "Pattern: '$Pattern'";
Write-Host "Replacement: '$Replacement'";
Write-Host

try{

    if ($PSCmdlet.ParameterSetName -eq "ReplaceFile") {
        If ((Test-Path -Path $Path -PathType Leaf) -ne $True){
            throw "The path '$($Path)' does not exist or is not a file.";
        }

        $Value = Get-Content -Path $Path -ErrorAction Stop;
    }

    $RxMatches = $Value -Match $Pattern;

    if ($RxMatches.Length -eq 0) {
        throw "Not text was found using pattern '$($Pattern)'."
    } else {
        $RxMatches | ForEach-Object { Write-Host "Text: '$($_)'" }
    }

    $RxMatches | ForEach-Object {
        $Value = $Value -Replace [Regex]::Escape("$_"),  "$Replacement";
    } -ErrorAction Stop;

    if ($PSCmdlet.ParameterSetName -eq "ReplaceFile") {
        Set-Content -Path $Path -Value $Value -ErrorAction Stop;
    } else {
        Return $Value;
    }

    Write-Host
    Write-Host -ForegroundColor Green "Success";
}
catch{
    Write-Host -ForegroundColor Red "Error: $_";
}