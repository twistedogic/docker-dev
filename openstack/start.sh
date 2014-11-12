#!/bin/bash
# DB & MQ
docker run -d -p 5672:5672 -p 15672:15672 dockerfile/rabbitmq
docker run -d -p 3306:3306 twistedogic/openstack-database
sleep 10
# init keystone
docker run -rm -e MYSQL_HOST=192.168.100.74 twistedogic/openstack-keystone keystone-manage db_sync
docker run -d -p 5000:5000 -p 35357:35357 -e MYSQL_HOST=192.168.100.74 twistedogic/openstack-keystone keystone-all
sleep 10
# add service accounts
docker run -rm twistedogic/openstack-cli sh /init

