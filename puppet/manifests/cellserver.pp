
include vagrant::package_cache
include krb5::server::kdc
include krb5::server::kadmind

File { owner => 0, group => 0, mode => 0644 }   

#File['/var/cache/apt'] -> Class['apt::update']

