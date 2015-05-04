#!/bin/sh
sed -i s/__MASTER__/$1/ /etc/hadoop/etc/hadoop/core-site.xml
cd /etc/hadoop
bin/hdfs datanode
