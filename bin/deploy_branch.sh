#!/bin/bash

set -e

if [[ -z $HOSTNAME_PREFIX ]];HOSTNAME_PREFIX=poc; fi
if [[ -z $NAME ]]; then read -p "NAME of the instance" NAME; fi
if [[ -z $BRANCH_NAME ]]; then read -p "BRANCH_NAME to deploy" BRANCH_NAME; fi

HOSTNAME=$HOSTNAME_PREFIX$NAME

# create vm
echo -e "\e[32m[INFO]\e[39m create vm for ${HOSTNAME}"
echo -e "\e[2mgandi vm delete ${HOSTNAME}\e[22m to delete"
gandi vm create --memory 3072 --ip-version 4 --hostname $HOSTNAME --image "Debian 9" --size 40G

IP=gandi vm info $HOSTNAME | grep ip4 | sed 's/ip4\s*:\s//g'

echo -e "\e[32m[INFO]\e[39m set IP host for $HOSTNAME: $IP"

cat > hosts-${HOSTNAME} << EOF
[caliopen:vars]
use_https=false
stage=false
vhost_name=
devtools_dir=/opt/caliopen/devtools/
compose_file="{{ devtools_dir+'docker-compose.staging.yml' if stage == 'true' else devtools_dir+'docker-compose.yml' }}"

[caliopen]
docker-stack ansible_ssh_host=${IP} ansible_ssh_user=root ansible_ssh_private_key_file=
EOF
#---

# Boot
echo -e "\e[32m[INFO]\e[39m play ansible book to init caliopen"
ansible-playbook -i hosts-${HOSTNAME} playbook.yml --extra-vars "caliopen_version=${BRANCH_NAME}"
echo -e "\e[32m[INFO]\e[39m play ansible book to load fixtures"
ansible-playbook -i hosts-${HOSTNAME} playbook-load-data.yml
