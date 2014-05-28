#
# Nginx Dockerfile
#
# https://github.com/dockerfile/nginx
#

# Pull base image.
FROM base
RUN echo "deb http://archive.ubuntu.com/ubuntu quantal main universe multiverse" > /etc/apt/sources.list
RUN apt-get update

# Install Nginx.
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y wget build-essential supervisor openssh-server && \
    mkdir /var/run/sshd && chmod 700 /var/run/sshd && \
    echo 'root:root' | chpasswd

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

RUN mkdir /data

RUN apt-get update && apt-get install -y supervisor openjdk-7-jre-headless
RUN wget http://logstash.objects.dreamhost.com/release/logstash-1.1.13-flatjar.jar -O /opt/logstash.jar --no-check-certificate
ADD logstash.sh /usr/local/bin/logstash
RUN chmod +x /usr/local/bin/logstash

EXPOSE 6379

ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord"]
