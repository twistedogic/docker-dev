FROM redjack/mesos
MAINTAINER RedJack, LLC

RUN \
  echo "# Install OpenSSH Server" ;\
  apt-get -q -y install openssh-server supervisor;\
  mkdir -p /var/run/sshd ;\
  echo 'root:passw0rd' | chpasswd ;\
  \
true

RUN mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
EXPOSE 5051 22 80 3000
CMD ["/usr/bin/supervisord"] 

