#!/bin/bash
echo "command=/opt/job-server/server_start.sh $SPARK_SERVER_EXEC" >> /etc/supervisord.conf
/usr/bin/supervisord -c /etc/supervisord.conf
