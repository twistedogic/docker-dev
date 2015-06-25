FROM google/debian:wheezy
RUN apt-get update
RUN apt-get install python python-dev git ssh python-pip gcc -y

RUN pip install setuptools flask gevent gevent-websocket paramiko

RUN git clone https://github.com/aluzzardi/wssh.git /root/wssh

RUN cd /root/wssh && python setup.py install

RUN \
  echo "# Install OpenSSH Server" ;\
  apt-get -q -y install openssh-server supervisor;\
  mkdir -p /var/run/sshd ;\
  echo 'root:passw0rd' | chpasswd ;\
  \
true

ADD sshd_config /etc/ssh/sshd_config
RUN mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord"]

# wsshd runs by default on port 5000
EXPOSE 5000 22
