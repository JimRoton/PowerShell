# PowerShell
A collection of PowerShell Scripts

Items/Rename-Items.ps1

- Summary: Renames multiple items given a 'OldValue' and 'NewValue'. Optionally provide a 'FileList' as list, path, filter, or script. Optionally perform operation as recurse

- Inputs:
     OldValue: String value to be replaced.
     NewValue: String value to replace with.
     ItemList: (Optional) List of items to perform replace on.
  ScriptBlock: (Optional) Script to generate list of items to perfrom replace on.
       Filter: (Optional) Filter used to generate list of items to perform replace on.
         Path: (Optional) Path used to generate list of items to perform replace on.
      Recurse: (Optional) Recurse switch used with Path to generate a recurse list of items.

- Example: Rename-Items -OldValue "foo" -NewValue "bar";
- Example: Rename-Items -OldValue "foo" -NewValue "bar" -Filter "*.txt"
- Example: Rename-Items -OldValue "foo" -NewValue "bar" -Filter "*.txt" -Recurse
- Example: Rename-Items -OldValue "foo" -NewValue "bar" -Path "..\FooBar\" -Filter "*.txt" -Recurse
- Example: Rename-Items -OldValue "foo" -NewValue "bar" -ItemList $ItemList
- Example: Rename-Items -OldValue "foo" -NewValue "bar" -ScriptBlock { Get-ChildItem }

--------------------------------------------------------------------------------

Strings/WaitFor-Pattern.ps1

- Summary: Waits for a pattern in a string and returns "Found It" when the string is discovered in the string. Good for running a command that outputs a string and waiting for some given text in the string output.

- Inputs: 
          Pattern: The string pattern to wait for
      ScriptBlock: The script block to run which returns a string.
     WaitInterval: (Optional) In seconds, the time to wait between executions of Script Block (default: 0).
  TimeoutInterval: (Optional) Number of loops before giving up (default: indefinite).
    IsAntiPattern: (Optional) Return 'Found It' when the string IS NOT found.

- Example: WaitFor-Pattern -Pattern "12:00" -ScriptBlock { Get-Date }
- Example: WaitFor-Pattern -Pattern "12:00" -ScriptBlock { Get-Date } -WaitInterval 1
- Example: WaitFor-Pattern -Pattern "12:00" -ScriptBlock { Get-Date } -WaitInterval 1 -TimeoutInterval 60
- Example: WaitFor-Pattern -Pattern "12:00" -ScriptBlock { Get-Date } -WaitInterval 1 -TimeoutInterval 60 -IsAntipattern

