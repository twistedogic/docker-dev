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
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-6-jre wget nginx-full supervisor openssh-server && \
    mkdir /var/run/sshd && chmod 700 /var/run/sshd && \
    echo 'root:root' | chpasswd

# Define mountable directories.
VOLUME ["/data", "/etc/nginx/sites-enabled", "/var/log/nginx"]

RUN apt-get update && apt-get install -y supervisor openjdk-7-jre-headless
RUN wget http://logstash.objects.dreamhost.com/release/logstash-1.1.13-flatjar.jar -O /opt/logstash.jar --no-check-certificate


ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD ./logstash.conf /etc/logstash.conf
CMD ["/usr/bin/supervisord"]
