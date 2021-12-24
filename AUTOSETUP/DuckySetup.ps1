  #check for ducky:
  If (!(Test-Path E:\INFO_UF2.TXT))
    {
        Write-Host "ERROR: Ducky not found!"
        Read-Host -Prompt "`r`nPress Enter to exit"
        Exit
    }

    Write-Host "Ducky found, Starting AutoSetup:"
    #copy circuitpython.uf2 to ducky:
    Copy-Item -Path adafruit-circuitpython-raspberry_pi_pico-en_US-7.0.0.uf2 -Destination E:\
    Read-Host -Prompt "`r`nPress Enter to exit"