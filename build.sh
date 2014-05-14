#!/bin/bash
location=$(pwd)
cd ${location}/docker-mesos/mesos-master-ssh && docker build -t mesos-master-ssh .
cd ${location}/docker-mesos/mesos-slave-ssh && docker build -t mesos-slave-ssh .
cd ${location}/master-with-marathon && docker build -t mesos .
echo "build completed!"
