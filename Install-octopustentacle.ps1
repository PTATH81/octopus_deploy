<#
.Synopsis
   Installs OctopusDeploy Tentacle
.NOTES
   Installation Requirements:
.COMPONENT
   The component this cmdlet belongs to
.ROLE
   Octopus Deploy worker node
#>

msiexec /i C:\axsops\Octopus.Tentacle.5.0.12-x64.msi /quiet

Start-Sleep 30

Set-Location "C:\Program Files\Octopus Deploy\Tentacle"


.\Tentacle.exe create-instance --instance "Tentacle" --config "C:\Octopus\Tentacle.config" --console
.\Tentacle.exe new-certificate --instance "Tentacle" --if-blank --console
.\Tentacle.exe configure --instance "Tentacle" --reset-trust --console
.\Tentacle.exe configure --instance "Tentacle" --home "C:\Octopus" --app "C:\Octopus\Applications" --port "10933" --console
.\Tentacle.exe configure --instance "Tentacle" --trust "2C309D143DBF700703453D72F0A899F2E3617001" --console
netsh advfirewall firewall add rule "name=Octopus Deploy Tentacle" dir=in action=allow protocol=TCP localport=10933 # SETS FIREWALL RULE
.\Tentacle.exe register-with --instance "Tentacle" --server "http://10.10.10.100" --apiKey="API-PQY2WQDVTCX69KEOOE14TJQOTW" -h "10.10.10.51" --role "web-server" --environment "dev" --comms-style TentaclePassive --console
.\Tentacle.exe service --instance "Tentacle" --install --start --console


NetSh Advfirewall set allprofiles state off