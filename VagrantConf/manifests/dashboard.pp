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

# Manifest to stand up a Puppet Dashboard

node default{
    include host_conf

file {'/etc/init/dashboard_workers.conf':
    owner => root,
    require => Class['dashboard'],
    group => root,
    mode  => '0644',
    content => '#/etc/init/dashboard_workers.conf.conf
description "My dashboard Service"

start on (local-filesystems and net-device-up IFACE=eth0)
stop on shutdown

pre-start exec env RAILS_ENV=production /usr/share/puppet-dashboard/script/delayed_job -p dashboard -n 4 -m start',
}

  # Ensure that the service is running.
  service { 'dashboard_workers':
    ensure => running,
    provider => 'upstart',
    require => File['/etc/init/dashboard_workers.conf'],
  }
  
    package {'build-essential':
        ensure => installed,
    }
    
    package {'rubygems':
        ensure => installed,
    }

    package {'zlib1g-dev':
        ensure => installed,
    }
  

    class {'dashboard':
        dashboard_site => $fqdn,
        dashboard_workers_start => 'no',
        dashboard_port => '3000',
        passenger      => true,
        require        => Host['dashboard.nacswildcats.dev'],
    }
}
