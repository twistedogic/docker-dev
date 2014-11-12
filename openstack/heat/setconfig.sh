#!/bin/bash
MYSQL_HOST=${MYSQL_HOST:-127.0.0.1}
crudini --set /etc/heat/heat.conf database connection mysql://heat:Root123#@${MYSQL_HOST}/heat
crudini --set /etc/heat/heat.conf DEFAULT verbose True
crudini --set /etc/heat/heat.conf keystone_authtoken auth_uri http://${MYSQL_HOST}:5000/v2.0
crudini --set /etc/heat/heat.conf keystone_authtoken identity_uri http://${MYSQL_HOST}:35357
crudini --set /etc/heat/heat.conf keystone_authtoken admin_tenant_name service
crudini --set /etc/heat/heat.conf keystone_authtoken admin_user heat
crudini --set /etc/heat/heat.conf keystone_authtoken admin_password HEAT_PASS
crudini --set /etc/heat/heat.conf DEFAULT rpc_backend rabbit
crudini --set /etc/heat/heat.conf DEFAULT rabbit_host ${MYSQL_HOST}
crudini --set /etc/heat/heat.conf DEFAULT rabbit_password guest
crudini --set /etc/heat/heat.conf DEFAULT auth_strategy keystone
crudini --set /etc/heat/heat.conf DEFAULT my_ip ${MYSQL_HOST}
crudini --set /etc/heat/heat.conf ec2authtoken auth_uri http://${MYSQL_HOST}:5000/v2.0
crudini --set /etc/heat/heat.conf DEFAULT heat_metadata_server_url http://${MYSQL_HOST}:8000
crudini --set /etc/heat/heat.conf DEFAULT heat_waitcondition_server_url http://${MYSQL_HOST}:8000/v1/waitcondition
rm -f /var/lib/heat/heat.sqlite
