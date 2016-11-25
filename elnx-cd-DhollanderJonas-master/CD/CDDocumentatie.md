##Linux CD setup
####What happens at vagrant up (provisioning)
##### CD
- We start with a ubuntu trusy box assign it the ip ip 10.100.198.200
- We start provisioning cd with the `bootstrap_ansible` shell script. This will start installing ansible and copy the config file in /vagrant to /etc/ansible/ on the client
- Next up start de ansible playbook cd.yml which has the following roles. These roles will start .yml files that set correct config, copy files, enable services. The main.yml files are pretty straightforwrd.
 - common (disables obsolete services)
 - docker (configures docker, add user to docker group)
 - docker-compose (sets up docker-compose)
 - docker-flow (Sets up docker-flow)
 - consul-template (Copy template to client)
 - registry (copy config file, run registry container for docker on :5000 and mirror conatiner on 5001:5000)

##### Prod 
- We start with a ubuntu trusy box assign it the ip ip 10.100.198.201

##### Configure prod node
With the command ```ansible-playbook /vagrant/ansible/prod2.yml -i /vagrant/ansible/hosts/prod```  we will have the following services running.

- Consul
- Registrator
- Consul Template
- Nginx

This will allow us to proxy all requests to their destination services.

##### Configure jenkins node
```ansible-playbook /vagrant/ansible/jenkins-node.yml -i /vagrant/ansible/hosts/prod```
We'll setup the Jenkins node we'll use.
The first playbook installs the JDK (required by jenkins) and make a directory to store files when executing processes on those nodes.

```ansible-playbook /vagrant/ansible/jenkins.yml -c local```

`jenkinks.yml`  will install Consul Template and the jenkins role. 

In the role jenkins we'll start by creating the directories we need. After that we can run the jenkins container.
When jenkins in fully operational we copy a few config files (credentials.xml, and some nodes -> cd_config & prod_config)

Next we will install several plugins (for pipeline, docker, github).

This will be continued by creating jobs.


######What steps do we have to go through to achieve Continuous Delivery
 1. Run pre-deployement tests
 2. Compile/package the code
 3. Build the container
 4. Push the container to the registry
 5. Deploy the container to production server
 6. Integrate the container
 7. Run post-deployement tests
 8. Push the tests container to the registry


#### 1. Pre-deployement tests
- Start by running test that do not require a service to be deployed
 - Build test container with the Dockerfile.test
 - Run all pre-deployement tests and compile into JAR file for distribution (docker-compose-dev.yml).

#### 2. Build the docker containers
- We'll build a container which will be deployed to production based on the dockerfile in the case.
 - `RUN` executes a set of commands that updates packages - installs services 
 - `CMD` specifies the command that will be executed when the container starts

#### 3. Running containers


