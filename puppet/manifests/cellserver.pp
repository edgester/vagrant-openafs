
include vagrant::package_cache
include kerberos::server::kadmind

class {'kerberos::client':
  realm        => 'EXAMPLE.ORG',
  kdc          => ['cellserver.example.org'],
  admin_server => ['cellserver.example.org'],
}

class {'kerberos::server::kdc':
  realm => 'EXAMPLE.ORG',
}

File { owner => 0, group => 0, mode => 0644 }   

host { 'cellserver.example.com':
    ip => '192.168.44.44',
    host_aliases => 'cellserver',
}

#File['/var/cache/apt'] -> Class['apt::update']

