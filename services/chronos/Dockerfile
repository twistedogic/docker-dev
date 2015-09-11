FROM mesosphere/mesos:0.21.1-1.1.ubuntu1404
MAINTAINER Jordan Li
ENV CHRONOS_VERSION 2.4.0
RUN apt-get update && apt-get -y install curl maven npm wget && apt-get clean all
RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN cd /opt && wget https://github.com/mesos/chronos/archive/$CHRONOS_VERSION.tar.gz && tar -zxvf $CHRONOS_VERSION.tar.gz
RUN cd /opt/chronos-$CHRONOS_VERSION && mvn clean package
RUN ln -s /opt/chronos-$CHRONOS_VERSION /opt/chronos
WORKDIR /opt/chronos
ENTRYPOINT ["bin/start-chronos.bash"]

