#!/bin/bash
DNS=10.0.0.129
NN=$(docker run --name=master -d -e SERF_JOIN_IP=$DNS twistedogic/spark-hdfs-master)
NNIP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${NN})
sleep 10
docker run --name=worker -d -e MASTER_IP=$NNIP -e SERF_JOIN_IP=$DNS twistedogic/spark-hdfs-worker
docker run --name=shell -d -e MASTER_IP=$NNIP -e SERF_JOIN_IP=$DNS twistedogic/spark-shell
