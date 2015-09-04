#!/bin/bash
set -e
IP=$(ip a s eth0 | grep global | awk '{print$2}' | cut -d/ -f1)
if [ "${1:0:1}" = '-' ]; then
	set -- mongod --bind_ip $IP "$@"
fi

if [ "$1" = 'mongod' ]; then
	chown -R mongodb /data/db

	numa='numactl --interleave=all'
	if $numa true &> /dev/null; then
		set -- $numa "$@"
	fi

	exec gosu mongodb "$@"
fi

exec "$@"
