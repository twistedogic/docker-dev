#!/bin/sh

if [ ! -f ${HDFS_NAMENODE_ROOT_DIR}/current/VERSION ]; then
	echo Formatting namenode root fs in ${HDFS_NN_ROOT_DIR}
	/etc/hadoop/bin/hdfs namenode -format
fi

/etc/hadoop/bin/hdfs namenode
