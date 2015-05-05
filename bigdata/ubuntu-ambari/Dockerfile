FROM ubuntu:precise
MAINTAINER Jordan Li
ENV SERF_HOME /root/serf
RUN apt-get update -y
RUN apt-get install -y sudo tar wget openjdk-7-jre-headless supervisor
RUN \
  echo "# Install OpenSSH Server" ;\
  apt-get install -y openssh-server openssh-clients;\
  mkdir -p /var/run/sshd ;\
  echo 'root:passw0rd' | chpasswd ;\
  \
true
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa
RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys
RUN sed  -i "/^[^#]*UsePAM/ s/.*/#&/"  /etc/ssh/sshd_config
RUN echo "UsePAM no" >> /etc/ssh/sshd_config

RUN wget -nv http://public-repo-1.hortonworks.com/ambari/ubuntu12/2.x/updates/2.0.0/ambari.list  -O /etc/apt/sources.list.d/ambari.list
RUN apt-get update -y
RUN apt-get -y install python-setuptools
RUN easy_install pip
RUN wget https://dl.bintray.com/mitchellh/serf/0.6.4_linux_amd64.zip -P /tmp
RUN unzip /tmp/0.6.4_linux_amd64.zip -d $SERF_HOME/bin && rm -f /tmp/0.6.4_linux_amd64.zip
ADD serf_init.sh $SERF_HOME/bin/serf_init.sh
RUN chmod +x $SERF_HOME/bin/*
ADD supervisord.conf /etc/supervisord.conf
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
EXPOSE 8080 22
