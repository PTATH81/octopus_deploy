<#
#variable Set
$dns = (Get-DnsClientServerAddress -InterfaceAlias "Ethernet")

#set dns server to 9.9.9.9 for dns resolution.
if ($dns.ServerAddresses -ne '9.9.9.9') {

  Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses "9.9.9.9"
}

elseif ($dns.ServerAddresses -eq '9.9.9.9') {

  Write-Host "Dns already set as" $dns.ServerAddresses
  #install chocolatey
  ﻿Write-Host "You are about to install Chocolatey!"
#>

$feature = ('web-server','web-mgmt-tools','telnet-client')

Install-WindowsFeature -Name $feature

$choco_install = Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))


$choco_install

#choco.exe install git -y
choco.exe install googlechrome --checksum "FE0AA8BC26564AC460C129FF3BB522788E052F28B8479B5F0E2156A4C6A356B0" -y
choco.exe install sql-server-express -y
#choco.exe install notepadplusplus -y

NetSh Advfirewall set allprofiles state off