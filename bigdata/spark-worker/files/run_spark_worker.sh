#!/bin/bash
. /opt/spark-${SPARK_VERSION}/conf/spark-env.sh
${SPARK_HOME}/bin/spark-class org.apache.spark.deploy.worker.Worker $MASTER
