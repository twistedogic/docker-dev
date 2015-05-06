FROM twistedogic/ambari-serf
MAINTAINER Jordan Li
RUN yum update -y && yum install -y ambari-server
ADD supervisord.conf /etc/supervisord.conf

