#!/bin/bash

vagrant up
git clone https://github.com/open-io/ansible-playbook-openio-deployment.git --branch 19.04 oiosds
mv oiosds/products/sds .
rm -rf oiosds
