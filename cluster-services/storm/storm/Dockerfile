FROM twistedogic/worker

MAINTAINER twistedogic 

RUN apt-get update && apt-get install unzip -y

ADD ./setup.sh /setup.sh
RUN sh /setup.sh

# install consul
RUN wget https://dl.bintray.com/mitchellh/consul/0.2.0_linux_amd64.zip -O /tmp/consul.zip -P /tmp/ --no-check-certificate && unzip /tmp/consul.zip -d /tmp/
RUN chmod +x /tmp/consul
RUN mv /tmp/consul /usr/bin/consul

# install consul-web-ui
RUN wget https://dl.bintray.com/mitchellh/consul/0.2.0_web_ui.zip -O /tmp/consul-web-ui.zip -P /tmp/ --no-check-certificate && unzip /tmp/consul-web-ui.zip -d /usr/local/consul-web-ui

ENV STORM_HOME /usr/local/storm

ADD storm.yaml $STORM_HOME/conf/storm.yaml
ADD cluster.xml $STORM_HOME/logback/cluster.xml
ADD config-supervisord.sh /usr/bin/config-supervisord.sh

RUN echo [supervisord] | tee -a /etc/supervisor/supervisord.conf ; echo nodaemon=true | tee -a /etc/supervisor/supervisord.conf

ADD sshd.conf /etc/supervisor/conf.d/sshd.conf

CMD ["/usr/bin/supervisord"]