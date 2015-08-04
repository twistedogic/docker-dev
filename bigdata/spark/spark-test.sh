#!/bin/bash
DNS="10.0.0.129"
SPARK_MASTER=$(docker run -d -p 8080:8080 -e SERF_JOIN_IP=$DNS twistedogic/spark-master)
sleep 5
MIP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${SPARK_MASTER})
docker run -d -e MASTER_IP=$MIP -e SERF_JOIN_IP=$DNS twistedogic/spark-worker
docker run -d -e MASTER_IP=$MIP -e SERF_JOIN_IP=$DNS twistedogic/spark-shell
