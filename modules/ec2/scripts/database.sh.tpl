#! /bin/bash
sudo yum install epel-release -y
sudo yum install git python-pip ansible -y
sudo echo localhost >> /tmp/hosts
ansible-pull -i /tmp/hosts -U https://github.com/Anurag-30/infra-workshop.git ansible/playbook.yml -e db_user=${db_user} -e db_password=${db_password} -e db_name=${db_name}
