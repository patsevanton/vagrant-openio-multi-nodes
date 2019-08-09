#!/bin/bash

vagrant up
git clone https://github.com/open-io/ansible-playbook-openio-deployment.git --branch 19.04 oiosds
mv oiosds/products/sds .
rm -rf oiosds
cd sds
sed '/      ansible_host: IP_ADDRESS_OF_NODE1/a       ansible_host: 192.168.33.31' inventory.yml
sed '/      ansible_host: IP_ADDRESS_OF_NODE2/a       ansible_host: 192.168.33.32' inventory.yml
sed '/      ansible_host: IP_ADDRESS_OF_NODE3/a       ansible_host: 192.168.33.33' inventory.yml
sed -i 's/IP_ADDRESS_OF_NODE1/"192.168.33.31"/g' inventory.yml
sed -i 's/IP_ADDRESS_OF_NODE2/"192.168.33.32"/g' inventory.yml
sed -i 's/IP_ADDRESS_OF_NODE3/"192.168.33.33"/g' inventory.yml
ansible all -i inventory.yml -bv -m ping
./requirements_install.sh
