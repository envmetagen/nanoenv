FROM ubuntu:bionic
# ubuntu 18
MAINTAINER Nuno Fonseca email: nuno.fonseca at gmail.com
LABEL EMN.vesion="0.2" maintainer="nuno.fonseca at gmail.com"

# To create the image
# docker build --no-cache -t EMN:latest -f Dockerfile2 .

RUN apt-get update

RUN apt-get install -yq sudo less wget xvfb libusb-1.0-0-dev usbutils apt-transport-https libasound2 libgconf-2-4 libxss-dev libgtk-3-0 libnss3 libatomic1 libusb-1.0-0-dev usbutils gnupg gvfs

#ENV PLATFORM $(lsb_release -cs)

# key
RUN wget -O- https://mirror.oxfordnanoportal.com/apt/ont-repo.pub | sudo apt-key add  -
RUN echo "deb http://mirror.oxfordnanoportal.com/apt bionic-stable non-free" | sudo tee /etc/apt/sources.list.d/nanoporetech.sources.list


ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install -y  wget epi2me-agent minknow-nc minion-nc
# ont-guppy not available for ubuntu 18 2019-10-29

# /opt/metrichor/MetrichorAgent
# Minknow application directory is found in /opt/ui 
# Reads folder: /var/lib/MinKNOW/data/

# NVIDIA driver: version 384 or above
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
	echo "#sudo service minknow restart " >> /usr/bin/MinKNOW && \
	echo "/opt/ont/ui/kingfisher/MinKNOW" >> /usr/bin/MinKNOW && chmod +x /usr/bin/MinKNOW && \
	ln -s /home/minion /var/lib/MinKNOW/data/

USER minion
ENV HOME /home/minion

#CMD /bin/bash -l
#ENTRYPOINT ["/bin/bash"]
