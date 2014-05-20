FROM ubuntu:raring
MAINTAINER Jordan Li
RUN apt-get update && apt-get install -y wget supervisor
RUN wget --no-check-certificate https://github.com/calmh/syncthing/releases/download/v0.8.7/syncthing-linux-amd64-v0.8.7.tar.gz -O /tmp/syncthing.tar.gz 
RUN cd /tmp/ &&  tar zxf /tmp/syncthing.tar.gz
RUN rm /tmp/syncthing.tar.gz && mv /tmp/syncthing-linux-amd64-v0.8.7/syncthing /usr/bin/syncthing
ADD ./run /run
CMD ["/bin/bash","/run"]
