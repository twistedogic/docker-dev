#!/bin/bash
ES_HOST=${ES_HOST:-127.0.0.1}
ES_PORT=${ES_PORT:-9300}
sed -e "s/%%ES_HOST%%/$ES_HOST/" /etc/td-agent/td-agent.conf.tmp > /etc/td-agent/td-agent.conf
/etc/init.d/td-agent restart