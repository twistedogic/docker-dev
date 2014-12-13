FROM sequenceiq/drill
MAINTAINER Jordan Li 
RUN apt-get update -y
RUN \
  echo "# Install OpenSSH Server" ;\
  apt-get -q -y install openssh-server screen;\
  mkdir -p /var/run/sshd ;\
  echo 'root:passw0rd' | chpasswd ;\
  \
true

ADD sshd_config /etc/ssh/sshd_config
CMD ["/usr/sbin/sshd","-D"]