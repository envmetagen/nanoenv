# nanoenv
Nanopore software

## INSTALLATION

You will need to have docker installed: 
- windows howto: https://runnable.com/docker/install-docker-on-windows-10


To create the docker image with the Nanopore software

`docker build -t emg:nanoenv -f Dockerfile`


## RUNNING

### To get a terminal with the Nanopore software installed

`./run_nanosoft

Note that the software is the the /opt folder.


### To run MinKNOW

`./run_nanosoft MinKNOW`
 

