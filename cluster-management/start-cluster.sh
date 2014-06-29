#!/bin/bash
location=$(pwd)
CID=$(docker run -h master --name master -m=104857600 -d -p 5050:5050 -p 172.17.42.1:53:8600 -p 172.17.42.1:53:8600/udp --dns=172.17.42.1 --dns=8.8.8.8 -p 2181:2181 -p 8500:8500 twistedogic/mesos-master)
MIP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${CID})
cp ${location}/template.conf ${location}/slave_conf/supervisord.conf
sed -i "s|CHANGEME|${MIP}|" ${location}/slave_conf/supervisord.conf
cp ${location}/template.yaml ${location}/storm_conf/storm.yaml
sed -i "s|CHANGEME|${MIP}|" ${location}/storm_conf/storm.yaml
S1=$(docker run -h slave1 --name slave1 --link master:master -p 5051:5051 --dns=172.17.42.1 --dns=8.8.8.8 -d -v ${location}/slave_conf:/etc/supervisor/conf.d/ -m=104857600 twistedogic/mesos-slave)
S2=$(docker run -h marathon1 -p 8080:8080 --name marathon1 --dns=172.17.42.1 --dns=8.8.8.8 -d twistedogic/marathon /opt/marathon/bin/start --master zk://${MIP}:2181/mesos --zk zk://${MIP}:2181/marathon)
S3=$(docker run -h chronos1 -p 8082:8081 --name chronos1 --dns=172.17.42.1 --dns=8.8.8.8 -d twistedogic/chronos /opt/chronos/bin/start-chronos.bash --master zk://${MIP}:2181/mesos --zk_hosts zk://${MIP}:2181/mesos --http_port 8081)
S4=$(docker run -h storm1 --name storm1 -d -p 8083:8080 --dns=172.17.42.1 --dns=8.8.8.8  -v ${location}/storm_conf/:/opt/storm/conf/ twistedogic/storm)