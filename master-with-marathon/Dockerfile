FROM ubuntu
MAINTAINER Jordan Li <twistedogic@gmail.com>

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y
## DEPENDENCIES ##
RUN apt-get update && apt-get install --assume-yes python-software-properties curl openjdk-7-jdk

# install maven from a PPA, it doesn't seem to be in the Docker Ubuntu distro.
RUN add-apt-repository ppa:natecarlson/maven3
RUN apt-get update && apt-get install --assume-yes maven3

RUN apt-get install -y -q openjdk-7-jre-headless wget vim supervisor
RUN wget -q -O /opt/zookeeper-3.4.6.tar.gz http://apache.mirrors.pair.com/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz
RUN tar -xzf /opt/zookeeper-3.4.6.tar.gz -C /opt
RUN cp /opt/zookeeper-3.4.6/conf/zoo_sample.cfg /opt/zookeeper-3.4.6/conf/zoo.cfg

RUN \
  echo "# Install OpenSSH Server" ;\
  apt-get -q -y install openssh-server ;\
  mkdir -p /var/run/sshd ;\
  echo 'root:passw0rd' | chpasswd ;\
  \
true

WORKDIR /tmp
RUN curl -O http://s3.amazonaws.com/downloads.mesosphere.io/master/ubuntu/12.04/mesos_0.18.0_amd64.deb && \
  dpkg --unpack mesos_0.18.0_amd64.deb && \
  apt-get install -f -y && \
  rm mesos_0.18.0_amd64.deb && \
  apt-get clean

## MARATHON ##
ADD . /opt/marathon
RUN cd /opt/marathon && mvn3 package

RUN mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
EXPOSE 5050 22 2181 2888 3888
CMD ["/usr/bin/supervisord"]
