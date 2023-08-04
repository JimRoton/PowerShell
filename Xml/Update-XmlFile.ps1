# ---------------------------------------------------
# -  Author: Jim Roton
# -    Date: 2023.07.17
# -    Desc: Updates a value in a key within a an
#       XML file. This script is good when you want
#       to update a value in an XML file and then
#       save the XML back to the file.
#
# - Example: Update-XmlFile -FilePath "C:\MyFile.xml" -XmlKeyPath "//mysection/mysubscetion/mykey" -XmlKeyValue "myvalue"
# ---------------------------------------------------
param(
    [Parameter(
        Position    = 0,
        Mandatory   = $True,
        HelpMessage = "Path to XML file."
    )]
    [String] $FilePath,
    [Parameter(
        Position    = 1,
        Mandatory   = $True,
        HelpMessage = "XPath to key to be updated."
    )]
    [String] $XmlKeyPath,
    [Parameter(
        Position    = 2,
        Mandatory   = $True,
        HelpMessage = "New value to be updated."
    )]
    [String] $XmlKeyValue
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