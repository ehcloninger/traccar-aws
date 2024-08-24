#!/bin/bash -e

sudo yum -y update
# sudo yum -y install python3-pip
sudo pip install ansible
sudo yum install nc git python3-pip yum-utils device-mapper-persistent-data lvm2 docker systemd-libs

ansible-playbook --connection=local -i "localhost," ansible/prepare-server.yml
ansible-playbook --connection=local -i "localhost," ansible/install-traccar.yml

if [[ $TC_LETSENCRYPT == true ]]; then
  ansible-playbook --connection=local -i "localhost," ansible/install-letsencrypt.yml
fi
