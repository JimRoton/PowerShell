[CmdletBinding(DefaultParameterSetName = 'ItemList')]
param(
    [Parameter(Mandatory = $True)]
    [String]$OldValue,
    [Parameter(Mandatory = $True)]
    [String]$NewValue,
    
    [Parameter(ParameterSetName="ItemList")]
    [Object[]]$ItemList,
    [Parameter(ParameterSetName="ItemList")]
    [String]$ScriptBlock,
    [Parameter(ParameterSetName="ItemList")]
    [Parameter(Mandatory = $True, ParameterSetName="Recurse")]
    [String]$Filter,
    [Parameter(ParameterSetName="Recurse")]
    [String]$Path = ".",
    [Parameter(ParameterSetName="Recurse")]
    [Switch]$Recurse
)

# if scriptblock was provided
if ($ScriptBlock){
    $ItemList = ([ScriptBlock]::Create($ScriptBlock).Invoke());
}

# if file pattern was provided
elseif ($Filter){
    if ($Recurse){
        $ItemList = Get-ChildItem -Path $Path -Filter $Filter -Recurse;
    } else {
        $ItemList = Get-ChildItem -Path $Path -Filter $Filter;
    }
}

elseif ($ItemList -eq $null){
    $ItemList = Get-ChildItem;
}

if ($ItemList){
    $ItemList | Rename-Item -NewName { $_.Name -Replace $OldValue, $NewValue }
}
