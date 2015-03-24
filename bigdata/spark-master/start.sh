#!/bin/bash
LOCAL_IP=$(ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')
echo $LOCAL_IP > /hostname
java -Dspark.akka.logLifecycleEvents=true -Xms512m -Xmx512m -cp ::/usr/spark/conf:/usr/spark/lib/* org.apache.spark.deploy.master.Master -h $LOCAL_IP
