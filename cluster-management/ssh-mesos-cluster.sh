#!/bin/bash
location=$(pwd)
CID=$(docker run -h master --name mesos -m=104857600 -d -p 5050:5050 -p 8080:8080 -p 8081:8081 -p 172.17.42.1:53:8600 -p 172.17.42.1:53:8600/udp --dns-search=node.dc1.consul. --dns=172.17.42.1 --dns=8.8.8.8 -p 2181:2181 -p 8500:8500 mesos-master)
MIP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${CID})
cp ${location}/template.conf ${location}/slave_conf/supervisord.conf
sed -i "s|CHANGEME|${MIP}|" ${location}/slave_conf/supervisord.conf
S1=$(docker run -h slave1 --name mesos-slave1 --dns-search=node.dc1.consul. --dns=172.17.42.1 --dns=8.8.8.8 -d -v ${location}/slave_conf:/etc/supervisor/conf.d/ -m=104857600 mesos-slave)
S3IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${S3})
echo ${MIP}
echo ${S1IP}
docker ps -a
