FROM twistedogic/openstack-base
MAINTAINER twistedogic

RUN apt-get install keystone -y
ADD ./keystone.conf /etc/keystone/keystone.conf 
ADD ./run.sh /usr/bin/start-keystone
ADD ./init.sql /init.sql
RUN chmod u+x /usr/bin/start-keystone
RUN rm -f /var/lib/keystone/keystone.db
CMD ["/usr/bin/start-keystone"]
