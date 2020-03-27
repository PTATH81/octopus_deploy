<#
.Synopsis
   Installs OctopusDeploy Server
.NOTES
   Installation Requirements: https://octopus.com/docs/installation/requirements
.COMPONENT
   The component this cmdlet belongs to
.ROLE
   Octopus Deploy Master Node
#>


$path = 'C:\Program Files\Octopus Deploy\Octopus'


if ((Test-Path $path) -eq $false) {

    msiexec /i C:\vagrant\Octopus.2019.12.3-x64.msi /quiet RUNMANAGERONEXIT=no
}

else {

    Write-Host "Path exist!"
}

Start-Sleep 60
Set-Location $path

.\Octopus.Server.exe create-instance --instance "OctopusServer" --config "C:\Octopus\OctopusServer.config" --serverNodeName "OCTOPUSMASTER"
.\Octopus.Server.exe database --instance "OctopusServer" --connectionString "Data Source=(local)\SQLEXPRESS;Initial Catalog=octopus;Integrated Security=True" --create --grant "NT AUTHORITY\SYSTEM"
.\Octopus.Server.exe configure --instance "OctopusServer" --webForceSSL "False" --webListenPrefixes "http://localhost:80/" --commsListenPort "10943" --usernamePasswordIsEnabled "True"
.\Octopus.Server.exe service --instance "OctopusServer" --stop
.\Octopus.Server.exe admin --instance "OctopusServer" --username "admin" --email "admin@admin.com" --password "es0n.rar"
.\Octopus.Server.exe license --instance "OctopusServer" --licenseBase64 "PExpY2Vuc2UgU2lnbmF0dXJlPSJhamJmWml2MFh4VzhOcFV2TysrNHVtVHd5TGpDR1pGSkIwT3RZbHROQzZJczFGVVh5Z3Fvb2t3b0JZREkyVWpraTQvNzdTaTQ4U1RGTHphQmc1RDlLZz09Ij4NCiAgPExpY2Vuc2VkVG8+YXhzPC9MaWNlbnNlZFRvPg0KICA8TGljZW5zZUtleT41MzY2My0zMTY2My0yNTQyOS05MjQ5MjwvTGljZW5zZUtleT4NCiAgPFZlcnNpb24+Mi4wPCEtLSBMaWNlbnNlIFNjaGVtYSBWZXJzaW9uIC0tPjwvVmVyc2lvbj4NCiAgPFZhbGlkRnJvbT4yMDIwLTAxLTMxPC9WYWxpZEZyb20+DQogIDxLaW5kPlN1YnNjcmlwdGlvbjwvS2luZD4NCiAgPFZhbGlkVG8+MjAyMS0wMS0zMTwvVmFsaWRUbz4NCiAgPFByb2plY3RMaW1pdD5VbmxpbWl0ZWQ8L1Byb2plY3RMaW1pdD4NCiAgPE1hY2hpbmVMaW1pdD4xMDwvTWFjaGluZUxpbWl0Pg0KICA8VXNlckxpbWl0PlVubGltaXRlZDwvVXNlckxpbWl0Pg0KICA8Tm9kZUxpbWl0PlVubGltaXRlZDwvTm9kZUxpbWl0Pg0KICA8U3BhY2VMaW1pdD5VbmxpbWl0ZWQ8L1NwYWNlTGltaXQ+DQogIDxUYXNrQ2FwPjU8L1Rhc2tDYXA+DQo8L0xpY2Vuc2U+"
.\Octopus.Server.exe service --instance "OctopusServer" --install --reconfigure --start #--dependOn "MSSQL$SQLEXPRESS"