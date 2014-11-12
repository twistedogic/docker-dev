#!/bin/bash
MYSQL_HOST=${MYSQL_HOST:-127.0.0.1}
crudini --set /etc/cinder/cinder.conf database connection mysql://cinder:Root123#@${MYSQL_HOST}/cinder
crudini --set /etc/cinder/cinder.conf DEFAULT verbose True
crudini --set /etc/cinder/cinder.conf keystone_authtoken auth_uri http://${MYSQL_HOST}:5000/v2.0
crudini --set /etc/cinder/cinder.conf keystone_authtoken identity_uri http://${MYSQL_HOST}:35357
crudini --set /etc/cinder/cinder.conf keystone_authtoken admin_tenant_name service
crudini --set /etc/cinder/cinder.conf keystone_authtoken admin_user cinder
crudini --set /etc/cinder/cinder.conf keystone_authtoken admin_password CINDER_PASS
crudini --set /etc/cinder/cinder.conf DEFAULT rpc_backend rabbit
crudini --set /etc/cinder/cinder.conf DEFAULT rabbit_host ${MYSQL_HOST}
crudini --set /etc/cinder/cinder.conf DEFAULT rabbit_password guest
crudini --set /etc/cinder/cinder.conf DEFAULT auth_strategy keystone
crudini --set /etc/cinder/cinder.conf DEFAULT my_ip ${MYSQL_HOST}
rm -f /var/lib/cinder/cinder.sqlite
