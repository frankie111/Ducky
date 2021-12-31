#compile ShellCon.exe:
ps2exe ".\ShellCon.ps1" ".\ShellCon.exe"

#find CIRCUITPY drive and get Root directory:
try{$drive = (Get-Volume -FriendlyName CIRCUITPY -erroraction stop)}
catch{Write-Host "Couldn't find CIRCUITPY!"}
$root = $drive.DriveLetter + ":\"

#copy ShellCon.exe, Setup.ps1, nssm.exe to CIRCUITPY:
Write-Host "Copying Invoke-ConPtyShell.ps1..."
Copy-Item -Path ".\Invoke-ConPtyShell.ps1" -Destination ($root + "Invoke-ConPtyShell.ps1")
Write-Host "Copying ShellCon.exe..."
Copy-Item -Path ".\ShellCon.exe" -Destination ($root + "ShellCon.exe")
Write-Host "Copying Setup.ps1..."
Copy-Item -Path ".\Setup.ps1" -Destination ($root + "Setup.ps1")
Write-Host "Copying nssm.exe..."
Copy-Item -Path ".\nssm.exe" -Destination ($root + "nssm.exe")
Write-Host "Copying tsc folder..."
#Get BDEF Stick drive:
try{$drive = (Get-Volume -FriendlyName BDEF -erroraction stop)}
catch{
  "Couldn't find BDEF Drive!"
  Read-Host -Prompt "`r`nPress Enter to exit"
  Exit
}
$tsc = ($drive.DriveLetter + ":\" + "tsc")

#copy tsc folder:
Copy-Item -Path .\tsc -Destination $tsc -recurse -force

Read-Host -Prompt "`r`nPress Enter to exit"