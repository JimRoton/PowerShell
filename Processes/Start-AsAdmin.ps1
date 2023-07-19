# ---------------------------------------------------
# -  Author: Jim Roton
# -    Date: 2023.07.18
# -    Desc: Run any process with elevated privilages. Defaults to running a new
#       PowerShell window as administrator.
#
# - Example: Start-AsAdmin
# - Example: Start-AsAdmin -FilePath "cmd.exe"
# - Example: Start-AsAdmin -FilePath ""
# ---------------------------------------------------
param(
    [Parameter(
        Position        = 0,
        Mandatory       = $False,
        HelpMessage     = "Process to run as administrator."
    )]
    [String] $FilePath  = "pwsh",
    [Parameter(
        Position        = 1,
        Mandatory       = $False,
        HelpMessage     = "Additional arguments passed to process."
    )]
    [String[]] $Arguments
)

try {
    Start-Process -FilePath $FilePath -ArgumentList $Arguments -Verb RunAs -ErrorAction Stop;

} catch {
    Write-Host -ForegroundColor Red $_;
}
