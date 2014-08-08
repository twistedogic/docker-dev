#!/bin/bash
location=$(pwd)
CID=$(docker run --name consul1 -h master -d -p 3000:3000 -p 8301:8301 -p 9002:22 -p 8500:8500 twistedogic/consul)
MIP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${CID})
S1=$(docker run --name consul2 -d -h node01 -p 7777:7777 -v ${location}/supervisor_conf:/etc/supervisor/conf.d/ twistedogic/consul)
S2=$(docker run --name consul3 -d -h node02 -v ${location}/supervisor_conf:/etc/supervisor/conf.d/ twistedogic/consul)
S1IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${S1})
S2IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${S2})
echo ${MIP}
echo ${S1IP}
echo ${S2IP}
docker ps -a
