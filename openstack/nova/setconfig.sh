#!/bin/bash
MYSQL_HOST=${MYSQL_HOST:-127.0.0.1}
crudini --set /etc/nova/nova.conf database connection mysql://nova:Root123#@${MYSQL_HOST}/nova
crudini --set /etc/nova/nova.conf DEFAULT verbose True
crudini --set /etc/nova/nova.conf keystone_authtoken auth_uri http://${MYSQL_HOST}:5000/v2.0
crudini --set /etc/nova/nova.conf keystone_authtoken identity_uri http://${MYSQL_HOST}:35357
crudini --set /etc/nova/nova.conf keystone_authtoken admin_tenant_name service
crudini --set /etc/nova/nova.conf keystone_authtoken admin_user nova
crudini --set /etc/nova/nova.conf keystone_authtoken admin_password NOVA_PASS
crudini --set /etc/nova/nova.conf DEFAULT rpc_backend rabbit
crudini --set /etc/nova/nova.conf DEFAULT rabbit_host ${MYSQL_HOST}
crudini --set /etc/nova/nova.conf DEFAULT rabbit_password guest
crudini --set /etc/nova/nova.conf DEFAULT auth_strategy keystone
crudini --set /etc/nova/nova.conf DEFAULT my_ip ${MYSQL_HOST}
crudini --set /etc/nova/nova.conf DEFAULT vncserver_listen ${MYSQL_HOST}
crudini --set /etc/nova/nova.conf DEFAULT vncserver_proxyclient_address ${MYSQL_HOST}
crudini --set /etc/nova/nova.conf glance host ${MYSQL_HOST}
rm -f /var/lib/nova/nova.sqlite
