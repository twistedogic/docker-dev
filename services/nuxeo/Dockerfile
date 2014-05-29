FROM ubuntu:raring
MAINTAINER Jordan Li
RUN apt-get update -y && apt-get install -y wget software-properties-common python-software-properties supervisor openssh-server && \
	mkdir /var/run/sshd && chmod 700 /var/run/sshd && \
    	echo 'root:root' | chpasswd
RUN wget -q -O- http://apt.nuxeo.org/nuxeo.key | apt-key add -
RUN add-apt-repository "deb http://apt.nuxeo.org/ $(lsb_release -cs) fasttracks"
RUN DEBIAN_FRONTEND=noninteractive apt-get update -y && apt-get install nuxeo -y
CMD ["/bin/bash"]
