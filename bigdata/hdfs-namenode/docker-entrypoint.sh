#!/bin/sh

if [ ! -f ${HDFS_NAMENODE_ROOT_DIR}/current/VERSION ]; then
	echo Formatting namenode root fs in ${HDFS_NN_ROOT_DIR}

	bin/hdfs namenode -format
fi


exec "$@"
