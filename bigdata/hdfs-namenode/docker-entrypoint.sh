#!/bin/sh

if [ ! -f ${HDFS_NAMENODE_ROOT_DIR}/current/VERSION ]; then
	echo Formatting namenode root fs in ${HDFS_NN_ROOT_DIR}
	sed -i s/__MASTER__/$(hostname)/ /etc/hadoop/etc/hadoop/core-site.xml
	bin/hdfs namenode -format
fi


exec "$@"
