# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "precise64"
  
  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  config.vm.provision :shell, :path => "puppet_master.sh"

  config.vm.define :master do |master_config|
    master_config.vm.provider "virtualbox" do |v|
      # Advanced VM sizes - only enable if computer can handle it
      v.customize ["modifyvm", :id, "--memory", "2048"]
      v.customize ["modifyvm", :id, "--cpus", "2"]
      # Base vm sizes
      # v.customize ["modifyvm", :id, "--memory", "512"]
      # v.customize ["modifyvm", :id, "--cpus", "1"]
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
    master_config.vm.network "private_network", ip: "192.168.2.10"
        
    # Share an additional folder to the guest VM. The first argument is
    # an identifier, the second is the path on the guest to mount the
    # folder, and the third is the path on the host to the actual folder.
      
    # Enable the Puppet provisioner
    master_config.vm.provision "puppet" do |puppet| 
      puppet.module_path = "VagrantConf/modules"
      puppet.manifests_path = "VagrantConf/manifests" 
      puppet.manifest_file  = "master.pp"
      #:working_directory => "/tmp/vagrant-puppet/manifests
    end

    master_config.vm.synced_folder "puppet/manifests", "/etc/puppet/manifests"
    master_config.vm.synced_folder "puppet/modules", "/etc/puppet/modules"
    master_config.vm.synced_folder "puppet/hieradata", "/etc/puppet/hieradata"
  end

  config.vm.define :dash do |dash|

    dash.vm.hostname = "dashboard.nacswildcats.dev"
    dash.vm.network "private_network", ip: "192.168.2.11"

    dash.vm.provision "puppet" do |puppet|
      puppet.module_path = "VagrantConf/modules" 
      puppet.manifests_path = "VagrantConf/manifests" 
      puppet.manifest_file  = "dashboard.pp"
      #:working_directory => "/tmp/vagrant-puppet/manifests"
    end

    dash.vm.provider "virtualbox" do |v|
      v.customize ["modifyvm", :id, "--memory", "512"]
      v.customize ["modifyvm", :id, "--cpus", "1"]
    end
  end  

  config.vm.define :db do |db|

    db.vm.hostname = "puppetdb.nacswildcats.dev"
    db.vm.network "private_network", ip: "192.168.2.12"

    db.vm.provision "puppet" do |puppet| 
      puppet.module_path = "VagrantConf/modules"
      puppet.manifests_path = "VagrantConf/manifests"
      puppet.manifest_file  = "db.pp"
      # :working_directory => "/tmp/vagrant-puppet/manifests"
    end
   
    db.vm.provider "virtualbox" do |v|
      v.customize ["modifyvm", :id, "--memory", "512"]
      v.customize ["modifyvm", :id, "--cpus", "1"]
    end
  end
  
  
end
