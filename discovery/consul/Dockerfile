FROM worker
MAINTAINER twistedogic

ENV DEBIAN_FRONTEND noninteractive

# install dependencies
RUN apt-get install -y unzip supervisor wget curl

# install consul
RUN wget https://dl.bintray.com/mitchellh/consul/0.2.0_linux_amd64.zip -O /tmp/consul.zip -P /tmp/ --no-check-certificate && unzip /tmp/consul.zip -d /tmp/
RUN chmod +x /tmp/consul
RUN mv /tmp/consul /usr/bin/consul

RUN apt-get update && apt-get install -y supervisor openjdk-7-jre-headless
RUN wget http://logstash.objects.dreamhost.com/release/logstash-1.1.13-flatjar.jar -O /opt/logstash.jar --no-check-certificate
ADD ./logstash.sh /usr/local/bin/logstash
RUN chmod +x /usr/local/bin/logstash

# install consul-web-ui
RUN wget https://dl.bintray.com/mitchellh/consul/0.2.0_web_ui.zip -O /tmp/consul-web-ui.zip -P /tmp/ --no-check-certificate && unzip /tmp/consul-web-ui.zip -d /usr/local/consul-web-ui

RUN mkdir /etc/consul.d
RUN mkdir -p /var/log/supervisor
ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
EXPOSE 22 80 3000 8500 8300 7777
CMD ["/usr/bin/supervisord"]
