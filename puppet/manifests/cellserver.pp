
include vagrant::package_cache
include kerberos::server::kadmind

class {'kerberos::client':
  realm        => 'EXAMPLE.ORG',
  kdc          => ['192.168.44.44'],
  admin_server => ['192.168.44.44'],
}

class {'kerberos::server::kdc':
  realm => 'EXAMPLE.ORG',
}

File { owner => 0, group => 0, mode => 0644 }   

#File['/var/cache/apt'] -> Class['apt::update']

