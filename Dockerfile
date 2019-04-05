FROM ubuntu:xenial
MAINTAINER Nuno Fonseca email: nuno.fonseca at gmail.com
LABEL EMN.vesion="0.1" maintainer="nuno.fonseca at gmail.com"

# To create the image
# docker build --no-cache -t EMN:latest -f Dockerfile .

RUN apt-get update
#RUN apt-get install -yq --no-install-recommends sudo less wget  lsb-release xvfb libasound2 libgconf-2-4 libxss-dev libgtk-3-0 libnss3 libatomic1 libusb-1.0-0-dev usbutils
RUN apt-get install -yq sudo less wget xvfb libusb-1.0-0-dev usbutils apt-transport-https

#ENV PLATFORM $(lsb_release -cs)

# key
RUN wget -O-  --no-check-certificate https://mirror.oxfordnanoportal.com/apt/ont-repo.pub | apt-key add -
# add repository
RUN echo "deb http://mirror.oxfordnanoportal.com/apt xenial-stable non-free" | sudo tee /etc/apt/sources.list.d/nanoporetech.sources.list

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install -y epi2me-agent minknow-nc ont-guppy
#ont-guppy-cpu

# /opt/metrichor/MetrichorAgent
# Minknow application directory is found in /opt/ui 
# Reads folder: /var/lib/MinKNOW/data/

# NVIDIA driver of at least version 384



ENV MUID 1000
ENV MGID 1000

# create the user minion
RUN export uid=$MUID gid=$MGID && \
	groupadd -g ${gid} minion && \
	useradd -u ${uid} -g ${gid} -m minion && \
	mkdir -p /etc/sudoers.d/ /var/lib/MinKNOW/data/ && \
	echo "minion ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/minion && \
	chmod 0440 /etc/sudoers.d/minion && \
        echo "#!/usr/bin/env bash" > /usr/bin/MinKNOW && \
	echo "cd /opt/ONT/MinKNOW; sudo bin/mk_manager_svc & " >> /usr/bin/MinKNOW && \
	echo "/opt/ui/MinKNOW" >> /usr/bin/MinKNOW && chmod +x /usr/bin/MinKNOW && \
	ln -s /home/minion /var/lib/MinKNOW/data/
## Home directory has the reads

USER minion
ENV HOME /home/minion

#CMD /bin/bash -l
#ENTRYPOINT ["/bin/bash"]
