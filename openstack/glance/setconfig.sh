#!/bin/bash
MYSQL_HOST=${MYSQL_HOST:-127.0.0.1}
crudini --set /etc/glance/glance-api.conf database connection mysql://glance:Root123#@${MYSQL_HOST}/glance
crudini --set /etc/glance/glance-api.conf DEFAULT verbose True
crudini --set /etc/glance/glance-api.conf keystone_authtoken auth_uri http://controller:5000/v2.0
crudini --set /etc/glance/glance-api.conf keystone_authtoken identity_uri http://controller:35357
crudini --set /etc/glance/glance-api.conf keystone_authtoken admin_tenant_name service
crudini --set /etc/glance/glance-api.conf keystone_authtoken admin_user glance
crudini --set /etc/glance/glance-api.conf keystone_authtoken admin_password GLANCE_PASS
crudini --set /etc/glance/glance-api.conf paste_deploy flavor keystone
crudini --set /etc/glance/glance-api.conf glance_store default_store file
crudini --set /etc/glance/glance-api.conf glance_store filesystem_store_datadir /var/lib/glance/images/

crudini --set /etc/glance/glance-registry.conf database connection mysql://glance:Root123#@${MYSQL_HOST}/glance
crudini --set /etc/glance/glance-registry.conf DEFAULT verbose True
crudini --set /etc/glance/glance-registry.conf keystone_authtoken auth_uri http://controller:5000/v2.0
crudini --set /etc/glance/glance-registry.conf keystone_authtoken identity_uri http://controller:35357
crudini --set /etc/glance/glance-registry.conf keystone_authtoken admin_tenant_name service
crudini --set /etc/glance/glance-registry.conf keystone_authtoken admin_user glance
crudini --set /etc/glance/glance-registry.conf keystone_authtoken admin_password GLANCE_PASS
crudini --set /etc/glance/glance-registry.conf paste_deploy flavor keystone
rm -f /var/lib/glance/glance.sqlite
