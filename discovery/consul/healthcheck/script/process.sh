#!/bin/bash
process=$(/bin/ps -ef | grep $1 | wc -l)

if [ "$process" -gt 1 ]; then
        echo "Running $process $1 process(es)"
	echo $(tail -5 /var/log/supervisor/$1.log)
        $(exit 0)
else
        echo "Process is dead"
        $(exit 2)
fi
