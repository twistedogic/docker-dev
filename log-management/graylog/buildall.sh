#!/bin/bash
location=$(pwd)
cd ${location}/graylog2-docker && docker build -t logserver .
cd ${location}/test-nginx && docker build -t testnginx .
echo "build completed!"
