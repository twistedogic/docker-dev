#!/bin/bash
DNS="10.0.0.129"
SPARK_MASTER=$(docker run -d -p 8080:8080 -p 50070:50070 -e SERF_JOIN_IP=$DNS twistedogic/spark-hdfs-master)
sleep 15
MIP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${SPARK_MASTER})
docker run -d -e MASTER_UI=$MIP:8080 -e SERF_JOIN_IP=$DNS twistedogic/spark-hdfs-worker
