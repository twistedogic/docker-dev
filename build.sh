#!/bin/bash
cd ./docker-mesos/mesos-slave && docker build -t mesos-slave .
cd ./docker-mesos/mesos-slave-ssh && docker build -t mesos-slave-ssh .
cd ./master-with-marathon && docker build -t mesos .
