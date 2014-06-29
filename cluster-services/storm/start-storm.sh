#!/bin/bash
location=$(pwd)
CID=$(docker run -h nimbus --name nimbus -d -p 172.17.42.1:53:8600 -p 172.17.42.1:53:8600/udp --dns=172.17.42.1 --dns=8.8.8.8 -p 6627:6627 -p 2181:2181 -p 8500:8500 twistedogic/storm-nimbus)
MIP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${CID})
cp ${location}/template.yaml ${location}/yaml/storm.yaml
sed -i "s|CHANGEME|${MIP}|" ${location}/yaml/storm.yaml
S1=$(docker run -h ui --name ui -p 8080:8080 --dns=172.17.42.1 --dns=8.8.8.8 -d -v ${location}/yaml:/usr/local/storm/conf/ twistedogic/storm-ui)
S2=$(docker run -h supervisor --name supervisor --link nimbus:nimbus --dns=172.17.42.1 --dns=8.8.8.8 -d twistedogic/storm-supervisor)
