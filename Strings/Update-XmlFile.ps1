param(
    [Parameter(Mandatory=$true)]
    [String]$FilePath,
    [Parameter(Mandatory=$true)]
    [String]$XmlKeyPath,
    [Parameter(Mandatory=$true)]
    [String]$XmlKeyValue
)

Write-Host "FilePath: '$FilePath'";
Write-Host "XmlKeyPath: '$XmlKeyPath'";
Write-Host "XmlKeyValue: '$XmlKeyValue'";
Write-Host

try{

    #resolve path
    $FilePath = Resolve-Path -Path $FilePath;

    # check file exists
    If ((Test-Path -Path $FilePath -PathType Leaf) -ne $True){
        throw "The path '$($FilePath)' does not exist or is not a file.";
    }

    # get xml
    [Xml] $XmlDoc = Get-Content -Path $FilePath -ErrorAction Stop;

    # select node
    $Node = $XmlDoc.SelectSingleNode($XmlKeyPath);

    # check node exists
    if ($null -eq $Node) {
        throw "The key path '$($XmlKeyPath)' does not exist in the file.";
    }

    # set node value
    $Node.Value = $XmlKeyValue;

    Write-Host "Node.Value: $($Node.Value)";

    # save xml
    $XmlDoc.Save($FilePath);

    Write-Host
    Write-Host -ForegroundColor Green "Success";
}
catch{
    Write-Host -ForegroundColor Red "Error: $_";
}