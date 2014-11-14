FROM twistedogic/openstack-base
MAINTAINER twistedogic

RUN apt-get install keystone -y
ADD ./setconfig.sh /usr/bin/setconfig
RUN chmod u+x /usr/bin/setconfig
EXPOSE 5000 35357
