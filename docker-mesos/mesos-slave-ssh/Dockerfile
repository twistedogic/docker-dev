FROM ubuntu:raring
MAINTAINER RedJack, LLC

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN \
  echo "# Install OpenSSH Server" ;\
  apt-get -q -y install openssh-server ;\
  mkdir -p /var/run/sshd ;\
  echo 'root:passw0rd' | chpasswd ;\
  \
true


# Make sure to install OpenJDK 6 explicitly.  The libmesos library includes an
# RPATH entry, which is needed to find libjvm.so at runtime.  This RPATH is
# hard-coded to the OpenJDK version that was present when the package was
# compiled.  So even though the Debian package claims that it works with either
# OpenJDK 6 or OpenJDK 7, the fact that Mesosphere compiled with OpenJDK 6 means
# that we have to have that specific version present at runtime.

WORKDIR /tmp
RUN \
  apt-get install -y curl openjdk-6-jre-headless && \
  curl -O http://s3.amazonaws.com/downloads.mesosphere.io/master/ubuntu/12.04/mesos_0.18.0_amd64.deb && \
  dpkg --unpack mesos_0.18.0_amd64.deb && \
  apt-get install -f -y && \
  rm mesos_0.18.0_amd64.deb && \
  apt-get clean

RUN apt-get install -y -q supervisor vim curl
RUN mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
EXPOSE 5051 22 80 3000
CMD ["/usr/bin/supervisord"]