param(
    [Parameter(Mandatory=$true)]
    [String]$Path,
    [Parameter(Mandatory=$true)]
    [String]$Pattern,
    [Parameter(Mandatory=$true)]
    [String]$Replacement
)

Write-Host "Path: '$Path'";
Write-Host "Pattern: '$Pattern'";
Write-Host "Replacement: '$Replacement'";
Write-Host

try{

    If ((Test-Path -Path $Path -PathType Leaf) -ne $True){
        throw "The path '$($Path)' does not exist or is not a file.";
    }

    $Value = Get-Content -Path $Path -ErrorAction Stop;
    $RxMatches = $Value -Match $Pattern;

    if ($RxMatches -eq $False) {
        throw "Not text was found using pattern '$($Pattern)'."
    } else {
        $RxMatches | ForEach-Object { Write-Host "Text: '$($_)'" }
    }

    $RxMatches | ForEach-Object {
        $Value = $Value -Replace [Regex]::Escape("$_"),  "$Replacement";
    } -ErrorAction Stop;

    Set-Content -Path $Path -Value $Value -ErrorAction Stop;

    Write-Host
    Write-Host -ForegroundColor Green "Success";
}
catch{
    Write-Host -ForegroundColor Red "Error: $_";
}