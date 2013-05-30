
include vagrant::package_cache
include krb5::server::kadmind

class {'krb5::server::kdc':
  realm => 'EXAMPLE.ORG',
}

File { owner => 0, group => 0, mode => 0644 }   

#File['/var/cache/apt'] -> Class['apt::update']

