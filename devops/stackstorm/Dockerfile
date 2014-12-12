# Pull base image.
FROM dockerfile/ubuntu

# Reset policy-rc.d
RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d

# Install Python
RUN \
  apt-get update && \
    apt-get install -y python python-dev python-pip python-virtualenv openssh-server supervisor
# Set environment variable to Docker
ENV CONTAINER DOCKER

RUN mkdir -p /var/run/sshd && echo 'root:passw0rd' | chpasswd

RUN cd /root && curl -sS -k -O https://ops.stackstorm.net/releases/st2/0.5.1/st2_deploy.sh

RUN bash -c 'chmod +x /root/st2_deploy.sh'

RUN bash -c '/root/st2_deploy.sh 0.6.0';'bash'

ADD . /root/st2/

ADD sshd_config /etc/ssh/sshd_config

RUN mv /root/st2/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN bash -c 'chmod +x /root/st2/start.sh'

EXPOSE 9101

CMD /root/st2/start.sh 
