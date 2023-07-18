# ---------------------------------------------------
# -  Author: Jim Roton
# -    Date: 2023.07.17
# -    Desc: Renames multiple items given a 'OldValue'
#       and 'NewValue'. Optionally provide a 'FileList'
#       as list, path, filter, or script. Optionally
#       perform operation as recurse
#
# - Example: Rename-Items -OldValue "foo" -NewValue "bar";
# - Example: Rename-Items -OldValue "foo" -NewValue "bar" -Filter "*.txt"
# - Example: Rename-Items -OldValue "foo" -NewValue "bar" -Filter "*.txt" -Recurse
# - Example: Rename-Items -OldValue "foo" -NewValue "bar" -Path "..\FooBar\" -Filter "*.txt" -Recurse
# - Example: Rename-Items -OldValue "foo" -NewValue "bar" -ItemList $ItemList
# - Example: Rename-Items -OldValue "foo" -NewValue "bar" -ScriptBlock { Get-ChildItem }
# ---------------------------------------------------
[CmdletBinding(DefaultParameterSetName = 'ItemList')]
param(
    [Parameter(
        Position            = 0,
        Mandatory           = $True,
        HelpMessage         = "String value to be replaced.")]
    [String]$OldValue,
    [Parameter(
        Position            = 1,
        Mandatory           = $True,
        HelpMessage         = "String value to replace with.")]
    [String]$NewValue,
    [Parameter(
        ParameterSetName    = "ItemList",
        HelpMessage         = "(Optional) List of items to perform replace on.")]
    [Object[]]$ItemList,
    [Parameter(
        ParameterSetName    = "ItemList",
        HelpMessage         = "(Optional) Script to generate list of items to perfrom replace on.")]
    [String]$ScriptBlock,
    [Parameter(
        ParameterSetName    = "ItemList",
        HelpMessage         = "(Optional) Filter used to generate list of items to perform replace on.")]
    [Parameter(
        ParameterSetName    = "Recurse",
        HelpMessage         = "(Optional) Filter used to generate list of items to perform replace on.")]
    [String]$Filter         = "*",
    [Parameter(
        ParameterSetName    = "Recurse",
        HelpMessage         = "(Optional) Path used to generate list of items to perform replace on.")]
    [String]$Path           = ".",
    [Parameter(
        ParameterSetName    = "Recurse",
        HelpMessage         = "(Optional) Recurse switch used with Path to generate a recurse list of items.")]
    [Switch]$Recurse
)

try {

    # if scriptblock was provided
    if ($ScriptBlock){
        $ItemList = Invoke-Command -ScriptBlock ([ScriptBlock]::Create($ScriptBlock)) -ErrorAction Stop;
    }

    # if file pattern was provided
    elseif ($Filter){
        if ($Recurse){
            $ItemList = Get-ChildItem -Path $Path -Filter $Filter -ErrorAction Stop -Recurse;
        } else {
            $ItemList = Get-ChildItem -Path $Path -Filter $Filter -ErrorAction Stop;
        }
    }

    # if no list then use local directory list
    elseif ($ItemList -eq $null){
        $ItemList = Get-ChildItem;
    }

    # if list generated, perform rename
    if ($ItemList){
        $ItemList | Rename-Item -NewName { $_.Name -Replace $OldValue, $NewValue } -ErrorAction Stop;

        Write-Host "$($ItemList.Count) items renamed."
    } else {
        Write-Host "0 items renamed."
    }

} catch {
    Write-Host -ForegroundColor Red $_;
}
