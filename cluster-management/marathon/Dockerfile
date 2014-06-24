FROM twistedogic/mesos-master
MAINTAINER Jordan Li

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y

## MARATHON ##
RUN curl -sSfL http://downloads.mesosphere.io/marathon/marathon-0.5.1/marathon-0.5.1.tgz --output /tmp/marathon.tgz
RUN mkdir -p /opt/marathon && tar xzf /tmp/marathon.tgz -C /opt/marathon --strip=1 && rm -f /tmp/marathon.tgz

CMD ["/opt/marathon/bin/start"]
