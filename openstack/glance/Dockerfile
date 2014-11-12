FROM twistedogic/openstack-base
MAINTAINER twistedogic

RUN apt-get install glance -y
ADD ./setconfig.sh /usr/bin/setconfig
RUN chmod u+x /usr/bin/setconfig
EXPOSE 5000 35357
ENTRYPOINT ["/usr/bin/setconfig &&"]
