class host_conf {
    host { 'puppet.nacswildcats.dev':
      ensure       => 'present',
      host_aliases => ['puppet'],
      ip           => '192.168.2.10',
      target       => '/etc/hosts',
    }

    host { 'dashboard.nacswildcats.dev':
      ensure       => 'present',
      host_aliases => ['dashboard'],
      ip           => '192.168.2.11',
      target       => '/etc/hosts',
    }
    
    host { 'puppetdb.nacswildcats.dev':
      ensure       => 'present',
      host_aliases => ['puppetdb'],
      ip           => '192.168.2.12',
      target       => '/etc/hosts',
    }
}

#Quick Manifest to stand up a demo Puppet Master

##Need to install puppet dashboard and configure it
node default{
  include host_conf

  class { 'puppetdb::database::postgresql':
      listen_addresses => '0.0.0.0',
      require => Class['host_conf']
    }
}
