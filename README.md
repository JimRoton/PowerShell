# PowerShell
A collection of PowerShell Scripts

Items/Rename-Items.ps1

- Summary: Renames multiple items given a 'OldValue' and 'NewValue'. Optionally provide a 'FileList' as list, path, filter, or script. Optionally perform operation as recurse

- Inputs:<br>
     OldValue: String value to be replaced.<br>
     NewValue: String value to replace with.<br>
     ItemList: (Optional) List of items to perform replace on.<br>
  ScriptBlock: (Optional) Script to generate list of items to perfrom replace on.<br>
       Filter: (Optional) Filter used to generate list of items to perform replace on.<br>
         Path: (Optional) Path used to generate list of items to perform replace on.<br>
      Recurse: (Optional) Recurse switch used with Path to generate a recurse list of items.<br>

- Examples:<br>
   Rename-Items -OldValue "foo" -NewValue "bar";<br>
   Rename-Items -OldValue "foo" -NewValue "bar" -Filter "*.txt";<br>
   Rename-Items -OldValue "foo" -NewValue "bar" -Filter "*.txt" -Recurse;<br>
   Rename-Items -OldValue "foo" -NewValue "bar" -Path "..\FooBar\" -Filter "*.txt" -Recurse;<br>
   Rename-Items -OldValue "foo" -NewValue "bar" -ItemList $ItemList;<br>
   Rename-Items -OldValue "foo" -NewValue "bar" -ScriptBlock { Get-ChildItem };<br>

--------------------------------------------------------------------------------

Strings/WaitFor-Pattern.ps1

- Summary: Waits for a pattern in a string and returns "Found It" when the string is discovered in the string. Good for running a command that outputs a string and waiting for some given text in the string output.

- Inputs:<br>
Pattern: The string pattern to wait for.<br>
      ScriptBlock: The script block to run which returns a string.<br>
     WaitInterval: (Optional) In seconds, the time to wait between executions of Script Block (default: 0).<br>
  TimeoutInterval: (Optional) Number of loops before giving up (default: indefinite).<br>
    IsAntiPattern: (Optional) Return 'Found It' when the string IS NOT found.<br>

- Example: WaitFor-Pattern -Pattern "12:00" -ScriptBlock { Get-Date }
- Example: WaitFor-Pattern -Pattern "12:00" -ScriptBlock { Get-Date } -WaitInterval 1
- Example: WaitFor-Pattern -Pattern "12:00" -ScriptBlock { Get-Date } -WaitInterval 1 -TimeoutInterval 60
- Example: WaitFor-Pattern -Pattern "12:00" -ScriptBlock { Get-Date } -WaitInterval 1 -TimeoutInterval 60 -IsAntipattern

