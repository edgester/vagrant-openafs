
include vagrant::package_cache

File { owner => 0, group => 0, mode => 0644 }   

#File['/var/cache/apt'] -> Class['apt::update']

