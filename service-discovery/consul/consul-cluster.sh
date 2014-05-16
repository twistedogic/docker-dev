#!/bin/bash
location=$(pwd)
CID=$(docker run -m=104857600 -d -p 3000:3000 -p 8080:8080 -p 9002:22 -p 8500:8500 consul)
MIP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${CID})
cp ${location}/supervisor_conf/template.conf ${location}/supervisor_conf/supervisord.conf
sed -i "s|172.17.0.2|${MIP}|" ${location}/supervisor_conf/supervisord.conf
S1=$(docker run -d -p 7777:7777 -v ${location}/supervisor_conf:/etc/supervisor/conf.d/ -m=104857600 consul)
S2=$(docker run -d -v ${location}/supervisor_conf:/etc/supervisor/conf.d/ -m=104857600 consul)
S3=$(docker run -d -v ${location}/supervisor_conf:/etc/supervisor/conf.d/ -m=104857600 consul)
S1IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${S1})
S2IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${S2})
S3IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${S3})
echo ${MIP}
echo ${S1IP}
echo ${S2IP}
echo ${S3IP}
docker ps -a
