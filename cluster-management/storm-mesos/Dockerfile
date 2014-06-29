FROM twistedogic/mesos-master
MAINTAINER Jordan Li

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y

RUN curl -sSfL http://downloads.mesosphere.io/storm/storm-mesos-0.9.tgz --output /tmp/storm.tgz
RUN mkdir /opt/storm && tar xzf /tmp/storm.tgz -C /opt/storm --strip=1 && rm -f /tmp/storm.tgz
RUN cd /tmp && wget http://downloads.mesosphere.io/storm/storm-starter-0.0.1-SNAPSHOT.jar

ADD storm.yaml /opt/storm/conf/storm.yaml
RUN mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord"]