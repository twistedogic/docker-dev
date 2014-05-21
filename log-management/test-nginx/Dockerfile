#
# Nginx Dockerfile
#
# https://github.com/dockerfile/nginx
#

# Pull base image.
FROM dockerfile/ubuntu

# Install Nginx.
RUN \
  add-apt-repository -y ppa:nginx/stable && \
  apt-get update && \
  apt-get install -y nginx && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  chown -R www-data:www-data /var/lib/nginx

# Define mountable directories.
VOLUME ["/data", "/etc/nginx/sites-enabled", "/var/log/nginx"]

RUN apt-get update && apt-get install -y supervisor openjdk-7-jre-headless
RUN wget http://logstash.objects.dreamhost.com/release/logstash-1.1.13-flatjar.jar && mkdir —-parents /usr/local/bin/logstash && mv logstash-1.1.13-flatjar.jar /usr/local/bin/logstash/logstash.jar

ADD ./logstash.conf /etc/logstash.conf
ADD ./supervisord.conf /etc/supervisor/conf.d
CMD ["/usr/bin/supervisord"]