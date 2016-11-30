va1 `vagrant up cd prod`
2
3 `vagrant ssh cd`
4
5 ```ansible-playbook /vagrant/ansible/prod2.yml -i /vagrant/ansible/hosts/prod```
7
8 ```ansible-playbook /vagrant/ansible/jenkins-node.yml -i /vagrant/ansible/hosts/prod```
10
11 ```ansible-playbook /vagrant/ansible/jenkins.yml -c local```


