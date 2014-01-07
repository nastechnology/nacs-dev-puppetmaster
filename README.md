## NACS Dev PuppetMaster

Vagrant Puppet Dev Environment for testing NACS Modules


## Before you begin

You will need the following packages installed to work with this:

* [Vagrant](http://vagrantup.com)
* [VirtualBox](http://www.virtualbox.org)
* [Puppet](http://www.puppetlabs.com)
* Ruby - If using any variance of *nix or Mac OS X this will be installd

You will also need to install the librarian-puppet gem to install the needed modules for the puppet master.  If you are running Mac OS X Mavericks I would install the puppet gem.

``gem install librarian-puppet``


## Getting Startted

First you need to download the required Puppet modules - thankfully librarian-puppet will do that for you. 

``
cd ~/nacs-dev-puppetmaster/VagrantConf
librarian-puppet install
cd ../puppet
librarian-puppet install 
``

When starting the Vagrant VMs, there are some cross node dependencies, so they will need to be rebooted a few times to make sure the Puppet provisioner runs completely.

```
cd ~/nacs-dev-puppetmaster
vagrant up
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

## IP Addresses

<table>
<tr><th>Puppet Master</th><td>192.168.2.10</td></tr>
<tr><th>Windows Node</th><td>192.168.2.100</td></tr>
</table>

#Usage

The ``nacs-dev-puppetmaster/puppet`` directory is linked to ``/etc/puppet`` on your Puppet Master. You should put your classes in the ``puppet/classes`` directory and your modules in the ``puppet/modules`` directory.

After the windows box boots up you will need to run the ``C:\vagrant\firstboot.bat`` from the command prompt.  The ``firstboot.bat`` installs chocolatey and puppet and sets the Servername to ``puppet.nacswildcats.dev`` and the certname to ``xp.nas.dev``.

#What's next?

You can use the manifests in ``VagrantConf/manifests`` to stand up your own Puppet sever setup. Take a look at the Vagrantfile to see what's happening to each VM, adjust the IP addresses and host names in the manifests to match your own environment and you're good to go.
