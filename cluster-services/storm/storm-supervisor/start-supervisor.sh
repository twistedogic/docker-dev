#!/bin/bash
sed -i -e "s/localhost/$NIMBUS_PORT_6627_TCP_ADDR/g" $STORM_HOME/conf/storm.yaml
sed -i -e "s/CHANGEME/$NIMBUS_PORT_6627_TCP_ADDR/g" /etc/supervisor/conf.d/supervisord.conf
supervisord