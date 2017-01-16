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
- Consul Template (is a very convenient way to create files with values obtained from Consul. As a
bonus, it can also run arbitrary commands after the files have been updated.)
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
 - Build test container with the Dockerfile.test (Test enviroment) with name 10.100.198.200:5000/books-ms-tests.
 - Run all pre-deployement tests and compile the Scala code into JAR file for distribution (docker-compose-dev.yml).
 
##### Build the test containers 
 
 ```
 - name: Tests container is pulled
 shell: docker pull \
 {{ registry_url }}{{ service_name }}-tests
 delegate_to: 127.0.0.1
 ignore_errors: yes
 tags: [service, tests]

 - name: Tests container is built
 shell: docker build \
 -t {{ registry_url }}{{ service_name }}-tests \
 -f Dockerfile.test \
 .
 args:
 chdir: "{{ repo_dir }}"
 delegate_to: 127.0.0.1
 tags: [service, tests]
```
- registry_url -> IP and port of the docker registry (default in groups_vars/all)

###### Predeployement tests, Build container & Push to registry

```
 - name: Pre-deployment tests are run
 shell: docker-compose \
 -f docker-compose-dev.yml \
 run --rm tests
 args:
 chdir: "{{ repo_dir }}"
 delegate_to: 127.0.0.1
 tags: [service, tests]

 - name: Container is built
 shell: docker build \
 -t {{ registry_url }}{{ service_name }} \
 .
 args:
 chdir: "{{ repo_dir }}"
 delegate_to: 127.0.0.1
 tags: [service]

 - name: Container is pushed
 shell: docker push \
 {{ registry_url }}{{ service_name }}
 delegate_to: 127.0.0.1
 tags: [service]
 ```
 ##### Deployement
 
 ###### Create service directory, copy all files we need to destination server (files defined in roles/service/defaults/main.yml)
- service_name -> file destinations
```
 - name: Directory is created
 file:
 path: /data/{{ service_name }}
 recurse: yes
 state: directory
 tags: [service]

 - name: Files are copied
 copy:
 src: "{{ item.src }}"
 dest: "{{ item.dest }}"
 with_items: files
 tags: [service]
 ```
 
 ###### Pull latest image from docker registry and bring it up. When upped check wether container image or its config changed when compared with running containter. If it is Docker Compose will stop the running containers and run the new ones. Consul-template updates configurations and reloads nginx.
 ```
 - name: Containers are pulled
 shell: docker-compose pull app
 args:
 chdir: /data/{{ service_name }}
 tags: [service]

 - name: Containers are running
 shell: docker-compose up -d app
 args:
 chdir: /data/{{ service_name }}
 tags: [service]

 - name: Proxy is configured
 shell: consul-template \
 -consul localhost:8500 \
 -template "{{ ct_src }}:{{ ct_dest }}:{{ ct_cmd }}" \
 -once
 tags: [service]
 ```
 #### Post deployement tasks
 
 ```
 name: Post-deployment tests are run
 shell: docker-compose \
 -f docker-compose-dev.yml \
 run --rm \
 -e DOMAIN={{ proxy_url }} \
 integ
 args:
 chdir: "{{ repo_dir }}"
 delegate_to: 127.0.0.1
 tags: [service, tests]

 - name: Tests container is pushed
 shell: docker push \
 {{ registry_url }}{{ service_name }}-tests
 delegate_to: 127.0.0.1
 tags: [service, tests]
 ```
 
 ##### Run integration tests and push the tests container to the registry
 
#### 2. Build the docker containers

- We'll build a container which will be deployed to production based on the dockerfile in the case.
 - `RUN` executes a set of commands that updates packages - installs services 
 - `CMD` specifies the command that will be executed when the container starts

#### 3. Running containers

- Here we will start the db container required by the service.

#### 4. Pushing containers to the registry

- The docker registry is used to store en retrieve containers. Adding a container will allow us to pll it from any plce that can access the cd server. 

All the steps we run now are performed on the cd VM.

