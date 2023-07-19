# ---------------------------------------------------
# -  Author: Jim Roton
# -    Date: 2023.07.18
# -    Desc: Run any process with elevated privilages.
#
# - Example: Start-AsAdmin
# - Example: Start-AsAdmin -FilePath "cmd.exe"
# - Example: Start-AsAdmin -FilePath "cmd.exe" -Arguments "/C help"
# ---------------------------------------------------
param(
    [Parameter(
        Position        = 0,
        Mandatory       = $True,
        HelpMessage     = "Process to run as administrator."
    )]
    [String] $FilePath,
    [Parameter(
        Position        = 1,
        Mandatory       = $False,
        HelpMessage     = "Additional arguments passed to process."
    )]
    [String[]] $Arguments
)

try {
    # $verbs = New-Object System.Diagnostics.ProcessStartInfo -Args $FilePath
    # $verbs;
    # use runas on windows
    if ($IsWindows){
        Start-Process -FilePath "pwsh" -ArgumentList (@("-noexit") + @("-command") + @($FilePath) + @($Arguments)) -Verb RunAs -ErrorAction Stop;

    # use sudo on mac and linux
    } else {
        Start-Process -FilePath "sudo" -ArgumentList (@($FilePath) + @($Arguments)) -ErrorAction Stop;
    }
} catch {
    Write-Host -ForegroundColor Red $_;
}
