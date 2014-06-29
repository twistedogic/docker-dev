FROM twistedogic/worker
MAINTAINER twistedogic

RUN apt-get update && apt-get install unzip -y
ADD scripts/setup.sh /setup.sh
RUN sh /setup.sh

ADD confs/zookeeper/conf/zoo.cfg /usr/local/zookeeper/conf/zoo.cfg
ADD confs/storm/conf/storm.yaml ~/.storm/
ADD confs/supervisor/conf.d/sshd.conf /etc/supervisor/conf.d/sshd.conf
ADD confs/supervisor/conf.d/zookeeper.conf /etc/supervisor/conf.d/zookeeper.conf
ADD confs/supervisor/conf.d/storm_nimbus.conf /etc/supervisor/conf.d/storm_nimbus.conf
ADD confs/supervisor/conf.d/storm_ui.conf /etc/supervisor/conf.d/storm_ui.conf
ADD confs/supervisor/conf.d/storm_supervisor.conf /etc/supervisor/conf.d/storm_supervisor.conf

EXPOSE 8080:8080 8000:8000 6627:6627 3772:3772 3773:3773 2181:2181
ADD scripts/run.sh /run.sh
CMD ["/bin/sh", "-e", "/run.sh"]