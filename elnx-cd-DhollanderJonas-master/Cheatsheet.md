#Troubleshooting


| Task                       | Command |
| :---                       | :--:     |
| Search file excluding directories without permission | `find DIRECTORY -name "VALUE" 2> /dev/null`     |
|Check the ip configuration|`/sbin/ifconfig`|
|Change keyboard input|`loadkeys be-latin1`|
|Show the ip addressing|`ip a`|
|Show the configuration for a certain interface|`vi /etc/sysconfig/network-scripts/ifcfg-INTERFACE`|
|Show default gateway|`ip r`|
|Show DNS-Server|`cat /etc/resolv.conf`|
|Show the status of a service|`sudo systemctl status SERVICE.service`|
|Start a service|`sudo systemctl start SERVICE.service`|
|Restart a service|`sudo systemctl restart SERVICE.service`|
|Show ports (t=tcp, u=udp, l=listening, p=which proces, n=negates namechange)|`sudo ss -tulpn`|
|Show firewall|`sudo firewall-cmd --list-all`|
|Edit firewall to allow service|`sudo firewall-cmd --add-service=SERVICE --permanent`|
|Edit firewall to allow portaccess|`sudo firewall-cmd --add-port=PORT/tcp --permanent`|
|Restart the firewall|`sudo systemctl restart firewalld`|
|Show logfiles (continuous)|`sudo journalctl -l -f -u SERVICE.service`|
|Show logfiles current boot|`sudo journalctl -b`|
|Show logfiles since ... (e.g. yesterday)|`sudo journalctl --since=yesterday`|
|Check if configuration for apache is correct|`apachectl configtest`|
|Check if configuration for fileserver is correct|`testparm`|
|Check if configuration for main DNS is correct|`named-checkconf`|
|Check if configuration for specific DNS is correct|`named-checkzone`|
|Install commands for dns|`yum install bind-utils`|
|Show active running processes|`ps -A`|
|Stop process|`kill PID`|
|Bring an interface up (`cd` to the location)|`ifup IFACE`|
|Restart the network|`/etc/init.d/network restart`|

