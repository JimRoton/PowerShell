param(
    [String]$Path
)

try {
    If ((Test-Path -Path $Path -PathType Leaf) -ne $True){
        throw "The path '$($Path)' does not exist or is not a file.";
    } elseif ((".exe", ".dll" -Contains (Get-Item -Path $Path).Extension) -ne $True) {
        (Get-Item -Path $Path).Extension;
        throw "The file '$($Path)' is not an executable or dynamic link library.";
    }

    $FileVersion = (Get-Item -Path $Path).VersionInfo.FileVersion;

    if ($null -eq $FileVersion){
        throw "The file '$(Path)' does not have a version number.";
    }

    return $FileVersion;
    
} catch {
    Write-Host -ForegroundColor Red $_;
}

