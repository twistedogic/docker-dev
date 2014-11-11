#!/bin/bash
MYSQL_HOST=${MYSQL_HOST:-127.0.0.1}
mysql -uroot -h ${MYSQL_HOST} < /init.sql
sed -i "s|change_me|${MYSQL_HOST}|" /etc/keystone/keystone.conf
keystone-manage db_sync && keystone-all
