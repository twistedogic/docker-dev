#!/bin/bash
location=$(pwd)
cd ${location}/mesos-master && docker build -t twistedogic/mesos-master .
cd ${location}/mesos-slave && docker build -t twistedogic/mesos-slave .
cd ${location}/marathon && docker build -t twistedogic/marathon .
cd ${location}/chronos && docker build -t twistedogic/chronos .
cd ${location}/storm && docker build -t twistedogic/storm .
