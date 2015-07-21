#!/bin/sh
sed -i s/__MASTER__/$MASTER_IP/ /etc/hadoop/etc/hadoop/core-site.xml
cd /etc/hadoop
bin/hdfs datanode
