# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define :master do |master_config|
    # Every Vagrant virtual environment requires a box to build off of.
    master_config.vm.box = "hashicorp/precise64"

    # The url from where the 'config.vm.box' box will be fetched if it
    # doesn't already exist on the user's system.
    #master_config.vm.box_url = "http://files.vagrantup.com/precise64.box"

    master_config.vm.provision :shell, :path => "puppet_master.sh"
    master_config.vm.provider "virtualbox" do |v|
      # Advanced VM sizes - only enable if computer can handle it
      #v.customize ["modifyvm", :id, "--memory", "2048"]
      #v.customize ["modifyvm", :id, "--cpus", "2"]
      # Base vm sizes
       v.customize ["modifyvm", :id, "--memory", "512"]
       v.customize ["modifyvm", :id, "--cpus", "1"]
    end

    # All Vagrant configuration is done here. The most common configuration
    # options are documented and commented below. For a complete reference,
    # please see the online documentation at vagrantup.com.
    master_config.vm.hostname = "puppet.nacswildcats.dev"

    # If you're using VMWare Fusion rather than Virtualbox, you'll want to use this box_url instead
    # master_config.vm.box_url = "http://files.vagrantup.com/precise64_vmware_fusion.box"

    # Assign this VM to a host-only network IP, allowing you to access it
    # via the IP. Host-only networks can talk to the host machine as well as
    # any other machines on the same network, but cannot be accessed (through this
    # network interface) by any external networks.
<<<<<<< HEAD
    #master_config.vm.network "public_network", :bridge => 'en4: USB Ethernet', ip: "192.168.2.10"
    master_config.vm.network "private_network", ip: "192.168.2.10"

=======
    master_config.vm.network "public_network", :bridge => 'en4: Thunderbolt Ethernet', ip: "192.168.2.10"
    # master_config.vm.network "private_network", ip: "192.168.2.10"
        
>>>>>>> 863c74ca6dd529a722b8f118353fa09108a1d5f3
    # Share an additional folder to the guest VM. The first argument is
    # an identifier, the second is the path on the guest to mount the
    # folder, and the third is the path on the host to the actual folder.

    # Enable the Puppet provisioner
    master_config.vm.provision "puppet" do |puppet|
      puppet.module_path = "VagrantConf/modules"
      puppet.manifests_path = "VagrantConf/manifests"
      puppet.manifest_file  = "master.pp"
      puppet.working_directory = "/tmp/vagrant-puppet/manifests"
    end

#    master_config.vm.synced_folder "puppet", "/etc/puppet"
    master_config.vm.synced_folder "puppet/manifests", "/etc/puppet/manifests"
    master_config.vm.synced_folder "puppet/modules", "/etc/puppet/modules"
  end

  config.vm.define :xp do |windows_config|
    # Configure base box parameters
    windows_config.vm.box = "windowsxp"
    windows_config.vm.box_url = "http://tech.napoleonareaschools.org/wp-content/uploads/windowsxp.box"
    windows_config.vm.guest = :windows

    windows_config.vm.boot_timeout = 600
    # Port forward WinRM and RDP
    windows_config.vm.network :forwarded_port, guest: 3389, host: 3389
    windows_config.vm.network :forwarded_port, guest: 5985, host: 5985, id: "winrm", auto_correct: true
<<<<<<< HEAD
    #windows_config.vm.network "public_network", :bridge => 'en4: USB Ethernet', ip: "192.168.2.100"
    windows_config.vm.network :private_network, ip: "192.168.2.100"
=======
    windows_config.vm.network "public_network", :bridge => 'en4: Thunderbolt Ethernet', ip: "192.168.2.100"
    #windows_condfig.vm.network "private_network", ip: "192.168.2.100"
>>>>>>> 863c74ca6dd529a722b8f118353fa09108a1d5f3

    # Provider
    windows_config.vm.provider "virtualbox" do |v|
      v.gui =true
    end
  end

  config.vm.define :pdb do |pdb_config|
    # Set Hostname
    pdb_config.vm.hostname = "pdb.nacswildcats.dev"

    pdb_config.vm.network "private_network", ip: "192.168.2.11"

    # Set box
    pdb_config.vm.box = "hashicorp/precise64"

    # The url from where the 'master_config.vm.box' box will be fetched if it
    # doesn't already exist on the user's system.
    #pdb_config.vm.box_url = "http://files.vagrantup.com/precise64.box"

    pdb_config.vm.provision :shell, :path => "puppet_master.sh"

    # Enable the Puppet provisioner
    pdb_config.vm.provision "puppet" do |puppet|
      puppet.module_path = "VagrantConf/modules"
      puppet.manifests_path = "VagrantConf/manifests"
      puppet.manifest_file  = "pdb.pp"
      puppet.working_directory = "/tmp/vagrant-puppet/manifests"
    end

  end

  config.vm.define :dash do |dash_config|
    # Set Hostname
    dash_config.vm.hostname = "puppetdb.nacswildcats.dev"

    dash_config.vm.network "private_network", ip: "192.168.2.12"

    # Set box
    dash_config.vm.box = "hashicorp/precise64"

    # The url from where the 'master_config.vm.box' box will be fetched if it
    # doesn't already exist on the user's system.
    #dash_config.vm.box_url = "http://files.vagrantup.com/precise64.box"

    dash_config.vm.provision :shell, :path => "puppet_master.sh"

    # Enable the Puppet provisioner
    dash_config.vm.provision "puppet" do |puppet|
      puppet.module_path = "VagrantConf/modules"
      puppet.manifests_path = "VagrantConf/manifests"
      puppet.manifest_file  = "dashboard.pp"
      puppet.working_directory = "/tmp/vagrant-puppet/manifests"
    end

  end

end
