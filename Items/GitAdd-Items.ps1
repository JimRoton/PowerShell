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
        Mandatory           = $True,
        HelpMessage         = "Path to search for items.",
        ParameterSetName    = "ItemPath"
    )]
    [String] $Path,
    [Parameter(
        Position            = 0,
        Mandatory           = $False,
        HelpMessage         = "Filter for selecting items.",
        ParameterSetName    = "ItemPath"
    )]
    [String] $Filter
)

try {

    # get item list by filter
    if ($null -eq $ItemList){
        $ItemList = Start-Process -FilePath "git" -ArgumentList "status", "-s" -ErrorAction Stop; #Get-ChildItem -Recurse -Filter $Filter -ErrorAction Stop;  
    }

    if ($null -ne $ItemList){
        $ItemList | Start-Process -FilePath "git" -ArgumentList {"-add", $_};
    }

    $ItemList;
} catch {
    Write-Host -ForegroundColor Red $_;
}



