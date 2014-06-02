#Quick Manifest to stand up a demo Puppet Master

node default {

  host { 'puppet.nacswildcats.dev':
    ensure       => 'present',
    host_aliases => ['puppet'],
    ip           => '192.168.2.10',
    target       => '/etc/hosts',
  }

  host { 'pdb.nacswildcats.dev':
    ensure       => 'present',
    ip           => '192.168.2.11',
    target       => '/etc/hosts',
  }

  host { 'puppetdb.nacswildcats.dev':
    ensure       => 'present',
    ip           => '192.168.2.12',
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

  file { '/etc/puppet/Puppetfile':
    ensure => link,
    owner  => root,
    group  => root,
    source => "/vagrant/puppet/Puppetfile",
  }
<<<<<<< HEAD
=======
  
  package { 'librarian-puppet':
    ensure   => installed,
    provider => gem,
  }
>>>>>>> 863c74ca6dd529a722b8f118353fa09108a1d5f3

  file {'/etc/puppet/modules':
    mode  => '0644',
    recurse => true,
  }

  class { 'puppetdb::master::config':
    puppetdb_server => 'puppetdb',
  }

}
