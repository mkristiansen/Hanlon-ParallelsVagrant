#!/usr/bin/env bash
echo "Running: create-policy.sh"

cd /opt/hanlon

# image_uuid=$(docker exec -it vagrant_server_1 ./cli/hanlon image add -t os -p /vagrant/ubuntu-12.04.5-server-amd64.iso -v 12.04.5 -n ubuntu-precise|grep "UUID"|awk '{print $3}')

# model_uuid=$(docker exec -it vagrant_server_1 ./cli/hanlon model add -t ubuntu_precise -l install_precise -i $image_uuid -o /vagrant/attr.yaml |grep "UUID"|awk '{print $3}')

# docker exec -it vagrant_server_1 ./cli/hanlon policy add -p linux_deploy -l ubuntu_precise -m $model_uuid -t parallels_vm -b none -e true

image_uuid=$(./cli/hanlon image add -t os -p /vagrant/ubuntu-12.04.5-server-amd64.iso -v 12.04.5 -n ubuntu-precise|grep "UUID"|awk '{print $3}')

model_uuid=$(./cli/hanlon model add -t ubuntu_precise -l install_precise -i $image_uuid -o /vagrant/attr.yaml |grep "UUID"|awk '{print $3}')

./cli/hanlon policy add -p linux_deploy -l ubuntu_precise -m $model_uuid -t parallels_vm -b none -e true
