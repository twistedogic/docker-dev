#!/bin/bash
#IP=$(/usr/sbin/ip -o -4 addr list $1 | grep global | awk '{print $4}' | cut -d/ -f1)
if [ "$#" -ne 2 ]; then
    	echo "Please provide local & zookeeper IP"
	exit 1;
fi
ZK_IP=$1
LOCAL_IP=$2
cp -rf systemd/mesos-master.service /etc/systemd/system/
cp -rf systemd/mesos-slave.service /etc/systemd/system/
cp -rf systemd/marathon.service /etc/systemd/system/
cp -rf systemd/chronos.service /etc/systemd/system/
cp -rf systemd/zookeeper.service /etc/systemd/system/
sed -i "s/<ZK_IP>/${ZK_IP}/g" /etc/systemd/system/*.service
sed -i "s/<LOCAL_IP>/${LOCAL_IP}/g" /etc/systemd/system/*.service
systemctl enable zookeeper.service mesos-master.service mesos-slave.service marathon.service chronos.service
systemctl start zookeeper.service mesos-master.service mesos-slave.service marathon.service chronos.service
