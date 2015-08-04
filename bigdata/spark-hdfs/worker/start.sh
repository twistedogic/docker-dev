#!/bin/bash
MASTER_IP=$(curl -s http://$MASTER_UI |  grep title | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}')
IP=$(ip -o -4 addr list eth0 | perl -n -e 'if (m{inet\s([\d\.]+)\/\d+\s}xms) { print $1 }')
echo export SPARK_PUBLIC_DNS=$IP > $SPARK_HOME/conf/spark-env.sh
echo export SPARK_LOCAL_IP=$IP >> $SPARK_HOME/conf/spark-env.sh
sh $SPARK_HOME/conf/spark-env.sh
$SPARK_HOME/bin/spark-class org.apache.spark.deploy.worker.Worker spark://$MASTER_IP:7077

tail -F $SPARK_HOME/logs/spark*
