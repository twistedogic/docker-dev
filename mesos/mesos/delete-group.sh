#!/bin/bash

if [ "$#" -ne 1 ]; then
    	echo "script takes json file as an argument"
	exit 1;
fi

curl -i -L -H 'Content-Type: application/json' -X DELETE 10.0.0.129:8081/v2/groups/$@
