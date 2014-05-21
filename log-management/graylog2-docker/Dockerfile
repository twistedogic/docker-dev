FROM lukecyca/graylog2-docker

RUN apt-get install -y build-essential && \
    apt-get install -y software-properties-common

# Install Redis.
RUN \
  cd /tmp && \
  wget http://download.redis.io/redis-stable.tar.gz && \
  tar xvzf redis-stable.tar.gz && \
  cd redis-stable && \
  make && \
  make install && \
  cp -f src/redis-sentinel /usr/local/bin && \
  mkdir -p /etc/redis && \
  cp -f *.conf /etc/redis && \
  rm -rf /tmp/redis-stable* && \
  sed -i 's/^\(bind .*\)$/# \1/' /etc/redis/redis.conf && \
  sed -i 's/^\(daemonize .*\)$/# \1/' /etc/redis/redis.conf && \
  sed -i 's/^\(dir .*\)$/# \1\ndir \/data/' /etc/redis/redis.conf && \
  sed -i 's/^\(logfile .*\)$/# \1/' /etc/redis/redis.conf

wget http://logstash.objects.dreamhost.com/release/logstash-1.1.13-flatjar.jar && mkdir —-parents /usr/local/bin/logstash && mv logstash-1.1.13-flatjar.jar /usr/local/bin/logstash/logstash.jar

ADD ./logstash.conf /etc/logstash.conf
ADD ./supervisord-graylog.conf /etc/supervisor/conf.d

# Expose ports
#   - 22: sshd
#   - 9000: Web interface
#   - 12201: GELF (UDP & TCP)
#   - 12900: REST API
EXPOSE 22 9000 12201 12201/udp 12900

# Expose data directories
VOLUME /opt/elasticsearch/data
VOLUME /opt/mongodb
CMD ["/usr/bin/supervisord"]