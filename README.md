# atmfd
Type 1 Font Parsing Remote Code Execution Vulnerability

A vulnerability has recently been released in the Adobe Type Manager Library, which allows an attacker to run code with kernel permissions if the victim opens a file or in Windows font preview.
There are three ways to mitigate the problem, but they are highly system dependent. Disable the Windows preview panel from Explorer (the file viewer, not the browser). Disable WebClient service and rename ATMFD.DLL.
For more information see: https://portal.msrc.microsoft.com/en-us/security-guidance/advisory/adv200006

Below, you can see the script that I have created to carry out the process mentioned above.
feel free to use and improve it:

#Setting full privileges
param([switch]$Elevated)

function Test-Admin {
  $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
  $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if ((Test-Admin) -eq $false)  {
    if ($elevated) 
    {
        # tried to elevate, did not work, aborting
    } 
    else {
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
}

exit
}
'running with full privileges'

#Stopping service
Stop-Service WebClient
'service is stopped'

#Renaming files
$Thisfiles=(Get-Childitem –Path C:\ -Recurse | where {$_.Name -eq "atmfd.dll"}).fullname
  
foreach ($file in $Thisfiles) {    
  Rename-Item -Path $file -NewName "adv200006.dll"
}
'the library has been renamed'
