# PowerShell
A collection of PowerShell Scripts

Items/Rename-Items.ps1

- Summary: Renames multiple items given a 'OldValue' and 'NewValue'. Optionally provide a 'FileList' as list, path, filter, or script. Optionally perform operation as recurse

- Inputs:<br>
&nbsp;&nbsp;- OldValue: String value to be replaced.<br>
&nbsp;&nbsp;- NewValue: String value to replace with.<br>
&nbsp;&nbsp;- ItemList: (Optional) List of items to perform replace on.<br>
&nbsp;&nbsp;- ScriptBlock: (Optional) Script to generate list of items to perfrom replace on.<br>
&nbsp;&nbsp;- Filter: (Optional) Filter used to generate list of items to perform replace on.<br>
&nbsp;&nbsp;- Path: (Optional) Path used to generate list of items to perform replace on.<br>
&nbsp;&nbsp;- Recurse: (Optional) Recurse switch used with Path to generate a recurse list of items.<br>

- Examples:<br>
&nbsp;&nbsp;- Rename-Items -OldValue "foo" -NewValue "bar";<br>
&nbsp;&nbsp;- Rename-Items -OldValue "foo" -NewValue "bar" -Filter "*.txt";<br>
&nbsp;&nbsp;- Rename-Items -OldValue "foo" -NewValue "bar" -Filter "*.txt" -Recurse;<br>
&nbsp;&nbsp;- Rename-Items -OldValue "foo" -NewValue "bar" -Path "..\FooBar\" -Filter "*.txt" -Recurse;<br>
&nbsp;&nbsp;- Rename-Items -OldValue "foo" -NewValue "bar" -ItemList $ItemList;<br>
&nbsp;&nbsp;- Rename-Items -OldValue "foo" -NewValue "bar" -ScriptBlock { Get-ChildItem };<br>

--------------------------------------------------------------------------------

Strings/WaitFor-Pattern.ps1

- Summary: Waits for a pattern in a string and returns "Found It" when the string is discovered in the string. Good for running a command that outputs a string and waiting for some given text in the string output.

- Inputs:<br>
&nbsp;&nbsp;- Pattern: The string pattern to wait for.<br>
&nbsp;&nbsp;- ScriptBlock: The script block to run which returns a string.<br>
&nbsp;&nbsp;- WaitInterval: (Optional) In seconds, the time to wait between executions of Script Block (default: 0).<br>
&nbsp;&nbsp;- TimeoutInterval: (Optional) Number of loops before giving up (default: indefinite).<br>
&nbsp;&nbsp;- IsAntiPattern: (Optional) Return 'Found It' when the string IS NOT found.<br>

- Examples:<br>
&nbsp;&nbsp;- WaitFor-Pattern -Pattern "12:00" -ScriptBlock { Get-Date }<br>
&nbsp;&nbsp;- WaitFor-Pattern -Pattern "12:00" -ScriptBlock { Get-Date } -WaitInterval 1<br>
&nbsp;&nbsp;- WaitFor-Pattern -Pattern "12:00" -ScriptBlock { Get-Date } -WaitInterval 1 -TimeoutInterval 60<br>
&nbsp;&nbsp;- WaitFor-Pattern -Pattern "12:00" -ScriptBlock { Get-Date } -WaitInterval 1 -TimeoutInterval 60 -IsAntipattern<br>

