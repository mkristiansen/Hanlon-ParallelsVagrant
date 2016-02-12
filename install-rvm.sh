#!/usr/bin/env bash
echo "Running: install-rvm.sh"
sudo apt-get update
sudo apt-get install -y curl
gpg --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s $1
