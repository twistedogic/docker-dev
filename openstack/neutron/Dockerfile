FROM twistedogic/openstack-base
MAINTAINER twistedogic

RUN apt-get install neutron-server neutron-plugin-ml2 -y
ADD ./setconfig.sh /usr/bin/setconfig
RUN chmod u+x /usr/bin/setconfig
EXPOSE 9696
