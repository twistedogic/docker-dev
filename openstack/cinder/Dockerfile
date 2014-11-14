FROM twistedogic/openstack-base
MAINTAINER twistedogic

RUN apt-get install cinder-api cinder-scheduler -y
ADD ./setconfig.sh /usr/bin/setconfig
RUN chmod u+x /usr/bin/setconfig
EXPOSE 8776
