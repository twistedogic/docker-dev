FROM twistedogic/mesos-master
MAINTAINER Jordan Li

ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

RUN apt-get update -y

## MARATHON ##
RUN curl -sSfL http://downloads.mesosphere.io/marathon/marathon-0.6.1/marathon-0.6.1.tgz --output /tmp/marathon.tgz
RUN mkdir -p /opt/marathon && tar xzf /tmp/marathon.tgz -C /opt/marathon --strip=1 && rm -f /tmp/marathon.tgz

CMD ["/opt/marathon/bin/start"]
