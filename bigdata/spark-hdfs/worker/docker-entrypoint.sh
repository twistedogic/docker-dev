#!/bin/sh
sed -i s/__MASTER__/$MASTER_IP/ /etc/hadoop/etc/hadoop/core-site.xml
/etc/hadoop/bin/hdfs datanode
