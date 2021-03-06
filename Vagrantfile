# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.require_version ">= 1.7.2"
Vagrant.configure(2) do |config|
  
  config.vm.box = "ubuntu/trusty64"
  config.vm.box_check_update = true

  config.vm.hostname = "portalrevamp.dev"
  config.vm.network "private_network", ip: "192.168.56.133"

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.name = "ibwp-vagrant"
    vb.customize ["modifyvm", :id, "--memory", 1024]
    vb.customize ["modifyvm", :id, "--cpus", 1]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end

  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder "vm-files/", "/home/vagrant/vm-files"

  if Dir.exist?( "wp-content" ) then
    config.vm.synced_folder "wp-content", "/srv/portalrevamp.dev/wp-content", owner: "www-data", group: "www-data"
  end

  if Dir.exist?( "database" ) then
    config.vm.synced_folder "database", "/srv/portalrevamp.dev/database", owner: "www-data", group: "www-data"
  end
  
  config.vm.provision "fix-no-tty", type: "shell" do |s|
    s.privileged = false
    s.inline = "sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile"
  end
  
  config.vm.provision "shell", path: "vm-files/provisioning/general-server-setup.sh"
  config.vm.provision "shell", path: "vm-files/provisioning/install-nginx.sh"
  config.vm.provision "shell", path: "vm-files/provisioning/install-php.sh"
  config.vm.provision "shell", path: "vm-files/provisioning/install-mariadb.sh"
  # TODO: add db import script to run each boot that checks database folder for 
  # *.sql files to import to mysql. These .sql files must be full DB dumps.  
  config.vm.provision "shell", path: "vm-files/provisioning/install-nodejs.sh", privileged: false
  config.vm.provision "shell", path: "vm-files/provisioning/install-wordpress.sh"
end
