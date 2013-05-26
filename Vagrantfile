# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network :private_network, ip: "192.168.33.10"

  # customize virtualbox settings
  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--memory", "512"]
    v.customize ["modifyvm", :id, "--natdnshostresolver1", 'on']
  end

  ################ begin cell server ##############
  config.vm.define :cellserver do |cellserv|
    cellserv.vm.box = "cellserver"

    # Enable provisioning with Puppet stand alone.
    cellserv.vm.provision :puppet do |puppet|
      puppet.manifests_path = "puppet/manifests"
      puppet.manifest_file  = "cellserver.pp"
      puppet.module_path = "puppet/modules"
    end
  end
  ################ end cell server ##############

end
