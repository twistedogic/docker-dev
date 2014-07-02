#!/bin/bash
location=$(pwd)
cd ${location}/mesos-master && docker build -t twistedogic/mesos-master .
cd ${location}/mesos-worker && docker build -t twistedogic/mesos-worker .
cd ${location}/mesos-slave && docker build -t twistedogic/mesos-slave .
cd ${location}/marathon && docker build -t twistedogic/marathon .
cd ${location}/chronos && docker build -t twistedogic/chronos .
cd ${location}/storm-mesos && docker build -t twistedogic/storm-mesos .
