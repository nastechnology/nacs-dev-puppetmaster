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
