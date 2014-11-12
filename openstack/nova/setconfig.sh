#!/bin/bash
MYSQL_HOST=${MYSQL_HOST:-127.0.0.1}
crudini --set /etc/keystone/keystone.conf DEFAULT admin_token ADMIN
crudini --set /etc/keystone/keystone.conf database connection mysql://keystone:Root123#@${MYSQL_HOST}/keystone
crudini --set /etc/keystone/keystone.conf DEFAULT verbose True
crudini --set /etc/keystone/keystone.conf token provider keystone.token.providers.uuid.Provider
crudini --set /etc/keystone/keystone.conf token driver keystone.token.persistence.backends.sql.Token
rm -f /var/lib/keystone/keystone.db
