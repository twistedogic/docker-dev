#!/bin/bash
cd /opt/hadoop/etc/hadoop/
NAMENODE_IP=$1
sed -i s/namenode/${NAMENODE_IP}/g core-site.xmli
/opt/hadoop/bin/hdfs datanode
