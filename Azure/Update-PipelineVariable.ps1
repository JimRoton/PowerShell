# ---------------------------------------------------
# -  Author: Jim Roton
# -    Date: 2023.07.20
# -    Desc: Updates an Azure pipeline variable
#       group item value. Using the varible group ID
#       and access token, this script updates the
#       variable value. This script is good when you
#       need to use a variable group value in another
#       task on your pipeline and then update it from
#       a different task.
#
# - Example: Update-PipelineVariable `
#               -VariableGroupId 01 `
#               -VariableName 'foo' `
#               -VariableValue 'bar' `
#               -AccessToken $System.AccessToken;
# ---------------------------------------------------
param(
    [Parameter(
        Position            = 0,
        Mandatory           = $True,
        HelpMessage         = "Azure DevOps Variable Group ID")]
    [String]$VariableGroupId,
    [Parameter(
        Position            = 1,
        Mandatory           = $True,
        HelpMessage         = "Azure DevOps Variable Name")]
    [String]$VariableName,
    [Parameter(
        Position            = 2,
        Mandatory           = $True,
        HelpMessage         = "Azure DevOps Variable Value"
    )]
    [String]$VariableValue,
    [Parameter(
        Position            = 3,
        Mandatory           = $True,
        HelpMessage         = "Access Token"
    )]
    [String]$AccessToken
)

try {

    Write-Host "VariableGroupId: $($VariableGroupId)";
    Write-Host "VariableName: $($VariableName)";
    Write-Host "VariableValue: $($VariableValue)";
    Write-Host

    # get uri for azure devops
    $Uri = "$($env:SYSTEM_TEAMFOUNDATIONCOLLECTIONURI)$env:SYSTEM_TEAMPROJECTID/_apis/distributedtask/variablegroups/$($VariableGroupId)?api-version=7.0";

    Write-Host "URL: $Uri";

    # create header
    $Headers = @{Authorization = "Bearer $AccessToken"};

    # get values
    $Values = Invoke-RestMethod `
        -Uri $Uri `
        -Headers $Headers
        -ErrorAction Stop;

    Write-Host $Values | ConvertTo-Json -Depth 100;
    
    # set new variable value
    $Values.variables.$VariableName.value = $VariableValue;

    Write-Host "Value: $($Values.variables.$VariableName.value)"

    # convert back to jason for update
    $ValuesAsJson = $Values | ConvertTo-Json -Depth 100 -Compress;

    # update value
    Invoke-RestMethod `
        -ErrorAction Stop `
        -Method Put `
        -Uri $Uri `
        -Headers $Headers `
        -ContentType "application/json" `
        -Body ([System.Text.Encoding]::UTF8.GetBytes($ValuesAsJson)) | Out-Null;

} catch {
    Write-Host -ForegroundColor Red "Error: '$($_)'";
}
