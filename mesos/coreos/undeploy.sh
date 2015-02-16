#!/bin/bash
systemctl stop zookeeper.service mesos-master.service mesos-slave.service marathon.service chronos.service
systemctl disable zookeeper.service mesos-master.service mesos-slave.service marathon.service chronos.service
cd /etc/systemd/system
rm -rf zookeeper.service mesos-master.service mesos-slave.service marathon.service chronos.service
