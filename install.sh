#!/bin/bash
set -ue

# Get ansible package status
ansible_status=$(dpkg-query --show --showformat='${db:Status-Status}\n' ansible)

# Check for ansible
if [ "${ansible_status}" != "installed" ]; then
    sudo -s -- <<EOF
    apt update
    apt install -y software-properties-common
    apt-add-repository -y ppa:ansible/ansible
    apt update
    apt install -y ansible
EOF
fi

ansible-playbook -i inventory -K playbook.yml
