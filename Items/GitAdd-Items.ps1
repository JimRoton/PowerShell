[CmdletBinding(DefaultParameterSetName = 'ItemPath')]
param(
    [Parameter(
        Position            = 0,
        Mandatory           = $True,
        HelpMessage         = "Items to git.add.",
        ParameterSetName    = "ItemList"
    )]
    [String[]] $ItemList,
    [Parameter(
        Position            = 0,
        Mandatory           = $False,
        HelpMessage         = "Path to search for items.",
        ParameterSetName    = "ItemPath"
    )]
    [String] $Path          = ".",
    [Parameter(
        Position            = 0,
        Mandatory           = $False,
        HelpMessage         = "Filter for selecting items.",
        ParameterSetName    = "ItemPath"
    )]
    [String] $Pattern        = ""
)

Function DoReplace {
    param(
        [Parameter(
            Position        = 0,
            Mandatory       = $True
        )]
        [String[]] $Pattern   = "",
        [Parameter(
            Position        = 1,
            Mandatory       = $True
        )]
        [String] $Value      = ""
    )

    foreach ($_ in $Pattern){
$Value.Match("^M ");
        $Value = $Value.Replace($_, "");
    }

    return $Value;
}

try {

    # get item list by filter
    if ($null -eq $ItemList){
#        $ItemList = Start-Process -FilePath "git" -ArgumentList "status", "-s" -WorkingDirectory $Path -PassThru -ErrorAction Stop;
        $FileList = (git $FilePath status -s);

        foreach ($_ in $FileList) {
            $UpdatedList = DoReplace -Pattern (" M ", "?? ") -Value $_;
        }

        $FileList = $UpdatedList;
    }

    $FileList;
} catch {
    Write-Host -ForegroundColor Red $_;
}



