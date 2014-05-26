FROM ubuntu:precise
MAINTAINER Mesosphere <support@mesosphere.io>

## DEPENDENCIES ##
RUN apt-get update && apt-get install --assume-yes python-software-properties curl default-jdk git supervisor tomcat7 openssh-server && \
    mkdir /var/run/sshd && chmod 700 /var/run/sshd && \
    echo 'root:root' | chpasswd

# install maven from a PPA, it doesn't seem to be in the Docker Ubuntu distro.
RUN add-apt-repository ppa:natecarlson/maven3
RUN apt-get update && apt-get install --assume-yes maven

RUN git clone https://github.com/usergrid/usergrid.git /opt/usergrid
RUN cd /opt/usergrid/stack && mvn clean install -DskipTests=true
ADD ./run.sh /usr/local/bin/run
RUN chmod +x /usr/local/bin/run
ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 8080
CMD ["/usr/bin/supervisord"]
