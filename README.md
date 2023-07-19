# PowerShell Scripts
A collection of PowerShell Scripts that perform various functions that would normally require multiple commands and/or planning. Sometimes you need to perform a simple task, but one that requires multiple steps, such as gathering a list of files and then renaming all of them. These types of tasks can be completed easily using PowerShell, but require multiple commands, piping and managing variables. These scripts are designed to be a slight extension to the normal commands that PowerShell provides so that you can perform these kinds of slightly more complex tasks without the need to remember multiple commands and how to pipe them together.

Table of Contents
=================

 - [Rename-Items](#Items-Rename-Items)
 - [WaitFor-Pattern](#Strings-WaitFor-Pattern)

Items/Rename-Items
==================

Summary: Renames multiple items given a 'OldValue' and 'NewValue'. Optionally provide a 'FileList' as list, path, filter, or script. Optionally perform operation as recurse

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

Strings/WaitFor-Pattern
=======================

Summary: Waits for a pattern in a string and returns "Found It" when the string is discovered in the string. Good for running a command that outputs a string and waiting for some given text in the string output.

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

