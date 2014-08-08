FROM twistedogic/worker
MAINTAINER twistedogic

ENV DEBIAN_FRONTEND noninteractive

# install dependencies
RUN apt-get install -y unzip supervisor wget curl

# install consul
RUN wget https://dl.bintray.com/mitchellh/consul/0.3.1_linux_amd64.zip -O /tmp/consul.zip -P /tmp/ --no-check-certificate && unzip /tmp/consul.zip -d /tmp/
RUN chmod +x /tmp/consul
RUN mv /tmp/consul /usr/bin/consul

RUN apt-get update && apt-get install -y supervisor openjdk-7-jre-headless
RUN wget http://logstash.objects.dreamhost.com/release/logstash-1.1.13-flatjar.jar -O /opt/logstash.jar --no-check-certificate
ADD ./logstash.sh /usr/local/bin/logstash
RUN chmod +x /usr/local/bin/logstash

# install consul-web-ui
RUN wget https://dl.bintray.com/mitchellh/consul/0.3.1_web_ui.zip -O /tmp/consul-web-ui.zip -P /tmp/ --no-check-certificate && unzip /tmp/consul-web-ui.zip -d /usr/local/consul-web-ui

RUN mkdir /etc/consul.d
ADD ./healthcheck/script/cpu.sh /usr/local/bin/cpu.sh
ADD ./healthcheck/script/mem.sh /usr/local/bin/mem.sh
ADD ./healthcheck/script/process.sh /usr/local/bin/process.sh
RUN chmod u+x /usr/local/bin/process.sh
RUN chmod u+x /usr/local/bin/cpu.sh
RUN chmod u+x /usr/local/bin/mem.sh
ADD ./healthcheck/check/cpu.json /etc/consul.d/cpu.json
ADD ./healthcheck/check/mem.json /etc/consul.d/mem.json
RUN mkdir -p /var/log/supervisor
ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
EXPOSE 22 80 3000 8500 8300 7777
CMD ["/usr/bin/supervisord"]
