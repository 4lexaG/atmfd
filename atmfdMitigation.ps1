
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
