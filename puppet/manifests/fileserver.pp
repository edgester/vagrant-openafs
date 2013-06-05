
include vagrant::package_cache
include kerberos::server::kadmind

class {'kerberos::client':
  realm             => 'EXAMPLE.ORG',
  kdc               => ['cellserver.example.org'],
  admin_server      => ['cellserver.example.org'],
  allow_weak_crypto => true,
}

File { owner => 0, group => 0, mode => 0644 }   

host { 'cellserver.example.org':
    ip => '192.168.44.44',
    host_aliases => 'cellserver',
}

host { 'fileserver.example.org':
    ip => '192.168.44.55',
    host_aliases => 'fileserver',
}

class {'openafs::server':
  cell => 'example.org',
  is_dbserver => 'false',
}

class {'openafs::client':
  cell         => 'example.org',
  db_hostnames => ['cellserver.example.org'],
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
