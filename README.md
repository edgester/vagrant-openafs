# OpenAFS demo using Vagrant

This is a vagrant config for trying out OpenAFS. This was used in a
presentation at SouthEast Linux Fest 2013.

## Boxen

Both boxes have three virtual hard drives. The 2nd and third drives are
formatted at creation time and mounted as /vicepa and /vicepb

 * dbserver - First box. A self-contained box running OpenAFS DB server
   and file server.

 * file server - an additional file server to see how how to move volumes
   around.

## How to use

Using [rvm](https://rvm.io/rvm/install/) is recommended.

Install the librarian-puppet module

    git clone git://github.com/edgester/vagrant-openafs.git
    cd vagrant-openafs/puppet
    librarian-puppet install
    cd ..
    vagrant up dbserver
    vagrant ssh

Once in the VM, setup kerberos and set the stash password and "admin" password:

    sudo -i
    /vagrant/scripts/setup-kerberos

 Set up OpenAFS the cell, type in the admin password from the previous step when prompted

    /vagrant/scripts/setup-openafs-dbserver
    service openafs-client restart

 You now have a working OpenAFS cell in a single VM.

 To add a second file server, run the following:
 
    # while in the dbserver VM as root
    cp  /etc/openafs/server/* /vagrant/tmp
    exit # sudo
    exit # the VM
    vagrant up fileserver
    vagrant ssh fileserver
    sudo -i
    cp /vagrant/tmp/* /etc/openafs/server/
    /vagrant/scripts/setup-openafs-fileserver
    service openafs-fileserver restart

 Enjoy using your new OpenAFS VM!

## Gotchas

  * The puppet modules take the realmname, cellname and DB servers as
    parameters. The IP's and hostnames for DB servers shuold be in the
    same positino in the array.

  * The files in /vagrant/scripts have hard-coded cell and realm
    names. Edit the files if you want to use a name other than example.org

  * The setup uses a pre-compile DKMS kernel module. To upgrade the
    kernel, install the kernel headers and build-essential packages.
 
 ## More info

  * [OpenAFS web site](http://openafs.org/)
  * [OpenAFS Docs](http://docs.openafs.org/index.html)
  * [OpenAFS Mailing list](https://lists.openafs.org/mailman/listinfo/openafs-info)
