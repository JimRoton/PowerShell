# ---------------------------------------------------
# -  Author: Jim Roton
# -    Date: 2023.07.18
# -    Desc: Run any process with elevated privilages (Windows only). Defaults to running a new
#       PowerShell window as administrator.
#
# - Example: Start-AsAdmin
# - Example: Start-AsAdmin -FilePath "cmd.exe"
# - Example: Start-AsAdmin -FilePath "pwsh.exe" -Arguments "-noexit", "-command ""cmd.exe /C help"""
# ---------------------------------------------------
param(
    [Parameter(
        Position        = 0,
        Mandatory       = $False,
        HelpMessage     = "Process to run as administrator."
    )]
    [String] $FilePath  = "pwsh.exe",
    [Parameter(
        Position        = 1,
        Mandatory       = $False,
        HelpMessage     = "Additional arguments passed to process."
    )]
    [String[]] $Arguments
)

try {

    # use runas on windows
    if ($IsWindows){
        Start-Process -FilePath $FilePath -ArgumentList $Arguments -Verb RunAs -ErrorAction Stop;

    # use sudo on mac and linux
    } else {
        Start-Process -FilePath "sudo" -ArgumentList (@($FilePath) + @($Arguments));
    }
} catch {
    Write-Host -ForegroundColor Red $_;
}
