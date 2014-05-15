FROM ubuntu
MAINTAINER Jordan Li <twistedogic@gmail.com>

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y
## DEPENDENCIES ##
RUN apt-get update && apt-get install --assume-yes python-software-properties curl default-jdk

# install maven from a PPA, it doesn't seem to be in the Docker Ubuntu distro.
RUN add-apt-repository ppa:natecarlson/maven3
RUN apt-get update && apt-get install --assume-yes maven3

RUN apt-get install -y -q openjdk-6-jre-headless wget vim supervisor
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

# install dependencies
RUN apt-get install -y unzip

# install consul
RUN wget https://dl.bintray.com/mitchellh/consul/0.2.0_linux_amd64.zip -O /tmp/consul.zip -P /tmp/ --no-check-certificate && unzip /tmp/consul.zip -d /tmp/
RUN chmod +x /tmp/consul
RUN mv /tmp/consul /usr/bin/consul

# install consul-web-ui
RUN wget https://dl.bintray.com/mitchellh/consul/0.2.0_web_ui.zip -O /tmp/consul-web-ui.zip -P /tmp/ --no-check-certificate && unzip /tmp/consul-web-ui.zip -d /usr/local/consul-web-ui

RUN mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
EXPOSE 5050 22 2181 2888 3888 9000 8081 8082 8300 8500
CMD ["/usr/bin/supervisord"]