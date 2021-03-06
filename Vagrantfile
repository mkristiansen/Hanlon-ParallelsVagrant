# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = 'my/parallels/ubuntu-15.04'

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network 'forwarded_port', :guest => 80, :host => 8081
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network 'private_network', :ip => '10.142.142.101'
  config.vm.network "private_network", :ip => '10.142.142.101'
  config.vm.hostname = 'hanlon'

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  config.vm.provider :parallels do |prl|
    # Customize the amount of memory on the VM:
    prl.memory = '1024'
  end

  # Provision dependencies for Hanlon
  config.vm.provision :shell, :path => 'install-rvm.sh', :args => 'stable', :privileged => false
  config.vm.provision :shell, :path => 'install-ruby.sh', :args => '2.2.3 bundler bson_ext', :privileged => false
  config.vm.provision :shell, :path => 'install-dependencies.sh', :privileged => false
  config.vm.provision :shell, :path => 'install-hanlon.sh', :privileged => false
  config.vm.provision :shell, :path => 'create-policy.sh', :privileged => false
end
