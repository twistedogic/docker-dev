#!/bin/bash
# DB & MQ
docker run -d -p 5672:5672 -p 15672:15672 dockerfile/rabbitmq
docker run -d -p 3306:3306 twistedogic/openstack-database
sleep 10
# init keystone
docker run -rm -e MYSQL_HOST=192.168.100.74 twistedogic/openstack-keystone sh -c 'setconfig && keystone-manage db_sync'
docker run -d -p 5000:5000 -p 35357:35357 -e MYSQL_HOST=192.168.100.74 twistedogic/openstack-keystone sh -c 'setconfig && keystone-all'
sleep 10
# add service accounts
docker run -rm twistedogic/openstack-cli sh /init

# init glance
docker run -rm -e MYSQL_HOST=192.168.100.74 twistedogic/openstack-glance sh -c 'setconfig && glance-manage db_sync'
docker run -d -p 9292:9292 -e MYSQL_HOST=192.168.100.74 twistedogic/openstack-glance sh -c 'setconfig && glance-api'
docker run -d -p 9191:9191 -e MYSQL_HOST=192.168.100.74 twistedogic/openstack-glance sh -c 'setconfig && glance-registry'

# init nova
docker run -rm -e MYSQL_HOST=192.168.100.74 twistedogic/openstack-nova sh -c 'setconfig && nova-manage db sync'
docker run -d -privileged -p 8773:8773 -p 8774:8774 -p 8775:8775 -p 3333:3333 -e MYSQL_HOST=192.168.100.74 twistedogic/openstack-nova sh -c 'setconfig && nova-api'
docker run -d -e MYSQL_HOST=192.168.100.74 twistedogic/openstack-nova sh -c 'setconfig && nova-cert'
docker run -d -e MYSQL_HOST=192.168.100.74 twistedogic/openstack-nova sh -c 'setconfig && nova-consoleauth'
docker run -d -e MYSQL_HOST=192.168.100.74 twistedogic/openstack-nova sh -c 'setconfig && nova-scheduler'
docker run -d -e MYSQL_HOST=192.168.100.74 twistedogic/openstack-nova sh -c 'setconfig && nova-conductor'
docker run -d -p 6080:6080 -p 5800:5800 -p 5900:5900 -e MYSQL_HOST=192.168.100.74 twistedogic/openstack-nova sh -c 'setconfig && nova-novncproxy'

# init horizon
docker run -d -p 80:80 -e MYSQL_HOST=192.168.100.74 twistedogic/openstack-dashboard

# init cinder
docker run -rm -e MYSQL_HOST=192.168.100.74 twistedogic/openstack-cinder sh -c 'setconfig && cinder-manage db sync'
docker run -d -e MYSQL_HOST=192.168.100.74 twistedogic/openstack-cinder sh -c 'setconfig && cinder-scheduler'
docker run -d -p 8776:8776 -e MYSQL_HOST=192.168.100.74 twistedogic/openstack-cinder sh -c 'setconfig && cinder-api'
