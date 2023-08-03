# ---------------------------------------------------
# -  Author: Jim Roton
# -    Date: 2023.07.25
# -    Desc: Returns the FileVersion of a file. The
#       file must be an executable file or dynamic
#       link library file.
#
# - Example: Get-ItemVersion -Path "C:\MySample.dll"
# ---------------------------------------------------
param(
    [Parameter(
        Position    = 1,
        Mandatory   = $True,
        HelpMessage = "Path to the dll or executable file."
    )]
    [String]$Path
)

try {

    # make sure the file exists and is a file
    If ((Test-Path -Path $Path -PathType Leaf) -ne $True){
        throw "The path '$($Path)' does not exist or is not a file.";

    # make sure the file is exe or dll
    } elseif ((".exe", ".dll" -Contains (Get-Item -Path $Path).Extension) -ne $True) {
        (Get-Item -Path $Path).Extension;
        throw "The file '$($Path)' is not an executable or dynamic link library.";
    }

    # get file version
    $FileVersion = (Get-Item -Path $Path).VersionInfo.FileVersion;

    # check for value
    if ($null -eq $FileVersion){
        throw "The file '$(Path)' does not have a version number.";
    }

    return $FileVersion;
    
} catch {
    Write-Host -ForegroundColor Red $_;
}

