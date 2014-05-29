#!/bin/bash

set -e

if [ -f /configured ]; then
  exec /usr/bin/supervisord
fi

POSTGRESQL_BIN=/usr/lib/postgresql/9.3/bin/postgres
POSTGRESQL_CONFIG_FILE=/etc/postgresql/9.3/main/postgresql.conf

sudo -u postgres $POSTGRESQL_BIN --single \
  --config-file=$POSTGRESQL_CONFIG_FILE \
  <<< "UPDATE pg_database SET encoding = pg_char_to_encoding('UTF8') WHERE datname = 'template1'" &>/dev/null
sudo -u postgres $POSTGRESQL_BIN --single \
  --config-file=$POSTGRESQL_CONFIG_FILE \
  <<< "CREATE USER openerp WITH SUPERUSER;" &>/dev/null
sudo -u postgres $POSTGRESQL_BIN --single \
  --config-file=$POSTGRESQL_CONFIG_FILE \
  <<< "ALTER USER openerp WITH PASSWORD 'postgres';" &>/dev/null

password=$(pwgen -1 -s)
echo -e "$password\n$password"|passwd &>/dev/null
echo "PASSWORD: $password"
date > /configured
exec /usr/bin/supervisord
