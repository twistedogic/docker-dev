#!/bin/bash
HOST=$(/sbin/ifconfig eth1 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')
location=$(pwd)
KID=$(docker run --name kibana01 -d -h kibana01 -e ES_HOST=${HOST} -p 80:80 -p 9300:9300 -p 9200:9200 kibana)
LID=$(docker run --name logstash01 -h logstash01 -d -e ES_HOST=${HOST} -p 6379:6379 logstash)
LIP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${LID})
CID=$(docker run --name consul1 -h master -e ES_HOST=${LIP} -d -p 3000:3000 -p 8080:8080 -p 9002:22 -p 8500:8500 consul)
MIP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${CID})
cp ${location}/supervisor_conf/template.conf ${location}/supervisor_conf/supervisord.conf
sed -i "s|172.17.0.2|${MIP}|" ${location}/supervisor_conf/supervisord.conf
S1=$(docker run --name consul2 -d -h node01 -e ES_HOST=${LIP} -p 7777:7777 -v ${location}/supervisor_conf:/etc/supervisor/conf.d/ consul)
S2=$(docker run --name consul3 -d -h node02 -e ES_HOST=${LIP} -v ${location}/supervisor_conf:/etc/supervisor/conf.d/ consul)
S1IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${S1})
S2IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${S2})
echo ${MIP}
echo ${S1IP}
echo ${S2IP}
docker ps -a