#!/bin/bash
LOCAL_IP=$(ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')
java -Dspark.akka.logLifecycleEvents=true -Xms512m -Xmx512m -cp ::/usr/spark/conf:/usr/spark/lib/* org.apache.spark.deploy.worker.Worker -h $LOCAL_IP $1
