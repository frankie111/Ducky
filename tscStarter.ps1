$delay = 5000
while($True){
    $status = ./tailscale status
    if($status -eq "Tailscale is stopped." -or $status.GetType().Name -eq "String"){
        Write-Host "Attempting connection!"
      ./tailscale up --reset --authkey=tskey-knFKi74CNTRL-EbsV55iGXQWMJ1xAvSWvnC --accept-routes --unattended --accept-dns --force-reauth 
    } else {
        Write-Host "Tailscale is connected!"
        Write-Host $status
    }
    Start-Sleep -Milliseconds $delay
}