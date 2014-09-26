#!/bin/bash
location=$(pwd)
docker pull dockerfile/redis
docker pull sequenceiq/hadoop-docker:2.5.1
cd ${location}/worker && docker build -t twistedogic/worker .
cd ${location}/h2o && docker build -t twistedogic/h2o .
cd ${location}/r && docker build -t twistedogic/r .
cd ${location}/openscoring && docker build -t twistedogic/openscoring .
