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

#Quick Manifest to stand up a dev Puppet Master
node 'puppet.nacswildcats.dev' {
  include host_conf

  package { 'puppetmaster-passenger': 
     ensure => installed, 
     require => Class['host_conf'],
     before  => [Class['puppetdb::master::config'],Class['puppetdb::server']],
  }

  service {'apache2':
    ensure  => 'running',
    require => Class['puppetmaster'],
  }

  package {'puppet-dashboard':
    ensure => installed,
  }

  class { puppetmaster:
    puppetmaster_service_ensure => 'stopped',
    puppetmaster_service_enable => 'false',
    puppetmaster_report         => 'true',
    puppetmaster_autosign       => 'true',
    require                     => Class['host_conf'],
  }

  class { 'puppetdb::server':
    database_host => 'puppetdb.grahamgilbert.dev',
    require       => [Package['puppetmaster-passenger'],Class['host_conf']],
  }

  class { 'puppetdb::master::config':
  }

  ini_setting { "puppetmaster_dns_alt_names":
    path    => '/etc/puppet/puppet.conf',
    section => 'master',
    setting => 'dns_alt_names',
    value   => 'puppet, puppet.local, puppet.nacswildcats.dev',
    ensure  => present,
    before  => Class['puppetmaster'],
  }

  ini_setting { "puppetmaster_reports":
    path    => '/etc/puppet/puppet.conf',
    section => 'master',
    setting => 'reports',
    value   => 'store, http, puppetdb',
    ensure  => present,
    before  => Class['puppetmaster'],
  }

  ini_setting { "puppetmaster_reporturl":
    path    => '/etc/puppet/puppet.conf',
    section => 'master',
    setting => 'reporturl',
    value   => 'http://dashboard.nacswildcats.dev:3000/reports/upload',
    ensure  => present,
    before  => Class['puppetmaster'],
  }

  ini_setting { "puppetmaster_node_terminus":
    path    => '/etc/puppet/puppet.conf',
    section => 'master',
    setting => 'node_terminus',
    value   => 'exec',
    ensure  => present,
    before  => Class['puppetmaster'],
  }

  ini_setting { "puppetmaster_external_nodes":
    path    => '/etc/puppet/puppet.conf',
    section => 'master',
    setting => 'external_nodes',
    value   => '/usr/bin/env PUPPET_DASHBOARD_URL=http://dashboard.nacswildcats.dev:3000 /usr/share/puppet-dashboard/bin/external_node',
    ensure  => present,
    before  => Class['puppetmaster'],
  }

  ini_setting { "puppetmaster_storeconfigs":
    path    => '/etc/puppet/puppet.conf',
    section => 'master',
    setting => 'storeconfigs',
    value   => 'true',
    ensure  => present,
  }

  ini_setting { "puppetmaster_storeconfigs_backend":
    path    => '/etc/puppet/puppet.conf',
    section => 'master',
    setting => 'storeconfigs_backend',
    value   => 'puppetdb',
    ensure  => present,
  }

  file {'/etc/puppet/auth.conf':
    ensure => link,
    owner => root,
    group => root,
    source => "/vagrant/puppet/auth.conf",
  }

  file {'/etc/puppet/fileserver.conf':
    ensure => link,
    owner => root,
    group => root,
    source => "/vagrant/puppet/fileserver.conf",
  }
}
