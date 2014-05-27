FROM worker
MAINTAINER twistedogic

ENV DEBIAN_FRONTEND noninteractive

# install dependencies
RUN apt-get install -y unzip supervisor wget curl

# install doozerd
RUN wget https://github.com/downloads/ha/doozerd/doozerd-0.8-linux-amd64.tar.gz -O /tmp/doozerd.tar.gz -P /tmp/ --no-check-certificate && tar zxf /tmp/doozerd.tar.gz -C /tmp/
RUN chmod +x /tmp/doozerd-0.8/doozerd
RUN mv /tmp/doozerd-0.8/doozerd /usr/bin/doozerd

# install doozer
RUN wget https://github.com/downloads/ha/doozer/doozer-0.8-linux-amd64.tar.gz -O /tmp/doozer.tar.gz -P /tmp/ --no-check-certificate && tar zxf /tmp/doozer.tar.gz -C /tmp/
RUN chmod +x /tmp/doozer-0.8/doozer
RUN mv /tmp/doozer-0.8/doozer /usr/bin/doozer

RUN mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
EXPOSE 22 80 3000 8500 8300 7777
CMD ["/usr/bin/supervisord"]
