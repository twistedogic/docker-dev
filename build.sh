#!/bin/bash
location=$(pwd)
cd ${location}/docker-mesos/mesos-master-ssh && docker build -t mesos-master-ssh-consul .
cd ${location}/docker-mesos/mesos-slave-ssh && docker build -t mesos-slave-ssh-consul .
cd ${location}/master-with-marathon && docker build -t mesos-consul .
echo "build completed!"
