Bash in Lifecycle
```
vagrant up cd prod

 vagrant ssh cd
 
ansible-playbook /vagrant/ansible/prod2.yml -i /vagrant/ansible/hosts/prod

ansible-playbook /vagrant/ansible/jenkins-node.yml -i /vagrant/ansible/hosts/prod

ansible-playbook /vagrant/ansible/jenkins.yml -c local
```

Open jenkins in host - > http://10.100.198.200:8080/

Open Docker UI -> http://10.100.198.200:9000/