#Clonezilla
####Restore parameters
![CloneZilla]
(https://github.com/HoGentTIN/elnx-cd-DhollanderJonas/blob/master/CloneZilla/Images/clonezillaPara.PNG?raw=true)

#DRBL
####drblsrv -h
Usage:
/usr/sbin/drblsrv [Option]
Option:

| Parameter                      | Explanation |
| :---                       | :--:     |
| -f --force-yes |  force yes, only for Debian-like distribution. It  should  not  be used except in very special situations. Using force-yes can potentially destroy your system! |
| -i --install |    install DRBL. |
| -u --uninstall |  uninstall DRBL. |
| -v --verbose |    verbose mode. |
| -t --testing [y/n] |    use packages in testing branch or not. |
| -a --unstable [y/n] |   use packages in unstable branch or not. |
| -n --netinstall [y/n] | install the network installation program or not. |
| -m --smp-client [y/n] | use SMP kernel for DRBL clients or not. |
| -x --set-proxy [y/n] |  set proxy or not. |
| -c --console-output [y/n] | set console output for client or not. |
| -g --upgrade_system [y/n] | upgrade system or not. |
| -k --client_archi [0/1/2] | set the client's CPU arch, 0 for i386, 1 for i586, 2 for same level with DRBL server (for x86_64, use 2). |
 |-o --client_kernel_from [1/2] | choose client's kernel image from, 1 from DRBL server running kernel (if available), 2 from ayo repository. |
| -s --skip-select-repository | skip the question for selecting repository. |
| -l --language N | Set the language to be shown, where N 0: English, 1: Traditional Chinese (Big5) - Taiwan, 2: Traditional Chinese (UTF-8, Unicode) - Taiwan. |


####drblpush -h
``` 
Usage: /usr/sbin/drblpush [-c|--config config_file] [-d|--debug] [-e|--accept-one-nic] [-h|--help] [-i|--interactive] [-k|--keep_clients Y/n] [-l|--language index_number] [-m|--client_startup_mode 1/2] [-n|--no_deploy] [-o|--clonezilla_home DIR] [-p|--port_client_no number] [-q|--quiet] [-r|--drbl_mode 0|1|2] [-t|--live_client_branch 0|1|2|3] [-s|--swap_create y/N] [-v|--verbose] [-z|--clonezilla_mode 0|1|2|3] [--skip-drbl-ocs-live-prep] [--drbl-ocs-live-server IP] 
```

| Parameter                      | Explanation |
| :---                       | :--:     |
|-b, --not-add-start-drbl-srvi| Do NOT add and start DRBL related services after the configuration is done|
|-c, --config |     The DRBL config file, text format|
|-d, --debug |      Turn on debug mode when run shell script|
|-e, --accept-one-nic |  Accept to run DRBL service in only one network card. ///NOTE/// This might mess up your network environment especially if there is an existing DHCP service in your network environment.|
|-h, --help |       Show this help message|
|-i, --interactive| Interactive mode, setup step by step.|
|-k, --keep_clients Y/n |Keep previously saved files for clients.|
|-m, --client_startup_mode [1/2]| Assign client mode, 1 for graphic mode, 2 for text mode.|
|-n, --no_deploy |  Just create files, do NOT deploy the files into system|
|-o, --clonezilla_home DIR | Use DIR as the clonezilla image directory|
|-p, --port_client_no number |The client no. in each NIC port.|
|-q, --quiet   |          Be less verbose|
|-r, --drbl_mode [0/1/2]| Assign DRBL mode (0: Full DRBL mode, 1: DRBL SSI mode, 2: Do NOT provide diskless Linux service to clients)|
|-s, --swap_create y/N |  Switch to create and use local swap in clients (yes or no)|
|-t, --live_client_branch [0/1/2/3]| Assign the Clonezilla live release branch to be used, 0 is stable branch (Debian-based), 1 is testing branch (Debian-based), 2 is alternative stable branch (Ubuntu-based), 3 is alternative testing branch (Ubuntu-based). This option should be used when -z|--clonezilla_mode = 3|
|-u, --live_client_cpu_mode [0/1/2] | Assign the CPU mode for client when doing Clonezilla job with Clonezilla live (0: i486, 1: i686, 2: amd64)|
|-v, --verbose      |     Be more verbose|
|-z, --clonezilla_mode [0/1/2/3]| Assign Clonezilla mode (0: Full DRBL mode, 1: Clonezilla box mode, 2: Do NOT provide clonezilla service to clients, 3: Use Clonezilla live as the OS of clients)|
|--skip-drbl-ocs-live-prep | Force to skip running drbl-ocs-live-prep|
|--drbl-ocs-live-server IP | Assign the Clonezilla live server as IP when running drbl-ocs-live-prep|
|-l, --language INDEX | Set the language to be shown (deprecated! Use environmental LC_ALL or LANG instead). [0]: English [1]: Traditional Chinese (Big5) - Taiwan [2]: Traditional Chinese (UTF-8, Unicode) - Taiwan [a|ask]: Prompt to ask the language index|
|--ln INDEX    |        Set the language to be shown (deprecated! Use environmental LC_ALL or LANG instead). [en_US]: English [zh_TW.BIG5]: Traditional Chinese (Big5) - Taiwan [zh_TW.UTF-8]: Traditional Chinese (UTF-8, Unicode) - Taiwan|

####drbl4imp -h
Usage:
/usr/sbin/drbl4imp [Option]
Option:

| Parameter                      | Explanation |
| :---                       | :--:     |
|-a, --unstable [y/n]|   Use packages in unstable branch or not (Only works for RH-like distribution).|
|-b, --batch|            Run /usr/sbin/drbl4imp in batch mode (non-attended mode).|
|-e, --accept-one-nic |   Accept to run DRBL service in only one network card. ///NOTE/// This might mess up your network environment especially if there is an exi sting DHCP service in your network environment.|
|-c, --live-client-branch [0/1/2/3] |Assign the Clonezilla live release branch to be used, 0 is stable branch (Debian-based), 1 is testing branch (Debian-based), 2 is alternative stable branch (Ubuntu-based), 3 is alternative testing branch (Ubuntu-based). This option should be used when -z/--clonezilla-mode = 3|
|-p, --port-client-no | NO  The client number NO in each NIC port.|
|-k, --client-archi [0/1/2]| Set the client's CPU arch, 0 for i386, 1 for i586, 2 for same level with DRBL server (for x86-64, use 2). This option is for the DRBL client is NFS based, i.e. all files are NFS mounted from server. It's different from the option '-u', which is only for clonezilla mode.|
|-r, --drbl-mode [0/1/2] |Assign DRBL mode (0: Full DRBL mode, 1: DRBL SSI mode, 2: Do NOT provide diskless Linux service to clients). Default value is 0..|
|-t, --testing [y/n]|    Use packages in testing branch or not (Only works for RH-like distribution).|
|-u, --live-client-cpu-mode [0/1/2] | Assign the CPU mode for client when doing Clonezilla job with Clonezilla live (0: i486, 1: i686, 2: amd64). This option should be used with -z/--clonezilla-mode = 3.|
|-x, --limit-pxe-drbl-client | Force the DHCP service managed by DRBL will only allow PXE or DRBL clients to lease IP address. By default all the clients can lease IP address. //NOTE// If you want to use Clonezilla live as the OS of clients when running Clonezilla job, do _NOT_ use this option. Otherwise your client won't be able to mount the root file system.|
|-z, --clonezilla-mode [0/1/2/3]| Assign Clonezilla mode (0: Full DRBL mode, 1: Clonezilla box mode, 2: Do NOT provide clonezilla service to clients, 3: Use Clonezilla live as the OS of clients). Default value is 0.|

#Ansible
####Hosts

`$ sudo mkdir /etc/ansible`
`$ sudo vim /etc/ansible/hosts`

####Running a playbook

`$ ansible-playbook playbook.yml`

####Tasks
```
 - hosts: all
  user: root
  sudo: no
  vars:
    aaa: bbb
  tasks:
    - ...
  handlers:
    - ...
```
####Includes
```
 tasks:
  - include: db.yml
handlers:
  - include: db.yml user=timmy 
```

####Handlers
```
 handlers:
  - name: start apache2
    action: service name=apache2 state=started

tasks:
  - name: install apache
    action: apt pkg=apache2 state=latest
    notify:
      - start apache2 
 ```     
####Vars
```
 - host: lol
  vars_files:
    - vars.yml
  vars:
    project_root: /etc/xyz
  tasks:
    - name: Create the SSH directory.
      file: state=directory path=${project_root}/home/.ssh/
      only_if: "$vm == 0" 
```
####Roles
```
- host: xxx
  roles:
    - db
    - { role:ruby, sudo_user:$user }
    - web 
```    
 Uses:
roles/db/tasks/*.yml
 roles/db/handlers/*.yml
 
####Task: Failures
```
- name: my task
  command: ...
  register: result
  failed_when: "'FAILED' in result.stderr"

  ignore_errors: yes

  changed_when: "result.rc != 2" 
```
####Env vars
```
 vars:
  local_home: "" 
```
#Docker
## Containers

[Your basic isolated Docker process](http://etherealmind.com/basics-docker-containers-hypervisors-coreos/). Containers are to Virtual Machines as threads are to processes. Or you can think of them as chroots on steroids.

### Lifecycle

* [`docker create`](https://docs.docker.com/engine/reference/commandline/create) creates a container but does not start it.
* [`docker rename`](https://docs.docker.com/engine/reference/commandline/rename/) allows the container to be renamed.
* [`docker run`](https://docs.docker.com/engine/reference/commandline/run) creates and starts a container in one operation.
* [`docker rm`](https://docs.docker.com/engine/reference/commandline/rm) deletes a container.
* [`docker update`](https://docs.docker.com/engine/reference/commandline/update/) updates a container's resource limits.

### Starting and Stopping

* [`docker start`](https://docs.docker.com/engine/reference/commandline/start) starts a container so it is running.
* [`docker stop`](https://docs.docker.com/engine/reference/commandline/stop) stops a running container.
* [`docker restart`](https://docs.docker.com/engine/reference/commandline/restart) stops and starts a container.
* [`docker pause`](https://docs.docker.com/engine/reference/commandline/pause/) pauses a running container, "freezing" it in place.
* [`docker unpause`](https://docs.docker.com/engine/reference/commandline/unpause/) will unpause a running container.
* [`docker wait`](https://docs.docker.com/engine/reference/commandline/wait) blocks until running container stops.
* [`docker kill`](https://docs.docker.com/engine/reference/commandline/kill) sends a SIGKILL to a running container.
* [`docker attach`](https://docs.docker.com/engine/reference/commandline/attach) will connect to a running container.

#### Memory Constraints

You can also set [memory constraints](https://docs.docker.com/engine/reference/run/#/user-memory-constraints) on Docker:

```
docker run -it -m 300M ubuntu:14.04 /bin/bash
```

## Images

Images are just [templates for docker containers](https://docs.docker.com/engine/understanding-docker/#how-does-a-docker-image-work).

### Lifecycle

* [`docker images`](https://docs.docker.com/engine/reference/commandline/images) shows all images.
* [`docker import`](https://docs.docker.com/engine/reference/commandline/import) creates an image from a tarball.
* [`docker build`](https://docs.docker.com/engine/reference/commandline/build) creates image from Dockerfile.
* [`docker commit`](https://docs.docker.com/engine/reference/commandline/commit) creates image from a container, pausing it temporarily if it is running.
* [`docker rmi`](https://docs.docker.com/engine/reference/commandline/rmi) removes an image.
* [`docker load`](https://docs.docker.com/engine/reference/commandline/load) loads an image from a tar archive as STDIN, including images and tags (as of 0.7).
* [`docker save`](https://docs.docker.com/engine/reference/commandline/save) saves an image to a tar archive stream to STDOUT with all parent layers, tags & versions (as of 0.7).

## Registry & Repository

A repository is a *hosted* collection of tagged images that together create the file system for a container.

A registry is a *host* -- a server that stores repositories and provides an HTTP API for [managing the uploading and downloading of repositories](https://docs.docker.com/engine/tutorials/dockerrepos/).

Docker.com hosts its own [index](https://hub.docker.com/) to a central registry which contains a large number of repositories.  Having said that, the central docker registry [does not do a good job of verifying images](https://titanous.com/posts/docker-insecurity) and should be avoided if you're worried about security.

* [`docker login`](https://docs.docker.com/engine/reference/commandline/login) to login to a registry.
* [`docker logout`](https://docs.docker.com/engine/reference/commandline/logout) to logout from a registry.
* [`docker search`](https://docs.docker.com/engine/reference/commandline/search) searches registry for image.
* [`docker pull`](https://docs.docker.com/engine/reference/commandline/pull) pulls an image from registry to local machine.
* [`docker push`](https://docs.docker.com/engine/reference/commandline/push) pushes an image to the registry from local machine.

### Run local registry

You can run a local registry by using the [docker distribution](https://github.com/docker/distribution) project and looking at the [local deploy](https://github.com/docker/docker.github.io/blob/master/registry/deploying.md) instructions.

Also see the [mailing list](https://groups.google.com/a/dockerproject.org/forum/#!forum/distribution).

## Dockerfile

[The configuration file](https://docs.docker.com/engine/reference/builder/). Sets up a Docker container when you run `docker build` on it. Vastly preferable to `docker commit`.  

### Instructions

* [.dockerignore](https://docs.docker.com/engine/reference/builder/#dockerignore-file)
* [FROM](https://docs.docker.com/engine/reference/builder/#from) Sets the Base Image for subsequent instructions.
* [MAINTAINER](https://docs.docker.com/engine/reference/builder/#maintainer) Set the Author field of the generated images..
* [RUN](https://docs.docker.com/engine/reference/builder/#run) execute any commands in a new layer on top of the current image and commit the results.
* [CMD](https://docs.docker.com/engine/reference/builder/#cmd) provide defaults for an executing container.
* [EXPOSE](https://docs.docker.com/engine/reference/builder/#expose) informs Docker that the container listens on the specified network ports at runtime.  NOTE: does not actually make ports accessible.
* [ENV](https://docs.docker.com/engine/reference/builder/#env) sets environment variable.
* [ADD](https://docs.docker.com/engine/reference/builder/#add) copies new files, directories or remote file to container.  Invalidates caches. Avoid `ADD` and use `COPY` instead.
* [COPY](https://docs.docker.com/engine/reference/builder/#copy) copies new files or directories to container.
* [ENTRYPOINT](https://docs.docker.com/engine/reference/builder/#entrypoint) configures a container that will run as an executable.
* [VOLUME](https://docs.docker.com/engine/reference/builder/#volume) creates a mount point for externally mounted volumes or other containers.
* [USER](https://docs.docker.com/engine/reference/builder/#user) sets the user name for following RUN / CMD / ENTRYPOINT commands.
* [WORKDIR](https://docs.docker.com/engine/reference/builder/#workdir) sets the working directory.
* [ARG](https://docs.docker.com/engine/reference/builder/#arg) defines a build-time variable.
* [ONBUILD](https://docs.docker.com/engine/reference/builder/#onbuild) adds a trigger instruction when the image is used as the base for another build.
* [STOPSIGNAL](https://docs.docker.com/engine/reference/builder/#stopsignal) sets the system call signal that will be sent to the container to exit.
* [LABEL](https://docs.docker.com/engine/userguide/labels-custom-metadata/) apply key/value metadata to your images, containers, or daemons.
