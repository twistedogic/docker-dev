FROM twistedogic/openstack-base
MAINTAINER twistedogic

RUN apt-get install nova-api nova-cert nova-conductor nova-consoleauth nova-novncproxy nova-scheduler -y
ADD ./setconfig.sh /usr/bin/setconfig
RUN chmod u+x /usr/bin/setconfig
EXPOSE 8773 8774 8775 8060 5800 5900
ENTRYPOINT ["/usr/bin/setconfig &&"]
