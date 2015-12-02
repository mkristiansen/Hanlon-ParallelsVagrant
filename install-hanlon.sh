#!/usr/bin/env bash

# Download and init Hanlon code from gitub (master/HEAD)
sudo mkdir /opt/hanlon
cd /opt/hanlon
sudo chown -R vagrant ./
git clone https://github.com/csc/Hanlon.git .
bundle install
./hanlon_init

# Start Hanlon server
web/run_puma.sh &

# Create Hanlon iPXE configuration
cli/hanlon config ipxe > /tftpboot/hanlon.ipxe

# Download Microkernel and Rancher OS Images
sudo docker pull cscdock/hanlon-microkernel:3.0.0
sudo docker save cscdock/hanlon-microkernel:3.0.0 > cscdock-mk-image.tar
bzip2 -c cscdock-mk-image.tar > /tmp/cscdock-mk-image.tar.bz2
rm -rf cscdock-mk-image.tar
sudo wget https://releases.rancher.com/os/v0.4.1/rancheros.iso -O /tmp/rancheros-v0.4.1.iso

# Add the image for the Microkernel
cli/hanlon image add -t mk -p /tmp/rancheros-v0.4.1.iso -d /tmp/cscdock-mk-image.tar.bz2
