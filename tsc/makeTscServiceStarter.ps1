$ServiceName = "tscStarter"
$ExecPath = "C:\Windows\Setup\State\tsc\tscStarter.exe"
$AppDirectory = "C:\Windows\Setup\State\tsc"

..\nssm install $ServiceName $ExecPath
..\nssm set $ServiceName AppDirectory $AppDirectory
..\nssm set $ServiceName Start SERVICE_AUTO_START
..\nssm set $ServiceName AppStopMethodConsole 30000