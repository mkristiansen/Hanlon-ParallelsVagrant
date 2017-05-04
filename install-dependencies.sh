#!/usr/bin/env bash
echo "[INFO] Running: install-dependencies.sh"

sudo apt-get update
sudo apt-get install -y curl lbzip2 libbz2-dev libpq-dev

echo "[INFO] Installing: MongDB"
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv 7F0CEB10
sudo echo "deb http://repo.mongodb.org/apt/ubuntu precise/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list
sudo apt-get update
sudo apt-get install -y mongodb-org
# sudo cp /vagrant/mongod.service /lib/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable mongod
sudo systemctl start mongod

echo "[INFO] Installing: Docker Engine"
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
sudo echo "deb https://apt.dockerproject.org/repo ubuntu-precise main" | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt-get update
sudo apt-get install -y docker-engine

echo "[INFO] Starting Docker Engine"
sudo systemctl start docker

echo "[INFO] Installing: DHCP, TFT and iPXE Services"
sudo apt-get install -y isc-dhcp-server ipxe tftp tftpd

echo "[INFO] Configuring TFTPD"
[ ! -d /tftpboot ] && sudo mkdir /tftpboot
sudo chmod -R 777 /tftpboot
sudo chown -R nobody /tftpboot

sudo cp /vagrant/tftp /etc/xinetd.d/tftp
sudo service xinetd reload

# Copy ipxe files to tftpboot
echo "[INFO] Configuring iPXE"
cp -r /usr/lib/ipxe/* /tftpboot

#Patch general.h - only needed for ESXi
#cd ~
#git clone git://git.ipxe.org/ipxe.git
#wget https://gist.githubusercontent.com/jcpowermac/7cc13ce51816ce5222f4/raw/4384911a921a732e0b85d28ff3485fe18c092ffd/image_comboot.patch
#patch -p0 < image_comboot.patch
#rm image_comboot.patch

echo "[INFO] Installing PXELinux"
wget -nv https://www.kernel.org/pub/linux/utils/boot/syslinux/syslinux-6.02.tar.gz
tar -zxvf syslinux-6.02.tar.gz --strip-components 3 -C /tftpboot syslinux-6.02/bios/core/pxelinux.0
tar -zxvf syslinux-6.02.tar.gz --strip-components 4 -C /tftpboot syslinux-6.02/bios/com32/menu/menu.c32

[ ! -d /tftpboot/pxelinux.cfg ] && mkdir /tftpboot/pxelinux.cfg
sudo cp /vagrant/default /tftpboot/pxelinux.cfg/default


echo "[INFO] Configuring DHCPD"
sudo cp /vagrant/dhcpd.conf /etc/dhcp/dhcpd.conf
sudo service isc-dhcp-server restart
