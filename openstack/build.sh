#!/bin/bash
location=$(pwd)
docker pull dockerfile/rabbitmq
cd ${location}/base && docker build -t twistedogic/openstack-base .
cd ${location}/database && docker build -t twistedogic/openstack-database .
cd ${location}/cli && docker build -t twistedogic/openstack-cli .
cd ${location}/keystone && docker build -t twistedogic/openstack-keystone .
cd ${location}/glance && docker build -t twistedogic/openstack-glance .
cd ${location}/nova && docker build -t twistedogic/openstack-nova .
cd ${location}/heat && docker build -t twistedogic/openstack-heat .
cd ${location}/cinder && docker build -t twistedogic/openstack-cinder .
cd ${location}/dashboard && docker build -t twistedogic/openstack-dashboard .

