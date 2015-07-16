#!/bin/bash
ID=$(docker run -d twistedogic/serf-dns)
DNS=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${ID})
NN=$(docker run -d -p 50070:50070 twistedogic/namenode)
NNIP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${NN})
docker run -d twistedogic/datanode $NNIP
ZK=$(docker run -d -p 2181:2181 jplock/zookeeper)
ZKIP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${ZK})
docker run -d --dns $DNS -p 5050:5050 -e ZK_IP=$ZKIP -e SERF_JOIN_IP=$DNS twistedogic/mesos-master-serf
docker run -d --dns $DNS -e ZK_IP=$ZKIP -e SERF_JOIN_IP=$DNS twistedogic/mesos-slave-serf
#docker run -d --dns $DNS -e SERF_JOIN_IP=$DNS twistedogic/spark-mesos
docker run -d -p 8888:8888 --dns $DNS -e SERF_JOIN_IP=$DNS -e PYSPARK_SUBMIT_ARGS="--master mesos://zk://$ZKIP:2181/mesos --conf spark.executor.uri=http://d3kbcqa49mib13.cloudfront.net/spark-1.3.1-bin-hadoop2.6.tgz" twistedogic/pyspark
