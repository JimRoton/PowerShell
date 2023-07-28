[CmdletBinding(DefaultParameterSetName = 'ItemPath')]
param(
    [Parameter(
        Position            = 0,
        Mandatory           = $False,
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
        Position            = 1,
        Mandatory           = $False,
        HelpMessage         = "Filter for selecting items.",
        ParameterSetName    = "ItemPath"
    )]
    [String] $Pattern       = "",
    [Parameter(
        Mandatory           = $False,
        HelpMessage         = "Show verbose logging messages."
    )]
    [Switch] $Log       = $False
)

Function IIf($If, $Right, $Wrong) {
    If ($If) { $Right } Else { $Wrong }
}

Function Log($Message, $LogType = "Green") {
    if ($Log){
        Write-Host -ForegroundColor $LogType $Message;
    }
}

Function DoReplace ($Pattern, $Value) {

    Log -Message "Value: $($Value)";

    foreach ($_ in $Pattern){
        Log -Message "Pattern: '$($_)'";

        if ($Value -Match $_){
            $Value = $Value.Replace($_, "");
        }
    }

    return $Value;
}

try {

    # get item list by filter
    if ($null -eq $ItemList){
#        $ItemList = Start-Process -FilePath "git" -ArgumentList "status", "-s" -WorkingDirectory $Path -PassThru -ErrorAction Stop;
        $FileList = (git $FilePath status -s);

        foreach ($_ in $FileList) {
            $UpdatedList = DoReplace -Pattern ("^ M ", "^\?\? ") -Value $_;
        }

        $FileList = $UpdatedList;
    }

    $FileList;
} catch {
    Write-Host -ForegroundColor Red $_;
}



