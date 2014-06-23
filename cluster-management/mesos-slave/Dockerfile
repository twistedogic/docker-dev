FROM twistedogic/worker
MAINTAINER twistedogic

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -y

# Make sure to install OpenJDK 6 explicitly.  The libmesos library includes an
# RPATH entry, which is needed to find libjvm.so at runtime.  This RPATH is
# hard-coded to the OpenJDK version that was present when the package was
# compiled.  So even though the Debian package claims that it works with either
# OpenJDK 6 or OpenJDK 7, the fact that Mesosphere compiled with OpenJDK 6 means
# that we have to have that specific version present at runtime.

WORKDIR /tmp
RUN \
  apt-get install -y curl openjdk-6-jre-headless && \
  curl -fL http://downloads.mesosphere.io/master/ubuntu/14.04/mesos_0.19.0~ubuntu14.04%2B1_amd64.deb -o /tmp/mesos.deb && \
  dpkg -i /tmp/mesos.deb && \
  apt-get install -f -y && \
  rm mesos.deb && \
  apt-get clean

RUN apt-get install -y -q supervisor vim curl
# install dependencies
RUN apt-get install -y unzip

# install consul
RUN wget https://dl.bintray.com/mitchellh/consul/0.2.0_linux_amd64.zip -O /tmp/consul.zip -P /tmp/ --no-check-certificate && unzip /tmp/consul.zip -d /tmp/
RUN chmod +x /tmp/consul
RUN mv /tmp/consul /usr/bin/consul

# install consul-web-ui
RUN wget https://dl.bintray.com/mitchellh/consul/0.2.0_web_ui.zip -O /tmp/consul-web-ui.zip -P /tmp/ --no-check-certificate && unzip /tmp/consul-web-ui.zip -d /usr/local/consul-web-ui
ADD sshd_config /etc/ssh/sshd_config
RUN mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN mkdir -p /etc/consul.d
EXPOSE 5051 22 80 3000 8500 8300
CMD ["/usr/bin/supervisord"]
