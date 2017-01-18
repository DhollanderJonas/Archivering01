#Steps for CD

##Part 1 (early stages deployment)

vagrant up cd 

vagrant ssh cd

cd books-ms/

docker build -f Dockerfile.test -t 10.100.198.200:5000/books-ms-tests --> doesn't work

- resolved by removing `Dockerfile`, copying `Dockerfile.tests` as `Dockerfile` and running `docker build ~/books-ms`. Added a tag to it with `docker tag IMAGE ID 10.100.198.200:5000/books-ms-tests`. STILL NEED PROPER FIX

(docker-compose -f docker-compose-dev.yml run --rm tests 
target/scala-2.10/)

docker-compose -f docker-compose-dev.yml up -d app

docker push 10.100.198.200:5000/books-ms-tests

exit

vagrant destroy -f

## Part 2 (don't think we'll need)

vagrant up cd prod --provision

vagrant ssh cd

ansible-playbook /vagrant/ansible/prod.yml -i /vagrant/ansible/hosts/prod

vagrant destroy -f

## Part 3 (intermediate stages deployment)

vagrant up cd prod

vagrant ssh cd

ansible-playbook /vagrant/ansible/prod.yml -i /vagrant/ansible/hosts/prod

wget https://raw.githubusercontent.com/vfarcic/books-ms/master/docker-compose.yml

export DOCKER_HOST=tcp://prod:2375

docker-compose up -d app

-> page 99 (pdf)

vagrant destroy -f

## Part 4 (Service Discovery) --> skipping for now

uses the etcd.yml

Consul

Registrator

vagrant destroy -f

## Part 5 (Proxy Services) --> skipping for now

vagrant up cd proxy

vagrant destroy -f

## Part 6 (late stages deployment pipeline)

vagrant up cd prod

vagrant ssh cd

ansible-playbook /vagrant/ansible/prod2.yml -i /vagrant/ansible/hosts/prod 

- prod2 installs proxy and service discovery (see previous)

wget https://raw.githubusercontent.com/vfarcic\ 2 /books-ms/master/docker-compose.yml

export DOCKER_HOST=tcp://prod:2375 

docker-compose up -d app

vagrant ssh prod

wget https://raw.githubusercontent.com/vfarcic/books-ms/master/nginx-includes.conf -O /data/nginx/includes/books-ms.conf 

wget https://raw.githubusercontent.com/vfarcic/books-ms/master/nginx-upstreams.ctmpl -O /data/nginx/upstreams/books-ms.ctmpl 

consul-template -consul localhost:8500 -template "/data/nginx/upstreams/books-ms.ctmpl:/data/nginx/upstreams/books-ms.conf docker kill -s HUP nginx" -once

exit

vagrant ssh cd

git clone https://github.com/vfarcic/books-ms.git 

cd books-ms

docker-compose -f docker-compose-dev.yml run --rm -e DOMAIN=http://10.100.198.201 integ

docker push 10.100.198.200:5000/books-ms-tests

vagrant destroy -f

## Part 7 (automating everything)

vagrant up cd prod

vagrant ssh cd

git clone https://github.com/vfarcic/books-ms.git

ansible-playbook /vagrant/ansible/service.yml -i /vagrant/ansible/hosts/prod --extra-vars "repo_dir=$PWD service_name=books-ms"

vagrant destroy -f

## Part 8 (CI, CI tools)

vagrant up cd prod

vagrant ssh cd

ansible-playbook /vagrant/ansible/prod2.yml -i /vagrant/ansible/hosts/prod

sudo mkdir -p /data/jenkins 

sudo chmod 0777 /data/jenkins 

docker run -d --name jenkins -p 8080:8080 -v /data/jenkins:/var/jenkins_home -v /vagrant/.vagrant/machines:/machines jenkins

docker rm -f jenkins

sudo rm -rf /data/jenkins

ansible-playbook /vagrant/ansible/jenkins-node.yml -i /vagrant/ansible/hosts/prod

ansible-playbook /vagrant/ansible/jenkins.yml -c local