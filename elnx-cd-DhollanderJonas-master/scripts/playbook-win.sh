#!/bin/bash
# Source: https://github.com/geerlingguy/JJG-Ansible-Windows/blob/master/windows.sh

# Windows shell provisioner for Ansible playbooks, based on KSid's
# windows-vagrant-ansible: https://github.com/KSid/windows-vagrant-ansible
#
# @todo - Allow proxy configuration to be passed in via Vagrantfile config.
#
# @see README.md
# @author Jeff Geerling, 2014
# @version 1.0
#

playbook=/vagrant/ansible/site.yml
inventory=/vagrant/scripts/inventory.py

if [ ! -f ${playbook} ]; then
  echo "Cannot find Ansible playbook."
  exit 1
fi

if [ ! -f ${inventory} ]; then
  echo "Cannot find inventory file."
  exit 2
fi

# Install Ansible and its dependencies if it's not installed already.
if [ ! -f /usr/bin/ansible ] ; then

#checks if linux destro is redhat
 if [ -f /etc/os-release ] ; then
  echo "Installing Ansible dependencies and build tools."
  yum install -y gcc git python-devel libffi-devel openssl-devel python-setuptools
  echo "Installing pip via easy_install."
  easy_install pip
  # Make sure setuptools are installed crrectly.
  pip install setuptools --no-binary :all: --upgrade
  echo "Installing Ansible."
  pip install ansible
  echo "Ansible installed:"
  ansible --version

#checks if linux destro is debian
  elif [ -f /etc/lsb-release ] ; then
      echo "Installing Ansible..."
      apt-get install -y software-properties-common
      apt-add-repository ppa:ansible/ansible
      apt-get update
      apt-get install -y --force-yes ansible

            #apt-get update -y
            #apt-get install -y python-pip python-dev
            #pip install ansible==1.9.2
            #mkdir -p /etc/ansible
            #touch /etc/ansible/hosts
            #cp /vagrant/ansible/ansible.cfg /etc/ansible/ansible.cfg
            #mkdir -p /etc/ansible/callback_plugins/
            #cp /vagrant/ansible/plugins/human_log.py /etc/ansible/callback_plugins/human_log.py

     fi
  fi


ansible-playbook "${playbook}" \
  --inventory-file="${inventory}" \
  --limit="${HOSTNAME}" \
  --extra-vars "is_windows=true" \
  --connection=local \
  "$@"
