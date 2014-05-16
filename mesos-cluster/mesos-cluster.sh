#!/bin/bash
CID=$(docker run -m=104857600 -d -p 5050:5050 -p 8080:8080 -p 9002:22 -p 2181:2181 mesos);
MIP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${CID})
S1=$(docker run -d -m=104857600 mesos-slave mesos-slave --master=${MIP}:5050)
S2=$(docker run -d -m=104857600 mesos-slave mesos-slave --master=${MIP}:5050)
S3=$(docker run -d -m=104857600 mesos-slave mesos-slave --master=${MIP}:5050)
S1IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${S1})
S2IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${S2})
S3IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${S3})
echo ${MIP}
echo ${S1IP}
echo ${S2IP}
echo ${S3IP}
docker ps -a
