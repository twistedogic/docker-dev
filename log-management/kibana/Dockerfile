FROM base
MAINTAINER twistedogic
RUN echo "deb http://archive.ubuntu.com/ubuntu quantal main universe multiverse" > /etc/apt/sources.list
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential openjdk-6-jre wget nginx-full supervisor openssh-server && \
    mkdir /var/run/sshd && chmod 700 /var/run/sshd && \
    echo 'root:root' | chpasswd
ENV JAVA_HOME /usr/lib/jvm/java-6-openjdk-amd64
RUN (cd /tmp && wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.1.tar.gz -O pkg.tar.gz && tar zxf pkg.tar.gz && mv elasticsearch-* /opt/elasticsearch)
RUN rm -rf /tmp/*

RUN (cd /tmp && wget --no-check-certificate https://github.com/elasticsearch/kibana/archive/v3.0.0milestone2.tar.gz -O pkg.tar.gz && tar zxf pkg.tar.gz && cd kibana-* && cp -rf ./* /usr/share/nginx/www/)
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
ADD kibana.sh /usr/local/bin/kibana
RUN chmod +x /usr/local/bin/kibana
RUN rm -rf /tmp/*

RUN wget http://logstash.objects.dreamhost.com/release/logstash-1.1.13-flatjar.jar -O /opt/logstash.jar --no-check-certificate
ADD ./logstash.sh /usr/local/bin/logstash
RUN chmod +x /usr/local/bin/logstash

ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 6379
EXPOSE 9200
EXPOSE 9300
EXPOSE 80
CMD ["/usr/bin/supervisord"]
