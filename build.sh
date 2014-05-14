#!/bin/bash
cd ./docker-mesos/mesos-master-ssh && docker build -t mesos-master-ssh .
cd ./docker-mesos/mesos-slave-ssh && docker build -t mesos-slave-ssh .
cd ./master-with-marathon && docker build -t mesos .
