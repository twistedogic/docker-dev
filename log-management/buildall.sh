#!/bin/bash
location=$(pwd)
echo "========graylog2========="
cd ${location}/graylog2 && docker build -t graylog2 .
echo "========logstash========="
cd ${location}/logstash && docker build -t testnginx .
echo "========kibana========="
cd ${location}/kibana && docker build -t kibana .
echo "========fluentd========="
cd ${location}/fluentd && docker build -t fluentd .
echo "build completed!"
