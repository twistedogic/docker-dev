#!/bin/bash
location=$(pwd)
echo "========logstash========="
cd ${location}/logstash && docker build -t logstash .
echo "========kibana========="
cd ${location}/kibana && docker build -t kibana .
echo "build completed!"