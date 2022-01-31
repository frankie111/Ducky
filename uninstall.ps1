#stop and delete services:
$services = @("tscStarter", "Tailscale")
foreach ($service in $services){
    #cmd.exe /c sc stop $service
    #cmd.exe /c sc delete $service
}

#run uvnc uninstaller:

#delete everything in "c:\windows\setup\state" except "State.ini":
$path = "c:\windows\setup\state"
$exception = "State.ini"
cd $path
$files = dir
foreach ($file in $files){
    if($file.name -ne $exception){
        Remove-Item $file
    }
}
