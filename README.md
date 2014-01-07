## NACS Dev PuppetMaster

Vagrant Puppet Dev Environment for testing NACS Modules

**** NOT WORKING CURRENTLY ******


## Before you begin

You will need the following packages installed to work with this:

* [Vagrant](http://vagrantup.com)
* [VirtualBox](http://www.virtualbox.org)
* Ruby - If using any variance of *nix or Mac OS X this will be installd

You will also need to install the librarian-puppet gem to install the needed modules for the puppet master.

``gem install librarian-puppet``


## Getting Startted

First you need to download the required Puppet modules - thankfully librarian-puppet will do that for you. 

``
cd  ~/nacs-dev-puppetmaster/VagrantConf
librarian-puppet install
``

When starting the Vagrant VMs, there are some cross node dependencies, so they will need to be rebooted a few times to make sure the Puppet provisioner runs completely.

```
cd ~/nacs-dev-puppetmaster
# First boot, this will fail during provisioning the Master
vagrant up
# This will boot the rest of the VMs
vagrant up
# This will reboot the VMs for the first time
vagrant reload
# This will complete the configuration of the Master
vagrant reload
```

If you get errors about Apache not being able to start on port 8140, SSH into the Puppet Master VM:

``vagrant ssh master``

And stop the puppetmaster service, then go back to your own computer:

``
sudo service puppetmaster stop
exit
``

Then provision the machine again:

``vagrant provision master``

This will leave you with a fully operational Puppet setup to cut your teeth on.

If you still get errors from Vagrant, just issue vagrant reload until they clear up. This is just an issue with the various parts being exchanged between the Puppet Master and PuppetDB servers during initial configuration. This only needs to be done once.

## IP Addresses

<table>
<tr><th>Puppet Master</th><td>192.168.2.10</td></tr>
<tr><th>Dashboard</th><td>192.168.2.11</td></tr>
<tr><th>PuppetDB</th><td>192.168.2.12</td></tr>
</table>

#Usage

The ``nacs-dev-puppetmaster/puppet`` directory is linked to ``/etc/puppet`` on your Puppet Master. You should put your classes in the ``puppet/classes`` directory and your modules in the ``puppet/modules`` directory.

You can access the Puppet Dashboard by hitting http://192.168.2.11:3000 in your web browser.

#What's next?

You can use the manifests in ``VagrantConf/manifests`` to stand up your own Puppet sever setup. Take a look at the Vagrantfile to see what's happening to each VM, adjust the IP addresses and host names in the manifests to match your own environment and you're good to go.
