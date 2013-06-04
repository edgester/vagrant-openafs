
include vagrant::package_cache
include kerberos::server::kadmind

class {'kerberos::client':
  realm             => 'EXAMPLE.ORG',
  kdc               => ['cellserver.example.org'],
  admin_server      => ['cellserver.example.org'],
  allow_weak_crypto => true,
}

class {'kerberos::server::kdc':
  realm => 'EXAMPLE.ORG',
}

File { owner => 0, group => 0, mode => 0644 }   

host { 'cellserver.example.org':
    ip => '192.168.44.44',
    host_aliases => 'cellserver',
}

class {'openafs::server':
  cell => 'example.org',
  is_dbserver => 'true',
}

class {'openafs::client':
  cell         => 'example.org',
  db_hostnames => ['cellserver.example.org'],
  db_ips       => ['192.168.44.44'],
}

#File['/var/cache/apt'] -> Class['apt::update']

# install rng-utils to speed up kerberbos DB generation
package { 'rng-tools' :
  ensure => present,
}
package { 'curl' :
  ensure => present,
}
