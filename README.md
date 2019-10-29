# nanoenv [![Dockerhub](https://img.shields.io/docker/automated/jrottenberg/ffmpeg.svg)](https://hub.docker.com/r/nunofonseca/nanoenv/tags/)
Nanopore software

## INSTALLATION

You will need to have docker installed: 
- Windows: https://docs.docker.com/docker-for-windows/install/
- Mac: https://docs.docker.com/docker-for-mac/
- Linux: https://docs.docker.com/install/linux/docker-ce/ubuntu/


To create the docker image with the Nanopore software

`docker build -t emg:nanoenv -f Dockerfile .`


## RUNNING

### To get a terminal with the Nanopore software installed

`./run_nanosoft`

Note that the software is the the /opt folder.


### To run MinKNOW

`./run_nanosoft MinKNOW`
 

