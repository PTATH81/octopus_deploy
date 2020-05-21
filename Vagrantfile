# -*- mode: ruby -*-
# vi: set ft=ruby :

# Every Vagrant development environment requires a box. You can search for
# boxes at https://app.vagrantup.com/boxes/search.

VAGRANTFILE_API_VERSION = '2'
WORKERS = 1
IMAGE_TYPE = "mcree/win2019"
PROVIDER_TYPE = 'virtualbox'
SUBNET = '10.10.10'
MEM = 1024
CPU = 2

# List plugins dependencies
plugins_dependencies = %w( vagrant-vbguest )
plugin_status = false
plugins_dependencies.each do |plugin_name|
	unless Vagrant.has_plugin? plugin_name
		system("vagrant plugin install #{plugin_name}")
		plugin_status = true
		puts " #{plugin_name}  Dependencies installed"
	end


Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vbguest.auto_update = false
  #config.gatling.rsync_on_startup = true
  config.vm.box = IMAGE_TYPE
  config.vm.communicator = "winrm"
  config.vm.guest = "windows"

  config.vm.define "octopusmaster" do |master|
	#master.vm.hostname = 'octopusmaster'
    master.vm.network 'forwarded_port', guest: 80, host: 8181, auto_correct: 'true'
	master.vm.network 'private_network', ip: "#{SUBNET}.101"
	master.vm.synced_folder ".", "/vagrant", disabled: false
	master.vm.synced_folder ".", "/axsops", create: true

# Memory and vcpu
    master.vm.provider PROVIDER_TYPE do |vb|
	   vb.cpus = CPU
	   vb.memory = MEM
	   vb.gui = true
# http://www.virtualbox.org/manual/ch09.html#nat-adv-dns
	   vb.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
	   vb.customize ['modifyvm', :id, '--natdnsproxy1', 'on']
	end

# Execute script
	master.vm.provision 'install_choco', type: "shell" do |a|
	  a.path = 'Install-Choco.ps1'
	  a.name = 'Install Choco'
	  a.privileged = true
	  a.powershell_elevated_interactive = true
    end

	master.vm.provision 'install_octopusdeploy', type: "shell" do |b|
	  b.path = 'Install-octopusdeploy.ps1'
	  b.name = 'Install OctopusDeploy'
	  b.privileged = true
	  b.powershell_elevated_interactive = true
    end
  end
####################WORKERS###############################

WORKERS.times do |i|
  config.vm.define "worker#{i}".to_sym do |worker|
	#master.vm.hostname = 'octopusmaster'
    worker.vm.network 'forwarded_port', guest: 80, host: 8181, auto_correct: 'true'
	worker.vm.network 'private_network', ip: "#{SUBNET}.%d" % (50 + i + 1)
	worker.vm.synced_folder ".", "/vagrant", disabled: false
	worker.vm.synced_folder ".", "/axsops", create: true

# Memory and vcpu
    worker.vm.provider PROVIDER_TYPE do |vb_worker|
	   vb_worker.cpus = CPU
	   vb_worker.memory = MEM
	   vb_worker.gui = true
# http://www.virtualbox.org/manual/ch09.html#nat-adv-dns
	   vb_worker.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
	   vb_worker.customize ['modifyvm', :id, '--natdnsproxy1', 'on']
	end
	worker.vm.provision 'install_octopustentacle', type: "shell" do |t|
	  t.path = 'Install-octopustentacle.ps1'
	  t.name = 'Install octopustentacle'
	  t.privileged = true
	  t.powershell_elevated_interactive = true
	end
  end
 end
end
end
