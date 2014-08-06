FROM twistedogic/worker
MAINTAINER twistedogic
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential wget nginx-full supervisor redis-server
RUN (cd /tmp && wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.1.tar.gz -O pkg.tar.gz && tar zxf pkg.tar.gz && mv elasticsearch-* /opt/elasticsearch)
RUN rm -rf /tmp/*

RUN \
  sed -i 's/^\(bind .*\)$/# \1/' /etc/redis/redis.conf && \
  sed -i 's/^\(daemonize .*\)$/# \1/' /etc/redis/redis.conf && \
  sed -i 's/^\(dir .*\)$/# \1\ndir \/data/' /etc/redis/redis.conf && \
  sed -i 's/^\(logfile .*\)$/# \1/' /etc/redis/redis.conf


RUN (cd /tmp && wget --no-check-certificate https://github.com/elasticsearch/kibana/archive/v3.0.0milestone2.tar.gz -O pkg.tar.gz && tar zxf pkg.tar.gz && cd kibana-* && cp -rf ./* /usr/share/nginx/html/)
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
ADD kibana.sh /usr/local/bin/kibana
RUN chmod +x /usr/local/bin/kibana
RUN rm -rf /tmp/*

RUN wget http://logstash.objects.dreamhost.com/release/logstash-1.1.13-flatjar.jar -O /opt/logstash.jar --no-check-certificate
ADD ./logstash.sh /usr/local/bin/logstash
RUN chmod +x /usr/local/bin/logstash
ADD ./logstash-redis.sh /usr/local/bin/logstash-redis
RUN chmod +x /usr/local/bin/logstash-redis

ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN mkdir /data

EXPOSE 6379
EXPOSE 9200
EXPOSE 9300
EXPOSE 80
EXPOSE 22
CMD ["/usr/bin/supervisord"]
