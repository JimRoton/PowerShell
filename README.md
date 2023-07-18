# PowerShell
A collection of PowerShell Scripts


Strings/WaitFor-Pattern.ps1
- Summary: Waits for a pattern in a string and returns "Found It" when the string is discovered in the string. Good for running a command that outputs a string and waiting for some given text in the string output.
- Inputs: 
  Pattern: The string pattern to wait for
  ScriptBlock: The script block to run which returns a string.
  IsAntiPattern: (Optional) Return 'Found It' when the string IS NOT found.
  WaitInterval: (Optional) In seconds, the time to wait between executions of Script Block (default is 5).
  TimeoutInterval: (Optional) Number of loops before giving up (default is unlimited).
- Example: WaitFor-Pattern.ps1 -Pattern "Registered" -ScriptBlock {az feature show --name EncryptionAtHost --namespace Microsoft.Compute}
  This example uses WaitFor-Pattern along with Azure to return a string of output indicating that a provider has been registered. WaitFor-Pattern continues to call Azure, returning when the provider has been registered and the proper string is returned. Using the Patternt o wait until the string "Registered" is being returned.
- Example: WaitFor-Pattern.ps1 -Pattern "Registering" -ScriptBlock {az feature show --name EncryptionAtHost --namespace Microsoft.Computer} -IsAntiPattern
  This example uses WAitFor-Pattern along with Azure to return a string of output indicating that a provider has been registered. WaitFor-Pattern continues to call Azure, return when the provider has been registered and the proper string is returned. Using the AntiPattern to wait until the stirng "Registering" is no longer being returned.

