#!/bin/bash
location=$(pwd)
docker pull dockerfile/redis
docker pull sequenceiq/ambari:1.6.0
docker pull sequenceiq/hadoop-docker:2.5.1
docker pull sequenceiq/spark:1.1.0
cd ${location}/worker && docker build -t twistedogic/worker .
cd ${location}/h2o && docker build -t twistedogic/h2o .
cd ${location}/r && docker build -t twistedogic/r .
cd ${location}/openscoring && docker build -t twistedogic/openscoring .
cd ${location}/rstudio && docker build -t twistedogic/rstudio .
cd ${location}/kali && docker build -t twistedogic/kali .
