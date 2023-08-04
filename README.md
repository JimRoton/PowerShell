# PowerShell Scripts
A collection of PowerShell Scripts that perform various functions that would normally require multiple commands and/or planning. Sometimes you need to perform a simple task, but one that requires multiple steps, such as gathering a list of files and then renaming all of them. These types of tasks can be completed easily using PowerShell, but require multiple commands, piping and managing variables. These scripts are designed to be a slight extension to the normal commands that PowerShell provides so that you can perform these kinds of slightly more complex tasks without the need to remember multiple commands and how to pipe them together.

Table of Contents
=================

 - [Get-ItemVersion](#get-itemversion)
 - [Get-Add-Items](#get-additems)
 - [Increment-Version](#increment-version)
 - [Rename-Items](#rename-items)
 - [Replace-String](#replace-string)
 - [Start-AsAdmin](#start-asadmin)
 - [Update-PipelineVariable](#update-pipelinevariable)
 - [WaitFor-Pattern](#waitfor-pattern)

--------------------------------------------------------------------------------

Get-ItemVersion
===============

Summary: Returns the FileVersion of a file. The file must be an executable file or dynamic link library file.

Locations:
----------
[Items/Get-ItemVersion.ps1](https://github.com/JimRoton/PowerShell/blob/main/Items/Get-ItemVersion.ps1)

Inputs:
-------
&nbsp;&nbsp;- Path: Path to the dll or executable file.<br>

Examples:
---------
    Get-ItemVersion -Path "C:\MySample.dll"

--------------------------------------------------------------------------------

GitAdd-Items
===========

Summary: (WIP) Get files that have been modified for git and...

Location:
---------
[Items/GitAdd-Items.ps1](https://github.com/JimRoton/PowerShell/blob/main/Items/GitAdd-Items.ps1)

Inputs:
-------
&nbsp;&nbsp;- ItemList: Items to git.add.<br>
&nbsp;&nbsp;- Path: Path to search for items.<br>
&nbsp;&nbsp;- Pattern: Filter for selecting items.<br>
&nbsp;&nbsp;- Log: Show verbose logging messages.<br>

Examples:
--------
    GitAdd-Items
    GitAdd-Items -ItemList [List of files in git repo]
    GitAdd-Items -Path "C:\Repos\MyRepo"
    GitAdd-Items -Path "C:\Repos\MyRepo" -Pattern "*.xml"
    GitAdd-Items -Path "C:\Repos\MyRepo" -Pattern "*.xml" -Log

--------------------------------------------------------------------------------

Increment-Version
=================

Summary: Accepts a version number as a string: xxx.xxx.xxx.xxx and an optional AND value to indicate which parts of the version should be incremented. By default the build number is incremented.

Location:
---------
[Strings/Increment-Version.ps1](https://github.com/JimRoton/PowerShell/blob/main/Strings/Increment-Version.ps1)

Inputs:
-------
&nbsp;&nbsp;- Version: Version string to increment.<br>
&nbsp;&nbsp;- Increment: Values to be updated as (AND).<br>

Examples:
---------
    Increment-Version -Version "1.0.0.1"
    Increment-Version -Version "1.0.0.1" -Increment 2

--------------------------------------------------------------------------------

Rename-Items
============

Summary: Renames multiple items given a 'OldValue' and 'NewValue'. Optionally provide a 'FileList' as list, path, filter, or script. Optionally perform operation as recurse

Location:
---------
[Items/Rename-Items.ps1](https://github.com/JimRoton/PowerShell/blob/main/Items/Rename-Items.ps1)

Inputs:
-------
&nbsp;&nbsp;- OldValue: String value to be replaced.<br>
&nbsp;&nbsp;- NewValue: String value to replace with.<br>
&nbsp;&nbsp;- ItemList: (Optional) List of items to perform replace on.<br>
&nbsp;&nbsp;- ScriptBlock: (Optional) Script to generate list of items to perfrom replace on.<br>
&nbsp;&nbsp;- Filter: (Optional) Filter used to generate list of items to perform replace on.<br>
&nbsp;&nbsp;- Path: (Optional) Path used to generate list of items to perform replace on.<br>
&nbsp;&nbsp;- Recurse: (Optional) Recurse switch used with Path to generate a recurse list of items.<br>

Examples:
---------
    Rename-Items -OldValue "foo" -NewValue "bar";
    Rename-Items -OldValue "foo" -NewValue "bar" -Filter "*.txt";
    Rename-Items -OldValue "foo" -NewValue "bar" -Filter "*.txt" -Recurse;
    Rename-Items -OldValue "foo" -NewValue "bar" -Path "..\FooBar\" -Filter "*.txt" -Recurse;
    Rename-Items -OldValue "foo" -NewValue "bar" -ItemList $ItemList;
    Rename-Items -OldValue "foo" -NewValue "bar" -ScriptBlock { Get-ChildItem };

--------------------------------------------------------------------------------

Replace-String
==============

Summary: Replaces a string value in a file using a pattern and a value. This script is good when you want to replace a placeholder value in a file with the actual value.

Location:
---------
[Strings/Replace-String.ps1](https://github.com/JimRoton/PowerShell/blob/main/Strings/Replace-String.ps1)

Inputs:
-------
&nbsp;&nbsp;- Path: Path to the file to be processed.<br>
&nbsp;&nbsp;- Pattern: Regex pattern for value to be replaced.<br>
&nbsp;&nbsp;- Replacement: Value to be used in replace--new value.<br>

Examples:
---------
    Replace-String -Path "C:\Myfile.txt" -Pattern "foo" -Replacement "bar"

--------------------------------------------------------------------------------

Start-AsAdmin
=============

Summary: Run any process with elevated privilages.

Location:
---------
[Processes/Start-AsAdmin.ps1](https://github.com/JimRoton/PowerShell/blob/main/Processes/Start-AsAdmin.ps1)

Inputs:
-------
&nbsp;&nbsp;- FilePath: Process to run as administrator.<br>
&nbsp;&nbsp;- Arguments: Additional arguments passed to process.<br>

Examples:
---------
    Start-AsAdmin -FilePath "cmd";
    Start-AsAdmin -FilePath "cmd" -Arguments "/c help";

--------------------------------------------------------------------------------

Update-PipelineVariable
=======================

Summar: Updates an Azure pipeline variable group item value. Using the varible group ID and access token, this script updates the variable value. This script is good when you need to use a variable group value in another task on your pipeline and then update it from a different task.

Location:
---------
[Azure/Update-PipelineVariable.ps1](https://github.com/JimRoton/PowerShell/blob/main/Azure/Update-PipelineVariable.ps1)

Inputs:
-------
&nbsp;&nbsp;- VariableGroupId: Azure DevOps Variable Group ID<br>
&nbsp;&nbsp;- VariableName: Azure DevOps Variable Name<br>
&nbsp;&nbsp;- VariableName: Azure DevOps Variable Value<br>
&nbsp;&nbsp;- AccessToken: Access Token<br>

Examples:
---------
    Update-PipelineVariable `
      -VariableGroupId 01 `
      -VariableName 'foo' `
      -VariableValue 'bar' `
      -AccessToken $System.AccessToken;

--------------------------------------------------------------------------------

WaitFor-Pattern
===============

Summary: Waits for a pattern in a string and returns "Found It" when the string is discovered in the string. Good for running a command that outputs a string and waiting for some given text in the string output.

Location:
---------
[Strings/WaitFor-Pattern.ps1](https://github.com/JimRoton/PowerShell/blob/main/Strings/WaitFor-Pattern.ps1)

Inputs:
-------
&nbsp;&nbsp;- Pattern: The string pattern to wait for.<br>
&nbsp;&nbsp;- ScriptBlock: The script block to run which returns a string.<br>
&nbsp;&nbsp;- WaitInterval: (Optional) In seconds, the time to wait between executions of Script Block (default: 0).<br>
&nbsp;&nbsp;- TimeoutInterval: (Optional) Number of loops before giving up (default: indefinite).<br>
&nbsp;&nbsp;- IsAntiPattern: (Optional) Return 'Found It' when the string IS NOT found.<br>

Examples:
---------
    WaitFor-Pattern -Pattern "12:00" -ScriptBlock { Get-Date }
    WaitFor-Pattern -Pattern "12:00" -ScriptBlock { Get-Date } -WaitInterval 1
    WaitFor-Pattern -Pattern "12:00" -ScriptBlock { Get-Date } -WaitInterval 1 -TimeoutInterval 60
    WaitFor-Pattern -Pattern "12:00" -ScriptBlock { Get-Date } -WaitInterval 1 -TimeoutInterval 60 -IsAntipattern
