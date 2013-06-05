
include vagrant::package_cache
include kerberos::server::kadmind

class {'kerberos::client':
  realm             => 'EXAMPLE.ORG',
  kdc               => ['dbserver.example.org'],
  admin_server      => ['dbserver.example.org'],
  allow_weak_crypto => true,
}

class {'kerberos::server::kdc':
  realm => 'EXAMPLE.ORG',
}

File { owner => 0, group => 0, mode => 0644 }   

host { 'dbserver.example.org':
    ip => '192.168.44.44',
    host_aliases => 'dbserver',
}

host { 'fileserver.example.org':
    ip => '192.168.44.55',
    host_aliases => 'fileserver',
}

class {'openafs::server':
  cell => 'example.org',
  is_dbserver => 'true',
}

class {'openafs::client':
  cell         => 'example.org',
  db_hostnames => ['dbserver.example.org'],
  db_ips       => ['192.168.44.44'],
}

# prevent the file server from listening on the NAT interface
file { '/var/lib/openafs/local/NetRestrict':
  ensure  => 'file',
  content => "$::ipaddress_eth0\n",
  before  => Service['openafs-fileserver'],
  require => Package[ $openafs::params::fileserver_packages ],
  notify  => Service['openafs-fileserver'],
}

#File['/var/cache/apt'] -> Class['apt::update']

# install rng-utils to speed up kerberbos DB generation
package { 'rng-tools' :
  ensure => present,
}
package { 'curl' :
  ensure => present,
}
