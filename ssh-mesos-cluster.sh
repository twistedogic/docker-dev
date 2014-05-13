#!/bin/bash
CID=$(docker run -m=104857600 -d -p 5050:5050 -p 8080:8080 -p 9002:22 -p 2181:2181 mesos);
MIP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${CID})
S1=$(docker run -d -p 9003:22 -m=134217728 mesos-slave-ssh)
S2=$(docker run -d -p 9004:22 -m=134217728 mesos-slave-ssh)
S3=$(docker run -d -p 9005:22 -m=134217728 mesos-slave-ssh)
S1IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${S1})
S2IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${S2})
S3IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${S3})
echo ${MIP}
echo ${S1IP}
echo ${S2IP}
echo ${S3IP}
docker ps -a
