FROM twistedogic/openstack-base
MAINTAINER twistedogic

RUN apt-get install keystone -y
ADD ./keystone.conf /etc/keystone/keystone.conf 
RUN rm -f /var/lib/keystone/keystone.db

