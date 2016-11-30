```vagrant up cd prod

 vagrant ssh cd
 
ansible-playbook /vagrant/ansible/prod2.yml -i /vagrant/ansible/hosts/prod

ansible-playbook /vagrant/ansible/jenkins-node.yml -i /vagrant/ansible/hosts/prod

ansible-playbook /vagrant/ansible/jenkins.yml -c local```


