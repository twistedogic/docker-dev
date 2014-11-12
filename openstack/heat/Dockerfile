FROM twistedogic/openstack-base
MAINTAINER twistedogic

RUN apt-get install heat-api heat-api-cfn heat-engine -y
ADD ./setconfig.sh /usr/bin/setconfig
RUN chmod u+x /usr/bin/setconfig
EXPOSE 8000 8004
ENTRYPOINT ["/usr/bin/setconfig &&"]
