# Enterprise Linux Lab Report

- Student name: Jonas D'hollander
- Github repo: <https://github.com/HoGentTIN/elnx-DhollanderJonas.git>


Conintuous Delivery 

## Requirements

- Configure pipeline to build a job to start the case mentioned in the videos (todobackend)
	- Understand the case
	- Reverse engineer pipeline (delete existing jobs)
	- Create job to start pipeline for todobackend case
	- Create dockerhub
	- Reconfigure Makefile, Jenkinsfile, docker-compose file 


## Test plan

- Pipeline builds only using `vagrant up`
- Jenkins job "todobackend" is made
- Pipeline runs without errors
- New container pushed to docker hub
- Manually pull docker container and test manualy
## Documentation

- https://github.com/DhollanderJonas/Archivering01
- https://github.com/DhollanderJonas/todobackend
- https://hub.docker.com/r/dudusolutions/linuxtestcd/
- DevOps 2.0
- Videos Justin Menga

## Test report

- Vm's and jobs are created succesfully
- Pipeline runs and tests the case
- Container is pushed to dockerhub
- When pulling and starting container case can be started succesfully

## Resources

- https://github.com/DhollanderJonas/Archivering01
- https://github.com/DhollanderJonas/todobackend
- https://hub.docker.com/r/dudusolutions/linuxtestcd/
- DevOps 2.0
- Videos Justin Menga
