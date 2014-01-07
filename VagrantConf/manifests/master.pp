#Quick Manifest to stand up a demo Puppet Master

node default {
  
  host { 'puppet.nacswildcats.dev':
    ensure       => 'present',
    host_aliases => ['puppet'],
    ip           => '192.168.2.10',
    target       => '/etc/hosts',
  }

  package { 'git':
    ensure => installed,
  }

  service { 'puppetmaster':
    ensure => running,
  }

  ini_setting { "puppetmaster_dns_alt_names":
    path    => '/etc/puppet/puppet.conf',
    section => 'master',
    setting => 'dns_alt_names',
    value   => 'puppet, puppet.local, puppet.nacswildcats.dev',
    ensure  => present,
    notify  => Service['puppetmaster'],
  }
    
  file {'/etc/puppet/autosign.conf':
    ensure => link,
    owner => root,
    group => root,
    source => "/vagrant/puppet/autosign.conf",
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
  
  file {'/etc/puppet/modules':
    mode  => '0644',
    recurse => true,
  }
  
}
