#!/bin/bash
ID=$(docker run -d twistedogic/serf-dns)
DNS=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${ID})
NN=$(docker run -d twistedogic/namenode)
NNIP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${NN})
docker run -d twistedogic/datanode $NNIP
SPARK_MASTER=$(docker run -d --dns $DNS -p 8080:8080 -e SERF_JOIN_IP=$DNS twistedogic/spark-master)
sleep 5
MIP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${SPARK_MASTER})
docker run -d --dns $DNS -e MASTER_IP=$MIP -e SERF_JOIN_IP=$DNS twistedogic/spark-worker
docker run -d --dns $DNS -e MASTER_IP=$MIP -e SERF_JOIN_IP=$DNS twistedogic/spark-shell
