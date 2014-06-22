#!/bin/bash
MIP=$(ifconfig | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}')
sed -i "s|CHANGEME|${MIP}|" /etc/supervisor/conf.d/supervisord.conf
/usr/bin/supervisord
