#!/bin/bash

#vagrant up
git clone https://github.com/open-io/ansible-playbook-openio-deployment.git --branch 19.04 oiosds
mv oiosds/products/sds .
rm -rf oiosds
cd sds
sed -i '/ansible_host: IP_ADDRESS_OF_NODE1/a \      ansible_ssh_private_key_file: ../.vagrant/machines/node1/virtualbox/private_key' inventory.yml
sed -i '/ansible_host: IP_ADDRESS_OF_NODE2/a \      ansible_ssh_private_key_file: ../.vagrant/machines/node2/virtualbox/private_key' inventory.yml
sed -i '/ansible_host: IP_ADDRESS_OF_NODE3/a \      ansible_ssh_private_key_file: ../.vagrant/machines/node3/virtualbox/private_key' inventory.yml
sed -i 's/IP_ADDRESS_OF_NODE1/"192.168.33.31"/g' inventory.yml
sed -i 's/IP_ADDRESS_OF_NODE2/"192.168.33.32"/g' inventory.yml
sed -i 's/IP_ADDRESS_OF_NODE3/"192.168.33.33"/g' inventory.yml
#ansible all -i inventory.yml -bv -m ping
#./requirements_install.sh
