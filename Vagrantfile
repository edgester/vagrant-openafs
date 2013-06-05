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

  ################ begin db server ##############
  config.vm.define :dbserver do |dbserv|
    dbserv.vm.box = "precise32"
    dbserv.vm.hostname = "dbserver.example.org"
    dbserv.vm.network :private_network, ip: "192.168.44.44"

    dbserv.vm.provision :shell, :path => "scripts/format-disk"

    # Enable provisioning with Puppet stand alone.
    dbserv.vm.provision :puppet do |puppet|
      puppet.manifests_path = "puppet/manifests"
      puppet.manifest_file  = "dbserver.pp"
      puppet.module_path = "puppet/modules"
    end

    # customize virtualbox settings
    dbserv.vm.provider "virtualbox" do |v|
      
      # add a second virtual hard drive (/vicepa)
      dbserverVicepa="virtual-hdd/dbserv-vicepa.vmdk"
      if ( ! File.exist?(dbserverVicepa) )
        v.customize ["createhd", "--filename", dbserverVicepa, "--size", "80000"]
      end
      v.customize ["storageattach", :id, "--storagectl", "SATA Controller",
                   "--port", "1", "--device", "0",
                   "--type", "hdd", "--medium", dbserverVicepa ]
      
      # add a third virtual hard drive (/vicepb)
      dbserverVicepb="virtual-hdd/dbserv-vicepb.vmdk"
      if ( ! File.exist?(dbserverVicepb) )
        v.customize ["createhd", "--filename", dbserverVicepb, "--size", "80000"]
      end
      v.customize ["storageattach", :id, "--storagectl", "SATA Controller",
                   "--port", "2", "--device", "0",
                   "--type", "hdd", "--medium", dbserverVicepb ]
    end

  end
  ################ end db server ##############

  ################ begin file server ##############
  config.vm.define :fileserver do |fileserv|
    fileserv.vm.box = "precise32"
    fileserv.vm.hostname = "fileserver.example.org"
    fileserv.vm.network :private_network, ip: "192.168.44.55"

    fileserv.vm.provision :shell, :path => "scripts/format-disk"

    # Enable provisioning with Puppet stand alone.
    fileserv.vm.provision :puppet do |puppet|
      puppet.manifests_path = "puppet/manifests"
      puppet.manifest_file  = "fileserver.pp"
      puppet.module_path = "puppet/modules"
    end

    # customize virtualbox settings
    fileserv.vm.provider "virtualbox" do |v|
      
      # add a second virtual hard drive (/vicepa)
      fileserverVicepa="virtual-hdd/fileserv-vicepa.vmdk"
      if ( ! File.exist?(fileserverVicepa) )
        v.customize ["createhd", "--filename", fileserverVicepa, "--size", "80000"]
      end
      v.customize ["storageattach", :id, "--storagectl", "SATA Controller",
                   "--port", "1", "--device", "0",
                   "--type", "hdd", "--medium", fileserverVicepa ]
      
      # add a third virtual hard drive (/vicepb)
      fileserverVicepb="virtual-hdd/fileserv-vicepb.vmdk"
      if ( ! File.exist?(fileserverVicepb) )
        v.customize ["createhd", "--filename", fileserverVicepb, "--size", "80000"]
      end
      v.customize ["storageattach", :id, "--storagectl", "SATA Controller",
                   "--port", "2", "--device", "0",
                   "--type", "hdd", "--medium", fileserverVicepb ]
    end

  end
  ################ end file server ##############

end
