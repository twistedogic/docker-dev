#!/bin/bash
/opt/spark/bin/spark-shell --master $1 --conf spark.executor.uri=http://d3kbcqa49mib13.cloudfront.net/spark-1.3.1-bin-hadoop2.6.tgz
