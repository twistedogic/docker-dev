FROM twistedogic/storm
MAINTAINER twistedogic

RUN /usr/bin/config-supervisord.sh nimbus 
RUN /usr/bin/config-supervisord.sh drpc

EXPOSE 2181
EXPOSE 6627
EXPOSE 3772
EXPOSE 3773
ADD zookeeper.conf /etc/supervisor/conf.d/zookeeper.conf
ADD consul.conf /etc/supervisor/conf.d/consul.conf
CMD ["/usr/bin/supervisord"]
