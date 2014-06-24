FROM twistedogic/mesos-master
MAINTAINER Jordan Li

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y 
## CHRONOS ##
RUN curl -sSfL http://downloads.mesosphere.io/chronos/chronos-2.1.0_mesos-0.14.0-rc4.tgz --output /tmp/chronos.tgz
RUN mkdir -p /opt/chronos && tar xzf /tmp/chronos.tgz -C /opt/ --strip=1 && rm -f /tmp/chronos.tgz

CMD ["/opt/chronos/bin/start-chronos.bash"]
