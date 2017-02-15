#!/usr/bin/env bash
echo "Running: install-hanlon.sh"
# Download and init Hanlon code from gitub (master/HEAD)
sudo mkdir /opt/hanlon
cd /opt/hanlon
sudo chown -R vagrant ./
git clone https://github.com/mkristiansen/Hanlon.git .
bundle install
./hanlon_init

# Start Hanlon server
web/run-puma.sh &

# Download Microkernel and Rancher OS Images
sudo docker pull cscdock/hanlon-microkernel:3.0.1
sudo docker save cscdock/hanlon-microkernel:3.0.1 > cscdock-mk-image.tar
bzip2 -c cscdock-mk-image.tar > /tmp/cscdock-mk-image.tar.bzip2
rm -rf cscdock-mk-image.tar
ssh-keygen -t rsa -N hanlon -C "RSA key for password authentication to microkernel" -f hanlonkey
sudo wget https://releases.rancher.com/os/v0.4.1/rancheros.iso -O /tmp/rancheros-v0.4.1.iso

# Create Hanlon iPXE configuration
cli/hanlon config ipxe > /tftpboot/hanlon.ipxe

# Add the image for the Microkernel
cli/hanlon image add -t mk -p /tmp/rancheros-v0.4.1.iso -d /tmp/cscdock-mk-image.tar.bzip2 -m passw0rd
